Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2F541322C
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 19:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778266948; cv=none; b=JOlacCvZmHittUCmf+1cZjzwZ1ctshSBsyjFJSIda8yjbuIbOb+oJ1OyTnqzLMwOKeVCqv7bkLqymW/+mBin1MEySTw0HXwCtH/xNsL9xBI3nB9b/CWBAVQbKPMizdevgHo8+vC0riB9TLC8nfwe9dzRBt1I/ayqbH7NHpVK11o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778266948; c=relaxed/simple;
	bh=jsp6D7DK4Gfko4Lqdl8o4woe4dM/xXARWYMtuZYtxO0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DZPzHl+uwdRwqH3eN0HbdUSEs+ji9OZeKKaLj+bG9aGtehjK6AmAv/vnQ700XBbB5SjR56yayE+IaIDnMjtSMIktQFtp1UCKWzAbeSskV6PEnQXVFwqRxmoxBZqMhEm4sxGaTeDVOL+TEcEj2l51kGZ3DKWUwZ8kh0OZnqkl82s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mG1dhpCo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mG1dhpCo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAE9C2BD00;
	Fri,  8 May 2026 19:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778266947;
	bh=jsp6D7DK4Gfko4Lqdl8o4woe4dM/xXARWYMtuZYtxO0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=mG1dhpCo09zgh7mGx4n/ja7zKa4iibPr+1wxgWAtkoVmC9I9uQpWTtj41gCuK+7pX
	 gJym/543qmT+s9tVddVS8hu0D1TtqwyUq888nBRcPYj9cD0o5Ek9dNVqEp5cWZ2fBK
	 /+IiZ2bkgLVo0oVgiJUQzw3tIzV7p8eGfDx3Bof42coZL+yFB0uzw84F6gHs/KrySN
	 vmP2yL9HTwRvXgLl0sHtXJUx4Eh1RVLXPUZ+4q48GPnrUwtMCnbnPEWXU41ee9DxNb
	 LCwIqkZb2yL/FiNTjiBZXKRpo17ymwn2KThmDIPxBdtUMK7Loc5HmUAkI++jeRzyoX
	 JbMARhB3U1Omg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 bpf-next 1/8] selftest: bpf: Use
 BPF_SOCK_OPS_ALL_CB_FLAGS + 1 for bad_cb_test_rv.
Reply-To: sashiko@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260508073355.3916746-2-kuniyu@google.com>
References: <20260508073355.3916746-2-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 19:02:26 +0000
Message-Id: <20260508190227.AFAE9C2BD00@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Using `BPF_SOCK_OPS_ALL_CB_FLAGS + 1` to test invalid BPF callba=
ck flags creates brittle test logic that assumes contiguous bitmasks and br=
eaks forward compatibility.
--

commit dfed6c2387074d0f6f7afb70b6bba777371f7267
Author: Kuniyuki Iwashima <kuniyu@google.com>

selftest: bpf: Use BPF_SOCK_OPS_ALL_CB_FLAGS + 1 for bad_cb_test_rv.

Once bpf_sock_ops_cb_flags_set() supports a new flag,
tcpbpf_user.c fails due to the hard-coded max value, 0x80.

> diff --git a/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c b/tools=
/testing/selftests/bpf/prog_tests/tcpbpf_user.c
> index 7e8fe1bad03f5..e4849d2a2956f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
> @@ -26,7 +26,8 @@ static void verify_result(struct tcpbpf_globals *result)
>  	ASSERT_EQ(result->bytes_acked, 1002, "bytes_acked");
>  	ASSERT_EQ(result->data_segs_in, 1, "data_segs_in");
>  	ASSERT_EQ(result->data_segs_out, 1, "data_segs_out");
> -	ASSERT_EQ(result->bad_cb_test_rv, 0x80, "bad_cb_test_rv");
> +	ASSERT_EQ(result->bad_cb_test_rv, BPF_SOCK_OPS_ALL_CB_FLAGS + 1,
> +		  "bad_cb_test_rv");

Is BPF_SOCK_OPS_ALL_CB_FLAGS + 1 robust for forward compatibility?

When the test is compiled, BPF_SOCK_OPS_ALL_CB_FLAGS + 1 is evaluated to a
hardcoded value. If this compiled test runs on a future kernel where this v=
alue
is supported, the helper will successfully set the flag and return 0. The
userspace test would still expect the hardcoded remainder, causing it to fa=
il.

Furthermore, this assumes contiguous bitmasks. If a flag is ever deprecated=
 or
skipped, adding 1 could overlap with valid bits.

Would it be better to use a safely distant bit, such as 1 << 30, to guarant=
ee
the flag remains unsupported and the test doesn't break in the future?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508073355.3916=
746-1-kuniyu@google.com?part=3D1
