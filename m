Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB885175A7D
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 00:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782865645; cv=none; b=QvEbIolWWU26tfdbr3OpjD2zHw7KZMBLgkATOUd8z7fFgWow0Ol0rv4lJIO1XLd+fTOaBUyAbx+fcLdyhBIr3casBrACAD3WEoXNm+KDZf3gcbqUZUEmYnKAKQZoWl3gv172jfEnxI+d3nG37tvyI/kRu6l445hwY3NA6OC7jtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782865645; c=relaxed/simple;
	bh=S4fVn2PeBTpmHB2q1rf3L5C81QuZVwdv7TrWYyFvhyc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Bku44vtX84C2p00bfx0nJBDKJubGJ5RcWcaelXPmXqrbJx7gx3bezlJEbnHxKiN9aFNBHsRONY46LKFlAfKEz2cbyYWx5K/oX1wsRoELR51B8KJu9DEaiZ8EQhK1n03RM22Uo2cUIEXXXscx0+3yxe+t20VTdx22jr8JAkuZ0FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=UMcR43zn; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="UMcR43zn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782865638; bh=sFMeXxSTl/HrBHMeIcDbvJwqmfOLH3BmpE8opUaJj0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UMcR43znXXu3RPo/j71pvZQq0qmUgLTzuD8VRj3Jyv1Y9Quqb/nvLD3L3Qti9PBDj
	 t1OwFvn50pUcGQsR6A0yF3fT2d35mkITA0NKfqG1dBiCh8+YmRRbGOZ37cKWrWaCiF
	 6j6YyHoe1Z8eQjlGlmBlehu9FaJQ7bHfTyzHnwM0=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 6CE36C53; Wed, 01 Jul 2026 08:27:14 +0800
X-QQ-mid: xmsmtpt1782865634t8hxpv7lu
Message-ID: <tencent_70F825FB8D959232DDCB5DDC991ACFB40D07@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5/1+xTilerq8/Xml2eD6MFSIKpHgZi0fF+y71pkML46d8QSmuak
	 18MtSy9T/h4qt1wwhhOuyH49cqIQET4FqJbAnn/kiwqjPkPELTwkm+FntXIXwr71w6cqjGWnZr3T
	 TjUhdxlRZxYUhmxAXwX6ePc7aKxE9Rit0AP59GX2tgjIZqeyJENuord4ShiJsOioNdyBbUMIsUOS
	 3KNMDkatSqD67INoir6Iu6hpdcqG5GnQwr2/uYvygEtHooV4poenlGE1EhQar4Uiz0iLR1Dl3m1I
	 netdaPR/QFGLZ1o4uT3i6Y9GZI/oar99r2Sc//mieQxF3Mjh9knNWO8+B5/ixbATKD7D0SoZaOoD
	 +FUU0RYXkIoG1iPS7oxM/KXx+7m2AxjbJi/BkUdqpWroe7zbnvU7XjQP/gSTurW5AQhtx1DEY5BW
	 0EI8Vxei6B1CRMmyKFjSHhmyrPhbMDO6ZhRIyaQWunZ04G+2NBfF+AN5+Tp9+GoIWbJml3wxbv4+
	 RbKQTQo49mq9x61AiYpvNOu9UDTvK0tzRXENGspl5ogYKc6og58jhsE2uK0Fx8bS1vtMqpXMKYoL
	 bNtlYZP1wv0P3c2zK1vy3o1sGjEukMczGismy7qkBI9PFwLYceIG/MXkKQnT0QeWrFZGuC15cueA
	 TdjuRd88ItPXIrlsig7RV32Dj69VYA1ubK0wMxdzwvOX1MwF8QlT89UXVaHZLurL/d3Ck8QJvHWl
	 4wWktgzuEwpmOABOI5bYSA4fAaUVCnw6KGkCDYNXYUgSHf7LyHsZBDWvZ1bLF0N2VEDoJ9Sc3lov
	 fb3lE4NFULvmjoS2ajbMzL8hvnJ5NrvQMlvz3FNH3xOiegmzgqOeNzBjiLxUumYB4gla+Jl5JDNz
	 KKnwdaq/09pwwNR3qgVC2Up2KqITlJRV8h8wSOrizunIWNMjChYHRyPH+xkZZeeYrFhfXl36x5u8
	 ZxpGq5uuPI0n2SkJGlv8u/HCbbnyqb+JmX/JvYazeflmbUF/d0o2OVK8N1+kxQMxVEESvD4DXApL
	 NSFhRDQmiPF34ZTBvMQ1agdVi8JIs=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Edward Adam Davis <eadavis@qq.com>
To: sashiko-bot@kernel.org
Cc: eadavis@qq.com,
	jiayuan.chen@linux.dev,
	sashiko-reviews@lists.linux.dev,
	andrii@kernel.org,
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
Subject: [PATCH v5] bpf: Fix smp_processor_id() call trace for preemptible kernels
Date: Wed,  1 Jul 2026 08:27:14 +0800
X-OQ-MSGID: <20260701002713.969502-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630132226.C44601F000E9@smtp.kernel.org>
References: <20260630132226.C44601F000E9@smtp.kernel.org>
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

this_cpu_ptr() requires the caller to prevent task migration.
These helpers currently do not enforce that requirement and may
be invoked from preemptible contexts, leading to accesses to another
CPU's per-CPU cache after migration. Use get_cpu_ptr()/put_cpu_ptr()
to pin the task while accessing the per-CPU allocator state.

Fixes: 5af6807bdb10 ("bpf: Introduce bpf_mem_free_rcu() similar to kfree_rcu().")
Fixes: 7c8199e24fa0 ("bpf: Introduce any context BPF specific memory allocator.")
Reported-by: syzbot+fd7e415d891073b83e1f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fd7e415d891073b83e1f
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
v1 -> v2: using guard against preemption
v2 -> v3: replace get/put_cpu() to bpf_disable/enable_instrumentation()
v3 -> v4: disable preempt to make this_cpu_ptr() work
v4 -> v5: in mem free disable preemption

 kernel/bpf/memalloc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index e9662db7198f..2118fe725ed4 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -911,7 +911,8 @@ void notrace bpf_mem_free(struct bpf_mem_alloc *ma, void *ptr)
 	if (WARN_ON_ONCE(idx < 0))
 		return;
 
-	unit_free(this_cpu_ptr(ma->caches)->cache + idx, ptr);
+	unit_free(get_cpu_ptr(ma->caches)->cache + idx, ptr);
+	put_cpu_ptr(ma->caches);
 }
 
 void notrace bpf_mem_free_rcu(struct bpf_mem_alloc *ma, void *ptr)
@@ -927,7 +928,8 @@ void notrace bpf_mem_free_rcu(struct bpf_mem_alloc *ma, void *ptr)
 	if (WARN_ON_ONCE(idx < 0))
 		return;
 
-	unit_free_rcu(this_cpu_ptr(ma->caches)->cache + idx, ptr);
+	unit_free_rcu(get_cpu_ptr(ma->caches)->cache + idx, ptr);
+	put_cpu_ptr(ma->caches);
 }
 
 void notrace *bpf_mem_cache_alloc(struct bpf_mem_alloc *ma)
@@ -951,7 +953,8 @@ void notrace bpf_mem_cache_free_rcu(struct bpf_mem_alloc *ma, void *ptr)
 	if (!ptr)
 		return;
 
-	unit_free_rcu(this_cpu_ptr(ma->cache), ptr);
+	unit_free_rcu(get_cpu_ptr(ma->cache), ptr);
+	put_cpu_ptr(ma->cache);
 }
 
 /* Directly does a kfree() without putting 'ptr' back to the free_llist
-- 
2.43.0

