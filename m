Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3943037A832
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 04:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789706531; cv=none; b=LXlF6EUD6GoJMgcJIhV92id91gpGVBfaf6q5NbkQ4bht1gM/R91AfgTD41vBOauRW9bypXeQJ1gafPs6+K1rCkKuOQ+8IbyO1smd6oWobWrqXpQOeWSv3mS+tdXmGtcb8goMLcAIWGJp8VGzTEPSc/NfyqVWwoyEL4ZEnK5cOnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789706531; c=relaxed/simple;
	bh=cjZc+tEQIwmX+wndaYUMj2tMX66I4Lr/IL+X+GJI8WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4QG9ZS95uv4nqC+KCiOB2S1VjxYYerd5QFWT1CaxA5NT+cPwOw2EcssEBGw1xrYy8ElVhb8gQibiDbQ/c+ilghoG5xcyqTgv2mll16+GlWDn5c+94reiwYulOGv2mVmsd2OmyuDS5eOIvqaGxc7IWEMIuFTuohEppR7O8YepaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 3DD6B2B7C4BFE1; Thu, 17 Sep 2026 21:42:06 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 02/20] bpf: Add the bpf_unwind_resume() kfunc
Date: Thu, 17 Sep 2026 21:42:06 -0700
Message-ID: <20260918044206.3285274-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918044156.3283973-1-yonghong.song@linux.dev>
References: <20260918044156.3283973-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A compiler-emitted cleanup landing pad ends with a call to
_Unwind_Resume(), which carries the unwind on once that frame's cleanups
have run. The kernel provides the same terminator as a kfunc, named
bpf_unwind_resume() to keep the 'bpf_' prefix kfunc convention; a later
libbpf patch resolves the compiler's name to it.

The body never runs. A JIT emits the way back out of a landing pad in its
place.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/helpers.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 051b6654e57c..31d84de4d318 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3407,6 +3407,17 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 	WARN(1, "A call to BPF exception callback should never return\n");
 }
=20
+/*
+ * Terminator of a compiler-emitted cleanup landing pad. The compiler na=
mes
+ * this _Unwind_Resume, the base unwind ABI's entry point for carrying a=
n
+ * unwind on once a frame's cleanups have run. To match kernel kfunc
+ * convention, the kernel calls it bpf_unwind_resume and libbpf maps the
+ * compiler's name onto it.
+ */
+__bpf_kfunc void bpf_unwind_resume(void)
+{
+}
+
 __bpf_kfunc int bpf_wq_init(struct bpf_wq *wq, void *p__const_map, unsig=
ned int flags)
 {
 	struct bpf_async_kern *async =3D (struct bpf_async_kern *)wq;
@@ -4853,6 +4864,7 @@ BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE=
 | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_from_vpid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_throw)
+BTF_ID_FLAGS(func, bpf_unwind_resume)
 #ifdef CONFIG_BPF_EVENTS
 BTF_ID_FLAGS(func, bpf_send_signal_task)
 #endif
--=20
2.53.0-Meta

