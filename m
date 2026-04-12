Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1446B1FF1B5
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 21:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776028001; cv=none; b=YKkMDzdZNMkGgkKjJ1Lbdg/prwW4/geSC41/tV6ew6YUtgRhkv5GEJxttKiHj8d1sUIopC5Ex0M+pVyZXOBtaBSfIKXqeJuedrjKLgR05BuU2oeVyUak0OyAoP8gpZ31G7PubXMscObsaBLHNtdEFlXVKd7yDoS9gqKF6V2rbio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776028001; c=relaxed/simple;
	bh=5prrjAsOQCrUaTyxgM5/zKJOVqL/fFRv43hdqj6D9Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e57rMX7WdpJbENbQNj4H9ywpflpoTrAGmWlsntWNJDQvt5K8IkLz3NPCzKFQ8j33EtDbuk9ZKGBd4BBwDqfcLBFcdF9rXQlvcy4rrjUfl617ml9kBYntTURvNRnlR6idGdhd0FZmvq49sNwu9x1cq1iu1p6nYGiKq23chKC1QLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihJTbICk; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihJTbICk"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35d965648a2so3115861a91.0
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 14:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776027999; x=1776632799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JznjFapbdb9VgsxIU6h6Rnj+fkyJs2JPdnyTNJj0hN8=;
        b=ihJTbICkpVe2qOoAn3sR0lsunXe992rBD+iHgjkVjyzE8q+EwnJEHj6v73R4MJHZI5
         YcpnaxurylN1goCB+lZwjucCMgjhdQrEULQnSIjUWDG0HxZ6clSi1/Vywlka4HEFHRJe
         4Rzj9q5iZjPeWTfCa2ms+BSThwAq17Xnq4FsrMjQBO80e8yKyeZYnrgxZVWX7isnNfvP
         lDR2ZXLM5Sy8zjoKbknz+2VQ+gkSvqT5AkditilAd5ys1qW/BkbCZpqvFmV7/xUCGBbv
         5Dgu7LHhqgXKQKPZFCuUFnHHsr8K3dBFRkBhsJlc9/LnkoCH7nfi6QvjFKePAKuCn2Wf
         KA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776027999; x=1776632799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JznjFapbdb9VgsxIU6h6Rnj+fkyJs2JPdnyTNJj0hN8=;
        b=XiV0OF4T1lPSbKGJFYgtVAvL9UOgwm2DaF8OsXMKRq8yJuOCwiTviLngZNi2NY1Dug
         QddHEzv62pGgpk0IDLicBYYpxgf9epBvbje07dGETwcQvU3p6LMnu9UVPNn61Os8VhYN
         Zkcl8asdrSwFXYWYg7Vn1fSdlCRVUcJxdQOmpDWVJwVr3/5t1MMYPVh9U15q6BS96QmI
         flkXDXC0YYwU5ARpwXEwf3GSdHgNJbazB9PpfscshDTzaaFHqK3QUWQR5OR/g6kXv+Z6
         MFiMq/P94+PLkgcTcw7bk1oOLdGLKSLr/RIv9VHdQabNER/adEeNBO3S4UCwTtcebvBB
         O1kA==
X-Gm-Message-State: AOJu0Yzf+I4lzcaPBkgATefoYm0nET0AVNq/7wSnJxJivkqGSIMbxb2G
	Uh8KGAjW4oaKGSnPjd6R/cxw7Sgkg2NqphKvG6kYUhFikRHfUCshN/2X3n8MQQ==
X-Gm-Gg: AeBDieuFYMViuKlmV2RFYSH4lKq7qST+WNuA0hqNJD3fEwaTQC0BrCiCUyieHZNL7E/
	1kA/2g4pemEfdAVi8vQNlopclXKDgMk6qoe3dRRns9fsjB9emmT6nHEomXN1Mia2DI9MrQ59y0q
	nR6Fs2gXN0hBcZixreAIqJxUPE05UZ+fvMX3QQVR4oUh/wfScUGPkFnqtdTWgdbSod0oXwTrMT2
	ob1QJlOMqtzjTRKl0vya+tuz3gXrL9HVyKhY6zifHPf/beGJk0+Tw773XwMKfL6ooILn1nfMOxb
	YkC51d5gKX65ic907YquZwcP8m7nod0m9TKM23j91fEf0wNujZiOjMRcYv+SdNtHIwn+EKJsrmb
	HRH4ciP0xU1IJpvT9oLeOVYZbgyio0ChkGPiKE3ZPAHTumgnmVZrwj93gAt+Wc6Amlq+fIbYl/Z
	vx0IMSWWZfXDGQ39+NqAYZmtUuzMh+tBg86OrnjNIv1JXYb0Vm62d2SIvtTFxae/6DLfphPW8Xw
	TtNU9I7ndEi2hcmEOqHPk6mXo34YW1rBXScG7SWzvz3t3ovuMI1Jqxmty8AUA==
X-Received: by 2002:a17:90b:28cc:b0:35d:aeb2:25b2 with SMTP id 98e67ed59e1d1-35e428cda1bmr11477378a91.27.1776027998881;
        Sun, 12 Apr 2026 14:06:38 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e3517f2a0sm17082205a91.17.2026.04.12.14.06.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 12 Apr 2026 14:06:38 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH bpf-next] selftests/bpf: Use memfd_create instead of shm_open in cgroup_iter_memcg
Date: Sun, 12 Apr 2026 14:06:36 -0700
Message-ID: <20260412210636.47516-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Replace shm_open/shm_unlink with memfd_create in the shmem subtest.
shm_open requires /dev/shm to be mounted, which is not always available
in test environments, causing the test to fail with ENOENT.
memfd_create creates an anonymous shmem-backed fd without any filesystem
dependency while exercising the same shmem accounting path.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
index 88fc3e83d2b7..b7c18d590b99 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
@@ -107,10 +107,10 @@ static void test_shmem(struct bpf_link *link, struct memcg_query *memcg_query)
 
 	/*
 	 * Increase memcg shmem usage by creating and writing
-	 * to a shmem object.
+	 * to a memfd backed by shmem/tmpfs.
 	 */
-	fd = shm_open("/tmp_shmem", O_CREAT | O_RDWR, 0644);
-	if (!ASSERT_OK_FD(fd, "shm_open"))
+	fd = memfd_create("tmp_shmem", 0);
+	if (!ASSERT_OK_FD(fd, "memfd_create"))
 		return;
 
 	if (!ASSERT_OK(fallocate(fd, 0, 0, len), "fallocate"))
@@ -123,7 +123,6 @@ static void test_shmem(struct bpf_link *link, struct memcg_query *memcg_query)
 
 cleanup:
 	close(fd);
-	shm_unlink("/tmp_shmem");
 }
 
 static void test_pgfault(struct bpf_link *link, struct memcg_query *memcg_query)
-- 
2.52.0

