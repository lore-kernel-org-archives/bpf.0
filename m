Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B003F3D3D05
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 05:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882970; cv=none; b=WoEdbFgQ5gDkrdrSgvs71E1ziymGHmMcqTuMPOyXyglrUjOkhIbnh1pm+CRaqefHqlcK1LoM5BpDhqE7UxpmiEQxvN/ns/fOxej+CFjVzKrMJ6wDCcwJPkbFca6N0tnp8Qp/imIg6bicb4GyeWRpNj64nljETbuEVS8bpwqJry0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882970; c=relaxed/simple;
	bh=ILQlzCuiuqy5eUtol4Uv6FDBqIt9hB9+fXIfclJJ5DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NidkflH4VvckPoNaEOom6hA8YtQ0rY8yFCiv/LCNARtDyB3LnkC5GoBqOIEMeVx1MJXCgBajC6D77ICatMrGO+zrv86Q9zQYqDIiEv5P7PvVuK/iD398sHL9hfdAq676dQpYhkLmszMVrR/EGYbz43MhfhmNxenSHG+3ejwdY24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 5CCD42BEBA30AA; Sat, 19 Sep 2026 22:42:36 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 02/20] bpf: Add the bpf_unwind_resume() kfunc
Date: Sat, 19 Sep 2026 22:42:36 -0700
Message-ID: <20260920054236.865966-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920054225.864535-1-yonghong.song@linux.dev>
References: <20260920054225.864535-1-yonghong.song@linux.dev>
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
index 82402d97ce67..2163fd40f349 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3445,6 +3445,17 @@ __bpf_kfunc void bpf_throw(u64 cookie)
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
@@ -4981,6 +4992,7 @@ BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE=
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

