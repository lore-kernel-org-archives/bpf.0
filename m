Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632C12D1916;
	Tue, 30 Jun 2026 08:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782808926; cv=none; b=pvUUpdQGhYbJIgCAd/bvuJ3joLpys4dIK6IF8JmXtRjWYZK9WZeuHR8pFGQHA16uxhV68kKgI9H9OslbJtywNd97ma0N8ydRNkjz60YHlWxcXivRsVcI5NRZttXNsprBstvA1PMo/cOVu6/qFnB2KdNSqSbuE32TVsRXrPmjoag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782808926; c=relaxed/simple;
	bh=ZfX+WUlidGt3MD9RKL56uLQHVqdQY9yPw3YfZBPiEmw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=CSf7KMSXyd+jFwIuFaBj0J2jaga+p4lZgRxg2hNBSfFeMOF9MrRi3uuCCylm4WnchlXHlQVzgcU1x7J70u6wLigcvu5uMLJH9lw4f12LV1syr0oMSpgyQR6mgtpYCeSvQ7Q1Jc1vFERiRkVX4vu+hauAHvsUJMoJknb+hbrWWpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=f/UhJW1O; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="f/UhJW1O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782808912; bh=PgRWuavyvpcMX6a1mtBTkd77HNcfXSkaUDGACw6U90c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f/UhJW1OAGKo3j7rkLAdm5+QtQ9alnIt/PUBTKkjG8FizMidQMgERc9N+S4+DR48J
	 mlI4zp+28fEvZoFMnkLbpAANSRug0dPXfiH5sirvpgQKlH3NgPct6/dCzYvQcFqacJ
	 fF/6WWoODJ/8PuNnHsXO1goatrbQPvxFlE1lDMig=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id A70A549F; Tue, 30 Jun 2026 16:41:48 +0800
X-QQ-mid: xmsmtpt1782808908tg9sujbui
Message-ID: <tencent_C4C3064909A16EDCAEDB0C8767D886D01206@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJKjm/DmkFv2Zcms1KQYsBE/KFXP5xNItufkG88nBulvvPq39P0y
	 ZZ5FzOPXrTsJZiV28EKON9rArzcCq3ZRv7qoiVDQ2ARMRH9RLvOuF7spsBzyAlBVWh3OZ7h1i1Dt
	 ekefuTX+GiCYntHA4SZENZ76AlsCmILx2k3PPV/ySXCnMqSS7fhzpbnK/KgoW9IKhxaqVIaOHBst
	 Hf50O8ZQEjkhBqXeUz8H1lsYVwFGPKRp1OkWAfQ6zI2w2O+OqsauVHNOJwOmbmtNOtwp++v3MFiT
	 EegC5f8zENP3viKP1/oRNxY8y4xOHfgSdkxGS4MOpEGwV8GjjUQuAvgO0pY4WvOjenzvTtqZo4kr
	 BRpoG99aExz7JK6jOgDTMEO+ynhn4lwZQQ1+ooq30GePYXZMw8ML6uPnCEs0tZpP1bouVEGdVgQ9
	 d+AHHrw/uPUmFe9NedxzWfmDUOWUYUc1igCit1ZylOcTDrX3Ce4aAr39qbuHBUiS+dcOyTFqOGJU
	 q7v/jgZzpRrGfXAh2lGTTaTezeCLywlUDK/aS1YojpY820EAV3Hmd20Omun3+kv+glJzvlU/J/iB
	 8KS87AX9EapvR8Q1m8/sJaImnDutYRqN7qSM12162jju0QyYQXOxwQGDrbCwQmQ73TWzu9FWc7Ld
	 140zx9Fx745alcEUbNUY4BNWdIhWu8NpHDeWvdG7b/oYVA8tPq7rGTJQOqSshE1fwacEnHGUI/lF
	 kgRZVuKylrEhkC04l7uS59De7aZf1uqE3NvNlkBw2k84Bj4oEdIfo0MbK9nUJyuY6nJWrPqlqegb
	 Xr4Bej+xa22qAHDlIqThIxzEyFfLuFi6lEDQ1kz3AjF9bhXINzemUGR8OnlcxCstXQXCcuOKRc9P
	 WUnhK5SkB+156JnO/9bCOWcff1OZwFBn36nVZYfxnsFc+ER5saG6ScZNMAdhYEyaAUZ99L0tS9cB
	 y5HgiZ8mTb81IZ8zZimQ86JEyk4Fz2xB5XdYYE3uIIwZF8ApR/OG5D4tsKmqIrYHWZiIwrRmwfG3
	 TfF4cJ3gvJevyddGCE
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+fd7e415d891073b83e1f@syzkaller.appspotmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: [PATCH] bpf: Fix smp_processor_id() call trace for preemptible kernels
Date: Tue, 30 Jun 2026 16:41:49 +0800
X-OQ-MSGID: <20260630084148.938854-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6a436023.b42ede87.8e801.0003.GAE@google.com>
References: <6a436023.b42ede87.8e801.0003.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_mem_cache_free_rcu() maybe called in preemptible context, this
will trigger the below warning message:

BUG: using smp_processor_id() in preemptible [00000000] code: syz.0.17/5820
caller is bpf_mem_cache_free_rcu+0x48/0xc0 kernel/bpf/memalloc.c:954
Call Trace:
 check_preemption_disabled+0xd3/0xe0 lib/smp_processor_id.c:47
 bpf_mem_cache_free_rcu+0x48/0xc0 kernel/bpf/memalloc.c:954
 rhtab_delete_elem+0x185a/0x1b30 kernel/bpf/hashtab.c:2969
 __rhtab_map_lookup_and_delete_batch+0x935/0xcb0 kernel/bpf/hashtab.c:3349
 bpf_map_do_batch+0x445/0x630 kernel/bpf/syscall.c:-1
 __sys_bpf+0x906/0xd90 kernel/bpf/syscall.c:-1

this_cpu_ptr() calls smp_processor_id() in a preemptible context.
Fix by using per_cpu_ptr() with raw_smp_processor_id() instead.

Fixes: 5af6807bdb10 ("bpf: Introduce bpf_mem_free_rcu() similar to kfree_rcu().")
Reported-by: syzbot+fd7e415d891073b83e1f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fd7e415d891073b83e1f
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 kernel/bpf/memalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index bd45dda9dc35..151d9c8183bc 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -957,7 +957,7 @@ void notrace bpf_mem_cache_free_rcu(struct bpf_mem_alloc *ma, void *ptr)
 	if (!ptr)
 		return;
 
-	unit_free_rcu(this_cpu_ptr(ma->cache), ptr);
+	unit_free_rcu(per_cpu_ptr(ma->cache, raw_smp_processor_id()), ptr);
 }
 
 /* Directly does a kfree() without putting 'ptr' back to the free_llist
-- 
2.43.0

