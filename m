Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C4F25771
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 06:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769581089; cv=none; b=MFR7ATiRd5e5uBnuzH64kxZ9VNTZExBAC82LCLPtwwimsDP4/cH8FafQC6O9ycn9xSgT1qEZ3I1kLUduT0jXmtToC6Zqpp6O9UgiRpghkp64SOtPBq6/KhovCAXBQb3pjNvLH7esue4TuFmX7oKAuSm6wmFoxsugY4y2yhVdp3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769581089; c=relaxed/simple;
	bh=BVQ+5t+Hf4wV1jIPnuyirQ5UawcbijD0vuqg+0uHdL8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ewr2agnuZgwCqa7r2MnAEnTjLz+CQoklsyYiF+uL0EjUPOjybUnmxr7++zUlU2l4jRqGIx6io7ipbs5euJNDCfe5iMaY0X1aV8CnVigO+V4h4S8f84VvgkHbbLSgvsuh78uhkvEVgU9T/mmGeVMgas9nxANx9mvamEUjYI0g06c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJ1apNzB; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJ1apNzB"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a0a95200e8so44094125ad.0
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 22:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769581087; x=1770185887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bXlJRjEpT0CKX6a0WZrAnqYbp473ZZ+LFCiXXLocpIA=;
        b=EJ1apNzB014mOk6KGK2JuSP9KuRJP21Fpha6UzOzQpDjJYwz/wXEysYMC65HZeRPa3
         6f8FoBLsLO4at4e0jKCE7SMYypaaXVO+M3dp/UZR1msVFpoAY580Koo8CbXMVIGj+2yX
         aEBCfsKXHI4holALg2lDMwhzgZexoqz1lB33igBsmVUWQVpoloo/KrIg9Cu5N0JVMpQ2
         JRed4PyU1DjlXGd92sHgQlGIpxaBLWCBpYdK1IsR69INjqfufWHzCAc0/NEA+liEYx0c
         +kvqZsUgaygknHkPaHfNl+Wh1i8U9v5hmP4k7ukBYVPD1NEl2EYJ6wTCNVCxJFuiC9GX
         Gn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769581087; x=1770185887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXlJRjEpT0CKX6a0WZrAnqYbp473ZZ+LFCiXXLocpIA=;
        b=YXM5Z0zczWvBqWTfDIC8j4yzvv2uvh043tHKEV8PIOSxdOXweQmcwlgfE50gqSfPAS
         Vw7QgK8GYUDA2EvV1+y+9HVT9OlfT09zMY8lf+eK8upkjtjmfL3w648ccRQZa6TYKXFq
         IiiNh0kDlod7ESz7vMbMQ+HvT1lfp5V4TiOgGL6yLLUcq19YZF2HvjHV9bpI9vK0DSKr
         LqHj/nEUZMN23civ8BVB2QtwcVhLyMEi/CUa8ncVnx5qyPTtdVpyXNckSDWM0mlUL1Pv
         wU4T/8NCxVB6+o5LFWvDQfjsTG1evMbk+gh+dcacqWXaEB1fH+qcCgLZsvX/j3/9lxfC
         bxkQ==
X-Gm-Message-State: AOJu0YwUymvm+Dnnmc2Y7ff4syw9grSok58hRHSP7zqf8eWExAioNRT/
	bs1jekW+DxJY6GvQ6sj+OVeoRbGLwk8cZscS79AVF/ox5gyWS1yD7dmB
X-Gm-Gg: AZuq6aK2vLhOUEgFDPAKq99faHE0AqZZdPGOg6VvKYJOnvVY56V8Y6XlM6lLQCXXejc
	1vpH1ubK5S8E11cYdMJD3hX3OCFxPkU2E3zB53fGGSrG9pUuCV75c3KINNmt4IZnOwptZ76HMN8
	AubZ+as1BMjMuI9Wc6Dpr+Gjlf9fYwnfe91zafHGSE7XBbxL9KTwDbg94EqTgsgCQLwyerKGAEJ
	ujN7PA3RTOx1F/jdp7slAfjGsxM95io7Zkq6+oRLb4C2+7hRfz1Wcl8yFbb9LfG8yTsQr2/vcNp
	v4AZiSw/yWBLeDDoLLECw5nUOY7iqcMFQmsgWZN5fmS9zCmiydfUjkW8k/f49IW+oiPFrUX4+eI
	8RSfSiqw+J8SSNWoEANJHN0OEtuln/PkiZ1vB2avOR4xhvcKWEHF/mFACM3Lv0UM+8NBYWR2Zwu
	3KKVNCFqockB6VX40v7RYwLeJRkUAU357jkv+z5g==
X-Received: by 2002:a17:902:ce0b:b0:295:3584:1bbd with SMTP id d9443c01a7336-2a870ddc619mr47181525ad.41.1769581087372;
        Tue, 27 Jan 2026 22:18:07 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4c3dd4sm11591535ad.65.2026.01.27.22.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 22:18:06 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	peterz@infradead.org,
	acme@kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Qing Wang <wangqing7171@gmail.com>,
	syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com
Subject: [PATCH] bpf/perf: Fix suspicious RCU usage in get_callchain_entry()
Date: Wed, 28 Jan 2026 14:17:53 +0800
Message-Id: <20260128061753.1857803-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a patch intended to fix suspicious RCU usage in get_callchain_entry(),
but it is incorrect. Specifically, rcu_read_lock()/rcu_read_unlock() is not
called when may_fault == false.

Previous discussion:
https://lore.kernel.org/all/CAEf4BzaYL9zZN8TZyRHW3_O3vbHc7On+NSunrkDvDQx2=wwyRw@mail.gmail.com/#R

For perf's callchain, rcu_read_lock()/rcu_read_unlock() should be called when
trace_in == false.

Fixes: d4dd9775ec24 ("bpf: wire up sleepable bpf_get_stack() and bpf_get_task_stack() helpers")
Reported-by: syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=72a43cdb78469f7fbad1
Tested-by: syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com
Signed-off-by: Qing Wang <wangqing7171@gmail.com>
---
 kernel/bpf/stackmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index da3d328f5c15..f97d4aa9d038 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -460,7 +460,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 
 	max_depth = stack_map_calculate_max_depth(size, elem_size, flags);
 
-	if (may_fault)
+	if (!trace_in)
 		rcu_read_lock(); /* need RCU for perf's callchain below */
 
 	if (trace_in) {
@@ -474,7 +474,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	}
 
 	if (unlikely(!trace) || trace->nr < skip) {
-		if (may_fault)
+		if (!trace_in)
 			rcu_read_unlock();
 		goto err_fault;
 	}
@@ -494,7 +494,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	}
 
 	/* trace/ips should not be dereferenced after this point */
-	if (may_fault)
+	if (!trace_in)
 		rcu_read_unlock();
 
 	if (user_build_id)
-- 
2.34.1

