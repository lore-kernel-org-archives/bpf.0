Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B29618A6CF
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 06:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787811136; cv=none; b=fM7CP2HlMlKFEpesZorvDACoDAsmhCI6oL/vIpvy5tspRF5K2cTVb7v3z9GZMxHkPytYkJo0Q0N3iGaNd7A/uecdUNTuGpU6O7xlbTCOhwgUhCyn98uAixorWXk2/lXkuO6bHIDvrSBqiQo7z73nXrmV7AcnG7W0PrQX+sUEsJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787811136; c=relaxed/simple;
	bh=O0dYbG3HywEWAXpzOdZu0XK5B7whHcyDxH3653JKhiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+UQEhoD5n8avrDpeDfrgMRJF2Rd+DzeCmBerHWlbIad10vOebNddE37O6vx+TJW278v63mqSO5Fh6LAab/Fvmz85MdYWe33YJi/lfHaNjadAS8/K3yKSiMYs1jx7+vTM4qwl9JkBWcWZy6xGrhoQe95kIfTVOJ4IXMFQoV+5Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 3800E26CDEC722; Wed, 26 Aug 2026 23:12:11 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 11/11] docs/bpf: Document arena pointers in a by-value return
Date: Wed, 26 Aug 2026 23:12:11 -0700
Message-ID: <20260827061211.2520959-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827061114.2514603-1-yonghong.song@linux.dev>
References: <20260827061114.2514603-1-yonghong.song@linux.dev>
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
 Documentation/bpf/kfuncs.rst | 39 +++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 89dea6b0b024..96bf63d34432 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -581,20 +581,27 @@ against the arena. Larger accesses must verify the =
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
-all.
+A struct or union returned by value must be composed only of scalars and=
 arena
+pointers (recursively), where a scalar is an integer or an enum and an a=
rena
+pointer is one carrying the ``btf_type_tag("arena")`` attribute; arrays =
of
+either are allowed as members. Its bytes are handed back to the program =
as the
+raw contents of R0 (and R2), so a member of any other pointer type would=
 be
+laundered into a scalar and escape the verifier's pointer provenance and
+reference tracking. A struct or union with such a member is therefore re=
jected
+at load time, and so is one with a floating-point member, which the ABI =
may not
+return in R0:R2 at all.
+
+An arena pointer member is handed back as a scalar too, but nothing is l=
ost by
+that. The program must ``cast_kern()`` the value before it can be used, =
and the
+verifier allows that cast on any scalar, so a laundered arena address gi=
ves the
+program no reach it did not already have. The result is confined to the
+program's arena in either case.
=20
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
@@ -620,10 +627,10 @@ used when the program is JITed, since the interpret=
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

