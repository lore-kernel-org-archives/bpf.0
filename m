Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347B4347BAF
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772824140; cv=none; b=IsiDyt7bezAeo3+jBdEJD3BmpEAkI0SBSL1y8lWpkklzkSRetA0/Bsb4Y2RI43QR0TnpSOPT2jA0VaSGDas1X9xrvcIs0S0pjIOfjE7L9G7XB9BjyaPCp8zynU8wR2D9m1cU/FSr6WtjbK+ltYOJ9+nnQ031b/i4Eg5cnkeDfhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772824140; c=relaxed/simple;
	bh=qlACSX6hwy1mOHW6k9hLKXSX6Ovk+Qhqa4ZgwjT/JpE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i7bXJ0PXvKWQSfUNpDLVePMWkT9SR39kZx4zaz8kMAhwBUU8i8lKHX7L0tZe70z/uITQd0oL54fqN3oV4T73upWHn/IDVDMuMVFwxyjFwDqPQXksBV2aimXzxFJcoswt11vuYbyndQRhG9ECuHHSc2/KQ4JOUBmklxXxDkHGqkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRSTLjnl; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRSTLjnl"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cbc593a67aso905689685a.2
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 11:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772824138; x=1773428938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiL2MvXoPmEq5QF32m0XXHv0UJ31bcM+RTyi0t3M5Qk=;
        b=jRSTLjnlWA0/++GBWlbuOjodw/mTInAgFJz2+C8LZjloX+Zt5qh09X/CRa9bSTDjjx
         I3NA5gPrISzu0Rk4SOnzteH/VZOTE7lzZ36t9xeP1F9JJpwkjGnwm91YTnlcmenlK41b
         zdiL+AW+8XyR3gykaxzopJWjWlm9sGcNCd8lgjKpR1HLWMAVCyDZjtDRcTdx0zzWwQrQ
         cqlwufv8WE84Gu0OEgBRj/SBcRkD9603lGTgHok2/vCfqXnT7U6kYPmyCZNRgd2vHKY1
         gNkPjz8KKZVtfs/ztgF2YFNlep7OvKiSsmG6WP+I1K0EiGwSZTKA5cQAeDqh3jSZm0sd
         M1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772824138; x=1773428938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tiL2MvXoPmEq5QF32m0XXHv0UJ31bcM+RTyi0t3M5Qk=;
        b=cF8L4Su7Y0n/eyzPsSU7XQ2YwW0eiJ8ZBhkBz8n4KPJ682Eap+UFEzHWnc1br2PHnG
         lUfaMMxb6YrXo7E1riUll6vMur9RjjRXQxUK32HSGkebuTyvl2ZUTuPBs+0lrHEHC7lu
         nCeUviiO+Sq5rq4WX4t+oEE0EUxQ7xQI6Caq+PHrdvaGlzJNDmezhFGXG6WPvH42r+pb
         O5Fs9sU7UzPDyZ6PuJAjQrvMcoq3ZHYTRM6qXFNbg3G1lD2Pn75WOkqMqgIwRE1V9iMb
         Sz8HbGQ1xMtEaRYBYjpVGsoh+6VP6dCPjEFzeoJNkog7bxokuuUOkQBuWYLHDGx7iEkH
         WaoA==
X-Gm-Message-State: AOJu0YxQbRGXdKYxgq5/gdE18SPiAiOy6lf8CInm0bYsuvIpRq2TMrO5
	wtC56LPDcgUfOFzjJKkhnpuf78bybYTxJ2J0HELJkUpkUiwGMPAiQUs6zHqcwj25
X-Gm-Gg: ATEYQzyFQ3mrqga/QwBBt9NO7h9RDTbaIjxyL8fny0ZLKdD+jzIObNuaacWZU3unv0H
	fsR2uSEaDnVSG8RTVg+X3AdfuBfr/LU6k8Y15pXDzI4qxBzfxUb2/1cQy4Y5tCgVJu0nSBppJvX
	omrdfm90idjEocSaf0gxwOsdnpcqRm8n9SnYCnO2+3J0G8aYOUV/GIGn7CEu3xSOSsMnymi9jyg
	H0Bvd92EAbeGszHuQ2Ei+4urTQHVwQ3rvt8ldu9HLXcMLslnDqZGylxi+8JfdzY1zdWiCyPHLg8
	ZV9ZyzhaZh3RBYwaTpiT61LJijJujWJx+3MQec166oa1uDKNUp9YJGFgidQmS92mz2zqBF/urHR
	Z3IKe1OIwLoYLlwBZuN9QY9Edt4qbaMra2nnM4FAoJFGBLBoWRFTGxMQdEYXyYBfhsrJpkWRIdd
	GZ313WQ9e4Bi6z1Y8E3sQcXODCtIdVgVxAtIOZKIhvA6ey
X-Received: by 2002:a05:620a:31a0:b0:8cb:66dc:9fcd with SMTP id af79cd13be357-8cd6d454b7cmr411990185a.56.1772824138000;
        Fri, 06 Mar 2026 11:08:58 -0800 (PST)
Received: from 192-222-50-213.tail19a0b.ts.net ([192.222.50.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a317187c0sm20322976d6.50.2026.03.06.11.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 11:08:57 -0800 (PST)
From: Jenny Guanni Qu <qguanni@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	lkp@intel.com,
	Jenny Guanni Qu <qguanni@gmail.com>
Subject: [PATCH v2 1/2] bpf: Fix undefined behavior in interpreter sdiv/smod for INT_MIN
Date: Fri,  6 Mar 2026 19:08:54 +0000
Message-Id: <20260306190855.937198-2-qguanni@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306190855.937198-1-qguanni@gmail.com>
References: <20260306190855.937198-1-qguanni@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF interpreter's signed 32-bit division and modulo handlers use
the kernel abs() macro on s32 operands. The abs() macro documentation
(include/linux/math.h) explicitly states the result is undefined when
the input is the type minimum. When DST contains S32_MIN (0x80000000),
abs((s32)DST) triggers undefined behavior and returns S32_MIN unchanged
on arm64/x86. This value is then sign-extended to u64 as
0xFFFFFFFF80000000, causing do_div() to compute the wrong result.

The verifier's abstract interpretation (scalar32_min_max_sdiv) computes
the mathematically correct result for range tracking, creating a
verifier/interpreter mismatch that can be exploited for out-of-bounds
map value access.

Introduce __safe_abs32() which handles S32_MIN correctly and replace
all 8 abs((s32)...) call sites in the interpreter's sdiv32/smod32
handlers.

Fixes: ec0e2da95f72 ("bpf: Support new signed div/mod instructions.")
Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
---
 kernel/bpf/core.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3ece2da55625..663b9af6d19b 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -16,7 +16,6 @@
  * Andi Kleen - Fix a few bad bugs and races.
  * Kris Katterjohn - Added many additional checks in bpf_check_classic()
  */
-
 #include <uapi/linux/btf.h>
 #include <crypto/sha1.h>
 #include <linux/filter.h>
@@ -1736,6 +1735,12 @@ bool bpf_opcode_in_insntable(u8 code)
 }
 
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
+/* Safe absolute value for s32 - abs() is undefined for S32_MIN */
+static inline u32 __safe_abs32(s32 x)
+{
+	return x >= 0 ? (u32)x : x == S32_MIN ? (u32)S32_MIN : (u32)-x;
+}
+
 /**
  *	___bpf_prog_run - run eBPF program on a given context
  *	@regs: is the array of MAX_BPF_EXT_REG eBPF pseudo-registers
@@ -1900,8 +1905,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 			DST = do_div(AX, (u32) SRC);
 			break;
 		case 1:
-			AX = abs((s32)DST);
-			AX = do_div(AX, abs((s32)SRC));
+			AX = __safe_abs32((s32)DST);
+			AX = do_div(AX, __safe_abs32((s32)SRC));
 			if ((s32)DST < 0)
 				DST = (u32)-AX;
 			else
@@ -1928,8 +1933,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 			DST = do_div(AX, (u32) IMM);
 			break;
 		case 1:
-			AX = abs((s32)DST);
-			AX = do_div(AX, abs((s32)IMM));
+			AX = __safe_abs32((s32)DST);
+			AX = do_div(AX, __safe_abs32((s32)IMM));
 			if ((s32)DST < 0)
 				DST = (u32)-AX;
 			else
@@ -1955,8 +1960,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 			DST = (u32) AX;
 			break;
 		case 1:
-			AX = abs((s32)DST);
-			do_div(AX, abs((s32)SRC));
+			AX = __safe_abs32((s32)DST);
+			do_div(AX, __safe_abs32((s32)SRC));
 			if (((s32)DST < 0) == ((s32)SRC < 0))
 				DST = (u32)AX;
 			else
@@ -1982,8 +1987,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 			DST = (u32) AX;
 			break;
 		case 1:
-			AX = abs((s32)DST);
-			do_div(AX, abs((s32)IMM));
+			AX = __safe_abs32((s32)DST);
+			do_div(AX, __safe_abs32((s32)IMM));
 			if (((s32)DST < 0) == ((s32)IMM < 0))
 				DST = (u32)AX;
 			else
-- 
2.34.1

