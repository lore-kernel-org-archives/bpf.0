Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF2A38AC99
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791476018; cv=none; b=hTcz9f4GtrDbUuGIk8QCvsxIdqROXtuBY1dq5fpG2UsxNF0jvyALo5Yu61pu//POKJqt0UCyE5wGtgog6kaKS4CAWUxv8byJDLCIqt34Sh6vdYVbKQK2092xzvEkkRSeg2qFzmx3Z02UN/LNN+mpN2TrIp1MgsDPavLaYD9bX3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791476018; c=relaxed/simple;
	bh=ctjqrT0ClDhJ4kwgUJDSm0RQ29Lw8YZNFjREtaOVINs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dPLSHmuL2Wi0mVnCfjdPRhFNUi34HBRo4KGr8b6oU9/YswmVUM4HVZmTWofLkEvFJC2wLwXH1mBYX63wujW+7BssyAMdN3Ykb9Q2q7lr+0gg75Ke6t0y3bm6UxpRtjknL3r/2JXTgpfO160QTaEUEVeEXICLmojMWdyMXx6T/7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkXuoTl4; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkXuoTl4"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48c4649b3aaso2180128f8f.2
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 09:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791476011; x=1792080811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KnRbsO40pgOKFThX66ioZGni0tsr5d/QoIBkjkvb+Kg=;
        b=bkXuoTl4eWiSXjN2RrMA6Ib+g470o74VfdAjkePD6r5kBQO7kLhHy3biGpxsZ+X7JT
         8SuKLeUF/IIaS31Em75cRDNMQ7CrYEuFp3/sbMZYjuDiC/kkvoD7iPZZMRInqlUDB7/2
         Ow0wN+2qj63VMY+88d6jFl078TDdA/Svc2CWs0xRNczLwhiszHOxcnKb/lNvlG2dCiHL
         VrzVnQoROGvGabw1QgbROCdob5Qu8Kqa7oN69Wm3KSleTtH/07AuBWXr8NTBKMSXfjXT
         dIdwJq6mGY3Ypj9hAVan+9ydVZiiLeVq4N1Lep/lXd9Ujsc9Ydr6B4TJNpY3M8GsGovx
         m9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791476011; x=1792080811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KnRbsO40pgOKFThX66ioZGni0tsr5d/QoIBkjkvb+Kg=;
        b=k3zV8r7R1+fKoOHDoI+maXOeCSvY0c1L1t/ECarL0mpSGIMsOn0zLPHd0VViKagHcz
         qHWJEevzEjETFpppRCJdNTy4tCgHi4c/yDIoJ1nzPwhUwTBngK10nV3FPg+0JLm30Bq2
         5U/nDqb2cbIWDyhZxEjNI2vhKCiP+V1d9GwajFUxOuJEmIg4+JLtgdvqYW5bxo8uEqzN
         dKgnZw1yp12wLFmWW3AyJ77p9kQsXr5k2NM2SsPd1LS5PyB5Xv5EObk1YSFNrPcT4ECH
         415IzVsWjY9res8A8UhW9aKZ7yJiWYm1xra42MLhrtBUvVuZLWULIsiQkPgqAVSHb1jY
         hdrQ==
X-Gm-Message-State: AFq9FYJD0zcIHAaUsshPao0Xl4jVnxdP6t6iYSo96jtfgZLmm0W7D+9H
	kXXYP2brFaTGN632trjrvZuePRCqHV+ZXAjwXH7FyWa6I0pkWM5wE99bmG8xn5+yphc=
X-Gm-Gg: AYBFou0qDqvEvlOj4mE+XMkwKWDc+1iLHj+H3DVyKAHTIqrcUVQwOAspuOCsOFyhDsQ
	29EHcDEEhsXd19BGrUYtdnDauZL3K2H/5WaqwSk0+7ia2FSPAfPr6QH9UvHVK+cb5L55uIq+EiO
	FMaFOU3W1JTnqmmuwRSlsEtWZ7iIfJ0rq2DMiBbs63N7T7OLuJFkYDrPxyHRuwZMdK+O1k3qiEd
	mS4+F7/MokG9LQDwkvGHVvvk1G5ITFu29JNs3gcgOFO9YFu5RQRsHlfryTiOtjBLpK9otP7eWD2
	ure/SSKWSV8bz97R9jFNSjkrvCacRTM1xgc9iWsLiG2qfY7lLnG0FXuk9rEfis2vpezsLxi8Kej
	6YWFVem7JvMy4OEBuO5tYt638BpzEny5WluVboc9fS8VtKEl+UEeBS0ADEXYuNeaTNg5t3LZk3V
	F9rV7VIJ5oTD/lTRQNMgApgc8seooswOhXZOMS0IPg8unil7UVVz9jSQ/8xM29a2z93wxNtZRRx
	A0SlHo1kHMjS3kHbs5IAjMhIVPJqfCjBhMPHw==
X-Received: by 2002:a5d:64c8:0:b0:48a:f52d:ca47 with SMTP id ffacd0b85a97d-48c72785207mr12533471f8f.22.1791476011230;
        Thu, 08 Oct 2026 09:13:31 -0700 (PDT)
Received: from MacBookAir.home.tenber.ge ([2a00:6020:a725:dc00:95bf:d5d1:d7d8:747f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db63401desm448005f8f.0.2026.10.08.09.13.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 09:13:29 -0700 (PDT)
From: Jan-Gerd Tenberge <janten@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	kuniyu@google.com,
	willemb@google.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 2/2] selftests/bpf: Test iterator link target validation
Date: Thu,  8 Oct 2026 18:13:09 +0200
Message-ID: <20261008161309.8179-3-janten@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261008161309.8179-1-janten@gmail.com>
References: <20261008161309.8179-1-janten@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exercise target-dependent iterator checks during BPF_LINK_UPDATE.
Verify that updates to a program with an oversized array or socket-storage
value access are rejected, as is an update to a sleepable program on a
non-reschedulable hash iterator.

Run each original program after the rejected update to ensure that it
remains attached. Also verify that a compatible array iterator update
succeeds.

Assisted-by: LLM
Signed-off-by: Jan-Gerd Tenberge <janten@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_iter.c       | 34 +++++++++++++++++--
 .../bpf/progs/bpf_iter_bpf_array_map.c        | 17 ++++++++++
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index c69080ca14f5..3ae5203d3fac 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -897,14 +897,22 @@ static void test_bpf_hash_map(void)
 	/* Sleepable program is prohibited for hash map iterator */
 	linfo.map.map_fd = map_fd;
 	link = bpf_program__attach_iter(skel->progs.sleepable_dummy_dump, &opts);
-	if (!ASSERT_ERR_PTR(link, "attach_sleepable_prog_to_iter"))
+	err = libbpf_get_error(link);
+	if (!ASSERT_EQ(err, -EINVAL, "attach_sleepable_prog_to_iter")) {
+		if (!err)
+			bpf_link__destroy(link);
 		goto out;
+	}
 
 	linfo.map.map_fd = map_fd;
 	link = bpf_program__attach_iter(skel->progs.dump_bpf_hash_map, &opts);
 	if (!ASSERT_OK_PTR(link, "attach_iter"))
 		goto out;
 
+	err = bpf_link__update_program(link, skel->progs.sleepable_dummy_dump);
+	if (!ASSERT_EQ(err, -EINVAL, "update_sleepable_prog"))
+		goto free_link;
+
 	iter_fd = bpf_iter_create(bpf_link__fd(link));
 	if (!ASSERT_GE(iter_fd, 0, "create_iter"))
 		goto free_link;
@@ -1023,7 +1031,7 @@ static void test_bpf_array_map(void)
 	int err, i, map_fd, hash_fd, iter_fd;
 	struct bpf_iter_bpf_array_map *skel;
 	union bpf_iter_link_info linfo;
-	struct bpf_link *link;
+	struct bpf_link *link, *bad_link;
 	char buf[64] = {};
 	int len, start;
 
@@ -1049,10 +1057,24 @@ static void test_bpf_array_map(void)
 	linfo.map.map_fd = map_fd;
 	opts.link_info = &linfo;
 	opts.link_info_len = sizeof(linfo);
+	bad_link = bpf_program__attach_iter(skel->progs.oob_write_bpf_array_map,
+					    &opts);
+	err = libbpf_get_error(bad_link);
+	if (!ASSERT_EQ(err, -EACCES, "attach_oob_write_iter")) {
+		if (!err)
+			bpf_link__destroy(bad_link);
+		goto out;
+	}
+
 	link = bpf_program__attach_iter(skel->progs.dump_bpf_array_map, &opts);
 	if (!ASSERT_OK_PTR(link, "attach_iter"))
 		goto out;
 
+	err = bpf_link__update_program(link, skel->progs.oob_write_bpf_array_map);
+	if (!ASSERT_EQ(err, -EACCES, "update_oob_write_iter"))
+		goto free_link;
+
+	/* The rejected update must leave dump_bpf_array_map attached. */
 	iter_fd = bpf_iter_create(bpf_link__fd(link));
 	if (!ASSERT_GE(iter_fd, 0, "create_iter"))
 		goto free_link;
@@ -1092,6 +1114,9 @@ static void test_bpf_array_map(void)
 			goto close_iter;
 	}
 
+	err = bpf_link__update_program(link, skel->progs.noop_bpf_array_map);
+	ASSERT_OK(err, "update_valid_iter");
+
 close_iter:
 	close(iter_fd);
 free_link:
@@ -1363,6 +1388,11 @@ static void test_bpf_sk_storage_map(void)
 	if (!ASSERT_OK_PTR(link, "attach_iter"))
 		goto out;
 
+	err = bpf_link__update_program(link,
+				       skel->progs.oob_write_bpf_sk_storage_map);
+	if (!ASSERT_EQ(err, -EACCES, "update_oob_write_iter"))
+		goto free_link;
+
 	iter_fd = bpf_iter_create(bpf_link__fd(link));
 	if (!ASSERT_GE(iter_fd, 0, "create_iter"))
 		goto free_link;
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_array_map.c b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_array_map.c
index 19710cc0f250..beb1b714f120 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_bpf_array_map.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_bpf_array_map.c
@@ -51,3 +51,20 @@ int dump_bpf_array_map(struct bpf_iter__bpf_map_elem *ctx)
 	*val = *key;
 	return 0;
 }
+
+SEC("iter/bpf_map_elem")
+int noop_bpf_array_map(struct bpf_iter__bpf_map_elem *ctx)
+{
+	return 0;
+}
+
+SEC("iter/bpf_map_elem")
+int oob_write_bpf_array_map(struct bpf_iter__bpf_map_elem *ctx)
+{
+	__u64 *val = ctx->value;
+
+	if (val)
+		val[1] = 0;
+
+	return 0;
+}
-- 
2.54.0 (Apple Git-157)

