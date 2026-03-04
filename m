Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5743932F7
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 09:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772616243; cv=none; b=axv2a+ISNrHvs6Z8HVL3ieac2ZetYHguiamzYzk6dEaOUJjSL5N7/U7NpT+XU3I77hOOGv4ErencsE5sOuWvNgLnRSF091gyFz8gK03xdpWNbL8jVOuUEK6KmHLbrxBEJLkomptjn/L3OA3GHFdwXG95rT6v523B4udzuxMJNi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772616243; c=relaxed/simple;
	bh=U0eVh8rknoxQ5P/LRl2C58ozsqVbhU5VVy2wI8/KjNk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XgA93R9JtmYvskyV/xtNDAAsc/IHrOCf5Md4GqeVYpOZ9tzSXj7B8MprQP4yLgFAs0jdiRIBjxSoIi13xGr2wJV0er0x2NK+kBOQilaE3FTUPytrikQavx8pOuxz4DyphHalBTFxkPzRyH5YhsehcAON7fIZCvS0cQXyC1aw2i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEa+tR+O; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEa+tR+O"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-483703e4b08so62468075e9.1
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 01:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772616240; x=1773221040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TkBHgTSYQa7hABaWg7+/qV6sPwNl26cwPEJnQ76iATQ=;
        b=iEa+tR+OAZspNCY8g/fwcu5KWztPG3GT5F9Ch28rBxjALnM7UGTru78mVEqyUzOzEZ
         60Wosp2/YQyZH/Sr51ku1RQJM1XZU75ltpbGZCQ46wju07ylLTFabqnM65NSV2c6d31p
         lGlffNCr+Zn4tYhJvEwgvGkfPcNGMMOI4CQJhZoi0fJNBgSpsAYvB6gNJJlgV8PyCPFz
         yNcN6qnUN6YNrxLoSuE2roZRxB1YjG3gZHmHx6eDf44gnaKi/wOkb+Tiw35B3WXK7uIO
         A6pEN73njn9m/QgezRF7FsZlpmZSdUS9A2y/GZm5MA5e96ogTOcmrgq2+bM0O7tu8m4a
         yPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772616240; x=1773221040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkBHgTSYQa7hABaWg7+/qV6sPwNl26cwPEJnQ76iATQ=;
        b=weTK8m6uMniyRSZCfW7lKZiKTwm8DFUNTKslVuFVa+QNE4cviKVPrYy6aOao8SiHWH
         U4mwyZhq6eDEe78s2CsHZP87nU8jqyUR5UlIqFYsFYP95X8oo4OFWWDY+kXaNmYA5tE4
         RHB0vbBPmbJXXEGd8INJLkazTayOqAYbaimuh2mVBGNTkv3Ht8dhK/U2xv71eKvNEhS1
         9tPDHDNKcabxg+YcMXllAOICq1GAqsXnPxGe0ROz4zvSfeaHgNo1usqJxmvNkwfbI/2Q
         51EuYOPkg5TfQCJatarBKkTe1IlEGdyjL/50UA5AOnOU8Q/rwa0zZd20Z/7GWCbkN3+Z
         lZ0g==
X-Gm-Message-State: AOJu0Yzs1NSm7kOezpg94CHeKshSRmOyF7Lqd42wHFmue4YDPydrbe8M
	Kdz2e/0i+tzp2+eqvs9454s9/sbuJf3vVWYtDwH+ix6fakLUPCtj0zd0
X-Gm-Gg: ATEYQzxIBAiOiyTvHlL6n5oa2gbkSvnZ+LqFvFfBaazmt8D1/vHAe9hL8tTq0rdB/kv
	oaLKSittEvVCswjK0j0TO8rdmXLhKkapruYWVaL3MnHa7V8s6p1nhFlvUmrXnl0Kn/Fh1tZUGvu
	2KKKpZBfIcsh++7Lexlh8VQ7wPimZ6KXlB6i/GUJeMoqM99vjtD+5xqPvr7mi/v7qgHkrWyv3ld
	GxqL3NUO3nb1FTmcVfs7jskTVK5VQtIeRCkPofwtq7IyGUQzkTEcgGvbvCCIilKhHKOShALr4os
	lt2mm/3kue7NxgHeRphjr7qGzkxaFhAauw5xcP4OoDs/Pp/spB+NTDIkXrR2NbooHqOeRb+xpKv
	L3mgyA3TlfUaZVbpFPVWuCkKaPAVvAgk7nMJavHj09eEYcOhV0VTqq7gX7LGUF1PARt3QkxEkBX
	NVf72XjEeTycy792l/etHnrrHFzDYTW7FVNPt3+hmueZu0IwWCTw==
X-Received: by 2002:a05:600c:4695:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-485198becb2mr21116885e9.11.1772616239290;
        Wed, 04 Mar 2026 01:23:59 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851884225asm38570725e9.6.2026.03.04.01.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 01:23:58 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qing Wang <wangqing7171@gmail.com>,
	syzbot+b4c5ad098c821bf8d8bc@syzkaller.appspotmail.com
Subject: [PATCH v2] bpf: Fix use-after-free in __bpf_trace_run()
Date: Wed,  4 Mar 2026 17:23:45 +0800
Message-Id: <20260304092345.233522-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A use-after-free issue reported from syzbot exists in __bpf_trace_run().

BUG: KASAN: slab-use-after-free in __bpf_trace_run kernel/trace/bpf_trace.c:2075 [inline]
    -> struct bpf_prog *prog = link->link.prog;

The link(struct bpf_raw_tp_link) was freed before accessing
link->link.prog.

The root cause is that: When bpf_probe_unregister() is called, tasks may
have already entered the old tp_probes array (RCU read-side section)
before rcu_assign_pointer() updates tp->funcs. These tasks can access the
link through the old array. Without synchronization, the link can be freed
via call_rcu() after bpf_probe_unregister() in bpf_link_free(), leading to
use-after-free in __bpf_trace_run().

CPU 0 (free link)                    CPU 1 (enter old tp probe)
─────────────────                    ────────────────────────

                                     rcu_read_lock()
                                     old_funcs = tp->funcs
bpf_raw_tp_link_release()
bpf_probe_unregister()
rcu_assign_pointer(tp->funcs, new)
call_srcu/call_rcu_tasks_trace(old_tp)
...
call_rcu/call_rcu_tasks_trace(&link->rcu, ...)
(RCU grace period)
kfree(link)
                                     __bpf_trace_run(link, ...)
                                     access link->link.prog
                                     UAF!

Fix by calling tracepoint_synchronize_unregister() to ensure all
in-flight tracepoint callbacks have completed, so the link is no
longer reachable before it is freed.

The issue was introduced by commit d4dfc5700e86 ("bpf:
pass whole link instead of prog when triggering raw tracepoint"),
which changed tracepoint callbacks to receive bpf_raw_tp_link pointers
instead of bpf_prog pointers.

Prior to this commit, this issue did not occur because the bpf_prog was
directly used and protected by reference counting.

Fixes: d4dfc5700e86 ("bpf: pass whole link instead of prog when triggering raw tracepoint")
Reported-by: syzbot+b4c5ad098c821bf8d8bc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b4c5ad098c821bf8d8bc
Tested-by: syzbot+b4c5ad098c821bf8d8bc@syzkaller.appspotmail.com
Signed-off-by: Qing Wang <wangqing7171@gmail.com>
---
Changes in v2:
- Modified commit message from bpf-ci AI reviewed.
- Link to v1: https://lore.kernel.org/all/20260304070927.178464-1-wangqing7171@gmail.com/T/

 kernel/bpf/syscall.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0378e83b4099..dd491bc35027 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3783,6 +3783,13 @@ static void bpf_raw_tp_link_release(struct bpf_link *link)
 
 	bpf_probe_unregister(raw_tp->btp, raw_tp);
 	bpf_put_raw_tracepoint(raw_tp->btp);
+
+	/*
+	 * Wait for all in-flight tracepoint callbacks to complete so the
+	 * link is no longer reachable through tp_probes. This prevents
+	 * use-after-free in __bpf_trace_run() when a tracepoint fires.
+	 */
+	tracepoint_synchronize_unregister();
 }
 
 static void bpf_raw_tp_link_dealloc(struct bpf_link *link)
-- 
2.34.1

