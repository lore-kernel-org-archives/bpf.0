Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0B91AA797
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 00:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778616; cv=none; b=KFT68FujVJg5+Y0VPLWj/Isv5gObec9hTHQNZm6H0aZNvjmefuCMPJtlBJjDGwo1EbTJEeYcXDdI7ZM9U6JmyTAl9MQ83o56Zh6YW4y6vDX72FGm4SKQMMeGVzseAQ/opOyaawFF2sIJNnY/BwcpmFsCx/YIf6lYz8VtKlFhVR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778616; c=relaxed/simple;
	bh=hIVbs7YWtDY4LwlJbAtWQqDgc2Y/wZBrzXkRXEJgykI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mXqmdBYZT7wuPMdXCFPFAsd+0RLiIQIf6AJP7/Nw4u5/pZ35sF/jIJTDJJqJ+aVU1/r6V2poM7StU1IMUSTPvXETge/r6q72ys6CY/C5x/rJpnn8t6Thar9E2wLyPA2V7ur9dL6dEwcFxZlcaMU2A9gz1e+O8tF5xBSdqvr2oqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqdzCANq; arc=none smtp.client-ip=74.125.225.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqdzCANq"
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-4858866f7ffso305168f8f.0
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 17:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789778612; x=1790383412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gab2MLBhumkLdDb8h1rXkYjNAYIU+06hP2pKB86hnqs=;
        b=JqdzCANqZk9FJ0fMZbNvJ14Aoi++byyFw66PYmQtmY6Cr/Gnay1FpnCcUsOiZzPH0L
         vRv7ZjxBOdPREj8LtswA05lizl7sPjqMd1ItaTtG+M/01NY/c0YXsJjhR7gU1isewS5R
         /pYqPp05XL4+wHLdvkEYHJhtoExUIntaKGHhumWX+01zkQYpjL9x5j4KzpYskv2X2EKS
         wqRpkfwdSm8gQD1ANIc5jblq+V9aIu84hFq8oOD0SgyBCKTflmQppxaGr0ITOevZyWjV
         QTHdVTvhlK5KyPdVRn/sSffQGwRo5/I0Nl2jJlRXFK0yWRP1VxpNEsZkbrF85ebv0bJ+
         M/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789778612; x=1790383412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gab2MLBhumkLdDb8h1rXkYjNAYIU+06hP2pKB86hnqs=;
        b=UAA8X1CQIaxYJsyFDMrx59ghjZp5LiDeoqRUWbk9Sj8abAnPmu1kLKyAIovy9l9BaF
         Lu9LLO7/BWYbK8SVPCvPPul0LtND+bA2QqtHgWKApqxuKBHQR8dkCO6oJb3qOfhkGGne
         6fxZkSOr6WuuJFvjNkRyjzN9rWNNfoSCD3dS/ySiWo5+bXq5j2LXMhADmskP2BZbdiLB
         rWVukWPJ/vThScMTd+TKxcv9OU/vURqOnQZPiatDUf9EFDpdWQ5kBusCol8906whF73W
         U4DxzEEcvMENjkyyLfV9VYkniVcNTegwTkJjnsRYOhcWqaEuSUnKW7B+3W4pA/5iAkYg
         o/ww==
X-Gm-Message-State: AFuF++k0hWK1inwgwzLLhMOmrgup0vnxiQYF5uHIvI0s5hvUNelhLnVV
	5BVpEQScqy0rprcROj2h3lur4siuD4gFRnjtTqadHG/9xy51eZveTEZkl+XyCDlk
X-Gm-Gg: AYBFou14hR5neIu9o7YtqTmQ+ZCkpx0Z9nGwyat0IatsXH693PcTPJJ4WrUCMssr3fF
	q1iFPtJAyms8Xf8USx48t2c0vBd6qtRx4ks5I6F0zrD5W4eLNK8N1QGabw2XwROJW5703Y5OjFs
	PLncbla8fCe4zB3EP6aiRQR8Am7P878UI+GwWgZUWak7gEWi196u7i37+cGNhzVd9kqkQ50T6W0
	c5dW6XYCk/fRle1ao7anALjJAengvbyXSqI6ZulmCdJgxbT+dbj0lTVaMR4pvYX2PTD8yHbPU9n
	dXJ0BIcK4D/fUNpK8U3yKxfe9rvZBq6vAWEXY7CwU02RkQikuK70xq8CUE9l5HptbedqnkrP3Bl
	Z5eI42aJ4DdU0vfxclv79W96tOI24RcieKqfg9ARWfwVIfkDS3Sr9MSEtj9zZ9tJDwiCzZQ9kwC
	aK8aQ6A9BReeO1ogZ/7nzbMW/iBJBrx+rbsFTPlVdsMwl+5kxcRaaNzss6Ww9YXCleKh2cwSN5f
	cVQVx9Dy7UnixwspIrAY7KJLo0LN4uFYk2WOuUT0wAzuFNZp2OIPXb52/iNhVdQrXl0hAz3Ueyd
	amJSQ3O4VpujwWJr1Hyd7veb0s2G13WZDScWxA==
X-Received: by 2002:a05:600c:1382:b0:49d:1d7e:4085 with SMTP id 5b1f17b1804b1-49fc5750e24mr49392375e9.22.1789778612085;
        Fri, 18 Sep 2026 17:43:32 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0eab91sm33873545e9.1.2026.09.18.17.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 17:43:31 -0700 (PDT)
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
Subject: [PATCH bpf v3 2/2] selftests/bpf: Cover frame changes in bounded loops
Date: Sat, 19 Sep 2026 02:43:25 +0200
Message-ID: <20260919004327.1403382-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260919004327.1403382-1-memxor@gmail.com>
References: <20260919004327.1403382-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2025; i=memxor@gmail.com; h=from:subject; bh=hIVbs7YWtDY4LwlJbAtWQqDgc2Y/wZBrzXkRXEJgykI=; b=kA0DAAoWRy03e2NUL4MByyZiAGqt2fCgEz1kDkMy4eYK4BHoUHiQisdSSrSfXvyRyTE3ikmzj Ih1BAAWCgAdFiEEdP++AjPIeftRPaYLRy03e2NUL4MFAmqt2fAACgkQRy03e2NUL4MykgD/ZlHa h/+VENeTTNkuKjrpoVt8ht8kjnXKxzKvGCFthCYA/jjrLHBzU4mPVb1CeElvyP1s7E5UfF5sjug lCc/3CZ0O
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

