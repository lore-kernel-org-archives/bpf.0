Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9773B19CF
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255309; cv=none; b=WQz1YZ/k8LFlL1yRt16IbgOrntgzS79NOXSheev9BSIAqhSGzjsDZoE/6JC8u0cy5qGn4frdWljGe7r1y3DHJleWn+9SvLmzGsZ/hP6JUAI59ukAqzTaMcnySnH0pYgQ502+Kv2CzJZGDuXyVprEye56BLrBSHUa1f0vFCxWE1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255309; c=relaxed/simple;
	bh=vtzRMlYWrVUFGImrGa6pKSIaWK0o77pm550E+QX1aBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lM1AQRqrWP8Hh3bGA0gUTcq+TJDRpKYuezqB/e7uPV889kuJs/7NQA8/HJa+M0WIILBa64w5s2C3odIuDxx3N1Mg/qaKSMZPNLpMq3AUKREfsJwrGCvhXRLcpmFSoSrKenCDBkK1XOuM06eHPPfxv3NCDN6wtgblfS/YPm7Irw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TX9EfQY2; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TX9EfQY2"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso413651a91.1
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 09:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255307; x=1792860107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WX9A5FgatI9/iBdXsBlHi3tZ5RBdWBYmZQ1Rjaj24QE=;
        b=TX9EfQY2rerbx9YCHDfwtKArfAkKi7w7bP4TwtgQxOnYSWtE3/bIT+2o2xlFsN4p74
         A5gTPkbb0UWDqkUlWUR0RK9Pc2kYPWjskUvsZIZxe1VIVNkh3kCTGhqRMNRJXbQdEMNc
         o/oObsX4Lr0VNUP0jMiJwk8mQTfwhS824le/7ii3RdwXXEqn+m4TrO33FgPvI88wyY1M
         rNf6/5bjCGvqQfZNGsKm7PFkceVkXTDz9XdoN7LfbEby9PGCuN4u0ZRLhAo4CMT5uMyB
         gHXi5jzH8a6zfteD4tS36oLVEBQPUd4PF1OOHNq9nN73yF/NvedRC9jC1EHTzmfh/uy5
         rWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255307; x=1792860107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WX9A5FgatI9/iBdXsBlHi3tZ5RBdWBYmZQ1Rjaj24QE=;
        b=A5/ZlDMX8fORpUR3cDRfywGDb54f5AqPVB5dmSk2oFLfywtKIdr/6U/nvUetjM0hF8
         k8nQBeT5VLDVkwveR1yza4SZNXPuUhONtXFD7KxOO8BgWt9vCD7UG1GHCOkg4MWttCPQ
         po4xHWPgoVgqwNzr240gRFVRHcedj41VO1NCzy1u8T+b+IpHnbVP5Gr+yujG5FhNpZ/b
         e/aRhLheERoCoVG9zAGF7FTt0wsl/KeSkAd1sgoE+C4xiGtwNr7Loh6Hr/SBLblKWsRE
         4EeDUSPrhvNjGreYQQhn7LrOuM7ixBk41gyJbToX0deepvOvEpLYVOvvmIRp2prP9NEJ
         BrcA==
X-Gm-Message-State: AFq9FYLsu+ZkCnmov0nNHyXAcslGfEoXvk9jcT4t5Mp/NfZaWwkeTWb/
	xY83GhZBg+Pvl7tV4oHd/pxvCodGguiYjcRlBzp0CXAZbNa/oLiJ/fRoK4roTg==
X-Gm-Gg: AYBFou11ZDTbhIOkzAJpwCGm8wgPKeJ/Pjo67OEd9aaRalVMpbGiLOVV2lnZKnxqDGF
	v/pVraXOTeRvpwF4BpCidX6AV6Ejh7sGWCGNxLzN9rMj+Kh/u2oap2WawjTJtZGb9WX2FBGIH2d
	p/2VOqMfjiC/q65pqn32pB5nlPRWVBwx+IlARRggNY4dwDvmmBTd3xW4+EsAWs4fcJ2eyYzV9ns
	macWZXAX8/IWbfiOpIeA8hHoHbcLZxVFdXQ2HN9Rl6XcjowuGuMnsQs0G0mRCea928hZtXLCcct
	RBP2HB6lt9B9EoBxUNMa0cXHbL/xAdZF31nDvg5zbOtHX4QAJhH9RdPlm1EbQNpVwT1cEh6zHUG
	UzSDMQhQeana+szDR3Pyz3SuVqTXHKg5NDupgIjwv6AztytF2k7iDB3eBK/SO4+VZHT9jpYh1q/
	Saijr9PUrxvpdePYw+ort7+x1xMkjRW3GTLcXbsYbGePOWIbQyCSW6xnFMUTH275RKxOW7XLln5
	RKy8SZtzMH57LVX0WmChUsrejC7iQ5MZZwUMtinOGJW9frHdZrwbtrXkdzkDR5nWsN4gY5VcI/X
	VttTDH54rMq6yDCebR9vmWrFaowPO1vPInqkh919wMZIDR50+rBHfA==
X-Received: by 2002:a17:90b:28c5:b0:3ac:4e18:237c with SMTP id 98e67ed59e1d1-3aced87290fmr2713831a91.0.1792255306961;
        Sat, 17 Oct 2026 09:41:46 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac943e7548sm13855935a91.1.2026.10.17.09.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:41:46 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 39/43] bpf: Refuse the prologue for an extension that cannot take it
Date: Sat, 17 Oct 2026 16:37:41 +0000
Message-ID: <20261017163745.3341787-40-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

A program that writes to packet data starts with bpf_unclone_prologue().
It takes the skb from R1, and if the skb is cloned it calls
bpf_skb_pull_data() and restores R1 only.

That suits the main function of a program.  An extension gets the prologue
too, but it starts with the arguments of the function that it replaces.
If the first one is not the context, something else is taken for an skb:

  BUG: KASAN: stack-out-of-bounds in skb_ensure_writable+0x84/0x1a0
  Read of size 8 at addr ffffc90000270ad0 by task uncl/105
   skb_ensure_writable+0x84/0x1a0
   bpf_skb_pull_data+0x32/0xf0
   bpf_prog_853eb1991d35e093_ext_slice+0x4f/0x321
   bpf_prog_9eb18752b5d0959a_t_glob+0x2ac/0x2de
  BUG: unable to handle page fault for address: 0000000082298821

And whatever R2-R5 held is lost, while the verifier goes on trusting
pointers in them.

Refuse an extension that writes to packet data unless it gets the context
as its first argument and scalars beside it.  A scalar is still clobbered
if the skb is cloned, which the verifier can cope with.

Fixes: be8704ff07d2 ("bpf: Introduce dynamic program extensions")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/fixups.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index fe59e3114d82..32911d7f494c 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -858,6 +858,25 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 	return 0;
 }
 
+/*
+ * The prologue takes the context from R1, and it can clobber R2-R5. An
+ * extension gets the arguments of the function that it replaces.
+ */
+static bool ext_prog_takes_prologue(const struct bpf_verifier_env *env)
+{
+	const struct bpf_subprog_info *sub = &env->subprog_info[0];
+	int i, cnt = min_t(int, sub->arg_slot_cnt, MAX_BPF_FUNC_REG_ARGS);
+
+	if (!cnt || sub->args[0].arg_type != ARG_PTR_TO_CTX)
+		return false;
+
+	for (i = 1; i < cnt; i++)
+		if (sub->args[i].arg_type != ARG_SCALAR)
+			return false;
+
+	return true;
+}
+
 /* convert load instructions that access fields of a context type into a
  * sequence of instructions that access fields of the underlying structure:
  *     struct __sk_buff    -> struct sk_buff
@@ -909,6 +928,13 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			verifier_bug(env, "gen_prologue is null");
 			return -EFAULT;
 		}
+		if (env->seen_direct_write &&
+		    env->prog->type == BPF_PROG_TYPE_EXT &&
+		    !ext_prog_takes_prologue(env)) {
+			verbose(env,
+				"Extension writing packet data must take ctx and scalars only\n");
+			return -EINVAL;
+		}
 		cnt = ops->gen_prologue(insn_buf, env->seen_direct_write,
 					env->prog);
 		if (cnt >= INSN_BUF_SIZE) {
-- 
2.55.0

