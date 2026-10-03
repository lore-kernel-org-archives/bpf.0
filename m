Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05E342A175
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791039901; cv=none; b=D5mEqVEEXhVpyflfl+R7DymnFlIIe+5btDUauWiAjsmxDz93nrbtF9yB07GlDcs368xAbar3RQqtDj83tzKTMLts2HaRy4WWwk8Xf9pZyOQ8VGjiPm8aKv1Ip9vroXc7gDnrlzd9wgQ9HhpeqZsDJRlSp7GF86HdrPZa6ahpNpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791039901; c=relaxed/simple;
	bh=/6fD7YaXe/+lroyRhUz0O3HQdb5/o4WrRyy5rNDzWuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DCt6qIBCek0f8bU/yJvc0Wv4Zizs6nXd1tBEXv1LlniLismXv2iWbEgizVZK8wU9CR3pq3b9C9hS3PpSqbcP/8PY7JIXh9/XHWDERHgJZzaeDcfyKsTW3z9Ey4JJxyRruX1vV0CrVhHATctUMKTtk4utKfKeEl2Dz5MSLh63BXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFY4ZjPQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFY4ZjPQ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2caced6038eso1201415ad.0
        for <bpf@vger.kernel.org>; Sat, 03 Oct 2026 08:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791039899; x=1791644699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=98Ekv5liO7qAP1L6FWL9USJwsVxggN9GVFf/VQaCLt0=;
        b=UFY4ZjPQwwRK1XCAEk5T1Omk541E1LLdD2Tvo3Iy7AVScS5wGurzlkvHiCZzqv+PK4
         nSeNGWLbol9kF7FdjrsgbIvHchiMCxo8+Kr94YLk7+bmjqCzp8MghADMx/pLOgihTD2/
         iQZ7ZKsY3dOuwdKQFbilEePuJf0MZJX/QjLVwHxestLTnci+DxHeyJiBr9J8qAL1JTxB
         m27e4VEjDG6jpFzQ/zyu5JbZ0wszPtbXgeMyB/39ji8M800opi93LPXongdDnmm6Mnm7
         HoN5MPrSdRwI0/+KNwA5xXqJqDUZmXFSA9HXL9SojmaxRMmk28WcIMBGEoaeETtJMtYr
         GT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791039899; x=1791644699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=98Ekv5liO7qAP1L6FWL9USJwsVxggN9GVFf/VQaCLt0=;
        b=XdP58ox+aPH3/tUCfJkQ/8DuBV6KzND6npF9krJGWQYcpJRafRUAEeLiknOCR4HAni
         IzKahMxKzVVKgYMvp3t7mnl+RyU/8RDgCtx9kXfGE1uKC5EVKOU+XW4dW6FY5XUdlllS
         IbIgwNQ7dbJxqLYNHH0YXSUi7gADk/rfJaZxKRrFliQVBzwnPqQkvX6mglVAqj0yaMfW
         JOGovMPJLQ8vhtng+PwRvy5ozdj9Eso0e8qoyj9cBmnq0FNHW0qDNf6qUZr0/+WKdrzt
         m/V1eJxjBNMUCne/kS0HcvoYyYmeSfM2kJ0JcYE1E1xz1jBg27IowD1Ihn45rLCnjD1t
         mfBg==
X-Gm-Message-State: AFq9FYIke26Kfqf4VuIE2abJwvT5CkQv8NZ4Z0TFBjYZcitojp5bLU15
	woSV3dKYW+9sgUabl9mkrEyJWza6ji/sNV9mOo/zJPvbIMv+Pazk+dqlrER0jNsv
X-Gm-Gg: AYBFou0NBVN9Qpu7oeJTP/pdyht1eg3ZWnCoLaGdbPJ0x2/8Vbq+Im0wT+ntFqju+EF
	I5lXExZmcuu0VQF3hRpgXMutnJIu3TRpZkWUmm7+SDDUMP7hhXjcM3TGOblurVf/7zL2TPjFmpC
	VLio2ZHCSmK5Xn5plSTSfXNYXBqwKAQ/hljJBS4IrhsPsoWUcmewNtlbEytV19/XfuIz5fq8o1y
	baScGUrx0dKH7hmIVUPNApKoXoF1d+8/GBFKV4B/Z+qzVfT5BhhmtfTZ/qFVUzmqVsVm7v/J5GW
	0Qwag9CDDgT6keP3bEDZwAH8QwciqxwkaxmCfjqlkBUEWo01Ms/GZuPn7Som/aEwTDIhwv8faLL
	KKCZ3QDUA5S+iPAt1j+G2J4smCgUT5hwswFGXArkby8tL1wwH+djz2y9P+r8Gc20R9hVnItTJNa
	c64OXUJYsPYxQB+ingY0XbHbRfIJOBFCVQzpzTMarjHrV1A7epF4HYalF5355TjSpMq+RAend1U
	0b3BMAjhF7zZtkgBe8EFgnrMjA52mML4odX9r5qtwOQqc0ijcOKIX58vWqtAu9t0cqZmvFKH7K8
	xc4i5SX0HWohs6VXrVCpy1v2DuyYKVEjxyqJMWaPHA3QH2TuONjiOg==
X-Received: by 2002:a17:903:284:b0:2e2:ac88:f3c with SMTP id d9443c01a7336-2e3000ed803mr60034195ad.9.1791039898735;
        Sat, 03 Oct 2026 08:04:58 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e535d0e8d9sm5544145ad.1.2026.10.03.08.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 08:04:58 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next] selftests/bpf: Fix data_in_arena test with GCC
Date: Sat,  3 Oct 2026 15:04:56 +0000
Message-ID: <20261003150456.168903-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

GCC doesn't support indirect calls in BPF:

  progs/data_in_arena.c: In function 'use_ops':
  progs/data_in_arena.c:65:1: error: indirect call in function, which are not supported by eBPF

Call add1() directly when the test is built with GCC. use_ops() still
loads the pointers to data that are next to the pointer to the function
in .data.rel.ro and dereferences them.

Once the build is fixed data_in_arena/arena_var_no_map fails with GCC:

  test_arena_var_no_map:FAIL:open unexpected pointer: 0x559fb35d3ca0

GCC doesn't support address spaces. __arena is a type tag only there,
so avar is in .data instead of .addr_space.1 and there is nothing wrong
with the object. Use __arena_global. It puts the variable into
.addr_space.1 with both compilers.

Fixes: 27e24617a83b ("selftests/bpf: Add test for global data in arena")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/progs/data_in_arena.c       | 5 +++++
 tools/testing/selftests/bpf/progs/data_in_arena_nomap.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/data_in_arena.c b/tools/testing/selftests/bpf/progs/data_in_arena.c
index ce3838327d6f..18f38103c0fc 100644
--- a/tools/testing/selftests/bpf/progs/data_in_arena.c
+++ b/tools/testing/selftests/bpf/progs/data_in_arena.c
@@ -61,7 +61,12 @@ int use_ops(void *ctx)
 {
 	/* a program has the arena when its code refers to it */
 	counter++;
+#ifdef __clang__
 	return ops.fn(*ops.data) + ops.name[1];
+#else
+	/* gcc doesn't support indirect calls */
+	return add1(*ops.data) + ops.name[1];
+#endif
 }
 
 SEC("syscall")
diff --git a/tools/testing/selftests/bpf/progs/data_in_arena_nomap.c b/tools/testing/selftests/bpf/progs/data_in_arena_nomap.c
index da27a8f10d6f..ccf66321eb36 100644
--- a/tools/testing/selftests/bpf/progs/data_in_arena_nomap.c
+++ b/tools/testing/selftests/bpf/progs/data_in_arena_nomap.c
@@ -9,7 +9,7 @@ char data_in_arena SEC(".arena.data");
 
 int counter = 5;
 /* needs an arena map that is declared. The one that libbpf creates won't do. */
-int __arena avar = 11;
+int __arena_global avar = 11;
 
 SEC("syscall")
 int arena_var(void *ctx)
