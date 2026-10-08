Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3C2372EF3
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 07:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791445823; cv=none; b=A7168zh7Ybn6qTK0N2X1x6wZbRBEvR8fbkqTzlcLZotoQ0fB5ki1XLL7RXKl9/V22Dn8unsjs6nmq/uwoW6h0LZe/SonAL+ZE3t3QVkESQGThWPRk6X/ihXFquMczZ/ll+d3owbVW4MU1ZeNlLGIv6Idigs1Fsi6t91sxELbDCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791445823; c=relaxed/simple;
	bh=gbjkncN7SLGd+gQsE8W6q7Ky6A4jYqERu8bqU3x0SuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3O7uO9yQ0cBIPHvwjR5KVe34KTca43MfvVv5DRXqIq4gO7zX8/Vi2K68c572E+RrLfjQ03LRs69S52eLzSlqgeoo40eOcJHK/3S6Q8bnUzMcMN8eDiCpnGZA2eJaDTSfWh83O5I3QGL6gYNffJxpdR3ivKjjFy6I+CkqynfmXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 0980B2FDA0BD20; Thu,  8 Oct 2026 00:50:15 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v9 03/23] bpf: Add the bpf_unwind() and bpf_unwind_resume() kfuncs
Date: Thu,  8 Oct 2026 00:50:15 -0700
Message-ID: <20261008075015.2996034-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008074959.2993751-1-yonghong.song@linux.dev>
References: <20261008074959.2993751-1-yonghong.song@linux.dev>
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

