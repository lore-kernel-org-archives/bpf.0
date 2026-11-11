Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365087;
	b=cMTxxpoXK17Ct45YOJ721yy1bPOH6EH39zwTXiNhYEg7e2cIJYO9GLvVPycUCyhQjhKT
	 E59kM9C1HQy/CfiRppH8sQtSRNtRR5DSSmC4OJIVNRU9x/IzaoVP4KQmuaz6klhOhUJcC
	 r3V1woRX26X1n7y71CASVyKF6oL6byeQ4uRT4HWzQp/kwPN1KgcjHTXM0+1jAOjCTiO7r
	 2hKHrTv4ahxSkXlwuuSvvEgQZX+BLH/IZPdDtO+DTi6Yh+W7tOzYGQ+ToZ3Cs3yxhk6av
	 0QgCKo3SZ5ugzem/8gczMY1DqPoMdkLeMIOENYafxuk5tbTE3ScKZsVcx1KK4AUpJYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365087;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=9rgwOcxR7ffaONZd7lmNf4B7S9LxkedcsGDeJcdx5iQ=;
	b=aWHfjkIqN4EG2BVw1vd/h/PDCRPKM52SYxIStA4cvT7egyFFlXYqm9xWQf80RJQX+BDM
	 DekvTbXOZAtUZUxeKkxisiJebFsc3+rusOxaPGJtU1X+tioMIGa0XMfk0Et7TmbgLxIRn
	 Tq4nWZGQ9E0wF1j0jE//uSEZ2RxOZMMmhanTkpWhvBKd6LjF8LVhj7C1O++4Wgq7mxT2H
	 jt0ef6HUDZbb6E8b/SuMa6q1jCGU/Z8dWkl4MG1z4yIg4YygZBSGvx6lA75pAsxsKxhsv
	 3+xxHd+vcpsrCJwsLHV7ywE6eytcds1OVrYdeeJNYATxmhMAQ0fzD/68ffeMQx6goBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=FBXd2ri+;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194BB606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 02:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 194BB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=FBXd2ri+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=9r
	gwOcxR7ffaONZd7lmNf4B7S9LxkedcsGDeJcdx5iQ=; b=FBXd2ri+xT4zS4ln8A
	J3msIHNTirm6Z1SACGmTjJ9maZYuP9Q6UzCRE04uC098RILRsZW8YxXgo9UBU6nS
	ML6yFnCxmJtpcprYyB2BOyOC36nB2W9bBhdbUgMqu4b2+zaQPsJIencNXwXziPTB
	aRMRPHSKp/ok1TJO9G4lIjGHo=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgBXCgpq1vNqdIGjEw--.26036S8;
	Wed, 11 Nov 2026 10:43:58 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev
Cc: yatsenko@meta.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 6/6] selftests/bpf: Test wq set_callback on a deleted value
Date: Wed, 11 Nov 2026 10:43:33 +0800
Message-ID: <20261111024333.228633-7-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111024333.228633-1-luyun_611@163.com>
References: <20261111024333.228633-1-luyun_611@163.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgBXCgpq1vNqdIGjEw--.26036S8
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw1fJw4ftFy8Kr1ktFWxXrb_yoW8XFW3pa
	yrArWYkrs5Wr17Jw1Syw4fKF4rZws5JrWUAr9ag34DZrn3Jr9rXr1IkFyjqFn8ArZYqr4r
	Ca1xK3ZxCw48Z37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5dbbUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7A5oN2rz1m5juwAA3E

From: Yun Lu <luyun@kylinos.cn>

Add a deleted-value case to wq.c using its existing NO_PREALLOC HASH map
and callback. Look up and delete a value, initialize its workqueue, and
assert that bpf_wq_set_callback() returns -ENOENT. Do not start work on
the deleted value.

Signed-off-by: Yun Lu <luyun@kylinos.cn>

---
 tools/testing/selftests/bpf/progs/wq.c |  20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/wq.c b/tools/testing/selftests/bpf/progs/wq.c
index 25be2cd9d42c..4bd663d427ab 100644
--- a/tools/testing/selftests/bpf/progs/wq.c
+++ b/tools/testing/selftests/bpf/progs/wq.c
@@ -3,6 +3,7 @@
  */
 
 #include "bpf_experimental.h"
+#include <errno.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 #include "../test_kmods/bpf_testmod_kfunc.h"
@@ -138,6 +139,25 @@ static int wq_cb_sleepable(void *map, int *key, void *value)
 	return 0;
 }
 
+SEC("syscall")
+__retval(-ENOENT)
+long test_deleted_wq(void *ctx)
+{
+	struct hmap_elem empty = {}, *value;
+	int key = 0;
+
+	if (bpf_map_update_elem(&hmap_malloc, &key, &empty, BPF_NOEXIST))
+		return 1;
+	value = bpf_map_lookup_elem(&hmap_malloc, &key);
+	if (!value)
+		return 2;
+	if (bpf_map_delete_elem(&hmap_malloc, &key))
+		return 3;
+	if (bpf_wq_init(&value->work, &hmap_malloc, 0))
+		return 4;
+	return bpf_wq_set_callback(&value->work, wq_callback, 0);
+}
+
 SEC("tc")
 /* test that workqueues can be used from an array */
 __retval(0)
-- 
2.43.0

