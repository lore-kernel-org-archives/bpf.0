Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2E54DB57B;
	Thu,  9 Jul 2026 18:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622360; cv=none; b=UthR2sP4pr+J40tfLDj9NF1slv7aUBDSGLPiR63uMv8tr4yHwDA7Z2vAabPL+llnAkXdD72Sx/tIxw5jLEqlups5bO6X2zXQghlLnUmeX3JAcCG7Q5d/LpNaiUWjH4RZ7e2LGqfJfKD6XXkX/LZ1az4P1TJS8G2HlGq3VWs+PTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622360; c=relaxed/simple;
	bh=Ao+OcpDkVECfaEnSWFvbxU5FyjXTDFHFObfvlqNIR+w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CsQPz2PgZ9HOt2vKdTR/6KOL4vBO3NQsPRgyDBtj+oqyvWxikaU14ArFsgAnufgi9445jIfReoDDrbxGskot33Wi5CISJmHtnymo0sLNgE1y3GzOBXRa6NXlXVlLwfh+j8jRV4KLVJbkPODzOe2vX0DSyZ0bEHgr9Jfyt8sqk4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7vRPc7F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7vRPc7F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42371F000E9;
	Thu,  9 Jul 2026 18:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783622359;
	bh=I2mN5+IHh+LQpJA/DfMOeoxSfYikw5y1RdeZJo4AfJk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I7vRPc7Fj5YQd/axeswmIHeSy9ULK338vaH5NAy6gvDc1z1LENUdwwsW5EieVjXTX
	 2n/DeIiuGMSyJO1jKGuKNmUOHrloNWhRSyovoquHpC68upGufrhWhJ2j4WS/t/HzPO
	 ytmzCWUWvxuTXne4x+WYY5N5390BM5GLCkhcgx/9wHu9ayaBKCqIZj40NVn7W5N94M
	 H7vzuwgbkH2gu/o9ehBDqYH+aDZ579+zpXKbt14bmNqZDidoldwSARgYL1fK8s1oEt
	 mgBKH7SySnwKC/C+ND64oxk7rU44LfgQw87q5lwJS1luTYQXfnNd4vJR+Pn4H2G31Z
	 DUwnOcvZha6Ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Require a BPF cpumask for
 bpf_cpumask_populate()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicholas Dudar" <main.kalliope@gmail.com>
Cc: bpf@vger.kernel.org, sched-ext@lists.linux.dev
In-Reply-To: <20260709182800.2037938-2-main.kalliope@gmail.com>
References: <20260709182800.2037938-1-main.kalliope@gmail.com>
 <20260709182800.2037938-2-main.kalliope@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 18:39:18 +0000
Message-Id: <20260709183918.E42371F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The BPF selftests and their headers were not updated to reflect the=
 new `struct bpf_cpumask *` signature for `bpf_cpumask_populate()`.
--

--- Patch [1]: [PATCH bpf-next v3 1/2] bpf: Require a BPF cpumask for bpf_c=
pumask_populate() ---
commit 79080c077263fb184f42fe92f3d8db1f3967a4b5
Author: Nicholas Dudar <main.kalliope@gmail.com>

bpf: Require a BPF cpumask for bpf_cpumask_populate()

This commit changes the first argument of bpf_cpumask_populate() to require
a struct bpf_cpumask pointer instead of a struct cpumask pointer. This
ensures the function follows the same ownership rules as other mutating
cpumask kfuncs.

> diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
> index b8c805b4b06a0..1336a4efa7553 100644
> --- a/kernel/bpf/cpumask.c
> +++ b/kernel/bpf/cpumask.c
[ ... ]
> @@ -467,7 +467,7 @@ __bpf_kfunc int bpf_cpumask_populate(struct cpumask *=
cpumask, void *src, size_t
>  		!IS_ALIGNED(source, sizeof(long)))
>  		return -EINVAL;
> =20
> -	bitmap_copy(cpumask_bits(cpumask), src, nr_cpu_ids);
> +	bitmap_copy(cpumask_bits(&cpumask->cpumask), src, nr_cpu_ids);
> =20
>  	return 0;
>  }
> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/i=
nclude/scx/compat.bpf.h
> index 87f15f2962348..3f74d522f7e79 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -84,7 +84,7 @@ bool scx_bpf_dispatch_vtime_from_dsq___old(struct bpf_i=
ter_scx_dsq *it__iter, st
>   *
>   * Compat macro will be dropped on v6.19 release.
>   */
> -int bpf_cpumask_populate(struct cpumask *dst, void *src, size_t src__sz)=
 __ksym __weak;
> +int bpf_cpumask_populate(struct bpf_cpumask *dst, void *src, size_t src_=
_sz) __ksym __weak;

[Severity: Low]
This isn't a bug, but should the BPF selftest headers also be updated to
reflect this new signature?

Looking at tools/testing/selftests/bpf/progs/cpumask_common.h, it appears it
still declares the old signature for the kfunc:

int bpf_cpumask_populate(struct cpumask *cpumask, void *src, size_t src__sz=
) __ksym __weak;

Because of this, the tests in cpumask_success.c and cpumask_failure.c under
tools/testing/selftests/bpf/progs/ continue to use explicit C-level casts
from struct bpf_cpumask * to struct cpumask *. For example, in
test_populate_success():

ret =3D bpf_cpumask_populate((struct cpumask *)mask, bits, CPUMASK_TEST_MAS=
KLEN);

While this doesn't cause runtime failures since the BPF verifier matches the
runtime register BTF type instead of C-level casts, updating the selftests
would ensure complete consistency with the new kfunc signature.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709182800.2037=
938-1-main.kalliope@gmail.com?part=3D1
