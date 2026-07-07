Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A1623E334;
	Tue,  7 Jul 2026 08:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412161; cv=none; b=f8p3p2qz2d7pj1oOTDQakMqA+ENZ8vlTa7AgHIRCx/U0RDwYZ4DbTfpiIXZAsBRbokHWhbEUiEDKDXM1bVuuGRSmuXYx8BXzq5E3YVVC0aPlQRlOMtT4pSEfFqK8NaG4SOumXt91sKLKD5xBoAUXbeXzlIaf8JsXVBaVTMe3/KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412161; c=relaxed/simple;
	bh=QqoJU/JG16Ze/tMMCEdTlKiakq3ltdOJBhDrntajUUU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JGEOeNIguLu5w3Rfu7DlyfJ4+fJDOxH5ZN7KleBcGZYmwTPyl8BQDkltCbH54MOjcsjfgHG42MwpE6Ep38pFJdf45SI6yU7Zmj/VGwe89K2JzK3b5z2Zry7xmm1Tlu8nRaKFeRZ1P+y9gsFbv6UL9RtlInWjXt07MKKlSWJQkuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gcQUa6OU; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gcQUa6OU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ho
	dYro4wZAm6E+qsMZuopCMoS+bPSflPCXm/NCusRIQ=; b=gcQUa6OUdmHP126iKI
	gnIqCIYP2TqdEE59LkU6ktX2oBBHn17Wx4F9VswMxjjoGwuHY8AnsjQbpC//1EE4
	OUxP/SVbqqrjC7OKmPYL4jKSUjo2efnE/QhWXqGItIazO65u52IElwTOw9UvHEW5
	bJXFlTcXCw9OWh0gwY198k0SQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wAnL8xqtUxq1q4tIA--.53457S2;
	Tue, 07 Jul 2026 16:14:36 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: Fix memory leak in msg_alloc_iov
Date: Tue,  7 Jul 2026 16:14:34 +0800
Message-Id: <20260707081434.539327-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnL8xqtUxq1q4tIA--.53457S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF45Gw4UCr17tr4rZr43ZFb_yoWDZFg_Wr
	40qwn7C3yqyF95Gw18Wr45Crs5Kan3Wr47JrZxXFy3Kr12qa15JFsF9rnYvay5WrZ8CryS
	yF9YgryxtF15CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8e6wtUUUUU==
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8Qw2rmpMtWzODQAA3Z

From: Feng Yang <yangfeng@kylinos.cn>

In the msg_alloc_iov function, the iov pointer is only assigned to
msg->msg_iov after all memory allocations complete successfully.
Therefore, when a calloc failure triggers the unwind_iov cleanup branch,
we should use the local variable iov instead of msg->msg_iov.

Fixes: 753fb2ee0934 ("bpf: sockmap, add msg_peek tests to test_sockmap")
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 tools/testing/selftests/bpf/test_sockmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 3e6be455d158..aaf2050e8845 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -435,7 +435,7 @@ static int msg_alloc_iov(struct msghdr *msg,
 	return 0;
 unwind_iov:
 	for (i--; i >= 0 ; i--)
-		free(msg->msg_iov[i].iov_base);
+		free(iov[i].iov_base);
 	free(iov);
 	return -ENOMEM;
 }
-- 
2.43.0

