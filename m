Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626BF408638
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 20:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780689915; cv=none; b=bhZMKFIeBJW1amMzhtH94w8cxoDtUvGvQBT/XDFMYjAcB8PFPJFV3A4HUtq5JYOjJdJ96rL91GsvTw/h7z7WFAuGcf4JC+2+63Ce54pe0WT/jwxI+RrYAPXwKL7TNuliiPyxOCJZJl3FaVZAUpSOiYZ5dcRbW1t3sg+lrIT+lzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780689915; c=relaxed/simple;
	bh=Rk7IOlpOOQz6Wbk1TWfaxd5Da5lG4fM7Elqv7xX7BUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GT3NTzw18no4h2asRfTrqv52bFDf3znumBlvmt2edLk9y9a3NM6s2yfh3jzcGyMvRfrz9iopTsb1PJfE4AOkWS+mHYRNvTub8IicmK9iEtAi5x63m38Znx0Ojbdqzw+lN7w0W0Aqipz3WWfQCzCoHSrdmaLRM3A9U/0M6V1edRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o1fRcs8b; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1fRcs8b"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36bcf3d2565so1744388a91.3
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 13:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780689912; x=1781294712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dNbRJmCRrzBsFXYqrB+uWE+oQVCCDNWPcO6WRGR2yX4=;
        b=o1fRcs8bK1V/KVutBpZ6hFutcoZzpjNFUbu+mgxAgWR5Wf7IlwKIlu1/Fs62oOwQRN
         Iw6TixiYFMlg7u9pNM4JYlnzqElnzo0EjMZ5AQ19rUo5odiiw79ntDjaNV5G0RCl+vI9
         t5oUO7EhyB+AgHqwaY7QoAroOW1aVzjqvBIfL27S1D1Ajh+W0uRKS/XLK/o63K71oicV
         kJhVvCeJ1dvndGAWx2gHiktcmtyqixVNDllmqr1pY/XKs7Pe1dR+d8KV7Pw6QMEiI9hz
         Ay65E9hcxTlSSHLLS6iMM311lFx/oFQWhn0SPI11vbWWgvPo/IT5gKP+gyyj1vh81CSW
         MJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780689912; x=1781294712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNbRJmCRrzBsFXYqrB+uWE+oQVCCDNWPcO6WRGR2yX4=;
        b=E1C8jxAmQbT3MO5mpLDlDyEnCeGyyTqvWiFk3trsBt5M59SrMcaTytX8adRJfF/NAw
         kbfBKk/airuXbLstZ2/hdLiH1bH7LTsUS+WrPn/Xd4K2143MkPLphSAVhsmBTElPeelL
         Oj7oW+wCb8N2CCMlf4bMEpU0ZJerqLr8gjkbp3uvFZuh3QeOLfe0y6PcQZo3/sTYYAvn
         0qockP9J4/WpvbC0nRqp3l49Q7wm847pVbZt0r3xodbQTdKZlFouVIttpvWCu/OSwdGj
         nfjqgmV53H28f32U/koS87i9bUNk5B32GqXM1Yv/EduwJ5WtX+pOzB5HT47N/QG/MZRs
         QUrw==
X-Forwarded-Encrypted: i=1; AFNElJ8QuYwtBazulssey3baFd+VLrey59sP45yMuZjlpN+WO+1hHQNh7Qfav8tz1sUa92ZdsFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2w6Q8E9SG+4ch5IGiEo8/SZ/eRaa5RNfbQshv20b0lRGJLSWk
	G0nuiBHCNo2EWWU9HgxAlGV9IiofytIlKn6OSQYeQ9aUYKfiBKI/vLP2
X-Gm-Gg: Acq92OFun2cE15tzxzGpIHpwKFbym6uE3L5l9jYqzbDB92EPpoCnGJnO2W9Qoqgs/Ds
	7xSdjVSRgtxtdd7BcDgUHmeEOpZ0Wquhr4nTNRrvDsjB1WhYV0EOJke42k9l3q3c8rxs6zB4TY/
	dcVoAhuRoAfZc5e3B/xZhd3UibeTSikOiFapzW0qi1zYinIaUaXll1mwYIdSnHd1xig5xLaQmUd
	XlgjwLG39XMb2qYxYCL5CoGt15B1aGVRtw+wN713hUpYP/YrLcIMhavVbSL7ZPmX8/h9rsmqy/Y
	GUhOk7xacegWZbudP/BqJsZZ9+ptseW52fWuILmej08De8879olZVIgS0YmW/TDMwk8R5QzQBeD
	7BK77Xd5Afo1ga9L0YyzqRsgBAUm27t/xK2qkC/4dwBisrEYPU4dMsG9DhQDGZFxoj6dCMn0T6S
	a/Li//8a408RFD/hPoptJsFfsDi2h1VP2RUaxfPCbyrB/dCnIVcQAwV4mo8U9gNJE3wBf4T+t5
X-Received: by 2002:a17:90b:5210:b0:36a:1ed8:6fe6 with SMTP id 98e67ed59e1d1-370f0b58cefmr5020296a91.24.1780689911521;
        Fri, 05 Jun 2026 13:05:11 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf830b2sm6811667a91.4.2026.06.05.13.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 13:05:11 -0700 (PDT)
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
Subject: [PATCH bpf v2] bpf: fix NULL pointer dereference in bpf_task_from_vpid()
Date: Fri,  5 Jun 2026 20:04:57 +0000
Message-ID: <20260605200501.1619406-1-rhkrqnwk98@gmail.com>
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

Return NULL when called from interrupt context.

Suggested-by: Yonghong Song <yonghong.song@linux.dev> 
Fixes: 675c3596ff32 ("bpf: Add bpf_task_from_vpid() kfunc")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
v2:
 - Reject calls from interrupt context (Yonghong Song)

v1:
 - https://lore.kernel.org/bpf/20260603204206.773482-1-rhkrqnwk98@gmail.com/

 kernel/bpf/helpers.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b5314c9fed3c..890202361b53 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2912,6 +2912,9 @@ __bpf_kfunc struct task_struct *bpf_task_from_vpid(s32 vpid)
 {
 	struct task_struct *p;
 
+	if (in_interrupt())
+		return NULL;
+
 	rcu_read_lock();
 	p = find_task_by_vpid(vpid);
 	if (p)
-- 
2.43.0

