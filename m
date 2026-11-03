Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749416;
	b=EqaZARwOGhux+dKbElpw5ChyRU2pllQT8sej56zfU0d5QiTsudWMrEPhJdTgYaxNMv1P
	 yI7T9CkH1YTVQX8cEz+58rPSSLqd2bsOQkSDZHLTJFfay0VIbKahsa36CzE1UG1QQCMbB
	 4rk9RadZ/rzmsqraXMYdqsQ3sQjn9p6ukQ2CEwXhM9tvTTCyCIGBbDh9wVTSqf5IihUzb
	 w1/jdVXhFnhZ9bUrghGnzQpXeVng+/YznIGHknYfpdJ6NzYelAct7u7lCdSAxbFoJLiMq
	 OQ1mCwuXvtMyUgTKU1UXxs/LauSkG4muBfZebCu+3sdMq4RVs09Yn4prdeimkas7NXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yqkkxBK8Oq8gbW6/MFdqvC7WIlMHup0AD0g2iJc+QHw=;
	b=eh5MTrdUkAc6Vusv4Nuw8bUlW6yHVFvPhpF9JaYntT5etBg/ZqsHUdVcqesdoYuowCm2
	 hCLMGg8mFi+BvvKn8Q3oRSfkNIBOth+LP1+42iynZrhdOfnh08pqoosS3z0Z8VLCRfwyL
	 vp2ZnqUkXqYghwWTyAIA4ME0N7MxAeFUsZ2uhJ4FuJL3gKOOmtZp4P0e5x3BfPziZmdu0
	 oryfqy227DWYwDxvrgGefV9T+yLDwlwX8/kDh0EluYzVvxmSe5rEADFdS3sZnIC9mlhPY
	 cwGyJ9eLuvScid3awjjtqQnA4UYzLhbXjoEuQ/iL3nCfMaOfYr5lUpUV1FHxbDSEK/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FFyYoVar;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5C1606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC5C1606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FFyYoVar
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-89f85edd210so77259b3a.2
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749415; x=1794354215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yqkkxBK8Oq8gbW6/MFdqvC7WIlMHup0AD0g2iJc+QHw=;
        b=FFyYoVar3io2QzzK3vjFxAPXTZqaf07ojd2Gj6yl4q7N07/VhJt6KrwqC8SX+LxYJ3
         3+dFIJ8vbA78e7dWVIjZLLPvVW3W4/+QDB+NA4fzfYlrimXM8e6pu6a5tA+nBoQ0V1iz
         QhUDV90fq9XmgQAAZ7XKYSHOKVue2J1GF8lKOCubiLgDggblTio27DkhZ80cdRYk96pt
         POEVe+teNfhGbA3bo7TaTyZxfjmB1fLFfraChvyg2JfqgWymiJeSnR2Z5lhHKtoC0doI
         cVgCFbnyukIZXbSzc1eUZ+rwr1UTATs11/tKkc79Yd8066GrIK8em5tz8JmRXgsS3tpF
         hsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749415; x=1794354215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yqkkxBK8Oq8gbW6/MFdqvC7WIlMHup0AD0g2iJc+QHw=;
        b=ylw01A38I8LfqEpAtKeDucoS5Qd85RVmfmcWoeG8zY+CKdzQTTXUXVBcJepbS0TO9K
         h0kxOO8RgyM8WrQ85OTh7BeqxmvEvVMhdpY5mzid0soS+S9KuGVafv3OIWgEkgsQ57vQ
         xytxmDU0BBV/qR/DmKSE1VCSpxvS+ezPWhOnw+Ks3JDVrcA8xiQNwCDq05EAJAdQ+0FU
         T9W0MD+bP0ZuNh+KE9oQhOWAJ5kinbEBpK8bJBRBafcRnSLRKn/zGXrRzNMEAuhe5W2P
         +syaqkYG/VIzF84Zt8mSI2cKmC3S4WsdkwTC5c/StNnesevstosEBEi4ty78ST+Wjmuy
         BK3A==
X-Gm-Message-State: APuU4Z+v6Lmo7RRF93XEC0lt2fg9PmLz/V3RlP63Xqvl4Zhhi1g8U1rM
	zd1pUXnzfiyVTJdxD5b6+9CrjA7ZZdi0Q84zpBhLUXOOxCRLA8Kqh53PbY7T5w==
X-Gm-Gg: AYBFou1WMIeb4roZFF49N4lO+zoVEHnfqyP4AdYF5FIGocd7iw6gr7vhKizdzry03YB
	ZB+wYkfPtNuLa9Ar+nnqz6zo4/yboK+e25OfPOTshsOx9Hj1+DB3Sfa+dXKPAF1BP7wbGxox2+V
	ltKFEvXf2tlXduxjmxx+zOey3WOxTaGPEfy9St03CynqefdOBbKs/g1qHHC3MLKMfq9w43HpVhV
	HU2JPZkWCSXDnNP+OUxrx+/PU3fphjgzIxLXRF1+QeViOUgSXW/2h48++wMTxwNmHA6NKh1c53n
	gih9+01tZgyHnIeNC9Aomu9n+mGKgfdy0aaMG+g5JM4X829vZqrlfoBuo1+A9PaN29Ps6re/2jz
	w4nQL0suE2iZ/iVePYKedACsLKQ+16wcKdPB0fUoPyHHK/eEAll5NorjbxqIcYORIY1zgp/1qBZ
	TQKiYVYuAk8VHwplKbW9pBVju+dUd1GTHopE1fKjan/SooXbFfCvOBCiTU4xfkXx+kKt7r1XGo5
	zCxrY2FvkUXDIfelVjqkx6pmxvxGiWlHE+chxKxbK/Wc3AJ/7y/hSuAEzGSNy4PNwPYcDSwRg/e
	Mxwld2R+T/i7Nob+uz+4ewMwE8fduKf8AZr2gc9k+vE9lp17etY0PC0msaddGwXgXoX7zb9HVJC
	MShCF4KlFN1l/jLejl4/x/eBHERLpkivvCrp9kKOG5Jl7Oyi6T3Rb5BSd/r5psYgXZb+k3HLQEA
	==
X-Received: by 2002:a17:90b:264e:b0:3ac:8ee5:e007 with SMTP id 98e67ed59e1d1-3ae89735e6fmr10740267a91.20.1793749414927;
        Tue, 03 Nov 2026 15:43:34 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b096b72d5asm268009a91.4.2026.11.03.15.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:43:34 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 25/37] selftests/bpf: Test loops with several back edges
Date: Tue,  3 Nov 2026 23:40:50 +0000
Message-ID: <20261103234104.208239-26-alexei.starovoitov@gmail.com>
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

The tests are rows of RANGE_TEST(). BACKEDGES() makes a loop with two back
edges. The verifier does not know which one is taken.

 - 2 loops whose latches are still false in the last iteration: '<' with
   '!=', a variable that wraps around directly after the last iteration.
   The progs run along the longest path and return the number of
   iterations. It must be the upper bound of the verifier.
 - 4 loops with a latch that can be true again: 'r6 != 3' behind 3, a
   variable that wraps around downwards and upwards, a pointer that gets
   to the limit of its offset.
 - The same '!=' with a range in front of both back edges has a count. It
   has none if the bound, the variable, the op or the width differ.
 - No count: a back edge without a count, 17 back edges.
 - The first value is a range: the variable has what one of three latches
   lets through, and nothing is known if the latches test two variables.
 - Two bounds, 3 and 5, meet in front of the loop, for each of the two
   latches. The verifier must count the loop two times.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_scev.c       | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index bb4ce07de1e5..f3908f37ca74 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -1137,6 +1137,92 @@ RANGE_TEST(range_ge_dir,    "", 10, 20,     2,   3,  5,  PRE("<"),    NO_COUNT)
 RANGE_TEST(range_ne_step2,  "",  0,  3,     2,   3,  8,  PRE("=="),   NO_COUNT)
 RANGE_TEST(range_ne_behind, "",  0,  4,     1,   3,  8,  PRE("=="),   NO_COUNT)
 
+/*
+ * Two back edges:
+ *
+ *    do {
+ *        add;
+ *        if (!other) {
+ *            if (jump1) continue;
+ *            break;
+ *        }
+ *    } while (jump0);
+ *
+ * The verifier doesn't know which one is taken. 'r7 == 0' is false at run time: r7 is 0..1 and 1.
+ */
+#define BACKEDGES(add, other, jump1, jump0)							\
+	"1:" LIMIT_ITERATIONS add ";"								\
+	"if " other " goto 3f; if " jump1 " goto 1b; goto 2f; 3: if " jump0 " goto 1b;"
+/* The loop can go on through the other back edge and get to a latch that was false */
+#define AGAIN(iteration)									\
+	__msg("loop header at {{[0-9]+}}, a latch may be true again in iteration " #iteration)	\
+	__not_msg("header_count is")
+
+/* The largest count. '!=' is false in one iteration: it has to be the last one. */
+RANGE_TEST(backedges_ne_is_last, "", 0, 0, 1, 0, 1,
+	   BACKEDGES("r6 += 1", "r7 == 0", "r6 != 6", "r6 < 3"), COUNTED(6, "0..5"))
+/* Only the latch with the smallest count of a back edge is looked at: 'r6 != 3', not 'r6 < 100' */
+#define AND_R8(add, count, jump0)								\
+	"r8 = 0;" BACKEDGES(add "; r8 += 1", "r7 == 0", "r8 < " #count, jump0)
+RANGE_TEST(backedges_ne_is_not_last, "", 0, 0, 1, 0, 1,
+	   AND_R8("r6 += 1", 5, "r6 >= 100 goto 2f; if r6 != 3"), AGAIN(4))
+/*
+ * w6 is 31, 23, 15, 7 in iterations 0..3, and M32 in iteration 4. 'w6 > 15' is false in iterations
+ * 2 and 3.
+ */
+RANGE_TEST(backedges_end_then_wrap, "", 39, 39, 1, 0, 1,
+	   AND_R8("w5 = -8; w6 += w5", 4, "w6 > 15"), __retval(4) __msg("header_count is [0..4] "))
+RANGE_TEST(backedges_wrap_then_end, "", 39, 39, 1, 0, 1,
+	   AND_R8("w5 = -8; w6 += w5", 5, "w6 > 15"), AGAIN(4))
+/* The same upwards. The largest first value wraps around first. */
+RANGE_TEST(backedges_wrap_up_then_end, "", M32 - 55, M32 - 39, 1, 0, 1,
+	   AND_R8("w6 += 8", 5, "w6 < -16"), AGAIN(4))
+/* It's base + offset that wraps around when the variable is a pointer */
+RANGE_TEST(backedges_pointer_wraps, "", 0, 0, 1, 0, 1, "r4 = r10; r4 += -8; r5 = r10; r5 += -512;"
+	   AND_R8("r5 += 8", 100000000, "r5 < r4"), AGAIN(99999999))
+
+/* The same test in front of each back edge: the first iteration in which it's false is the last */
+#define TWO_TESTS(jump1, jump0)									\
+	"r5 = 0; r8 = 0;" BACKEDGES("r5 += 1; r8 += 1", "r9 & 1", jump1, jump0)
+RANGE_TEST(backedges_same_test,   "", 1, 6, 1, 1, 6, TWO_TESTS("r8 != r7", "r8 != r7"),
+	   __retval(6) __msg("header_count is [0..6] "))
+RANGE_TEST(backedges_other_bound, "", 1, 6, 1, 1, 6, TWO_TESTS("r8 != r7", "r8 != r6"), AGAIN(5))
+RANGE_TEST(backedges_other_first, "", 1, 6, 1, 1, 6, TWO_TESTS("r8 != r7", "r5 != r7"), AGAIN(5))
+RANGE_TEST(backedges_other_op,    "", 1, 6, 1, 1, 6, TWO_TESTS("r8 != r7", "r8 < r7"),  AGAIN(5))
+RANGE_TEST(backedges_other_width, "", 1, 6, 1, 1, 6, TWO_TESTS("r8 != r7", "w8 != w7"), AGAIN(5))
+
+/* A back edge has no count */
+RANGE_TEST(backedges_no_count, "", 0, 0, 1, 0, 1,
+	   BACKEDGES("r6 += 1", "r7 == 0", "r6 < 3", "r7 == 0"), NO_COUNT)
+/* More than 16 back edges */
+#define X4(s)	s s s s
+RANGE_TEST(backedges_17, "", 0, 0, 1, 0, 1,
+	   "1:" LIMIT_ITERATIONS "if r6 >= 3 goto 2f; r6 += 1;" X4(X4("if r7 == 9 goto 1b;"))
+	   "goto 1b;",
+	   __msg("unsupported loop: too many backedges") __not_msg("header_count is"))
+
+/*
+ * The first value is 0..3: 'first + step * count' is 0..8. At the header r6 is its first value or
+ * what one of the three latches lets through.
+ */
+RANGE_TEST(backedges_first_is_a_range, "", 0, 3, 1, 0, 2,
+	   "1:" LIMIT_ITERATIONS "r6 += 1; if r7 == 0 goto 3f; if r7 == 2 goto 4f;"
+	   "if r6 < 3 goto 1b; goto 2f; 4: if r6 < 6 goto 1b; goto 2f; 3: if r6 < 4 goto 1b;",
+	   COUNTED(6, "0..5"))
+/* The latches test different variables: they tell nothing about r6 */
+RANGE_TEST(backedges_two_variables, "", 0, 3, 1, 0, 1,
+	   BACKEDGES("r6 += 1; r7 += 1", "r9 & 1", "r6 < 3", "r7 < 6"),
+	   __msg("header_count is [0..6] ") __msg("widening r6 to 0..8 "))
+/* Explore with a bound of 3 first, of 5 next. The second state is not equal to the first. */
+#define PRECISE_BOUND(reg)									\
+	"r4 = 2; r5 = 2; " reg " = 5; if r7 == 0 goto +1; " reg " = 3; r0 = 0;"		\
+	BACKEDGES("r6 += 1", "r9 & 1", "r6 < r4", "r6 < r5")
+#define EXPLORED_TWICE										\
+	__flag(BPF_F_TEST_STATE_FREQ)								\
+	__msg("header_count is [0..3] ") __msg("header_count is [0..5] ")
+RANGE_TEST(backedges_bound1_is_precise, "", 0, 0, 1, 0, 1, PRECISE_BOUND("r4"), EXPLORED_TWICE)
+RANGE_TEST(backedges_bound0_is_precise, "", 0, 0, 1, 0, 1, PRECISE_BOUND("r5"), EXPLORED_TWICE)
+
 SEC("xdp")
 __success
 __log_level(2)
-- 
2.55.0

