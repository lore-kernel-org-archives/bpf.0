Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550184756CC
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045831; cv=none; b=dwo2O+VvxvxAsDJg7G+sgOzeElVuecfQkbWuQA3V2pqHZCm9wXyKK1wS+kE8ma63oYsSYS3aYdRP+D0LBLzCC65gixtnKTW/xsmR8BXAC+athtyhZIwJvvfWIzIiGNzWVUG2E/uBsMxo8LezNnoLptDNBQZa6Ch6/L4hzVxmAN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045831; c=relaxed/simple;
	bh=Z+Dfwq2jn4++rAorMvSbcick1L2UQwWVuYXiZpm++Lg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D6I72vnmh46SwH4CNK+ycVgrWUH2/Sj/RNxWAdozNk49tGeaToFZFJov4+CippAi9mJmDmXP+uF3Ac+JVjc9Vgtl8H38vaYSAFR0IEd3QN0s1aQg41uKQGqYUIjOFa5HoWtWk9EtmYM+2WY7U/qTZqwgVRaQ+yyy90jN0MqEGVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrFq+gIn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrFq+gIn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3A31F000FF;
	Thu, 10 Sep 2026 13:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789045828;
	bh=NcE0W7+mTLMlM7wr6zP6gCEJSdzPSLKmCmqvNx18GMs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lrFq+gInOn66tMTTSVjCGk6LtIFoTap99cllcMWbAf/1jo9CHD914mU0Gd4iPXM1I
	 fMx9VNz+4TxWHhmqRwTWjl0DkthX3QhSpgSNJjsTKXEj4Nhc57XH/k1IoMwfY1jRpz
	 m10B7ekr/geJJKVI05qcnFy6iMduiYqac833+3tjFNgbXm6FWoz3umZDr54SxiRf+o
	 bctowVjK/EtSxTXSZBDyLYuq7eGNCZUxmoKzAoBQIpPKAW5gIF+y/cNvlMsrsYb17E
	 zdsLdAX3jy9KYc3YXcz6Jxswyg7OPgZLN9ebiODxPaK/IY7arbYLctd6tEOJZGRNCs
	 t9M7vZSrwzTQA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 4/5] selftests/bpf: add multi-stream
 sequentiality example model
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: tj@kernel.org, mkoutny@suse.com, hannes@cmpxchg.org, bpf@vger.kernel.org
In-Reply-To: <20260910125817.223354-5-cui.tao@linux.dev>
References: <20260910125817.223354-1-cui.tao@linux.dev>
 <20260910125817.223354-5-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 13:10:28 +0000
Message-Id: <20260910131028.9B3A31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Concurrent accesses and modifications to shared cgroup storage w=
ithout synchronization.
--

commit 00d96497e1688fa01fa5b76f7ec3a10048823d74
Author: Tao Cui <cuitao@kylinos.cn>

selftests/bpf: add multi-stream sequentiality example model

This commit introduces a new example cost model for iocost using eBPF,
replacing the single-cursor sequentiality heuristic with a per-cgroup table
of stream slots. The stream state is maintained in a CGRP_STORAGE map keyed
by the cgroup.

> diff --git a/tools/testing/selftests/bpf/progs/iocost_ms.c b/tools/testin=
g/selftests/bpf/progs/iocost_ms.c
> new file mode 100644
> index 0000000000000..3cc57c03d3c88
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/iocost_ms.c

[ ... ]

> +	now =3D bpf_ktime_get_ns();
> +	for (i =3D 0; i < NSLOTS; i++) {
> +		if (s->expected[i] =3D=3D sector && s->stamp[i]) {
> +			found =3D i;
> +			break;
> +		}
> +	}
> +	if (found !=3D 0xFFFFFFFF) {
> +		/* sequential: keep the seq base from the op branch */
> +		s->expected[found] =3D sector + advance;
> +		s->stamp[found] =3D now;

[Severity: Medium]
Are these lockless updates susceptible to data races? Multiple CPUs process=
ing
IO for the same cgroup could concurrently execute iocost_ms_calc_cost() and
modify the shared cgroup storage.

Could this concurrency result in lost updates or interleaved reads and writ=
es,
leading to inaccuracies in the sequential IO heuristic?

> +	} else {
> +		base =3D randio;
> +		for (i =3D 1; i < NSLOTS; i++) {
> +			if (s->stamp[i] < s->stamp[victim])
> +				victim =3D i;
> +		}
> +		s->expected[victim] =3D sector + advance;
> +		s->stamp[victim] =3D now;

[Severity: Medium]
Similarly, when claiming and updating a new stream slot, could multiple
CPUs select the same victim concurrently?

While lockless updates are often an intentional performance tradeoff in IO
hotpaths and this is an example model, could the resulting data races on the
expected and stamp arrays cause unintended behavior when tracking interleav=
ed
streams?

> +	}
> +
> +	pages =3D RU(nbytes, IOC_PAGE_SIZE);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910125817.2233=
54-1-cui.tao@linux.dev?part=3D4
