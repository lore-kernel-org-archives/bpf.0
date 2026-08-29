Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69522353A9B
	for <bpf@vger.kernel.org>; Sat, 29 Aug 2026 06:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787984131; cv=none; b=T00AEheFYUTXHYu2OYKxsGRnCDXWY9n7QIEtSupk59BCbzaAr9qrl2rEFDag78ac3J+h1SHSBiOCSOuxaCHJEITa290+07fEUcN37+iJc/Bk3j0vcF1041QVRMQ/hmF4tjR3XvHXq0Cn5wODeQ9FY+5Tdnnzoksc/xi8Mtm76Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787984131; c=relaxed/simple;
	bh=ov+z864zBFReNM+4W2wh622zwgJkALsO2ucQYvk0XU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cuFCrQA9V1gvmrUyQDuu3mDIRheECBNj/Hm/cHmsZahIV290vaS6HcyN03kxHx0+IHHpK0eAbdr0D10xb9kGR4ZD+N2j2dr/RM6uP171L/LgCW6aZiiIkvNYv2qKQn/gv5XX9GgsFYyDkHCYnghCTWfwvc/VKZ+x7QGVoIFKpwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 5A1FA273B9C7A9; Fri, 28 Aug 2026 23:15:14 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 00/12] bpf: Allow arena pointers in by-value returns
Date: Fri, 28 Aug 2026 23:15:14 -0700
Message-ID: <20260829061514.1690730-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A function returning a struct by value may only return one whose members
are all scalars. That is stricter than it needs to be: an arena pointer
is safe to hand over as raw register bits, and both a global function
and a kfunc can already return one on its own.

This patch set allows returning arena pointer(s) (as member(s) of a
struct) for global functions and kfuncs. Any other pointer member stays
rejected, as it would be laundered into a scalar and escape provenance
and reference tracking.

Patch 1 fixes a diagnostics bug. Patches 2-4 are refactoring with no
functional change. Patch 5 checked (nested) arrays until non-array type
to be checked by struct or other types. Patch 6 improves the diagnostics
for an unsupported return type, and patches 7-8 allow arena pointer membe=
rs.
Patches 9-11 are selftests. Patch 12 updates the kfunc's doc.

Changelog:
  v3 -> v4:
    - v3: https://lore.kernel.org/bpf/20260827061114.2514603-1-yonghong.s=
ong@linux.dev/
    - Generate type string(s) for those verifier rejected kfunc's.
    - For global function, disable returning arena pointer if main prog.
    - Add additional tests for rejected kfunc type string(s).
  v2 -> v3:
    - v2: https://lore.kernel.org/bpf/20260825205412.1320099-1-yonghong.s=
ong@linux.dev/
    - Fix two more verifier diagnostics.
    - Fix btf_member_path_str() by detecting anonymous union/struct.
    - Fix a few arena tests with non-zero arena pointers.
    - Update kfuncs doc for supporting return value with arena pointers.
  v1 -> v2:
    - v1: https://lore.kernel.org/bpf/20260824144943.991316-1-yonghong.so=
ng@linux.dev/
    - Add nested struct field names for diagnostics, and report the
      nesting depth for a type nested past the walk limit.
    - Allow to return arena pointers for global functions and kfuncs.
    - Necessary selftests for newly supported arena pointers.

Yonghong Song (12):
  bpf: Record each half of a paired return value in verifier diagnostics
  bpf: Drop the recursion depth argument of btf_type_is_scalar_struct()
  bpf: Add btf_type_is_arena_ptr()
  bpf: Let the by-value struct walk take the kinds of member it accepts
  bpf: Let a by-value struct nest arrays and structs freely
  bpf: Report which member makes a kfunc return type unsupported
  bpf: Allow a global function to return arena pointers by value
  bpf: Allow arena pointers in a by-value kfunc return
  selftests/bpf: Check the member named for an unsupported kfunc return
    type
  selftests/bpf: Test global functions returning arena pointers by value
  selftests/bpf: Test kfuncs returning arena pointers by value
  docs/bpf: Document arena pointers in a by-value return

 Documentation/bpf/kfuncs.rst                  |  39 +--
 include/linux/bpf_verifier.h                  |  11 +-
 include/linux/btf.h                           |   1 +
 kernel/bpf/btf.c                              |  90 ++++---
 kernel/bpf/verifier.c                         | 228 ++++++++++++++----
 .../selftests/bpf/prog_tests/aggregate_ret.c  |  42 ++++
 .../selftests/bpf/progs/aggregate_ret_func.c  | 146 +++++++++++
 .../selftests/bpf/progs/aggregate_ret_kfunc.c |  84 ++++++-
 .../bpf/progs/aggregate_ret_kfunc_arena.c     | 121 ++++++++++
 .../selftests/bpf/progs/exceptions_fail.c     |   2 +-
 .../selftests/bpf/progs/verifier_arena.c      |  48 ++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  72 ++++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  72 ++++++
 13 files changed, 850 insertions(+), 106 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_kfunc=
_arena.c

--=20
2.53.0-Meta

