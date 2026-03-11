Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8829F355F2B
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 01:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773191479; cv=none; b=NyMIxHu6JWDn18bYfImkBMu+BtNibCuvK6Cis06aZQWRWZiEn8P4lQa/ikXzWcU2RBLM6qC+aM7EFiaY1ZOlbyEtZtDcjyWcw2iAEZzPRvAiHLxBxi95AnbXDmgNmX61KJHHpGGoM6kgPsbS20oE9isMNDr95v0CixLRQ8r+S7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773191479; c=relaxed/simple;
	bh=etwn8hxQ+XoGAGoKkiHBQXvXjZMQoQ82LCUjI51o7GI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=go5Yra37kfeyVVhMB5p03uqyAq98yXt2vw9KJn85APVRYrG9FwL7xKdUevwFnedN6ZUjJrlvhuDfuuG0vpUe/CtO8GpxtzOJXt2lhZ0ANYSaOSDAT7EAwddcwvTzTmOLpy7kcypSvMMUCUldlOHpsEyer51x39q1sGrpBvU2cbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyRGkSmx; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyRGkSmx"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cd751a4e93so266216885a.0
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 18:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773191477; x=1773796277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlbeJYh8momYD3HijrkYjlt/aimqrdYqPgRQzSFZegk=;
        b=fyRGkSmxs6F9a+Ft+F7RcPLVi6x6MoI0OQICMMOqonnJezXiAWlcPJZi8ehDyQbMHs
         ySSH7EesvueqY1cTykY5HDECD8JHwc1RlxuGmjEpAqARGv2/OiTScqFJDKHrIwiWwtEn
         BK2P0hFs1DCT50DJDby8ktNB7+Z80GJBhHXR83fySlW0XqdBk3c/Prw/w0PYfygCV5iy
         zfPkJULGoOU83Z/kot5jcqtyaWFGbLV2wCl+xTAfPX7OkenTMoC06vtUvkEKdr9R/rgc
         DHoYveUfBsvTtGqu4AedunigLOxuD5NHGVf73oboOrgFAzyN2UScL7SsIqdlYaHV+imS
         aL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773191477; x=1773796277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AlbeJYh8momYD3HijrkYjlt/aimqrdYqPgRQzSFZegk=;
        b=R6B1itmY4w9MKz6oaFhMLRp5diHaSdTX/BioUPcSXN3JXIf++Y0A//HDOKJHAn7NGP
         uSsjXrUj2i+Fw5jOcLWF2We3qgpvE45Su9mKGpcuI9OFlZhFEJ1hyrjcvNk4LJp2DHwP
         ZAQlqs7UI/TL5aTe5xZH03v/AoaRwka4r4hilPN7cztmooJlK7wwafsvc3dqkdSdOPuO
         co66SgRSCMvwb2l0DQwl6G/qbqxQbC5dbHJjvZNCYvRb0fS5ZInnWIH0SqNY6uxqhd5J
         MNshIlri/KQ5rZ61cDjvWL5iIAzWI5sPyumocYf8crjcoJbqWD3a4x7vrclnk2FKsN67
         6j4g==
X-Gm-Message-State: AOJu0Yyr3WYt1HgWJuGzTfMccyKt8h/UDUKW4roPOPiwcoU9ZUJU8vMm
	0Cz5CRCZHMjhz9P3qiz1MZZBJ4Zg5GpxweZZK49f9lgu+8tfqX7fNQR5HlcVMMm2
X-Gm-Gg: ATEYQzx6WXFnI6zqiIyRdcOyzyuGYRQDBH1gP+d9z+w9KRIEQ+SqFLbR7AwLYkVAZqe
	nwDS+hJ0pstOrt4oY10xZ7FKLPgWWh0s/hBWJDDi50XiCwLucRRnSFOIBv0VkF4+ZifHAdixCOh
	D6Y7ISmzAyMgl1PvtrSviSIJRlLwGvu3P4nG6o0XbFHetiu+gnJ6kqorPCXf8nIHUzaiZ72752p
	pb/WmO0+kFxxb3i8fy1cUpq9DDI3gVOu2hnKjruxbDEDth031BJ/nWrFTV6LQFBUPaLrknMOG7x
	MIcJsWHgYh1SvPVg4P6cae4dmcD3/a9IVY5ahzDkARv/Tgw9EykSFsPnNKybH7I85xVQgR+AcgE
	b7PkLuIaMFLMQiciWKeqNWLe8gzys6Eo/1xHW+HyhW+IXu1wXF6kxnVuNveGO34lwXEFVM4NKpK
	2nJbd1Dg6zvRDThMnuiwXZrw3BF3yb+BTvCw==
X-Received: by 2002:a05:620a:4055:b0:8cd:81cc:556e with SMTP id af79cd13be357-8cda1a2d878mr124448385a.40.1773191477478;
        Tue, 10 Mar 2026 18:11:17 -0700 (PDT)
Received: from 192-222-50-213.ll.local ([192.222.50.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda2148400sm36451685a.39.2026.03.10.18.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 18:11:17 -0700 (PDT)
From: Jenny Guanni Qu <qguanni@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	mykyta.yatsenko5@gmail.com,
	yonghong.song@linux.dev,
	jiayuan.chen@linux.dev,
	lkp@intel.com,
	Jenny Guanni Qu <qguanni@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH v5 1/2] bpf: Fix undefined behavior in interpreter sdiv/smod for INT_MIN
Date: Wed, 11 Mar 2026 01:11:15 +0000
Message-Id: <20260311011116.2108005-2-qguanni@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311011116.2108005-1-qguanni@gmail.com>
References: <20260311011116.2108005-1-qguanni@gmail.com>
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

Introduce abs_s32() which handles S32_MIN correctly by casting to u32
before negating, avoiding signed overflow entirely. Replace all 8
abs((s32)...) call sites in the interpreter's sdiv32/smod32 handlers.

s32 is the only affected case -- the s64 division/modulo handlers do
not use abs().

Fixes: ec0e2da95f72 ("bpf: Support new signed div/mod instructions.")
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
---
 kernel/bpf/core.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3ece2da55625..3e2843ffb098 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1736,6 +1736,12 @@ bool bpf_opcode_in_insntable(u8 code)
 }
 
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
+/* Absolute value of s32 without undefined behavior for S32_MIN */
+static u32 abs_s32(s32 x)
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
+			AX = abs_s32((s32)DST);
+			AX = do_div(AX, abs_s32((s32)SRC));
 			if ((s32)DST < 0)
 				DST = (u32)-AX;
 			else
@@ -1928,8 +1934,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 			DST = do_div(AX, (u32) IMM);
 			break;
 		case 1:
-			AX = abs((s32)DST);
-			AX = do_div(AX, abs((s32)IMM));
+			AX = abs_s32((s32)DST);
+			AX = do_div(AX, abs_s32((s32)IMM));
 			if ((s32)DST < 0)
 				DST = (u32)-AX;
 			else
@@ -1955,8 +1961,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 			DST = (u32) AX;
 			break;
 		case 1:
-			AX = abs((s32)DST);
-			do_div(AX, abs((s32)SRC));
+			AX = abs_s32((s32)DST);
+			do_div(AX, abs_s32((s32)SRC));
 			if (((s32)DST < 0) == ((s32)SRC < 0))
 				DST = (u32)AX;
 			else
@@ -1982,8 +1988,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 			DST = (u32) AX;
 			break;
 		case 1:
-			AX = abs((s32)DST);
-			do_div(AX, abs((s32)IMM));
+			AX = abs_s32((s32)DST);
+			do_div(AX, abs_s32((s32)IMM));
 			if (((s32)DST < 0) == ((s32)IMM < 0))
 				DST = (u32)AX;
 			else
-- 
2.34.1

