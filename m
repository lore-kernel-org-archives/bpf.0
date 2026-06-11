Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135C735504D
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 15:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190471; cv=none; b=TyVMCLGhd89YCxpsBAoc322fLFEKMjp8EosQH36kKuLH7l2NzKiZydo88x+5Y44nxytJuJKuy52ox6MSwclOr6+nSuKo7iaSZBIyxtNgbVQDP/AslAvKQ3RB1/ZTbUQFf8H0SfhnKoK8b2JgG+lU9mS8UOInclJnmxD2vUcsBBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190471; c=relaxed/simple;
	bh=9FEuV5fSd29uNBGYMcM4imW91zywpwZ5wJYK4FqNSvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ePkoelkez7V3jPVKzECPtcp488ADwHaL/G5zbr0F6RvSXDeoJ2jjtlCXOHWUB9d3nZieSiMQovy7bLkEyCBFFarvu2tdX7Y0dbPVhOymBryXzoSba3+u+E7+iT41AqhSwivE3iWvGaH9f7qWvub7uQaglejnfRVjy8S6wZn0ABU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N06gQObH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N06gQObH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781190469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HLMNQWK2qUjD76HjTu4AN6U4NjDfgr0okMXaX6F1/oM=;
	b=N06gQObHu3p33xcF6MrUEB1nOai2i7kVKBubytShLl5MUbgWs4dVxcd4chWJy5Y2gqQPXr
	/4HZGNetEDhttbs2hUtCnhS2wJ5XoKvcdr8GPDtY7IvFd5h9d8X0SB3lq9cQHF/x4q0X7x
	BGfUVVFWAz3UmNDmM85mrEVMyzzWT6A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-tZiFQOrbPjWXr5V1ILfKng-1; Thu,
 11 Jun 2026 11:07:46 -0400
X-MC-Unique: tZiFQOrbPjWXr5V1ILfKng-1
X-Mimecast-MFC-AGG-ID: tZiFQOrbPjWXr5V1ILfKng_1781190464
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4AD9B1953963;
	Thu, 11 Jun 2026 15:07:44 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 13128195410A;
	Thu, 11 Jun 2026 15:07:40 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH bpf-next] selftsets/bpf: Retry map update on helper_fill_hashmap()
Date: Thu, 11 Jun 2026 17:07:03 +0200
Message-ID: <20260611150704.95133-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

helper_fill_hashmap() is used also on parallel and stress map tests.
Those are consistently failing with ENOMEM on kernels built with
PREEMPT_RT if preallocation is disabled. The failure is transient and
only called by the memory cache refill running in a preemptible
irq_work, which can easily stall in case of contention.

Use a retriable update in those cases to handle transient ENOMEM and
make the test more stable also on PREEMPT_RT.
Also fix the sign of the value printed in case of error (strerror()
expects a positive errno while updates return it negative).

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/testing/selftests/bpf/test_maps.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index ccc5acd55f..c32da7bd8b 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -260,6 +260,16 @@ static void test_hashmap_percpu(unsigned int task, void *data)
 	close(fd);
 }
 
+#define MAP_RETRIES 20
+
+static bool can_retry(int err)
+{
+	return (err == EAGAIN || err == EBUSY ||
+		((err == ENOMEM || err == E2BIG) &&
+		 map_opts.map_flags == BPF_F_NO_PREALLOC));
+}
+
+
 #define VALUE_SIZE 3
 static int helper_fill_hashmap(int max_entries)
 {
@@ -274,10 +284,11 @@ static int helper_fill_hashmap(int max_entries)
 
 	for (i = 0; i < max_entries; i++) {
 		key = i; value[0] = key;
-		ret = bpf_map_update_elem(fd, &key, value, BPF_NOEXIST);
+		ret = map_update_retriable(fd, &key, value, BPF_NOEXIST,
+					   MAP_RETRIES, can_retry);
 		CHECK(ret != 0,
 		      "can't update hashmap",
-		      "err: %s\n", strerror(ret));
+		      "err: %s\n", strerror(-ret));
 	}
 
 	return fd;
@@ -1392,17 +1403,9 @@ static void test_map_stress(void)
 #define DO_UPDATE 1
 #define DO_DELETE 0
 
-#define MAP_RETRIES 20
 #define MAX_DELAY_US 50000
 #define MIN_DELAY_RANGE_US 5000
 
-static bool can_retry(int err)
-{
-	return (err == EAGAIN || err == EBUSY ||
-		((err == ENOMEM || err == E2BIG) &&
-		 map_opts.map_flags == BPF_F_NO_PREALLOC));
-}
-
 int map_update_retriable(int map_fd, const void *key, const void *value, int flags, int attempts,
 			 retry_for_error_fn need_retry)
 {

base-commit: 2d3090a8aeb596a26935db0955d46c9a5db5c6ce
-- 
2.54.0

