Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795476384;
	b=5Nj+tk2+/f70fYhZPL2S0k/uCvPDsvRfJMgBwD19vZeFaUmkQ6oONm1YOARD0faKerLD
	 LxGAaWzr+d9o2XdqfbB+IJ/lghoDVU2FXs8sR4pNmoTmM89/i+BcAc59hEtUGBKB7KOje
	 0QDHOFu3vpWxHfMF8QFis+QDL10lFq/Z7ffNB3EjFDA+OHk1cpUxgmuoew0tiUxnGcuvD
	 wFOo0Y13NCoV511vqN8it2mthZ/2pKwLMEyFwkgEniClsX4/oUVt0U6RvZYUmoBH9/vV3
	 lKut6JEeKF5vCFy4qQLP+GxWj/ssOC7QgHJZY58iXGBf/PiGzicNYJVJAGSahOji2zA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795476384;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=MQWlDJjW8xpL/p2sZ5f4jnbMjOG08OgWckpms5J2u/g=;
	b=cZwL+aUoFUDHpMLtZ/iIi/PZWattHpN0hmyyiQdmlUYx0l70WVUTcqfwrFJoUdWZ/7hI
	 2iD+wCoVH4GLZcTLzripNbNxDeyLOYlQE50+asfoxZ9F2FC/a6wDQenKxjK5hRM3gFn1b
	 gbXjWECVftSfPOzf3khfbUgUqfIn0uD4NNsTTJ9vsiklDQoVAVnlXL2NEwg/EXcn1eUaJ
	 RgoCS3EtPTktIO9rtdC+o5liCKWzJL0vAoWaN2z5xS3SesH6Zne5CTL4Yq8Mw8C7Klcv9
	 Oo/WMjyjCptTBbsqtYW+DzWdhY8WVUsjdFUEuYMtkLjCc/ByFhHRfMAXnQ+7MMaV32Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Ny5pcpEZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.42
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE39606A321
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 23:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFE39606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Ny5pcpEZ
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-48e2d5a69c4so2010885fac.3
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 15:26:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795476383; cv=none;
        d=google.com; s=arc-20260327;
        b=ImWkh8icex4evT6+7hoAA0gi7rSb7Cd6F/HvhXPm9nQb4zZloTKFGa0NgZkMMZJ1t9
         7XVEMFp6JKZRvPJD+S9md6hEcySdrP0q5ukqVBk0vtvC6DHPmtEqeLnurTr7JBRiaMRf
         YSnQ9EE4hnChsRm84EzyywnKq9BqVqKfF0PBMm7E1hPZRmuM+C4IwLFGva1Rkrn2LTou
         zwqKmQDnIgotdYkSDPWOmdSxWGi4RVcmjKtDy56unPOH3IOgmKHvSVMo2yJZpyu1e1z0
         yHhgDDVQ+zYR3y8Ut0t6SUM6xaqFr4MpbRENPzsQgPoozS8dll5XoD9VLMmDYlIaBTDr
         WvzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MQWlDJjW8xpL/p2sZ5f4jnbMjOG08OgWckpms5J2u/g=;
        fh=VgSKTleNvXlIHqbclMwvL71cNZf+/4EahdLlNnTszKw=;
        b=RBfo8nhEKPSi2O/t18KGbC+LvZRUdGRjz++ElJ8uP2MkMJcooLqE2/w3JJKxfITC5A
         4Hj3jJCv9+VhZNcPHdHt88yvwg3cJTkXEY+BUgbkeBo3HU+5kfdGiunoIU0FQNbSGSTw
         QeBO2FI6ZsOzBYowvOU3o47jT1uez2qWSK/mSYQrM1UCdzYN/VcmtVauNb6A3xgFX8ei
         140zHtHwWyp9ane+u4U6W7oZKBq4cAJLVfzzjNAzf+pncvzUNMaVqpC7LRIrJJEe1V+K
         VlDVKCqkmG3zUQXPErhL7oYaaGL7cxpx9jVDEYs7+sET8pu30cdXtflHycJh6PO87DNJ
         5mbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1795476383; x=1796081183; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MQWlDJjW8xpL/p2sZ5f4jnbMjOG08OgWckpms5J2u/g=;
        b=Ny5pcpEZW/QhMUJMZc3xvd1BJPBd93ty31NAL7quY331QK2N7vYBQrggjZ5J7SKd6w
         lQqECpjRBFmlGJ61ZHNINiqdYDLVuxBX76cPTDe16ytr45ux2GzaTCIY6YBjFjeBd576
         xbOG7iHumylmDGJlj7p5qqsi8Kb2rYyzhVUDQxRI75HeZlNp+Yxd5Q3AfBM7Yy61ydlN
         vq12SvSOC4VvPBOndIuIE1nvO/oskcCtCNweebWQRrJOQATYw/AeXFuXJcjfpyEjlD8o
         cOUyZGegh++M8dPUSlwg1cbC8UC5WKKjg4qWn6wxSVMklfjynhD5O0HJo4JMfkqWYjB9
         xk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795476383; x=1796081183;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MQWlDJjW8xpL/p2sZ5f4jnbMjOG08OgWckpms5J2u/g=;
        b=eeLKmQwUmfPakxKf3dFYfEm8OafZf0UffTdc6kSPOn9nb34QEPUrRpCunnCcPMdHe/
         M+izafpoNkN2c5ofXdomGS84U8eW31A5muYv1e9GYfrQ5bIvmYErq0dP9brUdMS16L44
         tg4+T8eLgmDXci2BWaMPDXJB7rjw857x4UVyEvMnSpYW8cmObDYUPLk1S0xzS8v2vCyq
         9rz30+v7tZY3R9lq98fxEKXgJTm0UMUL9N5OjyzJrEjlzLCcese5bjjc1EJeln4UGCy1
         DmFRT+QzWC24EGdvPs9A6Enuq/+OA+W45kZQqm/Kpy0L4sgsRjzrakaTsopa/h0ECFXu
         CXFQ==
X-Forwarded-Encrypted: i=1; AL+hErFxO6nQBRqQPcOmRgfDNvq1BBx8cqnXjuE+3RXN5ahM2FfQDF2gWe6f1P3OOOGcgn3673I=@vger.kernel.org
X-Gm-Message-State: APuU4Z+A0rKKH4uOQMtJWB/Gfq3LL7Ovom3064XKECnou7UjRyXLDOn+
	8EgzssfnLDCeVUIBlmLbI0OWfDTb/zwLqnz0tfjkiRVQ50Ie2GzKBYoLkKqJ0pGzEoC3DWtO/Tf
	y9xImYnk3WUD4QqC+MOAEI3oSyBlGxuP5C6jn9SIARQ==
X-Gm-Gg: AZFdTZdtjyClUA+Bu4fGrYp9Lg9MMkjP5rek5vl9Kvxzfz08pkk9FsCw9ltwCrpshPC
	PBYpEcf+/K9sEmhk6DyJdNSavgirOdSZUNGExNfGA2JYUMW020K6rCVmX22JcqRh4w9NneInZO3
	w4LxL6qjMMm5Kwmh5xEPUjHWHlFc5nIGIDi0FZBiYu+jYsXwYWSkSTOObOw5Lfw6mxnID89Cj5j
	YUjKicx1sz3XZn5V5IB1rl+YvqyMJKdDO/aS02zCMpi42qVZsB13ivkei3yzNOOE/Ks6tw1xcD7
	vSg0p5cuB8yOls4XWeV8KP8Ko/hr9VNtS70E8VAIIBqzLDnuCMzgNr5f7vZ+u7bqwNg9XSvKIqd
	JbksHzr/HKToXdCX+j1cbx5+8CpoV8/kYdDnd1fbf0dYEs+k0FnkPNl9zCEdwH5TXL/JySfPJ7N
	EdSAzy8HP2XQ==
X-Received: by 2002:a05:6870:31a4:b0:48f:e0f6:bd58 with SMTP id
 586e51a60fabf-4bc860f05e8mr13202699fac.41.1795476382627; Mon, 23 Nov 2026
 15:26:22 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121012402.84848-1-tianyi@cloudflare.com> <3adef4b4d528780bae31f2fb02d0a08bf9c8ebd5.camel@gmail.com>
 <CAG4wq-f18SHytDb39SdJYzRPk-dzECjH_HCSiMGAQ721Zmfomg@mail.gmail.com>
 <CAKgT0UeWWherBt1MDcPF7R7jxt6E_3peo8VuxrgY3JdseM-0rg@mail.gmail.com>
 <CAG4wq-dizUz-6GB8Aj1wRTQBOzbHbT7pX9gom+AhR=5OWSyjzw@mail.gmail.com> <CAKgT0UffmbELMsGi8HRfu62MfC9VRYZ+TMNKFjZMWJyrV4t3jw@mail.gmail.com>
In-Reply-To: <CAKgT0UffmbELMsGi8HRfu62MfC9VRYZ+TMNKFjZMWJyrV4t3jw@mail.gmail.com>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Mon, 23 Nov 2026 23:26:11 +0000
X-Gm-Features: Aa3M54qQLsKa50Hpke4S8nRP-l5tPOwhsGlHSy5rlgDYx5CUns_VsM1q-PHhDTE
Message-ID: <CAG4wq-cG1bseTFczZTjashN75J1Jsrv=u1ccuRsY-N1kZ=SXXg@mail.gmail.com>
Subject: Re: [PATCH net] ice: do not report CHECKSUM_COMPLETE when an XDP
 program is attached
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Paul Greenwalt <paul.greenwalt@intel.com>, Alice Michael <alice.michael@intel.com>, 
	Eric Joyner <eric.joyner@intel.com>, Jesse Brandeburg <jbrandeb@kernel.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org, kernel-team@cloudflare.com, 
	tianyi.gao@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

Thank you for being so responsive, and I really appreciate it.

On Mon, 2026-11-23 at 14:42 -0800, Alexander Duyck wrote:
> In the mlx5e case they were disabling the feature via the private
> control flag if it was enabled. In the case of your change you are
> just disabling it without exposing that it is disabled.

mlx5 does not change the private flag when a program is attached. It
sets MLX5E_RQ_STATE_NO_CSUM_COMPLETE on the RQ, and
rx_no_csum_complete keeps its value ("off" by default).

> is it falling through into the CHECKSUM_UNNECESSARY path with all
> the indications that a tunnel was still there even though you
> stripped the header?

Yes, the same path as E810, and mlx5 does the same with a program
attached.

> The issue is that the driver is making a number of assumptions about
> what is there based on what the hardware parsed for headers and such.

This was discussed in the thread of [1], including the decap problem
with csum_level. The summary there was that reporting
CHECKSUM_COMPLETE on the XDP-to-skb path is unsafe, and that the
safest option for now is CHECKSUM_UNNECESSARY only [3]. The decap
case with CHECKSUM_UNNECESSARY was left open as a known problem.

I am also working on the long-term design in [2], though there is
still a long way to go. Please take a look if you are interested.

For this patch, my aim is simple: stop the "hw csum failure", and
make E830 with XDP report RX checksums the same way as E810, i.e. as
before GCS was added.

[3] https://lore.kernel.org/all/20260721183256.6f49d6e1@kernel.org/

Thanks,
Tianyi
