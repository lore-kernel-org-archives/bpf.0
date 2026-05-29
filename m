Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A451351C0D
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780050216; cv=none; b=tWBxtinFr9bXQpW+pRTNjTpZVeBX9CFJ8nFO3GICMCJP4Op3aUiNeV3ajgumhVKO5PRP3EigxFBge/VcO3hs+l2AC79qeVI8ka5DveNb+R+A/aSJyrJk/d4tp1KZfWIIJNkhJv9loNdpiHZYiKGeGWRU3Am4LGe92IgpmOfVnG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780050216; c=relaxed/simple;
	bh=f2o44IsMingbtMQeJmm+WHTiqFuJHjYDIYuXGIS+tng=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIMHJqQDxsKYeBnkOW0RWkGe56I8ikKJVmnNagXaWcaHKzteOqh9xQP+B25nkJ0BzKfBnyA3xEwTULzFqbitHXvsJZK4E0VtDUFhEOY9LFHmzXhg+gHba895AvCY2FSFs0V8EsYc3NgKFCJBrol1eEatkS4GVJhUnLZ1HTpp2iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGts/4y8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGts/4y8"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4903d5c67bfso44565225e9.1
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 03:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780050214; x=1780655014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2FG+cH7jgYGXNPa08asvaKTrwZCoqAgTJr6HnWeF9pI=;
        b=dGts/4y8KhjSltrM+bXX8AxOPPUYxSacj1kock7v+o85zaWMBk+8pr19bCuny5vxfF
         K03nUvrkc4yH3bKjr7F0Av6yAHVRtxGL87+AsdYTraWj/Vl+3HNm+h1t9VyyTqxASXTA
         GSN5iIQ2hKgS20B5fz43hNuW7gMrqVEBrzdq9+eEAgcIfkoy1WqdaMBRe/MSLW8vOYJu
         qQVqt2JPJTONPuK34MA7S9qa/DyQU01ShirjDYRhWKkLDeIW48hHSUXsatLGT1RHFxde
         UET3QqFY3Pf50Q88HwH+khXRac0uKvT+VpbxeswzpgOKHL37I9xp1+D4lqWH0DitrFOk
         3xTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780050214; x=1780655014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2FG+cH7jgYGXNPa08asvaKTrwZCoqAgTJr6HnWeF9pI=;
        b=hPE6pfkZskpA7QNBms0g3LCYg9PTS+uwb4u3uDxtSSzeNanvP/rzW2yJ9/v+Zgz8P8
         Ro51jfbz/oQU/hx3GGXNljZGI/4agTUX3ioyvMZIX4OSbIKDkwY2oA9hP6rVutDYepB4
         Cx3m8F8YD6DJ7Ui4kEEd+S6QnLUwFKsJnS1pq4GTSMMz5ObAs9eyC8/CihR7PCFmzYa+
         mKhPWlJtV6k0DJp76KRzGcq5IH9d9FLQiWkQdADVYgG+WfSV8sB7do4E3SNPQyv34mBl
         mjT4lFUePBEVmquG0HowcqZbX1nWg3mlUmWSPdHd4+q1M81lHhe288Xx6BTNTBvXx7ZO
         rk5g==
X-Gm-Message-State: AOJu0Yy1mJkSkmqkg2/XQgMapuXiWcPunuZtyY2+PbO/Z+QZ0StVlaqb
	BbPv7392/8IKs5LnNsE8BJR05KNE1Sx3BbnlRe0m1SttG1l20eMYgwMlVgFJGA==
X-Gm-Gg: Acq92OFQPoGQK7SWmzhf5LqWq58awQI+avHp6+cS5AMvYP008oTqwdycagTCI8O0CIc
	ZTxoGN+pUw9js7wdjbvXoCxNi0IXAVZ69aAx8hmM0ekTYJ6ZykkLuM2kyFhTKM0grxyxrPFUpDQ
	2krs8+9pKlY51jCTez/5D61e1aFAxDEBGpmq7EM3EaKm5XuZznwgDM/Ht+a3QNXRmT2a/4hbQV1
	YngiqfRWwn6R+iepYM19cRrpDmZDGUmU675gUj0UQLuQxBx7OLTPEvHgsWYhx/Q/cg2vfM4KNN7
	JVNl7oPuy06NPdHg56lIl51Pr1kvVgmjPq/SvYf/E3YCRHKt6Ll3WOrpCOA2cRIioXYP8BHiADL
	zcpvlEj0lM2/NwSigtyfKGdU+sHrna7rsYH6yzFPZW0JwN1pRAf6GeZZrj+T8hUb8cEDDibnT5b
	lFw6Npf46tjqBSJVMmFXzwgs6JRw==
X-Received: by 2002:a05:600c:34d4:b0:490:9e5b:9e31 with SMTP id 5b1f17b1804b1-4909e5ba0c2mr31657945e9.0.1780050213453;
        Fri, 29 May 2026 03:23:33 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d7002e8sm42434285e9.15.2026.05.29.03.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 03:23:33 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 29 May 2026 12:23:31 +0200
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH RFC bpf-next v3 4/6] bpf: report hot simulated callchains
 when 1M instructions limit is met
Message-ID: <ahlpI7sRJt1FQdYg@krava>
References: <20260527-better-1m-reporting-v3-0-b3ede0588a75@gmail.com>
 <20260527-better-1m-reporting-v3-4-b3ede0588a75@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527-better-1m-reporting-v3-4-b3ede0588a75@gmail.com>

On Wed, May 27, 2026 at 12:29:52AM -0700, Eduard Zingerman wrote:

SNIP

> +
>  static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
>  {
>  	int err;
> @@ -17381,6 +17527,7 @@ static int do_check(struct bpf_verifier_env *env)
>  		insn_aux = &env->insn_aux_data[env->insn_idx];
>  
>  		if (++env->insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
> +			print_hotspots(env);

hi,
this is really cool feature, I've already used it to fix issues :)

Would it be possible to make this configurable? like to be able
to get this output for program that passed and display more than
3 hottest callchains?

thanks,
jirka


>  			verbose(env,
>  				"BPF program is too large. Processed %d insn\n",
>  				env->insn_processed);
> @@ -17390,6 +17537,12 @@ static int do_check(struct bpf_verifier_env *env)
>  		state->last_insn_idx = env->prev_insn_idx;
>  		state->insn_idx = env->insn_idx;
>  
> +		if (bpf_is_force_checkpoint(env, env->insn_idx) || insn_aux->loop) {
> +			err = update_callchain_profile(env, state);
> +			if (err)
> +				return err;
> +		}
> +
>  		if (bpf_is_prune_point(env, env->insn_idx)) {
>  			err = bpf_is_state_visited(env, env->insn_idx);
>  			if (err < 0)
> @@ -19673,6 +19826,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
>  		return -ENOMEM;
>  
>  	env->bt.env = env;
> +	hash_init(env->callchain_htab);
>  
>  	len = (*prog)->len;
>  	env->insn_aux_data =
> @@ -19945,6 +20099,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
>  	bpf_clear_insn_aux_data(env, 0, env->prog->len);
>  	vfree(env->insn_aux_data);
>  err_free_env:
> +	free_callchain_profile(env);
>  	bpf_stack_liveness_free(env);
>  	kvfree(env->cfg.insn_postorder);
>  	kvfree(env->scc_info);
> 
> -- 
> 2.53.0
> 
