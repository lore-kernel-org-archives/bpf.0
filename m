Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795258753;
	b=SSlnRZdna3BRkabKbLCFdWtVZm381vySIQ18cvgqMkmCualQO0qoWwiS+SZ0Yfz6bSti
	 wZIix8RNm9LcO1NtnM6CMTVQf3tr/15MKdm/sq3tqu2XlF4Drm7oV0N38jWTG65Xb7LBN
	 gz5jiFpFVeC/G0T1ZIz3TYOlOshLA0leZasoclmBwa3ozOE+Dv+IZKKwDMQVrGF+Fx7hr
	 tPzv55VaHETYKVQrs/a/XRL0KlLiAx0h8WLXUhVHkI1XHbnBE0jFSRCba5SLFggN+FNLt
	 GMiHIY9T3Yz/9JxMq/vWG6x6g52GsB9U/IyzqAmIDgOkx799ZbrF4Ai5ptUKXHKhsCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795258753;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oPJ38whhcjxMpK9Es8GPGojZvC8dSHYXQDm1tcGaepI=;
	b=VCcJShNxfkcylSQ5O5S/pYImJULs/s2Y1+rpZH9bra0oEwCSdXHtkjwLVl1rxoIVUp/2
	 OMEiHEvWv8ZDLQFQH9YkKg96tZnTFMwWn6fC5UBAQoeOdZW3lSJhP6/aQhcxwmpkXY1Ix
	 ps7B2GUW2evXongru5Uzn6Wfb5C6twGWuJdGq0/gFtZYrgNknn9S6mAO9df7tmBMhBK3A
	 qz1gK/8uAifGnDjKFHmhpmhIThIg1inrUDC2IYyjBo+RapnmzYZY4bPzJrus1obkGIYEZ
	 JMorY/lkd0wcKMVVEcwOzjj6NiabwcpfCCAdw4B78lEB0fSxSj6fh2rkjbjTz9K3CYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="d/b3x48B";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0072C606A32A
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d/b3x48B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4EC1F000D4;
	Sat, 21 Nov 2026 10:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795258752;
	bh=oPJ38whhcjxMpK9Es8GPGojZvC8dSHYXQDm1tcGaepI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=d/b3x48ByPoJivaouf287zJkbBfhZJKy8KhBlvDTeRF+QF37xbEe+HSsiXob0yDtB
	 mK23yr57dHsLAa2okyITh46MuTNPxXCcIofF/zUT6joWe1zF9f7Vg4Dh5RhVC9R82H
	 vjW/K4EngQ4vsyvoI8OFZFRlOWeUfBRiG5NtWt+B1M6JSWeGwETgxLK7CK2deaj2xL
	 1d9KUP3gykE9vJMj+LbusI6u82qeXl90hrm8F1s9kreNQn1oJEcfH+LVDMU1KZF3f+
	 Oy7QWnZNxgvbpfhwyCXO6waZitw9MssT1haNfg003eSqGtdkXA+QNp5Bt17jQQleiC
	 Xxt2bQ6WZReyA==
Message-ID: <sashiko-outbox-226964@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 02/11] selftests/bpf: Add test for unread SK_PASS
 data with strparser
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, bpf@vger.kernel.org
In-Reply-To: <20261121103222.88209-3-jiayuan.chen@linux.dev>
References: <20261121103222.88209-1-jiayuan.chen@linux.dev>
 <20261121103222.88209-3-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 10:59:09 +0000
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
- [Low] selftests/bpf: unbounded FIONREAD polling loop in
  sockmap_strp_wait_fionread()
--

commit 7dc8918154820719ad134eef16ba69d4d7e96153
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

selftests/bpf: Add test for unread SK_PASS data with strparser

This commit adds IPv4 and IPv6 sockmap strparser subtests verifying that
unread SK_PASS data across multiple parser invocations does not stall
subsequent packet delivery.

> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c b/tool=
s/testing/selftests/bpf/prog_tests/sockmap_strp.c
> index 1d7231728eafd..18eb0c791e492 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
> @@ -364,6 +364,88 @@ static void test_sockmap_strp_pass(int family, int s=
otype, bool fionread)
>  	test_sockmap_strp__destroy(strp);
>  }
> =20
> +static int sockmap_strp_wait_fionread(int fd, int expected)
> +{
> +	int err, avail =3D 0;
> +
> +	while (1) {
> +		err =3D ioctl(fd, FIONREAD, &avail);
> +		if (!ASSERT_OK(err, "ioctl(FIONREAD) error"))
> +			return -1;
> +		if (avail >=3D expected)
> +			break;
> +		usleep(10000);
> +	}
> +	return ASSERT_EQ(avail, expected, "ioctl(FIONREAD)") ? 0 : -1;
> +}

[Severity: Low]
Can sockmap_strp_wait_fionread() hang test_progs forever if a regression
prevents the expected bytes from arriving?  Without a timeout or retry
bound on the loop, avail < expected spins indefinitely instead of exiting
and failing the ASSERT_EQ() check.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121103222.8820=
9-1-jiayuan.chen@linux.dev?part=3D2
