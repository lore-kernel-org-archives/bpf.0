Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399B23515CA
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 20:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786651400; cv=none; b=s67u6EpdUpvidV+Mg+a/jx8ixgHmKVAT0i6uos+JqN1oIGgHhnVOK3ucaTk1l8uAi1JJTvas4I7R9HxLuQXoLbaFFVlgk4AqI1PIN4e8tDgL5HqCqIOlXLLuyTygGcxaKu+0ynYosbvo+jDygU1VN5APiYXz4z5Uxs1AcHbE8To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786651400; c=relaxed/simple;
	bh=Y4FOtCXduASeTM7EUTdwOuQNcd+hp9B/hMi2pgB50XQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLQIGtJ/XWs8S7PhgOsuqYxXnpbm6eOeDt1MjS76GhMg6RCbOiDpDzvm14IbCNFr+/yiPqtEMFQOJA1d+/W8iu0/umYhKpzRM2T12Jh8l4xWo9APixffYX6yaCmBnksYv6K0+1tS/BGFl8rg3ZRtRF9l0j+lbuvgiV3y3O0rDP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 1F7B623E03564A; Thu, 13 Aug 2026 13:03:07 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 11/11] Documentation/bpf: Document up to 16-byte kfunc return values in R0:R2
Date: Thu, 13 Aug 2026 13:03:07 -0700
Message-ID: <20260813200307.1998008-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813200210.1991507-1-yonghong.song@linux.dev>
References: <20260813200210.1991507-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

kfuncs may now return a value larger than 8 bytes and up to 16 bytes (a
scalar-only struct or union, or an __int128), passed back in the R0:R2
register pair. Add a kfunc return-value section documenting this,
including that a struct or union up to 8 bytes is returned in R0 alone,
which struct and union members are accepted, that the R0:R2 register pair
requires JIT support (bpf_jit_supports_kfunc_ret_reg_pair()), and that a
return value larger than 16 bytes is unsupported.

Also note that the same convention applies to BPF subprogram returns, and
document the consequence for a global subprogram: it must assign both
halves of a register-pair return, since an unassigned R2 may be left
holding a pointer argument and is then rejected as a leak.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 Documentation/bpf/kfuncs.rst | 63 ++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 10e725cbe64c..5d840d300033 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -575,6 +575,69 @@ is also covered by this recovery. A kfunc handed an =
arena pointer may
 therefore access up to ``GUARD_SZ / 2`` past it without bounds-checking
 against the arena. Larger accesses must verify the range explicitly.
=20
+2.9 kfunc Return Values
+-----------------------
+
+A kfunc may return a scalar, a pointer, or a small struct or union by
+value. A scalar or pointer of up to 8 bytes is returned in R0, as usual.
+
+A struct or union returned by value must be composed only of scalars
+(recursively), where a scalar is an integer or an enum; arrays of scalar=
s are
+allowed as members. Its bytes are handed back to the program as the raw
+contents of R0 (and R2), so a pointer field would be laundered into a sc=
alar
+and escape the verifier's pointer provenance and reference tracking. A s=
truct
+or union with a pointer member is therefore rejected at load time, and s=
o is
+one with a floating-point member, which the ABI may not return in R0:R2 =
at
+all.
+
+A kfunc may also return a value larger than 8 bytes and up to 16 bytes -=
- a
+scalar-only struct or union, or an ``__int128``. Such a value is returne=
d
+in the register pair R0:R2, matching the convention LLVM uses for the BP=
F
+target: the first 8 bytes in R0 and the second 8 bytes in R2. A struct o=
r
+union of 8 bytes or less is returned in R0 alone.
+
+::
+
+        struct bpf_pair { __u64 a, b; };   /* 16 bytes */
+
+        __bpf_kfunc struct bpf_pair bpf_kfunc_get_pair(void)
+        {
+                struct bpf_pair p =3D { .a =3D 1, .b =3D 2 };
+
+                return p;      /* p.a in R0, p.b in R2 */
+        }
+
+Returning a value in the R0:R2 pair requires the JIT to place the second
+half of the return value into R2, which not every architecture supports
+right now. A kfunc with a return value larger than 8 bytes is therefore
+rejected at load time on a JIT that does not advertise this capability (=
see
+``bpf_jit_supports_kfunc_ret_reg_pair()``), and such a program is never =
run
+by the interpreter. A return value larger than 16 bytes is not supported=
.
+
+The same R0:R2 convention applies to a BPF subprogram, global or static,
+that returns an ``__int128`` or a struct or union larger than 8 bytes. S=
uch a
+program also requires the JIT, since the interpreter propagates only R0 =
out
+of a subprogram. A global subprogram is verified in isolation, so its
+by-value struct or union return is restricted to scalars just like a kfu=
nc's;
+a static subprogram is verified inline and has no such restriction. The =
main
+program is not covered: its return value is the program's exit code, rea=
d out
+of R0 alone, so a declared upper half is never looked at.
+
+A global subprogram must leave a scalar in *every* register of the pair,=
 so
+both halves of the returned value have to be assigned. Leaving the upper=
 half
+uninitialized is not merely untidy: the compiler is then free to leave R=
2
+holding whatever it happened to hold, which for a subprogram taking a po=
inter
+argument is typically that pointer. Handing the caller an unknown scalar=
 built
+from a pointer is a leak, so the verifier rejects it with::
+
+        At subprogram exit the register R2 is not a scalar value (...)
+
+Initialize the whole return value, for example ``struct pair p =3D {};``=
, to
+avoid this. A static subprogram is exempt from the scalar-only rule: it =
is
+verified inline, so an unassigned R2 is simply passed back to the caller=
 as
+uninitialized and only a caller that reads it fails. A stack pointer lef=
t in
+R2 is still rejected there, just as one in R0 is.
+
 .. _BPF_kfunc_lifecycle_expectations:
=20
 3. kfunc lifecycle expectations
--=20
2.53.0-Meta

