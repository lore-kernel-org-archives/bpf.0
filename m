Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EEB3B19D2
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 20:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783541452; cv=none; b=BMD70XosewtMU+DvN/Ru8GUcXVNrYSZavEuj7eplxEQe1MCsq47KU+iStvNCFnHWnL9hpqy0aTQBrY+ddLO8UJx/xSirc7WewVekk8v3yrjBEm0+B3sCLy8EPdAbfzQOfpJ9MmkrR/BKY03O7h2+NIZclZtl0bjAN6E5gI1F8vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783541452; c=relaxed/simple;
	bh=4n1/NLhri3dILZaEJziw9DS9Gb6FcYU2RmRQiKFgZGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjocsAa/v0x0YOdgLPnjsLu1LZatHGhNvZ2LEjprDrKyTGdk4ARUYtYrR5AyNZNxzUeehHVdn5Je52uo+hyyJYjVfAoAdVP3K5hBP/84UpJ7PdMo/pW3gYVKYViGMuRq5scYSqeglGjC6kR1OsPxs/XNtFJoRBnowTdxoVCkPM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 5408F1D0B78CB3; Wed,  8 Jul 2026 13:10:41 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 12/12] Documentation/bpf: Document 16-byte kfunc return values in R0:R2
Date: Wed,  8 Jul 2026 13:10:41 -0700
Message-ID: <20260708201041.2164554-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708200939.2153664-1-yonghong.song@linux.dev>
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

kfuncs may now return a value larger than 8 bytes and up to 16 bytes (a
16-byte struct or union, or an __int128), passed back in the R0:R2 regist=
er
pair. Add a kfunc return-value section documenting this, including that a
struct or union up to 8 bytes is returned in R0 alone, that the R0:R2
register pair requires JIT support
(bpf_jit_supports_kfunc_ret_reg_pair()), and that a return value larger
than 16 bytes is unsupported.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 Documentation/bpf/kfuncs.rst | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index c801a330aece..be4f489a9f16 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -501,6 +501,42 @@ is also covered by this recovery. A kfunc handed an =
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
+(recursively). Its bytes are handed back to the program as the raw conte=
nts
+of R0 (and R2), so a pointer field would otherwise be laundered into a s=
calar
+and escape the verifier's pointer provenance and reference tracking. Suc=
h a
+struct or union is therefore rejected at load time.
+
+A kfunc may also return a value larger than 8 bytes and up to 16 bytes -=
- a
+16-byte scalar-only struct or union, or an ``__int128``. Such a value is
+returned in the register pair R0:R2, matching the convention LLVM uses f=
or
+the BPF target: the low 64 bits in R0 and the high 64 bits in R2. A stru=
ct
+or union of 8 bytes or less is returned in R0 alone.
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
 .. _BPF_kfunc_lifecycle_expectations:
=20
 3. kfunc lifecycle expectations
--=20
2.53.0-Meta

