Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092CF54704D
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 05:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790399800; cv=none; b=WrHnaQpF2+fmMFc+ecx9rMXNzaf3keDSOx8wIF1SizaJuzcvSN6EkUsT5mDvVu4SVGii6LnGvdM23N9DGz824G0BGz3JiSZvizNhUQDi/6bvAE+j9ee4hUWykkPDtnVeBMnhhK0KwDJesl5rNETpBJ/897vAioz3c1wAhDaH7Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790399800; c=relaxed/simple;
	bh=kGwoPft2ANHjW5tpoOolqka6UDGLHiWtRMqeUd7t3bU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TKy5PTI+9WV1eNhvMSbctzP9Yg3hhhq6sDaN0jIog+ecknBMuVtow9om7O4QkjORj5EvFFbc/qkdaq9f2givnnQ8ZaTpTlAbMJY8Gg6y3YJHmCCYm82iL8zMtlkEIzyiOXkxpmxPYNTvWnC8OXo3OLFjamEvz+tYCcuD80HU6gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvXu3MyY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvXu3MyY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867681F00893;
	Sat, 26 Sep 2026 05:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790399798;
	bh=4P9XJmpE4s7FTnEe+vDrZ4ZnE8yjrJH2hwSJCjgxwko=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hvXu3MyYyXf7KouHFmJiKPYawyNibVJGPr9OHFA4ScShvJ6oGlAEaWE1GMhnUdTAf
	 SkxgRQZeCf/FoaCzzsVLXHKwOJXaXb62ZxyimMSZoVE5l+L42HC5WsYXIM3FZZwNsR
	 /+eDIUs0YR7nk443RcAY68/yC50cfxjiUC+hzd/sdboGQTKp12r9MUQ85xd/5PXEw7
	 475Lv2Lk3POfIs9w0B97ZqnB8b6HW4jw+OqlexRupRWoBmcr5oGcMlhYVGq+Ybd1Gc
	 q3I4WmSQ+4fi84i5LwZXxZAvVgkq5cQAnpKgsNaCCK7yUT74I4BCL/1/tnZ790bW1M
	 S0T9bHdsv53IQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 05/21] bpf: Prepare for an exception cleanup
 table before the CFG walk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260926050032.2215748-1-yonghong.song@linux.dev>
References: <20260926050006.2213110-1-yonghong.song@linux.dev>
 <20260926050032.2215748-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 05:16:38 +0000
Message-Id: <20260926051638.867681F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: bpf_throw() bypasses exception_callback_subprog check skipp=
ing cleanup pads
--

commit bfb14bc84bb67f59ae10ca034e824ec0357d7d80
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Prepare for an exception cleanup table before the CFG walk

This commit introduces bpf_prepare_cleanup_exceptions() to record landing p=
ads
for BPF-to-BPF calls and bpf_unwind() within a cleanup record's range. It
ensures the JIT supports dispatching landing pads and refuses to combine
tables with an exception callback.

> diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
> index b19fcbf49b7ef..1ed0370a171b7 100644
> --- a/kernel/bpf/exception.c
> +++ b/kernel/bpf/exception.c
> @@ -7,9 +7,56 @@
>  #include <linux/filter.h>
>  #include "exception.h"
> =20
> +#define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##ar=
gs)
> +
>  BTF_ID_LIST_SINGLE(bpf_unwind_id, func, bpf_unwind)
>  BTF_ID_LIST_SINGLE(bpf_unwind_resume_id, func, bpf_unwind_resume)
> =20
> +static void mark_call_sites(struct bpf_verifier_env *env)
> +{
> +	u32 i, j;
> +
> +	for (i =3D 0; i < env->cleanup_info_cnt; i++) {
> +		struct bpf_cleanup_info *rec =3D &env->cleanup_info[i];
> +
> +		for (j =3D rec->begin_off; j < rec->end_off; j++) {
> +			struct bpf_insn *insn =3D &env->prog->insnsi[j];
> +
> +			if (!bpf_pseudo_call(insn) && !bpf_is_unwind_kfunc(insn))
> +				continue;

[Severity: Medium]
Since bpf_throw() is not matched here, does it skip receiving a landing pad?

If a program is loaded with .bpf_cleanup records and calls bpf_throw() with=
out
specifying a custom exception callback, could this cause it to silently byp=
ass
the cleanup execution during unwinding, leaking user-defined logical resour=
ces
like map-based counters?

> +			env->insn_aux_data[j].cleanup_pad =3D rec->landing_pad_off + 1;
> +		}
> +	}
> +}
> +
> +int bpf_prepare_cleanup_exceptions(struct bpf_verifier_env *env)
> +{

[ ... ]

> +	if (!bpf_jit_supports_cleanup_pads() || !env->prog->jit_requested) {
> +		verbose(env,
> +			"exception cleanup needs a JIT that can dispatch landing pads\n");
> +		return -EOPNOTSUPP;
> +	}
> +	env->prog->jit_required =3D 1;
> +
> +	if (env->exception_callback_subprog) {

[Severity: Medium]
Does this check the state of env->exception_callback_subprog too early?

If a later pass dynamically inserts a default exception callback, could it
bypass this restriction and result in a mix of exception cleanup tables and
bpf_throw() usage?

> +		verbose(env,
> +			"exception cleanup table cannot be combined with an exception callbac=
k\n");
> +		return -EINVAL;
> +	}
> +
> +	mark_call_sites(env);
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926050006.2213=
110-1-yonghong.song@linux.dev?part=3D5
