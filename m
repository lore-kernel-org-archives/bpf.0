Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1EA3CF679
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775655433; cv=none; b=kaZ0IGszrR07Hl1y0Kig7/KH8Chwr0LVrCnpJoFtUbh++jML+rYUmgSfIRnzsYTU7OWakOsAiL+8EP6aXza2y55SFcLGTzGsxM/fOxjLN+IQGzNlaoow6SLjg2VsNmczHrYIuaRuEFmqIx91Upjr4XYBm5em/CbA/QHPb8jfVyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775655433; c=relaxed/simple;
	bh=VdsAyITYSvOoIvRuLVnRqd7ZMcFxRitEkEhZ1xfKNj4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdZsU/AcPkDe/KXJd0G6TmC/r8+xejgh0vik5vY2ANMupWz0msA6hQh61pfO1h3OoydtX/GvKO3GEYe7OW4Wc14VnJ+6JeEYLUQtNbSu7pVLQxyHPP7GLW7upXAKyHUcPH9a7+tUcXoPp9Osn/7hpN7tjD4xsCC4qDX6HIPn0Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CS+ZQFtw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CS+ZQFtw"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso48912575e9.3
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 06:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775655431; x=1776260231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3/LGuGCi+w7qbftpon2fkJ0OLFz43jmAigvI+d6u0d0=;
        b=CS+ZQFtwgc98hG/ElXf7MJqFN+VXArHbLsDkyd04FDBi6u+Pn9c6AK+5xmbWWaYYum
         aYukc+uuFPLiwpCZVZazzib/dsTw5bsu1JwGVr3JjxaS27gSZaQ/jrbibn8/55YpIxPI
         HexuXAk0g9WwXabaRgfFkaNFHtA9QoDUB+EyRoXCyciDkqw3EDCyMog7hH1Ffb0076Kq
         2hC8ETXcIArNJ1IwS+gPvG9BqulvwxxAYcgWdoeXj2olgoBPilsmdloRYM1Ew1LiOgzD
         rXYNxTCAPf4H1vYfDNNvv+Syp09qbyMp7Wli+Gn8kZMeP+LSriG2Spbn/Fe8sZ3YUyYX
         677Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775655431; x=1776260231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/LGuGCi+w7qbftpon2fkJ0OLFz43jmAigvI+d6u0d0=;
        b=LJlbOaEmr4Xm7zRaaYomwxApYNB0XiqA9kJRaSUsyjgSsbLLshv4qTucDivmqJ3jw8
         wfnhC1OVjBCKI2WFRFZZbBrk/NHb9PsXj1RUeE6bz4d/9QvDLLDHjipN16RNTshNuq30
         JLX06La5LpGtScj2DJrpIO36iXLUqDRsJsDmSw/fC2OkfgPoBAOgfds0c2fmHBn8B6yV
         Nj4fSHG+ad7LIonbssUJFvwcPI44qsr3sHiLvQatF71iCjSwEVBz+ZeHh/lWzn7h/yTO
         vvs8tXn06LCYZy5xuL2zeMbDA5DzmDpfkfG9QNIuCYjpSWJOr96sgJ9Pak5pma0zA+oa
         DdfA==
X-Forwarded-Encrypted: i=1; AJvYcCX4nVXq5l41TJW7ErEe5CrfBKm8iHEujlpuwVdEN/8mZadAB/FEw9V9oeT+ilHQENWfEYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOdwW5d2eZX6NCLdpLVF+r/2KWAmN18t8EF2Whqaf6CPUioLP7
	hkxMIoYMUyjnArdtRb6AkQ+ztimjuyv4b2P7Wi4KGrdvZYGOtu0N/7HA
X-Gm-Gg: AeBDievRYjVnQ1PK4fuoxhfS/L5Tw4/AOKTUeI42yprxdoH/PRz9PZWQ06yu7xY1Iuk
	Ek3stq5II+84sMM9av2LFn5gsj9ZjvJOMKWJRkvlyn2xmDTFjg1op/kwQ3fJ4pYA1QIeUwJABVY
	hID205T5KCdhshbZm541/myqguxHsQIFwCqtGmPpaB/tJcxSYU8y7DxnptjY1l13wRWNEkBwdQ0
	a9vhIiOdzKCdGpJqtLK1PxmZ6ogx0S2KswdCGfwbRVOAnx0FnDUQ4LUlMK4Z/igJAfOorXlDxXI
	JuREUVxpVle2VULo6HKbcr6AVNnrQ+5sr75UX1c522ciD07DhJl5yeS4TnMj9aB1gZqiFe547zm
	pxqQCdSbub0a0J7suT+TIPDzdtIDP+doTBfTnSPx0fbgA8hWEsBV5lNKl1x9Sm1sBo0qWlwjYAn
	7tYIs9e5nvUGiHHFo=
X-Received: by 2002:a05:600c:4f4e:b0:488:a98b:b891 with SMTP id 5b1f17b1804b1-488a98bbd04mr243029675e9.3.1775655430590;
        Wed, 08 Apr 2026 06:37:10 -0700 (PDT)
Received: from krava ([2a00:102a:5031:5a39:87ca:af14:10da:98b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c5308b3esm21277505e9.1.2026.04.08.06.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 06:37:09 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 8 Apr 2026 15:37:05 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 1/2] libbpf: Allow use of feature cache for
 non-token cases
Message-ID: <adZaASNAuZSaxcni@krava>
References: <20260408105324.663280-1-alan.maguire@oracle.com>
 <20260408105324.663280-2-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408105324.663280-2-alan.maguire@oracle.com>

On Wed, Apr 08, 2026 at 11:53:23AM +0100, Alan Maguire wrote:
> Allow bpf object feat_cache assignment in BPF selftests
> to simulate missing features via inclusion of libbpf_internal.h
> and use of bpf_object_set_feat_cache() and bpf_object__sanitize_btf() to
> test BTF sanitization for cases where missing features are simulated.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/libbpf.c          | 12 ++++++++++--
>  tools/lib/bpf/libbpf_internal.h |  3 ++-
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 42bdba4efd0c..b7b636786d38 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -3145,7 +3145,7 @@ static bool btf_needs_sanitization(struct bpf_object *obj)
>  	       !has_layout;
>  }
>  
> -static struct btf *bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *orig_btf)
> +struct btf *bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *orig_btf)
>  {
>  	bool has_func_global = kernel_supports(obj, FEAT_BTF_GLOBAL_FUNC);
>  	bool has_datasec = kernel_supports(obj, FEAT_BTF_DATASEC);
> @@ -5203,12 +5203,20 @@ bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
>  		 */
>  		return true;
>  
> -	if (obj->token_fd)
> +	if (obj->feat_cache)
>  		return feat_supported(obj->feat_cache, feat_id);
>  
>  	return feat_supported(NULL, feat_id);
>  }
>  
> +/* Used in testing to simulate missing features. */
> +void bpf_object_set_feat_cache(struct bpf_object *obj, struct kern_feature_cache *cache)
> +{
> +	if (obj->feat_cache)
> +		zfree(&obj->feat_cache);

nit, no need to zfree, we set it right below

jirka

> +	obj->feat_cache = cache;
> +}
> +
>  static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
>  {
>  	struct bpf_map_info map_info;
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> index cabdaef79098..3781c45b46d3 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -414,6 +414,7 @@ struct kern_feature_cache {
>  
>  bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id);
>  bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id);
> +void bpf_object_set_feat_cache(struct bpf_object *obj, struct kern_feature_cache *cache);
>  
>  int probe_kern_syscall_wrapper(int token_fd);
>  int probe_memcg_account(int token_fd);
> @@ -427,7 +428,7 @@ int libbpf__load_raw_btf(const char *raw_types, size_t types_len,
>  int libbpf__load_raw_btf_hdr(const struct btf_header *hdr,
>  			     const char *raw_types, const char *str_sec,
>  			     const char *layout_sec, int token_fd);
> -
> +struct btf *bpf_object__sanitize_btf(struct bpf_object *obj, struct btf *orig_btf);
>  int btf_load_into_kernel(struct btf *btf,
>  			 char *log_buf, size_t log_sz, __u32 log_level,
>  			 int token_fd);
> -- 
> 2.39.3
> 
