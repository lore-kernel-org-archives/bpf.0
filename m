Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D8A476CCE;
	Thu, 20 Aug 2026 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787239914; cv=none; b=bI8sF75qicSlBMpxYVFIiFTDnch/6yF9FJ2AjB4/WapwM2eCqaXEc/5X5aiOhP6/Dgh/LJ/4LOye3koWUd1Gn5hE8CfbLoctnUOQBZfuE7up6UyRUxXLbIDSiUQ06kbPdCBK9G9Lxvw5+/oYuTjJQihTfloWTf12B1sQlD61Wqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787239914; c=relaxed/simple;
	bh=bX4F8fbDYk1pMbaaFVuC2gJZ7gdHty9FAL8pUarXuzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XLBT1GKbkQHKZlOPQDTDy7driUYt94QnhelJX+AXS7QVmwahWfAPrALJJhagKTK6TUIL+d21kqksqeW7B8iZ1ce9fmw26Q+dtFQ9yhsGo0lCLDU9e806TDY1Ep+FrrywUMsC98qDIeIGud7q7E655Gic9q8HKM5A3SjknzcZKtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lzcBu9SQ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lzcBu9SQ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACC751D31;
	Thu, 20 Aug 2026 08:31:46 -0700 (PDT)
Received: from fedora (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF8B23FA21;
	Thu, 20 Aug 2026 08:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787239910; bh=bX4F8fbDYk1pMbaaFVuC2gJZ7gdHty9FAL8pUarXuzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lzcBu9SQy9TZ6ND+cKlpT43akt6y9WiKmwjCcDTgN/Oepz1s/WxsenuJOuMFDkmSE
	 W3CamJM5cGjeE1jn1H9HsJryRCJ/rB8EU9MvGK96nHumEQirfF2xHBsuVQvBeOD3uj
	 GnJF2yWUGbEM1ZsWlmVU3otwtYaOtGlSLucqnf9s=
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
Subject: [PATCH v3 2/5] selftests/x86: fix fork bug
Date: Tue, 18 Aug 2026 17:54:25 -0500
Message-ID: <20260818225428.1983328-3-bill.roberts@arm.com>
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

Shashiko correctly pointed out this fork bug, the report is below. This
patch fixes it by checking for the child and error conditions
explicitly.

[ ... ]
> +int test_ptrace(void)
> +{
> +     unsigned long saved_ssp, ssp = 0;
> +     struct sigaction sa = {};
> +     struct iovec iov;
> +     int status;
> +     int pid;
> +
> +     iov.iov_base = &ssp;
> +     iov.iov_len = sizeof(ssp);
> +
> +     pid = fork();
> +     if (!pid) {

[Severity: High]
This is a pre-existing issue, but could this code broadcast SIGKILL to
all user processes if fork() fails?

If fork() returns -1 due to resource limits, execution will proceed with
pid = -1. When ptrace() subsequently fails, the error path is triggered:

out_kill:
        kill(pid, SIGKILL);
        return 1;

Since pid is -1, POSIX specifies that this will kill all processes the
current user has permission to terminate, potentially crashing the host
environment.

Signed-off-by: Bill Roberts <bill.roberts@arm.com>
---
 tools/testing/selftests/x86/test_shadow_stack.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/x86/test_shadow_stack.c b/tools/testing/selftests/x86/test_shadow_stack.c
index 3d6ca33edba4..b52c5420c137 100644
--- a/tools/testing/selftests/x86/test_shadow_stack.c
+++ b/tools/testing/selftests/x86/test_shadow_stack.c
@@ -971,6 +971,11 @@ int test_ptrace(void)
 	iov.iov_len = sizeof(ssp);
 
 	pid = fork();
+	if (pid < 0) {
+		printf("[FAIL]\tFork failed for %s\n", __func__);
+		return 1;
+	}
+
 	if (!pid) {
 		ssp = get_ssp();
 
-- 
2.55.0

