Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749356;
	b=bEMi5Z48oHmvHILDqfsXi/IjbXbnHZgbctJiplTXXs6IraPrVfvdh29P4/nfsd769+Uz
	 63h8znUfjd6Dk3A83sEGzFxkLPc1jJS3TxG2vCCSQXVhBW1sKopDFBzUzD3h6kIQJ9h5z
	 TEFHu0I+knvfi6KwciAzAh4CmQ+gsdBKf6UvVMndCllqzENUaqHSCQXoWd3hfffn87W0o
	 U8Hu86hhx6hvPmmcYDtXt5DTUQkucUsdm+zxEpPQt57T20cAEOs6+REN1f1b/IidD2C0M
	 jsQRWkc0BRmncZQBwKOKPTLJz1h0nP41VbCRk6ailYK0ZZeaTYjMGv3H4JVvYZzZP8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749356;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=v+PziHyA8HzvjRryNDbG10BjXMFqBF247hX+pWLKP6g=;
	b=KUB9JukIT5j2EzKRxny4pBqIfNiMBA7WjwbDZumk6vPWS27IuLJtvjBO1LXJX7c2ylgN
	 d+RQkvw0rbF1IayrRN/ctNxMOBeTp2e+fGChv0nHTZEcKvsuaN3B2XJhV57IPqHw40HHb
	 8HnkeDh0lfQ6lyJCg8153eZVKEcYehBJ1MkGbOKcJ6ak/dEY9dkAya9uPDUA+yKso9J5H
	 eHmK1JquKSXRB5KvF8u0LyOwuRq9ZyjwGTWn7R0xnYMsJydN8C6cil4a3J15MwT8c1nj3
	 /8yb94KY3Y+2dII79VI9+ho4Jt14GjFNyed0WzHiDa1J5Ozifgf3nc0d+4VtK7uU+OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wgO06VLV;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DB2606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48DB2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wgO06VLV
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so94396a12.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749356; x=1794354156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v+PziHyA8HzvjRryNDbG10BjXMFqBF247hX+pWLKP6g=;
        b=wgO06VLVtADJz7tjL96LF+D5Yyd48pNwQ431JK6vx7WGLLbj39v/KwUXR7zNhhIRLy
         UPprcFUU40+XslaCaXkGP5kg3hhYf155N+Mz5wyi8riourO0Nq+xgb82rPPjaXf08pHY
         waCGcXbpBkUIbqOVLKdDggHsJu0igtALDDQZmStgugE6PamQL7MaBTkelzJNvFkdd0Ld
         9LwLkaQaZU971joQQn6FsmR0f73+0zVHohmiUq6z8XqnEokRYkb4Pb39qUUakoB0xAqw
         PoetwyUuHTLiKutg2JkiYQzUNTVxnWgAPFl82Q6ow5MzJdcVmxCen4t+FGk+zeTiz94B
         OKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749356; x=1794354156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v+PziHyA8HzvjRryNDbG10BjXMFqBF247hX+pWLKP6g=;
        b=ms2KRod92llJPsukKxmrgBHZiYe0ML9+HNy8P7HJejhWMdHaaEbatTko3SLEnOq8or
         TjN4e55aa1m9yHvz9soRlP1yiScl5cUeJA6+vcrg7ptJUdktbbWioKj17kMj8/6cC9bz
         c0Q4t+gn4oqz57iKIKs7tMf5s233IgzYdS/HvSETt/Fs8h38Beoynpn4MUbRzU+PALUJ
         Khcn+baW5lhni+qOdiwFQdlKmSPuAfWLM/2B6mokBZi0FmoT5XtrMW4Gim5Q9MtPW2Br
         0KIgC/Dt2VUxnNvLoZivxsPhYiVITRepPVmXsCT1vBkMn5IWuXr6A3vu0G4kRRAg3hTo
         e6Tw==
X-Gm-Message-State: APuU4Z+cfFDKNvfaWFHk0KQvpyVfVFnZgbaxeZHjzloevwspmY7R42Ou
	nJXztyQU+z4vhk1Ba/BjVFR1bUkKP+ITz+ru1CKOocozZQm2T6PrABNMhbV+VA==
X-Gm-Gg: AYBFou3XpP+R1ml7wAPFRxuGM1qvlsuqXUDl7VltRNTSkhN+b5Aaf1pkdP349KfOoAu
	dosG9I/dQe/aVoPM/bx2tTMj/Nwhm+puOOxmAkN46eq/X5qnW3N7dPhHVjLeRCvDyntUeuFyIYq
	Yhmls2BpfwRzVrxP9K2ZDDzH70NKHoeeESgBCyV6rAccWW20Yk6L3ZBOxR1XT6MD5e/3VH0bqMY
	k9JBHfJMG0d0NQhiVwiLogjLuq3wCRiKMr2mVI2+IFrxTRnd2IOJJPBWqt9te3zv/vqF4KyVY6r
	UyduOXIHvOTceTtY4Jy9GjyPhWu820MKFTam1UMBeXznWcVuRQ3ABHCIfsm+Dwsa/QuxHjnzaGi
	LNvn3t2Ec0RigwlyBnM0a/pZAcNlPXATVFKWgqpeTay0ta2BETHp3FkqHyxbD9Skr+z79enK7vc
	vVRDw/Vl+G0L4jw8kzQJe4jxcGgvHVyMN+LgnzaFZCu1Wk7LN7YQ4OJt6N34QJtPJYKV6Uk3cKp
	ech17U+r8qUyEdu8M16xmLImqer8U0h25jgM/1HEtV4jsZUqwvt4q8f8U9T6psumlNTI6ENmzQO
	3P/EIHl1lFs+G6plUUpqW/PWuBLSFHAvuqTAQZNEGB6ab20hRlvaj2dXXQeYZfwT8ZEFkWX9TPb
	0olv4hvOINwcjnueSLRuOXK+Kizjo26GnchZbCLyos+lOboxwHQHsvylTqpUpI2po15MYX6CHbt
	I=
X-Received: by 2002:a05:6a21:6f11:b0:3e1:860a:73f2 with SMTP id adf61e73a8af0-3e928f728c5mr13642044637.32.1793749355450;
        Tue, 03 Nov 2026 15:42:35 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb46981369sm273113a12.25.2026.11.03.15.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:42:35 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 15/37] selftests/bpf: Test sums of constants and shifts by 32 in scalar evolution
Date: Tue,  3 Nov 2026 23:40:40 +0000
Message-ID: <20261103234104.208239-16-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
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

 - Two additions, a subtraction, two 64-bit shifts by 32. The tests expect
   one step and the count, and run the progs.
 - 5 pairs of shifts that are not a zero extension: one of the two is a
   32-bit shift by a register that has 32 in it, which shifts by 0, one of
   the counts is not 32, the shift to the right is arithmetic. If scalar
   evolution takes them for a zero extension, then a read of a register
   that is not set becomes dead code and the progs load. They must not
   load.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_scev.c       | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index e6251c21b474..60b823876eaa 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -1621,6 +1621,59 @@ __naked void latch_base_differs_from_step(void)
 "	::: __clobber_all);
 }
 
+/* Additions and subtractions of constants are one step. Two 64-bit shifts by 32 are (u32)r6. */
+#define ONE_STEP_TEST(name, first, body, jump, expr, ret)			\
+SEC("socket")									\
+__success __retval(ret) __log_level(2)						\
+__msg("  r6=" expr)								\
+__msg("loop header at 1, header_count is 8 ")					\
+__naked void name(void)								\
+{										\
+	asm volatile (								\
+	"r6 = " #first ";"							\
+"1:"	body									\
+	"if r6 " jump " goto 1b;"						\
+	"r0 = r6;"								\
+	"exit;"									\
+	::: __clobber_all);							\
+}
+
+ONE_STEP_TEST(add_add, 0, "r6 += 1; r6 += 1;", "< 16", "(+ r6 2) / (linear r6 2)", 16)
+ONE_STEP_TEST(sub, 16, "r6 -= 2;", "> 0", "(+ r6 -2) / (linear r6 -2)", 0)
+ONE_STEP_TEST(two_shifts_by_32, 0, "r6 += 2; r6 <<= 32; r6 >>= 32;", "< 16",
+	      "(zext32 (+ r6 2)) / (zext32 (linear r6 2))", 16)
+
+/*
+ * @shifts are not (u32)r7: a 32-bit shift by a register that has 32 in it shifts by 32 & 31 = 0.
+ * If they are taken for (u32)r7 then r7 is in [first, first + 7] and the read of r9 is dead code.
+ */
+#define NO_ZEXT32_TEST(name, first, shifts)					\
+SEC("socket")									\
+__failure __msg("R9 !read_ok")							\
+__naked void name(void)								\
+{										\
+	asm volatile (								\
+	"r7 = " #first ";"							\
+	"r8 = 0;"								\
+"1:	r1 = r7;"								\
+	"r1 -= " #first ";"							\
+	"if r1 < 8 goto 2f;"							\
+	"r0 = *(u64 *)(r9 + 0);"						\
+"2:	r7 += 1;"								\
+	shifts									\
+	"r8 += 1;"								\
+	"if r8 < 8 goto 1b;"							\
+	"r0 = 0;"								\
+	"exit;"									\
+	::: __clobber_all);							\
+}
+
+NO_ZEXT32_TEST(rsh32_by_reg_32, 100, "r7 <<= 32; r2 = 32; w7 >>= w2;")
+NO_ZEXT32_TEST(lsh32_by_reg_32, 100, "r2 = 32; w7 <<= w2; r7 >>= 32;")
+NO_ZEXT32_TEST(lsh_by_16, 100, "r7 <<= 16; r7 >>= 32;")
+NO_ZEXT32_TEST(rsh_by_33, 100, "r7 <<= 32; r7 >>= 33;")
+NO_ZEXT32_TEST(arsh_by_32, 0x7ffffffe, "r7 <<= 32; r7 s>>= 32;")
+
 SEC("xdp")
 __success
 __log_level(2)
-- 
2.55.0

