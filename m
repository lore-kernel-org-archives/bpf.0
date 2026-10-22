Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792658932;
	b=1sZkVYs1D0ePvaEKU1Yog+uvkocJymL+1IN2m9cO8cf6tCOtwLfoxZIlxW0QGqONg/g6
	 wFRAyBTNDL8wCkVMmjj2/2fnR3J3OBWw9w5GHBXaMhW6eKZOg4/hIOeIHTM1+GEhqhJfd
	 PFVgEq+A5TKR5K8DYgqbpMMQSe7hDaWpXfmuOVZuhDk74PelZTfKdR5g4lMOryWzlWTtC
	 z/1nMCuyUPMpLViBMaSP8HOmQN5sHiWednKGBlf53UP/lpKMGidc2bdBQt9GZqo0OGM5J
	 1Iow4DY3wLrHsD96NV+ovJttgLCdugh89onmb5uqXLj2e1954+OJ939RyoL88RnYkqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792658932;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=ZgxGYakB4OAbqmfUpoRBZ1h/Ym4Uy7aZcRmLcKkfZ3E=;
	b=GOdY3xA2kWYTRKL2DxITYDmslqIDlU/4+jq7ouPn1kyYwk17jEgC4zif/kOmNHt+oPTC
	 OchuXGtqonClrpABnD8JXKs5CC6bmAriV+k+PCbdZebYUfiu4bf/1Kr+a9SasmffIhfcI
	 kBwYIdslAgQ+4nU8cO4SOFJPCLaifR21HlJPunSHolepvtMl0D4eA6AAeMWnd6yhH8Rie
	 Q4ie3Nj3bHzF7ezOIteDlhQGuNj40T+89D/rRBm1aetZQzlZWV4NKkBKdXC/KlQ0iY2Wz
	 8exU28wflvuwwGhaDUTiG4Il5FDqWt9XAZzmT6zIzj+uX6t9qz0VTfRHM+FUY/lLcOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VthhSAZa;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA26606A320
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 08:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAA26606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VthhSAZa
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-353804b591eso2936574eec.0
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 01:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792658931; x=1793263731; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZgxGYakB4OAbqmfUpoRBZ1h/Ym4Uy7aZcRmLcKkfZ3E=;
        b=VthhSAZaIu93ccIM+niIeQn2HJ3ppWySTcvgZII3J3/FW08bGRYdhYCWc/sDlR6DKl
         EQrsyEGsFDyJQ4ZW1/2MBY/YUGWy/yFtiLD6f0OQhjpgH14hJnIs67sjNYs3grMdQNi+
         sXfs+IeK9S+QWQoz9VQP1+z63C0x5OjL7k4dUCn3m/hTw2MKGuGxLGeKRG412vqKk4DD
         Rch6C/2OJZDJXQoWaqdG9i3uRU4oBFcabPyC8jl3RDOZi5yNVIMLmJRm8bsM8izsB0Wp
         rD13hfKY6IKi7MjAyrFGBoju8SNp5eV/M87mbDyZwrM7FuVNYRr2qk8PCSsunASAyyDb
         Gs0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792658931; x=1793263731;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZgxGYakB4OAbqmfUpoRBZ1h/Ym4Uy7aZcRmLcKkfZ3E=;
        b=g4/eNG+MlTozsFBIlesrz94zyCuc6OimtkmvfLIX70BzCkx6d6kvvoSpXR27i1/9AG
         2e5Odfm3Xc3jDKn0gy+PohnTPSuRX5LGxiw2rZrz8ORrwr8rc9Wulq56WFGjzsAF5Zeh
         dZAIZXjHljyAUzaY6Y6cgzwlzW9eBgswcHdTtjWxo7WQk5+x2rngFMvtZR9pcfnmVNEh
         nucvaTYRrsNu+NN14+iyDqjtxzLauMHY5p5jq64i9raXkNXmrFVdz6ueKuN1OHJuD54b
         TKjT8wfltI5vigyGgnUnVxKo9Rb24vdZSZ7EoFuhfhMF77W5O7GLztrSy1XqNDZEE0ma
         bRNw==
X-Gm-Message-State: AFq9FYKke5tR3FI89g+pReqyahzuu4fppNkpT1zy1X3EFTpeLdBN83IY
	GUS+durVPW069PXQ0Adu1A/b3iHlaIrPgHW3BtUvVSK70f4QOXjZFCTD
X-Gm-Gg: AYBFou2oUg4hS6p7KBsoh1AtNi1zmk7932ryMGtMBaN50LHnnW+nytuF3W1k5fPLGGa
	UBLZDQO+az3MV90AZi3VupwAU/ALtAzQNCr9SCFEyPOtSg9I6RaojtfrBvDAqklXODYKM9T6zd/
	3s9ri69Ckie05anGe1bwxMykV8ksb4BxzB71W3KfppvtOlmzQdToVSMCoWadjD8xUXC2NY2+sWs
	nyiXO45kAnrc48ZepvdZ/gwp5+ByAk8uOhYvbXuBIH3X6iUpSNgNgZnAwCVSs1T9yhqdUWsbOKw
	bNcwZef8v7ZdSq6v96khZN+Mhj67zbTvggnkHFHS+jwuAjeaHG5qIfcv0CZN35ZbScj8YOrCQgK
	vDCmv1z2NPTBx5LPdSkKhtlKZ/XG+6U/QN0qrEf0NeSWcHiQJc6z9AcihSdGxq+whbMbz24rKvs
	fHxi2+DM/S9dSXs47m1XGnmjUTLQIv3lQPF7Qn7RwG1LodrYeejbY7Of74VA3dZiAZvZmxypiLP
	voSGIa2WlKoNpBj+3Ld0juin64EEK8rGih+JENWYiLs4xAHrOm7Gdhjsc8U/Nxh+tgm1QfC
X-Received: by 2002:a05:7300:ea8e:b0:369:38e3:5363 with SMTP id 5a478bee46e88-36938e357a4mr859137eec.7.1792658930788;
        Thu, 22 Oct 2026 01:48:50 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367417a2fadsm13962472eec.21.2026.10.22.01.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 01:48:50 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Thu, 22 Oct 2026 16:48:37 +0800
Subject: [PATCH bpf-next v6 2/4] bpf: Dissociate struct_ops progs before
 the grace period of the map
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-selftests-bpf-struct-ops-assoc-timer-v6-2-2c0f18e82582@gmail.com>
References: <20261022-selftests-bpf-struct-ops-assoc-timer-v6-0-2c0f18e82582@gmail.com>
In-Reply-To: <20261022-selftests-bpf-struct-ops-assoc-timer-v6-0-2c0f18e82582@gmail.com>
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
Stop setting free_after_rcu_gp, which bpf_map_put() no longer reads for
a struct_ops map, and update the comment of free_after_mult_rcu_gp in
struct bpf_struct_ops, which now only picks the grace period of a cgroup
prog array.

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
 include/linux/bpf.h         |  8 +++++---
 kernel/bpf/bpf_struct_ops.c | 10 ++++++----
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 17b2a425e05eb..ff04367812935 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2240,9 +2240,11 @@ struct btf_member;
  *                           and its progs. It is unnecessary if the @unreg
  *                           has waited for the correct rcu gp or the @unreg
  *                           has ensured all struct_ops prog has finished running.
- * @free_after_mult_rcu_gp: Same as @free_after_tasks_rcu_gp but waiting for
- *                          both tasks_trace_rcu and regular rcu grace period.
- *                          It is usually needed if the struct_ops has sleepable prog.
+ * @free_after_mult_rcu_gp: Set to true if the cgroup prog array of this
+ *                          struct_ops needs a tasks_trace_rcu gp, besides a
+ *                          regular rcu gp, before it is freed. It is usually
+ *                          needed if the struct_ops has sleepable prog. A
+ *                          struct_ops map always waits for both.
  */
 struct bpf_struct_ops {
 	const struct bpf_verifier_ops *verifier_ops;
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index a1ae30b145a03..7c5cd6086e273 100644
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
 
@@ -1162,8 +1161,11 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 
 	mutex_init(&st_map->lock);
 	bpf_map_init_from_attr(map, attr);
-	map->free_after_mult_rcu_gp = st_ops_desc->st_ops->free_after_mult_rcu_gp;
-	map->free_after_rcu_gp = true;
+	/*
+	 * A prog dissociated in map_free_pre_rcu() may still run the struct_ops
+	 * from a bpf_wq callback or a sleepable prog, under RCU tasks trace.
+	 */
+	map->free_after_mult_rcu_gp = true;
 
 	return map;
 

-- 
2.43.0

