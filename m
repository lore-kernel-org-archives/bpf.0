Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2650C48823C
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 23:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791502590; cv=none; b=N5BqtT/z81xwPitGklf7L+VUz9YBlDb76Qr6spamM6Gdl27/rYbdsdf6DATu+Bozw0kv9Z8DZpajeAhe9+lwuIwVUn6G8FK5b/x5LVxI7T+tjuBae7KZ/QTi/ZCimWMO6O4ihW0Zk0QVD3cXbWlbcFdP1xiwpKxmjhbIxRBGo0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791502590; c=relaxed/simple;
	bh=M/rQ4561R6UGKHsMQcfnGPKUwVjb9tqVoXZCGSnYpGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KN1JoZ/mteYS0AkHSEZY1d0w5bNgycPw5dHFweMLQ/ycSPFTz+LAo/A8tHoihEn2s3vK8g5pTy42VzGdfSng4Hp483Wfd2Xz7B6m1vEnixz30NanvCLv42s4kjrCjATJVty+Zat0ODYydb9vSh9pMHvFQaUmZGLxScC+jffPg1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4bNCNlE; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4bNCNlE"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93c5b7f5bfaso478683085a.1
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 16:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791502588; x=1792107388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f5p2nTO5pz9p/mFq6enSm35xmN3QB4rNCp8nZZUu4Is=;
        b=A4bNCNlE2cQ8mo8jkpfdFWeILTEGV69vADUlry59sokN4N5E7/BVzrWWjPS+BZwXtj
         Rja0UnlC55PWxLIReHMXljNQsJumU+4fshNL2+GKkpqq5PATYGAkiG9T/SDlxnNeLYJ7
         ewOLMy4tUZYi3p6FT5fm0XoN/Dq4pBunzTw80q5RuIWdjdEtiOzs7wOeiPICK28yY5Iy
         d283p3I2r1aAAU9xorYtn9UQCZ+xOt+/6FolmrgiP0yVs76i4yoVNsJfm/089kqGTR5e
         TO1UNH+ht9sstmfqS2UYByJH/+8IVhdl5EwROXbrt3dVPuUJ+dQfPJ2c5DlZiVRYtI9b
         mS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791502588; x=1792107388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f5p2nTO5pz9p/mFq6enSm35xmN3QB4rNCp8nZZUu4Is=;
        b=X1NQMpylHKHafijwif7YOLs5S/4Sr7XAsqVmfp9rowK/D3utubblKhgHW8z3rsiqfD
         /cWxa4GhOPIwu+OSCuVXurPpYxADBZd3eETMnGVf34CvNXUpUPFKcudOPgjQh7pKj/8E
         5M6501TNMOHgRCm9ZiGE0qw9ATbfbB7tr3SMVJj615VAEz4RBrNQ57RaDWyO1D6s/pdw
         i8YHDJyrt4O4nxXcQ+LtsxHdyvWOEZ8kaPsAv449VVzd19Cdm3cLrYcXwMq8XeA3sDgC
         IaDtFaP4R+Tkfpu1k8UO6M6OlX1xIEwwQpGssNivoHHWFkNiTrMcy/gl9FAb2ZyIuYiB
         LzZw==
X-Gm-Message-State: AFuF++lQPn9jG2lFvb81CwPd0sZs74EPv5QVkcEZAeTJZ+SWGRyBHBFb
	+MFWGQUxAa9EBZKQWv8mTDZGx2d5wVJzrCvY+ekDco3MWbdOEbn5M5idda3ujRZX
X-Gm-Gg: AYBFou37Fpasy2gweujKXiei3vfL/JcTwxnBB3dxBcNtpp/mohukVgyWdVP4WOpowgu
	xNJ83TGxi/ZSL1MaWZ5pCn4FCf0MKIHV9z+LPesa0hbcYz1d9/A0YaOSPpSw+mbIPuqlObufWco
	Lld4IfFpay3Z74V+0L/olp59xaR3c77O2DxPVKjnFP2XhL2EzMO2JT2OyXtEYgYwTd6PoyTkiLY
	orBb0qdIpLi+HRAXkHzUkCWGv/cmj13LwjckpL4oJ0HxlgGdsWsvsqLMAPOrSafKvKhkg/9uSO4
	dCFMiv3rm07w8fnUophTDw5+zPtxobQBRnASU5lONtnythVPv0bJjg1VmXt7w92c/MhNJ4PCH7S
	BiqFKvNz7Ql9s5HuW1/Fh5s1nyBLuOZISq8zdSneh8ndwh8JVDmGod1RXCfJ8XLu4pSfOsocx4d
	Ia7J1G9R+kMJoRSN6heptMNmHBqmv6/FGXrR0dWmHoDFw2U56L9EsyVdwT1r6fWRXIaHHe2XZyB
	LCyzD3buwL3EsPotz1erW3zQ5CpmZ1rbtPm9KlCuR++feGugbELQSgXL9RF7aZKYIx+o4Mn4+Wv
	TYXoDjAq
X-Received: by 2002:a05:620a:1786:b0:93e:5cad:643f with SMTP id af79cd13be357-93ebdc7013dmr16445485a.29.1791502588033;
        Thu, 08 Oct 2026 16:36:28 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb9848702sm51693885a.12.2026.10.08.16.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 16:36:25 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	yunwei356@gmail.com,
	David Windsor <dwindsor@gmail.com>
Subject: [PATCH bpf 2/2] selftests/bpf: cover bpf_loop() state pruning regression
Date: Thu,  8 Oct 2026 19:36:23 -0400
Message-ID: <20261008233623.4011127-2-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008233623.4011127-1-dwindsor@gmail.com>
References: <20261008233623.4011127-1-dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exercise 18 independent conditional stores to dead callback stack slots,
reproducing the verifier state explosion fixed by the preceding commit.

Signed-off-by: David Windsor <dwindsor@gmail.com>

diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index 75dd922e4e9f87ebc947ee6e621a789cad10431e..c1c3099a6a20391c8b36b39eedd9cc6ce893d996 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -783,4 +783,62 @@ __naked void check_add_const_regsafe_off(void)
 	: __clobber_common);
 }
 
+#define DEAD_STACK_SLOT(off) \
+	"call %[bpf_get_prandom_u32];" \
+	"if r0 == 0 goto 1f;" \
+	"*(u64 *)(r10 - " #off ") = 1;" /* dead stack store */ \
+	"goto 2f;" \
+	"1: *(u64 *)(r10 - " #off ") = 2;" /* dead stack store */ \
+	"2:;"
+
+__used __naked
+static void dead_stack_cb(void)
+{
+	asm volatile (
+		DEAD_STACK_SLOT(8)
+		DEAD_STACK_SLOT(16)
+		DEAD_STACK_SLOT(24)
+		DEAD_STACK_SLOT(32)
+		DEAD_STACK_SLOT(40)
+		DEAD_STACK_SLOT(48)
+		DEAD_STACK_SLOT(56)
+		DEAD_STACK_SLOT(64)
+		DEAD_STACK_SLOT(72)
+		DEAD_STACK_SLOT(80)
+		DEAD_STACK_SLOT(88)
+		DEAD_STACK_SLOT(96)
+		DEAD_STACK_SLOT(104)
+		DEAD_STACK_SLOT(112)
+		DEAD_STACK_SLOT(120)
+		DEAD_STACK_SLOT(128)
+		DEAD_STACK_SLOT(136)
+		DEAD_STACK_SLOT(144)
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
+#undef DEAD_STACK_SLOT
+
+SEC("?raw_tp")
+__success __flag(BPF_F_TEST_STATE_FREQ) __log_level(4)
+__naked void callback_dead_stack(void)
+{
+	asm volatile (
+		"r1 = 100;"
+		"r2 = dead_stack_cb ll;"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];" /* trigger state pruning */
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_loop)
+		: __clobber_all
+	);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0

