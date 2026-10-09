Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7131F3A8723
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 04:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791519324; cv=none; b=n0btF1/1LH41dSxCSLtEj2qgdL2ezKgopVCWmmoNKVQEglYdUNzju0KSDdiNJnPD7/qELpQk0d2qdscKLlAYGArLrzWn5sVN7HeSae9Jw6uya2orl+EOsHhWcedp+nHMBUD81v/baI9saGEPftUusQyWgk2uRwAjcbB8Z7dBWPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791519324; c=relaxed/simple;
	bh=gbjkncN7SLGd+gQsE8W6q7Ky6A4jYqERu8bqU3x0SuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DMX2/LNAQv68JeD/Dameo/cDP3InuEzEfpZZT7larQUphHx4r7c9uING6j5v0mdqf4BWNmYqzQ6F3oKuub8YzdBW8ERCw8an16J1EpwULc+L2+CkggcazAlG7GpLanwiwReOnpfXkhsFMDylQdVIPcSNRMgBlT0WVnsA3kDgtV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 5F0BD3008C0E4D; Thu,  8 Oct 2026 21:15:03 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v10 03/24] bpf: Add the bpf_unwind() and bpf_unwind_resume() kfuncs
Date: Thu,  8 Oct 2026 21:15:03 -0700
Message-ID: <20261009041503.20582-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009041447.17092-1-yonghong.song@linux.dev>
References: <20261009041447.17092-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

An exception cleanup needs two terminators:

 - bpf_unwind() begins an unwind: the frames it leaves run their landing
   pads on the way out to the program's exit. It is separate from
   bpf_throw(), which discards the frames in between.
 - bpf_unwind_resume() ends a landing pad, carrying the unwind on. The
   compiler calls it _Unwind_Resume, which a later libbpf patch resolves
   to this name, and passes it the exception object, which the kfunc
   takes as ptr__ign.

Neither is registered yet: that waits for the patch that dispatches pads
at run time.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/helpers.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a284f20c97d5..4eccd6742eba 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3424,6 +3424,10 @@ static bool bpf_stack_walker(void *cookie, u64 ip,=
 u64 sp, u64 bp)
 	return false;
 }
=20
+__bpf_kfunc void bpf_unwind(void)
+{
+}
+
 __bpf_kfunc void bpf_throw(u64 cookie)
 {
 	struct bpf_throw_ctx ctx =3D {};
@@ -3445,6 +3449,16 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 	WARN(1, "A call to BPF exception callback should never return\n");
 }
=20
+__bpf_kfunc void bpf_unwind_resume(void *ptr__ign)
+{
+	/*
+	 * Never reached: the verifier accepts this kfunc only as a frame
+	 * terminator and bpf_do_misc_fixups() lowers every one of them to
+	 * 'r0 =3D 0; exit', so no call to this body survives to run.
+	 */
+	WARN_ONCE(1, "exception cleanup resume was not lowered to a return\n");
+}
+
 __bpf_kfunc int bpf_wq_init(struct bpf_wq *wq, void *p__const_map, unsig=
ned int flags)
 {
 	struct bpf_async_kern *async =3D (struct bpf_async_kern *)wq;
--=20
2.53.0-Meta

