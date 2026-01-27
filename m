Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2D9823DD
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 23:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769557529; cv=none; b=J6MF7+BEzvU7xX4zPXYY8t6TvBYruVRENjYvOz6XW18kyHu/zTGIg9pIue01H0L5lQp05gQPNl/1JklOv6ylxS2/bDSjPX9butBctuHbgt1IZHWxkw6kcgydowZIe71L11ybzjlnoYoEEnzUCs9vAQIRgg2hw/5Y08GpXG2OgIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769557529; c=relaxed/simple;
	bh=lix78lsfEcKTYekapK4rjRuiZlm2T4hqgYycfg3yxKA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ALXFvp4ZlsFzgTzhx2oWyGhvpQN/GotuGUgjk/QRasuNZBpj8H74JwRjPD/W1tPPtFIy/h67gH4gVIGYkgbblwQ0rSvuy80nTIy4lLhbgm5bAilAoZC2jY7kqYu50H/mJlGrTxbn3NfNFBkxkHKR8JT4chIB3LvLN5pU1i2YTRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMV+0ZYD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMV+0ZYD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FFBC116C6;
	Tue, 27 Jan 2026 23:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769557529;
	bh=lix78lsfEcKTYekapK4rjRuiZlm2T4hqgYycfg3yxKA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=PMV+0ZYDAlTM0XapVRm8+VR2LNbkhKhdqL6pqJ7TqUSEMJ4KowWh6DDR2+7aG/IVC
	 Q8ZoZKyQE8Z2o+EGFmoBq5OSZmg6SibGI43INtZNkSijfDqkktTqETOPiiWN+iC7zd
	 D2uxGPy5XrxpRC7qWW4VtzbT6wYS5d1vBYYRBhX1kXWHbOcD/9kPLJPOF3fB/weWEO
	 k8GirKHQfgM462QeeupUliLB37xKUAy6dbInjt8HTNfWImrYPp6sgbeDepTkPgeJvq
	 BAAHWyiZtbTK/zVoj+Qyt86XvXVDsEGLr7dsKK8Vxa/PDcJwX88y4jRa0fHXfC9vFu
	 n2I2rQ4Oup8Uw==
Content-Type: multipart/mixed; boundary="===============7171791208809742574=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <85a0ec6ff812bfcd7e648a36edb28517817fe05a0b5b164d4b3c269d365e1562@mail.kernel.org>
In-Reply-To: <20260127231414.359283-1-emil@etsalapatis.com>
References: <20260127231414.359283-1-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next] bpf: Allow void return type for global subprogs
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,martin.lau@kernel.org,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 27 Jan 2026 23:45:28 +0000 (UTC)

--===============7171791208809742574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c2f2650db9..2cc7404954 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -10875,7 +10898,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		subprog_aux(env, subprog)->called = true;
>  		clear_caller_saved_regs(env, caller->regs);
>
> -		/* All global functions return a 64-bit SCALAR_VALUE */
> +		/* All non-void global functions return a 64-bit SCALAR_VALUE. */
>  		mark_reg_unknown(env, caller->regs, BPF_REG_0);
>  		caller->regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;

The comment was updated to say "non-void" but mark_reg_unknown() is still
called unconditionally for all global functions.  Should this skip marking
R0 as SCALAR_VALUE when the callee is a void function?

As written, after calling a void global function, R0 is marked as a valid
scalar that the caller can use, even though the callee never set it.

The new subprog_is_void() helper is used in check_return_code() to bypass
the R0 validation at the callee's exit, but check_func_call() does not use
it to avoid marking R0 at the call site.

Something like this might be needed here:

    if (!subprog_is_void(env, subprog)) {
        mark_reg_unknown(env, caller->regs, BPF_REG_0);
        caller->regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
    }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21418326339

AI-authorship-score: low
AI-authorship-explanation: The code follows standard kernel conventions with appropriate use of existing patterns and helper functions, showing familiarity with the BPF verifier internals.
issues-found: 1
issue-severity-score: medium
issue-severity-explanation: The verifier incorrectly marks R0 as a valid scalar after calling a void global function, allowing programs to use an undefined value, though it does not directly cause crashes or security issues.

--===============7171791208809742574==--
