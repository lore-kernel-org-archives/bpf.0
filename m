Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975311;
	b=Ay5TmSG9+rU/LL7/SwHza3VFMVZrS1wDPshGXMpVa1XRrkHD33tVVuANR023MgXSU+Vm
	 kLpceISJ7lVUp5yWPx1SqvfWNbh4evSQdiBsw0t4IzNJcjHJpFWuQWegihVFT1bSJgy4V
	 FffNU1OqdsVSY9kFn3TwUTpO/C9F5xbkvjdRnxLVKowxPYbHU3TdMe4DDCqj23OmJFaCx
	 z00kwEtwody4b5tGrPfjVfz45tvJvLU9cs5s57Nuqzfzd7MInIzT8I8A2fsC2g2hGBWrs
	 E5unmeRt6aBZU0vg9CoIcDaxCHuTMJBsva0xVsm5+cmdQd2qsPHwLG4LHlHx21mzrBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975311;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Xi81y1XZW609wk/sWs6sIq2iQGR+N/bC4UAGbPKuq4A=;
	b=QiDo7j7oJ/YCXn7IQ4XcPrK9FZr3he2Vq+Lik2NoHR0vt3565gTub75JoyRVVI4BLwhy
	 B7WCcwVHm7t9qp3+twKUexdsHRv5qxGSqQjnNvaLiXDFIXvDPjwuV29XXGCC43D5yMsZf
	 OeEb8hBt0u/WDYvNKKpmID9E95tZx2SFitR9BLQ4zUZyt9QEew6/Z1VmKHAoRyLMl5Wbs
	 g/JOrybxccbCouK/a2ioCx4HqGtEJLhrlTKBzZUwkyfK+YTg1R8ebKWcKvOmxWyg2KsLa
	 4apscwuh6RDMt/jJvv+FHkv8XIRDoUWFTLZ1id3OouNIasY07izlkJxFUH6a2N8ca3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nNYKqIju;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20C3606A32E
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 14:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B20C3606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nNYKqIju
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdb681db419so241395a12.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 06:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793975310; x=1794580110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xi81y1XZW609wk/sWs6sIq2iQGR+N/bC4UAGbPKuq4A=;
        b=nNYKqIjuEjYDx86pC7gLB0wWbCMP9LeWFfMYAVHzNUuU/cQ05fgm3jn6d3knZMEAkl
         6NeW6BaecfNO0mrlQFVYHb2m8dLyginJlZRTPDeWO/3W7JSr6GW6dJzXIAei90z5+J6e
         wLcCS701vrX7XfCit1mIWsChOnsLt+tHikk+Q6H74y38mcnbwavdihXJC/hHGxsIzmIq
         Ubr5W59mPIf3aszrbISHaFrfuTBna8uTy/N7xhWyKhCA1D0U4WDHqGuPOQY5dN19rFC6
         wI1WoDriOvIRhlvKhVkjOAYVeuO2qENksJtYhO9JWB5ashZE6mUENfRa0VMER/Tj0pmp
         gx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793975310; x=1794580110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xi81y1XZW609wk/sWs6sIq2iQGR+N/bC4UAGbPKuq4A=;
        b=jr7hCpykyq9RwMOnGRnoTnKmsakkmRS1nt9ArndaDlgU0HkOBIEalNxv1exABizKU+
         2c9WEaMaKYrFUdcEk3l9Ry/wjbWFnklua90nIMgDceZGy9uFwtFBC5uUfCTUH+nGBd05
         dus3bMuwsuL1R6tZixk8CVl6vgLGTAJELVRpJfqcsgsjsLfoHrhoSTROG7b0IpRLE+Sv
         xDBPz/frg3esPCLfIihBUdQqSqi9CxBCqZouaGO7HdvsveW4L8MK13n00kd12L2drrkL
         I/GT5puv2rnMxwquUQeoYwG5vtQRyskI0y3UcAAAF15LF8n3+zw05kLdPU/IVb8vB31g
         OXcg==
X-Forwarded-Encrypted: i=1; AKwUvBwkoY3jLHyjNCOJ2+ZWY+PJV7V1zQ5Nj6rgE+YMTyXlOxhn+RWZp8g213wOXQCwMzys3IY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6jgspOoYWS05sWUKa+9Z4YQS9uCMAV4jpFA24z6KbAwaPeHYH
	Q/cuYYyFhmU0GitHmvVYe+P3SIv3S630g1Is2u4Nd8BDKfL2954yKm2I
X-Gm-Gg: AYBFou3Qnr2+LWRnbWdiKWha2a0E1vdLzjapVTxp3LVy8bL3UyuCZh16DJF1Y7l7lHI
	7Wp7PAkSMvk4xUbIlCJfd+GNhdoRNtD6Dcdaln+c8er5vSklQbyN8fka6ThOFR8REdckWwrL1JW
	MV55DxgLVM7mfQIRoObo5p4ilW2fEcaw4yVXHfSgBpip9yoHnfwrzm78y+Q0TzKP3thFCA3odYw
	N7x0lQhU+4BLVrXtZTdWjIY2fGyB62QTjYnBoBeTWJEmaClMjUZspNnW0r9SW63jSF3EX5eWtRH
	xOBnZcr54TbXwel7nZE891WuA++BnPgZ6QF0/o7G10XEj6RGcsG/SThsqVCI4ma1wo5IltaiyEv
	kSd/y3OGouseC+UoaDNMsZo9SPVguxXxiehM3zUkPpNuCGMiMgGgGCnyG/ufxEI43m6JwNnLMw0
	qTFxgMtpv6rA1OZKqHNUwuZRy7ocPF0esp8juC5SaJA6YsCyCr18ZgnKTa/piJTokPngMrqZhzz
	lRr0gn/8ZyxpY+/OL1qjlzXjdS+YOHwXI2AYaq5XFZ1sfVyU8HbyL1i9rbci6g5AKtDVMMwCqZ4
	a6jXGKLupVohrl6ZUvRFteQePrfvq1zOe2Y4as9nhqyFBx3tJQsH
X-Received: by 2002:a05:6a21:4ead:b0:3de:2fbc:c391 with SMTP id adf61e73a8af0-3eb9830cb5cmr4470055637.7.1793975309829;
        Fri, 06 Nov 2026 06:28:29 -0800 (PST)
Received: from DESKTOP-31QBR7C ([103.120.166.86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb70aa6878sm634384a12.28.2026.11.06.06.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 06:28:29 -0800 (PST)
From: Rahad Bhuiya <rahadbhuiya2021@gmail.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Rahad Bhuiya <rahadbhuiya2021@gmail.com>
Subject: [PATCH bpf-next] sched_ext: Reset task fields on exit of an SCX_TASK_READY task
Date: Fri,  6 Nov 2026 20:28:18 +0600
Message-ID: <20261106142818.1475-1-rahadbhuiya2021@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
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

Commit a298fd5f4ee8 ("sched_ext: Fix use-after-free of a NONE rescuee
leaving its sched while running") moved the reset of SCX-managed fields
out of scx_disable_task() into scx_reset_task_fields() so that it can be
invoked on every path where a task leaves its scheduler's control,
including tasks in SCX_TASK_NONE.

However, in __scx_disable_and_exit_task(), an exiting task in state
SCX_TASK_READY (e.g., a forked task that was initialized via
ops.init_task() but never enabled under an ext_sched_class before exiting,
or a disabled task) currently breaks out of the state switch without
calling scx_reset_task_fields().

Consequently, its managed fields (vtime, slice, reenqueue flags, and
watchdog runnable_at reset) are not reset, violating the invariant that a
task leaving its scheduler's control starts clean.

Call scx_reset_task_fields() in the SCX_TASK_READY case of
__scx_disable_and_exit_task() to ensure consistent cleanup across all exit
paths.

Fixes: a298fd5f4ee8 ("sched_ext: Fix use-after-free of a NONE rescuee leaving its sched while running")
Signed-off-by: Rahad Bhuiya <rahadbhuiya2021@gmail.com>
---
 kernel/sched/ext/ext.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index f74ffb3b1aca..b57a7989f304 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4728,6 +4728,7 @@ void __scx_disable_and_exit_task(struct scx_sched *sch, struct task_struct *p)
 		args.cancelled = true;
 		break;
 	case SCX_TASK_READY:
+		scx_reset_task_fields(task_rq(p), p);
 		break;
 	case SCX_TASK_ENABLED:
 		scx_disable_task(sch, p);
-- 
2.55.0.windows.3

