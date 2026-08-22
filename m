Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3670199EAD
	for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 00:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787358783; cv=none; b=gDvR+tFbXpe9SWloWGIWFw7hIFiLsJ/dP3P88AFPZwPITWRhl6c53xGPpBnun55fIAKaqGMOHaUduV2RfKmFoAihpI4O8D739VGdAI8EMwxTKniP/zC66PU08cjykwV3YX3GVsVH0nfgR25hY/ElK4V52fUKLqJXBo7tcQAaVSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787358783; c=relaxed/simple;
	bh=rqqyzEHYoqPiJMKdWuPT/aVdVHVo1FXAsseEXmK5OhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2g6I3e2ZFFjn6BMWyhoZVYtUSsA70gnaxZ+9TrfnjEHEUPLdn1UfXXIBbwGmq2EN1nc0eTXRN3zBRy54Pi7h3+L9HVyHQpeKtuQQOwXqwbHiD76zmD9i7U/R3SIhA5nWDzdveedE4W9xrhJq0a3lH/gsFo4YPAVWjA3p9G2COc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ouo/wTIp; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ouo/wTIp"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so1624461a91.3
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 17:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787358782; x=1787963582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rDjyMj7F/Gue2OfOZrN+tNb38oRLdKs+B6+lZWh2LfQ=;
        b=Ouo/wTIpRdEtWtO/I8xDufdvcnNdNvbuGHFwVgPVh0wZrLknBhNG4y0pkDxj1CR/AH
         aYRtpXshYrjIyCbuhpX8uzz42mdX/tz6hIsqXPlRwJTUdCHfdujPcI9f7u+EPEw6KTBU
         I+7aenJoXB3tTBiJiUXSps8dMsuKmBlbA5wQzo9SQUzGbuJJC8+If8pxyp/13Gvl+Awb
         vGjxnpWgkzmD4Rve1xcDugda1ZF2yoZuiLpiWxBJ0KE0JAaVioKbmj47djuIvfQqY+R7
         SK/xc9pHJAGsqIOZhDu+ZSBjyN6BxP7JSXpHghjfHfL1WXHYpyCKwuJLqUYMp+eNjiFX
         SX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787358782; x=1787963582;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rDjyMj7F/Gue2OfOZrN+tNb38oRLdKs+B6+lZWh2LfQ=;
        b=ZcNwtw9PgQIyOHbo6dEWPgEMcOq+i3b+4AuFEwTm9WkVywvXnS7eDnMvPpNvOidLDA
         l/iusbc/Q8neZp2DMPFjFQpkRekDyE8X233EPfCcFA3Dq1E54KozOMPHraehZsPqN6y/
         QIRyh80preUE3nzbfhO8EN1aCHmHHFIUSFB22ggwaHIbpuWAFCqUSM5MbfB1KiNOJtrV
         Tj8OBM/tyYpuNhdaRVRaSytZVCMGWIT7TkUS1WoM5LyRxL1vMb8pEelz+fHwu2vyRcdZ
         37p9QNuyC7AvSK1tRRjUSCcyNAG9XYoIjrCL1FRRI+WikAvRmLksT4tfOULRWisvTCmk
         0bYA==
X-Gm-Message-State: AFuF++m06OY7DKn5c56bTEWOVbYO6FwXtZvmUy73NTVp9zupB7mEE8b9
	Go6mLf4v3SNmHhQy3IvcAqeFVzty3AUUrzPex79N1xK8mTzQw+tuLNJ+npVZ6A==
X-Gm-Gg: AR+sD12M/89E1/lzAABEh0+dD25ZjTpGVBiv+e4e8IfwoJjGf5doXyfPZ6Fd3eArHFJ
	re9KXaX//E37fIz4id/jSNc7UJY0Pl/1ArweWA8AvViBflOph/C54NT2A61u2Hg1KnAtBCIPwNp
	Rnk2IVYmoCxchTRYDwspeJNbbYE8gL5wJYxmi83VZPn/43BZABzWc0GaqtDh7MbaRGqtESynKpR
	pV9Ga+4vXPQokziLYIN8TJD62w52Cn0//B6TjkDp0cJ+UkdnaJ32U+3Wg1znZkenpnMF73FXNZY
	SJq76RHkuZYQgETPMSDMyG2fWBDxvqroqgBVzWJUMoePcYFgzW3Uw1Vk45FApD830tuIjELG7lc
	TY0Gm2LJHUFibCexi5KPPIsa1kuGWVdtFFbWLQpbGxlCW+J4pFJWyUYsu1zWJwoMn/VEFfl/sPn
	qYP8qgfXRn3Ry32oFg/W7Ex46qbAIya1Wf1Y6jpRplNEau8eJSXYxAZyWq0PGp4MfsPu/sAPqMu
	LGdKA==
X-Received: by 2002:a17:90b:4fc4:b0:38e:fea2:df53 with SMTP id 98e67ed59e1d1-395dee88d49mr4057912a91.4.1787358781896;
        Fri, 21 Aug 2026 17:33:01 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4968618sm880297a91.3.2026.08.21.17.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 17:32:59 -0700 (PDT)
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
Subject: [PATCH bpf-next 2/2] selftests/bpf: a demo for check_cond_jmp_op() non-null inference bug
Date: Fri, 21 Aug 2026 17:32:37 -0700
Message-ID: <20260821-bug-029-bad-non-null-inference-v1-2-45ddc0f7c308@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821-bug-029-bad-non-null-inference-v1-1-45ddc0f7c308@gmail.com>
References: <20260821-bug-029-bad-non-null-inference-v1-1-45ddc0f7c308@gmail.com>
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
 .../bpf/progs/verifier_jeq_infer_not_null.c        | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c b/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
index 3d1e8de4390c..085d1146896c 100644
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
@@ -264,4 +266,46 @@ __naked void jne_reg_reg_null_check(void)
         : __clobber_all);
 }
 
+/*
+ * A comparison between PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED and
+ * PTR_TO_MAP_VALUE_OR_NULL should not infer that map pointer is not null.
+ * A bug in check_cond_jmp_op() made such inference possible.
+ */
+SEC("raw_tp")
+__failure
+__msg("error: invalid dereference of R0 (xdp_sock_or_null)")
+__msg(">>> 10 | (61) r0 = *(u32 *)(r0 +0)")
+__naked void untrusted_mem_does_not_infer_map_value_non_null(void)
+{
+	asm volatile ("					\
+	/* r8 = bpf_rdonly_cast(0, 0); */		\
+	r2 = 0;						\
+	call %[bpf_rdonly_cast];			\
+	r6 = r0;					\
+	/* r0 = bpf_map_lookup_elem(map_hash, &key); */	\
+	*(u64 *)(r10 - 8) = 0;				\
+	r1 = %[map_xskmap] ll;				\
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
+	  __imm_addr(map_xskmap)
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
