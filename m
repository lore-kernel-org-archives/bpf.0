Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B4A3B5DED
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 23:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782948888; cv=none; b=duDfgl4IdjTYF+wHXIGedRQJI7/pbDik0HLfQASi9Rd6vmd/KpobArYCpBxoFsp1OtzC9vvY5HP1veGbcgdqo7I9WrRrTbcCO1Vh3vcWsKEYiHkLTcyBhX8zWWmLuOEM5+cKtgcp5c95BdhjROFKphosjvEpiB+86GM8iJUI4XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782948888; c=relaxed/simple;
	bh=zGN3/1F5eIrrJsOax4Q5Hct5Cjlrsq7a/s72lJnXAnU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QX10JoAIyaViu430X98vph3VFXR8KXS3hrVkM2GfvqCRNPC4PLwJ9HycjbGMLovV/gCThVbV77wCmBiYzV9uOjMzjpN6hipB9BIbxWurR3X+L9s+LE5DSPXqbAnOlEnCEtaBmw6zE4lHybPxslk1PQEMtdX+/WotSkn5gobcz7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjRoYCst; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjRoYCst"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC20B1F000E9;
	Wed,  1 Jul 2026 23:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782948887;
	bh=C1kv4uO+THNC/s8b6TQYyjLBXCvEQPDbk3aQzST8XxI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZjRoYCstaIpPcX0xwULegD9WNx+FsAU5Cv8uuUnI+4TDuwI0rbezoi5O+OtVVZg9L
	 lAq/nut93jLNnqcqEfAssOlGy8jwfxdxdkvjRuUrMvUaNrvqRxlxddST0ZVrf/YtJF
	 S82g+1rSAJ9G6gGpZTt4JXyRdjfLCBCqvEo9licPdIUbCYQb0CYEPw90LU/zKO9XVI
	 UNfP6jcDJf3dHUaPk66/oEVXnjmEO3YOmVQMt2J10516ncuTEEj7SXMOdMil4HgioL
	 AZNus4W8KS0u7HHJ+JMPG2CYrseZe0r36CwFCoZ03Ko4mLJGfgqNuaOdlLU6A1pR7/
	 ozn3SraF7vHuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 4/4] selftests/bpf: Fail unbound UDP on sockmap
 update
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Luczaj" <mhal@rbox.co>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260702-sockmap-lookup-udp-leak-v3-4-ff8de8782468@rbox.co>
References: <20260702-sockmap-lookup-udp-leak-v3-0-ff8de8782468@rbox.co>
 <20260702-sockmap-lookup-udp-leak-v3-4-ff8de8782468@rbox.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 23:34:46 +0000
Message-Id: <20260701233446.DC20B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch uses the deprecated `CHECK()` macro instead of the requir=
ed `ASSERT_*()` macros.
--

commit 050b7402e55d196faa9ab77dfc6be970046bf275
Author: Michal Luczaj <mhal@rbox.co>

selftests/bpf: Fail unbound UDP on sockmap update

This commit adjusts test_maps to reflect that sockmap now rejects unbound U=
DP
sockets. It also checks the return value of socket() when creating the test
socket.

> diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/self=
tests/bpf/test_maps.c
> index c32da7bd8be27..6a2641ee78975 100644
> --- a/tools/testing/selftests/bpf/test_maps.c
> +++ b/tools/testing/selftests/bpf/test_maps.c
[ ... ]
> @@ -759,16 +759,15 @@ static void test_sockmap(unsigned int tasks, void *=
data)
>  		goto out_sockmap;
>  	}
> =20
> -	/* Test update with unsupported UDP socket */
> +	/* Test update with unsupported unbound UDP socket */
>  	udp =3D socket(AF_INET, SOCK_DGRAM, 0);
> -	i =3D 0;
> -	err =3D bpf_map_update_elem(fd, &i, &udp, BPF_ANY);
> -	if (err) {
> -		printf("Failed socket update SOCK_DGRAM '%i:%i'\n",
> -		       i, udp);
> +	CHECK(udp < 0, "socket(AF_INET, SOCK_DGRAM)", "errno:%d\n", errno);

[Severity: Low]
This isn't a bug, but should this new code use the modern ASSERT_OK_FD()
macro rather than the deprecated CHECK() macro?

> +	err =3D bpf_map_update_elem(fd, &(int){0}, &udp, BPF_ANY);
> +	close(udp);
> +	if (!err) {
> +		printf("Unexpectedly succeeded unbound UDP update '0:%i'\n", udp);
>  		goto out_sockmap;
>  	}
> -	close(udp);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-sockmap-lo=
okup-udp-leak-v3-0-ff8de8782468@rbox.co?part=3D4
