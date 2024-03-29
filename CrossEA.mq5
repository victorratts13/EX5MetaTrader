//+------------------------------------------------------------------+
//|                                                      CrossEA.mq5 |
//|                                     Copyright 2019,Victor Ratts. |
//|                                  https://victorratts13.gthub.io/ |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019,Victor Ratts."
#property link      "https://victorratts13.gthub.io/"
#property version   "1.00"
#include <Trade\Trade.mqh>
CTrade trade;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
      double ask, bid, last;
      double smaArray01[], smaArray02[];
      int smaHandle01,smaHandle02;
      
      ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
      bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
      last = SymbolInfoDouble(_Symbol, SYMBOL_LAST);
      
      smaHandle01 = iMA(_Symbol, _Period, 1, 0, MODE_SMA, PRICE_CLOSE);
      smaHandle02 = iMA(_Symbol, _Period, 5, 0, MODE_SMA, PRICE_CLOSE);
      ArraySetAsSeries(smaArray01, true);
      ArraySetAsSeries(smaArray02, true);
      CopyBuffer(smaHandle01, 0, 0, 3, smaArray01);
      CopyBuffer(smaHandle02, 0, 0, 3, smaArray02);
      
      if(smaArray02[0]<smaArray01[0] && PositionsTotal()==0)
         {  
            trade.PositionClose(_Symbol);
            Comment("Compra");
            trade.Buy(1, _Symbol, ask, ask-1, ask+5, "");
         }
      else if(smaArray02[0]>smaArray01[0] && PositionsTotal()==0)
         {
            trade.PositionClose(_Symbol);
            Comment("Venda");
            trade.Sell(1, _Symbol, bid, bid+5, bid-1, ""); 
         }
  }
//+------------------------------------------------------------------+
