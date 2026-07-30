Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A672DB780
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 00:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785371089; cv=none; b=CWev2DxjjWCQ6Rvjpz19jlncXeFIwbNqFM6oSrJwo3wn00RVwvZvYGg2aQbcUR0ytxeMDASjFI/3ABzsafEOAW5mJkaX1LfWB8zv8HvLUqT/CX76NCcjmpdod40Uqe/++LqU01f1SSY6GeHBczXqf2S/y2U0sxdzyXV769CXrLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785371089; c=relaxed/simple;
	bh=fZTDJgHjgFA8hJXePHd0IOdr4Def4YEWowickRhCAiU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bwloCRLa2jRFkHPwKXa+9ym7vwKDrGpyORDbq2b6NJqL3ysbb3i0dePJO+4gLRtFlJ67rRu0GdQY5rlgMGrvgVVCESoUgAh90FJQo+w/POUB0i2dbtEFLUVAkiHeiN11ZLQYbJta5V3hDS0f00hMCFKNheB30Wto2Mx4NNvOlVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=DfA229Rr; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="DfA229Rr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1785371082; x=1785630282;
	bh=xbBvurX/eNA6TwVsol5jsrihqKcz/zsSGpBEzoPC094=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DfA229RrY333Ac2Q4Q3kn/vMlj8XjUlcFc8fBmDd+aKtFVezPJ744KOUrjjvsR4+G
	 KcQXeAr/uGTjveYWWwFevmzkxP3pRZ2VrlhhYAMG2ya0cYO6+8nTLJeLBhkbG2LNEk
	 9MtLNLc2sNUNZTdmj9ACeNcb6kKCnRHQyUDhutITxLFBOdVErue14nVOwZPF4gusTW
	 JBkDeZzPQqHuSwm8ge86Si/c2pRIeuJEXxh8bniHL+Ox0oDjQDMNbxUwKZAVVeodn5
	 B0cegRG04W6Y81Y1HnpGk+IzEg+tqp6vHMFMedOjvjSb/xD5V8Gg2x6vI/i+Ctz2l5
	 x/Tv6Jg9AMVKQ==
Date: Thu, 30 Jul 2026 00:24:33 +0000
To: bpf@vger.kernel.org
From: Vinicius Sampaio <vldsampaio@pm.me>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, tangyazhou518@outlook.com, shenghaoyuan0928@163.com, vldsampaio@pm.me, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v3 2/3] bpf: Simplify cnum normalize() by dropping unnecessary comparisons
Message-ID: <20260730002451.387556-1-vldsampaio@pm.me>
In-Reply-To: <20260730001145.381820-1-vldsampaio@pm.me>
References: <20260730001145.381820-1-vldsampaio@pm.me>
Feedback-ID: 138063245:user:proton
X-Pm-Message-ID: f8f90d69bec885d42d53c7a3090a7f49d6e276cd
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch simplifies the normalize() implementation.

In normalize(), there's no need to compare cnum.base with ST_MAX,
because any cnum with size =3D=3D UT_MAX represents the full unsigned domai=
n
independently of base, so normalize() can canonicalize all such values
to base 0. Also, it's a no-op assigning 0 to cnum.base if the cnum is
already unbounded, so we can remove the base !=3D 0 check too.

We've also run some benchmarks to compare the performance of the new
implementation. We've run the tests with O2 optimization.

Results:

        | Test                    | normalize   | normalize_new |
        | ----------------------- | ----------- | ------------- |
        | normal small range      | 1.255 ns/op | 1.217 ns/op   |
        | full range normalized   | 1.019 ns/op | 1.217 ns/op   |
        | full range nonzero base | 1.031 ns/op | 1.221 ns/op   |
        | empty                   | 1.023 ns/op | 1.217 ns/op   |
        | signed max full range   | 1.020 ns/op | 1.218 ns/op   |
        | max base singleton      | 1.218 ns/op | 1.219 ns/op   |

You can check the full implementation of these tests on this repository:

        https://github.com/OpenSourceVerif/open-verified-artifacts/tree/cnu=
m-refactor-verif/cnum/benches

Lean4 proofs showing that the new implementation preserves soundness of
the operation are available at:

        https://github.com/OpenSourceVerif/open-verified-artifacts/tree/cnu=
m-refactor-verif/cnum/lean

Co-developed-by: Yazhou Tang <tangyazhou518@outlook.com>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Vinicius Sampaio <vldsampaio@pm.me>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 kernel/bpf/cnum_defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/cnum_defs.h b/kernel/bpf/cnum_defs.h
index ac1f62a0195d..09535edbbafc 100644
--- a/kernel/bpf/cnum_defs.h
+++ b/kernel/bpf/cnum_defs.h
@@ -181,7 +181,7 @@ void FN(intersect_with_srange)(struct cnum_t *dst, st m=
in, st max)
=20
 static inline struct cnum_t FN(normalize)(struct cnum_t cnum)
 {
-=09if (cnum.size =3D=3D UT_MAX && cnum.base !=3D 0 && cnum.base !=3D (ut)S=
T_MAX)
+=09if (cnum.size =3D=3D UT_MAX)
 =09=09cnum.base =3D 0;
 =09return cnum;
 }
--=20
2.54.0


