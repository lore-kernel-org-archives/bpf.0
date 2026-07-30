Received: from mail-244123.protonmail.ch (mail-244123.protonmail.ch [109.224.244.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8D93D79EF
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785406902; cv=none; b=DGrvq3vNQH64jZ1XXllWHsnzm1OZsmCI6EkRkOeo3oKB8F51Cmqa8qLq4ERbfSSwbLGmj4iGq7Cf8KpHNHkqeMWzcb11b+oNl77WFHIzCPxdm29sInNrgebUwhN3q16/Q66WZWPxWH23FA7zf8DJpR2kjI4Z5E/xHdFByjZGupM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785406902; c=relaxed/simple;
	bh=i2tBtdqqM1LvLeDL1YtY3bqlWhGBzmkA09K9j4aaIDM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qawBB+OhyX+bnW1+/9jETEnhA/uwrp5yfRwhlUzu0L4XhfImHxwYVxlGtPVny7QjQ2ADjDTbpVUnA9PXQHtSTwgWXZiywkabhcjmqDCc7mQIYK/29r7jxMNQz7sGIXpy3QckSQ7fi3HeYtLukEiH2RtuxkLIE1eHr7U6voPadNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=nxN5vtMK; arc=none smtp.client-ip=109.224.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="nxN5vtMK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1785406897; x=1785666097;
	bh=Q4epURTv0CUfjWFITrmLkLW3xyXr1G8B9K63p8age4k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=nxN5vtMKRmxVN6nDhiRU9hAdD+wAbTYlKQWtMRfOIU1XsHga3PUY9599cxUWBVy6C
	 t1VnkrgyUnPgnHpp8yGkvhchcCRhxw241FGOQ7mKh5+stLnmRJss3oQGrEm+h4NsRD
	 n5c5QOwIwfu+rfOUC1A5IkgiHwsKf2ylGQWa2nnQnNO2Oq9CNBV73YCas+qiFLJqqJ
	 zyl6xRzz9ho6eUgjc/Vu/8RynqNbz388nUMCg95/6y1243OYuEnajeIsOt8ehRAd3v
	 RX+gMQx+M9xOc4mYq7X3P4MCvaeaqSeFVQ5v6tEp9PCZk06L9uznXiWhHpEMHrwcS4
	 oBMGwVApuN0HQ==
Date: Thu, 30 Jul 2026 10:21:32 +0000
To: bpf@vger.kernel.org
From: Vinicius Sampaio <vldsampaio@pm.me>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, tangyazhou518@outlook.com, shenghaoyuan0928@163.com, vldsampaio@pm.me, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v4 3/3] bpf: Avoid redundant min()/max() in cnum signed bounds
Message-ID: <20260730102129.15209-4-vldsampaio@pm.me>
In-Reply-To: <20260730102129.15209-1-vldsampaio@pm.me>
References: <20260730102129.15209-1-vldsampaio@pm.me>
Feedback-ID: 138063245:user:proton
X-Pm-Message-ID: a9ddc7cdf514afb71fe0c64c0ee2819fffcfad5e
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Simplify the smin() and smax() calculation by removing the integer min
and max calculation on the non-overflowing branch. This is a valid
simplification because when the arc does not cross the signed
ST_MAX/ST_MIN boundary, the signed order of the endpoints is preserved,
so base is the signed minimum and base + size is the signed maximum.
Therefore, the min()/max() calls are redundant.

We've also run benchmarks to compare the performance of this change.
With O2 optimization we have:

smin() results:

        | Test                     | smin        | smin_new    |
        | ------------------------ | ----------- | ----------- |
        | empty                    | 1.866 ns/op | 1.477 ns/op |
        | positive range           | 1.870 ns/op | 1.248 ns/op |
        | negative range           | 1.657 ns/op | 1.246 ns/op |
        | cross zero               | 1.870 ns/op | 1.660 ns/op |
        | signed overflow boundary | 1.463 ns/op | 1.049 ns/op |
        | signed overflow range    | 1.519 ns/op | 1.050 ns/op |
        | unsigned overflow range  | 1.883 ns/op | 1.669 ns/op |
        | full range               | 1.555 ns/op | 1.049 ns/op |

smax() results:

        | Test                     | smax        | smax_new    |
        | ------------------------ | ----------- | ----------- |
        | empty                    | 1.462 ns/op | 1.456 ns/op |
        | positive range           | 1.250 ns/op | 1.249 ns/op |
        | negative range           | 1.259 ns/op | 1.297 ns/op |
        | cross zero               | 1.471 ns/op | 1.475 ns/op |
        | signed overflow boundary | 1.056 ns/op | 1.260 ns/op |
        | signed overflow range    | 1.049 ns/op | 1.259 ns/op |
        | unsigned overflow range  | 1.470 ns/op | 1.477 ns/op |
        | full range               | 1.072 ns/op | 1.263 ns/op |

You can check the full implementation of these tests on this repository:

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
 kernel/bpf/cnum_defs.h | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/cnum_defs.h b/kernel/bpf/cnum_defs.h
index 09535edbbafc..30685e43de04 100644
--- a/kernel/bpf/cnum_defs.h
+++ b/kernel/bpf/cnum_defs.h
@@ -33,7 +33,12 @@ struct cnum_t FN(from_srange)(st min, st max)
 =09return (struct cnum_t){ .base =3D base, .size =3D size };
 }
=20
-/* True if this cnum represents two unsigned ranges. */
+/*
+ * True if this cnum represents two unsigned ranges.
+ *
+ * The caller should ensure !is_empty(cnum) holds when calling
+ * this function.
+ */
 static inline bool FN(urange_overflow)(struct cnum_t cnum)
 {
 =09/* Same as cnum.base + cnum.size > UT_MAX but avoids overflow */
@@ -44,6 +49,9 @@ static inline bool FN(urange_overflow)(struct cnum_t cnum=
)
  * cnum{T}_umin / cnum{T}_umax query an unsigned range represented by this=
 cnum.
  * If cnum represents a range crossing the UT_MAX/0 boundary, the unbound =
range
  * [0..UT_MAX] is returned.
+ *
+ * The caller should ensure !is_empty(cnum) holds when calling
+ * cnum{T}_umin / cnum{T}_umax.
  */
 ut FN(umin)(struct cnum_t cnum)
 {
@@ -57,7 +65,12 @@ ut FN(umax)(struct cnum_t cnum)
 }
 EXPORT_SYMBOL_GPL(FN(umax));
=20
-/* True if this cnum represents two signed ranges. */
+/*
+ * True if this cnum represents two signed ranges.
+ *
+ * The caller should ensure !is_empty(cnum) holds when calling
+ * this function.
+ */
 static inline bool FN(srange_overflow)(struct cnum_t cnum)
 {
 =09return FN(contains)(cnum, (ut)ST_MAX) && FN(contains)(cnum, (ut)ST_MIN)=
;
@@ -67,19 +80,18 @@ static inline bool FN(srange_overflow)(struct cnum_t cn=
um)
  * cnum{T}_smin / cnum{T}_smax query a signed range represented by this cn=
um.
  * If cnum represents a range crossing the ST_MAX/ST_MIN boundary, the unb=
ound range
  * [ST_MIN..ST_MAX] is returned.
+ *
+ * The caller should ensure !is_empty(cnum) holds when calling
+ * cnum{T}_smin / cnum{T}_smax.
  */
 st FN(smin)(struct cnum_t cnum)
 {
-=09return FN(srange_overflow)(cnum)
-=09       ? ST_MIN
-=09       : min((st)cnum.base, (st)(cnum.base + cnum.size));
+=09return FN(srange_overflow)(cnum) ? ST_MIN : (st)cnum.base;
 }
=20
 st FN(smax)(struct cnum_t cnum)
 {
-=09return FN(srange_overflow)(cnum)
-=09       ? ST_MAX
-=09       : max((st)cnum.base, (st)(cnum.base + cnum.size));
+=09return FN(srange_overflow)(cnum) ? ST_MAX : (st)(cnum.base + cnum.size)=
;
 }
=20
 /*
--=20
2.54.0


