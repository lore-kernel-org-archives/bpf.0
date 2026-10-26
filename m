Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792979591;
	b=uDfMvdwv47KGrcy4n2+JiokVq2SkICujdSVHkQoerbLad46rJ7ZGYipMlEcj6+kK8XJ9
	 Te5OwbpFGw6FjfBlz2tkikrkHTBMvyerJ6p2ET9rsmW7fwvmJXyJwwyMH+nUbSnujmZob
	 w0wsV80YYbkcejBPym4aleZ9Q0YYUmjrxSdoLVGBj9KdjBS5JHUaZFp2gMZI+zIy6byC7
	 GrbAUvSF/1vnMIAWvWrGpeTKopIAwGJZSRRXyIHfTX48jFf2deLYXcr/4Vkk17pVFhPXT
	 jbfalPpNZfxBhT6HSG16na07LnVALOcH54+uMjf1d0de6KtPuM2GMdZZCcThSzqPMeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792979591;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=tkGyQEb1F9hHz/xznoehXSDNs1CLiz2rTicTpUpSfbo=;
	b=GDZgs5XO9gKhlPNxINJ4MRlN2xxdTd8Cspq4uz1qrje7vc84xL6vyNogF3lsCKGCp9YS
	 +UPdnj+S2NtvFslPnUqeW2yyZy/TexfRoM7FNHPLXhYTsmPXBM8K8ezZNXX9UYge6NmLE
	 dO0MihykQ1tNQyhWCMS4A34nGPOHtU7dpA8tI8xolo+PzyNotixXdAzHFtxjSONUM6ytW
	 W2NddUcOWteMFcYpI6LTZ4vL05DDlwAqmeAIUasmdBR9zxstMjfzif7MRLaTpaNvnpAPN
	 n+VLQCZ7GdC25H3fa8GVHgBGmbkGUKvc7eWu7/vdg7QBu+UPqV4FDMy0b5vdAYwmm6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aCbxvSOx;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FD4606A31B
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 01:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72FD4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aCbxvSOx
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e9d7791b00so14779235ad.0
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 18:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792979591; x=1793584391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tkGyQEb1F9hHz/xznoehXSDNs1CLiz2rTicTpUpSfbo=;
        b=aCbxvSOxwsThWLKE0MsJS5hHxV0kdTRowgCgVwHYIl9kQID2jYpEWIQO4hFIrS6md2
         q6MPryXGuVhtMtb545P1A7QR2PjKZI6SyIIJGzlBHkuvpojfdInfvdDAWdbIw5YKt+g7
         yGQxuZzCDJAx7vpxBmFWN3czElUqVF6facxQA3ldeaoSrK2SFR3Wq09ViqPLY2N2f9Hc
         ws/gzxBcqPfoOjuQRO2T9UqB2qIhF6U3h1OTdEleetSE7BaFlvI3K4Xcivm/TR19+Lwi
         kyKs6NDQ22n4GYNtdYCtFa9xIMEUOBTeZDKXhbrUoAEzV5y8zfUk9odtDFLVK4MQlxPg
         btiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792979591; x=1793584391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tkGyQEb1F9hHz/xznoehXSDNs1CLiz2rTicTpUpSfbo=;
        b=VpFfQLYtBUvzI2ILCTdXHOXExF7Fjjpuw7sapMRUrT7fycTqRwUKR1ulo9yb/zAXRW
         PHAHDOKVJOU7FMVZkxJnbToCBrajY5s/J1IAxr1hj7JWqyVTqplcD34odU/hXlc++dKP
         WLHIuoIgdSMvRe9XuCRhY3EKjWAhCycBiC4xFddJAB5K3DgeYLXcsItnX4xoRm10Gf/N
         u75/HCz66DQcrpoLLs8NS2qdmrQQmrsWzAkybiUdww7b4lLSO9ZH0jW/nIICMdLQb9Uz
         D9HE32O+OiIQSmY92LTFSHPnT9We+SwOejbPCxkIwh/POMml5ET7Onwohur5Iya6J3hS
         rpiA==
X-Gm-Message-State: AFq9FYK6EwEIdiPeNWa4Ko3Ggp9oSuWh6sdumXvDmXv83JH3h0vlHBgE
	8rpmRxRnpn6bzU3MDKglDyjz8T1G1oQGNJ3pZfoLMFfYuMivOkzm4+/W
X-Gm-Gg: AYBFou30rvlrgLEdCyneqh3ndB/kk1PcgPyfbIKdNboVILEGgQRNC/TX+H1bgaBMkJk
	gmZcyBNzsXn7+7ibSFSyNWu1KCGTU6CnXz7Zu0MjGPt4uaB1gKT/tmQzcC+OCW+w6h2TnCFcu9l
	0lBB0VtS6DsY86kD6C/SigneHIt/DdBbvYuorf8asQiKU2qF+g3QR4NL8XInRV8d97BdPrD4XTB
	u9q0JnB1//G1PQQo2CkyuA+xTHx5HJAFDH7sD0+ztNqPBBYOyEztiVAoj8Pkf2+q73hhtns/VWq
	bjG2ZXVe42Zjt+CvFzpnyMzozAsMrObswJpd7Qj6/+sSb2iWWybviJLSe53sVIcOs7qBfsPhhLu
	AHW1wYgWSPkEjoCkLiQu8PoLJ1z+iE5oA6oaYpsNXyiXmW6F9LC2AwzazEJXLiQqD5cGiaE/AK8
	rTaHnmjoAvEf38UEjme+6CKaJyrNUhce7nFCwjPnte9D+lBAPgoN+nW784NxWw6RTHh2sJnLfBH
	ZzQB2Uztv3oI14ZtqZAMxyTBYKQ54FnKj4gdgU3t0iVUtU5rSK59NF56irxKR8ZOcww+WhWGm1R
	Sl/qZCP4UMxCRGvXA5ZMrFdngsaP1lldcCB4WiFrgYmpztKaKw==
X-Received: by 2002:a17:902:e5cd:b0:2e9:658f:c33e with SMTP id d9443c01a7336-2ea9c0d4beamr44584065ad.8.1792979590768;
        Sun, 25 Oct 2026 18:53:10 -0700 (PDT)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9af3232bsm10137655ad.10.2026.10.25.18.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 18:53:09 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	co+eada64ce90ecebce@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf v3 1/2] bpf: Validate stack arg reads against caller state
Date: Sun, 25 Oct 2026 18:52:49 -0700
Message-ID: <20261026015250.1674676-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.56.0
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

check_stack_arg_read() bounds a stack argument index with the callee's
BTF-derived argument count, then uses the index in the caller's
stack_arg_regs[] array. The array's actual logical length is recorded in
caller->out_stack_arg_cnt, so the bound and indexed object can diverge.

A crafted BPF_PROG_LOAD can use an argument mismatch to mark a static
subprogram's BTF information unreliable. Later calls return from
btf_check_subprog_call() before check_outgoing_stack_args(), while
check_func_call() continues the static call on -EINVAL. The callee can
then read a slot that the caller never allocated or initialized. The
earlier commit 4286f5deee14 ("bpf: Validate outgoing stack args when
btf_prepare_func_args fails") closed this hole for the first call, but
not for later calls after the subprogram has been marked unreliable.

Callbacks have a related problem. The verifier can make incoming stack
arguments readable from outgoing slots at the helper call site. However,
helpers and kfuncs invoke callbacks through an ABI that passes at most five
arguments, so the runtime callback receives no stack arguments. Async
callback verification can also reach check_stack_arg_read() without a
caller frame.

On x86-64, KASAN reports the direct-call out-of-bounds copy as:

  BUG: KASAN: slab-out-of-bounds in check_load_mem+0xb51/0xc60
  Read of size 80 at addr ffff8881009af550 by task poc/131
  Call Trace:
   check_stack_arg_read at kernel/bpf/verifier.c:4234
   (inlined by) check_load_mem at kernel/bpf/verifier.c:6645
   do_check_common at kernel/bpf/verifier.c:19568
   bpf_check at kernel/bpf/verifier.c:21318
   bpf_prog_load at kernel/bpf/syscall.c:3134

Reject callback subprograms with incoming stack arguments before their
state is pushed. For direct calls, retrieve the slot with
bpf_get_spilled_stack_arg(), which validates the index against the caller's
out_stack_arg_cnt and rejects uninitialized slots before copying the
register state.

Fixes: 0f6bd5e7a804 ("bpf: Support stack arguments for bpf functions")
Reported-by: <co+eada64ce90ecebce@bugs.sh>
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
Changes in v3:
- Rebase onto the bpf tree at commit 00d2cdf1637e ("Merge branch
  'bpf-track-borrowed-iterator-result-lifetimes'").

Changes in v2:
- Reject callback subprograms that declare stack arguments.
- Drop the curframe-zero check because only async callbacks can reach that
  state, and callbacks with stack arguments are now rejected earlier.
- Explain that commit 4286f5deee14 closed the hole for the first call only.

 kernel/bpf/verifier.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c223bf3bc9cdb6..a0a5f075d2018a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4666,7 +4666,12 @@ static int check_stack_arg_read(struct bpf_verifier_env *env, struct bpf_func_st
 	}
 
 	caller = vstate->frame[vstate->curframe - 1];
-	arg = &caller->stack_arg_regs[spi];
+	arg = bpf_get_spilled_stack_arg(spi, caller);
+	if (!arg) {
+		verbose(env, "invalid read from uninitialized stack arg off %d\n", off);
+		return -EACCES;
+	}
+
 	cur = vstate->frame[vstate->curframe];
 	bpf_diag_mod_begin(env, &cur->regs[dst_regno], arg, BPF_DIAG_MOD_WRITE);
 	cur->regs[dst_regno] = *arg;
@@ -11451,6 +11456,10 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	err = btf_check_subprog_call(env, subprog);
 	if (err == -EFAULT)
 		return err;
+	if (bpf_in_stack_arg_cnt(&env->subprog_info[subprog])) {
+		verbose(env, "callback subprog cannot have stack args\n");
+		return -EINVAL;
+	}
 
 	/* set_callee_state is used for direct subprog calls, but we are
 	 * interested in validating only BPF helpers that can call subprogs as
-- 
2.56.0

