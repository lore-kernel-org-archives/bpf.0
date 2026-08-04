Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645F02F1FDE
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 08:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833013; cv=none; b=qJwoutBc6JoNs9EiNA95fs4cHUvYttopAE0peNRmEzirklPNlbjqMYN5Tx+BbxrMcDjobWxivpjGDW0ngbtCBbVpYKvK2twVFC9QdZmNtxElk6nKoApBT7rhBxtaUUW/YzYwdS/qXTg2ic7TQEq4M5Q/crmV5tcSo3j+gK8Bre0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833013; c=relaxed/simple;
	bh=hPFf1ypLPsXSxk5jJ/tdXLRHlGtS/pCEQCDRTah8aic=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BISdP8K1UEiRAzG6QR+icCB1nLGyOl/QC9e4MhHV6PdkecGDtkNuUdkQzmSq+fTUmclfl3NyKbGc/6CJyyAEUttPs37DOtGgYRoKwddcSFb+Wbypdg9OtX45TMCBojd8rEb07hm+xxX2hHTgATZ2Q7S6WW9mlITcajYr6JrxyHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcwbohFl; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcwbohFl"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-46cbf263216so1995816f8f.1
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 01:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785833010; x=1786437810; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CPBdcxqneLJaWRE3D0wohrfsaMJhDjseJnAc+v/1Cjs=;
        b=FcwbohFluF66cQhY5wqtvfWDUlyna3+GBn6FRG6MtuGufcc2k/RB1TBtJwfvHZKAln
         VV59hmWTsGuih8nGTZE2siHiGKMqVGqJGIJSs+D9pQmK5fe4YzEq7l2OiSbdPBnEm2BC
         AZ4mP95mFxI4Wxc0AhzA4PndH+B5kP4CFNko1MvtcTFmzMGH1tJXOxrFlVDeoIFYNyxF
         MsqrArDbXB+4YjDi4mX3Il8a9VaawIEnQ9oGE8UHp3rXSZBKziCPSI3juJ4RxaatekXH
         gtSYsn6BxhX12kFO2u/4JLwUOP+Xt4G3VE8Et7bl/Hg8g185reCTe4xjeafvJeYzj3FG
         rMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785833010; x=1786437810;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CPBdcxqneLJaWRE3D0wohrfsaMJhDjseJnAc+v/1Cjs=;
        b=Pva7EjoDBdvgz8kgvGY4vFkkBvEvkhvf4qN57ljC09KcOzeQ5lUygdxnqc6bCkC2N2
         7MS/EAgE9vDji7eqYck2H8eO05Uc2nmvOCgS3ogFMRJklOrSxGL8K9P1L8ZMpimkEDti
         CtkEa9Foil3e3Kea3461N9toUscHzunYqKvFf4hPLbZola6KVbQcod947mAiNeJs4PE1
         /tpSwIjPn/roX15nR4gumadLHx8D/24Pev0l0sYK99ZQ11WDb4iy6dOp5KrByj8IXkLs
         Vosv2sOjq0jXC+kZAuXJuunsykEcZ/CHwFonTW2WPyxmZKl+0BBc+ikCR4Hvm6sdE7AV
         gEsw==
X-Gm-Message-State: AOJu0YzCj6+ejgv3PU7hG3f8MaNCnCfNRD17YTOGY13sKHAmGxrcMG37
	e16DphLB4MgTDdXX/+7DG98AAjXylVxxiOb0G+ekqdQwIfRwOrcPNFiN
X-Gm-Gg: AR+sD11lbN5dlJtadKwqlFnnn0HAQME1RScVFoaN07r5iJHIL249gF5eupKE4Oa68La
	DCvx7Fbho3M6aGkxfrF8cP+lEQrdQ1DF3lhySqzgWjUQXwP4ht1pS3wwFs+9duWv88Ruj467pgy
	oQHABgkxaLYluIAnXAwK5wRrO2TohLVzf5UayL7HLSmbOEL14S8xqxhQAXPozEhr2RXSCxgDyX8
	ZfdpmYeNgjf6B2jIjU5QIkFBvd0p0z25md4tYqSOc1gCoBHmIpmXxhX6Ezo6BiOpS1EMCQT/YrN
	lvhNUnjwC9WVkGfThwjWsX/G8ZZcFr8rinUyIGbHvj3CKTYpRLrBtM6oWwk+XASGvDOr2gcqq5l
	rTWFXWEsPFxyd7oUh6+szgP36/gP1gpDtIZYZfKEWlEUpsrxU9cjDer+2S/TkL9EYObBwrLv0Cq
	dtC9ZoIyojzAZ3xywaLaVeop1jqDKKTssNYf/o64EoL/nFEtLv2A5XPRdN5CkAIFb24vC1NFKzS
	rM6qasGI6EYd/8ZuZXN7rx/QLhqzh0c5vhQhTkiZYo3Y7EN6TgHcvDA+u0OLqVQSXuQ20syQ77q
	KzT5ut3pBqVE1yNe8rfK7XPIEgY=
X-Received: by 2002:a05:600c:4e52:b0:496:bbce:fc with SMTP id 5b1f17b1804b1-4980c658ff3mr345856595e9.12.1785833009276;
        Tue, 04 Aug 2026 01:43:29 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994a0fca55sm72931465e9.13.2026.08.04.01.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 01:43:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Aug 2026 10:43:28 +0200
Message-Id: <DKG0YUDSTBUY.1X220287HT9V3@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Kaitao Cheng"
 <chengkaitao@kylinos.cn>
Subject: Re: [PATCH] bpf: add KF_SPIN_LOCK flag for kfuncs under
 bpf_spin_lock
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Kaitao Cheng" <kaitao.cheng@linux.dev>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "John Fastabend"
 <john.fastabend@gmail.com>, "Ihor Solodrai" <ihor.solodrai@linux.dev>
X-Mailer: aerc 0.21.0
References: <20260804083212.79271-1-kaitao.cheng@linux.dev>
In-Reply-To: <20260804083212.79271-1-kaitao.cheng@linux.dev>

On Tue Aug 4, 2026 at 10:32 AM CEST, Kaitao Cheng wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>
> Introduce the KF_SPIN_LOCK kfunc metadata flag in BTF so kfuncs may be
> explicitly marked as safe to call while holding bpf_spin_lock.
>
> Allow kfuncs defined in kernel modules to be marked with KF_SPIN_LOCK.
>
> Example: BTF_ID_FLAGS(func, $kfunc_name, KF_SPIN_LOCK)
>
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---
>  include/linux/btf.h   |  1 +
>  kernel/bpf/verifier.c | 20 +++++++++++++++-----
>  2 files changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index c09b7994de4e..380dc10b6750 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -79,6 +79,7 @@
>  #define KF_ARENA_ARG1   (1 << 14) /* kfunc takes an arena pointer as its=
 first argument */
>  #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as its=
 second argument */
>  #define KF_IMPLICIT_ARGS (1 << 16) /* kfunc has implicit arguments suppl=
ied by the verifier */
> +#define KF_SPIN_LOCK    (1 << 17) /* kfunc is allowed inside bpf_spin_lo=
ck-ed region */
>
>  /*
>   * Tag marking a kernel function as a kfunc. This is meant to minimize t=
he
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7aa47342dc65..9f3feba3c2fe 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11657,11 +11657,21 @@ static bool is_bpf_stream_kfunc(u32 btf_id)
>  	       btf_id =3D=3D special_kfunc_list[KF_bpf_stream_print_stack];
>  }
>
> -static bool kfunc_spin_allowed(u32 btf_id)
> +static bool kfunc_spin_allowed(struct bpf_verifier_env *env, s32 func_id=
, s16 offset)
>  {
> -	return is_bpf_graph_api_kfunc(btf_id) || is_bpf_iter_num_api_kfunc(btf_=
id) ||
> -	       is_bpf_res_spin_lock_kfunc(btf_id) || is_bpf_arena_kfunc(btf_id)=
 ||
> -	       is_bpf_stream_kfunc(btf_id);
> +	struct bpf_kfunc_meta kfunc;
> +	int err;
> +
> +	if (is_bpf_graph_api_kfunc(func_id) || is_bpf_iter_num_api_kfunc(func_i=
d) ||
> +	    is_bpf_res_spin_lock_kfunc(func_id) || is_bpf_arena_kfunc(func_id) =
||
> +	    is_bpf_stream_kfunc(func_id))
> +		return true;
> +
> +	err =3D fetch_kfunc_meta(env, func_id, offset, &kfunc);
> +	if (err || !kfunc.flags)
> +		return false;
> +
> +	return *kfunc.flags & KF_SPIN_LOCK;
>  }
>
>  static bool is_sync_callback_calling_kfunc(u32 btf_id)
> @@ -17289,7 +17299,7 @@ static int do_check_insn(struct bpf_verifier_env =
*env, bool *do_print_state)
>  				     insn->imm !=3D BPF_FUNC_spin_unlock &&
>  				     insn->imm !=3D BPF_FUNC_kptr_xchg) ||
>  				    (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL &&
> -				     (insn->off !=3D 0 || !kfunc_spin_allowed(insn->imm)))) {
> +				     !kfunc_spin_allowed(env, insn->imm, insn->off))) {
>  					verbose(env,
>  						"function calls are not allowed while holding a lock\n");
>  					return -EINVAL;

Why not apply it to all of the existing kfuncs? Also, use [PATCH bpf-next] =
subject.

pw-bot: cr
