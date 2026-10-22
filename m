Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634256;
	b=E+7ep9SZJoTNyHhwU6yP2nLjt4C4KOR9eGfVyOVNkfSWRAmlwXL4wSAzH28/5M7cU5wY
	 PFF6IYwyvlYP3StzWbY9EqeTAraQIjx6nmjDTLBkrkRX64ZGo5C0L+ClbKYKcMbBTlTQA
	 h/X6nVPrT3LUdGWclpYSdFzO5jvn+CvtbEeux1iIMFKx90A4Uk+kgID2g2blszMZf5nIH
	 Gj7mC5VyHoVjPiku1+k8dl3//3NrAZne6kH0JKWqrXLWAmx3tW4ALm9cBoBna+3g08ix+
	 kBQ+KMIzluvzC+40wHJVsuqUK6xPP52UbzGsXOk1ZPKBXjYWLKWGsmhQuha+WfPjnuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634256;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hzZTIl9xajYqJye47ARFhIH6S/mo0DE83iMFJBmKqCA=;
	b=S2ifdj78BjQW7SV3J9gbM6CNxCse8ZsZi3Hqk3a6/8uCcPuS0UEoho9ztkHlMU7ukBeB
	 MO6pqwKl7NNS7JyzO4vsjUwJSyOfY5U7543q3cO8U8E7PyGIk31lSYNjn7vXJb/JCbF2n
	 /OPBeXoVtwH81oKamWE2VkGNWQboCei2NJqsj+oRYOCd9oyyzLKK2bU2CjQsO7b94SMsM
	 JhodlAb4QgIJHmlVZH29BQj+AoVyFNcKplrXHm3Ay17Qxzff4mRPEP1m7FuenDK12bH3l
	 Y/RgSCc6ZHYEL0D3XrqP26X3WsYaeivPoOiZMA7SLGoxyJfBoW7Z6hLCVZQyNx58/bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ENH+XPCy;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD96606A31D
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 01:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAD96606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ENH+XPCy
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ada8bc2380so127455a91.3
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 18:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792634255; x=1793239055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hzZTIl9xajYqJye47ARFhIH6S/mo0DE83iMFJBmKqCA=;
        b=ENH+XPCyJctxYy0tq/P/dNgxodBKniOt72zMFjcHfl88zP152hyucaTU7RJZf4QI1x
         1VpGfRQTR9BMTIjq7PqmW4d78toRZTLTxsmwNZLt56CIZqKfeDGwd7/hVLiAQGUE9xLn
         F6LDiVHHO3801WBDL3nqEPo57ozaTFsl5oZIT4EPDiOWTd41sFl/XYF6hvSs1r9WurX2
         LXE4lsm4XWPQo2UgKi2+Q6LrGO/06MLbgfsSUUp8N/mlZQyiDVupLjeRTdemuXbfK63X
         mPm1iX4y2RdwuUMCaRNX4Slq5YKvU1lf3YRAFvofA1yVVeHpFoFuPQvpIr8zc8Z0+B7Z
         wHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792634255; x=1793239055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hzZTIl9xajYqJye47ARFhIH6S/mo0DE83iMFJBmKqCA=;
        b=bqtXKS4MCq3eyztronhkHlNf6GK+8D1Pfdn6qdQykUr5EY1p/Zv3LpdrT3l1CnFK6q
         Vvc+/hl/SQIPP24/is+gZ7eZefDvhAvt2b3FElDM121uWan25y9TKmBD3cDE2zYl7cng
         PCjqdygK4GkXZw4p0CtQAy+SHF88O5k8wkubYYLtfd9T+9UpGFoRtg+7TWBh++hHRwwq
         QejLv7r2e/K12casQVv7eXk20Gz3IdirLL8O8b6Mn/3zMcOEhmBMcVpSLIU6g7ox/SXl
         wprlka9neSWuHzb/1nSXVGDq9pEFvhKuTi5IxrsqEMm6TT+jXZFvAr8KWeJg3TCzcZsk
         pgow==
X-Gm-Message-State: AFq9FYJH4+ldblXz+2wNuIVS3anbsZoea4KuvZzjEGMEdN+ZVBqJCTVp
	3PtGvbVLeAW7/X1lfl7Uye5l1ai/U6R7W40uEP3VLkNMGbg9/9hbaeb0DK69gw==
X-Gm-Gg: AYBFou0YJ/3g4+TEJS6oSMUFufmb8as/QeAkHqoCox2aYkAJGbeyHYzMTx/HJMN2ASS
	8jQB/XxFN1DkhfeYNYqZYbHh5dLq9R+54YE/uC6g1tLfKyFtnI2G3u7wh8MZOkBnMH6EbuZals4
	WUZJz/ThO9KAHqsN33byIfa8qyYm3N8W0ul6eq+w6U7AX93YewFS7Bp+Nq/IT1sBuZktCCTUaNf
	9TWpbjKKZHsIbs7m7wk8LkhAXECdlFlYEGX9sDGnkpcYh6dzd77viAeYn7A2YtPUBL4b3vmY1WZ
	cCBzd/r3ZUPSBf9CPTXJn0zS2aZSwfcmnJmxhzcfSmKxWsVHeY0Xmc3+Pqaf3v08n/3nA2fSQl3
	bvk0oQWPErcOLKJHDWAJ9LygJK7F16WHjonQg3tn+sY2SOceOhAw/qc6nkTrtUnVFmP1qkl88RH
	66u6LGPGa5IFCB8DYmFsmANGGTfFJ2kCUZZEJv7pZA/qtrOQF573eMiR0Db+8NL/hKVacZ2GSS5
	DL03yUAFWCaXCk5w9LaWXQonnL4JDTNaguWfJV5bRBaAhlvrk3d7cph3vjaZOMwAgm3d4+UQuSL
	NHh48QTrAqEBB2wZAtkXI13GzhQRLo0eQ1WS/vGA0my2qirxmIXjlFNRcr4aLoq0Lkih64azyiJ
	C3KUEj8xPNo1rVydQvEk/7cI9
X-Received: by 2002:a17:90b:1dc4:b0:3ac:8897:7baa with SMTP id 98e67ed59e1d1-3ad86d4e4abmr2953396a91.40.1792634255162;
        Wed, 21 Oct 2026 18:57:35 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad85fa6b87sm2978876a91.3.2026.10.21.18.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 18:57:34 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	oleg@redhat.com,
	peterz@infradead.org,
	mhiramat@kernel.org,
	jolsa@kernel.org,
	akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org,
	surenb@google.com,
	david@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	hughd@google.com,
	kees@kernel.org,
	mingo@redhat.com,
	tglx@kernel.org,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 3/9] uprobes/x86: Finish an unoptimization which failed half-way
Date: Thu, 22 Oct 2026 01:57:06 +0000
Message-ID: <20261022015712.1297331-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
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

int3_update_unoptimize() restores optimized nop10 in three writes:

  48 8d 64 24 80 e8 d0 d1 d2 d3    lea -0x80(%rsp),%rsp; call tramp
  cc 8d 64 24 80 e8 d0 d1 d2 d3    1. trap new entries
  cc 2e 0f 1f 84 e8 d0 d1 d2 d3    2. restore bytes 1..4
  66 2e 0f 1f 84 e8 d0 d1 d2 d3    3. restore byte 0

uprobe_write() can fail with -ENOMEM, or with -EINTR when the task is being
killed. When the 2nd write fails the result of the 1st one stays. Byte 0 is
a breakpoint and it works. But the next set_orig_insn() doesn't find lea in
byte 0, takes it for a plain breakpoint and restores one byte:

  66 8d 64 24 80 e8 d0 d1 d2 d3    lea -0x80(%rsp),%sp; call tramp

Nothing recognizes these bytes anymore. The process keeps the call into
uprobe trampoline, which can be unmapped already.

Teach is_optimized() to recognize the half-way state, and let the 1st write
of int3_update_unoptimize() skip what is already done.

The failure wasn't reproduced, but the state can be made by hand. Attach to
nop10, call it to get it optimized, write 0xcc over byte 0, detach.

"uprobes: Don't sleep on mmap_lock under dup_mmap_sem" needs this. There
fork() removes the breakpoint from its mm. When fork() is killed in
the middle register_for_each_vma() removes it for the second time.

Fixes: 554ba38456da ("uprobes/x86: Move optimized uprobe from nop5 to nop10")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/x86/kernel/uprobes.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 65a2de82ecd2..62bbe41c6466 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -896,6 +896,9 @@ static int verify_insn(struct page *page, unsigned long vaddr, uprobe_opcode_t *
 	case EXPECT_OPTIMIZED:
 		if (is_opt_insns(&old_opcode[0]))
 			return 1;
+		/* An earlier attempt got this far and failed, nothing to write. */
+		if (is_swbp_opt_insns(&old_opcode[0]))
+			return 0;
 		break;
 	case EXPECT_SWBP_OPTIMIZED:
 		if (is_swbp_opt_insns(&old_opcode[0]))
@@ -1109,6 +1112,17 @@ static bool __is_optimized(struct mm_struct *mm, uprobe_opcode_t *insn, unsigned
 		s32 raddr;
 	} *call = (struct __arch_relative_insn *)(insn + LEA_INSN_SIZE);
 
+	/*
+	 * INT3 followed by the rest of the optimized instructions is what is
+	 * left if int3_update_optimize() or int3_update_unoptimize() failed
+	 * half-way. It works as a breakpoint, but to restore the original
+	 * instruction it has to be unoptimized like a completely optimized one.
+	 * The same has to be done if a debugger has put its INT3 on top of an
+	 * optimized uprobe. The trampoline can be gone already, so do not look
+	 * at the target of the call.
+	 */
+	if (is_swbp_opt_insns(insn))
+		return true;
 	if (!is_opt_insns(insn))
 		return false;
 	return __in_uprobe_trampoline(mm, vaddr + OPT_INSN_SIZE + call->raddr);
-- 
2.55.0

