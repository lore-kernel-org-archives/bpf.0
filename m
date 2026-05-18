Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C33D31F9A1;
	Mon, 18 May 2026 11:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779105038; cv=none; b=lbB/6nZko3JCSA9n2o/ZW5/asjv9PabQaCkmDHegQNBYU3m++zAI6eXaA0/cG7sQKi9z4PpREOnsko3bonrINGp9trHo33ah1s/3hesMBZf1U+nWHrXE1CUbXfp8DhyhndV/TwogGngSR4s9M0a26HIbkVDdrTGrInu2c58uR4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779105038; c=relaxed/simple;
	bh=1JIo07qQczhfwuIsFODJJuB1qHJMGUp6WD5QFagu/fg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=A/JKMuTPrlB2VR8xISmKR0hFjVsTwdApd7+u7PCd8PU9hj3wnH03SeHhVYI9y7JDqMqOtM8roC3TzPGw9aKL+xm9jNQ2MeWtLfiYMPKNTpShgpoikvQjbbwHq6NW9wZj4Yu/RpboTGiXYrt5+o3OgIOTAvHPofOnb+lgzAszgAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h33ObMx2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h33ObMx2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71F1C2BCB7;
	Mon, 18 May 2026 11:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779105038;
	bh=1JIo07qQczhfwuIsFODJJuB1qHJMGUp6WD5QFagu/fg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=h33ObMx2pTJo/0sDEf+8/XYpYonhsHu7K61An7jgnzAgKRovb9jEEbXw6XACbmLg9
	 ASIcPYorH/gbL/zieQzn7rwB9xmbxyLc6oopIEuKZa5Ah9qtzYV21OqCpw8gCLYY1w
	 zhAjETx0Y4naqAxiYp8Dk90oJCcw1MCIfvXF1kNmWkFP4OMPsBNIWKz2BAnAqFSiAP
	 YVryQAs+aVJGolUgsGRjoTYMauEcpTWktws6FOhaIOinpk+MUg94Vce4OoHgf8Wkbw
	 l5fiu7YreZmTmx9TwMD0i/WDd4cqe5yypZz2XGI75vrsbYKEJDNDCzVtA0NCCz4AkE
	 TcmXSdqOna7zQ==
Content-Type: multipart/mixed; boundary="===============0995334349500366706=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8f529063bd4e4e1874fcc7a938ba5fb9a620d8c208b96f09aab524a7ffb379dd@mail.kernel.org>
In-Reply-To: <20260518105957.123445-8-jolsa@kernel.org>
References: <20260518105957.123445-8-jolsa@kernel.org>
Subject: Re: [PATCHv2 07/11] selftests/bpf: Change uprobe syscall tests to use nop10
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,oleg@redhat.com,peterz@infradead.org,mingo@kernel.org,mhiramat@kernel.org,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 18 May 2026 11:50:37 +0000 (UTC)

--===============0995334349500366706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> index 2f22ec61667b..bcc4820c802e 100644
> --- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
> +++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> @@ -398,7 +398,7 @@ static void *uprobe_producer_ret(void *input)
>  #ifdef __x86_64__
>  __nocf_check __weak void uprobe_target_nop5(void)
>  {
> -	asm volatile (".byte 0x0f, 0x1f, 0x44, 0x00, 0x00");
> +	asm volatile (".byte 0x66, 0x66, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00");
>  }
>
>  static void *uprobe_producer_nop5(void *input)

This isn't a bug, but should the function and benchmark names also be
updated? The function is still called uprobe_target_nop5() and the
benchmark exposes names like uprobe-nop5, uretprobe-nop5,
uprobe-multi-nop5, uretprobe-multi-nop5, and usdt-nop5, but they are
now all testing a 10-byte nop instruction.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
> index 69759b27794d..a160d7c4fa0d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> @@ -252,7 +252,7 @@ extern void usdt_1(void);
>  extern void usdt_2(void);
>
>  static unsigned char nop1[1] = { 0x90 };
> -static unsigned char nop1_nop5_combo[6] = { 0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 };
> +static unsigned char nop1_nop10_combo[11] = { 0x90, 0x66, 0x66, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 };
>
>  static void *find_instr(void *fn, unsigned char *instr, size_t cnt)
>  {
>  	int i;
>
>  	for (i = 0; i < 10; i++) {
>  		if (!memcmp(instr, fn + i, cnt))
>  			return fn + i;
>  	}
>  	return NULL;
>  }

Is the loop in find_instr() adequate to find this instruction sequence?
In uprobe_syscall.c, find_nop10() was updated to search up to 128 bytes
to account for compiler-generated prologues. If a modern compiler
generates a prologue longer than 9 bytes for usdt_2(), this will
prematurely terminate and cause the subtest_optimized_attach() test to
fail.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26030080109
--===============0995334349500366706==--
