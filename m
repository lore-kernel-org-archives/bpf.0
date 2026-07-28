Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BAA2C0261
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 01:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785203837; cv=none; b=oNUvgJsoQIaXy2TPwnLyBO13R1MeRBCwgmeT+LWHqk8lreJTHzk7sRNV154ULq/nxgO4oeokscDYfUNFiF1iOw7DdpVty/C0FYlIrRPrnNh5t4X5sVtq1Qs2T/BF/jPjMLxKORaKf1MQ5O3vY0HXE743Q4foucN5mSJ4MM5pQW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785203837; c=relaxed/simple;
	bh=z0gR1WBBI7R6SQktoUVdTuCJ7eQv9Hgg3Qu9gNvrF4M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kg0jCYceAwIF7EomTqeIHFfXAljOfQ0cCbg7R8X0x6eaF0vvyAYQzq0WRSdoPjmLMr2M+xCZXWtaY59EeptKUPgBMNamW/BeKLbV7rlOxGnJPvg5mrY8WzGl71cCKQV5vQVaqtLQJ9/nwX93+fU0b5etPw8Q3EU+dVTa4m7JJEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=kT2ze9PW; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="kT2ze9PW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1785203826; x=1785463026;
	bh=zj7+Knwe4RgXRwjJPG6HrulszxIPsJAcWCrVywxDsQk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kT2ze9PWkz6fgkLtwU48rGCygkTr/6rn/onvnYTI+IWe0v3krrRgu0LNKgdeY+p6U
	 YzV56f0uWj8rzlIS04FJ/pnZou0iw6c0n4ddPtA7iMXatFG70uNuUcGPLDX4VWdEIZ
	 T7ys1FggfW/EwcEKgy8gYoHAur3kzrIJMZGafZyTlcH84mZDW2iIO0N7L5/rmQvTa4
	 HT0YNobmWXiQAs7PcrFeuvyUwGwmCtM5SDg1kXk3HyUENevF6VcLLJ6IsoFZp6Gv1t
	 cPUt8plwnWWYiivBotamQLzLnW4ZO4nKW8VUXN2QdqbZeuL4NUvVZ5l/stHYpZmG92
	 ubVfpw9jDfN+Q==
Date: Tue, 28 Jul 2026 01:56:58 +0000
To: bpf@vger.kernel.org
From: Vinicius Sampaio <vldsampaio@pm.me>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, tangyazhou518@outlook.com, shenghaoyuan0928@163.com, Vinicius Sampaio <vldsampaio@pm.me>
Subject: [PATCH bpf-next 1/2] bpf: Simplify cnum contains() and normalize() implementation
Message-ID: <20260728015601.1567098-2-vldsampaio@pm.me>
In-Reply-To: <20260728015601.1567098-1-vldsampaio@pm.me>
References: <20260728015601.1567098-1-vldsampaio@pm.me>
Feedback-ID: 138063245:user:proton
X-Pm-Message-ID: 5577c4a3fcd34d69de9c96e7f92cd61c74a283de
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch introduces two optimizations one for the normalize() function
and other for the contains() function.

In normalize(), there's no need to compare cnum.base with ST_MAX,
because any cnum with size =3D=3D UT_MAX represents the full unsigned domai=
n
independently of base, so normalize() can canonicalize all such values
to base 0.

In contains(), bearing in mind that a non-empty cnum represents a
inclusive circular range in the corresponding unsigned integer domain,
membership could be tested by checking whether the distance from the
range base to the queried value is within the range size.

This makes the explicit wrapping and non-wrapping cases in contains()
unnecessary, since:

        v - cnum.base <=3D cnum.size

is equivalent for both ordinary ranges and ranges that cross the
unsigned wrap boundary.

We've also run some benchmarks to compare the performance of the new
implementation, for example, for empty ranges, overflowing ranges
non-overflowing ranges. We've run the tests with O2 optimization.

normalize() results:

        | Test                    | normalize   | normalize_new |
        | ----------------------- | ----------- | ------------- |
        | normal small range      | 1.254 ns/op | 1.049 ns/op   |
        | full range normalized   | 1.055 ns/op | 1.046 ns/op   |
        | full range nonzero base | 1.053 ns/op | 1.055 ns/op   |
        | empty                   | 1.054 ns/op | 1.059 ns/op   |
        | signed max full range   | 1.051 ns/op | 1.049 ns/op   |
        | max base singleton      | 1.253 ns/op | 1.045 ns/op   |

contains() results:

        | Test                 | contains    | contains_new |
        | -------------------- | ----------- | ------------ |
        | empty                | 1.511 ns/op | 1.479 ns/op  |
        | non-overflow inside  | 1.156 ns/op | 1.270 ns/op  |
        | non-overflow outside | 1.053 ns/op | 1.258 ns/op  |
        | overflow high side   | 1.469 ns/op | 1.257 ns/op  |
        | overflow low side    | 1.469 ns/op | 1.270 ns/op  |
        | overflow outside     | 1.478 ns/op | 1.256 ns/op  |
        | singleton inside     | 1.049 ns/op | 1.256 ns/op  |
        | singleton outside    | 1.051 ns/op | 1.254 ns/op  |
        | full range           | 1.053 ns/op | 1.256 ns/op  |

You can check the full implementation of theses tests on this repository:

        https://github.com/OpenSourceVerif/open-verified-artifacts/tree/cnu=
m-refactor-verif/cnum/benches

Lean4 proofs showing that the new implementation preserves soundness of
these operations are available at:

        https://github.com/OpenSourceVerif/open-verified-artifacts/tree/cnu=
m-refactor-verif/cnum/lean

Co-developed-by: Yazhou Tang <tangyazhou518@outlook.com>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Vinicius Sampaio <vldsampaio@pm.me>
---
 kernel/bpf/cnum_defs.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/cnum_defs.h b/kernel/bpf/cnum_defs.h
index a90e317e3578..25649b740560 100644
--- a/kernel/bpf/cnum_defs.h
+++ b/kernel/bpf/cnum_defs.h
@@ -181,7 +181,7 @@ void FN(intersect_with_srange)(struct cnum_t *dst, st m=
in, st max)
=20
 static inline struct cnum_t FN(normalize)(struct cnum_t cnum)
 {
-=09if (cnum.size =3D=3D UT_MAX && cnum.base !=3D 0 && cnum.base !=3D (ut)S=
T_MAX)
+=09if (cnum.size =3D=3D UT_MAX && cnum.base !=3D 0)
 =09=09cnum.base =3D 0;
 =09return cnum;
 }
@@ -210,12 +210,7 @@ bool FN(is_empty)(struct cnum_t cnum)
=20
 bool FN(contains)(struct cnum_t cnum, ut v)
 {
-=09if (FN(is_empty)(cnum))
-=09=09return false;
-=09if (FN(urange_overflow)(cnum))
-=09=09return v >=3D cnum.base || v <=3D (ut)cnum.base + cnum.size;
-=09else
-=09=09return v >=3D cnum.base && v <=3D (ut)cnum.base + cnum.size;
+=09return !FN(is_empty)(cnum) && v - cnum.base <=3D cnum.size;
 }
=20
 bool FN(is_const)(struct cnum_t cnum)
--=20
2.54.0


