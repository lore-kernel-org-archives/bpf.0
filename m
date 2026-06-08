Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0461A274B23
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 05:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780894843; cv=none; b=gGYByQblwZFK/7I9pDJ4tJT6l77cmc8OolC6y/10AowxP/zqr2EcGqQZhQLSmAUFazaN7QWfTIlhtYF1YBL5YZUmI5Dx3bxliKpWML1KMJQ2cw7mXt6DEOJbYEXS0rUR9kGgoAwr5Wj4pFZP/250q8CKgcdUYpppqtA2UyjlRq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780894843; c=relaxed/simple;
	bh=Oh1MV1RWGEKUsSG9k6LPTui2Lt/unV+D836axWkaWRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fOxyHR6eSZaOR2HFy4xB6dyBqWWs7fHUjAxaJB/1ALXMkbYBMx7Ec8cXx87ui4xr1TGgZG9gRxoypRIk22fVZX9ENbj5E+zVhhGKH++ac8vVZV/xw12YfqZ9bC5Ma77PQXROXorZ7J8IUe5Zz/dfM1h6cXBsFkGv0YA+e6Ci5sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpHm9+ga; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpHm9+ga"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c0c1e0d00bso38236675ad.0
        for <bpf@vger.kernel.org>; Sun, 07 Jun 2026 22:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780894841; x=1781499641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R4p5Co7VxrJ6oR2ZhA3C1MwZelFLsSrAfJgqOqIxMmA=;
        b=FpHm9+galER5UGM6rhbgXE43GsEfiVmfZ1hTMhskQlhpzShl9Zgo+OTHcIdAj2FBhs
         zEMFr5yC25SthYw1dHEbv9TkQmstejSoiH1b+GYzq5CPobSb0nKUdw2yW9q9TrjpohhC
         YHS2xBpPHVbIGgPnXdLdoZ4ySVYb+Dh31X4kmTSGQ6NDAHq0v5l90nYbIiUmN629HPnv
         TDnM9hw+7gQdUF8STqNIvaI8xdHszbiqvp6TNgYLdq2ycw7Ybheb+APvn9xFoOFZJFPV
         2Qn6gh+XPsbweU4XNEuNK0Pqc2/7pgwbT2PryE89Gb6W/QZsFqI7Buf25Cd6/ceoXo2z
         8jfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780894841; x=1781499641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4p5Co7VxrJ6oR2ZhA3C1MwZelFLsSrAfJgqOqIxMmA=;
        b=KoTDhSw/zHIuEr1KsWIx3irDYBuVa0UcksyJxXZuuK0ov68dF18zkwIlFbdK0Q7UkO
         b0zaJGbfB+cFA8CXH7pLP9X8b3ZHSZAx00gksdTtbKmoZdJLwhOymLfPRSoV0fHXrdsp
         hSC0SqT2vRe4sJhWERF/6lD84MwMrG9ZwRXF3+RaTdRCEIwTanrHtNMSOtgmjpjH3HiZ
         COILk/sgA4XwPQAiokift8F28vdspjH0CK7WomJjKKP6oVJVXG8CI38gK6vqrRpmiqXU
         pC+VTkgualIz37me0ggIFTWu5Y1gB7EI3VaQ4g9yaotn9UQ2LNoIdDgAqS2Ap4tN0HkT
         88PQ==
X-Forwarded-Encrypted: i=1; AFNElJ/YcHiXLKZECxkxsnqxXpc+AxJoW5teYDy/LAvAL1bOCud7uunQ4qoikdORJhGXPA3Cqeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjkeuuWYQcxJTv0duWYc5Eb6ju/tmmS5aY8W0TqoPZPnLoJDfl
	An6R5KoEZhGk4ZlR3rCmaYlxzZoVhdoHonbOyUvby2300YwfYQ1Tf9Bc
X-Gm-Gg: Acq92OHulz9ZCd3cpoRfVE6RHHPbp1ES/eYaRmBSrOx3RNRfmG1jqpAtKjvrOJxmpus
	sK+Mj8nm4eLkLmbIEnHXFR6EzviMX/yaiqFeizi7YjfOFV7nWnimwmpI/GSPQOmx6m902j9Qsd5
	IZFuWPcRZgOUh+ReZLSRRFwh1XFEB3eXvc+2x7mXgYdVY8Hu1VmWAKCPJDrLJQsnpbj4/kcVHMr
	+I/Qj743cbFfxbER3BUSKXDV9qMZ8f4zgnuAaUPJw847yEGA+Sv8XjbGPHBqTCwqEbRP6qm0bPi
	vLWGkDqEqpYDe/GOSeJQZcUBOVc7WhIinFWKiu2Ia720NKx4+u9DAHGcXjlriL1ZQXkYg3I12e1
	c/Ekiv5ZA/b4C+wJq9ZNZVEaO6fRvblMREOAAPikjojQch96rNwKwlNK8LdxTz90mmclTYqnR7y
	7GPzbuNfHO+FN1sMbU0Y+xfnW1UG4oRd/DePnevsDmgAwYSiTtPtr0YGNDy0/s1+Coi6wq53t+
X-Received: by 2002:a17:903:1b4e:b0:2bd:8dbb:293e with SMTP id d9443c01a7336-2c1e820e57cmr159075445ad.14.1780894841141;
        Sun, 07 Jun 2026 22:00:41 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164fa00b3sm158987715ad.32.2026.06.07.22.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 22:00:40 -0700 (PDT)
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
	Leon Hwang <leon.hwang@linux.dev>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v4] bpf: fix NULL pointer dereference in bpf_task_from_vpid()
Date: Mon,  8 Jun 2026 05:00:00 +0000
Message-ID: <20260608050001.2545245-1-rhkrqnwk98@gmail.com>
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
v4:
 - Drop the in_interrupt() check. (Kumar Kartikeya Dwivedi)
 - Switch to guard(rcu)() and drop the explicit rcu_read_unlock(). (Leon
   Hwang)

v3:
 - https://lore.kernel.org/bpf/20260606091941.1803115-1-rhkrqnwk98@gmail.com/

v2:
 - https://lore.kernel.org/bpf/20260605200501.1619406-1-rhkrqnwk98@gmail.com/

v1:
 - https://lore.kernel.org/bpf/20260603204206.773482-1-rhkrqnwk98@gmail.com/

 kernel/bpf/helpers.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b5314c9fed3c..80aa3bf203b0 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2912,11 +2912,13 @@ __bpf_kfunc struct task_struct *bpf_task_from_vpid(s32 vpid)
 {
 	struct task_struct *p;
 
-	rcu_read_lock();
+	guard(rcu)();
+	if (!task_active_pid_ns(current))
+		return NULL;
+
 	p = find_task_by_vpid(vpid);
 	if (p)
 		p = bpf_task_acquire(p);
-	rcu_read_unlock();
 
 	return p;
 }
-- 
2.43.0

