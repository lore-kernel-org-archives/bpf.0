Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243289;
	b=12a1d/U87mdbW3lkVFPU7GnM1PKTEfgpcr6QHvLmBkzvkiWUaBVlKroY4GbESzB/Tz+M
	 JK1k6j1N++tcH+5MhfImt+UCnB7/vryL40Seh+SbqiFOI5ZjDYMjcSzIoXkSjJBzWm7Sj
	 BmEentrEqAi0oTzek+wospPzaWo210UWb4hQcWgsSTUOjGndtUBzYC/tR0FXlq8C2da83
	 mT4HFmid3DGO4he/aWlHcZaJfYo44q1/q97AboOOVzvfRyZJdlXoHlAHPZLKP2MR7uy/R
	 ImYpZl0FIGqNAHu/oKvuZhvwBmj3DUwDXVpmPbtRZ/rIXNPeHTJbNHIdUXLWYbYtSJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243289;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GnSlEXCfAYWX0BUaQQssXYW/i20wZpZ88Wvzskv1kms=;
	b=QZcif0/EY74/csW+GA2diBvV43hqRDQt1NEnw2foo+lKg7GbMWoEame5caI6Oaan8hjb
	 v06mZPpEkJvP/CH5u6Ki9eyIO755TDk9ETPthLB7FMWHvAXyLFsnROSeoKyEp08N0nqe1
	 x+vVBJgCiYd3wnmrEPXQB/U/KuJnR8lsHz42r4M3jcft/QWJ3rMx0aaFjMB4zeP3X90xk
	 RV7XYvOehYnVsWwSqOm4Z3O8u0t3gzGqaaSepgfk7zY8dO/EmxTKUaP3fsxQdd7eEo/8k
	 y0pHxGhQtMJHUQCZWofa+y6VnzZDRhNS9Nj4GprT8q6XKIgioJqnhTNVs7E/jC/oMzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MDIGLpU1;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD2B60A383F
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 16:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FD2B60A383F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MDIGLpU1
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4918c2d727fso574579f8f.3
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 08:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243288; x=1794848088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GnSlEXCfAYWX0BUaQQssXYW/i20wZpZ88Wvzskv1kms=;
        b=MDIGLpU12dyazLzj1gduW4ftQUKJoGj2Abg4DQEQ85HbKPIs7BVCUuDtm8IIpn6XTb
         6xLk8czGRWsgwflXpvSpoVwIRqZ133asGUr7vYdrNJ/VmaNFIL49xUT7BhA/umdUmO5t
         A83XKK4Yw5GWdnHUQ/d/xUE31m/hH/xuGWNLiTCt4BJLuXiFbmR4RXNqwH5DCGIABwGj
         yhBMiWWW1W+YYliT5sxV5e61j1mG/FrKLFbC7A1JeVw06xBsRdoSr0ROubBLlHyTi7nX
         ZVKLaKWZLlZlSnYYoxGynrOQvBk1V8SDwckE1Z4YjjNaYPJrNPiLl07dyx0ka3nxwZKe
         B7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243288; x=1794848088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GnSlEXCfAYWX0BUaQQssXYW/i20wZpZ88Wvzskv1kms=;
        b=rhnP0+WbBjqv4EwjpR11ACHM7a4OForuvkPpCPOZkshvcvRrXHDI0Rjh8vZzLFAOJf
         LFxCgsoGP65jQ6nr5QwoLQUH3CPYPWP8uBYGTmxz41Rxnj3NJlYL7Y0lu6UopiyOGFry
         aCmMOyX6xv8jK/ge7P/2uUv5Xxy9Bj3tO3ZRiidpNxJUi0B1LvUeMCG+tZls7Ov/F149
         V0Ss0ZVCeteS4wjXD16H1JMhe8hmfkSSjj/bX+HI6gmiHYe2HW+Kpzv7kV1n0kUb6fb7
         HBUhFK3JMzPU3sdVuZiQLZ2Y3LCHjkefGHz8If+elCBBSlJtWAJGbNyWOT3U75tV02uW
         IiDg==
X-Forwarded-Encrypted: i=1; AL+hErFimCIJ8dKzodrQO+4XAEoy4bNLnUgkUiwQvHxYAfZkwbOLT3Z26EZKqDN3urGhywo29sc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/wTyx4CkGaztu0AUhcjuXcUIO1wcVB1CNAGtCJIW5DeJ/FCUom
	h1svj698Cmox8O4Sv5jxJ0XMnNzZ71JRPsiTLEcLqbTM8Cn/09EEHrmr
X-Gm-Gg: AYBFou2GWMTIjQcOzDDVLOh+B3PEXa9L+qq19BACCfC55fsYYoMEgXmxhpN20IhuZy7
	MP2jiRt/i3vnTJtqBM6P3Y6dzAGV3FWtKjKeVkGqh3FCf3fklNdp1+Bb7cbi1zDywDan9s7u7CZ
	Gm5aDcEYJVVuQnv9KuBZIQWFGaAp70iyUVlRJpO8emAEfEiQzDgrI++drIoYrTBuIi5zRrOh5al
	SjHlygoOEeyxsRwBFzKnXhLyzE7NBpRaTK8R3JKEMaw2sW5tPCKguZZrCTKK8c8d2u9JqFNJjlP
	Oqqm3/+GO1bpH4TdOwaWcyoy/viNEXF8qMH8bL6G3a8g9SrCjQitJE7TJ5vOC91UO3+aI4lOgx/
	8pWmbkWaa+/4TRX9ktT8BNbrJyuFZorv3ev1wxTnPb/LvZcpmfIHEpnFz/G25TbZMgkcphbXOg5
	SAK4d8lpRhiXtmpIHF+ddClOOq9c0oarfB23R1Mt5EH4Min+QM1uHPjlTvoCaj7awCiQVSIjPp4
	i4RnzLPzgNrsdx4jebywmGErrEgR8dUCc0LBr0WneAulapXmoEzVUGVZ7Can98Mt22ajSq07fzY
	ZBRh9GvYcNdCnX8yyQKXBJhYHl/I22x+huw7z0+sLzngZDg=
X-Received: by 2002:a05:6000:2006:b0:48e:720a:ccaf with SMTP id ffacd0b85a97d-4982b28a87amr173590f8f.5.1794243287705;
        Mon, 09 Nov 2026 08:54:47 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4959783fd04sm11392369f8f.47.2026.11.09.08.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:54:45 -0800 (PST)
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
Subject: [PATCH v2 bpf-next 05/18] bpf: Declare fmod_ret targets with BTF_FMODRET sets
Date: Mon,  9 Nov 2026 17:05:25 +0000
Message-ID: <20261109170550.141443-6-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109170550.141443-1-a.s.protopopov@gmail.com>
References: <20261109170550.141443-1-a.s.protopopov@gmail.com>
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

