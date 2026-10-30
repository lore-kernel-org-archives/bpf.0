Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394599;
	b=qOgG16ECKEEOJ53T58ecg3t8KR85bU0uTG1RBI4TVUQTyWrzWhsWvH2l3MEKajwGu1P2
	 1i16GvqpXmWZuAz5lClFM9c/8MFq7kLQvyfRQNjq+Ti0aNJ/PjebWCOVlReUceQRoLMAB
	 ktwbtIVQW5g3S2SeV+OdRctlDeyAwMuN5gwBcjH5EU2nMA8PWqodF3pxsUVRNNhmej8eu
	 V5g3Kqhq80bGPbJbL+YDchJgNDQKuHaJGbBnwLyoRfgrIo9rEFufsJVUuq51zyinMzexR
	 W5v4JZPAUnVOY7o5BzVGqfLOnhSVLVMUor4ypJCPU6NXehNg8lw25ly1FNf6p4CS1KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394599;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UeWsWBdX7J4FJQTPBJcMohdQ3j/ghfWXSqsNvUyru/g=;
	b=0FYfZglgLDz0LOTOrmPQUN4TwD68eHTm7RptjwpE29FgCp1DH+e0bwwql/GPyvE6FGgG
	 6g/NG25TGvXq81PjFDSPW2hKYJMT1UB+6wfMyxmGj93vdgadudgqqfTfN9ssyAr+rljSQ
	 DsOeLcm39TvaVeBjvpcl7qUJnLXfi3NaevOXr2iyBB/iq41p3mujX0+Ui/Pxt0b3MsqT3
	 mmuBd2/3lUWO4i7Oauwjt5/G4pPDeuPloFoComBmzkFunLd0R0y/6Wa7isRHAVkDIU8h7
	 hZM9TRW4ZibI/Hv6y22v9r5n/UvmsyigPgWGJ4gHMdgDv0X9MaBBtA9xCm3WukX3esA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="VI/SC3Ex";
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AD8606A31A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 21:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53AD8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VI/SC3Ex
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso1521424a91.0
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 14:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793394599; x=1793999399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UeWsWBdX7J4FJQTPBJcMohdQ3j/ghfWXSqsNvUyru/g=;
        b=VI/SC3ExwemPg6OUJ87NvG27qgjBIAqRpzl5Ls8gXurLY11eYSKzESVOSUL2VT6Ydj
         HSkUc89tXP310JSALIhMf845lAbrSMLlfBBpdwrmn8HWNCEF3/ReVUMgkSHDKnXmIamE
         n3B7NVPyHuTZZSHqmb+C/zwIser69RDSN/+9u4OoUZp6wHHfauaTQplu5Mt2PDm7VoDv
         QuGtdjERKxw+LvQrUp4h3CI8HLfPi0z9jnHAtmDLKDOpH3LQ5WPkML44sbhbVoAP8MMm
         CFahoTOIZ31wsXPjmxIRreD8czaMf9F7gCrSMEwHn6u8KxRcN92S0ExoS46XSpCWDFZC
         1Svg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394599; x=1793999399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UeWsWBdX7J4FJQTPBJcMohdQ3j/ghfWXSqsNvUyru/g=;
        b=ZQQ9zGSvKc2aGoaknGqO0aHL3hR1NBIWPLuDgqmbQhjQXUJrZOFqYIRHBqcvtQqpyY
         7GvHU/c90N8j90I7ysa1V6+2MaSM6ZBDLa4oz6eChFWEZNqxc7C11/6lSVUZ1omRdmSG
         7j7BvC8xFY1btEIJgu+6aGLLi5BbDml8x7x+gywKR/DU8pYgnxc5RaQZvr7KIYEaJey6
         Tq6ldd4qKKWBbBHuBElgT3uGIvTUGZhOzGQqIrmi0+ZvJsVWzd34YgNtX8IyTFZN5JcJ
         R1sI4akioeiCzJoWOkVcrCHgIkR/bgSkUekQTE8QiBSPlTtOFG0jyLvWgV+1/U4PNVTf
         uCFg==
X-Gm-Message-State: AFq9FYJJZTWMHcotfkjo0Ot6e2zPiyghLjA4z8huaNJHdWDUiKWIelOo
	NwNBJY9eU0RtPBczSNSmoESO+vj851g3NqDAIzMH8aXb+x8u9M2We+hmwMqGNw==
X-Gm-Gg: AYBFou1M+APNAgo5wtKkhpKKQowCDCbVpXNcJYTwoADlmopPxIXZkFYHgm7AZlrpgSq
	c8xWHY62h5ehY1KiqoS6qnkiinMb4yO0q+AGEYM2u2LKSuUdVChCLzmP9f/JfjrTxWD+HJFcd3V
	xgVK+Uc/9qEsTmxNHpSqfvGwvZib9wf+PB4IfTriEtR607svylXzqT3nsiD7fnzXF71geLHjzHM
	ByWJ1vYj4S7g0YOicMGlzjFTZHwwTNkwYG1d1gT6TGbI10ktSxyqsZKRORJMyq3qBMT7GmiHsbO
	Qrlf++UbWPoJvN71oMLqY3ABTW5uyBWM8d4W76Ul2TTl8RNBhL9uTyE3ialRgjfwbFmc/RwZ2vE
	6d1LGWcExN00cW2hh8hDv7xA1FtTG2mTaIKm2qmiJy0OKv2ka0sgToZ9dJP24oE8nIFtoMO2B/Q
	FyraZg0x2E4AqBO/z7+gjF5HFIdTbB1u/4AGu1vVwxm4c6bkAeIIo8/yg1oyN+yaHSX3eOUa2Wm
	yZNrSZzj/JKq1oPUP0OXnjpfcyM5Iw7WljPVOjpTQkHVmLAl1ZVlxHVQncarMNzKLIWTP5WRy/a
	5qccSvTgZ7HkcshunFQaJUWiD5V2fwaIAw9I8YJvUxzNd2FpJfn/ZHp8RvTqtpb/5zQjnl3yQlF
	zyo1Sgn8sTbG6hS8jdcIMYnr2b0s8BdPNSjCtvYJrbESMSl00exHS1uwgH8xF9clj+YsEdPUgCg
	==
X-Received: by 2002:a17:90b:5687:b0:3ac:9ad9:6afe with SMTP id 98e67ed59e1d1-3ae897c71e8mr1758853a91.39.1793394598679;
        Fri, 30 Oct 2026 14:09:58 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae84542a13sm5292202a91.5.2026.10.30.14.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:09:58 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH v2 bpf 1/2] bpf: Keep the valid bytes of a packet pointer in scalar evolution
Date: Fri, 30 Oct 2026 21:09:49 +0000
Message-ID: <20261030210950.1904640-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030210950.1904640-1-alexei.starovoitov@gmail.com>
References: <20261030210950.1904640-1-alexei.starovoitov@gmail.com>
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

check_packet_access() accepts an access when umax + off + size <= range.
Thus 'range - umax' bytes from a packet pointer are in the packet, and
nothing can make umax smaller without a change of the range. For this
reason commit b88822d2584f ("bpf: Fix packet range of pointers sharing an
id") removed reg_bounds_sync() from the arithmetic on packet pointers.

At the head of a counted loop scalar evolution gives new bounds to a packet
pointer, in bpf_set_reg_range() and in bpf_reg_union(). The two functions
call reg_bounds_sync(). Then the step or var_off makes umax smaller.

     r4 &= 0x38
     if r4 > 50 goto 2f         ; r4 is 0, 8 .. 48, but umax is 50
     r6 = pkt
     r6 += r4
     r5 = r6
     r5 += 8
     if r5 > pkt_end goto 2f    ; 8 bytes from r6 are in the packet
  1: r0 = *(u16 *)(r6 + 0)
     r6 += 8
     r9 += 1
     if r9 < 2 goto 1b

  r6                       umax  range  valid bytes
  -----------------------  ----  -----  ------------
  in front of the loop       50     58  8
  in all iterations          58     58  0
  after the step of 8        56     58  2, incorrect

In the second iteration r6 can be pkt_end. The verifier accepts the prog,
and the prog reads 2 bytes after the packet. A kernel without scalar
evolution rejects it.

Make the range smaller by the same number as the largest offset.

The largest offset is smax, not umax. With 'r6 += -8' in the loop the
offset can be negative. Then umax is U64_MAX before and after
reg_bounds_sync(). The verifier rejects an access through such r6. It
accepts an access through 'r5 = r6; r5 += 8', and r5 has the range of r6.

All registers of a union have the same range, and bpf_reg_union() makes
sure of that for each register. Thus change the range one time, after the
last register. The range goes with the largest offset of all registers.

The range can also be a mark: the pointer is at pkt_end or beyond pkt_end.
The mark is for the pointer at the entry of the loop, not for all
iterations. Remove it when the pointer is widened. The arithmetic in the
loop removes the mark too. Thus the state that returns to the head was not
pruned, and the verifier made one more pass with the two branches of each
compare. Now the first pass examines the two branches. The verdict can
change only when no state returned to the head: the mark sent each path out
of the loop, and the other insns of the loop were dead code.

Fixes: 6ccf49f79327 ("bpf: Use SCEV to widen bounded loops")
Closes: https://lore.kernel.org/bpf/sashiko-outbox-187068@kernel.org/
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/scev.c            |  7 +++++++
 kernel/bpf/verifier.c        | 13 +++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7baeb831281f..8852c173c53e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1900,6 +1900,7 @@ bpf_global_subprog_stack_access_bytes(struct bpf_verifier_env *env,
 int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env);
 bool bpf_same_memory_origin(const struct bpf_reg_state *reg_a,
 			    const struct bpf_reg_state *reg_b);
+void bpf_trim_pkt_range(struct bpf_reg_state *reg, s64 smax);
 int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		      struct cnum64 r64, struct cnum32 r32, u16 base, u16 step);
 bool bpf_reg_union_compatible(const struct bpf_reg_state *a, const struct bpf_reg_state *b);
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 7b82fd79f9cc..1123a14e7389 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -2762,6 +2762,7 @@ static int union_any_reg(struct bpf_verifier_env *env, struct bpf_func_state *lo
 	const struct bpf_reg_state *leaf_reg;
 	struct scev *scev = env->scev;
 	u32 l, r, leaf, order;
+	s64 smax = reg_smax(acc);
 	s64 imm;
 	int err;
 
@@ -2785,10 +2786,13 @@ static int union_any_reg(struct bpf_verifier_env *env, struct bpf_func_state *lo
 			verifier_bug(env, "scev ANY union has an unsupported leaf");
 			return -EFAULT;
 		}
+		smax = max(smax, reg_smax(leaf_reg));
 		err = bpf_reg_union(env, acc, leaf_reg);
 		if (err)
 			return err;
 	}
+	/* All leaves have the same range. It goes with the largest offset of all leaves. */
+	bpf_trim_pkt_range(acc, smax);
 	return 0;
 }
 
@@ -2837,6 +2841,9 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 				bpf_log(log, "\n");
 			}
 			scratch_widened_reg_id(env, reg);
+			/* "at pkt_end" and "beyond pkt_end" are not valid in all iterations */
+			if (type_is_pkt_pointer(reg->type))
+				reg->range = max(reg->range, 0);
 			err = bpf_set_reg_range(env, reg, bounds.r64, bounds.r32,
 						bounds.base, bounds.step);
 			if (err)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 26a5ee0708a3..a90bc6c4033a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17736,6 +17736,18 @@ bool bpf_same_memory_origin(const struct bpf_reg_state *reg_a,
 	}
 }
 
+/*
+ * 'range - smax' bytes from a packet pointer are in the packet. reg_bounds_sync() can make smax
+ * smaller than @smax: with a step of 8, or with 3 zero bits in var_off, 58 becomes 56. Make the
+ * range smaller by the same number, so that the number of bytes does not grow. umax is not
+ * sufficient: it is U64_MAX when the offset can be negative.
+ */
+void bpf_trim_pkt_range(struct bpf_reg_state *reg, s64 smax)
+{
+	if (type_is_pkt_pointer(reg->type) && reg->range > 0)
+		reg->range = max_t(s64, reg->range - (smax - reg_smax(reg)), 0);
+}
+
 int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		      struct cnum64 r64, struct cnum32 r32, u16 base, u16 step)
 {
@@ -17745,6 +17757,7 @@ int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 	reg->base = base;
 	reg->var_off = tnum_unknown;
 	reg_bounds_sync(reg); /* this should infer the tnum alignment */
+	bpf_trim_pkt_range(reg, cnum64_smax(r64));
 	return reg_bounds_sanity_check(env, reg, "bpf_set_reg_range");
 }
 
-- 
2.55.0

