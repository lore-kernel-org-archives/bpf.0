Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6031F1534
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 20:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782506487; cv=none; b=WEaftgAUT55GxT6CJX2XtJtIsAsj+Sn+lGkEqdeeri5U6YhZGK6J1XEn4zTNwyIjdrUwDpFdEuNTuj/v/01ExshuKxMnMidYjUlw0M0ugtG48Cg5/XqJ3+98LGuchDiZVecHy27GGkvQLAm9JB/0TWX5KluEy1gLbSPZbCVDQ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782506487; c=relaxed/simple;
	bh=i0A/Ox3WhbwZ8AonnfklU1LaEphaTGFGvTsmUgTFWlw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N4TK3KnUZGeLd7EroyvS/OXQZRy2IG2mJBWY09Cr/D0YBnmMjq/79nSPVnuaA5OgKeV/kiQPzb/zU+mf53BlgC4jWFuUYMxSF3YYtc5zEeJ37n9+1hdpTZhQYm8PgkrS6nIZdrseZs91NqLlRT0EIXxMTAz2yJIrzdwk2FF0tl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhSo1Q14; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhSo1Q14"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75961F000E9;
	Fri, 26 Jun 2026 20:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782506486;
	bh=pZOV46DjW++6Rh2e6okShWF5Wv8h8pdOEAB3PHY/5Q4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LhSo1Q140hvgDZVZIDwvb2iG4YlQXIOQ1i3Km9DVyGmS4rkAM0eielyCF5mcOi/Ov
	 24zimH742/9N/JWMXueYs7gip8apOHfOFVLRmvso0PI2pD6AnVlq/JqwvPQcx1xAZj
	 v3CeVAePFwStpJSWUY+4A9wyxR2UWXMb0DvHWvaCWaIKzACDWxvIv5fOVhDy2Q3vMi
	 AX8SYJFiRtcFM5a1zfmMXHk9szVgzo/uHcUe0J0nIDTc0mviwlM6+sU/MR60oBd1se
	 F6ssZrxx1XA7EhFQmnKPLdWi0Xc5o+Wj6O3DbKjOR/I7y/AIj04p7EKRScZcL5eWlb
	 JlnTsru/p7krA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 4/4] selftests/bpf: Fail unbound UDP on sockmap
 update
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Luczaj" <mhal@rbox.co>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260626-sockmap-lookup-udp-leak-v2-4-7e7e201c951a@rbox.co>
References: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co>
 <20260626-sockmap-lookup-udp-leak-v2-4-7e7e201c951a@rbox.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 20:41:25 +0000
Message-Id: <20260626204125.C75961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing check for `socket()` failure leads to a false positive t=
est pass.
--

commit 7f8484db13c3ae1f9676009ab7e283f2b68e4ae0
Author: Michal Luczaj <mhal@rbox.co>

selftests/bpf: Fail unbound UDP on sockmap update

This commit modifies test_maps to expect a failure when updating a sockmap
with an unbound UDP socket. It effectively reverts a previous selftests
change now that sockmap rejects unbound UDP sockets.

> diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/self=
tests/bpf/test_maps.c
> --- a/tools/testing/selftests/bpf/test_maps.c
> +++ b/tools/testing/selftests/bpf/test_maps.c
> @@ -759,12 +759,12 @@ static void test_sockmap(unsigned int tasks, void *=
data)
>  		goto out_sockmap;
>  	}
> =20
> -	/* Test update with unsupported UDP socket */
> +	/* Test update with unsupported unbound UDP socket */
>  	udp =3D socket(AF_INET, SOCK_DGRAM, 0);
>  	i =3D 0;
>  	err =3D bpf_map_update_elem(fd, &i, &udp, BPF_ANY);

[Severity: Medium]
Will test_sockmap() in tools/testing/selftests/bpf/test_maps.c now silently
pass if socket() fails to create a file descriptor?

Because this patch changes the logic to expect an error from
bpf_map_update_elem() by checking if (!err), if socket() returns -1 due to
setup failures, bpf_map_update_elem() will fail with an error like -EBADF.

This would cause the test to erroneously pass without actually testing the
kernel's behavior for unbound UDP sockets. Does this test need a check to
ensure the returned udp file descriptor is valid before proceeding with the
map update?

> -	if (err) {
> -		printf("Failed socket update SOCK_DGRAM '%i:%i'\n",
> +	if (!err) {
> +		printf("Failed allowed unbound SOCK_DGRAM socket update '%i:%i'\n",
>  		       i, udp);
>  		goto out_sockmap;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-sockmap-lo=
okup-udp-leak-v2-0-7e7e201c951a@rbox.co?part=3D4
