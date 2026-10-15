Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171DA3EE1EE
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 04:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792036934; cv=none; b=OMPTKQ0yKCc8B+JBBHeC3hskhmhIg+NtOIW8ucCsLxJJiE1GC1ph7aJMUdvAAAg78we/yiqoL1Tdw2v+jFX7I9qVjUDvohNQI1avjkoJ4D5tCpb2kM4TQxU5GNC3iwfF1PloMhMZSa0Hbze8+AajS1v7ci99hEKNlgRFSSRMqLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792036934; c=relaxed/simple;
	bh=fYojV1QgPqqP475NiWHC1E5uSGKtRcohjGDPf9oOGXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRgbCSx9728q7uDw2sOdtdY68921qQILM025n2sC91/ApczaOqynJCrR3eJ+vPMTt2ICTwt+e5ruMJ8ZiEI3wCY0CnQoQVEaYpWJAVRTLEdY3nYr9Liq8hLb4r9EhIb7AirS4Ib8W4Odfr7vW1VMSgH1x8Hz/oakCB09vvYqul8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 25A5D31498D98F; Wed, 14 Oct 2026 21:01:59 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v11 03/26] bpf: Add the bpf_unwind() and bpf_unwind_resume() kfuncs
Date: Wed, 14 Oct 2026 21:01:59 -0700
Message-ID: <20261015040159.855401-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015040143.854070-1-yonghong.song@linux.dev>
References: <20261015040143.854070-1-yonghong.song@linux.dev>
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
 kernel/bpf/helpers.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a284f20c97d5..98ab22c6adc4 100644
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
@@ -3445,6 +3449,15 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 	WARN(1, "A call to BPF exception callback should never return\n");
 }
=20
+__bpf_kfunc void bpf_unwind_resume(void *ptr__ign)
+{
+	/*
+	 * Not meant to run: every call of this kfunc is to be lowered to
+	 * 'r0 =3D 0; exit' by the verifier.
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

