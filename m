Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983909;
	b=ra6CCrGTjzGMjIK2JrepA641XpzYS8s3b79y4bXE9cndNOLzS6QtroXa2JYN4Zdc/0uT
	 D5TNEbbPwTAmzhDIdx+W2qcbO2MNSFSQGMflDRQh8rZjJQxsKldHlsOeN6hB6ceIcIjIX
	 0j+9dNFMiDirkz5SPZISLu6XKe6BQm90QTs7Nx7L7imDnlWiTcw5PaFk5Hj8/BOFaFpwI
	 cODJdx2kwpY+nWvIP47LQeSPBgHDu/qTV75nSnVfNugfH+YsMl/hKkWJA7UkkJQZ+YP32
	 9ZhQprDm7x+0mOLgmT0f87Q/GqnWpRbNw6rz9wPk/WYqv6o8b8DLn352oOxKIZuQGyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983909;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TuYwCzzOhMVm6EYo35DQ/9RsEF3sem7OfEv6MU0QIos=;
	b=FLd4101ZG6P6x/Nkr45WILAk86YznD2oefmHRHkreF6uJVudg7ohdAvAWOk49v1UxP/Y
	 cPG0LJ4Z+GbY2wbbFKfq+41DM3GGOXfUr1z0H6zSHQ/utifA5O64Nm4/y34Tc+fJA/+z8
	 DparzlzUm1UtkrE4OM7B1RhMcYkOOI1nmKzSIH94wAU7Zm+vAgW7XAqhIprBW/+HJ99Dr
	 G1CenhUw782DEdrGbAEwDXJQbKPtUSHCp2F3rbLpKA4Zz/NkhqI9wMLGXpYXcNfIhgF2F
	 4CWlJS64rwW86zybQj640/Ph/5NuUEXZcWycBlQ9RkNqeiiw+LL4MMKDdpEubDuCVvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ooYh5Ocs;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8072F606A31B
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8072F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ooYh5Ocs
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e99b1e5b4cso13410175ad.0
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983909; x=1793588709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TuYwCzzOhMVm6EYo35DQ/9RsEF3sem7OfEv6MU0QIos=;
        b=ooYh5OcsceW+HkUuUL94Rt/pNfzoetGFhXZlAnTWPKFQf8aOG/HorLTiMSJPmlD28G
         y7PdjX20F/4hGTI5mGwXGh5AhfNKvBYuQ+4Ws3ulha4wDr7jy4mWB2rTkk4SvKOM9lus
         yxlOu8TWCEa/RlcAxgmJCiwz1RpDGmGUiOwkXydjwiSAJJhVz+Qd4/f3KLvWMzkdtQbz
         Yl1jYmqMtOBdrjFd1cOCMuZpDvHUwPAxk6h0dlJHyBkwCmC4g2emU+bGCcj2ROXpVIHB
         fSHtRNCUp7KBaUst97oqg/ui12ZS1334m767PYhPWqc/9IR7x6y6n8nmJ7mNp7HQoWkj
         c06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983909; x=1793588709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TuYwCzzOhMVm6EYo35DQ/9RsEF3sem7OfEv6MU0QIos=;
        b=gbfes64lPP41iUo/D8V7ondA+xkLOVglHgfHtY10mGEMf2QDyKrzb4Q0ncDwocobji
         Oc25FBQT9wXeAswIpP5ozOE1RvHwi5J3AJnr7eF8E5c6SYBkixyMO+PLrxPys7nRJfFq
         tbhYJ+L2tfElJnkrsrXdWAFtObJiz5gm8EtJtaiA7CnVmGk8MIT36jrM/u+1gEOTzYsa
         aA1l9okXzNusLk5OUYasHlZcMdmJIsfbJ3GdpwADUTb508bGZ2bopVdrXALxOLsHWW1q
         SFCWCJKKcfLeHJcfM+ZETBQOA2WnA1XMiJWnishVUyykH2zkCNTCGAHb3+pDgz7a+IRh
         wN2g==
X-Gm-Message-State: AFq9FYKnuFKBYw8sAiu/0o6jnn/6oK8Y64LoJB9Ng1DqQeOLXcYL996C
	2Rri/C1KsEM4vCMzxN06OIvdJWeO7HckSjL8PqTgR+KfGDj32WlCoIWaUvgkEQ==
X-Gm-Gg: AYBFou0gMBN5eapZkR7hE+TwomSe925KyOVjfHWDz8R2JPbZxvD35s87/HrrAvBAgjA
	jjyHOOGZKctgd1Inmx+sGAlZCEozHDn+fDm79qbCl2O6c5pXsJSdJ3GdKvwu80LkmIRsD3yKt9d
	jKkcERNr1HwD7HXPiiVqDNpyEnoEEpVMHkTrTLzBnl9FtABZlymsAHRoPN0yhenvc3kUkRjznE9
	6Y2dmMBP08+0DzXLB971E0e0aw0y+WJmuwy7G2l47Opnkvj2yaoxBdGCXPrJjU3kIvztTltZU0T
	Dp+liT5sNhSEg5ARNNAqP+QUwnei1tFWLAAyAlfGJ7XUSlNaOcReLj6PywiGK2FiQdjZAeAHmnJ
	M5XNrkvS0OKSxf4Uv5pbZn/gqi+BTU+A6Lura+ksuqCtO0zkDw8tG7IhfOn7Vs6PliyS476uxJS
	7CWNgjaYnctuHnlzYgn3uOmNj6VOVaeB6PueN77ctz0shTAMiAbUkJwfF8Qlz+x9AkexKYf8jLD
	gfCyK3pl7WGijrcXpp78jb+s3ZjHWBQ+8VfYZn6vQUuVkh5H1JcgV/8EC/kJNTBAfslQ3D94qTP
	eZnIXlmLys1OWgvlnSnJbBqipf023b0SC+MyuUtgqD/d9CmvbiT9MzDR8i22ta58klR36NRe+xA
	tWvqi7hmZj1TH3XQeyuutxQPT
X-Received: by 2002:a17:902:f64e:b0:2dd:c100:80ba with SMTP id d9443c01a7336-2ea9c9858b7mr47637795ad.53.1792983908756;
        Sun, 25 Oct 2026 20:05:08 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a2676sm10342955ad.50.2026.10.25.20.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:05:08 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 55/81] selftests/bpf: Test a static subprog with 24 arguments
Date: Mon, 26 Oct 2026 02:59:16 +0000
Message-ID: <20261026025943.404450-56-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

A prog passes 1 .. 24 to a static subprog, in r1 - r5 and in all 19 stack
slots. The subprog adds them up. The test runs the prog and expects 300.
Thus it also shows that the JIT has room for each slot.

The verifier must reject a store to slot 20:

  stack arg write offset -160 exceeds max 19 stack args

The subprog is in asm and its prototype has no parameters. Thus no test
covers BTF with more than 12 parameters.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_stack_arg.c  | 95 ++++++++++++++++++-
 1 file changed, 92 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
index 5062c5bab5f0..42c241ebe796 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
@@ -359,10 +359,99 @@ __naked void stack_arg_shared_store(void)
 	);
 }
 
+/* r1 - r5 and all 19 slots. There is no BTF for it: what it takes is seen in its code. */
+__naked __noinline __used
+static unsigned long subprog_24args(void)
+{
+	asm volatile (
+		"r0 = r1;"
+		"r0 += r2;"
+		"r0 += r3;"
+		"r0 += r4;"
+		"r0 += r5;"
+		"r1 = *(u64 *)(r11 + 8);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 16);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 24);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 32);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 40);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 48);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 56);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 64);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 72);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 80);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 88);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 96);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 104);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 112);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 120);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 128);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 136);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 144);"
+		"r0 += r1;"
+		"r1 = *(u64 *)(r11 + 152);"
+		"r0 += r1;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("stack_arg: static subprog with 24 args")
+__success __retval(300)
+__naked void stack_arg_24args(void)
+{
+	asm volatile (
+		"r1 = 1;"
+		"r2 = 2;"
+		"r3 = 3;"
+		"r4 = 4;"
+		"r5 = 5;"
+		"*(u64 *)(r11 - 152) = 24;"
+		"*(u64 *)(r11 - 144) = 23;"
+		"*(u64 *)(r11 - 136) = 22;"
+		"*(u64 *)(r11 - 128) = 21;"
+		"*(u64 *)(r11 - 120) = 20;"
+		"*(u64 *)(r11 - 112) = 19;"
+		"*(u64 *)(r11 - 104) = 18;"
+		"*(u64 *)(r11 - 96) = 17;"
+		"*(u64 *)(r11 - 88) = 16;"
+		"*(u64 *)(r11 - 80) = 15;"
+		"*(u64 *)(r11 - 72) = 14;"
+		"*(u64 *)(r11 - 64) = 13;"
+		"*(u64 *)(r11 - 56) = 12;"
+		"*(u64 *)(r11 - 48) = 11;"
+		"*(u64 *)(r11 - 40) = 10;"
+		"*(u64 *)(r11 - 32) = 9;"
+		"*(u64 *)(r11 - 24) = 8;"
+		"*(u64 *)(r11 - 16) = 7;"
+		"*(u64 *)(r11 - 8) = 6;"
+		"call subprog_24args;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
 SEC("tc")
 __description("stack_arg: write beyond max outgoing depth")
 __failure
-__msg("stack arg write offset -80 exceeds max 7 stack args")
+__msg("stack arg write offset -160 exceeds max 19 stack args")
 __naked void stack_arg_write_beyond_max(void)
 {
 	asm volatile (
@@ -371,8 +460,8 @@ __naked void stack_arg_write_beyond_max(void)
 		"r3 = 3;"
 		"r4 = 4;"
 		"r5 = 5;"
-		/* Write to offset -80, way beyond any callee's needs */
-		"*(u64 *)(r11 - 80) = 99;"
+		/* Write to offset -160, way beyond any callee's needs */
+		"*(u64 *)(r11 - 160) = 99;"
 		"*(u64 *)(r11 - 16) = 20;"
 		"*(u64 *)(r11 - 8) = 10;"
 		"call subprog_7args;"
-- 
2.55.0

