Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885BF36D4EA
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773093553; cv=none; b=ISYlkORqledHzxLAaHiB87ZhmbL3GGv5nimRdWIambqA1D64fakZ/7p824NITdeL4YzBgCcMiIlwRa5zmwXj8pgEVFxBpqE8gQDLGrUgWHUe1/FjzNFRmPW6i+kddni8wpCjXE/20s+BXeyza8lZ4ZA9z9YOerkyyC3gFCgAdAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773093553; c=relaxed/simple;
	bh=XYfYOzNWAUDV32+wmzra1pO2YXuWbR5KifJnkftPnDk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H00iKU1NhwQ5VsKhaJeOxM8pt/AuIeUYCxd5BEXDZgN5jIdPQ5b5PwjhCxZcdIFBBAilaZm3tUNbu0I0bNsgzG0O6XNRf7Vx1LZnu8HVWWE15Tj/fxAw63/yHqIEiwh/smOaPNm1PRPFomsGcWFpCiHasFPBXNxW1bUKcr5XBgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lv97NG5M; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lv97NG5M"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-89a1347051aso122702976d6.2
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 14:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773093551; x=1773698351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nEY1nfRW57PWSCcXKanJBTKNEGGoM8wfSdsz1hDi2s=;
        b=Lv97NG5MChAH1lzepSB+q4KUv6hDNIscQWbJx7ZsZJKE/htdOeP7zvSx6vl3mbdUlO
         sJJ7Ckn+n3EkTuTutxDqM/WeoM71fOw/LxWnPZsPAF7Twwr7R3VmXUvJg37uzDasduhp
         RPtXwWhMxZwWtnIFTQAtF/FplsOsHmJMR+zatXuWBK8RJd5rxCJ1Jx7XDvr5U2YCZ9oU
         ekAfpmMykbhUifWxIFNyvmxXc0MywYdjiX90/b5TMhk+qasuKOJ5VIdzIGX7lalSIacU
         W9+pEmCLM71HbHbRR+lTM8oRByYLdTzBy878HBxLODvb7TwwHjNzT/d/xe96qhPWESUK
         43hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773093551; x=1773698351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4nEY1nfRW57PWSCcXKanJBTKNEGGoM8wfSdsz1hDi2s=;
        b=KB2lCGsHXKyt8v85fpUKeQ0FflrPmdnO/ViiFFTlDzNB1ChmthdHTVmnWKLGg+tJhN
         MMq6vL9wCnEPenF2kS6ZDDppr2/CQCb4Yf7nG/HS9rqGvKwF+VdhIYmbZfHF7SdNo1Ce
         tS2Rr3JzlVW5Jkoh9h9ZhIlJpoZELM9JqzmRUhw0TnCGi0WKDMdt7FWMAQByIg2QzDC7
         kUSxC3MaWngs3fkifspb4tUUDXQA/KUCBX9c5eyzqrkMuhPOMpqQg/fT4w2h+Tl2w+9P
         HSax++baU21oU+L1C5Nl/7Y53SluQxwyFgH3othSw2wOHO2zMA6Ij4ABbyOtT/rK9M1A
         XvLw==
X-Gm-Message-State: AOJu0YxVHajF0G9pa3ahATX8EZw6DUxm8jIk8Zxtuo6WoKRIVxg70kFM
	sJ8we+j5nSmNDgxcAoiv+0ia3pk4FIk8ull4lSvoGGvHaQ+p8DDINCfzl/OQks5a
X-Gm-Gg: ATEYQzyzNP7EF+nsZwCOHYKFv0iPlB5fch8WZoaZvX1FS60Df/bApZuOxLeCWEY0GyV
	5VmCK7XYuxHKbMVOwqNlUa1fT5yRKd7yhD3SHK8J0yamQdcMaMg7BJJorQw0uqghiRSAwugjQQW
	Z+z3BEstRrR+/Y8WcWHT6jLpe6lSGEZpaRml4yZHh4TlOXnBD+2b7Y872E+/b/ksD7E4G2OIwSt
	hXdI0zDWmO/3dnW1YhQ+E6jaRJSdhNoMCwGo2CDUeRDHjUe7gdx8Mboa/1WoUA4MI3JpKb7U608
	EfFpCOxILqKGOFPlfaZh0xfN+NfJxXey9yQ8UKTYRkCu2jSvhwiw3T5BMnfuf3ko+6kDxAUMgOm
	bcEFjptRiHiJbNr0BRU9J395KLQE3Y4Rbt6ezoiGmiOC6bCTS7YUwf3OIcMNgx1Lx2AtsJridOv
	GCSHzXZpcUMFRcAV0feYWGB7eU6bIN9KOKsw==
X-Received: by 2002:a05:6214:5292:b0:899:fa7f:7155 with SMTP id 6a1803df08f44-89a30a2f357mr188788576d6.5.1773093551494;
        Mon, 09 Mar 2026 14:59:11 -0700 (PDT)
Received: from 192-222-50-213.ll.local ([192.222.50.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57c34a59sm6134856d6.45.2026.03.09.14.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 14:59:11 -0700 (PDT)
From: Jenny Guanni Qu <qguanni@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	mykyta.yatsenko5@gmail.com,
	yonghong.song@linux.dev,
	lkp@intel.com,
	Jenny Guanni Qu <qguanni@gmail.com>
Subject: [PATCH v4 1/2] bpf: Fix undefined behavior in interpreter sdiv/smod for INT_MIN
Date: Mon,  9 Mar 2026 21:59:09 +0000
Message-Id: <20260309215910.4131143-2-qguanni@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309215910.4131143-1-qguanni@gmail.com>
References: <20260309215910.4131143-1-qguanni@gmail.com>
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
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
---
 kernel/bpf/core.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3ece2da55625..a620d4d6f567 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1736,6 +1736,12 @@ bool bpf_opcode_in_insntable(u8 code)
 }
 
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
+/* Safe absolute value for s32 to prevent undefined behavior for abs(S32_MIN) */
+static inline u32 __safe_abs32(s32 x)
+{
+	return x >= 0 ? (u32)x : -(u32)x;
+}
+
 /**
  *	___bpf_prog_run - run eBPF program on a given context
  *	@regs: is the array of MAX_BPF_EXT_REG eBPF pseudo-registers
@@ -1900,8 +1906,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
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
@@ -1928,8 +1934,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
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
@@ -1955,8 +1961,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
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
@@ -1982,8 +1988,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
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

