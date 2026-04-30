Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFA0217F33
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 22:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777588290; cv=none; b=J8q7JMcKSNWkBNgin5bEiNAK6VDsvixYgnlfC6rAP+oGM2aMN5GIxH2/uqanrRVYPvpTQ2SnRZMt6PfZkWJw917EiAES9Oyon3SxJXNuTl4xmAl5BdYZqEqQBk/M9Iw1VNyhXrx8fB2fKJi/i5xH1f6QVbl6iaeqk8EhVKCMoTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777588290; c=relaxed/simple;
	bh=88NwwDNbLNgqjYIpc6ZAmAgYbj6WP/bJnHPRXhkX6Oc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KKo4igaH3sjld3OCvl++6hb3NWCc0ah3I/gfqPkJ04RS+lTshdsjb63IKzWeaV4fDbIP9y5rN+qjCN08jamrnJKEoa5Gs+68ol3diIEH+fTq4Y2YL+WQN3oggFkL/ujCFQ1T206ZIcjTKQ+TrAo4czy8o1krkj2pqKNN6H1DHPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKDYJ2/o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKDYJ2/o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A0EC2BCB3;
	Thu, 30 Apr 2026 22:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777588290;
	bh=88NwwDNbLNgqjYIpc6ZAmAgYbj6WP/bJnHPRXhkX6Oc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=BKDYJ2/o+DlU1VB6n5VGZtskR6AqL+6eMQbJbyHTy1I9jCTcNuBGJ8uK2Aulz+ux2
	 WSr42QS9jjrZS7r9qL+pppHvXLECecgZcPvMSCrjg07HExVw5MQQYkxwNHwD2Jn06H
	 iPQqOPdSog4gavAw0LLelN08zUkhhPLmG1VP7f/3lIXmtLo+BhWxrOX8nOPN+idnsX
	 OTwnFYxtldlGfCUAN/DKoGOOO1MVtSUfIpKEXJ3qGqdJol3v7E6XSUbDGZMpCzdJKW
	 0x9vbH8nRmi+0oC1dFPi1ZA/fX/xqXKiBU0DmRDCc0peZTRfHedI9jcMbASCG6QUjA
	 eFiqGfmiRqT7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/7] selftests: tls: add test for data loss on small
 pipe
Reply-To: sashiko@lists.linux.dev
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260429222944.2139041-3-kuba@kernel.org>
References: <20260429222944.2139041-3-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Apr 2026 22:31:29 +0000
Message-Id: <20260430223130.52A0EC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Test logic flaw on architectures with large page sizes defeats t=
he purpose of the test.
- [Medium] Unhandled failure paths and use of EXPECT_EQ cause uninitialized=
 memory reads and test hangs.
--

commit 52c9391392d3ea9a9876d20000032a6a0985383b
Author: Jakub Kicinski <kuba@kernel.org>

selftests: tls: add test for data loss on small pipe

This commit adds a new selftest splice_to_pipe_small to the TLS test suite.
The test verifies that data is not lost when using splice to move data from
a TLS socket into a small pipe that requires multiple iterations to drain.

> diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/=
net/tls.c
> --- a/tools/testing/selftests/net/tls.c
> +++ b/tools/testing/selftests/net/tls.c

[ ... ]

> +TEST_F(tls, splice_to_pipe_small)
> +{
> +	int send_len =3D TLS_PAYLOAD_MAX_LEN;
> +	char mem_send[TLS_PAYLOAD_MAX_LEN];
> +	char mem_recv[TLS_PAYLOAD_MAX_LEN];
> +	size_t total =3D 0;
> +	int p[2];
> +
> +	memrnd(mem_send, sizeof(mem_send));
> +
> +	ASSERT_GE(pipe(p), 0);
> +
> +	/* Shrink pipe to 1 page (typically 4096 bytes) to force multiple
> +	 * splice iterations for a 16384-byte TLS record.
> +	 */
> +	EXPECT_GE(fcntl(p[1], F_SETPIPE_SZ, 4096), 4096);

Does this test behave as expected on architectures with large page sizes?

The kernel rounds pipe capacities up to the system page size. On architectu=
res
with a 64KB page size (such as ARM64 or PowerPC), the pipe size will be set
to 64KB instead of 4096 bytes.

Since the 16KB payload easily fits within a 64KB pipe, the splice call would
transfer the entire payload in a single iteration, bypassing the intended
multiple-iteration behavior.

> +	EXPECT_EQ(send(self->fd, mem_send, send_len, 0), send_len);

Will this test hang on a short send?

Unlike ASSERT_EQ, EXPECT_EQ allows execution to continue on failure. If sen=
d()
transmits a partial payload, total will not advance enough relative to the
data on the socket. The subsequent splice() could then block indefinitely
waiting for data that will never arrive.

> +	while (total < (size_t)send_len) {
> +		ssize_t spliced, drained;
> +
> +		spliced =3D splice(self->cfd, NULL, p[1], NULL,
> +				 send_len - total, 0);
> +		EXPECT_GT(spliced, 0);
> +		if (spliced <=3D 0)
> +			break;
> +
> +		drained =3D read(p[0], mem_recv + total, spliced);
> +		EXPECT_EQ(drained, spliced);
> +		if (drained <=3D 0)
> +			break;
> +
> +		total +=3D drained;
> +	}
> +
> +	EXPECT_EQ(total, (size_t)send_len);
> +	EXPECT_EQ(memcmp(mem_send, mem_recv, send_len), 0);

Could this read uninitialized memory?

If splice() or read() return <=3D 0, the loop breaks early with total < sen=
d_len.

Because mem_recv is uninitialized stack memory, the memcmp() call will
read past mem_recv + total into uninitialized memory, triggering undefined
behavior and potential memory sanitizer failures.

> +
> +	close(p[0]);
> +	close(p[1]);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429222944.2139=
041-1-kuba@kernel.org?part=3D2
