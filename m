Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEA33A9DAB
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 07:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786778376; cv=none; b=Drx8w9YH1h8wQAnGBCeJFOu3K1pKHfDvhXRMJdFQMFJ8GlOhWOngEr+gJ0WitLf7a7sZAs9JG+8mX3NIaphVSzVaYAcYq5hyThqAz5svGXcKWGaln3mj3rZdmd04B6ZoeAhupDTygcYmOa2Ldk/i94skUomWdktGSEa55CLYpME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786778376; c=relaxed/simple;
	bh=dq7rsWXPg7CPAZjoVJMMMnSIieGznr1tY7BH0+TvScU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o+PrpX3t6Xs9wsgXj6pDZhOoHD2YvJBiI/sz1PM5WVN3bK7pAq1huQdf3jQl4OnKJf3jXJf3nWolj7Af+edxI22zBlunteULAWjjeqV0P8bLlTBkkt1FestMqT+MIUoeSa9bLhm2FfwVdqrwnu9wnK6mjs8NRQhjMP+HLod9gvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADr3lDS9; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADr3lDS9"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso1348938a91.1
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 00:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786778374; x=1787383174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wLVuog34z6R6soPMaJ74HbUeKt8zA1r3GQLtA9oJDos=;
        b=ADr3lDS9x+9/VeUSIDjHfiVDH+0J3szkNsJ3ZAXP1TnRg7r4ulGhiriDhPu/Gkja/z
         /o+O7SMWTNnOB4OpzmQshhNkCm6QCDz/mgPczk0XT+YM/NCug6cWkuE3qtxPhGgBGXDb
         8J5lwcSKIcnzoTYNwt47bgqoEcBWVn0gJZTMahwhDqU5UYGW0YlzreoQATpJNvS/xk90
         CeafqmlJi35Tr7iLVVF+WsuTuhM4K9TTqx+qmjeI1MR7/yejWKiqbJRUjD9PPOhkRd1m
         o2cel29VjrU1u49eF1em6bA4QTL10qw1Me7y7ILNHydjA8gvfhwL+ghaG6RJqgfdgat0
         3a7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786778374; x=1787383174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wLVuog34z6R6soPMaJ74HbUeKt8zA1r3GQLtA9oJDos=;
        b=dUFzK4nkPKa3Q7feWkW3mT0RoIEn513jglBE8EXS+vfQNvze3CpGabbBcn3cLD5e/s
         fOUKX8c5M1Tov8Wm0V66cf5SberTy9cDnD4LDiOQVBRLD8VKQWQmR5tWbA9AXanS5pyQ
         g41JlEmIStyp9/FIYas8F0hflrlpXVypYgi9SUKbXdHQp+xVLfBrzbSsc71VEm9+duk9
         /Hk3hWmmZeIu6aUCHXcmvK4XEP+ehlbC1fo6CWurQzCacXGjmu1BGqsTUiZXzOllfvD8
         CgYBmgBYKu9JrS3HQF+wD650sVREDICO3sSG4U0/3Deume3UAxWOE5UmadFG1yxiYMOL
         ACPg==
X-Forwarded-Encrypted: i=1; AHgh+Rp7bXJKTaohygQEVD+IOAFwIfM9jK70MFW5EQ1Kfx5kcOM8Q1sJCzT1bWbdBXTCvY9OOQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza54Y6w2irNn+ssbbEmmUEiKBhJxjqG/SVjxDurt76n6tYfTfx
	/v3rBybLo7+0C16C2kNllc1nkmlnpHhpOsOaFF6kAa1fGdvc7zbxr5Bp
X-Gm-Gg: AR+sD10e1KQhLqr34ZZbmvtBhS9I5SVWGEtizi470V/gf6ZdYKy4rP/wNUlw5S0QBYC
	61XW+bf0Ps+gInlhmPJawFPSkKYFp1u2zg2J9ouDpHlatMf1HFPGuVH6nBMDhVyep5owctYECuR
	oMeBVcHetwo3r+L7qOlqVkiwjtk+dHByBV9nkRi3tgROozgl+/RnMJoxHSBfNlTJkAa9xLxNsUS
	3XN+sRwbSz1J3EwBLd/gMnClmcUQOUG+EvvI/GxQhUgy/Vd8Ic9tzZ8hpP/zoxn4sBAIk5IxFAu
	kCLJJUTh3KRr70r16eTwy5gY1aYPlFcRbxkQYhS+DgDzcqPnJ/RT57Z5CSwhhHXxMwOXnKb0Gft
	NkkrgOZVEORFi1nJi5VI5PzbsqMVbjhZt9YEn1tLSyQn2CZLdeU+j4D/S3ZnXTdOcsO1RBDntHC
	ynBGcfEiWh18YWXLd/5eI87UimhCi1WdsKkrfjI7cpaPXKcSsb7uTG5uc=
X-Received: by 2002:a17:90a:da8d:b0:38d:f94d:4c6e with SMTP id 98e67ed59e1d1-3933b8cb3d4mr12420030a91.17.1786778373914;
        Sat, 15 Aug 2026 00:19:33 -0700 (PDT)
Received: from omen-arch ([211.58.239.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ebc08871sm5400446a91.16.2026.08.15.00.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 00:19:33 -0700 (PDT)
From: Junseo Lim <zirajs7@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH bpf] bpf: fix UAF of trampoline progs before image release
Date: Sat, 15 Aug 2026 16:19:27 +0900
Message-ID: <20260815071927.147049-1-zirajs7@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch_prepare_bpf_trampoline() embeds program pointers in the generated
image and passes them to __bpf_prog_enter_recur(). After
bpf_trampoline_update() replaces the image, bpf_tramp_image_put() can keep
the old image executable past a normal RCU grace period.

A detached non-sleepable prog can therefore be freed before a preempted
task reaches rcu_read_lock_dont_migrate() in __bpf_prog_enter_recur(),
leading to a use-after-free.

Keep image-local prog refs and drop them from bpf_tramp_image_free().

Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")
Reported-by: Sechang Lim <rhkrqnwk98@gmail.com>
Signed-off-by: Junseo Lim <zirajs7@gmail.com>
---
This issue was found by a custom fuzzer developed by
Sechang Lim <rhkrqnwk98@gmail.com>.

This issue was reproduced on bpf/master commit a13307e97d5c.
Below is the KASAN report:

    ==================================================================
    BUG: KASAN: vmalloc-out-of-bounds in __bpf_prog_enter_recur+0x3a5/0x3f0
    Read of size 8 at addr ffffc90000081040 by task candidate/114
    
    CPU: 0 UID: 0 PID: 114 Comm: candidate Not tainted 7.2.0-rc6-00341-ga13307e97d5c #120 PREEMPT(full)
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.17.0-2-2 04/01/2014
    Call Trace:
     <TASK>
     dump_stack_lvl+0xb0/0x110
     print_report+0x14b/0x4a4
     ? preempt_schedule_notrace_thunk+0x16/0x30
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? preempt_schedule_notrace_thunk+0x16/0x30
     kasan_report+0x108/0x130
     ? __bpf_prog_enter_recur+0x3a5/0x3f0
     ? __bpf_prog_enter_recur+0x3a5/0x3f0
     __bpf_prog_enter_recur+0x3a5/0x3f0
     bpf_trampoline_6442508591+0x32/0xa7
     __x64_sys_futex+0x9/0x410
     do_syscall_64+0xae/0x5e0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? srso_alias_return_thunk+0x5/0xfbef5
     entry_SYSCALL_64_after_hwframe+0x76/0x7e
    RIP: 0033:0x429f4d
    Code: d5 48 8d 3c 0a eb 91 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
    RSP: 002b:00007f2332067128 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
    RAX: ffffffffffffffda RBX: 00007f2332067ce4 RCX: 0000000000429f4d
    RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
    RBP: 00007f23320672b0 R08: 0000000000000000 R09: 0000000000000000
    R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000021
    R13: 00007ffd9ad0b660 R14: 0000000000000010 R15: 00007ffd9ad0b757
     </TASK>
    
    The buggy address belongs to a vmalloc virtual mapping
    Memory state around the buggy address:
     ffffc90000080f00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
     ffffc90000080f80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
    >ffffc90000081000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                                               ^
     ffffc90000081080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
     ffffc90000081100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
    ==================================================================

 include/linux/bpf.h     |  5 +++++
 kernel/bpf/trampoline.c | 20 ++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7719f6528445..bacb6bc2e27b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1376,6 +1376,11 @@ struct bpf_tramp_image {
 		struct rcu_head rcu;
 		struct work_struct work;
 	};
+#ifdef CONFIG_PREEMPTION
+	/* Programs called from this image must outlive deferred image freeing. */
+	struct bpf_prog *progs[BPF_MAX_TRAMP_LINKS];
+	int nr_progs;
+#endif
 };
 
 struct bpf_trampoline {
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 1a721fc4bef5..ff6b331c965b 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -531,6 +531,13 @@ bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bool *ip_a
 
 static void bpf_tramp_image_free(struct bpf_tramp_image *im)
 {
+#ifdef CONFIG_PREEMPTION
+	int i;
+
+	for (i = 0; i < im->nr_progs; i++)
+		bpf_prog_put(im->progs[i]);
+#endif
+
 	bpf_image_ksym_del(&im->ksym);
 	arch_free_bpf_trampoline(im->image, im->size);
 	bpf_jit_uncharge_modmem(im->size);
@@ -678,6 +685,9 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	u32 orig_flags = tr->flags;
 	bool ip_arg = false;
 	int err, total, size;
+#ifdef CONFIG_PREEMPTION
+	int i, kind;
+#endif
 
 	tnodes = bpf_trampoline_get_progs(tr, &total, &ip_arg);
 	if (IS_ERR(tnodes))
@@ -740,6 +750,16 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		goto out;
 	}
 
+#ifdef CONFIG_PREEMPTION
+	for (kind = 0; kind < BPF_TRAMP_MAX; kind++)
+		for (i = 0; i < tnodes[kind].nr_nodes; i++) {
+			struct bpf_prog *prog = tnodes[kind].nodes[i]->link->prog;
+
+			bpf_prog_inc(prog);
+			im->progs[im->nr_progs++] = prog;
+		}
+#endif
+
 	err = arch_prepare_bpf_trampoline(im, im->image, im->image + size,
 					  &tr->func.model, tr->flags, tnodes,
 					  tr->func.addr);
-- 
2.55.0

