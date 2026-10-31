Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793484384;
	b=ys2EC2lS9CUhNF5TsFlwLtsXgzMafLK6Gv+oS7c/TGYSN0jdVO9nFoduclNSg0Sqrog0
	 O013W5m+c8VQdZifTOrrlK0UMjF5LTRbuioZsHKtFsnuBZodaQwfHNjBvPLlBx6JLowKY
	 OeCPHGo6pdDS4z6v/OAS3AHo7GceNSW++Qjr6H3X9y3/7VDuH/RYNA3EPU06OhnpyMfVA
	 bcFBj32zvCMjOa/k0qf4Lqw3clZjj7t9gZK0/53MI+0y/teW9m/Mv6mzdBEFb8HXl1RBE
	 eQqxWS9JQUQ/gq4mP7ctjKypdVMSHbeW30KqCwNP3wzmiIi9ihCiYC1NUcnw5Y8mVlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793484384;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MQf8xVkyJ6BZ1ZQXfTi/DgUep/Woye1fq8Ep49KRHJk=;
	b=iKoU3Pjaoz0iNb257uoDZO5NvLH1LCoxz6lq8cFcv9CevW3nNCIE3vLDRDGAMOvN0Eop
	 bcvhZPbAzrsc8wIICfSKFtPoQwNwcsBVxmiPn3hsw7ozSy2oTwjYUuJKQGy9icDJsqRE8
	 wZG7ysLE90+hh46eVWmL3KKLZ+r34xaZTkly30uYio2vRpnCgPgKwI9Mi8bspWnW94PPw
	 ZTwZmOidJTxg9mZHuOXHLB5w4HbdHTp5rCi9k6VkZUoZQ0Z2PWQCVVcP2HOVolojpozSH
	 7R8VLBUAPx5JyZlopvQjDVY6cdBeSayQmVarVmE5Ddn6XgJh6jzQEdq/K6h4smllQ8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LKUw6Y+c;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A70606A31D
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 22:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4A70606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LKUw6Y+c
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso976027a91.2
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 15:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793484383; x=1794089183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MQf8xVkyJ6BZ1ZQXfTi/DgUep/Woye1fq8Ep49KRHJk=;
        b=LKUw6Y+c2OILXFGq72NOQ8Nn+lCITC9fhBjYPmi5EBX4zwlQX5lo2gGXH6ctgSWZ0u
         1oQpxqmK7+Zr3ztoXJj40VQwsSNirmaQFUpoABNYlbKXvKXpZmITkrijhyxfllUU73Ds
         RzC5DeT6++fQXQt35r52lzvMRf7OXLYxBKPaHNnMqaI6HQ+ggDVz31lf1qSSVU+NOTuz
         fs32V5rHhRl1lp4/F7tiNzSu18bnnlRNxt0tMGc/v1GQRF3jc12JycCZ/x+7JrrUMXjR
         ZSuATO3k93QMgvjLZ/ipY3BkNwuE680FWLIxkabqGlhpQjEFzpVZy9mRIF/rHVUAtzP5
         IDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793484383; x=1794089183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MQf8xVkyJ6BZ1ZQXfTi/DgUep/Woye1fq8Ep49KRHJk=;
        b=WvkOvbuv1sGIwi+nGOLwsJvTcZ4dIw5neJwkgSpPGTCrwvf+1YOTVa1F0ONm42XZp6
         uEiAiA/f2IR0KR1ut3GtJfOCF7xWARmY1vnRYglpzTMhaHfnH6W1t88+R3Wg2dT/T0W1
         oTm4LhDHLU7xJJs4EZkJUba/jeLTRG0DUA74zLccQCiKyqkw8hUnJkqlVcVwJEMZ+TCn
         yexlpQz+i9Nbg9SdhuHvEFEJ/JDttuCvsC542vAQDHGH8DYRqUndzGk/yrvCHp/9yOjz
         Txw3thtZWab3kxy0s3G0Kxc8wQQIhPIbHIuhVWG1C0c4Jhf4diDRqMb+XyLMe9GmMo4j
         L1sQ==
X-Gm-Message-State: AFq9FYIRMhNxMqHbdT3wZeIZlytwMRp9zUIykNIP25FKXdZ91+DUtd2L
	nfw9+XXcDKoKh8NXIIzr7NB+Zj+tXYo0Vr84H0AHPPZTdXS0oo6Vl3yiA/VSjg==
X-Gm-Gg: AYBFou3cMq9TVYBti2p2zNzQ/wANM+jX9/nj1evVtdpaIIsqwchUYKZkJJe7bAnD8te
	b3SGTfWYBZSc3mJ8noUarxRV+YmCKiLJXa6PKVCpDvBiiK8hoqcgJHo7CBxwKaNYWi1iY57jUrI
	95Br8F3NmUDvS08JWTBdyqzFPfuVZigC11A2udSaqJkdQBL8VzPGKzdXrEwt+A8s7/pJJ4Ckyxv
	CYjPbT95k5kk4qh+uf6B/NhfWIuENUxyutKebo7Z5Uv26ty0GDwv3x8CuzKUlytgvhsK23jgzHb
	GR2z+H4UI2BWa1DT0/up6zL8BRRsg4PQxJ3w945ldy+v5c3juLIxmqfNgKYkZG0n5+kVMf02KJ2
	ne1iHuXws5IxirH/ITkBExF8kS/iTvpT13s01PjVTONdRDXlc4CYyOk6Q5CKbYDVTSJXmFy8fek
	KwVxPVCHYwLszb/qsrKLe++x8/QrgrEXbYtlsed26ivjvgWf1se4YBPjDw3bFUvwX+c6V+JpPc+
	yOxxqsqR0qawWEVwj52RyL622zrMMkWI+CiJrbt+PGJbA3P2FfYoPRSBZ6XfT4vE3qPBfwVaUu0
	tPff4sHjQhrNpjBM6N8x+oRv1NS3XOkn4c6bXTL5U7ltptVnBzBb9srDTcD4w6nnto34uezITJl
	a42no3SeU8/okQLRTXaBDDsaykDSkFx2ypCji3cwS3j5Gx1XozvrxiPpDFmKnKvvbS+yNweSFwB
	3e0Ej4AN6ow01DWjegMNk=
X-Received: by 2002:a17:90b:534c:b0:3a0:abc3:afb5 with SMTP id 98e67ed59e1d1-3ae897f5d26mr4778190a91.34.1793484383010;
        Sat, 31 Oct 2026 15:06:23 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb096e9f87sm1801957a12.16.2026.10.31.15.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 15:06:22 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 1/2] bpf: Fix the join of fp+0 with a value that is not a pointer to stack
Date: Sat, 31 Oct 2026 22:06:14 +0000
Message-ID: <20261031220615.804426-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261031220615.804426-1-alexei.starovoitov@gmail.com>
References: <20261031220615.804426-1-alexei.starovoitov@gmail.com>
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

Before the main pass, arg_track follows pointers to the stack through
registers and spills. For each insn it tells which slots the insn can read,
which slots it can write, and which slot it writes for certain. Scalar
evolution and the removal of dead slots rely on the answer.

Where two paths meet, a register can be fp-N on one path and not a pointer
to the stack on the other path. There is no value for "fp-N or not
a pointer". The join adds a fake second offset, fp+0. With two offsets no
store through the register is a certain write:

  join(fp-8, none) = {fp-8, fp+0}    two offsets
  join(fp+0, none) = {fp+0}          one offset: "exactly fp+0"

fp+0 is a copy of r10, or the end of the top object of the frame. For fp+0
the fake offset is the offset itself. The result has one offset. Then
a store counts as a certain write to the stack, but at run time it can go
to other memory:

  r7 = r10, or r7 = map_value + 8     ; arg_track: exactly fp+0
  *(u64 *)(r10 - 8) = fp-24
  *(u64 *)(r7 - 8) = 0                ; arg_track: fp-8 is overwritten
  r8 = *(u64 *)(r10 - 8)              ; verifier: fp-24. arg_track: none
  loop:
    r1 = *(u64 *)(r10 - 24)           ; the counter of the loop
    ...
    *(u64 *)(r8 + 0) = 4096           ; arg_track: not a write to fp-24

Scalar evolution does not hear about the last store. It gives the counter
the range of a loop that only increments it. The prog loads, and it
accesses a map value out of bounds.

A valid prog is rejected too. A slot is dead in front of a certain write.
A prog that reads fp-8 after the store through r7 gets:

  reading from stack off -8+0 size 8, slot poisoned by dead code elimination

When the single offset is 0, drop the offsets. The result is a pointer to
an unknown slot of the frame, and all updates through it are weak.

The price: an access through such a pointer can read or write each slot of
the frame. Then scalar evolution cannot count a loop whose counter is in
the stack. Veristat sees no difference in selftests, Cilium and sched_ext.

Fixes: bf0c571f7feb ("bpf: introduce forward arg-tracking dataflow analysis")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/liveness.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index e657e6d95408..db01aecdffba 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -976,6 +976,19 @@ static struct arg_track arg_join_imprecise(struct arg_track a, struct arg_track
 	return (struct arg_track){ .mask = m, .frame = ARG_IMPRECISE };
 }
 
+/*
+ * 'a' or a value that is not a pointer to stack. A single fp-N gets a fake fp+0,
+ * to keep stack_use and prevent stack_def. fp+0 itself would stay a single offset.
+ */
+static struct arg_track arg_or_none(struct arg_track a)
+{
+	if (a.off_cnt != 1)
+		return a;
+	if (!a.off[0])
+		return (struct arg_track){ .frame = a.frame };
+	return arg_merge_offsets(a, arg_single(a.frame, 0));
+}
+
 /* Join two arg_track values at merge points */
 static struct arg_track __arg_track_join(struct arg_track a, struct arg_track b)
 {
@@ -1000,20 +1013,10 @@ static struct arg_track __arg_track_join(struct arg_track a, struct arg_track b)
 	 */
 	if (a.frame == ARG_NONE && b.frame == ARG_NONE)
 		return a;
-	if (a.frame >= 0 && b.frame == ARG_NONE) {
-		/*
-		 * When joining single fp-N add fake fp+0 to
-		 * keep stack_use and prevent stack_def
-		 */
-		if (a.off_cnt == 1)
-			return arg_merge_offsets(a, arg_single(a.frame, 0));
-		return a;
-	}
-	if (b.frame >= 0 && a.frame == ARG_NONE) {
-		if (b.off_cnt == 1)
-			return arg_merge_offsets(b, arg_single(b.frame, 0));
-		return b;
-	}
+	if (a.frame >= 0 && b.frame == ARG_NONE)
+		return arg_or_none(a);
+	if (b.frame >= 0 && a.frame == ARG_NONE)
+		return arg_or_none(b);
 
 	return arg_join_imprecise(a, b);
 }
-- 
2.55.0

