Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248881;
	b=d7aC6W4U7ldNNkgmX5lStKHrG5Op9y8IhNRBWb2jiMx6tOSOCJ2UHIxlNbMTOJZCLmIy
	 DdZ5WfnrHU7us+ABDRENC250d34pe91CqjS3WKkkO6ZcxOMg/2fjDo07NBoKMIek45EQh
	 Du4W4drLfE/F110ecTZFYeu6LV5rAVJhsu6xTbWBjLi+xqSXcUUQoqOk9maPk30jzUS5z
	 utU3RL4tfWYdX9LIlLYSVQ+2BVlnTnkEUUUJIBNn9srlB8yzJifh4JVv+7aBJMgnRnyEC
	 AO6wORhmBlqNlEXBOukpfkxOHbWCnreOafqK1qaUoytOST4h3VfMgrY1G/AgkaEAuzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248881;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mDWFweHSaiLpPshCS+h0q+iQaBu+Lgc9eGDx2KfwrFI=;
	b=uVYwA4jaOr+z997c5TkRfoIiiImU+XgUDOr4uGAUAvnmImGVfKBnI7BRfZmzwqIK9hfQ
	 gycc9cRq9FKi4fK+ynX73/Z5iNG3tUUOgVp4rsgreKyEiyk8YB11RTOnb1Aao9S3BrozO
	 Ds32fBCx4ilFTkWB2RB4WxfTYSEAjh+KkaAG3q9uXdyLQoI50ldcvnwIF1d0krJCvjQhS
	 0TsYw+ZmFFF9BQSu0jwrHkSd/1ng9CWHJkhhZKyG4y8FmpQ2lARGCiMAJ98MWwyZ3Wnp7
	 YWmrRK4os6wALCemxxhEUoABdFy4mrCVbrIVibl8tr4Yt9RPlKD0GWMhfo7pU7DPZlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YcqTCjTp;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7E4606CC67;
	Mon,  9 Nov 2026 18:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E7E4606CC67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YcqTCjTp
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E91191758;
	Mon,  9 Nov 2026 10:27:57 -0800 (PST)
Received: from fedora (LJ9QCPV96V.austin.arm.com [10.118.150.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D12233F882;
	Mon,  9 Nov 2026 10:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794248880; bh=J7EaISQeGY9QzQfcJ7AujRJOKPOkfJhuRA/a7kt8pXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YcqTCjTpFZ8v6r5DSW9z3y4VFfKrCU486QOfw2utAPO7Lhg521/Zg0JVwjXE6iex7
	 DwNxAI8qtYwO86gLXzWJqinLT83xKK7mvVfoU8Nf2hr3n/T6WeL+U1GsA6jzJhvO5j
	 7FvCMN5ZkHFdu/UbWO3y3dbd3XI5/e1RP1ERV9Mc=
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
Subject: [PATCH v5 3/6] selftests/x86: add shadow stack lock test
Date: Mon,  9 Nov 2026 12:27:55 -0600
Message-ID: <20261109182758.252223-4-bill.roberts@arm.com>
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

The shadow stack selftests do not currently verify that locking
a feature prevents subsequent changes to its enabled state.

Add a test that locks the WRSS feature while enabled and verifies
that attempting to disable it fails with -EPERM.

Despite WRSS being locked, this allows the existing code in main()
to disable shadow stack before returning to prevent a SIGSEGV from
a shadow stack underflow. This is why shadow stack enable is not
locked.

Signed-off-by: Bill Roberts <bill.roberts@arm.com>
---
 .../testing/selftests/x86/test_shadow_stack.c | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/x86/test_shadow_stack.c b/tools/testing/selftests/x86/test_shadow_stack.c
index b52c5420c137..e047f1ceae0a 100644
--- a/tools/testing/selftests/x86/test_shadow_stack.c
+++ b/tools/testing/selftests/x86/test_shadow_stack.c
@@ -1060,9 +1060,28 @@ int test_ptrace(void)
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
+	unsigned long status = 0;
 
 	if (ARCH_PRCTL(ARCH_SHSTK_ENABLE, ARCH_SHSTK_SHSTK)) {
 		printf("[SKIP]\tCould not enable Shadow stack\n");
@@ -1079,12 +1098,31 @@ int main(int argc, char *argv[])
 		return 1;
 	}
 
+	/* Note: test_shadow_stack_lock() needs write enabled */
 	if (ARCH_PRCTL(ARCH_SHSTK_ENABLE, ARCH_SHSTK_WRSS)) {
 		printf("[SKIP]\tCould not enable WRSS\n");
 		ret = 1;
 		goto out;
 	}
 
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

