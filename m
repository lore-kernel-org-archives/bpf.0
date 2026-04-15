Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF95386429
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 20:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776285158; cv=none; b=ZaB/k5yfPACcUsZDY8MFuoe42MGtUnLHexA5gHcXX6Lvrn02fG063B1qDimgmq0RRZ2NWLavZjC22X+AlgnKTxD5o7kE/zIOiIp938gkovzwpcQYXdrCNH/vAEHZ+2kaBt57KuVY4belSSt6Dbpo4bfpVCD8e88/IKZBqr6wZmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776285158; c=relaxed/simple;
	bh=oYVNkZQ8rPmcj+mN1HlW9dMhjMy7gew1Sec6LKVxIpo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I6tJ4ZDR4Z5zjL0I9mOU50tvPP+P0TIN+qOu3oI+qyKSnEJng2H40x69X1QSPhUcTV8oDuHzlpMRbK2yR/OCG6nkTb+QH+YSJqTfDXZnyAL44v/k4dq4wDuGenv0ZyTqkHim+P8VgynKsBP/QwCQYmMG6UxvT5HpNAa88GldECQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQuKT1Qi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQuKT1Qi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92500C2BCB4;
	Wed, 15 Apr 2026 20:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776285157;
	bh=oYVNkZQ8rPmcj+mN1HlW9dMhjMy7gew1Sec6LKVxIpo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=CQuKT1Qihq4NbIKUmQqBE/NLA45JqdT7KA70qKOAzfuCd+jH8ZMI3U394OnOMpJOr
	 ydTxwwrpEf33/4AVsaTxRHHfAP+wyiWU+9I5SlCTgPt7gJleVo5IREL7CtQlkWqmZc
	 kCERPklJ1lEUjfFIjrD3Mho3ihiil6OsB3MnmiVC06Oqgffbny7AHcM2CWD1yL9UXS
	 hpKQOkl5OxWsIEQ6RmPGRWvBGvzjpiK1FJrThxlZDyL2uni4MrAm2GJlFOxDs2kuQz
	 1Klegilrapwj7skzAUXzDt83Dgm+N5y7NlQ4UqKnyIpCh+L3awF8vVkgt7twlhDVYU
	 +/zXUvhDhBB3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v10 6/6] selftests/bpf: Add tests for sleepable
 tracepoint programs
Reply-To: sashiko@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260415-sleepable_tracepoints-v10-6-161f40b33dd7@meta.com>
References: <20260415-sleepable_tracepoints-v10-6-161f40b33dd7@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Apr 2026 20:32:37 +0000
Message-Id: <20260415203237.92500C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] The test uses libc's `struct timespec` and `__NR_nanosleep`, cau=
sing out-of-bounds reads in the BPF program and test failures on 32-bit arc=
hitectures.
- [Medium] Resource leak in `test_attach_reject()` when program attachment =
unexpectedly succeeds.
--

commit 464b100e0185655df5851c1f5731b7cd7fb84bb1
Author: Mykyta Yatsenko <yatsenko@meta.com>

selftests/bpf: Add tests for sleepable tracepoint programs

This commit adds tests for sleepable tracepoint programs covering various
attachment types. It verifies functionality using bpf_copy_from_user()
on nanosleep and checks attachment rejection for non-faultable tracepoints.

> diff --git a/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints=
.c b/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c
> new file mode 100644
> index 0000000000000..bdc7fe294e7c9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c
[ ... ]
> +static void run_test(struct test_sleepable_tracepoints *skel)
> +{
> +	skel->bss->target_pid =3D getpid();
> +	skel->bss->prog_triggered =3D 0;
> +	skel->bss->err =3D 0;
> +	skel->bss->copied_tv_nsec =3D 0;
> +
> +	syscall(__NR_nanosleep, &(struct timespec){ .tv_nsec =3D 555 }, NULL);

Could this cause out-of-bounds reads in the BPF program and test failures on
32-bit architectures? On 32-bit systems, __NR_nanosleep invokes the legacy
32-bit syscall which expects an 8-byte struct old_timespec32 argument.

Because the BPF program in test_sleepable_tracepoints.c casts this to
struct __kernel_timespec * and reads from it:

static int copy_nanosleep_arg(struct __kernel_timespec *ts)
{
	long tv_nsec;

	err =3D bpf_copy_from_user(&tv_nsec, sizeof(tv_nsec), &ts->tv_nsec);
	...

it would read uninitialized stack memory past the end of the provided 8-byte
struct, potentially resulting in garbage data or an -EFAULT.

[ ... ]
> +static void test_attach_reject(struct bpf_program *prog)
> +{
> +	struct bpf_link *link;
> +
> +	link =3D bpf_program__attach(prog);
> +	ASSERT_ERR_PTR(link, "attach_should_fail");
> +}

Does this leak the bpf_link if the attachment unexpectedly succeeds?

If bpf_program__attach() succeeds when it shouldn't, ASSERT_ERR_PTR() will =
mark
the test as failed, but execution will continue. Since test_progs is a long=
-lived
process, the unreleased file descriptor would keep the sleepable BPF program
attached to global tracepoints (like sched_switch) for the remainder of the
test suite execution, potentially causing cascading failures or side effect=
s.

Should this link be destroyed if ASSERT_ERR_PTR() fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415-sleepable_=
tracepoints-v10-0-161f40b33dd7@meta.com?part=3D6
