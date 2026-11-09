Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248882;
	b=Qm4eeo1QGnyF3FTksoRB9lgUJKYexepWfrDGVwm84nNXrH6sVikxJ/t2eFG/wEYsghyY
	 X6fOp2jnLEYWfML9gkKRhz+SKluW9JGdQE/eD+nsslr+IiZk+ycTqx7cTR7McureGO0ZW
	 nMSbMNwnkCWxAaarmzR99aveVDgagDFB6uVmn0v6BTTmgQiMJHgxVlhEvCsqPsAON2PIM
	 0qMbLqWnFPMvgY0BTzt5YYXmsy+PEB3PI22PKT5OUDsP4UW4zM8HnhGe8fQEhzvP7yRua
	 9nDgHVt/QoTOkudX7lPKFH/lhoC9OvVPyurSLcQ+n3Y4sndT7oVYytOf/DBsVpGQuiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248882;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2Km2GSxbHj/FwJWinfGFQrNYNNiuY/aL3TRKRBAUre4=;
	b=ilDCk5DmxSS7CAkSgs1OmeRhkvN5C9eeIBD//tGpbmW3uq9COfilVfCPMYCcrRFunNBq
	 jsU3tTls7P2T0qgpFdqSYNKpkqsV/g77ECAb5j8mi6FimEbefG1XFj39dKKdxywzTD+2x
	 iczCCK7yn+m4pQ109J3i7IjSxOIyA+uAtnFeAsRjzsq6O5f369lvK/YVX1jNFuLzkqqiO
	 ZaAaT37w5L3iAhLdrxjF4dS/iS6Nd4p85Dy+yPcKoVLecjDHh5Q1SVv+IMHWg9fSBhtXj
	 lre4l3a9qF2TRoIbnwb5QYpKI7Tnl6dfZS2KWVcetBLdxuWI38UP4Op/QUq03WpNTRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=LCpU0slD;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125D3606CC7E;
	Mon,  9 Nov 2026 18:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 125D3606CC7E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=LCpU0slD
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FAFD1516;
	Mon,  9 Nov 2026 10:27:57 -0800 (PST)
Received: from fedora (LJ9QCPV96V.austin.arm.com [10.118.150.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67B023F882;
	Mon,  9 Nov 2026 10:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794248880; bh=TezBVMNN6ys0eo1UDXqs5nEWcIgbDf5ZaksL5J9sVA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LCpU0slDYy6FAmTne67yVMyUDseKI/TcfooVukx5cMHtl1ArCnMWZSfeh81vJYbRw
	 sgikhecqphNp0sHI2P8Rz7m62kxFlqBPYq3fgAaVbjItBepgIINJf+NCh5Vg7sHCzo
	 NVll1VkJIB0m4llujQkLtv8KQDKuY2/oym8U8lZk=
From: Bill Roberts <bill.roberts@arm.com>
To: "H. Peter Anvin" <hpa@zytor.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	rick.p.edgecombe@intel.com,
	Shuah Khan <shuah@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	x86@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Bill Roberts <bill.roberts@arm.com>
Subject: [PATCH v5 1/6] selftests/x86: fix Makefile dependencies
Date: Mon,  9 Nov 2026 12:27:53 -0600
Message-ID: <20261109182758.252223-2-bill.roberts@arm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261109182758.252223-1-bill.roberts@arm.com>
References: <20261109182758.252223-1-bill.roberts@arm.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The amx_64, avx_64, and apx_64 tests compile xstate.c as an
additional source file. However, their Makefile rules add xstate.c
directly to EXTRA_FILES without registering it as a prerequisite.

As a result, modifying xstate.c does not trigger a rebuild of the
affected test binaries, potentially leaving stale test executables.

Use the existing extra-files macro to register xstate.c as both
an additional compilation input and a build dependency.

Signed-off-by: Bill Roberts <bill.roberts@arm.com>
---
 tools/testing/selftests/x86/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 7565d2cf6a3c..407f52ac2628 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -125,6 +125,9 @@ $(eval $(call extra-files,test_syscall_vdso_32,thunks_32.S))
 $(eval $(call extra-files,fsgsbase_restore_64,clang_helpers_64.S))
 $(eval $(call extra-files,fsgsbase_restore_32,clang_helpers_32.S))
 $(eval $(call extra-files,sysret_rip_64,clang_helpers_64.S))
+$(eval $(call extra-files,amx_64,xstate.c))
+$(eval $(call extra-files,avx_64,xstate.c))
+$(eval $(call extra-files,apx_64,xstate.c))
 
 # check_initial_reg_state is special: it needs a custom entry, and it
 # needs to be static so that its interpreter doesn't destroy its initial
@@ -136,8 +139,5 @@ $(OUTPUT)/nx_stack_32: CFLAGS += -Wl,-z,noexecstack
 $(OUTPUT)/nx_stack_64: CFLAGS += -Wl,-z,noexecstack
 
 $(OUTPUT)/avx_64: CFLAGS += -mno-avx -mno-avx512f
-$(OUTPUT)/amx_64: EXTRA_FILES += xstate.c
-$(OUTPUT)/avx_64: EXTRA_FILES += xstate.c
-$(OUTPUT)/apx_64: EXTRA_FILES += xstate.c
 
 $(OUTPUT)/sigframe_fpu_portability_64: CFLAGS += -mno-avx -mno-avx512f
-- 
2.55.0

