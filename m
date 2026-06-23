Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0629F3AEF49
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782225587; cv=none; b=sXwtG/ZE9WdOc5W6tNMjp7LhOkPt9Bi9w7qJA86+99GDpVktaKaoi2yUMyG4Oz3j+Fy1bS8biDes8xOVLynmoZ+tD23hDp+zU1gQFhyfSGYIyELYdJxLUVIV+Inu0vLc/LMaBCz2+n5PygiVNS5Mp47bjni2qqLfen2FWdnanGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782225587; c=relaxed/simple;
	bh=mFZBSEOcJUdrGKcR0R8U+0AQ/0E9Wn0s2b/+PKoTLo0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZYhG94qa8u+PSlb33sagnQRYgbaehx/qui1f9zL98bQ6nuGsqXz2ImwVWTn0oAzsUoywjiDTKYALxgD/hYivi5iiz+ufTOisiCsJaMveNJvznZ79K5EgyTwrZrtcEonHi3OZa1ewgvGPPFMtAsORwRj7tIIP8VJTxtZKc1BAn3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMotK1ul; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMotK1ul"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C6F1F000E9;
	Tue, 23 Jun 2026 14:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782225584;
	bh=1OcXKnQQEoobBJMbrFrQW9R4hUr3hVazvKUQFFpToUI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SMotK1ulZubSZPKkG4EzztvcePvu+vpA9X6smwjaS3S1eM+vATswPAfwJl2VmjL/h
	 +q0QQIFRpaLz8dJSIql31bPTfMYmQOlNNTifjb8d9EYS2T1sK9CXfnRFaXTM8/XS9v
	 3GAK7WqVbHO+0exIstDQPenJCy2CQ59qACjEDw52kslxSO8cW+tKj32fUSaT1uoCGI
	 63y8wpTU+7Q2LNP43XcflJSNf+hBIt02zC4kwUOJm7L1hRCooBl8b6BRJAXpCZYcGU
	 ivoVpT7iUcHcFN1LTBuOfoN78c2Qug+aRKfpsh7omBnwUS3D4ZHUnDoyKf0w7QQOfi
	 PcrLsLScu5Zfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 bpf-next 2/3] selftests/bpf: Add tracing_multi link
 info tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260623142417.275892-3-jolsa@kernel.org>
References: <20260623142417.275892-1-jolsa@kernel.org>
 <20260623142417.275892-3-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 14:39:43 +0000
Message-Id: <20260623143944.54C6F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The patch adds selftests for `tracing_multi` link info (`BPF_LIN=
K_TYPE_TRACING_MULTI`), but the required kernel-side implementation is enti=
rely missing.
- [Low] The patch references `info.tracing_multi` inside `struct bpf_link_i=
nfo`, but this field does not exist in the UAPI headers.
--

commit 23bb30d6d6d285433f08e70bf1a166ecfd023a7d
Author: Jiri Olsa <jolsa@kernel.org>

selftests/bpf: Add tracing_multi link info tests
   =20
Adding tracing_multi link info tests that follow the kprobe_multi
and uprobe_multi tests logic.

> diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/to=
ols/testing/selftests/bpf/prog_tests/fill_link_info.c
> index f589eefbf9fbd..4d021e9b0129c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
[ ... ]
> +static int verify_tracing_multi_link_info(int fd, const struct bpf_progr=
am *prog,
> +					  const struct tmulti_target *targets,
> +					  __u32 obj_id, bool has_cookies)
> +{
[ ... ]
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
Does the tracing_multi field exist in struct bpf_link_info within the UAPI
headers?

It doesn't seem to be present in include/uapi/linux/bpf.h yet, which would
cause a build failure here when accessing info.tracing_multi.attach_type.

> +	ASSERT_EQ(info.tracing_multi.count, TRACING_MULTI_CNT, "info.tracing_mu=
lti.count");

[Severity: Medium]
Is the kernel-side implementation for filling this link info missing?

Without a .fill_link_info callback defined in bpf_tracing_multi_link_lops in
kernel/trace/bpf_trace.c, bpf_link_get_info_by_fd() will leave the
tracing_multi struct zero-initialized, causing this assertion to fail.

[ ... ]
> +static void verify_tracing_multi_invalid_user_buffer(int fd, const struc=
t tmulti_target *targets)
> +{
> +	__u32 ids[TRACING_MULTI_CNT] =3D {};
> +	struct bpf_link_info info;
> +	__u32 len =3D sizeof(info);
> +	int err, i;
> +
> +	/* Wrong info setup (ids !=3D NULL and cnt =3D=3D 0) -> EINVAL */
> +	memset(&info, 0, sizeof(info));
> +	info.tracing_multi.ids =3D ptr_to_u64(ids);
> +	err =3D bpf_link_get_info_by_fd(fd, &info, &len);
> +	ASSERT_EQ(err, -EINVAL, "tracing_multi.invalid_count");

[Severity: Medium]
Will this return the expected -EINVAL error?

Since the kernel doesn't appear to implement .fill_link_info for this link
type yet, the validation that would return -EINVAL won't execute, causing
this assertion to fail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623142417.2758=
92-3-jolsa@kernel.org?part=3D1
