Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27AA3B059C
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 22:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788645713; cv=none; b=fK/x5ky5Q8YdI86ZNZvi0yOh6DsED3uAiWTjbGRPVpHIYG1gZqzNoHkcg+duStypWHpMyn75MmfHjTqNj0q4FPTnxeXsAWnPIW1Z+vOAVSPEoeTw2sra10GcYzYWPZ9GMhmwohSHyx42aTzRY6taV5SSzkVS8DXd/ya6vvcVt+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788645713; c=relaxed/simple;
	bh=WTux83t1RNTPvkY4Eia9AtDKQ75SBMnOF6IfUzpLA2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r83lfRqg43iCSYl5k57TH6VQiskuC+mNYzpO8DJVv9HJW8/sKiG/QGv+3TAyxLS9ESFdv/1S5oHb9nSh44ffDlqTm+5ut2AZ2UrVNJ7mcmgkUS/CRdPZnKvncExK8YvgIkmkcSint3MwoNJmEiFI5ZKBScjIVButSIPfTF/FMLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNIUvbH9; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNIUvbH9"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6b128dd0cb1so1514962eaf.3
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 15:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788645710; x=1789250510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XyvwS02J3+yPeyRgxBN2Ol3Rg1dCptnABjFgmUje2iM=;
        b=KNIUvbH92BNA2m3hsArctXn73rZylA0OGpUy1TwaltVfrrwN5J2L3yDLnpGMhV6OLj
         R3D3ucWIUAVyc9wkbyaRjXNxo5zn7olzgH8UOcOMvZD3D7JRypeVlCoplkG+xmlW7qXH
         LBVgeyPABBeesHTopfk5GwYNl/o6oRtLX8ba662vGsFQOuivO7oCjjHhG7D293SdqdOZ
         z2jNvzyPGHCumDM4CQtl7USxvkg8T/tSdpQPNqiFV59A856BJstZTR1h470nHAHuiJej
         5CV2MyDvKiFHldfc7t5G0kYC2uEYQwPlFDBjmlE/8Mj1SmAnCepDj4fDasD/a8yrHawD
         3cCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788645710; x=1789250510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XyvwS02J3+yPeyRgxBN2Ol3Rg1dCptnABjFgmUje2iM=;
        b=al57pDQUXyqyPltu4MR7nsA/Kb65MN0xfelIVl4jUwUimDJTTuaArhwsLuKHa5zPA9
         hubUwuuIyiKFARo3qo/UAwShvb8N0Z6xEORnYYktCo7SCypBUFT8aiVCwvJv9MzISSbj
         FeT9/Hav+ZL29fFZFJ63gopSi/9JzurEMu5aP61pSGksJLfO0Dt9RkPvOiTts0dMhdgO
         My5JnZRDVc4K6W8OVPsZ0DsEIBktITZws2B9du460otdwqXMRY1gJCx4G2GNjWREzZ0P
         99zw171gtjAEJCG0gp+GXrUHRM903Bc/wJdRyw4lYQ6cdXLZYTv4TvEe0gpn69xD0EtW
         KrJw==
X-Gm-Message-State: AFuF++lG8UMf0WVEYmqZn0SKY/RvoFeBXYRyRAgA45Yk2QYqqd6oubnL
	UiPxep/fzv5bs1+Nc5II6KRryqjGQ5bt5PlHxKY2lvZRWVPTG5v00pypgQSYKQ==
X-Gm-Gg: AYBFou2RKJyDEf03yIRKScYmSFMPyG6NZXHB7rt+8hSSHCrH9CpV/UwWiyM6hly7xqA
	+Be2oTB9Z5/U5WOd9BFIkVOmR+n3o7qnR9KDtKg+MZEsxYa0DcE85MagFdf8ZFmtXmjnRoMiv/X
	GnJrbuTHwhjtsaxBLHsYGVCI9vpFyvFdTNVwP9A0kwCt9MKvqC32mekk02l3swzFyY0OOZBEF4S
	tRnX2AOgcK/ZrH4jqzhHOJElq8d2ZJ1sbJqoDdAVyBzboQsdPHI9J4vLHVBwrOGgVVgSuTpmkEH
	kfSiXnWEt7wYjRounNs8dgDo4o5i96L7fb7T/hUmEm8Wa1vBkphbW1SBBtmNt+zBmzGIdbtKv2H
	x7NaJss8UuPWqZGD2zzGGFrYDr52trT5kBCzmiKRritsfJW21BZzY5IDu9wvmv63nBIkIJ8U8Kn
	rzgspqRJzA7bYXvHJD9MTQjRWo7+x1I69Y7zKz4T+RUHCuXI64rmA=
X-Received: by 2002:a05:6820:a07:b0:6b9:3295:7712 with SMTP id 006d021491bc7-6b932957a0cmr2145885eaf.53.1788645710226;
        Sat, 05 Sep 2026 15:01:50 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:44::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47554935751sm5831598fac.11.2026.09.05.15.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 15:01:49 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 20/22] bpf: Consolidate function call pkt_access validation
Date: Sat,  5 Sep 2026 15:01:15 -0700
Message-ID: <20260905220117.922028-21-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260905220117.922028-1-ameryhung@gmail.com>
References: <20260905220117.922028-1-ameryhung@gmail.com>
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
index cad49ea5fdfa..487ad1ee4179 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4849,7 +4849,7 @@ static int check_map_access(struct bpf_verifier_env *env, struct bpf_reg_state *
 }
 
 static bool may_access_direct_pkt_data(struct bpf_verifier_env *env,
-			       const struct bpf_func_proto *fn,
+			       const struct bpf_call_arg_meta *meta,
 			       enum bpf_access_type t)
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
@@ -4873,10 +4873,11 @@ static bool may_access_direct_pkt_data(struct bpf_verifier_env *env,
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
@@ -7048,6 +7049,10 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, struct bpf_reg_
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
@@ -7164,7 +7169,7 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 	 * the memory that the helper could just partially fill up.
 	 */
 	if (!tnum_is_const(size_reg->var_off))
-		meta = NULL;
+		meta->arg_raw_mem.regno = 0;
 
 	if (reg_smin(size_reg) < 0) {
 		verbose(env, "%s min value is negative, either use unsigned or 'var &= const'\n",
@@ -8773,7 +8778,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	struct bpf_reg_state *reg = get_func_arg_reg(caller, regs, arg);
 	enum bpf_arg_type arg_type = fn->arg_type[arg];
 	int regno = reg_from_argno(argno);
-	enum bpf_reg_type type = reg->type;
 	u32 arg_size = arg_type & MEM_FIXED_SIZE ? fn->arg_size[arg] : 0;
 	u32 key_size;
 	int err = 0;
@@ -8798,12 +8802,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
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
@@ -8876,7 +8874,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
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

