Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2999D486428
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 22:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164292; cv=none; b=IbSeGVdNHqbUUJ/gKHCJZAo+rKUhuMOOArUTbXa0DqoxS1UwRlOmdl6KMn49FOlBD66hZk9RSLtHc0eZ7phgUcRv1JWSOgUWMsL7FP39OFbidnwE75dcmcx/IY0bhe0xxbDr9YxOT+dvdoL25ViE/VmN3hAHwKOoTzAp3p7ZH/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164292; c=relaxed/simple;
	bh=iCvhkumTeQdPrNMwtUd1ZC0o/8acZT/nxGL5ybelbT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDGXsrJLC5mRWKpwKhcQ/4N4BUmKhyNB3fofwgYr5lpsMLAu3chJjrH5B/gHv5LFcCXN52GNbYCJ1/8+AFVdiOkdCeY+e06ehqtFGNdRX4ZSY399pta5sdazhrpGibF/SBOZawM+XNQ2GeNUSvNzya8oBhiWsQgh67cy6OZzot0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oR6m8H5G; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oR6m8H5G"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466ccdd77e3so20329fac.2
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789164285; x=1789769085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XDHQSN8+DkSWUYjRm9ekupStpynVaJmFgH+tQ9pfsHY=;
        b=oR6m8H5GWtcgfwZzN8cd91rq1Hu64UFrNwNXjTTXoGadTkV7xLtA2wES/48sHTYzrb
         w5dCikLb5rvHYBLAvsgEf1oT6KNO2/rfSePZX+DzarhV1t8xkk7PzczIlxYQaV0UMVbu
         xZZ7vA7THwAutbk3GNLtRDymvvZs+EGmvzxWsigzpRL7Qc4hSTlrh3s4WhmsUz9quKfG
         /IZfkt04s8q0P7243hgSmkwvoW1PHZIP3mIGB6P3wtrXzweGuVHcuq81KMdJTnolafI3
         /67KYYvuqFT+1U6X3ECx6LYO6z+h6nQ2sgcLgK9mY9+Ou12VRTVfs7PODKxrnzNFplay
         bOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789164285; x=1789769085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XDHQSN8+DkSWUYjRm9ekupStpynVaJmFgH+tQ9pfsHY=;
        b=gZ9sdEFqhiNTUD1A8vTHi3J/5aZXGSi2WwxFDzRdehj/jnx6zCn7cqOgp1MV/ggoPY
         o0EnAUxMOCHWroNc+x5tSq4tD9AY6mBgoVgezfhaEoDG0OExL/+7dXXS3zIHD82QGPaI
         aTCExAYoe0mDn+8aNTT7F0ErLNXBzC9VMY4ZC8DcGE4VcaTWsBE7XKkKn/ASk9MeB/3u
         3X3U1BQEF3r8eW9umrkGV4dwaMhWVUCX8/oO+W89dkS5MEwrwa1PSwIK8idDtHM25ig+
         Am3s2YXIhqSdaF7P/hsbGqyXQXYAz5xEw+G8ue+PZFi3AQI6x7MH1d8Ffqqps+BC8GhH
         O2Bg==
X-Gm-Message-State: AFuF++kSAghDiSUA2yv44Dhteekw5qv0peTNQaE56KJKyUlXkJp8ciho
	bIUiqXbgIovLkB7qZ8LA4jTd2CN/CmTc9lzcjar1gDJVEXX9BIwEk3G6gOk2wA==
X-Gm-Gg: AYBFou2LwMqb8okV+n9MLiDUKHvJmvyG0XeX0FSyw2qu6jao7Gb1sVqkDiK+SQU7jfk
	gBCYmGbHor8s6ieFL093F7WmsY8RwPS+X/kJvS/Y6f1jUo/z2T81MtHWrLRyhEky1qgDyiy2Mz8
	svAzoW9a7ncsOYjfX9WqZltv/iRCumJXlM1e/rE/8T01U1TcSrAbcst3S/G6aPvilYKM+I70BAZ
	0KuHrV2mleUM803P4wOZXHXww26/YCMOgAZrNd4ylKlZaU4fjsGYI47kLp6j5dka6zUpjWPTC2y
	CFWJ0q867ey2CP4t7MgevWJctLBS0ihJrkXlo5EoB6PsjSFQTNtNJJXnDa6Gy3ee97N83ZAsnDg
	u9q+IxKLuGJLZ0y1aMS6JSyrqv1fHlOHP0dZ1GPjIDF71+rESQSHCQzkIFCauBheJaPLG+TDNwp
	YacEyXjzw9E1cDWvg61la40Lypr63F2G7Cyv0Tg402xehCsml02UNt+O1bUTUXDg==
X-Received: by 2002:a05:6820:1849:b0:6b7:46e9:96ff with SMTP id 006d021491bc7-6c24eb5d247mr303339eaf.47.1789164284678;
        Fri, 11 Sep 2026 15:04:44 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4d::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c0990ccbdfsm3734523eaf.4.2026.09.11.15.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:04:44 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 19/23] bpf: Consolidate function call pkt_access validation
Date: Fri, 11 Sep 2026 15:04:11 -0700
Message-ID: <20260911220415.1396439-20-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260911220415.1396439-1-ameryhung@gmail.com>
References: <20260911220415.1396439-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_func_arg() checks whether a helper permits packet pointers before
dispatching argument-specific memory validation. check_kfunc_args() has
no equivalent check, even though kfunc memory arguments may be backed by
packet data.

Move packet-access validation to check_helper_mem_access(), where the
access direction is known and helper, kfunc, and global-subprogram memory
arguments converge. Pass call metadata there so helpers continue to
require bpf_func_proto::pkt_access, while writes through kfunc and global
subprogram arguments use the program-type policy and set
env->seen_direct_write.

Keep call metadata when variable-size memory disables raw mode by
clearing arg_raw_mem.regno instead, and pass it through the map-key path
as well.

This also makes kfunc and global-subprogram packet writes request the
required writable-packet prologue and rejects them for program types
that only support direct packet reads.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c                         | 24 +++++++++----------
 .../bpf/progs/verifier_helper_packet_access.c |  4 ++--
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 254458cc1737..bb33d0755a61 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4881,7 +4881,7 @@ static int check_map_access(struct bpf_verifier_env *env, struct bpf_reg_state *
 }
 
 static bool may_access_direct_pkt_data(struct bpf_verifier_env *env,
-			       const struct bpf_func_proto *fn,
+			       const struct bpf_call_arg_meta *meta,
 			       enum bpf_access_type t)
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
@@ -4905,10 +4905,11 @@ static bool may_access_direct_pkt_data(struct bpf_verifier_env *env,
 	case BPF_PROG_TYPE_LWT_XMIT:
 	case BPF_PROG_TYPE_SK_SKB:
 	case BPF_PROG_TYPE_SK_MSG:
-		if (fn)
-			return fn->pkt_access;
+		if (meta && !meta->btf && meta->func_id)
+			return meta->fn->pkt_access;
 
-		env->seen_direct_write = true;
+		if (t == BPF_WRITE)
+			env->seen_direct_write = true;
 		return true;
 
 	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
@@ -7095,6 +7096,10 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, struct bpf_reg_
 	switch (base_type(reg->type)) {
 	case PTR_TO_PACKET:
 	case PTR_TO_PACKET_META:
+		if (!may_access_direct_pkt_data(env, meta, access_type)) {
+			verbose(env, "function access to the packet is not allowed\n");
+			return -EACCES;
+		}
 		return check_packet_access(env, reg, argno, 0, access_size,
 					   zero_size_allowed);
 	case PTR_TO_MAP_KEY:
@@ -7211,7 +7216,7 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 	 * the memory that the helper could just partially fill up.
 	 */
 	if (!tnum_is_const(size_reg->var_off))
-		meta = NULL;
+		meta->arg_raw_mem.regno = 0;
 
 	if (reg_smin(size_reg) < 0) {
 		verbose(env, "%s min value is negative, either use unsigned or 'var &= const'\n",
@@ -8822,7 +8827,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	struct bpf_reg_state *reg = get_func_arg_reg(caller, regs, arg);
 	enum bpf_arg_type arg_type = fn->arg_type[arg];
 	int regno = reg_from_argno(argno);
-	enum bpf_reg_type type = reg->type;
 	u32 arg_size = arg_type & MEM_FIXED_SIZE ? fn->arg_size[arg] : 0;
 	u32 key_size;
 	int err = 0;
@@ -8850,12 +8854,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		return 0;
 	}
 
-	if (type_is_pkt_pointer(type) &&
-	    !may_access_direct_pkt_data(env, fn, BPF_READ)) {
-		verbose(env, "helper access to the packet is not allowed\n");
-		return -EACCES;
-	}
-
 	err = resolve_func_arg_type(env, reg, arg, meta, &arg_type, &arg_size);
 	if (err)
 		return err;
@@ -8932,7 +8930,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			return -EFAULT;
 		}
 		key_size = meta->map.ptr->key_size;
-		err = check_helper_mem_access(env, reg, argno, key_size, BPF_READ, false, NULL,
+		err = check_helper_mem_access(env, reg, argno, key_size, BPF_READ, false, meta,
 					      NULL);
 		if (err)
 			return err;
diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_packet_access.c b/tools/testing/selftests/bpf/progs/verifier_helper_packet_access.c
index 71cee3f58324..12786b72c694 100644
--- a/tools/testing/selftests/bpf/progs/verifier_helper_packet_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_helper_packet_access.c
@@ -258,7 +258,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("tc")
 __description("helper access to packet: test11, cls unsuitable helper 1")
-__failure __msg("helper access to the packet")
+__failure __msg("function access to the packet")
 __naked void test11_cls_unsuitable_helper_1(void)
 {
 	asm volatile ("					\
@@ -283,7 +283,7 @@ l0_%=:	r0 = 0;						\
 
 SEC("tc")
 __description("helper access to packet: test12, cls unsuitable helper 2")
-__failure __msg("helper access to the packet")
+__failure __msg("function access to the packet")
 __naked void test12_cls_unsuitable_helper_2(void)
 {
 	asm volatile ("					\
-- 
2.52.0

