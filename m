Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328171;
	b=Ak1R6XMPJwtF0aTlb0ddDH5B73eOuvhKpQD9LMTQTdRabByHPQVpCtn2rRr09K9RXXVf
	 4rSOn1NZLgp0Xj+4hyMMEIPvt8EWY7vW+93R9r5MvfGQZFsjfTAdkXxkr5MK8kVvcazs+
	 MVYt+D9dDfWgn3mC9DVXhtPwctO+tl0susoKIrP3HiZzMF3Kd0JtRiA4BoY8/+tAh8cH/
	 0ApPO6nLafEG7jocLiaDmOUUTXuhGXGiesPDh37wT0ZER2+/ewqyNuYHa3sw7wGFbH8nn
	 fKbZ24iBDKd/4rhOJiXDOSC8rkKRjVJuVrpK8/MmPnR0l/Sv30gnBcmbTc7Suws7Puw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328171;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GnSlEXCfAYWX0BUaQQssXYW/i20wZpZ88Wvzskv1kms=;
	b=zk5awgaOpZAGB4QWyK+5xt0H/7ibaBu862uL0hZHP/5u/Bht98ZJ/QifE90TS13r4w66
	 H7dtGj6Ua5z7+FrzopXi+Z6vmaw74bKFyGHKJUniTQ55UX525XiEjDoJaf2mlpkef9l2l
	 L8tq3Ecli+LHqXjqiD7Dd5baKIng3zpRBR/H9p2ZbUBu30qSv1kqU2h8R0OV2smJi0cGx
	 GdvLOX/gm11mLSPu2XdL2zB+aJRudI1OxH0CRS6ffttQuFBe+pRgthCWG3Bh6/yHrmjlt
	 VB6+IlYQiYhju3KnKlWdTAkuWYpJfTyqVRcCZFTs+JYvoaoqmJQPeaIqWJjNfWlRBWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="XOpK9OW/";
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A773360A261A
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 16:29:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A773360A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XOpK9OW/
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so22490825e9.3
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 08:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794328169; x=1794932969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GnSlEXCfAYWX0BUaQQssXYW/i20wZpZ88Wvzskv1kms=;
        b=XOpK9OW/maoQLHYZJ6rXsBidMvFadNRQ5mvV+vQh0adhjviKGHOkWLEFw2hvn5/HXc
         eWHgB/GmKSVgIWXFLp8gLxQDTuMkWv8atbeHfve4ENjwjozL245/87nbW+8lTcMY34jp
         0O5ynawkihMQkQD9Gc3nF6eaX8kGxgk3f5JaorZXRk4XpyVSfQMMDjG5ZqgzZdYPyzuM
         96bomNokebHsP3rVMr2UbNhzKs+UkTb25lANpzc5/pl5BAaDBGS+8MNo+WLnQqEO13AH
         UxVydmJne0OKzr9pLNxcbBmEq9LOJfQLwDJ7ueOGWX8o7BIVeBVf99pxlYIkmccHMM1B
         dMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328169; x=1794932969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GnSlEXCfAYWX0BUaQQssXYW/i20wZpZ88Wvzskv1kms=;
        b=QwdyN7rtm8L2xIJR+QBNiv9guYvXTnF4W4i0JoqmUd9hk08UXocLMgr9+3drC4V42+
         2IAN5qKtTUICq4s5BCoPV7IatJPEVwTJIQFA45CvdrLE1av4omOaSLn7Nq15eHBWzvS9
         GCYfGDxb1VrL2jZ6cLa/Z74+aUuAGxlD498N8WhXKsYRsK1xMMfjfOa6olFNK1ks1bM8
         NAHK2Gi2XTojDjcfGAd6p1jAq3UmsGnTKVvIWU/qcCNAsS6XRFHstQ/H2nAJa7pQCNCl
         r7tJDtc4ky47vXsehRmMbhHU0I76FplsUz4MkLgf8HkAeeQ3DKuM5D0t5AF76BI3qOId
         v6yg==
X-Forwarded-Encrypted: i=1; AL+hErEWPBsEbA0TK1ksVO6A5Swlqi4Xq+0ZxeubcjPQ5TlvE3Y7c4tAvk8ho9Vz6w3M1GWvQDk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+0uMTt13O0v1OkVrMMGbyOOpFDegYzqhFaHUn7AQ8J8pv7q+iC
	CIOZ2QbmHOSOFWcM0sWXKmkhFBZJOFBeuIsk3JAfBd5vpF/5xo+zcGUy
X-Gm-Gg: AYBFou2YyhGA+dH3lXR9+W4Oj03uVFwi+MmqtuV655NjKdF7zypsODwx2+zQyMP6j6W
	hU618gjj7ooRym9Lgl4QsZohO6YGjZqdIIENt3diYiXlWTxYlZYIp3QhktYGlO3Vrbaf90p15GP
	UzIWHX4s/6QrPj8IXQRVuRvtDIwKJCUmDWN0D3Vnyy6xtjrTUSyidP4u0hkeKKbr7BjMT+pbkfT
	l/worOMDebVZIh8fzjh+Ko3VNb58HbhTLlao26VkR5So6X45+GYij8mzxDBILDvnPjmdUQqCPA2
	+F0NlHhobIqWCBBNPpPkmgg8vwL135XPtrMEcMy87pTxz3LbJEsWtyhd3fwJHN2ulKvJfBP/QF4
	Aew8keaoWsap2FgrPCBpKpfbUGBmuxK+FF/IkZBtZhWmxM+Zlx44yihqX+BVUl53G2B2Keav440
	nr293l4x0ThCwJmk5Kt0Oo1yzkLCF6q072jiEKfkWVImQNdJ0/AaLu2J8tlxtcgCLBwpKy2Ugo3
	RvkSgI/nN/4/s4+vh7XZqyrb4hso0HB2juWe6ESc3KxUD7mv5Tm4UTXlU5TwuKqSMmNlwDpQQ91
	ezcZHRuwoXbxJiu3bIUYvggz0LmphWhDnSQo7Jgpd8qLj4Q=
X-Received: by 2002:a05:600c:350c:b0:4a1:6517:ccf1 with SMTP id 5b1f17b1804b1-4ba0233ea4fmr53156235e9.9.1794328168839;
        Tue, 10 Nov 2026 08:29:28 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fea745sm71287485e9.10.2026.11.10.08.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:29:28 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v3 bpf-next 05/18] bpf: Declare fmod_ret targets with BTF_FMODRET sets
Date: Tue, 10 Nov 2026 16:40:25 +0000
Message-ID: <20261110164046.454431-6-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110164046.454431-1-a.s.protopopov@gmail.com>
References: <20261110164046.454431-1-a.s.protopopov@gmail.com>
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

Move the fmod_ret targets of the BPF test functions, MPTCP and bpf_testmod
from registered kfunc sets to BTF_FMODRET sets. Attachment flags stay the
same: bpf_fentry_test1 is still the sleepable target.

These functions are no longer kfuncs, so the bpf_kfunc decl tag, and
with it the vmlinux.h declaration, is gone. Only
bpf_modify_return_test_tp() stays a kfunc, as it is also in the
common_btf_ids kfunc set. Selftests which need bpf_fentry_test1 declare
it themselves.

No code registers an fmod_ret set anymore, as the kernel builds them from
BTF. Remove register_btf_fmodret_id_set(), so a module cannot register a
second set next to the one from its BTF.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 include/linux/btf.h                               |  1 -
 kernel/bpf/btf.c                                  |  7 -------
 net/bpf/test_run.c                                | 12 +++---------
 net/mptcp/bpf.c                                   | 15 ++-------------
 .../selftests/bpf/test_kmods/bpf_testmod.c        | 11 ++---------
 5 files changed, 7 insertions(+), 39 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 00495e7833b6..5522c7fe1373 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -632,7 +632,6 @@ u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
 				const struct bpf_prog *prog);
 int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
 			      const struct btf_kfunc_id_set *s);
-int register_btf_fmodret_id_set(const struct btf_kfunc_id_set *kset);
 s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id);
 int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_cnt,
 				struct module *owner);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 2c45e5fa1d7b..f81a8ae9b92c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -10294,13 +10294,6 @@ static int __init btf_fmodret_tags_init(void)
 }
 fs_initcall(btf_fmodret_tags_init);
 
-/* This function must be invoked only from initcalls/module init functions */
-int register_btf_fmodret_id_set(const struct btf_kfunc_id_set *kset)
-{
-	return __register_btf_kfunc_id_set(BTF_KFUNC_HOOK_FMODRET, kset);
-}
-EXPORT_SYMBOL_GPL(register_btf_fmodret_id_set);
-
 s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id)
 {
 	struct btf_id_dtor_kfunc_tab *tab = btf->dtor_kfunc_tab;
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index d6c9dc62182e..d63c3b697552 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -643,17 +643,12 @@ CFI_NOSEAL(bpf_kfunc_call_memb_release_dtor);
 
 __bpf_kfunc_end_defs();
 
-BTF_KFUNCS_START(bpf_test_modify_return_ids)
+BTF_FMODRET_START(bpf_test_modify_return_ids)
 BTF_ID_FLAGS(func, bpf_modify_return_test)
 BTF_ID_FLAGS(func, bpf_modify_return_test2)
 BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
 BTF_ID_FLAGS(func, bpf_fentry_test1, KF_SLEEPABLE)
-BTF_KFUNCS_END(bpf_test_modify_return_ids)
-
-static const struct btf_kfunc_id_set bpf_test_modify_return_set = {
-	.owner = THIS_MODULE,
-	.set   = &bpf_test_modify_return_ids,
-};
+BTF_FMODRET_END(bpf_test_modify_return_ids)
 
 BTF_KFUNCS_START(test_sk_check_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_release, KF_RELEASE)
@@ -1905,8 +1900,7 @@ static int __init bpf_prog_test_run_init(void)
 	};
 	int ret;
 
-	ret = register_btf_fmodret_id_set(&bpf_test_modify_return_set);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_prog_test_kfunc_set);
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_prog_test_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_prog_test_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_prog_test_kfunc_set);
 	return ret ?: register_btf_id_dtor_kfuncs(bpf_prog_test_dtor_kfunc,
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 4cc16cbeb328..d0d489624689 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -20,17 +20,6 @@ struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
 	return NULL;
 }
 
-BTF_SET8_START(bpf_mptcp_fmodret_ids)
+BTF_FMODRET_START(bpf_mptcp_fmodret_ids)
 BTF_ID_FLAGS(func, update_socket_protocol)
-BTF_SET8_END(bpf_mptcp_fmodret_ids)
-
-static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
-	.owner = THIS_MODULE,
-	.set   = &bpf_mptcp_fmodret_ids,
-};
-
-static int __init bpf_mptcp_kfunc_init(void)
-{
-	return register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
-}
-late_initcall(bpf_mptcp_kfunc_init);
+BTF_FMODRET_END(bpf_mptcp_fmodret_ids)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 41ff36f0ca77..91cb311a2dc8 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -2607,15 +2607,9 @@ struct bpf_struct_ops testmod_multi_st_ops = {
 
 extern int bpf_fentry_test1(int a);
 
-BTF_KFUNCS_START(bpf_testmod_trampoline_count_ids)
+BTF_FMODRET_START(bpf_testmod_trampoline_count_ids)
 BTF_ID_FLAGS(func, bpf_testmod_trampoline_count_test)
-BTF_KFUNCS_END(bpf_testmod_trampoline_count_ids)
-
-static const struct
-btf_kfunc_id_set bpf_testmod_trampoline_count_fmodret_set = {
-	.owner = THIS_MODULE,
-	.set = &bpf_testmod_trampoline_count_ids,
-};
+BTF_FMODRET_END(bpf_testmod_trampoline_count_ids)
 
 static int bpf_testmod_init(void)
 {
@@ -2633,7 +2627,6 @@ static int bpf_testmod_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_testmod_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_testmod_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_testmod_kfunc_set);
-	ret = ret ?: register_btf_fmodret_id_set(&bpf_testmod_trampoline_count_fmodret_set);
 	ret = ret ?: register_bpf_struct_ops(&bpf_bpf_testmod_ops, bpf_testmod_ops);
 	ret = ret ?: register_bpf_struct_ops(&bpf_testmod_ops2, bpf_testmod_ops2);
 	ret = ret ?: register_bpf_struct_ops(&bpf_testmod_ops3, bpf_testmod_ops3);
-- 
2.43.0

