Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911674;
	b=yLI/ubAwzDdAW+WrZ5vARQlHYTs6oODTDSwFQ2qQo4Guh7GiiwlLmcasIVD6ks2CKuSD
	 +jv+9WQEkvp9BkL6yh7bqWZFzCp9iv6VbbiIOAKtKRd76WK0pTg1Suen/nNyyHcfaWDhR
	 i4H2TKoLe00NO0zVy0vHxvh8dm/93GWCL4cN9WtkR+BQPpfuDa/iFgXAvVtCQt/FnA+HR
	 ovWiIxTP5ao8RucPZAFHUt6T7KaIkxvEdC2SYhjC0HymI7XN2MKc2mHG46U+jKoXUeO11
	 sFbH5++1DpwcP05oBO9WdMBd4n9Tnzj/ViZLFkDVDldHm6gxstVgo/KJTiAOd/Y394A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911674;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0jaKc4f8rKfsWdTY9CvwawCD8sMoYbS/IYHBnjDqo9k=;
	b=e7aqnBBl5KLZMsc9H9fvXM7a+2mSCZlc0ukV6TGVhyWC3k83mmwLohsSLXADgZvF5BeR
	 vFOAaRikVHIErS762iXaG55ncGtDRlguLWAIpIC0NzIHLSiZ0r2wKosOEQEYE7d44Smpj
	 Z3odjrpC2HI2gLKWT4f6bb81dyiZ9RisFOL/wnnW0Jr16uX5hiDR7qyja0DnXrt5+gWNY
	 IbXryPKTOdzbYBTQiTCBlagfpmZaZCw689CE5tKNVJzHQGqk8C5BmgWXeGx5gM3Z3B61Q
	 MjM0aBzhYEHMXZ9yqGMYte8IJ0+qoClfS88x03Hu/tULwvhrid0nQbgXLkVuilTXoeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=gmail.com;
	spf=pass smtp.mailfrom=runbox.com;
	dkim=pass header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=cKu9ER1W;
	arc=none smtp.remote-ip=185.226.149.38
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6E2606A339;
	Tue, 17 Nov 2026 10:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F6E2606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=cKu9ER1W
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xTGW8-002Lk4-SX; Tue, 17 Nov 2026 11:34:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=0jaKc4f8rKfsWdTY9CvwawCD8sMoYbS/IYHBnjDqo9k=; b=cKu9ER1WzeKRhwJK7eulD7MJeV
	d8gghixBOLJfFgCoB/Je5DgfcbG5JRXTz8zM5GucTB/SUf5xyFX8BFuR/b3yvS3QPMz7QfVYV7iCs
	Brpa6QfyBMNrDFa33MWlCrQc1tXAxsXI7bdI7E9JhpBgvuSY3zzVgYv9OM7yhmr3tT9YNE5E1v88L
	vb+WnDjMN/E286HvFpE5gNt7x9VOQhZ2T4qFjQb48x90kz+KCzS7w0s8qDcmjMmeEpNSFoofZmFV6
	BCO34QHziHEh7KpZ5SeaCqaFrF6soaifG4oCKToo15nTdTHOLiV1P950Cb09iFMb53AQ0XNk/jcT5
	kOXY3Dfw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xTGW3-0002FH-H7; Tue, 17 Nov 2026 11:34:19 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xTGVm-005qHU-MW;
	Tue, 17 Nov 2026 11:34:02 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Petr Mladek <pmladek@suse.com>,
	Kees Cook <kees@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Samuel Wu <wusamuel@google.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 next 05/13] kallsyms: Fix selftest startup delay
Date: Tue, 17 Nov 2026 10:33:44 +0000
Message-Id: <20261117103352.1244657-6-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261117103352.1244657-1-david.laight.linux@gmail.com>
References: <20261117103352.1244657-1-david.laight.linux@gmail.com>
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

Unchanged, was patch 2 in v2.

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

