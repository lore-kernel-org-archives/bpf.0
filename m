Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5420435B62F
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 07:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274945; cv=none; b=OElhVSv3UTK9qRQFnluAx5y2m7bqKiYcLnJ2jVvacOdbVTzRWQfDIJJu8ufsYJCzQOENsH/OPqh2ApGITJFcw9po8I2ugUzEcZ3OzVftAlGKPqtIwtadjXc7aE3n8p2LKgC8KtnGkSCP+skNmh0IiEjnt9u8CinqD2nXrlcmFwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274945; c=relaxed/simple;
	bh=TADLOMRKh4Q7PejR9tjfy5dVMNcv1vOqD5dk+oNJKhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/ANDjurdoc80PnssMrd3W3rp8csZfZiUMp7LtT0F2MeyBuwfsBF4hK9wkJqwAMwmHa3DoKGV5RyOEqV5Xku3xOY55Bp4Zz8bThHWLBrlbxujrHzmmPlyDTkXTlOENHN9BoYPhe4Ny6axWc3aDFOq3RtzoVK3jPstmOqSIDyn1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeyhKoay; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeyhKoay"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-bc17d39ccd2so194620a12.3
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 23:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770274944; x=1770879744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYHVAl2Jp6GfAhmX3kqqnc7v6eyJBa0A6W5eDY8skXU=;
        b=XeyhKoayUxebKIvgNqOetd2eTgoABC9i0+f4tsPvzNGkluDDBADUtgLSfRsgItguQQ
         qCgNxzxvJtC3TlqO0nRx56a08QOa6Yci3vPUakDmWA3cd6eMaPc56/JLshMInrLkGPSq
         nLZhULJx4lQcxMNufjuYtgiFbU7NiR+IlAndsvN9KGUC8XGeXfRBeZJbZtlfQT0Ucvco
         5V02Awlw1iw8aUlOUURZzRwblu70QKRfFknZAoZJQILWq5piUkT85YXbNF2GpAzMleOQ
         fPWvbKtYZSVg9LMq5Oh4YYWmiwzXfHeoFFfkFCa28LWzxVTgClJcj8S+d2pEP7WHzmmO
         OHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770274944; x=1770879744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NYHVAl2Jp6GfAhmX3kqqnc7v6eyJBa0A6W5eDY8skXU=;
        b=SmUbQGwx6nCbLeR/1wZ7hF3HCfzof936FLJhWnmsmm5gbfLixckUSSmvFmsvdniako
         gAKCUotgRdzEVCUYFEdR4pnpdx5cCPCo2r2MDFUAMELSxjWdJBds1Pznv06B0/QYtuGM
         Zus//pdgcd4jOnVPHhzqD8Ig/7oX+B+fT97h/8rx0RyNM7XahRBFNIunaxOcCq09kuhy
         gDuM3AcYTaEFS1F6ANFDALPW+lvw6IQBoyCSGU7+jRWohrIte58zme8/Ig1H9i+ZduYx
         bYi5CHJjvWW5OWyGS+HY7KtoHk3zF30rOgMqEaRWamkGbj8MdBPN2h3hqlaNS4eYQ0sW
         pmvQ==
X-Gm-Message-State: AOJu0Ywva5pfj2fIJswOZ93aQFE/JezuPlsQ+eIKKYbgVFQ1TykRIdMD
	RoW1x9huYuVc2p2u8oDY/GM9QiBkrKxwhvgeQqBQIjuTDL7x8fmTE0VW0kWUrQ==
X-Gm-Gg: AZuq6aLzrsW9Gr5LyvsjFhiWLfaLEwujm3OzpEMeokj+8rRU5fu42wqmRECnSHH2UlK
	DokOyzrQj+xWz2Rkx3CEVE84Fx4MstSA0PDNMnNmyOPcrldXZ/UfJPtgZW/IsMj1hteV1sGoDSW
	10kNGPrvX63oPtrUPBefnrBQuSFuQ2j97NQEIBx6MbfifSubPMirBzdKdPaTkwm6knD/A6XWZO0
	6DhmrKe2Ev+VfqafIfdAo9+haL+EuB8mi4ya3BRfh81Y5Sed8kQGYFrBNVDf2hAW7ekYcJnXVlN
	PGQZV9Agnmer2luxSCnayNSer1AlMs11Y5FJevunI4NKnxjufsRIbAEuZQN8NQpwquewuEp8B4K
	gRUW41aMk609uK2WkFcDBxwJEiF0P5aCBrfnb22qq3Bilm7xiSz2YqOHx96zhYucwLAKFnR3Pd8
	+pzy93YTR0Du8=
X-Received: by 2002:a05:6a21:e58d:b0:38b:ee34:24f4 with SMTP id adf61e73a8af0-3937205ff63mr5458024637.15.1770274944399;
        Wed, 04 Feb 2026 23:02:24 -0800 (PST)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6c8581fe1esm3883202a12.35.2026.02.04.23.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:02:23 -0800 (PST)
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
Subject: [PATCH bpf-next v6 13/17] selftests/bpf: Update task_local_storage/recursion test
Date: Wed,  4 Feb 2026 23:02:02 -0800
Message-ID: <20260205070208.186382-14-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205070208.186382-1-ameryhung@gmail.com>
References: <20260205070208.186382-1-ameryhung@gmail.com>
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
 .../selftests/bpf/prog_tests/task_local_storage.c      | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

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
-- 
2.47.3

