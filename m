Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE51319617;
	Sat, 24 Jan 2026 13:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769261260; cv=none; b=n91t57XW6BGeIl1JTqCtxQDczGguyu+UfDo5QtnxXEexPFWcUEOUGbQLZ4Jvfd9zuC6PYPKJ1znXhQ9irF6GEK2+KPlAaKr9QnRBU+fhCNoxbetARNtJAzVUesGjWWJlkvPA2WZQ4gDpZUJ3uL9JgsSQtCwIu8YYFaqIoSAJcF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769261260; c=relaxed/simple;
	bh=aph4bN+h6Du3wkXa2Ge6qFDIwoSnf9wzR/wJFGFjJDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ca3W+M6TCjU/H6lS4T+2jb6ub5w4PK0MmN/E8yELavTnGzkqjmk6wXMX/tR+aV34LhUfTckY1tdaHXhwmtogvKwxXdgsi85OcJWKNh6EQP103D1MX0+iIbvFR85Vtf4sX9U7Atbe1o+EuoqS6P7gk/3sIEd0+nVvOm6asfzmZeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=KOqKg/7Q; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KOqKg/7Q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=hYQKTmNL3usHkDODv+v2CqzvPFVZMn8b05MkXsnAs9M=; b=KOqKg/7QNaR/7oJjP02Urrb9l3
	kx1GIWcR4/+mVBZhUtYH4OafAOeGh+SiuqBhRpOp48Xbaf/Yunrf8vNr1Y6+DL6PdW6pBNcm825dY
	SuYAb8ieOOOGBUjk+KZQgCBxGLuyhCedt6vBobI9K/PQ8tYiDLuuw8adzkgLS/dHQ0SFaRb6xa/jF
	2KFt1FFcCaWtNcQkjVYCyHtEvCb/bg6yUhWkum8ZfDaGd/bJefkFSjyFCFDqkCEf86aRSZvkvSYeE
	qKa42nQSWLYEhThHAcRSrrlN/eq5TmhvEiTorZSrMdu2LmiAAuapzSaNAV0PAThFL49xjalWEp8vG
	kkePJquA==;
Received: from [175.114.83.198] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vjdfh-009OAw-58; Sat, 24 Jan 2026 14:27:26 +0100
From: Changwoo Min <changwoo@igalia.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	kernel-dev@igalia.com,
	bpf@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH bpf-next v2 1/2] selftests/bpf: Introduce execution context detection helpers
Date: Sat, 24 Jan 2026 22:27:05 +0900
Message-ID: <20260124132706.183681-2-changwoo@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124132706.183681-1-changwoo@igalia.com>
References: <20260124132706.183681-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce bpf_in_nmi(), bpf_in_hardirq(), bpf_in_serving_softirq(), and
bpf_in_task() inline helpers in bpf_experimental.h. These allow BPF
programs to query the current execution context with higher granularity
than the existing bpf_in_interrupt() helper.

While BPF programs can often infer their context from attachment points,
subsystems like sched_ext may call the same BPF logic from multiple
contexts (e.g., task-to-task wake-ups vs. interrupt-to-task wake-ups).
These helpers provide a reliable way for logic to branch based on
the current CPU execution state.

Implementing these as BPF-native inline helpers wrapping
get_preempt_count() allows the compiler and JIT to inline the logic. The
implementation accounts for differences in preempt_count layout between
standard and PREEMPT_RT kernels.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 .../testing/selftests/bpf/bpf_experimental.h  | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 68a49b1f77ae..30abdc08366f 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -610,6 +610,8 @@ extern int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__str,
 #define HARDIRQ_MASK	(__IRQ_MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
 #define NMI_MASK	(__IRQ_MASK(NMI_BITS)     << NMI_SHIFT)
 
+#define SOFTIRQ_OFFSET	(1UL << SOFTIRQ_SHIFT)
+
 extern bool CONFIG_PREEMPT_RT __kconfig __weak;
 #ifdef bpf_target_x86
 extern const int __preempt_count __ksym;
@@ -648,4 +650,40 @@ static inline int bpf_in_interrupt(void)
 	       (tsk->softirq_disable_cnt & SOFTIRQ_MASK);
 }
 
+static inline int bpf_in_nmi(void)
+{
+	return get_preempt_count() & NMI_MASK;
+}
+
+static inline int bpf_in_hardirq(void)
+{
+	return get_preempt_count() & HARDIRQ_MASK;
+}
+
+static inline int bpf_in_serving_softirq(void)
+{
+	struct task_struct___preempt_rt *tsk;
+	int pcnt;
+
+	pcnt = get_preempt_count();
+	if (!CONFIG_PREEMPT_RT)
+		return (pcnt & SOFTIRQ_MASK) & SOFTIRQ_OFFSET;
+
+	tsk = (void *) bpf_get_current_task_btf();
+	return (tsk->softirq_disable_cnt & SOFTIRQ_MASK) & SOFTIRQ_OFFSET;
+}
+
+static inline int bpf_in_task(void)
+{
+	struct task_struct___preempt_rt *tsk;
+	int pcnt;
+
+	pcnt = get_preempt_count();
+	if (!CONFIG_PREEMPT_RT)
+		return !(pcnt & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET));
+
+	tsk = (void *) bpf_get_current_task_btf();
+	return !((pcnt & (NMI_MASK | HARDIRQ_MASK)) |
+		 ((tsk->softirq_disable_cnt & SOFTIRQ_MASK) & SOFTIRQ_OFFSET));
+}
 #endif
-- 
2.52.0

