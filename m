Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C7715A85A
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780737598; cv=none; b=HVTzQD9wO2muyHIkb83cPemlDh2TMjhngR9mxWY4oMBV1kC7ylYAJiunE+ahuVl2xsl31w4WV+6IuPI2H+FhqaF2Oqwv+m97SpGPCNm6maGk/6YoaWsKNaM3fGYHUJoODnJ5dzb3ldPTXrWEZe9uB7KbYGLIJSJOwbSywmQWDjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780737598; c=relaxed/simple;
	bh=jRlVNt33dcmY+Gqh8IAK/Cp9Kzl0Ro5FZJQSIpzuERA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A8cdBj3M+fjj/Jvq0+idt8d12LDaU8LZoyrPcbBUoRm5bkhq9/mHVaYzJZmjpaW7C3+/T3jzrg3499j7FiOuXkERByLf4qX4L9X6lrZsJ4RXdo2tXrY63U/0ZYhei2ynozAxr5pdq9skZYmlshYtbN8A6zW/8Lhj/gdYSOtjLss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbQTgX5p; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbQTgX5p"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8423f420455so1202815b3a.3
        for <bpf@vger.kernel.org>; Sat, 06 Jun 2026 02:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780737596; x=1781342396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C8Z2dEedFACMstCQHDyAELUklZOwhGF6wngz7Y8OzOo=;
        b=lbQTgX5pA3SBIOoFew67y43tFwHHBOvqrSFuyQCpOPS/+nJMnhlqHMxXNPkd1HxzqM
         ghXA2LvpBju1UC8FkpCF8pC+FoCunfJ8VCsOQvdkvnc6xQJmQeOzMLQ3o5FOShLffta2
         jzUvqRF2SV9b/+nz/sfiBj59Jqrxk1x508jFTfr19bpQuRdUA3dEFYA9GB8cXbxKBFGf
         GUpAXBojDexfFgfDNdw6jYP6nqb5WS2PnT4VroXeczBsgIyrgnyTDRurn8UY8vUbQdMb
         4J9otEO7I8YvIDpgcvnRfSpkoiKkPbIcFcRPubtyYYIzUsYc7brxMfTm4oQVRUoSfMHx
         d9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780737596; x=1781342396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8Z2dEedFACMstCQHDyAELUklZOwhGF6wngz7Y8OzOo=;
        b=dOGEwvkaGbnInEmTtywExVVRzCoemCduyqsmNDNc3mRbAXkLazLe9DAtPLSZWMAGkd
         yKDOHJ3rjxTkaEuq21YAaJ38yrP/D7adGSvnLBS/xHI3xh40DC5i1KhDCiJUJT6s0U98
         Y2liMtczPmEeTPT2/XRcZu2QKvCDnrMweoGsT2CmZO4WukqY6M1jt6hXGPbf+XhrvTBu
         ksz2bck1RqAE7aYbKunnv8ZaTKblK/jeWkokZkJuzqRx+/gE5oLOQJN8sM1S1ysl3/ko
         q4GQl+sjCTt6aseb1N9OCl+91JPbaPJ9mOxmzm0nqi6LwIg5e65FVZ3mBS1S9CiZZNXr
         Pv8g==
X-Forwarded-Encrypted: i=1; AFNElJ8gbTfQtS/Ugb/Ae6ceJbKLe5EsEWom6C90d8FNeMlvM48qbv+xPI5DV40egD9R9CVaZX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy0QMD+Nks1OcUS7tGQdQrjFuf7qQyXm/SnWJqBF5kgQEHeuIU
	FVBgDks0616nOqA1oTU7FSZyyUy1VahhmF3GopiUFLCxwGnu+D0sm5mvldqpnCLp
X-Gm-Gg: Acq92OEsNORbhLb9/VDO1I+ndw3L4gWr7Q3xK69dnMZQxUudGRfcCfOaG27QfJvPwnQ
	D/0GEGGz/lt2zElWs8b9Kx0m/A+m/RgYgxyH0OrPahzkw5CdhTmm1yLNLeJwKgry7p+hZCMqRS2
	KuJj3bCWwlJ0mM/SoGE+xGRkyh1nfCbb7kJN1ESuhlR/ou8RVMz9cnhFfU/mzrzwPyxjb9VDMLG
	pX4AIRKasQjuQh0kHxU2YKZeACS8+UZ1Xd/2Fr+W8iwT8Lcq98bmcvDZcfLM2Nhm1IUybAe2XUv
	XUcjekS/mdRXqW+jhZ6xrzALicJWVVZh+iqA52Hrufdf6dgLHY+GMDK3elGcalXgIZtv8ZU8n2f
	HkY1tDStlNkUGvKY/ULfB0+UkoAw8sIyYvc728onA0AM8hbQJupEoXwE67NecpsmEz1iKA7uoda
	ipMmRECe3ziNzbFfcZLpWJrLwI80mVzxAB8wmh6GHlcwsHGCFIfIWxhuysZafK+JreeOAZozSb
X-Received: by 2002:a05:6a00:23ca:b0:842:5b63:6119 with SMTP id d2e1a72fcca58-842b0e2f430mr7485422b3a.1.1780737596208;
        Sat, 06 Jun 2026 02:19:56 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428291ed20sm14585734b3a.61.2026.06.06.02.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 02:19:55 -0700 (PDT)
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
Subject: [PATCH bpf v3] bpf: fix NULL pointer dereference in bpf_task_from_vpid()
Date: Sat,  6 Jun 2026 09:19:27 +0000
Message-ID: <20260606091941.1803115-1-rhkrqnwk98@gmail.com>
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

Return NULL when bpf_task_from_vpid() runs in interrupt
context, or when current has no pid namespace.

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Fixes: 675c3596ff32 ("bpf: Add bpf_task_from_vpid() kfunc")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
v3:
 - Also handle current with no pid namespace 

v2:
 - Reject calls from interrupt context (Yonghong Song)
 - https://lore.kernel.org/bpf/20260605200501.1619406-1-rhkrqnwk98@gmail.com/

v1:
 - https://lore.kernel.org/bpf/20260603204206.773482-1-rhkrqnwk98@gmail.com/

 kernel/bpf/helpers.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b5314c9fed3c..226c31ccb5d6 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2912,7 +2912,14 @@ __bpf_kfunc struct task_struct *bpf_task_from_vpid(s32 vpid)
 {
 	struct task_struct *p;
 
+	if (in_interrupt())
+		return NULL;
+
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

