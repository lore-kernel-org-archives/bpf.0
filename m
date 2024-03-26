Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577F613CA82
	for <bpf@vger.kernel.org>; Tue, 26 Mar 2024 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470133; cv=none; b=Q9Ve1XRG9+WvMHP+fG0S6NYY44kJwYR78otljWtfOt9txsrpLAtUTgjn7D53BAdhg++2OYFUG4yA+yYgmHm1w2Vg7sZPIa7rxF5tehWLHtw4bJxpuByPKfpRzudMJye0FS2y4WlWaJCUdesSAM30SWZYu+99plupQmCWCmZHsZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470133; c=relaxed/simple;
	bh=FHse5wFkBT2C5doki9aJ9Lrjl8HOY2rW4r0iaCWsUQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svB2KSYKxIH/fs3I3zPoeqUlHzVMWIDYOoDknF/OFh4OCvusVtuFmESWzYNb46edcY9AKxkNQZyfgKzdqOhX5x4yL1ZPjdWpANX7X1PP86DZhZIhgdTZR7c1y0nkXZGRkeZ+GZ94LrAO0DmtQ2L1KdwgUR54opKcIa2UTSR4/2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UH289cUn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UH289cUn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC546C433C7;
	Tue, 26 Mar 2024 16:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711470132;
	bh=FHse5wFkBT2C5doki9aJ9Lrjl8HOY2rW4r0iaCWsUQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UH289cUnVxTpf+BVs/4kFMx6Twtt7AqWggVII6nZMvAaNlEnkLSFs0HWl5Hkm3q0/
	 WDXh6Hbl+pXWT0W/CHsuzyCC/OQ+nPnLHyBavIUsYqIYAk1UZIJKfe8DfDLnTfCbSB
	 aJolH1t6Mh5ha1vb1EZbvdv1Qa6kTPZpK2vGrfIPR4eG1Bjcz0y3jlX89mOotD8NxB
	 Rhx0Opkw025y7KdvuYZaRqDYaJ17vhKA6QjxReLfLOr0KjVnFc3bzIDGlDDG4QJgyM
	 gXgRKkcfyxjetmCCC6mv0yGYwHsc51sdSa5+YLZadUmnJJbWADUP8z+lAaKwQlm8xZ
	 piIs43scAExnA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 5/6] bpf: add bpf_modify_return_test_tp() kfunc triggering tracepoint
Date: Tue, 26 Mar 2024 09:21:50 -0700
Message-ID: <20240326162151.3981687-6-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326162151.3981687-1-andrii@kernel.org>
References: <20240326162151.3981687-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple bpf_modify_return_test_tp() kfunc, available to all program
types, that is useful for various testing and benchmarking scenarios, as
it allows to trigger most tracing BPF program types from BPF side,
allowing to do complex testing and benchmarking scenarios.

It is also attachable to for fmod_ret programs, making it a good and
simple way to trigger fmod_ret program under test/benchmark.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/trace/events/bpf_test_run.h | 17 +++++++++++++++++
 kernel/bpf/helpers.c                |  1 +
 net/bpf/test_run.c                  |  8 ++++++++
 3 files changed, 26 insertions(+)

diff --git a/include/trace/events/bpf_test_run.h b/include/trace/events/bpf_test_run.h
index 265447e3f71a..0c924d39b7cb 100644
--- a/include/trace/events/bpf_test_run.h
+++ b/include/trace/events/bpf_test_run.h
@@ -7,6 +7,23 @@
 
 #include <linux/tracepoint.h>
 
+TRACE_EVENT(bpf_trigger_tp,
+
+	TP_PROTO(int nonce),
+
+	TP_ARGS(nonce),
+
+	TP_STRUCT__entry(
+		__field(int, nonce)
+	),
+
+	TP_fast_assign(
+		__entry->nonce = nonce;
+	),
+
+	TP_printk("nonce %d", __entry->nonce)
+);
+
 DECLARE_EVENT_CLASS(bpf_test_finish,
 
 	TP_PROTO(int *err),
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9234174ccb21..f89c35a17546 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2625,6 +2625,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
 BTF_ID_FLAGS(func, bpf_dynptr_size)
 BTF_ID_FLAGS(func, bpf_dynptr_clone)
+BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 61efeadaff8d..f6aad4ed2ab2 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -575,6 +575,13 @@ __bpf_kfunc int bpf_modify_return_test2(int a, int *b, short c, int d,
 	return a + *b + c + d + (long)e + f + g;
 }
 
+__bpf_kfunc int bpf_modify_return_test_tp(int nonce)
+{
+	trace_bpf_trigger_tp(nonce);
+
+	return nonce;
+}
+
 int noinline bpf_fentry_shadow_test(int a)
 {
 	return a + 1;
@@ -622,6 +629,7 @@ __bpf_kfunc_end_defs();
 BTF_KFUNCS_START(bpf_test_modify_return_ids)
 BTF_ID_FLAGS(func, bpf_modify_return_test)
 BTF_ID_FLAGS(func, bpf_modify_return_test2)
+BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
 BTF_ID_FLAGS(func, bpf_fentry_test1, KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_test_modify_return_ids)
 
-- 
2.43.0

