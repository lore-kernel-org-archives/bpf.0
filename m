Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5F043F0B6;
	Tue, 15 Sep 2026 19:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789500449; cv=none; b=RjQz/pv5a6VqkmDL/KO1O/DdFJea7HhDjNX0H1NiWqfUUcLd6uf58ausua9SbaiBVoeszUw+Jt5WyOBK0hwxuFy4+fn3flFjYwr7w5nhRwx31lwhjZpEOuU59xjD6MX87zb/ogP9tPoGe7Exz7grDeRIqaveC/AwBtS6gWbdTic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789500449; c=relaxed/simple;
	bh=dxEbHXWTcjfRkZ8H8m2GTN3i0m/Ob9N29KEozpiedGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9WgK+34bknum8dJrw9oV8KPrnhFdOopOw5Uy9Q+0V5dRBCslW+2RfATij1bQh1v0BinhMyJRJT42xR/czAaW6KUTuGxml+3Yvu35nuNktZZPwV3uXKM6OVEnGa57n5lvofCgrWlXE2v0qVMOgYHJqiAD7AMTcab02rcJzK6xTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=awjJPdnN; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="awjJPdnN"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0B1A1BF3;
	Tue, 15 Sep 2026 12:27:23 -0700 (PDT)
Received: from fedora (LJ9QCPV96V.austin.arm.com [10.118.150.127])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB8E93F882;
	Tue, 15 Sep 2026 12:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789500447; bh=dxEbHXWTcjfRkZ8H8m2GTN3i0m/Ob9N29KEozpiedGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=awjJPdnN/Fg/YjjVUJr8qqu9y5vM+Xdm6Rwj4IPozAnMpdCX0QnnZLuVREtuXujVa
	 B2wSZayAW9zWCfQmourO+Ib37aHjvNmkPSGuQjh4FcV0eX096ypJpJj8cM8heMjWNH
	 g5a6mKd4u+yY1PJ6OhojykObH6JHHWmxhQj+o1go=
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
Subject: [PATCH v4 1/6] selftests/x86: fix Makefile dependencies
Date: Wed, 16 Sep 2026 04:52:19 -0500
Message-ID: <20260916095224.1533971-2-bill.roberts@arm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916095224.1533971-1-bill.roberts@arm.com>
References: <20260916095224.1533971-1-bill.roberts@arm.com>
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
 tools/testing/selftests/x86/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 434065215d12..75315f1190d6 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -124,6 +124,9 @@ $(eval $(call extra-files,test_syscall_vdso_32,thunks_32.S))
 $(eval $(call extra-files,fsgsbase_restore_64,clang_helpers_64.S))
 $(eval $(call extra-files,fsgsbase_restore_32,clang_helpers_32.S))
 $(eval $(call extra-files,sysret_rip_64,clang_helpers_64.S))
+$(eval $(call extra-files,amx_64,xstate.c))
+$(eval $(call extra-files,avx_64,xstate.c))
+$(eval $(call extra-files,apx_64,xstate.c))
 
 # check_initial_reg_state is special: it needs a custom entry, and it
 # needs to be static so that its interpreter doesn't destroy its initial
@@ -135,6 +138,3 @@ $(OUTPUT)/nx_stack_32: CFLAGS += -Wl,-z,noexecstack
 $(OUTPUT)/nx_stack_64: CFLAGS += -Wl,-z,noexecstack
 
 $(OUTPUT)/avx_64: CFLAGS += -mno-avx -mno-avx512f
-$(OUTPUT)/amx_64: EXTRA_FILES += xstate.c
-$(OUTPUT)/avx_64: EXTRA_FILES += xstate.c
-$(OUTPUT)/apx_64: EXTRA_FILES += xstate.c
-- 
2.55.0

