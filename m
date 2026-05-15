Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5432E413D94
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 20:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778877885; cv=none; b=Ima8ijUaifWyrmBS8XqOCEKkJUf+5us1WefyRXpaZh+Zctdy+Fu59jZohlJkBPBLH49qCulftPWV4Bo1XRw6RhomNqtRxzvWY6kSKykGzGJbwQX0wxNkzYDotMzUM4kE/t8MeHGg0jHBXc2EdKlvjB/cp3Db/v5EJOQHoZZyKw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778877885; c=relaxed/simple;
	bh=HLKp3U6SjWnfr4cBAD4UHXHCEP45F2YpxiEapuxplqs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lcs8tgzp9K32CAbOdVbPvUQICpKLucNt83hXUSAK0/feCm4ShecfJahRVI8m2qtYaGFrdBZsZXbJqwLm5PkA2ldSuNf/hnA9oG2+WcwAevgHGqBmzDnrhFz3f3dMNQLDsrycPuLxKLh1Z8hEcIx1RMYqbNSLEIFkeWGLlTHvp34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+syuu6l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+syuu6l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8204C2BCB0;
	Fri, 15 May 2026 20:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778877885;
	bh=HLKp3U6SjWnfr4cBAD4UHXHCEP45F2YpxiEapuxplqs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=j+syuu6lRPpMwjeQyOOJYVYjQ3dNhNrEuuRXqOh2ryQVv8pwVhf6YmD0OHoHwfugU
	 CcUzmQgYdFoOMZs0ZXpWLHeIDWp3MaVyjPsNB0g4r+aEkyGWEpj0hGytM47mh4aqWO
	 4LcKRwhraa5zIvABBueMOJBsy5HxUhLsxJLluChOtS6NRfYr2egh6TQ9vhb4XszG17
	 rn+w3qraNat8wsqXSBwwAIJ9Bq4ozkZcMcTIqJC0CNps7J6RizSIHy+pRn0j5kUuOJ
	 g2XxVUFpj6pv1G6Qu3HNF6PtqUGlqTScp86l5tYN9StctKsdac8IbX+Bv3JMsvAM3a
	 Or79MusND0G/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 3/4] selftests/bpf: add bpf_icmp_send kfunc
 IPv6 tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mahe Tardy" <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260515194746.50920-4-mahe.tardy@gmail.com>
References: <20260515194746.50920-4-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 20:44:44 +0000
Message-Id: <20260515204444.D8204C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Buffer truncation and type confusion when calling getsockname() =
for IPv6 sockets.
--

commit 3f16e831f177058fc11380fe48e08f94594b83bf
Author: Mahe Tardy <mahe.tardy@gmail.com>

selftests/bpf: add bpf_icmp_send kfunc IPv6 tests

This commit extends the existing bpf_icmp_send kfunc tests with IPv6
support. It updates the test suite to handle IPv6 connections and
ICMPv6 error queues.

> diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/t=
ools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> index b98c0312adadc..d9badfc6e620c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c

[ ... ]

> @@ -78,14 +92,13 @@ static void read_icmp_errqueue(int sockfd, int expect=
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
> @@ -94,6 +107,8 @@ static void trigger_prog_read_icmp_errqueue(struct icm=
p_send *skel,
>  		return;
>  	}
>  	skel->bss->server_port =3D ntohs(addr.sin_port);

When af is AF_INET6, start_server() creates an IPv6 socket, but addr
is hardcoded as struct sockaddr_in which is 16 bytes.

Does this cause getsockname() to silently truncate the 28-byte
sockaddr_in6 structure because len is initialized to sizeof(addr)?

While reading addr.sin_port happens to work because sin_port and sin6_port
share the same offset, would it be better to use struct sockaddr_storage=20
here (like in connect_to_fd_nonblock() earlier in the file) and extract
the port conditionally based on the address family to avoid type confusion?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515194746.5092=
0-1-mahe.tardy@gmail.com?part=3D3
