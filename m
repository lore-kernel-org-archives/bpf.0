Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926044BF944
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542917; cv=none; b=Na6tvYfPfaiQxWtc6LfRwVhzN6qdq2FfOgjkiJJ96ncRWegQPZE9A5C9t6hWd3BKOsQjTnr88M29vYbM5IBjQBdzbdAPtnneEZQPTXUyDYOYjkB3Mk32kK0L2DmbBSV8NlnYrsOotO84+JRc01NMJEjvWd/A/ghla54yY94khmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542917; c=relaxed/simple;
	bh=AZJ4hVlXF97b8aJx3NcmagaJoPwP28ljCjne7XMWv4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oHp/x54XO6Dtm0ezZ72krcPzNG5Tnevb/HjLF7/KfQwDbq2E4p9kscVxGz2L7fQ061racYocnBmFjoFe+DeDGVdc53H8E9ZknOegSoqvz+sBVfMK/F5fOGo89dlPR0rw6oG7OGSXQUt2gHHogWy1xcoofcIgmJ/ZsfPRki7h9dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfE4110O; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfE4110O"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e82462a3f1so8269535ad.3
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542904; x=1792147704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qqFD6K+FyKzM6NjLSpiidT/Pao1ZBH1yZTi9t54LUmU=;
        b=UfE4110Or7t9wLV9IANiDVUwaltAyKxQwEwbyDlUb5DY2PpEIU8g5MUK+wwszcuusU
         wqbTekbqdAlRit7C/KGUjAYOPPFshaiwlmGwTHBr2N9iqw2GktYwROSodQKlJKxqYUS5
         hrrZw8c3P+shQ9oo3n9RYX7YVP0VQft7m7foRIRsP861x64cKKRHWnCfoLpeTF1yOqwe
         Cvi+8exgFh6sdMsBXPjlEHcXz8IJiRaQtmpfUxtQ9pzloWNknrwbYWiWht2zySr5iw5T
         mqRB+bMbUqBPMGwgBwOr3mQ01IdYmJxJ++znOY9XIxbhiL6KHLpeQQ/ufBOpx8W6AAZN
         mNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542904; x=1792147704;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qqFD6K+FyKzM6NjLSpiidT/Pao1ZBH1yZTi9t54LUmU=;
        b=Hvb36T22yHB7seJFfj+CZ3ZAw9kvvCXaQRr9XCrn/fepOzr1meIT22ZKkYAwtziEuk
         wuJxrNuCuYhX23kHO0x1bMVoAHYQ5HXyXZx6VRjzjVg8G/xmXRnJK1S2QKh9rj0ZqWQh
         LhFNYSbjSRunXLAunnY460SveCmxlTujxeG13iyBJtMj5GY1KMO7nOpJPJljHCALpgBh
         M1/vz7NoOGFlaUdScKYlI+L2ZAwahzR2mUhZIHnJ2FlfzdYE3oSRAr3+mANM7d1qSY/k
         xyqGzy5OgL9rryPlVZV40S7ZzYlBlLCd/UvIcCR3uc2/0Np4IhkpHNj00B9YhuwZYxuC
         77vw==
X-Gm-Message-State: AFq9FYITOkxFluhU4dd8FFeP8t6geATbFhFvPOi8nWgDSgKrnh12yWbV
	wC0imo4xF7mphpgXZ86GNb5f5N9sRJuQuhvh8jVUILvx7NMCMbwJVxRBvY5t3lkU
X-Gm-Gg: AYBFou1xOJ6sEb7nXS7YtUnapNv+lUxEFL4yknsmY/sY7i3g2a8an354pfCZnxTa05J
	683mowpEMmo7Qi9UvAb35lbnkuF6734mNdbF6Kpz6CBpd8+yFc8euVumE19fLZq1dEn9iA5TLcz
	sw0h81EwDOB+J6H53RZ2vch4+KQ+Xr39R7CJV7FLKSdS9XxD26pgrHtRU+VCJaPmHO6x/mX4o9M
	h1oQ0c9GySnlbylK6KAfoA0HayqJfg3ijgP/fcVitOjm5jL7dCLZTUddQokPnjKxnn+GgClHhWH
	8Z+WDa35ku0BwCRtsGyBq3r/LxH8DB0JW/Lz4e4Zz62N73EEEwQsJMaVF4oKZ2+9rIRqLJajNMd
	VWaoMCWPuXkiljBZ7X7Ynr5gSXP5AM1Kni3JIYzcXC+V3ddVfbOeY6iSDpSflC9igl6/1wPJVkb
	JlKzrLg7V0IFDgXps3dRX7bIedY/f6oPLRpnba52gDB25YZgl5SJjnuQfeSljq3xyr+TTZtDAck
	U0aVuvT52IWlEs=
X-Received: by 2002:a17:90b:3912:b0:3a7:f64f:6473 with SMTP id 98e67ed59e1d1-3ab3ac6e6camr1276166a91.50.1791542903665;
        Fri, 09 Oct 2026 03:48:23 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:23 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 08/51] bpf: record write effects for atomic operations in liveness.c
Date: Fri,  9 Oct 2026 03:47:26 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-8-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Atomic read-modify-write instructions are recorded as reads only,
omitting their stack write effects from the may_write masks needed
by SCEV.

Record both read and write accesses for atomic RMW operations. Keep
LOAD_ACQ read-only and STORE_REL write-only. Share the precise/imprecise
stack-access dispatch so both accesses use the same address handling.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/liveness.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index b9b76684906e..ce74e3f16eef 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1634,14 +1634,22 @@ static int record_load_store_access(struct bpf_verifier_env *env,
 		break;
 	case BPF_STX:
 		if (BPF_MODE(insn->code) == BPF_ATOMIC) {
-			if (insn->imm == BPF_STORE_REL)
-				write = true;
-			else
-				read = true;
-			if (insn->imm == BPF_LOAD_ACQ)
+			switch (insn->imm) {
+			case BPF_LOAD_ACQ:
 				ptr = &at[insn->src_reg];
-			else
+				read = true;
+				break;
+			case BPF_STORE_REL:
 				ptr = &at[insn->dst_reg];
+				write = true;
+				break;
+			default:
+				/* ADD/AND/OR/XOR(+FETCH), XCHG, CMPXCHG */
+				ptr = &at[insn->dst_reg];
+				read = true;
+				write = true;
+				break;
+			}
 		} else {
 			ptr = &at[insn->dst_reg];
 			write = true;

-- 
2.53.0
