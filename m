Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA4813B58C
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 17:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769968274; cv=none; b=ZACIF95TF5noOslR49zITjoAxjRbEeU1MXPNcNHFEgJP952x0CT1tcTWDtrD6JLmQ92eF68ZKjlRS13pxM+F6pqvrlxT8VV9nqZJbp6xf6rd0fkIhcDNz6NXzUnm7e4RIhLrk+H9ALAwVlShfH91PKYQWehtXaLrIHFzT6Psd+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769968274; c=relaxed/simple;
	bh=TADLOMRKh4Q7PejR9tjfy5dVMNcv1vOqD5dk+oNJKhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIIIFETeF3tuA+qA8cvgQ6iFHzgepbhraipwekdDFhnrZnqdm4HESltgWDaD0CsTMxvqCogssuWowtqB9rBwQPMhZAMmExlLKp6x6YSpqHWL78n5R9PT85sIi8beZ5QcBHSGGGTINkWPCCoIO3kSoqWuRjuL2ejyGsXje4l6B+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgD3a3GM; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgD3a3GM"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34c708702dfso1923185a91.1
        for <bpf@vger.kernel.org>; Sun, 01 Feb 2026 09:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769968268; x=1770573068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYHVAl2Jp6GfAhmX3kqqnc7v6eyJBa0A6W5eDY8skXU=;
        b=KgD3a3GMXpnsWPTJf7bDLd0ytX7nFM0ngn8IA5q75U2b+9M5DzsdrgAkmf6gXkhbzP
         VHLAoRfQ1eX6K4hB0XYj1hEZKtiBkm0uqi7H31lrT4lnBoq08hHBjBZqdAQO1UrIHtW5
         IeEMwUL2kf2JCN65XvukO1kPrsFEwKJg59bLzZ+NxgufMqVh/aJWYAXGlx53PTuEuALg
         4DS8PB8Cob8MsUJnrzSi1uz7hZc/dkTFEvrOnjvORHCbz1fJSkKk75LObycUsWDBj5be
         QBVsgpj0Pwm40K1fyxfX8lHBYGUSFh26pfw/HPO98OHFM0auzN+eY15fxSHnbUcWkbxb
         6CZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769968268; x=1770573068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NYHVAl2Jp6GfAhmX3kqqnc7v6eyJBa0A6W5eDY8skXU=;
        b=pUxb89Oq0HQ+IVZCj5ZIirfcOlQRmj1LybBS1NljIyjCYKzOCXz3XMTdRlrewz2W25
         cWyLcA8ORuAa9DrVqlPTXkV+lPeHCCER9dwyNCpRYuoPdX/TK532m9D7+wYEcBsxuShF
         6LHXvN7qCV6qpzN1HDIe/XpEMAgmnR7siu0cPXw8HqFGGG1YYxhklO4HB7vpzQfDzBqd
         IZjRVnxK8bIvlLey98++vJqBADgpKGrjuizPQWHMzOFsQ2FOxisZsGQFevGZVUEWuEPt
         MvsXkO6UAtOHo8u/4zX/Yzmy4JahWBOd7aLX+3qLKB/SwO8ZlT6DsClQ/y6YTPcDT+Ew
         WaqQ==
X-Gm-Message-State: AOJu0YzPs2VeyBiWUYHBvSuuXxqRzP8GxckemD76f4Wbi+ITwkVhpGf8
	S+OFvaPjTEQbLuGAfDovCP1PP7gPhcOoOJoUuoMwHPCko6zPZt3yEocnlDcJiw==
X-Gm-Gg: AZuq6aIMrkJ+yC/VX7w8LZYAafkU7aql7nrlN1NfmLjlA7xiZwCCvtw2FnQL9LdcLY9
	O5Rlvk3f1/r1284rIk7UVf0gxXtEFp+e9QTYbIVMcMaTzlA57GGUi0hgiUL0r4wQhIOPcibNqmJ
	v+jUBqzQOjD8sRvQ2EQVUJ728ybBA1tJkZofHcT0xNrJtWcsUGgzgOCUFfnoucSGzcpWk1Fp0fe
	WYocUu0sATXJM5wYtRDF+haJxI+6I/faauV+4ddGi9wLzLJ7rkIp9xi1ZCLopqD2VVPskMovwmv
	avKOCe7HD3YSD4SCOw9RRCheDN9ddUK0Ow/FI7nMG68+Bd7DqkJ4ZxQT27pmdb69/4EdmcWv63L
	9mWutipj3Mrxh4NdkV1RE0Fxl6BOMUFI7G6mk7buaqPqRXoviFi/xKpJJEcO0w1zD1cW3TaNbP3
	MG+CF9rSdLA28=
X-Received: by 2002:a17:90b:3b42:b0:353:6373:590b with SMTP id 98e67ed59e1d1-3543b3138ecmr10128847a91.7.1769968267672;
        Sun, 01 Feb 2026 09:51:07 -0800 (PST)
Received: from localhost ([2a03:2880:ff:d::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f2f24aesm13228350a91.6.2026.02.01.09.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 09:51:06 -0800 (PST)
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
Subject: [PATCH bpf-next v5 13/16] selftests/bpf: Update task_local_storage/recursion test
Date: Sun,  1 Feb 2026 09:50:46 -0800
Message-ID: <20260201175050.468601-14-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260201175050.468601-1-ameryhung@gmail.com>
References: <20260201175050.468601-1-ameryhung@gmail.com>
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

