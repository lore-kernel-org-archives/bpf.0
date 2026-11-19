Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095457;
	b=quBfUCfQ8zHSd2V78kMMFaUMRMvT82I1c0E+ugtHt2wEMGIaCbTj3YcC0OQnd2MqTV+2
	 Zj/T7NUtliXkUwP//k8ufcFfg4IPOedjmBt//7vHie9rI/6KgIDJ07ERqdFT7HTbLqGNb
	 Bu7NMoQdOYklCONlqMciKItAJoh3C28xu5/UjgGaXCqLfj6VgYbGQaw6KNnC4uuh7dpPW
	 ASRIiyVsbFr82qu8mqNOXY1P1Qm6jd6501DBZC6NuFCtnhNnuuTnmYe/NWcMun2nYKNFL
	 ZgBWkJS9LpmmiBxeHHvpBKMVwnbawCyDNHCHrAaoacIy6y4/gZXXe0oYTC+lXJIAqAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095457;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KXMe9Dm4s8z3grsbEhT7dWPgLdntQ9s28jxutqXmgcI=;
	b=o2emqGjb4RXsgW/k0xuFU8LhjhZmggLy0HvpmC/kZ+3RpBD0AJ81VMnTtBQA+vgSNyCY
	 WPi2mfy+kw/9n4e1P50H4qfVdz176dXn3fj0g1G2I4EDypl97dMZt1fibiqsZqUdq+jnW
	 9LSabI9W1MnMzVojehVJDQjrXHDAihOemPgx1409ltJafIqbuBornjkQfg975bSenEnzQ
	 JhwJ1k+E3qE4BzzgeQH6QhCmr7G8JrQWw4EMfkDBwGpABkSvsgS5f2SR9u3GTr1Kb9Z8o
	 JHjT0sCX39m+4H0UvbvfDFzMYfeLRdd9oJAgW3azGTF2vR1j4rWYeknxbDPZ0x+mpPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZbpCuAOd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1A2606A325
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZbpCuAOd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D744C1F000C4;
	Thu, 19 Nov 2026 13:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795095457;
	bh=KXMe9Dm4s8z3grsbEhT7dWPgLdntQ9s28jxutqXmgcI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZbpCuAOd7patcuPoNDUQE7L+tW3lQF27ooK9LOAhNtk81Pb6PIp7rqb1xXs0eVRpW
	 NUYHPuFaDnOx1ZApG4kOHStCEZcNFBkGzl7s4deaXZAfHJkoqq9lY4+CXyA+2lfrTI
	 ksWcDaW0ijIXtqmoPm0xxz2MFIJzcJc/3t2V9Ujz4cPIuhuLN1RNtx8lpKEHjGw/MY
	 lHJTox0UETkbe2vFZhbKFXRmlddYSFUrQ1EdE4YkIzwHwiHCLKj1EF1sGP0mrGmdzd
	 /QkW/V79/xgdinyefPWgwAtfkAVgHbBcQlBO/9HP2ZUbzPdo0hdvVzVjoT+2ZnPCTi
	 cpxA2hIVjaM3A==
Message-ID: <sashiko-outbox-223187@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 bpf 5/5] selftests/bpf: Shrink test_run frags after
 generic XDP ran on lo
Reply-To: sashiko-reviews@lists.linux.dev
To: "Slawomir Stepien" <sst@poczta.fm>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261119133032.2015656-6-sst@poczta.fm>
References: <20261119133032.2015656-1-sst@poczta.fm>
 <20261119133032.2015656-6-sst@poczta.fm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 13:37:36 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] selftests/bpf: multi-line comment style violation in
  xdp_adjust_tail.c
--

commit 9a3d1edafa68cea574abb6c7a0a6330bded5c6c7
Author: Slawomir Stepien <sst@poczta.fm>

selftests/bpf: Shrink test_run frags after generic XDP ran on lo

This commit adds a BPF selftest that sends a packet through generic XDP
on the loopback interface in a new network namespace before running
test_xdp_adjust_frags_tail_shrink().

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c b/t=
ools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
> index 43264347e7d77..c0d54cf421d8c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c

[ ... ]

> @@ -355,6 +358,52 @@ static void test_xdp_adjust_frags_tail_grow_64k(void)
>  	bpf_object__close(obj);
>  }
> =20
> +/* bpf_prog_test_run_xdp() runs on the rxq of lo's queue 0, where generic
> + * XDP sets the mem type of the frags it hands to its program. Let gener=
ic
> + * XDP see a packet on lo first, then free test_run frags from the progr=
am.
> + */

[Severity: Low]
This isn't a bug, but BPF coding style places the opening /* of a
multi-line comment on its own line with the comment text starting on the
next line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119133032.2015=
656-1-sst@poczta.fm?part=3D5
