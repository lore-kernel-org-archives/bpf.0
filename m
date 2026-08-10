Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97934192B75
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 01:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786326794; cv=none; b=IEOz2D237nezAgQe0SZ2Nd+d0JJ5DuTfxToVagA+U3l3Tx82PWIqbHGoY1oML8W0Vuon/2ZwXtK7rUqn7QvFNd2lnGDmI4SzsO8sj0l9ogSd+8uY/2iBAEL9LJfgtc9FGS3hBMY1SKU8o0a0P9y9n0OuzGcRWQIDsW8hXTQUFWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786326794; c=relaxed/simple;
	bh=HOedCOa7JbHQxDb9QtMNeGJaDxLQ8cbPJV60M1RYTj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FGfD33if4lcHWVHCWs3lbiz/RKjcWy50bi3zyzG4oNy7u6H204VsOUlRHx45HJ0UHL0AtML1u1nU1JOGT7OwKxC0HmW8LTRUBLlLE8vvpVqfCHBRThHUnuLVphO9bJF6bgoT1SO9Po7niNpluZEFDoS2ZtvpkJJFPqV7JDSrELo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Z9npMjV8; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Z9npMjV8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=/B
	PA5mjUTcdtwf9bJhf80St3msgFMA8BoYtoPsajUM4=; b=Z9npMjV8WfEm3Umqil
	mFt31+jSvAsekJ33FIyhxf9knrhOBqEkFg8ybRSUHHTOloosCOo/8xFv1xV/r1aN
	FLeeJkOAT7oHdv60k9Dli/vl114aoVtNSd/xe55/9YYWMJ16ojpj7ZP8kH8fXUun
	7XemhsXASLFCYGynwgrb8Qkx8=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDHJhfZLnlqp3VjOA--.14579S3;
	Mon, 10 Aug 2026 09:52:30 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next 1/2] bpftool: fix double close in map dump
Date: Mon, 10 Aug 2026 09:52:15 +0800
Message-ID: <20260810015216.2369940-2-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810015216.2369940-1-chenyuan_fl@163.com>
References: <20260810015216.2369940-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHJhfZLnlqp3VjOA--.14579S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtryrZr45Wr1xAw13Kw1Dtrb_yoWfAFgEgr
	y8XFZ7WF1rtrW3Ca1FkryUuryIyF4vgF48JrW8Wry3tw45Ja4kWFW0yr1SqFy5JrZFyFnr
	CFZ3WrW3tF4fAjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0pBTUUUUUU==
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5h67eWp5Lt6CPwAA3k

From: Yuan Chen <chenyuan@kylinos.cn>

map_dump() closes the map fd in its error path, and do_dump() then
closes the same fd again after a successful dump. Closing an already
closed fd leaves errno set to EBADF, which poisons later errno checks
such as the batch file read check in do_batch(). Let do_dump() own the
fd and remove the close from map_dump().

Fixes: 99f9863a0c45f ("bpftool: Match maps by name")
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 tools/bpf/bpftool/map.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 6b9649294ca1..e9f4dd9458cf 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -895,7 +895,6 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 exit_free:
 	free(key);
 	free(value);
-	close(fd);
 	free_map_kv_btf(btf);
 
 	return err;
-- 
2.54.0

