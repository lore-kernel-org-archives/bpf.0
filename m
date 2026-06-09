Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB614C8FE7
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781026480; cv=none; b=iymamTmYVOkd8O3YKr+CmCDD6MYnqPKp5vqds0AdVdUhBqVr19nN74c9Y21qJy29FsmAev+wxOF+UJa1TpQBGDMWEyh1XbnL8I9paZ6oCkuo5o3mif2xvdG/7ei55UztYcxAa2V8zjx7vrZvS040iTvZ/DKBa2efj7qHwq+Z6gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781026480; c=relaxed/simple;
	bh=8N7XuyRU6c4ER45QABIfU6iv2y0qjX2rwhUyYzCewtw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tk2Gri+fBmiDnZ3G3FqGHlWOaewAi8VKPbwydiU2WmHd3BRlrEcwZ+cuX5yHxXDtSa/lfVOBs29gBrPpzdWZdyAC3zTCwNe+I8acFy00ievcHnk6B8466BdQb5EEe55dUFLzEPbBuMwGFyjp/KkzzXQ9vpammtjlyc8dTCbVbXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=OpZ1b/mA; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="OpZ1b/mA"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c8584bbbf2cso3811712a12.3
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 10:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1781026478; x=1781631278; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H0O37JLU9+UUO6RjfEV3qnVTJcbwi/sCUYtuia8QZ84=;
        b=OpZ1b/mAM7il9uLaDmV2dJfnKy7q0QPThcx2nA6IjX8bxsh6e7XaTsXd+Wof6Ww5Ap
         Y1WLFpxOgzjlLXSuzXP5+TDlJ71nFcdbNpxZKMvuWgVx3VuZ/JN1eaDKeedW/+syCUA0
         tYgrE4GHaYtKFnwneCV3rWaqVNq/2eYhg5szLbsYhgLiKX1lZgTeaSNQKrt5fvXF6FI8
         5eYa9eDXbSA7X6v3kmmoqXM20Um+z+mzTic4dqPtH3fsgcX1k3MX7CasgmGiphY3bIxZ
         01kNywJk0sGhDcfJ+ceQs09n816BXtMDBYMPNkSQQwc5jaTe7qbus5l6Pj0TafgLFfF4
         G57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781026478; x=1781631278;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0O37JLU9+UUO6RjfEV3qnVTJcbwi/sCUYtuia8QZ84=;
        b=BewSYA6t+ULmxs+PahX4ZjP9J9wQivPzbNjqT7Say8XsuayiIg+Yf4kI8PaaU15p1f
         K0KZNJ0M1+Ld9TsPbAWe5E9g7bug+4Ll+CPfbNSeYa2Qitkrdyz4lYrsPdqYDu+CC8SI
         Gq3WN36DFlApp29iXC9Ezbijk8v3bSPX+oC/t4KtYLEcO8DJu+lgrVLygVHfUxdy09nW
         ZVlTtDv1CD6lpGx3ldvPIN/+wLzxgsM9hwlo82j+FISAgjgIvNILr80sN5G/dB7ftJ0X
         FZ4crNiZBFJRCKq2IRj/qkMZeoRPkvFvlGnwiJtL8WmU8u0+CuoLCEof2JK7L2O44V9W
         BvJw==
X-Forwarded-Encrypted: i=1; AFNElJ9od5Afq7pKiioPKPkUqmjIHu+qho1NpEo0W+8eihFbp4myDsFJMJPF6P0T9a5Wl6IOS0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YySXhcFI0LnHrFzG7f5ZTw2OKa0yPF/Sc3CA1GSjQgVjFa6vNOs
	NJikd9os3RV1Zu3RU1fllY8FygFKDrdAm/fsiHhuBTySxV6XHJwrTFFRxQfO7C5am7c=
X-Gm-Gg: Acq92OFA5kVbC56MkH4Geapw2PdcHWji16CSfQ0DgbgPLw3XOmcwa0rLSJ2NASEoaM0
	d2w2hyzoXGNGRmNIkLaeGO2iQQpqdxGzsVzAEIos69cclV/4E6TofWoByXNPcdXparZn0KzH1Lk
	ubg8swjSj1dW5TLD6sO1jD5Im25Y9rTwxwv/hhfrovcqW2TP+2cy2hbg6cXGKfXlXLbXmtP7e01
	DuJlLBgy9MMAGJTTlLZHgxOeEx6VzWESjGbsRE+Ec1stzrRdMerOpUnhh+g2zVXK+oi03Kmeb31
	YQ448NtoS1IZ5XfOKBF955bQOHbeCjEmHYf2xuUlDoxUiMwFfzqmKizoRpNN0N6RPqjbi06gijK
	yY1C5NCg0btrhYhhr3GVDlifbpifYCGgoPQ88jGNVmBTV0b1gijNyOmeZlvjOL3TkJsPuz9Aj8c
	Vb82w7wg+wIxpyymg=
X-Received: by 2002:a05:6a00:908e:b0:842:459b:d61b with SMTP id d2e1a72fcca58-842b0f90d88mr21560405b3a.32.1781026478050;
        Tue, 09 Jun 2026 10:34:38 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:12::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828e5638sm22758898b3a.50.2026.06.09.10.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 10:34:37 -0700 (PDT)
Date: Tue, 9 Jun 2026 10:34:36 -0700
From: Joe Damato <joe@dama.to>
To: Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, horms@kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] bnxt: fix head underflow on XDP head-grow
Message-ID: <aihOrCfOLloudXmk@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, horms@kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260608203129.920104-1-joe@dama.to>
 <CACKFLikOyMh3Kbee-AifLXQryyPt-CftW7VYHeeKWoCuMoXj8w@mail.gmail.com>
 <aigoUdgW/icfFwvh@devvm20253.cco0.facebook.com>
 <CACKFLinzaJr8EjXx7yME5cKv9LR1+pF+2iY43V+GeYdEjbUo+Q@mail.gmail.com>
 <aihLw8yR6Vu5B6lS@devvm20253.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aihLw8yR6Vu5B6lS@devvm20253.cco0.facebook.com>

On Tue, Jun 09, 2026 at 10:22:12AM -0700, Joe Damato wrote:
> On Tue, Jun 09, 2026 at 09:44:17AM -0700, Michael Chan wrote:
> > On Tue, Jun 9, 2026 at 7:51 AM Joe Damato <joe@dama.to> wrote:
> > >
> > > On Mon, Jun 08, 2026 at 09:22:07PM -0700, Michael Chan wrote:
> > > > On Mon, Jun 8, 2026 at 1:31 PM Joe Damato <joe@dama.to> wrote:
> > > > >
> > > > > To fix this, we need to do a bit of math to recover the offset if this
> > > > > is a page fragment since it is not passed into rx_skb_func
> > > > > (bnxt_rx_multi_page_skb, in this case).
> > > >
> > > > I wonder if we should add an offset field to struct bnxt_sw_rx_bd to
> > > > simplify things for page mode.  Struct bnxt_sw_rx_agg_bd has the
> > > > offset field for a similar purpose.  Thanks.
> > >
> > > I don't mind doing that, but I wonder if that's better material for net-next?
> > >
> > > In other words, we get the minimal fix in (this patch?) and then do the
> > > cleanup and struct tweaking as a follow-up in net-next?
> > >
> > > I could definitely be wrong; I had just assumed patches for net were supposed
> > > to be as minimal as possible.
> > 
> > I think some minor refactoring/struct changes to make the fix
> > cleaner/simpler should be fine for -net.  I think the total number of
> > line changes should be about the same either way.
> 
> OK. Are you OK with changing the signature of rx_skb_func? I was going to add
> offset as an argument so it can be passed through.

Oh, actually nevermind. I think once offset is store in the struct we can
derive like this?

frag_start = page_address(page) + rxr->rx_buf_ring[cons].offset;

And then the signature doesn't need to change.
