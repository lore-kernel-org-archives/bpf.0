Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18893329E6F
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775654487; cv=none; b=Y4UzSr0qa9UMeCKxfY3OhofEpXZM0W6CJ8DwvPtCGyH7uSoNOiNbLwA5K0WgIYzldXnxgMN17VDgdQ1qZWLB27vsFTAEBAl5EkmMWrC6Q3RIc4b2+dl/wH4zW/ss+DX+laVwi6BfNZ0YIdFyVp+mbkc7ctHwIDzHQoJsPR+gJro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775654487; c=relaxed/simple;
	bh=VP3NcXff/+TYc44f6hOSBUWnA6Frgpc2AoF4mlLCtOc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzkeKozBGpzs3cBJIQKDtUS2MM+SckPrjiA7rTd25/GpoVtg+E2P05911LvD9kDOrvPgPQY/fJZDGaBYqdHsKw6NAIZB9fiDwKWQodbYG3M0LUYY8Qd2JlFNJM7OtO7ScXvaS9FKyg33o8Y2vMo+6ocegJJqCKT/AzrUKAAOHf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INaW3MxH; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INaW3MxH"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488ba6366a7so28244505e9.0
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 06:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775654482; x=1776259282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S6gNsg/Hs4yDzHq+ohAAgGwtWqgWEZ88+2YXJM2hzyc=;
        b=INaW3MxHtubbhLwuVv726EV/4BXfOXM0kjPc7n1JgDGHj5b0Vses3mMSg3C+QTIBOF
         RJGkHC4d6osqrbuZkEGvLEaMyqLn7e27/EF2N4UxuMm2D/CqQ041NJgP+1ErrBLCRnrq
         9pjGpFKl9TboIf5DMZLaL/AJZHHzH0HwGGGwvRcE9rV6T2L2ZttyJx2TdN8z4es+fDI3
         rK6L7AeSSzuTQnn7ez81gAeK/GhDZn1Y2eOf95Lt8hwBrcG4fjA5BFyN+eZMcWulbKFA
         PX2GsOO5blnlr5QY5FgHKRYuge7wy0zpsbjGpM4c578nqSfE0SfmfQccN0CFATuYeHx8
         ++nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775654482; x=1776259282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6gNsg/Hs4yDzHq+ohAAgGwtWqgWEZ88+2YXJM2hzyc=;
        b=W1PvL5CSauOmTkLt+yleYyQsbTWEz3nMAtArhVV4uiFE9m0EwZ5l8taO1CPOk6hr+B
         vEmzr1UGlPKi5zSRuncrZyenzQccd6YPgbOin5gjF8ODKK7rafA1GHn9/MmsvnHJTzc4
         MXyQ9Y97RTGaLE18LMrnQCaBV1o5hKdTf1sbcaI+t2eGtXHue6B//lRd1dqPwU6oJxLo
         qiIfFKUkb16W5Xo99GfbqHmB8wpCfDq5VVPXrpBDlZ9JCfXNGIP/W11kF3L/zZTsnVTg
         4bIfMINCbZPPqpAZggjhUcq8dZ/fjEF77fhUJx03FK9l/VUVylzjNTIb8x5W1cqy0mhk
         LU8A==
X-Forwarded-Encrypted: i=1; AJvYcCWHQrug6bcJqQ7rgMXqfPm+ATuySDRjjNfcYPLyJUZ4LhxGwgUgKFJ/UxBy//VxYjSly8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMEDxVmslykPlI8JCuMutA+RZwU1kyViwvFlIDwVqQjfNWFqqC
	tltp19xnWcCCWI/j1SrlrlCynjK5S9n4dHBGMNeUGEwnuSvoQ24ZBGTZ
X-Gm-Gg: AeBDiev9hbLDqUFeZgqzE9rD1PVrDLI0KO5b7mWh18AtHl0eggX+Hf8xkdezQcRca3N
	0ovqZzPAN6SrVtYqei9PZeFniJpU7psfKrkDEBaNmcngUroDf4qRF9024kzXsXPmqNxKB0biCTk
	oCeZdpVunndLtKoDRbpI45tHRJht1PbyFXdaHmf2optWV4mDuf2NPeQPnZ/fjV0AwF+wHcCc+Tm
	/paBvviIqM9abfFX1dUx+RWcQuNTmUoxlBG+VivTnR37i9/a6ke00zAduK0B7NOa95qalUhl5QP
	EPpRxwK1HTu1vlGEXbzUfuDKr/TBGnyWL6EWlxZuVUPgUrieY2O3LDZvoUbVSKDRZF0Al57nRLf
	jdh6LzN29ubY4P85g+siCCr+HcYG9ZBUbr1iHBhZF+thwoxKknL/HZN4zzztV6wBcrUVMP79SJm
	GEJuupzNPYDA1Xvwc=
X-Received: by 2002:a05:600c:3b23:b0:488:869c:edaf with SMTP id 5b1f17b1804b1-488996df052mr261117285e9.8.1775654481947;
        Wed, 08 Apr 2026 06:21:21 -0700 (PDT)
Received: from krava ([2a00:102a:5031:5a39:87ca:af14:10da:98b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488b6ff70bcsm363448385e9.14.2026.04.08.06.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 06:21:21 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 8 Apr 2026 15:21:14 +0200
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	shuah@kernel.org, emil@etsalapatis.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/3] bpf: add missing fsession to the
 verifier log
Message-ID: <adZWStMinOeunjSH@krava>
References: <20260408062109.386083-1-dongml2@chinatelecom.cn>
 <20260408062109.386083-2-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408062109.386083-2-dongml2@chinatelecom.cn>

On Wed, Apr 08, 2026 at 02:21:07PM +0800, Menglong Dong wrote:
> The fsession attach type is missed in the verifier log in
> check_get_func_ip(), bpf_check_attach_target() and check_attach_btf_id().
> Update them to make the verifier log proper. Meanwhile, update the
> corresponding selftests.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> Acked-by: Leon Hwang <leon.hwang@linux.dev>
> ---
> v2:
> - add a missing FSESSION in bpf_check_attach_target()
> ---
>  kernel/bpf/verifier.c                               | 10 +++++-----
>  tools/testing/selftests/bpf/prog_tests/exceptions.c |  8 ++++----
>  tools/testing/selftests/bpf/verifier/sleepable.c    |  2 +-
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 594260c1f382..beb660b4c3ec 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11757,7 +11757,7 @@ static int check_get_func_ip(struct bpf_verifier_env *env)
>  
>  	if (type == BPF_PROG_TYPE_TRACING) {
>  		if (!bpf_prog_has_trampoline(env->prog)) {
> -			verbose(env, "func %s#%d supported only for fentry/fexit/fmod_ret programs\n",
> +			verbose(env, "func %s#%d supported only for fentry/fexit/fsession/fmod_ret programs\n",
>  				func_id_name(func_id), func_id);
>  			return -ENOTSUPP;
>  		}
> @@ -25561,7 +25561,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  	btf = tgt_prog ? tgt_prog->aux->btf : prog->aux->attach_btf;
>  	if (!btf) {
>  		bpf_log(log,
> -			"FENTRY/FEXIT program can only be attached to another program annotated with BTF\n");
> +			"FENTRY/FEXIT/FSESSION program can only be attached to another program annotated with BTF\n");

I wonder this should say 'Tracing program...' instead,
we have other tracing types not covered in this error

jirka

>  		return -EINVAL;
>  	}
>  	t = btf_type_by_id(btf, btf_id);
> @@ -25597,7 +25597,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  		if (aux->func && aux->func[subprog]->aux->exception_cb) {
>  			bpf_log(log,
>  				"%s programs cannot attach to exception callback\n",
> -				prog_extension ? "Extension" : "FENTRY/FEXIT");
> +				prog_extension ? "Extension" : "FENTRY/FEXIT/FSESSION");
>  			return -EINVAL;
>  		}
>  		conservative = aux->func_info_aux[subprog].unreliable;
> @@ -25686,7 +25686,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  	case BPF_TRACE_RAW_TP:
>  		if (tgt_prog) {
>  			bpf_log(log,
> -				"Only FENTRY/FEXIT progs are attachable to another BPF prog\n");
> +				"Only FENTRY/FEXIT/FSESSION progs are attachable to another BPF prog\n");
>  			return -EINVAL;
>  		}
>  		if (!btf_type_is_typedef(t)) {
> @@ -25952,7 +25952,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
>  	}
>  
>  	if (prog->sleepable && !can_be_sleepable(prog)) {
> -		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable\n");
> +		verbose(env, "Only fentry/fexit/fsession/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable\n");
>  		return -EINVAL;
>  	}
>  
> diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions.c b/tools/testing/selftests/bpf/prog_tests/exceptions.c
> index 84ab73e08b0e..94a62fcd4543 100644
> --- a/tools/testing/selftests/bpf/prog_tests/exceptions.c
> +++ b/tools/testing/selftests/bpf/prog_tests/exceptions.c
> @@ -128,7 +128,7 @@ static void test_exceptions_success(void)
>  				       bpf_program__fd(skel->progs.exception_ext_mod_cb_runtime),
>  				       "exception_cb_mod"), "set_attach_target"))
>  				goto done;
> -		}), "FENTRY/FEXIT programs cannot attach to exception callback", 0);
> +		}), "FENTRY/FEXIT/FSESSION programs cannot attach to exception callback", 0);
>  
>  	if (test__start_subtest("throwing fentry -> exception_cb"))
>  		RUN_EXT(-EINVAL, true, ({
> @@ -138,7 +138,7 @@ static void test_exceptions_success(void)
>  				       bpf_program__fd(skel->progs.exception_ext_mod_cb_runtime),
>  				       "exception_cb_mod"), "set_attach_target"))
>  				goto done;
> -		}), "FENTRY/FEXIT programs cannot attach to exception callback", 0);
> +		}), "FENTRY/FEXIT/FSESSION programs cannot attach to exception callback", 0);
>  
>  	if (test__start_subtest("non-throwing fexit -> exception_cb"))
>  		RUN_EXT(-EINVAL, true, ({
> @@ -148,7 +148,7 @@ static void test_exceptions_success(void)
>  				       bpf_program__fd(skel->progs.exception_ext_mod_cb_runtime),
>  				       "exception_cb_mod"), "set_attach_target"))
>  				goto done;
> -		}), "FENTRY/FEXIT programs cannot attach to exception callback", 0);
> +		}), "FENTRY/FEXIT/FSESSION programs cannot attach to exception callback", 0);
>  
>  	if (test__start_subtest("throwing fexit -> exception_cb"))
>  		RUN_EXT(-EINVAL, true, ({
> @@ -158,7 +158,7 @@ static void test_exceptions_success(void)
>  				       bpf_program__fd(skel->progs.exception_ext_mod_cb_runtime),
>  				       "exception_cb_mod"), "set_attach_target"))
>  				goto done;
> -		}), "FENTRY/FEXIT programs cannot attach to exception callback", 0);
> +		}), "FENTRY/FEXIT/FSESSION programs cannot attach to exception callback", 0);
>  
>  	if (test__start_subtest("throwing extension (with custom cb) -> exception_cb"))
>  		RUN_EXT(-EINVAL, true, ({
> diff --git a/tools/testing/selftests/bpf/verifier/sleepable.c b/tools/testing/selftests/bpf/verifier/sleepable.c
> index 1f0d2bdc673f..c2b7f5ebf168 100644
> --- a/tools/testing/selftests/bpf/verifier/sleepable.c
> +++ b/tools/testing/selftests/bpf/verifier/sleepable.c
> @@ -85,7 +85,7 @@
>  	.expected_attach_type = BPF_TRACE_RAW_TP,
>  	.kfunc = "sched_switch",
>  	.result = REJECT,
> -	.errstr = "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable",
> +	.errstr = "Only fentry/fexit/fsession/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable",
>  	.flags = BPF_F_SLEEPABLE,
>  	.runs = -1,
>  },
> -- 
> 2.53.0
> 
