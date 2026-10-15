Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A87133F8AD
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 01:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792028166; cv=none; b=tNJVWr9eM7Af5goaWXGCBoQ7irOzwkQjSSfbqVp750nzhWQJ1FKEaONplMFwY9bvNg9z/Kf9+EHIVt1/7FhhZkHStpCZ1THK9d1EwGD6sUNResqB1BiOOHfLCw/jafdyssv+47YMZiXz8L++FkFIxNC3SlTgidLxr3jJBceclig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792028166; c=relaxed/simple;
	bh=1Dl83eh+RjnFqkaMyIj3k16xV6hCRZ7fQCUOkUq0l9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CHPSxtshjS1vttXtC+yzO2aeUkeB6m3iUvr8UdBuEMCf9+/mfAOuENutYdhCi7z6Z7CnZAkGy9Ed1/hblUIN+QPtbi9uHMmzh0VHM/uDLhhsoBUT0M2Z0SFwZUelGh3tT43ywVXBZ0yUBTCDoGJGOTTHyH6JbapjBcewcLZtc6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuPj+1Y7; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuPj+1Y7"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-30b6dad2382so11041721eec.0
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 18:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792028162; x=1792632962; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hBOrSOPmQk84Vhb6yfZNkmNfcdI9aL1b3Ak/uUvZCOk=;
        b=XuPj+1Y7fGMQbRmeyxn82jBTzspB0GzA7/y/nO4Kudje35x7eOwZXEPOFnVkEADJKw
         7DDZx2jfaus/Y8XzqcymQAROPr+KsG4wmkzrFFY4OcQ87KozQPSaNVpCKW22N8ceP9IY
         kUnryNrMrXeCd/NBBhycFAr4g/SaRD/8CPEWXWMvCiltPhf+N1Q9obGk8OQqSsaoQu0q
         fcoB2k0lnh96w06bzj5bgmjgIe6f2JzlWDWhUTIogT03kiDm5fFTL6CeavRQu735WB9p
         gtbvS2NmSLdJPxd2Rz4Cq3S1G70aoUT5FYs17n0aVAO4dgYpWV6WdxQeSRy4wtwLRXMf
         7zHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028162; x=1792632962;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hBOrSOPmQk84Vhb6yfZNkmNfcdI9aL1b3Ak/uUvZCOk=;
        b=UbmhcW2xbvxRWnJus7kDIfFbu9qusyv7aqwFAMfPLpTZHIJr+nziNqFD0yVyR8aOdu
         AwPzcfdp4n+4wCMO1e/zPphELfe28kXfKf80YHbHass+OhklpBfL1A4X2pPjbjf80qAC
         x6tCNGkoDaJKCeFg7v62JMWxjdujju+kc+0zbPYY2Dq/vntbXDPfLcsEy51glTwXwsvJ
         bx4CeXQvXZTMrKURgHviSBef31XXsbbMtBQr0hcV/Zq+B42tYSfjW4o0UtnZGHhh8oMe
         WDyGI0yjdk7kzw5R3DrQHuDZoygRX8tI4PZZKt6ZyHIRX1ZXfhF4524jG/e3l9wai+pS
         PGbw==
X-Gm-Message-State: AFq9FYLauySTbSNOjDcqLRopqa/mqINmdUmgSaXBA8qYh7Jspjms0phj
	o2PF/OyhVGUOjGWy7QeQLZ8cf3FOM8ePL4azEUHmxSJlM7Tuz9bvMgqJ
X-Gm-Gg: AYBFou01l2dsxcpkPR8uaxXrXsmmzrz/DThEVQW4JNPzsf6aj2xP36N/JrRA0YMobbH
	9pkGWjzvwVY3Jabpx03x5GH1F/FGPWthAk6UQeEjTbRcQn9Ss3xMIqOu6A6lr/y2E6abUXj/BM/
	3of8AuytWUOm707bd7aaf289yoCH7HyvStREm99m6qrMOGp00BnWeect8Lyjc3SaNU0dHrubH/8
	3dPdSSwpGhn2NWmQ7S60SYG2hpig9j86USQ7FSv6u//D0e+b+4PCA2kIRGfL50/S+VdHVdEYtRd
	WPJG5ToYOT56/AvJm41uqF5UU3xoscCFdBnS9ikb/pCmxdk2qG1b6cjqCb8wjkBQyHT41p4/129
	rsUWja0v+qn0U97XJx8R2MdpnXZ1a0/UuVcCp9Rnh4fjSsLaDwCpl08e8YwpwTHslt5IIz9+CeN
	w65qkZx5PcxMCqzO3VhbdfuXv0uURbSdSIaKcdCkkcOFFCLP+5crp6dAQJ8pFxrA4W9Q==
X-Received: by 2002:a05:7300:c01b:20b0:354:b5d7:5a8f with SMTP id 5a478bee46e88-354b5e69defmr25701444eec.30.1792028161433;
        Wed, 14 Oct 2026 18:36:01 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-358ee8a3387sm47863101eec.15.2026.10.14.18.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:36:01 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Thu, 15 Oct 2026 09:35:50 +0800
Subject: [PATCH bpf-next v3 1/3] bpf: Defer freeing a struct_ops map until
 its progs are done
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-selftests-bpf-struct-ops-assoc-timer-v3-1-efe643d4b2a3@gmail.com>
References: <20261015-selftests-bpf-struct-ops-assoc-timer-v3-0-efe643d4b2a3@gmail.com>
In-Reply-To: <20261015-selftests-bpf-struct-ops-assoc-timer-v3-0-efe643d4b2a3@gmail.com>
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
under RCU until bpf_struct_ops_map_free() clears the association. For a
struct_ops map, bpf_map_put() waits for an RCU grace period before it
calls bpf_struct_ops_map_free(), which clears the association and then
frees the trampoline and the kdata right away.

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

Free the map after an RCU tasks trace grace period that starts once the
association is cleared. It waits for the progs that read the association
under RCU, e.g. from a timer callback, as well as for those under RCU
tasks trace, e.g. from a bpf_wq callback or a sleepable prog, since a
tasks trace grace period implies an RCU one. Clearing the association
before the grace period of bpf_map_put() doesn't work, as it takes a
mutex while bpf_map_put() may run in softirq, e.g. from
bpf_struct_ops_put() of a tcp congestion control.

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
 kernel/bpf/bpf_struct_ops.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 1178acd72296e..c000419db1cf3 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -42,6 +42,9 @@ struct bpf_struct_ops_map {
 	void *image_pages[MAX_TRAMP_IMAGE_PAGES];
 	/* The owner moduler's btf. */
 	struct btf *btf;
+	/* free the map once the progs that used it have finished */
+	struct rcu_head free_rcu;
+	struct work_struct free_work;
 	/* uvalue->data stores the kernel struct
 	 * (e.g. tcp_congestion_ops) that is more useful
 	 * to userspace than the kvalue.  For example,
@@ -1032,6 +1035,23 @@ static void bpf_struct_ops_map_free_pre_rcu(struct bpf_map *map)
 	bpf_struct_ops_map_del_ksyms(st_map);
 }
 
+static void bpf_struct_ops_map_free_deferred(struct work_struct *work)
+{
+	struct bpf_struct_ops_map *st_map;
+
+	st_map = container_of(work, struct bpf_struct_ops_map, free_work);
+	__bpf_struct_ops_map_free(&st_map->map);
+}
+
+static void bpf_struct_ops_map_free_rcu_gp(struct rcu_head *rcu)
+{
+	struct bpf_struct_ops_map *st_map;
+
+	st_map = container_of(rcu, struct bpf_struct_ops_map, free_rcu);
+	INIT_WORK(&st_map->free_work, bpf_struct_ops_map_free_deferred);
+	queue_work(system_dfl_wq, &st_map->free_work);
+}
+
 static void bpf_struct_ops_map_free(struct bpf_map *map)
 {
 	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
@@ -1050,7 +1070,13 @@ static void bpf_struct_ops_map_free(struct bpf_map *map)
 	if (tasks_rcu && IS_ENABLED(CONFIG_TASKS_RCU))
 		synchronize_rcu_tasks();
 
-	__bpf_struct_ops_map_free(map);
+	/*
+	 * A prog may have read the association before it was cleared above,
+	 * e.g. from a timer or a bpf_wq callback, and may still be running the
+	 * struct_ops. A tasks trace grace period waits for both the RCU and the
+	 * RCU tasks trace readers, free the map only after it.
+	 */
+	call_rcu_tasks_trace(&st_map->free_rcu, bpf_struct_ops_map_free_rcu_gp);
 }
 
 static int bpf_struct_ops_map_alloc_check(union bpf_attr *attr)

-- 
2.43.0

