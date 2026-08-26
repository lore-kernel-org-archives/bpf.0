Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D5839060C
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787768349; cv=none; b=NEihaaUHFTcpY4CEfN2s1UO3AWWm1LU2mZnUnQCGrCBjWCuFWegNJ/mA13dlF0qH0mxoGIttzxRD0uL4otqHv92a2k8fXiiYSaDSPHX2cDfI6s6foJM3eScqsRiAEuAXIAe1OXROLT919hPLBqVXcHHAo5wdUZJzBBLduz+0fqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787768349; c=relaxed/simple;
	bh=O5BaCsGrFG2dfWZW0RyoyuM1zkopaWbAk3pbAGgS4bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m28NRQXT0v9jnXLhf7zs2WWg4SS7Q5f3o5gAjRV/AwzR9ZSBvfIcbTbZo0IrFejMOmWd114gGaqFJWBN6/bpZEmCYZQFq1ZalaEOC+QCcL+WrTQ0UhcpRoQxo3vh2991r4KTMmQrgCFJR0mthMfnKgpYSGH+whkzxN183Xlbtb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACulTohx; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACulTohx"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-39686abd426so935610a91.1
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 11:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787768335; x=1788373135; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o0tFLu5UrdQ5aJbv6zv2wYvHWm/AT6aUc9ZQ1d+7PDU=;
        b=ACulTohxjEg/jQOhDJyMmcwhkM/7MZPfBcxVmjLf7pOh/ZepZU/TlS9pH/L24ffvFP
         TNxrLlLR33KOYy3GEwOrFxKIdLe0+/oO02R1z28mrH1qJB358yt0kCSlpDVuLXhq/b7A
         eN/vBeIbfMrsDA31x3ADz8iuJ04Ph086jPfnnQnWzpT5AS4T2R7dP8s59kKICzLbpJaS
         vXROWnGssaYP64mxeBkpgDvE93gL7UxkHbB6k01jqc5YwB6P0sfGLYM0JEs+1fdfcf6R
         12Zw98VGHnZCpHEh0oR8N+UtNQzk/BxTTptzDtL62/h36jauqR0fUKjrbGF1xAT2PRC6
         sVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787768335; x=1788373135;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o0tFLu5UrdQ5aJbv6zv2wYvHWm/AT6aUc9ZQ1d+7PDU=;
        b=SAqXKeeTbapgl3+8S+d8LMDkH9kWtGb4Lc1+LPkfUYHyVkQlyMJ+h+X2B6IOiJW9ui
         TMvt7w8LqZeeXoW0yj6Bm7csrrkfPU/IGc75PxwC09z9K+QJhmAu4IfkjP/T4R0ehT7/
         Mis8uoS7oCZqtps2ZNbTZjdd5WVgDyNQ1LmMaPI/9fTw75kuueXs+nFoLbrqnlGL3zi/
         c6sxZSb+4Jh2nEO1ti9NE4Udupkj4V9lBmDg0FiPACnAn2R8q8BwUnfpp/eV2hcJAtXD
         zYUdloWoX19RNrsqmyD+rcNJdrEAs5pGW0DtXdi4M5Pmh707X5Na+pAUevTUHKtznjgY
         JkWQ==
X-Gm-Message-State: AFuF++kZlCP51loK+HyvTSA7756v8OoB3jxSYeNxZN7iNFhZm/CBtiy6
	vZVCo4rH3nxV50kvnlaKsbLbi2WjB5Ys4/vP2BgWDeYkt3RgYw88u+2RocPZsEq1
X-Gm-Gg: AR+sD11THkO3gjUmFw/Uii8Jm2U28FBFuikbKvBfy9DYdSQC7upV2Gw/pU5rPgeQbQn
	xrm1Yw76+Cf+2znI2pNf46gnL1qH3UOJpRu1rvAE/d8rdsdEnhCJHOG4qpy3/o68MLD12/94v5n
	xCHEzZ6rwCd/GC0S55u1AzxIuoI4reZeZsQkNC7/Rw1hdV0jn8cvSIFuEG+sBpUOqjFj/kCAzCi
	xwATd0jrl9z6vhYazCYsuno1cxraxw2acuJPZtkal+cZMaX+xvoB75vxg7nWIyd5sxB3XvqIu7n
	3BuLK9dyskEKYNl3Dt6k4cVnUfPCqTbXl78vBJPCx6gdlehf1xR8C9TFr7geMelqDY2A00HrP36
	btGmUX7zsAzGyGgGR1xaX4gtXoaa9u2ISEQe/g1YjDEwfOCivp5285y/XCjQ6aZO4CteWS3XcTo
	4+IkMbzwqeN8He0MJeiA7aJpolgpmj4NXsElcIESOpqpjUmDbgfgjLEZunIsIg0PShbHVhmfNmz
	c0WnDPXPZNmc/9T
X-Received: by 2002:a17:90b:2b4c:b0:38e:97f0:aa4b with SMTP id 98e67ed59e1d1-3966d4592fdmr19973298a91.13.1787768335236;
        Wed, 26 Aug 2026 11:18:55 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3966875e5c3sm5182901a91.7.2026.08.26.11.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 11:18:54 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	npc@anthropic.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: a demo for check_cond_jmp_op() non-null inference bug
Date: Wed, 26 Aug 2026 11:18:45 -0700
Message-ID: <20260826-bug-029-bad-non-null-inference-v2-2-136789ace9e9@localhost>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826-bug-029-bad-non-null-inference-v2-1-136789ace9e9@localhost>
References: <20260826-bug-029-bad-non-null-inference-v2-1-136789ace9e9@localhost>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

A comparison between PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED and
PTR_TO_MAP_VALUE_OR_NULL should not infer that map pointer is not null.
A bug in check_cond_jmp_op() made such inference possible.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

---
  v1->v2:
  - selftest updated to use regular BPF_MAP_TYPE_HASH map
    (bot+bpf-ci).
---
 .../bpf/progs/verifier_jeq_infer_not_null.c        | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c b/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
index 3d1e8de4390c..b412a542ef76 100644
--- a/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
+++ b/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
@@ -3,7 +3,9 @@
 
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include <stdbool.h>
 #include "bpf_misc.h"
+#include "bpf_kfuncs.h"
 
 struct {
 	__uint(type, BPF_MAP_TYPE_XSKMAP);
@@ -12,6 +14,13 @@ struct {
 	__type(value, int);
 } map_xskmap SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} map_hash SEC(".maps");
+
 /* This is equivalent to the following program:
  *
  *   r6 = skb->sk;
@@ -264,4 +273,47 @@ __naked void jne_reg_reg_null_check(void)
         : __clobber_all);
 }
 
+/*
+ * A comparison between PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED and
+ * PTR_TO_MAP_VALUE_OR_NULL should not infer that map pointer is not null.
+ * A bug in check_cond_jmp_op() made such inference possible.
+ */
+SEC("raw_tp")
+__failure
+__msg("error: invalid dereference of R0 (a nullable map value pointer)")
+__msg(">>> 11 | (61) r0 = *(u32 *)(r0 +0)")
+__naked void untrusted_mem_does_not_infer_map_value_non_null(void)
+{
+	asm volatile ("					\
+	/* r6 = bpf_rdonly_cast(0, 0); */		\
+	r1 = 0;						\
+	r2 = 0;						\
+	call %[bpf_rdonly_cast];			\
+	r6 = r0;					\
+	/* r0 = bpf_map_lookup_elem(map_hash, &key); */	\
+	*(u64 *)(r10 - 8) = 0;				\
+	r1 = %[map_hash] ll;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	call %[bpf_map_lookup_elem];			\
+	/*						\
+	 * buggy verifier assumed that r6 can't be null	\
+	 * and marked r0 non-null as well.		\
+	 */						\
+	if r6 != r0 goto 1f;				\
+	r0 = *(u32 *)(r0 + 0);				\
+1:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_rdonly_cast),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash)
+	: __clobber_all);
+}
+
+void kfunc_root(void)
+{
+	bpf_rdonly_cast(0, 0);
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.53.0
