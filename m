Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794206933;
	b=fYS0K2/tW2Erhw+Q0+UkfsaJ0avPEitw8ou4iP9P5HffPL8/bWhYVIblCxiaaMBO1Wrw
	 QPmuZxxqCHLTPQwjgiAY7t9TdsS0q3m3UEf7/JX927xXUarfjheYpjI4dWdVpeipjYBNZ
	 VMTQEZkGwnmOGiSe/fb+oTmuhkCN9rp7qQ/9mouwlKty3gnxZ+HXv9i6M0UIJzxNqLXQO
	 9ZsteoFcjsDrR9NOWbGSeFUxKoX/cmH/CESzDqDQmxFImzzKXxlSPnUnGTYIcZVfRMdQF
	 q2bfSMD5YthaCY9MVwaC6P3eFVXtL2roBvQEgsVOkDdr3Qijccq7WbCdTYyusGPJWPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206933;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EUwX/fpLd1eNsG6rgx95PPpsFMmv6oM1gqjDFNC6UMI=;
	b=zWU2T38Mp2CDEGL3AakmEgiYO1gsTfvb0hQnT/604VvAyVSak5WlkVOfa+TjYhiTK9oX
	 mnskK5z5NdE8hJ6lMlPA3mbzZcirIbb89wgkwol0x/lDhV4ySdEgzOEGzdemOIUmZMBMG
	 DBHpfh3/KMQPYgvudjdyRf1IqKsc2FTL3SiA6Eb4Ir7SOEvLd0sf+PfCQGOh1ef2lzCKO
	 fEo4DEouUzOx8oKCUGn9JL3RRMcr4Qkg413L1T7CncvO++4iiHvv4lIj1/a4bN0oCGqSy
	 bdXWM8c7BagsxYpPEzuBbmgCECByOvJnAKn6I1i7NJZ4ZSvhw8XnCBgGpOjfzi7Pp1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TrK8AIFl;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35526606A321
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 06:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35526606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TrK8AIFl
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cdb45e96d2bso141610a12.0
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 22:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794206933; x=1794811733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EUwX/fpLd1eNsG6rgx95PPpsFMmv6oM1gqjDFNC6UMI=;
        b=TrK8AIFlDC1pCJlQwa3Abzyq5aeg/qvQnldD05SxNVMOXlsW7IVsqW0CB8O1lWFEy5
         hM/M74fTZBLHMnBzL00X6QNGckk6Ijgq/6ILwOX6bqGa3pdqlEyYG03JduBU78CxQPx0
         w6EgzWlBqL3K9NrRS3v4wi7eqLc7bfFAZT35x3YF+S8Q1oTvYhBucqzajerZwZq/PG4i
         cNjT0idRWj1fHlcvCk+pS9xfMg73uqzL4qKH1zJT4No9XmimvcAJoGZea2G+i4Y7LWKK
         TIKKmnDG9Yfg2B5ZN5xJXXxztDIQVzOHH5t6P4ko84tgt9ZdN9YAWgifAwcyxmy928XV
         UmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794206933; x=1794811733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EUwX/fpLd1eNsG6rgx95PPpsFMmv6oM1gqjDFNC6UMI=;
        b=hmEi5CdgR91uY3Iw3LoSBCHIIaLQEoxCitgqeTtZLpUUANbFsOibS9JNT3LJq/Yuot
         b9el97ikgJ1S2njKYp+LnHzTkELqsRF8kiN1NOHyEqvGXz67OBF9aTh9tjhnPrlEm89D
         TUdf3b/BqXyyARcGgzx9xoQGr8o1yPTlqOnaKQIIgLBHbqfbDxqxij2QnXSsCSmEY180
         alD8x8PAgn1U8ei3IBOCI1EPOmJe3UdLYqnGHcX4NuwGss5PQULmqmiX8O/GHAUOVFN6
         SlA38/qu7Ssxk2BgqS2uLM4L2z0PHnGVsbrj4yJefZRdZK9ov7g+s4FxLQfhQvNRwVrF
         k+Ng==
X-Gm-Message-State: APuU4Z9vsBFGtbC1iLRMQA/EJm2YPknmk+e9lY++Yq73OxDK6hzj95IK
	/B7Uyp7IfZhdQ/oG7izOwu6nfXkJwZkAEqBUHOtp/2+gTwQ0iWWwvgTxOyRSQA==
X-Gm-Gg: AYBFou0auK4SAJnt3f2fHfkwxrKfPX6bVgADpDd1VtYnGHb0YqErwo1mAAh/9kpeiLZ
	sxwFwxe/vHY/Uo4NQoRQXJhNdUh4Qba3UY76g/bDFmAfYsn5p1d5e+4OYoNiO3AebBEIEXfaPCC
	TAnso0wJa/MKM1Lm1fU17Ck0ftChIbltsl1QVyrRHptRYxVuvevFMuVauMKjzMmfhqmr5lUiauN
	zqBcKpldnwoD7VJykXpiKqtSg9nbvQOtAO33e2+wcv+WHmAPwnp/WF+TajdYRuydPl6LVGZtLmG
	4TyCF88w6fbPJvLne/1NeyOzLxRL1iNI/zaIF/XZKT0QZi4GZCmfl2McqMZOzzwEB5k8uAt0KpE
	TthUaXMiuOhCB+cjZH6zni4dljpV/Q91N43Q61eb5W6sagSWIL7pOGwm0Tq1fwvO9DxZnS3I/it
	K3qnvT9vfvfuRliplUvvc/FgrLWGqhLnJNBPv15pg1ua7Q3Q3wVtfl1AFE6O2czS6pLwbmnRxDB
	8IYcrMZy2NpqPT3/R6FV8nDe3WNhA128GJX6/T2Vt3aNg65yAOz5aiwePvVnlwWUU6SNWrkDTch
	qjvPwf7xL94UxlnK346LPA2TwWXpCVDGufobPyL+Yh4wZUotUgd2XWrTfa1tlR1ajRHiC6tt7Ab
	WtssUmDp90lHtZAtdntVussGkeZ2fiSzxPcuz4+m24PVkeZGH4InyKuc+grj/2fA8fXZZKAcYcg
	==
X-Received: by 2002:a17:90b:530d:b0:3b0:91ce:6726 with SMTP id 98e67ed59e1d1-3b12d3300a8mr2751171a91.21.1794206932496;
        Sun, 08 Nov 2026 22:48:52 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0fc487e05sm5701271a91.1.2026.11.08.22.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:48:52 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 16/26] selftests/bpf: Test a pointer computed before its index is bounded
Date: Mon,  9 Nov 2026 06:47:00 +0000
Message-ID: <20261109064715.2382452-17-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261109064715.2382452-1-alexei.starovoitov@gmail.com>
References: <20261109064715.2382452-1-alexei.starovoitov@gmail.com>
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

Tests for the patch that recomputes a pointer after the jump that bounds
its index. Since that patch a linked register of a conditional jump can be
a pointer: an address base + the tested register + a constant on every path
to the jump.

Each prog adds an index to a pointer to 64 bytes, tests the index and reads
through the result. What loads is run.

 - The add comes before the jump: loads.
 - Only the low 32 bits of the index are tested. Rejected.
 - base + index at a loop header: the add is at the end of an iteration,
   the jump at the header. Negative tests: it holds at loop entry only, on
   the backedge only.
 - In a prog with an arena 'r1 += r2' is trusted once the main pass has
   verified it without an arena pointer (prevent_zext): loads.

The test with an arena is in verifier_arena.c, the others in
verifier_scev.c.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_arena.c      |  3 +++
 .../selftests/bpf/progs/verifier_scev.c       | 25 +++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index bf50413f6c08..3931a1d9b6da 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -663,6 +663,9 @@ ARENA_LINKED(arena_ptr_plus_constant, __failure,
 ARENA_LINKED(arena_ptr_plus_constant_on_two_paths, __failure,
 	"if r8 == 0 goto 1f; r3 += 1; goto 2f; 1: r3 += 1; 2: r8 += 1; r3 = le64 r3; r7 = le64 r7;"
 	"r2 = 0xffffffff ll; if r7 != r2 goto out_%=; r3 >>= 32; r3 -= 1; r1 = r6; r1 += r3;")
+/* 'r1 += r2' was verified without a pointer to arena: it stays ALU64 */
+ARENA_LINKED(index_tested_after_the_add, __success __retval(0),
+	"r2 = r8; r2 &= 255; r1 = r6; r1 += r2; if r2 > 63 goto out_%=; r0 = *(u8 *)(r6 + 0);")
 
 SEC("syscall")
 __description("arena: a number is not an address in arena")
diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 1047845c916b..8ffbe7bbdb0a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -3341,12 +3341,37 @@ __naked void name(void)								\
 #define LINKED(name, expect, body)	LINKED_SEC("socket", name, expect, body)
 
 #define VALID	__success __retval(0)
+#define MAP_OOB	__failure __msg("invalid access to map value")
 #define UNBOUND	__failure __msg("unbounded min value")
 
 /* r3 is the address in r1 as a scalar. It does not bound the offset of r1. */
 LINKED(pointer_is_not_scalar, __failure,
 	"r7 &= 127; r1 = r6; r1 += r7; r3 = r1; r3 = le64 r3; if r3 < 64 goto out_%=; r1 += -64;")
 
+/*
+ *	p = buf + i; if (i > 63) return 0; c = *p;
+ * The jump bounds i. r1 is r6 + r7 and r6 is live: r1 is recomputed.
+ */
+#define USE_R6	"r0 = *(u8 *)(r6 + 0);"
+
+LINKED(index_tested_after_the_add, VALID, "r1 = r6; r1 += r7; if r7 > 63 goto out_%=;" USE_R6)
+LINKED(low_32_bits_of_the_index_tested, __failure __msg("R1 unbounded memory access"),
+	"r2 = 0x1000000ff ll; r2 &= r8; r1 = r6; r1 += r2; w3 = w2; if r3 > 63 goto out_%=;" USE_R6)
+
+/*
+ *	p = buf; i = 0; do { if (i > 62) break; i = *(u16 *)p; p = buf + i; } while (i);
+ * r1 == r6 + r2 at the header in every iteration: it holds at loop entry, the backedge preserves it
+ */
+#define LOOP(add)								\
+	"l_%=: if r2 > 62 goto out_%=; r2 = *(u16 *)(r1 + 0);" add		\
+	"if r2 != 0 goto l_%=; r1 = r6;"
+
+LINKED(base_plus_index_at_loop_header, VALID, "r1 = r6; r2 = 0;" LOOP("r1 = r6; r1 += r2;"))
+LINKED(base_plus_index_at_loop_entry_only, MAP_OOB,
+	"r1 = r6; r2 = 0;" LOOP("r1 = r6; r1 += r2; r2 >>= 1;"))
+LINKED(base_plus_index_on_backedge_only, MAP_OOB,
+	"r1 = r6; r1 += r7; r2 = r8; r2 &= 255;" LOOP("r1 = r6; r1 += r2;"))
+
 LINKED(sign_extension_that_fits, VALID, "r2 = (s8)r8; if r8 > 63 goto out_%=; r1 = r6; r1 += r2;")
 
 /* The low 3 bits of r3 are 5. It is r8 + 5 once r8 fits in s8: no overlap with [-2, 1]. */
-- 
2.55.0

