Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F62A38BF8D
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790861425; cv=none; b=YpSGKsQQLAoeEqx8+Slv6DOqtrr6lDHT2itoPfKRUfmSEocuWz/YExR7ZVlazhARla9d8Mj1lNdGScOMaTDIQ/Loj/u0nj0+2w6vTgCZfa5rYBIuRjNwag8ZxewiRwrmxhgrB85C3Glm0qVR+T6dx7/mK22EBrnOkBRhwNdDmgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790861425; c=relaxed/simple;
	bh=PLSD6+NmYu+26TPKD2YfIBv6U+FkjHvllNuK8HLAH5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxKBmBqXW1iDDE5BJ8LiBDbN1kQo1RNOcH4DDKC/a95thoWbaKh1d3BQjzrL/9eEZcgUU1y0xjBmSDw+EkhMCZPx0oEZwUg5DGHKkDaWO1qHafBSVUH7bt5TqR9FyqY9/tOUlicPL/DIVXYwqmZRBk8Zf+LFr2/O7WYkdx7um60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 160502E6E0B87E; Thu,  1 Oct 2026 06:30:22 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v8 03/22] bpf: Add the bpf_unwind() and bpf_unwind_resume() kfuncs
Date: Thu,  1 Oct 2026 06:30:22 -0700
Message-ID: <20261001133022.1337350-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001133006.1335369-1-yonghong.song@linux.dev>
References: <20261001133006.1335369-1-yonghong.song@linux.dev>
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

bpf_unwind() begins an unwind: the frames it leaves run their landing
pads on the way out to the program's exit. It is separate from bpf_throw(=
),
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
bpf_unwind() may appear wherever a program can unwind from, and
bpf_unwind_resume() only inside a landing pad, and neither does anything
until a pad can be dispatched at run time, so registration waits for the
patch that adds that.

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

