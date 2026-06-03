Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A79402B8E
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 20:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780519349; cv=none; b=EUzruGR++tmc5XokGghzxYAQXFlUU88F2uJoAMZqtY9nXYi/7V7qwtb3svIJf/ex/j+JcViU1qYfqTo1qpw8fD7+q77vbjMyuiS9l6Brhn+6KZop7eCER30qgH3izGQNz8i07sCOMRIijo1GdLip+Zi1Hl7kOArm64EvcFI8G04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780519349; c=relaxed/simple;
	bh=S5gmSiVU0GTldz8MOGh/hxGorXwUtiyn6vDC1Djk7jE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XX2IlG9Qak0O8Ml2IGUx3AAW4b0wj6bctmmAsjuRH5Mw/EZofg5ELZ+FFBEgNUi8il5ZF4bKZT1dSrOq1N4wcWt0DyHb3oXlNQGjfqPSnMSlqPEFdoMN0pRiFapqr5HuutJCv/WN2fAdWbbSamYI0x6F6gjLFUqWvM+RLSwajYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8SGbkUS; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8SGbkUS"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c0c20f0c0aso29862725ad.0
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 13:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780519347; x=1781124147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wLbT+MK2FeIs2ihHI8/87OobjBApaN8Trxtynzp8QvI=;
        b=C8SGbkUScV8GC+VYvrHXC8c8aku8RZqMwm+PW8iA0GmYczAvxVd1REa05SVbnU0LLW
         6BYUhppa7dKRbjjFm6LtSl5fuq+c9c1Zg9bg5R/b6xS21lnjgE/PkGuOe6jQl9VgBt+5
         It2RBqmiBXrpXG3AldVFtnQlZ0BheIWHDtDlcMgpgSDFd31/RPy3yFHp7bKP7dTRdt0T
         jjvDoaJ1LTNIiHJpHsUTZIr8KaoUr8aLu01Ys16jn8v7gXnNNtl/KMxsdxnqrWa9APMW
         vXeo+wOHyPEJy2AnArQ4KwHcvc82yxreljT1lV5TqE2Sky7csiGSpWsXpPlnwboCl/lc
         L43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780519347; x=1781124147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLbT+MK2FeIs2ihHI8/87OobjBApaN8Trxtynzp8QvI=;
        b=dtg61remWIgLAeE3RjKsF80aA25wNGOwC1rxKsww4GDWpHdvxyFsbN9BgHV5lcAK1q
         XlBdS4omQv5eFoB2ZVLlnFjqtCbKp4qnsJLFPs3d5e+sUSEb9UU6C6cOOh+uJ1gk91Iu
         q4VAUVVpvkaCO8ZMOqeDok/LpRszVZh03c7lsgrazXfZoCFuGg/1wffBoInUzdVYyEZ4
         XYmvVcJmnMrNMWJKNI9Ixe/D3vIWbQ/9Bx0aA0rDuZzEkl7pY1Fl1JTJfBqG3IqtZ6JE
         MSXKSGhOoWWHzBTyZ5HPyjC8rMq64BUB2tekWX29xCzWOAFXJBfet+XQ7bjAYRP5uzUE
         kWuQ==
X-Forwarded-Encrypted: i=1; AFNElJ9JyfVbIIJL/SZezkAbDIUsyf6Ckp5mjm7QMkQ+TtBKZPMo4P7AE9QkEql6sJSpaVIHWHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoav5Ppg4k+E4VWDWDph0GXXKFSwurJRrcSyWRmGvX+mTijhH/
	1iIeS0H3XKtUIHsXT3UOZMfh7DXIkoflbqibdDEPFkwF2+AHw2uhBktV
X-Gm-Gg: Acq92OFjx4bulKjbRB6pJNf7j0rQsO8oS08dShwGOW4ticpYfZxyBw23Jr5ahgWvJp8
	GAemL82ICpJ61GiqsTTdHqYevDqpMWW9fGZBRtAwa0kKdQtpTTcTcXDmUPWoVP8WpsISAMTvdJr
	DLevo9r65UvLWMxZELLEh1LNeM8eSvNb4TXGosH3OWb5KwlH090hxJm0I4WrQwpxVQD67CRHCBM
	IzHNbv+lEL3MS6TCSk/8hY9aWylZGynTJ4AfqeTDjsCQrO9w+qKKS98RBsEEQ307Tfbjp5CzGuc
	JJcAjbQBMz+viXqgel0SxGID4ORZO/hGS96fKRhM1khp6cH1lDDnK242edso67HLu2e6eAbB25F
	nUg3THal6WIrvdGQ2HCdxdtYGUNg+LkmjlfRZIR2PuV3mfAd07S6ySFC0kwrQTQC1TD8WCv9K83
	SYIYujsAlVPdaoX2ZPqDUKFAhzphfLeosKH2hgk/6X6GUgRdC2/eguFuyyRZNwMF6c1K9A/jMZo
	3xHh/6No+s=
X-Received: by 2002:a17:903:1786:b0:2c0:c38d:9d51 with SMTP id d9443c01a7336-2c163d8c184mr51694615ad.21.1780519347310;
        Wed, 03 Jun 2026 13:42:27 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664ad172sm34595245ad.83.2026.06.03.13.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 13:42:26 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Juntong Deng <juntong.deng@outlook.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf: fix NULL pointer dereference in bpf_task_from_vpid()
Date: Wed,  3 Jun 2026 20:42:04 +0000
Message-ID: <20260603204206.773482-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_task_from_vpid() looks up a task in the pid namespace of the
current task, via find_task_by_vpid():

  find_task_by_vpid(vpid)
    find_task_by_pid_ns(vpid, task_active_pid_ns(current))
      find_pid_ns(nr, ns) -> idr_find(&ns->idr, nr)

cgroup_skb programs run in softirq, which may interrupt a task that is
itself in do_exit(). Once that task has passed
exit_notify() -> release_task() -> __unhash_process(), its thread_pid is
cleared, so task_active_pid_ns(current) returns NULL and find_pid_ns()
dereferences &NULL->idr:

  BUG: kernel NULL pointer dereference, address: 0000000000000050
  RIP: 0010:idr_find+0x11/0x30 lib/idr.c:176
  Call Trace:
   <IRQ>
   find_pid_ns kernel/pid.c:370 [inline]
   find_task_by_pid_ns+0x3b/0xe0 kernel/pid.c:485
   bpf_task_from_vpid+0x5b/0x200 kernel/bpf/helpers.c:2916
   bpf_prog_run_array_cg+0x17e/0x530 kernel/bpf/cgroup.c:81
   __cgroup_bpf_run_filter_skb+0x12b/0x250 kernel/bpf/cgroup.c:1612
   sk_filter_trim_cap+0x1dc/0x4c0 net/core/filter.c:148
   tcp_v4_rcv+0x18d1/0x2200 net/ipv4/tcp_ipv4.c:2223
   </IRQ>
   <TASK>
   do_exit+0xa63/0x1270 kernel/exit.c:1010
   get_signal+0x141c/0x1530 kernel/signal.c:3037

Bail out when current has no pid namespace.

Fixes: 675c3596ff32 ("bpf: Add bpf_task_from_vpid() kfunc")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 kernel/bpf/helpers.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b5314c9fed3c..4646a915bf98 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2913,6 +2913,10 @@ __bpf_kfunc struct task_struct *bpf_task_from_vpid(s32 vpid)
 	struct task_struct *p;
 
 	rcu_read_lock();
+	if (!task_active_pid_ns(current)) {
+		rcu_read_unlock();
+		return NULL;
+	}
 	p = find_task_by_vpid(vpid);
 	if (p)
 		p = bpf_task_acquire(p);
-- 
2.43.0

