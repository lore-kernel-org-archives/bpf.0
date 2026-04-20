Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AA6386C15
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 09:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776677861; cv=none; b=mQ61hoLDDfktIL+4lmrHV7UbUQgYXQVgIHOM/WUIw7L8NjshNHZxqSZDQmsvHD3xExdP0tWlSLVefublqX7Wfuu+w7JbC9hi/1RhVsftWcClQX0kQqE5hGzbTqEoqv/KiOjWmHCtTkAnB1hYmqKc3xLmwBMB4uL8fWuGZWcyAWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776677861; c=relaxed/simple;
	bh=dADow4atwoXCABCgiUifEg1AZRAvSaPU5ceXdc/HKxs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rXz2GRmrqfzYhtRKZhoCvousVpo7SrONv7SGgT96VRUIkMDrdDaEHXtmxrgW5xF8j6iPaAZed2DQ/unJojDzRds8edfoXoMAI+8gwOSIpT4ONy5jmHDcYcM1bQ+l2vfmXZU9ANx7tDbr4RTLFmjZEfCPX3UUTJG9+Ym9JDCV6EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MTk2Vx1H; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MTk2Vx1H"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-66a3c95958fso2189246a12.2
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 02:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776677858; x=1777282658; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=moEWAAlg1JgBmt68QW05OyBjLdcuGTaHFgb05SGksXU=;
        b=MTk2Vx1H3jMoBUSFmoHFR9DgtRuuTxcHbq3ujaG6FIKeEESM1oFkRH/eEyRnXiLRHm
         sWSCb1edNlzR1/zqddbf8PU6AxbfEzVMQTnry75BsF181/LYAdC7BwqtzOzPMlsEBDv4
         UH5qYBaAO6CruNxue4PJ4tFHBPCZHTg6hp4amFUrNWnuJ4KLzDtJ+RJsY2aifa6j7Yhi
         yJGyjB1CCnGVB+NFYGRXAItkB3sq6ahC1hjHZx1SshJDftrymitVof4JW3U2I9Gjt2rU
         AoJ9ejAv4eqJnPFCGnKdBC1HX7c3DqH6Z/xTf1vlwYr9AjgiODPGzS1b+CrgSFBkI4zI
         CyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776677858; x=1777282658;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=moEWAAlg1JgBmt68QW05OyBjLdcuGTaHFgb05SGksXU=;
        b=VQWmSCFt+FFBW/8Fw6tzuN3krXtCzlER1/UDoW0AFP1hE0q9fnqpGKHSJLVVGUldjj
         ue8yeGo/0bw0qiWrxkNu4BNhVxW5sYQdG55+l4LHp2cJL2609WlSy7gIUFjRtEOcKtAa
         b0mO1/KNSasRRqsKB6wV11O0uJ2mo4+vkBcnYbR8EYcKUA3hUawHk8i9VMjafVy1rn86
         AqF4d75KH57zFvzN0b+Sa1zgGMDhcfa1cR7/BSGGQT9tyjIRNpPcqjgomD348srURxei
         Nm/epj7a3SX7qQfeOe1Uhgfp22bb1WwwoyDKcY0RQj8O8prY9Kuw8PjGZiDWlWT/MFfe
         usnw==
X-Gm-Message-State: AOJu0YzPal3p+EMB99JyzalOdILW3DxiLHdB+kpB8Vgd/2Wyxcjw5Qu5
	tElOfsjMiwZRDkNuUK3EvqyqyMRnED/YaNdjB2AL/frOvnbkaFeTiM83AfTBa7NeCRRXV2I3z48
	JPy896aLcsk5ZJYZ2gRWyqNDDeNiZMLKL/BCHfiaETxFW5Ntj4SYIahgUIy5pumJsBYeNiL1rw4
	5JkJvHBN/crpE5MpP+dDzEy9MhDCbhhpj8PkAe6c0OMebkApSMZWMiPbTStiriO7EodAME/Q==
X-Received: from edcy7.prod.google.com ([2002:a05:6402:3587:b0:671:c356:8c2e])
 (user=mattbobrowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3596:b0:676:6e7c:2e3b with SMTP id 4fb4d7f45d1cf-6766e7c3388mr539759a12.7.1776677857576;
 Mon, 20 Apr 2026 02:37:37 -0700 (PDT)
Date: Mon, 20 Apr 2026 09:37:34 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260420093734.2400330-1-mattbobrowski@google.com>
Subject: [PATCH bpf-next] selftests/bpf: fix off-by-one in bpf_cpumask_populate
 related selftest
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

The test_populate test uses >= instead of > when checking if the
runtime nr_cpus exceeds the bit capacity of a cpumask_t.

On a system where the physical CPU core count perfectly matches the
CONFIG_NR_CPUS upper bound (e.g. nr_cpus = 512 and CONFIG_NR_CPUS =
512), the condition nr_cpus >= CPUMASK_TEST_MASKLEN * 8 evaluates to
true (512 >= 512). This incorrectly causes the test to fail with an
error value of 3.

A 512-bit cpumask_t provides enough bits (indices 0 through 511) to
represent 512 CPUs. The subsequent bpf_for(i, 0, nr_cpus) loop
iterates up to nr_cpus - 1 (511), which perfectly aligns with the
maximum valid index of the bitmask.

Change the condition to nr_cpus > CPUMASK_TEST_MASKLEN * 8 to fix the
false positive failure on these systems.

Fixes: 918ba2636d4e ("selftests: bpf: add bpf_cpumask_populate selftests")
Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 tools/testing/selftests/bpf/progs/cpumask_success.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tools/testing/selftests/bpf/progs/cpumask_success.c
index 0e04c31b91c0..774706e7b058 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_success.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
@@ -866,7 +866,7 @@ int BPF_PROG(test_populate, struct task_struct *task, u64 clone_flags)
 	 * access NR_CPUS, the upper bound for nr_cpus, so we infer
 	 * it from the size of cpumask_t.
 	 */
-	if (nr_cpus < 0 || nr_cpus >= CPUMASK_TEST_MASKLEN * 8) {
+	if (nr_cpus < 0 || nr_cpus > CPUMASK_TEST_MASKLEN * 8) {
 		err = 3;
 		goto out;
 	}
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

