Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2286B3BB13C;
	Tue, 26 May 2026 21:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832009; cv=none; b=drtW+TE1ShH6mDmbjzK3HqcAqMpm4hJlW5e1Zi5LeEX6KGiC5hut5wuhUdBMZLyugdfGR/0pbVzcOPjQxt0uVjUPvCnN6DlbPZbj61SiWHRrgy6UdtsB0A5IJQ0kLoV9yRnypBr3rW1iVHjJW5L2AzTYSrYgN4bDORk8ttd78Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832009; c=relaxed/simple;
	bh=mF25qPSgUN7zkWPUnZPmf+MPex4uXHf6ISClWYVzdCM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jvle0g4Rl1BKTdn/FnpYIdA7Pzth7QucdPtO1lbPh/+TC/51DhnSgB87Z6xJf13hEn+psHvPwg2+iSv5jmTDzs3L5NXfpUCt985Xiu6EUpAtnAR6pqMe7dNfU/wrAcrb2SkocnO13oFORscJTv+4MLq4Yr1q/1PLfzDWBgROkzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLoUBkIt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLoUBkIt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5081F000E9;
	Tue, 26 May 2026 21:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779832008;
	bh=mbHs/GRquYcoM0L4/6nf3YW++c5KA1EbR3frRwzWUIE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kLoUBkItQ7Jh+Vsm5WeZOf1aausqutPs++Un1g8u7XI8jjaT8u7N2R+FDHvg7WuCc
	 Luax2bagWCWttwtYZqxiOaIcB647tTYdyBN/0c8j+Q4fXDKfk854b+PZmS9c8TeFRE
	 Col9HFEnY59KtIgFjWCtIYAt4GbCh2HwqQTJBLDxrHx0z+PCNLsIn5Dnujq9M7XJql
	 H8x6/2hBhvTZ/+Gq3zKyRCXsideZiEMewPzZfvFx0UUyNvFkxfS3JwqF8Xbbg8fu0l
	 2tHsYsy/1K0fcNdVCmlHtFKmtLx1BdhhoeYKoLXZ27Y/AnF3iywviki6QyCbkDtAYe
	 STnHH6FhxPSNQ==
Content-Type: multipart/mixed; boundary="===============2734041602245654829=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8d40660db2d86430f00269c1d40bf64b3ac703339664230a19584462910132bf@mail.kernel.org>
In-Reply-To: <20260526205840.173790-9-jolsa@kernel.org>
References: <20260526205840.173790-9-jolsa@kernel.org>
Subject: Re: [PATCHv4 08/13] selftests/bpf: Emit nop,nop10 instructions combo for x86_64 arch
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,oleg@redhat.com,peterz@infradead.org,mingo@kernel.org,mhiramat@kernel.org,andrii@kernel.org
Cc: jakub@cloudflare.com,bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 26 May 2026 21:46:47 +0000 (UTC)

--===============2734041602245654829==
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

Does this change break the USDT selftest?  Multiple reviewers raised
concerns across v1 through v4 that subtest_optimized_attach() in
prog_tests/usdt.c searches for the old 6-byte nop1_nop5_combo sequence.
When usdt_2.c emits the new 11-byte nop,nop10 instead, find_instr() will
return NULL and fail the ASSERT_OK_PTR check.

You mentioned in v1/v2 that the test would be updated in a following commit,
preferring to keep changes separated for easier review.  However, this creates
a git bisect regression where the test breaks at this commit. Should the test
update be squashed in to avoid breaking bisectability?

The commit message contains a placeholder reference:

>     Syncing latest usdt.h change [1].
>
>     Now that we have nop10 optimization support in kernel, let's emit
>     nop,nop10 for usdt probe. We leave it up to the library to use
>     desirable nop instruction.
>
>     [1] TBD

This isn't a bug, but the "[1] TBD" should either be filled in or removed.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26475828601
--===============2734041602245654829==--
