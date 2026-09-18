Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B613368BD;
	Fri, 18 Sep 2026 08:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789718840; cv=none; b=EBm6Eyos8CxWsVrn1M859wBQJeLugZrkbpvOCxfZc6Ow4QUDosDn+uCuANb8sydHd3WquHwvyW6uVVedDOkK03fm1lL3q1xzh78cmK7xdrwQFgK0rIN/7XuZd86fRASd8JeL7DGCKaBS/sT4PR6ndId1WNb885MFZiaSp+25P5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789718840; c=relaxed/simple;
	bh=o7tPmMLnWOySzuuH11+7UgSh8Zn51tGFq5NyRcH52AA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FsUUvEL45DBkksb5SQ/ndy5wJZeOHySC1/+2qKe9bomBrrkfBt16Uz8Lzmj7RFq+LdqhqeDTpszQfCCOP96b2Gn9tLLlnchz+Wkt8jBFKPZcNtiVE/topmOItnFEN/JBjeAUstph9OO+2t6TS6SyIUf604/rmZlp6LFIWQ5pVno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzLAjqFr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzLAjqFr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C4A1F000FF;
	Fri, 18 Sep 2026 08:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789718838;
	bh=CN62GKBYW4Gh6bEa4wTsqXz2IMYSV3OeaKs617jAh5o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=EzLAjqFrG/HO3b+fLf1D9Lt53vKdK0OdUUVjk5YI3Lwzhadh+82qXHwYpuhwmQUCg
	 eOXEM2M6FedgnfOSuonmYdMRy/5J7ClJ9gSZ2Lp+u74Me/uicrhxCgdBsWv9BwPwxu
	 +YUYFNW3gjP3X5DMztp0Vuw3IIcTjj+viPvQKZz/HI1g2XQffgnEtZ08EbcVYBroRM
	 uTDk0CsvRTpR+4zqn1AayHLHNSCjYPp3t9HH0kLoFBC578e7ZNcTnxZ/O8qqJxv3wT
	 dTW1t1os0gil5fq9pnx5Q7gHqKbtNbp1WhYcclPslLeedj6HMicDWAf2A2p7UXOG57
	 PMonpcJTaZ/Uw==
Content-Type: multipart/mixed; boundary="===============2924590592151832210=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a96829b3ce33af67ccab9e1307714102daf95118dea89d95796ed440562acd12@mail.kernel.org>
In-Reply-To: <44f7fcfafd5f33072dd2b9abc31aa9bf5eacd9bb.1789714023.git.zhuhui@kylinos.cn>
References: <44f7fcfafd5f33072dd2b9abc31aa9bf5eacd9bb.1789714023.git.zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v12 2/2] selftests/bpf: Add memcg async reclaim test
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,roman.gushchin@linux.dev,inwardvessel@gmail.com,shakeel.butt@linux.dev,akpm@linux-foundation.org,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,david@kernel.org,baohua@kernel.org,geliang@kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-mm@kvack.org,linux-kselftest@vger.kernel.org
Cc: zhuhui@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 18 Sep 2026 08:07:17 +0000 (UTC)

--===============2924590592151832210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c b/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c
> new file mode 100644
> index 0000000000000..179b64fb6de84
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c

[ ... ]

> +	/*
> +	 * Optional baseline for the benchmark numbers below: run the
> +	 * same workload once without the BPF program, so the log can
> +	 * report how much async reclaim improved the pressured cgroup.
> +	 */
> +	if (bench) {
> +		err = run_high_low_workload(dir, &base_high_time,
> +					    &base_low_time, READ_TIMES);
> +		if (!ASSERT_OK(err, "run_high_low_workload baseline"))
> +			goto out;
> +
> +		/*
> +		 * The baseline left up to CG_LIMIT of page cache charged to the
> +		 * high and low cgroups, and memcg charges outlive the workload
> +		 * processes. Recreate the cgroups so that the instrumented run
> +		 * below starts from the same cold state the baseline did;
> +		 * otherwise the reported speedup compares a cold run against a
> +		 * warm one.
> +		 */
> +		cleanup_cgroup_environment();

Does this comment accurately describe why the cgroups are recreated?

Looking at run_high_low_workload(), its cleanup block closes all four file
descriptors and then unlinks all four temp files after both children have
been reaped. With link count zero and no remaining open descriptors or
mappings, the inodes are evicted, their page cache is truncated, and the
memcg charges are released - so memory.current for the high and low
cgroups is already back to near zero when control returns here.

What actually survives the baseline is memory.stat, particularly the
WORKINGSET_REFAULT_FILE counter that the BPF program samples via
should_reclaim_cgroup(). Without recreating the cgroups, wq_prog_init()
would start elem->prev_event at 0 while the counter is already large from
the baseline, so the very first timer tick would see a huge delta and kick
off a reclaim round unconditionally. Recreating the cgroups zeroes those
counters.

Could the comment be updated to describe that the recreation clears the
WORKINGSET_REFAULT_FILE counters in memory.stat rather than page cache
charges, which are already released when the files are unlinked?

[ ... ]

> +	reader_pid = spawn_keepalive_reader(data_fd);
> +	if (!ASSERT_GT(reader_pid, 0, "fork keepalive reader"))
> +		goto out;
> +
> +	/* Wait for reclaim rounds to reach the live target cgroup. */
> +	for (i = 0; i < EVENT_POLL_ROUNDS && !seen.called; i++) {
> +		n = ring_buffer__poll(rb, EVENT_POLL_TIMEOUT_MS);
> +		if (!ASSERT_GE(n, 0, "ring_buffer__poll"))
> +			goto out;
> +
> +		/*
> +		 * The reader loops until killed, so finding it already gone
> +		 * means the refaults the BPF program waits for never started.
> +		 * Report its exit code rather than letting the assert below
> +		 * blame the kernel for the full poll window.
> +		 */
> +		if (waitpid(reader_pid, &status, WNOHANG) == reader_pid) {
> +			/* Reaped, so cleanup must not signal a reused PID. */
> +			reader_pid = -1;
> +			if (WIFEXITED(status))
> +				PRINT_FAIL("keepalive reader exited early: %s",
> +					   child_exit_str(WEXITSTATUS(status)));
> +			else
> +				PRINT_FAIL("keepalive reader died, status 0x%x",
> +					   status);
> +			goto out;
> +		}
> +	}
> +	if (!ASSERT_GT(seen.called, 0, "reclaim events")) {
> +		report_timer_failures(skel);
> +		goto out;
> +	}
> +
> +	remove_cgroup(CG_DYING_TARGET_DIR);
> +
> +	/* Let reclaim passes that were already in flight drain. */
> +	usleep(DYING_SETTLE_US);
> +
> +	calls_before = skel->bss->reclaim_calls;
> +
> +	/*
> +	 * Wait for a reclaim round to hit the removed cgroup. Only TARGET_GONE
> +	 * ends the wait: an attempt that lands inside the rmdir window reports
> +	 * SKIPPED_DYING first, and stopping there would miss the events that
> +	 * follow it.
> +	 */
> +	for (i = 0; i < EVENT_POLL_ROUNDS && !seen.target_gone; i++) {
> +		n = ring_buffer__poll(rb, EVENT_POLL_TIMEOUT_MS);
> +		if (!ASSERT_GE(n, 0, "ring_buffer__poll"))
> +			goto out;
> +	}

The second poll loop here drops the keepalive-reader liveness check that
the first loop performs, although both loops depend on the reader equally.

TARGET_GONE is only emitted when a reclaim round actually starts, and a
round only starts when should_reclaim_cgroup() sees a fresh
WORKINGSET_REFAULT_FILE delta - which only happens while the reader keeps
refaulting. If the reader dies during this second window, refaults stop, no
TARGET_GONE ever arrives, and the test reports "no reclaim round hit the
removed cgroup (gone=0, dying=0)", blaming the kernel for a dead child.

That is exactly the misattribution the first loop added a waitpid(WNOHANG)
check to avoid. The reader's exit code is still available here, since a
reader that dies during the second loop is left unreaped until the out:
label. Should the second loop include the same liveness check to avoid
misattributing a dead reader as a kernel issue?

> +	/*
> +	 * TARGET_GONE is what the test can rely on: by the time rmdir has
> +	 * returned, bpf_cgroup_from_id() has stopped resolving the target.
> +	 * SKIPPED_DYING only happens if an attempt lands inside the rmdir
> +	 * window, so it is reported here rather than asserted.
> +	 */
> +	if (!seen.target_gone) {
> +		report_timer_failures(skel);
> +		PRINT_FAIL("no reclaim round hit the removed cgroup (gone=%d, dying=%d)",
> +			   seen.target_gone, seen.skipped_dying);
> +		goto out;
> +	}
> +
> +	/*
> +	 * Reclaim must have stopped with the target. Both counters stay put for
> +	 * the same reason: once rmdir has returned, bpf_cgroup_from_id() fails,
> +	 * so every attempt takes the TARGET_GONE path before it can reach
> +	 * reclaim_calls++. This therefore checks that reclaim really stops, not
> +	 * that cgroup_is_dying() works -- see that function in the BPF program
> +	 * for why the dying window cannot be hit reliably from userspace.
> +	 *
> +	 * reclaimed_bytes is compared against 0 rather than against its
> +	 * pre-removal value: the target is empty for the whole test, so
> +	 * bpf_proactive_reclaim() has nothing to reclaim and must have returned
> +	 * 0 on every call, before and after the removal alike. An "unchanged"
> +	 * comparison would be 0 == 0 and could never fail.
> +	 */

Does the reclaimed_bytes explanation make sense? The comment argues that
comparing reclaimed_bytes against a pre-removal snapshot "would be 0 == 0
and could never fail", but by its own premise that snapshot is 0, so the
snapshot comparison is literally the assertion that was written:
ASSERT_EQ(skel->bss->reclaimed_bytes, 0ULL). Both forms read
reclaimed_bytes after the removal window and both fail exactly when a
post-removal reclaim adds bytes; neither is vacuous and neither is stronger
than the other.

As written the comment tells a reader that one of two identical checks
cannot fail, which is misleading. Could it just state that
bpf_proactive_reclaim() returns 0 on the empty target throughout the test,
without the comparison that makes them sound different?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35318390791
--===============2924590592151832210==--
