Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B90B3ACF16
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 20:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785357420; cv=none; b=eDnU1SI3RmCKBfiLC2LA0/BVIyu0oWbv8wYrr4kQKr4cfW0P6qa+n0751pQ9UHOhQR79cir64ASY+vJnHXEzm1k0i8sQbWDd3A9QyKKIFCL2cPXySn/6fe4gOpydcm10Uc1KU1sutgInMGBAhf/r7O7SdAnDL9B9rz0vZwOtP+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785357420; c=relaxed/simple;
	bh=2BXgBXE5/oRavDXPyBGo81olJoeY3QN+YF0kohFyPdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1+NBTDkn0sJfA/kNcRs+72DbbYxnHQj9Nu5levBOhjJscmtqVd/f5hKu6zI9+Yswld5tvQ3d1+Sh5cG8UtX8tAZWUl8ek26DMSbCS65OCedpOsxr4k0emtQEL2gh+BO/kvVSoSgjgElJ+1r815Qd00qb0tmb7EX4lYK/N9lNd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olCI62kp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olCI62kp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596DD1F000E9;
	Wed, 29 Jul 2026 20:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785357412;
	bh=pI5gaVJmkFdxmdeBqWn4dU1OZqGk1SRtLyyDJhfvakk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=olCI62kpBKN7xGpruHyrVX8yiggcj6nuM6cVtvf3t8DQ35wKvTCfEuxDUk+HmpvQk
	 8o6zze+8+Ohqt77jnXMbVITpPweqQtMYc8//t749y8YiqJkVoeoFfc3TxRnAWOAJ41
	 8qD5/E7pIoek7h3d4ErI2iRoRgPB7wU48HA0YHJT8hW72QTZz7j98QceypNlU/q+34
	 dW9zrY/b/GSMGL9d93dP055cGTeqc4BAuP36iu1PqIKSQs/Tk+ZBDRx4d54QkVtYah
	 LfDeQSH0+uvP7oQXzF7V8H9QkMgmaEhzavPzTox9jxnYnVmaIkCQsfLeaWhtgyMzOe
	 bIfNBA2rebssw==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v4 1/6] bpf: Correct the overflow check comment in bpf_iter_num_next()
Date: Wed, 29 Jul 2026 13:36:21 -0700
Message-ID: <20260729203633.213973-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729203633.213973-1-puranjay@kernel.org>
References: <20260729203633.213973-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_iter_num_next() decides whether the iterator is exhausted with:

	if ((s64)(s->cur + 1) >= s->end) {

The comment above it claimed the (s64) cast was needed to be careful
about overflow, "e.g., if s->cur == s->end == INT_MAX, we can't just do
s->cur + 1 >= s->end". That reasoning is wrong: s->cur + 1 is evaluated
in int and wraps *before* the cast, so casting the already-wrapped result
to s64 changes nothing. For s->cur == s->end == INT_MAX the plain
s->cur + 1 >= s->end and the (s64) version both evaluate to false, and
more generally the two are identical for all inputs (sign-extending both
operands of a signed compare never changes its result).

The wraparound of s->cur + 1 is in fact intentional and load-bearing:
bpf_iter_num_new() initializes s->cur to start - 1, which wraps to
INT_MAX when start == INT_MIN, and the wrapping s->cur + 1 recovers
start on the first call. Using real 64-bit arithmetic ((s64)s->cur + 1)
would instead break iterators starting at INT_MIN.

Drop the redundant cast and rewrite the comment to describe what actually
happens. No functional change; the kernel builds with -fno-strict-overflow
so the signed wraparound is well defined.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/bpf_iter.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index f5eaeb2493d4a..f190f2b250048 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -802,12 +802,14 @@ __bpf_kfunc int *bpf_iter_num_next(struct bpf_iter_num* it)
 {
 	struct bpf_iter_num_kern *s = (void *)it;
 
-	/* check failed initialization or if we are done (same behavior);
-	 * need to be careful about overflow, so convert to s64 for checks,
-	 * e.g., if s->cur == s->end == INT_MAX, we can't just do
-	 * s->cur + 1 >= s->end
+	/* Detect the end of the range, or a failed/empty iterator: all of these
+	 * leave s->cur + 1 >= s->end. bpf_iter_num_new() set s->cur to start - 1
+	 * (which wraps to INT_MAX when start == INT_MIN), so the s->cur + 1 below
+	 * is a deliberate 32-bit wraparound that recovers start. As s->cur and
+	 * s->end are int, this is an ordinary signed 32-bit compare, exactly what
+	 * the inlined bpf_iter_num_next() emits.
 	 */
-	if ((s64)(s->cur + 1) >= s->end) {
+	if (s->cur + 1 >= s->end) {
 		s->cur = s->end = 0;
 		return NULL;
 	}
-- 
2.53.0-Meta

