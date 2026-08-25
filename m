Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D536202F70
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 20:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787691266; cv=none; b=bz/0zNirfaEMQIV8gGCUGHky1/+nZx5AMofxIMFi4R8zve+liW2ZCGXVOxRoupOmoX7iazUOXW/ie65K5+VtDUNH16oixls+QkIim68WNUweLZlATTKcv8unoodKd1bWv8R73Qtj6AH8bQstjhzenN+45R9aeIOBMV6yOT2gXDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787691266; c=relaxed/simple;
	bh=KeapneowJpyfdj13mw/h77zBeenuDTvaRHazls262xU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TcCTOIzEZQp9DDSfQeBB1d0Hoig0xzPZ0zl6SHOeXi1kywo+WKfcLprzBT0EGy2D+OVkFtI4VbseXeeH0GxEgpebPjVHv1XgLO9HKZ3fSV7igB96K4+CSuxLSqPKhF5nQ1Rhw9jOxG5cbTPkt7ATB5Tgu4zI+frKdcP+jPp6PnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 763BC268293CA3; Tue, 25 Aug 2026 13:54:12 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 00/10] bpf: Allow arena pointers in by-value returns
Date: Tue, 25 Aug 2026 13:54:12 -0700
Message-ID: <20260825205412.1320099-1-yonghong.song@linux.dev>
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
functional change. Patch 5 improves the diagnostics for an unsupported
return type, and patches 6-7 allow arena pointer members. Patches 8-10
are selftests.

Changelog:
  v1 -> v2:
    - v1: https://lore.kernel.org/bpf/20260824144943.991316-1-yonghong.so=
ng@linux.dev/
    - Add nested struct field names for diagnostics, and report the
      nesting depth for a type nested past the walk limit.
    - Allow to return arena pointers for global functions and kfuncs.
    - Necessary selftests for newly supported arena pointers.

Yonghong Song (10):
  bpf: Record each half of a paired return value in verifier diagnostics
  bpf: Drop the recursion depth argument of btf_type_is_scalar_struct()
  bpf: Add btf_type_is_arena_ptr()
  bpf: Let the by-value struct walk take the kinds of member it accepts
  bpf: Report which member makes a kfunc return type unsupported
  bpf: Allow a global function to return arena pointers by value
  bpf: Allow arena pointers in a by-value kfunc return
  selftests/bpf: Check the member named for an unsupported kfunc return
    type
  selftests/bpf: Test global functions returning arena pointers by value
  selftests/bpf: Test kfuncs returning arena pointers by value

 include/linux/bpf_verifier.h                  |  11 +-
 include/linux/btf.h                           |   1 +
 kernel/bpf/btf.c                              |  79 ++++------
 kernel/bpf/verifier.c                         | 148 ++++++++++++++----
 .../selftests/bpf/prog_tests/aggregate_ret.c  |  42 +++++
 .../selftests/bpf/progs/aggregate_ret_func.c  | 118 ++++++++++++++
 .../selftests/bpf/progs/aggregate_ret_kfunc.c |  36 ++++-
 .../bpf/progs/aggregate_ret_kfunc_arena.c     |  47 ++++++
 .../selftests/bpf/progs/exceptions_fail.c     |   2 +-
 .../selftests/bpf/progs/verifier_arena.c      |  37 +++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  32 ++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  39 +++++
 12 files changed, 513 insertions(+), 79 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_kfunc=
_arena.c

--=20
2.53.0-Meta

