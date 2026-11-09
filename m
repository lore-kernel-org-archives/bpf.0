Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794249319;
	b=ZeaZrHcjd+YPoYAXdK/aAJavuzjTuDP2hYn0AvjXmyJ+4focU/8P9O3EFHIn8gXx0uL9
	 8COyjLhdsA2QTUOHyV47wX7mGsF/qw5M/PExbj7Z3BJJ7Tjn6C9cVlrJSgB2HxgeJMqIK
	 uEStsgxYoZaynOnJ9lQjuLO/L48jXlSNqlBBfzdlmRc+uHgcaIMLwNOgwpLsNKHBFOMqk
	 vGHEaWYeGdk633BrrzJsIvg3QvEQhyZdGmRrvOkCtjXw7jRluDmpP4ox3U46rFZcrSmX+
	 Sd9rzyvnxZkrfsg1S4ixPil7FnbbDn3woeO17OcykZaBu3075wH7ByjZgDgYyIQlEyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794249319;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=S4YOzWBFUgxBbfQDXSdLfE9KUEn8lDmL88etHEBTpPs=;
	b=ne4uCCqtx3baxlArajvU32ykdutUdWuptapT+9P2gOAEgO5rVzwbBIio8zRXGKz7DJOi
	 6OYZCa+RsYUIBmNOfj3h1T8tsMDsFGF1qzQWyjDfc/WP3I4wKGL8Cxbu1GlTmq/Z68aIT
	 d1hq9JyRiTHTon9xRsWi6D4OfVOqPmxnv9JCqqxDTrsNtOK7AdkJLV12F94uUh1/53KGW
	 xGLNIT0c8QZ7Z3EBwBpUQgdtIQawmoeSNB/Na3drBu6nbob6gaxE8o1TLlsNDhkX1o1bS
	 1EiNgDH/pycjw8zD/RVJeVWxP8NTBxy4foZTxwVYrM6nlwjkoVPzZsURZ9kHNb8mOFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I3oka8sS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C51606A5DC
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 18:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I3oka8sS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716C21F00902;
	Mon,  9 Nov 2026 18:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794249318;
	bh=S4YOzWBFUgxBbfQDXSdLfE9KUEn8lDmL88etHEBTpPs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I3oka8sSkVXV1m8g4+9WSsTYYxYPXUswiYGvFw2DVOAhJuSm5hTRJRsuKXvujh3xh
	 I2sh5vFCs9Fh5gxbjb0ocM0VQiAcLSmKx4SaP96aBKyEc8pD2fkCGmwGg/kAQpFpwc
	 WlTuVJR0Y1uVLqEwVR7NfIJ+3dhIy3e4iJiRvbkQq9x9n1+8sSnCQUpj+5oSBz2BIz
	 iw8OGf7hWvv2Swa7RltukhJUc+Va9lHaeoA+xj8o5lPdHsdtOccOKbVBkQXnQbevAj
	 lNFrFiVjYq2MlMfd1QDj062KZv/PWvhkxLfMQ5LF8K1Cxdvb6wSuTM2oSN8iqW/iWI
	 triJjwcJDLN0A==
Message-ID: <sashiko-outbox-205422@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/6] selftests/x86: add shadow stack lock test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bill Roberts" <bill.roberts@arm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261109182758.252223-4-bill.roberts@arm.com>
References: <20261109182758.252223-1-bill.roberts@arm.com>
 <20261109182758.252223-4-bill.roberts@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 18:35:17 +0000
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
- [Low] selftests/x86: main() comment references nonexistent
  test_shadow_stack_lock()
--

commit c2aa8d04f3f8897cd4991d5c5c2ee94b8e83b82a
Author: Bill Roberts <bill.roberts@arm.com>

selftests/x86: add shadow stack lock test

This commit adds a selftest that locks the WRSS shadow stack feature and
verifies that subsequent attempts to disable it fail with -EPERM.

> diff --git a/tools/testing/selftests/x86/test_shadow_stack.c b/tools/test=
ing/selftests/x86/test_shadow_stack.c
> index b52c5420c1374..e047f1ceae0a7 100644
> --- a/tools/testing/selftests/x86/test_shadow_stack.c
> +++ b/tools/testing/selftests/x86/test_shadow_stack.c
> @@ -1060,9 +1060,28 @@ int test_ptrace(void)
>  	return 1;
>  }
> =20
> +static int test_locking(void)

[ ... ]

> @@ -1079,12 +1098,31 @@ int main(int argc, char *argv[])
>  		return 1;
>  	}
> =20
> +	/* Note: test_shadow_stack_lock() needs write enabled */
>  	if (ARCH_PRCTL(ARCH_SHSTK_ENABLE, ARCH_SHSTK_WRSS)) {

[Severity: Low]
This comment refers to test_shadow_stack_lock(), whereas the helper added a=
nd
called below is named test_locking().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109182758.2522=
23-1-bill.roberts@arm.com?part=3D3
