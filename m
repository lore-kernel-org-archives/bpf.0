Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EA6211A28;
	Thu, 21 May 2026 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369963; cv=none; b=u9hJrh2uwHw39Ax9OxADRg1WbjPtAcdDTP9qmgWhEFZtgTIvL1sORaM4OhOyu7WN45IkT1sGHHVv0eDDZV5bFvPMS58ySpEZ96R5+W3PgKbaAJaLdhsuLaX754UpT2YjpLDQ1QFAZ91U0WLQkH3xLWQ3lUV8eS/iGIa2qfqkCRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369963; c=relaxed/simple;
	bh=qJE96cj3vN7uTJYT6K1TacTXmymIk0z4VB8/y6H9RIs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WWYgTEuDu6Kh4pcWAz7NfoRJlJjx759TwoR3vtCmt8UYGFL3EaQU7nA8Q5YoMjbZkNwDpem70FWWkpOa8zse0/Org7RRv5wQGC/UjM9f1HyWh9CawxweaJIyONzmlb88TRtG3msG88ftfiOeu82WSyErCB/q7qNd4gYb0oKSYkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZu+YWUT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZu+YWUT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802BD1F000E9;
	Thu, 21 May 2026 13:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779369961;
	bh=lUh2hLJrJ9LiSIImxUrxQdXxZoykOEujYGNMMpyflbU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=FZu+YWUTrggkju81+sJ9agF8gbs9FZP7Q2yPnuMbZYDpGnoigIWg4I3SW1Z6W8xIt
	 50AHOGPU6oXhsKq+VQvuigUxPNnhMIdt5hW3EqMbkBQh+EyANRqvBr+Me/w2cPeZ14
	 U2QiZQBIyIrPOc2q+Myp+PRu6dEji1ZckC2mNCDVUaPDES2dpVo0+jhdDJaJdMVuT5
	 hsLH7jF6JXbOJGUxpBT2H4b3NIL9n2U5+3Z+TMohYwiuUTuMul3ulTULdSy4zMt+5E
	 ePx7fafZ8Dpuakthf+w1GDE6M2o7wOBmQgucIFip6LDZcuOiwG12Bs2RTemtZoiuFy
	 aLba05/pdpW+A==
Content-Type: multipart/mixed; boundary="===============5374997729471278115=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6a28fe5baa4a8735ac0e1e4fc2075563d9918e94597d06ea7bb3d3ab86482253@mail.kernel.org>
In-Reply-To: <20260521124411.31133-8-jolsa@kernel.org>
References: <20260521124411.31133-8-jolsa@kernel.org>
Subject: Re: [PATCHv3 07/12] selftests/bpf: Emit nop,nop10 instructions combo for x86_64 arch
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,oleg@redhat.com,peterz@infradead.org,mingo@kernel.org,mhiramat@kernel.org,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 21 May 2026 13:26:01 +0000 (UTC)

--===============5374997729471278115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/usdt.h b/tools/testing/selftests/bpf/usdt.h
> index c71e21df38b3..75687f50f4e2 100644
> --- a/tools/testing/selftests/bpf/usdt.h
> +++ b/tools/testing/selftests/bpf/usdt.h
> @@ -313,7 +313,7 @@ struct usdt_sema { volatile unsigned short active; };
>  #if defined(__ia64__) || defined(__s390__) || defined(__s390x__)
>  #define USDT_NOP			nop 0
>  #elif defined(__x86_64__)
> -#define USDT_NOP                       .byte 0x90, 0x0f, 0x1f, 0x44, 0x00, 0x0 /* nop, nop5 */
> +#define USDT_NOP                       .byte 0x90, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 /* nop, nop10 */
>  #else
>  #define USDT_NOP			nop
>  #endif

Does changing this instruction sequence from 6 bytes to 11 bytes break
prog_tests/usdt.c? The test in subtest_optimized_attach() searches for the
old 6-byte nop1_nop5_combo sequence:

tools/testing/selftests/bpf/prog_tests/usdt.c:
    /* usdt_2 USDT probe has nop,nop5 instructions combo */
    addr_2 = find_instr(usdt_2, nop1_nop5_combo, 6);
    if (!ASSERT_OK_PTR(addr_2, "usdt_2_find_nop1_nop5_combo"))
        goto cleanup;

Because the old sequence is no longer emitted by USDT_NOP, find_instr() will
return NULL, causing the ASSERT_OK_PTR assertion to fail. Should the test
update be squashed into this commit to avoid breaking git bisect?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26227520868
--===============5374997729471278115==--
