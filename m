Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2BF3ED11D
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 18:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773082640; cv=none; b=UMvlH6Nkqzwr/LNwihAVrYBwi+F/yKt+4HAbA7we/jI6iFeJjiaGlApeYp5yTNYGGdgaruOKZSYS7YhLR3Vdl0MGamjxDkGwXnRe/GTWWWlyyEKjmm/1k50LeL4uklqZVFydVG1HDt7LA4e8u0gpYFIo3cTxGm454pvcCK+yZOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773082640; c=relaxed/simple;
	bh=UEgh5YFQFzihdOp6J7lzVOybSz/9PEDpjajnlEsyUyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i5fSy3tCK4iZ8BL7AdeiRfSbND1Pf0nj6ZaRScDmBlMjDB1PhDeoDq5xflvoGR1EDijfurEc270m94GdKM4AU2TYVyge2Nj/vYltaMx9NspWDDOFg4DYQFlkfQDhB+boA5Efo0duY8BdVPzcuf/LpHfw6QtVnwpCqwdFPLhoHxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMdtPW0+; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMdtPW0+"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cd785a8783so265816385a.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 11:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773082638; x=1773687438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLUY7SXueOBdS7QDPSJNB+Wrjg86kA0y9gkvnAnLEfA=;
        b=VMdtPW0+5bTAgtBu2llUrdrtVNRjwfwLoV0Srhr8QgZSeQNVP9MQpO6USu8/9dUqaZ
         HkD4X5LgSE3cMrqvtyDQXfXDhq4lCNkXZPW12SmUbs8Lb5Ne+4Lv2rxF/qtrZkkGVz6v
         XRcPpB5U/tCYXvCKR0nPE55sTckwgF9Hpz6MQKOqdIqkHCe8OUohieq7XxXV+cQHWJk3
         G3ROYkzagcFjPKavzWOP6aRmgyD6lj5vyibPlkooL9iliOQ0I/HYo7bxLPOHITp4nxyw
         Pto0/lycYTDPVjy9wPFdhQ07z73LjrGNpwv7KaZJeRURtVv7qvKxOSCTXrX8XEYOcrj6
         W6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773082638; x=1773687438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KLUY7SXueOBdS7QDPSJNB+Wrjg86kA0y9gkvnAnLEfA=;
        b=PDIJgTvUE/tqTiWqnEPfB2s127wLRbUZaThGN8tkNbFjMya90G1oxE1QUiVgBC1rgf
         2Rr0LFHi6ISuBrcNNfBHjIEQRMOTUhVRbuv+sYz8sa1oWHCzHiH1LIXLeaMuTe67XfdS
         kvgetznzZ83aR6XE+cN4vIbg8fcmmUStTjs8YZf401CcA8KnekC2ebkojFh4AkWBP8Ao
         XFEDRvLXlR+lbTWXMOqbVok3M+dvdu00LXTDaGwSGZPx6PWsjkKNygn3ZkuBHjDFb3WF
         PDlsh5cmdvVT39glI2/FSBmyzW6Q64HoiPzKjmcnemsEcBONqCBoV8/WA2uxA9YwQ/Ck
         +iIg==
X-Gm-Message-State: AOJu0Yw8eQ5MUXuXttuLkBsi1DinhIcT6wFGITlkXowZraUOOUF9DhTx
	th5oiol+peGHpOMRgqi2eKRCqb3Ch6lbh8RUzcKK7kdg1SN6dAib4NHLdtjOR3+R
X-Gm-Gg: ATEYQzxE4r0shwazMjMLioWy1hVduJRNqCFsjkpcH7w5Q28I/wafZP7yumzzYdhbAhd
	HctptM26phHBp2kRi60OVenA8l+mFtONWceECO1zcryzmpqv0HVZdlIdsuOY/LeXiIU5ugt0MBM
	NFtgZr8wtFqs5gI64o1cYPWqqUH8x8hoS2dihq9vj+ylwzJBvnGWUGxWb+aVMqdOFU4CtuVWckt
	4PDtsWprOKzhF6bW2hQHcrQKU5hmIy56tO4/PXpciHiyLqGtJ5t76GSiOMryMtbPirmDouLQ1O8
	2JYktCykzc5q6AnxiluJkDhMcKoJcbJk8j2l77756DPra6YL7UBkY6eS1Nghyhd7OMcVVf2yMB3
	LoJ0srkHw6mam/g6/08lBlowy6QRRpAhFvUzQeZUY5v/wrXAmhUmvUd9S5WmVJuvK6Sa38wequl
	h6tvTOXCcrGIDSywzGpw7dO1x7nDbbyhUfDA==
X-Received: by 2002:a05:620a:bca:b0:8b2:74e5:b36 with SMTP id af79cd13be357-8cd6d49038amr1686852785a.68.1773082637923;
        Mon, 09 Mar 2026 11:57:17 -0700 (PDT)
Received: from 192-222-50-213.ll.local ([192.222.50.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd90aae2c0sm117876185a.27.2026.03.09.11.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 11:57:17 -0700 (PDT)
From: Jenny Guanni Qu <qguanni@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	mykyta.yatsenko5@gmail.com,
	lkp@intel.com,
	Jenny Guanni Qu <qguanni@gmail.com>
Subject: [PATCH v3 1/2] bpf: Fix undefined behavior in interpreter sdiv/smod for INT_MIN
Date: Mon,  9 Mar 2026 18:57:15 +0000
Message-Id: <20260309185716.717894-2-qguanni@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309185716.717894-1-qguanni@gmail.com>
References: <20260309185716.717894-1-qguanni@gmail.com>
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

Introduce __safe_abs32() which handles S32_MIN correctly by casting
to u32 before negating, avoiding signed overflow entirely. Replace
all 8 abs((s32)...) call sites in the interpreter's sdiv32/smod32
handlers.

Fixes: ec0e2da95f72 ("bpf: Support new signed div/mod instructions.")
Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
---
 kernel/bpf/core.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3ece2da55625..0bee54db03c1 100644
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
+	return x >= 0 ? (u32)x : -(u32)x;
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

