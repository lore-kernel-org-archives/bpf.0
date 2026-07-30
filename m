Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF981C2AA
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 00:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785370304; cv=none; b=J836ePnqb7DvNzuWVeaELVUPu7y7ZxGqgkBKOtryKXB9ZOBsuifenoCsMxd7N0SZLSo3OwL6R+xnWoI19LBn65/0syfXeTtFOG8kMInIIvQI3udzxzReF9QToPXMYcqVQ6DfEFRTpVceqKeHPxECWMdUA+hvQVDlN+JO0s5P8tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785370304; c=relaxed/simple;
	bh=CePH7tnHoJKK/MZdPxUYM1i08Ox2Owqu6tGAyJocRTA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d6FqFxfyJlQs/u7t6B3l8gtQ/b4Z9hzS3w0I1QWruRLkCt6Pb8/oI/Z2tyx6l0Dw+MbqxWqQEVQzI+hEqlG3a1gtcc1OD/ixVcbQlWqcKYZggo58ovufzPzcReP8ju8DYkfIIKhBkq007nI9vsvZbDWLD3AWMSF6anFINjfXsTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=pUihG8y0; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="pUihG8y0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1785370298; x=1785629498;
	bh=SwuCVdhl4KYg17zvO8uSUep020QWvvm8DGRD4JbPzeI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=pUihG8y0Yo+RJzPuX7olBLsaUoBY7SGDRhV2MUi4EH+6mdq+wHkqA8671MWzmOkfs
	 Yn0WBvqr3Qbv1ouwFnBmEG6YfRV6bgKc2xVKu+NXlULX788w8hipdBGYSgToBffWBW
	 kJBYdO+2GhQQGRnZT5unFgg3PO3rdwxqOrfVK8u/gY8aJnehUhPYXNLeR8KKbL5h3b
	 dXnn3UFmJamYP+cceQ//bjDPyqw+3ZDS3uDHriZDviRBLbBlKGuF93nY1WKq6tvPaF
	 CZdZRP6EN6p4B3QyprSjub0wRLncQ+E44QcML25LcO6Pw8h4KM71JL8BESckO6TXsS
	 BTn16IW4EpVvg==
Date: Thu, 30 Jul 2026 00:11:34 +0000
To: bpf@vger.kernel.org
From: Vinicius Sampaio <vldsampaio@pm.me>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, tangyazhou518@outlook.com, shenghaoyuan0928@163.com, vldsampaio@pm.me, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v3 1/3] bpf: Simplify cnum contains() by removing redundant branches
Message-ID: <20260730001145.381820-2-vldsampaio@pm.me>
In-Reply-To: <20260730001145.381820-1-vldsampaio@pm.me>
References: <20260730001145.381820-1-vldsampaio@pm.me>
Feedback-ID: 138063245:user:proton
X-Pm-Message-ID: 897a86c6d3d6d1749b28e0b16195cfd1b032b281
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch simplifies the contains() implementation.

Bearing in mind that a non-empty cnum represents an inclusive circular
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

You can check the full implementation of these tests on this repository:

        https://github.com/OpenSourceVerif/open-verified-artifacts/tree/cnu=
m-refactor-verif/cnum/benches

Lean4 proofs showing that the new implementation preserves the soundness
of the operation are available at:

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


