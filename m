Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47BF47C0FB
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432476; cv=none; b=FJZ/prZLmslKwO2IBRY3xWP+oaMOSKDWQc6cOs8mXWOcioF7SEyCBV4Vo49m6u7UFjQDBi2PjjNT5G+JI8YR3lozaiD1Qut0E0jqNlMoVJWJaUh/n8IdnOd6MPF717Ak1t29wzgU7O6lLqOB+u4fQ68PnI1l1AVrHPiqxPrnUFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432476; c=relaxed/simple;
	bh=XIoroSFSrAEcArazgXTwZukJX7VhgOnEU4YBfCYKezM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CC08ntECgsa6KbUqxAssf7DhQuQWW4jqIj+zCMEiUOcnw1uDMjTcs6Pm8kKEIg7RWAe1mQgS2CHif8vac84zPvD+9SikRNDjc4qZzpid1w9RMzL66lBlVQ7CWxluuJ0m2oAw/gMo8V7YjbmSyqpQBC1qLsATvVN1kBibIGruiRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNNyidrZ; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNNyidrZ"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2db1ca069c8so7868005ad.3
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432474; x=1791037274; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WcIYBCnapxPRAKoNA0t1+vrv8htm7L56qIdaIQ1F6DA=;
        b=mNNyidrZoC2VAkugZBEi0dJcuo8ejoAzPCUOODPvOU5u+pwKfpDJW7eFR58aSRbg9c
         dllLNkKBpy22kJy6SnpThqhdRA/VZGCjmea8hXugI4sDLZfYMQtLZIBxHy7wG8KqEQU2
         2ytYg+3ECPr8+L4vScgOVfKuaX8gj/ugS2LoImQUDl2A9KzTWIgnJiXgycVn3xWJnWcs
         qX3HgUufWPwVDR8XezPHusKIpJkTBbXOKaiGsOZLvOqjV7rn3GPadQ66uAUJxsho4q8e
         rWWvVYpw9xgcOle6HVwdpF28Tu9acwWfrUnLO2RnlL2goKV6NhXln4YnAWsEXmGPOv1s
         rqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432474; x=1791037274;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WcIYBCnapxPRAKoNA0t1+vrv8htm7L56qIdaIQ1F6DA=;
        b=AImaAi7iSaMWxL1UG8pgRAGpsmiXCgo1b/nRYZ9QC/C5d37ISqJTSFioVgvfxZL2s0
         0F81rKXBO5GAyNAgN2QqLSXwDDY3iJKAS6FMlasgn7F7O6FMwx9R2TuWmtzKmNF8EgBo
         dULerSakzoMN18dZXI4O+f0IzZKNPc2XOGeTCeK1teytkXJFlRx7967539xkNJUHq5SI
         7TO6X5h9CUDIwpSYGEw+Ayy2WaBOgZ6OMHFPPCM+d2BC8CUKxbqHVJqbWN6rvzzNhC9W
         vBRNyML4Pkmmn3swSGgXI3z8Url8by31dNgX+PPoib0hpEw9eTYKHg2WGF2f7/ZAXJAh
         D+bw==
X-Gm-Message-State: AFq9FYKHxlN4tbFbb1AYIiXvhvTCi5T1Z2wHq8YjPYgu9SO9J9V3yemf
	kdjVWU7/8X9EE2xhkM8ajdqp7clxaL3Jkx7WrzD5PUpHJhF3yqhfQL3kyIcV5mN2JAo=
X-Gm-Gg: AYBFou1NzfXaFTsuO08mZ092sVRHx4+laXfUPcXxMSvTOqHXZ+Da+HnI+qYTg1v8jGj
	NtNeRGwUy6Yd6o2u1E8vlf72UTGqJIcTmfOkzNgwaFZkYJqlKcoQlGCdJf+vRVThhcWujFRxkKo
	/x1fpHtc7azrmUIK3rlLOFMf4JoI3vB4xLkFnlmEesysytl3J3FF3s9wL0nyhW9bOO7jpEzwY4y
	tOrjyqejAS7vs/TZKr4ss/uhnC97dHeBPVig4KHI1ioNMnwAmYWgn/QE/JkVGsmmixiPCbob1Wm
	HtEhd00gHBS26N2Vi7uz7nsuB0ADPbOL/bS/1CVQPub+ETnq/N4fjdzRHNGvLL0WRt0WpebQm9z
	fL8+e/0VqDplj1lj/YaiVGijlqfP3Is+BbFgdbk5lHQXKsYCVYK3v9J1LARml/PuH6PSwpbEMV/
	2hJ0MIfS7Pke1Aro8hnY6+AkWt1wq6bUxac3O4mgGavuZcgel/8bJK48p3p3lENvKttRpzwsj29
	3MYkPvPCm84EYDMYQRWzKpWPbgq7ylNuVODJ0Ofnw==
X-Received: by 2002:a17:90b:3c8e:b0:3a0:e0a5:dbcd with SMTP id 98e67ed59e1d1-3a0e0a5df1emr1660187a91.37.1790432474032;
        Sat, 26 Sep 2026 07:21:14 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm10949613a91.1.2026.09.26.07.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:21:13 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 30/36] selftests/bpf: tests for may_def marks of atomic RMW operations
Date: Sat, 26 Sep 2026 07:20:28 -0700
Message-ID: <20260926-scev-minimal-rebase-v1-30-c8e5ab5ba79f@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Liveness analysis should produce may_def marks for read-modify-write
atomic operations:
- lock *(u64 *)(r10 -8) += r1
- r1 = atomic64_fetch_add((u64 *)(r10 -8), r1)
- r1 = atomic64_xchg((u64 *)(r10 -8), r1)
- r0 = atomic64_cmpxchg((u64 *)(r10 -8), r0, r1)

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_live_stack.c      | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 41df0c393981..496229a9b284 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -2666,6 +2666,32 @@ __naked void load_acquire_dont_clear_dst(void)
 
 #endif /* CAN_USE_LOAD_ACQ_STORE_REL */
 
+SEC("socket")
+__log_level(2)
+__success
+__msg("lock *(u64 *)(r10 -8) += r1{{.*}}use: fp0-8{{.*}}may_def: fp0-8")
+__msg("r1 = atomic64_fetch_add((u64 *)(r10 -8), r1){{.*}}use: fp0-8{{.*}}may_def: fp0-8")
+__msg("r1 = atomic64_xchg((u64 *)(r10 -8), r1){{.*}}use: fp0-8{{.*}}may_def: fp0-8")
+__msg("r0 = atomic64_cmpxchg((u64 *)(r10 -8), r0, r1){{.*}}use: fp0-8{{.*}}may_def: fp0-8")
+__naked void atomic_rmw(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u64 *)(r10 - 8) = r1;"
+	".8byte %[atomic_add];"
+	".8byte %[atomic_fetch_add];"
+	".8byte %[atomic_xchg];"
+	"r0 = 0;"
+	".8byte %[atomic_cmpxchg];"
+	"exit;"
+	:
+	: __imm_insn(atomic_add, BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_10, BPF_REG_1, -8)),
+	  __imm_insn(atomic_fetch_add, BPF_ATOMIC_OP(BPF_DW, BPF_ADD | BPF_FETCH, BPF_REG_10, BPF_REG_1, -8)),
+	  __imm_insn(atomic_xchg, BPF_ATOMIC_OP(BPF_DW, BPF_XCHG, BPF_REG_10, BPF_REG_1, -8)),
+	  __imm_insn(atomic_cmpxchg, BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, BPF_REG_10, BPF_REG_1, -8))
+	: __clobber_all);
+}
+
 SEC("socket")
 __success
 __naked void imprecise_fill_loses_cross_frame(void)

-- 
2.55.0
