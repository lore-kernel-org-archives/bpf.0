Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BC42E2EEE
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 14:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787494687; cv=none; b=Dc8PZ1YNC3t0VBUbv4Z6cAkxM3NuecsqOVcbRcaHyOFn7zdeQgEA1AQ2uKU9kjdlvRxELrOCJnj9kk4/QED7+Wj/bEToOjeCgCsOR4ZTQgfWNdE3h3dIIFMaiqieK4ePUlccmne7JOHnu2H3r/yldPdYyfhDY5xQHJeQif2vJSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787494687; c=relaxed/simple;
	bh=5oRKg6K0iG5r/v/hXBuDVgSmeObrV9gsWMCfckR8DaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+WRUSwvh1X06ipwO1NPHNO0I2kI4U3XuEq6xv5R3Dn+MToiMUYEmYRXiL0C6O7sPYmDlBuND9e89Grx08KcJUq4nsukW64i1FgEiI5AAxqvvoWDkoGjJuF3cJ/1VXfH/GAZsiJ6bjgz6KSyMAb6TCS16PR6gQXKmfbw3uRpguc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f0.google.com with SMTP id d9443c01a7336-2cc7a345f51so17652055ad.0
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 07:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787494686; x=1788099486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BLPNl7tv4b8gXirdXjyz87bURnmNqmX7AlYBb8DFG4I=;
        b=dM+CHSDnXNerA0ZP3r/ssVoa5f6btWqFJv9ZvlCJBu1TQlo4L57hvW2YPmcwSjiC37
         LeGJuj6ehk2BgaAcLlwKbLWVqgkqdls4IGqz1qdx9huJVaUQEjCGYmHu3BOfCkcj3myZ
         R6mWFEWA7OncvzQ3kEGJmiRSpWAzAhVz6DjBp/MzsGu5KWgou9szUAr6fkw6Yvll4loW
         vUmuZdAm4LWFjXafQNsoZtdylpsKeuUDHFPmm2fGUxSLunq2954yOOQWTdwHA1NyOeV8
         +KAMFRcVYq5BV7d5j/j8XCf544n+zlWLk2uxe7KiYaqIy65O55O2x8EJChOnSvapJWqW
         /WUw==
X-Gm-Message-State: AFuF++mN82o/z3phKQMKWnwpVAHXD/CSa4R/mvjfvjlD6fZevoM+VRex
	TFlzlh2nE2djadNJmNcO+fDbgC75NuwTw1niAqB5qmMWBynnU+e0I+d3DxPz+sblSMJR+Pq/
X-Gm-Gg: AR+sD10WqIpU7UGAipJgJofxQUVCEpNyRv+JZyJ2Yv7IpycRYl7g/RQ6Qtqsp3m2ETm
	FkrohJZJ9Rn64T6Bis7cE55DN1F0HLxsAphJ/qw/LAwb0ZykWcS4pIm00/Qcv7mcULTml/XZNl0
	7W6HsoK/LhrwRTQaDsaV4+Gh44IQHKztNgY5DK72nWEDS1jWuzIoztuXZHvqahukb2J2KBslIho
	HEl1HgzYN427tcLL1xmbmeUyuWqMVN9DxTnC028WfHxZueFmatXLGb47uZB7xzSoCFogZ+dS1QN
	L37Hs7HtBQiVJVU67758PEESQWeo3KOrylHX8I1Onmg6hdUlXFOEMxvAvuLL1WyXJ0rCdSw9HEe
	2EOl9Nvk8D7744Vc16JQRNZzk902i8dks105JH4oJQ1OTQ1bTlbZnm2CEb5TU/wVe/VGUjWwkLC
	N8nEsl4qPHKNDEfXNhdThPQ68nf+K1S/Pv9gmY2OtufBLFTNAh4HdvALGd0XVrKEnicEwg4JIQZ
	jtEzFg=
X-Received: by 2002:a17:902:cec7:b0:2d6:702e:b1ba with SMTP id d9443c01a7336-2d670b7f140mr195137145ad.3.1787494685686;
        Sun, 23 Aug 2026 07:18:05 -0700 (PDT)
Received: from localhost.localdomain ([180.153.160.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d676791d44sm9944575ad.24.2026.08.23.07.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 07:18:05 -0700 (PDT)
From: Jianlin Shi <shijianlin11@foxmail.com>
To: bpf@vger.kernel.org,
	memxor@gmail.com
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@chromium.org,
	sdf@falco.dk,
	haoluo@google.com,
	jolsa@kernel.org,
	emil@tsalapatis.com,
	pulehui@huawei.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 4/5] bpf: reject oversized bpf_stream_vprintk output with -E2BIG
Date: Sun, 23 Aug 2026 22:17:27 +0800
Message-ID: <74387ae5024d7e2996095e97211430285095b525.1787492521.git.shijianlin11@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787492521.git.shijianlin11@foxmail.com>
References: <cover.1787492521.git.shijianlin11@foxmail.com>
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
index 09471a605268..7a5c3ac8676b 100644
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

