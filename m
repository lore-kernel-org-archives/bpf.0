Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AF6405EC
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 12:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711111070; cv=none; b=NM5pmiQwdxgJqOc2zXAKaMO5JvQIFfcrmGOX+NiY2p08OS2fis2aW386p71i0FF1b7Oybph8kdtou2EVxG/jGhGIWm1zpCJIUajIXTNBWcJt3dL17L1qZfjmIc09UYC7NsdBXvTNSUWQcfu1gvdYW1vDBxGipW80mC1c1qpQVZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711111070; c=relaxed/simple;
	bh=XlDXGwc7mvggNzo4tCOyvFQ0ZDZcdWiJIQdYHKWECPY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvKKh44ZpH9upQUctQmTC1eYjR+MT2tzcA1xPhd/etlkttcXXAjoSarJowd3J9YUZ2UcRhVKH1zjwcPVrfAauwbZPlioLOiAI47+uG+ku1/WeBdxGRDk0LOVlwemsuMsPDwaSoZOgymEhCdp6VqMUN4ektN8/4sFqdYiLIimDRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jw0o1/Sm; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jw0o1/Sm"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4147ece66ecso138985e9.0
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 05:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711111067; x=1711715867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H8zabiTYaXjhWLm3VXlelyRqPb9buDYX0hjbSIoUI8g=;
        b=Jw0o1/Smg41e+U8q3RDSGN/JeU4hzDBnSOJMrJpveT8DKZeuIzydZ7rWfClpmeViJO
         E0XFAR2yLXCcrZCQF/ujFZXXz6a8hN/OGJyUh9241fO3onRxV+/wnTAj+XISUvPBapOj
         xa4jL180o0VUg5K6fGDmCehlOCTJB/HM5DLR0pN7IEWMM9u9JiIYlX1fQTq0ng8TTglW
         kXxqcmuxhEeoxpS32YWwT35Dl8B4RlyljSOwkZuy92nwbWyBYozyTaE5r3nWf5eTHHkR
         d0jVcCgi+wI+sIiJshFFR2TFdhuHOd6SnGWss/AXkSdDpI1QyobMmNSfctT6ENbRsokO
         FBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711111067; x=1711715867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8zabiTYaXjhWLm3VXlelyRqPb9buDYX0hjbSIoUI8g=;
        b=SYQDIh1WmiCYFBZOTgiMXa+rtdvY+1q2nBavmZl+SZSQOKjWy3ZwxYmj5gcOqCNMK3
         VwGG+6gGrTeLPaH1/Q3slP7yPqTFipgxJpAWcLNMb9WLrSEtrBAg/y/bJzBwP4r0XE6H
         ZqPUmmOPUvDzIwqUCczFfkadlWGCon2QbdetUIf27DDxIqWAMA/UC4kDfRHqR4Uaocu0
         tO2gruuvzQQ3xL+zKOAbVWgI9VJjdi2QRYwjYQSyGh12tgfCHsG6ZyUtjQuVXjBu4UCP
         VmNkcGDqR3PlxlhzMel7T45ca/8AgDgT6ud4PoWskzJvNHnkZW8kec7bnRpvH8xvoLEw
         ZI7w==
X-Gm-Message-State: AOJu0Yy5cAtWNzy5EBvoYI3+T8BQ7Pm8FtHeQekLTgNsZngIwhB1aDB3
	bXF7bcG5c+pA0aK2opYYefLBX+EkZBJpDHpIWuSkBommHh0yQais
X-Google-Smtp-Source: AGHT+IFxvAsTAztAbK2MZZ+Uza9i58/PbBID/5wqYkP1b765K4077i5Mxs1Ou42JVu8bM/USghcqow==
X-Received: by 2002:a05:600c:491d:b0:414:1eb:3010 with SMTP id f29-20020a05600c491d00b0041401eb3010mr1380965wmp.17.1711111066934;
        Fri, 22 Mar 2024 05:37:46 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c358b00b0041408af4b34sm8727499wmq.10.2024.03.22.05.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 05:37:46 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 22 Mar 2024 13:37:44 +0100
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v2 2/5] libbpf: Mark libbpf_kallsyms_parse
 static function
Message-ID: <Zf17mB9SYKiXDneG@krava>
References: <20240321200058.2218328-1-yonghong.song@linux.dev>
 <20240321200108.2219280-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321200108.2219280-1-yonghong.song@linux.dev>

On Thu, Mar 21, 2024 at 01:01:08PM -0700, Yonghong Song wrote:
> Currently libbpf_kallsyms_parse() function is declared as a global
> function but actually it is not a API and there is no external
> users in bpftool/bpf-selftests. So let us mark the function as
> static.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/lib/bpf/libbpf.c          | 2 +-
>  tools/lib/bpf/libbpf_internal.h | 2 --
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 86df0d50cba7..a7a89269148c 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -7982,7 +7982,7 @@ static int bpf_object__sanitize_maps(struct bpf_object *obj)
>  	return 0;
>  }
>  
> -int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *ctx)
> +static int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *ctx)
>  {
>  	char sym_type, sym_name[500];
>  	unsigned long long sym_addr;
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> index 864b36177424..b1bbbdcb7792 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -521,8 +521,6 @@ __s32 btf__find_by_name_kind_own(const struct btf *btf, const char *type_name,
>  typedef int (*kallsyms_cb_t)(unsigned long long sym_addr, char sym_type,
>  			     const char *sym_name, void *ctx);
>  

there's also kallsyms_cb_t which should be moved to libbpf.c,
or perhaps removed and unwinded in libbpf_kallsyms_parse

jirka

> -int libbpf_kallsyms_parse(kallsyms_cb_t cb, void *arg);
> -
>  /* handle direct returned errors */
>  static inline int libbpf_err(int ret)
>  {
> -- 
> 2.43.0
> 
> 
