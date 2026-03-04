Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5FE226863
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 07:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608183; cv=none; b=jFEw+dbwZtIucB8f2i2lOBaYDFHwo3Q/hoYjy4t1EPSVeeET4L78fpOIQ/4ZbBwl3CckPmbQw5XzxmKtyE9lpGMAY26dup4yTtx/suPw2uTJN6P1uP/eYlrqXNInCwX83glEMjlx6dKuTsds+wuvjlOncnWBJJHFHHHNZWohbL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608183; c=relaxed/simple;
	bh=4d/pDtjsCeJbpYXYsN17tpsk+pR/bruOy5b6xlGmRdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bcw5b+1EH4OsmUr9ZD8Q2OqduNad09ke29ZktVMiwTEJ9ggKCsVjg8rDxK1DjAPkm/zx+xYFXuXo7N5ZdUWicyYTtkvBUOfsDOs0xQ9fdnhNjIwTmH3g7ZRuqEt3Y/yUIrt7Ko2gv5tBIz1v9bN8U5YTYpjlGLavnJNAcCE3REI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOonlHRw; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOonlHRw"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c648bc907ebso4107981a12.3
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 23:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772608181; x=1773212981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nQWG5MjkMMO6X/T7/5cytYtSTJXPfn5rr0LrLEyQ9mg=;
        b=gOonlHRwrIn5gvqocpEdfWpHl/04k8qEAuqw/klMPYhlaYghN1uqrhcWyWOKCavxPm
         2FW4E4krr+gXnoka01bL/vGSOcrRK/t/PoQx4tats9Gt5GSLKg0GnuVe92ynsQy/GijF
         docCnkNxKBWRH5NyJqxx1MOeIJxjkUoHsOCvsehG4n04rfCirmqeMJEXAb2faqlRJ1u9
         wK3Pxjy+bD9yCZGj7Z722ABQ6RECJ0Pvkkjml+MmFB0Thobr9L+9Smaf7QSqj7sSHO9C
         s09qP1unAzBxgxnBDYKVeCl8eJ4uL1ufX0eAdDt+v2C7zfr4xfCnLDYlwMWSo5u0livY
         V6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772608181; x=1773212981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQWG5MjkMMO6X/T7/5cytYtSTJXPfn5rr0LrLEyQ9mg=;
        b=ulzK29wgdZ+/XXTwBFWNGwgPUkFNE4DLqSQMwmDuduo9AI+Xz57Bw4LZryDIuQcnL5
         bfqDtXw3O/AIuTvDIChEt+CDrc1ObVTftUwo/S9Nr1OHptdedZ5ZRzKks3pAVcN/5iHM
         fJ7zkpqtWWYuJIkY/JH7Gn53TRoPROmvP2gK8+UJbgXBBoMsc+bgu94hSnQoXXLjULWl
         LYuI/5HfqEuEVGjsZrXbW6Lioy/dEI6klxjGZlOxhddr42qWCRnWZb4kcxdLwiovlof7
         zgA7CCX4vUgNtItQneAnWpgbypswSRBsNJYHgFXMIzbcwFNhMO/yjKo0a+pqRSJhrhcj
         rhKw==
X-Gm-Message-State: AOJu0Yyvnpmx1s9ncFqNv0f4wOvm+fE/cgfD+EqPY45/0cAY+xwCTGVY
	dWwYVuYwT4Zfa2qXBOgB2TOvdYtyW/Mmn+UHkzqNSTduZPzdi+W6xXG7
X-Gm-Gg: ATEYQzwkbymw6ZNi5b92Ul7zQRvSi2q0BspVwWbU87LkwHW+mFBa46xAfst1+qR9L6z
	evOtxVa7QVKaX8LHya/VD9fIUcb0TuIIfHrTilX/ESnSRB2EE9dJAjaDlu9b7ksqm3QQNNT73jU
	en8rwkVBsXgsWnBGnwZ6gQ7VvWZSlEkrv4F9UU73NRJIqUnjtYFcrsxjlIEqZbVBHN0zhC5+5oA
	E+xEcXeGZNxFM3+ww4xppu/gspL6FU5Ev95ddsjQSuaGy7t9C5JGKt8her2EFMiNwHyEEKHecF7
	vXzQQLWv3E8lU4VksA85gm56zRVJNao+EJ1t8xJq1Rfl6qqr3+Gb3kvUV0VtUoLJmj0EhA87+TM
	/axl+oZq2XERsaB4mcgYKIdWBpmKwLdvjMAfy/sZ83vdOCZOa2fc324O2xD+49Aj5VwGAYJv4K5
	zTuIt2nBfGXRVtvbD/hsGVBTUdRN1ZJ06q17RWs/1yIs4qsmOvmA==
X-Received: by 2002:a17:902:d60f:b0:2ae:4bd5:a7f5 with SMTP id d9443c01a7336-2ae6ab6a1b3mr12636425ad.56.1772608180842;
        Tue, 03 Mar 2026 23:09:40 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6b416bsm190980875ad.61.2026.03.03.23.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 23:09:40 -0800 (PST)
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
Subject: [PATCH] bpf: Fix use-after-free in __bpf_trace_run()
Date: Wed,  4 Mar 2026 15:09:27 +0800
Message-Id: <20260304070927.178464-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A use-after-free issue reported from syzbot exists in __bpf_trace_run(O).

BUG: KASAN: slab-use-after-free in __bpf_trace_run kernel/trace/bpf_trace.c:2075 [inline]
    -> struct bpf_prog *prog = link->link.prog;

The link(struct bpf_raw_tp_link) was freed when link->link.prog.

The root cause is that: both bpf_raw_tp_link and tp_probes are RCU-managed,
but there is no synchronization between their lifecycles. The link can be
freed via call_rcu() before tp_probes is freed via
call_srcu()/call_rcu_tasks_trace(), causing the link's lifetime to be
shorter than tp_probes. This allows __bpf_trace_run() to access the freed
link when a tracepoint fires.

Fix by calling tracepoint_synchronize_unregister() to ensure tp_probes
is freed before allowing the link to be freed.

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
 kernel/bpf/syscall.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0378e83b4099..fc93dd544162 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3783,6 +3783,12 @@ static void bpf_raw_tp_link_release(struct bpf_link *link)
 
 	bpf_probe_unregister(raw_tp->btp, raw_tp);
 	bpf_put_raw_tracepoint(raw_tp->btp);
+
+	/*
+	 * Ensure tp_probes is freed before the link. This prevents
+	 * use-after-free in __bpf_trace_run() when a tracepoint fires.
+	 */
+	tracepoint_synchronize_unregister();
 }
 
 static void bpf_raw_tp_link_dealloc(struct bpf_link *link)
-- 
2.34.1

