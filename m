Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E826D2566D3
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 04:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783398668; cv=none; b=MhVQgOWo6MfP81s2mGN822XAgoa2mytAqmRzlkcbNq3I5NiHpv0doOH8d17g3O7QTGiy9BHA9T9RxL9uanno+wyvI8lGnnYR8MD2dA2ird0lz/JC9poNDclCRx/pZqBPhvAc2Op5jBXkEDO5ApYyWk/dz2fuGaBP2sNTD/yRjr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783398668; c=relaxed/simple;
	bh=l7dkB4S/4+BORe2Qmei5tXusHZdDDfvUgtEq21+18p4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oArN/IrMlH6K5EKdZ9zR1Ugc43/FYewijCBIhXxBvO4AA9JWT+5xs/bv7n2IVJOEhQO5nSY2/XSPFxY5aXplNyMcn9Iu5ihhdjisx4XLlKQ1WPRpVOdQaKM5vBpZ5kKzfu8ortE8rLU9Bii+UewWjXgronJIwQb/lM6uF2hfj0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cq+riwwJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cq+riwwJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CEF1F000E9;
	Tue,  7 Jul 2026 04:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783398666;
	bh=YF8rXObOUW0dHKGAeZsTdahR/bjkQQTAgxsPHdrT6fg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cq+riwwJkOQYlJPjmjZrs/gCzkboKlfzhltdo4HPkPSalgNQNqC/EV7qA6Q1lNUZq
	 H+crvPc6tUSQfq18Oi5aQo/ybzoNQDZmTCynklLM5CQgRq1s6/DWAi7CmoUtM7JHij
	 sAhqn+X5Tdvh+gqjRm/BhyqTmmSmHNtkkLT/HzoMBE1dNcAz448DkVx9Xm8o7d5eDo
	 ahk+ABj7/R0P0VU3aG5lXHXQYyrCh5pWYAOkR5029FjaEO5enCwEydFzexSd9qxJce
	 2LeB0MARJwX6zfjwlH4FJgWnTYkjwOuWqyF6SUDFI4QSUP8ab6HMPaWndCA380lOEI
	 kVhyOyeG3wRDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v4 4/4] selftests/bpf: Fail unbound UDP on sockmap
 update
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Luczaj" <mhal@rbox.co>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260707-sockmap-lookup-udp-leak-v4-4-f878346f27ab@rbox.co>
References: <20260707-sockmap-lookup-udp-leak-v4-0-f878346f27ab@rbox.co>
 <20260707-sockmap-lookup-udp-leak-v4-4-f878346f27ab@rbox.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 04:31:06 +0000
Message-Id: <20260707043106.B1CEF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Usage of the deprecated CHECK() macro in new patch code.
--

--- Patch [4]: [PATCH bpf v4 4/4] selftests/bpf: Fail unbound UDP on sockma=
p update ---
commit 97dab8be7b651b7cede0184ca7321b97bf080f13
Author: Michal Luczaj <mhal@rbox.co>

selftests/bpf: Fail unbound UDP on sockmap update

This commit adjusts test_maps to reflect that sockmap now rejects unbound
UDP sockets. It adds a check for the socket() return value and effectively
reverts an earlier commit.

> diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/self=
tests/bpf/test_maps.c
> --- a/tools/testing/selftests/bpf/test_maps.c
> +++ b/tools/testing/selftests/bpf/test_maps.c
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
This isn't a bug, but could we use ASSERT_OK_FD() or ASSERT_GE() instead of
the deprecated CHECK() macro here?=20

The BPF subsystem coding guidelines prefer using the modern ASSERT_* family
of macros for new tests and updates.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-sockmap-lo=
okup-udp-leak-v4-0-f878346f27ab@rbox.co?part=3D4
