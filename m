Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D7F3F5BE4
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788510824; cv=none; b=rOOHfUd37oxFlqog7QZpRnZihxZhCMjb+qScAOlsXUbZz3HSuNbdgOMn7NCzPQJV4pAB51CBIuQjtaGVCBjR4OKaVGISzo0lasJaSjzTGVDKOa7hyF63UCbzBtI39fs9xeaeymQdE4zyAiYaT2AYYgU6Yl0i2M1wELhJDL0x9k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788510824; c=relaxed/simple;
	bh=udjHpnYYzoMFnnltQ3g3DmTv+xJsgdJYpn+JPl189us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVgyCEcPcuXkUmick2//qyAw/hQe08VHkggIXCpBeR4S8wTBgvIT1sYglaw3pLv/dK7dcaCVldr6YhKKjcMZ7iV8cY+8nEhjfPR9A5ovJZ+lBDppKbdxeSckvXHwV26ykI25j6FrSAt9tOuwUfySDU6XvfD49TbMrstos5Wcpmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJPjK/8/; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJPjK/8/"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc1cc1b42b5so877866a12.2
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 01:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788510822; x=1789115622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=saWwH7+PSWtHADyWf5bONwrS8FtHJDJz9R1KvsTel+I=;
        b=gJPjK/8/1kJkjkvoahx871GJITsAi/D/lq2VKVeGJYz2M7ByFo+u7teaEfxW2+7gxB
         VycVdCxztiROWx3XWgsyiqnjVTwo2jnnxeLQ1vzpHPeOF9rkI3uCh3AOg9aFbo8I4WFO
         6lzMtwyJPfFdKxOKUuet4GtDKMpUL8Bq0Owj5DSq8M/84QwWxukzRs0kfANbtVwjK69H
         9tKWMIi6KswJqNVXDdxCiH+WDSl4hJemOXxkorpoHSpsMBKWAypK1SPpdGXAIGF93LrK
         Lt/jqllxR6qNJLEqSbmHYn5BguIdecsj10GxuenVZvYMPA2z5vFi7bOOAZlMyJZuOnCQ
         8YjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788510822; x=1789115622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=saWwH7+PSWtHADyWf5bONwrS8FtHJDJz9R1KvsTel+I=;
        b=Rs7RLVG4g6DNCwBTE/Vu7HdoDvtmGx9SVczwn1t8MP8QvA5vU9PQQX86K92AuiieZO
         7QReKQAwbUAGUswtI6/ksa60tmdx1VeaN/6m7vsQHhY+BDzGKGlMMi1sL2Z9qCA/6ZQj
         z8tiJ1ankGUahai0CY8CUemar/hPSXTdTHizeeXGb6oUldGobFuUfbEGP3Zj0UjsYmkY
         AB3369eN8fPOSoS+S431pWjsoUx/Xi727DYa9hrfCVUl85kVH7/Ffi/J8itwOVdhXHlb
         i4VyXp88SNBiQCwCKzppPU78Fwm2E+TObjvYNaLjAKLPh/Ebc9cFw0GRvzsrK9rgS/KG
         0f6g==
X-Gm-Message-State: AFuF++lbu8lyhZwMQavqg6PH/Thqp19PojIvMRt67XGMn5Iwl7uUcMka
	y7JhjKW7J3MLPb1nLc6OPZzSEIWtSZcsPGyDHuM5wHQoHFs9T+OwTSC3C2jJ/g==
X-Gm-Gg: AYBFou0E+sjeuQP3DD5TuQmOHF3L+5JPEH9dXQHdk0vDYwuw5bqBLL7Vb1MnStKQavt
	pnQdl5R8urMeF+08rXRreKsKFomRN2Ve31BPoLIuPNAllZIOpklYSRBLe3zCiX6SAKbnBUK84Uv
	spTUJ5ZxjA3+raNIF9Wr+unRsayrf9wz/jx4+kKJO6vgyWkiMRl0BXo55zL8Hy0N2KyCgZmkzQ7
	Q1AkNm8w2zksb5HZ/To6SDd0HI8N1+KmUV1e6bekWJpfVjF26M543eBWr5f4x+Dl22lTiFLuDVk
	28WZ/nqIXjSDmFMYnIZwM3rMcCMAMTPyRhxLJFbC7ldCmN2mfTCTGdQRi9H4dS9WKoJUtaV5RZk
	OjOfIrYl8USGzOno/yq3TIBlrZ11cKTirfCOr0R0CAUpGXP4rNgJliFQ4PyCdUcULaa4PafbQ8S
	hIRp03X3HYi6z/BULxx/pIEyo59lndrOL/zV+P1Ffy6FzlJePZqR+eaOsK46qD0islLDq9iWuBL
	BOSqEbufbVdMDWUlfpNsdwYRxpkPupb
X-Received: by 2002:a17:90b:3a50:b0:38e:4cb:51f with SMTP id 98e67ed59e1d1-39b26101576mr7700491a91.11.1788510822038;
        Fri, 04 Sep 2026 01:33:42 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm9628057a91.1.2026.09.04.01.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:33:41 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	npc@anthropic.com
Subject: [PATCH bpf 4/8] selftests/bpf: check the linked regs cap for the compared register
Date: Fri,  4 Sep 2026 01:33:21 -0700
Message-ID: <20260904083325.2083493-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904083325.2083493-1-eddyz87@gmail.com>
References: <20260904083325.2083493-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

linked_regs_too_many_regs checks that collect_linked_regs() ties at most
LINKED_REGS_MAX registers for a single jump. Compare r5 instead of r0,
so that the register the jump compares is itself the member that does
not fit, and check that it comes out of the jump unlinked.

W/o the previous patch env->{false,true}_reg{1,2} bring r5's id back and
insn 7 is logged as "R5=scalar(id=1,...)".

Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_scalar_ids.c       | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index 663d15fc5fd2..256547048cc4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -380,13 +380,14 @@ SEC("socket")
 __success __log_level(2)
 __flag(BPF_F_TEST_STATE_FREQ)
 /*
- * check that r0 and r5 have different IDs after 'if',
- * collect_linked_regs() can't tie more than 5 registers for a single insn.
+ * check that r5 is unlinked after 'if', collect_linked_regs() can't tie
+ * more than 5 registers for a single insn and the register compared by
+ * the jump is not exempt from that.
  */
-__msg("7: (25) if r0 > 0x7 goto pc+0         ; R0=scalar(id=1")
+__msg("7: (25) if r5 > 0x7 goto pc+0         ; R5=scalar(smin=")
 __msg("12: (bf) r5 = r5                      ; R5=scalar(id=2")
 /* check that r{0-4} are marked precise after 'if' */
-__msg("frame0: regs=r0 stack= before 7: (25) if r0 > 0x7 goto pc+0")
+__msg("frame0: regs=r0 stack= before 7: (25) if r5 > 0x7 goto pc+0")
 __msg("frame0: parent state regs=r0,r1,r2,r3,r4 stack=:")
 __naked void linked_regs_too_many_regs(void)
 {
@@ -400,8 +401,8 @@ __naked void linked_regs_too_many_regs(void)
 	"r3 = r0;"
 	"r4 = r0;"
 	"r5 = r0;"
-	/* propagate range for r{0-5} */
-	"if r0 > 7 goto +0;"
+	/* r{0-4} fill the record, r5 does not fit and is unlinked */
+	"if r5 > 7 goto +0;"
 	/* keep r{1-4} live */
 	"r1 = r1;"
 	"r2 = r2;"
-- 
2.55.0

