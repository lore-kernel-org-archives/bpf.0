Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBC039AD25;
	Mon, 20 Jul 2026 05:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784524444; cv=none; b=IfBEHpdDbkrFznTN2DzRWMGzdAr/PjtJSIwUdNOPoItc8dSBfrA8QucoyePI43oXs4azsCsbiyr/rffhxDhR9e1XMX0nbBt/3G9An4fwVtJIdOPUpH0dc5xN0z8A8keMyARQXTh+plI8jXn3/oD+Z9CfGfEejnlv18PO1G8wudM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784524444; c=relaxed/simple;
	bh=M2vTagZshWYVJzLGMY94jqL1ZAzAVp6NZkmRbz09P1I=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=bGqgG1T7ncpeZ0MaIUsUQHEEUvNwxHZosuyh73RkxDvdBeaUu+z27Buo3puA1ZwFA/YH3Zb6/RAuAQ3ZLSNHUADtnuys5v3pAlM+mjBWelbn5AktmPEhzR86C8K8m6evdwO4H/ZJdy+e/umsOE5Ch5qyIh7qVaZWkAB/CP1qlvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=iwxqpmur; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="iwxqpmur"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1784524432;
	bh=K/Oq076yhWFpYUBv4tcHa4FJr6rjkTqmaL4FJqOLNe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iwxqpmur86ZwyrKDslxBVlGmkanDkw8E3A+0Dm3ae5Aaf0Fs4kby/vPey0yG2gDaI
	 tD5yiDoUp4jganvu08RiXD7iBHVIBWrh1LNIfbk9euAE1re864PS8QOcOwAX1VSjYd
	 U70yjQqVbl0fMsuDiO5MuB5Xw474ebVjVDPgqlfo=
Received: from localhost.localdomain ([180.153.160.8])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 3728BC83; Mon, 20 Jul 2026 13:13:50 +0800
X-QQ-mid: xmsmtpt1784524430tlj2udc1m
Message-ID: <tencent_C919BB32458A4DAD645A68F441345B971E05@qq.com>
X-QQ-XMAILINFO: OTAuIxCfey6wvbD1/5/qotpTo0oGJyjVEshEJyH833jbAPVhJToBdrDt2sz1lz
	 /uKDnkJAeqRKJvLM0RfcEuZdn9S2xfWV1gF8G84H6puZqiBfjtjh7lXuUFdDG5wl9ySWdrgz/5km
	 p9TqAmpJlo9k1ROP3a5TVa4oP9DhjYpjKx5t7+QOSWuWmm6smD1lD+e5awhH3pdD5awUjKWPk077
	 m8Wag6aSoTqq6+XXYMLQAGcs5+5YTMT5U8mHOWkQ3v9TZetalMgOjkp1bBjjkrwKVoV9rmuJgpUq
	 DgApnD1BeP5AHzlB/5OQsxUUkR4K4HYwuDhXO/w6uK+KQaLeUo+k/rIJkDKZAyQZXO8PtfGWh1nI
	 tNIRbK22IQ93z22ggwTG2WttI8N3sZJX6jzZ7YicCjv5X3tGPou6MwcGmcRdb26Id92PfUfS8pjy
	 ZTL1GIK1M/DpvvzO8PL+nD51foRsfl2ONh8JPoHceITLzrOHlqS5MvaSRebJf+ilsPtxpTCsb5U1
	 xqgrnxocD1Q+rjkKhf5VyRvEjrfrDxLD+5V6jDoZBYQAmOt9kIM29fO8xyn0UZ6DiE+KTsueAfKF
	 IBKgo6cdBLyHvHvsz+Q2r1Y43eUKbsmhkssn+OOHmLfrcmcjqSaxF1qXtE7+Yu95j6mOIRoY8Zqm
	 Q6Xp8ufrfJpFCUiwLaL7e7/0USf1xZJhR6MxNnd7fnmJ6F6EeuuO7TZY0sX9d5L0sQUlIJJbeDA/
	 uQIGm6Pt20l6zIYDqIjDHrNjsQ9Ra9fvDT6myZbOfy5BGUTY7KaSSjAWhKI6guk5cKKCwQ//Nwlo
	 AlX51FsbZnj+qYaAGUAn6PyAt3pZUsSon+B/Nsc9SZ4L/l59LhfQURTXSnIkpOwGSLtsTuuozsCz
	 iZ2sMR7upYa5Vovn55GV2OGYnPmIVyhsI5y/NXokcQRhNF9zT2RIdszqCVov/nGKY6EzthhSOA8G
	 y2d9Jw7Bjo6yycF+WBXes6dj+d1hrZmHlAU/Ot+XS8cwWaSBpc33Tsg9oUMFzooTgwqe0p3bgCBB
	 bK2N51c/P5G93xeyKBoydO51PT66/NCcfIn+i1IBOqvEia2URzpoVbVJwOjqL+PUDGEplEk5Occx
	 7m1FFCjoTIOahcCOw=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Jianlin Shi <shijianlin11@foxmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	pulehui@huawei.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2] bpf: roll back stream capacity when allocation fails
Date: Mon, 20 Jul 2026 13:13:50 +0800
X-OQ-MSGID: <20260720051350.556496-1-shijianlin11@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_E69EAE29327E25B3548A9AF3F4FA289A6806@qq.com>
References: <tencent_E69EAE29327E25B3548A9AF3F4FA289A6806@qq.com>
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
v2:
- Retarget to bpf-next as suggested by Pu Lehui.

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

