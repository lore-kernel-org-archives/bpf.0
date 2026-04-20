Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF2E392C26
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 19:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776714547; cv=none; b=ezm4LcXIzx0OPy3lLPNrRymFeZZKv13DjQwZvLgHqLyYIBP94jrIJn37dzKvJQ42EVZELj9dJrmBmw+vwPMOvUpKXYy15pA6lfSB4bfhm1A0u0YB59i+Qya8DrwVTcq5u90h8O69AhC1PVWRBY1xK2b8bq3dz5EL6PltuxVQhrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776714547; c=relaxed/simple;
	bh=RvxmqShgoNfRbdSrDMGgU9v3sO/CSHCNP0968kgV2bY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bk2zgbEXEOdRVqVTlhjuxh4IE4VGqS84Iye3BkuRBiyJ3hYumjp8PguoVqm0rQw+fmdxamXR6CnkOUCf1f6ddK/bXxXYJAiIVsOl6wi2HPcS7RB2+aGO4ibKeFEJJXBmn8d/z79YdTNOknNkrQQhuJVOUx20fU4drNO9AJmgX44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eipjT9dI; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eipjT9dI"
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-415c8a4d2e6so1367476fac.0
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 12:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776714545; x=1777319345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v6sEVNyktJT3zTdcB1bcpogzWQ9r6pcoZ/Pg+Jhahbc=;
        b=eipjT9dIk2LWfawcTMue8OU2TtOSQjmu2kW0LoBIx7v1yCZYFVB0fcwcHUG0yKtc3C
         iL9LOD8PQgGaO8RIJAvOpOi/Tafzhjnl+eokvdKjUE4f59oYziu1Z9ZIeALeHkvbcyFV
         dm28ydDIcNpdtGmkphnfYPfNGNnG9tD6LZnGaSJw0oXK0k/1mYsuX6g34D1adzhFSFoF
         hHzljpNUH3MEYxYDSMtqI7YdPsiQdPy8ucxMBSeDU5zZwV0skEcoHLql9ZaN6OuBYWzc
         +tEhSqt3E3g9REdVkmtC7MKC/lQWePcLyKWAzuqtgB6uycKrAe++Ns8Khv+dHOz9l4q3
         b3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776714545; x=1777319345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v6sEVNyktJT3zTdcB1bcpogzWQ9r6pcoZ/Pg+Jhahbc=;
        b=qtNAJLKbUY5k60XhtZxUtSzYUEZNMit0LdQNmyKojVF9DF9rFCSY8pWvIGRxQZE4Xi
         iyMvEhI8gJwReVCYIrdcddAmOFhw+B8Z1H4qlS2Mglbrid6mUTOTwHVsXghtlpano0QW
         nny/oLluIZSSYDAcje3dHiMbYhMLju2dp+4p3CZVhzXuaOmE3oFb1pzYP6mx02RT9oNS
         JbZY25dwYVF+pdRgNGfiUBAW5gC7ZjCEFcXaoJrqy9JrpseJjviE7PeQVfM0BWYBkQNQ
         aI1cWNMME3hFHJkB3WM76SE712YCBicEMoNY5bUt00simtMrwlolUKhoM2cz4f83pXjF
         YTEQ==
X-Forwarded-Encrypted: i=1; AFNElJ+CPsi/FKa3DDrmdurlSvbsVhtiYKiojyzRmjYkyGvM9HozjxInTTYD/+bFsAtsm4Zna74=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMVTbtzl6UfN+fgQqd28IzOiPME0ZWaDSRqSZq3TwktWfib/S3
	t3g72TNYuMU6HeB8E9APuPSuNz5WuRNghay5knbypz2SzBPwuzuVhYJi
X-Gm-Gg: AeBDiests0ZLT1FoxHFZ7pyBowDhBax3tAFzmGaYYUzPlU82+74I9aIpo+sXR8dw8fn
	lvB1KNmeEBxuS/vQd6JG19dRIhD4p23KkrryAPjmYdDTs9iY+WymrTDFgV1tWt7M4zuYXWmMAbA
	sSzfK7+B8vK/UdlUrrPywn5ca0GBNDLFa8Q+xsFz5xAlAKddbidoxlwlncs+4LYPzmS2XFShXG1
	u3dyZ/7IeWv0ibVKpaSQVK5puK7iZ9VYZNZcBxIYRmrcH46fqDUPmFSKP3K7J3/BTvEZMJRtmhS
	qzQa+/gQS0mGVHTVLZtjUK54Df09IvpafSmekc8Mt7fCTvod5uNxC6TnH5667RjT8b7kYXeM7+1
	vj6601fk3vXRFzU8aDG3/ocUdxfUQQgkc7fuECjjMr7xh5tVp+oRde+LMHLWLWQG7V/UkX9Bs7C
	Nms76G8cGaaxlPhn4cEyCBQaQaOmroitmOoEmZEQ==
X-Received: by 2002:a05:6820:55c2:10b0:693:7a6f:b317 with SMTP id 006d021491bc7-69462e20f32mr5089979eaf.9.1776714544742;
        Mon, 20 Apr 2026 12:49:04 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:6::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69464fe6d3esm6324400eaf.14.2026.04.20.12.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 12:49:04 -0700 (PDT)
Date: Mon, 20 Apr 2026 12:49:03 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net v2 8/8] xsk: fix u64 descriptor address truncation on
 32-bit architectures
Message-ID: <aeaCzchKwsp_LWyA@devvm17672.vll0.facebook.com>
References: <20260420082805.14844-1-kerneljasonxing@gmail.com>
 <20260420082805.14844-9-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260420082805.14844-9-kerneljasonxing@gmail.com>

On 04/20, Jason Xing wrote:
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
> xsk_skb_destructor_set_addr(): when !CONFIG_64BIT, allocate an xsk_addrs
> struct (the same path already used for multi-descriptor SKBs) to store
> the full u64 address.

Is it easier to make XSK `depends on 64BIT` to avoid dealing with that? Does
anybody seriously run af_xdp on 32 bit systems?
