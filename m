Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A973BCD2C
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 05:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789624629; cv=none; b=EgVixxXezIQJfKlxiYKrE9CKGFakBMjy5o2Sz7EyUU62y7FfDidVEOB3g+ZqZtWQoSxjjnPOnKhD94zPkqL/jwuPOlkTbXsFaesvVzm1jxlPObfKR/Z8R5ipkWHRigo7AHIgM+7vnYpx+KxbRJiecCc+ddC+jCi5KThGAVkB1Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789624629; c=relaxed/simple;
	bh=cjZc+tEQIwmX+wndaYUMj2tMX66I4Lr/IL+X+GJI8WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xy8SNITaPz5rDL8ubF16q3ynTUMqjk35fPF3w1W+lXVFqWb1/3RCHs6rQiID/f3qHOMhPR748qbWvnPhcLlt5CXYDazyETWm7DSnWbrcC4XYtiHfn4oTk9aHipsITs6hX4y02iRjJX+MVyTJuCsEmqJ0BH7b10sTl7Hkn0psv04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 9F19E2B4872D3F; Wed, 16 Sep 2026 22:56:55 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 02/20] bpf: Add the bpf_unwind_resume() kfunc
Date: Wed, 16 Sep 2026 22:56:55 -0700
Message-ID: <20260917055655.3927263-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917055645.3926444-1-yonghong.song@linux.dev>
References: <20260917055645.3926444-1-yonghong.song@linux.dev>
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

