Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22ED136358
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 04:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778647809; cv=none; b=uxI2kAoXnIK3RVkrAbuV/w1rex0IYHb3kTUHhXBch1kVhlln0RcbAEK0IwinmVWFz8kp4DD6v4GRBycN6xKEGQ7RluBu3rJKFZQYjMo3uMGqzfv+WvPfOTog8/o63b3iUUG3Gl8PyJ92r0fqYVz8c6mCES8zVLRsTJkDyoxjPn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778647809; c=relaxed/simple;
	bh=sDeSH8x4Slu9DtobbGt362oG6Q1gDrBwYsTCMLDknB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVAvtP0UsRTI0UT8CDz36sZPyIebDdOF8VacvfAZUttoSruI6/IK9zeDIpTyv62jTz31zZ3Ss0tYUWEvbh4pGhIhAPP9YzdEgHR4uFygRyT0oXEKAIDyu+FkIznX1kSNbAZtP1vxdbwHS7nVMK9pBAZb/aeM4uSQspdUUyQXSQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id E3C9FB194683A; Tue, 12 May 2026 21:49:54 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 01/25] bpf: Convert bpf_get_spilled_reg macro to static inline function
Date: Tue, 12 May 2026 21:49:54 -0700
Message-ID: <20260513044954.2382693-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260513044949.2382019-1-yonghong.song@linux.dev>
References: <20260513044949.2382019-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Convert the bpf_get_spilled_reg() macro to a static inline function
for better type safety and readability. This also simplifies the macro
definition in preparation for upcoming stack argument support which
will introduce additional macros.

No functional change.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 976e2b2f40e8..321b9d69cf9c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -552,10 +552,14 @@ struct bpf_verifier_state {
 	u32 may_goto_depth;
 };
=20
-#define bpf_get_spilled_reg(slot, frame, mask)				\
-	(((slot < frame->allocated_stack / BPF_REG_SIZE) &&		\
-	  ((1 << frame->stack[slot].slot_type[BPF_REG_SIZE - 1]) & (mask))) \
-	 ? &frame->stack[slot].spilled_ptr : NULL)
+static inline struct bpf_reg_state *
+bpf_get_spilled_reg(int slot, struct bpf_func_state *frame, u32 mask)
+{
+	if (slot < frame->allocated_stack / BPF_REG_SIZE &&
+	    (1 << frame->stack[slot].slot_type[BPF_REG_SIZE - 1]) & mask)
+		return &frame->stack[slot].spilled_ptr;
+	return NULL;
+}
=20
 /* Iterate over 'frame', setting 'reg' to either NULL or a spilled regis=
ter. */
 #define bpf_for_each_spilled_reg(iter, frame, reg, mask)			\
--=20
2.53.0-Meta

