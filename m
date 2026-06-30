Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297DB3EAC74;
	Tue, 30 Jun 2026 09:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782810709; cv=none; b=rv/QpUOXfzEYiQKpCBba06co1nszdA5vrlwxJCiriQf3uMCyvL+/UtaiwwgM+wAFkTL1A+Q/eEkpDMwsP2ZiOMjs9HrhVwzmBzpW/Yvdlm9/5MGniFXYZQN7O5DP1qTX7DjIF8ge+rYAMPQcGKVnRpwblQAC+T5/jIgSLBdeNZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782810709; c=relaxed/simple;
	bh=kySt2e1rfj7LptBox57g7w5ICPrmxbvLWzxRFUNeSIk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=KznotneQy8kiYmQMBtaPjZLpwaEj45hfBrCVGetWX1ynPL9rEuxWq2ajTPr1tpgnaKMw02NNLwKH07iYhpYpuH92zoDvTLR+ZJQaL1lnQmd+zzPfng+ws4ntML5uB3c4Buhvt6vY0+dDiHqtIosNCdNRatC8m5CDIsYyrrqBM2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=PsG5sMtN; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="PsG5sMtN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782810699; bh=1dfi7biA1sGA59UN+588jwNbvleUJ44ok6h9LBwNWnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PsG5sMtN7gOH+c/kvH0vPU7sVZTyFmkMxunKcaaHBtkHDHRuY+NL6f77ev9r6Ewfu
	 ynOBqFKbQvzzDhnW7c9QkdPS9C0nM3Isnd1IeYvrWCpEnq7tNM075cd8VkDMQYRL5V
	 K6Bex3Q3jjpAA4bF/oaN5HFOQKslMnGmeJf59bPA=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 2E201616; Tue, 30 Jun 2026 17:11:34 +0800
X-QQ-mid: xmsmtpt1782810694t6vhyvnda
Message-ID: <tencent_45066D89AD6EF9AED34CA567FA46CA52C606@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjxnsilrLdrNDiNIRRjgkkepro8vxPt12NBctPvNYFwCeu81DM9Z
	 OfV9p6l/T41Jd7iuk/0sCvJQp27jU2a8CqX+dbCRmFWqGdxu+EEQZ7Gk/Cy44shP0EY5lPVZoZsg
	 RFQ811puuNOmncYOKpncYqU/JwF8Ue9RIV26QJZCXvJywPog5kzprRTKcagiwtitp9GFnMFF8z9t
	 h7w4NWkt/POpJZylA3b9sfRSlDUHR/vuJxrYENwD1yJ5AiYi+XJ4L75UJLZYBgyqGusmN7ajLlCW
	 9NFj9zHo/XHVAM9ifgBGbcV+ccU/E0N7ihtM4+Lp5GbqqWtjViujRPi5Y63R11szcpGvCTJRiwkD
	 6AUBajf7g16xLSnWyOpIYM2EAr0S7RQhIKK6ATOA9s5UgU3jv5PDZmdE7gsTDZNiOlnxYQjtkCj2
	 97Xa/k+UfZvtFLLZLZMjtOaNFW5QzqYlS5mPpvg02rbpvtuCtb+tEF1zD2qi3dP+lVL5Cbe9zEhE
	 wveQsB403beKq0POyjCojG3k/BOsFbX1UdWKePkSYqRtp4CmpU1zJWgVh7qfVOwMYGWAbLxs8FD5
	 Q/+pN7MdZtvkqN8Uo9DZrBZorS2st0JEArCr93+un1raqkMAm3h7CTxVGWfAjfKSWN8Z5ZdMe1tc
	 MbWkNbDrDk8+1/8Ym78hvkm3h3Jia8BRDj5docEiLxwl61qZdvPUfm4zQuvfWwN0Q46HsRwxyNpn
	 HZQMCKTHaE7zXWO/1ph8+/79fu0Gc0CtlND9QzPNE9lzuBWiqjN3bkCujGPE0sOSr/8fIobtQuaA
	 rL/c8paAMIVVptF02XVSEr1oY81Ab/PC3Jun55jNC9DZkuifWxRv58UbfLJ+cejVWYOqD+5UCtvy
	 f1ImAa15F0cNqwm8GMuYv7lNkDWxto5R3zvXi3cCPLXp4zkx7DOPsIdOxtqDKSmPAjB2ej69Edvc
	 5N17TF5nSxzg9M4FDGwmgneHMHLOX+5BQhU6u4xfybG/+9FsHip+ukJJWZz+Y8/hkmu08AFTVUXv
	 95VN6HYt64DzETfL1I7GdlAbO0DQDMcShe97JLS31So/nlglm89spHRfvsH62SFGqnMlDUZ+ulWY
	 9yVaYr
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Edward Adam Davis <eadavis@qq.com>
To: sashiko-bot@kernel.org
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
Subject: [PATCH v2] bpf: Fix smp_processor_id() call trace for preemptible kernels
Date: Tue, 30 Jun 2026 17:11:33 +0800
X-OQ-MSGID: <20260630091132.941145-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630084910.D5C3A1F000E9@smtp.kernel.org>
References: <20260630084910.D5C3A1F000E9@smtp.kernel.org>
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

this_cpu_ptr() access needs to be guarded against preemption.

Fixes: 5af6807bdb10 ("bpf: Introduce bpf_mem_free_rcu() similar to kfree_rcu().")
Reported-by: syzbot+fd7e415d891073b83e1f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fd7e415d891073b83e1f
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
v1 -> v2: using guard against preemption

 kernel/bpf/memalloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index bd45dda9dc35..1d7ddfc1c9d1 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -957,7 +957,9 @@ void notrace bpf_mem_cache_free_rcu(struct bpf_mem_alloc *ma, void *ptr)
 	if (!ptr)
 		return;
 
+	get_cpu();
 	unit_free_rcu(this_cpu_ptr(ma->cache), ptr);
+	put_cpu();
 }
 
 /* Directly does a kfree() without putting 'ptr' back to the free_llist
-- 
2.43.0

