Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D19F3EC81B
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 04:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790139562; cv=none; b=Zmay2cXrRJvTIyyukvNcuKUiP5PQGN/TF9xIyPKWsXGcBYG8+PsBfXLhmSvIYgodDNZjxs7MUhD5/CI3/HXNpvOI16Q8a7ACvMKprNPKxm80mJi0fQzmLQy9rPOcKd+hSdVUBL69YoGZUikMo+6/F0/tqnqcmOBfXcMdltxZZfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790139562; c=relaxed/simple;
	bh=YM95HBxCH5iATHg5SLkEsXHRPI1+W8WlPhzcRkNqnHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMJe0R7udh3lDSlk4oXwHVVMiMOvWr1V8BWQIo+QcXJL7gsh4Y6rEFFo1K04GRTSbjAPD4BVa067/gAjfCChOMrcAIiicFKK8qxx5sXjiiQIg4wpMfcgoTBuMtJGuRtWS8jDDL1di5P9q0Vx6ItJQH1mbJD1ArmGOnN9qcBw+pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id D6F172C8DA169A; Tue, 22 Sep 2026 21:59:01 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 03/21] bpf: Add the bpf_unwind_resume() kfunc
Date: Tue, 22 Sep 2026 21:59:01 -0700
Message-ID: <20260923045901.2415616-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923045846.2414643-1-yonghong.song@linux.dev>
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
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

The kfunc is defined here but not registered with any program type yet. A
call to it is only ever valid inside a landing pad, and the verifier cann=
ot
say that until it knows what a landing pad is, so registration waits for
the patch that adds the rule.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/helpers.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 301b35bd85c8..249418e60ee4 100644
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
--=20
2.53.0-Meta

