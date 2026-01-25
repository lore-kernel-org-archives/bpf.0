Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F84831691C;
	Sun, 25 Jan 2026 11:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769342123; cv=none; b=hl8Bh7aT4S46gVjlBbkec2gKg0NwNYUfJk401GcswO36mz4HLvA40yt2neYOA4V/XL87phWANu773/VF7+C8w1s9H1q9ur56XJHzxVW/vv6tOp1nivXK6bRGzrKKnzLRZ/eO9gvMxnffv76WizjKV0Q3YXr+OOB/tnjjPrKV+WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769342123; c=relaxed/simple;
	bh=LkP+Md5l2KkE6tCaMkXQ0ura8cZwnL5by6OEu6hZywA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QpDRadhATccRChd9GQCPv7skkIdjH3E2c8TeMun00K65Gb0d6ibFh9d5XOrmPXymXXrL/+ni5CJdAgrS0Sj7thMx0MKqy1LyuASAuUG31cxMvnH4VHXpkbVSF81LBaq1ehbXB8IvJY/2iMHKzhOnz8u5gU8h8lUDp5nVhPmQJSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ZNNZVVHp; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ZNNZVVHp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3upw99aAfp17wHre3fNEhYtjVVAjN3aHk/wLofA/wak=; b=ZNNZVVHpCdaF6kEPmNx141I8jz
	4tUQQe7n9EhGPhoTUy4T7ODVwQT/5ZJy6pdyNCJRPirGhhgkoWPA590xHEwLUIWtdGUoV2hz33Uax
	ytPbvmcAxYkvUQRnVrnMi/RvuJhnhAV+EE12YnGpcoof/efkoOu9zmPJgc5LnqeBZlW68JO/iK5aN
	GngNkps5OPADUd7/IdXkDdYhRlbsV+E4TQ72uVVDWjzfu/zF4mP5gcVmvE3nei/8dbjM4ckQDEvub
	WufAOEMIuYAAJT1XxHwmVf6u4DLYOlgETa9r5IndavGNJcsk460DAOe+DsYSxE0Z3S4S+vtInPP08
	kMMBd6Cw==;
Received: from [175.114.83.198] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vjyhp-009fre-AF; Sun, 25 Jan 2026 12:55:02 +0100
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
Subject: [PATCH bpf-next v3 1/2] selftests/bpf: Introduce execution context detection helpers
Date: Sun, 25 Jan 2026 20:54:12 +0900
Message-ID: <20260125115413.117502-2-changwoo@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260125115413.117502-1-changwoo@igalia.com>
References: <20260125115413.117502-1-changwoo@igalia.com>
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

Reviewed-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 .../testing/selftests/bpf/bpf_experimental.h  | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 68a49b1f77ae..a39576c8ba04 100644
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
@@ -648,4 +650,60 @@ static inline int bpf_in_interrupt(void)
 	       (tsk->softirq_disable_cnt & SOFTIRQ_MASK);
 }
 
+/* Description
+ *	Report whether it is in NMI context. Only works on the following archs:
+ *	* x86
+ *	* arm64
+ */
+static inline int bpf_in_nmi(void)
+{
+	return get_preempt_count() & NMI_MASK;
+}
+
+/* Description
+ *	Report whether it is in hard IRQ context. Only works on the following archs:
+ *	* x86
+ *	* arm64
+ */
+static inline int bpf_in_hardirq(void)
+{
+	return get_preempt_count() & HARDIRQ_MASK;
+}
+
+/* Description
+ *	Report whether it is in softirq context. Only works on the following archs:
+ *	* x86
+ *	* arm64
+ */
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
+/* Description
+ *	Report whether it is in task context. Only works on the following archs:
+ *	* x86
+ *	* arm64
+ */
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

