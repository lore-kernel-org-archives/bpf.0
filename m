Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C192EEE80
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 06:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787811091; cv=none; b=U0xTg9LI99R55hlb7BLd7wIio5J4maiGg9KiNUjWEsszglswWSBOEgIgATr8W/fdtAbJBz3FWJe1ma8+OmSSH1N+swGQqbev8+0kk2/eeEX4ks6ctBhv0QLGZX4ymtJ9F5ir5mlDmCRMWH5344KjftPvyqWnuuYOXrfBNLHCWHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787811091; c=relaxed/simple;
	bh=P+P5MDFNYugZa+3vwrzJM42ptFqgg68004Pu28HIQIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qrALx4jALM+mNyFLlbrbeytWPKKua02TIHYCuIFIac4DZmjdoRys0XO3dApc2uO16ECM4iKb5XKn52PGLyAorQ5ixeuIDM6wNVImAkiDC4Y48ar0lS1o5HGhn7qPG0OrAz/AiRCiOoilSC4erkO/ukHudCRG3bMrAAmQlwLy0Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id D2A4C26CDE2C8D; Wed, 26 Aug 2026 23:11:14 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 00/11] bpf: Allow arena pointers in by-value returns
Date: Wed, 26 Aug 2026 23:11:14 -0700
Message-ID: <20260827061114.2514603-1-yonghong.song@linux.dev>
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
are selftests. Patch 11 updates the kfunc's doc.

Changelog:
  v1 -> v2:
    - v1: https://lore.kernel.org/bpf/20260824144943.991316-1-yonghong.so=
ng@linux.dev/
    - Add nested struct field names for diagnostics, and report the
      nesting depth for a type nested past the walk limit.
    - Allow to return arena pointers for global functions and kfuncs.
    - Necessary selftests for newly supported arena pointers.
  v2 -> v3:
    - v2: https://lore.kernel.org/bpf/20260825205412.1320099-1-yonghong.s=
ong@linux.dev/
    - Fix two more verifier diagnostics.
    - Fix btf_member_path_str() by detecting anonymous union/struct.
    - Fix a few arena tests with non-zero arena pointers.
    - Update kfuncs doc for supporting return value with arena pointers.

Yonghong Song (11):
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
  docs/bpf: Document arena pointers in a by-value return

 Documentation/bpf/kfuncs.rst                  |  39 ++--
 include/linux/bpf_verifier.h                  |  11 +-
 include/linux/btf.h                           |   1 +
 kernel/bpf/btf.c                              |  82 ++++----
 kernel/bpf/verifier.c                         | 195 ++++++++++++++----
 .../selftests/bpf/prog_tests/aggregate_ret.c  |  42 ++++
 .../selftests/bpf/progs/aggregate_ret_func.c  | 146 +++++++++++++
 .../selftests/bpf/progs/aggregate_ret_kfunc.c |  36 +++-
 .../bpf/progs/aggregate_ret_kfunc_arena.c     | 129 ++++++++++++
 .../selftests/bpf/progs/exceptions_fail.c     |   2 +-
 .../selftests/bpf/progs/verifier_arena.c      |  48 +++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  48 +++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  51 +++++
 13 files changed, 729 insertions(+), 101 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/aggregate_ret_kfunc=
_arena.c

--=20
2.53.0-Meta

