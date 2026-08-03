Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776B03E5A38;
	Mon,  3 Aug 2026 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785770153; cv=none; b=Vw/hl+aqI4B2emSezwN4KPtDrI7UGcUULlIDedRmZR845A6Qna2yWZxPyuZg9KPCTGTlQ1hxwgLxd9GvMsJk9kwMTjmJ872fBz3fo4lqi58O3/jyWLXtlUTVIIflbQvN9wxwc4M4kYzXAO3Lkz5LXlVLGiAkgQa1JKVviJ2gUng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785770153; c=relaxed/simple;
	bh=C1gy7O+NaDG4RdgTsdh/63ebki0rwc1rcMQZbmMV9gM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jk39k08E8cC77fgUfJA1yqvR3Fz7PGEoCi7Ub1CBNVHmLq20IVKrI2O4npI56seIa+rKEDzoceEjKHEjGr8cov7SMvTQh97lT+f3eysOTY4jmTCz679p4IePNjCwnQlcMw8t19c45WFPChdI+v51XcyenWa5ywEZzxfQraGYPlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtzvlPls; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtzvlPls"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DDB1F000E9;
	Mon,  3 Aug 2026 15:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785770152;
	bh=1G/wAajG/qSsSmDrTvOz8OLqGc7jTAeJtxYYv6rGVMo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RtzvlPlsCdORgEXHh3zPg+ZcGTOZrOcBwMsxbnnkkrJqEOpCpTz/+bUyJ2+m3IUiR
	 1WjAOk3Bua9ZHjDnYVjXVqn59i0ezmec9Yy1cepMSayfF7YgkficB8y+MAAxMbukmb
	 wAR4vVBBwrDhyXZ5yCdQndOZ2J0ZVCDwmOosdGAKJdV9K85MMTcXlP5TBsJbDHwESP
	 YVt7sCsP/Appov7s9y+KClr2B7PEY2ReAdC65tqah8vaoCwx6EMFKJZkBSNuUu2PA2
	 86VPCWSL4SyYfgwmGRcGEmdxkNeVDRinGJX8x0mBSxun7uWldbFbpC6thMvAEHUvnG
	 +ayxPVC223HYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] selftests/bpf: Add a call_srcu() re-entry
 reproducer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260803135329.2327280-6-puranjay@kernel.org>
References: <20260803134839.2103051-1-puranjay@kernel.org>
 <20260803135329.2327280-6-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 15:15:51 +0000
Message-Id: <20260803151551.C1DDB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing control flow branch after ASSERT_OK failure for bpf_map_=
delete_elem in test_rcu_reentry.
- [Medium] The BPF test program unconditionally marks itself as successful =
even if it fails to trigger the nested RCU callback.
--

--- Patch [6]: [PATCH v2 6/6] selftests/bpf: Add a call_srcu() re-entry rep=
roducer ---
commit 60310d36c31afce9ef7c76534688f89f2ffa0f29
Author: Puranjay Mohan <puranjay@kernel.org>

selftests/bpf: Add a call_srcu() re-entry reproducer

This commit adds a BPF selftest to exercise call_srcu() re-entry safety. It
uses an fentry program on rcu_segcblist_enqueue() to perform a task-storage
delete, which defers work via call_rcu_tasks_trace() and re-enters the
enqueue on the same CPU.

> diff --git a/tools/testing/selftests/bpf/prog_tests/rcu_reentry.c b/tools=
/testing/selftests/bpf/prog_tests/rcu_reentry.c
> new file mode 100644
> index 0000000000000..f6ecd93be30f4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/rcu_reentry.c

[ ... ]

> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0

[ ... ]

> +	/* Arm the handler for this thread, then trigger call_rcu_tasks_trace()=
. */
> +	skel->bss->target_pid =3D syscall(__NR_gettid);
> +	err =3D bpf_map_delete_elem(map_fd, &pidfd);
> +	ASSERT_OK(err, "boot_delete");
> +
> +	/* Only Tree SRCU enqueues via rcu_segcblist_enqueue(); skip elsewhere.=
 */
> +	if (!skel->bss->hits) {

[Severity: Medium]
Should this ASSERT_OK() call be placed inside an if statement?

If bpf_map_delete_elem() fails, the boolean return value of ASSERT_OK() is
ignored and the code falls through. The test will evaluate if (!skel->bss->=
hits)
and incorrectly skip instead of properly aborting.

> +		test__skip();
> +		goto out;
> +	}
> +	ASSERT_EQ(skel->bss->reentered, 1, "reentry_deferred");
> +out:
> +	if (pidfd >=3D 0)
> +		close(pidfd);
> +	rcu_reentry__destroy(skel);
> +}

> diff --git a/tools/testing/selftests/bpf/progs/rcu_reentry.c b/tools/test=
ing/selftests/bpf/progs/rcu_reentry.c
> new file mode 100644
> index 0000000000000..d92a927ff51c0
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/rcu_reentry.c

[ ... ]

> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0

[ ... ]

> +SEC("fentry/rcu_segcblist_enqueue")
> +int BPF_PROG(reenter)
> +{
> +	struct task_struct *cur;
> +
> +	if (reentered || !target_pid)
> +		return 0;
> +
> +	cur =3D bpf_get_current_task_btf();
> +	if (!cur || cur->pid !=3D target_pid)
> +		return 0;
> +
> +	/* Re-enter via a task-storage delete, which calls call_rcu_tasks_trace=
(). */
> +	__sync_fetch_and_add(&hits, 1);
> +	bpf_task_storage_get(&task_stg, cur, 0, BPF_LOCAL_STORAGE_GET_F_CREATE);
> +	bpf_task_storage_delete(&task_stg, cur);
> +
> +	reentered =3D 1;

[Severity: Medium]
Will this unconditionally mark the test as passed even if the BPF program
failed to trigger the nested callback?

If bpf_task_storage_get() fails (e.g., due to memory limits), the subsequent
bpf_task_storage_delete() will safely fail without triggering the nested
call_rcu_tasks_trace(). The tested deadlock path is never exercised, but
reentered is still set to 1, which will cause the userspace test to assert
success.

> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803134839.2103=
051-1-puranjay@kernel.org?part=3D6
