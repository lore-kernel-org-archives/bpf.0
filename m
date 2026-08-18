Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC4447799B;
	Thu, 20 Aug 2026 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787239913; cv=none; b=PG/Vi/H5/+qZv41nsnNRrTR8lvTvpEO0urY2b/7dMZ83JOealT7E5JcUTyiu/f4Pz3XybbRTy74P2c+Dpmg9jU8xPEBphgrzTc9SHqUKQh0AK1ctszW9fbDk2du/o9QU6myxuBOESDgPmAG+5w3jrIGzcQM3p3sO0b482JO8B4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787239913; c=relaxed/simple;
	bh=SE7+SQCOB6oqaAE0wuDA+ZGR622dOiLN2dcvrAwIA+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yl+4j+E4yuPF7rcvc6kNNwTWlIglBDAlTMKCh7OMj2XIegCt9Yd1l1UFLq9cUjZ+7upqg10qC2ze0uZUhE0To5mDHYIrTVnHLCJR0t/+LSmgMMkchH2aZdtcZQHi7WtzRsFst9mrEWm7DlAMXWIKxI6mRAygVL1UBIntOkMpKZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UCP6uYrk; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UCP6uYrk"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F22DD153B;
	Thu, 20 Aug 2026 08:31:44 -0700 (PDT)
Received: from fedora (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AFEA3F763;
	Thu, 20 Aug 2026 08:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787239908; bh=SE7+SQCOB6oqaAE0wuDA+ZGR622dOiLN2dcvrAwIA+o=;
	h=From:To:Cc:Subject:Date:From;
	b=UCP6uYrk3v7L+sJmDPNwjvHM7Ke4Cq7H879K7vY1wi1HFXX/bdzj1h8SSRA8TVDCx
	 l7Z7e5iF77mejezmqwdFkccafqa5mh2kL/hBjdzohspCJUZtvrJp7yH7p96Ym9dXb6
	 FXmXWzfLfvbKrrkWguFveeFGAQTkbn621OgLnwCo=
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
Subject: [PATCH v3 0/5] x86: Support shstk via prctl
Date: Tue, 18 Aug 2026 17:54:23 -0500
Message-ID: <20260818225428.1983328-1-bill.roberts@arm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a continuation of adding prctl support for x86:
  - https://patchew.org/linux/20260714154740.140431-1-bill.roberts@arm.com/

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

FWIW X86 Maintaners and Rick, I structured this so you can just pull the bug fixes only
(up to but not including commit "x86/shstk: support via prctl") if you have concerns
on the other patches for me to address, this will allow you to take the bug fixes
and additional test now if desired.

Bill Roberts (5):
  selftests/x86: fix Makefile dependencies
  selftests/x86: fix fork bug
  selftests/x86: add shadow stack lock test
  x86/shstk: support via prctl
  selftests/x86: add generic prctl shadow stack test

 arch/x86/kernel/shstk.c                       |   56 +
 tools/testing/selftests/x86/Makefile          |   12 +-
 tools/testing/selftests/x86/shadow_stack.c    | 1287 +++++++++++++++++
 tools/testing/selftests/x86/shadow_stack.h    |   14 +
 .../testing/selftests/x86/test_shadow_stack.c | 1168 +--------------
 .../selftests/x86/test_shadow_stack_prctl.c   |   12 +
 6 files changed, 1384 insertions(+), 1165 deletions(-)
 create mode 100644 tools/testing/selftests/x86/shadow_stack.c
 create mode 100644 tools/testing/selftests/x86/shadow_stack.h
 create mode 100644 tools/testing/selftests/x86/test_shadow_stack_prctl.c

-- 
2.55.0

