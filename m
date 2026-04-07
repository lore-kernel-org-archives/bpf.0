Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849033A7827
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 12:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775564643; cv=none; b=XpDbmNKaSHUlGE9ir/i6LA4iGOD0h0/EtbfnuuICzMjcrQSPlObdRWZj5wUfTYAya6XGApWe8pGxhfgIB7Z5MgZwQUZFlCP8gMSm+S54fNn5Izmt/ZqaQxcm9vkjfOiw8ECp4/m1F0SAtygeD+fwG62ArnjHIvN75eSnZbECv0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775564643; c=relaxed/simple;
	bh=a9hyKY5spvWij0IgoVFNrQXeW2pmP5a3PGtD7rIUxMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cPo2WZ3hH8Mn/Nf5NOygFrv2znfdr0hzDUO7gT529pfFboMyQNQ2Ithz7vLJvIqnDbzTgSBIU3vYps+BlYAyQ6MU9rODJBDauP2ndmmnTDJId8kIb1+1+rzn9p4UoFxfxQYblL9F3riqX9OPQWJWuQNsVvMHwNRDFYRtW2I9+AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XWz9Tcjs; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XWz9Tcjs"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775564630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZRzvcqnuvpSHx+xb15S2TwtDUeBRFUSsWiRQyo3ePeA=;
	b=XWz9Tcjsbqf2Y6dkritCsUEZBwtoCUNwFqd+iH+dCoFfslxKWA3Ezs632VTGmo+kxTi+Xt
	MeaNAuhuVEw8cSpASRkTX0vSYA6nIWgtl2LAAjRHF09SKFTabIaqePii664O2uQr9KPgEw
	T++fNsZm2+NNiSMS1kfgt4/EX7vKqZ8=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Quan Sun <2022090917019@std.uestc.edu.cn>,
	Yinhao Hu <dddddd@hust.edu.cn>,
	Kaiyan Mei <M202472210@hust.edu.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf: Drop task_to_inode and inet_conn_established from lsm sleepable hooks
Date: Tue,  7 Apr 2026 20:23:33 +0800
Message-ID: <20260407122334.344072-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

bpf_lsm_task_to_inode() is called under rcu_read_lock() and
bpf_lsm_inet_conn_established() is called from softirq context, so
neither hook can be used by sleepable LSM programs.

Fixes: 423f16108c9d8 ("bpf: Augment the set of sleepable LSM hooks")
Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
Closes: https://lore.kernel.org/bpf/3ab69731-24d1-431a-a351-452aafaaf2a5@std.uestc.edu.cn/T/#u
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 kernel/bpf/bpf_lsm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 0e74325d96a61..c5c925f002021 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -359,8 +359,6 @@ BTF_ID(func, bpf_lsm_sb_umount)
 BTF_ID(func, bpf_lsm_settime)
 
 #ifdef CONFIG_SECURITY_NETWORK
-BTF_ID(func, bpf_lsm_inet_conn_established)
-
 BTF_ID(func, bpf_lsm_socket_accept)
 BTF_ID(func, bpf_lsm_socket_bind)
 BTF_ID(func, bpf_lsm_socket_connect)
@@ -381,7 +379,6 @@ BTF_ID(func, bpf_lsm_syslog)
 BTF_ID(func, bpf_lsm_task_alloc)
 BTF_ID(func, bpf_lsm_task_prctl)
 BTF_ID(func, bpf_lsm_task_setscheduler)
-BTF_ID(func, bpf_lsm_task_to_inode)
 BTF_ID(func, bpf_lsm_userns_create)
 BTF_ID(func, bpf_lsm_bdev_alloc_security)
 BTF_ID(func, bpf_lsm_bdev_setintegrity)
-- 
2.43.0

