Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D0E3A63EF
	for <bpf@vger.kernel.org>; Mon,  4 May 2026 14:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777906747; cv=none; b=H1mDqjxnS4V/46bC6udvQIQ/hFuunOjntiQiSkqG4ScPs+rJPlYbUdoD7gEiqRDWB8v8xHpiHOx/Z2rd269Zgf+WLh91OWhg5B3bBFep9M9yNf/9jAv0XwOrVuG+eGRdkhUO/MWiriIgrcBKxLHerCmcrbxByQskYKCLNAs8hiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777906747; c=relaxed/simple;
	bh=CsDy/LfJFNDUkKNXWKhbZTlzGt8sVL1eoAGYyZGFDDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqqAS9bwPQEaqk1fUocGdKmcE3rbRfse5Yt+tp+DKFnT4MuyH/PE7L6FDB6tPVFB1rxOBp1xa1C5VesFO4J4ryJko4+h2/S3d29LPyeU80Ciw43OTLYlq917on1VJZIYahOaP0nY2Gl1f0HTtfX3cxZwopvW3t8fq89O2LIsIWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVPFtxR7; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVPFtxR7"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-82fbdd60b64so3020793b3a.3
        for <bpf@vger.kernel.org>; Mon, 04 May 2026 07:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777906744; x=1778511544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b8q/EPPyhCK5sjTLWIJy3Uk1FD9dao+2uQzQee1Mzzc=;
        b=aVPFtxR7Fwl81rIfLRl++vTcutGGx7w0pqeP8kywybU6xUHZfe7sgcb802FuGDajcr
         OV4R4pNJyfSOmBJqWVFv0sWluqX0sEAEok3EwkW1cwJ8rc/N9tR7yrSiXiSv4vi1CI6Q
         bZr+U0wwuyhKASfxw/r33j9BJvCq1s/D3v+RikkuZc4pxOXIsgJzCRiqIBMFbBP00GDh
         kIsh5xBesdE4HyZthgKM52SujgmIZz6P+EVJIVxpZcvXZ3DlFgzrhZ1cxp24+lYbRsxY
         /d8kyYwRPgyr1856K4JVNuc3kBuJcBiPTdD5ycEiEX271yG8TKH6k7FC9a08GNRg4kNh
         9qYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777906744; x=1778511544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8q/EPPyhCK5sjTLWIJy3Uk1FD9dao+2uQzQee1Mzzc=;
        b=HV2i885XLIt7dTkL5ZaMtaVD/XbXlRSbO4JVVQCXNjpgYnh0Am9qOq48067V1fEra/
         3DJJjTUI6efTBNIzeKalL174Jzj6tZ9Sp5MQj8dVODzfGFOToW/3zYcIYSLI4MLIoTX6
         NrrOjrA2HRKvFYsRDys/wOwZZdz24ILFHO68TBQS/tSvsylaepyc5zlh630KsTVXolIR
         LTk1+UnJxEg6xeOgyULgMAU10FBP0ejIOJBjY8MzacLFSYMpFXpDzfTTcokpWO4K7v2O
         3ffqOxsUuBWyqPrODgqiYsbpWpFLK8/4C/b/o27VIIvB87YSOjXCLX9/SJ/u3ZxuAEQN
         Gm6Q==
X-Forwarded-Encrypted: i=1; AFNElJ9MPTWw4lj4ATAwWEvSuI5Pt5ihZclpmmwMsyRNM9S3NbBUqvk+onDybSZyhVlZ98Cv3H4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxuTKPjzHJzpiKjoGjiwSuL+vRWA8CAATKTOQElnSQQe0PkEnX
	YrZbqk+WcJjKrkK0eFz3yQMp2r6xfCs13sZXA+0jLfkUaHokdm8i5tCl
X-Gm-Gg: AeBDiev/ChUS/HlqnEH38uOHBzoL7kJKJ7WeCTLZEu8Qohq2AOZiR7C5e/G/0BPowPc
	e2fBGocKVjC/jvBnjrIAsmqtpbL8rN2fbRqupO2OeZ8iQZ3XB/EWxWNSDviiOmXPbaTmHOaQZi7
	zKDTNxm1OUpcuSItqWyInBhkJ95gh5yWQ85z1Qc+9PtljJtaLz5XC38yhmUt1K+Z35eq7jjyzZk
	rsbOpJZRjZSyXuH9vWzyh/TzjePDIeOBSMuYB7RD1RtMOW6M8hJJBMcgmRISrTbhUNedToTHwyZ
	pjR/fJtYycTfoEMMG9VHTU7uYtNwt/e3tWbRPezbjH/xf/q6QeUIi9gaiRz4DlR2mCsGiVNqSCn
	qV/mPQWMAgNHym6uQPWhfT4nm3rJUFP+O2dIu+Po3n9nAn5CDYs/a2T3YBCAzfp2o8Qh5fAXohR
	37rZhVVILtGeNWKBF1o8FDpD03lAg=
X-Received: by 2002:a05:6a21:9981:b0:3a2:df61:50e6 with SMTP id adf61e73a8af0-3a7f1caabb5mr10192770637.47.1777906744036;
        Mon, 04 May 2026 07:59:04 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:50::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbca323dsm10468070a12.28.2026.05.04.07.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 07:59:03 -0700 (PDT)
Date: Mon, 4 May 2026 07:59:03 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	andrew+netdev@lunn.ch, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net v5 8/8] xsk: fix u64 descriptor address truncation on
 32-bit architectures
Message-ID: <afi0I6UZ9FlueHBE@devvm7509.cco0.facebook.com>
References: <20260502200722.53960-1-kerneljasonxing@gmail.com>
 <20260502200722.53960-9-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260502200722.53960-9-kerneljasonxing@gmail.com>

On 05/02, Jason Xing wrote:
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
> Fix this by handling the 32-bit case directly in
> xsk_skb_destructor_set_addr(): when !CONFIG_64BIT, allocate an
> xsk_addrs struct (the same path already used for multi-descriptor
> SKBs) to store the full u64 address. The existing tagged-pointer logic
> in xsk_skb_destructor_is_addr() stays unchanged: slab pointers returned
> from kmem_cache_zalloc() are always word-aligned and therefore have
> bit 0 clear, which correctly identifies them as a struct pointer
> rather than an inline tagged address on every architecture.
> 
> Factor the shared kmem_cache_zalloc + destructor_arg assignment into
> __xsk_addrs_alloc() and add a wrapper xsk_addrs_alloc() that handles
> the inline-to-list upgrade (is_addr check + get_addr + num_descs = 1).
> The three former open-coded kmem_cache_zalloc call sites now reduce to
> a single call each.
> 
> Propagate the -ENOMEM from xsk_skb_destructor_set_addr() through
> xsk_skb_init_misc() so the caller can clean up the skb via kfree_skb()
> before skb->destructor is installed.
> 
> The overhead is one extra kmem_cache_zalloc per first descriptor on
> 32-bit only; 64-bit builds are completely unchanged.
> 
> Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.kernel.org/
> Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor number")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

LGTM, thanks!

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
