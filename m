Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749724BB5BF
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446684; cv=none; b=VKhcmoi/g4a6szgfwD6wyv0cRf8FolYX+8M2Fb9uAKevJ+8wwaU9Yf8QMz5XMUgDwArwQsGfhg8dLifWZPFaVwbbBviQfsfcoxBycEoKX4WafF5bQZDFSBBN/dmHaUKzZztaHv3QCTNcyHpMcVuT/ge7+yiN0ocWcrb14VnpyLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446684; c=relaxed/simple;
	bh=CLMyV4Q+xmelqsbypbkxqvm+TLdeTFKmu0iBp3AHWb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHXJ84v80lc68tx1rW0rSHE2qNhBFyXLFTZOTBFum0mnPXNgeMutG7CHgsxYQtpW2eo8i8lUHMmqjeTR/l0RG1/kd/4JSX6mGdjY8FFb771rzCJWGjAllydbXUgx4MUv/2Zn7vw1ZWKqC1zc+2Gq/5VqSqZxw3tjuu/Maw1HOZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdlWs0fg; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdlWs0fg"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495501e57beso7760155e9.1
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 07:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788446680; x=1789051480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NdaXSpttLhygDCWQxix7LiuXex/gDXEYiHMoCaYDypg=;
        b=AdlWs0fgEPCxMd0SJWR27EYUqNsh5roxMBIQISfUt3ThyoYUwappEIgKUDqk91BvGI
         z+q5ch2KYT+w7ZsBJKu6SYUeOkdk9qArQ4dQOK1zDX6+H04ddYZyOH+os8bR2oiSETKv
         EVvkz+sZC1YhTXxI68DPjnOeRas7XpcdG/EjApk/xC9u3cmHqUCwenF5tC94RJCg4B7U
         C54HFSWAEv6eSwgoKaaTkoyB+Hh2zDvIOMxoohZcVYIX/mMyBV4Hwp15OVzAlBfCgxFr
         3fY4JXlGrzUd39iKsLoiuUNvjEuZY57sEjv6Ddlx8EKHK9rbs5vQRxG3U3G85QthGRgS
         l38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446680; x=1789051480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NdaXSpttLhygDCWQxix7LiuXex/gDXEYiHMoCaYDypg=;
        b=FR3Eo7airOVJqLX2Zv009OzVQVxPcGza/MpDKEZmUZexaZUiime29O5FqonldOI2Vm
         LKJjurtp8BZjWSv67lAE/PCu7O18fGpZdpVgfLo2+HuAGyFubXBlGVg3u/61MWpAD9II
         KlSGPgI179eUEKhxGlXBagkIxrkmQB0/PgUPHSkL2Ty4r2JTF0FtekCsNYPFYc1Wzu9f
         jCnZBeLxnYQajxRUu0CTmDNoi70mT61vvWxvunDnJPhY8RZFnZLi8DT9NqMUeAYp0bIg
         WLGFa8E+Ar71DfX+5PLctwKpY7quQhrTdFKAuReouBqcVcN+fM0gn+/hBEgPznxjo2wX
         148g==
X-Gm-Message-State: AFuF++niXyIIfllZoRQx2eAEQSWciGVei3kiXTiQLdDtpFUDJQFAlaPX
	hTUhzALTU5FzQNee85WNNRxgJg3Svz3xcRsYy2AKHqh2neq/gNvun+xsLD8NQ03d
X-Gm-Gg: AYBFou24SQoLFFG8DB89UiYIE/tcZkTaYN1Mkw+O0dxnmBQJjajP/K15Uvma8JcLesZ
	c2G8D3GmeSTwrDmodTe26dw9nKXFefGIleFzb7njj5fRY3NUKHCnCwNg1QC1RzPoaE1k6MpcVx+
	IpmIswBSop7lXOZfdJSq/2BNVaVYcl61kWrvjjFFpdm/ZjnHrUIalk0uMiMHy2PtIOAUefZoz90
	81YXZTeX8kfTF1R3KFXVzqW/mFGXMtgrx+kJ97s0bCH+ofwt5nNAx0m/HAYK0DeGOtXgoo+IRHS
	xtfcjM4ilH+d8n+hH1ipwDp78qPyW8UY3BKEW04KfcGB1TxzPExdhgPUc50N4K7mL42q8g6kQzi
	IHj95TXH3Ye+f4NdH+QJ1kVXLj5JlOMWQj4iKWUGt8CuFMHnai3Qd167PyZJ4iHNMfQzoq0sI3Z
	BJ7d85RR3Mqgtoifu3LuCo1kKjpcTgiKJc3ynQig+or3RzNBenwFQ+K1cwxmi6C9oKJVC4mjPxU
	wUXmg7i9vId54oeO9iDWcT8UVIHNM11UVgOSz6MKsNiASnVNTDU2MwG+cG8Yk0P9fLw2sJ9XtYG
	SOw8zp95RM6iSbozpN8e86q2/jA=
X-Received: by 2002:a05:600c:620e:b0:499:51f0:a9b2 with SMTP id 5b1f17b1804b1-49cf5b9aac4mr12334035e9.1.1788446680178;
        Thu, 03 Sep 2026 07:44:40 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5f912esm76657115e9.4.2026.09.03.07.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:44:39 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 03/10] bpf: Reject tail calls directly from callback frames
Date: Thu,  3 Sep 2026 16:44:21 +0200
Message-ID: <20260903144433.1716731-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903144433.1716731-1-memxor@gmail.com>
References: <20260903144433.1716731-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2150; i=memxor@gmail.com; h=from:subject; bh=CLMyV4Q+xmelqsbypbkxqvm+TLdeTFKmu0iBp3AHWb4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtm8wTh4xPFdY13HdZaXJdibjDxoqha/qH8Rh8Vj+rXR 7Or/+zuKGFhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwET2sjD89y1ZnivAup3r03PR jVf/zpSomC+x5Lij3rQdv3hYWdvltjD8uHf6VIrjtOUTG7n/mjgYfL3fPPFSiItC/wk1vq8Vy+L 4AA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A tail call from a non-zero frame is modeled as a return from that frame.
The verifier makes R0 unknown and calls prepare_func_exit() for the taken
branch.

When the current frame is a synchronous callback, prepare_func_exit()
enforces the callback return-value contract and marks R0 precise. Since the
tail-call path synthesized R0 rather than deriving it from an instruction,
precision backtracking reaches the callback-calling instruction with R0
still requested and triggers the "callback unexpected regs" verifier bug.
A CAP_BPF task can therefore cause a WARN and an -EFAULT BPF_PROG_LOAD.

Tail calls reachable from callbacks are already rejected later by
check_max_stack_depth(). Reject a tail call made directly by a callback
before constructing the inconsistent return state, using the existing
diagnostic. Tail calls from ordinary subprograms keep their current
behavior.

Fixes: e3245f899043 ("bpf: properly verify tail call behavior")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7d8ddb1bee00..f540279ff4ab 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11228,6 +11228,17 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		if (env->cur_state->curframe) {
 			struct bpf_verifier_state *branch;
 
+			/*
+			 * A taken tail call is modeled as a return from the current
+			 * frame. A callback frame cannot be left that way because
+			 * prepare_func_exit() would apply its return contract to the
+			 * unknown R0 synthesized below. Stack-depth validation rejects
+			 * this construct anyway.
+			 */
+			if (cur_func(env)->in_callback_fn) {
+				verbose(env, "cannot tail call within callback\n");
+				return -EINVAL;
+			}
 			mark_reg_scratched(env, BPF_REG_0);
 			branch = push_stack(env, env->insn_idx + 1, env->insn_idx, false);
 			if (IS_ERR(branch))
-- 
2.53.0

