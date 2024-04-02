Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094E517C95
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 05:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712034138; cv=none; b=BNj5OUUOHgvB8f5sPw7otu4mOk5YboeQjc8EMdrFKjV5ROMmy2Ueo/UQFenTGGIbAfir/wffadtNF8aDmJDry0mUA+MzXU5iKQ68hfQyjLtdUcscyPRjpDYyViK4XUPmuiPU4G6zD3kgh84qWMi9UEfkwmmHwBRGwsRNUtn/yfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712034138; c=relaxed/simple;
	bh=S/s5HUCtvqzRVZAJf81D9ufsWfIm+6zN3rfSX4y7DTg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XT5buAUOLDTvZWaX9Y1bXrPAOeC5i/mZkecuL9h5yswDnNEAMr0jCm2Zrr++/cV54uBJcot9NRyjaH10i6+zt1YzUWoCNWlazGOmM5oGpXY+frr/aQl7setcXpoJYkhV1is1MTutvyX1l9Gr9usSd6Ef8JwS0s3O1eHUgq8Skro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmDwJled; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmDwJled"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6eae2b57ff2so3605671b3a.2
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2024 22:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712034136; x=1712638936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/u6s9z4VzfoIHZhaJJorfUr+z9ActDrHF7r4MujVUbk=;
        b=jmDwJledHjRZObQm02hark0vvg4bn55lTOVWNgyuf1fZxU8d6YwYUyRPNlqsmuSQfK
         R+zEdbkxrn+2Yl+FnrR7NA1thIV6wGaTnmkpXuC0m0xKp/HSFUqhzc6svo3W9rSQkSDd
         WiWkKtKXOgZibpwxgohRRAXr9FC5r+qJXgzPHsdZH6ako6zKb1KBxk8kUFfBqAclrj8l
         MspJFmmWzdrqQ240Ky+v6bO79yxNlE2uQ2oAAKWMy1GvHrpOM4gaCqnIw62Za+3mTSmo
         kjATuHy01P3KzhutmCaj5MOL8OERDQSswS2leX24ZN4ScJSTG/phorpwDP7e3cRzSEJn
         MH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712034136; x=1712638936;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/u6s9z4VzfoIHZhaJJorfUr+z9ActDrHF7r4MujVUbk=;
        b=jJk5pyNG9xCYwrbksGEbTuhPhN5M1Zf7bRW4EFmJBIubFonGG5RqfQ6snDHJlOYt75
         9sLDoGwcGkrwU8wAFdTAqJH7J3z+gBWj7VwiRS6cJtDimjl2YBIbzi/VVWov0NdHDygZ
         JIFResWhCsLzebeJaeVqZ+pRkJtD5ZzYcdEvcs4dv8J6OzKiYTWTav+jpDgJN4KgJftV
         sj0Ign/WZfI8HKPg3Uijz9FKissyM35WvVlE2yDaMeDZVsOhN6524HRDoAKo9zgGbKaH
         +/GkrDRpHuFs1sBsLA/7Xq/nvRG+iry0I8VfZtYpkLPTNfCTcMpJ5OcjojSdLBWveZko
         falA==
X-Forwarded-Encrypted: i=1; AJvYcCWLM7sf6yhgWJRvJYO20QXLDGTFn6upY02lpEeQGz0etmZ82yQ7jzMMnsomzdk2DR3N89/odJRz0fD+GMurQALPg3jg
X-Gm-Message-State: AOJu0Yyq9fn6QdDVvNN+fAskbyLmlMIA+lK3iIgv7SyIH0CNyexpYC0w
	qs82gR1NtHVQLfIP7Spxuy5s4yRibE9cvXe0HbcVU7pHfdd5PacXTHUKWjEa
X-Google-Smtp-Source: AGHT+IGb6eTScr0LY9DgD8zUpe3Bmg0viqcBsvMIjOEHpjDxUPdW1SQXe01gsziysnlgLDeZcS2iiw==
X-Received: by 2002:a05:6a20:2448:b0:1a7:243f:8d4e with SMTP id t8-20020a056a20244800b001a7243f8d4emr153881pzc.41.1712034136397;
        Mon, 01 Apr 2024 22:02:16 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id g21-20020aa78755000000b006e71aec34a8sm8854167pfo.167.2024.04.01.22.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 22:02:16 -0700 (PDT)
Date: Mon, 01 Apr 2024 22:02:14 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 bpf@vger.kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 martin.lau@kernel.org
Cc: andrii@kernel.org, 
 kernel-team@meta.com
Message-ID: <660b9156d5c3f_1af77208ec@john.notmuch>
In-Reply-To: <20240402021307.1012571-4-andrii@kernel.org>
References: <20240402021307.1012571-1-andrii@kernel.org>
 <20240402021307.1012571-4-andrii@kernel.org>
Subject: RE: [PATCH v2 bpf-next 3/4] bpf: inline bpf_map_lookup_elem() for
 PERCPU_ARRAY maps
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Andrii Nakryiko wrote:
> Using new per-CPU BPF instruction implement inlining for per-CPU ARRAY
> map lookup helper, if BPF JIT support is present.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/arraymap.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 13358675ff2e..8c1e6d7654bb 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -246,6 +246,38 @@ static void *percpu_array_map_lookup_elem(struct bpf_map *map, void *key)
>  	return this_cpu_ptr(array->pptrs[index & array->index_mask]);
>  }
>  
> +/* emit BPF instructions equivalent to C code of percpu_array_map_lookup_elem() */
> +static int percpu_array_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
> +{
> +	struct bpf_array *array = container_of(map, struct bpf_array, map);
> +	struct bpf_insn *insn = insn_buf;

Nit, If you wanted to be consistent with array_*_map_gen_lookup,

	const int ret = BPF_REG_0;
	const int map_ptr = BPF_REG_1;
	const int index = BPF_REG_2;

But, I think its easier to read as is.

> +
> +	if (!bpf_jit_supports_percpu_insn())
> +		return -EOPNOTSUPP;
> +
> +	if (map->map_flags & BPF_F_INNER_MAP)
> +		return -EOPNOTSUPP;
> +
> +	BUILD_BUG_ON(offsetof(struct bpf_array, map) != 0);
> +	*insn++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, offsetof(struct bpf_array, pptrs));
> +
> +	*insn++ = BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0);
> +	if (!map->bypass_spec_v1) {
> +		*insn++ = BPF_JMP_IMM(BPF_JGE, BPF_REG_0, map->max_entries, 6);
> +		*insn++ = BPF_ALU32_IMM(BPF_AND, BPF_REG_0, array->index_mask);
> +	} else {
> +		*insn++ = BPF_JMP_IMM(BPF_JGE, BPF_REG_0, map->max_entries, 5);
> +	}
> +
> +	*insn++ = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
> +	*insn++ = BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1);
> +	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
> +	*insn++ = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
> +	*insn++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
> +	*insn++ = BPF_MOV64_IMM(BPF_REG_0, 0);
> +	return insn - insn_buf;
> +}
> +
>  static void *percpu_array_map_lookup_percpu_elem(struct bpf_map *map, void *key, u32 cpu)
>  {
>  	struct bpf_array *array = container_of(map, struct bpf_array, map);
> @@ -776,6 +808,7 @@ const struct bpf_map_ops percpu_array_map_ops = {
>  	.map_free = array_map_free,
>  	.map_get_next_key = array_map_get_next_key,
>  	.map_lookup_elem = percpu_array_map_lookup_elem,
> +	.map_gen_lookup = percpu_array_map_gen_lookup,
>  	.map_update_elem = array_map_update_elem,
>  	.map_delete_elem = array_map_delete_elem,
>  	.map_lookup_percpu_elem = percpu_array_map_lookup_percpu_elem,

Acked-by: John Fastabend <john.fastabend@gmail.com>
