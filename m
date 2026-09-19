Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0074839184B
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 01:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789782146; cv=none; b=E24wW6qRlSf1GGE76oRDj9ZDLWWXnBcZcBAFedgZCm56AXBqAryktVJtG8MqcCZhWDQanMhwEREvMpccCB16b104EiVoE4uv30x/tVpmbjk8TFhRsCqfJ+hBfdhFVzZkSksYJNRmqpd3z1YWweP+yyf+zk/3W+mFzkz8V7UaYXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789782146; c=relaxed/simple;
	bh=hIVbs7YWtDY4LwlJbAtWQqDgc2Y/wZBrzXkRXEJgykI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5HbgRiI2Gs/3KcWBkbkE/YBcYUQ4ZX5yl8nGIoBv74i8ZXKUWNmnNpOHbl4+JCAynH38cmJOsrDCkvvI8WsBkb5DcQTP1XjNK/9pRk8G9fC82Gbaya/eszvdXtyAQtEOk/BwQ3a3EnNaowAiU77yibzrtbkow5YIhCdQG3jVNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDLJTHu0; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDLJTHu0"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49ccea58fe3so2872285e9.1
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 18:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789782138; x=1790386938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gab2MLBhumkLdDb8h1rXkYjNAYIU+06hP2pKB86hnqs=;
        b=kDLJTHu0Mnxu1gYgiw8BHNdQ77V55l7pyDzeoTBT0U+XP7ax/jT+rTSIGY/Um4IO5x
         tTU6DUEoysR2AlwfO2e/8ULT+1I7EEQGXAPl7tB8lYjk+zkfdHKW53zaF3XkeXwlyXYq
         xD2LepePhaq4UcEby9gx5W4M5iWcbrkb2CYig86dSi5AdYzqVRVEZ0/z6qF0blMuVepH
         86m+Th3R5dxd/phHT6KGHts7KVYMU45VuCOMhp4pwbNgfwM3Iq/bGDzKr1i+feVtfup2
         oQB8U6NnJIlFdCebr9S8fgtNyt9dJFf685aYCFj5gRRdChh0mXXM/mtTWiiETnLMjKmX
         4+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789782138; x=1790386938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gab2MLBhumkLdDb8h1rXkYjNAYIU+06hP2pKB86hnqs=;
        b=BYy4iKVkM6kVSpOV3oEy+/PqyI5ahxY7TsFMCWGiFDov2i74Xz6QDoeXLcbdyRywuN
         14YjqZT5X60xROMWKo0ckL7ruZ7M9ne+kK/BklD2uU6W4jt7/YnLw9ENfPVlyo7NLCjh
         k1g9PyT0ryPk46+AWsWYPzOBrgs8dFt/x6Y57v3OGIE/o1GqI7D4QlmOQyGG4Jl0+xuL
         vVJ3RDxiY26uLw+IwGiWysoSuNhH4gfYiQCs4SrQEXmVjMxzNfYCDlRPtSeW2KC7bvdm
         fs96+YAjJ2ndR08sOUwHyBIhXZN7IQ0QnU7aiRC/yZlgzDsAQmrAX2INstxNs9XeDs4c
         zQ8Q==
X-Gm-Message-State: AFuF++ko1tWGcdt7Y/m2WUyFVfK5A7ma6SxrFf9hGhIthZHhGLYHc7je
	0f+R5YHLyOcZVoJ+nZLMJdAVaoqP18q3MBhHDaYNjbZ9ssn8RIa2wxVD9GnojAPB
X-Gm-Gg: AYBFou3MPnsmmncEqNu+H6LQCGs6GQ2L/xBKTIU6C7rTbm4alA40X9Gu+i17cTin977
	xf1yUCk3uf37Nvuu8xXgu9iFAg3DEaOsSJJzETve9dNfx+N+M88ELxcjDMI6JTW9CFx9eYGKIwx
	6J+fYFrpYhOErRP72NHLwp5GE9Tc42YCXiP+v8fBTp90QiPNR9hIzWqvPbev4s4EBojnPcOkGss
	v64hH28l8SjsHZZa2u6tfa8jYjVc6hI5oNPXLgWPJ9ybI7282kWdiVTPAVBDH516RQF26LfIQ+t
	GXBZeMLNQgVOG3FK/s4EUoqKPxzLQC8ChutMu1P37jWEgJ3CVwh79cEzXpbKyEW1LkUPbQzi7Rx
	pQs11gWyHRf0FuJto+XBtX7GwdILWJP4LiENzqJapoY1Psdi+eStM7vN+iiXUp/K+/yhdP1NTi/
	U+0Zwmr2bM5/vYZjWl8Q2HSGVtXZL09TdFGXhPAo5q31AmffF52171m7LVyJKPq4aVUmoXqJ/8F
	ec3IXajYNh4rjB5Mmwv+Qju78/vZ17eHYKN4kFZagneglaA93ne6Mk2AuuzkmjjpqFtxyLFZ5J1
	zv/RJSLpxCx3HZ4vLx1FOpHFG2pIZFe1evmNUA==
X-Received: by 2002:a05:600c:4e8f:b0:49e:7cc2:e6c2 with SMTP id 5b1f17b1804b1-49fc584dc37mr57405765e9.27.1789782137911;
        Fri, 18 Sep 2026 18:42:17 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc585920fsm224795265e9.4.2026.09.18.18.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 18:42:17 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v4 2/2] selftests/bpf: Cover frame changes in bounded loops
Date: Sat, 19 Sep 2026 03:42:11 +0200
Message-ID: <20260919014213.1840880-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260919014213.1840880-1-memxor@gmail.com>
References: <20260919014213.1840880-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2025; i=memxor@gmail.com; h=from:subject; bh=hIVbs7YWtDY4LwlJbAtWQqDgc2Y/wZBrzXkRXEJgykI=; b=kA0DAAoWRy03e2NUL4MByyZiAGqt5smgEz1kDkMy4eYK4BHoUHiQisdSSrSfXvyRyTE3ikmzj Ih1BAAWCgAdFiEEdP++AjPIeftRPaYLRy03e2NUL4MFAmqt5skACgkQRy03e2NUL4PEEgEA/6Xs aglk0mUCjaeaV9OtMCp6rY1mXpqKgxLCgttpXbcA/2qcQcOp9g46iT8EQTrZxF4thaaSPoAldtL TcXt7RlEL
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a finite loop whose progress is represented only by changing the
frame number of a stack pointer. The loop first reads zero from the
caller's stack, switches to the same offset in the callee's stack, and
exits after reading one on its next iteration.

Force frequent checkpoints so the test exercises infinite-loop detection,
and check that the program returns one when run.

Without the frameno comparison in regs_exact(), the program is rejected
with an "infinite loop detected" diagnostic instead of loading
successfully.

Tested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/verifier_loops1.c     | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_loops1.c b/tools/testing/selftests/bpf/progs/verifier_loops1.c
index d248ce877f14..48a966cda199 100644
--- a/tools/testing/selftests/bpf/progs/verifier_loops1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_loops1.c
@@ -303,4 +303,40 @@ __naked void maybe_exit_scc_bug1(void)
 	::: __clobber_all);
 }
 
+/*
+ * The loop reads zero from the caller's stack on its first iteration and
+ * one from the callee's stack on its second iteration. At the loop header,
+ * only the frame number of the pointer in r1 changes.
+ */
+static __naked __noinline __used
+void loop_stack_frames_reg(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 8) = 1;"
+"1:"
+	"r0 = *(u64 *)(r1 + 0);"
+	"if r0 != 0 goto 2f;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"goto 1b;"
+"2:"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("xdp")
+__description("bounded loop changing stack frame in a register")
+__success __retval(1)
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void bounded_loop_stack_frames_reg(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 8) = 0;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call loop_stack_frames_reg;"
+	"exit;"
+	::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0

