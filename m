Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F376C3A1D14
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 06:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787122201; cv=none; b=lwfQ7pdIFkCNn8Aavv3mr5fhoGsRjKaIObQ3BZ7IQLr5AdGmHAwNf7h0t2ldMAHM6pmQ2DJEndS475v1GyQ8zpjFl4GNg4tdlfUF6aQ2Kk455xvJXaeHiDEaxUGdVQ+/0/HEYPX1fjVP9DF1OPPyahuo1ygAGNxRwdSvjIgxX6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787122201; c=relaxed/simple;
	bh=oPSrZj9RppNYB9mhJ/alZ1P8OjBa5YM2haGfz5swhg4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Q2kvFhlHECpSt5dBllOBdKHYiLHdgSlp1RSM82xJieKDXUEZv7RKUKbgfiBnbj/qWnMNGo+7eMuAss8YHExPXi5kAnKrVCWpHrA65SYM1/1DjfWaW0UfQkbW7A2i6hze+yYPnGbM04Krz+mqMhpgDwSdfsPGN/v1c836lLcVKM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VB/MdhDF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VB/MdhDF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3C81F00A3D;
	Wed, 19 Aug 2026 06:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787122199;
	bh=ejEZ4U9ZI9P8jQbCnLYEHxvphR7ZLM5TLBNmAcnMyKQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VB/MdhDF++Bm36TbnqPoNEWJ1aoaiInjKiUaILC4G3CaHCjgsL79pDAfI5OiN6ybD
	 7deLTCbTU0xJYHqyYiLNWHFLSmsshLpgyAIAFCz/lQ5I7yys3+PQ3XyXMQS3OQzC95
	 YfZDd2gbrd5y9Re/8AycNM8M2UFz8simSmMXjHZaLtycOpbIBRn8n+jLwg8s8tiUS/
	 bJfG2LxCRPPqP49CYIc5WFnX3sW4I8pxZ5JtPs7Or9GFQWKftTb6gUw6hGn7LshX2c
	 euWsWWzqVczaGDLNXjfSenk3KRKU9i+vCLKEUlPtwm2TjVrrrEGR7miMr7XXDE9hqt
	 oGlMuGEEpg2jg==
Content-Type: multipart/mixed; boundary="===============8591382915157929615=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <057ae35eeaccbbb9dc187bb5edbf0b29c974dab9bf2142c2ff924c12e9e21db4@mail.kernel.org>
In-Reply-To: <20260819055320.3300114-1-yonghong.song@linux.dev>
References: <20260819055320.3300114-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v7 08/10] selftests/bpf: Add C tests for 16-byte returns in R0:R2
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 19 Aug 2026 06:49:59 +0000 (UTC)

--===============8591382915157929615==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Add selftests that exercise a 16-byte return value passed in the R0:R2
> register pair, written in C so that they depend on the compiler lowering
> the register-pair return.
>
> The R0:R2 convention is only emitted by LLVM 23 and newer, and a by-value
> aggregate return does not compile at all before that, so the programs sit
> behind a __clang_major__ guard. An older compiler builds the dummy test in
> the #else branch instead, which keeps the object non-empty and says in its
> description why nothing was exercised.
>
> The kfunc tests are tagged __arch_x86_64/__arch_arm64 and skip elsewhere.
> Those are the architectures whose JIT advertises
> bpf_jit_supports_kfunc_ret_reg_pair(), which bpf_add_kfunc_call() requires
> before it accepts a kfunc returning more than 8 bytes, and they are also
> the only ones building the kfuncs.

The changelog states that x86_64 and arm64 are "the architectures whose
JIT advertises bpf_jit_supports_kfunc_ret_reg_pair()". Is this accurate?

Looking at commit 4b4530101f35 ("bpf: Wire up JIT support for 16-byte
kfunc returns"), the first patch of this same series, it adds
bpf_jit_supports_kfunc_ret_reg_pair() returning true to three JITs, not
two:

  arch/x86/net/bpf_jit_comp.c       bool bpf_jit_supports_kfunc_ret_reg_pair(void) { return true; }
  arch/arm64/net/bpf_jit_comp.c     bool bpf_jit_supports_kfunc_ret_reg_pair(void) { return true; }
  arch/riscv/net/bpf_jit_comp64.c   bool bpf_jit_supports_kfunc_ret_reg_pair(void) { return true; }

and its own changelog says so explicitly: "Only the x86-64, arm64 and
riscv64 JITs opt in so far." kernel/bpf/core.c keeps the __weak default
at false for everything else.

Stating the JIT capability as the reason for the architecture tagging
misleads a reader into believing riscv64 has no R0:R2 JIT support,
which is the opposite of what the series does.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32221968339
--===============8591382915157929615==--
