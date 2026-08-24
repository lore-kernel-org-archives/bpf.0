Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8577C2B2D7
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563491; cv=none; b=ttzIztGJrJxQFfkOWkQQHwrLbsppUMmLp+YdWl5vBN2WRx2y6HSv5wQFssx0cW/t8CA9athdeCLUEztk2YU59fKatAFxtTPy3f+hRGAVwmhddQsnmdmhtqsuqmAYeE3GPqgwqyY1rx65VGyXHXmxz+1YZaoYbhQ6tsDjZQHeVc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563491; c=relaxed/simple;
	bh=CahNCo/layAnikb1E/CdoBTlUcB4mxxs289DRcrbqfw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Kbl9A3SrqGLonkJwM6sgap1SRNdTfxQZiAMX+tjojVQCnngzNB5q18FV7ThR7ft0uEghD/V45pSJ5nQHgCN0qZmbmnQop+D2p9PtkrCt7IlD73nMXRXgDVyvTVUdg1z/D/bFNcuRj5AFX/Wki4G1bZuNWWs44WjdhSCiuZ0hL0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASy2NfkW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASy2NfkW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20D81F000E9;
	Mon, 24 Aug 2026 09:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787563490;
	bh=YA168WuuWzc62p48NphMDqE11mVO48Svw5W4+Ib86To=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ASy2NfkWbekmbLWXmwuQFB1QhVuNw1bPj+YEt4WOhYSAq3iof0ZvYcctPb7GulNTD
	 qPUJQEejBxYrRcOYwa/0po9dC3zFzAp5J4+NFYoCdUaSQdnyLPns6oLwQ2IIeS5BFk
	 zjUk4vxW/PehffK+0hGTGM7c12rO82buJGwDEMmcc5g/22Z9gATY7IHQEqmvTS6geY
	 eJHLNlYMPMwPTSImJ9TchddLQwt0ljCDmnWBcDo+vxxbb8q5Owh7/tfpbcknJFDjKM
	 MnWHJpwiyqZT3pNi3bLQVMxHPRB0n0E8vNj7sBtJoJVMTsM37dbbhU2947VhztizVu
	 geV/077markAQ==
Content-Type: multipart/mixed; boundary="===============8346699096990511389=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e1dec361baff00b14ad98b89a3cbaa07caf4b3980b946ac4d888f602399f3663@mail.kernel.org>
In-Reply-To: <20260824082530.47553-4-emil@etsalapatis.com>
References: <20260824082530.47553-4-emil@etsalapatis.com>
Subject: Re: [PATCH 3/3] selftests/bpf: Test large allocations for both sleepable/nonsleepable arena users
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 24 Aug 2026 09:24:49 +0000 (UTC)

--===============8346699096990511389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> index 6ab8730d4878..e388a67d9129 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c

[ ... ]

> @@ -284,6 +284,7 @@ int big_alloc2(void *ctx)
>  	return 0;
>  }
>
> +/* Nonsleepable because it binds to a socket program. */
>  SEC("socket")
>  __success __retval(0)
>  int big_alloc3(void *ctx)
> @@ -300,7 +301,31 @@ int big_alloc3(void *ctx)
>  	 */
>  	pages = bpf_arena_alloc_pages(&arena, NULL, 2051, NUMA_NO_NODE, 0);
>  	if (!pages)
> -		return 0;
> +		return 1;

Is it safe to make big_alloc3 fail the test when allocation fails?

The commit message says "add extra testing for that case," but the pre-existing
big_alloc3 deliberately tolerated allocation failure with 'return 0'. This
matters because big_alloc3 is SEC("socket"), and BPF_PROG_TEST_RUN executes
socket programs with local_bh_disable():

net/bpf/test_run.c:bpf_prog_test_run_skb()
    local_bh_disable();
    ...
    ret = bpf_test_run(skb, repeat, &retval, &duration, false);
    ...
    local_bh_enable();

That makes preempt_count() > 0, so is_bpf_alloc_nonsleepable() returns true
and bpf_arena_alloc_pages() selects arena_alloc_pages_non_sleepable() (as
intended, matching the commit message "different code paths ... depending on
whether the caller is sleepable or not").

The non-sleepable path can legitimately return NULL for reasons that aren't
kernel bugs. From d1f68a079731 in this same series:

    "This forces the use of alloc_pages_nolock() in the BPF allocator ...
     This in turn causes allocation failures even in cases where falling
     into the allocator slow path and possibly sleeping would eventually
     succeed."

So a 2051-page nolock allocation can fail when ZONE_NORMAL is below the min
watermark, or memory is fragmented, or the test runs on a busy CI VM. With
'return 1', big_alloc3 would report a false regression in those cases, even
though the allocator is working as designed.

Would it make sense to keep the tolerant 'return 0' for big_alloc3 (the
non-sleepable variant that uses alloc_pages_nolock), and reserve the strict
'return 1' for the new big_alloc4 (the sleepable variant that can use the
slow path)?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32709208315
--===============8346699096990511389==--
