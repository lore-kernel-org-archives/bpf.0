Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B0735C1AE
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016662; cv=none; b=hj3fFHrpVtG/L+8LP9URQq6dNtp18y36xA7VwtdLZDlHikiLgabU7dUCeOwthxlPkEc4qqED9FKAaxTUF7Kq2+7qKhXO/eWBpFRGNF5BT4l7AlVQCDK9DAUwLGGEnBFAJ5DODL+wRrZXbH72V9EmkUd+rTMRHkxWUudNE/LfUBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016662; c=relaxed/simple;
	bh=gxPRu6nbXG6vnDGagaNFiPthkbWpRHQdXXkxtNNL2Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fs/zq+D+/uvLi1J7AsASry1qHuut3cfwhUtyiK4whDpgjjx+jAhD6T3js533fu/y9Kv367xZNhrVvLIwMYm+tx6kuuF8oY6HBA4QWZgtEYvS7MGUxbojEjGOgulBroQx0OX7fszxPdWjbO2z2o0WqUWVa1A3LXskdrocLUO0cf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=QHI3la7a; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="QHI3la7a"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c8585ecdd71so2012128a12.0
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 07:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1781016659; x=1781621459; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CX1RLepI6BxsG1iHPv+ylDoNwQ0QIiidp1+2cKX8sjE=;
        b=QHI3la7aq7We/mUYCxIFPmB6lw/If0nWNbQXczWFkyvpLWJuxxb8aqCdbq1dInyBrV
         XlWISMKWfDPdVdkHMHq8xXDQdxiT5SUM6/WFNvR7IqI50kvVaZJ/KJbx8WvreuFlI+fd
         4yCSmg2Y283FUI/fE6DP9hpvgrFYKH2erqm8FSbK8XtQ/6fYRfOak0JXwbc8WH1GF1B5
         d4BBStBetC10jA2zHyiRyiiFVWlpz/Z/k893Ps+NRtg2fG/pT46Y7kAgRrRlaky5Pfhd
         nHIoLR58Okv0vww+UVaOPsnwm0sY27eMyyKUtR5uIywLO/GRwF+7ArgrvIKvIQtYnFx+
         8P3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016659; x=1781621459;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CX1RLepI6BxsG1iHPv+ylDoNwQ0QIiidp1+2cKX8sjE=;
        b=aoi2f6lfXrBIuwYpwLJFlu963xKNU3ecrZyjekcixSKRydKlcGxEmHuKXvyI3bLMap
         uyyHcnSYwAi42wWiLz4GW5FERkHelt5rs4/CqBo65T/N2nP1xwKCIlpvS4L+7qa3w2g3
         SaBC83LBVh57/XKknJqw3cpgRZEadOOJ9Owp+YUvFArxLvUvT9H6oLYkpdm9wE6UjQzS
         t+hT5RBWkEt0PZYFckKU4LWftHsjFn93Vgnl8D/Iz7tj4lNhpo62JBXZcRWuy1Iimnbq
         tvqOf4FAnCliC2CvOxr4kxUK93Z2sBXNx+E7RdUjPkIf8RrEhGkzWOu56CT8ERsRoaXP
         Bu0g==
X-Forwarded-Encrypted: i=1; AFNElJ/VwsI6nxTJrfGvfP28eP6UqtR0Z5jIYGprpKCr0StanqLB+hnasDaq0r4tjcJ2LIRoYcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNcFuiRePmw0eL8SB7A3rhXF0+6Q6UrKubE8RM0uvonfOMybQL
	La0z2XZOc7XpAmJXSaCqonbQp9X1NYgj5BWErItFi5bboFcjbq9MR34QbAKnD/cL5aI=
X-Gm-Gg: Acq92OFs5swd6AruoCLNaof7DNfEMtFlq1usqoPliz0yUKx8aB+OqY89WzT1ATntVus
	X6WZb9LwSTZ3oTgpOC1sby5Z/2MTV6jMbzyrXiOZp3wLiUSRDxFlWDp7UIKLkYcgdF90Klz9GMM
	ZQy6DEBeE9MbZForwjaXz7vbzAXBRf9vOWhD9qwlmESQP1TQr2CSzNxDkx3yTguQV7PyBt8xIRA
	36+B3sQ3ESwQ17nDoCbpOr/iJld1yfG+XpQO5IUXg4Y1TiGXvkBt/kkrCjFiY2hlsKy76fuMCfX
	XfMDpUWgFsCi2juIccY3UH3bFZg8t+H7gAD2CjKJMRn+oqjvD1SG3yOoudpRuRACnDkwGAppoJ5
	yW8TxYV7HlLnoj1K/xylgONEKQ6Jp5wYnmQ6Xb2jvBSBYdKsw+BAAtLImgoLRR3+9Y50sbnfyyC
	9knOcw/HXcCrSZ6A==
X-Received: by 2002:a05:6a00:bd04:b0:82f:2226:5aeb with SMTP id d2e1a72fcca58-842b0fa16a6mr20948292b3a.20.1781016659235;
        Tue, 09 Jun 2026 07:50:59 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:f::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828821d0sm21446834b3a.28.2026.06.09.07.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:50:58 -0700 (PDT)
Date: Tue, 9 Jun 2026 07:50:57 -0700
From: Joe Damato <joe@dama.to>
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>,
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
Message-ID: <aigoUdgW/icfFwvh@devvm20253.cco0.facebook.com>
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
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLikOyMh3Kbee-AifLXQryyPt-CftW7VYHeeKWoCuMoXj8w@mail.gmail.com>

On Mon, Jun 08, 2026 at 09:22:07PM -0700, Michael Chan wrote:
> On Mon, Jun 8, 2026 at 1:31 PM Joe Damato <joe@dama.to> wrote:
> >
> > The xdp.py test test_xdp_native_adjst_head_grow_data crashes when run on
> > a bnxt machine (and also crashes in NIPA).
> >
> > It seems that the bug is an underflow in bnxt_rx_multi_page_skb, which
> > builds the skb head:
> >
> >   napi_build_skb(data_ptr - bp->rx_offset, rxr->rx_page_size);
> >
> > The problem with this expression is that in page mode rx_offset is:
> >
> >   bp->rx_offset = NET_IP_ALIGN + XDP_PACKET_HEADROOM;
> >
> > Which evaluates (at least on x86_64) to 258.
> >
> > The test test_xdp_native_adjst_head_grow_data tests a case where the
> > head is adjusted by -256.
> >
> > When this test runs, data_ptr is shifted to frag_start + 2 (where
> > frag_start = page_address(page) + offset).
> >
> > Then, bnxt_rx_multi_page_skb is invoked and the napi_build_skb
> > expression subtracts 258, landing at an address before frag_start. This
> > could be either the previous fragment or the previous physical page when
> > the frag_offset is < 256 (e.g. if the fragment started at offset 0).
> >
> > When the skb is freed, the page pool fragment reference is dropped on
> > either the wrong page or the wrong frag of the right page. In either
> > case, the corrupted reference count can lead to the page being
> > prematurely recycled while still in use. Once (incorrectly) recycled, it
> > can be handed out again and on driver teardown this would result in a
> > double free.
> >
> > The commit under fixes updated this code to handle the case where the
> > native page size is >= 64k, but it unintentionally broke the head grow
> > case.
> >
> > To fix this, we need to do a bit of math to recover the offset if this
> > is a page fragment since it is not passed into rx_skb_func
> > (bnxt_rx_multi_page_skb, in this case).
> 
> I wonder if we should add an offset field to struct bnxt_sw_rx_bd to
> simplify things for page mode.  Struct bnxt_sw_rx_agg_bd has the
> offset field for a similar purpose.  Thanks.

I don't mind doing that, but I wonder if that's better material for net-next?

In other words, we get the minimal fix in (this patch?) and then do the
cleanup and struct tweaking as a follow-up in net-next?

I could definitely be wrong; I had just assumed patches for net were supposed
to be as minimal as possible.
