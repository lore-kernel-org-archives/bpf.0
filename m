Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF4930C170
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 06:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779949339; cv=none; b=uVygWrQXu3Q7ROhoegDegHW8JpkpCV8OhahEy6F7wZaODkZLxGJ/P9wgqD+kUIA+EamrTrH9cQecgMf1nzsKHwtFamwVplFrNMeuUWjV8fclOVhihDjYdGOHqfsuLoDVXVHvBU/I6hcPSDqrx6er10nGdo5It/6MjijwlXqulok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779949339; c=relaxed/simple;
	bh=ncZ8PO1GcrR9iQGi0K+uqcRTqlKCxKBfU6IngjaQfJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=duFGoOP/z6zh7XrDpIh/1IqtLjv4XVoqEDlHaDtDHdeIhTpceeesj25IxzZL9a4BWErxZ1WqUnw6Gg6o8Lcd18r+p6/aGpMTp1NI2GyxLuhi2plxeKWmoGtaegiX6GrtM9oVErYsYX5o0701u7431Q3RonA73YIwA6pKRqcV/QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fsk7+NkX; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fsk7+NkX"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c80203b9d7bso5134631a12.0
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 23:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779949338; x=1780554138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2xM/E7JCqF+aKvSO4PKrWVccq753Fk89T0nKpMlTyM=;
        b=Fsk7+NkX58PRBotqsC9yirToVjiCcv0Ms4ekU8P2ztfjv2XrRsnMKwekKzXfediCwO
         /NeHk/ORV7dMBaRt46MaxFWrjd25j2GoEBg4bZIe8tX68NpBXw6Kb9nsxGT89TqJqq3f
         q4PVy29HTCoKnjIwmZEK0p0nE8Js9HY0F122eh8SnydQ8W351gORwU5a0nEsK7OwWQXJ
         HMt0z6bVXr75Wev9b3q1LdDI/zPPH6Lq3TSBhNmr43oDM8jZb9bXunWYKRQypHfTkXkP
         J5pVA+3UDDnRoVcPmP3hn0P62XlC730mzpGfDYaLxRs4Fq/bjBjLeUP1/aKG/c0omKZ6
         9VxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779949338; x=1780554138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s2xM/E7JCqF+aKvSO4PKrWVccq753Fk89T0nKpMlTyM=;
        b=tCg+5aSNvjav0vP/siZ79WVbboucK5HXsy3lT8KDzwUhxK4nt1jum+LemIXXTQXdQO
         /2moZK2iHZw7YMGztQ4I/lE7WvSEuybdLwqoypDpL6jka/C9JwskVB2tfkFG/E9H4yIf
         R0ak3tcXILn5Fno5pmyE6u5E67kNmHTaTv28xWptOGNhQiiSnbhmJbpfwutmlQPoGXvW
         3WzVTgFqh6YumjT7u+4auIbnV82MgqQlbDLuEsq/nF3UFw21BqM6CnBXu1w+34OkxMuz
         i3qFsv66KOsvKyCMa+wsWit8ATM+0f9Wbhbezw1rcFATIz3EKf8qoHD5KlGJYh4XL5XN
         JhVg==
X-Forwarded-Encrypted: i=1; AFNElJ/EiqD939amQUK+j6wpcETcGWi7ciN4XFGGq2oH9SGI+rniOIL+2yi92Ie0t/u7I6MvKlk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3TchCMhNQrU1mtUCafDSP5BY+myCTAh9qYHXmbjEXY//G809k
	7ck0WIF6HjnPmgKBN4OT1NS4UxOl+wAAjbibuw23RO8+UyXg+9i5/Ys/
X-Gm-Gg: Acq92OF3OHT2K1G1QZpm5/ghG1m9cRBbHw5deebJ4AUDZV1lSL3evmDdL7KrjEs8suh
	QrA3gmJP9hGla2Er2qG27ZHSH4TncLyAts/YZaw2fltDu+lELaxs0zTVeV5xIJ5iZUGrDbDAB8C
	QjlxBb8mhPIuG7s+LqWqcsy8JCMEUlMlkourBZJb/Sy8HJ8U4nbnyL7Sl7zuy/Uf5DC/clXwU6Y
	TwvEEZabvtuzv2B3nW6fePSSploscz3PbWrsT3WdLOn/o42H3wzjzsF6YubPbRsuEgobVODMITL
	XKfJQM0OIdmIVKYZHqbGm9dzQYuolkgRZJQLxjlehfZFJ4/4F3jjDA0vl3UbIqns2nLs0oRV8hs
	DKgIosgHcWH2f7hv/98GKhM/8Pl6vBy9mZYnSDrBBe+65YLfCaU4AT0VAmcvsrjO+XYdLfQg4z7
	slx3ryarL4iBgrXCiGYywDLrUfm92osvWkTzNMKZnUbar/vDHtLHHBIg==
X-Received: by 2002:a05:6a00:7702:b0:841:dc7d:306a with SMTP id d2e1a72fcca58-841dc7d511cmr4529239b3a.25.1779949337883;
        Wed, 27 May 2026 23:22:17 -0700 (PDT)
Received: from foxirain.tailf10b76.ts.net ([220.83.29.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841ef4e9ec7sm964082b3a.24.2026.05.27.23.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 23:22:17 -0700 (PDT)
From: Taegu Ha <hataegu0826@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Stanislav Fomichev <yatsenko@meta.com>,
	Song Liu <song@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Emil Tantilov <emil@etsalapatis.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Taegu Ha <hataegu0826@gmail.com>
Subject: [PATCH bpf-next v3] bpf: reject overlarge global subprog argument sizes
Date: Thu, 28 May 2026 15:21:55 +0900
Message-ID: <20260528062155.3988156-1-hataegu0826@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528052533.3940181-1-hataegu0826@gmail.com>
References: <20260528052533.3940181-1-hataegu0826@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Global subprogram argument checking derives generic pointer sizes from BTF
and passes the resolved size to check_mem_reg() as a u32. The access-size
validation path then uses a signed int, and stack pointers negate the value
before calling check_helper_mem_access().

This creates a wrap when BTF describes a pointee size larger than S32_MAX.
For example, a global subprogram argument of type:

  int (*p)[0x3fffffff]

has a BTF-resolved pointee size of 0xfffffffc bytes. At a call site the
caller can pass a pointer to a 4-byte stack slot at fp-4. The current
PTR_TO_STACK path computes:

  size = -(int)mem_size

so 0xfffffffc becomes -4 as a signed int and the negation validates only
a 4-byte stack range. That range is covered by the caller's stack slot,
so the call is accepted.

The callee is then verified independently with R1 as PTR_TO_MEM and
mem_size 0xfffffffc. A small instruction such as:

  r0 = *(u32 *)(r1 + 4)

is accepted as being inside that BTF-described memory region. At run time,
however, the actual argument value is still fp-4, so r1 + 4 addresses fp+0,
outside the 4-byte object that the caller provided.

Reject sizes that cannot be represented by the verifier's signed
access-size API before the stack-specific negation. Add a verifier
regression test for the oversized BTF argument.

Fixes: 2cb27158adb3 ("bpf: poison dead stack slots")
Signed-off-by: Taegu Ha <hataegu0826@gmail.com>
---
v3:
- Fix bpf-next build by using reg_arg_name(env, argno) in
  check_mem_reg(); v2 referenced a stale regno parameter name.
- Keep the existing known-NULL fast path before the overlarge-size guard.
- Send as a single bpf-next patch without a cover letter.

v2:
- Expanded the commit message with the BTF-derived size wrap details.
- Kept the verifier fix to a mem_size > S32_MAX guard.

 kernel/bpf/verifier.c                           |  6 ++++++
 .../bpf/progs/verifier_global_subprogs.c        | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c8d980fdd709..3a270bc485c2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6927,6 +6927,12 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
 	if (bpf_register_is_null(reg))
 		return 0;
 
+	if (mem_size > S32_MAX) {
+		verbose(env, "%s memory size %u is too large\n",
+			reg_arg_name(env, argno), mem_size);
+		return -EACCES;
+	}
+
 	/* Assuming that the register contains a value check if the memory
 	 * access is safe. Temporarily save and restore the register's state as
 	 * the conversion shouldn't be visible to a caller.
diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index dc09d0e2d8ad..75a2e3f48d0f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -152,6 +152,23 @@ int anon_user_mem_valid(void *ctx)
 	return subprog_user_anon_mem(&t);
 }
 
+__noinline __weak int subprog_user_anon_mem_huge(int (*p)[0x3fffffff])
+{
+	return p ? (*p)[1] : 0;
+}
+
+SEC("?tracepoint")
+__failure __log_level(2)
+__msg("R1 memory size 4294967292 is too large")
+int anon_user_mem_huge_size_invalid(void *ctx)
+{
+	int (*p)[0x3fffffff];
+	int tiny = 42;
+
+	p = (void *)&tiny;
+	return subprog_user_anon_mem_huge(p) + tiny;
+}
+
 __noinline __weak int subprog_nonnull_ptr_good(int *p1 __arg_nonnull, int *p2 __arg_nonnull)
 {
 	return (*p1) * (*p2); /* good, no need for NULL checks */
-- 
2.43.0
