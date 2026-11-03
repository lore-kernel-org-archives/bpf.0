Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749292;
	b=gmJ/rz7XYCqS8Ka+AsGB7ndDrxsEm58VQ4p2tNhis18yOVKy0a8c9oYWK3+xTKFOu6I0
	 XCFE092etiqxBpDMct3A1eb2rxcMxWASPdJ+yr4dip1eCdlvrlYNNjsNNOsbxxwrSjkce
	 rq9OcNOXdnWJlhfasXN7dWGRSHhDXek40i6Fx8BXkQdxsfMp7cnP3wY6Vt2VZaTFDXhNS
	 XD80c45GWSVXalIDfLfx7QxgmCk1u+O0l0py8Shpare45dh0iry/TuSD1wjnIjttwFtXT
	 91SCQUgnkzXXW3bgNg+dOSgRFvWMTfFN5a6BHbpXqtTAyHQaSFin25+O3HFxuwAaRhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749292;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tBdJDIYNq0yh2yirDO1LcyjNGf5PBxMQXmdlNg08he8=;
	b=MIhy8J/lYO6kB+L6xSLrRCkOAe9gqSBkh+SfTxS6KTUl//1SBTQzT0IhdTz8Dylo+r6b
	 4a+VkUrQ4yW1YZGosFZ2QGzR9a1tv0CJIO/qcOXR3qjprUsDJnhx0NPfV9vBnNKWk33hy
	 xzLeD9i53FIZ0tVG4ufb5mNwi0Mhnfpu2AezRCa9tR+L/FhZOMuu1oIgpct9eOFn3nFCj
	 Fh5iqEoi0yYW8hSeAhvlKCD3jNHcCww2Fhw851NWKL6TraURXJyal5hqGqqWwh8NxL6IN
	 02nJyfiY7aH4Nmq8M1fGXNW4jJH3dTyB85+gqSJfiRa1En3oPkfO3DAt9W+DTDsnx1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V5MUlHbp;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0437606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0437606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V5MUlHbp
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a06210b29fso82096b3a.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749291; x=1794354091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tBdJDIYNq0yh2yirDO1LcyjNGf5PBxMQXmdlNg08he8=;
        b=V5MUlHbpJTRl/z7vTtLTIyzxy+3A4W5Z1j1VmSNKLzTHr5b9+252QV3M5UmSvjQdVc
         QYedbDUR96AzPZlupjV9TDaWKJHztAdVHsuJCJpfCOlRYwn+t6xpeIjzI092XpxVVoQR
         gSq8X5zDv4kwMydwyXJA5934Yz2MHOF1IKpGM1r90I0xidwGxkfZeX9wjaDVu4dWYRAJ
         q4aOmkenpsUv20CjsvGZqYXi4eEY//Otp5tJFzDF2tz0mmY5omfr7pqa2MTIXgV/JazH
         6WfS7rReYX6NLAqKhRKVULO8W1pq3zRuVnCqGpoXjGegkUisQL5WiRTMdLUggKohH9mJ
         7o9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749291; x=1794354091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tBdJDIYNq0yh2yirDO1LcyjNGf5PBxMQXmdlNg08he8=;
        b=oxn6aVJQfsT+nxbwM1xwrO0HXEVgMqJBITNN6YgGdfugq9Yd1ObVgBNmSmVl9mRTvL
         ScMv2S5u3LI7STl6ao/8rc224PlzSaTfImz10bCquKp7RfOYRXOk3VUC0CyF9YL7GJEl
         QOBbT270yyTU347yodinn8BTmF0u2QFjfP1DMV0mc9ne3nTLlKKepOL7UKxoHUQqua3s
         wIYjym1YKbCj7zwo60dOh41eyszUOeQuucP2vgpSwzpDVNA6oidERat0LT/32KOTFu5O
         vVyRH7glOOYN1ahyQ2FG7ejHmXB9jwLMq2m5Z/U4kNgWjCXOJI4nd6KEE2NmZAbfh5Aq
         UyFQ==
X-Gm-Message-State: APuU4Z+aH4eMLN44aKos23elUDuSf9yeG7DJ8a9NH6IrgjxWX4tn3uZO
	mQihNXG3iRu3McCFXJTGiPfqXPMnPLwE6kHz8BV41HK3bO7C4NW9cUHVtliydg==
X-Gm-Gg: AYBFou20mqpu2mXoOIl2aluR54vTCsk4D3ZBZVef/TqGLP3jv90gC1dBBygF6y++Mm7
	hTuWMZMXwZ9pwtVc8UQy+rSw+ufCITp5Z1dusRZa8jvI8K29NjxKExyEQgnmcPo2ph0U1Va1dF6
	Cy+4u6Zan8poQB0W+YUkYOlNxK0J/5HnL+4UwMiS+GQIXF3hkTUrELgwo2XDsudGMi7eNlO6F7U
	tWl4gL/xnnd5ZnumHUktm9Eif6Zy21AhImRxUMCuOTWerrfPNwV2CbYTIC7k7OAAP8w2Ef+HSvA
	hJmSCMT/6TDaxN/KyKj/ezfTk+q6kG2b8TK5CMLHtBOl/Fcqnr6oH+2QgsB59AFOBGyDO5OIWeh
	+fCr7m50Dw27O+wBvDrArpsSyqziBafC2ElVAiF7C06+0NKWb6Hs5jEdWSotPUIK6em0wycc20c
	J3Lg5TBpMp+A882kbL8bgceTTW88GegHRYgoNiT65oLQYQjYipzzpR90gI+tmxGMRYmqpoe8pkF
	XbOGDJun6bTd07r6bTrrrT3MqFtlar9tmyyFx/UlaInOx1ELB7at6sUEpfWZQoPh1o9MncBbJcd
	h1El2De/E+oOt+2ObjI6b/qBgOfzyxkJjyipddcYV7DV/gO26CDgr29YMAkSs4C4N1aeDtGAyvA
	sCvoZ0K5tGfz/htuejG13RwFcGcuhkXe/wko57fKzUDF+m94btnr4tZLd2W/7EeIiOCnXPtr3rg
	==
X-Received: by 2002:a05:6a20:a126:b0:3e1:c716:3a00 with SMTP id adf61e73a8af0-3e928dc7a79mr13996278637.53.1793749290627;
        Tue, 03 Nov 2026 15:41:30 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb4ba7d488sm21837a12.15.2026.11.03.15.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:41:30 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 04/37] bpf: Don't trust BTF of a static subprog that reads more registers
Date: Tue,  3 Nov 2026 23:40:29 +0000
Message-ID: <20261103234104.208239-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
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

A trampoline saves and restores the argument registers that the BTF
prototype of its target has. The prog that is attached can clobber all
other registers.

BTF of a static subprog describes the source. It does not describe what the
compiler passes: the code can take more arguments than the prototype has
parameters. rustc, for example, adds a hidden pointer to the result.

Thus the verifier compares BTF with the registers at each call of a static
subprog. When they disagree it marks BTF as unreliable, and a trampoline
keeps all of r1-r5. But the verifier examines only the registers that BTF
has. A subprog that reads more of r1-r5 keeps reliable BTF:

  BTF:  f(a)                  the trampoline keeps r1
  code: reads r1 and r2       the caller's r2 is lost

With fentry, fexit or fsession attached, the subprog runs with a value in
r2 that the verifier did not see.

Compare in the other direction too: BTF is unreliable when a register of
r1-r5 that BTF does not have is live at the entry of the subprog. A prog
can still attach. It gets 5 u64 arguments instead of the arguments of BTF,
and fexit gets the result behind them.

Liveness errs on the safe side. One static function of the C schedulers in
sched-ext/scx gets unreliable BTF though its BTF is right: a call of a
helper that the kernel does not have counts as a read of r1-r5.

There is one exception. Liveness misses r3-r5 of bpf_trace_printk() and the
flags of bpf_get_branch_snapshot(), which their protos do not declare. A
subprog that takes them from its caller keeps reliable BTF, and it prints
or passes a wrong number under a tracer. The helpers are safe with any
value there: the verifier never checks these registers.

Fixes: 8c1b6e69dcc1 ("bpf: Compare BTF types of functions arguments with actual types")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dcfced2573ee..d95f86b62e99 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11325,6 +11325,20 @@ static void gen_subprog_arg_proto(const struct bpf_subprog_info *sub, const stru
 	}
 }
 
+/*
+ * The argument slots that the code of a static subprog takes, whatever its BTF says.
+ * Liveness errs on the safe side: a callx in the subprog counts as a read of r1-r5.
+ * But it misses r3-r5 of bpf_trace_printk() and the flags of bpf_get_branch_snapshot(), which
+ * their protos do not declare. Such a subprog prints or passes a wrong number under a tracer.
+ * The helpers are safe with any value there: the verifier never checks these registers.
+ */
+static u32 code_arg_slots(struct bpf_verifier_env *env, struct bpf_subprog_info *sub)
+{
+	u32 live_regs = env->insn_aux_data[sub->start].live_regs_before;
+
+	return fls((live_regs & GENMASK(BPF_REG_5, BPF_REG_1)) >> BPF_REG_1);
+}
+
 static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog, struct btf *btf)
 {
 	struct bpf_subprog_info *sub = subprog_info(env, subprog);
@@ -11361,10 +11375,13 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog, s
 	meta.func_proto = func_proto;
 
 	/*
-	 * Check if all register arguments declared in BTF are initialized.
-	 * If they aren't the BTF is unreliable.
+	 * Check if all register arguments declared in BTF are initialized,
+	 * and if the code takes no other arguments: a trampoline keeps only
+	 * what BTF declares. If not, the BTF is unreliable.
 	 */
 	if (!bpf_subprog_is_global(env, subprog)) {
+		if (code_arg_slots(env, sub) > sub->arg_slot_cnt)
+			return -EINVAL;
 		for (i = 0; i < min_t(u32, sub->arg_slot_cnt, MAX_BPF_FUNC_REG_ARGS); i++)
 			if (caller->regs[BPF_REG_1 + i].type == NOT_INIT)
 				return -EINVAL;
-- 
2.55.0

