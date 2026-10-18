Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019443B47DF;
	Sun, 18 Oct 2026 15:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792338796; cv=none; b=D/jeiw7vrMHVsnim4SUhpsTBbGefiwcMFyNwL/AgAsOZVp5U/uaJ2e+8/I4eATdiBAFRnkTAGJPPPxfBQZwj+WehYq3tDdHiWgcWsriRwk72/h58PsgOMj2ut7RXLp9/m3SFqPrlomRw3Xirqg+5DHwPI9VDe+AdHfK/D4NZk18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792338796; c=relaxed/simple;
	bh=cMgcfn3oTkv/gWCcsXjtVKkuw5VWqPBnSyFIfd6VkJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OP8PmtTsLUtjxZx9jOTuUMxjlG9JAF0AN0bgEnb0K0nLFWfT2egGfljgdDh2Y2xnmF6Cq3Yw9bd7uPJRKrmttYaTJ7N176kNeqoawSwTGjr5C/CvpQSKhrHy4gcwek/0STlFktfd6/i6/hqjedVKw5m1gVOnuwDf62aJjrEisaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=dlfEY2yN; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="dlfEY2yN"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xITC6-000Ie5-4A; Sun, 18 Oct 2026 17:53:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=B9MBdm+AgkGYtGtq0kSFNXCbjbM2d9Z8MTSHpsIlcnY=; b=dlfEY2yNYR0ZJ60LmuefLyAPw0
	Ey5frvAZTDILyoNvsjX6ulMvL9TX1xBwIPN6VUm8SaLGk2ifwN31II5Tmj304SPBQeAFyDCChSZ51
	noHE9CJdMictDpWo/LoKXbqS70kQ+J71/aQnlZyOMRBUgovxyNCEcL4hqMB3qWt1SLlxrz4HxrMCH
	NjHssa+Ct35C/y0h1BHfh8usWXXHz83ibblT763kisySuF6Qw9kvaF/I4iyKAMo1aUzLlvVwSMyqQ
	o+z+b16aYjCfAdbfNcQB0mX8IA3XRnVwMFAWdk3LB1ev7netVW5VOrVBSM3Pda7n2hcFVm4Ws6nP8
	0aSC6odA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xITC0-0000Bs-Kk; Sun, 18 Oct 2026 17:53:00 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xITBe-004q3U-HJ;
	Sun, 18 Oct 2026 17:52:38 +0200
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Kees Cook <kees@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 next 02/15] kallsyms: Fix selftest startup delay
Date: Sun, 18 Oct 2026 16:51:53 +0100
Message-Id: <20261018155206.132411-3-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261018155206.132411-1-david.laight.linux@gmail.com>
References: <20261018155206.132411-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kallsym_selftest code clearly intends to sleep until initialisation
is complete in order to get more reproducable timings.

Replace the schedule_timeout() calls with schedule_timeout_idle()
so that the thread actually sleeps.
Poll every second (not every 5) for SYSTEM_RUNNING and then wait
another 10 seconds before starting the tests, otherwise the tests
start as soon an init is executed.

This code is in the initial 2022 import of the tests.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 kernel/kallsyms_selftest.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/kallsyms_selftest.c b/kernel/kallsyms_selftest.c
index 8f6c4e9b3a1c..0db79237fe54 100644
--- a/kernel/kallsyms_selftest.c
+++ b/kernel/kallsyms_selftest.c
@@ -411,9 +411,11 @@ static int test_entry(void *p)
 {
 	int ret;
 
+	pr_info("waiting\n");
 	do {
-		schedule_timeout(5 * HZ);
+		schedule_timeout_idle(HZ);
 	} while (system_state != SYSTEM_RUNNING);
+	schedule_timeout_idle(10 * HZ);
 
 	pr_info("start\n");
 	ret = test_kallsyms_basic_function();
-- 
2.39.5

