Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D9B36A02C
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 16:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701944; cv=none; b=hCCgYUyIZsWAbesgqFSlJ4SVVz/zcpQ9dRiTovPGSLM/VjozireIekTrIGSmuQ/mqbDeblWmkH47qVchjPm3s2faeY0dOMF1/nt22l1lq7ZBt9sTJ/vxU26mPX6Yjf628a+Q2a691IFxZ4RjxNRDxQZO9NI4qblAAdq539ltsxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701944; c=relaxed/simple;
	bh=md8QwCGgG5iP0jBi+SfANGftt61owOqnIs7ebnj/Sjg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Aprzsc6a858v86X2uwQxZ/Aqg6RnUQZMuLKOlUtdXa2F7oTmz/Q3YIVUEa2Khh8qYTUwFgzcN+L+ge/sUxEhk5YqR/YvPJUmKFmaGdAAqGhBJvB2dbzxuK8M669kT6YjjxyfVuZtyasPDBaEEwHe7+zpeQzCOFxs03xwK8Y74/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jf0aXV1D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jf0aXV1D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8651F000E9;
	Fri, 10 Jul 2026 16:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783701941;
	bh=0WpCXV5LuoACRWINceSLEum3MVUVK609fZc49wENrXU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jf0aXV1DbBZ16yXpnmJ4TwAZAesH2EpYy2CD2gTtywn+Zi028H0HKsrMpAfvGQnqe
	 xpSnLn+mOaFFglBIhj1ERig3WJ1upMPtbXXlGdM/vgZOFxSVQptI1b6gHbnBesl8uy
	 xiCl4qr581bUcbfmXvY7hlZTQcN5DShnfz6kRpx7rGY6vpn4JRPu95VmKy09VTj36W
	 CO6QVImHiNMBdndHMY298I5xp49HDFRCGhT47DF/fqSL31G50Ag9/3I6GZlgDFfvGm
	 TDofDQEJQb3jF3mr3SsvCC4NGbyJ60HU8mEHrhM5JqSsGQnjC2OTAZzLGq6inQ5Jxh
	 ikSpWqfNzcWbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] selftests/bpf: keep polling connection that is
 still in progress
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260710-tc_tunnel_flaky-v1-1-42aab5399a49@bootlin.com>
References: <20260710-tc_tunnel_flaky-v1-1-42aab5399a49@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 16:45:40 +0000
Message-Id: <20260710164541.6A8651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Synchronous connect() failures no longer log an error message, d=
egrading CI diagnostics.
--

--- Patch [1]: [PATCH bpf] selftests/bpf: keep polling connection that is s=
till in progress ---
commit c5020ae0b8634553031ed87b4d98c575b3b3d310
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

selftests/bpf: keep polling connection that is still in progress

This commit modifies the network test helper connect_to_addr() to handle
connections that return EINPROGRESS. Instead of failing immediately, it pol=
ls
the socket up to a timeout, helping CI reliability under load.

> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testin=
g/selftests/bpf/network_helpers.c
> index b82f572641b7d..97ddbe589e533 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
[ ... ]
> @@ -294,7 +297,8 @@ int client_socket(int family, int type,
>  int connect_to_addr(int type, const struct sockaddr_storage *addr, sockl=
en_t addrlen,
>  		    const struct network_helper_opts *opts)
>  {
[ ... ]
> -	if (connect(fd, (const struct sockaddr *)addr, addrlen)) {
> -		log_err("Failed to connect to server");
> -		save_errno_close(fd);
> -		return -1;
> +	err =3D connect(fd, (const struct sockaddr *)addr, addrlen);
> +	if (err && errno =3D=3D EINPROGRESS) {
[ ... ]
> +		if (err) {
> +			log_err("Failed to connect to server");
> +			errno =3D err;
> +			goto close;
> +		}
> +	} else if (err) {
> +		goto close;
>  	}

[Severity: Medium]
Does this unintentionally silence synchronous connection errors?

Before this patch, any failure from connect() would print "Failed to
connect to server" before closing the socket. With this change, if connect()
fails synchronously with an error other than EINPROGRESS (like ECONNREFUSED=
),
it hits this else-if block and goes straight to close without logging.=20

Could this make debugging non-EINPROGRESS failures more difficult in CI?

> =20
>  	return fd;
> +close:
> +	save_errno_close(fd);
> +	return -1;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-tc_tunnel_=
flaky-v1-1-42aab5399a49@bootlin.com?part=3D1
