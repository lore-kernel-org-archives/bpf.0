Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED8C345CC8;
	Thu, 29 Jan 2026 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769694899; cv=none; b=lVL0igskXbsdASy8bTNIw26TtY08paFkdVTWwnPsgsc5vBEHojwJHsWOVEIkV5oVSDHWOXdIfj0SZGiVE8V0oAApKkCO+CyCHLhGy7DIlu+RhUSo/lfOp3H/aVoMz9JmQDF796ZIXVrUeq6IIJuoSj4aNngVNOsRTq2XdmYwcbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769694899; c=relaxed/simple;
	bh=mco5asDOcBE71wVLzXfCHgo68w+MDccTXuXucWi9tb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AwECCXgmrmJmIRmyhH2NXyZw3Eu0N8FBWiG5OcPQ+FOhR8QcAfJelNw5fNA7g9mRDeOdWOuY1jb2DGb1dSGhonOCWnWLBydl5pB+aSZxa14AybKfNMUp2bU7HWVcvOm2F9gzTmnU45QPGT8YeTHREm6Jb8XaaSID4GUQJvtNRYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=GK3hndf1; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="GK3hndf1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rR7WtrprN0KIrdZl2S1HojGZveHJelvr9q7QYAhGiaI=; b=GK3hndf17fRZEk6nwWKf/0A2Sf
	tlRQgUMg2Lw/j23T3+45GgbI8SHJhXMi+RomUNT96efAG/wGh+fZjuAQnMAiNOZZEUJrw/lG5cD1e
	bwi3HOQbimM3ApTOQRZcDx7K9jSqHdXDsGU7879DNJ/ttzX8roYPcHINajZmMPTFHIfwKHZfgHtSB
	bdBBbrI7REBL0LbNiJdu6QXeyj9nev+Zv9c/Q3MIOG7JdrHS/Tf02AdJT7fRaE46nOqELqSe+G66H
	M6RcWjgdRwRdh0wwTuYVbybaFSyd8HLKlVTkjP6DjWeEjBt5KL0dyXc9N37QmwnULlEKa1It6hIOk
	cyHvIuNA==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vlSTg-00BJnY-GM; Thu, 29 Jan 2026 14:54:33 +0100
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
Subject: [PATCH] selftests/bpf: Make x86 preempt_count access compatible across v6.14+
Date: Thu, 29 Jan 2026 22:54:26 +0900
Message-ID: <20260129135426.93424-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent x86 kernels (v6.15+) export __preempt_count as a ksym, while older
kernels expose the preemption counter via pcpu_hot.preempt_count. The
existing selftest helper unconditionally dereferenced __preempt_count,
which breaks BPF program loading on older kernels.

Make the x86 preemption count lookup version-agnostic by:
- Marking __preempt_count and pcpu_hot as weak ksyms.
- Introducing a BTF-described pcpu_hot___local layout with
  preserve_access_index.
- Selecting the appropriate access path at runtime using ksym availability
  and bpf_core_field_exists().

This allows a single BPF binary to run correctly on both v6.14-and-older
and v6.15-and-newer kernels without relying on compile-time version checks.

Fixes: 4b69e31329b6 ("selftests/bpf: Introduce experimental bpf_in_interrupt()")
Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 tools/testing/selftests/bpf/bpf_experimental.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index a39576c8ba04..0194c0090e50 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -614,7 +614,13 @@ extern int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__str,
 
 extern bool CONFIG_PREEMPT_RT __kconfig __weak;
 #ifdef bpf_target_x86
-extern const int __preempt_count __ksym;
+extern const int __preempt_count __ksym __weak;
+
+struct pcpu_hot___local {
+	int preempt_count;
+} __attribute__((preserve_access_index));
+
+extern struct pcpu_hot___local pcpu_hot __ksym __weak;
 #endif
 
 struct task_struct___preempt_rt {
@@ -624,7 +630,13 @@ struct task_struct___preempt_rt {
 static inline int get_preempt_count(void)
 {
 #if defined(bpf_target_x86)
-	return *(int *) bpf_this_cpu_ptr(&__preempt_count);
+	/* v6.15 or later */
+	if (&__preempt_count)
+		return *(int *) bpf_this_cpu_ptr(&__preempt_count);
+	/* v6.14 or older */
+	if (bpf_core_field_exists(pcpu_hot.preempt_count))
+		return ((struct pcpu_hot___local *)
+			bpf_this_cpu_ptr(&pcpu_hot))->preempt_count;
 #elif defined(bpf_target_arm64)
 	return bpf_get_current_task_btf()->thread_info.preempt.count;
 #endif
-- 
2.52.0

