Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C04347534
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 20:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777409175; cv=none; b=mGr2b2SBHD2UeQsCMmAdNuQX3mmx8Do8UZMFM7awfdwzkB259+/YxOrQ8NZpsq0JZrPgwaRLHVn9NP0vMvpDpFOjLJK1yMSTHoPDyUzDosWyCloJIIA/xTldZpQUVG4LOgKyM+Aa6C7CYOrCm/y/xAZhEpJvmpKQ0n0nfqYI3ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777409175; c=relaxed/simple;
	bh=AGPlY4fLfBRBn0qReAoTeNzstI+0L7dvFimb3JvX1Qc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KQdQ7T1+So3qOGn3v8F2vPm1VmQuxM8SzzJYhfMWL3sYdUaAiocm6DkgbzVqhQp3Puu98DJJX0yWaYcggnYj0fObQaNTJDFVT+PxcEg2bBf34UvSahDz/L/NZSiLIrSE5HnTpOO4nuIfctbxf5LswHSN5PXpeGrfcY7IFhZFVmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epjKUc92; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epjKUc92"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99120C2BCB3;
	Tue, 28 Apr 2026 20:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777409174;
	bh=AGPlY4fLfBRBn0qReAoTeNzstI+0L7dvFimb3JvX1Qc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=epjKUc92IfeWOOitGJpoIMovRCxbrXQ93tCTobHM7/USvVpUjXVSWcG7VTz9e2YjU
	 tbMOM/hF5rSnEjqOQx0eTvnsrjBrI+OwKuYVtnxryJPYYJsCOiPSlFxkBaaCHgmdma
	 s4bmA+wrqsldluZuBrrbpDzcQkpRNlFUdjx8kPwd3SnkkM2U5xwXz6F/Qb83C97Kri
	 7Vr1gIp+PFPyvQfDANaUhrT8EEVvJvUzKgSasgkR+whL0csIvBAdSUdR9l+Pb4J3iF
	 iLFnc3ra0JoASbtxX+T05Pg5+lbG9QTrUPTBV7Y1j/1edZHKpEFC3LWvPWVuez/Xx2
	 xEFMbrpodiHCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC bpf-next 2/3] selftests/bpf: Test
 inline_bpf_get_current_task() for LoongArch
Reply-To: sashiko@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260428080051.20938-3-yangtiezhu@loongson.cn>
References: <20260428080051.20938-3-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Apr 2026 20:46:14 +0000
Message-Id: <20260428204614.99120C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The expected BPF JIT inline instruction for `bpf_get_current_task(=
)` on LoongArch incorrectly expects a pointer to `struct thread_info` inste=
ad of `struct task_struct`.
- [Medium] Adding test expectations for an unmerged kernel feature will cau=
se the test suite to fail on LoongArch, breaking CI.
--

commit e03cdf4a4a90c2aa3d904cdf264ea432cfe489b9
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

selftests/bpf: Test inline_bpf_get_current_task() for LoongArch

This commit adds the expected JIT inline instruction for bpf_get_current_ta=
sk()
on LoongArch to the verifier_jit_inline selftest. It defines the expected J=
IT
output ahead of the actual JIT implementation being merged.

> Note that this test will pass only after the JIT inline support for
> bpf_get_current_task is merged. While the JIT inlining is still in
> the pipeline, adding the changes now will not introduce any build
> regressions.

Will this cause the selftest suite to fail on LoongArch in the meantime?

Since the JIT implementation is not yet merged, the test framework will lik=
ely
fall back to emitting a standard helper call instead of the expected inline
instruction. Adding test expectations for unmerged features often results in
test suite regressions until the corresponding feature lands.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c b/to=
ols/testing/selftests/bpf/progs/verifier_jit_inline.c
> index 4ea254063646..913a1699e42b 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
> @@ -10,6 +10,8 @@ __arch_x86_64
>  __jited("	addq	%gs:{{.*}}, %rax")
>  __arch_arm64
>  __jited("	mrs	x7, SP_EL0")
> +__arch_loongarch
> +__jited("	move	$a5, $tp")

Does this instruction return a pointer to struct thread_info instead of
struct task_struct?

On LoongArch, it appears the kernel stack holds struct thread_info, and the
$tp register points directly to it rather than to struct task_struct. The t=
ask
pointer is the first member of struct thread_info at offset 0.

By using a move instruction, the BPF program would receive the thread_info
pointer. When the program later attempts to access fields like task->pid, it
will read out-of-bounds stack memory relative to the thread_info base.

Should this be a memory load like ld.d $a5, $tp, 0 to dereference the task
pointer instead?

>  int inline_bpf_get_current_task(void)
>  {
>  	bpf_get_current_task();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428080051.2093=
8-1-yangtiezhu@loongson.cn?part=3D2
