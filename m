Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C297E38910F
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 18:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784660229; cv=none; b=aAguF+22pw0cokFn8PrKfrbbVd/LUK3hcsDiLFjINWD1eFOsDagIu0/2CdYQ0/PlDLDToVFFWiKm2hAj7nEEwy8VuNvkIxWRKJ2jcP0NJegso0rbR+6w7n8Y7OE04LQJ17Q9ap1UdXkjICrAkMIEyJg3qPiIygA60tpXbgPXyIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784660229; c=relaxed/simple;
	bh=9vPVOhcidrkfmGU+61b65f9k4sdsOIy0u5RsMn6gUCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pIJFWCkD10xlsyXdjzFC0G3oQ9s8oi1zgXwVOpA6QyNxtzh4BuZqacqVv+qNtF+bttpXwCp3anv75K45L6RksMUSL4iTQ88bOiNkA7sjYTceOqx5cqBP9RQd/ZaFVH73KOt9/63X254It5XH3vY7LKIT11rkIkF4Hh79J+2piBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euCwfHJg; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euCwfHJg"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-4730b8edae6so2695074f8f.0
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 11:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784660226; x=1785265026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KzQFn2iphpF4EirtfX9fzQ86rPodYrLnVm9EYWDE+EI=;
        b=euCwfHJgEw9Eow76LuIX/BoyVWNdlKBR+BRskBB2sVMycxMqjDEF6K0r73PdTTXqXd
         oFD/kdAHPZq0KoG51Q64mVLRFWoSWeRnAUbUXFU9IwWlApeBbIuYXYGsOq4bHEIXYbaU
         pkp/GDUU8j1nxMsDP8lZxV3foEZL0GugY8wL1NKox5gjVli9XghpKWIIRMnOe9+8AwlT
         Yfjuh9sX4RRY9E2zwEAZF986LofT5Ln1tNKTf0s/r4y18zlPv5V98KGRA6dtLv6+lULX
         eI/oTPFykkwoHigNqM9TVMmDFEk7IBel6J+xS7HS2SPKAq5rVT0YdfeJ/Ke1bUZMyIFV
         7S5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784660226; x=1785265026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KzQFn2iphpF4EirtfX9fzQ86rPodYrLnVm9EYWDE+EI=;
        b=tX566Z2nkM8kEXUw49aj4QcO/56i8OvodQc/e/xEgJ9wRPAlysPhSGIHYQ8AsSwx6x
         dPplaRdYnbKgar/Ews1Gg60lV+ftUIjQmTQrf3/KmC9AobTf0NDssHF0jihFw+9kcBs3
         AGR5hVOk3RBr/TFxILiA03lgSlLFa6y5HW+DWs1QBl5aLcYlo0lqD9PNXOTel5/0xAqH
         hBEXtgJVbcJa+RPTpBCU31IlRvBExu6X4vvg23L1LguurLr88+rjlUX3OC2WX++tiWHK
         0knNyw53QVGxfLJaaf4l/usYmcp3cy0DHLg34XG0IekDUudj+lVXzw1khHP7gihJtRo0
         7erA==
X-Gm-Message-State: AOJu0YzRRB4JLWWpdcIjaS15+OJThx4l9LWlo5UghWnnIssWN3Fo/Muy
	CdrGi2XLlDSgxZEmRpwsSfk72T6W8TUvwTb4DyJcql9GZOWzi05/5orZa/2nybI4
X-Gm-Gg: AR+sD13J41PEsjJEZ9k83bwBO1edZEYKLqQjWN3QBHID5ZJwHubT9p88x9OFcP1wifk
	S29ynlhVK6gbc+HNhFC9iNOtXTMw/mKsr2DKIJKuKwJ9pjjqDGY1JSAD253skrPxuRN9O/zZz6V
	aXM1NhJTCpBjI9d3RCYwACEmWNqpUtH37Z00c/6b6uHOzvBmk5LIupzpB0/YeWo/8Nze3JZV4sr
	thd1EcTBLhIYU+frSt6qxForEmnR1mWQ4o1RgBlEzyGXMhDw2/oPAHeio1OYWkgOGOlNK4zDi1k
	lrbCiEN/gGW0OSF3TVGvJwKmw+rmrg0eeKJzyHRx83XquqzP0+zA4tfsnX8jpEXcng7lHrcJQ5E
	viFhojPjoUbwXefcnDYIG93doDRPi68BQLlEFV2aL0u4KzRZIOSHs98lUP0M6dTFB809XYv0jvi
	7yEoGPFeMJX+VUYp/QkFGQEBxtsVl4VL+PwwT+pgvHlm4z4/g7cH4TI6nLxFgFkav1kQRvjaSvj
	pSoWNZY88m9D3DzN8Fg2L+a4isg3rz+6qkEp0wP/847
X-Received: by 2002:a05:6000:4914:b0:47f:6e23:64d6 with SMTP id ffacd0b85a97d-47f6e2366f5mr15872089f8f.16.1784660225899;
        Tue, 21 Jul 2026 11:57:05 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ee9281sm44556897f8f.36.2026.07.21.11.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 11:57:05 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next] libarena: Use compiler load-acquire/store-release in bpf_atomic.h
Date: Tue, 21 Jul 2026 20:57:04 +0200
Message-ID: <20260721185705.1365329-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach libarena's BPF atomic primitives to use compiler builtins for
load-acquire and store-release when Clang advertises
__BPF_FEATURE_LOAD_ACQ_STORE_REL. Older compilers continue to use the
existing barrier-based fallback.

Notably, as BPF programs begin running on arm64, it is better to use the
more appropriate variants since we can no longer rely on x86 TSO ordering.

Commit 880442305a39 ("bpf: Introduce load-acquire and store-release instructions")
introduced support, hence kernels from 6.15 onwards are needed when
compiling with compilers supporting these instructions. We have
relatively recent kernel version requirements in libarena anyway, and
have not cut first release, hence declare such a dependency.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/libarena/include/bpf_atomic.h  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/libarena/include/bpf_atomic.h b/tools/testing/selftests/bpf/libarena/include/bpf_atomic.h
index b7b230431929..ec8d606e7ce3 100644
--- a/tools/testing/selftests/bpf/libarena/include/bpf_atomic.h
+++ b/tools/testing/selftests/bpf/libarena/include/bpf_atomic.h
@@ -86,6 +86,21 @@ extern bool CONFIG_X86_64 __kconfig __weak;
 /* Control dependency provides LOAD->STORE, provide LOAD->LOAD */
 #define smp_acquire__after_ctrl_dep() ({ smp_rmb(); })

+#if defined(__BPF_FEATURE_LOAD_ACQ_STORE_REL)
+#define __BPF_HAVE_LOAD_ACQUIRE_STORE_RELEASE 1
+#endif
+
+#ifdef __BPF_HAVE_LOAD_ACQUIRE_STORE_RELEASE
+/*
+ * Clang advertises this feature when it can lower acquire/release atomic
+ * builtins to BPF_LOAD_ACQ/BPF_STORE_REL. Older compilers keep using the
+ * barrier-based fallback below. The generated instructions require kernel
+ * verifier/JIT support added in Linux 6.15; compile for an older BPF CPU to
+ * keep using the fallback when targeting older kernels.
+ */
+#define smp_load_acquire(p) __atomic_load_n((p), __ATOMIC_ACQUIRE)
+#define smp_store_release(p, val) __atomic_store_n((p), (val), __ATOMIC_RELEASE)
+#else
 #define smp_load_acquire(p)                                  \
 	({                                                   \
 		__unqual_typeof(*(p)) __v = READ_ONCE(*(p)); \
@@ -102,6 +117,7 @@ extern bool CONFIG_X86_64 __kconfig __weak;
 		barrier();             \
 		WRITE_ONCE(*(p), val); \
 	})
+#endif

 #define smp_cond_load_relaxed_label(p, cond_expr, label)                \
 	({                                                              \
--
2.53.0

