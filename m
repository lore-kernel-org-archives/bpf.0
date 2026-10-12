Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBD242DA3D
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807200; cv=none; b=TLHy1JdTOO7HYaUGsXRn9MfpKyG7d8RvwlqxbJf0qSFS2qS4zlMo0ubsFtmHEL/IImYKWp6G6Bnxkq3mwtjbqqRIlLtSvUteufYSeDOJjdofsNgyo+DBPgwZQqlQ+frE4R1l7FMmjUSFfaFQu/2DeZYgPLUOg8Q6QFpAcO9mbRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807200; c=relaxed/simple;
	bh=yP4vqgXQjamIrFnQSbptWyR6Ta/GR8q43fPwtKsXPeY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=vB4hS0V3Z7z2y4aFxwpv20Wsxt2pBRSizHgsM11i0mI/s392uMq31ZW6YNg9r9Svg7KBrZbVDZPvMB+8gmuN7Ncb44BKeus0sWPq9Sy63sr6XhP++mLwX9owf49KgGeE8MGZTawK183iKzPlyXCp3tFqus704AVkwvp8ySskN3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXzQlQxN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXzQlQxN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87D51F0089B;
	Mon, 12 Oct 2026 12:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791807199;
	bh=VS9LALTMwz5D3kQJ3HUT6oBfy9kY+m41OrGCVpteEIM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RXzQlQxNwfr40YTUuqS9V25wHqahZ4nwPzooFd6BGa4V7krcnDV+md1yIc0GZYPI7
	 1StqxuS6OKumdtYJwDL+0+NzTpjoUa04iLTIsW6yZTccr+mPgLHibA5TXUEgWqg9mp
	 e8jGk/u4bj2FYgIWEtAovy8yEfCtP5ep3dfun6N/u5EhbMaa/L8IrrdzlItJ7An+0C
	 1xZ20GC+szJxhibf5IMh3h4UzchNiiWyvsDWs5XNJth4DJ4NvYHNmWN+fpMVoIcBLP
	 H4uFUeGmA70jeuTNg2TgmYdfkO2z6gkN4nMLwVQX4KBt2lq/3lo2GUi9Aj86/E6/C5
	 6m/iCS026RBlA==
Message-ID: <sashiko-outbox-168072@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 3/3] selftests/bpf: add tests for the
 bpf_numab_ops struct_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yafang Shao" <laoar.shao@gmail.com>
Cc: bpf@vger.kernel.org, mkoutny@suse.com, hannes@cmpxchg.org, tj@kernel.org
In-Reply-To: <20261012120438.52849-4-laoar.shao@gmail.com>
References: <20261012120438.52849-1-laoar.shao@gmail.com>
 <20261012120438.52849-4-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 12:13:18 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] selftests/bpf: uninitialized skel pointer dereference on test_hier=
archy error path
- [Medium] selftests/bpf: race condition leading to flaky test in test_atta=
ch_detach
--

commit 0d0b1887ad5f6f3d52adb583711d13aa30078932
Author: Yafang Shao <laoar.shao@gmail.com>

selftests/bpf: add tests for the bpf_numab_ops struct_ops

This commit adds selftests for the bpf_numab_ops struct_ops. It covers five
scenarios including attach/detach behavior, hierarchy aggregation, multi-po=
licy
combination, inheritance, and surface-dispatching.

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_numab_ops.c b/too=
ls/testing/selftests/bpf/prog_tests/bpf_numab_ops.c
> new file mode 100644
> index 0000000000000..3e5dac8e31313
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_numab_ops.c

[ ... ]

> +static void test_attach_detach(void)
> +{

[ ... ]

> +	/*
> +	 * Detach and let a grace period pass so that no reader is still
> +	 * walking the old effective array, then verify the hook stopped
> +	 * running.
> +	 */
> +	before =3D skel->bss->enable_cnt;
> +	bpf_link__destroy(link);
> +	link =3D NULL;
> +	sleep(1);
> +	burn_cpu_ms(300);
> +	ASSERT_EQ(skel->bss->enable_cnt, before, "enable_cnt_after_detach");

[Severity: Medium]
Could this snapshot timing cause the test to be flaky?

Because the task is running during bpf_link__destroy() and BPF hooks are
attached via RCU, scheduler ticks can still trigger the hook and increment
the counter after the before snapshot is taken but before the detachment is
complete or during the grace period.

If any ticks hit the task during teardown, the counts will not match and the
test will spuriously fail. Should the baseline counter be snapshotted after
the link is destroyed and the RCU grace period (sleep(1)) has fully elapsed?

[ ... ]

> +static void test_hierarchy(void)
> +{
> +	struct bpf_numab_ops *skel;
> +	struct bpf_link *plink =3D NULL;
> +	int parent_fd, child_fd =3D -1;
> +
> +	parent_fd =3D test__join_cgroup(CGROUP_PATH);
> +	if (!ASSERT_GE(parent_fd, 0, "join_parent_cgroup"))
> +		return;
> +
> +	child_fd =3D create_and_get_cgroup(CHILD_PATH);
> +	if (!ASSERT_GE(child_fd, 0, "create_child_cgroup"))
> +		goto cleanup;
> +
> +	if (!ASSERT_OK(join_cgroup(CHILD_PATH), "join_child_cgroup"))
> +		goto cleanup;
> +
> +	skel =3D bpf_numab_ops__open_and_load();

[ ... ]

> +cleanup:
> +	bpf_link__destroy(plink);
> +	bpf_numab_ops__destroy(skel);

[Severity: High]
Does this code dereference an uninitialized pointer if cgroup creation fail=
s?

The skel pointer is declared without initialization. If either
create_and_get_cgroup() or join_cgroup() fails, the code jumps to the clean=
up
label before skel is assigned a value.

At the cleanup label, bpf_numab_ops__destroy(skel) is invoked with the
uninitialized skel pointer containing garbage stack data. This bypasses the
internal NULL check in the destructor and can cause a segmentation fault.

Would initializing struct bpf_numab_ops *skel =3D NULL; prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012120438.5284=
9-1-laoar.shao@gmail.com?part=3D3
