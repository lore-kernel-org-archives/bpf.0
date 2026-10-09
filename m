Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB104C6535
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542948; cv=none; b=Ofpfzm984WoCoV00+Vn/ETSuhtZzgWHLKHS2OJ1G5aAY/YamC3wTh2HICrfjsqmlTz3k0c4VgNmyuY1LSOVE8/gwhS3i/pCRHdOIaB0d7Y8oF8l/A9la4Bb07Fa0PkujM1Mwa+eILcxiw8Lo49ZPegYWVxavminA7dPDo6qGGKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542948; c=relaxed/simple;
	bh=Rnl25DzF8N139Kkxe3Q+NrW8/L/YRcb4wVZmYuSpVhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hm8fT2KVlS3xbHrcOmEgeAz3buN9yhXDbQ51Y4vR9QKnNU30NJxm/fMOC9y5DRknGsVRMYOY+Rx2QcUujNCS0I045piZgMVkLSxLHXImatuz7Ka4TAq0TNrtl7TRPms0fBvfUn4BO9ax9cA7qI7Ea49LMZlHaJMZmEXs5TqJxcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVWDVJD8; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVWDVJD8"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so1353176a91.0
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542932; x=1792147732; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SwldsgZt22zk5Xb2d67Mk0ZkB0q/MObvg6/m/MNvLYU=;
        b=TVWDVJD8onDv/Lul69MLys0ztX0c5gDvwmwOpYjFhN7YlNH7UQQmaB0dV5WwYyMkj2
         8KSPGNoEgTUxeAtuUB38gFawMrfsrboZU1NIVWa3ve+o8hCidGAwZ5EgdTCs8YYcXH29
         O4QW28xIuKQ6m8VOyj7lIapQ6Cz/yoL7hgLRdiwxRvCKcouEC8EtL/0a/vZu9WXsWi8P
         dhQbiQ7CrsCCm0GReYenTb3xaNvCjJ9AH3GD0/9Fqk+cxf/QatGzpgIzRMdndr0WysYg
         G2YHH4+Ok4uR78uRtnrM76nJJ9DPzybvmmPk7WjoGGlfXHssW7Pa934IC4rguek/FAJc
         QUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542932; x=1792147732;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SwldsgZt22zk5Xb2d67Mk0ZkB0q/MObvg6/m/MNvLYU=;
        b=C+nREDjTh6XiXVkHSZjLAkoHHiEXFG/+d4BqZykQQuYnuZGp4t486rYMOKs3ldha0O
         KojFMd22wyODIRB/Zh+UzgiFZJoq0gcgSYdQXiydGWg6b4jAA3CFbEmlVklpZbzg/cGS
         cNpekjNEAnwdJ27HvhWg2/WKTfm3LR4uuJVnAjVnEwCYAWECkFvUDjis5VRXFtQZICNP
         v08+vkDN6Vquqs1bgEVympgb9hmArhLglJbVDn3AtJGL+20MizekUPOeJ/ce8QcNHLLV
         jK1HlFYwu/V3XKCjMHCwpwL1Q5QGLB5KyORInyfQkRFkf1Tny+fTAFSx7Or+66tblfvP
         m6Rg==
X-Gm-Message-State: AFq9FYKZ17UGJ9LEn3NZd6CBVWSbCx/bLxWvq7HD5Ystx5JBSAr7S8eJ
	rLEAy6GHjNbogB2Ctk0Yj03jhFURtIn3tLRzpR14cxurWRkwXTxmy26WWqwgC3re
X-Gm-Gg: AYBFou3m17MdwottMTg/PDMJPTjZQlnTgFvR3vdX2UsW59dWoSOZ8ZXHFARC3EKDeyC
	2rhIxnTLmc3mEYdBkjsLSZwGvEdVbt/C1DTT2/zQNg0DJkTSk7T6SFQUTBesO6wyxafr18TQ+I+
	6C97CdoZk0FruPJHcNqog+sanGVQaTwq7nxksuOIoGnPEMTTSL0pyeH9l8aa3F35/8nL+Z/j6jJ
	MUZO0Uh3jcEBLs9/T4jeYUPkk2ExbhaMaEXfKEHlQn+TRqCzBc6v/AEnLBJ+YJoqHp3RmduB72v
	elSEpaO9JqUs0NOAqojJOnCug6HGmuX67yiYBLNUs5GWX3LDLtVMH5x8kz1xQ3o+B0pjsR8IeYY
	xkLSFAE7Cm/+LnhlN2vkQ3E0VI2z/WPShe5GMBj/HAoQ/DC1kWWQdlty20l/MM9wDmhMO75XQZa
	o/8gePRX/VIISwwXJXekmgbhfbRhoxIiGR0FDcqhC9Fiuz2gDsVsKjdGiHXidW0ZYj8rIGFhuYK
	R7FIlpI8hbXnPA=
X-Received: by 2002:a17:90b:1a82:b0:3a0:d82b:237b with SMTP id 98e67ed59e1d1-3ab3ab209f3mr818423a91.25.1791542932195;
        Fri, 09 Oct 2026 03:48:52 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:51 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 44/51] selftests/bpf: tests for BTF-based global subprog stack liveness
Date: Fri,  9 Oct 2026 03:48:02 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-44-bcba9bc53ac9@gmail.com>
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

Check that passing a stack pointer to a no-op global callee produces:
- use, def and may_def marks for a fixed-size memory argument.
- No stack effects for an untrusted BTF pointer argument.

This verifies that call effects follow the declared argument types
rather than the callee's body.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_live_stack.c      | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 0fbc43a5d4f4..3d88cb28b8fe 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -159,6 +159,52 @@ static __used __naked void write_first_param(void)
 	::: __clobber_all);
 }
 
+struct cnt8 { long v; };
+
+__noinline int global_noop_arg(struct cnt8 *p)
+{
+	return 0;
+}
+
+SEC("socket")
+__log_level(2)
+/* Call to a global function: the argument is described by its declared type. */
+__msg("stack use/def subprog#0 global_callee_arg (d0,cs0):")
+__msg("3: (85) call pc+{{.*}}; use: fp0-8 def: fp0-8 may_def: fp0-8")
+__naked void global_callee_arg(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 8) = 0;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call global_noop_arg;"
+	"exit;"
+	::: __clobber_all);
+}
+
+struct task_struct { int pid; };
+
+__noinline int global_noop_btf_arg(struct task_struct *p __arg_untrusted)
+{
+	return 0;
+}
+
+SEC("socket")
+__success __log_level(2)
+/* Untrusted BTF pointer arguments need no caller stack state. */
+__msg("stack use/def subprog#0 global_callee_btf_arg (d0,cs0):")
+__msg("3: (85) call pc+{{[0-9]+}}\n")
+__naked void global_callee_btf_arg(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 8) = 0;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call global_noop_btf_arg;"
+	"exit;"
+	::: __clobber_all);
+}
+
 /*
  * Cross-frame imprecise write: imprecise_frame_writer() receives a pointer
  * into the caller's frame (frame 0) but conditionally replaces it with a

-- 
2.53.0
