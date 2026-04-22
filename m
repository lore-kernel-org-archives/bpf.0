Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20A1381AF9
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776875498; cv=none; b=tJb5h+G5dQUyMDVl4w3gzfdfmHlvyV4mofbDrq5h7OomMLm8WbBWAUeryVPS6AfrruVO3lGw421JOw0JOeVNGrODjeMxrC+gJHQrE57yL9refRV1IqlEmZ5kHLNaXfFrKa1eFYvZbEL88SNUhGggkvAALetmgdmTTtf663TgqmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776875498; c=relaxed/simple;
	bh=pPlUiWBDe8bOGmEouOxnQg1NNS4r/KUijif04dGB84Q=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:Subject:Content-Type; b=oroBCcOOEh0/IqHEdcWKX4j0i9/TFjUW277gZEFVjkmxCMalM2zym6UbKr132u89MqtXWRF+8jvFgPh+n1j9MuX9UfRaDgJRA4AaEEiAvwIdSF4oXP0yO3UcJ1h75tLI28XiPLe9PjQMb9yHN88vrtLw1vzMWOdcqZbWNq2X70E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFLFQ9Ij; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFLFQ9Ij"
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-7d4be94eeacso5675596a34.2
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 09:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776875496; x=1777480296; darn=vger.kernel.org;
        h=subject:in-reply-to:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kv1z6jincxy5WQdNfD4DCdTuj2rMmC7+D/DgcwscYe4=;
        b=dFLFQ9IjeqSRfuL/GDd8t5C/4/isGE6VG7/O+k9kezzOemnn1IlnsERmzyApbqfaK+
         KM8rvwqFCSkkSGF7ZLwB2M0Y7P+hFhwn+y0OngJNpSf0gECU2lceKQ4nPV/89MKJehNT
         C/uwOQegU7FmNcazmDegdy3o8H8ggFtcpVNETPhAwQnQ3dNBLPFWjL131rcBMNm46S3k
         n5pcRPhRgHtuT2zXPzp5afGd03efsuTAYN4kh1zCIPQbsl3mbNLgJDL39J9zdyOLTruL
         HysQ7SW5JDEH712l6sLJA1CGfU9qA+0kPV7EuZwrSV/mzHvSElsokTtQGzBeoNDsFQ/P
         Oysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776875496; x=1777480296;
        h=subject:in-reply-to:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kv1z6jincxy5WQdNfD4DCdTuj2rMmC7+D/DgcwscYe4=;
        b=g/uDy24e0nAGYrcVne0H7MJlVxllNM9MoCMXs90sym/WTpsxnJToLn6kh7t9TMbNT3
         unY9SGDaMiJCeENzaKgUx/0K4ptd+1hcYsHC38jzBRvDZlOgLL8nEiNi9UjtyX59N54W
         dThOf/SqLxawbN2jtfgbWm3alGaYhPATaUA1t0yoSDbFFWPOZWis05zeNO3P+4AxtfHb
         BI2krokFHPbfKJdjZCr39bZt3aJQ5SAxyrDUOIiLb56rC6l8uDa64puE3pT3oaQJl3aF
         jQUpzsOmFw/d3QusBg6l5IQwJtuP2mwY4s33Y4vgb9i3YcMoFhc6U++pvijWZv40vsaK
         qg7w==
X-Gm-Message-State: AOJu0YyOk0i+iyZWNd6oF1iEMbMKVuyO5EkDCyOo5/o1+6s/4Hh+AxDO
	DHTpmLkrKfH+40jPANcPlsouxBu44rCcZG2mNtO+R4rUpTHS4VVywMYGGcxVJcLw
X-Gm-Gg: AeBDiet0ueagf6AvDTEzszAPhxwnVbZ6ADQOouiS49krY66/GB78eKyLakgxxZD94qm
	8NGtWOaXAU51liEI0s8uNwcxwBHchAOo7Xiu9ST2xwVLMUf4zPTbNb8e3VJJ1kRAza0dfAche09
	JBlSstmU9bszvWhwxy8PRw3ue+NUrCnR614GW5/X7xi2kk1nhejbWR05pMuyJrHhvhMtv+cjW8f
	lT1A1TIuzf1gA1CLgUHh938JIQbygIrkI2zAROVJsblQOaVqGqVfpD7utoFJVBukzuLJmU+tu2r
	5dHaUUc+KEqiCkCEeq1uJBZYXcZW2HjZ54rbAdmhWIflZeXENi/vOrBL8AmuQgOH+L+0DftuZ3C
	8eAJh6bXxIgNXSesG5FJiqnA+AeZQh5f98movPrnQYzzFtzkkiXoMD1yvUUBYMZnWeQl+bHUc57
	LmNIEGw0mpsBBXiDNCnpSX2XXsoKt9
X-Received: by 2002:a05:6830:82d4:b0:7d9:7ea8:7a4f with SMTP id 46e09a7af769-7dc951c7209mr15569047a34.16.1776875496506;
        Wed, 22 Apr 2026 09:31:36 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:70::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc975034e7sm14178428a34.6.2026.04.22.09.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:31:36 -0700 (PDT)
Date: Wed, 22 Apr 2026 09:31:35 -0700
Message-ID: <c8745f07b8534a2e1fe4de143ea160ff.sdf.kernel@gmail.com>
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
In-Reply-To: <20260422033650.68457-9-kerneljasonxing@gmail.com>
Subject:
 Re: [PATCH net v3 8/8] xsk: don't support AF_XDP on 32-bit architectures
Content-Type: text/plain
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

> From: Jason Xing <kernelxing@tencent.com>
> 
> In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
> descriptor address into skb_shinfo(skb)->destructor_arg (void *) via a
> uintptr_t cast:
> 
>     skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
> 
> On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits of
> the descriptor address are silently dropped. In XDP_ZEROCOPY unaligned
> mode the chunk offset is encoded in bits 48-63 of the descriptor
> address (XSK_UNALIGNED_BUF_OFFSET_SHIFT = 48), meaning the offset is
> lost entirely. The completion queue then returns a truncated address to
> userspace, making buffer recycling impossible.
> 
> Since we hear no one is using AF_XDP on 32-bit arch, we decided to
> strictly stop supporting it at compile time.
> 
> Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.kernel.org/
> Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor number")
> Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/xdp/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/xdp/Kconfig b/net/xdp/Kconfig
> index 71af2febe72a..819aa5795f50 100644
> --- a/net/xdp/Kconfig
> +++ b/net/xdp/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config XDP_SOCKETS
>  	bool "XDP sockets"
> -	depends on BPF_SYSCALL
> +	depends on BPF_SYSCALL && 64BIT
>  	default n
>  	help
>  	  XDP sockets allows a channel between XDP programs and
> --
> 2.41.3
>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
