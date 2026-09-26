Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7BB21767D
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 05:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790398836; cv=none; b=m6yZGNmR6U3Jy3pm4KJ/ppyfMQIzGjBlISP9LIarz2ZJYfeaU2AvaCgNL+DCJmoOqWZ6UuOsomZcpVFtfF7M2uNCkJ+vRko53KXc6BXim85x5U6Xox+lIkbAJDVSN4KR5DC3ipEDJwU0v4Dcyxl/hUM/9/nB+6xdxrZ2oLuJhK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790398836; c=relaxed/simple;
	bh=9NtoDs3lxqZH4d+HXjyymvZyBjweFLLNRIn0lTHQ6Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mMvoJUopuqaTfqcQZV0ERhKwc0hEQV6K/5cZhCzqgWWuyJtcY8vPn2CWDBNE4RZvXSp04nK30Pjvh0G8GmV7EuyZTQw+mmUUpkjw7BzCw9K6MIXUsyYB5EUix9wt+QmJFypC6hZuTwwSgk3TwJ/yUYczKOIVWaS0P2AJuTjdEaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id C28B72D458FDCC; Fri, 25 Sep 2026 22:00:21 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v6 03/21] bpf: Add the bpf_unwind() and bpf_unwind_resume() kfuncs
Date: Fri, 25 Sep 2026 22:00:21 -0700
Message-ID: <20260926050021.2215322-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926050006.2213110-1-yonghong.song@linux.dev>
References: <20260926050006.2213110-1-yonghong.song@linux.dev>
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
record covers it, a resume inside a landing pad -- and the verifier canno=
t
say that until it knows what a landing pad is, so registration waits for
the patch that adds the rule.

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

