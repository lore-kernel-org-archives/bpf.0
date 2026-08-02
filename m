Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C1833B6D6
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 23:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785712443; cv=none; b=gQYOK5fD+NBrPCHq0EANFUu28FzSPidzvk7FwgMH2/w56jzo09PrPHAYUx++f8VT2gv0iR/Zd8htnutvLcNjycvf0HUtGkpYIwD4iep9R2mBuQfAGslgjhcAgETnGVVVJJFyHdzdUNlqmSwt43SbY5bHFKq6niGxkdNsAhBTVRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785712443; c=relaxed/simple;
	bh=k1fkw7WNhvI6GXASm5e75WiACpnhQ9kNrN2Sioy4TK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AJVpKBilJCSmiZclbKOmstBX2Jv9OhJRymjlR6XAIvvX9SRoiEXeiE6nNExnj6Yk3CTHFMp3GppqqrGCukp4TW0YVmvuIY8E6/F9DrjAX7DI0yrHCfvR4Z6Rex2pvsTHF6RaXDLnWdjff4ziFVdpuqVansMWe+5cHSw3O1roMuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qulABJSz; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qulABJSz"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ce7d2adef4so45919905ad.3
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 16:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785712440; x=1786317240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pU4v6hRTUge0KrXkRRWZsd+tc6Y5PUpwswApZzkRyGg=;
        b=qulABJSzgzKFfh5fmuaasYELrpznotCNM96Bs85ZqE3KClAwAUCpaSj5Zp+bWvY+PF
         WG/TXebrIpN5/L/TA4qdiw4Ztn8y/6X/8hk4Gg27zQRgx9ha2RlObrpa6vTrecJCQ8YG
         NKtX/UWfhNVyBD9CtgaHH1RthYnJTcA/6sX34y79UmEloh1afU439U090YihQPtBg9am
         e/HPJt+dfOzt1wl9hwipUaabpZqpZhliYi4oNCQWCNLJDVVjEMfH4IgO37D15aI2rsV+
         55v0kdhqKcj/9bIzyIg2I75ZN3bR2pdeLq/cScrprKzgCsD+GU696WMPUypB0gK60Alk
         07rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785712440; x=1786317240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pU4v6hRTUge0KrXkRRWZsd+tc6Y5PUpwswApZzkRyGg=;
        b=ceVZ5oaSOGxj4pMKATEDlb/eqkC4nx0Ai0iZEzEtx8qYQ0cQfDpESL8Z4Idfu1eP7e
         2igvx+U/aUBm0djrKiIB7wwYEX4VO+1hkNRMRR0+ABy2MWRxCg9xhsjk9MLoLx6WP7iN
         snqbvdKMG1B68zWLoyMMIwm1eEw6kJ+QcPChIhQPKK4308ljBkX+tYsBi55aGxGEZ4/R
         BgVM8nrTmU1sgdx4Hy6/Sk/gjOd2h9I4qXfVTb6NZvQoUxYg925p5XbGXTyffsY3nG5m
         /KsXXA0N0GNrV1dPGstvoc0XS37G6msf68C1DLDMjNIUmzAKQTlLbNdkrJ5q0RdG6itI
         9blQ==
X-Gm-Message-State: AOJu0Yz37S0Byy/HUflZoynA43beJaW3HqtB/efP+e80WDeNxT7enbRt
	+1ShgdBBsqpnGCNpRVZdZlpcYP6Qb9csjXzjrmIf5Muj5Q7sVFeZhtyZdEBVWKB8
X-Gm-Gg: AR+sD13ajt507bhLf5gjM8p1gj4nZFhdywELDIKLHUm+DKr/73HAFXzfrfrnu6Fvo3t
	+QcC4cnpW/AEtLIyvUx7OZUpQsvxiWdXle2IMqWRpMGNZeEBmq2C4JVBtybOh6xeVMHeuldYsnO
	XYepLqFWuOOhwEShkhVOwST/kFkZFgssmcHN6zcQXzVD6cd8l1qwM0ven95qGEdMtO6zYrTIIZp
	F7bTBpqZk0iQz9PJhDOuIzHXXMX2rcz4eqrcIa2/UEsjIlWRDK4J31bg5IbFDucBKjv/w0wnaXQ
	9NR498oPTiqqab0uzgXtQe8/B7JZdTsk8v2GFGwTa5SesW8A8xh+rWoLXSpxBllhQHDqiii+8SH
	faJASafcJavExJ+uoGTY+SsXgjoB6AthkTByXWBHWnyotM363EnC85NRvFJt6T9Gj9q60VtZ+PH
	XtFGRwt6PvtWAwH0JD7137FYntoz9YccDc8TU2j0HzmjY2zMlM1woM13KokHaARZHINrKDCV3go
	4sZg71aj66gKicw
X-Received: by 2002:a17:903:2b0b:b0:2bf:dd0:c8b1 with SMTP id d9443c01a7336-2d052035401mr83974545ad.0.1785712439995;
        Sun, 02 Aug 2026 16:13:59 -0700 (PDT)
Received: from patterson.cs.ubc.ca (patterson.cs.ubc.ca. [198.162.52.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae67d0esm29110265ad.30.2026.08.02.16.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 16:13:59 -0700 (PDT)
From: Ning Ding <dingning04@gmail.com>
To: bpf@vger.kernel.org
Cc: Ning Ding <dingning04@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf] bpf: Invalidate RCU pointers after final spin unlock
Date: Sun,  2 Aug 2026 16:12:37 -0700
Message-ID: <20260802231248.2781334-1-dingning04@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A verifier-tracked spin lock provides implicit RCU protection while held.
Consequently, a kptr loaded from a lock-protected map value is marked
MEM_RCU.

process_spin_lock() invalidates non-owning references on unlock, but leaves
RCU-protected references intact. This is correct while another RCU context
remains active. However, for a sleepable program, releasing its final lock
can end the only RCU-protected context. The verifier then allows a MEM_RCU
pointer to be used after its protection has ended.

Invalidate RCU-protected references when a successful unlock changes
in_rcu_cs() from true to false. Non-sleepable programs remain in their
invocation-wide implicit RCU context, and an explicit RCU read-side section
continues to protect pointers across the unlock.

A task kptr retained across the final unlock can race with removal of the
map kptr and bpf_task_release(). This was confirmed to result in a
task_struct use-after-free in __bpf_get_task_stack().

Add a negative sleepable regression and positive non-sleepable and explicit
RCU controls.

Fixes: 5861d1e8dbc4 ("bpf: Allow bpf_spin_{lock,unlock} in sleepable progs")
Assisted-by: Codex:gpt-5.6-sol
Assisted-by: ChatGPT:GPT-5.6-Pro
Signed-off-by: Ning Ding <dingning04@gmail.com>
---
 kernel/bpf/verifier.c                         |  5 ++
 .../selftests/bpf/prog_tests/task_kfunc.c     |  2 +
 .../selftests/bpf/progs/task_kfunc_common.h   | 12 +++++
 .../selftests/bpf/progs/task_kfunc_failure.c  | 24 ++++++++++
 .../selftests/bpf/progs/task_kfunc_success.c  | 48 +++++++++++++++++++
 5 files changed, 91 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fdc5fbb1f78c..aea9fdbbd33a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -204,6 +204,7 @@ static int acquire_reference(struct bpf_verifier_env *env, int insn_idx, int par
 static int release_reference_nomark(struct bpf_verifier_state *state, int id);
 static int release_reference(struct bpf_verifier_env *env, int id);
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
+static void invalidate_rcu_protected_refs(struct bpf_verifier_env *env);
 static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
 static bool is_tracing_prog_type(enum bpf_prog_type type);
 static int ref_set_non_owning(struct bpf_verifier_env *env,
@@ -7051,6 +7052,7 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
 			return err;
 		}
 	} else {
+		bool was_in_rcu_cs;
 		void *ptr;
 		int type;
 
@@ -7078,10 +7080,13 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
 			verbose(env, "%s_unlock cannot be out of order\n", lock_str);
 			return -EINVAL;
 		}
+		was_in_rcu_cs = in_rcu_cs(env);
 		if (release_lock_state(cur, type, reg->id, ptr)) {
 			verbose(env, "%s_unlock of different lock\n", lock_str);
 			return -EINVAL;
 		}
+		if (was_in_rcu_cs && !in_rcu_cs(env))
+			invalidate_rcu_protected_refs(env);
 
 		invalidate_non_owning_refs(env);
 	}
diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
index e6e95c1416e6..fbd7855712c1 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
@@ -176,6 +176,8 @@ static const char * const success_tests[] = {
 	"test_task_from_pid_current",
 	"test_task_from_pid_invalid",
 	"task_kfunc_acquire_trusted_walked",
+	"task_kfunc_acquire_after_spin_unlock_non_sleepable",
+	"task_kfunc_acquire_after_spin_unlock_explicit_rcu",
 	"test_task_kfunc_flavor_relo",
 	"test_task_kfunc_flavor_relo_not_found",
 };
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_common.h b/tools/testing/selftests/bpf/progs/task_kfunc_common.h
index e9c4fea7a4bb..052c9d0e3e2a 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_common.h
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_common.h
@@ -20,6 +20,18 @@ struct {
 	__uint(max_entries, 1);
 } __tasks_kfunc_map SEC(".maps");
 
+struct task_kptr_lock_value {
+	struct bpf_spin_lock lock;
+	struct task_struct __kptr * task;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, int);
+	__type(value, struct task_kptr_lock_value);
+	__uint(max_entries, 1);
+} task_kptr_lock_map SEC(".maps");
+
 struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym;
 void bpf_task_release(struct task_struct *p) __ksym;
 struct task_struct *bpf_task_from_pid(s32 pid) __ksym;
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
index 8942b5478129..7a0c7ee95511 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
@@ -378,3 +378,27 @@ int BPF_PROG(task_kfunc_release_in_map, struct task_struct *task, u64 clone_flag
 
 	return 0;
 }
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("R1 must be a rcu pointer")
+int BPF_PROG(task_kfunc_acquire_after_final_spin_unlock)
+{
+	struct task_kptr_lock_value *v;
+	struct task_struct *task, *acquired;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&task_kptr_lock_map, &key);
+	if (!v)
+		return 0;
+
+	bpf_spin_lock(&v->lock);
+	task = v->task;
+	bpf_spin_unlock(&v->lock);
+	if (!task)
+		return 0;
+
+	acquired = bpf_task_acquire(task);
+	if (acquired)
+		bpf_task_release(acquired);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_success.c b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
index d63a79ee33dc..2bab7634c9df 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_success.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
@@ -6,6 +6,7 @@
 #include <bpf/bpf_helpers.h>
 
 #include "../bpf_experimental.h"
+#include "bpf_misc.h"
 #include "task_kfunc_common.h"
 
 char _license[] SEC("license") = "GPL";
@@ -366,6 +367,53 @@ int BPF_PROG(task_kfunc_acquire_trusted_walked, struct task_struct *task, u64 cl
 	return 0;
 }
 
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
+int BPF_PROG(task_kfunc_acquire_after_spin_unlock_non_sleepable)
+{
+	struct task_kptr_lock_value *v;
+	struct task_struct *task, *acquired;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&task_kptr_lock_map, &key);
+	if (!v)
+		return 0;
+
+	bpf_spin_lock(&v->lock);
+	task = v->task;
+	bpf_spin_unlock(&v->lock);
+	if (!task)
+		return 0;
+
+	acquired = bpf_task_acquire(task);
+	if (acquired)
+		bpf_task_release(acquired);
+	return 0;
+}
+
+SEC("fentry.s/" SYS_PREFIX "sys_getpgid")
+int BPF_PROG(task_kfunc_acquire_after_spin_unlock_explicit_rcu)
+{
+	struct task_kptr_lock_value *v;
+	struct task_struct *task, *acquired;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&task_kptr_lock_map, &key);
+	if (!v)
+		return 0;
+
+	bpf_rcu_read_lock();
+	bpf_spin_lock(&v->lock);
+	task = v->task;
+	bpf_spin_unlock(&v->lock);
+	if (task) {
+		acquired = bpf_task_acquire(task);
+		if (acquired)
+			bpf_task_release(acquired);
+	}
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
 SEC("syscall")
 int test_task_from_vpid_current(const void *ctx)
 {
-- 
2.43.0

