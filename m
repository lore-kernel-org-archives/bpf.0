Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7991DDC1B;
	Fri,  9 Oct 2026 02:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791513057; cv=none; b=SqYe8RxS/64p6D3wzPqQhjGQ19XLTOvfrU3CmvN7vhyaI5iv/OWDnhpRrS+E2mt7PNZh33K3nzXS/HHkN4XKmT5Oke7pGTPkyb2OOZLvFKzAWUvBPCF4qwYWeGLDAws7hPDz8GOSYxTRlqiLR8I4SE8aw0MTdK28mRT3PsKtjKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791513057; c=relaxed/simple;
	bh=fOGcN6UzIi4o1Cy+F41LsQ7hqyprtLY4ArZeVW1jYls=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=vDzhZfq3bMMkWc4y4dmXdg1cImZUfCy5PNDaISo+Ox0etttAY3YSP7BdCWa38FVMnf0wEt2SAP4mtuxF3pGNhUXo00dnIEsE0e1xg/z7cDK4Cfu4M1wjexRnKe+jk/v1uxrsR5xua8RPqDvWRWxrVNnev7YSWuluSDcy7Wq1U8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POsErKbu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POsErKbu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14AC1F000FF;
	Fri,  9 Oct 2026 02:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791513052;
	bh=Y0viaUqLMu0Iy/XyHF0oELdeYqhsHiyJNe2//rvASGU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=POsErKbuF6AqC+eMVokkGYcDqXPlMNPm+Ddh8ut08YUomMuacU9QmUmhXoETAGson
	 HNeUCMWs8o8itezh8nyyE585GbGY+pAC1IIEL4cN0riSsDBFxRZHRF621zvKBrvVia
	 lTsRDSUCHmDhmwwuEL7+7CeSWUpI1F/1O3ZDLDXQrbu3UJ62zYyUW1JjEkNtAfjcPX
	 b0JnTxJJ17ZsADYnH4p55jysMfxMYf4b/xLxdS0zAPotXtXoveW1LpTNsJNR34GsMt
	 4d+8eJR9UbF7sT2K8Nr80HB1SWZde0GjJAR88JXrAASLH4euQiv/3RWlVVkGJhmXrI
	 Mvpk8sTwafSng==
Content-Type: multipart/mixed; boundary="===============7154618974049738489=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b5e8b2992ca673bba743e61f822566c6beac44e0e7e6997096f8681d1e36ef42@mail.kernel.org>
In-Reply-To: <20261009-selftests-bpf-mmap-wait-map-free-v1-1-96d066daea2d@gmail.com>
References: <20261009-selftests-bpf-mmap-wait-map-free-v1-1-96d066daea2d@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Wait until the .data map of test_mmap is freed
From: bot+bpf-ci@kernel.org
To: odys.yuan@gmail.com,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,odys.yuan@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  9 Oct 2026 02:30:50 +0000 (UTC)

--===============7154618974049738489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Wait until the .data map of test_mmap is freed

TL;DR:
- test_mmap's new unbounded wait may hang test_progs forever if the map leaks;
  the watchdog apparently won't kill it
- commit message's watchdog claim and ".data map" wording may be wrong

> diff --git a/tools/testing/selftests/bpf/prog_tests/mmap.c b/tools/testing/selftests/bpf/prog_tests/mmap.c
> index a271d5a0f7ab..0e297ed5da0f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mmap.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mmap.c
> @@ -280,7 +280,7 @@ void test_mmap(void)
>  	munmap(tmp1, map_sz);
>
>  	/* we need to wait for RCU grace period */
> -	for (i = 0; i < 10000; i++) {
> +	while (true) {
>  		__u32 id = data_map_id - 1;
>  		if (bpf_map_get_next_id(id, &id) || id > data_map_id)
>  			break;

Can this loop spin forever if the map is never freed?

The commit message relies on the watchdog to end the test:

> Poll until the map ID is gone. The watchdog of test_progs kills the
> test if the map is never freed.

Looking at watchdog_timer_func() in test_progs.c, the WD_KILL case only does:

    pthread_kill(env.main_thread, SIGSEGV);

It does not re-arm the timer, so it fires once.  main() installs the handler
with:

    struct sigaction sigact = {
        .sa_handler = crash_handler,
        .sa_flags = SA_RESETHAND,
    };

crash_handler() calls dump_crash_log(), prints a backtrace and returns.  It
does not call exit() or abort().  Since this SIGSEGV is sent by
pthread_kill() and is not a bad memory access, no faulting instruction runs
again after the handler returns, and SA_RESETHAND only resets the handler to
the default.

So the thread goes back into the loop, usleep() returns early with EINTR,
which the loop ignores, and polling carries on.  The sample output in commit
d9d4d127e813 shows the same behaviour: after "Caught signal #11!" the
send_signal test keeps running and reports "#292 send_signal:FAIL".  It only
stopped there because its blocking read() returned EINTR.

If the map is never freed, test_mmap would then loop forever.  That is the
mmap/prog/map reference leak this check is meant to catch.  Before the patch,
the same case failed after about 10000 iterations with "get_map_by_id_after
unexpectedly succeeded".

test_mmap is a parallel test, so with -j, dispatch_thread() would block in
read_prog_test_msg() waiting for MSG_TEST_DONE from the stuck worker and the
whole test_progs run never finishes.  In serial mode every later test is
blocked.  With -w 0 the watchdog is disabled and there is no message at all.
In a non-ASAN build the watchdog only prints a stack trace after 120s and the
hang continues.

Would a bounded wait with a much longer limit avoid the flake and still turn
a leak into a test failure?  For example,
tools/testing/selftests/bpf/prog_tests/tramp_prog_detach.c:wait_for_map_free()
polls bpf_map_get_fd_by_id() up to 100 times, 100ms apart.

Either way, should the sentence "The watchdog of test_progs kills the test if
the map is never freed." be corrected in the commit message?

This isn't a bug, but the subject and body call this "the .data map".  The
map in question is the user-defined BPF_F_MMAPABLE array named data_map in
SEC(".maps"), not a .data section map.  Could the wording be adjusted?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37873564350
--===============7154618974049738489==--
