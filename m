Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BB529898B
	for <bpf@vger.kernel.org>; Sun,  5 Jul 2026 22:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783291200; cv=none; b=P1tVCVJfwpUbfNs/sRrONhKASXJBANdxuL5WcYjtukTMVn32E6t6jf3Szz35hiupwftvu7n5N3tY2OOcJDC2d335YEmi6d1kEnCJVtWxq7tjRyTLX5Ukiyyov9teRjrji1t88yAVOa5ztLUz9HXleMjKI8GTmitf3/wk528iw5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783291200; c=relaxed/simple;
	bh=PS2xAXVIuQtCbQz1pkLmtiWqjTlS3vlheexdkuqP46o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkZmQrJ25D1sNCX/hb2s+UF73HRxJD/CmQD/XBMsGZMeSVY7dCsEJdB0Sg3Iw/nh6Y7iIlVdl1IcqwW+T1d7C/fR3j/ERxbr/k5sc4Mn7koGsrv/TWSqDU/JKWfIqpDasF2i9XbXQ6VIgXBrvzDEJ3zW6iQVHgERareCfvNbgZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVY+cHwr; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVY+cHwr"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso3107958a91.1
        for <bpf@vger.kernel.org>; Sun, 05 Jul 2026 15:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783291198; x=1783895998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gf/2ZnocWXbVZE2hJzu+IPJFR0h0FaQA/YYP7smERrg=;
        b=FVY+cHwrDtFh0x6w0tVQyL1nqTTDSDi3bobM1ugwPsKn36WRvOu0DEOgjYcMvUkrn9
         UFvVjvBvT8u02xQiXXY0BUqGpyC3wbxZ8EDmDoXNl2vRlkYl0zlbO4pVmrLw+ZpPGwCn
         uMKErdVjr3XFTlUk5GhJDbp3pFOVF2odY4lIOj2EALPJqM9jIxwWLG8HTWop1VWoztmd
         /j94UuBDOthkp6OrKs7YKSo7HOocRT0UuONTaMN9gpuL/jwIDxpjsEivF2UX5pLBr6kK
         u96S8mKhh9xpn7agYmmRm6LSW9cZOkQBMWcABR2waoIec5S1DQW/psySfYXKALPUXmHn
         HAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783291198; x=1783895998;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gf/2ZnocWXbVZE2hJzu+IPJFR0h0FaQA/YYP7smERrg=;
        b=kxntfFfKuaiXctxLZ0/g24EpVukWdgUZWiry9Q/hnhmBhzd1PlBqyW33txbigm4Cv+
         wlEsph/OenisOkaER0LQGzUFrVnOHCXSWWc70mKdE9XolTnyv8Kz1PflfuaM2xZHLuKT
         jduaZ6iSnj0sB+NcpJGvCxsija+wnV16LzjQoDW/hh4NP+hmogvwzlDSlNUNKhdUOmVd
         d8Eeza6OPHcGc8xGahzi+WEgbJTGDcLhw7AIf49mXvPVzdjQ4Cgdy0nOsCG2Ib//P8BT
         7BxfBp6rwY8cn1QpjLtUbKjLdrn/xlDozEximahqE+SunTByPA1v9QiqbUklqYCxwT8F
         8rTQ==
X-Forwarded-Encrypted: i=1; AHgh+RrXq0XiPWuQzNWVNWqWVbqbG8s5k7ht6C7PIhshnyCgjl+JRlAqwprLIU4bdrO/z+vUs7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Nu0/SF1JOGDFtBYyL2Tlz9N+kfQGQCFfr7sSVcDBveDAvf53
	zFw8JAl1uD3Y8Su4ayadWTdVYbj7RiARj47bcTpIm7SwkWANq7/cPNWO
X-Gm-Gg: AfdE7ckrCVRyQXBHjRU3lwKCXSyUNVj+FqXtjGaIvAljOqNYlJudXUycI4rt8QoJB3g
	G1qnxwArBPKVmwKRvdYwloYNvbn53Sl1cVytQRLfuI9KgzEsBO0PN5Xm7lPcv/MFwKQ5PZeodNo
	TlEkyl3Qd2Ekvo8WZk4Hg2ZsZYbpmXzrrB/X35RLGaegso7DFJB7e2Tw9J7P+NB8Bk5DEFHRw3N
	jBZFjeN2B4L6Lxjz74OWz4xQfiNRY8yMp+OTzLzfugRXLKx/4QSlQUizYGyJQ8Ohil2GO/CPT4M
	v5A27afC85vYaAjbg+CxDcnCnYotoKftOXDftQlbwLe2aj/Va2x+yTz7V7qH9b5NAvCetqsPAi+
	XC+Kci66m3IIqwz0KjaWWUExdyVTSkiocfYya7g8149KUpT1OWdkFvpXxrudlD8BR2bh258/lM3
	EN6TWU6iAqX/ygjBSe1sPQuiDbYgy2xF7ju0LwTbqZPOevVRU=
X-Received: by 2002:a17:90b:3c0f:b0:381:939e:adf0 with SMTP id 98e67ed59e1d1-3829fbd7827mr7796480a91.31.1783291198427;
        Sun, 05 Jul 2026 15:39:58 -0700 (PDT)
Received: from computer ([2405:201:d015:d26b:41c5:151e:6e02:36c7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f3b252222sm28162093eec.23.2026.07.05.15.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 15:39:58 -0700 (PDT)
Date: Mon, 6 Jul 2026 04:09:50 +0530
From: Varun R Mallya <varunrmallya@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libbpf: Check full backing type size for bitfield dump
Message-ID: <akrdNginNVZPd9if@computer>
References: <20260705032603.275766-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705032603.275766-1-lgs201920130244@gmail.com>

On Sun, Jul 05, 2026 at 11:26:03AM +0800, Guangshuo Li wrote:
> btf_dump_get_bitfield_value() builds a bitfield value by reading bytes
> from the backing integer type. The bounds check added for short data
> buffers uses the number of bytes covered by the bitfield itself, but the
> read loop consumes the full backing type width.
> 
> For narrow bitfields this can leave part of the backing type unchecked.
> For example, a one-bit field backed by a four-byte integer only requires
> one byte according to the bitfield span calculation, while the value
> construction still reads four bytes.
> 
> Check the backing type size instead, so the bounds check matches the
> actual read range.
> 
> Fixes: 5714ca8cba5e ("libbpf: Fix OOB read in btf_dump_get_bitfield_value")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  tools/lib/bpf/btf_dump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index cc1ba65bb6c5..a49790e356a8 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -1771,7 +1771,7 @@ static int btf_dump_get_bitfield_value(struct btf_dump *d,
>  	nr_bytes = (start_bit + bit_sz + 7) / 8;

nr_bytes and the line before it are made obsolete due to your change and
become an unused variable, so that would need cleanup, as sashiko
correctly pointed out.

>  	/* Bound check */
> -	if (data + nr_bytes > d->typed_dump->data_end)
> +	if (data + t->size > d->typed_dump->data_end)

The fix does not seem right to me. This will reject
something like:

  struct packed_int8 {
        int a:8;
  } __attribute__((packed));

with BTF output like:

  STRUCT 'packed_int8' size=1
    'a' type_id=2 bits_offset=0 bitfield_size=8
  INT 'int' size=4

As you can see, this valid object has a size of 1 but BTF type has size
4.
nr_bytes (the old one), would get calculated as 1, and t->size would
show up as 4. This will unncessarily reject valid data.

I do understand the concern with the loops below using t->size but the
check happening on a value calculated separately, and this can actually
trigger an OOB. You could maybe try fixing the loops instead by handling
packed bitfields (like the case I gave) specially, but making the check
more strict is something I don't think is helpful.

>  		return -E2BIG;
>  
>  	/* Maximum supported bitfield size is 64 bits */
> -- 
> 2.43.0
> 
