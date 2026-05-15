Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5326B389DF0
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 20:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778877370; cv=none; b=tf1UWJudl5bsYC4L9qoBKIDIUfr4BPv8PVclAC1SGxzDPpa/ZvD27wEtshiC9IZy1FCh9iBuQmTSgxOoH4XctiuuSJrU+SP7lp9R8oLt687PkZ12bz3g5t93xvXKZNi73aebDCObUrZUKsIs9SnG0z6I/05mOxFDAs/EzqkVtyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778877370; c=relaxed/simple;
	bh=jI6tqarsPGaco81iEqPfW1IgiYwnrNynhxjb6ExFkXI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qR0Qdp2YH2XMmsS3Nm5lmPFenGn6jtutLEL33RjiNFU/bWfOlqF4C31IU1ME73TpDpsuLysqdNVT2hgnmtuUwqNn5PPZe5PhNH6IWxf1eaiA/e2XYnz4Wa232PxMXD2F14SlrwN0sCBSdPzUx2XlnkmGZJxQqKeSjN7iBhN4rPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgFX6Mns; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgFX6Mns"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01BDC2BCB0;
	Fri, 15 May 2026 20:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778877370;
	bh=jI6tqarsPGaco81iEqPfW1IgiYwnrNynhxjb6ExFkXI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=SgFX6MnsRw2w0mGNsYC2DAWmKsdtdiuRQNux8qAf8/m9iYfPWOCdX7f7D2k46etwa
	 2FjHO785jVKNwiDrv78EeztOyaFAW0uwbvU1OY0TuJH0/9hSakr8q8SiwUaeUvLjBq
	 LBzQo2Fc3MGcuIGaL0XoDpR791wCggzR1N8RK7FTOtXNNgV4fvsB3hm45QF70nLAYK
	 oFnQ8JFvu5NnACCVJSmSo/8StbIie62ZHi96ZNDG49EwOIPhxMZYq190NFFzckHeSb
	 vRe37juU95wzPxh4CQbdljlqgKplBYgiM2OkRh6ufMEJX6qCIZbtcOHXpIQ6ie75TA
	 6hg14xPx+oaYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 2/4] selftests/bpf: add bpf_icmp_send kfunc
 tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mahe Tardy" <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260515194746.50920-3-mahe.tardy@gmail.com>
References: <20260515194746.50920-3-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 20:36:09 +0000
Message-Id: <20260515203609.E01BDC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `read_icmp_errqueue` function will silently pass without ass=
erting the error code if an `IP_RECVERR` control message is not found.
--

commit 30b471fdde74d100ff073064731c793e5f178384
Author: Mahe Tardy <mahe.tardy@gmail.com>

selftests/bpf: add bpf_icmp_send kfunc tests

This commit adds a new selftest for the bpf_icmp_send kfunc. It sets up
a client/server connection, attaches an egress cgroup_skb program to
trigger an ICMP unreach message, and verifies the correct ICMP unreach
code is received in the error queue.

> diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/t=
ools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> new file mode 100644
> index 0000000000000..b98c0312adadc
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c

[ ... ]

> +static void read_icmp_errqueue(int sockfd, int expected_code)
> +{

[ ... ]

> +	for (; cm; cm =3D CMSG_NXTHDR(&msg, cm)) {
> +		if (cm->cmsg_level !=3D IPPROTO_IP ||
> +		    cm->cmsg_type !=3D IP_RECVERR)
> +			continue;
> +
> +		sock_err =3D (struct sock_extended_err *)CMSG_DATA(cm);
> +
> +		if (!ASSERT_EQ(sock_err->ee_origin, SO_EE_ORIGIN_ICMP,
> +			       "sock_err_origin_icmp"))
> +			return;
> +		if (!ASSERT_EQ(sock_err->ee_type, ICMP_DEST_UNREACH,
> +			       "sock_err_type_dest_unreach"))
> +			return;
> +		ASSERT_EQ(sock_err->ee_code, expected_code, "sock_err_code");
> +	}
> +}

Does this function silently pass if no IP_RECVERR control message is found?

Looking at the loop, if it finishes without finding a message where
cm->cmsg_level =3D=3D IPPROTO_IP and cm->cmsg_type =3D=3D IP_RECVERR, it ex=
its
normally without executing the assertions.

Should there be a check after the loop or a boolean flag used to ensure the
expected message was actually received, rather than allowing the test to
pass successfully when the message is completely absent?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515194746.5092=
0-1-mahe.tardy@gmail.com?part=3D2
