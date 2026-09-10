Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71E549E158
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 22:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789079594; cv=none; b=gh11bAPLFvr2eLF3oOIw0p1zPJ03giZ29NdXGsebONOJSfkjhaN/N00jUGRVrPY5SSTCNTJht5sZKgzVT/jbWLhNl9jWhvNtj879fkJDeEMAIbzh9knPDE0WF4jde4DaEiOpEJThvJW+WSDqvwBW5+gOzVg3HAhJXE5TnmxpW/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789079594; c=relaxed/simple;
	bh=CaPhiOXGj0CMQ2Rg4LqjXg58ukdZF2AyvfHCNWgLq54=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Uw0Oby9HIf11nhmhxVvqGFeoAFUD4RSHtDHmkUPJ3wkMw1U0lEewuqh2pqyQui5bkATZ76lJCUtEHvspQpbI/hAk9aiYeXHZUUAin2nT8CsrhyUKZmeq8TfZ+wXB/QTdbHCuW5Nw3/XJpPaQaKgz9tD0n1ejcL7CilUDt981VeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzQXttDr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzQXttDr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FDE1F000FF;
	Thu, 10 Sep 2026 22:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789079593;
	bh=HI16uxw1u2Pu+4C+nGtMH888XxrNcUeXt2yI5ylcdrQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YzQXttDrFr/LVVfg25FsKPdmQ6eL2OxXMe0nyqx7MOTROVW1dwyxA0A2T4F3X6AQ1
	 Lyo/cNvMsxqLZMH+pf5PLlUwf93gSSlbArRSLb0lQfGBtHUtcWP4ouLLlrmL+GSGei
	 4c4SXbw3VOlBZBR6dEGf2nJj5N0nQ9Lpxat0dH/yJTNSgZyfV8Ux2CYsKKHAgdtk4N
	 W76xgRNUM3GyToHGQzA2xd+VZ+s/WC+cG1RQUiOWsJbpMNmRuMVHAotjzh0YVIC8j1
	 +CPMilOPv3UT1ONisP5qTxDfxXLYXaGGSde72Un1jI76lvVI0KR9mWGVYCYJ37iE0a
	 DkdkyCEICJFTw==
Content-Type: multipart/mixed; boundary="===============2515251266048956345=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20db746d8e77f9915dcfa1237f85e0aabdc2e87554642ecefd1e8948d74f8921@mail.kernel.org>
In-Reply-To: <20260910213510.49358-3-daniel@iogearbox.net>
References: <20260910213510.49358-3-daniel@iogearbox.net>
Subject: Re: [PATCH bpf v2 3/4] bpf: Require CAP_PERFMON for untrusted read-only memory reads
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,ast@kernel.org
Cc: memxor@gmail.com,eddyz87@gmail.com,info@starlabs.sg,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 10 Sep 2026 22:33:13 +0000 (UTC)

--===============2515251266048956345==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Require CAP_PERFMON for untrusted read-only memory reads
>
> Marking bpf_rdonly_cast() KF_PERFMON CAP-limits one producer of PTR_TO_MEM |
> MEM_RDONLY | PTR_UNTRUSTED, but not the type itself. A global subprogram
> argument tagged __arg_untrusted results in the same register with no kfunc
> call.
>
> Reported-by: STAR Labs SG <info@starlabs.sg>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

This looks like a bug fix for PTR_TO_MEM|MEM_RDONLY|PTR_UNTRUSTED support
introduced in an earlier commit. Should this include:

  Fixes: f2362a57aeff ("bpf: allow void* cast using bpf_rdonly_cast()")

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 939e535a3442..8058f684a9ea 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6453,6 +6453,15 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
>                         return -EACCES;
>                 }
>
> +               if (rdonly_untrusted && !env->allow_ptr_leaks) {
> +                       verbose(env, "%s access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN\n",
> +                               reg_type_str(env, reg->type));
> +                       bpf_diag_policy(env, insn_idx, "read from untrusted read-only memory",
> +                                       "the access requires CAP_PERFMON",
> +                                       "Load the program with CAP_PERFMON, or avoid dereferencing untrusted pointers.");
> +                       return -EPERM;
> +               }
> +
>                 /*
>                  * Accesses to untrusted PTR_TO_MEM are done through probe
>                  * instructions, hence no need to check bounds in that case.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34534885787
--===============2515251266048956345==--
