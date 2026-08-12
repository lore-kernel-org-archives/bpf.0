Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B96D35C69F
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 05:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786511299; cv=none; b=RmQPzXEwLcDFe6kuRwGmsqO4tK6hfuu8nUfWuMu/ZikyMzgnsT5M+wViZVe1TEVEizjmX21xVAuOhPGZEzOx4KQJiaFJANtJey7uW+dYH46OfJYY9b8v5DEAHb3E+jM3IsSM98FxclxjT37HCEUWU4OagYXSG1Tq0HlK5jcK/WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786511299; c=relaxed/simple;
	bh=uhc6wBwrNS9vfoVczwdeSLBZJ2E1HCq++cw6w9Sb3R0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BshNr/io/SmK5t9dscTHp9jw9saesPcgG6zb4hp/Vh1/a6mcm/ridB2nF7wm3vNanUqKebb1YU6osQrSIw6rkNdjIFevDi0l/pGav67U05QwR8bpg9DnU1o4K8rWNirdCyhcBSJK3f3vmKa/cI1MtcqiTklOMksM5uPwd++REQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=FgdAByvJ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="FgdAByvJ"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so498324a91.0
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 22:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1786511296; x=1787116096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1yuGBq7G0Bev3VP+vTDYTvYJPw7Cn0tNgdTp90qDuqk=;
        b=FgdAByvJQWkwjZ6d5fezqSAl1+zX6JeyNdKhYzwM1LITDlPCZMt1YC8R/deUacrsla
         P5T25Pnd1Xi3tLshGeUx689UchGjgQF2Dddn6XRASQ2KB2LhPYOyS4UuOAQlT39eRWDs
         ebxxw5L9D0LbXmpYWXvsSKbxD60uXHAlC946s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786511296; x=1787116096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1yuGBq7G0Bev3VP+vTDYTvYJPw7Cn0tNgdTp90qDuqk=;
        b=Wqov3x768L8GatE6riJwXoDXnv85f4rC3hjqd7H0stoGRA+50hqsHrdEPqdFYpxqIi
         JLMubwsFU3K29W4sKIMZFZ5YF1kuA7/DolAkrcdzGYr+v531EzsRlgs7AEagJ8UgFyXC
         ua0gpVhw20Sw68kcV6tb7hEK0spfzHcM7JDfJnCn+33CEMHXhVhHCjNXU8KeX9bgNkcr
         m9uqgSVstZyFLKvRmwis81lH5OwHg808LTisD/w0j0ZEx0F7+btXZHmgFJ9axJy11Ot+
         3ADEghGSIMaLN9i2Ikzb+Ou9/NYK4IBO7HxOPdCWSzmFP1a1dGZnY3rSRH5tQ6bbA2pu
         dX5Q==
X-Gm-Message-State: AOJu0YxiQgFGRUlSSxicxS6XXfgZYXUi5kfS4yut3jfKVQarsQgl1hhN
	e191/uf0p24kO+aNuapYcb1WudtDavZ53WLd7feyWIcIlKVwu/H+63wwWo7hix3XQoxTzlUUQIc
	M7fpTEThi0A==
X-Gm-Gg: AR+sD13kB99VlVw1noTZJkx8qxEhvHqPaFf32swA3S4Wy/UmwhLA+Q0w7nmL2kg/SMR
	T76YD5gE5oJleVZ9223XR7adYGrfr1Y4jrrI6dEMHttlZBy7vIcYb49nG7jSwFX/sEUgPIUH+6z
	7XSCDTerUKqCXfilvHDFnnM3Bsj2CSnmiVM1ExVrYn9XXLVRBOYWHvTmsP0VsYhJQ1fdM2KK0JR
	i6gNrzlFXauoD1xXdbU2tV3hm9H/C2lVyfdvc0UGKwFqfPuxGbWoZF80xCSwIQiGJSZdF5sM+ap
	5ifz33UCIIBOomAw4CRLHd/K3tb7Nu0lYpEpLZj2JtrAwwPlf7+HV7xlxmsr82g2wIemvcYNNut
	XluqSvODARybfCY0Pnc2Qq5nWIDwwPZmMTtlHuurCnT9hQpL1sWD4Wix/Op7VI5nLgnJ9Z71OYd
	KHGC7R5NIwM/nKSEjsscDXn1nsU9ClIO++I6Fx3o3IWOFHF9jjScIIcgD+/QaJG17s
X-Received: by 2002:a17:90b:5103:b0:38e:7297:a92e with SMTP id 98e67ed59e1d1-39302a39179mr898876a91.9.1786511295576;
        Tue, 11 Aug 2026 22:08:15 -0700 (PDT)
Received: from desktop ([147.46.174.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f8e7a68fsm2038658a91.17.2026.08.11.22.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 22:08:15 -0700 (PDT)
From: Kenneth Lee <kennethbwlee@snu.ac.kr>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	sdf@fomichev.me,
	yonghong.song@linux.dev,
	rhkrqnwk98@gmail.com
Subject: BUG: bpf: task hung in lock_sock_nested during sockmap free
Date: Wed, 12 Aug 2026 14:07:58 +0900
Message-ID: <20260812050758.813489-1-kennethbwlee@snu.ac.kr>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The following hung task was found by a custom fuzzer developed
by Sechang Lim <rhkrqnwk98@gmail.com>:

  INFO: task kworker/u8:19:1912 blocked for more than 122 seconds.

Unfortunately, we haven't found a reproducer for the hang yet. We'll
inform you if we have any update on the hang.

Detailed crash information is attached below.

Thanks,
Kenneth Lee

---
- Kernel version:
7.1.0-rc6

- Crash Report:
INFO: task kworker/u8:19:1912 blocked for more than 122 seconds.
      Not tainted 7.1.0-rc6-dirty #34
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:19   state:D stack:24296 pid:1912  tgid:1912  ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: events_unbound bpf_map_free_deferred
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5388 [inline]
 __schedule+0x1f31/0x2e80 kernel/sched/core.c:7189
 __schedule_loop kernel/sched/core.c:7268 [inline]
 schedule+0x167/0x360 kernel/sched/core.c:7283
 __lock_sock+0xf5/0x210 net/core/sock.c:3191
 lock_sock_nested+0xca/0x100 net/core/sock.c:3804
 lock_sock include/net/sock.h:1713 [inline]
 sock_map_free+0x120/0x3c0 net/core/sock_map.c:356
 bpf_map_free+0x197/0x3c0 kernel/bpf/syscall.c:892
 process_one_work kernel/workqueue.c:3314 [inline]
 process_scheduled_works+0xa98/0x1690 kernel/workqueue.c:3397
 worker_thread+0x8a5/0xd90 kernel/workqueue.c:3478
 kthread+0x397/0x480 kernel/kthread.c:436
 ret_from_fork+0x397/0x810 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/34:
 #0: ffffffffa4905880 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffffffffa4905880 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffffa4905880 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
3 locks held by systemd-journal/120:
1 lock held by syz-executor/327:
3 locks held by kworker/u8:19/1912:
 #0: ffff8881000ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3289 [inline]
 #0: ffff8881000ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x9af/0x1690 kernel/workqueue.c:3397
 #1: ffffc9001279fd20 ((work_completion)(&map->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3290 [inline]
 #1: ffffc9001279fd20 ((work_completion)(&map->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9d6/0x1690 kernel/workqueue.c:3397
 #2: ffff888118685d58 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1713 [inline]
 #2: ffff888118685d58 (sk_lock-AF_INET){+.+.}-{0:0}, at: sock_map_free+0x120/0x3c0 net/core/sock_map.c:356
2 locks held by syz.0.944/7410:
4 locks held by syz-executor/7721:
 #0: ffff88811a93a8a0 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested kernel/sched/core.c:652 [inline]
 #0: ffff88811a93a8a0 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock kernel/sched/sched.h:1624 [inline]
 #0: ffff88811a93a8a0 (&rq->__lock){-.-.}-{2:2}, at: rq_lock kernel/sched/sched.h:1968 [inline]
 #0: ffff88811a93a8a0 (&rq->__lock){-.-.}-{2:2}, at: __schedule+0x305/0x2e80 kernel/sched/core.c:7064
 #1: ffffffffa87c6018 (&obj_hash[i].lock){-.-.}-{2:2}, at: debug_object_activate+0x87/0x540 lib/debugobjects.c:845
 #2: ffffffffa87ef238 (&obj_hash[i].lock){-.-.}-{2:2}, at: debug_object_activate+0x87/0x540 lib/debugobjects.c:845
 #3: ffff88811a934228 (lock#3){+.+.}-{3:3}, at: local_lock_acquire include/linux/local_lock_internal.h:46 [inline]
 #3: ffff88811a934228 (lock#3){+.+.}-{3:3}, at: __folio_batch_add_and_move+0x93/0x810 mm/swap.c:192
1 lock held by (udev-worker)/8332:
2 locks held by kworker/u8:9/11248:
 #0: ffff8881000ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3289 [inline]
 #0: ffff8881000ac140 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x9af/0x1690 kernel/workqueue.c:3397
 #1: ffffc9000f397d20 ((work_completion)(&map->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3290 [inline]
 #1: ffffc9000f397d20 ((work_completion)(&map->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9d6/0x1690 kernel/workqueue.c:3397
1 lock held by syz.3.2068/11361:
 #0: ffffffffa50cd460 (rtnl_mutex){+.+.}-{4:4}, at: tcx_link_release+0x6e/0x4b0 kernel/bpf/tcx.c:177
