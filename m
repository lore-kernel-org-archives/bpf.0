Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050D93932C8
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 09:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789898341; cv=none; b=sHkohvOloqf+aXlkC0LNFmuXMN1EEtMZVgqVILcTRlcbv5IRV/AXe/DRCFqKm3Xh+QxVSrn8qSpigkbOktd9IgtxjCSCWUfvyDjDKL3hw/eP5BIuvAlXEglTIAE9kX8ipRw9Mnns3igY9Er+tNSAW8ALWuEC62pspMuWfrYBM/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789898341; c=relaxed/simple;
	bh=NjEPOuXBvpnYuziSga+cIxytuk9WMFPfY1XbqRdE4pk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LfddFi4gx+iry1cfBFpwAKVqaJ2bTAcS2CSVLV8wsDE4HAs0dlg3BvTU4fX0R+Hn4ko0RFSUX4DI14LkT4MNGzmX+ZJ5ejbc6jYQHvtVB1qDp2A658eM/7cNF/hRvPCpiTCDq1OxRWdixQ7BBPgVDOuyyVghs7BcgD1IqMFdVyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gm3LshPt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gm3LshPt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635921F000FF;
	Sun, 20 Sep 2026 09:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789898339;
	bh=t3FVuoSVTBMf11GXKaD/mTbVsElq9xyVwtvK0XSVzlo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gm3LshPtzUpRsx8/dH4kr+CVjzPBVetSVZr5Rssjaog2DK15aOQZrVBAsTgYZ6Dra
	 HkzfhUBBHKccB9ZqxOHZSBjQnfHIt8JRZcVosBKNfyvJejX03uPQqeAozzA9wGMS9V
	 LFfEHe6mnnvgbQ2T7RtHhv+motQbb8IKOh5DjZzvU0otnHIgwmF7UH45/3ZLS2jcP2
	 a8o5Yw295D65Xd0lvjX0X4jWPNOAiVHf/0cVDnE4TZG48+7Gsi9XuWuX0S9cvJTMz0
	 7uKYtnfAp2n669dqksGBL0NmlKeMFsyPMGpafHhtcyddcpuef9jaakUt89KSgAPLco
	 /sKVUfbpw/3aw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Test per-cpu initialization of a
 BPF_F_CPU created element
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donggeun Yoo" <donggeunyoo.kernel@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260920093153.439743-3-donggeunyoo.kernel@gmail.com>
References: <20260920093153.439743-1-donggeunyoo.kernel@gmail.com>
 <20260920093153.439743-3-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 09:58:58 +0000
Message-Id: <20260920095859.635921F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf: test inappropriately fails on uniprocessor systems instead =
of skipping
- [Low] bpf: multi-line comment does not follow required subsystem style
--

commit 5dd1fa65516377d52d53f05992d195284eba751e
Author: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

selftests/bpf: Test per-cpu initialization of a BPF_F_CPU created element

This commit adds a subtest to verify that a BPF_F_CPU map update correctly
zeros out the value on other CPUs when creating a new element. It runs this
test against PERCPU_HASH, non-preallocated PERCPU_HASH, and LRU_PERCPU_HASH.

> diff --git a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c b/tool=
s/testing/selftests/bpf/prog_tests/percpu_alloc.c
> index a72ae0b29f6e9..d0084a2405bed 100644
> --- a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
> @@ -350,6 +350,74 @@ static void test_lru_percpu_hash_cpu_flag(void)
>  	test_percpu_map_cpu_flag(BPF_MAP_TYPE_LRU_PERCPU_HASH);
>  }
> =20
> +/* A BPF_F_CPU update that creates an element must zero the value on the=
 other
> + * cpus, rather than leave them holding whatever the recycled element la=
st
> + * contained.  max_entries is 1 so the second key can only reuse the ele=
ment
> + * the first one released.
> + */

[Severity: Low]
This isn't a bug, but the BPF subsystem strictly requires multi-line commen=
ts
to have the opening /* on its own line. Could this be reformatted to match
the required style?

> +static void test_percpu_map_cpu_flag_create(enum bpf_map_type map_type, =
__u32 map_flags)
> +{
> +	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags =3D map_flags);
> +	const u32 stale =3D 0xDEADC0DE, fresh =3D 0xC0FFEE;
> +	int nr_cpus, cpu, map_fd, err, key;
> +	u32 value;
> +	u64 flags;
> +
> +	nr_cpus =3D libbpf_num_possible_cpus();
> +	if (!ASSERT_GT(nr_cpus, 1, "libbpf_num_possible_cpus"))
> +		return;

[Severity: Medium]
Does this force a hard failure on uniprocessor systems instead of correctly
skipping the test?

Since UP is a valid hardware configuration for running selftests, if a test
requires multiple CPUs, shouldn't it gracefully skip using test__skip()
rather than asserting a failure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920093153.4397=
43-1-donggeunyoo.kernel@gmail.com?part=3D2
