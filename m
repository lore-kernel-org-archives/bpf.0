Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792790517;
	b=cEDjY+AO8TGDXfnn+Gye8OUip8UICY4RjL344Nq6CHvKc2k2JZBnAXeJgJ/vIeEjphOL
	 EHrmSp1rytPJEshsZqoVyd/NjvOCK36UKLpnr0xnnV5IV9aJExWymssCsJkcSV5haXknq
	 datYpR9Nuf+RkYYYDvI2ApQGVllPafMoQU/rrB2QaYKrURrlvtNcCNNJPHe0Qi5Q4/Nkx
	 TxelPRJ7r37nsDP7omvYH7wtBzrMIDAxZ0mvRsk68IJPGeVEhWUcflEyR0MQPPYhcFrxa
	 QtkWLMw38KDc0AychUatNieqVEcgw1+ov32Dyg+sLcHJj8bj1Omb+9OHRAL94P6bgGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790517;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cNMAii4viuPWpDFNjsclLTJRjbUNd2eARaCPf06Nm+E=;
	b=ATbcsyvkV/nJszoY3aLcHr6+WQKGWqpfblpDaO1aFPZ0TDd9hLEDUU1CzsHt9UaXJ45b
	 S0C8WNLaAxye2+Sa0PMxRtRPKIrC+i7bfWrqfXnn2jHZ4yYmy1+lPBDk2MF22lAWqfM1R
	 EGUxteb9xu9m7x6S+n33onG97hAIQRwNGpp1Ydqx/s1szavivwevRPu+YbeQUEDxKPjzy
	 FcohBkDwH/B69bCxqM9NtpChbZg6MNKo375F7zlUWPdW1DUarphsnCxtLNqujWvT05VOA
	 k28uw6u95xdbGrvDlUekHKHiNDVJJ6iaWEky4U0bj/6G4XzOYZJe5RuRz7bVkrm0JGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OZ0x9qR1;
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9294606A320
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 21:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9294606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OZ0x9qR1
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8ac9d666d4eso11328417b3.3
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 14:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792790516; x=1793395316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cNMAii4viuPWpDFNjsclLTJRjbUNd2eARaCPf06Nm+E=;
        b=OZ0x9qR1EU8RR2hE+GEzWriU/QyhBdZp5XlZM7MlEqQvhP+b1k6lPl7qgfhoFpaJ3x
         Blmu6MmuclrbtEDbdPgyst3fPDlc6S95JMYFFBfz3u4MWakLKCa8kN9Pl0NndJ80stKu
         ZfJLQUx+O18QuBqM4Cpja3QnOqTDULzlWriZHulN+wTZ+CVCbuX/kZ0rtGWYKwauby89
         mWYeiJYREEKhqxUDdUcaVp8c6TAe8UA5Y3LoFgEm37lExXZQ3XEhsjxPfA7Kn4VP0aF7
         ZQ/R0y2S0b7nIxCDhKXqLBfNtXhD8nP2KT2zsgX1zK9L/RbzCe30PrMln4AqnISaE5t2
         2++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792790516; x=1793395316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cNMAii4viuPWpDFNjsclLTJRjbUNd2eARaCPf06Nm+E=;
        b=dEPeyXquhN3s/7Thg63T0/otxFeCUwf44wVfftaJHBJMmrKb+T723xlN6+9980ZryU
         An/o5UhKao013lqDvEqf0VZl0i6wmHjEp+Rq/6+NBdL8r6Dplbbj6QHrdR+Khs0b2bAF
         +UoYhDp1Yj68qC+3Ae7RuouY+3VFj301gKE0koPf8Co/8U0oGEhoC0UXRMp9Cm/OzoKk
         KZfc2wgVS56pojIHXPOvk+qHcP7S7Bkuo/iq5DDe4cpUESas8VxsojOzYmhQr4iTWF0P
         bH7lp0qHF/aR5jJcR+kwe9/YGpG9GdoEdW0riJm82JVGhCgktDgRjQBlORcY2c5JkDZs
         a4rw==
X-Forwarded-Encrypted: i=1; AKwUvBz1yeeYrJkTNc7d5AYGDzzFZh8jOkp/ILphzvkUMV+hHc6eV1w2NWXW3cll2bjBWYu4gPg=@vger.kernel.org
X-Gm-Message-State: AFq9FYI4UA7K1ZuNc+RnfX4y/LwP28shxRTcWQiP2X2UuhK7rkRKF8iG
	MvOzcssYmaD2jABy8ajP4KGPUwacmptgk4kdGLEwWVNWVoJAhoXMck3VOVjanA==
X-Gm-Gg: AYBFou32SXcaAqd5quTxb34i0YB8V27HI5YjxsBKcMbZ+Ka0GUN4CkaX7pmAle7AneG
	o9nbqT0UgINEhpgLz+p76Suj5gsTp0lqM/t50/zbUYZ05EKTDkgVaz8rz71/1OyHV6+OCe5C5Xf
	/GN+BPSVehEOSsx4y6PJ8yGhHrk6H65j+nO+FWbO43CYIbLsxPB90x+aBOFvbzyJxzXelXxKZyG
	eUTY8QXYWh8BIx6NGWIs1P4vIix3DxCtRXAC6eXomm0KA7IaRJPLBmVfeBvGcikmxgrrm/04i5J
	LChA3MARISs3oIZSl8jT2U5hVvoaoatcKZhnREIrHapLfQMsjIqrpTF35dax1B/xMtxJ7UV0PzU
	yA7VShMw8kv78PDNo5cKcxeDZ29ran340SsR8+YuyGetmFY8ZBmqTNSqrA90IYBsC4juKEtp6UP
	/VHO1GTDGX1F4/1wgngFEWjJpl8EEDoJEPH60YtBBFz5Rw5eavhKpNDPuqlvURGBuZbd3H1+bHl
	0r+Hp2FOrFS5w6owxjinygQLsoEbjKrCAFU2XoJl4eXJv48PIp1M8UIpw==
X-Received: by 2002:a05:690c:dd5:b0:87f:cfa:3db1 with SMTP id 00721157ae682-8b166be0ae5mr3017517b3.39.1792790515981;
        Fri, 23 Oct 2026 14:21:55 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:35e2:98f8:e90a:1695])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b166e46a93sm1915667b3.26.2026.10.23.14.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 14:21:55 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Song Liu <song@kernel.org>,
	Chris Mason <mason@kernel.org>,
	Xu Yunxiang <xyx2021@mail.ustc.edu.cn>,
	Amery Hung <ameryhung@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	bpf@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next v3 5/5] selftests/bpf: Test __derives_ret return invalidation on argument release
Date: Fri, 23 Oct 2026 17:20:41 -0400
Message-ID: <20261023212041.884996-6-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023212041.884996-1-utilityemal77@gmail.com>
References: <20261023212041.884996-1-utilityemal77@gmail.com>
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

A pointer a kfunc derives from a __derives_ret argument must not
outlive the reference that keeps the argument alive. Cover the inode
bpf_real_data_inode() returns for a file acquired from
bpf_get_task_exe_file(): a reject test dereferences it after
bpf_put_file(), an accept test before.

Annotate the argument of bpf_kfunc_call_test3() in bpf_testmod, which
returns its argument, and cover a socket acquired through a helper the
same way around bpf_sk_release().

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 .../testing/selftests/bpf/bpf_experimental.h  |  9 ++++
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_derives_ret.c          | 50 +++++++++++++++++++
 .../selftests/bpf/progs/verifier_vfs_accept.c | 20 ++++++++
 .../selftests/bpf/progs/verifier_vfs_reject.c | 22 ++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  4 +-
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  2 +-
 7 files changed, 106 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_derives_ret.c

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 2893bf06ff25..e9dfd5d2e1ec 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -64,6 +64,15 @@ extern struct file *bpf_get_task_exe_file(struct task_struct *task) __ksym;
  */
 extern void bpf_put_file(struct file *file) __ksym;
 
+/* Description
+ *	Resolve the supplied file to the inode hosting its data. The supplied
+ *	file must be trusted/referenced; the inode is valid only as long as
+ *	the file is.
+ * Returns
+ *	The inode hosting the file's data, or NULL.
+ */
+extern struct inode *bpf_real_data_inode(struct file *file) __ksym;
+
 /* Description
  *	Resolve a pathname for the supplied path and store it in the supplied
  *	buffer. The supplied path must be trusted/referenced.
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 04740ba37e91..ff6e6515ea48 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -45,6 +45,7 @@
 #include "verifier_ctx_sk_msg.skel.h"
 #include "verifier_d_path.skel.h"
 #include "verifier_default_trusted_ptr.skel.h"
+#include "verifier_derives_ret.skel.h"
 #include "verifier_direct_packet_access.skel.h"
 #include "verifier_direct_stack_access_wraparound.skel.h"
 #include "verifier_div0.skel.h"
@@ -237,6 +238,7 @@ void test_verifier_ctx(void)                  { RUN_TESTS(verifier_ctx); }
 void test_verifier_ctx_sk_msg(void)           { RUN(verifier_ctx_sk_msg); }
 void test_verifier_d_path(void)               { RUN(verifier_d_path); }
 void test_verifier_default_trusted_ptr(void)  { RUN_TESTS(verifier_default_trusted_ptr); }
+void test_verifier_derives_ret(void)          { RUN_TESTS(verifier_derives_ret); }
 void test_verifier_direct_packet_access(void) { RUN(verifier_direct_packet_access); }
 void test_verifier_direct_stack_access_wraparound(void) { RUN(verifier_direct_stack_access_wraparound); }
 void test_verifier_div0(void)                 { RUN(verifier_div0); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_derives_ret.c b/tools/testing/selftests/bpf/progs/verifier_derives_ret.c
new file mode 100644
index 000000000000..041d2a656233
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_derives_ret.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Justin Suess */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+#include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+/* bpf_kfunc_call_test3() returns its __derives_ret argument. */
+
+SEC("tc")
+__success
+int derived_sock_used_before_release(struct __sk_buff *skb)
+{
+	struct bpf_sock_tuple tuple = {};
+	struct sock *derived;
+	struct bpf_sock *sk;
+	int state;
+
+	sk = bpf_sk_lookup_tcp(skb, &tuple, sizeof(tuple.ipv4), BPF_F_CURRENT_NETNS, 0);
+	if (!sk)
+		return 0;
+
+	derived = bpf_kfunc_call_test3((struct sock *)sk);
+	state = derived->__sk_common.skc_state;
+	bpf_sk_release(sk);
+	return state;
+}
+
+SEC("tc")
+__failure __msg("invalid mem access 'scalar'")
+int derived_sock_outlives_release(struct __sk_buff *skb)
+{
+	struct bpf_sock_tuple tuple = {};
+	struct sock *derived;
+	struct bpf_sock *sk;
+
+	sk = bpf_sk_lookup_tcp(skb, &tuple, sizeof(tuple.ipv4), BPF_F_CURRENT_NETNS, 0);
+	if (!sk)
+		return 0;
+
+	derived = bpf_kfunc_call_test3((struct sock *)sk);
+	bpf_sk_release(sk);
+
+	/* derived was pinned by sk's reference and died with it. */
+	return derived->__sk_common.skc_state;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c b/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
index 34919abcff04..3f9e1f8fba58 100644
--- a/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
+++ b/tools/testing/selftests/bpf/progs/verifier_vfs_accept.c
@@ -124,4 +124,24 @@ int BPF_PROG(trusted_field_used_in_rcu_cs, struct linux_binprm *bprm)
 	return 0;
 }
 
+SEC("lsm.s/file_open")
+__success
+int BPF_PROG(derived_inode_used_before_put)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct file *file = bpf_get_task_exe_file(task);
+	struct inode *inode;
+	umode_t mode = 0;
+
+	if (!file)
+		return 0;
+
+	inode = bpf_real_data_inode(file);
+	if (inode)
+		mode = inode->i_mode;
+	bpf_put_file(file);
+	__sink(mode);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
index 067b4f979902..df2fe54deeff 100644
--- a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
+++ b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
@@ -224,4 +224,26 @@ int BPF_PROG(trusted_field_escapes_rcu_cs, struct linux_binprm *bprm)
 	subprog_trusted_inode(inode);
 	return 0;
 }
+
+SEC("lsm.s/file_open")
+__failure __msg("invalid mem access 'scalar'")
+int BPF_PROG(derived_inode_outlives_parent_reference)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct file *file = bpf_get_task_exe_file(task);
+	struct inode *inode;
+
+	if (!file)
+		return 0;
+
+	inode = bpf_real_data_inode(file);
+	if (!inode) {
+		bpf_put_file(file);
+		return 0;
+	}
+	bpf_put_file(file);
+
+	/* inode was derived from file's reference and died with it. */
+	return inode->i_mode;
+}
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 6380f52f4dd2..5308daa2259d 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1073,9 +1073,9 @@ __bpf_kfunc int bpf_kfunc_call_test2(struct sock *sk, u32 a, u32 b)
 	return a + b;
 }
 
-__bpf_kfunc struct sock *bpf_kfunc_call_test3(struct sock *sk)
+__bpf_kfunc struct sock *bpf_kfunc_call_test3(struct sock *sk__derives_ret)
 {
-	return sk;
+	return sk__derives_ret;
 }
 
 __bpf_kfunc long noinline bpf_kfunc_call_test4(signed char a, short b, int c, long d)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 3b810f1e438f..ccef296a9961 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -230,7 +230,7 @@ int bpf_testmod_ops3_call_test_nullable(void) __ksym;
 __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
 				__u32 c, __u64 d) __ksym;
 int bpf_kfunc_call_test2(struct sock *sk, __u32 a, __u32 b) __ksym;
-struct sock *bpf_kfunc_call_test3(struct sock *sk) __ksym;
+struct sock *bpf_kfunc_call_test3(struct sock *sk__derives_ret) __ksym;
 long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
 int bpf_kfunc_call_test5(__u8 a, __u16 b, __u32 c) __ksym;
 #ifdef __SIZEOF_INT128__
-- 
2.55.0

