Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615D037AA9E
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 11:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756402; cv=none; b=sqaXqplqu/hOGUQB5dGuYT+NsyYqF1/mYJl4SyQVNEeXmaGxLpqmXCCpYuJr8WOpPkeI7uomrA5yCykZzFue0EqDJAdT7UI4OQ4vkMsbJU+K4KQkNsCJ+xCkmCCnlqDHWvdrAhVo889OO+BOjFLEkcWtqPjDyO+/OB2l9C2r1P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756402; c=relaxed/simple;
	bh=teD57BmaN/6FLsS0871dabp8VMTB8OpEMm2R1Ln41/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sX9V9FCh+ceDRceKfVSpTRKi57amhak49I6ePzLr3u4rgzSvWUocUDSXZR8rNI+8N8UDG/gPYmLVC196wnMoJo8K21sAqNKzEjJLM7D+wdeeltc5XO1ufuKB0qOzU8xEyx70eM3a09/r3lnl7LbFYUTcjR+/VeIYADEF3v5Ijv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jujkhxA3; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jujkhxA3"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso1814673a12.2
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 04:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785756401; x=1786361201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yd9zapz3XgaX48J0GHwdbeC00T0Ul3oy7R9EcO1SBMc=;
        b=jujkhxA3ePTHOvTyZTkDhtJ4BJ4h8PD96yjeVfgXiz5vx/t0B8nxCwY7ntuxRp94/u
         j/6zkPHn3IFxtQoyveDbKFHUkKhVHwHB1j9oyvl2X5B5DaQrZFaPzPCCHx8OByFJnxev
         t8WaR2wToLDP5ePgXxYI26kdiur5baHpqOUpzgme5j5NYHkWuh9CCgzLc2vCHMm+yUMj
         A38KRtyA808lvO2FmDJtEsCqpbnK7LFkQqHLPiZ9QAjwOPgj+HGr8zpNKWCLYgJwuj2E
         64VCc1uEOwG0gX9FG91e4rNYH1PXAr0pJJoijHHQqkfuaoynDA5a09ue061kE5YdMkGS
         xs5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785756401; x=1786361201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yd9zapz3XgaX48J0GHwdbeC00T0Ul3oy7R9EcO1SBMc=;
        b=JALa1hhnqERgva8iTDW2IW8v1KC3M1CFCXX8U5eVyIiSgfb4og1KGFvuvM9a7rtALj
         IS7nFwMZil80ZpeoUFu+dXBR/dGOxPN/KR3L7S0dXia+c5yvnddnOw1OB0Z8Bf2S0zbN
         xp8yF/MV++sZK6IFCxw9ARm7Ekpwomzih/Qi6UbtukBtsBsNkDWq574GI1URO3CWc5rQ
         6A4TD1AqpfBBh2qa/WHuThNZBB3VJnVTh6oAPFe5LNCxETj/mg9hRe86nhuIaF9NvDOw
         eWSArysD0vQ7bwWzC4xsyIdw4x9fkTvGtiTDv3zDaY8glaCW+tQ0sLrOQzD2QCCAB/qN
         oKCw==
X-Gm-Message-State: AOJu0YxIAby4FQfJMB63VYMaGnE8ODu7BhKWDu1O6KKUc+GolQbfwNeW
	QUVoUraUxbKTMHyb5Gh4jeCABebijH9MKN69SLpDcwaq9SylyL/YptNdoHg6yg==
X-Gm-Gg: AR+sD10g90phYbmqaB5jFM0kbaOKJHjNkjIKFz/4bW56vS1mJ7lDOLtlFgI55Zhalqi
	NVct2F6naQLmEZJa6Ms5rpC/080H/FX+51I+g6RTco+gD+BerW56+q9i5XWFVToHfEWsJK23zX+
	3PJf4DSukl25iNjnJF/rRP/zA46UfCz5DRmkhVKHgxF4A2DA8c0Rl1s5XqqF/2Uc3EcKp7+MWD0
	6eHSSz2lkSJpW9EMDQcy5+nbrjNao1Y+ostTMEYOd0c73WK+74QyBDPKpVodOAqCcvVGdVvQxRa
	eoPtTnw8OsXnwGpTifZPRnpw/sT2OR7XI3kghc0Y+f+Wmwp1a2tKVQ5fUgMee0PLWNk4k0tBLi4
	ePMsCFbPVjWEjfBSbZf1P4WNTHxydaPdMPCkIAlUmpXtPb4/eZ/k1tIVEyvgivTsKcKQc5HoEpC
	xpRBh5SCWK8UOrg/6BeoevcTytqggv5cDoYs2oc5aiqfuXS2xDeed42hUe/nYSGlr2Kyp/1VVW1
	4x9ZyBjXJAYuFiO
X-Received: by 2002:a05:6a00:3a11:b0:84e:89a:b8ec with SMTP id d2e1a72fcca58-84ee4813a74mr9061209b3a.11.1785756400724;
        Mon, 03 Aug 2026 04:26:40 -0700 (PDT)
Received: from patterson.cs.ubc.ca (patterson.cs.ubc.ca. [198.162.52.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2a8223sm3494930b3a.28.2026.08.03.04.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 04:26:40 -0700 (PDT)
From: Ning Ding <dingning04@gmail.com>
To: bpf@vger.kernel.org
Cc: Ning Ding <dingning04@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Test RCU pointer invalidation after spin unlock
Date: Mon,  3 Aug 2026 04:26:09 -0700
Message-ID: <20260803112615.3362122-3-dingning04@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803112615.3362122-1-dingning04@gmail.com>
References: <20260803112615.3362122-1-dingning04@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier previously accepted a task kptr after the final spin unlock
ended its RCU protection in a sleepable program. The pointer could then be
used after the task was freed.

Add a negative test for that case. Add positive controls showing that the
pointer remains valid in a non-sleepable program and while an explicit RCU
read-side section is still active.

Assisted-by: Codex:gpt-5.6-sol
Assisted-by: ChatGPT:GPT-5.6-Pro
Signed-off-by: Ning Ding <dingning04@gmail.com>
---
 .../selftests/bpf/prog_tests/task_kfunc.c     |  2 +
 .../selftests/bpf/progs/task_kfunc_common.h   | 12 +++++
 .../selftests/bpf/progs/task_kfunc_failure.c  | 24 ++++++++++
 .../selftests/bpf/progs/task_kfunc_success.c  | 48 +++++++++++++++++++
 4 files changed, 86 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
index e6e95c1416e65..fbd7855712c1a 100644
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
index e9c4fea7a4bba..052c9d0e3e2a8 100644
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
index 5c99b1e6532bf..c0e7216b34193 100644
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
index d63a79ee33dce..2bab7634c9dfd 100644
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

