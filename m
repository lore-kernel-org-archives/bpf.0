Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch [185.70.43.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166603A7839
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 19:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785354621; cv=none; b=Qo/FrwbVov7uRo7terhWSv14ebvUwoRHXOb44RfMq8hMQfD2lSwloiZbpgPVjDTywo1ePm1Y4nUWcM/OYMTVH6PDSGUqPI5JjR8F7Jd3Bp2SUfULjrYgr6URop4Bm7wQVa/znaQg8qTgYM78L5Qe/Vs56aKZ3GEkg1vnWMWziOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785354621; c=relaxed/simple;
	bh=KAjGSxtdqsCQKntYTeu5Yz5zHb8olDIw2Bgs0JGDT/A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VXGbHHqeNXYzlJUO7j8mEDOA8zYQ+LYk4FWHfj8JAQ2pw+2Wzp1QZRqxYyxFf42xuqk2A8hzp5Wq89rDsPBQTIXvbx/PcNUgVCxqpBmHmERTt2db8rqylbeltZis7U+1Hty0ARQNS3cCzYjjI6e4nP2SkA0z8F+ZU3X2mBq26eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=CwwOLRBx; arc=none smtp.client-ip=185.70.43.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="CwwOLRBx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1785354608; x=1785613808;
	bh=bLoudCnxPDB6hyC21SXJhCYYKM/KoTaA3miIF91hpPA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CwwOLRBxVNYfV8udzIT/2hkW6B0PkTULB7U3tU9DOIUkPTHuQ58Pu7utmTm5AkNBh
	 J8eo3jIicgdfG5WSe3qnw4cqshSapRif9BPNHMpTdAxKtWbJsRG3bJdo2DDi9pPvUA
	 JanG7FO69lw3pDuR7d5PAjPq5MrAv0UZv5XnvKZFEYfCVqXtVejJiImF9TYddgo2cN
	 wfGmWwYevydpq8Ci03OKtCsIV0oYnl9QFDd+i2bbN9FcOa/cPY4+f6nemXr8hHV9rD
	 tmWZ1ugYNeKMc1Ey3Vtj1v0eq/zcIYlSHBmZVSuPdUlQPLtWY1cDr6mdZlClH1B/8/
	 VBb74g0WjlJvg==
Date: Wed, 29 Jul 2026 19:50:01 +0000
To: bpf@vger.kernel.org
From: Vinicius Sampaio <vldsampaio@pm.me>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, tangyazhou518@outlook.com, shenghaoyuan0928@163.com, vldsampaio@pm.me, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v2 1/3] bpf: Simplify cnum contains() implementation
Message-ID: <20260729194932.292368-2-vldsampaio@pm.me>
In-Reply-To: <20260729194932.292368-1-vldsampaio@pm.me>
References: <20260729194932.292368-1-vldsampaio@pm.me>
Feedback-ID: 138063245:user:proton
X-Pm-Message-ID: 7d4a2b6e02c9767efb9e1d563ed1c7e34afaa01e
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch introduces a optimization for the contains() function.

Bearing in mind that a non-empty cnum represents a inclusive circular
range in the corresponding unsigned integer domain, membership could be
tested by checking whether the distance from the range base to the
queried value is within the range size.

This makes the explicit wrapping and non-wrapping cases in contains()
unnecessary, since:

        v - cnum.base <=3D cnum.size

is equivalent for both ordinary ranges and ranges that cross the
unsigned wrap boundary.

We've also run some benchmarks to compare the performance of the new
implementation, for example, for empty ranges, overflowing ranges
non-overflowing ranges. We've run the tests with O2 optimization.

Results:

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
this operations are available at:

        https://github.com/OpenSourceVerif/open-verified-artifacts/tree/cnu=
m-refactor-verif/cnum/lean

Co-developed-by: Yazhou Tang <tangyazhou518@outlook.com>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Vinicius Sampaio <vldsampaio@pm.me>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 kernel/bpf/cnum_defs.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/bpf/cnum_defs.h b/kernel/bpf/cnum_defs.h
index a90e317e3578..ac1f62a0195d 100644
--- a/kernel/bpf/cnum_defs.h
+++ b/kernel/bpf/cnum_defs.h
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


