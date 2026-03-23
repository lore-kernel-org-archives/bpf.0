Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AB6223DCE
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 02:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774232657; cv=none; b=ftAJZrlAqUg0K1WKe7/UB15W19GCZGNFstAOpUegWVDX/pbMJdiKwSMhYpJF4Gg8I2PcIpQtoOXCvAbmC5WQByzvo1JzRLlEVw7kN0AjHlnV80+isETlK7A2CLvVPdsKcGZgvK+zSXA8gKHXqICVaLD5tQG6GgCy3hpC/Iw/YdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774232657; c=relaxed/simple;
	bh=C5bPly5nXEt1zAfNR452/7xLo2XsA1/NnmF95YCpdr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMgsjvqHl4uji7gKdcM8J7a7q9y0zeY/J+jgEi94QkOWYCUpvYH5JizuDFe/Mmkfb4AhNzYdPs+OCmzARi3HGb6oCMpyKzGXfIi15Qg1fI4F5IKbPHlyGuFvr203l8+OPAEKhYS6rXVDvsWJoRt2NGfvSyspYt84HbzLq9lDgaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ch9/CNl3; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ch9/CNl3"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82a67ce6969so2733682b3a.1
        for <bpf@vger.kernel.org>; Sun, 22 Mar 2026 19:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774232655; x=1774837455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LCDXdwjvwwl9EtwdAFSnDnYdNNIwVGtw9qFUtWLRX8=;
        b=Ch9/CNl3A+4KwdrxGcxAzKvpcoRPM+Xv52SNSt9DMP2NCVFguMCWFwgCXML68LZ6Bn
         ZGY87nCKzecPDInrqO21nflMTqQmy5dmT+W9HFs+muZqg+5Jmsx7oD7F/2xyRYIArQbD
         m61eFhG4A396QYZL3KAf1D+4cqFdtZF8cwiXftsHhMNLBPlb95zOac+/z1F9CMrhZzvS
         88pN7fzUJq04+sRsVIi4zc6WeXCmc6Umy1wO5kGJuR47FsV9ExAtSFgJHGPqHlHCEJfW
         kfgOmukchAUehHPT8VzYUEgfOwlyrgDVOhtb5qaeBGDI6oXhZqZ0gQSrzwt5grcMiUA8
         51kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774232655; x=1774837455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+LCDXdwjvwwl9EtwdAFSnDnYdNNIwVGtw9qFUtWLRX8=;
        b=bevt56uOuDYCo4aBqviKtb32gX+scTgiH0gwrYUVZQUckeNAzZ2uaegrO386Ca7PsB
         gW3wBtMg+ocBPjmS0HIZ0vIhUs9qG6cvC1dOPkBiWEwxlNQKhjsDjy/8y5jQrPCwBfVp
         mTTx8Lj4jAG/tSMAI+MJ97ckD9+EmYENStBy9/sz4w0xDmYq8mxSAD/keTUl9mVr/P1h
         qgkDKjFBTBCz61DJ0JWDoQfgpadlxT/E/K0OX4i+5T+SzEZqNfWCN29ToXfuMXJri9UW
         G6UgNCQeuFpnO0WM7QoQduccrjXsHumV4G3UKkPX8AHTfGizCJOqtdpPCY0XkD9mLigO
         c1zA==
X-Gm-Message-State: AOJu0Yz2djA0MOG2Txagu0mZNdDtSI1TUWgQ1pUmzHkVBJjxB4zVrNH+
	o9cs/2iRv9nyf9OekdO0TP8tsqsQ3GD3UjxabHKG5Phhg9XckNxfN469aLqjVg==
X-Gm-Gg: ATEYQzxrqhATU4hAvT+zdwFdz49mOicga7uWqlEUGBKVPcDh+gykL5dHAIr/qhRbU7F
	IlQdOY/b5snmpSmgnGEIr5ElymAxjUX1yzi7oP1fJTJNcg09nuq9x0qcIhMl9qjfKfVe18vAKhh
	i1WwxFcw6tej1YimpsRSlkXQEh6SlyGi+bsq24CUVXoVCxFT23A3FAyY1xXsAmfDvyOnvNoATY2
	LcfQIlvq5Qw9hJmX/YL2x9VliOevrpBMqZ85rzfkk5UWmu/A5Qtl6A4seKK/0ZsLKYEs/k/dgnA
	QX0zyI5A0a6asckR81AP+CAh5OzH+y6T2gLGsNXw0NY21ZFAUtxl7ovDTW99t4ILvZUc2dJvYAt
	xy8sHX5XtyteU0fxlmW+LWkfBbWPa1hqvDCLegndcWnL1+JoGAokB3vqflWRKJ8tcZ50ItXVfsC
	YBJVEJI1aMMZKXNdKIpVEiHP8tW+VTyj8MaKQYTAVeKwNXksSglkzz1HLntd+SvcLsfUyMb/926
	phsyjGsHiO/rr3WfVoBwn3sXdqKmkIMaUdkxc/5WlUczxFIfqzWzjCSSReyOA==
X-Received: by 2002:a05:6a00:9285:b0:82a:8163:4bfc with SMTP id d2e1a72fcca58-82a8c2ef471mr9134317b3a.33.1774232654897;
        Sun, 22 Mar 2026 19:24:14 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03be31f7sm8671483b3a.26.2026.03.22.19.24.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Mar 2026 19:24:14 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: Test 32-bit scalar spill pruning in stacksafe()
Date: Sun, 22 Mar 2026 19:24:10 -0700
Message-ID: <20260323022410.75444-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260323022410.75444-1-alexei.starovoitov@gmail.com>
References: <20260323022410.75444-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add a test verifying that stacksafe() correctly handles 32-bit scalar
spills when comparing stack states for equivalence during state pruning.

A 32-bit scalar spill creates slot[0-3] = STACK_INVALID and
slot[4-7] = STACK_SPILL. Without the im=4 check in stacksafe(), the
STACK_SPILL vs STACK_MISC mismatch at byte 4 causes pruning to fail,
forcing the verifier to re-explore a path that is provably safe.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_spill_fill.c | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 893d3bb024a0..8c74827d5396 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -1279,4 +1279,41 @@ __naked void stack_noperfmon_spill_32bit_onto_64bit_slot(void)
 	: __clobber_all);
 }
 
+/*
+ * stacksafe(): check if 32-bit scalar spill in old state is considered
+ * equivalent to STACK_MISC in cur state.
+ * 32-bit scalar spill creates slot[0-3] = STACK_MISC, slot[4-7] = STACK_SPILL.
+ * Without 32-bit spill support in stacksafe(), the STACK_SPILL vs STACK_MISC
+ * mismatch at slot[4] causes pruning to fail.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("8: (79) r1 = *(u64 *)(r10 -8)")
+__msg("8: safe")
+__msg("processed 11 insns")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void old_imprecise_scalar32_vs_cur_stack_misc(void)
+{
+	asm volatile(
+	/* get a random value for branching */
+	"call %[bpf_ktime_get_ns];"
+	"if r0 == 0 goto 1f;"
+	/* conjure 32-bit scalar spill at fp-8 */
+	"r0 = 42;"
+	"*(u32*)(r10 - 8) = r0;"
+	"goto 2f;"
+"1:"
+	/* conjure STACK_MISC at fp-8 */
+	"call %[bpf_ktime_get_ns];"
+	"*(u16*)(r10 - 8) = r0;"
+	"*(u16*)(r10 - 4) = r0;"
+"2:"
+	/* read fp-8, should be considered safe on second visit */
+	"r1 = *(u64*)(r10 - 8);"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.52.0

