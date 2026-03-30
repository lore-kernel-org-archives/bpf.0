Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB453B8BB1
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774865295; cv=none; b=pktKPTLFTnScMgTdEYgHtGHh7KsuezAS+LTAF9nUuAGxWbNuGx5+jUWJYEVhQAk8mcstbIFezYcRoloJSjXZTBhw887hWiiCfI5n+T2cpkMWquQGgDF7iWnaLZPN6EhL5i1iHNec8S8QaJp7p9X3Jl670KtAakMxvqMT8HrIXfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774865295; c=relaxed/simple;
	bh=v250ZV92EhEwjYdBfOvaczIRyfoVDf+akMaT36DogAs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFZ7Y6nftfYIeab85y8CP1rRWdahVYTYYCXAkKpQxA2DSvkF0qFCMFO8BOcPkpbT/N5ZOELqcbkDmZfeQ9AqOvqVm6Dj7oK+qoDkydsnPFH2zCPyszFk9hgWITLWRPlMvxryJlX/+DWfWskYWWARe0biWBXUZCifhlz3FOvWMyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhdfPi75; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhdfPi75"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48700b1ba53so37863995e9.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 03:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774865292; x=1775470092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wOJlHnF0FtnHg5n4sKn9pSKwGW+M2qTevZxKmKCpMJA=;
        b=RhdfPi75GDz4W0Us1XCw1F+urAq2UR0TOEkZ8y+6nFHzY3E4c0QJlusy1o65Ayo1g+
         qjRubdVhMqJNw6ulQNRB6Kpec3CA2pFtbDzkb3mjdVAKGcnZ3FBbr96K76XsQU+mDxgK
         HZir9giH0sMUEZ6xP0DHC8YW7w4XJqzwlPqE6SZDBMeP2WdYWz4YBj64VC1XEAMf5UNn
         G37otyrP2RmZk1QvG2nabawVo8CWI0SSNblxkgF79P0eh4c1puDMHHWrnJZQBlPHpFX3
         UHNAR2VIB/zjj/RGIgSrUf/b9SfNpjVbbLDaB5Q/RdGKxTJj+H24DFiIVPqAnRH+KFE5
         A7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774865292; x=1775470092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOJlHnF0FtnHg5n4sKn9pSKwGW+M2qTevZxKmKCpMJA=;
        b=h8Ia/y+R+01RQq/ZDvC2Bt8oMyN0MaOno1wKkLX6YY+LWOFLVuB3uxqks9QCXljvtu
         zwI5rfNGx8fCwEahv1Zc2K6n45s3pQcwDvq/SgVhtZINfbZHFZcwUdRNUYqwKyweUYFH
         vRk4ONa4/BKSgzYHrNwSplmmuPeJgJz21nwzKkotIvUB0JIP2DVoea5cYkeu1VrkvGbe
         gZUtqjeJ12geAXZ+z8pqoFIF1lGqsv7FvK3ofErKsTSq1pGUfdtu4QEdtrkQiMfWVUil
         6Z9IQfpg9Fsj+eQp64u4Qx2p/Kjcbu84bA9mxHQZ3ApoqCDy4Wlt+/cvu6cNAFSkvAG2
         57YQ==
X-Gm-Message-State: AOJu0YzRTqkLXicPAnlB2KWqSMdpcjELT9Fw14KprRy9JXTmkv2WDWny
	vrEywszDMMEMrumDdjlBvbOp+HrysPF56qn1dKViQhxDVG7jIB0Kik5T
X-Gm-Gg: ATEYQzzR29iq9WVRax0EqQ1aCFjj4kAAX+zXKl6XmVWojcb98GLkvaVLxSBd0eAjJ7b
	D2j/UISsmVWlGX416zkHRFhdbzRsNv810wjpWr9RsyLHhBDZ4G8k45aulF/PORr6Jb0WM32HN+c
	bEHKaE32W/Nu+rHDokGGuxN2tr5jng7Nghps0umT+LcumkdQL3v9WQXHC6PsKOISWt8v26L5dRo
	Nr8FPvJVFUue7t/3v+Zi1ZpHnHaPP51sHEQ6CGj4F+3aIg0JYvwd9e3nTynpZORFYFC4nHF/Vyu
	w9S00PAGVxraSBhy74vtr5CbYv96gh9M+I0yLB+s6QbGIKkOscbRF4K4wSK0otqTUWTPYM0OPuJ
	ZepdjWJAKeoEX12hR5pC6etM1x3T19crv7tPyZy0V5Ivr84gMj9MfUERpbu/YTus3RkikKCTft1
	dDxrfmFTzIIEFaj+9QeBuEj37J+3uHoLRCWPA=
X-Received: by 2002:a05:600c:3e15:b0:486:f9aa:2b57 with SMTP id 5b1f17b1804b1-48727f7be10mr215629695e9.16.1774865292204;
        Mon, 30 Mar 2026 03:08:12 -0700 (PDT)
Received: from krava (37-188-160-213.red.o2.cz. [37.188.160.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48730628efasm277656905e9.5.2026.03.30.03.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 03:08:11 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 30 Mar 2026 12:08:08 +0200
To: Hoyeon Lee <hoyeon.lee@suse.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Shuah Khan <shuah@kernel.org>, Feng Yang <yangfeng@kylinos.cn>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] libbpf: allow address-based single
 kprobe attach
Message-ID: <acpLiCDwAtn8xLjs@krava>
References: <20260329124429.689912-1-hoyeon.lee@suse.com>
 <20260329124429.689912-2-hoyeon.lee@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329124429.689912-2-hoyeon.lee@suse.com>

On Sun, Mar 29, 2026 at 09:43:38PM +0900, Hoyeon Lee wrote:
> bpf_program__attach_kprobe_opts() currently attaches a single kprobe only
> by func_name, with an optional offset. This covers only the symbol-
> based form, not the raw-address form that the kernel already supports
> for both kprobe PMU events and legacy tracefs/debugfs kprobes. Callers
> that already have a target IP still have to drop down to
> perf_event_open() or direct tracefs writes.
> 
> libbpf already exposes address-based attach for kprobe_multi through
> bpf_kprobe_multi_opts.addrs. This commit adds bpf_kprobe_opts.addr so
> that single kprobes can be attached either by func_name + offset or by
> raw address.

curious, is this change just for the api to be complete or you do have
a usecase where you can't use kprobe_multi and need to attach kprobe
by address?

SNIP

>  static void gen_probe_legacy_event_name(char *buf, size_t buf_sz,
> -					const char *name, size_t offset)
> +					const char *name,
> +					uint64_t offset_or_addr)
>  {
>  	static int index = 0;
>  	int i;
>  
> -	snprintf(buf, buf_sz, "libbpf_%u_%d_%s_0x%zx", getpid(),
> -		 __sync_fetch_and_add(&index, 1), name, offset);
> +	snprintf(buf, buf_sz, "libbpf_%u_%d_%s_0x%" PRIx64, getpid(),
> +		 __sync_fetch_and_add(&index, 1), name ?: "addr",
> +		 offset_or_addr);
>  
>  	/* sanitize name in the probe name */
>  	for (i = 0; buf[i]; i++) {
> @@ -11648,13 +11651,28 @@ static void gen_probe_legacy_event_name(char *buf, size_t buf_sz,
>  	}
>  }
>  
> +static void gen_kprobe_target(char *buf, size_t buf_sz, const char *name,
> +			      uint64_t offset_or_addr)
> +{
> +	if (name)
> +		snprintf(buf, buf_sz, "%s+0x%" PRIx64, name, offset_or_addr);
> +	else
> +		snprintf(buf, buf_sz, "0x%" PRIx64, offset_or_addr);
> +}
> +
>  static int add_kprobe_event_legacy(const char *probe_name, bool retprobe,
> -				   const char *kfunc_name, size_t offset)
> +				   const char *kfunc_name,
> +				   uint64_t offset_or_addr)
>  {
> -	return append_to_file(tracefs_kprobe_events(), "%c:%s/%s %s+0x%zx",
> +	char probe_target[128];
> +
> +	gen_kprobe_target(probe_target, sizeof(probe_target), kfunc_name,
> +			  offset_or_addr);
> +

it seems like it'd be easier to get probe_target (via gen_kprobe_target)
in bpf_program__attach_kprobe_opts and pass it down instead of generating
it over and over again

> +	return append_to_file(tracefs_kprobe_events(), "%c:%s/%s %s",
>  			      retprobe ? 'r' : 'p',
>  			      retprobe ? "kretprobes" : "kprobes",
> -			      probe_name, kfunc_name, offset);
> +			      probe_name, probe_target);
>  }
>  
>  static int remove_kprobe_event_legacy(const char *probe_name, bool retprobe)
> @@ -11674,25 +11692,29 @@ static int determine_kprobe_perf_type_legacy(const char *probe_name, bool retpro
>  }
>  
>  static int perf_event_kprobe_open_legacy(const char *probe_name, bool retprobe,
> -					 const char *kfunc_name, size_t offset, int pid)
> +					 const char *kfunc_name,
> +					 uint64_t offset_or_addr, int pid)
>  {
>  	const size_t attr_sz = sizeof(struct perf_event_attr);
>  	struct perf_event_attr attr;
>  	int type, pfd, err;
> +	char probe_target[128];

we need bigger buffer as explained by sashiko [1]

[1] https://sashiko.dev/#/patchset/20260329124429.689912-1-hoyeon.lee%40suse.com

jirka

>  
> -	err = add_kprobe_event_legacy(probe_name, retprobe, kfunc_name, offset);
> +	gen_kprobe_target(probe_target, sizeof(probe_target), kfunc_name,
> +			  offset_or_addr);
> +
> +	err = add_kprobe_event_legacy(probe_name, retprobe, kfunc_name,
> +				      offset_or_addr);
>  	if (err < 0) {
> -		pr_warn("failed to add legacy kprobe event for '%s+0x%zx': %s\n",
> -			kfunc_name, offset,
> -			errstr(err));
> +		pr_warn("failed to add legacy kprobe event for '%s': %s\n",
> +			probe_target, errstr(err));
>  		return err;
>  	}
>  	type = determine_kprobe_perf_type_legacy(probe_name, retprobe);
>  	if (type < 0) {
>  		err = type;
> -		pr_warn("failed to determine legacy kprobe event id for '%s+0x%zx': %s\n",
> -			kfunc_name, offset,
> -			errstr(err));
> +		pr_warn("failed to determine legacy kprobe event id for '%s': %s\n",
> +			probe_target, errstr(err));
>  		goto err_clean_legacy;
>  	}
>  

SNIP
