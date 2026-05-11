Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28FC3750D5
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 05:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778477601; cv=none; b=j1LHc46dez+GbQaKw9UGH049wXtA6qoNclRVDhDAZ52smxmEDmXZruUF8Q8IesI2ZLmC7qW5MUrQzELe5s81SbKQ+naf8X5lW4btZh4WUXBUXvq1mWkZeA+GN5Ek2796kXI5g3Xq/Jm3eh6ptwNxu+dulaKW6/pNncQDF9A5ex0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778477601; c=relaxed/simple;
	bh=sDeSH8x4Slu9DtobbGt362oG6Q1gDrBwYsTCMLDknB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCJIKJ4d8+6neyv9WrH8yJN+WrJeUzBZ3hiz2TcAX7iA/fhVJi5/Q4QWijtrJHnM4B6C3oLdLfrnr62SZxvskWLLBJ490TpOYT5kHpso8cnop5XKE0Tgc1hRjZpSrdsRrNyPX+s7862NI0I/LtnWSHLpZl2icuc3cGkioeiNSSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id EEFF6A59D5015; Sun, 10 May 2026 22:33:06 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 01/24] bpf: Convert bpf_get_spilled_reg macro to static inline function
Date: Sun, 10 May 2026 22:33:06 -0700
Message-ID: <20260511053306.1880263-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260511053301.1878610-1-yonghong.song@linux.dev>
References: <20260511053301.1878610-1-yonghong.song@linux.dev>
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

