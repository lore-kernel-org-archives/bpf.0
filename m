Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793599184;
	b=rQ/9GvmSZFXmnsZmn/HDmD9s/Vx++amRqiWg/04bOE3LFUNPchBVEHVI8tti4i6/klvY
	 7hThcxhcjUBZ1trJsHxxIDZngIAHVNUQ8fatx60kMGQlJww4Z8BZlQp7eyq6zMx+m98w7
	 jbCQbvlOWFPn5j+t5rHZPQBd7Eo1KhPqPxxC5YHZJ7uje7rb9hvqKPMAI27XFGqqfrVmp
	 9UHzwgpThzYkZe2QTCs94GP1HQIxjKq6eOKNq5rcCpL/D+FAaYLEJS1jWNbPlmxHGdO+a
	 JUEGXbiaP1Rk8Vze5JCvBG4ndceQh+mg4JvZBOHhnbejaa9fJOoaK2uS83XYEkfOYIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793599184;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SbRRXgi8Dlz0ZyN3+pKrT0ekcYoq46t7RH1Zfj1vvOc=;
	b=EtUEwUeOngyyCYVmtPdTnyGQTj8YCjWyOcqQfwOU6GBr7PHAxNqYasZS7u1pVHAW3SVL
	 5B9O8J9DT99WnBYYm2ivPY8+ozc8H1FnQjcIEr0d2NCT8qZfwoc0Fh/dKKx+xbgOn9Fyv
	 +J71l+hFfgWu33oK8co4cGZZ5XW8Qe92FU0kvOPiu+xsUdn5OIcnJiNByPGURx+favELE
	 wfaUICcl/A/A3vDE17mrff/d1ursjmUzN7uNU9i52+EdvqciC95tp/gtGoDlF6G3QZzMg
	 4sZjVu3YKkxVE+IXe1Hs/Rel91mTmoaMvtL7np+U2A7R7WZwN2wyvXxXWjQ2cM73/yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gXmOBH8y;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FF6606A327
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 05:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70FF6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gXmOBH8y
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a39e5161c1so1717102b3a.3
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 21:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793599184; x=1794203984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SbRRXgi8Dlz0ZyN3+pKrT0ekcYoq46t7RH1Zfj1vvOc=;
        b=gXmOBH8yyTu9qyDpe6mSAzrxq592wDbhiWEF6JBQmORUndHOejpH03948YimD0V5q8
         AXFgzNeqFFeS0bL5XKvwQGH11650Q7BWtCQNLRlUqf+H7Rlw/4zQWV00sjHvhYHyQ4T0
         6SOggcafYObtgNGeWPjEeau+z4/61apnyAAgUimfUTKMr78yVUaj6GefA9g93OPaL3wY
         Zrvl0hqV6WpD7zyODz0LtPL+GnmAu+rkDvYEzg0ythyV+UqeouTfvDz9ybSIjAxquBS4
         HbNSYD4bNE+x/LDWGf0PzBJcILoP+jsekPhitmqsG50H+Ag2cn3BSkbK+VwjA5rKz/K9
         oHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793599184; x=1794203984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SbRRXgi8Dlz0ZyN3+pKrT0ekcYoq46t7RH1Zfj1vvOc=;
        b=Z/NwRzMmG6hwrCRpiE3+dSw52u0VbLZAD5mxJpefadC52x1VoUXmqspaG02MbtOiwA
         iPVi9EXUiLCvshK23/BfLRqFkLNYDFZal2swMC4ge8wySmbHjxt49hq7M5G+Gxdw49J4
         4kkqrs3kvDrgYacLcaa5NkdPYhMXKPS+1i+TjGAfQt/0YlX/UoRIAImwBelQxp9vM/CV
         HL6N4e6VVe4oEkqNykjdC7aaSp3cezTvFnspjmZsn1a+MmtoVXrLkMA7LQvP256mLZjC
         4uOTJ99GU97xXb/KW7iIsQzwPc9MiqyIIKkU0rwt1gXvrO+jGsuAwpNJvFaBypaX/N5x
         FHRA==
X-Gm-Message-State: APuU4Z8gyTyMcb6gSKQy+VZtkCW16pl0E8BEEt8dz+vGttEz7YqDdJem
	ZqA4ISob6zCCrhACtQBj+Jpr3IqqLHKkrXCjPjki1t6Rm0AGs1SablFgRHDkcg==
X-Gm-Gg: AYBFou3DjzM1qYQu0FHlgd065wbigaVuF/+8APks8EKaSRUJB49tmAntalVtaPWOZds
	/0+6O72NWgv+eeTvuvtDVVqWpc5jSzYihkX20Zjk+RQrbPm9b7Czbqi8vEsgnxZIFeituPqPVSD
	SOLSYqwsKRVe2sDVE6CqROA1PW30/IfN/hcNSREnOYedAKMu1pseXyjT271Jm+csYbexvQ6jf9o
	M3hm2ZAIxuT5MbHVk9W50xBBMEsbTEQHCrg8QaXb8OfZ7ic0UZAzR+w5Z61xMq99BBg/Ws9OguT
	E+Do2kNkMTOcQislGUajbhJ3Ncd8gVflQmocFNP9DGpXGK99btTKr0BUg0uus6e05+bbpiro8Ct
	V7iKZtFwEV2FolTHfU+MypR2Y+Zw7pDg23MEBY7vdmBA9KUKQXmR40256YlZPbpXBVZNS9lXOYW
	Apyw4Cq8NUvSqAK9xdQk2o7D5s21x/m/Ora8q8n7frdh/ZWQBFCx35xrmR2Efox52TuIobiC96r
	5UM6eukmkRKJ95Vd7oKTfEHos9zbc+ZSVLVIqtEFXQFGgy+i8PFdiiubtKU465D6sjGDK0KobM8
	dUpaHYIJ9PxA3ImX0uplxPzHUxHz75XrzJjMrb5Ef+CfUqB5rz41VWx6LrOuE0teuDjbpyY6BcH
	VCeEnMwWd7gKXNYaRDdYbzMChapbe3W8s9CoaC6vr6gZVOWpRWPm9doYWMkJLi/D2Whjo62GCZ1
	c=
X-Received: by 2002:a05:6a00:410e:b0:881:4b67:ffd with SMTP id d2e1a72fcca58-8a9bc446fa2mr6858678b3a.26.1793599183481;
        Sun, 01 Nov 2026 21:59:43 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad9d03be0sm1489774b3a.27.2026.11.01.21.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 21:59:42 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf v2 4/4] selftests/bpf: Test a callee that overwrites a spilled pointer of its caller
Date: Mon,  2 Nov 2026 05:59:13 +0000
Message-ID: <20261102055913.3598414-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102055913.3598414-1-alexei.starovoitov@gmail.com>
References: <20261102055913.3598414-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The caller spills &fp[-8] to fp-16 and passes a pointer to another slot of
its frame to a callee, which stores a pointer to a map value to fp-16. The
caller fills fp-16 and stores through it. That store is not a certain write
to fp-8.

Three valid progs read fp-8 after the store. The callee is a static subprog
or a callback of bpf_loop(). In callee_overwrites_spilled_r10 the slot
holds a copy of r10. That prog also needs "bpf: Fix the join of fp+0 with
a value that is not a pointer to stack". Without the fix they fail with:

  reading from stack off -8+0 size 8, slot poisoned by dead code elimination

In callee_overwrites_spilled_fp_hidden_store the store hides a write to the
counter of a loop. Without the fix the prog loads, and it accesses a map
value out of bounds.

The test for callx checks the spilled pointer in the log.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_callx.c      |  20 ++++
 .../selftests/bpf/progs/verifier_live_stack.c | 103 ++++++++++++++++++
 2 files changed, 123 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_callx.c b/tools/testing/selftests/bpf/progs/verifier_callx.c
index 7e59188d9fca..a12bc421e75c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_callx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_callx.c
@@ -289,6 +289,26 @@ __naked void callx_callee_writes_caller_stack(void)
 		: __clobber_all);
 }
 
+/* callee can store a pointer that is not FP-derived over a pointer spilled by the caller */
+SEC("socket")
+__success __log_level(2)
+__msg("r0 = *(u64 *)(r10 -16) // fp-16=fp0-8|fp0+0")
+__naked void callx_callee_can_overwrite_spilled_fp(void)
+{
+	asm volatile (
+		"r1 = r10;"
+		"r1 += -8;"
+		"*(u64 *)(r10 - 16) = r1;"
+		"r2 = %[write42] ll;"
+		"callx r2;"
+		"r0 = *(u64 *)(r10 - 16);"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_addr(write42)
+		: __clobber_all);
+}
+
 SEC("socket")
 __failure __msg("R1 has type scalar, expected func")
 __naked void callx_scalar(void)
diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 61833ea784d0..2ae5c60150dd 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -2583,6 +2583,7 @@ __naked void stack_or_non_stack_write(void)
 	"exit;"								\
 	:								\
 	: __imm(bpf_map_lookup_elem),					\
+	  __imm(bpf_loop),						\
 	  __imm_addr(array_map_8b)					\
 	: __clobber_all)
 
@@ -2649,6 +2650,108 @@ __naked void join_of_r10_and_map_value_hidden_store(void)
 	LOOP_WITH_STORE_THROUGH_R8);
 }
 
+/* ctx[1] = ctx[0]. ctx is the second param, as in a callback of bpf_loop(). */
+static __used __naked void copy_first_to_second(void)
+{
+	asm volatile (
+	"r1 = *(u64 *)(r2 + 0);"
+	"*(u64 *)(r2 + 8) = r1;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/*
+ * fp-16 holds &fp[-8]. The callee gets &fp[-24] and stores a pointer to map value to fp-16.
+ * The store through the filled pointer is not a certain write to fp-8: fp-8 is live before it.
+ */
+SEC("socket")
+__success __retval(0) __log_level(2)
+__msg("r1 = *(u64 *)(r10 -16) // fp-16=fp0-8|fp0+0")
+__msg("*(u64 *)(r1 +0) = 42{{ +}}; may_def: fp0-8")
+__naked void callee_overwrites_spilled_fp(void)
+{
+	WITH_MAP_VALUE(
+	"r1 = r10;"
+	"r1 += -8;"
+	"*(u64 *)(r10 - 16) = r1;"
+	"*(u64 *)(r10 - 24) = r0;"
+	"r2 = r10;"
+	"r2 += -24;"
+	"call copy_first_to_second;"
+	"r1 = *(u64 *)(r10 - 16);"
+	"*(u64 *)(r1 + 0) = 42;"
+	"r0 = *(u64 *)(r10 - 8);");
+}
+
+/* The same, but fp-16 holds a copy of r10, and the callee stores map value + 8 over it. */
+SEC("socket")
+__success __retval(0)
+__naked void callee_overwrites_spilled_r10(void)
+{
+	WITH_MAP_VALUE(
+	"*(u64 *)(r10 - 16) = r10;"
+	"r0 += 8;"
+	"*(u64 *)(r10 - 24) = r0;"
+	"r2 = r10;"
+	"r2 += -24;"
+	"call copy_first_to_second;"
+	"r1 = *(u64 *)(r10 - 16);"
+	"*(u64 *)(r1 - 8) = 42;"
+	"r0 = *(u64 *)(r10 - 8);");
+}
+
+/* The same, but the callee is a callback. */
+SEC("socket")
+__success __retval(0)
+__load_if_JITed()
+__naked void callback_overwrites_spilled_fp(void)
+{
+	WITH_MAP_VALUE(
+	"r1 = r10;"
+	"r1 += -8;"
+	"*(u64 *)(r10 - 16) = r1;"
+	"*(u64 *)(r10 - 24) = r0;"
+	"r1 = 1;"
+	"r2 = copy_first_to_second ll;"
+	"r3 = r10;"
+	"r3 += -24;"
+	"r4 = 0;"
+	"call %[bpf_loop];"
+	"r1 = *(u64 *)(r10 - 16);"
+	"*(u64 *)(r1 + 0) = 42;"
+	"r0 = *(u64 *)(r10 - 8);");
+}
+
+/*
+ * fp-16 holds &fp[-8], fp-24 holds &fp[-16], and the callee stores a pointer to map value to fp-24.
+ * fp-16 is still known after the call, and the store through r7 is not a certain write to it:
+ * r8 is &fp[-8], and the store through r8 changes the counter of the loop.
+ */
+SEC("socket")
+__failure __msg("invalid access to map value, value_size=8 off=4096 size=1")
+__naked void callee_overwrites_spilled_fp_hidden_store(void)
+{
+	WITH_MAP_VALUE(
+	"r9 = r0;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"*(u64 *)(r10 - 16) = r1;"
+	"r1 += -8;"
+	"*(u64 *)(r10 - 24) = r1;"
+	"*(u64 *)(r10 - 32) = r9;"
+	"r2 = r10;"
+	"r2 += -32;"
+	"call copy_first_to_second;"
+	/* the fill keeps fp-16 live over the call */
+	"r1 = *(u64 *)(r10 - 16);"
+	"*(u64 *)(r10 - 16) = r1;"
+	"r7 = *(u64 *)(r10 - 24);"
+	"*(u64 *)(r7 + 0) = r9;"
+	"r8 = *(u64 *)(r10 - 16);"
+	LOOP_WITH_STORE_THROUGH_R8);
+}
+
 SEC("socket")
 __log_level(2)
 __flag(BPF_F_TEST_STATE_FREQ)
-- 
2.55.0

