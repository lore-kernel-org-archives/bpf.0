Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62D73D47D0;
	Tue,  2 Jun 2026 10:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780396058; cv=none; b=SG8Z9OmgPB64ObIT2ySttH9gvlFGOgqoiPJ+rPui63YD1XKm6aJWemVrHrLurbz+p5mdA/PiO9ejjkxI9Zl1orUAGnd8rUODuF/r1zD+CMe87B+4R/Zb9O1fGrBXTy+lsqICe/0qv6hU+rY/6icTG5n2TDMhAIMMmb5WjrzSFTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780396058; c=relaxed/simple;
	bh=eI1CjmOpCuWWuonExfYjZj9qSls0NJ/BYMbs5ggp7Js=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bBlJaqEG6E7FxLYLsZtB4f8SEdVN7kCzfbM0+fuGbURhv4Ge4RbFxVyDvgvX+Ivdbfi0B9c2LJa7NTDwkE2zPzvu9NJN4EB0B31vSD9lLy0OEcbfc2J2KGAyEA7ILGemmJiT4I9DVPo622//NmlCKiHOSRLzbA2ivp0D9aDzxT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxPyiiHQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxPyiiHQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9141F00893;
	Tue,  2 Jun 2026 10:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780396056;
	bh=5BaWAxrXazis17gLjbU3j69wzbPBsLsLJC9riaTgTRg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=JxPyiiHQ13cSsQPJSj5lEh8srKp/bW3aTtV8J2by7ol9zBUWrEkhnHa39BzrgmMc8
	 kKZ8FrZ+XRhw2GD+5eJqsBQlrJotrdqTSceW8FvGJTJ9pIu+CLLlyjndysVNLPY0u3
	 d+EWrEVYxpcXv1NBeqHeh7Qciy0YI9nxK+x6EeQ9iIhtEGVlglyJ4zGBHJBFWlQuqO
	 IQDUUNcacY/hJbMvbF2f+V/1egspeAhgI/ElOUmREVPyOfc52o0ub3VSjo9BwEX07y
	 N7Uc2ik7gvbRriPN9Y0FSHyUaWFTr0ZiDDK7fmzSyU7r6404RUYdlkX2NW/xuiKP8U
	 bRdjI7ZGnVQQg==
Content-Type: multipart/mixed; boundary="===============7364269074024431398=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <05115364a047f76b4eb87f58fef6c9753809f0aecbe57a2ce891edfed4058618@mail.kernel.org>
In-Reply-To: <20260602093836.2632714-3-chenyuan_fl@163.com>
References: <20260602093836.2632714-3-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf v4 2/2] selftests/bpf: Add regression test for kfunc implicit arg injection
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,eddyz87@gmail.com,yonghong.song@linux.dev
Cc: andrii@kernel.org,ast@kernel.org,bot+bpf-ci@kernel.org,bpf@vger.kernel.org,chenyuan@kylinos.cn,chenyuan_fl@163.com,clm@meta.com,daniel@iogearbox.net,ihor.solodrai@linux.dev,jolsa@kernel.org,linux-kernel@vger.kernel.org,martin.lau@kernel.org,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  2 Jun 2026 10:27:36 +0000 (UTC)

--===============7364269074024431398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
> index 461ded722351..192fd3166f38 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_assoc.c b/tools/testing/selftests/bpf/progs/struct_ops_assoc.c
> index 68842e3f936b..ed0084453d56 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_assoc.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_assoc.c
> @@ -103,3 +103,43 @@ SEC(".struct_ops.link")
>  struct bpf_testmod_multi_st_ops st_ops_map_b = {
>  	.test_1 = (void *)test_1_b,
>  };
> +
> +/* Test for aux injection with stale register contamination.
> + *
> + * This test verifies that the kernel correctly injects the implicit
> + * bpf_prog_aux pointer for kfuncs with KF_IMPLICIT_ARGS.  The program
> + * uses inline assembly to contaminate R2 with a known magic value
> + * before calling the kfunc:
> + *
> + *   asm volatile("r2 = %[magic]" :: [magic] "ri"(0xDEAD) : "r2");
> + *
> + * The kernel must inject env->prog->aux into R2, overriding the magic
> + * value.  The kfunc compares the received aux pointer against 0xDEAD:
> + *
> + *   - aux == 0xDEAD  -> kernel failed to inject -> kfunc returns -EINVAL
> + *   - aux != 0xDEAD  -> kernel correctly injected -> kfunc returns marker
> + *
> + * 0xDEAD is chosen with bit 31 clear to avoid BPF ALU64 sign-extension
> + * when used as a 32-bit immediate.
> + */
> +int test_err_inject;
> +
> +SEC("tp_btf/sys_enter")
> +int BPF_PROG(sys_enter_prog_test_aux_inject, struct pt_regs *regs, long id)
> +{
> +	struct task_struct *task;
> +	int marker = 0x5A5A;
> +	int ret;
> +
> +	task = bpf_get_current_task_btf();
> +	if (!test_pid || task->pid != test_pid)
> +		return 0;
> +
> +	asm volatile("r2 = %[magic]" :: [magic] "ri"(0xDEAD) : "r2");
> +
> +	ret = bpf_kfunc_aux_inject_stale(marker);
> +	if (ret != marker)
> +		test_err_inject++;
> +
> +	return 0;
> +}

In v2, Yonghong Song questioned whether this selftest makes sense, given
that CI has pahole 1.31 so the test will always succeed:

https://lore.kernel.org/bpf/9cc9ce47-c45e-4878-ad3a-6e6967399ab9@linux.dev/

The commit message now acknowledges that "the specific pahole 1.30 BTF
mismatch scenario cannot be tested with CI", but it's unclear what value
this test provides if it cannot actually verify the bug condition.

Could you explain the rationale for including a test that validates the
injection mechanism works under normal conditions but cannot reproduce the
actual pahole 1.30 BTF inconsistency scenario the bug fix addresses?

[ ... ]

Unaddressed review comment from the preceding patch

The issue below applies to the preceding patch (kernel/bpf/verifier.c)
rather than this selftest, but remains unaddressed in the patch series:

In v2, Yonghong Song requested that code comments should explain the fix
is due to pahole 1.30 BTF generation issues, so the code can be removed
later when that toolchain is no longer relevant:

https://lore.kernel.org/bpf/7b3ba4a8-a785-4f70-879d-50e63d6de787@linux.dev/

The commit message in the preceding patch describes the pahole 1.30 issue
extensively, but the in-code documentation was never added in v3 or v4.

Should this documentation be added to check_kfunc_args() or
is_kfunc_arg_implicit() to explain the temporary nature of this fix?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26812478701
--===============7364269074024431398==--
