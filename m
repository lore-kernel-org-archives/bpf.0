Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDFA477983;
	Thu, 20 Aug 2026 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787239915; cv=none; b=u/GXGga22620sSzix0ejND1k3FrH5x7Y24Vz+DyzXKHhcr+0j0NX8p0AURdgNaUuvQzFKUYi+Tl1DnF5DwT+GYUHuuHaI3ONamFMWGTEDFdge6ICgRg1qOMW5bns7/62aGOK2X/AJ706dqrbm0Hy0H8iY+AP1flNglCZgKFzevg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787239915; c=relaxed/simple;
	bh=KDuKqZCRSLoXodFYtXT1GvdkGt652Hs32fgPglj/sqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MuXRvJvV78XBk0ljylN3mcTuc/w9B/h5EGJXpXuZ9Kx9kz9sws23nM1WCbomjxt63oC7basQ8m0oFlAvyPz1yONSdlU+F9B9HIdn90ch2C21ABa8FR+XB3x32MLvdi9VKZlrnhlQFNw4+xX18w9YxTcvw5xOL7LxudBnTOVU0CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RvbTOVMi; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RvbTOVMi"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85A631D34;
	Thu, 20 Aug 2026 08:31:47 -0700 (PDT)
Received: from fedora (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB7A53F763;
	Thu, 20 Aug 2026 08:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787239911; bh=KDuKqZCRSLoXodFYtXT1GvdkGt652Hs32fgPglj/sqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RvbTOVMi16WGZGxPuXwQ4W1DIIg9XvTg0IZQB9rHZskZCS0ffLI3HW+7e0Z8DseXY
	 oXtSM75amqfwq8puYElP6x7pypEYaUQDrpxvl3r0l3gB5uI5p0UFwyU1I62lQB8ELc
	 /2MlOXkFVpH+ymWM67FyxsK1BypdIJnHfG2KvAzg=
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
Subject: [PATCH v3 3/5] selftests/x86: add shadow stack lock test
Date: Tue, 18 Aug 2026 17:54:26 -0500
Message-ID: <20260818225428.1983328-4-bill.roberts@arm.com>
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

Add a test that locks the shadow stack write bit and then attempts to
disable write. The disable should fail with EPERM since it's in a locked
state. This also preserves the write bit being set for the whole test
suite as well as preserving the ability to unlock at the end.
---
 .../testing/selftests/x86/test_shadow_stack.c | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/x86/test_shadow_stack.c b/tools/testing/selftests/x86/test_shadow_stack.c
index b52c5420c137..72e7329d89d7 100644
--- a/tools/testing/selftests/x86/test_shadow_stack.c
+++ b/tools/testing/selftests/x86/test_shadow_stack.c
@@ -1060,6 +1060,24 @@ int test_ptrace(void)
 	return 1;
 }
 
+static int test_locking(void)
+{
+
+	if (ARCH_PRCTL(ARCH_SHSTK_LOCK, ARCH_SHSTK_WRSS)) {
+		printf("[FAIL]\tCould not lock Shadow stack write\n");
+		return 1;
+	}
+
+	if (ARCH_PRCTL(ARCH_SHSTK_DISABLE, ARCH_SHSTK_WRSS) != -EPERM) {
+		printf("[FAIL]\tCould change Shadow stack write after lock\n");
+		return 1;
+	}
+
+	printf("[OK]\tShadow stack locking\n");
+
+	return 0;
+}
+
 int main(int argc, char *argv[])
 {
 	int ret = 0;
@@ -1079,12 +1097,33 @@ int main(int argc, char *argv[])
 		return 1;
 	}
 
+	/* Note: test_shadow_stack_lock() needs write enabled */
 	if (ARCH_PRCTL(ARCH_SHSTK_ENABLE, ARCH_SHSTK_WRSS)) {
 		printf("[SKIP]\tCould not enable WRSS\n");
 		ret = 1;
 		goto out;
 	}
 
+	unsigned long status = 0;
+
+	if (ARCH_PRCTL(ARCH_SHSTK_STATUS, &status)) {
+		printf("[FAIL]\tCould not get Shadow stack status\n");
+		ret = 1;
+		goto out;
+	}
+
+	if (status != (ARCH_SHSTK_WRSS|ARCH_SHSTK_SHSTK)) {
+		printf("[FAIL]\tStatus not as expected, got 0x%lx status, wanted: 0x%llx\n",
+			status, (ARCH_SHSTK_WRSS|ARCH_SHSTK_SHSTK));
+		ret = 1;
+		goto out;
+	}
+
+	if (test_locking()) {
+		ret = 1;
+		goto out;
+	}
+
 	/* Should have succeeded if here, but this is a test, so double check. */
 	if (!get_ssp()) {
 		printf("[FAIL]\tShadow stack disabled\n");
-- 
2.55.0

