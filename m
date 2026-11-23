Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795466141;
	b=paf8ureB7EFxkeE6PTtE4n3hzEwiENCbmkiVd3MEW2sia+0kEbZ20GEcX0EviAbiWqKn
	 hiTBueVvB5k9RrIEtFV0CYWDhnlWCl8bTbfsb2gEOZG5SOMil1bcsc4V4rCS5yQbtuRKs
	 L497aGZQtnvaWxQ+MVRQM665Md6kV8uRoJR3bVImWkA5OV6k1+MF9MheGaHy0N/QGjrl+
	 R71rTak3/TLL6gJTP+xj0mWw9xqHLf7IjHs/cyYivm1OkvkCP1paadaExjdDqmGqu94NW
	 g0K7iUqmel0OR22wtiAfzBQtBPBphTlgLeaiA0emw+O/DTTma7kSYgbpxGY7JLZoFUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795466141;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=krTB7RKoikRzD5yyiTQ8FGQ+GcAUNRrGAGBRDsGvivU=;
	b=Lz0iVSLE3uHO+rJiWvYkfuzXasIfEROr1a/ZkBIg8O/nfasdnNGWIxNC0NAv/BFkebuT
	 b2fKu0SO44JQyvV2dEbMW02Ora+sikRSiqKyKTRHxTshRf7p18cgQ2Zii2WDnFzTTF5dL
	 1Lm8EZ/UIhyZqGYmLWGeCM9Vut4WUeSDdqXxG4LLBuTRi7kI6uNxBMO5TRXWqagM69PB0
	 zPHxAnK+CiEZFzQsEGhyTmllaVrSQQKayRO+XP0U+rWKOnXMr4YmiTRNOyVU6avEdWq8L
	 NQZQS4zXc637vH/Z1pTfnMtUItKrqCZak9mom3ug5SgTY8w10aqDpZC3CbF1vHw2Dag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b="QQXh7/z1";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D3A606A32C
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 20:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21D3A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=QQXh7/z1
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6aa9606ddadso2498264eaf.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 12:35:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795466139; cv=none;
        d=google.com; s=arc-20260327;
        b=W1U2wGai1Lsvo6rp0E78DZh/Zd4ZrGMyGyVpy43yLeStVGHnJonTHX7PmgLNMvKpLz
         hFzO5M45tJfCs6ckgp87inG6yif0jVWVloLU4nHaj0d2B1FIo8SelQ87GgJou4ccHA2M
         W/UPUDZtNgzQzSgGxXBXmd5NKvrqGTmoHbRlamTLqZC6Otp9XBtZodF/Z7pocN+eK+/Q
         /FwO1h0Q4Q7vICc5sXfyilN+6R2aHNPULb39hU/ZgeuE9eePNBrBTSMASrRDlugkNUzN
         /JUAWH6+qB5pwP7GznHe2SlJazRc/pUoxY0/6GBf5GGQZX1DUQ+XwZfuiCCBREPjgwmL
         eyBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=krTB7RKoikRzD5yyiTQ8FGQ+GcAUNRrGAGBRDsGvivU=;
        fh=qBh8Eug7tRjtkA4zCBlg2t25AElInNN75IUFY19o1x0=;
        b=NIxXsBegiLKSyXctDnlrVnCIIFjNn/lE21RlOxbdxpKwh4+HjmaTX8JHuYUU0GuNW/
         R+PNcrF/DFdvepWGyB4bhM3S0PeUZ4YpevWQHCvXqaToq1YlziqzTS9IrSbx9CsKpI9W
         sPKIzoVxA62j+dhc+XM+QcrxGLUN2hdmAcGAa98sxGgyzHmSIgI0rXDtDAPKWo5hrQIQ
         6pwFRqgam1yoy2v6Se90LpNr2VffO+l/WwETABi8qk/BP2OAYzoXa4hnUOM3l5ayQ+e0
         RS7boT+Sl60u5gpYHudOVaUxlQzuaG8hDXZs0L8ClR2YYmlpZ/nC6P3HYxHnB36Lp8s+
         w4ZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1795466139; x=1796070939; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=krTB7RKoikRzD5yyiTQ8FGQ+GcAUNRrGAGBRDsGvivU=;
        b=QQXh7/z1dUg33nJ3IIus60/y21mBi3We5PBI1YHITS915S8JNeb83kVQ2JkKY8s9g0
         EVvXRSS6SIqCUx2D0R03SMnPbSA9YNIQMEAJwSl28n1RCjGMQ3glX/jdd5AIxVqjHT1f
         viWaOet0TqL5Ahrrpi++8Jmg1e8tUrDdcU5GF1wjOLHB/zFNWS4UCP7GGjD2XDUWe6+k
         4GLvLiFMjeH3QSRP7b4NNKghUJtXDeMbFeDLDQfhSWVHNYw6rKAs6UvrI9KjzEbreC+q
         1qLA0XbE7r/2tk/OydeDFaqmuQbb0UvEkbCwpDt1hhWYpzlgmO3OM2XplS40+ie2i7gH
         I6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795466139; x=1796070939;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=krTB7RKoikRzD5yyiTQ8FGQ+GcAUNRrGAGBRDsGvivU=;
        b=oAj4LtHt7/KbdStjKCdrVh5vAAUVTOSG4rx1t3gHtAbRPL7HzWOsIU0Z8aJtILnnTu
         q5PJdTCJHYI+0UDByeiASarBjQYMhSo6bBDCq6zMSPE8BJ91o4cfp8HkWhJk1MkuG3ka
         R4WVscd+dDyjDq2onXAxxPYqZSvFPn2tCCLV/PTd5md0lcJ7fxw7AHUq8FF+s3ZeMJX/
         sN415Mpasd4KJU7ZGF+xdhikBwl/GMbVY3L6LouTzT/kRbUoscQ3MF4bnGPJoe0AIogA
         YN/kLeqmdKplhNXawcOTv6DVjtATx/YT1ZOP8vyUsKHlhut6q/cRavmFQ1KPPJmXnxoH
         WBGQ==
X-Forwarded-Encrypted: i=1; AL+hErHUR2GrunX5GwCGRSyOrADnPcMOc+Xvfp7gZd10l2H/NdPpF40eLM9X/ZDgmiA4xmZGO8c=@vger.kernel.org
X-Gm-Message-State: APuU4Z94AJhZ5t/jGhlAFnbnTkinpIXgwi4+eP9E8RHh2WiTw+fEFn7c
	wj7hZlAH6O73GAUGSEUZkkg55o4ioo6lE5wIDQEN4mtGYiJbLfs++1uqWrPhbB6LBxDB87OGXOW
	PNS1LnF3BwXWmO+8iQOGLRG2USFs2uSubNOFZ3AuNlA==
X-Gm-Gg: AZFdTZf2Cph15s0PNh8lfQfI1qJLQPjzW3FKX4BKfxUa5oVWH40zL0Oy74lJ/TWDTFx
	y+Y/3I7NhuTMjGXJjWxAxSFtWsDJqsai8QQNqTvBGzA1oxJ+VqMh6ZCzuZKMYs2tDIkQRzlHP7a
	X8D5IBcj8M6L3m2qd/ZG3wtIfpqvYaxCYmm42BVtBVap0kDf9RwlXrUQv4c0FXVeMzw9tJ8+ZCq
	umh7flYwxuS3CQgqFPPgx205B0n6gp8FcXU6hTQF1cJbRQKmbuk8m2uzhbPoJCy6uYaq/qRCwfx
	8vGhb692bBw5RUDMbYySXeKoVqViOPns6XWaLgJEUErunVPrPe0T+37ncAGMbtdEyAaPqTnt9zT
	Jm73Xlj9xzUdD3OssPN3RpzTZqG62tx7hqFz06lUEuS0mrbYqXmGRbSmSez0aND9IVgi7/v5eBu
	q7JAzz10J+Eg==
X-Received: by 2002:a05:6820:a78c:20b0:716:bca7:41de with SMTP id
 006d021491bc7-71b395b5dc2mr6723471eaf.87.1795466138983; Mon, 23 Nov 2026
 12:35:38 -0800 (PST)
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
In-Reply-To: <3adef4b4d528780bae31f2fb02d0a08bf9c8ebd5.camel@gmail.com>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Mon, 23 Nov 2026 20:35:27 +0000
X-Gm-Features: Aa3M54plANLdGi-6T1QT2FegAb5y7dpeYS4xxUrv2cDoobb2gOCJGSKfYwT1pMM
Message-ID: <CAG4wq-f18SHytDb39SdJYzRPk-dzECjH_HCSiMGAQ721Zmfomg@mail.gmail.com>
Subject: Re: [PATCH net] ice: do not report CHECKSUM_COMPLETE when an XDP
 program is attached
To: Alexander H Duyck <alexander.duyck@gmail.com>
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

On Mon, 2026-11-23 at 10:49 -0800, Alexander H Duyck wrote:
> I'm not sure this is the best fix for this. If we are needing all NICs
> that support CHECKSUM_COMPLETE *and* XDP to report CHECKSUM_NONE in the
> event of a frame being modified by XDP it really feels like we should
> probably look at moving this further up the stack.

Thanks for the review, Alex.

IMHO we should first make sure XDP programs do not cause "hw csum
failure" in current kernels. Whatever an XDP program does, it should
not be able to trigger a hw csum failure. It's not an uncommon use
case, e.g., Katran from Meta [3] and Cloudflare's load balancer. And
existing selftests already do it (test_xdp_native_adjst_head_* and
test_xdp_native_adjst_tail_* in
tools/testing/selftests/drivers/net/xdp.py).

> Also even if we go the multiple driver fix route I wonder if we
> shouldn't look at adding a new XDP return type to indicate that we are
> passing a modified frame

IMHO that is for net-next. There we can add optimizations, such as a
way to keep CHECKSUM_COMPLETE for programs that do not change the
frame, potentially after [1] or [2] is accepted.


[3] https://github.com/facebookincubator/katran/blob/13a0d69221e43b4941b81303e6726ddc61a12169/katran/lib/bpf/pckt_encap.h#L137
