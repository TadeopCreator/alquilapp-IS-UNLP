class CardController < ApplicationController
    def create
        @card = Card.new(card_params)
        if @card.save
            redirect_to @card
        else
            render :new
        end
    end

    def edit
        @card = Card.find(params[:id])
    end

    def update
        @card = Card.find(params[:id])
        if @card.update(card_edit)
            redirect_to @card
        else
            render :edit
        end
    end

    private
        def card_params
            params.permit(:name,:number,:vto,:cvv)
        end

        def card_edit
            params.require(:tarjetum).permit(:name,:number,:vto,:cvv)
        end
end
