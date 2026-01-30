Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6C52367B3;
	Fri, 30 Jan 2026 02:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769739554; cv=none; b=WxBT0kUnWhXoJt292bwwinmjX3ZjAUySPj6ehu4KPyJ+Fx/6XklObxT5icf2bu17CJuehch62AcKFr8Hwlrx5KTK5SkojhwcvTcThR5ZK1RkqX/x5tCTIgKyLCSvTQkqKJoCis0DsItayRNP7eIuWTIwLrglh9ZFq921AH2WAKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769739554; c=relaxed/simple;
	bh=NjAPpTosY3lQ/p5rWHNPACXIr5Op02TX2xJmv0zDkJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xf+e4QebrGnzBpE88/0TAKcHHWDYEh09s5hez0z4lV3/lW4+vxaqtjYy/hJXA70lhIbh2cuJ1SxSDYGS3i2Djwiwk6nzUFmDbWoQ2eySYH5Su4w2gai8p7Ryh/LZY+HGumHL2uqkHpwQeRcwdOmyRWt3KCeYq5Al6VXSKyQXwF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Zhfkr5FS; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Zhfkr5FS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3L37Kj1YVepV8t0MrIFTs10YaampH61jAKZipBMOzSE=; b=Zhfkr5FSsKS6i2wo+F5XavtYDH
	xg3DwLF1DdhEnfuB0B3ON84vr4bwXY6a7RNjYPLMkpMFjne9sNBCpa6JFN+PtEGoImqCAAxuRcoTm
	wtKo3sDReLSoGyA/IApEJv19Lfdjg9Cj9jh9vpx0vhCL09sluxgA9WenxeG+yZ3rwkE1Jm4f/yO5g
	jNLxC4VFBydjkOLMTK5lO5i2+e7iwml5e5xcl1edOoudud1dMi14yFEQCxuWYu9za2cRgDiSjJoS8
	gBCAwJ2yc/GiFvS+0AJ8rs0KtGDZsTkSwpUqf7JqhzkVkiTyPlvQ3pkfee7W3z4JTalGvAveiDyw3
	jqGnsb4g==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vle5x-00BZgk-Ly; Fri, 30 Jan 2026 03:18:50 +0100
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
Subject: [PATCH v2] selftests/bpf: Make x86 preempt_count access compatible across v6.14+
Date: Fri, 30 Jan 2026 11:18:43 +0900
Message-ID: <20260130021843.154885-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent x86 kernels export __preempt_count as a ksym, while some old kernels
between v6.1 and v6.14 expose the preemption counter via
pcpu_hot.preempt_count. The existing selftest helper unconditionally
dereferenced __preempt_count, which breaks BPF program loading on such old
kernels.

Make the x86 preemption count lookup version-agnostic by:
- Marking __preempt_count and pcpu_hot as weak ksyms.
- Introducing a BTF-described pcpu_hot___local layout with
  preserve_access_index.
- Selecting the appropriate access path at runtime using ksym availability
  and bpf_ksym_exists() and bpf_core_field_exists().

This allows a single BPF binary to run correctly across kernel versions
(e.g., v6.18 vs. v6.13) without relying on compile-time version checks.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 .../testing/selftests/bpf/bpf_experimental.h  | 21 +++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index a39576c8ba04..acabf869d2c4 100644
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
@@ -624,7 +630,18 @@ struct task_struct___preempt_rt {
 static inline int get_preempt_count(void)
 {
 #if defined(bpf_target_x86)
-	return *(int *) bpf_this_cpu_ptr(&__preempt_count);
+	/* By default, read the per-CPU __preempt_count. */
+	if (bpf_ksym_exists(&__preempt_count))
+		return *(int *) bpf_this_cpu_ptr(&__preempt_count);
+
+	/* If __preempt_count does not exist, try to read preempt_count under
+	 * struct pcpu_hot. Between v6.1 and v6.14 -- more specifically,
+	 * [64701838bf057, 46e8fff6d45fe), preempt_count had been managed
+	 * under struct pcpu_hot.
+	 */
+	if (bpf_core_field_exists(pcpu_hot.preempt_count))
+		return ((struct pcpu_hot___local *)
+			bpf_this_cpu_ptr(&pcpu_hot))->preempt_count;
 #elif defined(bpf_target_arm64)
 	return bpf_get_current_task_btf()->thread_info.preempt.count;
 #endif
-- 
2.52.0

