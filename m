Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6697A4582DE
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 19:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920111; cv=none; b=N9a5KtmiGTRUrFTf5M03HdAyV5f5rSEvmhs+BAdX9uehE9f7twNoKFcv5HY8784GdI3OAFVVcbwpoU5VqQacijnYMFtVtHTSROgASD3e73po2n//LsiE6i7lDTb5HAZR0kXO57YtapeRprUYKUt7qQH8JqhAmxX/LBinaEx3Hvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920111; c=relaxed/simple;
	bh=5hfVKjTvPN9bNwfi8vhwmVkGMBBe1FkzABd+oqOpJOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJ+MxflCiAU31pTw/33PDJ2CHHewakkqpFJtUcvDlYj6IlO0pFydIsYeNS3CGDRXG+jQT1ZKdpgcxZNSynANpdj/kg/xQMPcgj8UGMf9CXiitB8V/1AaQ1f6XW7rYkP4rEbQv61l2SYW3cd8T464Jq62Q3Pl6ySbwNitSZi4vgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlEQxDhO; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlEQxDhO"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ceaf8a1265so10538525ad.2
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 12:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920110; x=1785524910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O7fF8x9NaviaLeLWZYjXQcydt8gRQyBwXDisGSdLBZQ=;
        b=ZlEQxDhOBwQZidkRyazMJjd4VUCpyKcRYdQ6T7METk44WNa+sGV9IawTfm8IAUPWAi
         DTM3st+m1E/5STqviKYu230oYkOpLjkS87S2INIdwYAgq9pKbHlt6MwilLnYQJXizx5+
         TcQnGCQm3cjATATwLlQfYa+qF6K9XYVB3oDGwus/w3Pdi/dBheJ75ZUSGtrjAkmCcmwI
         xey67Z+aHlMY3vPcQ/gDxPG613CJZv387nZvkyuTLtWhBLEQdJdzmv9A2F1eWzsYvkV7
         vZTLFREWScAmXYJGMCUVjzlTDjO8JBRb8s65I2Op4JNkBGmkaDo5mHAWNAdtT2/TNDn0
         O9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920110; x=1785524910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O7fF8x9NaviaLeLWZYjXQcydt8gRQyBwXDisGSdLBZQ=;
        b=QLXHvBUMzVyeWKxUg+s+qRWeB0TLiTOLTfSw3BxKwpaN1C9JwbZY3j1+eIedZP2JP9
         oyTBRQ2q5Q4wk7aoFmemt/EbjJPKxZOtjoiWRUEiZ8KP0EwrcsA+YGiK9MOSqBx+W8+E
         FhqMGyDcGbNtbHzEA+EHT4ZEjEvWsqmE8qsoST7W30HdjG17DujDsCfs2aouVGgyrxdE
         UfGzXAj1NvuHq6ZkBrx1aVXf7G7z90zM3dGHMOriZqZXjihcXopSA0UJ37/jafDYi71M
         QDOgf+Ku4Q50ZzxAE5YdycH62QAOTGsBCPEbC7ovW2U5YA94PtNEDdewQkbmERVc45o7
         GCkw==
X-Gm-Message-State: AOJu0YyInEhOtmh321cWUHcprGoBc5YlYfU7FwNXvKfbY4iZ7eHnxRLr
	Z1Y0ykiES1diIawdQ5g/hvZ7DCJ0yCGLtrXGcuQ5/loWgubvxyPSR1LDCdE8MA==
X-Gm-Gg: AR+sD12MOI0Lzy1y0GtsxBWv5tyizUrXSJqOjYbPG2XFlaDtRFxHwU6k8cvDMRL6tMD
	bTWEKAbAMrQ11qhzp4otKPqQl8WoAHQreY+Rti3p2aw58zsrGgdbw4a2vLdlS2SqjtlwDQk2E1+
	hYwNfBzx1NTHVyllFHxgGxQLAhIS/s7SX1tgMnKvs1FB8/nVt1v6uDTlRC/blB0z7UFmYq9dfSX
	cM9UCLzbGXsJXb8VsMTUhWhXfSAbsWU+iARuH+GBsQrl69tjoyXVkwMw541P+VoPMMdqxurXO+H
	X0SbxobApzy+NJZZby+ZgtPH8/FsjZlfHdAr0VRA+zVpUc6IO3H8GJ92scaYsAmdqxGfpc02AoF
	CXVWIEvktMcpG22fpt6YdrpaQjQlp584eCMOuc7Xn/3ZhEYcN4ydNd2Lt1v5JdcYk5XMPK86+VL
	xKLQ==
X-Received: by 2002:a17:903:b90:b0:2c9:97a8:8c1b with SMTP id d9443c01a7336-2cfa71cfbe8mr91297905ad.46.1784920109480;
        Fri, 24 Jul 2026 12:08:29 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd76c4sm58091765ad.23.2026.07.24.12.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:08:29 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 14/18] bpf: Check helper mem+size in ARG_PTR_TO_MEM case
Date: Fri, 24 Jul 2026 12:08:08 -0700
Message-ID: <20260724190813.1458271-15-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260724190813.1458271-1-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_func_arg() verified a variable-size memory argument across two
cases: ARG_PTR_TO_MEM was a no-op and the buffer+size pair was checked
only when the following ARG_MEM_SIZE argument was reached. Handle the
pair in the ARG_PTR_TO_MEM case instead, looking ahead to the size
register at regno + 1, mirroring the kfunc handling.

check_func_proto() already rejects a non-MEM_FIXED_SIZE ARG_PTR_TO_MEM
that is not paired with a following mem_size argument, so the size
register is guaranteed to exist and ARG_MEM_SIZE needs no case of its
own.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 144c2d8aa492..2326b12a1531 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8505,9 +8505,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		meta->subprogno = reg->subprogno;
 		break;
 	case ARG_PTR_TO_MEM:
-		/* The access to this pointer is only checked when we hit the
-		 * next is_mem_size argument below.
-		 */
 		if (arg_type & MEM_FIXED_SIZE) {
 			err = check_mem_reg(env, reg, argno_from_reg(regno), fn->arg_size[arg],
 					    arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ, meta);
@@ -8515,14 +8512,15 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 				return err;
 			if (arg_type & MEM_ALIGNED)
 				err = check_ptr_alignment(env, reg, 0, fn->arg_size[arg], true);
+		} else {
+			struct bpf_reg_state *size_reg = reg_state(env, regno + 1);
+
+			err = check_mem_size_reg(env, reg, size_reg, argno,
+						 argno_from_reg(regno + 1),
+						 arg_type & MEM_WRITE ? BPF_WRITE : BPF_READ,
+						 fn->arg_type[arg + 1] & SCALAR_MAYBE_ZERO, meta);
 		}
 		break;
-	case ARG_MEM_SIZE:
-		err = check_mem_size_reg(env, reg_state(env, regno - 1), reg,
-					 argno_from_reg(regno - 1), argno,
-					 fn->arg_type[arg - 1] & MEM_WRITE ? BPF_WRITE : BPF_READ,
-					 arg_type & SCALAR_MAYBE_ZERO, meta);
-		break;
 	case ARG_PTR_TO_DYNPTR:
 		err = process_dynptr_func(env, reg, argno, insn_idx, arg_type, &meta->ref_obj,
 					  &meta->dynptr);
-- 
2.52.0

