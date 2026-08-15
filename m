Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F2C29898F
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 08:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786781977; cv=none; b=L7j0D2wafJKWlPtCK7k0fXvnuyHJ7fdgOyWyYoDa1kI8ZeYHezPxkxkwc7zmrk7SYov7N3Lu7QoSHXfdJyWNQ5Zi0ZiInC/n7Rn384Grd3QcUNkEE3pXUSUYNF5oBbuNcNyGZg3jQLCJLC6wB//gdDoQywgSYMWOTrnbHFj5hZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786781977; c=relaxed/simple;
	bh=VMT+7O4PRfRA8hkUYOH4H8KA2oOaKuJWcfiM+CybF68=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ngOPbpn/g0H2J6wRnvg0AVh3OPn+vX6mDK3HukJt+dNLkWoDGmCFuktAhcl8HIueGu73Z8WOLKOgs2wdptrHueZYcbdg8RyUiAnRFX2ML46b9xTKSC7lZg/DJN0O7kMInr8PrJbtwJTo2O3Gb8ScBHS+9truZuRYFHBkKVUMJUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=bJ9d8GL1; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="bJ9d8GL1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1786781967;
	bh=pDaTtrBueWZK/iU1B8CemJY/aBytAH9QHxpofZQQz3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bJ9d8GL1tyk4kLyz/ZOprsRELK0TD4NemZDHJd4ze877g/ipS7RPz7fxbGBmq1Cme
	 IkvmJ9/oIt6w0E7WepdIAP1S2Y0qJfD6Dcgl3iUQ58/Mb1qjIOsKnLLRp7Q0QlTD56
	 MbjNspGmQNKNcV1iaOdDPMv/ilzBTIoiRSqfCDnY=
Received: from localhost.localdomain ([180.153.160.8])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 4D51223E; Sat, 15 Aug 2026 16:19:21 +0800
X-QQ-mid: xmsmtpt1786781963tlra11wsr
Message-ID: <tencent_6B540E4B95A9AD4DBF8C928942E95A23AB0A@qq.com>
X-QQ-XMAILINFO: N7qqMxIPUfzlays7gCZKK5zTuJ+VFgLXlTdNaS1mqYMKF29y0hh2PeyTAvc3SY
	 8LCTkVXj7QyvTx6Z4O1OrvmNthw1NgxAh0S1a0UtInFwtWE63mBd0LFl7HwPfmkjzm0GfUkAkq2T
	 Xq9t5NpD4ZBVuDnGhDU1ZqCo9TbTormtjBPkaHWgKdNU+h5PxFZX+eMv9iLaPAjLbaUDvSpn9Rh4
	 Fln1EK6syd8U2T0r2m6riM/5viH7JttVoxOnANv0utRYAEqIBZ4qdzFGN24u1enqiacaOVxHcG+w
	 2GazRYq+htzoK4KTcrTMZCU6ZuvPCBu0hA0roYVbLf88guzurS8GsaOKkw5EWXC0SWI0zOTUBYtv
	 aEK3aEIS2YlyvUbdYuMYHto/bOST+jMa8XOf1fvx4jpJHnH/C46vgnq4tFBq4b8KJXHbnFrg1CTX
	 yMLzTG3XDKPtLTXeSLnyM8J1i25dWus+QfIkyYx2JYokhrRhsBtD5T4zu76WCM4teopKAhbwcdua
	 MAoWgLHX+04eihC7HCfOIyhru3NvSjUd1NdQMmjv1HdTD539FgYzMa2XxIFH3XEdFrl0DsIvKt3V
	 eCCd85IVTH5erIdkz/890unSgzvRus8vGegrml3clondwG7MXwdilZ6l2npZCaE+HBtDm2MlF0B0
	 cbeo7inhR2HcbwYUQtGEexqGp2UlWKBPlLBTdqJyUIxx7IfjwotCUZ+bnO8Dc7xzg8ANEPdMQnbJ
	 vOAIP9NOw1a8o08XY5Gb8/1fMBJGtMeNSVcBn5aoTT7Q7B55djUq9DfmwxQKdozZZjYTPxYnQCmd
	 7JmQc4pnJPGUkRQ8Ry/9UnrI8x93IwjzGdTt0Y8OPbjqN+LEqt52R1YeT/1/m7GNieltl9nYJHDy
	 40SEbwGu0DrcJ8KtcR/KvlXtkPSA2Oq9d57iuObd0lQ/Y63LT+2Ai8yf522onLRF9br2ECDR9xwD
	 4Gk03Wm2P078Ylzc6cXUq3y6SFCbh6q/L4jZlAjYkpWgtLm1UVcCO+Dl8urYh95iYpvP2MBx0ofQ
	 Y8aINkFR0jHW7sx8nkM7Z6fCnvyeo=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Jianlin Shi <shijianlin11@foxmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	memxor@gmail.com,
	pulehui@huawei.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 1/5] bpf: roll back stream capacity when allocation fails
Date: Sat, 15 Aug 2026 16:19:16 +0800
X-OQ-MSGID: <20260815081920.609936-2-shijianlin11@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815081920.609936-1-shijianlin11@foxmail.com>
References: <tencent_C919BB32458A4DAD645A68F441345B971E05@qq.com>
 <20260815081920.609936-1-shijianlin11@foxmail.com>
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

Refactor bpf_stream_release_capacity() to take a length so the consume
and release sides are symmetric, and use it to roll back the charge when
creating the stream element fails.

Fixes: 5ab154f1463a ("bpf: Introduce BPF standard streams")
Signed-off-by: Jianlin Shi <shijianlin11@foxmail.com>
---
 kernel/bpf/stream.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index be9ce98e9469..0b157ec4e38e 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -68,10 +68,8 @@ static int bpf_stream_consume_capacity(struct bpf_stream *stream, int len)
 	return 0;
 }
 
-static void bpf_stream_release_capacity(struct bpf_stream *stream, struct bpf_stream_elem *elem)
+static void bpf_stream_release_capacity(struct bpf_stream *stream, int len)
 {
-	int len = elem->total_len;
-
 	atomic_sub(len, &stream->capacity);
 }
 
@@ -79,7 +77,14 @@ static int bpf_stream_push_str(struct bpf_stream *stream, const char *str, int l
 {
 	int ret = bpf_stream_consume_capacity(stream, len);
 
-	return ret ?: __bpf_stream_push_str(&stream->log, str, len);
+	if (ret)
+		return ret;
+
+	ret = __bpf_stream_push_str(&stream->log, str, len);
+	if (ret)
+		bpf_stream_release_capacity(stream, len);
+
+	return ret;
 }
 
 static struct bpf_stream *bpf_stream_get(enum bpf_stream_id stream_id, struct bpf_prog_aux *aux)
@@ -188,7 +193,7 @@ static int bpf_stream_read(struct bpf_stream *stream, void __user *buf, int len)
 		if (cont)
 			continue;
 		bpf_stream_backlog_pop(stream);
-		bpf_stream_release_capacity(stream, elem);
+		bpf_stream_release_capacity(stream, elem->total_len);
 		bpf_stream_free_elem(elem);
 	}
 
-- 
2.43.0

