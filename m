Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743023DEAC6
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 15:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776268670; cv=none; b=BORFQJP/fFQTYDAEnww7TZ+W0623/0KQNGi9IubmfAN7LLXS+q5uINJEOKvpji3L3acbkgOKS25q/f1TNWin5uBrP16cWi0RDGQFTZI2dNGD8sT7uU2QXPbue36ZQCPPryEp8RRHMzXbKk8Qp/xd9mf9vkfnLmLNemv+A2cQ0Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776268670; c=relaxed/simple;
	bh=YTdUR+GJ/190ROLNBy8sQhJQ76b2BXXm2OU9wVRsk1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HAf0Mp0uXt5NM6Cg/taA2IaSF56QQOe0AzIhw9qOEhRzGiTppw0VpPyjqY7i0MzdJ7zTkdxyBUBm67VJKk3AgY4MySOagvLUdkut+BRJVpft7r07iaEYHgXJXDETiffpoSNlp44yxtBRD5vJK/t5HkIeUEnNw2yytjCBFjO2fZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2J8PCm2; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2J8PCm2"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso56389445e9.0
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 08:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776268667; x=1776873467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bSJFCxAK7AwK6IYRzsR+dYW24mcaC3fBtdMN7p/JTHY=;
        b=B2J8PCm2uXfvTaEwTUR0HHzBYMkDehcrTdE0j0hQiAoDgVUSNwoUbFYqqf465VwUO8
         pCXsjQSBtOsmUskaeLBvD+dUikR7nDhvg/cn1ep6rK3B7Jv7U9Mo5nfswBxIMLOoH1ic
         szBI4tu+Iz+vrWZ3rvJlf/CAzHJcQnbcvRMqeOsSfBxZn8Fy0sz36+Sp6wSQBVjUTPqo
         0rD/1Q8vhVZOTKobx3EjYZpVRA3X9hqchQP1bLtVxXKAKUpeq/PYXR3Ks0gCaOtk1V9F
         6yRsYeFuk7s1ZCtQQuOzjNSmhH01g7WpPIYCZ1qkuUZ+OCQtm9D6JFwMijGYn9MvTCij
         qMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776268667; x=1776873467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bSJFCxAK7AwK6IYRzsR+dYW24mcaC3fBtdMN7p/JTHY=;
        b=BaNlaz7VmFu7zXMKFwbKsjOaGNi7+XD+djOZAEscA01s0evvl/WFhJ5vcWaeHtJJgy
         61QkCXXNVtWynPguXbklyTzLzPAMrDTK/HeKLIXUuoAoogp/+A2IV+2ut8VYHFsCKqkO
         CJ1tabRGhnTXNkHDYGEz5cVZV3zZBqGRaL7KggypwMoKe4it4QqxkbnIHzLZXGnSEuJ7
         xP4NKke0YWew/eKxkQVqqFsQ1pZ9p6dwvQomvKJSs/1RZugE4U0XJnMdcB8e8RJj/0Jr
         K6vmB3owJ5AOqekJQAWZbAc1LRN8tKVolp9YY6fYXhATCyn76EgXYsbuEPYDbbzLWokm
         sDBg==
X-Forwarded-Encrypted: i=1; AFNElJ+u4DpUH9CH+HSn1CrSIrkW+I+E97HBb/zOaV33JJYwLMjCGmVT0eWHRTff31jIE6gVZEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQE9Fy/Z1RMP08RWFvDJ3fWkqHEG7j2pm1FNKGkNM83e9hiIUZ
	Y5Mw+m7FxDU1pRX+WG48psQBr1qmnWm4Mpws67bdtEhGtyVJfLEEkyzN
X-Gm-Gg: AeBDiev/uSeMCYOLpSbU1qw/505m/Np5sOaRN5kfa/Tm3u4kBeJiNo+7Pa3n42VmEl1
	BmpFbh9jh7yPZyPoGIABP9qHnGu7vUCsPDfLJlPaIHQXXAH0rFwey5aDgTZu1oeTe+3GxxNGVye
	teyosrBosAja7LHlIP8kJZKx3uO5poOukoo5KGRUFoVuZrk5VShYYu9TY7+7Jl24WWXFLn3vNFK
	24yM3r0PKrM7YbP9JSp1UbXpkT96DQgwhjCmdwA2TJKOmZB79Vq7cMbXNRR+645mrXxXWK9VyD/
	/qcOiahV42+zTNHkJpv3EFMwruh2zocJIH/+wQSvZCOnUnLUHJDZ1TDQyxuIhW2AoQnPPDxgG7w
	ItLu+05kpa5MzYchcHVHrfyYs8m/RLilwij6tztQDGG+VQNXODQ395xlUBCv6fpcQjXqPDmlPh3
	Zyr4urTQMyqOHcH1i31eI4K3CDuJaanGH58kwdGrjc0Dygph+2N9PNBCerGcny
X-Received: by 2002:a05:600c:a109:b0:488:b239:77ec with SMTP id 5b1f17b1804b1-488d683d510mr220846895e9.17.1776268666610;
        Wed, 15 Apr 2026 08:57:46 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:cbe8:6434:118f:886d? ([2620:10d:c092:500::5:3ecd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f1e95130sm59339665e9.13.2026.04.15.08.57.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 08:57:46 -0700 (PDT)
Message-ID: <ba42c4f7-0bce-4aa9-be90-e102ea04336f@gmail.com>
Date: Wed, 15 Apr 2026 16:57:45 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/6] libbpf: Add feature for kernel extended
 vlen/kind support
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, qmo@kernel.org,
 bpf@vger.kernel.org
References: <20260414195019.684531-1-alan.maguire@oracle.com>
 <20260414195019.684531-4-alan.maguire@oracle.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260414195019.684531-4-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/14/26 8:50 PM, Alan Maguire wrote:
> Add feature check for kernel extended vlen/kind support, and reject
> BTF that uses extended vlens/kinds if the kernel does not support
> it.  There is no reasonable path to generally sanitize such BTF.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>   tools/lib/bpf/features.c        | 39 +++++++++++++++++++++++++++++++++
>   tools/lib/bpf/libbpf.c          | 17 +++++++++++++-
>   tools/lib/bpf/libbpf_internal.h |  2 ++
>   3 files changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index 4f19a0d79b0c..4a75d6717bbb 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -615,6 +615,42 @@ static int probe_kern_btf_layout(int token_fd)
>   						 (char *)layout, token_fd));
>   }
>   
> +static int probe_kern_btf_vlen_kind_extended(int token_fd)
> +{
> +	struct btf *btf;
> +	int ret = 0;
> +	__s32 id;
> +	int err;
> +
> +	btf = btf__load_vmlinux_btf();
> +	err = libbpf_get_error(btf);
> +	if (err)
> +		return err;
> +	id = btf__find_by_name_kind(btf, "btf_max", BTF_KIND_ENUM);

Looks like if id > 0 then extended vlen and kinds are available, so 
there is no point to continue processing the enum and checking value of 
the BTF_MAX_VLEN. Or is there a scenario, where BTF_MAX_VLEN goes back 
to 0xffff?

> +	if (id > 0) {
> +		const struct btf_type *t;
> +		const struct btf_enum *e;
> +		const char *name;
> +		__u32 i, vlen;
> +
> +		t = btf__type_by_id(btf, id);
> +		if (t) {
> +			vlen = btf_vlen(t);
> +
> +			for (i = 0, e = btf_enum(t); i < vlen; i++, e++) {
> +				name = btf__name_by_offset(btf, e->name_off);
> +				if (!name || strcmp(name, "BTF_MAX_VLEN") != 0)
> +					continue;
> +				if (e->val > 0xffff)
> +					ret = 1;
> +			}
> +		}
> +	}
> +	btf__free(btf);
> +
> +	return ret;
> +}
> +
>   typedef int (*feature_probe_fn)(int /* token_fd */);
>   
>   static struct kern_feature_cache feature_cache;
> @@ -699,6 +735,9 @@ static struct kern_feature_desc {
>   	[FEAT_BTF_LAYOUT] = {
>   		"kernel supports BTF layout", probe_kern_btf_layout,
>   	},
> +	[FEAT_BTF_VLEN_KIND_EXTENDED] = {
> +		"kernel supports extended BTF vlen/kind", probe_kern_btf_vlen_kind_extended,
> +	},
>   };
>   
>   bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id)
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 8b0c3246097f..5f19d8ac17a9 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -3139,10 +3139,11 @@ static bool btf_needs_sanitization(struct bpf_object *obj)
>   	bool has_enum64 = kernel_supports(obj, FEAT_BTF_ENUM64);
>   	bool has_qmark_datasec = kernel_supports(obj, FEAT_BTF_QMARK_DATASEC);
>   	bool has_layout = kernel_supports(obj, FEAT_BTF_LAYOUT);
> +	bool has_vlen_kind_extended = kernel_supports(obj, FEAT_BTF_VLEN_KIND_EXTENDED);
>   
>   	return !has_func || !has_datasec || !has_func_global || !has_float ||
>   	       !has_decl_tag || !has_type_tag || !has_enum64 || !has_qmark_datasec ||
> -	       !has_layout;
> +	       !has_layout || !has_vlen_kind_extended;
>   }
>   
>   struct btf *bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *orig_btf)
> @@ -3156,6 +3157,7 @@ struct btf *bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *orig_bt
>   	bool has_enum64 = kernel_supports(obj, FEAT_BTF_ENUM64);
>   	bool has_qmark_datasec = kernel_supports(obj, FEAT_BTF_QMARK_DATASEC);
>   	bool has_layout = kernel_supports(obj, FEAT_BTF_LAYOUT);
> +	bool has_vlen_kind_extended = kernel_supports(obj, FEAT_BTF_VLEN_KIND_EXTENDED);
>   	int enum64_placeholder_id = 0;
>   	const struct btf_header *hdr;
>   	struct btf *btf = NULL;
> @@ -3217,6 +3219,19 @@ struct btf *bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *orig_bt
>   	for (i = 1; i < btf__type_cnt(btf); i++) {
>   		t = (struct btf_type *)btf__type_by_id(btf, i);
>   
> +		/*
> +		 * If BTF uses extended vlen/kind and kernel does not support
> +		 * it, there is nothing we can do.
> +		 */
> +		if (!has_vlen_kind_extended) {
> +			if (btf_vlen(t) > 0xffff || btf_kind(t) > 0x1f) {
> +				pr_debug("Unsupported %s for id %u\n",
> +					 btf_kind(t) > 0x1f ? "BTF kind" : "BTF vlen", i);
> +				btf__free(btf);
> +				return ERR_PTR(-EINVAL);
> +			}
> +		}
> +
>   		if ((!has_datasec && btf_is_var(t)) || (!has_decl_tag && btf_is_decl_tag(t))) {
>   			/* replace VAR/DECL_TAG with INT */
>   			t->info = BTF_INFO_ENC(BTF_KIND_INT, 0, 0);
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> index 3781c45b46d3..8ef1fc96b73a 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -398,6 +398,8 @@ enum kern_feature_id {
>   	FEAT_UPROBE_SYSCALL,
>   	/* Kernel supports BTF layout information */
>   	FEAT_BTF_LAYOUT,
> +	/* Kernel supports BTF vlen > 65535 */
> +	FEAT_BTF_VLEN_KIND_EXTENDED,
>   	__FEAT_CNT,
>   };
>   

