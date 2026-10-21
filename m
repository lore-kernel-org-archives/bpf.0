Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792620044;
	b=0s+rq9rhtJtKmb0/NwVEEKzoADSvqoYI+WOS+Jpi7ln+4RYp6ee6oDZioi1IWR+XhNVs
	 6y+VWppfiiYCttQkxqjsqz1N0c1BOQ5Aip47AqGwF0fXPLIOgo3nOqA0yyFlQmRexeLnG
	 W6aL6YQj2cx0VFGGnItJLjOJk4zkj5eEoPTaeUyb6ZU6tBPXt337mygWuC9tjIHA/uzb+
	 ZWho3v4vIsYeymip5ZF99DIojazO+lX61tPRd17l+tKXE75S2uy3F9106x1kY3wq9Kr5E
	 aWq8sAvbA5LvgW7FY61D6JUP0hfS5/f5FPUwjIRqjF/KUUVN8DufLZag72+w5iFim4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792620044;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:X-Mailer:
	 Content-Transfer-Encoding:MIME-Version;
	bh=SK1JHY4Qru2sKfE7pI5aCFA5cz9Q9hLtB1cww8qn0+k=;
	b=qVKX0bFQJyOdTLm15VINIG5IvIoDE6Q0i2GMb4++utLQWNOvyrkUdkHYxtwXwd+I/O/3
	 WswIScR8hnIJZGb5bVRMvD4pR+3crgtzontxw4v9Y0FKkF7k2De8IX4gIAX6rRxylz8CP
	 PGtSjaDmb3xldzp/viE+FglRv90QlL1JZb1jNxJFTc5jXNQOLtAAgjT7BT3vtCIspO0Lv
	 xO8/9HQ3Km/yYHMuadgCA3XoWWvuosuW4N3DjyEz4at4zHqD1LnImi7K97Ou1UU/oR0aj
	 23a898YP70RlgLFY7lgecBCpIpni0g5llJ44hZdb3tmQ2AMW3x8CQUmn60lTVbO0alQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kw2epnKN;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0937B606A31D
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 22:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0937B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kw2epnKN
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ad787e0593so729857a91.3
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 15:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792620043; x=1793224843; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SK1JHY4Qru2sKfE7pI5aCFA5cz9Q9hLtB1cww8qn0+k=;
        b=kw2epnKNy3coxLIdT1Cnm8BfrHqUpoQ+Y+z46OX+2qx/VVDSgSZ+7m/Sibigly9aaK
         WW+VQBqUpie6FUqf8e6BSO7Xju1gVy0ZrNiWwe1OYd8ODgE52Z0abqZkeTL4znABYkGN
         p9/04ByGJecPY3bVDGl0u6GLz+3cKTkU2n+4jpGsr+1P3KE5J4HxF1/EoP5SpCryjdiJ
         Bnd930g0HXrSZGH8h3t38a7iRlfreM23K0ajJE8ASo1oIRGKzYvntYf6/vzGRQGxh5Rj
         9jh/vMpvPj/zxGb4kA13KcWgRUAdfo3jQiAzjSTT87/QoBJvHmnkQnO6KkcBTzIkgq14
         Y2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792620043; x=1793224843;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SK1JHY4Qru2sKfE7pI5aCFA5cz9Q9hLtB1cww8qn0+k=;
        b=WeHMIXu98/fBZm8t8HFMvIXK7kVGAV5N17BHgJRh8X/lQTyG5vuEzpe1kw/8YnC87j
         AaFQJXgKiJVBGCew0tmH0Rwn+xyvAp2zpKHcFqDFkLoQZ4SWojkzyJ3sr+aU2HozmxKr
         rf3ADYv3tsjSTX8Yzudst785cpIyDSvFSAXGuBfL023lOpdpXEVPupqHsAXqOniEZijS
         qwz3wQAz3lLYKffUXq2DUuTTPR6PfWiWGXin5qkgFB1Se8hJVnYKXXucN7N7Y11uqDhL
         Rr2rP6O1HfmcNXT/4UQ8i6k8uHA9cdWrTER9l+SC3yznAhxjvWEO+HTqamYn5dGV83Qz
         JM7g==
X-Gm-Message-State: AFq9FYLbmx5KAtCGSpbAUSNTqJXXpBkUwP2omGNamEonFt+LEk3MkxNR
	yT4hSgQztdB79TlNz/3DEkKOOBbcq0HokvEReM8stS1zLrzn395V19X0
X-Gm-Gg: AYBFou0Bo2D5sv5SRMXPJJ9Fq2jfWo2J4SPIvVjuWMpd9vmdXmu3qIk0ItqZFxz1MMV
	nsbQsh+e9e67YhatM6ZZjkeL6VkrueaU8tYJKsTyrOP+/aHAhRZjxfE0Jf4BOmYlE5JCQ9iOxvo
	VQm7NCOJXeZoDRKF3vQMZcPv4BckDtNnutEfak4mO9kyAzAmjH3HFLdBWEBjzj5ro1FjSHFgb+/
	OSLMJS6i5eqvUGopix/+oL5ghEHiHYLPKJ824+MeX8T1Zk4Bz75JiWh74PVB/xJ1r0IZEUHtF8r
	BlPVyctI6ZXKN0Zxluhjh4axCNkkCoCHlZMdbkp4uaQE6coz19Bqrs5i+0irMI+mYDG4YYoOmWg
	jGWYGLYcYJhJedsYVOwuHGTdjsrqlhWvTUB3BfXG6R5p0R6tXk7yBCtDstlVr/rd1IK99sP14c7
	6djnkVWG6ltvmRfdyHZtnOEOxunOMRXQxHagt9cdvzKugKhoQki2X4Ch9QGhgjyLPGmkWhMFacK
	kBN8TO3DUVyihS/GvQClxFlUrG7t3l0ATketYhfYsbt0pEvznk+FTbza+9N3vyj8X9t/rIIW4Jj
	s5cguvOChUCh99XEFzPFECEjmEhnnm0dyZ+Zz+FU9XRy8XYKSrITKd4rWEP8CgaUkBFszkFvd4D
	1AtyWxA==
X-Received: by 2002:a17:90b:2ccb:b0:3ac:a11a:7c7f with SMTP id 98e67ed59e1d1-3ad86ec9be4mr2512032a91.23.1792620043175;
        Wed, 21 Oct 2026 15:00:43 -0700 (PDT)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada48ed719sm1158289a91.5.2026.10.21.15.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 15:00:42 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 22:00:41 +0000
Message-Id: <DMAURQCKK6CG.10CZ7MFXGJO3V@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/7] mm/page_owner: add bpf_iter and kfuncs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Zhen Ni" <zhen.ni@easystack.cn>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
 <akpm@linux-foundation.org>, <vbabka@kernel.org>, <surenb@google.com>,
 <mhocko@suse.com>, <brendan.jackman@linux.dev>, <hannes@cmpxchg.org>,
 <ziy@nvidia.com>, <shuah@kernel.org>
In-Reply-To: <20261021112437.1799213-1-zhen.ni@easystack.cn>
References: <20261021112437.1799213-1-zhen.ni@easystack.cn>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Oct 21, 2026 at 04:24 AM Zhen Ni <zhen.ni@easystack.cn> wrote:
> Exposing the same walk to eBPF lets a program filter and aggregate in
> the kernel and surface only the records it cares about. This series
> adds that access as a seq_file bpf_iter target and an open-coded
> iterator.

This is overkill. Two iterators, two kfuncs that print strings,
a rewrite of read_page_owner(), a new file and a new header.

All that the prog needs from the kernel is the page_owner record
of a pfn. That's one kfunc. The walk, the eligibility rules and
the filters belong in the bpf prog:

  bpf_for(i, 0, ctx->nr) {
          pfn = ctx->start + i;
          if (bpf_page_owner_read(pfn, &po) ||
              pfn & ((1ul << po.order) - 1))
                  continue;
          if (po.pid != pid || bpf_page_cgroup_ino(pfn) != cgrp)
                  continue;
          /* add 1 << po.order to a hash map keyed by po.handle */
  }


Something like this:

diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
index d8f579c..3adb716 100644
--- a/mm/bpf_memcontrol.c
+++ b/mm/bpf_memcontrol.c
@@ -161,6 +161,20 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg)
 	mem_cgroup_flush_stats(memcg);
 }

+/**
+ * bpf_page_cgroup_ino - Get the cgroup a page is charged to
+ * @pfn: the page
+ *
+ * Return: What /proc/kpagecgroup has for @pfn: the inode number of the closest
+ * online ancestor of the memory cgroup, 0 if the page is not charged.
+ */
+__bpf_kfunc u64 bpf_page_cgroup_ino(unsigned long pfn)
+{
+	struct page *page = pfn_to_online_page(pfn);
+
+	return page ? page_cgroup_ino(page) : 0;
+}
+
 /**
  * bpf_proactive_reclaim - proactively reclaim memory from a memory cgroup
  * @memcg: the target memory cgroup to reclaim from.
@@ -218,6 +232,7 @@ BTF_ID_FLAGS(func, bpf_mem_cgroup_memory_events)
 BTF_ID_FLAGS(func, bpf_mem_cgroup_usage)
 BTF_ID_FLAGS(func, bpf_mem_cgroup_page_state)
 BTF_ID_FLAGS(func, bpf_mem_cgroup_flush_stats, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_page_cgroup_ino, KF_PERFMON)

 BTF_KFUNCS_END(bpf_memcontrol_kfuncs)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index fbbda7b..a26d7fe 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -12,6 +12,7 @@
 #include <linux/seq_file.h>
 #include <linux/memcontrol.h>
 #include <linux/sched/clock.h>
+#include <linux/btf.h>

 #include "page_alloc.h"

@@ -1144,6 +1145,44 @@ static int threshold_set(void *data, u64 val)

 DEFINE_SIMPLE_ATTRIBUTE(threshold_fops, &threshold_get, &threshold_set, "%llu\n");

+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_page_owner_read - Copy the page_owner record of an allocated page
+ * @pfn: the page
+ * @po__uninit: where to copy the record to
+ *
+ * All pages of a high-order allocation have the same record.
+ *
+ * Return: 0 on success, -ENOENT if @pfn is not online or not allocated.
+ */
+__bpf_kfunc int bpf_page_owner_read(unsigned long pfn, struct page_owner *po__uninit)
+{
+	struct page *page = pfn_to_online_page(pfn);
+	struct page_ext *page_ext = page ? page_ext_get(page) : NULL;
+
+	if (!page_ext || !test_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags)) {
+		page_ext_put(page_ext);
+		memset(po__uninit, 0, sizeof(*po__uninit));
+		return -ENOENT;
+	}
+
+	*po__uninit = *get_page_owner(page_ext);
+	page_ext_put(page_ext);
+	return 0;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(page_owner_kfuncs)
+BTF_ID_FLAGS(func, bpf_page_owner_read, KF_PERFMON)
+BTF_KFUNCS_END(page_owner_kfuncs)
+
+static const struct btf_kfunc_id_set page_owner_kfunc_set = {
+	.owner	= THIS_MODULE,
+	.set	= &page_owner_kfuncs,
+};
+
 static int __init pageowner_init(void)
 {
 	struct dentry *dir;
@@ -1169,6 +1208,6 @@ static int __init pageowner_init(void)
 			    &stack_fops);
 	debugfs_create_file("count_threshold", 0600, dir, NULL,
 			    &threshold_fops);
-	return 0;
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &page_owner_kfunc_set);
 }
 late_initcall(pageowner_init)

pw-bot: cr
