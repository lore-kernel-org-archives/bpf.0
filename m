Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02820473C91
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 11:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784807396; cv=none; b=jMZfmWDdRuL/5cHWPThJyWU8xwUzke6HE7/a44PzB6UAS43O7Wbldb77MsXj1USDtqdsomnnynb0j34WNZGvWjfOEouzdl7I4Ad8icgmZN6lYGDVr9oHVq3A24z9WM/04yW0S4c1PUMXF4ph76NtNf/JByVxWznWwcV4L0+4iU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784807396; c=relaxed/simple;
	bh=isPwUYVD50HE1xYJc8bY36U9sDqu8s4xj3vCMReej48=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uwRLuLXEuanw9cD/ShpfOoiPGrXl29q6IagxaMhlNPEY1HZsFRtEjEBK5Ckokt4/b4/AM9Ff1Ft6TRIIlhmxqM5wIhfWY2wl9ZhfW1A8A/tUxWtiL/i0Ar8xt52fBiWbxyYy/YNbl1KNvVGaZ3uhIgoH/1R6a+J4hI17u6yDwD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55571F000E9;
	Thu, 23 Jul 2026 11:49:48 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix flaky refcount asserts in
 map_kptr_race
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxim Khmelevskii" <max@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260723114042.559926-2-max@linux.ibm.com>
References: <20260723114042.559926-2-max@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 11:49:48 +0000
Message-Id: <20260723114948.B55571F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The polling loop in `wait_for_refs` continues retrying after a f=
atal error in `read_refs`, causing unnecessary delays and test log spam.
- [Medium] A Time-Of-Check to Time-Of-Use (TOCTOU) race exists between `wai=
t_for_refs()` and the subsequent `ASSERT_EQ()`, which can still cause flaky=
 test failures.
--

--- Patch [1]: [PATCH bpf-next] selftests/bpf: Fix flaky refcount asserts i=
n map_kptr_race ---
commit a9dbb8ca45d040e8f920633939d7db5945ecaca2
Author: Maxim Khmelevskii <max@linux.ibm.com>

selftests/bpf: Fix flaky refcount asserts in map_kptr_race
   =20
bpf_testmod shares objects across tests, including the prog_test_struct.
Refcounter release is deferred behind an RCU grace period, so it may still
be pending. This patch adds wait_for_refs to prevent flaky failures when
other tests have contaminated the refcount.

> diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c b/too=
ls/testing/selftests/bpf/prog_tests/map_kptr_race.c
> index 506ed55e85289..5a543b3465a80 100644
> --- a/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
> +++ b/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
> @@ -28,6 +28,15 @@ static int read_refs(struct map_kptr_race *skel)
>  	return skel->bss->num_of_refs;
>  }
> =20
> +static void wait_for_refs(struct map_kptr_race *skel)
> +{
> +	for (int i =3D 0; i < 500; i++) {
> +		if (read_refs(skel) =3D=3D 2)
> +			return;
> +		usleep(10 * 1000);
> +	}
> +}
> +

[Severity: Medium]
Since read_refs() uses ASSERT_OK() which logs an error message on failure
and returns -1, does this loop introduce a regression by failing to handle
fatal errors correctly?

If read_refs() returns a negative error code (for example, if
bpf_prog_test_run_opts fails), it appears this loop will ignore it and
retry 500 times.

This would result in 500 redundant assertion failures in the test output
and an unnecessary 5-second stall before the test finally fails.

Could we add a check to break early if read_refs() returns a value < 0?

[ ... ]

> @@ -73,6 +82,7 @@ static void test_htab_leak(void)
>  		sched_yield();
> =20
>  	ASSERT_EQ(watcher->bss->map_freed, 1, "map_freed");
> +	wait_for_refs(watcher);
>  	ASSERT_EQ(read_refs(watcher), 2, "htab refcount");
> =20

[Severity: Medium]
Is there a potential time-of-check to time-of-use regression here that could
still result in flaky tests?

wait_for_refs() waits for the condition and returns, but then the shared
state is read again via ASSERT_EQ(read_refs(watcher), 2).

Because tests run in parallel and share the bpf_testmod kernel module,
another test could increment the refcount in the unprotected window between
wait_for_refs() returning and read_refs() executing inside the assertion.
This same pattern also appears in test_percpu_htab_leak() and=20
test_sk_ls_leak().

Could wait_for_refs() return the final refcount value or boolean success
status so the double-read can be avoided?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723114042.5599=
26-2-max@linux.ibm.com?part=3D1
