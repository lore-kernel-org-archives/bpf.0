Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A70428466;
	Thu, 30 Apr 2026 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777555855; cv=none; b=VLFegq0RmETxgf3B3bP3Y5pXYWJhiIJvFYHktOfgFfEUWPOCrN2OCpUi5fqbjjq7dHrV5jQdP/6r8zRS7vpLcHQGCiKYQiARAN3BpzHXc6CxwM098p2TnxXr8u8BGCBXRItURgO/0etN1qOPGlfOJsiLTV/LtAF6EA40/WYE9sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777555855; c=relaxed/simple;
	bh=ax+ZlzG3JzpEyOXWLGjBwvOJikwf72NuWSrlZfkyUjc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dqeAgQq7ggUubxy/u3wzqyWFC0RuAsN10wbU7S/E4cA3ojuZu4pxWOAKcIQbVj8NzaeeyehQgThFD3aCAHHSCfvzrLEbKvf9ozrEf625iJhYysAKECUgQmxyBYfyKxT3K99xZPUA8m7VxSEt/gtLB1O28Wvi5gSOLyNV/fzA49s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nn4ZH4IM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nn4ZH4IM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D509C2BCB3;
	Thu, 30 Apr 2026 13:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777555855;
	bh=ax+ZlzG3JzpEyOXWLGjBwvOJikwf72NuWSrlZfkyUjc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Nn4ZH4IM8mAh7wzJ7Hs0EXFwva7EvObCD/4pI2dNyr3Rd8YvWnQlzsOuPxRpurhzd
	 pW70HIQvfZfTMMqb1GWcwj6Fuv2Zy5IfF/unB3SHO1heMARKh1Phn9e7hPNSPDxL7C
	 a+mOQKAwoExvgQOl6oucmjb9mRsbS7SCD9y2daHw+GFE/6+kARMVTrwPWX6MR0Y7oJ
	 8bw793TBWO5W7zX5k3HdrJ0guU2H+FVT4YXyakStStq8ZN0Ri3LBsf2e1cu0D/HvWn
	 BHH0QXvkCD0b0R5co8ZszOWdH1LbwJlDPRm0Ez0GMpUhUa2H1rtSwgcZClYopog+vh
	 icong+Vjzp9ug==
Content-Type: multipart/mixed; boundary="===============9109038514088101794=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9f76c238686812e3453aa5541d2a6db53ece8414508a8176a6e556d1eb372254@mail.kernel.org>
In-Reply-To: <20260430-selftests-bpf_misconfig-v10-10-cd302a31af16@suse.com>
References: <20260430-selftests-bpf_misconfig-v10-10-cd302a31af16@suse.com>
Subject: Re: [PATCH bpf-next v10 10/11] selftests/bpf: Provide weak definitions for cross-test functions
From: bot+bpf-ci@kernel.org
To: rbm@suse.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,nathan@kernel.org,nick.desaulniers+lkml@gmail.com,morbo@google.com,justinstitt@google.com
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,llvm@lists.linux.dev,alan.maguire@oracle.com,rbm@suse.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 30 Apr 2026 13:30:52 +0000 (UTC)

--===============9109038514088101794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> index 35adc3f6d443..5a864cd8ad1b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> @@ -252,10 +252,17 @@ static void kprobe_multi_attach_api_subtest(void)
>  	kprobe_multi__destroy(skel);
>  }
>
> -/* defined in prog_tests/uprobe_multi_test.c */
> -void uprobe_multi_func_1(void);
> -void uprobe_multi_func_2(void);
> -void uprobe_multi_func_3(void);
> +/*
> + * Weak uprobe target stubs. noinline is required because
> + * uprobe_multi_test_run() takes their addresses to configure the BPF
> + * program's attachment points; an inlined function has no stable
> + * address in the binary to probe. The strong definitions in
> + * uprobe_multi_test.c take precedence when that translation unit is
> + * linked.
> + */
> +noinline __weak void uprobe_multi_func_1(void) {}
> +noinline __weak void uprobe_multi_func_2(void) {}
> +noinline __weak void uprobe_multi_func_3(void) {}

Can compiler optimization passes like Identical Code Folding (ICF) merge
these three structurally identical weak stub functions into a single
memory address?

If they are folded into a single address, bpf_program__attach_uprobe_multi()
would attach three separate uprobes to the exact same offset, each with a
different cookie. Calling any of the functions would then execute the shared
address, triggering all three uprobes simultaneously:

  uprobe_multi_test_run() {
      uprobe_multi_func_1();  // triggers all 3 uprobes
      uprobe_multi_func_2();  // triggers all 3 uprobes
      uprobe_multi_func_3();  // triggers all 3 uprobes
  }

This would increment the BPF program counters multiple times per call,
causing assertions like:

  ASSERT_EQ(skel->bss->uprobe_multi_func_1_result, 1, ...);

to fail deterministically, as the result would be 3 instead of 1.

Would it make sense to make these stubs structurally unique, perhaps by
adding unique inline assembly to each?

This concern was raised by sashiko-bot@kernel.org in v9:
https://lore.kernel.org/bpf/20260429212931.44DD4C19425@smtp.kernel.org/

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25167006036
--===============9109038514088101794==--
