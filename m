Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch [79.135.106.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB363939BC
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 19:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785354659; cv=none; b=NYzI0HbMmYYQG0AlvLIpua8XfEbW06dcE5vnfx7iXM/yeGkyRHvO493D+2Le/doGZkGeJnKV3SEvD9cVfPwJfbpddqEIq5jNCLPkRQHF00Hyi4XbuRaoZUUNbYQ/sDV+lfqQ5sGe27GasDqy/O1IIUWxXoj6qRtGkGOHd3nB1gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785354659; c=relaxed/simple;
	bh=7qjE66lbftoF/FZ6iILEv4MT6qNGW0bF838J82hpeP4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M2C7gHx2pps7hGSDKrcgBfz127g6Ri1A93YOHYqPtwoSBj01S0eQWE3zMpyKmGqq2esbQCfaj+TZEk7AQupqtBQyp86RjCEjxWQPDUsq1KLiNtq4ps4SksknXNQ1wClnje5XINJFT5OvAi08EXjI5lO3OVJFHZpmBkwWpuc2ZIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=BOtA+4kU; arc=none smtp.client-ip=79.135.106.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="BOtA+4kU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1785354645; x=1785613845;
	bh=IgbX9ywBcbWKLAy952YwuOY9imXi27foZxzLooDK1Ws=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=BOtA+4kUcOIna4Aq9QPeW6KJMEwrEcwd359BiPsodRZyW1IrxzxEBhbzvb+Rra/c6
	 o+S3dNcRXwKgtIeZ4gghFZ9/JCG2ZJIcm5CwInnF5aroIm8hCPdvIyjJNVqfVmk8MA
	 XdxU6c6BxHGK45nfI+Er9jL/aHodIjpS1N4sjVlcsYebw98mZ3SCy5Zr3Z1JcZJhd/
	 AT5ynzUBBiUkSV7YcIeEuokCSf7t0ge9bwKhiPK++19zk6eZGPjCeRfxCVRboKbm8l
	 CTXDUBvz5ZoyeCsBL2HXFVeTI8spKUe0e4hjeCWB0HgPwLXtu6EmiCoz+oWR9xlXap
	 5lVJix5CJAnmg==
Date: Wed, 29 Jul 2026 19:50:43 +0000
To: bpf@vger.kernel.org
From: Vinicius Sampaio <vldsampaio@pm.me>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, tangyazhou518@outlook.com, shenghaoyuan0928@163.com, vldsampaio@pm.me, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v2 2/3] bpf: Simplify cnum normalize() implementation
Message-ID: <20260729194932.292368-3-vldsampaio@pm.me>
In-Reply-To: <20260729194932.292368-1-vldsampaio@pm.me>
References: <20260729194932.292368-1-vldsampaio@pm.me>
Feedback-ID: 138063245:user:proton
X-Pm-Message-ID: a7994b2fe8123ca61338eb29798ff3173e2c5d9b
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch introduces a optimization for the normalize() function.

In normalize(), there's no need to compare cnum.base with ST_MAX,
because any cnum with size =3D=3D UT_MAX represents the full unsigned domai=
n
independently of base, so normalize() can canonicalize all such values
to base 0. Also, it's a no-op assigning 0 to cnum.base if the cnum is
already unbounded, so we can remove the base !=3D 0 check too.

We've also run some benchmarks to compare the performance of the new
implementation, for example, for empty ranges, overflowing ranges
non-overflowing ranges. We've run the tests with O2 optimization.

Results:

        | Test                    | normalize   | normalize_new |
        | ----------------------- | ----------- | ------------- |
        | normal small range      | 1.254 ns/op | 1.049 ns/op   |
        | full range normalized   | 1.055 ns/op | 1.046 ns/op   |
        | full range nonzero base | 1.053 ns/op | 1.055 ns/op   |
        | empty                   | 1.054 ns/op | 1.059 ns/op   |
        | signed max full range   | 1.051 ns/op | 1.049 ns/op   |
        | max base singleton      | 1.253 ns/op | 1.045 ns/op   |

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


