Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613393839BA
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 21:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782768848; cv=none; b=OLWwjGxzJ8Uv8Sp9pUpD5aJh2en+T9nQ+Qk1n3Lzcqt0pBaM1va4uN9LXvuS+I5mfC5uZ1eKo1WdqR/f6/PmH/MpnzDcRvly7Aq4Pk6O+0awXFuDhptbBsKGqJHGc+XbIVh31Quku9dwoIWtp9omod1elElu6ZmD0dvmrEKCr10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782768848; c=relaxed/simple;
	bh=M5462KMZ2bCg9mXsoHHDyOLwNNh5xW7BQZpqxIsXR8I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XpAQtvqGxbNJ3LVCfa/WciALtZcPKF9T6uc7vFUyukbHYCrq74QYtJ2HaE6KHhufevEKkDDorFq3rbS9Jq/nfTG18/NGTtsvATZTR26JbdEJq5HwLBrwElxTtdc8cHRaGW57JpQVJbJO/hKRjRgIQf4yxT7LcZGmdqY4ForiPtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOFn3/qB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOFn3/qB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FB61F000E9;
	Mon, 29 Jun 2026 21:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782768847;
	bh=vAisuHaYn08O+ZRc5sUkzHfah0Rlz9Dn7ph9TJ35TUs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QOFn3/qBu8Sli6vA0CNWiKH/7Xsv8fLlJOXnyPzX8S3a73ummpMCEuaAFFFg1hffO
	 zeKV3/sitQArn4iAcPyjO4BDhtTguf6qAa33o11ZChb5y2DkUHnuFo0drn7e/Jaw9Q
	 i2I7L8oMfg/sC4w2O9B7F6LzJlFukPA6OqSySdWE4/LRIqIowdu4EC1X4LpuX8WBAw
	 lWGTWWMmTojUe7QcZDsd7AnU2Pp8/5+IW1n2vjJNgaE0MWe2LPml9Al308ULs+JdTF
	 kMxd+hz3dZJmh9+yFGs10SxPFw8M1VyQ9rqsq4jNVZOQsaBfCRTGDQroajRm4zeYqv
	 OauZfSPHLHeGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv4 bpf-next 2/3] selftests/bpf: Add tracing_multi link
 info tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260629212208.895962-3-jolsa@kernel.org>
References: <20260629212208.895962-1-jolsa@kernel.org>
 <20260629212208.895962-3-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 21:34:06 +0000
Message-Id: <20260629213407.11FB61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing UAPI and kernel implementation for 'tracing_multi' link =
info.
- [Medium] Flawed negative testing logic for 'tracing_multi' invalid user b=
uffers.
--

commit 10d5275538071b94b5cfb747b2b37b5cb2e5d158
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
> +	ASSERT_EQ(info.tracing_multi.count, TRACING_MULTI_CNT, "info.tracing_mu=
lti.count");

[Severity: Medium]
Does struct bpf_link_info currently have a tracing_multi member? It appears
this might cause a compilation failure because the UAPI header doesn't incl=
ude
it. Also, does the kernel side implement the .fill_link_info callback in
bpf_tracing_multi_link_lops?

> +
> +	memset(ids, 0, sizeof(ids));
> +	memset(cookies, 0, sizeof(cookies));
> +	memset(addrs, 0, sizeof(addrs));
[ ... ]
> +static void verify_tracing_multi_invalid_user_buffer(int fd, const struc=
t tmulti_target *targets)
> +{
> +	__u32 ids[TRACING_MULTI_CNT] =3D {};
> +	struct bpf_link_info info;
> +	__u32 len =3D sizeof(info);
> +	int err, i;
[ ... ]
> +	/* Invalid addrs pointer -> EFAULT */
> +	memset(&info, 0, sizeof(info));
> +	info.tracing_multi.addrs =3D 0x1;
> +	info.tracing_multi.count =3D TRACING_MULTI_CNT;
> +	err =3D bpf_link_get_info_by_fd(fd, &info, &len);
> +	ASSERT_EQ(err, -EFAULT, "tracing_multi.bad_addrs");

[Severity: Medium]
Will this test actually return -EFAULT?

By zeroing out the info struct before these checks, the mandatory ids
pointer is left as NULL while count is non-zero. If the kernel validation
logic eagerly rejects the missing ids array with -EINVAL before reaching
the -EFAULT paths, won't this assertion fail?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629212208.8959=
62-3-jolsa@kernel.org?part=3D1
