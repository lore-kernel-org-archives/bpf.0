Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795662239;
	b=a2o/EcxJ6ytOMyjbaRvJ2j4p2QAFnqMNahacNfG/elMiZvaxynedzAVJrmFQ9nAw5mb0
	 1qOwN1EolJ+OaKmfSHmkgi+PFcADU7Nj5Rj2qOZ7DaF4wOyGRObEv3b8yfgFIYvGeEY1J
	 gtlAZNyDnLVlrAk6ijvgaEfuH4FV+/725+YN7KiR9filjs3rLa0lv9gTE0Gg0+VymV4d+
	 nLCjJs6xJHlSJ/jTD0uUC+YnWG6dYKqEJ0+hjPEmZhgzeW7tP52rqioZy2/1+b5zCOoJi
	 tikX3dfvsrUFLD9EKeNNQOAml1Nc88Qnrarxf86o4LWFTvljwtE/6nk4EpSt0xqNNgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795662239;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ruHtWldu3HbL2DqTOOvXfrE1lnrlBG1C72WxuEuiV/8=;
	b=TGySamyDyr30vwTr6g7HgVlDIyfbdAfrQnVCXj1QedMtloZpI81MaVBYOnyGlE+XOkge
	 x9awrYby7Ki0mbZuWzFNo/b2iXl9QTWEB2mhEtLlgNQGi3tEu3vJ6lz3zNehUYrW8F+bs
	 ahfuaXsxFWzI/VVbjEiDw1kPntLiwU4UyJdzWFaH86H0DZdhn55/OJAmAPhXvD9k9FQZd
	 OHpVuUKsBFHQRCwx+UkDaTVtbxxvmLQ6bonaexVtiIPxyjwfsFkP4z4uMZeUjgF+n9rjA
	 CNMlw5+1UwiLZVMAZWAAtB6X5epT5q7roZwvLUVEBs1+sT0/2yt/53xZi0dc/Tvg2mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NwvBQFkh;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30931606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 03:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30931606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NwvBQFkh
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b4cd193b50so1646773a91.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 19:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795662238; x=1796267038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ruHtWldu3HbL2DqTOOvXfrE1lnrlBG1C72WxuEuiV/8=;
        b=NwvBQFkhCX1US6XFAXaNVHn9oXOOTswn0TjOB7lLebxgRYUCHCTTmfsuS+0/H+Lbqw
         AwMwY/wuxWDXtIxaFEOMDk5aEdizZs37r7MmIURg8nkjDzf+RpsEDyijhnGfUCreOsWW
         JfUD0nEuhOqO9j1DURs0mgxN4CqanqNIvi6Fu2ZHJVJtKDpEvzvj/KUAt8OLvejSmc4V
         9bziWq192cZ8SPHBzErPj5xcAjZPPyyH+ralpc/xuhoHLPKbxnNNt8V1F3C/seDa0MqC
         Mrz1gkH9daz1cvO8hPoGzFHQ4W0h8+gRf+mDGQuk8hDYwSRB1VQNjTyWmP0MVVIce7Nq
         8zIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795662238; x=1796267038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ruHtWldu3HbL2DqTOOvXfrE1lnrlBG1C72WxuEuiV/8=;
        b=p3lm4rBaIFM0qtagpemcpNyQN5gIhLqr4iNp5htoZT3WBR5qShksJ9ciUGgSYJUNqa
         WnW/ff1fLTSUZI98ivAi4cyj+zFPnPnjjr+hTbEZLzaEwS3DWh9cFbX8pfwPenO2TCcY
         U4d/GezQra+dFeNfYCaU/HhOWwyzTclnfEfyqBiAXxy9A291KcHj/FYznDImXtny/tlR
         cs1d9vbtz1xgJ/CtCUJT4wiaTu9ybqSb0m5h49F2w2rsyalkFIlwRlknLD62PEXNBYty
         0sEscTFwlzN3gO8Cio6CcZG65MkrMKMUARfZPJFytUpECerLAXtRkDLsMWczWLO6uzMA
         uYLA==
X-Gm-Message-State: APuU4Z+rYKJUoSPLTkmwjdUiAR6wX7Bs2ZejxJHMg4VPxgJHYwh1gIKJ
	XldHiZV6yNO45WKrUJTbtWjTJW/8GcxugLXKabMvv/N/nC1BBanIny4U8dHGdQ==
X-Gm-Gg: AZFdTZee0iY49k+1P15GDvXnlKFbkX2WEFv1DgGbTWN1QWyWteZWBGvbdzV2jbJRpDa
	528nACDVH3ol7tjncCO7XX+SxBywCSrVFZgOnvqeMAE5ZWjUvxJOK4N6Q7xH2A4ZKEd8NG29gcm
	gu5O64zbOpmyfnIHCnlfgwoeSDCSeTUByRNWKv58GQaHZBWSUAQrz0eXGS1UBU/2wjTEbiQrhuE
	KwBcjVvsSXrraGrr+YZcYCFxkoKHpCYPHDXQVvP9qevkxll2YDYbR8Qt6uU8XDr0tz0IfHJ/+3g
	3gYq0WXbkkIlurKIgdsBH+vVPkCqjfLP9Uor5TvcD6kslzLxe7MXMiVUK1rEJ+aPDr9XiGX7ZvM
	rucP88qomWiRN/xQYj6nys+IiOnyMTs0JGtCfPeuPHCGQet80L0BqNynMHwVsmiLlWFzHp7BgxQ
	2YtxI0kAye7J2MtcEl0s+3M6klb8tWN9r0nPW1jX3OMjbu4bQ3o+esJT0IKtip55M/6Ux8U0+Mp
	8tc0JzR/JcL/mNGg3Ysh4enL0wy+jSm8k7z5rww2kFLEApEEGzBo49opqs8EHA+cUxC43t/wybe
	LmebPeuyBTB/C4S5ceBuKnvg6fY4ZvDHCtdqGvZbsMHsHk65WjlmusBd2t4+1QvvlA0V/1dxg94
	S8wbvm9eJR2R/H/n0wFSB6EwpgS4sp6MnbLiIy5aa7XB0rrmBSYeW0TB3F3f94GBv1myyer/k8w
	==
X-Received: by 2002:a17:90b:3b47:b0:3b1:83d4:5d33 with SMTP id 98e67ed59e1d1-3b41c99524bmr19098198a91.60.1795662238282;
        Wed, 25 Nov 2026 19:03:58 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b792474sm14236623a91.3.2026.11.25.19.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 19:03:57 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 2/4] bpf: Require CAP_PERFMON for recursion
Date: Thu, 26 Nov 2026 03:03:40 +0000
Message-ID: <20261126030342.4013902-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126030342.4013902-1-alexei.starovoitov@gmail.com>
References: <20261126030342.4013902-1-alexei.starovoitov@gmail.com>
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

A recursive function is stopped when r10 gets to the middle of the
kernel stack. The depth tells how far the first frame is from there:
the low 13 bits of r10, with the random offset of the system call in
them. A program that has CAP_BPF only can count the calls.

Ask for CAP_PERFMON. Programs without it lose recursion, two selftests
expect the refusal now.

Fixes: 7b7dc9c6e8e9 ("bpf: Limit depth and time of recursive subprogs at run time")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 Documentation/bpf/verifier.rst                       |  2 +-
 kernel/bpf/fixups.c                                  |  7 +++++++
 tools/testing/selftests/bpf/progs/verifier_barrier.c | 11 ++++-------
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/bpf/verifier.rst b/Documentation/bpf/verifier.rst
index af9429ebe7b0..0bffb2b1476a 100644
--- a/Documentation/bpf/verifier.rst
+++ b/Documentation/bpf/verifier.rst
@@ -1292,7 +1292,7 @@ can go past the jump that a proof needs:
                                    full `Limits`_
 ``CAP_PERFMON``                    trip count, reads of stack that is not
                                    written, pointers as numbers, access to BTF
-                                   objects, arena
+                                   objects, arena, recursion
 ``CAP_PERFMON`` or no mitigations  equations of pointers, equations that a join
                                    makes from constants, the end of infeasible
                                    states, skipped first trips, stack access
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index eed9d13f6a6d..aa590efc32d3 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -715,6 +715,13 @@ int bpf_insert_recursion_checks(struct bpf_verifier_env *env)
 	for (s = 1; s < env->subprog_cnt; s++) {
 		if (!si[s].recursive)
 			continue;
+		/* The depth at which the check stops it tells the low bits of r10. */
+		if (!env->allow_ptr_leaks && env->insn_aux_data[si[s].start].seen) {
+			verbose(env,
+				"recursive %s() is allowed only to CAP_PERFMON and CAP_SYS_ADMIN\n",
+				bpf_subprog_name(env, s));
+			return -EPERM;
+		}
 		n = 0;
 		/* The exit drops the frame in the stack in arena. Take it before the check. */
 		if (is_arena_sp_adj(&env->prog->insnsi[si[s].start])) {
diff --git a/tools/testing/selftests/bpf/progs/verifier_barrier.c b/tools/testing/selftests/bpf/progs/verifier_barrier.c
index 7e68fc072e3c..bc12cc17f0f2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_barrier.c
+++ b/tools/testing/selftests/bpf/progs/verifier_barrier.c
@@ -207,7 +207,8 @@ static __naked __noinline __used int recurse(void)
 
 SEC("tc")
 __description("barrier: a speculative state holds more in a recursion")
-__success SPECULATES __success_unpriv
+__success SPECULATES
+__failure_unpriv __msg_unpriv("recursive recurse() is allowed only to CAP_PERFMON")
 __naked void recursion(void)
 {
 	ASM(START
@@ -237,12 +238,8 @@ static __naked __noinline __used int recurse_in_frames(void)
 
 SEC("tc")
 __description("barrier: at the call of a recursion in the frames of the callers")
-__success SPECULATES __success_unpriv
-#ifdef SPEC_V1
-__xlated_unpriv("r1 += -1")
-__xlated_unpriv("nospec")
-__xlated_unpriv("call pc-")
-#endif
+__success SPECULATES
+__failure_unpriv __msg_unpriv("recursive recurse_in_frames() is allowed only to CAP_PERFMON")
 __naked void recursion_in_frames(void)
 {
 	ASM("call bpf_rcu_read_lock;"
-- 
2.55.0

