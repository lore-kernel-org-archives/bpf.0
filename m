Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B5D2EEE76
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 23:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780617544; cv=none; b=dBmAovrkwgfuc6YJsdvI+DAywRBYujv9e5Oli+Q35yORoikbAPcJfUaH3DroPWn3fOS84huHWrGj7MBKeZq8B5ogbLuAKyrKeECDuPSp3KFVqIheIZqbrdhrKsNytbTtQJWmsQbHx5JX3s3k/BzqiLZx8wdoRbWWzt3ogN7JDEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780617544; c=relaxed/simple;
	bh=vNztx0X9JmzyE6XRM8az32RWwvogrpiO9gvgYKRaW7s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GLmo91Lo2V3mumQQ/SMfZ2+6BM0/7vAfyQAkoHw9xBr3i43xAnlj/b2KFYO31CkNDG9wAgXgDln8NLLtA58znkaJYFUz75ZByGp5jKRO73eDxSATWMcUsYG2I87xbOjWb8eSR0JQyg9wZKobf5W3MKgX0EIObUzp6hzCMX0QDOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qhbc8v8h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qhbc8v8h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD141F00893;
	Thu,  4 Jun 2026 23:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780617542;
	bh=zwb+P4TFCUaOcQcbUr96+2EIQ+rs/ADpSyRQThy5EFk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qhbc8v8ha+Ki5iRv8KKfKke4uNRfm3yBLrHFgVfiHiyxG+vOBtVqxW4t9ewfby4mq
	 6FC4l5ctdp5B1L6sjoiPBiexQ5wIK1j3yZcqLQnYyhrrVokjrsJDCgIJcdj1OC/kxv
	 TNdgKg0RbZCKC4edGzHb/N6RzdUKBhL0BoMN8WwOr7U5yaOIFaOSZZO5VBc/6B1Cki
	 XIqd1CuuEaMdqlJGBgqrjniQ1II25V1o7ItpIhhX20c1DFGL7Z47oyd4bls5d8Vka7
	 Er9CJwjmLE3VdNqBe0Muf/26k5B9I71V3+pgUtpJ4nZAeoTN8sK7BC1wIkwZ4ac1nM
	 X63LDAl3OT8JQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: libarena: Add spmc queue
 data structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260604235016.20856-3-emil@etsalapatis.com>
References: <20260604235016.20856-3-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 23:59:02 +0000
Message-Id: <20260604235902.BDD141F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Variadic format string specifier mismatch in selftest logging.
--

commit 642caf26abcc9e080fc29e8529df46f84a968a90
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: libarena: Add spmc queue data structure

Expand libarena with a single producer multiple consumer deque data
structure. This lock-free and wait-free structure permits efficient work
stealing. The queue exposes functions for pushing, popping, and stealing
work items.

> diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_spmc.bpf=
.c b/tools/testing/selftests/bpf/libarena/selftests/test_spmc.bpf.c
> new file mode 100644
> index 0000000000000..e458dd330906b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/selftests/test_spmc.bpf.c
[ ... ]
> +SEC("syscall")
> +int test_spmc_remove_many(void)
> +{
> +	u64 val, newval;
> +	int ret, i;
> +	u64 expected;
[ ... ]
> +	for (i =3D 0; i < 500 && can_loop; i++) {
> +		ret =3D spmc_owned_remove(spmc, &newval);
> +		if (ret) {
> +			arena_stderr("%s:%d error %d\n", __func__, __LINE__, ret);
> +			return 1;
> +		}
> +
> +		expected =3D 500 - 1 - i;
> +		if (newval !=3D expected) {
> +			arena_stderr("%s:%d expected %lu found %lu\n", __func__, __LINE__, ex=
pected, newval);

[Severity: Low]
Do these format specifiers match the variable types? Both expected and
newval are declared as u64, but %lu is being used. Should these use
%llu to avoid compiler warnings about format string mismatches?

> +			return 1;
> +		}
> +	}
> +
> +	spmc_destroy(spmc);
> +
> +	return 0;
> +}
> +
> +SEC("syscall")
> +int test_spmc_steal_many(void)
> +{
> +	u64 val, newval;
> +	int ret, i;
[ ... ]
> +	for (i =3D 0; i < 500 && can_loop; i++) {
> +		ret =3D spmc_steal(spmc, &newval);
> +		if (ret) {
> +			arena_stderr("%s:%d error %d\n", __func__, __LINE__, ret);
> +			return 1;
> +		}
> +
> +		if (newval !=3D i) {
> +			arena_stderr("%s:%d expected %lu found %lu\n", __func__, __LINE__, i,=
 newval);

[Severity: Low]
Does this format string specifier mismatch the arguments? The variable i
is declared as an int, but is passed to a %lu specifier. Could this result
in garbage output when printing?

> +			return 1;
> +		}
> +	}
> +
> +	spmc_destroy(spmc);
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604235016.2085=
6-1-emil@etsalapatis.com?part=3D2
