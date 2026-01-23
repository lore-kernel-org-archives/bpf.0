Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2316A23EA9B;
	Fri, 23 Jan 2026 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769157808; cv=none; b=rFszxdy19COU2hs3EqGlZMA6E/YBYqbAphDBonjKVinK613dGFV2cKVNRVlj+PxLocQaM7ehMRY8VnuGu/fZjDaqQ4A2PPioeFUHpQZsyc1zVfEl2dTJmHf5RrPxjJXtzn35rTgn2FnpWe6cL48qaqWG4EzYh+9BQ123ANK7k8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769157808; c=relaxed/simple;
	bh=XjzQZVgzxHEt/RB3A4QvYZvTIxwZr08iWRwU45q0vBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1hhYYRzSrS+I8fyyL3lUm4dMLawVpv7SghWOKrZPs0TwehPN6X90Bx48vfSgT4lZ2dIk8TNeLwF3pYfx+oNPUSjqskJlY6xH72OQGjPAxJtjX5J9qh5JSLJ5y93+ArKXN7Vd5QBfvZr1LT8Ssz4hQlrPWxUvtTnqHPMxng7CwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=HO3RQg1U; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HO3RQg1U"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ilViWn1D94q7wCMp+qMecvangQ8GTuiUkN2Q+A96uww=; b=HO3RQg1UjH530sINyI7MOKqPHV
	grpGmDuDSgxZRERYiZhsqknODvzlaLXfrdNLPAGwRt6Att9gAtXhOl57PUn4jKs8pcErgzJ0IBPd6
	Pq/uF4i7tknyEPvtCFin01udrOwrBOCRlMHYtonIUp2C5Np2n/06fByDT7t87UCsIDl2re8aSwT/2
	WEmklKlAFiiLo6LmtZAQ1a/Xpm13ZswCM4A+1em1MANCmS/sRc4WUJ1FG3ju1BiFtiQDDT1wePvJ/
	/VeGKByEpsTPoH2S/jzPmr9kiwiIq22+NTWej+mZmajAnlRuq6jgJxoImgNvyjHTariQJpWIVlcQp
	LD5u9aSg==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vjCl6-008nSD-Eu; Fri, 23 Jan 2026 09:43:13 +0100
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
Subject: [PATCH bpf-next v1 1/2] bpf: Introduce execution context detection kfuncs
Date: Fri, 23 Jan 2026 17:42:47 +0900
Message-ID: <20260123084248.259278-2-changwoo@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123084248.259278-1-changwoo@igalia.com>
References: <20260123084248.259278-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce bpf_in_nmi(), bpf_in_hardirq(), bpf_in_serving_softirq(), and
bpf_in_task() kfuncs to allow BPF programs to query the current execution
context.

While BPF programs can sometimes infer context based on the attach point,
certain programs (such as those in sched_ext) may be called from multiple
contexts. These kfuncs provide a reliable way for logic to branch based on
whether the CPU is currently handling an interrupt or executing in task
context.

For example, this is particularly useful for sched_ext schedulers that need
to differentiate between task-to-task wake-ups and interrupt-to-task
wake-ups.

As the names imply, these helpers wrap the kernel's internal in_nmi(),
in_hardirq(), in_serving_softirq(), and in_task() macros.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/bpf/helpers.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 637677815365..cb36bc7a80c6 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4365,6 +4365,46 @@ __bpf_kfunc int bpf_dynptr_file_discard(struct bpf_dynptr *dynptr)
 	return 0;
 }
 
+/**
+ * bpf_in_nmi - Test if the current execution context is in NMI context.
+ *
+ * Return: true if we are in NMI context, false otherwise.
+ */
+__bpf_kfunc bool bpf_in_nmi(void)
+{
+	return in_nmi();
+}
+
+/**
+ * bpf_in_hardirq - Test if the current execution context is in hard IRQ context.
+ *
+ * Return: true if we are in hard IRQ context, false otherwise.
+ */
+__bpf_kfunc bool bpf_in_hardirq(void)
+{
+	return in_hardirq();
+}
+
+/**
+ * bpf_in_serving_softirq - Test if the current execution context is in softirq context.
+ *
+ * Return: true if we are in softirq context, false otherwise.
+ */
+__bpf_kfunc bool bpf_in_serving_softirq(void)
+{
+	return in_serving_softirq();
+}
+
+/**
+ * bpf_in_task - Test if the current execution context is in task context.
+ *
+ * Return: true if we are in task context, false otherwise.
+ */
+__bpf_kfunc bool bpf_in_task(void)
+{
+	return in_task();
+}
+
 __bpf_kfunc_end_defs();
 
 static void bpf_task_work_cancel_scheduled(struct irq_work *irq_work)
@@ -4546,6 +4586,10 @@ BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_dynptr_from_file)
 BTF_ID_FLAGS(func, bpf_dynptr_file_discard)
+BTF_ID_FLAGS(func, bpf_in_nmi)
+BTF_ID_FLAGS(func, bpf_in_hardirq)
+BTF_ID_FLAGS(func, bpf_in_serving_softirq)
+BTF_ID_FLAGS(func, bpf_in_task)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.52.0

