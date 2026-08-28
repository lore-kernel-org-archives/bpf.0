Received: from mta0.migadu.com (out-122.mta0.migadu.com [91.218.175.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFFF322B9F
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 21:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787953943; cv=none; b=XOJxrOXBYptjhoC9Oce9KHlyH3DEVse4G7LbsLm1vclKYzWNmNvwcyeI5GDlY7bvpWm3kVJcVQxbdAl5FtGEDd2I5VMcR5sFNfVysjcolcF/8oU6NGNT6vawe/oEuRDy7CNFKWbh0NRoxSyRnPx2oH1L5blpcbK9yFb9A4tBAD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787953943; c=relaxed/simple;
	bh=zW6XZOu1s5g8bZsAuAsGbxhqGiJuOz9ab+p0lez/fN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mz1TsbHjXtXS7/wFyu0D3n8NNFubsKdeZbEcK0EAX42j989bA3+z1vrANbxlb+0zLxcjZya08/expdstJL0fl6CrZ73FoEt5I1apYSRMzgddyeiIadHup0NfCV2xD9No+tlCBXto5zDV3oCuxhujXKQGER2nK2Zsw05Ho2g2Euw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oRcER7tF; arc=none smtp.client-ip=91.218.175.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oRcER7tF"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zW6XZOu1s5g8bZsAuAsGbxhqGiJuOz9ab+p0lez/fN0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787953937; v=1; x=1788558737;
 b=oRcER7tFoULO9VJaGQqh3xxULwwXV87IFlfHRGiHO1TIWuoMwG/Acsfs7+I9FmL3yRcy/27x
 UA6YyfpgqZMctxS3SHEbu0678KcC7AKy2XnFVQfzlc+ITzn3dcEx1+qrKrBPe1EAh3XZi5ijuK3
 EBJyhHOgNi8lznKm+9xVkRmg=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id b49e28aca4ba8ddc;
	Fri, 28 Aug 2026 21:52:17 +0000
X-Mizu-Trace-ID: b49e28aca4ba8ddc
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 0/6] bpftool, selftests: Add tests for C dump and fix a dropped type
Date: Fri, 28 Aug 2026 14:52:01 -0700
Message-ID: <20260828215207.3105313-1-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"bpftool btf dump format c" generates the vmlinux.h that BPF programs
are built against, and it has no direct test coverage. Building
against the header is not a substitute for testing it, nothing a
compiler accepts would break the build.

Add selftests targeting C dump in particular.

While we are here, refactor btf_dump selftests to use a new
compare_text_to_expected() helper and become more efficient.

Fix a bug in bpftool dump that dropped a type when sorting.

---

v1->v2:
  * new patches (#1-#3) introducing compare_text_to_expected() helper
    and refactoring btf_dump selftests
  * bpftool dump selftest compares the output to the expected files
    exactly (Eduard)
  * use VALIDATE_RAW_BTF macro in the new test (Eduard)
  * drop v1 patch #4 ("selftests/bpf: Check that sorting preserves
    types in bpftool dump") as it became unnecessary
  * nit in the bpftool fix (Andrii)

v1: https://lore.kernel.org/bpf/20260820000627.3826188-1-ihor.solodrai@linux.dev/

---

Ihor Solodrai (6):
  selftests/bpf: Add compare_text_to_expected() helper
  selftests/bpf: Modernize btf_dump test scaffolding
  selftests/bpf: Compare btf_dump expected output in-process
  selftests/bpf: NUL-terminate bpftool command output
  selftests/bpf: Add tests for bpftool btf dump format c
  bpftool: Don't drop a type in the sorted C dump

 tools/bpf/bpftool/btf.c                       |   6 +-
 tools/testing/selftests/bpf/Makefile          |   8 +-
 .../bpf/bpftool_btf_dump_sorted.expected      |  48 +++++
 .../bpf/bpftool_btf_dump_unsorted.expected    |  48 +++++
 tools/testing/selftests/bpf/bpftool_helpers.c |   7 +-
 .../bpf/prog_tests/bpftool_btf_dump.c         | 178 ++++++++++++++++++
 .../selftests/bpf/prog_tests/btf_dump.c       | 125 ++++++++----
 .../bpf/prog_tests/prog_tests_framework.c     |  23 +++
 tools/testing/selftests/bpf/testing_helpers.c |  43 +++++
 tools/testing/selftests/bpf/testing_helpers.h |   3 +
 10 files changed, 446 insertions(+), 43 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpftool_btf_dump_sorted.expected
 create mode 100644 tools/testing/selftests/bpf/bpftool_btf_dump_unsorted.expected
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c


base-commit: cd35e1b10182c42b4ae31ee49119463b17d8ba7f
-- 
2.55.0

