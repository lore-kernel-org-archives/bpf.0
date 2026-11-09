Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794206892;
	b=5cxjTIKsV8Rq7jhpUuVTCTqwXdO2SI9pXe2BSfO9wj0hJ1hHCBwVL5twDQxSFaZZ5GwA
	 PQ4uSOGbDouMaaDXu/h83++SEfgHkVpT4QDLnW6sErsYTk4UPszspLSmcNQab3+D5glip
	 BbEvZ9zWo6mxEE2vcPdbWgABd57VMClASBFBP2XvlmDeC7B72S1CSO8nF6yz1eHkqgRu9
	 Xum4OaHrK1Kub/rGzyb2cZ2YmquWtisYqCJArnA4hJ7Ur2C4+NU9Q617NCMmoT73abM9o
	 gdr0+B/6T3YiFSfXkudb52JZ+6X+UlED23zSkR+oBSzj2QHLRbveGqoIOMVrZm5/c5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206892;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4G/1R2L4eDRS/MqtAT4k2oxCENHQjtwu4fAb9VTRtto=;
	b=p/MDC3afXjRnKLOszdt6JOPJuITmJ51ru/WKoDsm0Nqr5KaWokJ7fPII035dNJgHPmO1
	 Is2XQiCzsrkddH0SKTksDzEfEdxEph4UBzNmvHl3yNU8eE3gMlVf5xRXB0cAWQe2nMhM7
	 VaIOHSuv1IFvvqYGCMpnexHw5X9bKiPEiVxCbuxU4WkpiUp6VjSR7mc3U1KxVAroFq+sc
	 fBl8r7uX0Zg2qYrzmJpa21c2AqxT2D8/UAI9LLq/nKZZ1PFI08nCNX+B/Sx/mrrF/0lbs
	 R3u0t+aTnHq5GQMm8h5bqY1BLQa+GA0XKrCbujUvXeoF4DrTUobh1UCUmgTEr4CFhZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TMpjM3M3;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4098B606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 06:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4098B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TMpjM3M3
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b0d0b80fb9so270389a91.1
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 22:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794206891; x=1794811691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4G/1R2L4eDRS/MqtAT4k2oxCENHQjtwu4fAb9VTRtto=;
        b=TMpjM3M3fl8Lm/+uF4/ga32sNaL0jjCl+p7GLU+OFY290apxxI+uVy+Z2V6z/omL1v
         dfKhBh4Dim5bn/VBjK5T7m1nuNk6xvdl10+AlX9jP8sc0DO4uq6BIXOIQUhP2H1OVQ8+
         emanyrXU55nERQd3oLV43jZ3ULPqvvNWyIpwmNDdUnqGXSwdNI+9Gf0LGb7OtxNr/Npx
         mmYdTU8gx4rFSImh6kEnwCc9Vft8P8fEqPMTXt5JBolj8EGJm6ithCxapUiBY+kznr9u
         EDCvomPZLcpwXbgXa98OqcPzICNxhA5yqUF9tQvnK+flZ8eDil782fGTYphR+Iq1oJ2g
         vKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794206891; x=1794811691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4G/1R2L4eDRS/MqtAT4k2oxCENHQjtwu4fAb9VTRtto=;
        b=EUav1ara++JD8ExQ2j9JsQ9Kz95eTzfT+ZzZjAShQKYXZXTdqdfpEvfKhLZ9Tb8hhT
         91C6XjG8Kej1FhA7qmHk3Gn16DhwCAaC8pUjOw7ffpvF4fN3rBCcrp71IMsMXRPWcxoD
         K1lwzLDzMWp/VZ9PNIPlZoXFQkV/sszYTI9Yxc9qVqUkxXaFTVAMmKSle+WFvTsgmNMG
         sH+FI/WGUnJKDw7qzIvjYTNuFB8YG3jR0PHI+zVi6aH786fMpnA4OenRxvTjkTYzUdEY
         Xvdo8OGeqkGR3Ngv98XGquTyJvRj/a9OV3MQFtnjof7pyibbuKl7fLKOU5UJrqrJOEec
         vK7w==
X-Gm-Message-State: APuU4Z8bwUptaQ7ZEbDlNYWwTQgPC/8kO+Lvu3VeyArOcYjo4D9bb3Iu
	3nql1kt2rEv2C4AY3PglqA/j+RambOQNGYBgydV1oj6f7G8WfSRseqyGkhvZ3w==
X-Gm-Gg: AYBFou3x1BeWoRZCsvewpRL7VIcu5wbvuQh/evyRqeP9imU+hlBC+kdU79+IHQBh5AO
	DsRHUIvi1bmmnp2BHZiWdEEfVSr6ervJ3bNMiTL63ykaPoYu6eVBMh57X7PzNZhmXq87Bc2UONX
	XlVKdLAHo5mMcb/zDDAHqE/ZxS+dfBifwurKniRFlGd+10xOVzoFkj2Cfqe9iJ/MNAUlQl4bCAh
	LUc61gy2CvSC0j9brPjM87fj+tzKDkyd8Ney6aFoV8n7mDNUd8ehbXhqwGcCt7XrTZUs3+yEdZo
	sxxXC8haSQBbzuTM6uSrWHhJ4YVvP51kuk/d1KiHluoIv0hz54k9UlB/jf+W9g0EfTjf6JLm09H
	oPgcCqtTXFgN5YOusJHR6wpAPj8/AQQWCkLkJg+7uMw4/22S0YXaexMJGgEp4tEnO/OvG903qQg
	uTBfUcti1uaMAg0OR+pcAPCgvKlNpqMJDv6hRl1754dU14GO0IOd4NgUEMkvkBfW/sv+ZJ4V9QL
	zP3rX2a9dDEkDWbFYZeZ16rWgQtV8Rud7qsrnLYbie7kjhEhR9oA5nhsnoVKwJlqs3m3O6/8Lak
	gxDiskNmGAhX/AtquZBdCMx8wKnnl4LNAtLjOekcp1JsJ2dGyBdyYQXsLtLCgu8mOmypWGPQO9A
	H+5JCnZXeHH87B4qqSH8hY0EPFBGlWX4VkBA2uwYxKAdhbRaBf9JumeHLmruAatoq1aLePGmJJg
	==
X-Received: by 2002:a17:90b:3910:b0:3b0:ada3:b505 with SMTP id 98e67ed59e1d1-3b12d442ae3mr3213638a91.19.1794206891319;
        Sun, 08 Nov 2026 22:48:11 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1279158c4sm5783883a91.14.2026.11.08.22.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:48:10 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 09/26] bpf: Check writes to the stack against bpf_may_write_mask()
Date: Mon,  9 Nov 2026 06:46:53 +0000
Message-ID: <20261109064715.2382452-10-alexei.starovoitov@gmail.com>
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

A consistency check of the verifier, no new ability. Scalar evolution
trusts bpf_may_write_mask(), the stack slots that an insn may write, and
nothing checks it. The patches that follow refine stack slots at
conditional jumps by their expressions, so more is going to depend on it.

	int n = 10, v;

	for (i = 0; i < n; i++)
		bpf_probe_read_kernel(&v, sizeof(v), p + i);

With n on the stack scalar evolution computes the iteration count
(header_count: how often the header is executed) if the call does not write
n. It takes that from the mask of the call. liveness.c computes the masks
before the main pass: it tracks the values derived from FP
(struct arg_track) and looks at the argument types of helpers and kfuncs.
A counted loop gets no may_goto, and i gets its range from the
iteration count: nothing detects a wrong mask later.

Let the main pass check the masks. It sees every write to a stack with the
offset that it has in the state: a store in check_stack_write(), the memory
that a helper or a kfunc writes in check_stack_range_initialized(). Compare
the slots with the mask of the insn. If a subprog writes to the stack of
its caller it is the mask of the callsite in the frame of the caller.
A slot that is not in the mask is a bug of the verifier: verifier_bug_if(),
"insn %d writes to fp%d outside of may_write_mask".

The state can be less precise than the mask:

	struct st *cur = &first;

	for (..) { ..; cur = &rest; }
	cur->last = 1;

The mask of the store has two slots. cur is spilled, and at the loop header
the two offsets are joined to a range. So if the offset is not constant in
the state only require that some slot of the range is in the mask.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c                         | 36 +++++++++++++++++++
 .../selftests/bpf/progs/verifier_raw_stack.c  | 35 ++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5bffc1e288f6..ae3b751b99a1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4327,6 +4327,31 @@ static void invalidate_stack_slices(struct bpf_verifier_env *env, u32 frameno,
 	}));
 }
 
+/*
+ * Scalar evolution takes the may-defs of stack slots from bpf_may_write_mask(): a slot that is not
+ * in the mask holds the same value before and after the insn. The iteration count of a loop depends
+ * on that, and nothing detects a wrong one later. Here an insn, a helper or a kfunc writes to
+ * [min_off, max_off) of frame @frameno. For a frame of a caller the insn is the callsite. Without
+ * @fixed_off the range can be wider than the mask: two offsets become a range at a join point. Then
+ * the write is somewhere in the range.
+ */
+static int check_may_write_mask(struct bpf_verifier_env *env, u32 frameno, int min_off, int max_off,
+				bool fixed_off)
+{
+	struct bpf_verifier_state *st = env->cur_state;
+	int idx = frameno == st->curframe ? env->insn_idx : st->frame[frameno + 1]->callsite;
+	int spi, first = bpf_get_spi(max_off - 1), last = bpf_get_spi(min_off);
+	const unsigned long *mask = bpf_may_write_mask(env, idx);
+
+	spi = fixed_off ? find_next_zero_bit(mask, last + 1, first) : last + 1;
+	if (!fixed_off && find_next_bit(mask, last + 1, first) > last)
+		spi = first;
+	if (verifier_bug_if(spi <= last, env, "insn %d writes to fp%d outside of may_write_mask",
+			    idx, -(spi + 1) * BPF_REG_SIZE))
+		return -EFAULT;
+	return 0;
+}
+
 /* check_stack_write dispatches to check_stack_write_fixed_off or
  * check_stack_write_var_off.
  *
@@ -4345,6 +4370,10 @@ static int check_stack_write(struct bpf_verifier_env *env,
 	int max_off = reg_smax(reg) + off + size;
 	int err;
 
+	err = check_may_write_mask(env, state->frameno, min_off, max_off,
+				   tnum_is_const(reg->var_off));
+	if (err)
+		return err;
 	if (tnum_is_const(reg->var_off)) {
 		off += reg->var_off.value;
 		err = check_stack_write_fixed_off(env, state, off, size,
@@ -8032,6 +8061,13 @@ static int check_stack_range_initialized(
 		max_off = reg_smax(reg) + off;
 	}
 
+	if (clobber && access_size) {
+		err = check_may_write_mask(env, state->frameno, min_off, max_off + access_size,
+					   tnum_is_const(reg->var_off));
+		if (err)
+			return err;
+	}
+
 	/* Unprivileged outputs retain each byte's initialization state. */
 	if (raw_mode) {
 		meta->arg_raw_mem.size[arg_slot] = access_size;
diff --git a/tools/testing/selftests/bpf/progs/verifier_raw_stack.c b/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
index 0fe631411b9c..d0975a28a243 100644
--- a/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
@@ -125,6 +125,41 @@ __naked void stack_skb_load_bytes_init(void)
 	: __clobber_all);
 }
 
+/* The pointer is fp-128 or fp-96. At the loop header the two offsets are joined to a range. */
+SEC("tc")
+__description("raw_stack: store to one of two buffers")
+__success __retval(0)
+__naked void store_to_one_of_two_buffers(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r8 = r0;					\
+	r1 = 0;						\
+	*(u64*)(r10 - 144) = r1;			\
+	*(u64*)(r10 - 120) = r1;			\
+	*(u64*)(r10 - 88) = r1;				\
+	r3 = r10;					\
+	r3 += -128;					\
+	*(u64*)(r10 - 136) = r3;			\
+l0_%=:	r8 *= 8;					\
+	if w8 s> 100 goto l1_%=;			\
+	r3 = r10;					\
+	r3 += -96;					\
+	*(u64*)(r10 - 136) = r3;			\
+	r4 = *(u64*)(r10 - 144);			\
+	r4 += 1;					\
+	*(u64*)(r10 - 144) = r4;			\
+	if r4 < 3 goto l0_%=;				\
+l1_%=:	r3 = *(u64*)(r10 - 136);			\
+	r1 = 7;						\
+	*(u64*)(r3 + 8) = r1;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 SEC("tc")
 __description("raw_stack: skb_load_bytes, spilled regs around bounds")
 __success __retval(0)
-- 
2.55.0

