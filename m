Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFF23EDADA
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779974025; cv=none; b=qc80/YFIoDbCpquVL129uhhSWI+eOrtMiMLzzjxsKBn9D8U5eV9pkcMh0B3S7ugWkGJk8pNSVaHUS3We69Kh3tlbLdn8z+vtknMEcu85RidyZcJ8nPjcaaJ0d3bV9yOR99vT8ujQXbw3PoRnf/QcJr0ECw2mV0dhP0WXseklt3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779974025; c=relaxed/simple;
	bh=iNaI+nFEr8C9DO/sPmeOA7cPTZbWkxfBn4enxKJCerc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jncHUC+B/lYN0kbeGhzEGdNh0i/q5oqdVpgBp4/QAPxvTVp1uVzg+7QREiYvK045yqnpamZHsnEWN88ykgTkIRbetBsEqG0jK07vByAheASdeVhtFShyKyfH+fpfJRj8LZt0EiCQoZtIK2EET4V1oYfm6Nrw08HXJiigV4aPp8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lq5+KUCt; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lq5+KUCt"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-44ccbd3290aso11074199f8f.2
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 06:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779974022; x=1780578822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PVPqbiZ2BmYnKxbQOHUMOlkHdxsA7Q8DniMbt0NdK3Y=;
        b=Lq5+KUCtydK/IKDkyDJ/V0bQg3/OcSEIhVuhWvkVmGU2Qw1UleMw2RuAscUsY7oDzl
         ICMqQzF6MnnlO30GjdpRbEbj6Ei3aiXzEnMnQpQKNy242RY0yAusrD1tuaPOm+kDgrIK
         9Muk8NV5DgVizIoLXjj+FQJs7fmHrNUdjnYOj5ZprhArYX4vqGzMTPEC0h5tEoTnLIgB
         PGu9HlF52bh1u9IqIkCASCncYo94ka4oiYngYknTmN/scbT1MT60ZciSxHvfHNjj0pAi
         kePT1YticKtSCkA/uyMq2D/Jf1g9BjbUv9BGRGJOLPwDO0lSscD3ThAP7ecxpu7JHKY0
         K0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779974022; x=1780578822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVPqbiZ2BmYnKxbQOHUMOlkHdxsA7Q8DniMbt0NdK3Y=;
        b=WqV9w/Z9flvyZSSJ1BekZOJRxSlg+/1xA3lv+ep3tm8dsSIhzmdwlLPIrq18FJsI/3
         cxRI5BiB5PBniEiRgFvtMEPhKELOThNdqAe0Z5iY+Rv53hh2lu4QWS1xG+JvcrngGMQo
         oBqPM/sBDpH/BOvdwnFQItR36A870mHKqkjxlcfknpvSYccQaMVcSZNUvmpoEDRyM40q
         MUjco3zD7ZKuwfhl+2mpECQRYeyR+v/GLJJYx7bxvTGv9cSAaVk+AT8NovE4tJ4CZu+M
         TjOtzMYU4A6gN/aWioGPWoyz+sXarWyKNZqofp0H6lQ6jPvbYumD2wBAboC2TByjoOh7
         M7ug==
X-Forwarded-Encrypted: i=1; AFNElJ8Ym5XpVI5dJ2Ci3JDZRLCzJiSwNH21BwHJOxMq+y27BaJ2dqAAhAbPfkX6zvQHFY1uJMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq5/Ddzx2I6sfl8PFnQ6x5+3BwuM7xAjark7j1To6wFT44XPck
	pRhFE7+xIfNVUKbguNKC/2FmZ5vFkfB4XS1joQEk5BC9UGvOAPXqvQ4x
X-Gm-Gg: Acq92OErYpfWsfr+7sK61oQVEL54mGNYzpawVP14Z3r6XBn648p2tBQv62hBYBhNLmQ
	HWhS4g4jFOq6kY0ml2pHNZsH4wqEMD2Uu21UZq1iZbhqIraMPGyUM8N6y808+atfaQLloW5iiVl
	BYEHRIhvFrikzV4kMDSh1IT1J8bxf6rBgmgIX8mfMb+HsrRfs1LgjVrIjfCu2BH3OeKYwU/YztG
	AWGJ9uhcFq9dqJrJrPohi5lBwZVmWQSM31H+iUVlQXg44zQ2KvjrWCN7WYdBQLfCDQfOfNgqk8P
	EQf2estdX7qGXljz+cRKURq5e0LzehKeGdV4Txw4GTrkjQOMsFk9LtdchcA3k2YwkH7wWdLXCU/
	/tKXMpoVcPbWVCM9g0KxFaqtWwROeO29rYl0kaEedWXyXOAIRmQ74zM7aF8OsHJbYF4UcM7I99n
	CixlbmPtJj+1buMVfbMdrxF/D0yQ==
X-Received: by 2002:a5d:6f01:0:b0:45e:e95c:8106 with SMTP id ffacd0b85a97d-45ee95c81f4mr3625956f8f.13.1779974022153;
        Thu, 28 May 2026 06:13:42 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5584b8sm12912642f8f.11.2026.05.28.06.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 06:13:41 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 28 May 2026 15:13:39 +0200
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv6 bpf-next 10/29] bpf: Add multi tracing attach types
Message-ID: <ahg_gxSxmDNhoGoA@krava>
References: <20260527113951.46265-11-jolsa@kernel.org>
 <23ab5817f619274a252b35119e760817c383e3c20f9ce9facccbf4b4fec9dd58@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23ab5817f619274a252b35119e760817c383e3c20f9ce9facccbf4b4fec9dd58@mail.kernel.org>

On Wed, May 27, 2026 at 12:59:43PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 435ae6efe961..27ad0c265c95 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -41,6 +41,7 @@
> >  #include <linux/overflow.h>
> >  #include <linux/cookie.h>
> >  #include <linux/verification.h>
> > +#include <linux/btf_ids.h>
> >
> >  #include <net/netfilter/nf_bpf_link.h>
> >  #include <net/netkit.h>
> 
> [ ... ]
> 
> > @@ -2904,6 +2914,11 @@ static int bpf_prog_mark_insn_arrays_ready(struct bpf_prog *prog)
> >  	return 0;
> >  }
> >
> > +extern int bpf_multi_func(void);
> > +int __init __used bpf_multi_func(void) { return 0; }
> 
> The signature change from v5 to v6 creates a potential issue. In v5,
> bpf_multi_func had 6 arguments (matching the initial verifier setup):
> 
>   int __init __used bpf_multi_func(u64 r1, u64 r2, u64 r3,
>                                    u64 r4, u64 r5, u64 r6)
> 
> Now it has no arguments. The Sashiko AI review in v5 identified that
> context array bounds checking could fail when bpf_multi_func's argument
> count doesn't match the attached function's argument count, and the
> author acknowledged the need to disable direct context access.
> 
> Since the initial verification happens against bpf_multi_func (which now
> has 0 arguments), but the verifier previously allowed direct ctx[0-5]
> accesses based on the 6-argument version, is there still a path where
> direct context accesses could be allowed? If so, would accessing ctx[0]
> on a function with 0 arguments lead to out-of-bounds kernel stack reads?
> 
> The earlier review suggested either:
>   (a) explicitly disabling direct memory accesses to the ctx array for
>       FENTRY_MULTI and FEXIT_MULTI, or
>   (b) enforcing the use of bounds-checked helpers like bpf_get_func_arg()
> 
> Was this implemented somewhere in the patch series?

it's implemented through bpf_multi_func without any arguments,
then verifier won't allow any access to any argument,
including ctx[0], which is 1st argument

jirka

> 
> > +
> > +BTF_ID_LIST_GLOBAL_SINGLE(bpf_multi_func_btf_id, func, bpf_multi_func)
> 
> [ ... ]
> 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index c8d980fdd709..58450cb88beb 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> 
> [ ... ]
> 
> > @@ -18837,6 +18839,11 @@ static int check_attach_modify_return(unsigned long addr, const char *func_name)
> >
> >  #endif /* CONFIG_FUNCTION_ERROR_INJECTION */
> >
> > +static bool is_tracing_multi_id(const struct bpf_prog *prog, u32 btf_id)
> > +{
> > +	return is_tracing_multi(prog->expected_attach_type) && bpf_multi_func_btf_id[0] == btf_id;
> > +}
> > +
> >  int bpf_check_attach_target(struct bpf_verifier_log *log,
> >  			    const struct bpf_prog *prog,
> >  			    const struct bpf_prog *tgt_prog,
> 
> [ ... ]
> 
> > @@ -19094,7 +19105,18 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> >  		if (ret < 0)
> >  			return ret;
> >
> > -		if (tgt_prog) {
> > +		/*
> > +		 * *.multi programs don't need an address during program
> > +		 * verification, we just take the module ref if needed.
> > +		 */
> > +		if (is_tracing_multi_id(prog, btf_id)) {
> > +			if (btf_is_module(btf)) {
> > +				mod = btf_try_get_module(btf);
> > +				if (!mod)
> > +					return -ENOENT;
> > +			}
> > +			addr = 0;
> > +		} else if (tgt_prog) {
> >  			if (subprog == 0)
> >  				addr = (long) tgt_prog->bpf_func;
> >  			else
> 
> [ ... ]
> 
> > @@ -19122,6 +19144,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> >  			ret = -EINVAL;
> >  			switch (prog->type) {
> >  			case BPF_PROG_TYPE_TRACING:
> > +				/* *.multi sleepable programs will pass initial sleepable check,
> > +				 * the actual attached btf ids are checked later during the link
> > +				 * attachment.
> > +				 */
> > +				if (is_tracing_multi_id(prog, btf_id))
> > +					ret = 0;
> >  				if (!check_attach_sleepable(btf_id, addr, tname))
> >  					ret = 0;
> 
> The multi types are not included in btf_validate_prog_ctx_type() in
> kernel/bpf/btf.c. That function validates which attach types allow u64*
> as their ctx parameter:
> 
> kernel/bpf/btf.c:btf_validate_prog_ctx_type() {
>     case BPF_TRACE_FENTRY:
>     case BPF_TRACE_FEXIT:
>     case BPF_MODIFY_RETURN:
>         ...
> }
> 
> Since BPF_TRACE_FENTRY_MULTI and BPF_TRACE_FEXIT_MULTI also use u64*
> context, do they need to be added to that validation list? Or if direct
> context access should be disabled for multi types (per the earlier
> review concern), should they be handled with special rejection logic?
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26509800686

