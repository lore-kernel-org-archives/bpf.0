Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC357210E7
	for <bpf@vger.kernel.org>; Sun, 17 Mar 2024 22:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710714605; cv=none; b=s3Oof02MQLF+LTSGs2KycxWFUwyUjUB1xjlVaQ6uHcrto7/T1HkgSdNhlqnqKGTvWujjAX2g7HbNzUghB1YgTZ1UTMGJJJte/sTyCzVmRuZysoKg8DxvLToRW5bn/CJy3siJrBufQ9e7Q3kD0m8AEXq86K/8zAt5h3dkLARDooc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710714605; c=relaxed/simple;
	bh=6cFjJ1qh3Gc61IwRI+3epsGota0KZSdQBUCoVxtSEr0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTra/meqeOaUVmG0TTPWOD9n/1CP/Isj2a3i23nYJbwVABtJZothZHd8HHWcqgYqs+IIMdKKJ1wGTPj3rwx66CS6lDEU5Mi6xfT/TkJ9vm7QJfQN3nLszAPb817bCCl9oj6YYbdsmSh/aURNmb1Wh8+sPp8+Ic9rFO7BJfRpowU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQIVdXOT; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQIVdXOT"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33ec7e1d542so1984363f8f.1
        for <bpf@vger.kernel.org>; Sun, 17 Mar 2024 15:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710714602; x=1711319402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uB/mOm4IofnGCy3YEL2evJ5+pTSXLoUDqjY0T9kULbk=;
        b=iQIVdXOTWzrrzthefh/4d6+8eWvs2ozaSon7WdBikrjNJUGTyBN+7XW/vUlWkVM6Pm
         5OxpCbwRMINCRMsy8QK7LSDQckyNBSBlwEx9OyjuKr/TYKO2iTzZC6XQQGvdWNHdF7EB
         jpUN1HsRGpxJ+vIGMtUBrK2IsmsKi77UDtLOCIey5rW2j2mSBNXxUYpFxrnlYLZxIniZ
         gZxD9ck63lT65X4s+KJd2ZV0w0T9MLET6stn3TWMOg2GK+g5dypCOX1obi+v8bXt/RVl
         MByLxu8WczFMQ6rK0Op0mNXKynLClDZ9gX6ePPcNJVzWjaEO9sLyDaOOu11FNf64Dlr0
         VOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710714602; x=1711319402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uB/mOm4IofnGCy3YEL2evJ5+pTSXLoUDqjY0T9kULbk=;
        b=W6PTvQ1ImldJ/sdXw9aOKsoHazkWXaq+XTqo7R4oYaI+Hvr5QP9bbsLRMWojMNMMLr
         nUSWEsdIMifIJjEdZ+Vg8Kk7+70Lt8v7V1EDfDlwpiJ48FTs1oWqQDpLSr5TiBYU5Lmz
         2K73zKl4I8xD5DRq7QiftDxySpLFdbDnB+6ci4pP8PRkqu6WhWQF/GHi20SEpB+lv6kd
         0i24MXXD/BQ5igtlhmdP0KpFWTRSNH5uRnrkg7lH20l3uh8KS8/gCCdghSA35yKsBpjP
         bT2BB96IZIhr5BBJrDjkyNB9a856DTw1FPs1JupM1q/4C8CNGZrrZNUjNAwtoarsl3nc
         +yBw==
X-Gm-Message-State: AOJu0Yw+Iu8pwmcARclxLsIpIFK7ApGjNCG2QPmYvZnIPfy+64SwSvCM
	0ZZksH5kO9VHyN3AyTPYhDIQjkHLaKfbGlT+OaiULfqW8zRhwdKn
X-Google-Smtp-Source: AGHT+IFh9jZDwd3Ba9FjAVtDhbduy6n5wkB/6gsJl3HEtimTtUtZ8ZzdwGfBbjkcz8u8lTclV6VXAA==
X-Received: by 2002:a5d:5750:0:b0:33e:34aa:d78a with SMTP id q16-20020a5d5750000000b0033e34aad78amr7295017wrw.8.1710714601797;
        Sun, 17 Mar 2024 15:30:01 -0700 (PDT)
Received: from krava ([83.240.63.214])
        by smtp.gmail.com with ESMTPSA id l21-20020a056000023500b0033ec312cd8asm8409441wrz.33.2024.03.17.15.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 15:30:01 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 17 Mar 2024 23:29:59 +0100
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 3/5] bpf: support BPF cookie in raw tracepoint
 (raw_tp, tp_btf) programs
Message-ID: <Zfdu5xIO0ONUCMGr@krava>
References: <20240315204524.967664-1-andrii@kernel.org>
 <20240315204524.967664-4-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315204524.967664-4-andrii@kernel.org>

On Fri, Mar 15, 2024 at 01:45:22PM -0700, Andrii Nakryiko wrote:
> Wire up BPF cookie for raw tracepoint programs (both BTF and non-BTF
> aware variants). This brings them up to part w.r.t. BPF cookie usage
> with classic tracepoint and fentry/fexit programs.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf.h            |  1 +
>  include/uapi/linux/bpf.h       |  1 +
>  kernel/bpf/syscall.c           | 13 +++++++++----
>  kernel/trace/bpf_trace.c       | 13 +++++++++++++
>  tools/include/uapi/linux/bpf.h |  1 +
>  5 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f8a09a742e38..32dde6ce7e92 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1611,6 +1611,7 @@ struct bpf_tracing_link {
>  struct bpf_raw_tp_link {
>  	struct bpf_link link;
>  	struct bpf_raw_event_map *btp;
> +	u64 cookie;
>  };
>  
>  struct bpf_link_primer {
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 3c42b9f1bada..bf80b614c4db 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1664,6 +1664,7 @@ union bpf_attr {
>  	struct { /* anonymous struct used by BPF_RAW_TRACEPOINT_OPEN command */
>  		__u64 name;
>  		__u32 prog_fd;

should we add __u32 :32; in here ?

jirka

> +		__aligned_u64 cookie;
>  	} raw_tracepoint;
>  
>  	struct { /* anonymous struct for BPF_BTF_LOAD */
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 1cb4c3809af4..e44c276e8617 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3774,7 +3774,7 @@ static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *pro
>  #endif /* CONFIG_PERF_EVENTS */
>  
>  static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
> -				  const char __user *user_tp_name)
> +				  const char __user *user_tp_name, u64 cookie)
>  {
>  	struct bpf_link_primer link_primer;
>  	struct bpf_raw_tp_link *link;
> @@ -3821,6 +3821,7 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
>  	bpf_link_init(&link->link, BPF_LINK_TYPE_RAW_TRACEPOINT,
>  		      &bpf_raw_tp_link_lops, prog);
>  	link->btp = btp;
> +	link->cookie = cookie;
>  
>  	err = bpf_link_prime(&link->link, &link_primer);
>  	if (err) {
> @@ -3841,11 +3842,13 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
>  	return err;
>  }
>  
> -#define BPF_RAW_TRACEPOINT_OPEN_LAST_FIELD raw_tracepoint.prog_fd
> +#define BPF_RAW_TRACEPOINT_OPEN_LAST_FIELD raw_tracepoint.cookie
>  
>  static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
>  {
>  	struct bpf_prog *prog;
> +	void __user *tp_name;
> +	__u64 cookie;
>  	int fd;
>  
>  	if (CHECK_ATTR(BPF_RAW_TRACEPOINT_OPEN))
> @@ -3855,7 +3858,9 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
>  	if (IS_ERR(prog))
>  		return PTR_ERR(prog);
>  
> -	fd = bpf_raw_tp_link_attach(prog, u64_to_user_ptr(attr->raw_tracepoint.name));
> +	tp_name = u64_to_user_ptr(attr->raw_tracepoint.name);
> +	cookie = attr->raw_tracepoint.cookie;
> +	fd = bpf_raw_tp_link_attach(prog, tp_name, cookie);
>  	if (fd < 0)
>  		bpf_prog_put(prog);
>  	return fd;
> @@ -5193,7 +5198,7 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
>  			goto out;
>  		}
>  		if (prog->expected_attach_type == BPF_TRACE_RAW_TP)
> -			ret = bpf_raw_tp_link_attach(prog, NULL);
> +			ret = bpf_raw_tp_link_attach(prog, NULL, attr->link_create.tracing.cookie);
>  		else if (prog->expected_attach_type == BPF_TRACE_ITER)
>  			ret = bpf_iter_link_attach(attr, uattr, prog);
>  		else if (prog->expected_attach_type == BPF_LSM_CGROUP)
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index ed4c3610b5b5..f9b217bf9f32 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2008,6 +2008,8 @@ raw_tp_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  		return &bpf_get_stackid_proto_raw_tp;
>  	case BPF_FUNC_get_stack:
>  		return &bpf_get_stack_proto_raw_tp;
> +	case BPF_FUNC_get_attach_cookie:
> +		return &bpf_get_attach_cookie_proto_tracing;
>  	default:
>  		return bpf_tracing_func_proto(func_id, prog);
>  	}
> @@ -2070,6 +2072,9 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  	case BPF_FUNC_get_func_arg_cnt:
>  		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_cnt_proto : NULL;
>  	case BPF_FUNC_get_attach_cookie:
> +		if (prog->type == BPF_PROG_TYPE_TRACING &&
> +		    prog->expected_attach_type == BPF_TRACE_RAW_TP)
> +			return &bpf_get_attach_cookie_proto_tracing;
>  		return bpf_prog_has_trampoline(prog) ? &bpf_get_attach_cookie_proto_tracing : NULL;
>  	default:
>  		fn = raw_tp_prog_func_proto(func_id, prog);
> @@ -2373,15 +2378,23 @@ static __always_inline
>  void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
>  {
>  	struct bpf_prog *prog = link->link.prog;
> +	struct bpf_run_ctx *old_run_ctx;
> +	struct bpf_trace_run_ctx run_ctx;
>  
>  	cant_sleep();
>  	if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
>  		bpf_prog_inc_misses_counter(prog);
>  		goto out;
>  	}
> +
> +	run_ctx.bpf_cookie = link->cookie;
> +	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
> +
>  	rcu_read_lock();
>  	(void) bpf_prog_run(prog, args);
>  	rcu_read_unlock();
> +
> +	bpf_reset_run_ctx(old_run_ctx);
>  out:
>  	this_cpu_dec(*(prog->active));
>  }
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 3c42b9f1bada..bf80b614c4db 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1664,6 +1664,7 @@ union bpf_attr {
>  	struct { /* anonymous struct used by BPF_RAW_TRACEPOINT_OPEN command */
>  		__u64 name;
>  		__u32 prog_fd;
> +		__aligned_u64 cookie;
>  	} raw_tracepoint;
>  
>  	struct { /* anonymous struct for BPF_BTF_LOAD */
> -- 
> 2.43.0
> 
> 
