Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDF52EB10
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 00:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778805605; cv=none; b=ax5fgaqXFRgvlqHhDOaIGStdQMEXlh0OcJZkFmfZbWg9fArZhg4bNdSajadPHPtWbXHQXRJ038nsa3t0CMCuclP/CwUjQ4iH1gSflCU9ypymAZTwid/EKbWCv3NCuywmBjFVgka88p5TUHRcnk+5rNNQ8FkUYlt1p1aDnaIt0l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778805605; c=relaxed/simple;
	bh=MPsAoDgwSud8ujCJSnrS05eA3l7Zf0/YspFqjl5KxL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L18BKz3k2sa/bzF5u3B6vDqzegrlXR+hJNjcDmmpnh1hX43wbnPROIHXiwLaoP9FuDTSDP/tdJmonD9CwVU+ZWpPzS5oq9V3RsZCVq8gZGFArBfVAKK2ONWLTABJjOdDFPUwIQvfUvf647WQalEGZq1myph0V6Xa3/BeEVRq8Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=OohOHiBa; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OohOHiBa"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-47c7b282e21so3545259b6e.1
        for <bpf@vger.kernel.org>; Thu, 14 May 2026 17:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1778805598; x=1779410398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UFhBAFvMzOFdU+dTo9inXOk2WrWYrKcxJWd53K7eJsI=;
        b=OohOHiBaLc8K5Tlts/0Tu6ucHfYd3CGIYkLRiVPto4l+BdZKEjA7lFRldtNRyDjrgR
         RR8+BxBQxOaW75oE32lJHCp8W/ji5ObHpOHflrxJpQm1e729J6CzwY8+uifqbbkNRfLI
         sk1SLVKkcwCbeAjIagqJZTUNPcWnF1U1B+HAwLBhEusqDCTCjwAo3rVQ+YstlyzD33Nr
         s6ZRmbyLVu8KBfv5LQS33sihWGCvzZ2Oe63SZUbktomvU/a03x1Uay9iy5G1KQGXZoWe
         e4blKx5MKsyDfz/mgni1kZP5ity1v28aA2CKOgYM4JJwN1Qe+FxKf6f5uK/BzKCIn4op
         VGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778805598; x=1779410398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFhBAFvMzOFdU+dTo9inXOk2WrWYrKcxJWd53K7eJsI=;
        b=J+B38tfpAGndj42FJ0z31n/DDpL4v1fXN2D93p9MbyR4AdyBZ5ANPsMJUXdHlB2poP
         z/qwIH5CIJTVfH8c3JfewIB4XYr1st6IoPdEQLa877RaBNQAT/FIeyTnNtPiVTn5jXZu
         FatEvNM0dm4E5aY935AUcqibrnrwLboJXtXZz8PSlqNv4KzM4+GJd8v5OCQ9pUXvvrV+
         wy2TbOZ0trwPZwkw3b+3LtE7uqYfGQK/hPO1ctqNvDjV8kEKXxZh/sZ3JOWUkezPZaVL
         gKZt1Xgdk8M2UGgrESvbuxVDFKgIXxNCRP5nwyE4+Qa9ATR/s/DXHUMhMrC/Y1NPPmzo
         Y2EQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Gv9MxM1eD+iHVYzwlcDgn3SDDmAvjEXTQV7d2qzdsMQSX+AX8+tsEENuS/22GFWKGUG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfMXEpafHDT0Rg2mvKU4uO5KXpq7PAr3+t6ptcKuwqmb6o3fzQ
	XdKr9gIeNbWaUX/vnmyNbqboqYpX3k4a0op/QbRORWa2/dXyas/iO/FnTZ1wT59ngL8=
X-Gm-Gg: Acq92OFX+a6+HQw+azuqAbFwvWPw6/QyrXRuDpSo8sjPYre5NeH2Vm2UltzcyTuy9g6
	e9Vf+e0f7bWtTMpnlmWmrbBVZFGN9KK5RkKQD5dgX+xRy2DGTraSCKjRpTLvFHZYA3N4aqqUL7C
	skvrZlhvmcCutU3PwmjsNuJjkXtFEQGscv2zxoYyk2Kl0MDf5PUg6fBfpeKEGtjsWXzug0OfBov
	xOort61Y/e5hRgtygTF1uC+J/+XYvM3IiTX8FpK2RqLoYKblOPlLi+pagveccGNFrrKgfQ5YM2F
	o5VN4OwXRr3mWiQzrxMNqUHvKVjMbhC41I8x3mhwFFVnrEozi2s3ym5+2EhidGKaCBdMSX1VaN9
	fiTjNv1PbTenh3LRBOzOGZshMb9M39CNbjsXYe2yaB5abgBRfyFZ9QskAbaTg8bER2TqSXzei4C
	rv5EI=
X-Received: by 2002:a05:6808:384b:b0:466:fcbb:1673 with SMTP id 5614622812f47-482e56c1060mr1243567b6e.17.1778805598394;
        Thu, 14 May 2026 17:39:58 -0700 (PDT)
Received: from 20HS2G4 ([2a09:bac6:bf21:96::f:3c1])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-482ee331fa4sm55843b6e.2.2026.05.14.17.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 17:39:56 -0700 (PDT)
Date: Thu, 14 May 2026 19:39:54 -0500
From: Chris Arges <carges@cloudflare.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH net v2] net: Clear skb metadata in LWT BPF xmit
Message-ID: <agZrWsoTb0v4XieV@20HS2G4>
References: <20260514-bpf-lwt-drop-skb-metadata-v2-1-458664edc2b5@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514-bpf-lwt-drop-skb-metadata-v2-1-458664edc2b5@cloudflare.com>

On 2026-05-14 12:47:09, Jakub Sitnicki wrote:
> skb metadata is meant for passing information between XDP and TC.
> LWT programs cannot access the __sk_buff->data_meta pseudo-pointer.
> 
> However, LWT_XMIT programs can call helpers that move packet data.
> One such helper is bpf_skb_change_head(), which uses skb_data_move() to
> move both packet data and metadata after skb_push(). skb_data_move()
> expects metadata to sit immediately before skb->data. This is the layout
> that commit 8989d328dfe7 ("net: Helper to move packet data and metadata
> after skb_push/pull") preserves for TC(X) programs when skb_push() or
> skb_pull() moves packet data.
> 
> The IP output path can run LWT xmit before neighbour output has built the
> outgoing L2 header. For forwarded, or otherwise RX-originated, packets
> skb->data points at the network header while skb_mac_header() can still
> point at the old L2 header. If such an skb still carries XDP metadata,
> skb_data_move() sees metadata ending at skb_mac_header(), not immediately
> before skb->data, and warns:
> 
>   WARNING: CPU: 21 PID: 454557 at include/linux/skbuff.h:4609 skb_data_move+0x47/0x90
>   CPU: 21 UID: 0 PID: 454557 Comm: napi/iconduit-g Tainted: G           O        6.18.21 #1
>   RIP: 0010:skb_data_move+0x47/0x90
>   Call Trace:
>    <IRQ>
>    bpf_skb_change_head+0xe6/0x1a0
>    bpf_prog_...+0x213/0x2e3
>    run_lwt_bpf.isra.0+0x1d3/0x360
>    bpf_xmit+0x46/0xe0
>    lwtunnel_xmit+0xa1/0xf0
>    ip_finish_output2+0x1e7/0x5e0
>    ip_output+0x63/0x100
>    __netif_receive_skb_one_core+0x85/0xa0
>    process_backlog+0x9c/0x150
>    __napi_poll+0x2b/0x190
>    net_rx_action+0x40b/0x7f0
>    handle_softirqs+0xd2/0x270
>    do_softirq+0x3f/0x60
>    </IRQ>
> 
> Drop skb metadata in the LWT BPF xmit path, just before invoking the
> program. Doing it late, rather than in ip[6]_finish_output2(), preserves
> metadata for tc egress on the outgoing device when no LWT BPF program is
> attached - the only scenario where carrying tc-layer metadata through the
> IP output path could be meaningful. Non-BPF LWT encap types do not run
> helpers that touch metadata, so the BPF xmit op is the only site that needs
> the clear.
> 
> Fixes: 8989d328dfe7 ("net: Helper to move packet data and metadata after skb_push/pull")
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
> Changes in v2:
> - Clear metadata in bpf_xmit to allow access from tc(x) egress (Daniel)
> - Add WARNING snippet to the description
> - Link to v1: https://lore.kernel.org/r/20260428-wip-skb-local-storage-from-scratch-v1-1-8f7ca9b378ce@cloudflare.com

I was able to reproduce the problem with a C program. After applying your patch
I could no longer repro.

Tested-by: Chris J Arges <carges@cloudflare.com>
