Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0E23812F5
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351972; cv=none; b=KoNCEysU6+MqR2xQq7/E3L4GkBYOyLn1VlaQEUgUkNdstOZvWJkqXDsjXvKipVrDERFnVfa6CIoJjm5nGFfDdSL69gsZhyH5l55Qta5Kji9boQshSFaXIyFdR5dmI3KHulKthjE1Z90urHon6tGGezCCwCImjn9ZaPDrI/2Hj60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351972; c=relaxed/simple;
	bh=xFuRcaMQpGQSL2Dao1s4PWYVtF1l9NoTH7rBdz7PPds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJ3I91BAzHoBttO/Xlg/TqsZBnXaxRWM3xeRK16vTvl3OSaBeuDv0zl8mA8zQEajca0M9STjN0KsaUBEG+iqsdKFTtZmk1Gmj6JIIjwX2OEqNri6hbNcEnfT+4Rt66a+CGJCWWC/DYJ4EQlt3RiQgfzhTeT8K/bC2YCjenKBL1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbBslv81; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbBslv81"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493c52cde9eso32716635e9.3
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 08:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783351969; x=1783956769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=37Umb2yrBsD31B4W0F/cd/5pA0RZH20wLz9q4UgsqCg=;
        b=VbBslv81ksetFK6OAgihB0kkJbC3uipyOM9UvjAY6LzCdRcHPzrC6nn0N81D7qTzOS
         nyeamd2qn2RBWe37h5JSdbRWLVaMfXzrK9iAYE97eHNAZkpcN1hK3ckDWiX6HxT1vbp2
         eGFRxd8lMhW4QRcbqGzvR6ZKHM29sxoqNxpeJIYnHh8Wlw8L26Bs7faiFBrMRjfMq7gE
         GfWJsi0fpF76/9DR+l5aRv+hTfdwYZS/Wte8tchjdAxQI3WMPdfMKDssbfrzrtvN8SyH
         DRn1eg8nF3WKa5++dcBiF15jKxxI/LaoTv5aBeiQYReJawHjPs60U18u13e3naWCLOaz
         KfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783351969; x=1783956769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37Umb2yrBsD31B4W0F/cd/5pA0RZH20wLz9q4UgsqCg=;
        b=s8gbn74J8OiUJnGzYZhErEkyvIWxsbcq3HyGMotrVkkjytf6P+PZyUrZhuRaWQoVjS
         nXXbCQoYOpT8SdpyZepm4LGdk9Ov1Ocm8+V5L1BPytz91aoA7udfDZVY8VBtFRUkQ1ri
         50jpu2t3iBc4wAiIooihTNHSpEzCwNUcxZfEBiJHsRPQz06SffdyG9jknyK3ZMAYU8O0
         vSGD3Mw5qcPV8VR0ZOlajvttjovuZ+AwT07CQDRuYUZ0EOuf2SotdRi6gNHcxlQb9mZj
         4xLtVWH3M0QWFoDYosEBDuaWEUsg3qz1TKsG0IqYr0sUnTkIa5bjGQTgbpxSUUkWig9J
         /FiQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro5PNm7/ejIHa2YNVkeoSG8FSjtYxkgxcabVtedZS37OWOqUU1ifZ8H8xGPRJaLdoj65X8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO3DsVq0FCqacaBH5hQA8Ha5ud4EQp0817NL+pAMS7NrUn2Ra1
	9JKP7RFiPSuxGEgRvLIEEJnoJpyWClo4aH59k16OqvHRl1Z7J3WKb9LQ
X-Gm-Gg: AfdE7cnd0kBscUhMFDHdY/eLQIMLNOJGQaMOMwdAPgf1/mm9uX9gqWlo5dtjjGeNti2
	IaWhU2f2tyFOcmbHyaukYF7BCo3gY7lTTBhVAWupuCN0fIhrMYsPzRxnDyad/L0VaL3MBeR7cl5
	YQrmkYD883bUgUCjk5Ampo7WRWxsnBN3R6QwfRDjPt7uxGXLWddM7OpmDxPHZ9gE/iDKichVYBu
	MG3AzOVCQV+lWL0AF8nwFqWylNumvlHvTo04n4507JiU3iIMQqu4km/0YT9B6mGgNodlO3hlG1K
	hj6ZbHxUUF6VzDXwCbAl7nBJ77EWhlkc6EbCy5xaajb6dqcZBRk9c6Vu58NNI0B0HIXv+5FtFdF
	tVcZ8mAq9o+EmzWEXxHB6ZnOh+Y++yybT2PHG1IWYF+FvEJ/M6GKki46Pkx3mrHJ5YM1NOoPJqj
	aoeycChUKjbH2SaeG1Q7osKw==
X-Received: by 2002:a05:600c:1548:b0:493:b55f:bca2 with SMTP id 5b1f17b1804b1-493df09fe01mr12130495e9.34.1783351969247;
        Mon, 06 Jul 2026 08:32:49 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039af67sm29864567f8f.17.2026.07.06.08.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 08:32:48 -0700 (PDT)
Date: Mon, 6 Jul 2026 15:42:53 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, kpsingh@kernel.org,
	James.Bottomley@hansenpartnership.com, paul@paul-moore.com,
	bboscaccy@linux.microsoft.com, memxor@gmail.com,
	torvalds@linux-foundation.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 1/9] bpf: Resolve and cache fd_array objects
 at load time
Message-ID: <akvM/QABjUMINNtW@mail.gmail.com>
References: <20260706135644.326006-1-daniel@iogearbox.net>
 <20260706135644.326006-2-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706135644.326006-2-daniel@iogearbox.net>

On 26/07/06 03:56PM, Daniel Borkmann wrote:
> The fd_array passed to BPF_PROG_LOAD carries the map and module BTF file
> descriptors a program binds. The verifier reads it more than once during
> a load: process_fd_array() walks it to bind the maps and BTFs, and
> check_and_resolve_insns() and the kfunc BTF resolver later read it again
> to resolve the program's BPF_PSEUDO_MAP_IDX* and module kfunc refs.
> 
> For signed BPF, we need these upfront in memory, thus resolve each fd to
> its object once and cache it by fd_array index, then bind that cached
> object for the rest of the load. env->fd_array becomes a small per-slot
> {map, btf} cache rather than a bpfptr_t; every later reference is then
> an in-bounds lookup of an already-resolved object, and an index outside
> the cache is rejected instead of read from user memory:
> 
>   - continuous (fd_array_cnt given): the caller declares the length and
>     every entry is resolved and bound up front (used also by the BPF
>     signed loader)
> 
>   - sparse (no fd_array_cnt): left as the legacy path with no fd_array
>     cache; each reference reads its fd from the caller's fd_array and
>     resolves it on the spot. Deduplication in used_maps and the kfunc BTF
>     table keeps this correct, and only unsigned programs use this shape.
> 
> Split these into separate helpers to make it easier to follow.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Anton Protopopov <a.s.protopopov@gmail.com>
> ---
>  include/linux/bpf_verifier.h |  22 +++-
>  kernel/bpf/verifier.c        | 223 +++++++++++++++++++++++++++--------
>  2 files changed, 193 insertions(+), 52 deletions(-)

Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>

> [...]
> -- 
> 2.43.0
> 
