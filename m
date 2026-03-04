Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7490438423F
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 07:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610446; cv=none; b=bY+XvIlBCR/AXh5s/omu2qaUs3bKVUbfD9jh9bVO6wivnUM/5+3ovhziwG5YqXhjy5DlV+L1R0GqxMsjI3BH+o18EFs6QzUIXHWscHL+p7dRieNAb0qjlwJ8oOLG8M/TAhdeQSxhcFLTJZQggcdlmQnESxSGBG3xYL4T/b8Vs0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610446; c=relaxed/simple;
	bh=yRckoB6ziQPF5Ej6okVCmWtfBamAAg/Ab3cCVaNmIik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KTjpnEHoJILj+Z/1r1Au3QxBEfTmtC9YqobtOnh2yBPBYerrgfs20JyFjp4IE7+7fHC7sIIereSsFxjz6jO48t8S3JmMcD6VOfYlCLYdjmK2GUmR5SzSbVMpXBx4oKW1MOURbzToylsHMb4NIz9QsIQzgWxr4CqkbOIqkruD4O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krmqqgLa; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krmqqgLa"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3598c1ad542so1894589a91.0
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 23:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772610443; x=1773215243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IGWcCR+A6EXMnTgGJ2S1pAkRxkB7eLQpaJpcDvBiZQI=;
        b=krmqqgLaCZhCaQJ0k4ERQr6GLZ4KxeBTBkLWQMzVlct/O25x3zM1mckQR2ArVfMgLj
         AIkqg3Xx3fYV8T6VyO+XIPgx5Egs6FeIpw/QoAtpMiwCUs+SLWNyEIXzSN/5r0QpMHSL
         FmOdk2QhWc8R3EjJQJbdD94aBX95IRtMRpFlHbVWajJNhIP9LqvLyxhwewR1B4G4aJ0G
         96F4sJeAoCoWT0Fig9PWI6D7BH96wyMAYiwjcpubUXJAWM8AQcVKqeh3SHImYrS4kwzl
         kIBK7Z2dsS8i03BuL5RXOsYBC4PYnuYz5koK6CzqZArT4Pc+1f8C9yuyMiz/MWi87TiN
         w6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772610443; x=1773215243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGWcCR+A6EXMnTgGJ2S1pAkRxkB7eLQpaJpcDvBiZQI=;
        b=Oi3odW6oYgrk1jOns5bsSMUwXYIsAV9OOaFokWDpfY3VW9filFFJ4Jzb7NVES2/VrC
         oxQooN56BDsVwn13I4EsfVgtwfCvOCx6vgPWxhnIa4KWKf3/qmKkHBJA6INmOjtPSNEB
         xWHUaYf/0J1A6qQ+ZJfwPq/HxQQ/ix666d/vmcfoEMgEDWt4KOk1AOsxaXZBrUxJbSgS
         SdCKkg6FlEDSwSsLKWnBYVVjJ03dvei5c6L7FUi9N66yT96AEzw9MrwOoFOxMTk4d+UC
         eIaNmwlSzeYuP/lOjbs8sZ0o5UI7a7Fi66pva1wNyuUVG5L8Une7qvGBaU5SyGd31K98
         CINQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqMJCimQOOOg2Zski+X0ohnKGL3E5BQS8SqCLkTEbCrIwJNHidWhDk5/w5oLJP60o/I6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEdNDfQbgYYiR9GhGKvBHAlq0oouRXzyvcL0KqFSuo5VDWATUH
	rwaLCREKTX4nPXtH5/MycAUvgU3+HHmcsDgauISPyEvNRVKrjLQjgaOL
X-Gm-Gg: ATEYQzxHBEmES+WhDKEFA4H+hyuLjathjUMA/hRaPZB2L3/frXNIAhmI5jJIdOFfRQ7
	F2areRYJuvycNu7fClvzDd85lcvXI1QJowqlTfu2ozVJ0QzRabrp87IbkKJazP0fOblmtktvxk4
	WP5dCofNjrhvI1D6YepOG9Yql+qozewMaq8Q4MIFdPQnBfNrWEMVRI9YimrEF2n6DCVr29ZQjcW
	X5ZU0alEYodViEWuMKVXvhX7S3RNCP7aF3gDLIupXWwce0XRq67vQqqy45beiOA6+UX2o//E/qz
	BxHS645Y6ee8zeqchAJsWNFsgRaZ/TWWEVAcWg4qYPSsr7l8oKnsE+/e8Nq1PhPYI2mBbxJHZyf
	GCk8iGO0Q616gnzxgdNgYsRCnLqYqk6HnfQ8tvO8sTbmu0KPmywHib1NsCDwLL9yjgoL6f4iios
	5K0dm4F3BJ+P7rLa/bGSuJ40tMYK4jUDhrLaqxNv8e9OnlQuPzP/puRSE0HXXxWQ==
X-Received: by 2002:a17:90b:390e:b0:336:9dcf:ed14 with SMTP id 98e67ed59e1d1-359a6a531e6mr1125726a91.23.1772610442466;
        Tue, 03 Mar 2026 23:47:22 -0800 (PST)
Received: from localhost.localdomain ([2409:891f:1ba6:a29e:d73:6202:f71f:51b0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c39def7sm4352078a91.12.2026.03.03.23.47.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Mar 2026 23:47:21 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun@kernel.org,
	longman@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH 0/2] disable optimistic spinning for ftrace_lock
Date: Wed,  4 Mar 2026 15:46:48 +0800
Message-ID: <20260304074650.58165-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Background
==========

One of our latency-sensitive services reported random CPU %sys spikes.
After a thorough investigation, we finally identified the root cause of the
CPU %sys spikes. The key kernel stacks are as follows:

- Task A

2026-02-14-16:53:40.938243: [CPU198] 2156302(bpftrace) cgrp:4019437 pod:4019253

        find_kallsyms_symbol+142
        module_address_lookup+104
        kallsyms_lookup_buildid+203
        kallsyms_lookup+20
        print_rec+64
        t_show+67
        seq_read_iter+709
        seq_read+165
        vfs_read+165
        ksys_read+103
        __x64_sys_read+25
        do_syscall_64+56
        entry_SYSCALL_64_after_hwframe+100

This task (2156302, bpftrace) is reading the
/sys/kernel/debug/tracing/available_filter_functions to check if a function
is traceable:

  https://github.com/bpftrace/bpftrace/blob/master/src/tracefs/tracefs.h#L21

Reading the available_filter_functions file is time-consuming, as it
contains tens of thousands of functions:

  $ cat /sys/kernel/debug/tracing/available_filter_functions | wc -l
  61081

  $ time cat /sys/kernel/debug/tracing/available_filter_functions > /dev/null

  real    0m0.452s
  user    0m0.000s
  sys     0m0.452s

Consequently, the ftrace_lock is held by this task for an extended period.

- Other Tasks

2026-02-14-16:53:41.437094: [CPU79] 2156308(bpftrace) cgrp:4019437 pod:4019253

        mutex_spin_on_owner+108
        __mutex_lock.constprop.0+1132
        __mutex_lock_slowpath+19
        mutex_lock+56
        t_start+51
        seq_read_iter+250
        seq_read+165
        vfs_read+165
        ksys_read+103
        __x64_sys_read+25
        do_syscall_64+56
        entry_SYSCALL_64_after_hwframe+100

Since ftrace_lock is held by Task-A and Task-A is actively running on a
CPU, all other tasks waiting for the same lock will spin on their
respective CPUs. This leads to increased CPU pressure.

Reproduction
============

This issue can be reproduced simply by running
`cat available_filter_functions`.

- Single process reading available_filter_functions:

  $ time cat /sys/kernel/tracing/available_filter_functions > /dev/null

  real    0m0.452s
  user    0m0.001s
  sys     0m0.451s

- Six processes reading available_filter_functions simultaneously:

  for i in `seq 0 5`; do
    time cat /sys/kernel/tracing/available_filter_functions > /dev/null &
  done

  The results are as follows:

  real    0m1.801s
  user    0m0.000s
  sys     0m1.779s

  real    0m1.804s
  user    0m0.001s
  sys     0m1.791s

  real    0m1.805s
  user    0m0.000s
  sys     0m1.792s

  real    0m1.806s
  user    0m0.001s
  sys     0m1.796s

  As more processes are added, the system time increases correspondingly.

Solution
========

One approach is to optimize the reading of available_filter_functions to
make it as fast as possible. However, the risk lies in the contention
caused by optimistic spin locking.

Therefore, we need to consider an alternative solution that avoids
optimistic spinning for heavy mutexes that may be held for long durations.
Note that we do not want to disable CONFIG_MUTEX_SPIN_ON_OWNER entirely, as
that could lead to unexpected performance regressions.

In this patch, a new wrapper mutex_lock_nospin() is used for ftrace_lock to
selectively disable optimistic spinning.

Yafang Shao (2):
  locking: add mutex_lock_nospin()
  ftrace: disable optimistic spinning for ftrace_lock

 include/linux/mutex.h  |  3 +++
 kernel/locking/mutex.c | 39 +++++++++++++++++++++++++------
 kernel/trace/ftrace.c  | 52 +++++++++++++++++++++---------------------
 3 files changed, 61 insertions(+), 33 deletions(-)

-- 
2.47.3

