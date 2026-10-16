Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3FD3A9628
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 02:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792119562; cv=none; b=eHOJUb/avEgsgEptXvjj4CNchn7dhZnl/qLfwPITQTN8p2IPFCRIK7UaQw6SreeKqiFamy78ufpWrRlFfZTMF5MKwreYXE+IRCQv5fSf7xmF8UZTXKKFX+YxYuEs2qsWN3XD8PGj34g9p6yfJ8wCj8ETZRFx7RGPcmfJ/rSAKPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792119562; c=relaxed/simple;
	bh=RYNq5BB5qmCL5WHlAW+hqwgCZugQVCL/BrXHrxUGlNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lwY6DA+Au+kxrFVRvz21GH9Dje9FaktyAnufEqQFfPAZ9ixPlAnHvTxhApjKnHjm3xHfoHl2KTFj/3DVEbEapH9s25nuT5+8X19ctnCYu4bEhJDERLUPWj+0MF6KLnWfuzum2p02T2jxdXWuPPVBpkfLJem09MjrRzd8udtVL1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWUE0BuQ; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWUE0BuQ"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30b6dad2382so14258468eec.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 19:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792119560; x=1792724360; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2hIEJnGwSzaqA/hOBpSXRqZvtTI7vS1Ntv+NizT+m2U=;
        b=IWUE0BuQyMrN+B4Thu4FUrpN8SJNlQA0YG5A+Fi3Bny7E6kf2d2btjfVGiKScM4zqS
         r8aHrVrracIduUbtAkfc0Wz2+jZ0iDqU6VevMeEKTw7h3IFcGQuB54rJSo17E5suU4Ex
         L3KKSKAxr4IEhuc4QsgrU5V3IgpZl/maGu1zwX2AL0B8Z5/YOuQop16A1bPqxyDSB1Tg
         nJ5VqCc35U1ZbbYnlEXlKYsz9wN0cWQgYeVt6emOWT38BuDWxSEawfoIr1KccHpwF0sE
         y5rn8LB3XA83+EREushWKE3KyXJO3Ko9xS6yb8m39xJdNBjkbHfIJkIzKEAtCjmfvXwI
         omAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792119560; x=1792724360;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2hIEJnGwSzaqA/hOBpSXRqZvtTI7vS1Ntv+NizT+m2U=;
        b=u1qmFktM7LxGQQDdX9KY0GVODx/jweQo4uxWkOZuBmWgRJXQZAs+btQs7HzTj56Wsh
         tWTpYyYfHqcFalmi23OyWanDUD7xmO2ycAt9qI0x+895bgqNlZxSSnuHRNb047ebP+8C
         ohO8kfxDPzQPmt1uTg0n3ly1tdheeDNRWcEUvLbXyOggGw1ezWZ52lah4VT7Mvb5XORZ
         0TcbCqc5cAIgPg1x3GoB5HeDHwNas2Lrv/gRqTYN0eOB18nJROubJ+c6RB4rkuZegXCh
         k2F5XcGzE6nskFqTU3Y93VOWM7Nnv1+voSWNIOypsO7k2lG4lAb8ZLhDU/HniZXSe6Hi
         EaUA==
X-Gm-Message-State: AFq9FYJRvpDWRKMIht3VwnRgLjqovBKTOtvwG87Snk9DGKzufA/wjFhX
	v8BmjFsBHzISHlD0ltcIN6lN9CwYf/t97dh0ZrQQBEvDklwBGu3s7eVd
X-Gm-Gg: AYBFou2YYw6oUFthuHuDV5qFQgAPqI+c/W/S1jX2TjaqlSaAnUZ4Lab4yvXLbualDsX
	BzibROGPpD1rMNecB0SpyojVfnsiHT22RGEWnYt0531QFKwYGVfLE28iTkkX4bBIbdqo/hPPLGN
	JXSWQ0jQxw/qxDM60kJQR6Pg8fhDfSZyEwFu8DduUoxQYReBCykaCff/eh3ES3rJe4EaGa3MDwb
	xo5yfr1LABwQwD0cXKYu2JV66WGk/iG4eFIHUDm8KtXhSgXrwJoDSYmf4uaHbGakphc2yiGL1Ox
	AooBdld8H5H0JVZmUBiLN1o0L95Ba7FPuXXSQgBECiBOxWGMU/nTSaYnqh4LhPu3M6hq9icEvbv
	hInn34ohWlvEnNAXtKTgbwgw5vucUSnfZij3/afXgC8sl6Q4O4xlor0DmctqdfgCZeX7z3G8xHn
	3FIvlhvEH51osCFuyogjNiEJMZhADAVFOwW4NdQaf/si6dm/tiSW59zA5RauoD5X7bVZScrvYIJ
	BT8iw==
X-Received: by 2002:a05:7300:e510:b0:35d:e9b1:1c6f with SMTP id 5a478bee46e88-35de9b11d74mr8864152eec.0.1792119560531;
        Thu, 15 Oct 2026 19:59:20 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0cab0sm2481261eec.3.2026.10.15.19.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 19:59:20 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 16 Oct 2026 10:59:06 +0800
Subject: [PATCH bpf-next v4 2/4] bpf: Dissociate struct_ops progs before
 the grace period of the map
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-selftests-bpf-struct-ops-assoc-timer-v4-2-9ad31c21220c@gmail.com>
References: <20261016-selftests-bpf-struct-ops-assoc-timer-v4-0-9ad31c21220c@gmail.com>
In-Reply-To: <20261016-selftests-bpf-struct-ops-assoc-timer-v4-0-9ad31c21220c@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

A struct_ops prog is associated with its map without a reference on the
map, and finds the struct_ops through bpf_prog_get_assoc_struct_ops()
under RCU. For a struct_ops map, bpf_map_put() waits for an RCU grace
period before it calls bpf_struct_ops_map_free(), which clears the
association and then frees the trampoline and the kdata right away.

Nothing waits for a prog that reads the association after that grace
period started and before the association is cleared. A timer callback
of a struct_ops prog that calls test_1 of bpf_testmod's multi_st_ops
through the association while the map is freed returns into the freed
trampoline, whose image is filled with int3. RAX holds MAP_MAGIC (1234),
which test_1 has just returned:

  Oops: int3: 0000 [#1] SMP KASAN NOPTI
  CPU: 2 UID: 0 PID: 31 Comm: ksoftirqd/2 ...
  RIP: 0010:0xffffffffc043114d
  Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc <cc> cc cc cc
  RAX: 00000000000004d2 ...
  Call Trace:
   bpf_prog_ec591f4f9d13f364_timer_cb+0x96/0x1e2
   bpf_timer_cb+0x15d/0x240
   __hrtimer_run_queues+0x264/0x5a0
   hrtimer_run_softirq+0x1a7/0x3b0
   handle_softirqs+0x18c/0x5b0

Dissociate the progs in map_free_pre_rcu(), so that the grace period of
bpf_map_put() follows it, and make that an RCU tasks trace grace period
for every struct_ops map. It then also waits for the progs that read
the association under RCU tasks trace, e.g. from a bpf_wq callback or a
sleepable prog, as a tasks trace grace period implies an RCU one.

The st_ops_assoc_in_timer_free subtest of test_progs reproduces it. Its
timer callback keeps calling test_1 through the association while the
map is freed, and test_1 spins in bpf_loop() when called from there:

  $ cd tools/testing/selftests/bpf
  $ make test_progs
  $ ./test_progs -t struct_ops_assoc/st_ops_assoc_in_timer_free

On kernels of the same bpf-next commit with KASAN enabled, x86_64 VM
with 32 vCPUs, before and after this patch:

            before                     after
  outcome   Oops (int3) on run 1       100 of 100 runs passed, no Oops

Fixes: 5db69b0fbdc8 ("bpf: Make struct_ops tasks_rcu grace period optional")
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index a1ae30b145a03..7d1a8514ba341 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -1030,6 +1030,7 @@ static void bpf_struct_ops_map_free_pre_rcu(struct bpf_map *map)
 	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
 
 	bpf_struct_ops_map_del_ksyms(st_map);
+	bpf_struct_ops_map_dissoc_progs(st_map);
 }
 
 static void bpf_struct_ops_map_free(struct bpf_map *map)
@@ -1045,8 +1046,6 @@ static void bpf_struct_ops_map_free(struct bpf_map *map)
 	if (btf_is_module(st_map->btf))
 		module_put(st_map->st_ops_desc->st_ops->owner);
 
-	bpf_struct_ops_map_dissoc_progs(st_map);
-
 	if (tasks_rcu && IS_ENABLED(CONFIG_TASKS_RCU))
 		synchronize_rcu_tasks();
 
@@ -1162,7 +1161,11 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 
 	mutex_init(&st_map->lock);
 	bpf_map_init_from_attr(map, attr);
-	map->free_after_mult_rcu_gp = st_ops_desc->st_ops->free_after_mult_rcu_gp;
+	/*
+	 * A prog dissociated in map_free_pre_rcu() may still run the struct_ops
+	 * from a bpf_wq callback or a sleepable prog, under RCU tasks trace.
+	 */
+	map->free_after_mult_rcu_gp = true;
 	map->free_after_rcu_gp = true;
 
 	return map;

-- 
2.43.0

