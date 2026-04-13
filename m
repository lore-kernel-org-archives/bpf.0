Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ED6390981
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 19:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776106984; cv=none; b=D3d7j2GqSPAXtX8efz8DBKnA44h7Jk34YTI1XBi+yt2YKUtKTkrawS5RU0CEgG3LsuQPBJgTJGpw7Bu4pnlZ1becXcvVSn3cWVz1xIe7AaZauijCSROmJ+O2Y2uYtrjgaUqfFjYpybg34zGtVU60EdZx/ulwdqFuVuDiVpC42f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776106984; c=relaxed/simple;
	bh=wcogO+yi9UymmqXKF1p/G3r9lV+G0rzLcrvkUW6ZthE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cn5LBI/LN3mGqxnmFl+7PZ2iGbsbB7UAft86pX0v4V3J2yxADRI3MZ3CVIDUwm8xeuWW9JD86eDh3W8TBaLTW5W+wKO2Zm3CFyeOZ2l5pfBXcotw+QeB+eH1H/VEtrpndqNUcgXxY1QJo3mw2vnegU0fLEY+tfrIMl+Y3LiWVTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXaysll4; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXaysll4"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82cd70febc7so3210024b3a.2
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 12:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776106983; x=1776711783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LPzNhJ9SoJ92wROfmZC7oCsB29Lo57fmL6CTPDCcEk=;
        b=YXaysll4OCszhuD66aoCBDkfn3gTj5soTwhMGBIfvKXcxEdyweXMLv8UAE7MwD0xX3
         NILx5B2nYatTgmBhMjINTWuW8KFU2aSdNoiXFUOLY1t4GQUa/u82HMoUpVcVPVRPDhY1
         DOF8PDS19JWDaHLxQd2LPPTO3tuF1NNH/A0mgVqxlpARfU3P+KjUi03E7IJa1sbE6xzz
         OqWZJFoKj3Cx1LAgXzTbSkXUEBGQZXt7JxT7YVch1Ictr1IxJvHBmo+CH3KlrdeL/u6g
         ANAQtuZX9OgSsHc7L19eWERHbGwHLqFlGKDtZB3lK1tsjblkH6ID9FXCM8k6rWcfZ9t4
         iQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776106983; x=1776711783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1LPzNhJ9SoJ92wROfmZC7oCsB29Lo57fmL6CTPDCcEk=;
        b=PCSl7jcu9jOh5G2H7DIgFOXKTp6yFD/G4iPI2lUK+DhZNuVfOrfj2/dLNYTnREc6yk
         vd5/Tg4MvTMHyym9Lk2cw6mriyJ5+Lf5KUOJtmz3wd6d8U4yh+uRvLyKgwftHzmPR1oD
         Er7axJKLsaIqSDkcc3jg0U2DLiZPoJztm1rmPtLXDwGS1ig15W3jO827GwlQZxUlWdbW
         JvZ9nbPJDyfZcLxpuWyC7CWK3cjjgjF8DLfXgpiklTOuVZ77z6OGmzsmytNlIyhqDz1L
         Xisg8hfJVZH//dEQn0amLjN8W2b2mAHUjvq4Ljf7k8xvehie0EuKFlUN4t8vzJ8a0x6s
         JPbw==
X-Gm-Message-State: AOJu0YwD1GpvPyv33kQ+TaUTQvLn14LM2JFrqtYkEH3AOYz3K7jkXW04
	CL5zD267Kg39ujtQ50DouPFfEqMLth6RzUfz31Y43SAELow602mmh4bhtOKrrg==
X-Gm-Gg: AeBDies6lqevHuzgN84LllpCqQfgCiVoEmfzyx9MIyttfeQXbZ3NWCddWnNpiv7RCxA
	HebsoK9pAHs0nN9ft6hYkC+FBIo5s0R/qsu3wA/kMjejDfz3wOyxRGYyXeXRzXSJbQpszrB00XN
	ywA6Xc81PGwFh8d/FwzfyhH1VojhanyRAJ4s1tFVhfHs4eNkQVPzdNJHMHBcY7eNraCvyrOid9G
	jb+XXHhF+xY+UkihaS0NM3DcAvm5TrDbK47caBBHfZJMMOc0lPjub7xPJ3QMbBibwKCMStYG5zc
	VRtzmghyYnAAFYWTY52muVoaiypEkP0MKVDWCKSYma1WCEK14H9IGvVNSoLsQcp57Sqn4/XCVN0
	/iNE78FoQ/Kl0RHgiohnHQ1NWXZJwdF9Ycl0SHDjT8E+SZP3HvmpzEW3Ny+c6WEmNKQ5EzCO0UD
	07C3V7gYc2ON8KeA==
X-Received: by 2002:a05:6a00:a217:b0:82c:d7c9:5479 with SMTP id d2e1a72fcca58-82f0c29fe3bmr15748682b3a.32.1776106982651;
        Mon, 13 Apr 2026 12:03:02 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:49::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c35194asm15176042b3a.20.2026.04.13.12.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 12:03:02 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yatsenko@meta.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/3] selftests/bpf: Fix tld_get_data() returning garbage data
Date: Mon, 13 Apr 2026 12:02:58 -0700
Message-ID: <20260413190259.358442-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413190259.358442-1-ameryhung@gmail.com>
References: <20260413190259.358442-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF side tld_get_data() currently may return garbage when tld_data_u is
not aligned to page_size. This can happen when small amount of memory
is allocated for tld_data_u. The misalignment is supposed to be allowed
and the BPF side will use tld_data_u->start to reference the tld_data_u
in a page. However, since "start" is within tld_data_u, there is no way
to know the correct "start" in the first place. As a result, BPF
programs will see garbage data. The selftest did not catch this since
it tries to allocate the maximum amount of data possible (i.e., a page)
such that tld_data_u->start is always correct.

Fix it by moving tld_data_u->start to tld_data_map->start. The original
field is now renamed as unused instead of removing it because BPF side
tld_get_data() views off = 0 returned from tld_fetch_key() as
uninitialized.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/task_local_data.h | 10 ++++++++--
 .../testing/selftests/bpf/progs/task_local_data.bpf.h  |  5 +++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
index 489f07045c9f..8ae4fb2027f7 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
@@ -99,14 +99,20 @@ struct tld_meta_u {
 	struct tld_metadata metadata[];
 };
 
+/*
+ * The unused field ensures map_val.start > 0. On the BPF side, __tld_fetch_key()
+ * calculates off by summing map_val.start and tld_key_t.off and treats off == 0
+ * as key not cached.
+ */
 struct tld_data_u {
-	__u64 start; /* offset of tld_data_u->data in a page */
+	__u64 unused;
 	char data[] __attribute__((aligned(8)));
 };
 
 struct tld_map_value {
 	void *data;
 	struct tld_meta_u *meta;
+	__u16 start; /* offset of tld_data_u->data in a page */
 };
 
 struct tld_meta_u * _Atomic tld_meta_p __attribute__((weak));
@@ -182,7 +188,7 @@ static int __tld_init_data_p(int map_fd)
 	 * is a page in BTF.
 	 */
 	map_val.data = (void *)(TLD_PAGE_MASK & (intptr_t)data);
-	data->start = (~TLD_PAGE_MASK & (intptr_t)data) + sizeof(struct tld_data_u);
+	map_val.start = (~TLD_PAGE_MASK & (intptr_t)data) + sizeof(struct tld_data_u);
 	map_val.meta = tld_meta_p;
 
 	err = bpf_map_update_elem(map_fd, &tid_fd, &map_val, 0);
diff --git a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
index 1f396711f487..0df8a12fd61e 100644
--- a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
+++ b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
@@ -86,13 +86,14 @@ struct tld_meta_u {
 };
 
 struct tld_data_u {
-	__u64 start; /* offset of tld_data_u->data in a page */
+	__u64 unused;
 	char data[__PAGE_SIZE - sizeof(__u64)] __attribute__((aligned(8)));
 };
 
 struct tld_map_value {
 	struct tld_data_u __uptr *data;
 	struct tld_meta_u __uptr *meta;
+	__u16 start; /* offset of tld_data_u->data in a page */
 };
 
 typedef struct tld_uptr_dummy {
@@ -176,7 +177,7 @@ static int __tld_fetch_key(struct tld_object *tld_obj, const char *name, int i_s
 	if (!tld_obj->data_map || !tld_obj->data_map->data || !tld_obj->data_map->meta)
 		return 0;
 
-	start = tld_obj->data_map->data->start;
+	start = tld_obj->data_map->start;
 	cnt = tld_obj->data_map->meta->cnt;
 	metadata = tld_obj->data_map->meta->metadata;
 
-- 
2.52.0

