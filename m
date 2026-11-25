Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577536;
	b=P3oBPuSmN5XdXzfmnvuHMHfEpZAE1zQ8fOWOsH+x8elL86R5cDjpm7KOaXEaYZTkhgFm
	 jwDOsq0weqlX1ukBr6rf+cpEIXirTgKXMlOhciDswM/AoSg8kMl7HD2m9xb0QhXDYFghC
	 5sjBnjmy2k00RgjpP/PVC7F0PAOkU9NfoIrTz0eE4kEluKApozHPVDm4zOqm3h8cQIYhS
	 5ko4lqTbJYWdPqcCy49tywYthtM+c+KqucRSKceUSuLkcZD9TkL7fb9K985x6hrYT1yH9
	 3WQWHwLwOmkCa0cveyEkc7OyEERVJBpLuI4t2it8BSyNKFp7wyyr3juwlAUZSJDt+ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577536;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mNDhX+PjlFJOF0i60mR1jUbNgonHFASLNfEl+lG2Gac=;
	b=MAXMS5FCelXcprCL60GQT/B4/Gxw5a3ABr7zcR3MG3HKa7tR682ev9XjQ/Y2P+9fVcmH
	 1UTt0GEY62OzSBPwgN/VDmUQoAcfOyHt6MQLjAXoQ6zKBsq+8zQM3rpQwpBye9Tnaohxw
	 JMgmmOSl81ifDgK5/jn0anfqhXtjdEmBnmcFq/bVuWVsmxmsEgKYuZrYfclI9xwfnk88f
	 tHo5LBE2/Qsb1SIOy3q1eA4KcfV8uYS+h91+nk0VJvz3ev3I6xurCykh5c2opMfF/vdZK
	 R91VcFl6FKsqKMGZX7NWW1QIauPUD9hSX3qKWqgqRoIY25+Y2qlKcFSWpbM3JPAWcAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R6eRAkYH;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FED606A321
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59FED606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R6eRAkYH
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8b3577deeb0so2384208b3a.3
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577536; x=1796182336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mNDhX+PjlFJOF0i60mR1jUbNgonHFASLNfEl+lG2Gac=;
        b=R6eRAkYHsDWbcXY0w4QcLFtj3c8ww14CKHU8Nf5bkrfrxTjZyN0/1veNhSeqg4bwGu
         s5APui5/kHh6wroKmo1sT+qt9yvc0ya/hMzA6Ykvz5au1ZbArvfEulascUeJQtDSnUVi
         K4pAnFWbfGfOoXDCXTIRA3mMI5rHVGPXZYAHFFSkwsw7Ncc+FZ6XKO2Sxv2L3dT0Q57I
         NSjr7+t3mAiF4LFvBT1EhsakYHaQzHPA/NXuRBLRB4mF7HglfBdpzG+9FWvA178qb5yn
         RgWeE/RVzsmO7UlHpTNf9IxzpOfGUD6Q3lssbT8Eyejbd8FUZwh0bSdn5r077BRttXOq
         6h+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577536; x=1796182336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mNDhX+PjlFJOF0i60mR1jUbNgonHFASLNfEl+lG2Gac=;
        b=kdH1Z7kbavYBegW2ghwjFRgvw85KssEkvlW7KBSq2mqDvfYRJj2EmBIWuWlmUkzAY/
         dW/eCfuVUYZxbnh3eY2oNhuEdXQ2s/tJGhUo/ZYIM+t8cMewqvvICMVv8Uzu9oGu/h+b
         RE4nl6kEDpS3tQ7asR2FT47NhCYhDkcFm6gWVX4bnMBBD7rig/oIqOjZjNs36P2/MvZ5
         YEwGEdkSzvmPsUiJIaQ+f483fIVInZuvz11TXf1lzB6FlTfJixszykECPGzvp7f4Ro7C
         4geap3d8VDJh9RpE0izbSyy01RWivdFvEy+FApV6ysTyqimaWxaYxIV/3aCBd3t9PyBl
         ijBQ==
X-Gm-Message-State: APuU4Z83i94Pu1r/QyXygEkyxHzbZXwl+DeR2uOXLGASGVdmErwZIl7m
	X1uYi3rN3uoUutoewIOghzu3NUaXrx5mrymRLCAYWnmK/qc3RhFAeridJXE1finI
X-Gm-Gg: AZFdTZe9u9erCO246iZ3YpICFosYNQnW1O1pF8UFLwH8Ea0sWh9R7x7TpDTZvP/WItn
	KX6DRs2KjsgF4ImOldznl6qPp9MW70/Tz4okC/I/n5xziQDRQ0t9K6M2EkWXJyqvTCjI8WtMKMi
	cy8pHwavr53ZSI71r7vXIq8f9s4TVr4mlelIWMmZFNIl1rOO8U4c7zOrIiUJlnRa8d0kF6WEyCN
	ZCIfaoTZ8VD9aYIiQckNUdJHY++sSXWVB2OMgiaMeWQxgdn8ZeavyW3djBTB9ubZYk1+BHMgx5K
	n9WAqaSLZbQaGDRjpgZ0stVp9phkc9b9FjVjk5piJSwKmSwWuavPJ63DOTqMOLxfGcF7I8SW/cR
	gvlTncKPjh8cCVAEG4gTtcynw7RA5dmOFd+RbO402q8mU63GNsn6/qjj7sDjS1MhSwx3Xt8Rcjg
	hGaCKfXoDFzoC4rHGCs8/IiT1k5qlrPbOpfF864UoayA/51JHohSeLLC+VBdVvUnbC+jRk3XhkK
	Udu1QQq21mdtqtRP6JYXkuY6CDGrolCPqSGW8NhbVqxcTmqLMcbHr+GXQJdcuw09gmRplMBa89d
	jG4+A9CBWH0eLi/MSS09nNavUCYEI4liZ9d7p329uWjpMG+yfPbaGN1NLzP0r8gP8tpdDPWS1bk
	QIohLGFkPJsMtWFMU8z69Eo3QpblQkrPrJAqqet3EiDAB4pn0RF1l+88YM9GBsamb1SRA05UQtw
	==
X-Received: by 2002:a05:6a00:2888:b0:89f:db59:193c with SMTP id d2e1a72fcca58-8c87bac50abmr13138625b3a.9.1795577535429;
        Tue, 24 Nov 2026 19:32:15 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e45eccsm8128332b3a.31.2026.11.24.19.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:32:15 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 26/47] bpf: Require CAP_PERFMON for kfuncs that leak pointers or touch tasks
Date: Wed, 25 Nov 2026 03:29:17 +0000
Message-ID: <20261125032938.670542-27-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

Syscall, tc, XDP and cgroup programs load without CAP_PERFMON and can
call kfuncs that give more than CAP_BPF stands for:

- kfuncs of arena take any pointer for the address and can leak it.
  The check for an arena misses one from a map of maps.
- void * of a kfunc is a number for the verifier.
- bpf_send_signal_task() and the kfuncs of task work act on any task.

Ask for CAP_PERFMON, as the helpers of the same kind do. struct_ops and
tracing programs have it.

Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
Fixes: 88d1d4a7eebe ("bpf: Allow kfuncs return 'void *'")
Fixes: 6280cf718db0 ("bpf: Implement bpf_send_signal_task() kfunc")
Fixes: 38aa7003e369 ("bpf: task work scheduling kfuncs")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 Documentation/bpf/kfuncs.rst | 3 ++-
 kernel/bpf/arena.c           | 7 ++++---
 kernel/bpf/helpers.c         | 6 +++---
 kernel/bpf/verifier.c        | 6 ++++++
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 901c37504217..31389dd5c9f6 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -537,7 +537,8 @@ addresses to the BPF program, for example by reading through a pointer that the
 verifier does not check. Calling such a kfunc requires CAP_PERFMON, or
 CAP_SYS_ADMIN, in the same way that the equivalent BPF helpers are gated in
 bpf_base_func_proto(). A program loaded with CAP_BPF alone is rejected at load
-time.
+time. The flag is implied when the program gets a returned ``void *`` as a
+number.
 
 2.6 Registering the kfuncs
 --------------------------
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 56bd02b783f9..70a49b1200a9 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -1187,9 +1187,10 @@ __bpf_kfunc int bpf_arena_reserve_pages(void *p__map, void *ptr__ign, u32 page_c
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(arena_kfuncs)
-BTF_ID_FLAGS(func, bpf_arena_alloc_pages, KF_ARENA_RET | KF_ARENA_ARG2 | KF_SPINLOCK_SAFE)
-BTF_ID_FLAGS(func, bpf_arena_free_pages, KF_ARENA_ARG2 | KF_SPINLOCK_SAFE)
-BTF_ID_FLAGS(func, bpf_arena_reserve_pages, KF_ARENA_ARG2 | KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_arena_alloc_pages,
+	     KF_ARENA_RET | KF_ARENA_ARG2 | KF_SPINLOCK_SAFE | KF_PERFMON)
+BTF_ID_FLAGS(func, bpf_arena_free_pages, KF_ARENA_ARG2 | KF_SPINLOCK_SAFE | KF_PERFMON)
+BTF_ID_FLAGS(func, bpf_arena_reserve_pages, KF_ARENA_ARG2 | KF_SPINLOCK_SAFE | KF_PERFMON)
 BTF_KFUNCS_END(arena_kfuncs)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 70330a7088db..61ddc45b0330 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -5156,7 +5156,7 @@ BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_from_vpid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_throw)
 #ifdef CONFIG_BPF_EVENTS
-BTF_ID_FLAGS(func, bpf_send_signal_task)
+BTF_ID_FLAGS(func, bpf_send_signal_task, KF_PERFMON)
 #endif
 #ifdef CONFIG_KEYS
 BTF_ID_FLAGS(func, bpf_lookup_user_key, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
@@ -5272,8 +5272,8 @@ BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
 #endif
 BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_IMPLICIT_ARGS | KF_SPINLOCK_SAFE | KF_PERFMON)
 BTF_ID_FLAGS(func, bpf_stream_print_stack, KF_IMPLICIT_ARGS | KF_SPINLOCK_SAFE | KF_PERFMON)
-BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_IMPLICIT_ARGS)
-BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_IMPLICIT_ARGS | KF_PERFMON)
+BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_IMPLICIT_ARGS | KF_PERFMON)
 BTF_ID_FLAGS(func, bpf_call_rcu, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_call_rcu_tasks_trace, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_dynptr_from_file)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d29d0725ec01..410804e80392 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15851,6 +15851,12 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 				return err;
 		} else if (btf_type_is_void(ptr_type)) {
 			/* kfunc returning 'void *' is equivalent to returning scalar */
+			if (!env->allow_ptr_leaks) {
+				verbose(env,
+					"%s is allowed only to CAP_PERFMON and CAP_SYS_ADMIN\n",
+					func_name);
+				return -EPERM;
+			}
 			mark_reg_unknown(env, regs, BPF_REG_0);
 		} else if (!__btf_type_is_struct(ptr_type)) {
 			if (!meta.ret_mem.found) {
-- 
2.55.0

