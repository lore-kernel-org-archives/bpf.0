Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794206904;
	b=FDXL1z97lRb6NNRNZRV5jHTGOytHyHtDq9WIIyaxQA+Qt331ZUT+b6ih/HQc1QLeJp/p
	 skSX9ZnO4uKU22cmU0b9BInE53bdUWBTaZT/UdHEqNG7jA1sbTs+E5uBo1q/y4ARdQ8za
	 AIUtQZx5Y3vdxnyd03IJ8AkpQ9f7xsiL98VbcWn/sRi8+mIOMpmSAD6L2XLRDsicuI4CV
	 iPE00IBt/BiDerG5BzBGUkgPKcHrGfzPB790f1urJTE4IqAd+nFWshyr/CxzI+IWyIq7n
	 cDcK9LP6cTvySILp+mAqaxX+DKnPoc4e8QFCaWyuWf8YZgw1DnArBSTgpyoeqESTJDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TFkOTbaH5h93PUAjrWSBGidbhek4et0s9TiTQkOx1gs=;
	b=m1L2CBr7+HoVk4QsfoHV9VLIppjVFPeJKVYbBy3J3S9DA4LEvxexACnk/MpRTRCtD44i
	 5DkvBdhsyTVvjJpvbTvjbh1Pcyd5fCdGcREqOB6B5Na0YBbNsU4s0QS9bEN/aXSSxDkui
	 h7cJoohHxcdmD59rAjoc/L86yYznUTD6lRurCwu+GNm8d0vHhLepoN7G0vScbVkqecpHa
	 p2L3CG8rYv9V8IaoVWN7+5bdzKmlcJtrgNw/rqigRR53tJq1gGsaq3mM1tggsvBjO6MxM
	 sJmlDyr5MTOqCsCYGaP9cGN44bJk85QqP6brIu5S5EToS1PINRQYjvxGiZkabZ2cIkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jrj3lY5U;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBB9606A321
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 06:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFBB9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jrj3lY5U
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8b612fd74e1so146884b3a.0
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 22:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794206903; x=1794811703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TFkOTbaH5h93PUAjrWSBGidbhek4et0s9TiTQkOx1gs=;
        b=jrj3lY5UWAdogCpK9iFGjMAzaXtgFHE8Zq6zOkmVA6cp8NAfOWyZqZedGREOAWal4I
         XFMqjTLzphG0izCvukLl+teBPnBtVxnZlbbYUyS/ZCa1pa3SlEILnQCMcXDClw4daCZX
         q/9FQBT0d3fFPjoj5XpA8MK9noUKW34tU7KZ/NO+KAC6NIEkC8ohpwYfY9yviHDLUflw
         /bfzLNyVpWvXIoVeHS6cQiwsFS5rgYhyB6eu5fvfgenB8UGAWXYB2j2mKfGUCwjXj/vP
         KbQBZ2m0jKVNq5BT3WQHlS7eQHYN9KRuygfWVBuMK6ZXb+k6DB5MvpXyEqGYr7OcBYbn
         wemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794206903; x=1794811703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TFkOTbaH5h93PUAjrWSBGidbhek4et0s9TiTQkOx1gs=;
        b=pf6X4VZn49ihzyMr8L4rfJilQjIuAvl7OkF7BANkU5uFp/KZoHPqrjCRXsQuEUMF/7
         DySmj07yzRBRbTdxODCXcODr/Ys+qYVDDgw8RiAWhCrvuLytBbYt7T5Z8tWw3Izm8/y+
         XpirNQ0vklVIeZcyZ5wopkMBlG/U8pOjfG//SDOLM8nYOMdWL904IkSNybvAHKr1l4wL
         BdJikzst124hXQnLunLHnVA4wEyi1hXSzoyK/VzgKOZxGGvCDxJpGGXdmSMvr1c2YRmV
         EICPvG+Ti4qJJNZB9SzlxNFD+LNOhJgBn002NDiE8CLzxBUSMDOKpkrxSRoivINyyWvM
         6dHg==
X-Gm-Message-State: APuU4Z8P3YBMfjRtBojw2W87kmyxpB+ohk1UkrL22DjPm6JQyCMV/n/N
	Ivu84rufgJrjyOR1etBTUg73mb1qeM0lub7J3PgeGxoK0hJATLi33pERdGJ+lQ==
X-Gm-Gg: AYBFou0hMV046rZQF90JmA+Dc9fT5TwkDuLXBLcjHZY95BzhDr1Ga/7+xffJPXwPM+d
	+ERrh3vd+IJhC60Z0nWkqdMYGGZAX55ldhjRiBGv99wXEAtz6GJlQeoQ9q+pXAuyi1TSgTDsdRh
	Wrqxui/WhjgJ6AKumS6wQps5EAdHGWpsyXY6tgOPEDrQR3UR3ussqjNGAlnHzNtYnDxpOEx8zLc
	l30WbS41ztzYS7NvWr3t53BnCE4+PSWeluokQ+9l3tWQ2bXOUItq1VoclJ6o1E2k8ZBxjrZwgHr
	sTmNw47gkK36iZuytJ5Esr3aLaZVQEySv1fc3gAix81uFivfq964ICT1OdO/3N6T0mgxrclj6ov
	XAe5WnXvD50Qj/GAfX60vefofM9iDqRi768eY5b/Wlonz6yMWbQSHABoDDLeRlCOv5STYHXjomv
	I5+EWvLQ2jxVIpot37YRkG/zmW1PNlakv52smGcRgThq4G/tE8WIb/izeyQXvN/JbN6FTTJxES5
	aGdaEerGq+xtXgbBCnJwmEMQHwHQUN9cmX7T2G9EQka7ua4VgDJC2vFAh2zdGbGWzxrpNcpmvJ9
	RFgH9ClYq6peZoh7a7dl9PY+oiu26kLEkYd3W5Z1BgPi4qehxe1cVOVkPsylWOHfsUYUxi/csjF
	4sj3ZB6Inhzu4Z3Itt516je5ZARu+SBrYXo6ZHvlAYfFA8huYkrg5w7FROwu/jRDCLwpNTkTpcg
	==
X-Received: by 2002:a05:6a21:8201:b0:3e2:ac91:6bae with SMTP id adf61e73a8af0-3eed56db60amr3284407637.85.1794206903045;
        Sun, 08 Nov 2026 22:48:23 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb96923071sm1201266a12.16.2026.11.08.22.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:48:22 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 11/26] bpf: Don't treat half of a 64-bit spill as a 32-bit spill on big endian
Date: Mon,  9 Nov 2026 06:46:55 +0000
Message-ID: <20261109064715.2382452-12-alexei.starovoitov@gmail.com>
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

A fix of the main pass for big endian that stands alone. The patches that
follow refine more registers and stack slots at conditional jumps, so more
progs would run into it.

	*(u64 *)(r10 - 8) = r1
	r2 = *(u32 *)(r10 - 8)

r2 gets the low 32 bits of r1 on little endian and the upper 32 bits on big
endian. In two cases the verifier gives r2 the range of the low 32 bits on
big endian too.

The fill itself is right: check_stack_read_fixed_off() asks
bpf_stack_narrow_access_ok() where the low bytes of a spill are. A fill
from elsewhere gets an unbounded scalar.

After the 32-bit spill '*(u32 *)(r10 - 8) = r1' the half-slot at r10 - 8 is
STACK_SPILL and spilled_ptr describes r1, whose low 32 bits it holds on
both byte orders. Two functions take a 64-bit spill for such a slot:

 - __clean_func_state() marks a dead half-slot STACK_POISON. If that is the
   one at r10 - 4, what remains of a 64-bit spill has the slot types of
   a 32-bit spill.
 - stacksafe() skips the bytes that are STACK_MISC in the old state. An old
   32-bit spill and a current 64-bit spill are then compared by regsafe()
   of spilled_ptr.

That is right on little endian, where the half-slot at r10 - 8 has the low
32 bits of a 64-bit spill. On big endian it has the upper 32 bits.

Keep such a 64-bit spill whole in __clean_func_state(). In stacksafe()
compare two spills only if the bytes of the old one are the low bytes of
the current one. bpf_stack_narrow_access_ok() decides in both.

Two tests in verifier_spill_fill.c, one per function. They load on little
endian and are rejected on big endian.

Fixes: be23266b4a08 ("bpf: 4-byte precise clean_verifier_state")
Fixes: 6715df8d5d24 ("bpf: Allow reads from uninit stack")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/states.c                           | 19 ++++++++++++
 .../selftests/bpf/progs/verifier_spill_fill.c | 31 +++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index efc0870b85c2..b60676349655 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -168,6 +168,16 @@ static void __clean_func_state(struct bpf_verifier_env *env,
 			    stype == STACK_IRQ_FLAG)
 				continue;
 
+			/*
+			 * When the half-slot closer to FP is dead, what remains of a
+			 * 64-bit spill looks like a 32-bit spill: the low 32 bits of
+			 * the value. On big endian the other half-slot holds the upper
+			 * 32 bits.
+			 */
+			if (hi_live && bpf_spill_size(bpf_stack_slot(st, i)) == BPF_REG_SIZE &&
+			    !bpf_stack_narrow_access_ok(0, BPF_REG_SIZE / 2, BPF_REG_SIZE))
+				continue;
+
 			/*
 			 * Only scalar spills can be degraded to raw stack bytes
 			 * when their high half is dead. Pointer spills need the
@@ -446,6 +456,15 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		if (!cur_slot)
 			return false;
 
+		/*
+		 * The old spill is the first bytes of a wider spill. On big endian
+		 * these are not the low bytes of the value.
+		 */
+		if (old_type == STACK_SPILL && bpf_is_spilled_reg(cur_slot) &&
+		    !bpf_stack_narrow_access_ok(0, bpf_spill_size(old_slot),
+						bpf_spill_size(cur_slot)))
+			return false;
+
 		/*
 		 * 64 and 32-bit scalar spills vs MISC/INVALID slots and vice versa.
 		 * Load from MISC/INVALID slots produces unbound scalar.
diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 0baa8e06b8d1..623ed5ef3630 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -1451,6 +1451,37 @@ __naked void imprecise_scalar_spill_half_dead(void)
 : __clobber_all);
 }
 
+/*
+ * The first half-slot of a 64-bit spill holds its low 32 bits on little endian only.
+ * The test spills to r10 - 8. The first four bytes of the slot are an offset into one byte.
+ */
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+#define FIRST_HALF_IS_LOW	__success
+#else
+#define FIRST_HALF_IS_LOW	__failure __msg("access may be outside object bounds")
+#endif
+#define FIRST_HALF(name, stores)						\
+SEC("raw_tp") FIRST_HALF_IS_LOW							\
+__naked void name(void)								\
+{										\
+	asm volatile (								\
+	"call %[bpf_ktime_get_ns];"						\
+	stores									\
+	"r7 = *(u32 *)(r10 - 8); r1 = %[single_byte_buf] ll; r1 += r7; r0 = *(u8 *)(r1 + 0);"	\
+	"out_%=: r0 = 0; exit;"							\
+	:									\
+	: __imm(bpf_ktime_get_ns), __imm_addr(single_byte_buf)			\
+	: __clobber_all);							\
+}
+
+/* The low 32 bits of the value are 0. The second half-slot is dead after the jump. */
+FIRST_HALF(first_half_of_spill_second_half_dead,
+	   "r0 <<= 32; *(u64 *)(r10 - 8) = r0; if r0 == 0 goto out_%=;")
+/* One path has a 32-bit spill of r6, whose low 32 bits are 0, the other one a 64-bit spill */
+FIRST_HALF(spill_of_64_bits_vs_spill_of_32_bits,
+	   "r6 = r0; r6 <<= 32; if r0 > 5 goto 1f; *(u32 *)(r10 - 8) = r6; goto 2f;"
+	   "1: r6 = 0x7ffffff000000000 ll; *(u64 *)(r10 - 8) = r6; 2:")
+
 /* check valid spill/fill, ptr to tp buffer */
 SEC("raw_tracepoint.w")
 __success
-- 
2.55.0

