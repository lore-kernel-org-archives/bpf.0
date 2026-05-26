Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD587E792
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 19:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779823971; cv=none; b=Vf/tVfewgizmzx4G0fmVPtOkKag1zXW14GnxM7oHry4Cm7QpmZH+FMfwxdtAikM32bTj0csQsdlwzj+9vBpKdZqXQxGabJgMRc6YKHnFKlaRYOHJct8IOPQca+A/gj7c9c7sttGrfzsXM4Dltq5djYW5D9w+nnXin+UNd1yiGmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779823971; c=relaxed/simple;
	bh=a5ct/eHdaXinzA0e/Z3Lnbta7J3cKXXmD4hsG8LRKI8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HFAjX9+6XzK8hjPBEBb+uiDqWitQlSlGwVWvHc0E0XHuyH9NGufYsBWfAtTVNCD2QWUxq0IIL0TxQ9W+qnqiqswX/iXz9TLp9LOhGl+nj5TceQOz4pXWg6X/GN9XygihU/v32xj84ux5OnWIXbYVdsjSM4FBkE1uEoA5htMBFFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xl1sKtfv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xl1sKtfv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92CC1F000E9;
	Tue, 26 May 2026 19:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779823969;
	bh=940TWhyTCZuZ2VFlyZVFbKOAuqKFV5cE3b6yFHhruGc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xl1sKtfv+KHDuKo9qGmDSug9COxl8x8Cha+ryIVouRI1k+LS/Laft3iIRl2lgROev
	 7IklKIS36ds8Zzp2Aq3qaPXAitMSjjPmyQRkttzFAm2JljEwdUx880vdnZfz90Sb10
	 6ZdmqUyrGSnek0TSPo+LyaCVHPuPQCQDTUXatymeWQ6VWRHWXtC2zic2GVnCBeTNlX
	 6N8ECS9D6sl0FxFxY1IlyTTxbyziQ74FqUw59OKFkgOvqERDQ2aGIXj9qKnuxvEL3j
	 g/pPmmMT7c/cuFJWAAFjAsxMzSTwrQsOBqM4it1i8e4QZ3IPGui/ZD6lC5ldqWIclo
	 y+znTB8+3gkyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 5/7] selftests/bpf: add bpf_icmp_send kfunc
 cgroup_skb IPv6 tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mahe Tardy" <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260526153708.279717-6-mahe.tardy@gmail.com>
References: <20260526153708.279717-6-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 19:32:48 +0000
Message-Id: <20260526193248.B92CC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Type confusion and address truncation in getsockname() due to us=
ing struct sockaddr_in for IPv6 addresses.
--

commit 0cc9d08ecac1ed3d21b7e5cbf50d68e27cb610de
Author: Mahe Tardy <mahe.tardy@gmail.com>

selftests/bpf: add bpf_icmp_send kfunc cgroup_skb IPv6 tests

This test extends the existing cgroup_skb tests for the bpf_icmp_send
kfunc by adding IPv6 support.

> diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/t=
ools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> index 0dc6b6ceafb4a..1d6900d6a8f8c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c

[ ... ]

> @@ -79,14 +94,15 @@ static void read_icmp_errqueue(int sockfd, int expect=
ed_code)
>  	ASSERT_FAIL("no IP_RECVERR/IPV6_RECVERR control message found");
>  }
> =20
> -static void trigger_prog_read_icmp_errqueue(struct icmp_send *skel, int =
code)
> +static void trigger_prog_read_icmp_errqueue(struct icmp_send *skel, int =
code,
> +					    int af, const char *ip)
>  {
>  	int srv_fd =3D -1, client_fd =3D -1;
>  	struct sockaddr_in addr;
>  	socklen_t len =3D sizeof(addr);
> =20
> -	srv_fd =3D start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0, TIMEOUT_M=
S);
> -	if (!ASSERT_GE(srv_fd, 0, "start_server"))
> +	srv_fd =3D start_server(af, SOCK_STREAM, ip, 0, TIMEOUT_MS);
> +	if (!ASSERT_OK_FD(srv_fd, "start_server"))
>  		return;
> =20
>  	if (getsockname(srv_fd, (struct sockaddr *)&addr, &len)) {
> @@ -94,6 +110,8 @@ static void trigger_prog_read_icmp_errqueue(struct icm=
p_send *skel, int code)
>  		return;
>  	}
>  	skel->bss->server_port =3D ntohs(addr.sin_port);

[Severity: Medium]
When af is AF_INET6, does this cause an address truncation in getsockname()
since addr is defined as struct sockaddr_in?

For an IPv6 socket, getsockname() requires struct sockaddr_in6 which is
larger than struct sockaddr_in. While reading addr.sin_port happens to map
to the same memory offset as sin6_port, could this lead to type confusion
if the address fields are ever used?

Would it be safer to use struct sockaddr_storage here to ensure enough space
for either address family, similar to what is used in connect_to_fd_nonbloc=
k()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526153708.2797=
17-1-mahe.tardy@gmail.com?part=3D5
