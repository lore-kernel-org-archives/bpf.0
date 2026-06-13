Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9208A1C7012
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 22:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781391591; cv=none; b=lzfQ9Hb4GgoHkfVEerd97+Zg5gN5Jez+gpDgfHI3b5HUyc9Fx1H2aKxIRaVQtVo9H3+USmkRvPcupcU4qsgEXm2HkGozS9A8y5z6AKTsUzlJDH0VsLUPTFGzdjv9RXg6GRokPq2e6M1++qwnSmTjsCEc9SDKnbHzQ66R9lign6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781391591; c=relaxed/simple;
	bh=Z6udnD4gl+2yyc51XzdZo7BNVQ/MoSFxxB4OvfRsOcg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jSvxV+p8B4e8m3CymJRebC9W9cUT3ByK3RqzDivWCjT7vJ1ef5J50KeRohuYgkTkf+Ptct3fEczF/7armFcZVU898eMZV9D1GqDjueB3i4w3lc8WCbC0tQStz3hu22zaixknoWStw6WY8TJ3ytgbQBQxQWHrsbo3GRRwQQYLc5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqyPc01E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqyPc01E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9441F000E9;
	Sat, 13 Jun 2026 22:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781391590;
	bh=W4FilxYKVJ4ilswmhFJyIvxaslDfGQHg/wD4zOACe+k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MqyPc01E7LNzdN+Pu4H60HfGbTl/zWmCnAqjUoSA0Qu6Ip8j31VWPIx2z+RcSLOr/
	 OtTUZgEyVMCp+lXiQ0Fn1Pvljhj0hCeYIVxpr+n2CCgdvsfYmhbo/fnk8OLy/eDAHE
	 9mEjUqFn/bGLLvcIuL5IoMnWC2IxmLosh+iCnZrHhTnmZMMX3My5lngKGWTLjUXtve
	 70Hs2v+oqnnpB5JxxH4gHthR69cqnEE9deAcx3fC/FROtmgAC+sWu4TWv+smiaIYLF
	 xVpZx8EtZHSW9TKOVGQ5Ta447mNJBtPn0vlC0ObjAkYmUlXPTtdquorOiJDaV2nUu3
	 KVeOrM9tE/uHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 bpf-next 4/4] selftest: bpf: Add test for hwtstamp
 proxy.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260613224823.2399535-5-kuniyu@google.com>
References: <20260613224823.2399535-5-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 22:59:49 +0000
Message-Id: <20260613225950.5A9441F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The function `check_tstamp()` unconditionally returns -1 even up=
on successful validation, which causes the test driver to silently skip the=
 RX phase of the test.
- [Medium] An uninitialized stack buffer `buf_cmsg` is passed to the kernel=
 via `sendmsg()`, passing stack padding into the kernel and risking Memory =
Sanitizer (MSAN) failures.
--

commit cbe313a245c9f97c0ad306889154ce4bfae090f0
Author: Kuniyuki Iwashima <kuniyu@google.com>

selftest: bpf: Add test for hwtstamp proxy.

This selftest simulates the hardware timestamp proxy scenario using two UDP
sockets. It receives and injects encapsulated packets via a GENEVE device to
verify hardware timestamp behavior.

> diff --git a/tools/testing/selftests/bpf/prog_tests/proxy_hwtstamp.c b/to=
ols/testing/selftests/bpf/prog_tests/proxy_hwtstamp.c
> new file mode 100644
> index 0000000000000..175d8be74804d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/proxy_hwtstamp.c

[ ... ]

> @@ -335,11 +335,11 @@ static int check_tstamp(struct proxy_hwtstamp_test_=
case *test_case, bool tx)
>  	ret =3D memcmp(buf_msg, test_case->app_payload, sizeof(test_case->app_p=
ayload));
>  	ASSERT_OK(ret, "memcmp");
> =20
>  	ret =3D -1;
> =20
>  	for (cmsg =3D CMSG_FIRSTHDR(&msg); cmsg; cmsg =3D CMSG_NXTHDR(&msg, cms=
g)) {

[Severity: Medium]
Is ret intentionally left as -1 here?=20

If it isn't updated to 0 upon success, won't this cause the function to alw=
ays
return -1?

Looking at run_test(), the RX test phase is guarded by checking this return
value:

run_test() {
    ...
    ret =3D test_proxy_hwtstamp_tx(test_case);
    if (!ret)
        test_proxy_hwtstamp_rx(test_case);

Since test_proxy_hwtstamp_tx() returns the -1 from check_tstamp(), doesn't
this unconditionally skip the RX test phase without actually failing the te=
st?

[ ... ]

> @@ -364,22 +364,22 @@ static int test_proxy_hwtstamp_tx(struct proxy_hwts=
tamp_test_case *test_case)
>  {
>  	char h_source_dummy[ETH_HLEN] =3D {0xFF, 0xEE, 0xDD, 0xCC, 0xBB, 0xAA};
>  	char buf_cmsg[CMSG_SPACE(sizeof(u32))];
>  	struct proxy_header *phdr;
>  	struct msghdr msg =3D {};
>  	struct iovec iov =3D {};
>  	struct cmsghdr *cmsg;
>  	int ret;
> =20
>  	memset(test_case->app_payload, 0xAB, sizeof(test_case->app_payload));
>  	iov.iov_base =3D test_case->app_payload;
>  	iov.iov_len =3D sizeof(test_case->app_payload);
> =20
>  	msg.msg_iov =3D &iov;
>  	msg.msg_iovlen =3D 1;
>  	msg.msg_control =3D buf_cmsg;
>  	msg.msg_controllen =3D sizeof(buf_cmsg);
> =20
>  	cmsg =3D CMSG_FIRSTHDR(&msg);
>  	cmsg->cmsg_level =3D SOL_SOCKET;
>  	cmsg->cmsg_type =3D SCM_TS_OPT_ID;
>  	cmsg->cmsg_len =3D CMSG_LEN(sizeof(u32));
>  	*(u32 *)CMSG_DATA(cmsg) =3D TSKEY;
> =20
>  	ret =3D sendmsg(test_case->app_fd, &msg, 0);

[Severity: Medium]
Can this pass uninitialized stack memory to the kernel?

The buf_cmsg array is allocated on the stack without being zero-initialized.
While the cmsghdr structure assignments initialize CMSG_LEN(sizeof(u32)) by=
tes,
does this leave the remaining alignment padding bytes uninitialized?

If so, passing it to sendmsg() could leak uninitialized stack padding into =
the
kernel and trigger Memory Sanitizer (MSAN) warnings in continuous integrati=
on
environments.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613224823.2399=
535-1-kuniyu@google.com?part=3D4
