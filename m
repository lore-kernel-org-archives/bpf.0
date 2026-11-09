Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248883;
	b=1Bkha9vbn1+y+qmud6fGo9N6vul0sQqpTpBttnEYGsG+p+0kSLpSthbR8LNZlAd6vZs+
	 Ou+MoYAEiBN5POyqhCR30ZsvNyQzrONFHvJONRMBTcs+DjdeP1Zy5nRwBK+fXApT+gIEX
	 o/qjE7uRd+CgwQXK+ltFk/rXEUI9BL07FlM+BpvzUCKeu4g34kA4RfrEoAeTFRkRK6mAw
	 xFgwuqbB//PuN621uEIs45pE3h153+kvDv9WiUUqy9fJkVBDNvbavHHHhRa7ssHO610ix
	 4CFQL/J8gR5x2s3OKG6J5sKuQIBRfl7zdr7WMps12Q9UNPdKVJ8Qhnl7Q5SwnvkxFeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248883;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wz7Jp+PexIzTFHlXctkjuIdtWFHAXhZSXbPSBDeuIFk=;
	b=U9QLj6j4eXB3lirn/xEc/6i2wrGnSvHFuSC+3bALZgVf+gJZJ3QO5xe3WPCvza0tVqT4
	 YAvcalS6qRko58tXUDBWuc4tmQyEY5cCbTpy2w6GkT7+HYfBwxsxVXooZ4v2fwpK2P4Ze
	 WHz9odKYADBJ01aYfSrJCaclM8dJ7r+r3BPQk2Ploxrg9QIIC0HzN+1b4SlAtGbyUUBnv
	 KcknLa8fmclfb0k8e/l9FWChpj+CTDPw0yhP5mFpsgZ4ZPzhbDqZEOe/5WYyrmIwELBQZ
	 SpkfFzoChemH3hktzINglyEZnTxVUhDaXCZuBew71vrHVcnm9rMc+iaM+WLM/BG92Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=lF9KVjBi;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2F9606CC7F;
	Mon,  9 Nov 2026 18:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A2F9606CC7F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=lF9KVjBi
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B54A91682;
	Mon,  9 Nov 2026 10:27:57 -0800 (PST)
Received: from fedora (LJ9QCPV96V.austin.arm.com [10.118.150.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B5CE3F85F;
	Mon,  9 Nov 2026 10:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794248880; bh=AWhF8xfjFL5cvpPKw3tBPfCt67J602WNRROlhEqIn9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lF9KVjBiaGyK0O/yUZWxgoVclBjZ5BmPS1qav4KFT6u7+RVm/6X33XSdYC5pkCcps
	 h9IXfCi3xSRsObHIL6tzpmE1PLbZJgebO8onMhNQ2dNcUoriChX5sELRMV9C8CptrY
	 GQuYrTyWmHXoMil89hpvwclSX3kvO3cY0gG1+ur0=
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
Subject: [PATCH v5 2/6] selftests/x86: fix fork bug
Date: Mon,  9 Nov 2026 12:27:54 -0600
Message-ID: <20261109182758.252223-3-bill.roberts@arm.com>
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

The shadow stack ptrace test does not check whether fork() fails
before proceeding with the parent-side ptrace operations.

If fork() fails, it returns -1, which is subsequently passed to
kill() on the test's error path. Calling kill(-1, SIGKILL) sends
SIGKILL to every process the caller has permission to signal,
potentially terminating unrelated processes.

Check for fork() failure immediately and return an error before
entering the ptrace test's parent-side logic.

Shashiko pointed out this fork bug, and the relevant snippets from the
report are below:

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

