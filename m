Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32AD515967
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 21:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790024460; cv=none; b=jGv1TLZYBuHFjuQnJqTwMedwQhRetto3qhM8qIm92deDtyjzXrSzOw8QiKSQYV950ommGcsLFAu6umQ3ZqxHuKFwwJu0c2i4WwNagMV2GU0CzIB+YN+3/v4enENgYL3swwwOyTyV45t27G5VrdyeMKyG75cY6Gvru5GY8RrJFJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790024460; c=relaxed/simple;
	bh=StSFYLZhIVrAWVIhEoz6XdnlnmjXIhatOdEycEcu02g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFRRoM5iOkgLVT6257jTMXlt5DSutsjg6oUkZrQFT9BAkqhMLD/fiLGjRmfuo+1kNBM8puSeP1q2Byvbo81h3VAGpDEboXw9P47SA5i/dn487eJxVPU4Fxsg3jF+vc0nOUX0sq7ATaoYmVTZwmtk7neh7vE483/qVRUwZz1grRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 846D02C448A29E; Mon, 21 Sep 2026 14:00:43 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 02/20] bpf: Add the bpf_unwind_resume() kfunc
Date: Mon, 21 Sep 2026 14:00:43 -0700
Message-ID: <20260921210043.1715958-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921210033.1715000-1-yonghong.song@linux.dev>
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
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

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/helpers.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 501c7ce35cba..55c59f8b4c43 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3445,6 +3445,19 @@ __bpf_kfunc void bpf_throw(u64 cookie)
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
+	/* Never reached: a JIT emits the way out of a landing pad instead. */
+	WARN_ONCE(1, "A JIT should have replaced the exception cleanup resume\n=
");
+}
+
 __bpf_kfunc int bpf_wq_init(struct bpf_wq *wq, void *p__const_map, unsig=
ned int flags)
 {
 	struct bpf_async_kern *async =3D (struct bpf_async_kern *)wq;
@@ -4981,6 +4994,7 @@ BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE=
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

