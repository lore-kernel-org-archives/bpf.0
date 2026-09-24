Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B136349CD6
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238389; cv=none; b=B4w9bO0++fr6y6GX9O3diFGVSbZGT/DAxdX25JSD68bFD6CrihG4x8wi//3xevwXn1kY+pc4dG84l5GAuM1TOZXNmNBtof5o8g2kXTgF1aqf0J81K3P3VHtlZ8VZDbPvPxGAdrtAcvh2cAPkb3JdBCrvN+5dR4blOf+OP3XiAAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238389; c=relaxed/simple;
	bh=i0ynLbSwgzfOm7o4IJSLX0RoNEADaMII0zDO9q/uV4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zc3GW3oLmIvn0e02L8e3D4FKbWF3SwvREmEuk8wmmix/4RrFQtT7EBvxGCKwqN6nQ4nF4ECtoGejaTgCvCPJDalgVnOE8EKsNbUHElcmNu965bv5CIDY1YRPa8obCcBM5bJ6Lo4E5WZqwEa8X6LwJ6aEsUFVyilycNXcVnSUy9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NE7BGhej; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NE7BGhej"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49cfcf2548aso5763115e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 01:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790238386; x=1790843186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rk0W2+kDQ9wOmen/Go1msDr9ipAbOPS6t82SaJP0VV4=;
        b=NE7BGhejZIlPRPrmwrM4DDTi//31zwEbHyOG/GiNAxVuXEV032/UzKEwXPBA+q4J7I
         0cIxfEqDkhKzZbdSsRz4ZPEVrjdEirT7DI8+Ruvy2RvRrCS9ig8le0PveENEv8oeR7D4
         tV5G3Dq3gm06Gv96O+FGSy3GMf2Fod/mmJUpNQG4slCLNnj0ofUaxlLFN+XFCv8PhCrB
         ARtoVHfxyT8ivzfcUow/2WlCWgCV47fg2T+BDgNMOeNkV8EetgteerzteMw2kn6t1dQ1
         wpM+cWzwcKE9aeUAld258OkcQo2Ect38JbhKEQwEiBJYfKJD8d8NnKeb8p5L+8T5w8YE
         IS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790238386; x=1790843186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rk0W2+kDQ9wOmen/Go1msDr9ipAbOPS6t82SaJP0VV4=;
        b=oTpQ/j2fIkFuhpASlMoDIMVYweWZP5DvUf0DLoVtwHDZACGxX3wvHFX8azluBWGdjC
         MunCrLKtO36vJCpDtnkc7+Apyt/YmkWZuF2honZkDI/nlPta4jPjK/OgkHg24l7+PJ6a
         vuIUamXflM83VXXQm99PmHlDpVY8Za9aTtwfHX0iW5ypYO4CavGp3Bxe2rAOhK5l4t0O
         eoCEXZ3SZ6qE3YJIEIMJWGT5thk2p1AGsTQLxsnMRQmji3DQ983+wi1rHz5QjNBA8aak
         EQOujmC11DmWCWjnxNHBGEScxOD0faEUIEHJY0c62rTKM6kezY/aGYpbr7pW+YFgkXEj
         B3rw==
X-Gm-Message-State: AFuF++nCvpHrptfn1+ldK3TcnFPyC/qiI7KCaBXiCYIQdX8/vS6WqzGR
	F2hz8M6XmgF/MHHr+Ef9AnnPo5/NkvXf8MpIIo5Pq+BBh0wzIVHo4Tj/jWT74s46
X-Gm-Gg: AYBFou0t+OVPHOhqABRYqTvx6DD1QIvwtcnITxclpBILwZT9bSp2VqGRfWZAQkhDFlv
	3KH8ssEGxKvLOmUQVk+V7RftahZ+C91kczHpCBtA+wqzFUZpNTnEFdy3fdxMqQhB3P6jB6NZwix
	rtjJASRBZqwQOGFDTTOkCWqLRgVDFzlZir+G/uzkYEwbkMHi4YsR2SU3cPZzrRf7jHhocfVBBcv
	pYvOlHaaxYUcMkO5ACeq8skjtVHXm6rZbwdEHYljNdUyhAW5LHaMlkGgS0XVfDYfZwokUIJd3wR
	nwX4YACbjtfZZOm889DBDDMYe2xcLvKGQY9h0M+e+OoOwE5i5EoSdMQBRcwDq2aasn2T6ieCwUH
	GmoAmGhuniwcmWATRfFOHmGXZUOZIIFaqjGtjq2OPQxCWcwkkCA2Gc4EjM4VKIGHBxIYiRj4rpz
	UUCBI8zpYTTja4n+jScOYDzC0MJoiN3jpO0R9aJzIJzZQmS23ZJhV77hrvnQooEX/4IHDGXIrC8
	2U9V/dDDDmnRnweQmY+oVzzw588B55/Pk54vc6P2EpMLiYqhdf4de/zneQ4qOKkNOsY21N9gXqX
	h9n2ZRry7KKkmQZnkz+BG87nh8VD4dPFOr2mLQ==
X-Received: by 2002:a05:600c:621a:b0:496:c1f3:e8f8 with SMTP id 5b1f17b1804b1-49fe7b52ed6mr21090525e9.7.1790238385440;
        Thu, 24 Sep 2026 01:26:25 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5b9f253sm55103895e9.1.2026.09.24.01.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 01:26:24 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 09/18] selftests/bpf: Cover the tail call caller stack depth limit
Date: Thu, 24 Sep 2026 10:25:45 +0200
Message-ID: <20260924082607.2695649-10-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924082607.2695649-1-memxor@gmail.com>
References: <20260924082607.2695649-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2420; i=memxor@gmail.com; h=from:subject; bh=i0ynLbSwgzfOm7o4IJSLX0RoNEADaMII0zDO9q/uV4w=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvLveSXD7dMUv7Xvfn+/0PMKyw/Xn994PiN4EArk8npy /ruKP826ihlYRDjYpAVU2Qp+b+PyfhE5e9A22XcMHNYmUCGMHBxCsBEREMZGZ5cdpjPtj5OrPrD z5+fnj1yllnv7Nb3ueXCqov+ugZb/P4z/DN1cn4ZxdFnd6sy45veQcHrsd0X/5TtqpnTyzDtfTS TPicA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A tail call from a subprog only unwinds that subprog's frame, so the
verifier refuses tail calls once the frames of the callers add up to
256 bytes or more. Nothing exercised that rule. Add a pair of tests
with a caller using 240 and 256 bytes of stack respectively, the
latter expecting the "tail_calls are not allowed when call stack of
previous frames is 256 bytes" rejection.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/verifier_tailcall.c   | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_tailcall.c b/tools/testing/selftests/bpf/progs/verifier_tailcall.c
index b4acce60fb9b..51687da97225 100644
--- a/tools/testing/selftests/bpf/progs/verifier_tailcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_tailcall.c
@@ -28,4 +28,61 @@ __naked void invalid_map_for_tail_call(void)
 	: __clobber_all);
 }
 
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+__used __naked
+static int subprog_tail_call(void)
+{
+	asm volatile ("			\
+	r2 = %[jmp_table] ll;		\
+	r3 = 0;				\
+	call %[bpf_tail_call];		\
+	r0 = 0;				\
+	exit;				\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(jmp_table)
+	: __clobber_all);
+}
+
+/*
+ * A tail call unwinds only the frame of the subprog doing it, so the
+ * frames of its callers stay on the stack. With up to 33 tail calls in
+ * a chain the verifier caps the stack those frames may add up to at
+ * 256 bytes.
+ */
+SEC("tc")
+__description("tail call from subprog with 240 bytes of caller stack")
+__success
+__naked void tail_call_caller_stack_ok(void)
+{
+	asm volatile ("			\
+	r2 = 42;			\
+	*(u64 *)(r10 - 240) = r2;	\
+	call subprog_tail_call;		\
+	r0 = 0;				\
+	exit;				\
+"	::: __clobber_all);
+}
+
+SEC("tc")
+__description("tail call from subprog with 256 bytes of caller stack")
+__failure
+__msg("tail_calls are not allowed when call stack of previous frames is 256 bytes. Too large")
+__naked void tail_call_caller_stack_too_large(void)
+{
+	asm volatile ("			\
+	r2 = 42;			\
+	*(u64 *)(r10 - 256) = r2;	\
+	call subprog_tail_call;		\
+	r0 = 0;				\
+	exit;				\
+"	::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0

