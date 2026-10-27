Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793127844;
	b=Ku7z6brWC5+8lRCacacoH5zDBmsa/hUfaZZwNG84gd8zqQuILel9OsiVhBKK1XRdzF8K
	 +8K2Fy3JXis0wzBr5pq0kDydCXVVrqBuSv62ku6iHKvI0XYbvLI/bfuaa4CF693ktxUGR
	 ZryRIm7HKBJJ/uPEI/SPJASwMBRtl4blonaT1E+50YEEFWNF+/ldhLnVdJ8AmHVJ3TcL+
	 4KNfOB8rIoHWbzTag9PvqUbQzbLPov58dlNqRUNh37loaw10j43lPFubQggfYRSc0sTGn
	 TOyH1z2ig+nJuFZiea2Pm9OLPwBwQixT1aEG7G/jX8pvnEIkt+88bNWilTXqxBWRv0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793127844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=t7P7qL7zChLOKO9yVF60aiPyF28SO2IMjxp8PRCA7Ko=;
	b=C/YdK1YRp++tnN2jgp4gGDdahUVRC7+Q8j4xO1TP010uu3jrtsOpwI11Z5KNUHBWyGpD
	 VsZl8KBljEImCIGN+AahS+wPDKDYCxsNVPHQt8M34UKcqSFD3Ac1uPYYKquyrbDOnijR2
	 I/O5oACy46Jy3Y9Ql47Asu607WqqXKMnmqXJUfEfDGil360sJm1L7GcSVHtp1Z99zSsNA
	 /HpnkRsezRNdxtkY7VroBDB/k4gzQX8HvVVygaSgs7a0Kvl+3sEv0Oa4nHMVJEI3vy+T3
	 cLD8wKyHJ6cWO8CoS5lm0cBe8S3dGMv2yMcPSKlcK6/dJOXAmVp2RSd9Ocjm4NeEgvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=teqQ9FIE;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2F0606A330
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D2F0606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=teqQ9FIE
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e9d7791b00so1096845ad.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 12:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793127844; x=1793732644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t7P7qL7zChLOKO9yVF60aiPyF28SO2IMjxp8PRCA7Ko=;
        b=teqQ9FIEOsToVvAIFgX8LNZykiEdZnWGE9AU+Gky/wqsIS64jKUI54hD2VWBcykMae
         QVyUlRoTCiZvmZxNexkvpxO064/zSNshiQD6U20KQvS95eX18lHFwYkimUVhmxOpk3P9
         CnKlz7NNjeb5vr3eIl4Zlp9JGTD4zzclonH0LNUEi/+xoyoc1QBYAIjHDGeHyARQ/krl
         mtJS40RGVEgRWOYGC7uZ3shpCPVCdL13UBjKDoUsFjFEZR73V/trRe3KGmj/ngr3jTxi
         Z2tWRcc/YxL78H5/MgB6XSsJcAag95WYYNW77fMG8NW/3JJ52iQTbUr4DfgbxiFDkrUE
         TJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793127844; x=1793732644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t7P7qL7zChLOKO9yVF60aiPyF28SO2IMjxp8PRCA7Ko=;
        b=0bFCxum6c5wn4yZVAIka1ZGVUVNl54SzZYJP08dclPGJh1kPq6iNJMe4nRJEGyL5UG
         o3ftcG9bOi+pLrfVFZH/MjUtlogg1pNG9eBeD5nHuRO0pVEQ9wkIBflYDHJBy9QjqQZa
         IWkwDx3WdZbvOK/QZzVcqJm25R0NseUwlFvjwr3/ENhvzgolEheK32KdBh+9alkyLvb9
         m1OPPZAZpc1sL147IduinEiduN22/BSKROvgwAa7QjuUAYj0HFH357z5a6lMm5G2Altp
         Rx+RFYDe04I8yT4D6X8kBrfI6HzAiPKfiVyTOMZL53jW2RAr2dAozBjEQhE+80oawelj
         jpNA==
X-Gm-Message-State: AFq9FYLpGpQwhh+qBr/Tr2PYkFgDHULq/O3ZCiDiVf17qPbScI5PqM6h
	emDo2Jt+b5OJbRUYrynqzvihfxl+YVRkRqTfhF0PYRiRNIuKeKlvo4uvV7Luow==
X-Gm-Gg: AYBFou2twZqWdBL74j5Gocj7Oe0MESBEZ9YTdYEhbz9B8uxi5TYpVnoa49H/qLk50lj
	ipXP3/pdBq7gKepHhahmIIeHAlMquzw8niYzRcLudud3/EtvxOt1dAfUxqenf4qCjUXM26Fzgul
	pZshUE0ofGnciwWkz7Ux9MX3tUiCNPLY99MpAr7HXTEDAPMVI2ThDFaoCfBrFu4sLMHuwPvLnln
	OxCtbs+fq6lS59TWekFfK5nEXtg2k/3NAlrb59EUbA42qToP8Y7Ne/u1ptwvfwKdU0qgvGX0GEy
	UDxA3ZjhXeh/Kd3OHMGMfrIMW9ocAEGmZGNxlgIeZqL99Zvz3rBmGfjgOeB8pVjCAq7MMDycKZg
	s7WdXGkHIcjJSdI6uRwpmsVBK5CmGTrC412HU25EJK/e9LU4gYMeA9GoHAJM0Iv1gO0O+AcqLQh
	w6JUAafoQgbcMeXZrGI7AKg8gOXuhfQJZCZhjh1d8/DelPvcC9qCotYD7Tacdqzsw2QC4TA2tsB
	je1y+bcltknr7SQwn7CS3uRubBL+FHY3O36YlSdD3QKwNi/QrwjmcVQ9mao9F5sGu17ELJZQDnp
	tXbCY8LgokkT5WA2bw8o/QeScHPh0oYJepi/bH1qF9BhTlF8VvwBR44Ve7M6+Xesk+tkrlamX64
	VnNi0pxDXGQhBzZXoGmFTRdgZ
X-Received: by 2002:a17:903:2990:b0:2e9:5059:4468 with SMTP id d9443c01a7336-2eb00128ddcmr2710815ad.7.1793127843588;
        Tue, 27 Oct 2026 12:04:03 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdac68402a1sm2303407a12.1.2026.10.27.12.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:04:03 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH v2 bpf 08/19] selftests/bpf: Test that a widened register is not linked
Date: Tue, 27 Oct 2026 19:03:03 +0000
Message-ID: <20261027190314.1440199-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
References: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
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

Scalar evolution widens a register that has delta 4. Then the prog copies
the register. With the stale delta the verifier finds that a read of
uninitialized r9 is dead code, and it loads the prog. See
"bpf: Clear delta of a register that scalar evolution widens".

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_scev.c       | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 37434efd1490..ddc9667bb078 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -1377,6 +1377,40 @@ __naked __noinline __used static int probe_read_stack(void)
 	: __clobber_all);
 }
 
+/*
+ * r3 = r8 + 4 is linked to r8 when it enters the loop. Widening drops the link. If
+ * it leaves the 4 behind then r4 = r3 + 1 is taken for r3 - 3 when r3 is compared:
+ * r4 <= 7 instead of r4 <= 11, and the read of r9 looks like dead code.
+ */
+SEC("socket")
+__failure __msg("R9 !read_ok")
+__naked void widened_reg_is_not_linked(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r8 = r0;"
+	"r8 &= 0xff;"
+	"r3 = r8;"
+	"r3 += 4;"
+	"r1 = 0;"
+"1:"
+	"r4 = r3;"
+	"r4 += 1;"
+	"if r3 > 10 goto 3f;"
+	"if r4 <= 7 goto 2f;"
+	"r0 = *(u64 *)(r9 + 0);"
+"2:"
+	"r3 += 1;"
+	"r1 += 1;"
+	"if r1 < 2 goto 1b;"
+"3:"
+	"r0 = r8;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 /* The unknown SCEV of an unbound STACK_MISC slot must not prevent widening. */
 SEC("tracepoint")
 __success
-- 
2.55.0

