Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D081B436367;
	Wed,  1 Jul 2026 11:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907045; cv=none; b=iHGl14CQF4F4FQzIrmkWG0SUc/IVB0EdzTUBcIbmGDRgclpPiZjtQznsakjvtWUHAp2tPiJwRMKRPi9v+bRaKJlEIOvYydCzLIGsTKjZX3Z23wS9Za7Dd22Cd3/G46jJOM9GjSJIKs+c7yK1xTKLoRMqJtjYzsJE6ybgdUqdaNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907045; c=relaxed/simple;
	bh=aRQAU9eT0foZSiswMsLlNuhtqqtImnalvsfnhIWO4ow=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Sf9THpquBkchOoa/q0L3qHeqdgrBu89WrEZ19b/q0qe7lWCq+L/uzqg7elZBzWwm9iFj98ZsVdONrMZbjNjregjcodTwC7MG1FVdeW3k05tJXnEtwdY+uUoxieNkSkXRd/MJmSplD7dBkh1hvP3asoMVW1/AImNzi8t00fkAVOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHvJIZcm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHvJIZcm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BC01F000E9;
	Wed,  1 Jul 2026 11:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782907044;
	bh=TxF4LBJSSES2Z56A4SYU4ACXyu8JScPWCypLcddMZdw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mHvJIZcmXaKwkze0V+bmeOYolEkabAnGQ6PBX0wCd53R8TBO6E0vAIj770TZhzcmD
	 zLjniCiliUMPqCsJaROX51xWxPCzFNZgmJq/AblHwKoQUsRcjv8IG0DKk/MYcIDOJg
	 rllQLhsjh3jEfNFegSQMNcpugmu2bbPuLk0y4Fm0iacySu6KByjxXvukwwlNAbrfoL
	 y7mEbRXF3jpCmoAnjZz/L2dAr9CDlGkc6Qw9Xe8ZiA9QsHSWtYRJKFK7O22mV3O/ev
	 IpJ3i5BovJeOzPqM6laDHuUfgvVVGL3kbNZPyV4q7LiLncdHHs1gfZ6MwspOFPNOZJ
	 EK/ymUwEzUnZw==
Content-Type: multipart/mixed; boundary="===============2796236423524058254=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <abc994f32124893b2dfca6678096a7eba977dace1550a393dfdc516d4350ff9a@mail.kernel.org>
In-Reply-To: <20260701111337.53943-13-jolsa@kernel.org>
References: <20260701111337.53943-13-jolsa@kernel.org>
Subject: Re: [PATCHv5 12/13] selftests/bpf: Add tests for uprobe nop10 red zone clobbering
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,oleg@redhat.com,peterz@infradead.org,mingo@kernel.org,mhiramat@kernel.org,andrii@kernel.org
Cc: jakub@cloudflare.com,bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  1 Jul 2026 11:57:24 +0000 (UTC)

--===============2796236423524058254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
> index fda3a298ccfc..8004c9568ffa 100644
> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c

[ ... ]

> @@ -340,6 +341,52 @@ static void subtest_optimized_attach(void)
>  cleanup:
>  	test_usdt__destroy(skel);
>  }
> +
> +/*
> + * Test that USDT arguments survive nop10 optimization in a function where
> + * the compiler places operands in the red zone.
> + *
> + * Signal handlers are prone to having the compiler place USDT argument
> + * operands in the red zone (below rsp).
> + *
> + * The nop5 optimization used CALL (which pushes a return address to
> + * [rsp-8]), the value at -8(%rsp) was overwritten. The nop10 optimization
> + * should escape that by moving stackpointer below the redzone before
> + * doing the CALL.
> + */
> +static void subtest_optimized_red_zone(void)

This isn't a bug, but the four-line "nop5 optimization used CALL ..."
explanation here reads nearly verbatim to the comment added above
uprobe_red_zone_test() in prog_tests/uprobe_syscall.c.

Since both tests probe the same mechanism, would a single copy (or a
shorter note pointing at the other) be preferable, so the two don't drift
apart?

One small wording note: "moving stackpointer below the redzone" uses
"stackpointer" and "redzone", while the rest of the change and the commit
message use "stack pointer" and "red zone".


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28514315910
--===============2796236423524058254==--
