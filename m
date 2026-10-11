Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3C63242D4
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791737330; cv=none; b=qYuDFzo06bH2sNJ0dyctuviKKDRxv4rrdAOb9g3bPNJyzH8vMGg0fpWIE3tRDXu/Lorea2tGATqhVMGMDqmMdpxG31fAu8j0UJrfkkqViTA67Py35ZM87MgJnevYHr6KGV+jKOMt9ZfKgJ1M0+k3GUqZwH/yPxPOcyk4zTteZOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791737330; c=relaxed/simple;
	bh=qKOflWo6bGul0YeRr52Vj3tnG01XHDQz8NMnBgm0NsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nz1mwKaOaWywJeusG0rgMD0x/ieHpURkgIlFwJRlghLzqH0spNqEb01u7mJsxuqts25D9e0FVS5kEznrA23OiUdSQ23tVUbPLrSsX115zXmJIuyjU15lMxI6vfKifQ+zZHQfOKPhVaDa0PVg805K3BFQreGAx8LynzwhoEo1sw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMfuwgk1; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMfuwgk1"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2dd9ec41bc4so6260615ad.2
        for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 09:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791737322; x=1792342122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o1ZKitZJAuXF56oh9s5pwGuPKOuwLZ/iyg13fiOcScE=;
        b=bMfuwgk1IOLQgEAyvnC3+Mm/7PGpv/fhIor+9WiTrrM3aiiLo3DGDeuiE9Tm0HzC94
         Ss8lLWKkfgPBZ+Q6dzFp3FmWJUdi3MIjHtlVILFmWAvBLSHworTXUgA9KK7OTkF7hcVl
         ge9Y5yvr3s1C4lIIPhSI0XqAWE+ArUQ60Ga7bFhnYbByXuU93Rj0T9xQNtLuBycQhk66
         gDrTqDHG0jmwvcfpRPa/B/Nayp/hbL0O9POB535LTwvR2kdlONnbQSIsdTSjFWiJzf8A
         vh9TfYxNvwE3Yye9zYrc+YnoLgTCbDTHL9r8knR1/tAsoKH2C2S5khI7mJc7mBKW4zTg
         TUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791737322; x=1792342122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o1ZKitZJAuXF56oh9s5pwGuPKOuwLZ/iyg13fiOcScE=;
        b=DvMeGJGZoCWX/xBRQGWaIjCRuKy3sVpSiSomwvgR7SCQJerG3oh7haixLMc4jOliBT
         lr/4H+QTh7hWCrkKQ4X8zbZuF16LlBGq7lRuFPDKXu+7Y4na9I4JVEGN53j7tJV3bpKT
         qYnPkUFk/nSY5f+mCEy4QfQQRUtp2NLb+qleU31kFRNxZVuKHw9N13wIQcOOc9dI6qNZ
         Fhy1Jvt+eJtTe6LZmLS2ySxCKSf3Xr+xOY0GP2g6onPpzsf8eTPo7dpB/FxVyIohFPvl
         oWg45IF6vCP1H7ixaLQrWJhe9p+WWUFmHvfIcTCoANTa5e/5Ud8m+/w0/TxcrMgS7A45
         kWMQ==
X-Gm-Message-State: AFq9FYIj+bH1XARCZHXlBef7AuZ7nYrapaqtTqlyYb/2fVSoiNaBsbtN
	wypU1aXYJrND1WM9r+WPT0IV29Z96AL0IfBqsyK7vj8qUaW6lkHWydAXquJaDN19WhA=
X-Gm-Gg: AYBFou05gXEFR3CJ2W6U9rtuNmOATxahjpxgVHesCHUL7FEwHxoUGiKCx/ih0ecTsLh
	i5ISybyjehisEsdckwQH3Qa/1GWoG9uK6TgcMpeZiIdqd3CXmJRB6g4YT7P3joCVFvZ5a75sQAx
	4AZFB1O5j8rKPi/OnbSyUiTrPOD+RxRiDvaHdj6Oa5tAzm3coBccvwIb5V3+DMN3pWDK6kHwYVz
	kQotbygJJ82VE073UePEMlBJ9F0QeHz4suqGdK/ZRluXk/aJlgTBRopmtU6nq8ZoSTbl8ssbS77
	9HlFiOplIRT4ib+4LQOJizWlVRt4zV9f4vmkByJDhwZPDc8LgugXZcyBt/Wwdzfb4+ClIq6+Udm
	jnXLHKtc4tHE0xDje7nZlhF7ioclA3tCtcd7xtcYzfzmhyQMs4Me0wzZTjJdzJLh2cLtBv07oEK
	rtCllYnSap47BueYQ/RYc7ec152PWEnG2z9Bi3Pnc4AHMeVspEAQDGo+E2GXXeS+DEUacE+F+gH
	GZAGI9V2RX5CaJaMqXetmp2W3VryQCZws1T6+6gGWaYDjKVDm1qXGpr4PVHMNKUcUT+QN3g6P+A
	uHIU6Ts0YeMH3x3nDilRReKtCX3eJwcEoiGz0CGNIbo=
X-Received: by 2002:a17:903:3550:b0:2e5:cb9d:3207 with SMTP id d9443c01a7336-2e842805bcdmr62059765ad.1.1791737321844;
        Sun, 11 Oct 2026 09:48:41 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8421ae999sm33580835ad.31.2026.10.11.09.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 09:48:41 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 1/2] bpf: Reject BTF ids with the same address in tracing_multi link
Date: Sun, 11 Oct 2026 16:48:35 +0000
Message-ID: <20261011164836.2233874-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261011164836.2233874-1-alexei.starovoitov@gmail.com>
References: <20261011164836.2233874-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

check_dup_ids() rejects equal BTF ids, but different ids can resolve to
the same address. Aliases:

  ffffffff8161b6b0 t __do_sys_munlockall
  ffffffff8161b6b0 T __ia32_sys_munlockall
  ffffffff8161b6b0 T __x64_sys_munlockall

or several BTF_KIND_FUNC with the same name that vmlinux BTF has when
CONFIG_DEBUG_INFO_BTF_INLINE is set.

Each id gets its own trampoline and register_fentry_multi() adds them to
data->reg with the same ip. update_ftrace_direct_add() checks that new
entries are not in direct_functions, but doesn't compare them with each
other, so the attach succeeds. At detach update_ftrace_direct_del() sees
that 'direct' of one of the entries doesn't match and returns -EINVAL:

  WARNING: kernel/bpf/trampoline.c:1845 at bpf_trampoline_multi_detach+0x24c/0x280
  Call Trace:
   bpf_link_free+0x51/0x110
   bpf_link_release+0x18/0x20
   __fput+0x103/0x2d0
   __x64_sys_close+0x3d/0x80

The images are freed anyway, while ftrace still calls them:

  Oops: int3: 0000 [#1] SMP NOPTI
  RIP: 0010:0xffffffffc042b201
  Call Trace:
   ? __audit_syscall_exit+0x9/0x100
   ? do_syscall_64+0x5ab/0x5e0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  Kernel panic - not syncing: Fatal exception in interrupt

Return -EINVAL from register_fentry_multi() when ip is already in
data->reg. When such ids are attached via different links the second
attach already fails with -EINVAL in update_ftrace_direct_add().

Move the declaration of ftrace_lookup_ip() to include/linux/ftrace.h.

The lookup adds 60 msec to the attach of 64480 functions in
tracing_multi_bench_attach: 1.34 -> 1.40 sec.

Fixes: aef4dfa790b2 ("bpf: Add bpf_trampoline_multi_attach/detach functions")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/ftrace.h  | 1 +
 kernel/bpf/trampoline.c | 8 ++++++++
 kernel/trace/trace.h    | 3 ---
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index bd76a16a63af..b041d9142d2b 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -416,6 +416,7 @@ void free_ftrace_hash(struct ftrace_hash *hash);
 struct ftrace_func_entry *add_ftrace_hash_entry_direct(struct ftrace_hash *hash,
 						       unsigned long ip, unsigned long direct);
 void add_ftrace_hash_entry(struct ftrace_hash *hash, struct ftrace_func_entry *entry);
+struct ftrace_func_entry *ftrace_lookup_ip(struct ftrace_hash *hash, unsigned long ip);
 void ftrace_hash_remove(struct ftrace_hash *hash);
 
 /* The hash used to know what functions callbacks trace */
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index fc94d6062109..24edb59238f3 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -1638,6 +1638,14 @@ static int register_fentry_multi(struct bpf_trampoline *tr, struct bpf_tramp_ima
 	unsigned long ip = ftrace_location(tr->ip);
 	struct bpf_tracing_multi_data *data = ptr;
 
+	/*
+	 * Different BTF ids get different trampolines, but they can still
+	 * resolve to the same address (aliases, functions of the same name).
+	 * There's only one call site to attach to.
+	 */
+	if (ftrace_lookup_ip(data->reg, ip))
+		return -EINVAL;
+
 	if (bpf_trampoline_use_jmp(tr->flags))
 		addr = ftrace_jmp_set(addr);
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 3749485a7d85..9044f03fe2d9 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1006,9 +1006,6 @@ struct ftrace_hash {
 	struct rcu_head		rcu;
 };
 
-struct ftrace_func_entry *
-ftrace_lookup_ip(struct ftrace_hash *hash, unsigned long ip);
-
 static __always_inline bool ftrace_hash_empty(struct ftrace_hash *hash)
 {
 	return !hash || !(hash->count || (hash->flags & FTRACE_HASH_FL_MOD));
-- 
2.55.0

