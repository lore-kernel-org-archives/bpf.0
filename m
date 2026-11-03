Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749321;
	b=AgHuPWuweYyancnhKHdZJ880gEPHeOmhE77WDhRw94Th84/lgN7fw+ampEui6UwslBdJ
	 /zwFBzRkljKjS1SvgPPXJlGajSOwsxS3K0k30G3w0YT1izdZBfzdBY0HcelXxQXxbkT3e
	 ikVreIdQsSegBeuuAumk+3KpGqIt+ALwkP3pskRcVg6D2xFrRe68r7ClMcXsUmpy9mPYe
	 uItd6IW6a7fHjVUIY6Dz/AiaVWssAvdyF4k+EDagkcpK7kXu7onBgVO1EhyEaJ5sbMcif
	 stuyTA5MiP+yTCrXLY/yfMDVuyrB5ly2GE9XTz5uyPPmbLjdIxKVHvehVnw/u9aXZPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749321;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pxXFSO5l1giDy6NiiV333eUsWpcJ/SAtzEx/q9Uqkn0=;
	b=Q3h14T3LnFGykJHbG3sDaMl5+qDS+kJAbd3qxlN1M+QpQSkm9qXQHFRa624/4G3Ro58M
	 WI0Snm2u8hlA2Ar0QlOJ6AwjT4iBGGFTy0Zr5AbYTaxcxDUcWFMxSMbsxLxNTBkBkkDmx
	 vn4wm4Nar7oBAYCrjC8o1NgY+1xNGaronZkxaAQ06bY7uhWtmY6A6N3Q104lKWoQoJVHb
	 aK7zTZu9o5CbfWsUj6iYUGecrsZSmjedxdF/k2pnoqx04L83Bs8uXRK6zxjkaN2gOqt3s
	 iwEflSjRf2cyGOd5sExb1SzEj1+fgFCWiLA4KMBi2fMatQVsA/KehoXOeoc6DZbPKzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SZW+8o05;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4058C606A334
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4058C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SZW+8o05
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e98798cbddso505505ad.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749320; x=1794354120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pxXFSO5l1giDy6NiiV333eUsWpcJ/SAtzEx/q9Uqkn0=;
        b=SZW+8o05XZF0wbXge2tm5POVMcgUDWLzPvl8tj+83vgsIewbsdy8d5hF8L96B1Y6aB
         bOaSGLmusmJWo/Gx9VyKF5e1+KptrHwNc2cyuVeRWbdJspShxt4NV5HNl07opsTSNGdJ
         XzuwNG3p4OY/hqOtMddxg3qqvGgGnvhBlEnnFP0JH7MQ/2iN/FE8LCzVYINiCDvn81ln
         nTnzgrXAjpPi6CSCVXsdTmgRwrCHxmPMFBLwxBcd/pdTiUeEdPvdFcqAmyb/eEbYq7ht
         U3muLnd2wzy7le2F7vLzfXbVOGkiSt+YUKmx6QVhM2siOvjlBxRtP1xmzuMM7JtCk7yM
         5kfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749320; x=1794354120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pxXFSO5l1giDy6NiiV333eUsWpcJ/SAtzEx/q9Uqkn0=;
        b=1Su5epL+DDrjcOyqcfgyg+nJaSJc00sxexEiVGNLsaKoopu7efZt7jnqTS3jKggEgT
         BCa1sfb0FpvQNPPmk49WiEh1C9o017PCBlhOSUpMpDyVZ7zd/aFJvMZABOV+UluL3mJQ
         uaRMUGICcVpSjEA/sBn69JxrzeZy1UbasAXfymu+P4yxsNcK0BqZ/vgg+DzOVCfsad8+
         jr+bsGyBudShqFwXgdisZM+GXJ9s9Hpl1vHtDT4ip7hUDNKpBFybplL7lryjCbM92r3u
         3jiGlyRLXe0MyuqFbqQTnFAg8pp0OotQVSUgHVB5dwTpEhdh7a4rC6S9E7q9hdfy4SBA
         N86w==
X-Gm-Message-State: APuU4Z+qiRnpuyDjM75VHkPhjgP2Ljw3R6aZM1e1hdiH/5mmS0CQDVWW
	vdI9kXvC6NZwM0XzhoOyU6ToSlthXVVRAFS0vOj4/SVez/afwVd4wo6dUZ5XDw==
X-Gm-Gg: AYBFou2VGRpEIt6HSng/8XVhvWFSKDrnGNa6cT6iaAgqELMn9q3qUE6YZHVy/HK3OvS
	iM7Qx/dwzd4kp6jy2HZ2R3Ap48Ez0qnJxedB/WjYfkvm384nUIfDR9Hp6FEyPnEk8uDNTGQLweH
	dFYJ+EUz/wF4AybnHZm7dATrUIzovg8TV/JsW22PleZtA5m7iRXyV/wPWbeADW4Q7hP7GMSom8C
	q3IDfpxF1UcT2r7esD4ZgMC/GjWmymUVbHvpumfWnKOU+OU8p8hKz8k/3jNw0F/zwoxCJfPR/eW
	bCW+BfAB5m1fyA0qcYNUywZxkvk73AHMNh27dETfmLxhH7teD3OfkBvpDoe3R9YlBgPHoThWpyq
	nyRgFImYc8iacSe6ZyKPfuf6lRzJcCR09qv4BS6PhGBF6iSgzy/IKdGkpvoDrNrEMnmZSSQj0Bi
	MULdhusFFyVv3yXyJBtY0gbhokTxRMdC9xrltzdjSJxkXEjHirusaLu0ObCMgU/DzCRHO/5HDjP
	Y4sBgU+G1fyopN5O8KipkEm/titPConZOBxqJlWfquolyjZRBo7HWWpwtmYEmUUllp+0DkM3gnR
	p6xiDPVjbW4igtVdHgsBBaTznp0kOVDccOwEs4EHwM9OoDQCCBFw1mpe1oW6BY767JTZ3+fds0N
	XswBdL+Pn+Z4gU0NuwHCs0/EeC/TFfoGkISyQEtkefsSHGLWjnnvY0u5b9+XNJiIt9rLrz533/L
	8=
X-Received: by 2002:a17:90b:48c6:b0:3ac:9717:afd1 with SMTP id 98e67ed59e1d1-3ae897e07b5mr12263989a91.63.1793749320431;
        Tue, 03 Nov 2026 15:42:00 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b09455fbdasm441402a91.0.2026.11.03.15.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:42:00 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 09/37] selftests/bpf: Test loops that change a partial spill
Date: Tue,  3 Nov 2026 23:40:34 +0000
Message-ID: <20261103234104.208239-10-alexei.starovoitov@gmail.com>
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

 - 4 counted loops make a number of 2 or 4 bytes in the stack from itself:
   'if (...) cnt++', in a nested loop, two slots that feed each other. The
   verifier did not get to the end of these loops. It unrolls them now.
 - 5 loops with 1M iterations have a partial spill that does no harm: a
   flag, a copy of the counter, a copy of a partial spill that does not
   change, a number that the loop writes before it reads it, 32 bits about
   which nothing is known. The verifier does not unroll them, as before.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_scev.c       | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index c891c9b8dfbc..682f22d5fe1f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -2732,6 +2732,65 @@ __naked void clamp_nested_unrolled_loop_state_pruning(void)
 "	::: __clobber_all);
 }
 
+/*
+ * A number in a part of the stack slot fp-8. There is no formula for it, but the state has its
+ * value. If the loop makes the next value from it, each iteration has a new one: the loop is
+ * verified one iteration at a time. If not, the body is verified at most two times.
+ */
+#define PARTIAL_SPILL_TEST(name, sz, count, msg, first, body)			\
+SEC("socket")									\
+__success __log_level(2)							\
+__msg("loop header at {{[0-9]+}}, header_count is " #count)			\
+__msg("loop header at {{[0-9]+}}, " msg)					\
+__naked void name(void)								\
+{										\
+	asm volatile (								\
+	"call %[bpf_get_prandom_u32];"						\
+	"w0 = w0;"								\
+	"r1 = 0;"								\
+	"r6 = 0;"								\
+	first									\
+"1:"	body									\
+	"r6 += 1;"								\
+	"if r6 < " #count " goto 1b;"						\
+	"r0 = *(" #sz " *)(r10 - 8);"						\
+	"exit;"									\
+	:: __imm(bpf_get_prandom_u32) : __clobber_all);				\
+}
+
+#define SPILL32_0	"*(u32 *)(r10 - 8) = r1;"
+#define SPILL32_INC	"r1 = *(u32 *)(r10 - 8); w1 += 1; *(u32 *)(r10 - 8) = r1;"
+#define NOT_UNROLLED	"widening r6 to 0..0xf423f step 1"
+
+/* 'if (...) cnt++' */
+PARTIAL_SPILL_TEST(partial_spill32_inc, u32, 10, "can't widen *fp-8, expr is (any *fp-8 (spill32 ",
+	SPILL32_0, "if r6 & 1 goto 2f;" SPILL32_INC "2:")
+PARTIAL_SPILL_TEST(partial_spill16_inc, u16, 10, "can't widen *fp-8, expr is (spill16 ",
+	"*(u16 *)(r10 - 8) = r1;", "r1 = *(u16 *)(r10 - 8); w1 += 1; *(u16 *)(r10 - 8) = r1;")
+/* A loop in the loop does it */
+PARTIAL_SPILL_TEST(partial_spill32_inc_in_nested_loop, u32, 10, "can't widen *fp-8, expr is ?",
+	SPILL32_0, "r7 = 0; 2:" SPILL32_INC "r7 += 1; if r7 < 3 goto 2b;")
+/* Two slots feed each other */
+PARTIAL_SPILL_TEST(partial_spill32_two_slots, u32, 10, "can't widen *fp-8, expr is (spill32 ",
+	SPILL32_0 "*(u32 *)(r10 - 16) = r1;",
+	"r2 = *(u32 *)(r10 - 16);" SPILL32_INC "*(u32 *)(r10 - 16) = r1; *(u32 *)(r10 - 8) = r2;")
+/* 'if (...) found = 1' */
+PARTIAL_SPILL_TEST(partial_spill32_flag, u32, 1000000, NOT_UNROLLED,
+	SPILL32_0, "if r6 != 77 goto 2f; r1 = 1; *(u32 *)(r10 - 8) = r1; 2:")
+/* 'prev = last; last = i' */
+PARTIAL_SPILL_TEST(partial_spill32_copy_of_counter, u32, 1000000, NOT_UNROLLED,
+	SPILL32_0, "r7 = *(u32 *)(r10 - 8); *(u32 *)(r10 - 8) = r6;")
+/* A copy of a partial spill that the loop does not change */
+PARTIAL_SPILL_TEST(partial_spill32_copy_of_invariant, u32, 1000000, NOT_UNROLLED,
+	SPILL32_0 "r1 = 5; *(u32 *)(r10 - 16) = r1;",
+	"r7 = *(u32 *)(r10 - 8); r1 = *(u32 *)(r10 - 16); *(u32 *)(r10 - 8) = r1;")
+/* The loop writes the partial spill before it reads it. Only the other half of the slot is live. */
+PARTIAL_SPILL_TEST(partial_spill32_dead_at_the_head, u32, 1000000, NOT_UNROLLED,
+	SPILL32_0, "call %[bpf_get_prandom_u32]; *(u32 *)(r10 - 8) = r0; r1 = *(u32 *)(r10 - 4);")
+/* Nothing is known about the 32 bits in the partial spill: they are their own widening */
+PARTIAL_SPILL_TEST(partial_spill32_unknown, u32, 1000000, NOT_UNROLLED,
+	"*(u32 *)(r10 - 8) = r0;", SPILL32_INC)
+
 /*
  * r7 starts as 1 + 6*k and invariant r8 as 1 + 9*k (0 <= k <= 3).
  * The (any r7 r8) union must preserve base 1 and step gcd(6, 9) = 3.
-- 
2.55.0

