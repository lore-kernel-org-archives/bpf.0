Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394898;
	b=2KMswCyemlCQHEuh/NIdO8hhsVUWk7Xg2E+7JPMlpNIFaRuCjLbsFEzLErQJwIbWgC7C
	 mF3pgM7+N31oG6aHMOffdQCZ4A/UIpOZlB3rZdoqEjY4lqULqihyp7aHs9Sy8kTQr2WQs
	 x9khMuQ8agfjpO0KqTqBhjelbkxx++c5owMFaamGJUeS4gPqj1uL6dv5oWI63kuGqABYb
	 4RN5VXGstNghZ8PVTQ7Ji3XwJR3Z6tC0soROMo8lwMDBEJgJhrw7J+mKbf1xFdcHFBA7C
	 WBEx2/w/QSIbHLzhzuKwT/suHEJcRNQEF/ffLRcrQgYdYlKHaticqQb9aPhOG6k1sUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394898;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=rTShxCozmhSSeMWa7fG8X0mBP0JSHd6Gbx0iKXmpMcg=;
	b=VNE4f/I3nELDGQgT9h09169Go6hNQXaJfA3n2xztou2lJH8AFv1AzUE0e1qle/pFntWo
	 eBqo/N4zxKgEDI63IRCgwp3ByjmKf4a+gEQ/cPcgYSg2b4+X1m4Fm55wrAhBcjgRoNRjf
	 cfHqTlNkkbf17amn2pLiavdeHu1amOqrDo2jqwUo0IH5M4vteV31HxZQqzo10Uo3tlVr5
	 TADj/vcLiCms7R5e0dfS4GyHOvuoeM4iqNCk+kbXIFmi6Qh2ihzYB1IKi55Ds7yHbnbun
	 pWdpOkWds1HNg7fcKV9MCmcoARlF+jFsY/DDrs4BWbn7F+0NeRgq2RBlxt6TNJdKyjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K93qHA99;
	arc=none smtp.remote-ip=74.125.224.136
Received: from mail-yx2-f8.google.com (mail-yx2-f8.google.com [74.125.224.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2103F60A260B
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 21:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2103F60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K93qHA99
Received: by mail-yx2-f8.google.com with SMTP id 00721157ae682-8b0c81dcf98so4033097b3.1
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 14:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793394897; x=1793999697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rTShxCozmhSSeMWa7fG8X0mBP0JSHd6Gbx0iKXmpMcg=;
        b=K93qHA99T0Dmy3B5qb8JERE3q0KWUF+pIIzE67Eu648G8sUPcTJImR9GFZtAyIl8mY
         Ra9hX/nBsMI0l8V5qJqwHpiNTUVBehbBOmhZ4VhLmrKvpQzMCaS6GH2ScRguY8MWXhIM
         8jfx9nJH3JmH0OB1ml8knE+uuUZM7gcBDJYXbLXacOBn+p81EDj4x3P2ODeE4LWFVPxo
         UwWBo9+YKoAoJHJC5DpcNIZTt918Z7vDmCL7JzoiBHR40OI19SxeFwl2RvQhmWuhxZzb
         i4/PKEFQa4EiPJtF6v79fW8VE2a8XEwVIRFhhMzQT7P+imgEOcOoUDy+72U0jkk57DxP
         QUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394897; x=1793999697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rTShxCozmhSSeMWa7fG8X0mBP0JSHd6Gbx0iKXmpMcg=;
        b=AjD5lHxH6DVS4xxJP52IyZcBfjFwdEjtH01rWRKuvFKQftJW+mOl1jarYtjSWFkFca
         j+9qYhbomoFTSCsIgLxRik0XBZVzaXRgFnUGK5Mj8PWIGzSVaGmPug8UXeQU5mwk4m/q
         Pvom337VtIDJW6oPHWo6wmI+2/25lcpjoG9hXKLpk/suKz/8h6K7Y0nJK0ibVizOIp7N
         v4XM4mqfdUn0SVuzGDdKmYyiEPZ+vTewIv6v4tX56NkZe3sldkqeVILPw5/sk1uC4nYE
         JwiRu1ep3gX4ANt6M9P1KATiW1xdaI1fKLDykCLXgj1RT5NeevVzQuAGCi30+W1brYHQ
         IbGw==
X-Gm-Message-State: AFq9FYLdi/+zhpy2BqElkqs+YdhWtKbyEZG4GEV3CB5/vH8zFLwRTKfL
	1Ul8W/zfXIg+G//53RfeHTFuhjr4o1sZ1otdQrcU7YRYh/UKyRPkbh/UIS2j9297
X-Gm-Gg: AYBFou05Y35f4TRfCSpyLIYV0A+BBoRGE7CuhqRV7pOA2GQ5eroB9NC8TjGOD6B1Bqw
	m0aMtNGA3xBHFAtS5JbpmHunBTPH08ysiTgk384xl1P2tIG6m8tizO5m5NWpwVnlUrrEHJ2s2Kx
	X5E/n3WQavm3kEBYdpqSW8NbchQll84ye+GCO5dnrwOH/ja0Gbv5EpUcBMBsJ8KBh7FPaM1kVeS
	euZjAWpn5+sli2yIZIoCnLoXn0ptIc8cAjsJQae4BLUZlrLyjaok2nh53HbknX0+pLLfcFGXsH1
	I6mc82bNtzecC54B+jYEQfpUH6hfgtsglkJiqIzC8C84yOtfODztIYt9SFvCJB79/tmIeFIP2cM
	3sXecRfB03h6RR0AhuLBYQkoxZ6mky3sziKjiKNFf2kxMEhUheU08ZCgEaO/zAPTsKiBNX1/Q/a
	QwBVALufKJTjuTiJ9jjp1MVoIbetsCwHB84sUMsu/AWKXYjh0JtA10yzIUUfS+e24/I7n4WJ6Zj
	LXq+cT+td3VTacaWHr42HMiD6UNmQfyerjKnq89zVzm+XVaQAVZqIQnOBNUMdG4pRYj2nCZdh7G
	gEg71bVq3De0Y7wTQrdVOTJyto/LD7LJ0z8c4gJnw0PIh61tcvQ/NwuAnD5H7QU2Vmpgr2VI3OU
	VMb8YMDVj6w8rQkt8fjKsl53AtBHYYSDyZxD9
X-Received: by 2002:a05:690c:a0a7:10b0:8a8:6fac:21af with SMTP id 00721157ae682-8b2b66e2087mr22437777b3.12.1793394896955;
        Fri, 30 Oct 2026 14:14:56 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:15::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b7125371sm14420067b3.11.2026.10.30.14.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:14:55 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1] selftests/bpf: Cap the CPUs taking part in the rqspinlock stress test
Date: Fri, 30 Oct 2026 22:14:54 +0100
Message-ID: <7fb2cf7baeb262c7486b8e9b5204e2a159402608.1793394762.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4177; h=from:subject:message-id; bh=002onRIw0vfydK3FXaz7B61j8F5yvS3kYorQfUHPMcw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIesph9fvr5mfqnfpZtySCrmWleOwTtPj0UynuFlqH7JZJm/f pSTdUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIk4HGb4H8wybcdNH+9b55I2/d9a6W Jyzeuuw5pH/wK0pKcLz/q02ZuRYbPo+a9CJfuLSlVncX4X2nv005X7YR69u525TuScLU66ygwA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The stress test module starts a worker on every online CPU, and each one
holds its lock for 20ms with interrupts disabled before releasing it and
queueing again at once. A waiter that is not at the head of the queue has
no timeout, so the queue holds every worker but the holder, and the last
one in line waits for all of them: the longest wait, spent with interrupts
off, grows linearly with the number of CPUs. On a 4 CPU VM that is 40ms,
on a 128 CPU VM it is 2.5s, and the NMI handlers of the test spend the
same time in the queue:

  INFO: NMI handler (perf_event_nmi_handler) took too long to run: 2560.853 msecs
  perf: interrupt took too long (33533733 > 25008210), lowering kernel.perf_event_max_sample_rate to 1000
  tsc: Marking TSC unstable due to clocksource watchdog

Enabling the perf events alone takes over a minute, as each IPI waits for
its CPU to reenable interrupts, and the test takes 145s instead of 10s.
Once the host is oversubscribed, the waits stretch further, timers run
late, and the soft lockup detector fires, which panics the VM with
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=1 from the selftests config:

  WARNING: kernel/time/hrtimer.c:1098 at hrtimer_forward+0x76/0xc0, CPU#6: rqsl_w/6/1185
  watchdog: BUG: soft lockup - CPU#25 stuck for 21s! [kworker/R-mm_pe:13]

Andrii reports that the test panics his 128 vCPU VM every time, while the
same kernel and module pass with 8 vCPUs.

Limit the test to the first 8 CPUs by default, which bounds the longest
wait to 120ms with the default critical section length. A new max_cpus
module parameter overrides the limit, and 0 restores the old behavior of
using every online CPU. The worker threads and the perf events are both
created for the capped set of CPUs, and teardown walks the threads by
index instead of by online CPU so that it covers the same set.

Fixes: 15cf39221e89 ("selftests/bpf: Add stress test for rqspinlock in NMI")
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/test_kmods/bpf_test_rqspinlock.c      | 21 ++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.c b/tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.c
index 7b4ae5e81d32..a9cc5f496f46 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_test_rqspinlock.c
@@ -68,6 +68,11 @@ module_param(nmi_delay, int, 0644);
 MODULE_PARM_DESC(nmi_delay,
 		 "rqspinlock critical section length for NMI context (10ms default)");
 
+static int max_cpus = 8;
+module_param(max_cpus, int, 0444);
+MODULE_PARM_DESC(max_cpus,
+		 "maximum number of CPUs taking part in the test, 0 for all online CPUs (8 default)");
+
 static struct perf_event **rqsl_evts;
 static int rqsl_nevts;
 
@@ -216,7 +221,7 @@ static void free_rqsl_threads(void)
 	int i;
 
 	if (rqsl_threads) {
-		for_each_online_cpu(i) {
+		for (i = 0; i < rqsl_nthreads; i++) {
 			if (rqsl_threads[i])
 				kthread_stop(rqsl_threads[i]);
 		}
@@ -247,7 +252,17 @@ static int bpf_test_rqspinlock_init(void)
 		return -EINVAL;
 	}
 
-	pr_err("Mode = %s\n", rqsl_mode_names[test_mode]);
+	/*
+	 * Every worker holds its lock for normal_delay ms with interrupts
+	 * disabled, and a queued waiter does not time out until it reaches the
+	 * head of the queue, so the longest wait, spent with interrupts off,
+	 * grows with the number of contending CPUs. Limit the test to the first
+	 * max_cpus CPUs to keep it bounded on large machines.
+	 */
+	if (max_cpus > 0)
+		ncpus = min(ncpus, max_cpus);
+
+	pr_err("Mode = %s, CPUs = %d\n", rqsl_mode_names[test_mode], ncpus);
 
 	if (ncpus < test_mode + 2)
 		return -ENOTSUPP;
@@ -279,7 +294,7 @@ static int bpf_test_rqspinlock_init(void)
 	}
 	rqsl_nthreads = ncpus;
 
-	for_each_online_cpu(i) {
+	for (i = 0; i < ncpus; i++) {
 		struct task_struct *t;
 
 		t = kthread_create(rqspinlock_worker_fn, NULL, "rqsl_w/%d", i);

base-commit: b116ac6087541d3d98031e786adbe9c733cd6df3
-- 
2.53.0-Meta

