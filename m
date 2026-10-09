Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EBD4CA28B
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542935; cv=none; b=FkComnsW7/fQ+byUswj6RK/W+p09JRpwECKVj7dfZfQsvvl1OhwfnfifYE5jXAQuJQv6kEgQ8AzzrFQX19R2yyrTEmCTVu/Ve8hbn+c/FcbWfPwtdM+Xr7tJKKtJHyuOg+z4u9KySCw0XXyKuT2awtvQmkxuw6iDdCNxsMdiyDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542935; c=relaxed/simple;
	bh=xkrC+Y4jVPlkvkZnDpEA6iV72nVEtBfJtdDK8kY5jhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m4LPgPBYb2UZg39pUjT2t6YGU9aD4IndSJNLBWITnU2PodAR5DX8BIxeSpUFSiyyQz9XD2G0hBy8G7nHE4j4PWhGHCRXm2ZD7qz0gD1+8dEurQYj0h7PAqfHJmsVrMa2D3hWdlSgn3FcD4wKzZcc0xA8QczGIUU82obPhcD/m2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQGLnmNs; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQGLnmNs"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3a02551822eso1374739a91.1
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542921; x=1792147721; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BrMLDIMrZWokS8TNhrYInniTae1NmAetXK3y9Hw/tEY=;
        b=iQGLnmNsFkNVxErls8LbdfCh3bABH7dSe4egW+gYW3lxGHMQMqpLy0d23ddhEKu1Lb
         gWhYM0R/1NaV6b6LZ5JyJ4beu/X14ncofzsjci39tTwOAgFQQIFPpYJMhtLjM9rtGTUd
         Hn5CyrpZK/dxy2f9OqLoh7A/Pe1N2HmeoU33XlGCP3866cWz5gY7+THnmWZfSOK1ozlM
         YWSUAJXBN9e26lONgOnrU1UG7S0RqvYxbgAI+RFPUY9cstd7qI/mLLcTtreRl6qTTm4T
         oi4ml1JkK78GZgCymEy1v8lpkK1LZ1D1JZ1WDb1r/KepgaCOVtTk+20ShnnOXMibB4AP
         G6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542921; x=1792147721;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BrMLDIMrZWokS8TNhrYInniTae1NmAetXK3y9Hw/tEY=;
        b=M092huSF8DthLtmIUu3rLsYKC0MFB5YUpR+qH9reVkNwG9WN3fjY0AhWVtR61Un0DV
         egSI7c91ZsGgKCs0Yc6mDJfEfSj8CUarmOMBlABxgvOwQTCNsUYrlHW9PXSLj6Eandgw
         8iNNqmAJkGCz79KNgJVHr7KXQ15rnIes0zxuearmvn/ACCu0WUhiVtd7vZZU8zcOULFl
         99u3qhpzxeb3ZZqjF3Ij4I+WdsERgUi/W4e8FbnFOG3RVuQssHuWyvIfm17J5wvl0al2
         k0+LJ8awMqOKbXFFAop8r1c3nrSI8eUlq8xPrnDce0IN054T9WON5ZIHqO13/EKCSAKP
         wnWA==
X-Gm-Message-State: AFq9FYIO59ChePUukRabyWjv0OUoe8Dq4Hj5rKb4N7WIZGJ4954iAUlp
	huvPViYQk6WPE+d9If3twkorWcbiUtJqRutSoM+apC7HFW2Rllzruq4TVbbzC3HM
X-Gm-Gg: AYBFou0R5oeflPzz6oGwli1kylPjjH6y+7/SR3/fMqVcLJ0D0K/4IQJfLGDER0fAyMk
	BTrIhd/ydT7X7SJ6sEjIPipFChFwQ0iBTuR9koscYqLw/28nUD8CiuzihL5ZoRsyVp07TBgHwnt
	HBO5gTmWUQ6kfamcmkZN8p+YijsSwx4JwIP3Tt7GVDZB3IwlP7Zd3xwVhaEqEP48f+jVQ65TBkL
	UdR9WowwksrBwhO23+0ul/JZyh2NUfBFRFEnl6f28eiaDdsNRNbNZt+9WB49L+qenKueDepj/0K
	Ew/lraWwTfuyXKXqWzeJ9gKuDZZwH4xKicsldz+W/dDXTIM8L2YiRDXyMiU6Kgy9QpgY2JvQWp7
	MsbbG0EAQS8Wg+AxwtMzp+A9oLc4t59mIaApjSidrpYDPyYvrKBEtwRQksh5hOYqgGJNAfB7poe
	7CU5Dxfm6+kcpi7MuleIuyWSOvxI2plZS2KYop/4/1zkWZluGnp/nCSJtxlKyNZheWUgL2b7buV
	SDQZCfHV3ep59c=
X-Received: by 2002:a17:90b:384b:b0:3a0:295e:6e61 with SMTP id 98e67ed59e1d1-3ab3a953717mr885510a91.12.1791542921508;
        Fri, 09 Oct 2026 03:48:41 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:41 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <ezingerman@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 31/51] bpf: record basic-block ends in insn_aux_data
Date: Fri,  9 Oct 2026 03:47:49 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-31-bcba9bc53ac9@gmail.com>
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
index 7fb1e315de48..1458e50a1ad1 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -741,6 +741,7 @@ struct bpf_insn_aux_data {
 	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
 	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog percpu alloc */
 	bool arena_scalar; /* ldx/stx/st/atomic through a number, it's an address in arena */
+	bool bb_end; /* last instruction of a basic block */
 	u8 alu_state; /* used in combination with alu_limit */
 	/* true if STX or LDX instruction is a part of a spill/fill
 	 * pattern for a bpf_fastcall call.
diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
index 8a6dc805e559..2568079c2945 100644
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
 	u32 *num_preds, i, s, len = prog->len;
@@ -54,6 +69,10 @@ static struct bpf_iarray **compute_predecessors(struct bpf_verifier_env *env)
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
