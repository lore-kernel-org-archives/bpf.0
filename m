Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12247266576
	for <bpf@vger.kernel.org>; Sun, 21 Jun 2026 20:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782075233; cv=none; b=HU61LRIyL2rY/Wt7Kv6t0uGuAlFaPVafZUf4HtURB9fjFdOPHCqevuObXRXuVibjVxkeySydgEdcQPEAKDt9tO2nkkAZ08bpTex8g3n6NSkh4swkrR1JwBTk0JLA+kaMzin7wsZ3wm6yaEDAofM7AOkgyEpF3g5WrfeGHJRaKlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782075233; c=relaxed/simple;
	bh=6nPT77yGS2do3qyUuPcoZKWip4MqQs+ARnxwYnYbDi0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BMEn1ACG4T+G8oooyj+3Rv56CyO+FGxX9P3gv3A8R1NhQ9wOK5C7GbjTmZGnm5x4JaxWpOsg/q6XeJBQIFMkZn8mYTqzEdyuZsShVrJEw16Shpw7PIIud2KnIFjEhReSljRmGsvvA82ceOVrRUsfSW9SWIGOu8ITXSyrv40Bgdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glP/Zu28; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glP/Zu28"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2741F000E9;
	Sun, 21 Jun 2026 20:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782075231;
	bh=PsQ/ohN2gKlQtmXDtzupFQxvNLVjkpUSg4rHUvi8dtw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=glP/Zu2869OPjwFfVCk3j1p/87Nvgpgc674FWIV+mIhq9lWWo4CTL/9UoepvmxYJV
	 Ep/8st/nRMsLpm7zdgLtEQjmfjqSEYXDO8E8CPdPw53zX9Wb5SDa3ETmBy04qVpcJH
	 ER3bfTnM9peMKGoSWHmg2iUmy5WABHT/c8cg0v4OegkQAP7oSsNRDSgdyRGKHE65jg
	 a+ifb97CswDy7irb9A24Q0lz2pyDBb5S/BpLN6t+A/4WbmY2ULg+nfRX6UsiAwr57u
	 ekd8N7/DKkeKp2+htJSjlLTsxmntlxGVTv0fQb3t6UzKyrhUJpUZaFn6ovPh2JiwtI
	 umLG0rreDwTTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: Add tracing_multi link info
 tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260621204524.61067-3-jolsa@kernel.org>
References: <20260621204524.61067-1-jolsa@kernel.org>
 <20260621204524.61067-3-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 20:53:50 +0000
Message-Id: <20260621205350.ED2741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incorrect assertion failure message tag for invalid `addrs` pointer=
 test.
--

commit edec3b6e703fee4df106f0b3f019e87b22c606fc
Author: Jiri Olsa <jolsa@kernel.org>

selftests/bpf: Add tracing_multi link info tests

This commit adds new tests for tracing_multi link info. The tests follow the
existing logic used for kprobe_multi and uprobe_multi tests.

> diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/to=
ols/testing/selftests/bpf/prog_tests/fill_link_info.c
> index f589eefbf9fbd..969f04ee9ac6a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c

[ ... ]

> +static void verify_tracing_multi_invalid_user_buffer(int fd, const struc=
t tmulti_target *targets)
> +{
> +	__u32 ids[TRACING_MULTI_CNT] =3D {};
> +	struct bpf_link_info info;
> +	__u32 len =3D sizeof(info);
> +	int err, i;

[ ... ]

> +	/* Invalid cookies pointer -> EFAULT */
> +	memset(&info, 0, sizeof(info));
> +	info.tracing_multi.cookies =3D 0x1;
> +	info.tracing_multi.count =3D TRACING_MULTI_CNT;
> +	err =3D bpf_link_get_info_by_fd(fd, &info, &len);
> +	ASSERT_EQ(err, -EFAULT, "tracing_multi.bad_cookies");
> +
> +	/* Invalid addrs pointer -> EFAULT */
> +	memset(&info, 0, sizeof(info));
> +	info.tracing_multi.addrs =3D 0x1;
> +	info.tracing_multi.count =3D TRACING_MULTI_CNT;
> +	err =3D bpf_link_get_info_by_fd(fd, &info, &len);
> +	ASSERT_EQ(err, -EFAULT, "tracing_multi.bad_cookies");

[Severity: Low]
This isn't a bug, but is this tag a copy-paste error? The comment mentions
testing an invalid addrs pointer, but the assertion in
verify_tracing_multi_invalid_user_buffer() uses the
"tracing_multi.bad_cookies" tag rather than something like
"tracing_multi.bad_addrs".

> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621204524.6106=
7-1-jolsa@kernel.org?part=3D2
