Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F8018DB35;
	Mon, 20 Jul 2026 01:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784510638; cv=none; b=uhqHCCYEH/ulhXvF+oh2iljOAZeVqEiUXXgE/iYxaxENGaGbwpgO8WLFlanqO2u3wQ+zmdpReL7uynUkNTl4dcjfKF6ABbwSwemN1AFX/GomZ52elEoUm+YVOXU/9CuBbAUdfTcTxGVpj4m6Cg6XyoyFs4UVheMsHeQxkcti7wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784510638; c=relaxed/simple;
	bh=NiThv7kfbf2buZrwL6CwwZAuVk6xjxe0JzIBnRVWS/Y=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=qbSxBgMFmX1Z3FD5PlERgfkfk3gbje+IEtU9EVsotMCqgsLp+2fNPs5+0OODyCEC3xEuBSqsEO0zqUCfRkU6m/ed5WhT3IJ1wxO22TEfWus9sXdMojmGL7nXqmVW8Kk/oajQdgkWwnrPXljvT9Bx42rrdKAS1nLi2ypqYbJZEj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=kneIeAkQ; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="kneIeAkQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1784510626;
	bh=CMtZxEctUqjKSwrychWGxCD0l7XNqY5D+f7R9oUwO0E=;
	h=From:To:Cc:Subject:Date;
	b=kneIeAkQAdewKOsWVhD3zhEX0utufwwRTbruZTQkUgPasfo5pHPNTdhRYA8I4fpCl
	 DCS7bVnOwb6yHiuPNndg5qxeFvu39Ry+2piPj+xtaeklLH1xT8NkgFDC1JjZATZaph
	 Ssnqtwa34EhtfFjROafNQG8dUOag+79sDXc5kfo0=
Received: from localhost.localdomain ([180.153.160.8])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 5EC90E82; Mon, 20 Jul 2026 09:23:44 +0800
X-QQ-mid: xmsmtpt1784510624tzeryq01c
Message-ID: <tencent_E69EAE29327E25B3548A9AF3F4FA289A6806@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnL6yIddd00Ov+YT/m9m1l7Hz9KG39ZoHzy9BseuulY3eVIBsV2sM
	 9U69yMvqCmagsm37f/1FE+0OFSgGnOsavsKCuMCDaW/gT6hvMlQTBaddeN5hzihCVM1Fg8r9DMQS
	 4GYW8lBBWcUTs8rf9t/rPwTU0ZcBDEYpC6j87KCSuJxtbYK84YOqWnHCBSXXwFYX+Dt0QyxUybhS
	 gR+HVT36ghmyobFaI3kEgQWFHikU+oLRyKZ/A6vJIqaAAwPG0vzE4lBsLwJs6HCNcy6gojFZFDIo
	 HIo9nC0Jq4mSxAt60unaeGpnwq5AhVTGescojYyhd8dmxbDt+Pnl/Pnw4k2rBiuxtHGLr1RWqhym
	 wkyBWli9EKj/cZ9Jor/W42krf0gCLtOn6h48LwoW+1ElI7Jn4Kf82JktoR+sQlRT53cUF0VTrb5L
	 AFIsdKc3Fn6O+vzj0ozPs5t/rkrnwiqWdE0sU8jsu8hu16dsK0okURCH5qo56MMxu/aVegWHhJDp
	 yNiFBwtS8f5wYIAPKhFDmk3WxYj1njugADCH+BYHR7bg/etb6PyP8TI3b84UQGYJY9atJPq8vYcb
	 wetY1ZU6Ybs8gIGt97pexeiGiE5XiOcuy/DJzHzXNRapamgYUuDx1Sd7sO1Nsyrm8OUGWewtLhgS
	 UvhoQNRqfTt4aAd307t5Pnx3yRlUAl/tzotRFd1xzX+IgGol38RKk4M1QyZko6rWaSakx/I13LEJ
	 7DDYqF5kCicEyNXduz/AGW84Ok6QwL5alAwtQT6dRqNeywGYwT5jxmQMW54oN5fIMb6DGFY6Bn8b
	 V+1okWF0UgVXfNEHL/cCKPedBNqFVWaJ/SXHF12hmijIL7Nh7L/s2ci+MoFd2QS3peG6Tes2i8nB
	 Vn6sQ5PSgLutc6MKZ4bwUf8XMMS3gpldUT+LGLxqu/VquzmNFY5E4Ue96yHNSopjnQPTjctcybak
	 o56lGCJowspVBKQZ5nzWOu6HaXgcgJW5GXYWAGIl+7ecQ4+yTUXDie198SOYt0DfKe4dpsj7nH8j
	 YOurw1654bLH9rRHmkPazDz7yswQT/TQjs3DQBnnEIvcy60HfP3X7A+LPgEvwgbXRna2D9pNzHws
	 3KSQhVfGKdc+cD2Zg=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Jianlin Shi <shijianlin11@foxmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf: roll back stream capacity when allocation fails
Date: Mon, 20 Jul 2026 09:23:44 +0800
X-OQ-MSGID: <20260720012344.4165224-1-shijianlin11@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_stream_push_str() accounts the string length before allocating a
stream element. If the allocation fails, the length remains charged even
though no element is queued and therefore cannot be released by a reader.
Repeated failures can exhaust the stream capacity permanently until the
BPF program is freed.

Roll back the capacity charge when creating the stream element fails.

Fixes: 5ab154f1463a ("bpf: Introduce BPF standard streams")
Signed-off-by: Jianlin Shi <shijianlin11@foxmail.com>
---
 kernel/bpf/stream.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index be9ce98e9..4b8a74b91 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -79,7 +79,14 @@ static int bpf_stream_push_str(struct bpf_stream *stream, const char *str, int l
 {
 	int ret = bpf_stream_consume_capacity(stream, len);
 
-	return ret ?: __bpf_stream_push_str(&stream->log, str, len);
+	if (ret)
+		return ret;
+
+	ret = __bpf_stream_push_str(&stream->log, str, len);
+	if (ret)
+		atomic_sub(len, &stream->capacity);
+
+	return ret;
 }
 
 static struct bpf_stream *bpf_stream_get(enum bpf_stream_id stream_id, struct bpf_prog_aux *aux)
-- 
2.43.0

