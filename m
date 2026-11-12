Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493160;
	b=hD/uQfeTiMPATuwWZvYX0sEJABLx7HSPfbOshoEnkzEqLC7B91SXF8R+C3u6fTDjc9GS
	 YLrShzfcP9fNFrWHU2dB82WiidGKUZ/1ZcFTFl6zxvD8ZU7cVwg4LN88hLebTfVK/iIG+
	 7xnAZr3TnXynJmmAJhQ/iuKZFNAooobrzCyBOUPtAFNGHRUAsidFMDjb3dzla2tZ2cusH
	 7NfIOAM+TF4NLGeOPUJo04qEXkMfiCSwIJuPCAP+Tniwau/xtnri3PbWKmw42PEikJUWR
	 LFjUDrx8G4e5vVqDeiyiVAZk2VI7urCg6fwkAXLGkMP+QEgFNZ+1Omjgjr9Onfd9HXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493160;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kd+/Nlp8ommBqhSffMOJg7lXCNoL6VMsRA3sgFnMf+Q=;
	b=IsgscGNxV5MD93WPys5eJk7UrDZImGVzTY2QDa6QfN3rE5gbGP4LFgYzsjARgRr5cLgc
	 5TQ8WFyfMFKGswZtJFNLO/SZ7990ndUGg68oPt2PQpe5p5dFgyRDFHUTPJcUyBtKSr/BM
	 96Lt73L9/aNlZIiAIqKyE/UvM90CoXoLqn8gFn8g5f3Ny4sCbyyy3RMMaG0czBOxe64hs
	 NKScp+J8Zw9clrtjmivwfadcOJ2z3r6FJ81p8+ASNs1Pt3hfLUcSzBRG6JtucS8F2ZarW
	 xJJxfobQiA1lI4SiWjaLisSiLXEVC64qyM/br0n8P/ZMuwaboUWtQvdoNJcvbiUE3cQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n740z2IW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.54
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D70606A89E
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 14:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17D70606A89E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n740z2IW
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-486f013db83so1532410fac.0
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 06:19:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794493158; cv=none;
        d=google.com; s=arc-20260327;
        b=iV2sEY4LNGqQyRrpbN7YTDDilNkdvHvRzqRvWo9dpm9VVWq36efwXtpKKJ1fFk1Dzr
         /IGEmbeOI5itO2frDhxwbX+lHVUgTDGdW4kP9emvjO1vsOy05ASsB3dA0r6fhujtUH3e
         TP4/9FgheslogbHSGrwPrL0WjOgrr280ocUrVNl//YVlK+Fp5KCqO+gTVGX/J3a/Ino7
         QbU1uLx9sPVCfahZh54+1+vGXml24gF20h4LtGHWECE9cx6pEi1UNFWFrQaE6K8xWLQx
         Q6Wd1KJw4BPnlXQw1BeTUo3KeHMABqiLuobusH8nkJBXakOo4PwlUQRK0zbRi5txQTpf
         iD1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kd+/Nlp8ommBqhSffMOJg7lXCNoL6VMsRA3sgFnMf+Q=;
        fh=cqF9UQAeIDO6AO2wOFsf0ah4t6v2VuIDQRjv/YghPLg=;
        b=Yl7ZZVY8E6rXsknQGnW1sPGiN9SZ38hd2rgQNP3SbxTXb2pceEi4uSicbETQxgKwrm
         CBzAGBIA+LJU/CgrLfbqOuHP8ltnhvMH6dBgoDvCxNamPANTZTdaOt0ItPwBhBoN+sU0
         mSchRgFIGy+208YXswI8ecWYll+sraL5zYq6b6x4n3vcl6VKSUoxRcM0sSlWAkLJx6r0
         g0PVbgOE4ZYeBcmuXr7dZXhcIgy/zn5XSS+lsBUOy8VxHrEiFhVETLJ3lgHaHm8CmYdE
         HhUJcrO4P/IQDQ8xWnt7hK1rTuFNkv0Cw/5crMBl+HlGHhdqv+XzO5VW83UIj/sLquJN
         MwKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794493158; x=1795097958; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kd+/Nlp8ommBqhSffMOJg7lXCNoL6VMsRA3sgFnMf+Q=;
        b=n740z2IWYCmLBpYIgW448OkK5o3ft2gBxMpiTJ48LxTVxlMv+7UQabzWl8F6WGKYQa
         XOfd8zRj83llakPGeaGvKqWA1+fkHDUv6vc50OyrXLWCPWh6/t8U6bdPN9+S3G1DjowB
         lj02JtRwQz4UnVKEsAv+Apof0XrKarU3AkD0puPyB+s2T18f7BeAZe/GWMdgaSvY4NLa
         mpjbtSeIuZPbTZJz+aluoECSmzpKAziUUS83YuZBggqNkBcaBQ9Ob+mKPtJP5/y3xtWK
         Yboa6/x23UgnFTTfsxFTFIRiSHJ3qlAt+HzWqjptrbJHXV601r5hfhzHbCGQR7h3YTJ6
         L2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794493158; x=1795097958;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kd+/Nlp8ommBqhSffMOJg7lXCNoL6VMsRA3sgFnMf+Q=;
        b=1kpWlP9b7WlI8TYrRx3SgbKOZXkZmk33erW4rak+YZjOFFeUNDjmJSvm5RewhRVY1e
         xbKnjmbSxWu6CEmcxjKO6NvjrIVrziFDCruhBTcFRzWXOJBpNbVuJ84F0iLk6lfla6dk
         11jjS5wOZnBUacwV4pOOX5Y0ZJvJmBbLfrBTwb8d6CW0jVbA0jSI6YWArI4s0ejwCM01
         h2ET5llz+TXTfeabszbfOhSZmXPTyeIVV0/v9PhLOLh+lG4vhL7AD6bYwb0W5fabYhlT
         BSMP0rPEnCnQEBmDX0pYiZATv0YWMU3qrKhZOuqm4eDSm15Lc9CofSJNMAKaI3h0eN7o
         eF3Q==
X-Forwarded-Encrypted: i=1; AL+hErFcr0a1qgy/diCd1aQbI2ZsHGMb+X9hSDUyJAcx4xg52xAs+Wal/kxNVvbrVKt9+c5vx+k=@vger.kernel.org
X-Gm-Message-State: APuU4Z/QFA8QAhG93PH8TQYSvhSIR3V4N01I7ZG7vYAb2hrwjwVsm1BQ
	uT/lmMfmg1j8AJHYjqxDjA+KsNYxLB8vzVSj8Y+yqxpmRm3h3pK7g3BC6bVzJu5WPD/p0aUzzoW
	vZNWw9u8tjrmxSNuXR3pRckZ3/tHEDeU=
X-Gm-Gg: AYBFou2303ISIgeUukPfXsZaKsYi76XfWLoYCS+R+j9DVOobA5GOzS47kP1cVRZMVSi
	cgApz9kcQhQndJKY188GqntutcYmI4pUDKT5DYen8VpP3icjIx5SJ0hoDZV4waUMRKUbODiPmLf
	Slz3fvpPmxv/ukGuWq/j3VrHQLpPj3FZjXzNXAEseC88579NOygjicdIdIrqIHu42VECCha3/C+
	fQpx7Y0/dzC44d/wD1WzXOpLhTJol5YajJy+bPyN/IB3SwaHIQbLCeZgR16QvfyYIpfR+p561Cb
	NkH7EuTdo6RfLL7qVU8A/95oyZs9NaFPA3b1g2RHuzFxit+1ZOTRsObncbbLBAf9k+ypk1olZrB
	8VtYuFdmIe7le42XR8JdEv09A3LLlxy+uyGr/nLYiBoY6xkP31aXLml4O8oVtinpabAg+
X-Received: by 2002:a05:6870:8186:b0:4ad:8800:b277 with SMTP id
 586e51a60fabf-4ae46b9f2famr4644533fac.24.1794493157905; Thu, 12 Nov 2026
 06:19:17 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112091451.22969-1-amaan.cheval@gmail.com> <179447532371.2168702.1261444176228225499@kernel.org>
In-Reply-To: <179447532371.2168702.1261444176228225499@kernel.org>
From: Amaan Cheval <amaan.cheval@gmail.com>
Date: Thu, 12 Nov 2026 19:49:06 +0530
X-Gm-Features: AclHuK-8r8_CUyAx0z3-RpELzn7MRNMdR_7wvQomD_xLmxRhfmXb6fT2JGFsk1A
Message-ID: <CAG+wEg0k_VuhZ5Y4zPyUvaTmK-erV6=A6TDmFS5E9Ycu5B1Rcw@mail.gmail.com>
Subject: Re: [PATCH net v6 0/2] gve: fix RX page refcount overflow with the
 pagecnt bias
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, joshwash@google.com, hramamurthy@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, bcf@google.com, jordanrhee@google.com, 
	przemyslaw.kitszel@intel.com, maciej.fijalkowski@intel.com, 
	pkaligineedi@google.com, maolson@google.com, csully@google.com, 
	willemb@google.com, yangchun@google.com, npl@google.com, 
	awogbemila@google.com, shailend@google.com, nktgrg@google.com, 
	maxyuan@google.com, bpf@vger.kernel.org, john.fastabend@gmail.com, 
	hawk@kernel.org, sdf@fomichev.me, daniel@iogearbox.net, ast@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 2:52=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by LLM and not proven at runtime). If it was triggered
>    please include the symptoms, like the stack trace or kernel messages.
>

Patch 2's bug was triggered at runtime; patch 1's was not.

Patch 2 (the refcount overflow) was reproduced on gVNIC with the splice(2)
relay proxy described in its commit message, on GQI-QPL (n2-standard-8,
6.12.113 and v7.3 mainline) and on DQO-RDA (c3-standard-4, 6.12.113,
where DQO-RDA still used the bias). On the stock driver ~78 of 100
downloads through the proxy failed with EIO on GQI-QPL and ~39 of 100
on DQO-RDA, and tee() of the pipe failed with EFAULT; with the patch 100
of 100 completed. Harshitha also ran the reproducer on an N4 VM in
DQO-QPL mode, the one format I could not test myself, and gave a
Tested-by on v2:
https://lore.kernel.org/netdev/CAEAWyHfCM_ZesnChP71AQvxjM4MASwukesgzuWCYECt=
s7jiNhA@mail.gmail.com/

Kernel messages on the stock driver:

  WARNING: CPU: 5 PID: 1198138 at net/core/skbuff.c:7324
skb_splice_from_iter+0x118/0x300
  RDX: 0000000080000000 RSI: ff34c0bcc1881c00 RDI: ff89153145163c60

RDX is the page's refcount at the sendpage_ok() check: INT_MAX + 1.
With tee():

  WARNING: CPU: 7 PID: 3008617 at include/linux/mm.h:1456
generic_pipe_buf_get+0x51/0x60

And on GQI, once the pinned page comes back around the ring:

  Pagecount should never be less than the bias.
  WARNING: CPU: 0 ... gve_rx.c:507 gve_rx_can_recycle_buffer+0x58/0x70 [gve=
]
   gve_rx_poll ... gve_napi_poll ... __napi_poll ... net_rx_action
  gve 0000:00:04.0: Performing reset

The reset recovered on its own within 1-10 s each time and recurred for
as long as the pinning workload ran. The reproducer, full traces and the
kprobe measurements of the refcounts are at the Link in patch 2:
https://github.com/AmaanC/kernel-bias

Patch 1 (refuse XDP on DQO-QPL and GQI-RDA) is from code reading, not
from a crash. The DQO-QPL use-after-free on an XDP_REDIRECT to a copy-mode
AF_XDP socket was raised by Sashiko on an earlier version and I confirmed
the path through gve_xdp_done_dqo(), xdp_do_redirect() and xsk_rcv(); the
GQI-RDA NULL write came from Sashiko's review of v5 and the FIFO
allocation in gve_tx_alloc_ring_gqi(). I have not run XDP traffic on
either format and have not reproduced either crash. Patch 1 is in the
series because patch 2 makes that path matter: with the bias at
USHRT_MAX the driver hands its last reference to the consumer once every
65535 handoffs instead of once every INT_MAX, so a copy-mode AF_XDP
redirect on DQO-QPL would free a page still mapped in the QPL within
seconds rather than, in practice, never.

What I did confirm is the attach itself: on an n4-standard-4 whose gVNIC
runs in DQO-QPL (queue format 4), Debian's 7.2.11 kernel accepts a
native XDP attach once HW-GRO is off, Rx buffers are 2048 bytes and the
queues are 2/2 to get past the driver's other checks, which is what
patch 1 closes.

Thanks,
Amaan

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
