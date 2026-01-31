Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3563D329C70
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 05:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769836184; cv=none; b=BHdRhYOv/YCVlg9Awcpqc23Q6sT5CPCuWfn05fIWtb7j6DzZIQv98QydPpzsI5ovPXa9mMjWVF1mvyjGQ/o9gQb+8oMOx+IPW7WhuTZ8YQoD4f02QscsADqqsRBRPfWYZC4n0Micngyp+GUjJJfqf18e+sN7k5bQHZxaJIb3Dr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769836184; c=relaxed/simple;
	bh=UlL8oZQzeYpieEW9kR3O2tWXV0IGuasLKuUjGh/FzsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=euxXVZEr2VPU86L7DQ23Qy7SlYjwlH8Xg3v7zESkQIX0SSLxJ1vtATMk3o4FIxukUWL8IkvKGyh9kzXih0G2IhoMLlLX49ij7dCzCkwAUphmtI6ctJtlEmjWIh4932GuLft88gvYXtALdXMx1qF8Y+IroeWQLHhPsBNxoSUCDso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGOfdkpe; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGOfdkpe"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a12ebe4b74so30843405ad.0
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 21:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769836176; x=1770440976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+n1cYrkpCAn7OrNMXyl0RSJ5XctP2kSL+z13tA+mKTU=;
        b=RGOfdkpeFbJJo5LSE9UhBK821Y6vpBr07gYql+2WRTatEzRWhRFf0Kw9OPRxjybtyf
         3Jv45Ik4heUVcppbGQLcCQvIw8fjIuOAqFK5AozbCLXSigywhY2pjcudunyOIw7Sks9g
         bn6qMer5uz7QRH/F2RXJEJ0+kd7EPTIUECbcJbPxmJB5fpqp5qnesTT1btv94xiuY0KC
         ovey8s/je+ALtyTCoBMOPG8qhz1Lln9gYk5lSj/1LBFOX5/sUTMXUc/FJrakND937O0D
         gIwfOUB1Pl8TkiPwm2yjBt2A2irFiS8OqKILAij/ZsSsuDZSvF2OWhu0qrhA5xdAh7Vz
         1blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769836176; x=1770440976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+n1cYrkpCAn7OrNMXyl0RSJ5XctP2kSL+z13tA+mKTU=;
        b=Bxb30aAjKlBsUZE/oBl2LQslVbCkkhu+JO3TpbKC8VIXjvbf3ssIb1pN9AVNtclWyg
         wI0+UZMHGslq2ONxk+1uVDFN/ZJL4Vm2glcgtpPreNKgUhYsLvaQLAfvzlW+ts3Sso89
         VPC9He/QQQpG2prxpy7acbK4FHQRd2gyHQnKW3D11zUIm2/oEknc4DDc6FuOOEo3oxtz
         9Wi0pWWUXn+EUmgNK+ww8ZXaNFAueyB6j9tAv+KQcOenkOqcB6KqXGZP4HQ/+y4/41IC
         wEJyKjChXD3g8aSS4D1pAjljlHTbeAWEzIfzd4PzfN9qKv8tFHztpT6ugeDkQLNtA+Px
         ldxA==
X-Gm-Message-State: AOJu0Yx+v9zJnhozRRVYqh/Sv7EMtQqtC34QDTvL7wt79KX2twu4fWYY
	7zWb7e4BZlhwGl1kLNR9iCtAd2/d3G43AfFt3WU08KSaL9u68NDGNnNM9dLU2g==
X-Gm-Gg: AZuq6aLogIDM4LMyNj19pNqIxtZSB2sU8Lv5mfyZDqzhVvs/prLjCNCjBJE+wcRTQQq
	EQG1iTOu6YNm/b9wSKKConIeLOmjJvE8gL2w9H/5qzlf5tg4wDZC5cbpo9LbNJxFtxWeWl3hkLD
	s4UnbJwgz6qxN93JAv67dKzo2NRWbIBLkm6YZENk89Y/9cI15mI82uKY5wrY2zhl9Ip8QxuRlOG
	y4FdJ/BHFypwI9J5+StPpNoU1CTiOs80ssNdAcTkmmvL/vb7X9SqypWkX9etaywiKJZyLnHu39C
	Qajpw1x/Sk0EFjSHbnbfS6KiJqKUH8lWitVydcZTWkjn7Iy5PsTpKPHBT8hmqsZLNZlTC+QO6mQ
	0B8usOee+s/T4XhkJAM5QzArO1YZR2kIpPb///A0d4nQN5qUlY+agc16Pe2yab7iRxZqwDJAt+n
	EfGw==
X-Received: by 2002:a17:903:1547:b0:2a0:f828:24a3 with SMTP id d9443c01a7336-2a8d99366damr49587775ad.28.1769836176317;
        Fri, 30 Jan 2026 21:09:36 -0800 (PST)
Received: from localhost ([2a03:2880:ff:50::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eedd0sm87330305ad.3.2026.01.30.21.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 21:09:36 -0800 (PST)
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
Subject: [PATCH bpf-next v4 13/16] selftests/bpf: Update task_local_storage/recursion test
Date: Fri, 30 Jan 2026 21:09:16 -0800
Message-ID: <20260131050920.2574084-14-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260131050920.2574084-1-ameryhung@gmail.com>
References: <20260131050920.2574084-1-ameryhung@gmail.com>
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
 .../testing/selftests/bpf/prog_tests/task_local_storage.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index 42e822ea352f..559727b05e08 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -117,19 +117,19 @@ static void test_recursion(void)
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

