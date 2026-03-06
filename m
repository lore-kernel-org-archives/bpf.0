Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BD7369984
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 02:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772765765; cv=none; b=a5IgBcN1RBV3h20A76dqb7haLs6QKZoPx1ivTrlQyywtqi7PNVIw9lpo/ZkleOcoOBcz4n887iW+M0VufsiUww3/96lfP1J8/kdbwRsof4YsmC76dTcBj6sXx9DKPk/oYERnFk3NWhtK3ooUByIFxb1pj/wSpmjj0DtKW8p7uqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772765765; c=relaxed/simple;
	bh=g5tWww3C7jgIe3HFMcTxryN2P2xW2b1JUJN7ItNBZfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GdDNUeC6QSwHzT6iDrwunbbz4wnCy60QQ5igWekaWrOwV8i/AWlRf+VAUBYNE2NtH8r+6gJXBEW2xV4qBZB7Boii33mYLZCn7h0mLFz6oC0qzJv5zuvN8LNq915c0Z61x/3YelJCNW73f24CbgfvttCiUPPa81Rxm5s94hJMb28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISzsj5yO; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISzsj5yO"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-89a1347051aso57607326d6.2
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 18:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772765761; x=1773370561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmxMngkUA0BIJJYQrCq1n1d4iCTUNF75QEgmDx21FYc=;
        b=ISzsj5yO1BRQqWcbjxCoFuXodmMnGH53csZH5UZd9/u/OenHYmem6k3WCuzHe6FVYF
         gxvSW2lOq3RdXE9Zq0A90qRG58EBdej0TiukFFxa8cgakaaRmdu/cGs8sOlyYZlhZyN8
         I7xDw8Ku2GxttPx7qRRO/k0vfcZ43sTYR6vDBIvr04t50Jw5262XAc7HkdcuUQtE9nua
         NVGiBedhiqlMtz+5nJBE+YfXMDO2hQc4tShCZiSVp/HB80soAbE51rEEhsVu0LuUo8eu
         h6vuD6QybpDGZyEavsx2E6D+i2tNYR1tiKRU7udo4JtB4vGoeuMgd1Nv5Tzg0LnVrW+O
         hiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772765761; x=1773370561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fmxMngkUA0BIJJYQrCq1n1d4iCTUNF75QEgmDx21FYc=;
        b=JPKCwx9HoHRWumlmpTz26PNf2mMKNgmNV7lql1R05O5zhCYmep2/cNYEiusEdAQdu/
         k7x65ogs81xZA9yI3EbftIrGywd8R5/4wpHNfXYIo+GoiAE+1gOWdvhJTvOmj0krT+PA
         sU5ojkbiC4NmIvE58OoYDqJnhoT6jVKrF4xGujnUjE5WRLU7GqHYlkgD6H3pGnR/5Pw9
         EqKpobqNdpe4F14iUVHZPXB/pTkfZbAZEbo3ca5rmxOWHjX4JW4yUlPaq1W1swcV+I6L
         fPffyN+Y9oCTfWLevwam94FMVZN7r+yS7VAvb0GEgGgtgU4wwc7QDCIVjcpIL+oNYFpp
         1/oQ==
X-Gm-Message-State: AOJu0YxKDzvXE+DP5qhpETWt6X9OPubdW2SVCIAWHiXrdcPbNIvy6FpG
	oCk3IZqsnLl6ZmMnyjPm4mKrW/IWMwdZOOy6vkULYpnwllNQrqGZ3rijvg4/q0T8
X-Gm-Gg: ATEYQzwEza++H/9SgFWaYXrp+qde3VVF0fZX0AZVRKNwyoSP02RFgTKs4cQcWViUbL5
	JsJS5jkaoLw1euZkkytT7UTPEhgsn3a6u0JpwycCgnX02hw0eLHXo4UTNEIuSvpEwcJqKVIJuWA
	TRpf6zwEkOY9QdgWWQOqPaq/00GoSeKIUdnlB01Web84EL2D/LaVFjw3tSXzpCQx0nAaUqPKE4d
	Hid329pqPGoD35N9azF/4g5qPqZCde04BOH68/SdAx41/kko5J0b3ZOAzn9fZ4wIDoE5nMIgxTP
	GhlODJNOQLWCek2syLby01ga8D0Vg/vYWqJx0b5JuqPQGmIL2RoMNTFh7Sn6K8RuTjGUEFY77eu
	K47LAXBqNVpxNj7d1KhjpHGZ+1NWpcwOmCSoXWeFagJfnjqCP3OC7tvbUnu3O9b/aClCWO5wQrC
	EcQe1amiubX/nKWXNc/r6KRCSBVupF0fzE3fBtFwig8NdS
X-Received: by 2002:a05:6214:21c4:b0:899:ecd9:22be with SMTP id 6a1803df08f44-89a30c36ff6mr6340776d6.67.1772765761511;
        Thu, 05 Mar 2026 18:56:01 -0800 (PST)
Received: from 192-222-50-213.tail19a0b.ts.net ([192.222.50.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a3140d9edsm1628806d6.7.2026.03.05.18.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 18:56:01 -0800 (PST)
From: Jenny Guanni Qu <qguanni@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	Jenny Guanni Qu <qguanni@gmail.com>
Subject: [PATCH v1 1/2] bpf: Fix undefined behavior in interpreter sdiv/smod for INT_MIN
Date: Fri,  6 Mar 2026 02:55:59 +0000
Message-Id: <20260306025600.870163-2-qguanni@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306025600.870163-1-qguanni@gmail.com>
References: <20260306025600.870163-1-qguanni@gmail.com>
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
 kernel/bpf/core.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3ece2da55625..564d523689bf 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1745,6 +1745,12 @@ bool bpf_opcode_in_insntable(u8 code)
  *
  * Return: whatever value is in %BPF_R0 at program exit
  */
+
+/* Safe absolute value for s32 - abs() is undefined for S32_MIN */
+static inline u32 __safe_abs32(s32 x)
+{
+	return x >= 0 ? (u32)x : x == S32_MIN ? (u32)S32_MIN : (u32)-x;
+}
 static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 {
 #define BPF_INSN_2_LBL(x, y)    [BPF_##x | BPF_##y] = &&x##_##y
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

