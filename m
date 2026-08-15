Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C88345EC0
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 08:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786781977; cv=none; b=Dwi/5SBGZ9Qg5lFvjHtMdstHfyABuFEl6LYAcrS1nm/pGlh5BNRwELWjau/Ej4NWX5VmD/eWRbb9UxKd1xkQx6ZSQe5pTmcjsQEnUElqC46kfLll3AUm52QW3FJHMFEzjhjuDRiOSlfZvibLyPjzZwYELWg/iRxU9qNgqJXsSdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786781977; c=relaxed/simple;
	bh=a1GnAG8NnIFdx6FfN86aHAU5R9ovP9mHGkN5YFoOdG0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=QWbyk9GD7mHqTBkGEXngaqsDaxK7NTkLOj1Fzd/v2tbyElXVjs8Z5IuvQ/pnBzC9w+B3AxT/bBIb7Pj4jg4E6qMPRMS5w9YJgaEshKWxtlyAfkzdQpX+Up/RInnv3vANn3rnatuEqCji/ARq5pdSW2BjU9nqfMiWZnLKnl0Ae8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=ndiuIld/; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="ndiuIld/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1786781972;
	bh=5v7A/+8jJBbS8atrNGVsc3xelBryd4ftLyYpZG8ujJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ndiuIld/Cpve6jaLa9j0TPhwXD08sX7kF+yS9ZOExgRx8OPZHa/4/Ws9UxENcL1Td
	 W0zlHZaTpY/t2XmlE/u0lmS0GeAE5nhisFPjlIZEwmpKZpkDBJLEQZ7exWVKzzI92h
	 eTbcSj2BQM/QAO9zLyB+EoSw/oT2wWp6S23l2QUs=
Received: from localhost.localdomain ([180.153.160.8])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 4D51223E; Sat, 15 Aug 2026 16:19:21 +0800
X-QQ-mid: xmsmtpt1786781969tzvulxcpb
Message-ID: <tencent_9B5B6A48CD61BA62744B144B970939A23205@qq.com>
X-QQ-XMAILINFO: MqG4KXyEKpQy5v5qm3ZqCh22VvXJAfUEkKqj58E9U3EL9AAf5XxQ2mNMP5+vz7
	 hzErVUuUv9ekzLhrqTc9snVRV/d0vrPZdBftvAFpLFdFNkQWk640+VLP7skdgrJY8ZIdXY4A5mJC
	 neH2SVYFFDRdKQ0tODt972qEODdgewT9YWh+gKBxao0N1pXGQbTq8v8U0cq//qnswDCIo8JYVyP9
	 cGNSj8SjWjpceqOu1ws0n6IOrXgHGPUGcwGULSynfZqvXuDLkHD+5pfMoE2AFI/vDe8Hv1RU6yWw
	 YbZdG430g2b/r83GOYWlkD68ruFEwE1JCi+ln8EeMuCbM2p4h7+0eNE4bNoVEJWO0+WHCjjwbJ8v
	 8wgEjV4G5cKQtxGxti/ExMMBZhfjZj/VvgnoTlliLHHc4+EWaW6S2cBaUgI0NIy2NHssTIqAvGE1
	 5DNr0gzFYWmwsfet6/7eNSYMXI2fpdLZK780lhp8iEefJSVIfNwn/YbHXL0HkNAgkG2IGakn3XcY
	 jsy+RhBSSVYkaUtfx3zwVd/7hZu4BAFQn4zeoBTr0F134YBUSwUBMnrgSv/tjLoZ3mGO6OaUePky
	 oqjq/65Q2fO8VtFV/C6G+xOXrlu3vRkb9feOj/VQWvVZbzGa1EsiYXY5oh2MHMLkbs0+2fJaQCw/
	 iku91lkvMD4Tna8fKNcdnAuNW7Nz5NvPLKoL93g772pzDZUW4U6K16gf585hPa7CIu6qWgFa9FTo
	 ekitqnH0c8+00/WLX2GrknrOqFd2tO8gSgVHY7A67f3nlunnERd56og+Rd9NBRQmXsNPJfoBxSnC
	 zKI+gQY6CbVLF6dhplNjA2kfoyAseK8i3WoRy/Y3nvmlJvJyFgDIdAwlIeBWKHkPBiG71ie8KFCq
	 /+Yyay6DuQF+r72bxrl/4scRtFCZGqa/Yd1Yey7cMLlI1f7jF7HvqZ1ybuTcL57D1WM/VhKsZcIw
	 U4SkQWKQKRqczrF98AoM2unJF5spYsBh0vi9wcqCZtLFspxZiKMASOkmhS8vqygkRQViXjtF+aYY
	 o5sMAXanrnQs/8SpCQVKgwUgvTGQ1v64DwrULmhalpfPoRfjbiafgWKdOK8DIgTbDMAY7lF183tq
	 1zUIAhdmDmx1hPr3s=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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
Subject: [PATCH bpf-next v3 4/5] bpf: reject oversized bpf_stream_vprintk output with -E2BIG
Date: Sat, 15 Aug 2026 16:19:19 +0800
X-OQ-MSGID: <20260815081920.609936-5-shijianlin11@foxmail.com>
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

bstr_printf() returns the would-be length excluding the trailing NUL.
When that value is >= MAX_BPRINTF_BUF the message was truncated, but
bpf_stream_push_str() still tried to allocate with the inflated length
and failed with -ENOMEM. The boundary case of exactly MAX_BPRINTF_BUF
could also copy the trailing NUL into the stream element.

Reject such lengths with -E2BIG before charging stream capacity, and
tighten bpf_stream_elem_alloc() to accept only payloads strictly shorter
than the bprintf buffer.

Fixes: 5ab154f1463a ("bpf: Introduce BPF standard streams")
Signed-off-by: Jianlin Shi <shijianlin11@foxmail.com>
---
 kernel/bpf/stream.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index c1077160074c..bd1e98fde4b0 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -22,11 +22,11 @@ static struct bpf_stream_elem *bpf_stream_elem_alloc(int len)
 	size_t alloc_size;
 
 	/*
-	 * Length denotes the amount of data to be written as part of stream element,
-	 * thus includes '\0' byte. We're capped by how much bpf_bprintf_buffers can
-	 * accomodate, therefore deny allocations that won't fit into them.
+	 * Length is the payload pushed into the stream, excluding the
+	 * trailing NUL of the bprintf buffer. Reject anything that cannot
+	 * fit without copying that NUL into the stream element.
 	 */
-	if (len < 0 || len > max_len)
+	if (len < 0 || len >= max_len)
 		return NULL;
 
 	alloc_size = offsetof(struct bpf_stream_elem, str[len]);
@@ -245,6 +245,11 @@ __bpf_kfunc int bpf_stream_vprintk(int stream_id, const char *fmt__str, const vo
 		return ret;
 
 	ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt__str, data.bin_args);
+	/* Truncation: reject before capacity charge (not -ENOMEM). */
+	if (ret >= MAX_BPRINTF_BUF) {
+		bpf_bprintf_cleanup(&data);
+		return -E2BIG;
+	}
 	/* Exclude NULL byte during push. */
 	ret = bpf_stream_push_str(stream, data.buf, ret);
 	bpf_bprintf_cleanup(&data);
-- 
2.43.0

