Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com [74.125.231.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3762E2F7EF1
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786034457; cv=none; b=B2Bndb6bvUZXpUe5W1IIwpreeT/Q74cq1HrHsYF8Ibz4PsNc1LCr7mGBDUTBs9v7gSn9A5tzUzWHAWpSXSxFa7pCBr2AKq/Dd04lNQXI4uFFJ9B+wwyafTfx863Tuftgs+92e32Pe0NsSbdWHqFoCzuRKXCjj3VsIPfCuzPXcLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786034457; c=relaxed/simple;
	bh=fVUdm/HbJKrVhtPJPLwXu35mrGgllKeSfR/jt7Em2tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIUeLm+rEoNr3iZIXmewdnfBnms6dnETN35925BoPFaiWUaHDLtXldKjrj1wJoWlSOaOtj6UIJbpt14djzLU4oF6qopw/1x5GYlh1UYZdeyHpHj0tcKpYqDRKbqGbTqbyMdCFFWwgu6r3hwSMWs9hF/77UIzKcpF4jJjCIWi3KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ooZEVlQb; arc=none smtp.client-ip=74.125.231.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ooZEVlQb"
Received: by mail-oi2-f10.google.com with SMTP id 46e09a7af769-7e9f9a3167aso754752a34.1
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 09:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786034455; x=1786639255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vtQaWOWHpz8AaE1yp8UqZGPgOYumV/u98AeybF5C/Tg=;
        b=ooZEVlQb/+dwJZj956TCyduIu0sAnDDqJERNLLjDAZnUPevIrVGpBM8pGFAKkFjqks
         FrYwfIo6XQDytqc7lVg3AhWGtmjvjm7KtpoC5QW+H/8NR1V9lUWbxd2C8+Cz1vT/0Ndy
         c5oV8JCiTqi5fzHLitN3/N3cLt7a0Iu1kgS58oXnYh6p+eLz/nFaDChBWxuu/s13RLrJ
         sY2PTnqEhyXmgu4QWuf9qhmp3X6/vAvZv0sWMduuRdNzeEt2B4Hz64anHNd9tJMhgJno
         g1QgM8kcE8FF7JWspaKUFdMj2d/1xOxQFHd7DYkcSUBaZhe2YLFmnzLolmDn01qklYDE
         VFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786034455; x=1786639255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vtQaWOWHpz8AaE1yp8UqZGPgOYumV/u98AeybF5C/Tg=;
        b=LvKySrrv8H/xAJ59XqlKwWPkIcTCak5qlsJapJpp2G4kJ7urDmbWv7/hc6fsYqDwa4
         JFddQ6e2Nm/Gs2dfKjQ+aC/N+YXQjv5o0u2aoaH6S+avmeGlwDkB2vXGyf6NXdx+hL0O
         r8S24MczfdQG5wfoAiYwjFEDR/eOgCuIsTzXnBfPa1u7Ul7BFKnvify6rVtESmUmD9fg
         HwkQTervOFfY8ZwcmGVWvMtuDeC+ziquDdi3Z4vekRkVT947C4o+IiePYtsEVaWS2G9O
         l5pWMntZCtFe0B61BQ3Y+zy7GVxTZda4WVk79KZyf4QBc1McNJWhPk8kOSCun2ydTrd1
         CXuA==
X-Gm-Message-State: AOJu0YzMjIyxkGQrEAx5o2pPfQyEaOoEfcualuSfmbMcz7Rr0FAzmh/U
	pQa3zbL7YCAQgM/Je5/ck7YZLLSPrjKQYatSgZLWMpSMOinvRPtj2XpuEhdlexvgeqc=
X-Gm-Gg: AR+sD12m4j38wBo0jHsOJgC2nWn/NR48IG4qK0KwUklwjGd8EU4mcKcmLxIHkN+0bQL
	FHhcal9bSIDRnohMZNTuc9R99rkQbfXp3TQRHVu+z0hmHpm1T0YC80gTR7gugW+RbPFA0b9wxFl
	K4pA2d3Tt4RbboWe+SG9CMIi/KspgZq0IcjmBc9ceiPfk5WGpDasQtvYkI/jHoyp44gUsBBxghV
	2mD69twGrNMSWes5B+Jxhyv56Kk7Jk9uwA/k6EsJlZzc+37vG5m35jpnGSS1xlJIXV6w3FHTlzm
	/mhgTm1gnkFnry0OYJEPSy+tgqPITvmiEj5UJxAzDVTLNRnuaES8YNmIOLG+Vp9ZuL57I31kROV
	ciphAhhY9aslsm8dQb1pQNnz/HC4rzLnaVdj/Iel27ks1nMh8fa8RotaNE4Job4oNb+TZD0hvs1
	ra/uJ0MisN2nUhhg4kn2l8tvDbaHMxC9cxBhKq13k/TlwINB4pggJWYco7jiuQZ9Dl4WvlpMBK1
	XK930G4YPdIhtJXnmRJRgimPq6musJMKnbgn0s9P4hdrIjM5MAk6JlS1GR+CBkyiXlFvPw=
X-Received: by 2002:a05:6830:6605:b0:7e9:d634:77b8 with SMTP id 46e09a7af769-7f34dcf165fmr1829562a34.2.1786034454877;
        Thu, 06 Aug 2026 09:40:54 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4b::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f1df346a8bsm4718579a34.11.2026.08.06.09.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 09:40:53 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Test sleepable context distinctions
Date: Thu,  6 Aug 2026 18:40:49 +0200
Message-ID: <20260806164049.3158887-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806164049.3158887-1-memxor@gmail.com>
References: <20260806164049.3158887-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5705; h=from:subject; bh=fVUdm/HbJKrVhtPJPLwXu35mrGgllKeSfR/jt7Em2tg=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIatkx0+319LT7jZy696T3jhtWt+lKUkFXbOeR3JVtB9zCw4S WMzbUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIl82cfI8C3gdce/Wcvzm9mPRmp/sD 1kuHNj5fRpPDI1ouZzeGvnb2P4HzldK3B7XUa7hefeZzPfh/3tatOaODXgTQRbT45u0/Y5vAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Exercise verifier decisions which depend on the complete sleepable context
rather than only the current state's in_sleepable bit.

Verify that preemption-disabled and IRQ-disabled regions provide implicit RCU
protection to KF_RCU_PROTECTED css iterators.  Also verify that iterator
pointers become untrusted after the final preemption enable or IRQ restore,
and that css_task iterators are rejected in explicit RCU, preemption-disabled,
and IRQ-disabled regions of sleepable programs.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/iters_task_failure.c  | 153 ++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters_task_failure.c b/tools/testing/selftests/bpf/progs/iters_task_failure.c
index fe3663dedbe1..0a2ea8b6adda 100644
--- a/tools/testing/selftests/bpf/progs/iters_task_failure.c
+++ b/tools/testing/selftests/bpf/progs/iters_task_failure.c
@@ -13,6 +13,8 @@ struct cgroup *bpf_cgroup_from_id(u64 cgid) __ksym;
 void bpf_cgroup_release(struct cgroup *p) __ksym;
 void bpf_rcu_read_lock(void) __ksym;
 void bpf_rcu_read_unlock(void) __ksym;
+void bpf_local_irq_save(unsigned long *flags) __weak __ksym;
+void bpf_local_irq_restore(unsigned long *flags) __weak __ksym;
 
 SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
 __failure __msg("kernel func bpf_iter_task_new requires RCU critical section protection")
@@ -84,6 +86,157 @@ int BPF_PROG(iter_css_lock_and_unlock)
 	return 0;
 }
 
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__success
+int BPF_PROG(iter_css_preempt)
+{
+	u64 cg_id = bpf_get_current_cgroup_id();
+	struct cgroup *cgrp = bpf_cgroup_from_id(cg_id);
+	struct cgroup_subsys_state *root_css, *pos;
+
+	if (!cgrp)
+		return 0;
+	root_css = &cgrp->self;
+
+	bpf_preempt_disable();
+	bpf_for_each(css, pos, root_css, BPF_CGROUP_ITER_DESCENDANTS_POST) {}
+	bpf_preempt_enable();
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__success
+int BPF_PROG(iter_css_irq)
+{
+	u64 cg_id = bpf_get_current_cgroup_id();
+	struct cgroup *cgrp = bpf_cgroup_from_id(cg_id);
+	struct cgroup_subsys_state *root_css, *pos;
+	unsigned long flags;
+
+	if (!cgrp)
+		return 0;
+	root_css = &cgrp->self;
+
+	bpf_local_irq_save(&flags);
+	bpf_for_each(css, pos, root_css, BPF_CGROUP_ITER_DESCENDANTS_POST) {}
+	bpf_local_irq_restore(&flags);
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("R2 must be referenced or trusted")
+int BPF_PROG(iter_css_preempt_escape)
+{
+	u64 cg_id = bpf_get_current_cgroup_id();
+	struct cgroup *cgrp = bpf_cgroup_from_id(cg_id);
+	struct cgroup_subsys_state *root_css, *pos;
+	struct task_struct *task;
+
+	if (!cgrp)
+		return 0;
+	root_css = &cgrp->self;
+
+	bpf_preempt_disable();
+	bpf_for_each(css, pos, root_css, BPF_CGROUP_ITER_DESCENDANTS_POST) {
+		break;
+	}
+	bpf_preempt_enable();
+	if (pos) {
+		bpf_for_each(css_task, task, pos, CSS_TASK_ITER_PROCS) {}
+	}
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("R2 must be referenced or trusted")
+int BPF_PROG(iter_css_irq_escape)
+{
+	u64 cg_id = bpf_get_current_cgroup_id();
+	struct cgroup *cgrp = bpf_cgroup_from_id(cg_id);
+	struct cgroup_subsys_state *root_css, *pos;
+	struct task_struct *task;
+	unsigned long flags;
+
+	if (!cgrp)
+		return 0;
+	root_css = &cgrp->self;
+
+	bpf_local_irq_save(&flags);
+	bpf_for_each(css, pos, root_css, BPF_CGROUP_ITER_DESCENDANTS_POST) {
+		break;
+	}
+	bpf_local_irq_restore(&flags);
+	if (pos) {
+		bpf_for_each(css_task, task, pos, CSS_TASK_ITER_PROCS) {}
+	}
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("css_task_iter is only allowed in bpf_lsm, bpf_iter and sleepable progs")
+int BPF_PROG(iter_css_task_rcu)
+{
+	u64 cg_id = bpf_get_current_cgroup_id();
+	struct cgroup *cgrp = bpf_cgroup_from_id(cg_id);
+	struct cgroup_subsys_state *css;
+	struct task_struct *task;
+
+	if (!cgrp)
+		return 0;
+	css = &cgrp->self;
+
+	bpf_rcu_read_lock();
+	bpf_for_each(css_task, task, css, CSS_TASK_ITER_PROCS) {}
+	bpf_rcu_read_unlock();
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("css_task_iter is only allowed in bpf_lsm, bpf_iter and sleepable progs")
+int BPF_PROG(iter_css_task_preempt)
+{
+	u64 cg_id = bpf_get_current_cgroup_id();
+	struct cgroup *cgrp = bpf_cgroup_from_id(cg_id);
+	struct cgroup_subsys_state *css;
+	struct task_struct *task;
+
+	if (!cgrp)
+		return 0;
+	css = &cgrp->self;
+
+	bpf_preempt_disable();
+	bpf_for_each(css_task, task, css, CSS_TASK_ITER_PROCS) {}
+	bpf_preempt_enable();
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("css_task_iter is only allowed in bpf_lsm, bpf_iter and sleepable progs")
+int BPF_PROG(iter_css_task_irq)
+{
+	u64 cg_id = bpf_get_current_cgroup_id();
+	struct cgroup *cgrp = bpf_cgroup_from_id(cg_id);
+	struct cgroup_subsys_state *css;
+	struct task_struct *task;
+	unsigned long flags;
+
+	if (!cgrp)
+		return 0;
+	css = &cgrp->self;
+
+	bpf_local_irq_save(&flags);
+	bpf_for_each(css_task, task, css, CSS_TASK_ITER_PROCS) {}
+	bpf_local_irq_restore(&flags);
+	bpf_cgroup_release(cgrp);
+	return 0;
+}
+
 SEC("?fentry/" SYS_PREFIX "sys_getpgid")
 __failure __msg("css_task_iter is only allowed in bpf_lsm, bpf_iter and sleepable progs")
 int BPF_PROG(iter_css_task_for_each)
-- 
2.53.0-Meta

