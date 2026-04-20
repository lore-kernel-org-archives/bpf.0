Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A9333DEF9
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 13:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776693426; cv=none; b=JSaF+jpMLgCaovt2JTMQ6Qu2QORrwY+9U90vJagfUkHJr8qPA5ep+BejJBErsTPZ+AFmLv9UuSgzAx9+fqksXnP+ZcL1etGlLMom663GZ46iY2JSQt1I0+WXinS0qB/IiVCStcpzGztGpHWyzwviEub2CiLmFZ3wvQOP8rx6ung=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776693426; c=relaxed/simple;
	bh=l/PdCOgIG42EOMs8vomp8wYoE3wgsbJzSA0jPOXkhjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JTHj1aNWIwYacIUjovOqq1eBARcAcf+Yp5Y9nHSA1YTGgRyCHu0Da8EIN0cbsgw0MNSNBR4Ppu00Cx9kKdI2hMi1s9o0XYYcGHZRy4wAOrRzFmD1+vVj9yG8ICcsrD2D+5MAsuA3JA+GveU04g4WIAV73rKt1gQrkap84uUENmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Od2ZPk2W; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Od2ZPk2W"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43fde5b81a1so2264710f8f.0
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 06:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776693424; x=1777298224; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TVO8lmv+ySnv3ODGt06ei7GCj6or8bryxePh1k/oUoA=;
        b=Od2ZPk2W0WT7SVNqdoR63PFEhIts1TIVMS0ICAMj8758Ag4ri/pE1rKzvb2UhJoPnl
         KKwAMMwNyW/3KoiBTvsCa00YHa+rIX5uJabvk9qU4emPpLxw4zZj3EEODNuOIrPXjEDH
         q7UCRoArVA/54wtD5fH5uijz8HaucdAhdqCihsE8yExYer3Op58/1d6/H+RS4B6OL3oM
         0GrUCw8J5lQrlhkZQIuFNDvYv0QBUSAs/XwtN2biXmooN4H64ZFtoIj/80E9afxm9Ue/
         8UxMEI8iyzd37Kfp1GqI8ydRYmO7J0cBY4q1wqCHHOwqXNI4kxRgTa8z5FADDmV9De1L
         ifbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776693424; x=1777298224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVO8lmv+ySnv3ODGt06ei7GCj6or8bryxePh1k/oUoA=;
        b=VP/7jgHQHMN4nygJoPFUe8Rp6mMEN0oCiCt/8Hn9oO2u/l6x4KpcW0TMphI5wB/QRX
         gaorQJVqkh2OTiMZXO30KpQDuAN5CqFOEPsapIvcMRNuTq0dzf6Y99Q4f6P/6O3oXW74
         VIymo8vOthOJCXZxMTiPdUm4NinUc92L9XhcmEDefh1RAcovNvgHmUa4Ido7mtORe7zc
         iTWFhu8SyA6uOuNZILpPkAr0te9PjT0n+hZ9DTl5e1DtAlmUfYqp78m6daLGaSX9C31M
         avQAkGoDop+MyzcMDII45A9ECotwDH7OmYKE/eR74Tz+n5aNe2PC4yuXq8GJdz256Ken
         BxWA==
X-Forwarded-Encrypted: i=1; AFNElJ+GoTaleGxQGRf0zMz30b9m0JXYdIzaU5LiDZ9yU8V99hJ5mZ3fX8P7TkPrcztBCVXdX8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlATGlxRHnkrDLOZVOVztt5BnAZ6wEBUOO4HI7DQ8uaw2vzQ0J
	6o3kirp+Wk2SX2f30oh1VpGlCCtm567FJDg+D+F9xDStCUiFnM3vilUq
X-Gm-Gg: AeBDievZ5CyBaNsqDEYmsoJTpG91yzxQMJjqFsPIgzUAnZ8ndnaxow9tFYn0W+6fHbO
	lVFPPuHj2F1BiNhe39mUFtAV1e2RVvirVBMfdRwtH+0NUjR4gZYkRaoNVBmzci2bM5Dm8FuHvXA
	YsMDbfx9wJKQnDm+Opq9bQHmxl89QbmzAwT2YBXCFZHMLon8y7XbuAUhRtKxjNoEwacICuoWAzf
	SJH0mYafO8M1r20ZYBWzYwlZ4GXzQIGEs1PWfOFQUVrIjAh9dLJcsMKYsMxrCnubAg4EPI6n2jk
	Vmedhzd89KrFbnFZgCO55jEwmpgVzuhjlf1UJA7PZIVsF+OroQvpsxanvam2LLzamrh5RIUkjtr
	FfQmFAy1YA4TdWamixXvi3h8IRJr7LpyJsOFuKDyUBepHmkwuyJqq+S5JnzhyzWIHvP2nq1IRSt
	MTRTO+F77xCljqxZqHze5/uPdGyHHJtA5e1u77HaR08zZRm5IRaRZ7kACGOBmO4F8kqhV/2Q==
X-Received: by 2002:a05:6000:1889:b0:439:c62a:6dc2 with SMTP id ffacd0b85a97d-43fe3e0afb9mr21485031f8f.41.1776693423521;
        Mon, 20 Apr 2026 06:57:03 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:5432:2d05:ea5:f7f7? ([2620:10d:c092:500::6:8ffd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc2cacsm29370091f8f.13.2026.04.20.06.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 06:57:03 -0700 (PDT)
Message-ID: <d3e3a02f-8948-4952-b0e9-6e289fe09a41@gmail.com>
Date: Mon, 20 Apr 2026 14:57:02 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 3/4] libbpf: Request verifier warnings for
 object loads
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, kkd@meta.com, kernel-team@meta.com
References: <20260418171701.610025-1-memxor@gmail.com>
 <20260418171701.610025-4-memxor@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260418171701.610025-4-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/18/26 6:16 PM, Kumar Kartikeya Dwivedi wrote:
> On kernels supporting BPF_LOG_LEVEL_WARN, have libbpf request verifier
> warnings for BPF object program loads by ORing in the warning bit.  This
> keeps the existing log_level=0 retry semantics for verbose logs, while
> still surfacing verifier warnings for successful loads.
> 
> When libbpf owns the log buffer, use a small buffer for warning-only
> loads and flush captured warnings through the print callback. Detect
> support by probing for BPF_FEAT_VERIFIER_WARNINGS in enum bpf_features,
> and document the updated kernel_log_level behavior.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>   tools/lib/bpf/features.c        | 56 +++++++++++++++++++++++++++++++++
>   tools/lib/bpf/libbpf.c          | 25 ++++++++++-----
>   tools/lib/bpf/libbpf.h          |  7 +++--
>   tools/lib/bpf/libbpf_internal.h |  2 ++
>   4 files changed, 80 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index 4f19a0d79b0c..78f07866db12 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -208,6 +208,59 @@ static int probe_kern_btf_type_tag(int token_fd)
>   					     strs, sizeof(strs), token_fd));
>   }
>   
> +static bool btf_type_has_enum_value(const struct btf *btf, const struct btf_type *t,
> +				    const char *value_name)
> +{
> +	int i, vlen = btf_vlen(t);
> +
> +	if (btf_is_enum(t)) {
> +		const struct btf_enum *e = btf_enum(t);
> +
> +		for (i = 0; i < vlen; i++, e++) {
> +			if (strcmp(btf__name_by_offset(btf, e->name_off), value_name) == 0)
> +				return true;
> +		}
> +	} else if (btf_is_enum64(t)) {
> +		const struct btf_enum64 *e = btf_enum64(t);
> +
> +		for (i = 0; i < vlen; i++, e++) {
> +			if (strcmp(btf__name_by_offset(btf, e->name_off), value_name) == 0)
> +				return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
> +static int probe_kern_verifier_warnings(int token_fd)
> +{
> +	const struct btf_type *t;
> +	struct btf *btf;
> +	bool found = false;
> +	__s32 type_id;
> +
> +	(void)token_fd;
> +
> +	btf = btf__load_vmlinux_btf();
> +	if (libbpf_get_error(btf))
> +		return 0;
> +
> +	type_id = btf__find_by_name_kind(btf, "bpf_features", BTF_KIND_ENUM);
> +	if (type_id < 0)
> +		type_id = btf__find_by_name_kind(btf, "bpf_features", BTF_KIND_ENUM64);
> +	if (type_id < 0) {
> +		btf__free(btf);
> +		return 0;
> +	}
> +
> +	t = btf__type_by_id(btf, type_id);
> +	if (t)
> +		found = btf_type_has_enum_value(btf, t, "BPF_FEAT_VERIFIER_WARNINGS");
> +
> +	btf__free(btf);
> +	return found;
> +}
> +
>   static int probe_kern_array_mmap(int token_fd)
>   {
>   	LIBBPF_OPTS(bpf_map_create_opts, opts,
> @@ -669,6 +722,9 @@ static struct kern_feature_desc {
>   	[FEAT_BTF_TYPE_TAG] = {
>   		"BTF_KIND_TYPE_TAG support", probe_kern_btf_type_tag,
>   	},
> +	[FEAT_VERIFIER_WARNINGS] = {
> +		"BPF_LOG_LEVEL_WARN verifier warnings", probe_kern_verifier_warnings,
> +	},
>   	[FEAT_MEMCG_ACCOUNT] = {
>   		"memcg-based memory accounting", probe_memcg_account,
>   	},
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 3a80a018fc7d..c7b00c097698 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -7841,12 +7841,17 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
>   {
>   	LIBBPF_OPTS(bpf_prog_load_opts, load_attr);
>   	const char *prog_name = NULL;
> +	const size_t warn_log_buf_size = 4096;
>   	size_t log_buf_size = 0;
>   	char *log_buf = NULL, *tmp;
>   	bool own_log_buf = true;
>   	__u32 log_level = prog->log_level;
> +	bool supports_verifier_warnings = kernel_supports(obj, FEAT_VERIFIER_WARNINGS);
>   	int ret, err;
>   
> +	if (supports_verifier_warnings)
> +		log_level |= 16;
> +
>   	/* Be more helpful by rejecting programs that can't be validated early
>   	 * with more meaningful and actionable error message.
>   	 */
> @@ -7921,10 +7926,9 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
>   	}
>   
>   retry_load:
> -	/* if log_level is zero, we don't request logs initially even if
> -	 * custom log_buf is specified; if the program load fails, then we'll
> -	 * bump log_level to 1 and use either custom log_buf or we'll allocate
> -	 * our own and retry the load to get details on what failed
> +	/* If verifier warning logging is supported, we can request warnings
> +	 * even without verbose logging. If the program load fails, retry with
> +	 * log_level=1 to get details on what failed.
>   	 */
>   	if (log_level) {
>   		if (prog->log_buf) {
> @@ -7936,7 +7940,9 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
>   			log_buf_size = obj->log_size;
>   			own_log_buf = false;
>   		} else {
> -			log_buf_size = max((size_t)BPF_LOG_BUF_SIZE, log_buf_size * 2);
> +			log_buf_size = max(log_level == 16 ? warn_log_buf_size :
> +					   (size_t)BPF_LOG_BUF_SIZE,
> +					   log_buf_size * 2);
>   			tmp = realloc(log_buf, log_buf_size);
>   			if (!tmp) {
>   				ret = -ENOMEM;
> @@ -7954,7 +7960,10 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
>   
>   	ret = bpf_prog_load(prog->type, prog_name, license, insns, insns_cnt, &load_attr);
>   	if (ret >= 0) {
> -		if (log_level && own_log_buf) {
> +		if (log_level == 16 && load_attr.log_true_size && own_log_buf) {
> +			pr_warn("prog '%s': -- BEGIN PROG LOAD WARNINGS --\n%s-- END PROG LOAD WARNINGS --\n",
> +				prog->name, log_buf);

I'm not sure if this block makes sense to me: we only print warnings 
banner is warnings is the only requested log type, but we print no 
banner if warnings are requested with other log level, also different 
log_levels: pr_warn() vs pr_debug().

> +		} else if (log_level && own_log_buf) {
>   			pr_debug("prog '%s': -- BEGIN PROG LOAD LOG --\n%s-- END PROG LOAD LOG --\n",
>   				 prog->name, log_buf);
>   		}
> @@ -7981,8 +7990,8 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
>   		goto out;
>   	}
>   
> -	if (log_level == 0) {
> -		log_level = 1;
> +	if (log_level == (supports_verifier_warnings ? 16 : 0)) {
> +		log_level = 1 | (supports_verifier_warnings ? 16 : 0);
>   		goto retry_load;
>   	}
>   	/* On ENOSPC, increase log buffer size and retry, unless custom
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index bba4e8464396..598c6daa822b 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -194,8 +194,11 @@ struct bpf_object_open_opts {
>   	/*
>   	 * Log level can be set independently from log buffer. Log_level=0
>   	 * means that libbpf will attempt loading BTF or program without any
> -	 * logging requested, but will retry with either its own or custom log
> -	 * buffer, if provided, and log_level=1 on any error.
> +	 * verbose logging requested, but will retry with either its own or
> +	 * custom log buffer, if provided, and log_level=1 on any error. On
> +	 * kernels supporting verifier warning logging, libbpf will also
> +	 * request warning messages for successful program loads by default
> +	 * when log_level=0.
>   	 * And vice versa, setting log_level>0 will request BTF or prog
>   	 * loading with verbose log from the first attempt (and as such also
>   	 * for successfully loaded BTF or program), and the actual log buffer
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> index 3781c45b46d3..b2460982d6ca 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -378,6 +378,8 @@ enum kern_feature_id {
>   	FEAT_BTF_DECL_TAG,
>   	/* BTF_KIND_TYPE_TAG support */
>   	FEAT_BTF_TYPE_TAG,
> +	/* Kernel supports BPF_LOG_LEVEL_WARN for verifier warnings */
> +	FEAT_VERIFIER_WARNINGS,
>   	/* memcg-based accounting for BPF maps and progs */
>   	FEAT_MEMCG_ACCOUNT,
>   	/* BPF cookie (bpf_get_attach_cookie() BPF helper) support */

