Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2483D649F
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 10:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779792245; cv=none; b=LcnKV9Hd8zg9GZ+ioWgoiaj/iwGuSJE4mtmTVSpd1zvE9gMGxY/X7Lu+nZZHmMhCmbN2wQSRVYRwZ1KmclCORQ25miSugxMc5JlEz2XA18ivBesgjpWxg4VkD37e/St0rX+WTFrqcFrQ5Bu9vLOTl9KjIrVuk1vxwIgKask2Vsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779792245; c=relaxed/simple;
	bh=HsOr8rpplJjgS7Av7/K41Jv793JfILZijFQlo8B/bws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uXrNwnhr9oxrO3xf+QiiLGeE+gSo+hBEV7Ui61ufkLcC96DSZboudeP5+AudfQzH2AKZmkhjygZPvl5anLcPfAMQ+qGtV6JrGe06nuTbExmzoaNlz4atTrr4NaVpbI7RIhIiw2uaNN+X2cPo+AIQBapgrG435EgqRtcmcHqiLw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJ1aoNQV; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJ1aoNQV"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-83537a80ab6so7242690b3a.1
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 03:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779792243; x=1780397043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0woIQHOIcIhPQzNkOpwE+A4HIJ4EcK8YFk4nOva52aE=;
        b=OJ1aoNQVqzQF6siB4fYX9SI6yBYbVgGw/iR33y06CYsRABLEhZWFI5940eaNCjXW7A
         aXzOC+Ce18+xfxW52sw11RtbDpBtFkq2+IAV5649yXE/Ys0W69I3hYvw5SMjS3yLgWtH
         srKwaEqC8MrTBLu2vMXW8u4+W8wLAUyESER1jCYFdweKiDagonxfxj/lB5apJBPRasbx
         lRQExOIH2RODBgwdoToqpQt5rqSux14FrwXsCO/CCDPAU0LkFuWCdH1Y0wUhq7dqrp2J
         2MFS7kQBo/AHvN6CvSrg4Fmoa/Y0ZU9gkCrfzLiNAzWW/OG1kYhjDThAUFe7l98WDQzt
         rOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779792243; x=1780397043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0woIQHOIcIhPQzNkOpwE+A4HIJ4EcK8YFk4nOva52aE=;
        b=dVfiaWviHmxYMiNR+rnvw6fYvrugPBC2pjRtdN7Zlaib8PL/Ptwp8tp6AXYTWLhyuj
         fhZDLJU4ocrOiGsAy8/Mq8g+oHeaVerHPMw3lteLKEaVy+hIUknUH4Ua8P3bNydw9Ebb
         o1ulIVgCRgQ2ev5N4mx/jZfyIdDbO6Fux5lykKg+RLjsqoT0R+OE9u6zJybadi8UVJgS
         TDOVXx57a4iyShEyMt0LWKoAS3zCzeQywl49EutL4PJvbaBLpiBC9/s48pvz64C3qsGe
         jb4H2cJJk1eh7S0rMmvMerxs7nsae1D2HrTzdH7hesgyJgq/7q6vaKp3qKBkDZDXwzyb
         Y9Qg==
X-Gm-Message-State: AOJu0YybwJgh/kKms5DBJJgiHUAm8+c6aRi5X3CUvEAvdBEczrp0Mu9m
	ENDW9iwKG6+2yiHPvO4H+ykhhutzYdcQiPp80lCVZ9cKGGPPaGhk0WM6
X-Gm-Gg: Acq92OFwj+5Pe7nfUtP7OqBXnkF43nLUkk7A4c8HqViswY+lwA5NgDFSYAB8gSPXO9D
	U8+ESJIgM1RN2nFB6M2cz2ATXhye0vrOrX0z0DlcC2SsMHnBMbdM4WXDX7CLvnyN8k5i6A7ypYw
	UwIHbyK2jxHmKTHol0qoFknH6mTJqbJfpJx9NQ7m02Ox/eSlImhIqBSA3n2S/yxCUfQDC+oZBF3
	H7O77Pb+ceOPsG4qd9JayTE2Q6UWlzENYH5ZeJ2mwRN9PjZ7HnOCs16e7WJbE3dGWpXiQjO0QUd
	8VlryLRlAKu6jFcK8p1Fwri4FN6zGnWvaLPWC42pxhNYL23rvOesi7nX6oB7GPKWRiR8jn8tBGe
	IcqvPOFNgINZGBtdvBCRgP4yTdVsG5VwxH5AfXhjKTsFlxn2bqv68IwtMFWtLk9sGnH2PkR45dg
	NMSI6copSghUeQU9j/87iRzpVGkoglAylZe0k48Kh0sv/anFud4INq1WndeK9C
X-Received: by 2002:a05:6a00:1c8a:b0:837:7e7d:3d2 with SMTP id d2e1a72fcca58-8415f332b6cmr18931174b3a.31.1779792243590;
        Tue, 26 May 2026 03:44:03 -0700 (PDT)
Received: from KIPREYXIAO-MC2.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164afe2dasm12132890b3a.19.2026.05.26.03.44.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 03:44:02 -0700 (PDT)
From: Zhenghang Xiao <kipreyyy@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: bpf@vger.kernel.org,
	Zhenghang Xiao <kipreyyy@gmail.com>
Subject: [PATCH bpf] bpf: add rcu_read_lock_trace to bpf_timer_cb
Date: Tue, 26 May 2026 18:43:57 +0800
Message-ID: <20260526104357.35779-1-kipreyyy@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_timer_cb() invokes the BPF callback without holding
rcu_read_lock_trace(), unlike bpf_wq_work() which correctly wraps its
callback in a trace RCU reader section. The free path in
bpf_async_cb_rcu_tasks_trace_free() uses call_rcu_tasks_trace() to wait
for running callbacks before freeing bpf_async_cb, but this
synchronization is ineffective for timers since they never enter a trace
RCU reader section.

Add rcu_read_lock_trace()/rcu_read_unlock_trace() around callback_fn() in
bpf_timer_cb() to match the bpf_wq_work() pattern. migrate_disable() is
not needed because the timer callback already runs in softirq context
which prevents migration.

Fixes: 1bfbc267ec91 ("bpf: Enable bpf_timer and bpf_wq in any context")
Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>
---
 kernel/bpf/helpers.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 2bb60200c266..5056aae41c77 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1204,7 +1204,9 @@ static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
 
 	key = map_key_from_value(map, value, &idx);
 
+	rcu_read_lock_trace();
 	callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
+	rcu_read_unlock_trace();
 	/* The verifier checked that return value is zero. */
 
 	this_cpu_write(hrtimer_running, NULL);
-- 
2.50.1 (Apple Git-155)

