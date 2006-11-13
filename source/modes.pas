unit modes;

interface

procedure SetOnlineMode;
procedure SetOfflineMode;


implementation
uses unit1,Graphics;

procedure SetOnlineMode;
begin
with hauptfenster do
begin

           online.font.Color:= clGreen;
           online.caption:= 'Online';
           surfdauer.visible:= false;
           costs.Visible:= false;
           label3.Visible:= false;
           ednumber.Visible:= false;
           setmultilink.Visible:= false;

           if MM3_2.checked then //Profi-Mode
           begin
            AutoTrennen.ActivePage:= TabSheet1;
            Autotrennen.Visible:= true;
            PanelBevel.Visible:= true;
            if assigned(edwebsite) then edwebsite.top:= 406;

            if not beliebig_check.Checked then
            begin
             takt1.Visible:= true;
             takt2.Visible:= true;
            end
            else
            begin
             beliebig_date.Visible:= true;
             beliebig_time.Visible:= true;
            end;


           end
           else  //easy mode
            begin

            takt1.Visible          := false;
            takt2.Visible          := false;
            beliebig_date.Visible  := false;
            beliebig_time.Visible  := false;

            Autotrennen.Visible:= false;
            PanelBevel.Visible:= false;
            if assigned(edwebsite) then edWebsite.Top:= 330;
            end;
           ozeit.Visible:=true;
end;
end;

procedure SetOfflineMode;
begin
with hauptfenster do
begin
          online.font.Color:= clRed;
          online.caption:='Offline';

          Autotrennen.Visible:= false;
          PanelBevel.Visible:= false;
          ozeit.Visible:=false;

          surfdauer.visible:= true;
          label3.Visible:= true;

          if MM3_2.checked then //profimode
          begin
           ednumber.Visible:= true;
           if assigned(edwebsite) then edWebsite.Top:= 375;
           costs.Visible:=  true;

           if beliebig_check.Checked then
            begin
             beliebig_date.Visible:= true;
             beliebig_time.Visible:= true;
            end
            else
            begin
             beliebig_date.Visible:= false;
             beliebig_time.Visible:= false;
            end

          end
           else //easymode
          begin
           takt1.Visible          := false;
           takt2.Visible          := false;
           beliebig_date.Visible  := false;
           beliebig_time.Visible  := false;
           ednumber.Visible:= false;
           if assigned(edwebsite) then edwebsite.top:= 330;
           costs.Visible:=  false;
          end

end;
end;

end.
 