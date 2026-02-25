Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8595A213254
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 11:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772017931; cv=none; b=DLUwjlJFEsArdJ87ocT18V7KQt1uMKRl5/kRENBr+XEBvuM8tDiKeWmJ4NqE0N3L9/jp+Ilkn+ISW3ktHfQBJLgKKJaQPRL6Vm9kPlFhpKvg2yR1TOAIYTjNW28Gm6ds95CcG89pagVCVGC3nFOko5AR0Z/Wbr5wdSpIOmpLKHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772017931; c=relaxed/simple;
	bh=euv0b1jOYXmox0xMfxa8d34uU4tYwxcEjUzRv5RY1lM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=d0tkxoPbzUWwtkmYbxudmmXQcD9PakFmccOqdXYiznBOIJTEW3K0/m2QNpENc0NUz1pILb0ZOdtS7Iqt5i8xCxMMzOnn7ODBAO5SKyIF8ViZ3S1Srn8lteSkN/N8lie0m8tzZ8CMEe8sru8G7+1kQ9y0u2Fpz+Z4BpLON7EVpOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RK6SAmZX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RK6SAmZX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016EBC116D0;
	Wed, 25 Feb 2026 11:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772017931;
	bh=euv0b1jOYXmox0xMfxa8d34uU4tYwxcEjUzRv5RY1lM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=RK6SAmZXI79+Yt1NFJ3rv3BhrnDrpdbVVJ4edONcjJ1B+KIrPbbXRFzbVTNCBOElN
	 us5NL4WrigLTzuc8zOMv/ejciOlR2uGxv0AXzX0BGQne3wtRIoSEB2S6d+pnr6vMDq
	 G+B+CCejF7vN7dbLGQFgDL7wJh45HEoQWMQ8stdDaarOenW8BtGJffyv9hxJZ2hBZC
	 zYc1xgtNvRldltjvkaSp1UaICv2dEBLMw2XperskQE17RuxsP0fPgOsZwI84MZxXTX
	 yueNVe9hTOq9lf9BUPwTJfICRkk3vGec9/Tghuee8A0aoH7LlCbcB7y3mmwCt5XPNA
	 gOMpLxglQ2uOg==
Content-Type: multipart/mixed; boundary="===============6469514507980447881=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <05836ab33e1d18dd049c73ae561f9348a3ec5a24dd9de56c72ebab6db14dcc60@mail.kernel.org>
In-Reply-To: <20260225153950.15331-2-adubey@linux.ibm.com>
References: <20260225153950.15331-2-adubey@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] selftests/bpf: Enable private stack tests for powerpc64
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,linuxppc-dev@lists.ozlabs.org
Cc: bpf@vger.kernel.org,hbathini@linux.ibm.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,maddy@linux.ibm.com,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 25 Feb 2026 11:12:09 +0000 (UTC)

--===============6469514507980447881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
> --- a/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
> @@ -7,7 +7,8 @@
>
>  char _license[] SEC("license") = "GPL";
>
> -#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
> +#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) \
> +				|| defined(__TARGET_ARCH_powerpc)

As Christophe Leroy noted in the v1 review, __TARGET_ARCH_powerpc
matches both powerpc32 and powerpc64.

bpf_jit_supports_private_stack() in bpf_jit_comp.c returns
IS_ENABLED(CONFIG_PPC64), so private stack is only available on
powerpc64. On powerpc32 skip would be false, the tests would
attempt to load programs with combined stack depths exceeding
512 bytes, and the verifier would reject them.

Was this intended to be addressed in a follow-up, or should the
guard be narrowed to powerpc64 only?

https://lore.kernel.org/bpf/1956c912-c880-4214-9bc3-e205902459b5@kernel.org/

> [ ... ]

The same change appears in struct_ops_private_stack_fail.c and
struct_ops_private_stack_recur.c with the same concern.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22393518231

AI-authorship-score: low
AI-authorship-explanation: Straightforward mechanical change with copy-pasted test output, typical of a human developer enabling tests for a newly supported architecture.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Unaddressed review comment from the PowerPC BPF JIT co-maintainer about __TARGET_ARCH_powerpc matching both PPC32 and PPC64, causing test failures on powerpc32 where private stack is not supported.

--===============6469514507980447881==--
