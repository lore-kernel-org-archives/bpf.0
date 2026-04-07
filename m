Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B0C33F8C4
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 04:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775537857; cv=none; b=Rn0fH6gD7AJZxwMlD1NEbuTfO/rdjOlaUXqq3uGUtdVP2fbbserec5arjYlLewxd2bZmOmUGYLhQuy26Js8AmghPVaidJnd3h2L1MRQY1EUClO1I5cmVOB0QW3scpoxIpmgJchLiL09yJFru/n4Tk58MdK9N3KJ07B1BAvOCem4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775537857; c=relaxed/simple;
	bh=d4debhK1Q301xrcRrsZ0EyEAkbwRnRz+ndlsplAD0OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=taHvzxYXBp7/xwUFzL9DWHEEgukxN0PolNuaETOYplOQ5lrvSRkv1aRAMr4dXnupaw5T/Tm1oUP8orSXEgFPgRMmw+4aM7JHVNun94v04UVdh5V7GCRhv8/gFZlQDfj/Z2C21tzGja7nWmXrF2BeFqlLsJZDe5FAxO9UR6EQwhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=neRqbmEe; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="neRqbmEe"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82cdb4ab547so2250208b3a.2
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 21:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775537855; x=1776142655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzWqOx3auCUUXjYYIUX5SAV4w62eVI/+TO/JYFwflkE=;
        b=neRqbmEeyi06Owa24i3fAN3gu6kbdQDkSQG1dJDCyDk2Xt38ONnw5zV9fv1J8br3TQ
         v74Nca5e1UTWvEWPkv84PwSka3rR5mOf0BnSs16Yg1VxegKWNWJ6IZyXNPVTISElDLzL
         xAinUrTRgJoB4zOJFxy3ocl3Y5pdpWn3vLxn5fXdCZ/YoY+3Z2YSaHFOqUZoxAOSLBG5
         ccKB4tY9y89NUOwisec0IwJR0qdGdeSvwGkowwLh0JPne7K5dl2exvFNY8CHc3nWXqOe
         IAslg7PQ+Gpa15dAXk+JvvJNqD/n2tgMs0e2uizw6elzQyqPyUqYqZXlQ1lX6Y+/4chp
         ShPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775537855; x=1776142655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fzWqOx3auCUUXjYYIUX5SAV4w62eVI/+TO/JYFwflkE=;
        b=ItxQO5V0cd0KhfVewPwev+4M+bl3glUi+vtug5C9uVzIYjV3+UombC57W8OFC1Rjec
         Vq7TpKkDVla+L+4M2M8reo6EIscsNGwZuInhgsFOy8tBQJgvyWWdTjC+rMDHdH8/8owN
         Rm2IIuLs4ajeOTacGkbCe6Ibv0ADEF6jDKNjSbWsFhZ49ycVp7wQnvRDfA+Rde7BT58c
         ddaIgRyHvXJDdEH2jS4qBG3yROd8u/uSU04Iv26I8K5xBN1sCnrOyPM+n/WZDumvxsnk
         CjyDPn6OMqvFpnhUtB3+7UUzIS8gZu0fKi+cfzj3fBFnuFT3AaNzPcx7+bqsSleF3FO3
         R4Sw==
X-Gm-Message-State: AOJu0YzR6QA1IWdJzx0QzB2DQrGuc9M+I3xx86YiZkJkxCErR7cp6Y4A
	h2cFbiA3NkLCayMEkwiglG/ArmCGcnTazZTCK7Inzsy11GDnwsStY8XGXpj4G4S44EMtLvTIcsi
	a37RfmTlzWA==
X-Gm-Gg: AeBDiesxHEubNrDia+vhogvSrpnzqjcmk/OyKU3rN612gmiU85KNb/GmxGEpk4iE37O
	kuup5sRCmYzDGu+v7/n17t6Lqp6rCEZeeW8BZlAG8KP0iIQkdUKp/YcS9WXdRyMqbJBx33IlNE1
	CcVD5es4h/ha7TCzd/yWBVgHRCRqI9g4nCLfUqdk2QCy4oZit5CtynHtZPU4Ji/e6SNlpmo+NyG
	HrQXAj6HvF/KgzDFhNXr/CXCzgs9rUh7zQsRE1nJdb/OTIsi3Na6gvX+1kO9HpPGIkvntyU31jZ
	ptaMSZro0aiamTOkBxvL29jw+D0T5k6v/a5Rn5guvcN1cOJk7O4aKZCFZUvSOA6kSdDrdpzJTTE
	+FmZfO2NPN3IzaI4Xg6pZ+Le+Lti8OOtRmooiyoskpSLCa2ajA3dYq4gmX+CATQRblBil0n3gLM
	crTLmujnhMODhF
X-Received: by 2002:a05:6a00:ab87:b0:82c:dc9c:e770 with SMTP id d2e1a72fcca58-82d0dbb2ad9mr13978404b3a.40.1775537855075;
        Mon, 06 Apr 2026 21:57:35 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b2694csm16156807b3a.2.2026.04.06.21.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 21:57:34 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v4 2/9] selftests/bpf: Add test for scalar/arena pointer addition
Date: Tue,  7 Apr 2026 00:57:23 -0400
Message-ID: <20260407045730.13359-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407045730.13359-1-emil@etsalapatis.com>
References: <20260407045730.13359-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest that ensures scalar += ptr_to_arena instructions
are accepted by the verifier.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
Acked-by: Song Liu <song@kernel.org>
---
 .../selftests/bpf/progs/verifier_arena.c      | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index c4b8daac4388..7ba60a7b9ac9 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -477,4 +477,89 @@ int arena_kfuncs_under_bpf_lock(void *ctx)
 
 	return 0;
 }
+
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+
+/*
+ * Test that scalar += PTR_TO_ARENA correctly upgrades the
+ * destination register to a PTR_TO_ARENA.
+ */
+SEC("syscall")
+__success __retval(0)
+int scalar_add_arena_ptr(void *ctx)
+{
+	int __arena *scalar, *arena_ptr;
+
+	volatile char __arena *base = arena_base(&arena);
+
+	asm volatile (
+		"%[arena_ptr] = 8192;"
+		"%[arena_ptr] = addr_space_cast(%[arena_ptr], 0x0, 0x1);"
+		"%[scalar] = 12;"
+		"%[scalar] += %[arena_ptr];"
+		: [scalar] "=r"(scalar),
+		  [arena_ptr] "=&r"(arena_ptr)
+		: "r"(base)
+		:
+	);
+	return 0;
+}
+
+/*
+ * Test that PTR_TO_ARENA + PTR_TO_ARENA is allowed.
+ */
+SEC("syscall")
+__success __retval(0)
+int arena_ptr_add_arena_ptr(void *ctx)
+{
+	int __arena *arena_ptr2, *arena_ptr1;
+
+	/* Needed for the verifier to link the arena to the subprog. */
+	volatile char __arena *base = arena_base(&arena);
+
+	asm volatile (
+		"%[arena_ptr1] = 8192;"
+		"%[arena_ptr1] = addr_space_cast(%[arena_ptr1], 0x0, 0x1);"
+		"%[arena_ptr2] = 4096;"
+		"%[arena_ptr2] = addr_space_cast(%[arena_ptr2], 0x0, 0x1);"
+		"%[arena_ptr2] += %[arena_ptr1];"
+		: [arena_ptr2] "=r"(arena_ptr2),
+		  [arena_ptr1] "=&r"(arena_ptr1)
+		: "r"(base)
+		:
+	);
+	return 0;
+}
+
+/*
+ * Test that PTR_TO_ARENA + non-arena pointer is rejected.
+ */
+SEC("syscall")
+__failure __msg("pointer += arena prohibited")
+int arena_ptr_add_to_non_arena_ptr(void *ctx)
+{
+	int __arena *arena_ptr;
+	void *dst;
+
+	/* Needed for the verifier to link the arena to the subprog. */
+	volatile char __arena *base = arena_base(&arena);
+
+	asm volatile (
+		"%[arena_ptr] = 8192;"
+		"%[arena_ptr] = addr_space_cast(%[arena_ptr], 0x0, 0x1);"
+		"%[dst] = %[ctx];"
+		"%[dst] += %[arena_ptr];"
+		: [arena_ptr] "=&r"(arena_ptr),
+		  [dst] "=&r"(dst)
+		: [ctx] "r"(ctx), "r"(base)
+		:
+	);
+
+	(void)ctx;
+
+	return 0;
+}
+
+#endif
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0

