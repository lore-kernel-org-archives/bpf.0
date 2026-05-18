Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882132DFF04
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 16:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779122738; cv=none; b=sKhpR2X6DJACjiYZUInf88aWbNts6+BqE4RcXIqy+XQvlHf07fiRzXPBrsC7fTJbPMO3rbvWZgnFwvDFisphqSEq3rOyx8XXfCSrK9q2zYFGrtTAy+Qn5d8xkiA6YGwGnluvgwbsW2WNSxVOqNM7mk6oBNXHFW+gt8X/2Kl23aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779122738; c=relaxed/simple;
	bh=9lI3n3wJfCupGx6bm0Ikv4WuSk3rSG2iHjR2vQfbjS0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hRcMbLTiGZPuCrM6YvKXM7aa9NTll58aDosNHXNwoxyUq5FHCNV8T7JAc/CSfjATEE6QwJ34+5TkgvSNfUc9+B+r7dV2arOnwEK4yr+YE2GvoEVbC4yusuhd95DKXqL0dUXRK5bqYSv8WEpPwkWiyGMZ2GiHYZpZS8vF5Vt3S3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPCNV6NB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPCNV6NB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D3BC2BCB7;
	Mon, 18 May 2026 16:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779122738;
	bh=9lI3n3wJfCupGx6bm0Ikv4WuSk3rSG2iHjR2vQfbjS0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=OPCNV6NBF4a7GnQL+h8KG17ALCho/PSMzDD/50icYv+f3eK8m2QvGd/jt1temWqDt
	 njQ82VuyqGsww4kQ2RjCCdC9aganC+vGKGp1MrBI7wBtcadNFvBO4Zr+JYIelYUPHp
	 79fir6rCoBV4vJDFhfBMkqXybfYxtGCIdaCDILRLupKAC80FyIoP5uadXpAKMmxBie
	 C5YpMbJg0MVWHNGNHhO+kdgpgEXy5LTutpI0sjbwk+Ny1wqJhYFgMELNSm3isAUkod
	 zfUbxEshDDES8NdMDi7DrA86vLKpyMn2KRc3Q2osjHcXhVuq9tSOkglTBnIB+kio+8
	 +1W/RKrY74d2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 5/6] selftests/bpf: add bpf_icmp_send kfunc
 IPv6 tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mahe Tardy" <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260518122842.218522-6-mahe.tardy@gmail.com>
References: <20260518122842.218522-6-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 16:45:37 +0000
Message-Id: <20260518164538.21D3BC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Buffer truncation and type mismatch when calling getsockname() f=
or IPv6 sockets.
--

commit 324aeb5b326896da717647e51a1e69a4c3e6f647
Author: Mahe Tardy <mahe.tardy@gmail.com>

selftests/bpf: add bpf_icmp_send kfunc IPv6 tests

This commit extends the existing ICMP send tests with IPv6 support.

> diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/t=
ools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> --- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> @@ -81,14 +95,13 @@ static void read_icmp_errqueue(int sockfd, int expect=
ed_code)
>  }
> =20
>  static void trigger_prog_read_icmp_errqueue(struct icmp_send *skel,
> -					    int code)
> +					    int code, int af, const char *ip)
>  {
>  	int srv_fd =3D -1, client_fd =3D -1;
>  	struct sockaddr_in addr;
>  	socklen_t len =3D sizeof(addr);
> =20
> -	srv_fd =3D start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0,
> -			      TIMEOUT_MS);
> +	srv_fd =3D start_server(af, SOCK_STREAM, ip, 0, TIMEOUT_MS);
>  	if (!ASSERT_GE(srv_fd, 0, "start_server"))
>  		return;
> =20
>  	if (getsockname(srv_fd, (struct sockaddr *)&addr, &len)) {
>  		close(srv_fd);
>  		return;
>  	}
>  	skel->bss->server_port =3D ntohs(addr.sin_port);

Since start_server() can now return an IPv6 socket, does getsockname() trun=
cate
the 28-byte IPv6 address data into the 16-byte sockaddr_in structure here?

Should addr be updated to a struct sockaddr_storage to safely handle both
address families, along with a cast to read the port properly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518122842.2185=
22-1-mahe.tardy@gmail.com?part=3D5
