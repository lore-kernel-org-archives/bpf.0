Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DD337B02A
	for <bpf@vger.kernel.org>; Sat, 29 Aug 2026 06:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787984182; cv=none; b=kMpVA6UHime/u+uGrPlswXoJOp0B8VSJXOL66m+DYXXGS/0ODse8FI+S1wIqlW3O2i3JLhqrsL2VRVC7zhhfuAlJYF14TAMY3YkD5ZUt47NGSEEGNi8sixHtXlTq84yxOL0lVvyBDyDvsLqveTL+0DKGsoIHiS8OMDaTRYGL8ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787984182; c=relaxed/simple;
	bh=S2J/2BOu+akWWayHGirBFj/myFcZ7oova4hYdXniWpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/hioqIRv9bNTOOv5p5xnIXZg073Y2IflqIwyNLBaCOo7Gzicval8/W+hggFqlupjZeNLn+dWnWx/CwT4c4Xca0LqJQDAxDyZCVe8WZAXyhVRrn9ntWELWmLwjZijw+3AHmNkw63m34/u3vtwindF97sXdpmpMO4DP7gWPyGIcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id A83B6273BA36F7; Fri, 28 Aug 2026 23:16:15 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 12/12] docs/bpf: Document arena pointers in a by-value return
Date: Fri, 28 Aug 2026 23:16:15 -0700
Message-ID: <20260829061615.1700421-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260829061514.1690730-1-yonghong.song@linux.dev>
References: <20260829061514.1690730-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Section 2.9 describes the by-value return contract as scalars only, which
no longer holds: a kfunc and a global subprogram may now return a struct
or union whose members are scalars or arena pointers. Update it.

Note that an arena pointer member is handed back as a scalar like every
other member. That costs nothing: the program has to cast_kern() the valu=
e
before it can be used, and the verifier allows that cast on any scalar, s=
o
the member gives the program no reach it did not already have.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 Documentation/bpf/kfuncs.rst | 39 ++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 89dea6b0b024..ebe37c1fe9d2 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -581,20 +581,29 @@ against the arena. Larger accesses must verify the =
range explicitly.
 A kfunc may return a scalar, a pointer, or a small struct or union by
 value. A scalar or pointer of up to 8 bytes is returned in R0, as usual.
=20
-A struct or union returned by value must be composed only of scalars
-(recursively), where a scalar is an integer or an enum; arrays of scalar=
s are
-allowed as members. Its bytes are handed back to the program as the raw
-contents of R0 (and R2), so a pointer field would be laundered into a sc=
alar
-and escape the verifier's pointer provenance and reference tracking. A s=
truct
-or union with a pointer member is therefore rejected at load time, and s=
o is
-one with a floating-point member, which the ABI may not return in R0:R2 =
at
+A struct or union returned by value must be composed only of scalars and=
 arena
+pointers, where a scalar is an integer or an enum and an arena pointer i=
s one
+carrying the ``btf_type_tag("arena")`` attribute. Those may be nested in
+structs and unions and in arrays of any number of dimensions, in any
+combination, as long as what the nesting bottoms out in is a scalar or a=
n arena
+pointer. Its bytes are handed back to the program as the raw contents of=
 R0
+(and R2), so a member of any other pointer type would be laundered into =
a
+scalar and escape the verifier's pointer provenance and reference tracki=
ng. A
+struct or union with such a member is therefore rejected at load time, a=
nd so
+is one with a floating-point member, which the ABI may not return in R0:=
R2 at
 all.
=20
+An arena pointer member is handed back as a scalar too, but nothing is l=
ost by
+that. The program must ``cast_kern()`` the value before it can be used, =
and the
+verifier allows that cast on any scalar, so a laundered arena address gi=
ves the
+program no reach it did not already have. The result is confined to the
+program's arena in either case.
+
 A kfunc may also return a value larger than 8 bytes and up to 16 bytes -=
- a
-scalar-only struct or union, or an ``__int128``. Such a value is returne=
d
-in the register pair R0:R2, matching the convention LLVM uses for the BP=
F
-target: the first 8 bytes in R0 and the second 8 bytes in R2. A struct o=
r
-union of 8 bytes or less is returned in R0 alone.
+struct or union of scalars and arena pointers, or an ``__int128``. Such =
a
+value is returned in the register pair R0:R2, matching the convention LL=
VM
+uses for the BPF target: the first 8 bytes in R0 and the second 8 bytes =
in R2.
+A struct or union of 8 bytes or less is returned in R0 alone.
=20
 ::
=20
@@ -620,10 +629,10 @@ used when the program is JITed, since the interpret=
er propagates only R0 out of
 a subprogram: without a JIT the return value stays in R0 alone, and a ca=
ller
 reading R2 is rejected for reading an uninitialized register. A global
 subprogram is verified in isolation, so its by-value struct or union ret=
urn is
-restricted to scalars just like a kfunc's; a static subprogram is verifi=
ed
-inline and has no such restriction. The main program is not covered: its=
 return
-value is the program's exit code, read out of R0 alone, so a declared up=
per
-half is never looked at.
+restricted to scalars and arena pointers just like a kfunc's; a static
+subprogram is verified inline and has no such restriction. The main prog=
ram is
+not covered: its return value is the program's exit code, read out of R0
+alone, so a declared upper half is never looked at.
=20
 A global subprogram must leave a scalar in *every* register of the pair,=
 so
 both halves of the returned value have to be assigned. Leaving the upper=
 half
--=20
2.53.0-Meta

