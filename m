Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248882;
	b=uUILEdwssl7vkbHDY3jVb9WDwpI8oL3miVdTvycKFsBLmnK3FkIsLF5b5ot9U9ykXKDf
	 irYyeBbPKpiDUnMDxhqJYgU2+Mcjq/fjBF4bGxLAVK41BhG5xcl8o80QP/62bOh3tGuvG
	 zX4TlygH1ZL4dHwO4JWN2OQ+1sbyEJ9m3tbpgxdYAoupCk7ipzOaVEV3ypm24Rc0Kb+p5
	 WMuV7wjRq6E0ge3neq6Z82OFeVfOJcolTFtDONyEs8+/5IvRWaCpTxLAd7oP6Fd7RKMCY
	 iTzhag2zgkdCR12Py9VenGseZPBl2huBtxke83yG+WihqBp1UtI5aUDCiNnnvyyYJfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248882;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tBVcLDTDQdLuRrkj3YaQGxFUQfaBfSmy+arSLpiA7uo=;
	b=ag1DxXTiEzFLSJBgS57pLuGu0Eq61POzbAFhSxrOJCsusTUvViPLZVxMFmZG/hkiS0mQ
	 5lZYvICa/xgt7v/vhftPm2xu4Ok8INwff9J50xZY6PsonA4D1SSX+CZtdmF/5k4tDS8xw
	 TtxCBQ7jMeHpHcHI+L4TNc17Ut7AXhIiV7VnoxrHe7XhSHA23fCkFKJmzjT8jR4mcvOKh
	 z+1pcGODXgpNy9CUIw/0S/7qOiTAdmk7mRbD57ZoE6TlUYHZml+r/9hwM+e03+E8cw63T
	 GVnasgl+7hcBRd9rOANUX0xNnhJZUbvD/OI1FRVQB65hkgnvClBdn9zQdL5r/dDelBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=MrmthumD;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3B8606A31C;
	Mon,  9 Nov 2026 18:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E3B8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=MrmthumD
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 281661BCB;
	Mon,  9 Nov 2026 10:27:58 -0800 (PST)
Received: from fedora (LJ9QCPV96V.austin.arm.com [10.118.150.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 115D73F85F;
	Mon,  9 Nov 2026 10:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794248881; bh=lYo1Cd4405j4FxsBfBXZ4VfAkXOBhek+n65bObADoV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MrmthumDbz8H2s29YVtokXEoCRNz6+HHM0q8Nph19XifQQDa6f7Pr7dyXz3E4gErs
	 Vcgno8N4N88LO9XQURcc5Npj0FM1FNxvBfCwKgKPbFcCXhKephZuBEFUBb3v4b7rbR
	 fT0mb798gAfVKPdZGkdXFHM33CUodIXX4BAxanOs=
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
Subject: [PATCH v5 4/6] x86/shstk: support via prctl
Date: Mon,  9 Nov 2026 12:27:56 -0600
Message-ID: <20261109182758.252223-5-bill.roberts@arm.com>
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

On x86, userspace shadow stack state is managed through the
architecture-specific arch_prctl() interface. Other architectures,
including arm64 and RISC-V, use the generic shadow stack prctl()
interface instead.

This difference requires userspace runtimes, toolchains, and libc
implementations to support architecture-specific interfaces for
managing shadow stack state. It also complicates efforts to provide
consistent LSM mediation of control-flow integrity state changes.

Implement the generic PR_SET_SHADOW_STACK_STATUS,
PR_GET_SHADOW_STACK_STATUS, and PR_LOCK_SHADOW_STACK_STATUS
operations on x86 using the existing shadow stack helpers.
Retain the arch_prctl() interface for compatibility with
existing userspace.

Unlike arch_prctl(), which enables or disables individual features,
PR_SET_SHADOW_STACK_STATUS specifies the desired state of the
supported feature set. Translate this state into the corresponding
shadow stack and WRSS operations, changing only features whose
state differs from the requested state.

Avoid unnecessary operations because the underlying shadow stack
helpers check locked bits before checking whether the requested
feature state is already satisfied. If enabling or disabling WRSS
fails after enabling shadow stack, restore the original shadow
stack state.

Disabling shadow stack also disables WRSS, so do not disable WRSS
separately when clearing the entire feature set. This avoids
allowing a locked WRSS feature to prevent shadow stack disablement.

Reject unsupported feature combinations and use the existing
shadow stack helpers to enforce feature locking.

Signed-off-by: Bill Roberts <bill.roberts@arm.com>
---
 arch/x86/kernel/shstk.c | 80 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index eb690ba90180..6dfe310634b0 100644
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
@@ -630,3 +631,82 @@ bool shstk_is_enabled(void)
 {
 	return features_enabled(ARCH_SHSTK_SHSTK);
 }
+
+/* Handles the generic prctl interface for PR_SET_SHADOW_STACK_STATUS and its feature bits */
+int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status)
+{
+	int rc;
+	bool shstk_was_enabled = features_enabled(ARCH_SHSTK_SHSTK);
+
+	/*
+	 * Enable/disable the full feature set and preserve the original state for rollback.
+	 * Only act on changed features, since shstk_prctl() checks locked bits before checking
+	 * feature status.
+	 */
+	switch (status) {
+	case 0:
+		/*
+		 * Do not explicitly disable WRSS. Disabling shadow stack also
+		 * disables WRSS, and a locked WRSS must not prevent this.
+		 */
+		return shstk_was_enabled ?
+			shstk_prctl(t, ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK) : 0;
+
+	case PR_SHADOW_STACK_ENABLE:
+		if (!shstk_was_enabled) {
+			rc = shstk_prctl(t, ARCH_SHSTK_ENABLE, ARCH_SHSTK_SHSTK);
+			if (rc)
+				return rc;
+		}
+
+		if (features_enabled(ARCH_SHSTK_WRSS)) {
+			rc = shstk_prctl(t, ARCH_SHSTK_DISABLE, ARCH_SHSTK_WRSS);
+			if (rc && !shstk_was_enabled)
+				shstk_prctl(t, ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
+			return rc;
+		}
+
+		return 0;
+
+	case PR_SHADOW_STACK_ENABLE|PR_SHADOW_STACK_WRITE:
+		if (!shstk_was_enabled) {
+			rc = shstk_prctl(t, ARCH_SHSTK_ENABLE, ARCH_SHSTK_SHSTK);
+			if (rc)
+				return rc;
+		}
+
+		if (!features_enabled(ARCH_SHSTK_WRSS)) {
+			rc = shstk_prctl(t, ARCH_SHSTK_ENABLE, ARCH_SHSTK_WRSS);
+			if (rc && !shstk_was_enabled)
+				shstk_prctl(t, ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
+
+			return rc;
+		}
+
+		return 0;
+
+	/*
+	 * Unknown bit mapping, unsupported PR_SHADOW_STACK_PUSH or *only*
+	 * PR_SHADOW_STACK_WRITE.
+	 */
+	default:
+		return -EINVAL;
+	}
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

