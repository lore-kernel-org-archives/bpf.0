Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9C53290DB;
	Thu, 28 May 2026 06:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779948338; cv=none; b=HeEQUqcToyb3NcLDxfgYK5vKeLhRq85553txmH+ICU1Yy5cQArLjp49gjohuG9DpxkMnOjlGfc0Gf8RxGZ4x6HuTumea6CZS4suzCC51E1SEXRFlHYlFqRPVyctdtW9Mxq//fMEMy2XfYiYXy0Abs4SUZXbQ5aiEkOlPkZLoSt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779948338; c=relaxed/simple;
	bh=xjzlLeSYYGBvR7i4PSMpOxEehwyqNM9HncJa6Y1NkuM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SsDRtde2E3oi/Xm/v5CdyRYojSzdTPPvr6TnyISSyCTDT8GCgt74v60ihpeC6stq/DsZJ/XCMuvnvp0Sg0KlEoIARyKWGBI7afE+YlxFRxpKqirX8GJtXSBBL/zY+fmjWXp9LYhxVC9KxC3s7F+rdY+sPThe3LkgD3nKIdCP+tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLa5BBoH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLa5BBoH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBDC1F000E9;
	Thu, 28 May 2026 06:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779948336;
	bh=ZDO6oKi1Sv7Tkb2XSujiBaEJr698U7Nbe46tZ/sMSZA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VLa5BBoHOrDT4F6+U347l00jrL2a5nvuv9BnTdw5diTD6RUiYmxmXig40mCWc5mnk
	 paapqupeboBPIvekoghL+SNgH3RsGDHIbHUyw60LKKLawL8+wX4jw4MatKzcqMDlsk
	 Yo/pHyrkvRYaTD2Qfk0cLk3PCR7g4CfntDqJkBJsOSFIkQaeCVautBWpwginuZz/D9
	 nsv8Hy3LVSgVQAsq/QwKEWEeEL56gCjMd3iEAmd3mPpKlk+G12igbq+b5IBVHc2CWY
	 2XOdG6j9BzwPXVviVKCuDVbbOM5rh8ZX0r3PNzaswhrVCBgzHtjEvZGGi8gAltE/+a
	 CZCUONyGKyWnw==
Content-Type: multipart/mixed; boundary="===============5796768601224652263=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <08893f561c8f0e0d3016bb5c5f2618672da84327f27ab77df08fc3cb6a37ea07@mail.kernel.org>
In-Reply-To: <20260528052533.3940181-2-hataegu0826@gmail.com>
References: <20260528052533.3940181-2-hataegu0826@gmail.com>
Subject: Re: [PATCH v2 1/1] bpf: reject overlarge global subprog argument sizes
From: bot+bpf-ci@kernel.org
To: hataegu0826@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,shuah@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,hataegu0826@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 28 May 2026 06:05:36 +0000 (UTC)

--===============5796768601224652263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c8d980fdd709..9248ba0f8089 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6924,6 +6924,11 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
>  	struct bpf_reg_state saved_reg;
>  	int err;
>
> +	if (mem_size > S32_MAX) {
> +		verbose(env, "R%d memory size %u is too large\n", regno, mem_size);
> +		return -EACCES;
> +	}
> +

Does this hunk build?  The function signature is:

  static int check_mem_reg(struct bpf_verifier_env *env,
                           struct bpf_reg_state *reg,
                           argno_t argno, u32 mem_size)

There is no parameter or local named regno here, only argno (of typedef
argno_t).  Other helpers in this file that need a register number
compute it locally, e.g.:

  int regno = reg_from_argno(argno);

Without that, the verbose() call references an undeclared identifier
and the file fails to compile.

The selftest below expects the literal text "R1 memory size 4294967292
is too large", so the format string presumably wants the integer
register number printed.  Would something like:

  int regno = reg_from_argno(argno);

  if (mem_size > S32_MAX) {
          verbose(env, "R%d memory size %u is too large\n",
                  regno, mem_size);
          return -EACCES;
  }

be the intended form, or should this switch to reg_arg_name(env, argno)
with a matching update to the selftest __msg()?

> diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> index dc09d0e2d8ad..75a2e3f48d0f 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> @@ -152,6 +152,23 @@ int anon_user_mem_valid(void *ctx)
>  	return subprog_user_anon_mem(&t);
>  }
>
> +__noinline __weak int subprog_user_anon_mem_huge(int (*p)[0x3fffffff])
> +{
> +	return p ? (*p)[1] : 0;
> +}
> +
> +SEC("?tracepoint")
> +__failure __log_level(2)
> +__msg("R1 memory size 4294967292 is too large")
> +int anon_user_mem_huge_size_invalid(void *ctx)
> +{
> +	int (*p)[0x3fffffff];
> +	int tiny = 42;
> +
> +	p = (void *)&tiny;
> +	return subprog_user_anon_mem_huge(p) + tiny;
> +}
> +


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26556945758
--===============5796768601224652263==--
