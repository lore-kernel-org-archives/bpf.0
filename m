Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1161C37EFE7
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 03:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789098905; cv=none; b=dzh9wTPLYOtcXJqvUB8G3UHSlaNRarWIs7rQW3WEq/0RXbJSGdSDHje93fgJhO5pbY0o34OSz7JMy/W87zLoUw8D11rP1EkdtgdbWv71mfrpyaThb+tCwVbm1cisfQDRyZacCC5h/EguMwrqfIqRJWJW714eQOwNi7+DGMZQ0ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789098905; c=relaxed/simple;
	bh=Sc2BPmbf6jWUDM9URXd6ODGVAxr+vgtRaH4vZLPCaa0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hTEiilS6PvAsDfvbaugS4+T+2YlhdR4bAoeJETlT4Ply6dM1fbF9fn/iC8lbNqYyC7OFhSJtJGj4ypjJ0Xti8XQJ9KsVIIKCLo5oqIDsr6doxywqTkRI25AyskpKMErkVbeIv7CQZ+oqBRB1jXSmvfuv+v+/9O5oCETtiI7CYJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrkQ2my9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrkQ2my9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891321F000FF;
	Fri, 11 Sep 2026 03:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789098903;
	bh=wnCpbL7w7KI6DPULRa0j5nWWocnFi5y6GOSNoQxArgE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hrkQ2my99C1VoBMdYA6iHQkvs2ejRZJSc4Eml9sGPViOK+n4fLqJjA3Kl44k33nuG
	 KVVcFF8qxXTQ/2bzZ7feWandmEnzzHiKtOMD0xt0CwQJCBGrQ9TaWxzMqxiGFA0beH
	 gYsQ4loJoNuUtbq6LPeb+cs35ZY5PqMkqlX/Q0V32j8NPwl4QanOIDOm7MUU6aTCZ5
	 M2vQ/uCV03rsItHfA6UJ/so9MfNerMSzPBgGaR/A6R4RxEQecCZKCgI52u3c+v7+7B
	 fpwBgaWuei/OsxYdyjuC4SNTAjVFf/hWkXpVdn+pIueihEmXrLCB1MJxXZBek1Cdz2
	 yB5MoMLkbw69g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: Cover recursive bpftool
 map dumps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tianyi Chen" <diannaaav@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260911034715.219552-3-diannaaav@gmail.com>
References: <20260911034715.219552-1-diannaaav@gmail.com>
 <20260911034715.219552-3-diannaaav@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 03:55:03 +0000
Message-Id: <20260911035503.891321F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Dangerous accumulation of `snprintf` return values without bound=
s checking can lead to a stack buffer overflow.
--

commit 9bcae338c80433d98472777c175bac68e5e0d8b5
Author: Tianyi Chen <hi@tychen.cc>

selftests/bpf: Cover recursive bpftool map dumps

This commit adds selftests to exercise recursive map dumping for
array-of-maps and hash-of-maps. It verifies complete JSON documents against
nonrecursive entry representations, checks both short and long options, and
tests file descriptor retention under limits.

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c b/=
tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
[ ... ]
> +static void test_multiple_roots(void)
> +{
> +	LIBBPF_OPTS(bpf_map_create_opts, opts);
> +	char command[MAX_BPFTOOL_CMD_LEN], name[BPF_OBJ_NAME_LEN];
> +	char output[OUTPUT_SIZE] =3D {}, expected[OUTPUT_SIZE * 4], elements[OU=
TPUT_SIZE];
[ ... ]
> +	for (i =3D 0; i < ARRAY_SIZE(fds); i++) {
> +		ids[i] =3D map_id(fds[i]);
> +		if (!ids[i] || !dump_map(ids[i], "-j", elements))
> +			goto out;
> +		len +=3D snprintf(expected + len, sizeof(expected) - len,
> +				"%s{\"id\":%u,\"type\":\"%s\",\"name\":\"%s\","
> +				"\"flags\":0,\"elements\":%s}%s",
> +				i ? "," : "[", ids[i], types[i],
> +				i =3D=3D 3 ? "dump_discovered" : name, elements, i =3D=3D 3 ? "]" : =
"");

[Severity: Medium]
Could this accumulation of the snprintf return value cause a stack buffer
overflow?

snprintf returns the number of bytes that would have been written, not the
number of bytes actually written. If the accumulated length exceeds
sizeof(expected), the subsequent loop iteration passes sizeof(expected) - l=
en
as the buffer size, which underflows to a large unsigned integer since the
sizeof operator yields a size_t.=20

Since the elements buffer can hold up to 8191 bytes, over 4 iterations
this can mathematically exceed the 32768 bytes of expected when combined wi=
th
the JSON formatting overhead (for instance, if bpftool produces unexpectedly
long output or errors).

Does this code need a bounds check before adding to len to prevent writing
past the end of the expected stack buffer?

> +	}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911034715.2195=
52-1-diannaaav@gmail.com?part=3D2
