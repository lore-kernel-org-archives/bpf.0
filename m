Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B037477990;
	Thu, 20 Aug 2026 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787239915; cv=none; b=aqTH64NNR63sOQbGyxab2dvlE9x6R6s00FfpAmx7AQOsv1DSTAyqRQszmPNn32Cw0UyhNhF2AUts5M+mtn6Zq1OC63qsJhtf0Vo7rtgnfG7YIMQJh3HKJLGNTNPOXTcGJPsbtSZppzNirSUpV4hz+cf7jPDrf3Z7JX4ygNxn0iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787239915; c=relaxed/simple;
	bh=crCYSSYpl48F2u7NOxJhg9Z//OSNsCqQ+HpgSMuElyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NuqkFuV+kiF6oMIYeBKDZgJoJDDy2PqmZ2QvCfT+FPZFXXK57UafBS7mb7OFbU1xggwT0j+IPTJOJUC5Zh5HTqRdI7A7QKpWXWMshx4GbMhNcaPGgX6ip5vT0PXvl2S0seu2funU30SDBrV5AvHOBSEP1WZEuuWtYonZAFQT7+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MrQg33LH; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MrQg33LH"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AA361D6F;
	Thu, 20 Aug 2026 08:31:48 -0700 (PDT)
Received: from fedora (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 807433FA21;
	Thu, 20 Aug 2026 08:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787239912; bh=crCYSSYpl48F2u7NOxJhg9Z//OSNsCqQ+HpgSMuElyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MrQg33LHiarXzep16uPzThOOQNAZTdMpCJl9zpvlzJAw3LbKR+BVGkJ8OlW50L3eS
	 rm/DkAiHq6AEKFZHx3eWpO/8Qc1IdNRR3iKaw9IabChBMkdRctzHybyVmJCtkMw5c0
	 hOu3wDC1qXqp9+DyKy8lh5fOpgPegn/F13jZ+kk4=
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
Subject: [PATCH v3 4/5] x86/shstk: support via prctl
Date: Tue, 18 Aug 2026 17:54:27 -0500
Message-ID: <20260818225428.1983328-5-bill.roberts@arm.com>
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

Historically, managing the user-space shadow stack state on x86 has
been handled exclusively through the arch_prctl() interface via the
ARCH_SHSTK_* operations. However, other architectures (such as arm64 and
riscv) do not implement arch_prctl() and instead utilize the newer,
arch-agnostic, prctl() interface (i.e. PR_GET_SHADOW_STACK_STATUS and
PR_SET_SHADOW_STACK_STATUS).

To provide language runtimes, toolchains, and libc implementations with a
consistent, cross-architecture interface for managing control-flow
integrity, wire up the generic shadow stack prctl handlers for x86.

Map the generic PR_SHADOW_STACK_ENABLE, PR_SHADOW_STACK_DISABLE, and
PR_SHADOW_STACK_LOCK operations onto the underlying x86 internal CET helper
routines. This allows portable userspace applications to toggle or query
shadow stack states without relying on architecture-specific system calls,
while maintaining backward compatibility with existing arch_prctl() calls.

Signed-off-by: Bill Roberts <bill.roberts@arm.com>
---
 arch/x86/kernel/shstk.c | 56 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 0ca64900192f..2c2a96b2d936 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -18,6 +18,7 @@
 #include <linux/sizes.h>
 #include <linux/user.h>
 #include <linux/syscalls.h>
+#include <linux/prctl.h>
 #include <asm/msr.h>
 #include <asm/fpu/xstate.h>
 #include <asm/fpu/types.h>
@@ -630,3 +631,58 @@ bool shstk_is_enabled(void)
 {
 	return features_enabled(ARCH_SHSTK_SHSTK);
 }
+
+#define PR_SHADOW_STACK_SUPPORTED_STATUS_MASK \
+		(PR_SHADOW_STACK_ENABLE | PR_SHADOW_STACK_WRITE)
+
+/* Handles the generic prctl interface for PR_SET_SHADOW_STACK_STATUS and its feature bits */
+int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status)
+{
+	int rc;
+	int tmp_rc;
+
+	if (status & ~PR_SHADOW_STACK_SUPPORTED_STATUS_MASK)
+		return -EINVAL;
+
+	/*
+	 * x86 arch_prctl is single bit at a time, so handle these one at time
+	 * If anything fails, rollback state.
+	 */
+	if (!(status & PR_SHADOW_STACK_ENABLE))
+		return shstk_prctl(t, ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
+
+	rc = shstk_prctl(t, ARCH_SHSTK_ENABLE, ARCH_SHSTK_SHSTK);
+	if (rc)
+		return rc;
+
+	if (status & PR_SHADOW_STACK_WRITE) {
+		rc = shstk_prctl(t, ARCH_SHSTK_ENABLE, ARCH_SHSTK_WRSS);
+		/* rollback, best attempt, if we actually enabled shadow stack in feature bits */
+		if (rc && (status & PR_SHADOW_STACK_ENABLE)) {
+			tmp_rc = shstk_prctl(t, ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
+			WARN(tmp_rc, "Could not rollback shadow stack enabled: %d\n", tmp_rc);
+		}
+
+		return rc;
+
+	}
+
+	return shstk_prctl(t, ARCH_SHSTK_DISABLE, ARCH_SHSTK_WRSS);
+}
+
+/* Handles the generic prctl interface for PR_LOCK_SHADOW_STACK_STATUS and its feature bits */
+int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status)
+{
+	return shstk_prctl(t, ARCH_SHSTK_LOCK, status);
+}
+
+/*
+ * We assume the prctl() feature bits line up with the arch_prctl() specific ones. If not,
+ * the flags returned via arch_get_shadow_stack_status will be mapped wrong.
+ */
+static_assert(PR_SHADOW_STACK_ENABLE == ARCH_SHSTK_SHSTK);
+static_assert(PR_SHADOW_STACK_WRITE  == ARCH_SHSTK_WRSS);
+int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *status)
+{
+	return shstk_prctl(t, ARCH_SHSTK_STATUS, (unsigned long)status);
+}
-- 
2.55.0

