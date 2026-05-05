Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1F83B2FCC
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 04:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777954473; cv=none; b=DYm/OR+Bt2wsc0G6qUBQvGY903WwbrZc+nIcg4/AvW88kGVdpCk5NqhHEqSHtiKI/dGqJIG/RUz5GZoM+Fo5or9LF7CwUQNOy0o3xs+zH+MGO2FovBxKkYxkGz4mvdxXwtFsmMsnNAyBugntglYfHgDAARWtOAqCYWn1BcNh4Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777954473; c=relaxed/simple;
	bh=7hxkhdsuBRHAgeF2Ik/PFLtR//oVRVF0e5+d72nyUp4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZJWSx9+41yyaMX1tAHk00nWclBwvex88LFvMLAmnbl3bGpyZX66MjuCHpjkIFAYWksBXejEI2zOkXtR9ycmpIOckHXqA4EUGMylWuXOwnqZI4nxcePxL2vcYq+Tab9VIy1s692rCcy9XM9Ny1QHDTc/Pq74BeuqavcFxT9OYUM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKvvdJZy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKvvdJZy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6AEC2BCC7;
	Tue,  5 May 2026 04:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777954473;
	bh=7hxkhdsuBRHAgeF2Ik/PFLtR//oVRVF0e5+d72nyUp4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=WKvvdJZyYNMXfWqyFYNguoVqrWIzfPT5vWacqFb4x0Jvx/FMJpSNM0SNabca35KNQ
	 S8zTqRetFLGHnYnZKrA/tCHF7QmvIONyE0EaK0iTOztWwwUnG7nlxkxeV42vqRA9Kj
	 4QV/dFyS8qErnIUNK61LjC1JxaBxRX5aUC+jJ7r/kYybKDhnesRpLartq0LjkDwJyn
	 do47JTfcwBLagwp+JxA2CQWuXuu6V8uGqBIZnp7ouEZwmpMoPrY4mK2qaA09v5jU+B
	 Br6wVqkmHapOZYCvVLo7DvM0+ws64geksJbWuMNfnE6wxoPUCqt3se/VmO8DGWT4Jx
	 gfQNKd3vQkGzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf 2/6] selftest: bpf: Add test for bpf_tcp_sock()
 and RAW socket.
Reply-To: sashiko@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260504210610.180150-3-kuniyu@google.com>
References: <20260504210610.180150-3-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 04:14:33 +0000
Message-Id: <20260505041433.8B6AEC2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Newly added code uses manual error checks instead of the mandated m=
odern ASSERT_* macros.
--

commit 1a574056fa08ab8c66dcd9b6ee5f0739ff6721b7
Author: Kuniyuki Iwashima <kuniyu@google.com>

selftest: bpf: Add test for bpf_tcp_sock() and RAW socket.

This commit adds a test to cover bpf_tcp_sock() for wrong socket types,
specifically tricking it with IPPROTO_TCP on an AF_INET RAW socket. It
also fixes a missing free() in the test.

> diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/=
testing/selftests/bpf/prog_tests/sockopt_sk.c
> index 53637431ec5d..5fd33ad2eaaf 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c

[ ... ]

> @@ -211,6 +211,22 @@ static int getsetsockopt(void)
>  	}
>  	ASSERT_EQ(optlen, 8, "Unexpected NETLINK_LIST_MEMBERSHIPS value");
> =20
> +	/* Trick bpf_tcp_sock() with IPPROTO_TCP */
> +	close(fd);
> +	fd =3D socket(AF_INET, SOCK_RAW, IPPROTO_TCP);
> +	if (fd < 0) {
> +		log_err("Failed to create RAW socket");
> +		goto err;
> +	}

This isn't a bug, but should this new code use the modern ASSERT_OK_FD()
macro instead of manual fd checks and log_err()?

> +
> +	optlen =3D 20;
> +	errno =3D 0;
> +	err =3D setsockopt(fd, SOL_TCP, TCP_SAVED_SYN, &buf, optlen);
> +	if (!err) {
> +		log_err("Unexpected setsockopt(TCP_SAVED_SYN)");
> +		goto err;
> +	}

Could we use ASSERT_ERR() for this error check as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504210610.1801=
50-1-kuniyu@google.com?part=3D2
