Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374128;
	b=RaUxH6ocTV4gQPMTlDKdFMKWsLIGFzQJcLkGMJIiyLgWLJROIctISx0aceWbifUubVtB
	 RgiYzXIX4zIf7ckmN0iIXN1xttpBY1FUOfbw3np9h6vJxSSN+NbaKu1tKzDLLVos7D6Qb
	 hwYmLzZOfu3O9oiaMxZEnRqWywqCWkUuga1y2dzqsGWm8aj5ygdQ0n7n+iRSyhoV/5MsS
	 eVqBkYmJ3pLYB8xf/AUDljg036M1FoKAvrnerIldrjOpugvFAN9N3vOnRtyW5CTakDNOh
	 E9Ozqj86C0nHwIzr6f1i7w32FFBHxfDNYp/6Z9b090PSXeNiES3MTK1eMENiTY8jYOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fgJmZO4AEsFbJ68zC0SetoBrgVz+A6pXoM39Jxsu77A=;
	b=tPJuBUj9/1SoBjfHmbTKrbHfQ6p1Zf1xjBd+QDrlXP+jDBOYvlyW4Ric/uYaP2EwOwAE
	 pUj3ZIYogmEdD2Mw3tXEMmOPY5v0FL2nuCYGkEZWh6HD/vJ9mq3/TQ9iEagpmyAOOUEXX
	 fjyZg3J2kiz24xS/3b0eeIuwQlhRn9liYUGzBc6TY4294gGiwb/c/QUkiYpJ8vtBTMEZD
	 Aj0twSGCFqvaQDNHivCu89I7sqFJym0xmLYvqZMnazqVozG7stBzjKrHMnYf5I5/LZD/N
	 3Gh9E6W01UTyD3HvTJzJM7VNlPGbEtnZzAMb26L+QnMbhZPZZWLxkRA4thiQGSlu78Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Poun6d3L;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1AF606A324
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 05:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B1AF606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Poun6d3L
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so1344199a12.0
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 21:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794374127; x=1794978927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fgJmZO4AEsFbJ68zC0SetoBrgVz+A6pXoM39Jxsu77A=;
        b=Poun6d3LanOMMFlVGxM+LZfdWoWlNeHLVx7B+Y4osEjqFDLMbnbsSs2GOxcYOq3k+8
         E1nR8xWf9SQjjTxY6aKGxhsTEZjHaPyl1VfciFCaRPB60HfY8sRK5IPy3D1s0yBAkhql
         f7vVn+b5tEln5GJIaEfV9BobLNHHWuRaOj1AbUwoE9gZu+whg2D7H0QVhwrASC9ADwzb
         NUHxpY+I5Sr9PAgRugQaDeyE4PyXEVD7OgtseTzo/N06Myj2IbKFjE5K8/1/RGwl7vHx
         gbo1ksGWvY4Pa7/UiZ2Y4zYNuYE0rXsCHOQEuP6vSgrCSfA1toOw6iJSGcjNGzv9FcLY
         Ovog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794374127; x=1794978927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fgJmZO4AEsFbJ68zC0SetoBrgVz+A6pXoM39Jxsu77A=;
        b=zltDQTZ5f+U8sbYKvJiNqUzpiS+Xxy5QN3gJRbSNF1l87PizACtAHTasF89fBtjv25
         CaDJRtmvXAl/UtHjlTSWBHJdZ6mp+hoxxw5bGGXpfGaq/sq9wgL7kpNjih/g87KUMjp1
         hNV9AfjPU7GqH9uQ7U5fDg5+Egym4+cfl7wjP1XIGJDX2YZRZN8UT8eQXNPJukISJsdJ
         2NVzE+UubOYANlN0JhtZ69hkH6cIhJ1g/ZFXxydzHNnxN3kQFJNd9AfnYrI3Tm40acge
         mYcH3QRX+nDlPhzy95Lb3fI6yNQDYzOtuz8sxBfa+W+0KzLgBKK/Hm8pI8WCz2MU+P4P
         AoNg==
X-Gm-Message-State: APuU4Z8GVYoL+LCHIh9WP69SI/XEHSU5y2AxYZk+ZLd2N3pN32c55AcF
	FwhXLlGlM6xBLgfzmkyjfex1PNchUVJZ1EIC3oylzXSceaxlXXc1d8lIIKMbwg==
X-Gm-Gg: AYBFou2kFWWE6r8GbPLw61uyoXFvN67q96j3RLv0huOHTUbQJpby5vls+CHxBT6DZ8C
	5jWi2USBjGSKb7jMuyuhK7O43ibNyjl3aWu+77pP7ec8GgWJ3/89M417x1NqbL7l2AUr1h8leFI
	jHxyw/A3B8pdps6CxT9dSZMSFJ+7XeUMFLp56eNjkFc4CB7yeXViRoiOsqazisYdDttBQ33OhWf
	HUj5/C3xP8ZzdV9d7orpdbqhYfDl6qQEga8hN8cqHfCy8i3tQlZ+o18CizzfUwCV1E67U0+ino9
	r6rTgWsNcERedMsb/17maX9u+PrgEG/L+CeF6riFfAIyB7Om68ul9F33KreIj4eZq8tMYgNpA/u
	aCcOn8XyH9SzjFnOsX9zlhL/awZGq5ylaJ8BODQVDpi7cUIRbvoQ82DrY9R0KYTHp8krJ7bNhuT
	RfBV2u6qQAv28ulP7H47/PNHo98XDNiGGjYQsnzRpbrtMS7zgTbRCQ4qmG6UJuG+FAVvuIBj8hB
	osVD4I0cspkLkbkBotdkvJQCqZ2Bor2ExO7dLhMA7UokOXMQCim04d9s4GT+7KDXAKhjyGXO7gk
	Ui1AGTk5pehhLxpIISgZ2yRQ1fvAFgiZMQdNUaouxlJxrOMShbWNkDTdZVU+Ijo6KEa2Tt5uLbY
	eBAYJQBz7dLbnFooqNVmugVgYiMnxt9mgyLqkTK0AB04qmbc7kmIPR7W/VRvv9HNDAM181aS1zQ
	==
X-Received: by 2002:a17:90b:4c05:b0:3ad:6090:a17b with SMTP id 98e67ed59e1d1-3b182eec312mr1147983a91.17.1794374126849;
        Tue, 10 Nov 2026 21:15:26 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b182debb54sm707645a91.2.2026.11.10.21.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 21:15:26 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 17/29] selftests/bpf: Test a pointer computed before its index is bounded
Date: Wed, 11 Nov 2026 05:13:28 +0000
Message-ID: <20261111051341.2800252-18-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
References: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
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
 - The jumps leave no value for the index, base + index is empty: the
   pointer is left as it is. Loads with BPF_F_TEST_REG_INVARIANTS.
 - base + index at a loop header: the add is at the end of an iteration,
   the jump at the header. Negative tests: it holds at loop entry only, on
   the backedge only.
 - In a prog with an arena 'r1 += r2' is trusted once the main pass has
   verified it without an arena pointer (prevent_zext): loads.

The test with an arena is in verifier_arena.c, the others in
verifier_scev.c.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_arena.c      |  3 ++
 .../selftests/bpf/progs/verifier_scev.c       | 29 +++++++++++++++++++
 2 files changed, 32 insertions(+)

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
index 1f9aa7e691be..3588a0a005e2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -3372,12 +3372,41 @@ __naked void name(void)								\
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
+/* r7 is -2 or 5. Its low 2 bits are not 3: the path is infeasible, and r6 + r7 + 2 is empty. */
+LINKED(index_is_empty, VALID __flag(BPF_F_TEST_REG_INVARIANTS),
+	"r7 &= 1; r7 *= 7; r7 += -2; r1 = r6; r1 += r7; r1 += 2; if r7 & 1 goto l_%=; goto out_%=;"
+	"l_%=: if r7 & 2 goto m_%=; goto out_%=; m_%=: r1 += 1;" USE_R6)
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
 
 /* 'int n' in three registers. 'if w3 s> 63' refines only 32-bit ranges: those of the copies too. */
-- 
2.55.0

