Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6F6411A04
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121140; cv=none; b=Jwp4jObiIVdAxNTvNOVjGQ2qpd15O8RWdiAsBEi8uquz52jMM3HGZTzy9CDMjJpIc+NEsWUIxttYt8igWLmlezSfyZmXlJznQmWrscKkGISopp6btf7MtqYmmI+skreM5gpnuacsLpN8MjGM5KyaqKU4lbavU+YULikkXo1AvmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121140; c=relaxed/simple;
	bh=J9T0dh8j61v+7NXXaq+p5R0nvYu/taUTsIrZMAB8kZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iP/jatOHFyfAI7EKiwLsbYcAdO3fBKeUhlyrGwuRJqK7HvFPUPy2k/rsgyodK70SdrQRqJKLVhksioj76vzyts6uYFclKIHh5HCcz8Pm7PPA7jeP/r+G38ZPehRnfCkyfVKiNAqW0BJp5gOQ9HI/pNS9pKpaMKI8XOWjBALD/f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qIUNeLtI; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIUNeLtI"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc797656e36so163201a12.3
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121138; x=1791725938; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lsXoFQmn6AEG8vk+4Qki4cdwGh2/k1EUbkg/hYC9scU=;
        b=qIUNeLtIAJ454Lp+m6FGrH4bYNJR92Ohr7wKGtXscDdUKqq28Ei9pXEB+ywUHJrF2F
         VdYUDl/Tm6KcmTJJzkD4JfMKyY3GNpeBD+3P0ttt1N+dswdwSOEECmeXmsYmEHBZPpnb
         qEu3PG1SY+I8M5eoJe8oetH6G4cwihpSUKhF6HbVq8malSZhdAXvfhendpAkhtjidC1J
         fW3rDXPBPpQ/P8cnhqmMCtSUSnCRV+l2S9snFVbMZejavWnE4t3l9UNzyw5spr/eoDq7
         ZtrMK2gRsYewa1CW7C4QqATJENVIsB2QZy21GQKU5b6hHLPkb90fYL1B/SgzCt18T+rs
         5B2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121138; x=1791725938;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lsXoFQmn6AEG8vk+4Qki4cdwGh2/k1EUbkg/hYC9scU=;
        b=QiBZwXzXh+sv4545vqmlsgCCGIh6bf4SKMGxXOVYPIsyZnrLq8AH1Yhf1DL87FH4DN
         ozzbTxdTYzIp94FE9phq/0SvsGsvnCLuDzFAySZ3Qw6S2MrwcxeS86mD/Of/gk80HmaX
         6wJp/6eaRsKVQ9xVoDSgX9HZG4t5zDio5fTz+OA5EkMzmgZBpleneI/wecBNv5BnO1rl
         nI+ooZN10abUkdDHipT73bUpAwjTaxenbjyG35ww91YRIMcdptG/5qj+grapW0e8kjAi
         DOYImAQhedsLfJF3Jb4B0pkU5RROUAfk5Cu4mCijwe8K5wQ+pnvEjQUxpNXXgNY7Q143
         i07g==
X-Gm-Message-State: AFuF++m5A2QhL/GMOcgcT/rZ0nC6zocv35LbxiM11L/Qi/VtF7yF1Ak8
	P7aL7u27PQp7yHPhwVc4thIKcpPMcggqZB3BdbCGFux22MNxkj83O1V3hHoEog==
X-Gm-Gg: AYBFou3Nunjqlz0VOIP51tmiCLDHyreYN9ax2c28VNde1HNCVQZUEfU7bz6/UkxHNop
	IFBeQwLC87vX3JhHbClkWoVbokg0VM3j1E9S9Uh+7y/T6yYfKOyFcuW59MX0ZdaXn6xyEKCCS15
	FcfV9QbhUFV8UjhM/KErLKuy43dg76hIyQD7lztLbm2i/px1Wc0IPuTgfnHoz05uZ8hIKR+CLJI
	dR71LfLt88HlsdbSsLPMnPFD9Qv/WtmZxwips5KHQah+dlct6uMhZPgc4HjZIu2CA7XV9M3yUPr
	ahi8e7ShEoMiUmha/tc7FChxQfUPDJ6CWTX3v0awKrw55ANw1Jrtwldk9uDb2ZgEDU1m34dLsP5
	CLRoCirjTzb1MQf5Fu5YfQF+rijlTGU1x9wEZySlp5aM6CslOxXH+72fUVHuD0smlCbQg4aDFQD
	AXMcCaeWCac5qMX+meeYtr7m0Nk9byAazC6xpcL/rzKzzn9nGBifs3//6oz2N79iblyhIwjCSAR
	EOzwC9s9UIPdYU=
X-Received: by 2002:a05:6300:218d:b0:3de:5b57:565f with SMTP id adf61e73a8af0-3e0bd17fa78mr7335001637.23.1791121138364;
        Sun, 04 Oct 2026 06:38:58 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:38:58 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <ezingerman@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 24/43] bpf: record basic-block ends in insn_aux_data
Date: Sun,  4 Oct 2026 06:38:06 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-24-f6254e29fdf2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <ezingerman@fb.com>

SCEV needs information about the program's basic-block structure.
Piggyback on compute_predecessors() and set
insn_aux_data->bb_end for an instruction if:
- it has multiple successors, or
- its sole successor has multiple predecessors, or
- it is a jump instruction.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/loops.c           | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 8f5d35fa9aab..8c00a78575a1 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -730,6 +730,7 @@ struct bpf_insn_aux_data {
 	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
 	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog percpu alloc */
 	bool arena_scalar; /* ldx/stx/st/atomic through a number, it's an address in arena */
+	bool bb_end; /* last instruction of a basic block */
 	u8 alu_state; /* used in combination with alu_limit */
 	/* true if STX or LDX instruction is a part of a spill/fill
 	 * pattern for a bpf_fastcall call.
diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
index 545cee0fd956..7a9167028012 100644
--- a/kernel/bpf/loops.c
+++ b/kernel/bpf/loops.c
@@ -5,8 +5,23 @@
 #include <linux/sched/signal.h>
 #include <linux/bpf_verifier.h>
 
+static bool is_cfg_jump(struct bpf_insn *insn)
+{
+	u8 class = BPF_CLASS(insn->code);
+	u8 opcode = BPF_OP(insn->code);
+
+	switch (class) {
+	case BPF_JMP:
+	case BPF_JMP32:
+		return opcode != BPF_CALL;
+	default:
+		return false;
+	}
+}
+
 static struct bpf_iarray **compute_predecessors(struct bpf_verifier_env *env)
 {
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
 	struct bpf_iarray *succ, *preds, **result;
 	struct bpf_prog *prog = env->prog;
 	u32 *num_preds, i, s, sz, len = prog->len;
@@ -55,6 +70,10 @@ static struct bpf_iarray **compute_predecessors(struct bpf_verifier_env *env)
 			preds = result[s];
 			preds->items[preds->cnt++] = i;
 		}
+		if (succ->cnt > 1 ||
+		    (succ->cnt == 1 && num_preds[succ->items[0]] > 1) ||
+		    is_cfg_jump(insn))
+			aux[i].bb_end = true;
 		if (bpf_is_ldimm64(insn))
 			i++;
 	}

-- 
2.53.0
