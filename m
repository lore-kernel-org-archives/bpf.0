Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F654AE8C1;
	Tue, 15 Sep 2026 19:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789500450; cv=none; b=G3S7MhjIil7DINT0gIpl1HD9450H8whJzogdqmp002LSUFH3KtVje+VGZc9X3oWKSp4qwNAssSFaPfNh1Tt+X5nMUdW/FnuPeyKfodE4YMkvYh8NZCI/BDv7k1764WpIhvfO9ZlwHylf54z8OB8P63biUQtKuMBWZkcKmNU0yL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789500450; c=relaxed/simple;
	bh=bX4F8fbDYk1pMbaaFVuC2gJZ7gdHty9FAL8pUarXuzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYXIXGlDTgnt2n0rCn0u9J2ktjzG/8yv2nWZ2XSBgQAT+qqPI19EXjsbPBCjnTUC/32X5SPb1HvlRa6trP58TZQR77IhMagyg3HBYzuEm8wjOOSPvPHt+dW7eXiONuTWMOidPYb36kXCHho79jZhZAHvhpoMgRQ+sW/mXR8+BgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=r5y1CCgD; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="r5y1CCgD"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6363D153B;
	Tue, 15 Sep 2026 12:27:24 -0700 (PDT)
Received: from fedora (LJ9QCPV96V.austin.arm.com [10.118.150.127])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E2A93FBCB;
	Tue, 15 Sep 2026 12:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789500448; bh=bX4F8fbDYk1pMbaaFVuC2gJZ7gdHty9FAL8pUarXuzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r5y1CCgDF3QYx7o4gAZLmQCqAc3JpofmCEbeW/4ZmyyyQ1t0OHdB+dPc3eJbqoCme
	 d7Q0Y0Qo5BoZXL8ZF+IEGQg2RkjGPlBwUwpVrLoNmW2vuDgp/CKmDrkTofFgoaakwv
	 vgbkmfE/cqQE0G2N2raxxqsEFKoAhMBVCfXlt+iA=
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
Subject: [PATCH v4 2/6] selftests/x86: fix fork bug
Date: Wed, 16 Sep 2026 04:52:20 -0500
Message-ID: <20260916095224.1533971-3-bill.roberts@arm.com>
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

