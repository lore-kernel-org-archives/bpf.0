Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795416691;
	b=0N935ZpVCR02B7cP1jyTd3UwOdnbLpEHUYr+saGLJbIlmsHfv4ibeUA7HYCK7Pfko+zJ
	 QO3mXtZJe0b6ftp8tU8pmsFbmOlK3KUMCo1QYjKD4XJzfIUO6b8YQ4zic+7Y30j87v1lA
	 xb+Mtal1uGkKmka+of4M6TCJjWT/q39OSAMbh+D150dqi46kbBNz3mZNDwyaanagag8rB
	 eiyl2xv0PaLpFYLUmfsoAwk1+NZNdL17dRR/jDrqu6qxe4aOaoKgFrUyenN+O0UVoXEIt
	 xzZsKe6PujsM0IhT5/90E7ymCHbZAJXLU9pSIyMG4dEiXkCQHQy29xQZSKJ4HoMSj4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795416691;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=K+6B0gWoSrUledv2HKRXi0gyYw6VTPkEWeocJbaGXVY=;
	b=0yBn3ms+oL+w+5ybcag20gCxZml7sU1FJP6WbQhLwPlO0gJaw/nPOPhRZQ1nBnbV6K/9
	 xGHrs+44eIN15Tt8cvvkxDfnXMKYk0KrV0IkeYCaZPfz3m4pYgvraw3yPppSfWSxdtXx6
	 MKBPLCT16U8Iar7QyaWVZf2ySO7Xp/vei96rdqy11JdVl6hnwLo7PLL89D7xlRAtRuG9C
	 pm2LiOBdpu2yw5zcSTUeWaAv5tvaMOGRgmpjRchW7iAk043T7FxY+zoRfarWIOYNGb9/l
	 w0plNbE3/5if8pRnVbgEKs0FN55g7XZAt6XlwsgWVoFnKIrGM+F6nUE9zNCbXEeL3pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QjRNna0B;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BD5606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 06:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88BD5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QjRNna0B
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc147d86bebso1501066a12.0
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 22:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795416691; x=1796021491; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K+6B0gWoSrUledv2HKRXi0gyYw6VTPkEWeocJbaGXVY=;
        b=QjRNna0BnzrMShDrBLER9RcS7SXIBigrkI1n4Bk+l9+Xh89Juvw5yv3CkkklTVfoVU
         grvTUapDfWPJyLD3z3a1Tp7UTWcEAtCYjcs0xV0M4CrwroRQ+LsaogwFtkii8F27sbtX
         aoG8Rlv2K5euod4K8q0y17aE/6KUeAc6Kt7IjZb8mvyyU7RLDoPAN4wf3MjfY2Yef+SG
         TA5VFEIytF2KB2JCbtt6svywVI4l8wHPVqTo5X8iIbi6Snsv1zkPdeREwAVG3Q1NJP4k
         HH6p2v2pT7DkSJ6AKpOitvVxgiHI9cOXbw02i5qukjv/n8Jqw5+LkOFvn+RvTl9kkNo3
         /tkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795416691; x=1796021491;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K+6B0gWoSrUledv2HKRXi0gyYw6VTPkEWeocJbaGXVY=;
        b=jm5Fhf6YQpotsPd7MzRfYPQGx54j+eUEmVzGvP5EylYYUiCRNr/ssIjcplrnVuB99X
         NKwK1X6FC9Iy8fWWa7Gg9Fbf373EPuBZF01qyoeegDw5Z+2F2dm9+w7hZPbq4wkOI9u0
         lsO4nC6VrbgPbZT6MxSLzAflyaj8byPLNC/3amq7/ikHeic4HcE9LRVNcd/Ms4TDfw3m
         qn8H+oSgdgwbmpJVjWvc/Ak5hJSMI37FJ33YrqToY19lpOkecLb3JKapm5Vr+Wqhih50
         Nb06RZ8hFOxzBvok4RVsIzoB/f/r+Kef6kuSwsbviNTlJ7dOtuYIxePUEHZtB+98PMM2
         TIPA==
X-Forwarded-Encrypted: i=1; AL+hErE0hOQ1nbSALiLIt6jhieRcGAi5uGxf/5MZ0erJX0DaX1IYCUslD2c3kosusPd3MmjrMC8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/z+RkQS3G4o/wSx4wokyMtiRb4fzyEMTvAZnHwlYptIRT9xkKc
	TGdTuQwC6kGivrXtAmw3cs+8qAQZNUjqxFZwCdHIwjbH7jCI4PA04OFi
X-Gm-Gg: AZFdTZdDMwpHtpMR17h8OkP4UssLPfE5G9A9eR/hGHsXpuw1kjVVZ6Jz0bSnKJwPtQ+
	naOinwDvuqYfADLsGtcC5yOslZm0sbywTHdnzN/vbP+BtQ5hrBRM/qwth1OxaDGTlGk6APfNPeH
	ReZrnHAf9Ewztc9B2BDvmhnUaBCTOepUiCizxuS+dmX3EktThTeVUAWyUUERzt70khaheCWwAJk
	i0J47k5ujZRgmd6xLOXBBc/wEFPJ8Jisp5KGIw5pwhjwJICgzUBwr3cxFTvFUhJRZE/AB43vC/P
	L++gfjtsBjF7yu+A00Mu4SC3XzRPdT0SufG/IVJgG1Yrux+2B4AYRQFImCYSdObeKEXYPsqKhLk
	H6oe5gvGK1/nGMuxwlAYECvuf9RycFmIXgqXZb+rDSCytP4PkBbPyk+BPhSnTyLVOjPQcqM0YSV
	4rjW5TGyTkmy01oY3eJinJGQUe1GjwhbR/Fx9iemE4VcIWaMqHJCJhCt6ZPkT9Qhflpc+ODfOhl
	NFGUNeGaoyzuwvVM3eFufGZk0RI/4DVigaVKa0qQMHggsfjK2rD1CP0ZarHRyzqatyq2dYVni2w
	9RvnfI+xVmMTzZ4GbNUCMd5mSs2LeB8P9WH9/PpVSh+hZq7n9NO8iCOXybWByjtnoCKYl5sclZh
	tILNzn4H3uS6RrHvAZCIvivhBfkZqBnDulQ==
X-Received: by 2002:a05:6a21:3995:b0:3e2:8c2f:4b80 with SMTP id adf61e73a8af0-4014db586d6mr7642491637.25.1795416690430;
        Sun, 22 Nov 2026 22:51:30 -0800 (PST)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87344184fsm5152236b3a.35.2026.11.22.22.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 22:51:30 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 06:51:29 +0000
Message-Id: <DN2E3KPRKZL5.3PSJD3I9JFARH@gmail.com>
Subject: Re: [PATCH net-next] net: gro: skip the checksum of fraglist GRO
 packets
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Rosen Penev" <rosenp@gmail.com>, <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Willem de Bruijn" <willemb@google.com>, "Simon
 Horman" <horms@kernel.org>, "Neal Cardwell" <ncardwell@google.com>,
 "Kuniyuki Iwashima" <kuniyu@google.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261123042735.139550-1-rosenp@gmail.com>
References: <20261123042735.139550-1-rosenp@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sun, Nov 22, 2026 at 08:27 PM Rosen Penev <rosenp@gmail.com> wrote:
> Make __skb_checksum_complete() verify each packet against its own
> headers instead, and mark the skb CHECKSUM_UNNECESSARY when they all
> match. This covers whatever asks for the checksum later: conntrack with
> nf_conntrack_checksum enabled, and local delivery, which happens for

It doesn't. This breaks tc progs.
Today the skb is CHECKSUM_UNNECESSARY when a tc ingress prog runs.
With the patch valid packets fail skb_flist_csum_ok() after the prog:

  helper                  what skb_flist_tcp_csum_ok() gets
  ----------------------  -------------------------------------------
  bpf_skb_pull_data()     2 packets, mss 536, thlen 20, all pulled:
                          len = 1092 bytes, th->check covers 556
  bpf_skb_change_proto()  6 to 4: ipv6 = false, frag_list has IPv6
                          headers, iph->ihl = 0

TCP drops the skb and conntrack marks it invalid.
CLAT has no IPv6 socket, so GRO always picks fraglist for it.

> A fraglist skb whose geometry was changed after GRO, by NAT or
> bpf_skb_pull_data(), is segmented by skb_segment(), which computes new
> checksums. Such a packet is now forwarded with a valid checksum even if
> it was corrupted before it arrived; the packet boundaries needed to
> check it are gone by then.

That's silent data corruption. It's not an option.
tcp4_gso_segment() also takes that path on SKB_GSO_DODGY.
bpf_skb_adjust_room() and bpf_skb_change_proto() set it on every GSO skb.
Willem's series adds skb->encapsulation, like seg6 encap or ESP offload:
https://lore.kernel.org/bpf/20261120044733.222627-3-willemdebruijn.kernel@gmail.com/

> At the full MSS the router already forwards at line rate in each
> direction, and csum_partial(), which took 27% of the cycles, drops out
> of the profile.

So there is no throughput win at full MSS.
With the default nf_conntrack_checksum the work only moves to conntrack.
Paolo suggests to remove fraglist GSO. This adds another state to it:
https://lore.kernel.org/bpf/ce3e6832-ca9f-4e91-8302-b5bd7cf2f178@redhat.com/

Nack.

pw-bot: cr
