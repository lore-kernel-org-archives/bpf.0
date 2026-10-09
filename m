Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D15C1B808
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 02:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791512058; cv=none; b=phSvyE6wvFTMuPFR1yDzVqE5qbchNsPM1FFYi9URe8GCvx+CaNCWADRCi2zqv3rYRLpApfzU2SckPv4mCUTg82y3P+gvZ0Mitl5bW4pzrx8p3UkGH5EZieFMb5hloeJhhdXFBR7esNzjDdSGI5uIXGAEFYKGovARrOdcfTu5qd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791512058; c=relaxed/simple;
	bh=RWeUomr4/zWMv5SdMu4di6saHMrCONlWbfVGGZkCspI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ivN6FEcDjYPrUFdrhiTbP9FOATqCpKfbi4MMCNhgTjMqu4jIYZzqQzBAAjeoWKOTkJRSNFaiB/aY3fSo7AmXu0TGgXZWGAcS4Tn/nlgmxKiSsqMsvabouKcahuuD6ibhwpoI1ccZAO+jzwzXRdakpkOxMkOUPMkagwlsMT4y01U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cawB43ie; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cawB43ie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB081F000FF;
	Fri,  9 Oct 2026 02:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791512057;
	bh=LVQVU0WlO8P7DPglNBE03mvtpbq4UJjaOUaHjjm/VzA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cawB43ieuNZaWvmb2igkS/vIX2U0av+FFDWtIkCjgkNLqcGPSO0niu9mp+nIpKz9y
	 HFHcKEYp861YW1E6s8XZCoCq+mCaiyifhnQqnxYvKupqBQR428J4Ow3v42fJymiT1j
	 O3awK6K4qUMUHs5NNilWjEbcMFHgPsAlaZUmXdz9cAsgApIZRcs0uwp27x3njlclBo
	 aU7t10VEFx1BNv4Suj1HwgqH0Qu7EvsqzehrFn+CwkHYTX+r4WOv5FkKyVWy659faI
	 3H1lXIpZB5feRuQeGjPhq4EIWUCgfhnM+gZAd2w8eb5y8xwlDencNC5bB8nDo+Pom0
	 BKEt94JAoGtNw==
Message-ID: <sashiko-outbox-164722@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Unmount the bpffs that
 cgroup_hierarchical_stats mounted
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiliang Yuan" <odys.yuan@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009-selftests-bpf-cgroup-stats-bpffs-v2-2-f93a111da992@gmail.com>
References: <20261009-selftests-bpf-cgroup-stats-bpffs-v2-0-f93a111da992@gmail.com>
 <20261009-selftests-bpf-cgroup-stats-bpffs-v2-2-f93a111da992@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 02:14:16 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: unconditional rmdir in cleanup_bpffs triggers spurious asserti=
on failures
--

commit 34f23b53e236bfae8b2ad74d5d89f8806c601dbb
Author: Qiliang Yuan <odys.yuan@gmail.com>

selftests/bpf: Unmount the bpffs that cgroup_hierarchical_stats mounted

This commit fixes a logic error in cleanup_bpffs() where a locally mounted
bpffs was not correctly unmounted. By inverting the check on mounted_bpffs,
the test ensures it cleans up its own mounts rather than leaking them.

> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_s=
tats.c b/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
> index ad19d6d41918a..cc6ab2c263da1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
> @@ -110,7 +110,7 @@ static void cleanup_bpffs(void)
>  	ASSERT_OK(rmdir(BPFFS_ATTACH_COUNTERS), "rmdir "BPFFS_ATTACH_COUNTERS);

[Severity: Low]
In cleanup_bpffs() within
tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c, does th=
is
unconditional rmdir() trigger spurious assertion failures during early setup
error paths?

When setup fails (e.g., in setup_cgroups() or the initial mount() call), the
BPFFS_ATTACH_COUNTERS directory is never created. During the teardown path
(hierarchy_cleanup() -> destroy_hierarchy() -> cleanup_bpffs()), rmdir() is
unconditionally called and wrapped in ASSERT_OK().

If the directory does not exist, rmdir() returns -ENOENT, triggering a
secondary assertion failure. This clutters the test output and masks the
original setup failure.

> =20
>  	/* Unmount bpffs, if it wasn't already mounted when we started */
> -	if (mounted_bpffs)
> +	if (!mounted_bpffs)
>  		return;
> =20
>  	ASSERT_OK(umount(BPFFS_ROOT), "unmount bpffs");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-selftests-=
bpf-cgroup-stats-bpffs-v2-0-f93a111da992@gmail.com?part=3D2
