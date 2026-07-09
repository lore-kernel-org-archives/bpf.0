Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8474335A3AF
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605261; cv=none; b=Lm5d2Jbdc/+M5DvKtakFm3Q2ua53RG8qjxIVFxF/1i0GlJ8LZlexRwYfIur4duSTyEP0SiWCo2DltxMreqK5DfVwysNTrw3ABidz5nWuIbNbHcr5Xtrhf8ArV5IKefwXVHo0NUwY11/RjcZeD4WVbFu+rQRzcBRkO5fne5wD1N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605261; c=relaxed/simple;
	bh=/reHL08UUuRRUqOr6ljVZhHoxt0kntH+itBGJpC8Sck=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QiddKl41dPJtx//E3YlolpCIv0uaTuubYojs3bNdO2JNgBQxx0d6haUwajX6g5bikvgRo+oFjk8vwxGMVl5I8TsbMEpVMVacUY9BRdt5duEO9xE0fskMcg+R49SJfmYRSUzUqUjbjedzJcpN9usCzE17kGilxjTc0c5Ix1jqsqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScJ4xQx5; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScJ4xQx5"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-735f73287e2so1369248137.2
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 06:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783605259; x=1784210059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9HFJASiiOuWiepuHtUiiSys+tiJGmlgDvNhkyGk5g18=;
        b=ScJ4xQx5wSQvJ9m4Qd6WoEkW+XZ/67aQmaHs3+UOh2o2wD4pZmHCCXDTdvAH6vSd/4
         2qPOOueElW+5EVmCw+eAUex5z8QqqvZwDZr8/GAYI8zrKjMnenK6SHGZTio4/1Z41yfv
         18TJSUAAdENOP1Ab5q4AdfOSQ1GXmMKvcEaC3S9BkiojRTrRnE2rP+CGsx+hNjbhp1yj
         FkhmDTS02xk/AoU3tB/vukuT210O53LCrSQB5dqjC0a9Q2e7vAuLQeAfQpBAi/6d/SME
         a924Gi5+zs7FzvqEnbIaHmhxRT5+qbS7LjVwJCUkI2ciQK3MqoF0me2nzpLnSyxzArob
         LylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783605259; x=1784210059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9HFJASiiOuWiepuHtUiiSys+tiJGmlgDvNhkyGk5g18=;
        b=QfAXMSQPVZ80Or7/CHBE5TmoiyjR5XmGZpeqAiou3hebkCMECTTBmMTxLH1Tmn7iT0
         h+eIWnG9bjJlTZOYEZvKAb/0P5S6eFSCcK14H0t4E76n/XjwbZt2QE6mo279fZlOmHxc
         hqljNdlGlfiaJrzLq1kHrGAqeRT/TbYMhWGHVbITg1cKh+8dIwM4z05ce/pNUPCazdIT
         V5qGqBkxY1/Ocrnj1vAvAnJkCyA+WtwdXIMf8rjUFSIBzA+T4eXeEArB2h0pehygdIR2
         LdaKf9BRD34AzPQ3Ap1V1AnjT5rqG96vW8pDm0H9NgLgj7oxzw9/UIPb0A3gsgGex4ia
         Jr6A==
X-Gm-Message-State: AOJu0Yzh+7epgE8R/vFpL03tHZlfac5APSEVwzhiZC+JqNNROmRkbSp/
	fS6Kbs9dE+PuRWSFhyQolkjKbE0aayCfpyWQ19X56LQ0D5medRXbGbsbtXSeoQ==
X-Gm-Gg: AfdE7cl5+ogN1pcSA9zgxvq3fUL7aj5keLiwMe0XE2cZCu4YSJXbHtfCOR1um2db2c7
	PVrcO28J5/C6g0rmdEU2IJ5VUofKT+lQ219N79Lr5SHj1Y/iuBf3YosZpoRspUNj24wPmcS/SWb
	nyN8rT1uQtxboZinoT4GzjMrwtDsrg/rtVM0S0FSO6K4E7iwxyahpqcgXexlA3GBqGm1dmwTE7n
	w7TlzcwCC83wPU57G1OpPL7V2PoYQbPar7jVSoO4idcXIcfwPutC8GUH3lY5mQe9efTvgoxDz5q
	7olrhIvfQdP4DjVR2FL4XnUTwGS0t3024KfeWLLcUxZ9/sqfS3oOupzgnKJMbLqEu920ApjByUJ
	LcHZjv2yvyyCi88zKAbcGmJ/fkx8VeFKIkNIkSaN7nJXzERz6gkpRiIqzqthh+bYR2EHsiN/f7g
	tYD7BmyACbiJRn4EsR3Lc=
X-Received: by 2002:a05:6102:f89:b0:744:d1a6:b11d with SMTP id ada2fe7eead31-744dff7e31fmr4672295137.3.1783605259309;
        Thu, 09 Jul 2026 06:54:19 -0700 (PDT)
Received: from TurinLinux.. ([184.144.109.221])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-744d6deb1aasm3610916137.7.2026.07.09.06.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 06:54:18 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: bpf@vger.kernel.org
Cc: yangtiezhu@loongson.cn,
	hengqi.chen@gmail.com
Subject: [PATCH bpf] LoongArch: bpf: zero-extend signed ALU32 div/mod results
Date: Thu,  9 Jul 2026 09:53:44 -0400
Message-Id: <20260709135344.1744677-1-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ALU32 operations write a 32-bit result and leave the upper 32 bits of
the BPF register zero. The LoongArch JIT sign-extends the result of
signed ALU32 BPF_DIV and BPF_MOD (off=1), so a negative 32-bit quotient
or remainder leaves bits 63:32 set in JITted code while the verifier
and interpreter model those bits as zero.

Keep sign-extension on the operands, which signed divide needs, and
zero-extend the ALU32 result after the divide or modulo instruction,
matching the unsigned ALU32 div/mod paths and every other ALU32
operation in this JIT.

Fixes: 2425c9e002d2 ("LoongArch: BPF: Support signed div instructions")
Fixes: 7b6b13d32965 ("LoongArch: BPF: Support signed mod instructions")
Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
Assisted-by: Claude:claude-opus-4-8
---
Reported privately to security@kernel.org first; posting to the list
at the maintainer's request. The patch is the same.

 arch/loongarch/net/bpf_jit.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 2738b4db1165..c91d474faba7 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -835,7 +835,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			move_reg(ctx, t1, src);
 			emit_sext_32(ctx, t1, is32);
 			emit_insn(ctx, divd, dst, dst, t1);
-			emit_sext_32(ctx, dst, is32);
+			emit_zext_32(ctx, dst, is32);
 		}
 		break;
 
@@ -852,7 +852,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			emit_sext_32(ctx, t1, is32);
 			emit_sext_32(ctx, dst, is32);
 			emit_insn(ctx, divd, dst, dst, t1);
-			emit_sext_32(ctx, dst, is32);
+			emit_zext_32(ctx, dst, is32);
 		}
 		break;
 
@@ -870,7 +870,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			move_reg(ctx, t1, src);
 			emit_sext_32(ctx, t1, is32);
 			emit_insn(ctx, modd, dst, dst, t1);
-			emit_sext_32(ctx, dst, is32);
+			emit_zext_32(ctx, dst, is32);
 		}
 		break;
 
@@ -887,7 +887,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			emit_sext_32(ctx, t1, is32);
 			emit_sext_32(ctx, dst, is32);
 			emit_insn(ctx, modd, dst, dst, t1);
-			emit_sext_32(ctx, dst, is32);
+			emit_zext_32(ctx, dst, is32);
 		}
 		break;
 

base-commit: 0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53
-- 
2.34.1

