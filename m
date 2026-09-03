Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DC54A3D35
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788455757; cv=none; b=gfK+v4441QFkGH0J0i7phkBAxzzAAexo2YQ9dARwFONJbXqBnSXuBSW1Uub9FjDv9aMbQg5M5chzmNcXxkdW8e7+uiay5AqpIi7hA2ayomuqtU1RNOfTYBVDNjsgB64eYAme7uD/j25VuWwnTBoj3XN666YighbiyqI9BrAWkg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788455757; c=relaxed/simple;
	bh=TrawKVsMBnuYr+/fCAcyRdjqy9UBSYno1FdzWJgIHwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZVLotwRyAAQ+GpdfDrZkox+XqJtfdXPk53e3hzFx6f+ciZb5vz5HTJ/dW602Bkeugk1fkS0rwjwknwKDL+TSRGs7VNjjz5jRlBdBVGSi8kDP0cPAA1b8VaOq1qaCkaBKTCBcpbXYBW/QWuX8gBjZ0KYi3eSy4iUfNbWhQUsbi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sMejV3kK; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sMejV3kK"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so146582a12.2
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 10:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788455755; x=1789060555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Znm5zITyLMbofZW2dQW52/uJRtKbB/f+/eAh6w8nf3Q=;
        b=sMejV3kKYZQfWKy5HJp2ltaDdFjM4+P0EHYWPK7PHKv9i8y4yLM/BorXrDBNlRUp8B
         pktdNl0n3eeqw+YJB+139dN26cBM71HxarzsEb/T816nUi1fWfve2D/7Y0U+PlfSH8jV
         4DpBy+srHFrCLsNhFcGeQ1jOQYATirdoz3W4BkXRd/HhLSagyHET9JZ/lsU5x1LlW0eH
         qbeeZuSyAyZtx2fdPbUqY8lYSPuvmYITY8qGO4BSKW3d6/noKsEVH2M52lSaClaIFIqE
         TopUMhfHBQe/4kWiVA+ysLxyzbw5q+CzEHao2qkzQIqLpJlXSaf/9sUEwjHgIg/HwuEn
         t1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788455755; x=1789060555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Znm5zITyLMbofZW2dQW52/uJRtKbB/f+/eAh6w8nf3Q=;
        b=atag0B8Q5fHYyrQuFGJ/UCnZ/QG1U7xYLZSOWxQsgwlSQyfJ3/W/EqoZw05nAKaM+b
         ofTQ6URlGNBHlXvckPsI8I33y51RBQPO99JASYfJV1HYHG2ljJcL2aKf7vbQGdJr0MW+
         Bb8MXT+LeGaDwP6jAsqLvaEGZL1YSitat86HkTvCAYghYI7QL4kF7AlvgNjlEoJd7uQl
         TivdkmGyWz6QekRfmw12F/rHW8Pt8WsYkiPDAB3TBakivAGUIH/bF+87nwikTZGsEhRG
         Jk7vq1Bex4CPgf00/gDiPBcmx56ZDoebGgVPiDbTBYbb5Bd/wWCgFLXbXeZudt6kT8B1
         a4Ng==
X-Gm-Message-State: AFuF++k9HknnW5MDD7BkjEETthnNJyC+qgz+deeMjBrPMNaj7Q0LgTaZ
	A7LcroltdMj5B2vWtuAT7PmqRT5PFCtW41q+sZwX3v0JcX7/wMIgPempnZ9/0f7UCQ0=
X-Gm-Gg: AYBFou2LRwTstzDDv5thkSAz+p4v5cTqTt0C9v9cKqw5h0UujW+D1q+lpp0I5YNtDtG
	xuCpkOgsKJHFMB0LTdZKR+kwfYdfJdE6VYXkBAHjb9cnrNbBq8oN/ttQtiYY4f1YdoIeWMb8NIj
	ZcPLFhUnJX0cksS83dodLQjOjNRJMdUAwSzasE89WCAvy4aYncWCp60B8mOM6bHR5/XNVIQxv2F
	vn6OfgtJ6IYEBa7kdqWz0kaCIg1kxHglhpz6XaxPoLb+hOmQsmQDZEDStatOfslfpSkWuVfQZXQ
	Ed2irYOik/YeqMcQyavD/2t7ekTbOfpcqbPQoKKhwyuuD1OhvsTVcXN6EWZ+l3ZoIVhDKcec7W7
	tYmSJ11nP3+FiXkju38Ksbs0Q4VVrDpRe1aecnb701mOpubb8RofFk0yS+jEfvCSDOacgCBzOmB
	eH53hQ8Si3v9edMnZDnqwyNshdWTIvVQjurDOzsykKVlcJ5rYOa182ARM44JtJHvX45BmxsLDZa
	NSS0GypKi6eni4Ew+Yq002dwRbzTjnIW1MsMkdIty7WFg==
X-Received: by 2002:a17:90b:4c44:b0:38d:b36e:9813 with SMTP id 98e67ed59e1d1-39aee0188bbmr21302428a91.11.1788455755267;
        Thu, 03 Sep 2026 10:15:55 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::6:dba3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534d25sm354893eec.5.2026.09.03.10.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 10:15:54 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	npc@anthropic.com
Subject: [PATCH bpf 3/3] selftests/bpf: check zero extension of an arena 32-bit cmpxchg
Date: Thu,  3 Sep 2026 10:15:41 -0700
Message-ID: <20260903171542.1438050-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903171542.1438050-1-eddyz87@gmail.com>
References: <20260903171542.1438050-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test to verify that destination register of a 32-bit cmpxchg
operating on an arena pointer is explicitly zero extended.
W/o patch #1 this did not happen.

Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_zext.c       | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_zext.c b/tools/testing/selftests/bpf/progs/verifier_zext.c
index 8f2362da91d6..572017fe28fb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_zext.c
+++ b/tools/testing/selftests/bpf/progs/verifier_zext.c
@@ -356,6 +356,32 @@ __naked void arena_ptr(void)
 	: __clobber_all);
 }
 
+/*
+ * Result of a 32-bit cmpxchg is always explicitly zero extended.
+ * Check that this holds for arenas (BPF_PROBE_ATOMIC instruction flavor).
+ */
+SEC("socket")
+__success
+__xlated("probe r0 = atomic_cmpxchg((u32 *)(r1 +0), r0, r2)")
+__xlated("w0 = w0")
+__naked void zext_arena_cmpxchg32(void)
+{
+	asm volatile ("					\
+	r9 = %[arena] ll;	/* associate the arena with the program */ \
+	r1 = 0;						\
+	r1 = addr_space_cast(r1, 0, 1);			\
+	r0 = 0;						\
+	r2 = 0;						\
+	.8byte %[cmpxchg32];				\
+	r0 >>= 32;		/* make the upper half live */ \
+	exit;						\
+"	:
+	: __imm_addr(arena),
+	  __imm_insn(cmpxchg32,
+		     BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, BPF_REG_1, BPF_REG_2, 0))
+	: __clobber_all);
+}
+
 #endif
 
 /* Check if probe mem loads keep their zero extension. */
-- 
2.55.0

