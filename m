Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch [79.135.106.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7ED2E7F17
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 00:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785371098; cv=none; b=Soha/76vvndcyZVRFnFLnaGgAXzQDVZEk3oEPZi8dff67MtjxVd2WBXTUxlFhXw7Jo5QQzwZt2yOzCDnaR65mS5XkDJR71/oPw17OHRv9KxD1UA4YCnlU4aIYaT48EkK5KtUAotenz7b2T0kU6mWT2hguKKt34lpUk1TLk92PPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785371098; c=relaxed/simple;
	bh=GEvp8UMQRMCbi/nZ/7j0//2/tK5qJL7uTPLhNQfb84s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=njobLOHkYFvOpI/w2S+tHdTiSY8vyCxk0jNoyDsTjRM0IA0Cox5u02YvLyG9PciDMW2hJfZ4FnBJYo7/ijnk+jaoQGBFnJ6VYxjlzlr9C4Nxrdk7465OHflcyvUQZDuldsukmfd+tCNkfXRu2R6Q+mEJK9tXtLMndfLmJqW42hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=BXzSakx3; arc=none smtp.client-ip=79.135.106.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="BXzSakx3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1785371086; x=1785630286;
	bh=LwBISmnCGOSwzxvdGgXDJS6ULyaFnYynEsfuANgZDcI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=BXzSakx3yKZNjHpfOQ9da/6ti/2cgTeLE5Zi7n7ghKdx1G5wPChuDBZ7LyzgJbTAD
	 yeNTmRTzMAmybeAerWGBEcZWHmzgQPixoHEbOpz2kyUAajzyMGkWNn8EkUDUxWmVl7
	 CRpK6bA5wSTkpaYU2DTC6ajU9H9OLDCkDcgfgQ1pljQl/APkSR5qzM1JfEePQLU9qh
	 SVZWzSetCGMBf24Fr31/iML7uFvS9ShL3aHlCTlGlsEzPK8EoumQ0/w4awM0uSVf/4
	 /Qam2zaBUeceaiKTYfIWWBtn9nES7OGnOE2CgoNShRw+28ZdSOTszcuR9leYfkOyZL
	 zIsFqZOzM6AkQ==
Date: Thu, 30 Jul 2026 00:24:42 +0000
To: bpf@vger.kernel.org
From: Vinicius Sampaio <vldsampaio@pm.me>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, tangyazhou518@outlook.com, shenghaoyuan0928@163.com, vldsampaio@pm.me, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v3 3/3] bpf: Avoid redundant min()/max() in cnum signed bounds
Message-ID: <20260730002451.387556-2-vldsampaio@pm.me>
In-Reply-To: <20260730002451.387556-1-vldsampaio@pm.me>
References: <20260730001145.381820-1-vldsampaio@pm.me> <20260730002451.387556-1-vldsampaio@pm.me>
Feedback-ID: 138063245:user:proton
X-Pm-Message-ID: eb0c3dc3e6f502467e86028195170703137a2282
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch simplifies the smin() and smax() calculation by removing the
integer min and max calculation on the non-overflowing branch. This is a
valid simplification because when the arc does not cross the signed
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


