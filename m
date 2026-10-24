Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792800253;
	b=Y3vOjkMIB4egx87nkrMASivoGLHIuTnNXH8RsV/czhk5IuW3PAWp6XvW9gTmbzxl5xhR
	 1nMX4yq50YSW9S+eVsfwv2PFX3OqJuvbV+9++gfFUyODP7rj1x6IXNJPdHJPSVAAcwANb
	 kHzPui+wlsrQXcX6lPo25SVc43jAMnBHg4cC2WatlhX8gl27pQ7VFOpZyOfJTTpm8T08J
	 koxPug3z+HjbbayFpnQqUBLSGFA9O/k433bWNrA6lmU5bijVKIINeD8ffMitYQcUybQ5t
	 rkve1YoOwuMCNA384XCV50L7jVkTfROc33SfXHcCh+o0PBg7UkIghL9cQwhr5UPT3Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792800253;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=yfkmUa2t8jXkfSqYl4d9xAgj/JlJDzvobw4HzUgrsyQ=;
	b=KhWSjh/fXfy2t1/H7Dq6SDNWDUgPQrLA99EMHXuhRtr+T/YvVUtsm0H4ntL2H+VYQ0Qm
	 zFCHnKS6yDSsAzucio78VNrugCuboTufle4c/I4ACByhHAjLc2YjbJnlpXq5nCbimJbzU
	 ZwxiDMl3WVWjhaYn5nU/VS4c+gbc09+uP3fYA2s7JBMf5Ka3sGV60zLV19tm/ezDH4Jyt
	 QXW4t3gRMmQ03EJSJs49EVSwqRsF0eXqlx0xgr5y8Fp2OiWruPhh6fGztKRrsK9oM1eHh
	 rpNJmYsOkI9hTFbNnsDPQbR3tAsV6qOZPGaobFd6HqoO4MG8fUPy+u1NUj1ygAzWRHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="pzfJ1Be/";
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7762606A328
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 00:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7762606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pzfJ1Be/
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e9d1114320so10275385ad.3
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 17:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792800252; x=1793405052; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yfkmUa2t8jXkfSqYl4d9xAgj/JlJDzvobw4HzUgrsyQ=;
        b=pzfJ1Be/FxxOzV62Hu9qurW4BS4HBf+uGYwaJcuUpPKSad3yOOnaC6fD5m+a+NroNa
         kFLuSSCeYsY7GX8b0y6hmsowF2g9hn10kfQBm1YzlKSd/BeKwbMGN2Xfmx/tAtEc21wG
         U2h5j/g4xk8FuVjgqGYF085AUBHT93G3+rDyIL2x1rCizY4Yu7RFAUGz7KIAXIPQ0F6J
         jaDP2BfL7Rv6feGA7Groa0oQp6bTjS+9w0HNGzCaKBi5N8n4QLbWHufiPXWSIkbbKFzC
         3ov6q8XM2CqpNAhfgCV8lGwLK+bS508TLo0W3XZ4lmPju4asYyYKmJdUSnJKt+/Q0RF7
         FxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792800252; x=1793405052;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yfkmUa2t8jXkfSqYl4d9xAgj/JlJDzvobw4HzUgrsyQ=;
        b=C0EfjigiMaqAx69LRa+Z7C+QHaLr50ZI061Tzo3z5pHenL3Q0XcLKYVhqKoLUke0WW
         2U4Rd8BRgld2FM0cmvQZaRI8jNfm5WsoB2RWzDXOMtI4wA5bE3IvBzdB27LaRpXTMYGL
         ndUeNHpUfRlRSb021lFAcBKk29HcoWxrlDgTyiKz/3z9GO1dZ8jvCqOyEf5NKxtJAWSS
         +mLJMi/kOK9O05MiQZxX9/Z2x0VpaCqEe37F/tNLW27AvDGpNNLorqIEuIsAPRTOrb3Y
         STJOJ+9jFnFpv+Ag0sJ+r7w03GMyqIFX/mc895b7Ivtr47oAvWrVqQds5nNZIvLUuS6+
         crxw==
X-Gm-Message-State: AFq9FYIY84Tcb71Xp/5pKyVPNBV7jd4LzmvgfqY2jMApHosNZH/hZmh/
	i2Nvm6sDCVDw29U/+xHoaUAl/FOyYtf6AhDMcQNEoqKRYT+V1LVts3WGGTGbVg==
X-Gm-Gg: AYBFou0LtWNbSF1oxODT4EYVFZVr8VkLA/ejVXq+tSoFN2pdimGXBePJrIVb2OjonH+
	snHy/CbkXOD9EFUpfmxDIM0L+agfxdZHOiDRVK1lWBOWvc46PKE50qVFqVh6RBUF20UUygrIt+l
	D9/1FHRZ0KgBp3Nakfk0MXD7C566NT1jvz4Zr2jYvr6MlvWUHD0Bof4hT2ohNWP4n2gfPOCQutd
	fVSgvooqFqYc6luixltohOfk9lvxiOq/LsuC3VNPwL7ZD/k8OFO6b9LlQFJkIbWtLZG7DVuMWsc
	ywHo9BwZl8GC3hin85C0f4i7sohyOH+e2H2/oIiUm/ivYyMqu9zFAa3MiDTXXMuhB5qZttOT2lb
	d9iWRGuYBDrG8jKVTMWhffsUQQg1YO0BZjqCILqmtDd0O6DXfxB8d2oO+wMbR4AwY9m0NhI/z4P
	Ff1vWpNFTaVVulDptzbKbc95OIovhmkeBfkbab/tVf5uJpO07oXhGeDe/1KfCTyR/tFtB08lk90
	y8TpVS1UvNU3UJpky5Udk8/04kdK3OMmFwwuIKneo1hY1A7TxLAr48mIjDt1aF+u5YX3YaN
X-Received: by 2002:a17:90b:3846:b0:3ac:945c:7f69 with SMTP id 98e67ed59e1d1-3adeb162362mr618757a91.66.1792800252343;
        Fri, 23 Oct 2026 17:04:12 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba31797sm547433a91.1.2026.10.23.17.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:04:11 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 10/11] selftests/bpf: 32-bit copy of the counter compared at the latch
Date: Fri, 23 Oct 2026 17:03:52 -0700
Message-ID: <20261023-scev-simpler-clamp-v1-10-d43a07eda7af@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023-scev-simpler-clamp-v1-0-d43a07eda7af@gmail.com>
References: <20261023-scev-simpler-clamp-v1-0-d43a07eda7af@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

When building SCEV expressions for the loop:

  w7 = w1;    r7 = (zext32 r1)
  w1 = w7;    r1 = (zext32 (zext32 r1))
  w1 += 2;    r1 = (zext32 (+ (zext32 (zext32 r1)) 2))

Computed SCEV expression for r1:

  (zext32 (linear r1 2))

Substituting this into r7's expression at the latch:

  (zext32 (zext32 (linear r1 2)))

Without (zext32 (zext32 X)) -> (zext32 X) simplification rule
the latch would not be recognized as linear and head_count
won't be computed.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_scev.c | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 078803e71197..bbc25da41018 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -3652,4 +3652,31 @@ __naked void dominating_exit_bounds_count(void)
 "	::: __clobber_all);
 }
 
+/*
+ * The counter is copied to a callee-saved register for the call and the copy is compared.
+ */
+SEC("xdp")
+__success
+__log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg(" scev at latch 5:")
+__msg("  r7=(zext32 r1) / (zext32 (linear r1 2))")
+__msg("loop header at 1, header_count is 100 ")
+__msg("loop header at 1, widening r1 to 0..198 step 2")
+__naked void post_cond_jlt32_copy(void)
+{
+	asm volatile ("					\
+	w1 = 0;						\
+1:	w7 = w1;					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w7;					\
+	w1 += 2;					\
+	if w7 < 198 goto 1b;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.53.0
