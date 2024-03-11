Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B19487BF
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710176946; cv=none; b=eRYZTn73cLaddNDb6DrLiU7fHbmm+fk6a5wS2mpkPczpY+4BBNLl5whrWya43K/+hO6GUV8qoGvgTj5LfG0FS8rIvoy2e5YeJ4HUdzFx+QA0ViOzfnI2r6bo7LQ66bqt/ABVsWhbpFP4fzST5xJ6LAf2ZiCOVU/1J3FTFbBGwjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710176946; c=relaxed/simple;
	bh=pvnbgPgKkI1H0KzUxrOPoDLBjtpBt6DVVMXa3wBd3e8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C24OgC8JbFUbzMY0CY7quCkvamBPf1UZZsqWBoKp/1fm0XUnttfCoFOJxl5t8oN7j1Bs/g/DIpmvRzOGYLcZxqFBVBWPwOMoEn9DjOVBSkBb4IKNK2mHY/SGtnZYsqQde0A1NfniBD2O40CB4y7al8c1AmIMsSnynA5jzIF6qBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=Y6/RiW0H; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="Y6/RiW0H"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-413318a3a29so390975e9.2
        for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 10:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1710176943; x=1710781743; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w7QBBvHnh4PlUsmZzoHgjUDMPYX7tQVox7z1neNLrLU=;
        b=Y6/RiW0HnpNYO8Ucud/DCzGPiGYkti2VW/AKiQuicFwZbchUZIboyNr2ROcz9huSnL
         O0MAZhWVmwDYnJTgjKnCgZcTImtL5zGKDjFV0OOmlO4gzgevi1XcoTAtXLWkBxyF1Myz
         3tcIuRq6jYiSwzS+OuuPzVNO9poKZfpuSaBswZfBA63iTDoFNBah1DJ2mDX+4sDPcHyi
         All8zZ566y8H0Lpiee08LUHIf+9CDSJUJ7ZFW/Yz5TUsnJa2ve/YKBahTN1ypMZ5xzOY
         YSltUuKrEQvR/oOClILZt4Y1B3PSXURMjVDnA7gEv2jWYuEsJ7CEsvi9LM3LPQljWEjZ
         rInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710176943; x=1710781743;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w7QBBvHnh4PlUsmZzoHgjUDMPYX7tQVox7z1neNLrLU=;
        b=UA9uRgf35AnJT2OqJXvcsMC6nkQiMO7zHYMGTmIMNexbxsbrOD6oeaP4h5cJYo2KvK
         0r2nloEVOQZ8Igf4DtEGJjDZ8AsMycdRzjxmdiuYhapHEIQ0+GbAYVVFhjKxe73YAA2u
         aQf7mOtjZE8V45SdV95svySGWezFMt68y6xJ1fgktY/hJfykmHCvQ2gtEGQx2ztsdR+X
         QdaZY7LQVTCRR+fjOipA+3PAjWKScKyEyZLqNyKANYJmzVYxoA4E7am6wo0io6UtZ4FE
         Y4KVtWK7n1pffYL6WXMgL3D73Y3bsMP/WyPCE00WgLOMVT2imL/1uZHkMd587oyXV79q
         UApA==
X-Forwarded-Encrypted: i=1; AJvYcCVJrIImvr/VjaTV0c0gYGhchpEptsPdIZrF2G4G5Uhze+IhqDauqTMxzerJaMRbfXHyg1xoan92hl2kFv/wMN86NiWf
X-Gm-Message-State: AOJu0YxQaKAV9v+oyvRNnQ8MXciw9OU6v4IaYj86u+orudsKBL6NUkSW
	Wh3pum7m4tkZQy+NAx/qzyPyl5N4ZBy8FfhWp0UmkIlUfkyTs8rW4151jvavT8Y=
X-Google-Smtp-Source: AGHT+IHV5C2HrXCecTMWw0lJ6pjdweGxpyvgWHlwI9xbYoiI0D8ATdcEESE5sVO/pJ0uyiTv8q8jdQ==
X-Received: by 2002:a05:600c:450f:b0:413:29a4:9e99 with SMTP id t15-20020a05600c450f00b0041329a49e99mr2264852wmo.39.1710176942716;
        Mon, 11 Mar 2024 10:09:02 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:5231:db44:25b0:339e? ([2a02:8011:e80c:0:5231:db44:25b0:339e])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c4fc200b004132f9cf053sm1310682wmq.33.2024.03.11.10.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 10:09:02 -0700 (PDT)
Message-ID: <aa2bdd2d-4c85-4b64-ba77-7da0df4f4660@isovalent.com>
Date: Mon, 11 Mar 2024 17:09:01 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 10/14] libbpf: Recognize __arena global
 varaibles.
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, torvalds@linux-foundation.org,
 brho@google.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
 urezki@gmail.com, hch@infradead.org, linux-mm@kvack.org, kernel-team@fb.com
References: <20240308010812.89848-1-alexei.starovoitov@gmail.com>
 <20240308010812.89848-11-alexei.starovoitov@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20240308010812.89848-11-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-03-08 01:08 UTC+0000 ~ Alexei Starovoitov
<alexei.starovoitov@gmail.com>
> From: Andrii Nakryiko <andrii@kernel.org>
> 
> LLVM automatically places __arena variables into ".arena.1" ELF section.
> In order to use such global variables bpf program must include definition
> of arena map in ".maps" section, like:
> struct {
>        __uint(type, BPF_MAP_TYPE_ARENA);
>        __uint(map_flags, BPF_F_MMAPABLE);
>        __uint(max_entries, 1000);         /* number of pages */
>        __ulong(map_extra, 2ull << 44);    /* start of mmap() region */
> } arena SEC(".maps");
> 
> libbpf recognizes both uses of arena and creates single `struct bpf_map *`
> instance in libbpf APIs.
> ".arena.1" ELF section data is used as initial data image, which is exposed
> through skeleton and bpf_map__initial_value() to the user, if they need to tune
> it before the load phase. During load phase, this initial image is copied over
> into mmap()'ed region corresponding to arena, and discarded.
> 
> Few small checks here and there had to be added to make sure this
> approach works with bpf_map__initial_value(), mostly due to hard-coded
> assumption that map->mmaped is set up with mmap() syscall and should be
> munmap()'ed. For arena, .arena.1 can be (much) smaller than maximum
> arena size, so this smaller data size has to be tracked separately.
> Given it is enforced that there is only one arena for entire bpf_object
> instance, we just keep it in a separate field. This can be generalized
> if necessary later.
> 
> All global variables from ".arena.1" section are accessible from user space
> via skel->arena->name_of_var.
> 
> For bss/data/rodata the skeleton/libbpf perform the following sequence:
> 1. addr = mmap(MAP_ANONYMOUS)
> 2. user space optionally modifies global vars
> 3. map_fd = bpf_create_map()
> 4. bpf_update_map_elem(map_fd, addr) // to store values into the kernel
> 5. mmap(addr, MAP_FIXED, map_fd)
> after step 5 user spaces see the values it wrote at step 2 at the same addresses
> 
> arena doesn't support update_map_elem. Hence skeleton/libbpf do:
> 1. addr = malloc(sizeof SEC ".arena.1")
> 2. user space optionally modifies global vars
> 3. map_fd = bpf_create_map(MAP_TYPE_ARENA)
> 4. real_addr = mmap(map->map_extra, MAP_SHARED | MAP_FIXED, map_fd)
> 5. memcpy(real_addr, addr) // this will fault-in and allocate pages
> 
> At the end look and feel of global data vs __arena global data is the same from
> bpf prog pov.
> 
> Another complication is:
> struct {
>   __uint(type, BPF_MAP_TYPE_ARENA);
> } arena SEC(".maps");
> 
> int __arena foo;
> int bar;
> 
>   ptr1 = &foo;   // relocation against ".arena.1" section
>   ptr2 = &arena; // relocation against ".maps" section
>   ptr3 = &bar;   // relocation against ".bss" section
> 
> Fo the kernel ptr1 and ptr2 has point to the same arena's map_fd
> while ptr3 points to a different global array's map_fd.
> For the verifier:
> ptr1->type == unknown_scalar
> ptr2->type == const_ptr_to_map
> ptr3->type == ptr_to_map_value
> 
> After verification, from JIT pov all 3 ptr-s are normal ld_imm64 insns.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/bpf/bpftool/gen.c |  13 +++++
>  tools/lib/bpf/libbpf.c  | 118 ++++++++++++++++++++++++++++++++++++----
>  tools/lib/bpf/libbpf.h  |   2 +-
>  3 files changed, 120 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index a3d72be347b0..4fa4ade1ce74 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -120,6 +120,12 @@ static bool get_datasec_ident(const char *sec_name, char *buf, size_t buf_sz)
>  	static const char *pfxs[] = { ".data", ".rodata", ".bss", ".kconfig" };
>  	int i, n;
>  
> +	/* recognize hard coded LLVM section name */
> +	if (strcmp(sec_name, ".arena.1") == 0) {
> +		/* this is the name to use in skeleton */
> +		snprintf(buf, buf_sz, "arena");
> +		return true;
> +	}
>  	for  (i = 0, n = ARRAY_SIZE(pfxs); i < n; i++) {
>  		const char *pfx = pfxs[i];
>  
> @@ -250,6 +256,13 @@ static const struct btf_type *find_type_for_map(struct btf *btf, const char *map
>  
>  static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
>  {
> +	size_t tmp_sz;
> +
> +	if (bpf_map__type(map) == BPF_MAP_TYPE_ARENA && bpf_map__initial_value(map, &tmp_sz)) {
> +		snprintf(buf, sz, "arena");
> +		return true;
> +	}
> +
>  	if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
>  		return false;
>  

For the bpftool changes:

Acked-by: Quentin Monnet <quentin@isovalent.com>

