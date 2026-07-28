Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch [79.135.106.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B772C326D
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 01:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785203856; cv=none; b=J7C7MVSJbhK33CFQT9PlTI1oV9xPQjqfVXA2LexSFQ3cL3lRGb1mD27eKHD/Nx6B8gyopjzf8QMR2U41hOqm0Kl7ZHhEJ9k7Z+4VtwGYbQN6xEvOBr4bnnRywIfl7ZFq7gAip66LkCaHxNWqpMxOirrYGkueDJSIFB8s97DULvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785203856; c=relaxed/simple;
	bh=pjfE4fFB8zY1UNzFshCmmM8VGeyKUkZuLaQqzLP76J8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SJlr9RXi9AXq3doXjUuIYEbYewED5JM/XA83MRrRLeIcw8hjw5szyBwzP/EPohakt9ZCvHYP9yenrsFIizSii0lg2637gDLlDGzks8tR6FyclGtoOQS5GixTF/2tp3mxSyebW0QcVkPGKKK5Q3iOX8lXmF7HDgj5EbDnvXVUD4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=aQnfKB9q; arc=none smtp.client-ip=79.135.106.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="aQnfKB9q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1785203845; x=1785463045;
	bh=MppZ/zeUsnC9urMES/fF74aIDWoKeV8qgfD+Popml1k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aQnfKB9qXoQjNzxCe3FMP9P1fn4JQNrf8CGoAYeahD8WkYSOCOVGQzbIqsZAIJCzS
	 scy0dI51MWxdUzF3feziJ8Z4BNaQI4BYRweWQ1dI/lLdqKcyTVdz+TdAs3MOsnZ3Ck
	 K9f1LqtAJax0cMi5Hd9aI4LtHECK0zdjZNfvP5Wy2eqRsFL4DjafMLC9LydYfKCQGx
	 4fcc7oVJRC9dc4Ld5FyS+Gve+YxFUcxNWQO2wx51DEAAyxh0+P+6uQMh543uKpJ8re
	 C+qH30xsNJo1bLa0F9ujcpvgs/WGzPmWk+jBVWDCdWldnWY4QzRhBD+ojEl3dWyKZy
	 h2AcAu3qsjUaw==
Date: Tue, 28 Jul 2026 01:57:18 +0000
To: bpf@vger.kernel.org
From: Vinicius Sampaio <vldsampaio@pm.me>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, tangyazhou518@outlook.com, shenghaoyuan0928@163.com, Vinicius Sampaio <vldsampaio@pm.me>
Subject: [PATCH bpf-next 2/2] bpf: Avoid redundant min()/max() in cnum signed bounds
Message-ID: <20260728015601.1567098-3-vldsampaio@pm.me>
In-Reply-To: <20260728015601.1567098-1-vldsampaio@pm.me>
References: <20260728015601.1567098-1-vldsampaio@pm.me>
Feedback-ID: 138063245:user:proton
X-Pm-Message-ID: 48cee5899673dd36612e1a0fbd1bb9b4af902eab
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
---
 kernel/bpf/cnum_defs.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/cnum_defs.h b/kernel/bpf/cnum_defs.h
index 25649b740560..456366408353 100644
--- a/kernel/bpf/cnum_defs.h
+++ b/kernel/bpf/cnum_defs.h
@@ -44,6 +44,9 @@ static inline bool FN(urange_overflow)(struct cnum_t cnum=
)
  * cnum{T}_umin / cnum{T}_umax query an unsigned range represented by this=
 cnum.
  * If cnum represents a range crossing the UT_MAX/0 boundary, the unbound =
range
  * [0..UT_MAX] is returned.
+ *
+ * The empty cnum doesn't produce any meaningful value, so you should avoi=
d
+ * calling cnum{T}_umin / cnum{T}_umax with it.
  */
 ut FN(umin)(struct cnum_t cnum)
 {
@@ -67,19 +70,18 @@ static inline bool FN(srange_overflow)(struct cnum_t cn=
um)
  * cnum{T}_smin / cnum{T}_smax query a signed range represented by this cn=
um.
  * If cnum represents a range crossing the ST_MAX/ST_MIN boundary, the unb=
ound range
  * [ST_MIN..ST_MAX] is returned.
+ *
+ * The empty cnum doesn't produce any meaningful value, so you should avoi=
d
+ * calling cnum{T}_smin / cnum{T}_smax with it.
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


