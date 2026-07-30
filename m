Received: from mail-244116.protonmail.ch (mail-244116.protonmail.ch [109.224.244.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF183D34A4
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 10:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785406892; cv=none; b=e2R3361cRRAeJazp/dlRoM9OP/gHeo/oNUIEQNeknTtLdQnJQyPQS/1jYgG1FZwHK2olbHZzUE/P07WxXKI61+WAg+8xLZ+zyx7MFjC/qvB50SNC1jfXkuFkxBvNzoSsMljH+3iKl+JFYVjvpx4Bk/j49kpqN+ZyVDu01Gy6qFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785406892; c=relaxed/simple;
	bh=J/YAeT+OlcqylMzhoqBnQzUW04j4LNB3Ac1It5sE1hY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lk+6A3SsJRKatUms5u85w/hr3Wmx8+FuhkuEk2ey1a27b2PD9qvHRYFKGe4Wd5/tEA07WXbhQHOEWXxPHwYU1q5f27hgQyXGOJmWFL5Qyos7xeM3Zk7opW8Fnxtzf/CNUxk5pID3FHCKu3mtFpbJ7wJ5s6unCea5Ev8Zf/DiDiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=aXOms4PE; arc=none smtp.client-ip=109.224.244.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="aXOms4PE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1785406882; x=1785666082;
	bh=+PbEXD3oq0eOjsS9qch0nk9tfGiOkAxlyfiHc4fEQN8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aXOms4PEKRvGTzIEOLAdfJxMUggj53gD1yQfsymp2yfMTEiWKlkrGzAOv59ULX2g4
	 Kjc4FF6feaq0RQx15naFgCV9d0z9aK1tqSQYOcJ84GK5rGdqIYbXiWvpBYwaqoSd7C
	 9kvBmYUKn3ELxaHtVgRTJvnQIZyNlvW2PKQSibA8vCvupO8Y0859iLRLwYoGECSU1l
	 ZMh8fNEDg5VcOn9CcGeFmkCzBOrsiNqAAzkJH1ZQDim17i64WAVW5q1jiL7d64zXq7
	 1deTaab5VKSRnI1vIdNj9beRTd8yt+PADJRmSWklTwVRJUvDK4h05ZBjChJr8CdxrZ
	 rz4yE1YAycNNg==
Date: Thu, 30 Jul 2026 10:21:18 +0000
To: bpf@vger.kernel.org
From: Vinicius Sampaio <vldsampaio@pm.me>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, tangyazhou518@outlook.com, shenghaoyuan0928@163.com, vldsampaio@pm.me, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v4 1/3] bpf: Simplify cnum contains() by removing redundant branches
Message-ID: <20260730102129.15209-2-vldsampaio@pm.me>
In-Reply-To: <20260730102129.15209-1-vldsampaio@pm.me>
References: <20260730102129.15209-1-vldsampaio@pm.me>
Feedback-ID: 138063245:user:proton
X-Pm-Message-ID: 0a25d215f6fce63c498ec258505d7f77b45411b7
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

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


