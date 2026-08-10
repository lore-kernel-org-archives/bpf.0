Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471443F9268
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 14:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371804; cv=none; b=QJuOsQe5y5EbToE86zZ48TPzauZg+gTxtLDBfb48RbfYeWfPf+8QYmlLxby8uOd01X69K7JfI7hJEiQG2HfO1dP+MzjOHzoaHXSZ5BkLvcTh08xmuEJICRfcn2OLjfOWrsxx09fuGv9rvKSzYAbM0sIgu8fYSCAYg3p3DPWtzJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371804; c=relaxed/simple;
	bh=CrEu/JBw7B0lQUopOJWSGyL3Hi6yJjEsYY8ywYBad1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pccetXzI0ZGuahu/a7jVZZFxMXzqyji4i5kztFhqxO3872biyubU4zs1oEkPXMtitiiC2gZjDg8zhRGLo3r0qEz/+DBYa+ePNN4jKe8B/SJSrT5dS3OLCJlAcOU2o4JoyruE9JZSp3NX38sToYCkY3ssc3dY8xU7Nad+wOGfPkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=B5OBmVVn; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="B5OBmVVn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Bs
	iBYj7zzRJvUVye6x9nyB4ZrraZR9Gjr0hfUPot4aU=; b=B5OBmVVnSyqgg1NTLc
	nYc33XeLtG63X/hPwBTRf1XNgf9Q85OzEPxmnJgHx+jN/xHf0iZ3ufhPNZbV/GV1
	yzTVh60Td4uLt9gOOxeu3bj4oPAgmQaV1O9x684ahBiEOdeJb7uwwLURadLMluKY
	VAdFQz2sPfeGHy73vBSuW0Qm8=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3n9ip3nlq3APzNA--.8292S3;
	Mon, 10 Aug 2026 22:22:40 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next v5 1/3] bpftool: fix double close in map dump
Date: Mon, 10 Aug 2026 22:22:22 +0800
Message-ID: <20260810142224.2907373-2-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810142224.2907373-1-chenyuan_fl@163.com>
References: <20260810142224.2907373-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n9ip3nlq3APzNA--.8292S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ArWrtryrGw18WFyrXFW7XFb_yoW8CrWrp3
	98K34YkrZrXrWDuFZ7G398GFWrCw12g3y3Jrs8G3y5Zw1kJrnIqrWxK3Wxu343Xr1SyayI
	vr4I9FyrZF47uFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jf8n5UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAhDcmmp53rAHEQAA3-

From: Yuan Chen <chenyuan@kylinos.cn>

map_dump() closes the map fd in its error path, and do_dump() then
closes the same fd again after a successful dump. Closing an already
closed fd leaves errno set to EBADF, which poisons later errno checks
such as the batch file read check in do_batch(). Let do_dump() own the
fd and remove the close from map_dump().

The same double-close pattern exists in do_show_subset(): both
show_map_close_json() and show_map_close_plain() already close the fd,
so drop the extra close() there as well.

Also propagate the error when bpf_map_get_info_by_fd() fails on a
subsequent map in do_dump(): set err = -1 before breaking out of the
loop, so a later failure is not silently hidden after an earlier
iteration succeeded.

Fixes: 99f9863a0c45f ("bpftool: Match maps by name")
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 tools/bpf/bpftool/map.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 6b9649294ca1..684a8fb72414 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -659,8 +659,6 @@ static int do_show_subset(int argc, char **argv)
 			show_map_close_json(fds[i], &info);
 		else
 			show_map_close_plain(fds[i], &info);
-
-		close(fds[i]);
 	}
 	if (json_output && nb_fds > 1)
 		jsonw_end_array(json_wtr);	/* root array */
@@ -895,7 +893,6 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 exit_free:
 	free(key);
 	free(value);
-	close(fd);
 	free_map_kv_btf(btf);
 
 	return err;
@@ -944,6 +941,7 @@ static int do_dump(int argc, char **argv)
 	for (i = 0; i < nb_fds; i++) {
 		if (bpf_map_get_info_by_fd(fds[i], &info, &len)) {
 			p_err("can't get map info: %s", strerror(errno));
+			err = -1;
 			break;
 		}
 		err = map_dump(fds[i], &info, wtr, nb_fds > 1);
-- 
2.54.0

