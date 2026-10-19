Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E69933B6D9;
	Mon, 19 Oct 2026 02:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792378485; cv=none; b=ueIDkm9il7okChZg4ICe3zlTCuP5IHGp9gkL5j69lkOR08skw1LLiliMm2Uda256camm0z3XQrYia160aT7/LroNL6hAb4wOfLYgitIxAo6mwD4RS/L2qFFRLh9fLupwhI1PMLQegkVzkiCNH76cd2inlL0RHabwfgkOYW1u3kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792378485; c=relaxed/simple;
	bh=PVrwqvKEthX3wdksrrsEyThcG23HBrIFO7ww9PY3ijQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fTUK+GlRKVmRZJKkLu1dAWdxLEXmf9L2EKeDxEeDsdGaRYj2FhOrHlkZK+P16Y3eg1hlaW37OBSZz4SSvAfSIOacKq2F/0OVRFB7h2bFe9SMu4gxAdxWSj9QGgBY9Wnc+mfo9i/MHESDjzPsYeKBYbqA5Jc4xPuLPl6N3j0ziU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wrx8cCKf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wrx8cCKf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859F21F000C4;
	Mon, 19 Oct 2026 02:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792378483;
	bh=PtI6+dIwvwEK12mkJxGzJ4N6Vx3udLhLWvVW+I6u72g=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Wrx8cCKfzTS70Z5ArUfTv8HmdnKkcI2+h2LEzxUothWhGzJzhCSUG65PVTicZDSYL
	 KUIINwSA7qcgVFoQiXDfSWVYM4bYbRwM12aXkcZg3ROmylVWsC5dwXwTYw0e7jt6ox
	 8XTRzWHtsV1V5pK+osKdO1xNLle/IOzgSB/dnEYbZybP1gOdMkIVoDsXU0QeC93ouK
	 GSlc69pcmA8iEVk1th5jOj2O6BhT2d9G4XDHdP5brcoRFLFMLG9IUadHc4xqHlo1Ty
	 zW3u+sJhV4RvGLsN1qEeVQuMGF7S/GcjI1spqjK/qy2fWoGelGQKxP6ZOltTmzi7GM
	 q5CdnRcV0TVhw==
Content-Type: multipart/mixed; boundary="===============3370801737930680150=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ddd03929abea4bc45cd39901bf5fe7378ff634e0d6e71d948b8a47776c49604e@mail.kernel.org>
In-Reply-To: <20261019022705.30670-1-yangtiezhu@loongson.cn>
References: <20261019022705.30670-1-yangtiezhu@loongson.cn>
Subject: Re: [PATCH bpf-next] selftests/bpf: Use snake_case for subtest descriptions in jit_insns_arena.c
From: bot+bpf-ci@kernel.org
To: yangtiezhu@loongson.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 19 Oct 2026 02:54:42 +0000 (UTC)

--===============3370801737930680150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Use snake_case for subtest descriptions in jit_insns_arena.c

TL;DR: Commit message only: the snake_case rename is described as fixing a
test_progs filter parsing bug, but the failures come from unquoted shell
word-splitting; quoted names should already work, so the wording may be
inaccurate.

> selftests/bpf: Use snake_case for subtest descriptions in jit_insns_arena.c
>
> Normalize two inline assembly test descriptions in jit_insns_arena.c
> from space-separated strings to snake_case for consistency and to fix
> command-line filter parsing in test_progs. Otherwise:
>
> $ sudo ./test_progs -t jit_insns/arena access with zero offset
> Usage: test_progs [OPTION...]
> Try `test_progs --help' or `test_progs --usage' for more information.
>
> $ sudo ./test_progs -t jit_insns/cast to a user address
> Usage: test_progs [OPTION...]
> Try `test_progs --help' or `test_progs --usage' for more information.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

The commit message says the rename fixes "command-line filter parsing in
test_progs".  Is that description accurate?

In the quoted examples the shell word-splits the unquoted argument, so
test_progs receives extra positional arguments ("access", "with", "zero",
"offset").  parse_arg() in test_progs.c rejects those with:

    case ARGP_KEY_ARG:
        argp_usage(state);

and this happens before any filter is parsed.

The filter code itself handles spaces.  parse_test_list() splits only on
',', insert_test() splits on the first '/', and glob_match() compares
characters literally.  A quoted invocation such as:

    $ sudo ./test_progs -t 'jit_insns/arena access with zero offset'

should be accepted and match the subtest description through
match_subtest_desc().

Before this patch, -t jit_insns/arena_zero_off also worked, because
match_subtest_desc() additionally matches the BPF function name.

Other __description() strings in the tree contain spaces and show the same
shell-quoting behaviour when passed unquoted.

Could the commit message instead describe this as making the two names
convenient to pass unquoted on the command line, and consistent with the
snake_case names of the sibling subtests registered in test_jit_insns()
(alu_imm, alu_reg, ...), rather than as a fix for a parsing bug in
test_progs?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39190996107
--===============3370801737930680150==--
