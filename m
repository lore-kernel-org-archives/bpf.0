Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6E93B18A
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744737; cv=none; b=F+95sBLpINnwcCq/NZ/x0dtYgXPnDnWm4n0mKYo6JtHx3UtOoD4/JODvMYN78DPsWJtdHK5ZjEtS8P2fNDAjzd3S6JP9igi09tbarL0wgma3iV7brSWm4aRZw0fr4oBou2PAQGKpN3ZaGRbmVr40SMASHihqmn26+O8Op8PT6Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744737; c=relaxed/simple;
	bh=osW+1cmh0LsP3+S8Hzx7Eh0d640i+pNt7EEwYjl4sA0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JHsAZO+ORKIyF+Vg0MS1MDgNbnMqx/iTB5A+X4Iro8T/JSaBltdN/sRAqha2PGBI3YMqZ1K6+p2KvXU3yP+XCUKN286cQmAhh1Uxa1lGDtzXgL+VLT7IcrwG4BocCuEc2zlPkqkhKMVyrMgfttQmkgvILiHUMaMeovZCzy45Nk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhp/+fOY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhp/+fOY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699B21F000E9;
	Mon, 29 Jun 2026 14:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782744735;
	bh=+NQxZ2bHhvql5m3jTK7GzWA1dIy0ER4XA9xsoMvDRvg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mhp/+fOYzyYpMRaVDeXmBhs/dhuqjUw2R3bXX/J58VzyXneLlsQy5yTnkKwh4Ejpt
	 3G976t7kMjVLA3uyjRYBaVMWuSpksePyMTbKoQXySUs4CVn4SuHRoF+PieKJcGpJEo
	 zPAx4rRgZS0SMaluSM/B5O1lZ/5PZIa3CTg4FBBDn9utF5WPrlz2scVmYBMcj+vvj0
	 6e9sFqaBMXM9AQpqTidAvQTGMtXutUx4pfZLn8JJ3bUSS1VxpYNw+YikqumyaGoc/Y
	 mK+DLfsA1JQyNNDfhwJeI2MO+XVMQTemypGeE68M/5Dl3gR6l/LjGaJicxE/jIU3jn
	 hDNsZhRmYqVJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 bpf-next 2/3] selftests/bpf: Add tracing_multi link
 info tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260629143844.862369-3-jolsa@kernel.org>
References: <20260629143844.862369-1-jolsa@kernel.org>
 <20260629143844.862369-3-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 14:52:15 +0000
Message-Id: <20260629145215.699B21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The kernel implementation of `.fill_link_info` for `BPF_LINK_TYP=
E_TRACING_MULTI` is completely missing, which would cause the new tests to =
unconditionally fail at runtime.
- [Low] The patch introduces a compilation failure because it attempts to a=
ccess a non-existent `tracing_multi` member in `struct bpf_link_info`.
--

commit 0277eab302404c5b366c836f0d334f0e2681388e
Author: Jiri Olsa <jolsa@kernel.org>

selftests/bpf: Add tracing_multi link info tests

Adding tracing_multi link info tests that follow the kprobe_multi
and uprobe_multi tests logic.

> diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/to=
ols/testing/selftests/bpf/prog_tests/fill_link_info.c
> index f589eefbf9fbd..0918321c8e63d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
[ ... ]
> @@ -396,6 +413,224 @@ static void test_kprobe_multi_fill_link_info(struct=
 test_fill_link_info *skel,
[ ... ]
> +static int verify_tracing_multi_link_info(int fd, const struct bpf_progr=
am *prog,
> +					  const struct tmulti_target *targets,
> +					  __u32 btf_obj_id, bool has_cookies)
> +{
> +	enum bpf_attach_type attach_type =3D bpf_program__expected_attach_type(=
prog);
> +	__u64 addrs[TRACING_MULTI_CNT], cookies[TRACING_MULTI_CNT];
> +	__u32 ids[TRACING_MULTI_CNT];
> +	struct bpf_link_info info;
> +	__u32 len =3D sizeof(info);
> +	int err, i;
> +
> +	memset(&info, 0, sizeof(info));
> +	err =3D bpf_link_get_info_by_fd(fd, &info, &len);
> +	if (!ASSERT_OK(err, "bpf_link_get_info_by_fd"))
> +		return -1;
> +
> +	if (!ASSERT_EQ(info.type, BPF_LINK_TYPE_TRACING_MULTI, "info.type"))
> +		return -1;
> +
> +	ASSERT_EQ(info.tracing_multi.attach_type, attach_type, "info.tracing_mu=
lti.attach_type");

[Severity: Low]
Does this code fail to compile?  It looks like struct bpf_link_info does not
have a tracing_multi member.

[Severity: Medium]
Will this test unconditionally fail at runtime?

Looking at bpf_tracing_multi_link_lops in kernel/trace/bpf_trace.c, it
appears the .fill_link_info callback is missing for TRACING_MULTI links.

Since bpf_link_get_info_by_fd() returns 0 without populating link-specific
info or returning expected error codes when the callback is missing, won't
these assertions fail?

> +	ASSERT_EQ(info.tracing_multi.count, TRACING_MULTI_CNT, "info.tracing_mu=
lti.count");
> +
> +	memset(ids, 0, sizeof(ids));
> +	memset(cookies, 0, sizeof(cookies));
> +	memset(addrs, 0, sizeof(addrs));
> +
> +	info.tracing_multi.ids =3D ptr_to_u64(ids);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629143844.8623=
69-3-jolsa@kernel.org?part=3D1
