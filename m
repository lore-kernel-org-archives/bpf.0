Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022864;
	b=RT8+AYvMRLTVKiPer8tvFdyo2Mtge/LIl9tb+i0yCn7HlCV1Nq5UbSBP2fc+ZSC0a/6K
	 kO4aYSaPsDLKpx9RY/5B3aP2B11sVXJJMNcQb/UkehH8Ut1XI2koegFRd6+UmDpcZLTPH
	 3l6GsyQzh9W5258vyXuUwU5+JvqYNbXb2FH9MyIB05bYVo0Zt8vra2/Qk8v6fSz1H5Yi1
	 kmBFlehImDrvOZvJh9lKCCX/x/Hln0vry2oOaWRxQnkKJD2kwp/mpgwkJT4A7/UZm78dX
	 SoQr//IIrXKvBSEOVvqADOuJrkv7iEqMJWOLOZQRDcAGjnKpnP5T9fwAxW8v8PIogNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zvyZpIyWJXrMhgudD8xN6cBHckziew2+x4v5pN1UdFU=;
	b=EY0rHBwGtlt+EdZkNeQWTOk5hOQpmEY2vD+4izLwfAmBHjs9nspF+BM+87RBrYomwKiT
	 FjWFRvf5qsvTcz0Y8/13EdXFLdxMK/AM69OxrsK6HvVZ16V0S92PWym6Rtv7aw+2NNuXl
	 +yIPZP+ZKdzpp22pucbkiWpAxXalO/XrQEtEYs6BpZlpYSnh8zR5MzXnbE4LIV7daaV+f
	 dUnLKkqy9Ujg44V9rj12xyoodFa7y8CyX7bmJlUxqxA2Zxu8QZOP7PEf9P2fNViDqqBCc
	 cW8ghr2OU+UUYE/pkMmmdYM14+wg7qCDwbOh5uKikwbkiXjU1GcwJP38TDFgKMg2u8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GrCdB2a1;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4254F606A32C
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4254F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GrCdB2a1
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b09c07b3d2so794639a91.3
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022864; x=1794627664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zvyZpIyWJXrMhgudD8xN6cBHckziew2+x4v5pN1UdFU=;
        b=GrCdB2a1/HucdHoLcghpZ0h3N2ZaMaGlclILjlz5C5tLMHX1FG9WXG94rcgrCwiLOi
         F9Vb5GrmH344Ute89AKgbizkgNPweYS4m9Btz4vP/bAmqFOLkG+rcvbx6rwiAYZ/wcjJ
         1/qAESQjoY3qfz8rs9L5Dom3Sy4IdRNR2ipJ/fTiCQpzKcx67n91CXb5ZgkOr2VOsWM2
         f63tUFjwu/d+HHoVbQ0Aw3o8Kpw5WZ1OP32eDROR/sd/e8ul4R58QnCo6ErUaIEdwX5s
         5px9KzXD5xT/gw9PHjyEyCz0RzG1wRAM6FlCXwBve++4PSwLuy96kAuE2pcnVZHYWxwa
         fYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022864; x=1794627664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zvyZpIyWJXrMhgudD8xN6cBHckziew2+x4v5pN1UdFU=;
        b=OsGM8frJTA4HINotV3gSpBKXqTeEHQoq7CG65ybZHJLOwDENmhktCNpNMs4DStHLta
         m8gB5TLF3nkJH9zENcmVXOIc0nyK7b+7yPTqJaznNNkocwMO2v4AzUsEw2kuiLLe8RIs
         NrzGOmndNhDi7p5MtEPjJVLPNvVqxJmVcYRXmzfOfLkp59+G62WEsepaQpSaPYkDBsMH
         HEQLgcVbjKr2FIwhgrx/2Fi3nMdOa83GYJT5yXTbrX/sAoKTRQjkz8MI7Ku3u54Q1GmK
         jE3qEXDJX8cIOf0ASOscr8Vmjv8IZQfvoIXLnnQEQxwhEUo/JEx+xangIwm/oE+AboQE
         GJQw==
X-Gm-Message-State: APuU4Z9jiJ1N19UcqBZHd+BAnr2mBE14piR/1KV2t2AOHKp69tBuYh70
	nU59gT4qWiVni1P7jfHFYXQMVxfLgy4F8wTaGc+mMYlKO8cdxwto9AlKSrt3/g==
X-Gm-Gg: AYBFou2LLIt74zmQGBEKFFVyC1NuJF7cB2bNr+DO/oHoIbltmqk0Kw8Ba3qbcLIFPun
	LgEfrZTmDZVmU/44LNpXR/WPHkW9zxSF9plSOYjvyAt4na63QSBrtB98yXuJEsZeLVYOerioTJW
	QRdwqPg/GYRlFYt2JqGKe3Gjt1/ro/GUzITHRoXoTRQDkXYm1NkyZKVDtjAs9+C0fU8tspGRajL
	cnXGj+VLZxyIlGvYKvtDULeGgwA0ubnpMXm2cn/WoILyn8BT6gJVbIM/yOHZtI1IMiuOzNQ+p0/
	bkQdAG9W9qnV9RJ6s7StczT9KiyFsvl9Jk8roZx1L8PhS3H61LAXDGH8fKD8BjANX+d0dTABfNp
	U4M+dWm2KqYbVnEtFOr4OdJicfJJkN8IVVoP6gU9BxRdu6N4UdPeYoKZCw9kILwnpUiTaINzShL
	D9SrDUI2SIECeMdtSvIP3yZco0dnpxYwHcLwBdtJasgtfASOal/danAC78Wjf7t5qgj/HFsNXVo
	EOVyIYPHH65VQUAO3MuPbtJZqz7z0SkeLFd6cGrZjSstwfoyUDbTHuVjHVjxzuv3tjX+t7LETFu
	YYHSYtOUQbUv9ZlMS4NxLJtoE/Yw8z8+s5H5QUiL2zbJwZFKPgeDKntyyuT8WgKg0cjazKTLyRn
	65wu7VHRn9Cc+VuaTgIC3IJu9dn0ebp+RTG0e8mRyPrZprJ5UIcBxFOzdN5bitMGKA39Y9iuz1g
	==
X-Received: by 2002:a17:90b:1c86:b0:3ac:9669:846e with SMTP id 98e67ed59e1d1-3b0db6ebba7mr4675076a91.27.1794022863434;
        Fri, 06 Nov 2026 19:41:03 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10585df83sm1441481a91.16.2026.11.06.19.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:41:03 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v4 30/46] bpf: What a call returns in each iteration is like what the loop loads
Date: Sat,  7 Nov 2026 03:37:38 +0000
Message-ID: <20261107033758.1547725-31-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

  for (i = 0; i < 20000; i++) {
          sum += a[x];
          x = bpf_get_prandom_u32() & 15;
  }

x is loop-carried: an iteration uses what the iteration before made. The
loop is counted, and too long to go through its iterations one by one.
Scalar evolution knows nothing about r0 after a call, so x is widened at
the loop head. The prog loaded before states were joined:

  R0 unbounded memory access, make sure to bounds check any such access

A value that the loop loads from memory in each iteration is handled: the
first iteration is verified on its own, and tells what the value is in the
others. What a call returns is made anew in each iteration in the same way.

Give r0 after a call the expression that a load gets, with a parameter that
tells the two apart. A call can return NULL in one iteration and set a flag
with it, so a loop that is short enough is still walked first.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index d8c847efbd7f..06f485853df1 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -852,8 +852,11 @@ static int transfer(struct bpf_verifier_env *env, struct env *e, int idx)
 		break;
 	case BPF_JMP:
 	case BPF_JMP32:
-		if (opcode == BPF_CALL)
+		if (opcode == BPF_CALL) {
 			forget_call_regs(e);
+			/* made anew, like what is loaded. The parameter tells the two apart. */
+			return replace_reg(scev, e, BPF_REG_0, expr1(scev, OPAQUE, 1));
+		}
 		/* for non-CALL there are no changes in register states */
 		break;
 	case BPF_LD:
@@ -3254,14 +3257,15 @@ static void iv_bounds(struct bounds *bounds, struct cnum64 iv_range)
 
 /*
  * Nothing that @id is computed from is what a register had at the head of the loop, and
- * some of it is not known: it's made anew in every iteration.
+ * some of it is not known: it's made anew in every iteration. @call: by a call.
  */
-static bool expr_is_fresh(struct bpf_verifier_env *env, u32 id)
+static bool expr_is_fresh(struct bpf_verifier_env *env, u32 id, bool *call)
 {
 	struct scev *scev = env->scev;
 	bool opaque = false;
 	u32 order, regno;
 
+	*call = false;
 	scev->stack_sz = 0;
 	expr_stack_push(scev, id);
 	while (expr_next(scev, &id, &order)) {
@@ -3271,8 +3275,10 @@ static bool expr_is_fresh(struct bpf_verifier_env *env, u32 id)
 			continue;
 		if (is_reg(scev, id, &regno) || is_op(scev, id, UNKNOWN))
 			return false;
-		if (is_opaque(scev, id))
+		if (is_opaque(scev, id)) {
 			opaque = true;
+			*call |= scev->exprs[id].params[0];
+		}
 	}
 	return opaque;
 }
@@ -3402,7 +3408,7 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 	struct bpf_loop *loop;
 	int insn_idx = st->insn_idx;
 	u64 until, false_until;
-	bool same = true, walk = false;
+	bool same = true, walk = false, call;
 	int err, i;
 	u32 r;
 
@@ -3605,15 +3611,18 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 			continue;
 		}
 		/*
-		 * What is loaded from memory in every iteration is the same kind of thing in all
-		 * of them. One iteration tells what. There is nothing more to find out when
-		 * iterations are looked at one by one.
+		 * What is loaded from memory or returned by a call in every iteration is the same
+		 * kind of thing in all of them. One iteration tells what. There is nothing more
+		 * to find out when iterations are looked at one by one. But for what goes with it:
+		 * a call returns NULL and a flag is set. So a walk comes first for a call.
 		 */
-		if (expr_is_fresh(env, header_env->reg2expr[r])) {
+		if (expr_is_fresh(env, header_env->reg2expr[r], &call)) {
 			__set_bit(r, iters->fresh_regs);
-			continue;
+			if (!call)
+				continue;
+		} else {
+			__set_bit(r, iters->forget_regs);
 		}
-		__set_bit(r, iters->forget_regs);
 		/*
 		 *	for (i = 0; i < 40; i++) { if (i) sum += prev; prev = (x ^ i) * 3; }
 		 * It's not set in the first iteration only. That counts if the loop is not walked:
-- 
2.55.0

