Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431B6331203
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761290; cv=none; b=k/17lGiqT5Vih7nGq61a0R5oT/SWiE18UVB+E3fBepkgVcP1qq49lYdwozl14JBpAbkkm31P+3VMuo8jGdU/TN5OZuGGp/TUHEfwWm6ZgSzQjB03YAD5ZvquUiDJgti2xIu7fvRt3Sd3OCf1gb1fFTYBt+mdFIPOI9C8P+oD1es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761290; c=relaxed/simple;
	bh=7h4TJVSevEbkfttESb+Gzb+0ZICqEmMukoYBnMI759s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t7DH/kRDw1A5DQajF+bTuGoIohGM0WnT30MIlvZS73WdCJXbuMijsCkinRJEZCQYPtlkp2tV2tseffx2zXL+Y/619YEaDktxj3UfSte1jEVVh7hUKzdWGLd/b2bfSid6TFKjMRBTJgyd2cWpYaEn8Xo0AuChsJDnvJCPOS0U4WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vSSEUriZ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vSSEUriZ"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f7bec24fdso2559931b3a.2
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 01:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776761288; x=1777366088; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sqvVkMZcMT8TtCxVSBBP8sBjus436WDPs40NDH+tyT8=;
        b=vSSEUriZDTGHtq+PNOSCfqW/OoFxAwapPpvAU4XnzNPrBuScRGnFpoXOmnCENf05vM
         Q7iI4RceKOuscyYG00KSCjZIjZrICnOzgi917/DtQAkzeiZj55VoU0TGfCLzv7eK7U15
         085OidfsqEBeYBUwQ8zn/UBAFt8q1rP5Qt6EJMOa+oFfF1b6MqazGOgJi/QlmzouTrqB
         5ac+Fu71VnJ2qe2IZ1TLR/Ho/Mr3uiHCADSmCjDJGZfdtiAlxIf0Nfr4vmWyRu1z0E7N
         JKsk+44zFamB50htmGgRBIEunJW0CSxWSlmOXOf/LwmS8Occwm0N7cUikKX420xgMXgm
         OGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776761288; x=1777366088;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sqvVkMZcMT8TtCxVSBBP8sBjus436WDPs40NDH+tyT8=;
        b=CDUdbRLx1eUb/m5VwEd/M/VhdUHr3nZQBQMWcDE0GM0vYl8Y8usEK1MK1iPd6+j0TD
         //SYvjX0yhY3LklxV8oAslfdWNu42zAm2Axjs2ktKZFvLH3AetyDMbfv15FQOGJv82ut
         Uw76MQ6ogTanUZ7yBJsxkCbrF87Tjt1KRnFty/iS1ff57t1dXkYkooT2ZfzaALF+c+Tg
         ru85kIMIHa6nOuJ0xTSWnViMDzbXrrviwOPMuPP2N1cp7f3KG4jTBKUy/hLFM6TTMq3u
         syJDZ0hnIL5gyR7aWRcE7QPW+JuLpSUgVIyXoPxbsWmBFH9fyMUn1v3u+ceM0WtDnIXO
         tR7A==
X-Forwarded-Encrypted: i=1; AFNElJ+ytkNE6225wR1sEXkW0lhzOFN9zCIRuz5igfuw5YfU8JyayjjOosAaSIMwkOAH51qbcBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdjxJT7Vr6wtgEbKHQ0FSaZmSrh0C25kx2bucBAsCO94MCt0zO
	iDfm8a/oYiepFCbzS9101ANsIhjywAZXDFN8JQAvUCu4nf2z2hwxEXGEYxYbOU82DR1DftmOZOw
	a59wzDw==
X-Received: from pfkm5.prod.google.com ([2002:a05:6a00:805:b0:82f:7ce1:182])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:27a8:b0:81a:b602:daf6
 with SMTP id d2e1a72fcca58-82f8c9213a4mr16343290b3a.48.1776761288284; Tue, 21
 Apr 2026 01:48:08 -0700 (PDT)
Date: Tue, 21 Apr 2026 08:47:31 +0000
In-Reply-To: <567d3206-74a5-44e5-99c6-779c425f399e@std.uestc.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <567d3206-74a5-44e5-99c6-779c425f399e@std.uestc.edu.cn>
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260421084806.1785541-1-kuniyu@google.com>
Subject: Uninitialized Stack Variable / NULL Pointer Dereference in
 __sys_socket_create via BPF LSM hooks
From: Kuniyuki Iwashima <kuniyu@google.com>
To: 2022090917019@std.uestc.edu.cn
Cc: M202472210@hust.edu.cn, bpf@vger.kernel.org, daniel@iogearbox.net, 
	dddddd@hust.edu.cn, dzm91@hust.edu.cn, edumazet@google.com, 
	hust-os-kernel-patches@googlegroups.com, jiayuan.chen@linux.dev, 
	kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"

From: Quan Sun <2022090917019@std.uestc.edu.cn>
Date: Tue, 21 Apr 2026 14:32:35 +0800
> Our fuzzing found an Uninitialized Stack Variable vulnerability in the 
> Linux Socket Subsystem. The issue is triggered when a 
> `BPF_PROG_TYPE_LSM` attached to the `bpf_lsm_socket_create` cgroup hook 
> uses the `bpf_set_retval()` helper to return a value greater than 0 
> (e.g., `1`). This bypasses the actual `socket_create` execution but 
> returns a success status back to `__sys_socket_create`, which then 
> accesses the uninitialized stack variable `sock` leading to a NULL 
> pointer dereference or potential privilege escalation.
> 
> Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> 
> ## Root Cause
> 
> This vulnerability is caused by treating a manipulated return value from 
> an LSM hook as complete success in `__sys_socket_create` without 
> ensuring that the underlying object has been fully initialized.
> 
> 1. `__sys_socket_create()` in `net/socket.c` reserves a pointer variable 
> `struct socket *sock;` on the kernel stack without zero-initializing it.
> 2. It calls `sock_create(family, type, protocol, &sock);` to allocate 
> and initialize the socket object.
> 3. `sock_create` proceeds to allocate the socket internally and invokes 
> the `security_socket_create` LSM hook (which triggers 
> `bpf_lsm_socket_create`).
> 4. If a BPF program is attached to the cgroup LSM hook for 
> `bpf_lsm_socket_create`, it can call `bpf_set_retval(1)` and return `1`.
> 5. Because the BPF hook completes without an error code (< 0), 
> `sock_create` interprets this bypass as success and promptly returns `1` 
> (or a positive bypass value) back to `__sys_socket_create()`. However, 
> the critical variable `sock` is never populated.
> 6. The caller `__sys_socket_create()` checks if `sock_create()`'s return 
> value is `< 0`. Since `1` is not less than `0`, it assumes the `sock` 
> pointer is valid.
> 7. Subsequent socket operations inside `__sys_socket_create()`, such as 
> `sock_map_fd(sock, ...)`, attempt to dereference the uninitialized 
> `sock` stack pointer.
> 
> #### Execution Flow Visualization
> 
> ```text
> Vulnerability Execution Flow
> |
> |--- 1. `__sys_socket_create(...)`
> |    |\
> |    | `-- struct socket *sock; (Uninitialized pointer on stack)
> |    |
> |--- 2. `sock_create(...)` -> `security_socket_create(...)`
> |    |\
> |    | `-- BPF LSM CGROUP hook for `bpf_lsm_socket_create` triggered.
> |    |     |
> |    |     `-- bpf_set_retval(1); return 1;
> |    |
> |--- 3. Context switches back to `sock_create`
> |    |\
> |    | `-- LSM hook returns `1`. `sock_create` skips allocation and 
> returns `1`.
> |    |
> |--- 4. Context switches back to `__sys_socket_create`
> |    |\
> |    | `-- Check return value (1 < 0 is False). Treated as SUCCESS.
> |    |     |
> |    |     `-- `sock_map_fd(sock, ...)`
> |    |         |
> |    |         `-- Dereferences `sock` leading to KERNEL PANIC or Hijack.
> ```
> 
> ## Reproduction Steps
> 
> 1. Load a `BPF_PROG_TYPE_LSM` BPF program that:
>     - Sets the target BTF ID to `bpf_lsm_socket_create`.
>     - Calls the `bpf_set_retval(1)` helper inside the hook.
> 2. Attach the loaded program to a chosen cgroup directory using 
> `BPF_LSM_CGROUP`.
> 3. Add the current process to the targeted cgroup.
> 4. Trigger the creation of a socket by invoking the `socket(AF_INET, 
> SOCK_STREAM, 0)` system call from within the cgroup.
> 5. The `sock_create` function skips allocation, returns 1, and 
> `__sys_socket_create` dereferences the uninitialized stack pointer.

Thanks for the report.

Maybe we could fix like below.
I guess all (most?) places suppose LSM to return 0 or
a negative value, and the btf_id_set_contains() check
would be unnecessary ?

---8<---
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index c5c925f00202..c4b9e9d4de92 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -87,6 +87,13 @@ BTF_ID(func, bpf_lsm_socket_socketpair)
 #endif
 BTF_SET_END(bpf_lsm_unlocked_sockopt_hooks)
 
+BTF_SET_START(bpf_lsm_negative_set_retval_hooks)
+#ifdef CONFIG_SECURITY_NETWORK
+BTF_ID(func, bpf_lsm_socket_create)
+#endif
+BTF_SET_END(bpf_lsm_negative_set_retval_hooks)
+
+
 #ifdef CONFIG_CGROUP_BPF
 void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
 			     bpf_func_t *bpf_func)
@@ -221,12 +228,37 @@ static const struct bpf_func_proto bpf_get_attach_cookie_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 };
 
+BPF_CALL_1(bpf_lsm_set_retval, int, retval)
+{
+	struct bpf_cg_run_ctx *ctx;
+
+	if (retval > 0)
+		return -EINVAL;
+
+	ctx = container_of(current->bpf_ctx, struct bpf_cg_run_ctx, run_ctx);
+	ctx->retval = retval;
+
+	return 0;
+}
+
+const struct bpf_func_proto bpf_lsm_set_retval_proto = {
+	.func		= bpf_lsm_set_retval,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_ANYTHING,
+};
+
 static const struct bpf_func_proto *
 bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
 	const struct bpf_func_proto *func_proto;
 
 	if (prog->expected_attach_type == BPF_LSM_CGROUP) {
+		if (func_id == BPF_FUNC_set_retval &&
+		    btf_id_set_contains(&bpf_lsm_negative_set_retval_hooks,
+					prog->aux->attach_btf_id))
+			return &bpf_lsm_set_retval_proto;
+
 		func_proto = cgroup_common_func_proto(func_id, prog);
 		if (func_proto)
 			return func_proto;
---8<---
