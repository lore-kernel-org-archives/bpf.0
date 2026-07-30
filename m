Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9163E5581
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 10:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785406894; cv=none; b=chuj6710pWmMuDQBrCGxl7V+ljWV8GCG4PFZYX4dIV+tUa8FcP1p0zETWLYk7JBq5wUmTMg56/X7EOf/n1oKkfI/Mn77bEqyRTj1tsqTDfHdregFXJVs7VPGDmm0C3IAOnSpi52MM1rpO5KK45bTOYEoy2DWaMDQVHOE6F29Xe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785406894; c=relaxed/simple;
	bh=BZz8whr/kCtyCFZa5IgQ0NQUO8vj8lKjWr0gH4tLBXQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N9KWVx+Dy0D0pluQIKMmynN0GD01QtdsINMcStKxxRJPWwIhU/bne7hv2oxxjEFHRVrAP1lxnSUMvgy6lUmo8ziHLtabMH5q2l5tVWQulcHmMqHxw8qis7Evao2o/Icwsf111CxYylwlp4FY3mgh3Upvh5lPZijpn2YOkq0jxSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=KfX1qsck; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="KfX1qsck"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1785406890; x=1785666090;
	bh=vhhjsF7pSmzcuHhZSYSEQ4M7x7zD4YLCPKPeK7swoqU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KfX1qsckoRC82Lbn3fCFo9RVQUAaqbPzwQWwWOLyR/pe1SE9c9odtrlz/YAG8CmDt
	 VKGtnrgQ1LofWYa0e0F2mPodcLVTVNgfbcYw0m0hJLuPBmfLuiwpoRTmPh68MEuJCU
	 oeJu6oqa8F0AkoWjkAyjhO74XdYzqjKnfbGpd374RIIwSP3F67hRoVph5GcohvAaVP
	 EQTCYGDwy9HhwA/MZoqqCUzq60+KAdvxeEy2ril+iZOD4Etr1sHTshzMqTFVp7ce8K
	 msnQngboMhVU3+O8l1Sal+pP0as8JqwBuVsB/MfFRXhqV1e4j54G3mN+khJSZT2LX5
	 JGQXjZucjpayA==
Date: Thu, 30 Jul 2026 10:21:24 +0000
To: bpf@vger.kernel.org
From: Vinicius Sampaio <vldsampaio@pm.me>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, tangyazhou518@outlook.com, shenghaoyuan0928@163.com, vldsampaio@pm.me, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v4 2/3] bpf: Simplify cnum normalize() by dropping unnecessary comparisons
Message-ID: <20260730102129.15209-3-vldsampaio@pm.me>
In-Reply-To: <20260730102129.15209-1-vldsampaio@pm.me>
References: <20260730102129.15209-1-vldsampaio@pm.me>
Feedback-ID: 138063245:user:proton
X-Pm-Message-ID: ce656a8d7a9038ee046f9ac2e13733441ac9cd49
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

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


