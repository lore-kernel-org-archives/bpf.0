Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028B6337699
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 22:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770330574; cv=none; b=qIFfrupIYH1DMM4h9lkz44CPswGfw0ouqsgWr4YsPUZZghNpWVIbxaHp6Ls9hjqlpBnLpWqQgXEE1Av4DQl0VTOVw+8GyjXNYTBm0WZoWrfs0p0njbWzJBWl5sB+evozXAEMxqyucaFIxco98Z+pVLmfKR5mBWv2+Maw0obTPRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770330574; c=relaxed/simple;
	bh=ufc9ipn4DgFd2tvof3LuGSXuZhXMYch1RwfgAmSLjx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1n3IOXgFHwYKJ29Pcv/ou2auc9U3Yq3x/vnayQ9DVHOLYd1ByrNn3hnA89ZQeAH47Ra+QljrpEHFbzmorRLmz6kvVRLDM6TrVV01PX+staJc/LvvSrEOnutlretiNjt5gcP4Axj4JDovygllT+aEbbjtEBbhwxjUah1tGUz5m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m38ctGbB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m38ctGbB"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a8a7269547so12856215ad.0
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 14:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770330572; x=1770935372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Br86rIdDfNGQDBD6yTRQ/wFNopMbNYBc/rl4mxWqQjc=;
        b=m38ctGbBghzJo0wNUK4xs6IZdkVbc7ANOgEHNTl0ZEf6eYyXbKgfQ4JRfhkvrT2rND
         RU++XZ/AfOB3PQXIX6oJTqTq6yhfN3sttQqIucd7yDNguA7wCPem9yRBj5Hl3BE4OEyw
         6h8zIrIeOJ7BIf/klf7xhIc9uoEMl/j7EOZiMprFYtcIlIip4IsYSh5uGw8soclN76xQ
         LpJEukcNsyirzu3wuCXmmJuSa8+wlkPXslVdzR9uzPc0D2+oS2VOqoGarPQ6Lplmkp9N
         AIqnJ+6x/UwqRBkdxcQa1DkzTwkboe4XiIeZrF1h6EI2jPnc44w9YJkWbcrvzxFAo1Oq
         DpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770330572; x=1770935372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Br86rIdDfNGQDBD6yTRQ/wFNopMbNYBc/rl4mxWqQjc=;
        b=jEGsZk83wxg/jZZNKrBNJR9CsCg9h+0xvB4m+tXPl5fmPff4tQ2IT4x6IraiRyjDMP
         juFOJwJDaPS+knTr+fWN85ZVMvJIlHV3oMOAnHrzqNz7A5eG2k4xGo4QNS5BQcOwzwnR
         JNxlHFkj1rDMy+HvIW/ZE+s22ghL01VynzgLq6AQYk33q1GAsS23ubfpAxjBqflRJESy
         Tu/SGtR3+jINPmRNoVcovLhe6GJGIZ6V4vMU4maFA+A0PP4YEIRq2tb/AhZ1Hud4988f
         khv7comHZBNo4rwmBit8aSD97IZDxKlCQU742aLx+a05Ivj1tAkCYXkrdBAp6CaXxLgk
         A9VA==
X-Gm-Message-State: AOJu0YyBYG4BgWjeJN8jo52IqGu45+vKhlRwLRkA13kdDbgQmQiwQUAm
	GDJ+ZZcWH9E9evUk5kWTfoQUhcHEUhKZbMlZy4bZk2Pfuwv9pPt7UrOLdRPQbA==
X-Gm-Gg: AZuq6aIKgQCjlmIRY9zgwLDxAkqizURU6gAsuS3TJAU9r0j0p+t8ZZwDHt7oTKfBcx2
	TQavS0bz8QUqZZv3aCN5z3XUwrgZEPBJwZ1HyS4xC5jSX/BqVF7ZCKtYhjuGW5hLVAeaFz30+p3
	7gs5Lixepsguq1AszRkFQ85hHvc6/5bmkhV3vT5AhrTg7hVYzaoMxPmWVyFGj1M4c/4r36Ito8c
	2OtO8KWvr5LMnHqVPKfucOrpEpnlK8C/w3vPV2BEwKagTK/i4ec5cgORf5/tjZzm0ljqdaKvimA
	9Of95mfGxRQQMz8fZQBM6irHVAgP0MnccbJ9L95jKiDUJYq6N/U2q2oYFFSV+RR/Qh0zgJRwzoc
	S80iRXDj3lpdnvESx0KbepdwNjGdC4iN0f7YzOgVQvuzfAFSlTZ2h5fAxqApJhO0Q2pUDNwboQO
	zQQg==
X-Received: by 2002:a17:903:2f08:b0:2a7:a6b1:4f8d with SMTP id d9443c01a7336-2a951700f29mr6682455ad.40.1770330572165;
        Thu, 05 Feb 2026 14:29:32 -0800 (PST)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951a63686sm4193235ad.14.2026.02.05.14.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 14:29:31 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 13/17] selftests/bpf: Update task_local_storage/recursion test
Date: Thu,  5 Feb 2026 14:29:11 -0800
Message-ID: <20260205222916.1788211-14-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205222916.1788211-1-ameryhung@gmail.com>
References: <20260205222916.1788211-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the expected result of the selftest as recursion of task local
storage syscall and helpers have been relaxed. Now that the percpu
counter is removed, task local storage helpers, bpf_task_storage_get()
and bpf_task_storage_delete() can now run on the same CPU at the same
time unless they cause deadlock.

Note that since there is no percpu counter preventing recursion in
task local storage helpers, bpf_trampoline now catches the recursion
of on_update as reported by recursion_misses.

on_enter: tp_btf/sys_enter
on_update: fentry/bpf_local_storage_update

           Old behavior                         New behavior
           ____________                         ____________
on_enter                             on_enter
  bpf_task_storage_get(&map_a)         bpf_task_storage_get(&map_a)
    bpf_task_storage_trylock succeed     bpf_local_storage_update(&map_a)
    bpf_local_storage_update(&map_a)

    on_update                            on_update
      bpf_task_storage_get(&map_a)         bpf_task_storage_get(&map_a)
        bpf_task_storage_trylock fail        on_update::misses++ (1)
        return NULL                        create and return map_a::ptr

                                           map_a::ptr += 1 (1)

                                           bpf_task_storage_delete(&map_a)
                                             return 0

      bpf_task_storage_get(&map_b)         bpf_task_storage_get(&map_b)
        bpf_task_storage_trylock fail        on_update::misses++ (2)
        return NULL                        create and return map_b::ptr

                                           map_b::ptr += 1 (1)

    create and return map_a::ptr         create and return map_a::ptr
  map_a::ptr = 200                     map_a::ptr = 200

  bpf_task_storage_get(&map_b)         bpf_task_storage_get(&map_b)
    bpf_task_storage_trylock succeed     lockless lookup succeed
    bpf_local_storage_update(&map_b)     return map_b::ptr

    on_update
      bpf_task_storage_get(&map_a)
        bpf_task_storage_trylock fail
        lockless lookup succeed
        return map_a::ptr

      map_a::ptr += 1 (201)

      bpf_task_storage_delete(&map_a)
        bpf_task_storage_trylock fail
        return -EBUSY
      nr_del_errs++ (1)

      bpf_task_storage_get(&map_b)
        bpf_task_storage_trylock fail
        return NULL

    create and return ptr

  map_b::ptr = 100

Expected result:

map_a::ptr = 201                          map_a::ptr = 200
map_b::ptr = 100                          map_b::ptr = 1
nr_del_err = 1                            nr_del_err = 0
on_update::recursion_misses = 0           on_update::recursion_misses = 2
On_enter::recursion_misses = 0            on_enter::recursion_misses = 0

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/task_local_storage.c  | 10 +++++-----
 .../selftests/bpf/progs/task_ls_recursion.c        | 14 ++------------
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index 42e822ea352f..7bee33797c71 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -112,24 +112,24 @@ static void test_recursion(void)
 	task_ls_recursion__detach(skel);
 
 	/* Refer to the comment in BPF_PROG(on_update) for
-	 * the explanation on the value 201 and 100.
+	 * the explanation on the value 200 and 1.
 	 */
 	map_fd = bpf_map__fd(skel->maps.map_a);
 	err = bpf_map_lookup_elem(map_fd, &task_fd, &value);
 	ASSERT_OK(err, "lookup map_a");
-	ASSERT_EQ(value, 201, "map_a value");
-	ASSERT_EQ(skel->bss->nr_del_errs, 1, "bpf_task_storage_delete busy");
+	ASSERT_EQ(value, 200, "map_a value");
+	ASSERT_EQ(skel->bss->nr_del_errs, 0, "bpf_task_storage_delete busy");
 
 	map_fd = bpf_map__fd(skel->maps.map_b);
 	err = bpf_map_lookup_elem(map_fd, &task_fd, &value);
 	ASSERT_OK(err, "lookup map_b");
-	ASSERT_EQ(value, 100, "map_b value");
+	ASSERT_EQ(value, 1, "map_b value");
 
 	prog_fd = bpf_program__fd(skel->progs.on_update);
 	memset(&info, 0, sizeof(info));
 	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
 	ASSERT_OK(err, "get prog info");
-	ASSERT_EQ(info.recursion_misses, 0, "on_update prog recursion");
+	ASSERT_EQ(info.recursion_misses, 2, "on_update prog recursion");
 
 	prog_fd = bpf_program__fd(skel->progs.on_enter);
 	memset(&info, 0, sizeof(info));
diff --git a/tools/testing/selftests/bpf/progs/task_ls_recursion.c b/tools/testing/selftests/bpf/progs/task_ls_recursion.c
index f1853c38aada..b37359432692 100644
--- a/tools/testing/selftests/bpf/progs/task_ls_recursion.c
+++ b/tools/testing/selftests/bpf/progs/task_ls_recursion.c
@@ -36,14 +36,9 @@ int BPF_PROG(on_update)
 	if (!test_pid || task->pid != test_pid)
 		return 0;
 
+	/* This will succeed as there is no real deadlock */
 	ptr = bpf_task_storage_get(&map_a, task, 0,
 				   BPF_LOCAL_STORAGE_GET_F_CREATE);
-	/* ptr will not be NULL when it is called from
-	 * the bpf_task_storage_get(&map_b,...F_CREATE) in
-	 * the BPF_PROG(on_enter) below.  It is because
-	 * the value can be found in map_a and the kernel
-	 * does not need to acquire any spin_lock.
-	 */
 	if (ptr) {
 		int err;
 
@@ -53,12 +48,7 @@ int BPF_PROG(on_update)
 			nr_del_errs++;
 	}
 
-	/* This will still fail because map_b is empty and
-	 * this BPF_PROG(on_update) has failed to acquire
-	 * the percpu busy lock => meaning potential
-	 * deadlock is detected and it will fail to create
-	 * new storage.
-	 */
+	/* This will succeed as there is no real deadlock */
 	ptr = bpf_task_storage_get(&map_b, task, 0,
 				   BPF_LOCAL_STORAGE_GET_F_CREATE);
 	if (ptr)
-- 
2.47.3

