Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17F630CD85
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 00:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790640993; cv=none; b=sC1mVSdIZYTxrWFzqgLWYshyRW4AWUgdigzJcERqm4qOlmWlwxIUSyvllV1Xh2qWsbauHIQ1yYjGP3B7aBY/nTSLePS2CJERcjAmMhmcNES4qAsaW3eafWUhPPEdwM7kp+z1ZSETTDkxOIOfbyfAH+0DpRZeJE6dg0054VljRQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790640993; c=relaxed/simple;
	bh=Ww/qH/w79FVKc28d8HIzsE1XshWdGSoWUykJUFw5SdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lni/2ciFwDrgHVztZgkeGOARJSBtjTEO+CBaWpnIRbi5KXP1BnAotbzdfUkBirf6qWgPzn4OaM8tNO2CwQNdgy3bso6/XwXn0PftlIhYbvYSFRqQ4iVIHp/0cQ/5XLxHvqsSb0+2lRYY6oDE0ANPq141ofOU4uA2u7nJouFT/E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id E62F82DE06B751; Mon, 28 Sep 2026 17:16:17 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v7 03/22] bpf: Add the bpf_unwind() and bpf_unwind_resume() kfuncs
Date: Mon, 28 Sep 2026 17:16:17 -0700
Message-ID: <20260929001617.3246997-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929001601.3242665-1-yonghong.song@linux.dev>
References: <20260929001601.3242665-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

An exception cleanup needs two terminators, and the kernel provides both =
as
kfuncs so that a BPF program can name them.

bpf_unwind() begins an unwind: the frames between it and whatever catches
run their landing pads on the way out. It is separate from bpf_throw(),
which keeps its own meaning -- leaving for the exception boundary with th=
e
frames in between discarded.

bpf_unwind_resume() ends a landing pad, carrying the unwind on once that
frame's cleanups have run. The compiler names it _Unwind_Resume, the base
unwind ABI's entry point for the same thing; a later libbpf patch resolve=
s
that name to this one. Every unwind ABI hands _Unwind_Resume the exceptio=
n
object, and LLVM emits that argument on BPF too. Nothing in the kernel
needs it now, but the kfunc takes it as ptr__ign so the prototype matches
the call the compiler makes.

Both are defined here and neither is registered with any program type yet=
.
A call to either is only valid in a particular place -- an unwind where a
record covers it, a resume inside a landing pad -- and neither does
anything until a pad can be dispatched at run time, so registration waits
for the patch that adds that.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/helpers.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a284f20c97d5..08aee86a155c 100644
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
+	 * terminator and do_misc_fixups() lowers every one of them to
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

