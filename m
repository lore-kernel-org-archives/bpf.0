Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A08474267;
	Wed, 12 Aug 2026 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555193; cv=none; b=ZKTGJs2+lNTqddXvNkVPsETkgFoUGvQIn/0sTXWN0MKEfetQKYPQkQpyq0b5NlQVGlKpH5vgm02ArhAaK+hyd4c5FbstwMRuM0F+DIcicbfr47SwfPapc7cRtv2CjzDogcIkZ8npyxUH/kBdiZ+4LgbwtbZSUVRqSWfQCrDXUEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555193; c=relaxed/simple;
	bh=i5iDbk7xspyU9JtWPxQanLp+P+TxFksfKMvwWQ0GNmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sFeLzVGt1F3s0rYcq2QvnVIt00CKjdehz4Y2RTB4aVAD3aNaEuSn1aW4Lh4iYfEFVVnzyRDjUFRMVGIevhOZWUUXo4iVmCJS+BJh1tHS14un6GJbz///yve3Iynb5vGuaWg238A2J7ABmXrNzWHHf0OJoFCaptOOGOsSk68Pdwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=M6DHFVir; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="M6DHFVir"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D295B1596;
	Wed, 12 Aug 2026 10:19:46 -0700 (PDT)
Received: from fedora (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B287F3F66F;
	Wed, 12 Aug 2026 10:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786555190; bh=i5iDbk7xspyU9JtWPxQanLp+P+TxFksfKMvwWQ0GNmU=;
	h=From:To:Cc:Subject:Date:From;
	b=M6DHFVir0DQKQ3p3jdphqsuM/XS1GejEM6rjemttLZzudXUBL/Q6p8XmzkocZadC5
	 lPG8BN6/JCURoSKcrafIKBQCV9s59NrO7cokSBI5IOb3WKRC1cFftcEAAjTqmxoOkH
	 f2dUbhJ6hcKKz7fl1NmgIRagL2bNzPvap5MRpakA=
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
Subject: [PATCH v2 1/2] x86/shstk: support via prctl
Date: Wed, 12 Aug 2026 12:19:39 -0500
Message-ID: <20260812171940.1046116-1-bill.roberts@arm.com>
X-Mailer: git-send-email 2.55.0
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
 arch/x86/kernel/shstk.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 0ca64900192f..c34ba3701dd0 100644
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
@@ -630,3 +631,39 @@ bool shstk_is_enabled(void)
 {
 	return features_enabled(ARCH_SHSTK_SHSTK);
 }
+
+#define PR_SHADOW_STACK_SUPPORTED_STATUS_MASK \
+		(PR_SHADOW_STACK_ENABLE | PR_SHADOW_STACK_WRITE | PR_SHADOW_STACK_PUSH)
+
+/* Handles the generic prctl interface for PR_SET_SHADOW_STACK_STATUS and its feature bits */
+int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status)
+{
+	int rc;
+
+	if (status & ~PR_SHADOW_STACK_SUPPORTED_STATUS_MASK)
+		return -EINVAL;
+
+	/* x86 arch_prctl is single bit at a time, so handle these one at time */
+	if (!status & PR_SHADOW_STACK_ENABLE)
+		return shstk_prctl(t, ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
+
+	rc = shstk_prctl(t, ARCH_SHSTK_ENABLE, ARCH_SHSTK_SHSTK);
+	if (rc)
+		return rc;
+
+	if (status & PR_SHADOW_STACK_WRITE)
+		return shstk_prctl(t, ARCH_SHSTK_ENABLE, ARCH_SHSTK_WRSS);
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
+int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *status)
+{
+	return shstk_prctl(t, ARCH_SHSTK_STATUS, (unsigned long)status);
+}
-- 
2.55.0

