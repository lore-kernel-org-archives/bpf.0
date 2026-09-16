Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDD1414A1E;
	Tue, 15 Sep 2026 19:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789500451; cv=none; b=HfDv1Y7Vh4qvlDLn0BhxVWdWXAqYif7TBlxR2Vy4acUHDNms46/PyfoxvDmZhlLSdfGi1cMBE3miGUp+w2pYtVmV14j4cTaM4hROeRALPYieJLOItgJQkMZJ2hbvHluDIdFs3l2jtyKKhpGkU6o7rOR2m8MXLs/5KrmC5upmR5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789500451; c=relaxed/simple;
	bh=SERxyWYD022WZHuV/yT5Rq6DmPEtRTzqUEfVTjwzJkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fAPSEcw23Z0q0YIubOdSdQuJFpVgaMb8vNVude2E3Vtfh/yRKPlc//oR2JU+LiznzxQ93Ba58csX08IKTMA3cg/PWRRVw7TEdMKsCPPhfeQGUsb+oMzAC5oQ83x9D/jssduc8yn8C06M3bOp1dAJHo1KSkVrWXapQmmBMsZuvAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rqD4xt3e; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rqD4xt3e"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0846E152B;
	Tue, 15 Sep 2026 12:27:23 -0700 (PDT)
Received: from fedora (LJ9QCPV96V.austin.arm.com [10.118.150.127])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E6233F7B4;
	Tue, 15 Sep 2026 12:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789500446; bh=SERxyWYD022WZHuV/yT5Rq6DmPEtRTzqUEfVTjwzJkA=;
	h=From:To:Cc:Subject:Date:From;
	b=rqD4xt3etJOFtBmB9JtcZ+IA2lcH52ghXFJRrRk2ZigGVebq73VK+kzoxNkwMMqu8
	 JBW1z9ooL6eEWS2TR05pg5R1KZEsJeO0r/Xx/8EddnvvzZzEj6STm0LnFOA2bkqj0q
	 OGgGc/K2VQbX2SgSLZ8LPJdhJM35lw7r2ompn/ig=
From: Bill Roberts <bill.roberts@arm.com>
To: "H. Peter Anvin" <hpa@zytor.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	rick.p.edgecombe@intel.com,
	Shuah Khan <shuah@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	x86@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Bill Roberts <bill.roberts@arm.com>
Subject: [PATCH v4 0/6] 
Date: Wed, 16 Sep 2026 04:52:18 -0500
Message-ID: <20260916095224.1533971-1-bill.roberts@arm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a continuation of:
  - https://lore.kernel.org/all/20260818225428.1983328-1-bill.roberts@arm.com/

FWIW X86 Maintaners and Rick, I structured this so you can just pull the bug fixes only
(up to but not including commit "x86/shstk: support via prctl") if you have concerns
on the other patches for me to address, this will allow you to take the bug fixes
and additional test now if desired.

History:
  - v1: Initial Patches
  - v2: Nacked by author
    - Refactors the test suite
  - v3:
    - Fixes an existing fork bug pointed out by Shashiko
    - Fixes a state rollback issue in the patch itself
    - Fixes Makefile dependencies
    - Add's a test for shadow stack state locking
    - Refactors the arch_prctl and prctl tests into two different files using
      a shared testing suite file
  - v4:
    - fix rollback state logic


Bill Roberts (6):
  selftests/x86: fix Makefile dependencies
  selftests/x86: fix fork bug
  selftests/x86: add shadow stack lock test
  x86/shstk: support via prctl
  selftests/x86: support header files in extra-files
  selftests/x86: add generic prctl shadow stack test

 arch/x86/kernel/shstk.c                       |   83 ++
 tools/testing/selftests/x86/Makefile          |   13 +-
 tools/testing/selftests/x86/shadow_stack.c    | 1287 +++++++++++++++++
 tools/testing/selftests/x86/shadow_stack.h    |   14 +
 .../testing/selftests/x86/test_shadow_stack.c | 1168 +--------------
 .../selftests/x86/test_shadow_stack_prctl.c   |   12 +
 6 files changed, 1411 insertions(+), 1166 deletions(-)
 create mode 100644 tools/testing/selftests/x86/shadow_stack.c
 create mode 100644 tools/testing/selftests/x86/shadow_stack.h
 create mode 100644 tools/testing/selftests/x86/test_shadow_stack_prctl.c

-- 
2.55.0

