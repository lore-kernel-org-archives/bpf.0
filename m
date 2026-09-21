Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E2C15665C
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 02:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789958345; cv=none; b=kz0PMykJu6tLvEk8xQL2nHkY28Lz1Agk9XbR5US4rlIH2gK4OSyUPlyrMJOW1wUSN+EMklgmVWD43Mmv3lTdeD8BHnGLdHcEErNifS6HRNbbhL/5hMcvM5JAr+Hu3q3+WL3m6jykHyaW+COZYMAkq7080g+9AkTwGBwrHTjvVbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789958345; c=relaxed/simple;
	bh=N4IY8y4dVcpQvjB2ndiPzIqrVGoMeP2M4WOLI0Z0Bqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cv1qhh3b5zfmV+aZAt6CRmF8WmXMWXoDu5XYl1iOO7hoHN8GetJn7Lh/SrgHFozvL9Kr7/gnPK1iL61ZPcovKBKILRXxpUa/JXSBoA12RIk/bAzn+vQq2iNs89UGpcZrikV9rU2dt3RCoU+Br1OPrIO0XRjlN5RBer6BZcE1pqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmdWswpw; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmdWswpw"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-49fd4ea3409so1118765e9.0
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 19:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789958341; x=1790563141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RELnWSkUyacVldQIjFCOrMYsfZBo0qvwhLGZemFkBiI=;
        b=CmdWswpwovS/x55A0HDIpYnwRytzSlbyVk922mP2l7yf1waYulvoPWTyoI2lnL9eKa
         xPAcpfFazP965Zs+A5dDEDwmU7tqkKEeENecMwQfAhFJkwIQGhPb8fBfBZX0fAmS0nHe
         Q4nXmdOTjfBp4TfBNz7XFgZiR27hmOh3WNXDkZYBOFajXDjfJ7ur50f8aq7QWyCvSs7a
         xqhksaOK9HvjaiuW69kPPBp+iM5gWoCtpkvwHz/c+gj/HHUnxmdLd9/47geI1mx3JJFG
         bX1X3dXREgaq8bGyVWW5+EFV1jXQYITau5mIrF5489DY8cpILu0PTDyhifuLySB6zaTf
         ekew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789958341; x=1790563141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RELnWSkUyacVldQIjFCOrMYsfZBo0qvwhLGZemFkBiI=;
        b=xmWnwmeeM1Nec+Jb0Zows6eUDsFqOChQ8JapwnqIjLwgbnRFnpSu8XpF9w+boyKaoa
         HRcSSrTgMOtsw9aGsRjN79/YRWRyujeh+T5iD+YDxoKFXKV874I7AtHEzHhddD+oqCpC
         Q0Eme5nzHc4QGCIZpbEky0bjdxK00Ryr3oSmGLFmA5EK+eWLJ+SWAuLvobb1FY3/a2Q+
         EmEzk2zvRF96bOunpg39gh7pn5g1yNRcibx0eZMutZiYL3GaoAS5mc8uWOWCiuE8J19V
         63LpCgcYIoAYYtwJxRlGY96MwZoFrkTTlmcoRUp6m2qnDSAsU5PjkoUbEP2B3Luu+v5k
         01HQ==
X-Gm-Message-State: AFuF++lM/DKVVEl6uOgv3qnu1BELCYXnkaHVesIwnFh2QPLm08hTQtyH
	kRlSFdaUhMZ7BxWks7VL7CziZeg2LxVA30yXH9SIFTpc/Dpwg187DvmqliTKm78R
X-Gm-Gg: AYBFou2n85pneFQwZuAZPnBNbEjNQzSTSOOE+RFZgYqCCMHIYGeJYz4bbGvBN7EIfwo
	4sj4vlu1SxgkcGNO7gwQjCNObXdox3SJ+WIMt3M+TblcKMo0tfiKuZ3u87qJbrVYZ8FBIHSC+ta
	5YrdYlV/n54sZqZFRugktMDTbkcuJqd/JF7QvAhPMgNIxTa5kRkVlVZZrKp4ATSgVLvOz/6gqCI
	rffNqfvVgJc05P7CC11IH1FALxzwsU7mtMiNu7sWyvSOiTogybdfXODuOl64X9bXOp+oq59heQh
	+6EutSCgXChzpiyJqkaRKQo7lesAi9Ql3SGTRxRYPj7aWPjsenB4VDea3cKkPNDGUhL0bZQwpOp
	n4SqYpjgFu1NtD5kLIN/vrFUi/GmFKlVbhsAXMnGByAzajS5flY8dnONKKqhgGsq2/X9up4fi8S
	hEp+AW1Wx1bCnbRsaotGT0tsqG5yJHL8iaVERGvEw5juug3mam/me/RAHTkiH2aZ3++RDlX+aJo
	BxMoMZ6ZredJBcjmU9b40mnAJLFq0GjKVBcKPLcnYbFWk56jVvt+KrGnpO7UD1Erupa/taAZszp
	B7JlfMD9Ean5tlcFF1PsiWghtFRD7np8hOiG5bPwNpgAeOxY
X-Received: by 2002:a05:600c:3107:b0:49c:ff9f:f6b6 with SMTP id 5b1f17b1804b1-49fc5669346mr130605925e9.6.1789958341142;
        Sun, 20 Sep 2026 19:39:01 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcc1160a1sm155601505e9.4.2026.09.20.19.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 19:39:00 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 09/11] selftests/bpf: Cover generic output stack initialization
Date: Mon, 21 Sep 2026 04:38:33 +0200
Message-ID: <20260921023843.411943-10-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921023843.411943-1-memxor@gmail.com>
References: <20260921023843.411943-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17462; i=memxor@gmail.com; h=from:subject; bh=N4IY8y4dVcpQvjB2ndiPzIqrVGoMeP2M4WOLI0Z0Bqo=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvD9K0bhA+1KbcfLGt7slHq1Zy1Kxl+l/+zuxYQaMf8b q1202r3jlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEykyZqR4VdcBKvyrrI8X2GZ dvXGt5JeFgHmE/J43y9oTCtL/yl5i+GvkGHyxRPPYt7M1ck+t/D4XKuk5I0G374YfZR27J1zoes 3MwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Exercise generic output buffers with and without CAP_PERFMON, using both
helpers and __uninit kfuncs. Check that initialized bytes stay readable
and lose stale value information, while invalid bytes remain unreadable
without permission to read uninitialized stack memory. Cover constant and
variable sizes, scalar spills, pointer spills, special stack objects, and
privileged variable offsets.

Add a kfunc that writes only the first byte of its output. Its runtime tests
read preinitialized bytes, checking both the written byte and an untouched
tail byte across a liveness checkpoint. Verify that the sysctl name helper
and uninitialized fixed and variable-sized kfunc outputs are accepted when
their contents are not read back.

Update existing __uninit readback expectations and exercise skb_load_bytes
with reduced capabilities. Even fully-writing generic outputs now preserve
invalid bytes in the verifier, so reading those bytes requires prior
initialization by the BPF program.

Use map_update_elem inputs for helper_arg_fallback_keeps_scanning. Its
original snprintf argument no longer reads the buffer, and a privileged
output with an unknown size does not trigger the whole-stack read fallback.
A variable-offset key and parent-frame value retain the intended assertion.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../progs/verifier_helper_access_var_len.c    | 189 ++++++++++++++++++
 .../bpf/progs/verifier_kfunc_uninit.c         | 136 +++++++++++++
 .../bpf/progs/verifier_kfunc_uninit_multi.c   |   6 +-
 .../selftests/bpf/progs/verifier_live_stack.c |  33 ++-
 .../selftests/bpf/progs/verifier_raw_stack.c  |   4 +
 .../selftests/bpf/test_kmods/bpf_testmod.c    |   7 +
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   1 +
 7 files changed, 356 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_helper_access_var_len.c b/tools/testing/selftests/bpf/progs/verifier_helper_access_var_len.c
index d1452ef6f2f9..e87eb6f221e4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_helper_access_var_len.c
+++ b/tools/testing/selftests/bpf/progs/verifier_helper_access_var_len.c
@@ -822,4 +822,193 @@ __naked void bytes_no_leak_init_memory(void)
 	: __clobber_all);
 }
 
+SEC("cgroup/sysctl")
+__success
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__success_unpriv
+__naked void sysctl_initialized_stack(void)
+{
+	asm volatile (
+		"*(u64 *)(r10 - 16) = 0;"
+		"*(u64 *)(r10 - 8) = 0;"
+		"r2 = r10;"
+		"r2 += -16;"
+		"r3 = 16;"
+		"r4 = 0;"
+		"call %[bpf_sysctl_get_name];"
+		"r0 = *(u8 *)(r10 - 1);"
+		"r0 &= 1;"
+		"exit;"
+		: : __imm(bpf_sysctl_get_name) : __clobber_all);
+}
+
+SEC("cgroup/sysctl")
+__success
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__success_unpriv
+__naked void sysctl_uninitialized_stack(void)
+{
+	asm volatile (
+		"r2 = r10;"
+		"r2 += -16;"
+		"r3 = 16;"
+		"r4 = 0;"
+		"call %[bpf_sysctl_get_name];"
+		"r0 = 0;"
+		"exit;"
+		: : __imm(bpf_sysctl_get_name) : __clobber_all);
+}
+
+SEC("cgroup/sysctl")
+__success
+__flag(BPF_F_TEST_STATE_FREQ)
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__success_unpriv
+__naked void sysctl_partial_initialized_bytes(void)
+{
+	asm volatile (
+		"*(u32 *)(r10 - 16) = 0;"
+		"*(u8 *)(r10 - 1) = 1;"
+		"goto +0;"
+		"r2 = r10;"
+		"r2 += -16;"
+		"r3 = 16;"
+		"r4 = 0;"
+		"call %[bpf_sysctl_get_name];"
+		"r0 = *(u32 *)(r10 - 16);"
+		"r1 = *(u8 *)(r10 - 1);"
+		"r0 += r1;"
+		"r0 &= 1;"
+		"exit;"
+		: : __imm(bpf_sysctl_get_name) : __clobber_all);
+}
+
+SEC("cgroup/sysctl")
+__success
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__failure_unpriv __msg_unpriv("invalid read from stack off -1+0 size 1")
+__naked void sysctl_partial_invalid_bytes(void)
+{
+	asm volatile (
+		"*(u32 *)(r10 - 16) = 0;"
+		"r2 = r10;"
+		"r2 += -16;"
+		"r3 = 16;"
+		"r4 = 0;"
+		"call %[bpf_sysctl_get_name];"
+		"r0 = *(u8 *)(r10 - 1);"
+		"r0 &= 1;"
+		"exit;"
+		: : __imm(bpf_sysctl_get_name) : __clobber_all);
+}
+
+SEC("cgroup/sysctl")
+__success
+__flag(BPF_F_TEST_STATE_FREQ)
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__success_unpriv
+__naked void sysctl_partial_variable_size(void)
+{
+	asm volatile (
+		"r3 = *(u32 *)(r1 + 0);"
+		"r3 &= 15;"
+		"r3 += 1;"
+		"*(u8 *)(r10 - 1) = 1;"
+		"goto +0;"
+		"r2 = r10;"
+		"r2 += -16;"
+		"r4 = 0;"
+		"call %[bpf_sysctl_get_name];"
+		"r0 = *(u8 *)(r10 - 1);"
+		"r0 &= 1;"
+		"exit;"
+		: : __imm(bpf_sysctl_get_name) : __clobber_all);
+}
+
+SEC("cgroup/sysctl")
+__success
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__failure_unpriv __msg_unpriv("invalid read from stack off -1+0 size 1")
+__naked void sysctl_partial_variable_invalid(void)
+{
+	asm volatile (
+		"r3 = *(u32 *)(r1 + 0);"
+		"r3 &= 15;"
+		"r3 += 1;"
+		"r2 = r10;"
+		"r2 += -16;"
+		"r4 = 0;"
+		"call %[bpf_sysctl_get_name];"
+		"r0 = *(u8 *)(r10 - 1);"
+		"r0 &= 1;"
+		"exit;"
+		: : __imm(bpf_sysctl_get_name) : __clobber_all);
+}
+
+SEC("cgroup/sysctl")
+__success
+__flag(BPF_F_TEST_STATE_FREQ)
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__failure_unpriv __msg_unpriv("invalid read from stack R2")
+__naked void sysctl_partial_spilled_pointer(void)
+{
+	asm volatile (
+		"*(u64 *)(r10 - 8) = r1;"
+		"goto +0;"
+		"r2 = r10;"
+		"r2 += -8;"
+		"r3 = 8;"
+		"r4 = 0;"
+		"call %[bpf_sysctl_get_name];"
+		"r0 = 0;"
+		"exit;"
+		: : __imm(bpf_sysctl_get_name) : __clobber_all);
+}
+
+SEC("cgroup/sysctl")
+__success
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__failure_unpriv __msg_unpriv("invalid read from stack R2")
+int sysctl_partial_dynptr(struct bpf_sysctl *ctx)
+{
+	struct bpf_dynptr ptr;
+	long long key = 0, *data;
+
+	data = bpf_map_lookup_elem(&map_hash_8b, &key);
+	if (!data)
+		return 0;
+	bpf_dynptr_from_mem(data, sizeof(*data), 0, &ptr);
+	bpf_sysctl_get_name(ctx, (char *)&ptr, sizeof(ptr), 0);
+	return 0;
+}
+
+SEC("cgroup/sysctl")
+__success
+__naked void sysctl_partial_variable_offset(void)
+{
+	asm volatile (
+		"r2 = *(u32 *)(r1 + 0);"
+		"r2 &= 8;"
+		"r2 += r10;"
+		"r2 += -24;"
+		"r3 = 16;"
+		"r4 = 0;"
+		"call %[bpf_sysctl_get_name];"
+		"r0 = *(u8 *)(r10 - 16);"
+		"r0 &= 1;"
+		"exit;"
+		: : __imm(bpf_sysctl_get_name) : __clobber_all);
+}
+
+SEC("tc")
+__success __retval(42)
+int snprintf_partial_output_runtime(struct __sk_buff *ctx)
+{
+	char buf[16];
+
+	buf[15] = 42;
+	bpf_snprintf(buf, sizeof(buf), "ok", NULL, 0);
+	return buf[15];
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit.c b/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit.c
index f7818303e703..ff2fb36a0260 100644
--- a/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit.c
+++ b/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit.c
@@ -12,6 +12,7 @@ void __kfunc_btf_root(void)
 	asm volatile ("" :
 		: "r"(&bpf_kfunc_test_uninit_struct),
 		  "r"(&bpf_kfunc_test_uninit_mem),
+		  "r"(&bpf_kfunc_test_uninit_partial),
 		  "r"(&bpf_kfunc_test_uninit_alias));
 }
 
@@ -97,4 +98,139 @@ __naked void uninitialized_input_alias(void)
 		: : __imm(bpf_kfunc_test_uninit_alias) : __clobber_all);
 }
 
+SEC("tc")
+__success __retval(0)
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__prepare_priv
+__success_unpriv
+__naked void uninitialized_struct_output_ignored(void)
+{
+	asm volatile (
+		"r1 = r10;"
+		"r1 += -16;"
+		"call %[bpf_kfunc_test_uninit_struct];"
+		"r0 = 0;"
+		"exit;"
+		: : __imm(bpf_kfunc_test_uninit_struct) : __clobber_all);
+}
+
+SEC("tc")
+__success __retval(0)
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__prepare_priv
+__success_unpriv
+__naked void variable_size_uninitialized_output_ignored(void)
+{
+	asm volatile (
+		"r2 = *(u32 *)(r1 + 0);"
+		"r2 &= 7;"
+		"r2 += 1;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_kfunc_test_uninit_mem];"
+		"r0 = 0;"
+		"exit;"
+		: : __imm(bpf_kfunc_test_uninit_mem) : __clobber_all);
+}
+
+SEC("tc")
+__success __retval(49)
+__flag(BPF_F_TEST_STATE_FREQ)
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__prepare_priv
+__success_unpriv
+__naked void partial_output_preserves_initialized_bytes(void)
+{
+	asm volatile (
+		"*(u8 *)(r10 - 8) = 0;"
+		"*(u8 *)(r10 - 1) = 7;"
+		"goto +0;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = 8;"
+		"call %[bpf_kfunc_test_uninit_partial];"
+		"r0 = *(u8 *)(r10 - 8);"
+		"r1 = *(u8 *)(r10 - 1);"
+		"r0 += r1;"
+		"exit;"
+		: : __imm(bpf_kfunc_test_uninit_partial) : __clobber_all);
+}
+
+SEC("tc")
+__success __retval(42)
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__prepare_priv
+__failure_unpriv __msg_unpriv("invalid read from stack off -8+0 size 1")
+__naked void uninitialized_sized_output_read(void)
+{
+	asm volatile (
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = 8;"
+		"call %[bpf_kfunc_test_uninit_mem];"
+		"r0 = *(u8 *)(r10 - 8);"
+		"exit;"
+		: : __imm(bpf_kfunc_test_uninit_mem) : __clobber_all);
+}
+
+SEC("tc")
+__success __retval(42)
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__prepare_priv
+__failure_unpriv __msg_unpriv("invalid read from stack off -8+0 size 1")
+__naked void variable_size_uninitialized_output_read(void)
+{
+	asm volatile (
+		"r2 = *(u32 *)(r1 + 0);"
+		"r2 &= 7;"
+		"r2 += 1;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_kfunc_test_uninit_mem];"
+		"r0 = *(u8 *)(r10 - 8);"
+		"exit;"
+		: : __imm(bpf_kfunc_test_uninit_mem) : __clobber_all);
+}
+
+SEC("tc")
+__success __retval(1)
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__prepare_priv
+__failure_unpriv __msg_unpriv("invalid read from stack off -16+0 size 4")
+__naked void fixed_struct_uninitialized_output_read(void)
+{
+	asm volatile (
+		"r1 = r10;"
+		"r1 += -16;"
+		"call %[bpf_kfunc_test_uninit_struct];"
+		"r0 = *(u32 *)(r10 - 16);"
+		"exit;"
+		: : __imm(bpf_kfunc_test_uninit_struct) : __clobber_all);
+}
+
+SEC("tc")
+__success __retval(49)
+__flag(BPF_F_TEST_STATE_FREQ)
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__prepare_priv
+__success_unpriv
+__naked void partial_output_variable_size(void)
+{
+	asm volatile (
+		"r2 = *(u32 *)(r1 + 0);"
+		"r2 &= 7;"
+		"r2 += 1;"
+		"*(u8 *)(r10 - 8) = 0;"
+		"*(u8 *)(r10 - 1) = 7;"
+		"goto +0;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_kfunc_test_uninit_partial];"
+		"r0 = *(u8 *)(r10 - 8);"
+		"r1 = *(u8 *)(r10 - 1);"
+		"r0 += r1;"
+		"exit;"
+		: : __imm(bpf_kfunc_test_uninit_partial) : __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit_multi.c b/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit_multi.c
index 18ced0d0a3b2..ab3bb81a11fd 100644
--- a/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit_multi.c
+++ b/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit_multi.c
@@ -49,7 +49,7 @@ SEC("tc")
 __success __retval(42)
 __caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
 __prepare_priv
-__success_unpriv
+__failure_unpriv __msg_unpriv("invalid read from stack off -16+0 size 4")
 __naked void variable_size_preserves_other_output(void)
 {
 	asm volatile (
@@ -71,7 +71,7 @@ __arch_x86_64 __arch_arm64
 __success __retval(42)
 __caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
 __prepare_priv
-__success_unpriv
+__failure_unpriv __msg_unpriv("invalid read from stack off -8+0 size 4")
 __naked void output_after_by_value_argument(void)
 {
 	asm volatile (
@@ -91,7 +91,7 @@ __arch_x86_64 __arch_arm64 __arch_riscv64
 __success __retval(15)
 __caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
 __prepare_priv
-__success_unpriv
+__failure_unpriv __msg_unpriv("invalid read from stack off -8+0 size 4")
 __naked void output_passed_on_stack(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index bc3dfdc1a536..7a1a0670f851 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -21,8 +21,6 @@ struct {
 	__type(value, __u64);
 } array_map_8b SEC(".maps");
 
-const char snprintf_u64_fmt[] = "%llu";
-
 SEC("socket")
 __log_level(2)
 __msg("0: (79) r1 = *(u64 *)(r10 -8)        ; use: fp0-8")
@@ -1947,15 +1945,15 @@ static __used __naked void fwd_parent_key_to_helper(void)
 
 /*
  * Regression for keeping later helper args after a whole-stack fallback
- * on an earlier local arg.  The first bpf_snprintf() arg is a local
+ * on an earlier local arg.  The bpf_map_update_elem() key is a local
  * frame-derived pointer with offset-imprecise tracking (`fp1 ?`), which
- * conservatively marks the whole local stack live.  The fourth arg still
+ * conservatively marks the whole local stack live.  The value arg still
  * forwards &parent_fp-8 and must contribute nonlocal_use[0]=0:3.
  */
 SEC("socket")
 __log_level(2)
 __success
-__msg("call bpf_snprintf{{.*}}        ; use: fp1-8..-512 fp0-8")
+__msg("call bpf_map_update_elem{{.*}}; use: fp1-8..-512 fp0-8")
 __naked void helper_arg_fallback_keeps_scanning(void)
 {
 	asm volatile (
@@ -1963,32 +1961,33 @@ __naked void helper_arg_fallback_keeps_scanning(void)
 	"*(u64 *)(r10 - 8) = r1;"
 	"r1 = r10;"
 	"r1 += -8;"
-	"call helper_snprintf_parent_after_local_fallback;"
+	"call helper_update_parent_after_local_fallback;"
 	"r0 = 0;"
 	"exit;"
 	::: __clobber_all);
 }
 
-static __used __naked void helper_snprintf_parent_after_local_fallback(void)
+static __used __naked void helper_update_parent_after_local_fallback(void)
 {
 	asm volatile (
 	"r6 = r1;"				/* save &parent_fp-8 */
 	"call %[bpf_get_prandom_u32];"
 	"r0 &= 8;"
-	"r1 = r10;"
-	"r1 += -16;"
-	"r1 += r0;"				/* local fp, offset-imprecise */
-	"r2 = 8;"
-	"r3 = %[snprintf_u64_fmt] ll;"
-	"r4 = r6;"				/* later arg: parent fp-8 */
-	"r5 = 8;"
-	"call %[bpf_snprintf];"
+	"*(u64 *)(r10 - 16) = 0;"
+	"*(u64 *)(r10 - 8) = 0;"
+	"r2 = r10;"
+	"r2 += -16;"
+	"r2 += r0;"				/* local fp, offset-imprecise */
+	"r1 = %[array_map_8b] ll;"
+	"r3 = r6;"				/* later arg: parent fp-8 */
+	"r4 = 0;"
+	"call %[bpf_map_update_elem];"
 	"r0 = 0;"
 	"exit;"
 	:
 	: __imm(bpf_get_prandom_u32),
-	  __imm(bpf_snprintf),
-	  __imm_addr(snprintf_u64_fmt)
+	  __imm(bpf_map_update_elem),
+	  __imm_addr(array_map_8b)
 	: __clobber_all);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_raw_stack.c b/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
index c689665e07b9..9f0f48ecb421 100644
--- a/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
@@ -84,6 +84,8 @@ __naked void skb_load_bytes_zero_len(void)
 SEC("tc")
 __description("raw_stack: skb_load_bytes, no init")
 __success __retval(0)
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__failure_unpriv __msg_unpriv("invalid read from stack off -8+0 size 8")
 __naked void skb_load_bytes_no_init(void)
 {
 	asm volatile ("					\
@@ -103,6 +105,8 @@ __naked void skb_load_bytes_no_init(void)
 SEC("tc")
 __description("raw_stack: skb_load_bytes, init")
 __success __retval(0)
+__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__success_unpriv
 __naked void stack_skb_load_bytes_init(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 211886a8ee87..93847ca6293b 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1330,6 +1330,12 @@ __bpf_kfunc void bpf_kfunc_test_uninit_mem(void *out__uninit, u32 out__sz)
 	memset(out__uninit, 0x2a, out__sz);
 }
 
+__bpf_kfunc void bpf_kfunc_test_uninit_partial(void *out__uninit, u32 out__sz)
+{
+	if (out__sz)
+		*(u8 *)out__uninit = 42;
+}
+
 __bpf_kfunc int bpf_kfunc_test_uninit_alias(int *out__uninit, const int *in)
 {
 	int value = get_unaligned(in);
@@ -1788,6 +1794,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass2)
 BTF_ID_FLAGS(func, bpf_kfunc_test_uninit_struct)
 BTF_ID_FLAGS(func, bpf_kfunc_test_uninit_mem)
+BTF_ID_FLAGS(func, bpf_kfunc_test_uninit_partial)
 BTF_ID_FLAGS(func, bpf_kfunc_test_uninit_alias)
 BTF_ID_FLAGS(func, bpf_kfunc_test_uninit_multi)
 BTF_ID_FLAGS(func, bpf_kfunc_test_uninit_pair)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 524f2cb9bdf4..67c02a421d13 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -291,6 +291,7 @@ void bpf_kfunc_call_test_pass1(struct prog_test_pass1 *p) __ksym;
 void bpf_kfunc_call_test_pass2(struct prog_test_pass2 *p) __ksym;
 void bpf_kfunc_test_uninit_struct(struct prog_test_pass1 *out__uninit) __ksym;
 void bpf_kfunc_test_uninit_mem(void *out__uninit, __u32 out__sz) __ksym;
+void bpf_kfunc_test_uninit_partial(void *out__uninit, __u32 out__sz) __ksym;
 int bpf_kfunc_test_uninit_alias(int *out__uninit, const int *in) __ksym;
 void bpf_kfunc_test_uninit_multi(int *a__uninit, void *b__uninit, __u32 b__sz) __ksym;
 void bpf_kfunc_test_uninit_pair(struct prog_test_pair_arg p, int *out__uninit) __ksym;
-- 
2.53.0

