Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AA61ACED5
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 02:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791511976; cv=none; b=me5WEJFOd8nwkg5dPcm8rGJLdeKAAznEVio+tptNQXsLkzEBUL/a5pQojYS69CKjmXfcW/DStxGjVAGqkkV/35kb8mCDnsWrBnojvHnS1dvqE5PXMpIdjRdTuPk0xUhEFQ3HqxgYiEHt8YVZYkropvzuQWmij+9NbGXqt6DueUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791511976; c=relaxed/simple;
	bh=erPAOdYtn+jItFvJABi9LhUVrpR4DNEknctCqs+oMyg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=RLJLOEgnzN6EXtM2R2cmkNKOXbNttgt4EracWbMFnbwvitPMhSSBWB3bqCKrdd3UKH6Uwd8FyJ7gmV1RHMEK6kezwrii7konAsXL7dazzxLaPIr1Sn02TSfs6RbbG21aCy3W2Y/2A3VuWJ8QMrshROwqHdDoFuZ9d+bngl0gNOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWzwd5JT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWzwd5JT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E641F000FF;
	Fri,  9 Oct 2026 02:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791511975;
	bh=FyJiT/LaOi8f+LHWHCq/UYlhOYEvw0nkh7NGo0s3lrs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kWzwd5JTqj4RJR+ZS0dxXoWK7fjHYWP2tbuFoKmtQwGUYDKUNysW+OT47ouVfGDw3
	 jD3UBFCtq9euj02+a46jeh7i3oHQhCd1se5QcYAtCPt8RBcaaIgemlGMB/jB/vv2jg
	 IxEF8XgxCvV9JKGwpbW2RqTWkQavGiKiJpc+rp/Wi+8cZch+tPuyY2dB1953IgDO4H
	 3g2K2W5/gXdkFAlfncT5a2z6uAigW6Ep10RrSOGl5ehE90JkHK7oEihd+Lk9NGGiJa
	 2JwUrBpA1EcjCflppeVHaYZ5VN+EP08ltFnU6SSZKhb0Wfo6FmHr38vlgd+691Bdca
	 jcQd1omws4yGQ==
Message-ID: <sashiko-outbox-164719@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: Keep the bpffs of
 cgroup_hierarchical_stats private
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiliang Yuan" <odys.yuan@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009-selftests-bpf-cgroup-stats-bpffs-v2-1-f93a111da992@gmail.com>
References: <20261009-selftests-bpf-cgroup-stats-bpffs-v2-0-f93a111da992@gmail.com>
 <20261009-selftests-bpf-cgroup-stats-bpffs-v2-1-f93a111da992@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 02:12:54 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: unbalanced lifecycle in destroy_hierarchy() teardown
--

commit be18155cbccd124da201337ba01f9571021f8d5c
Author: Qiliang Yuan <odys.yuan@gmail.com>

selftests/bpf: Keep the bpffs of cgroup_hierarchical_stats private

setup_hierarchy() mounts a bpffs on /sys/fs/bpf with setup_bpffs(), and
then sets up the cgroups with setup_cgroups(), which moves the test into
a private mount namespace. The patch sets up the cgroups first, so that
the bpffs is mounted in the private mount namespace.

> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_s=
tats.c b/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
> index 3bd27d2ea668c..ad19d6d41918a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
> @@ -151,7 +151,7 @@ static void cleanup_cgroups(void)
>  /* Sets up cgroup hiearchary, returns 0 on success. */
>  static int setup_hierarchy(void)
>  {
> -	return setup_bpffs() || setup_cgroups();
> +	return setup_cgroups() || setup_bpffs();
>  }
> =20
>  static void destroy_hierarchy(void)

[Severity: Low]
Does destroy_hierarchy() need to be updated to reverse the teardown order?

Because the setup order has been changed to initialize cgroups before bpffs,
the test is placed in a private mount namespace before mounting the BPF
filesystem.=20

However, destroy_hierarchy() continues to execute teardown in FIFO order
(cleanup_cgroups() followed by cleanup_bpffs()) instead of LIFO order.

While cleanup_cgroups() does not fully destroy the namespace until process
exit (preventing immediate crashes during cleanup_bpffs()), should
cleanup_bpffs() be called before cleanup_cgroups() to properly mirror the
new initialization order?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-selftests-=
bpf-cgroup-stats-bpffs-v2-0-f93a111da992@gmail.com?part=3D1
