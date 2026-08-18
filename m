Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F2F47799E;
	Thu, 20 Aug 2026 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787239914; cv=none; b=vBdfveE/iamg8igr9SUvLUNLqtyLPy141kecRd0qtVTYGOB8Hg6iIald9DPZKQoZS2OA4/7plH3dQj85YHaFw2TrqVanERjIAR7JVI+vXkTFQ6+4xJpNWEUyZIb3tuNNCTdyH3NnGXKlkzsvR6qvzGeVMc7vGlBeQNo3/kKSOwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787239914; c=relaxed/simple;
	bh=i3IVg9/IsAijQfkogrB4lEzc6L9iguV8iX0Bfx9OVtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZ8t6xhzAYcfKcPrzToLUuoKADp2wlaJFO8rvQxazyG7LqETQG/nwF3f/dddBxvgVQxrXASZlmSP+8snSrV01vdQkt1e6gvEfpfjplCr5THI4vGRerFo77zHudNl0tv3xphUchtC/TkUBBNUVvYnjY2/rZXD2zk0jXYeFQE2Opg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=t3pY1Hjt; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="t3pY1Hjt"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5D041691;
	Thu, 20 Aug 2026 08:31:45 -0700 (PDT)
Received: from fedora (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF05A3F763;
	Thu, 20 Aug 2026 08:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787239909; bh=i3IVg9/IsAijQfkogrB4lEzc6L9iguV8iX0Bfx9OVtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t3pY1HjtOuX6eDBKXjOuIvX6DHW5c/WnM7RMPGswlzJy5qaaKh6Mo1WzjqDMM9tD6
	 SBJV8u9muytpDmDygBqYqVAG3lXz8hVKn4pFr3rGu6uDSz8kG8hAHKS0Ij2Lb45XFW
	 fQbe0F6v9VYDaDcCaaz/etrm1sVPQh4mabaY776Y=
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
Subject: [PATCH v3 1/5] selftests/x86: fix Makefile dependencies
Date: Tue, 18 Aug 2026 17:54:24 -0500
Message-ID: <20260818225428.1983328-2-bill.roberts@arm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818225428.1983328-1-bill.roberts@arm.com>
References: <20260818225428.1983328-1-bill.roberts@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Makefile has a macro called "extra-files" that sets up the
dependency on the target. Right now, for some targets that need
EXTRA_FILES added to the compilation, the dependency is left untracked.
Thus, to fix this, use the aforementioned macro.

Signed-off-by: Bill Roberts <bill.roberts@arm.com>
---
 tools/testing/selftests/x86/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 434065215d12..a9a229f83b77 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -124,6 +124,10 @@ $(eval $(call extra-files,test_syscall_vdso_32,thunks_32.S))
 $(eval $(call extra-files,fsgsbase_restore_64,clang_helpers_64.S))
 $(eval $(call extra-files,fsgsbase_restore_32,clang_helpers_32.S))
 $(eval $(call extra-files,sysret_rip_64,clang_helpers_64.S))
+$(eval $(call extra-files,amx_64,xstate.c))
+$(eval $(call extra-files,avx_64,xstate.c))
+$(eval $(call extra-files,avx_64,xstate.c))
+$(eval $(call extra-files,apx_64,xstate.c))
 
 # check_initial_reg_state is special: it needs a custom entry, and it
 # needs to be static so that its interpreter doesn't destroy its initial
@@ -135,6 +139,3 @@ $(OUTPUT)/nx_stack_32: CFLAGS += -Wl,-z,noexecstack
 $(OUTPUT)/nx_stack_64: CFLAGS += -Wl,-z,noexecstack
 
 $(OUTPUT)/avx_64: CFLAGS += -mno-avx -mno-avx512f
-$(OUTPUT)/amx_64: EXTRA_FILES += xstate.c
-$(OUTPUT)/avx_64: EXTRA_FILES += xstate.c
-$(OUTPUT)/apx_64: EXTRA_FILES += xstate.c
-- 
2.55.0

