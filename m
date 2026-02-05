Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF5032BF4C
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 20:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770323241; cv=none; b=tags1sy/X2MG7RDmjHv/1iW8fJR3/26bgp2bl1Fs8AZfwkIKGPYzdk8NUMjNVTAzJQYP5VxNQ8viRkMIqVtt/rv+EGgv1PC4CF7i2ZTvNMUUB7GiGvutqGnkhfRfjt03sB132uQEA0RJu0T0s078nK18xC3+zYRYiktxMF/Dkb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770323241; c=relaxed/simple;
	bh=gm6bBiQU8PZ/QZx25phxxpnrJJaVyMN3T7nsfxSD6XM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MbcXeJkoXGdTf+nTGuIjigcPu+cxGvLv1ZUR5jHFsddf4b10kQLe7AIW66HHrYJHuQWFivKFpjTlSgObmeZddcMgCada6UnHSEofbe83sHpmv7+hELOvtRuEc2bwhqGW75WsmWb5e6kbRDK+4Rd5Mgk7Jy+GAq/e2VZ0ORJsoo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ak2dzjuY; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ak2dzjuY"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4801ea9bafdso8500925e9.3
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 12:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770323239; x=1770928039; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wUmdRmniV/AbCKQPwVBc9R6soa5H9SgDS+/K3SfmgWU=;
        b=Ak2dzjuYqMwUP8MZqMkEzYSjj/nPWrOAb3qUv8fFrUs+10+hImGPY59+V88AHHpOTC
         DLB8YEFsJUm472BrgR2RHDblcI0nYOPmPKkMAtP3F40U20fub2jp1Pvg4YVQuVr6TCYS
         F0eQVqlLchn88W6fqsKE2VU6n4BCqei3gYf+srQU4hhdgCkRlTaHvjapWbtEy7Ic49iD
         DmFP6bkchtKQFW/hqDBgv9cT/n+wwZ4ysibDwRYm+fxlCzS+CPswU7zNFs3jVgxUA1jD
         bICQB8vbI6lo3jrp+9roGJ9lzLQEIQYhJYFhEVwmzfwWEMI8id+wPBKlnehJIoBuGyFU
         xIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770323239; x=1770928039;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wUmdRmniV/AbCKQPwVBc9R6soa5H9SgDS+/K3SfmgWU=;
        b=sENQRJE8yHsFiKc9lqC/f8qV0ZDy3p36mMKgmdmvslPULz8xxdOnj2pSlmnpTFUBMY
         CqzRzRqJoXiz4iD5AIDxRJvR+rNv7cXkSfDre0rX3l8UkzcSs56XslBx7CTfmOVky1Nl
         8PAp2Sgb3FN7V5m9uDDos0dRTkzhpe8S9lUESk96TFca8gdN7/NjgUAwfoCDkfSX7irP
         0SSpOl22jLJ5xqTDm5k7sO86+0U8iOJe6/pQ3VBAi6uLVQp23wgSQmRTEszHqK03+1Hq
         jPXlRC/OTztZjal5Eg2aijOA9RyBfTT9sHcRluYkU6+/VpH7IoYuYrEjVVkbOCa+uFBt
         lK8A==
X-Gm-Message-State: AOJu0YyhTUTApiS32BXDAEs3DCcltQ1vCgFk4OIepNzzST8B9B7lYRU1
	waPaKFor+cIropVvttZDncJJ/D/olOQqYkXhgoJdYH+vKuuCNvTCxveTeHgahA==
X-Gm-Gg: AZuq6aIRBR9aG9fzCV3DPK2oIavbtDMUmyUWLH5zBXBvf6HfdrJhrEjHZXtgLa2qi3n
	EvdQaI29AW6skWJiZj7FI+z8kB4xp+sQLA7e15igA3DYa6RhWPO+z/QkvleYT6GKdO7EK3PIvXn
	3iNkcRxOjPYPFAQmJ4JO5iLSFzEop2ge/9CZDoYwWgELX3Bh5TiKvv1r3XtSxsORTJT3LWYk5AQ
	xr+1dNEzCMpxtreIrZT4A51LRyhCyox0ru+nXTuSKVUqvldxsStftSYqgmao+dBACuZaZgHpGxS
	q6njtxni1kKPyZ3njiYg9ZrkjNPwaMp30XrDIRG8zc9/1aNyodHafwMGQDdbMbYMB7TafKuwFAN
	9nlxc3qlk6bASJ5RFTgcxd5CATR0439bBgVsqAVSlmMaJCTKTETCmRmrk72BKfqRqShJu5t8=
X-Received: by 2002:a05:600c:354d:b0:479:2f95:5179 with SMTP id 5b1f17b1804b1-4832093d427mr2122245e9.15.1770323239334;
        Thu, 05 Feb 2026 12:27:19 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::6:1325])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483206d87c7sm3716855e9.7.2026.02.05.12.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 12:27:18 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 05 Feb 2026 20:24:41 +0000
Subject: [PATCH RFC bpf-next 11/12] selftests/bpf: Verify resizable hash
 map is rejected in tracing progs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-rhash-v1-11-30dd6d63c462@meta.com>
References: <20260205-rhash-v1-0-30dd6d63c462@meta.com>
In-Reply-To: <20260205-rhash-v1-0-30dd6d63c462@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, ameryhung@gmail.com, memxor@gmail.com, 
 puranjay@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770323224; l=4754;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=dzBrd8eLiuhpRTj2NJiwdYjrbeuOqHRJXBv3nYrx4/c=;
 b=d7xR2Vrlpa9DC8UZE5uX2+tQkwIpuf8fHdxDDDcq+Z1lWbPP1eShK4V8I+CdSWy8Wb7o+o3Cs
 FwCPHA72Pk5CYQ5d1ey5kgGDkndL8Uf3Wn2CsLaMzdiWIseOh6clPAC
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Verify that resizable hash map can't be used in tracing progs, as it
uses bit_spin_lock for per-bucket locking which can deadlock in NMI
context.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 tools/testing/selftests/bpf/progs/verifier_rhash.c | 112 +++++++++++++++++++++
 2 files changed, 114 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 302286a80154d37e1e81bef405c2806d1310c252..ef42781a9c1856600a52b4d04f78fb0fd7b54bfb 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -79,6 +79,7 @@
 #include "verifier_reg_equal.skel.h"
 #include "verifier_ref_tracking.skel.h"
 #include "verifier_regalloc.skel.h"
+#include "verifier_rhash.skel.h"
 #include "verifier_ringbuf.skel.h"
 #include "verifier_runtime_jit.skel.h"
 #include "verifier_scalar_ids.skel.h"
@@ -222,6 +223,7 @@ void test_verifier_raw_tp_writable(void)      { RUN(verifier_raw_tp_writable); }
 void test_verifier_reg_equal(void)            { RUN(verifier_reg_equal); }
 void test_verifier_ref_tracking(void)         { RUN(verifier_ref_tracking); }
 void test_verifier_regalloc(void)             { RUN(verifier_regalloc); }
+void test_verifier_rhash(void)                { RUN(verifier_rhash); }
 void test_verifier_ringbuf(void)              { RUN(verifier_ringbuf); }
 void test_verifier_runtime_jit(void)          { RUN(verifier_runtime_jit); }
 void test_verifier_scalar_ids(void)           { RUN(verifier_scalar_ids); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_rhash.c b/tools/testing/selftests/bpf/progs/verifier_rhash.c
new file mode 100644
index 0000000000000000000000000000000000000000..66dda95d56b0544a43682df42381759e0f8c62d6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_rhash.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RHASH);
+	__uint(max_entries, 1);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, __u32);
+	__type(value, __u64);
+} map_rhash SEC(".maps");
+
+SEC("kprobe")
+__description("rhash map is forbidden in BPF_PROG_TYPE_KPROBE")
+__failure __msg("tracing progs cannot use resizable hash maps yet")
+__naked void rhash_forbidden_in_kprobe(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u64*)(r10 - 8) = r1;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"r1 = %[map_rhash] ll;"
+	"call %[bpf_map_lookup_elem];"
+	"exit;"
+	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_rhash)
+	: __clobber_all);
+}
+
+SEC("tracepoint")
+__description("rhash map is forbidden in BPF_PROG_TYPE_TRACEPOINT")
+__failure __msg("tracing progs cannot use resizable hash maps yet")
+__naked void rhash_forbidden_in_tracepoint(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u64*)(r10 - 8) = r1;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"r1 = %[map_rhash] ll;"
+	"call %[bpf_map_lookup_elem];"
+	"exit;"
+	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_rhash)
+	: __clobber_all);
+}
+
+SEC("perf_event")
+__description("rhash map is forbidden in BPF_PROG_TYPE_PERF_EVENT")
+__failure __msg("tracing progs cannot use resizable hash maps yet")
+__naked void rhash_forbidden_in_perf_event(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u64*)(r10 - 8) = r1;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"r1 = %[map_rhash] ll;"
+	"call %[bpf_map_lookup_elem];"
+	"exit;"
+	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_rhash)
+	: __clobber_all);
+}
+
+SEC("raw_tracepoint")
+__description("rhash map is forbidden in BPF_PROG_TYPE_RAW_TRACEPOINT")
+__failure __msg("tracing progs cannot use resizable hash maps yet")
+__naked void rhash_forbidden_in_raw_tp(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u64*)(r10 - 8) = r1;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"r1 = %[map_rhash] ll;"
+	"call %[bpf_map_lookup_elem];"
+	"exit;"
+	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_rhash)
+	: __clobber_all);
+}
+
+/* Positive test: socket filter programs CAN use rhash maps */
+SEC("socket")
+__description("rhash map is allowed in BPF_PROG_TYPE_SOCKET_FILTER")
+__success
+__naked void rhash_allowed_in_socket(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u64*)(r10 - 8) = r1;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"r1 = %[map_rhash] ll;"
+	"call %[bpf_map_lookup_elem];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_rhash)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";

-- 
2.53.0

