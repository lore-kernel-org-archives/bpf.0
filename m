Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4773448BA3
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 08:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695293; cv=none; b=TWv8x2egqKqFeQ4aR0TeokhWT5ke1VclPWWXCEsHuKy6VLkRVZCsScZoI0CMyDJCYA2WmK5RbKz2NZsQ3L8L4NhfKwrMEdTtW3UctupG/l8lcSUpqWBuc8UB3Xnc0bHafcF02Xh6QsrLz22JYZOVghyDCqOJ2OM9DArihmh0x7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695293; c=relaxed/simple;
	bh=uKotYtBwPfT4bBG8cqhBTPIJ0IAxdZDHhrxBiqdLA38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BHj0tQkfHmfGAJl+1dtlHZ/FAdLMYUmgfZOzkU0G9D5fI33m+p23NcJ9MerVbDUj9nDfrHSu0DteWnMBzI0eEHVX1saCXMfTWGKofod4ZkdzBhEsBjYPkNa4debY3ADIvtTodDsG5maImK2aawSaK7i2iMBCijuJ5pY/HnUSXWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IR7lyFLt; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IR7lyFLt"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a18840e2abso1086805a12.0
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 01:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1786695284; x=1787300084; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ITEm8CRypMtPNDaWKJLB67u4FZ2Yil9GXw3Eg3gJSss=;
        b=IR7lyFLtgourOUJA1+WSN7PpPkadHzliGfnKc6B6Q0F5mMMZtmU8Kd4FDrUZv0ZeyE
         jplGY75Id4dw/+gwrMGLtySTRs4YaPlFZNtSZsBMSxlzJihKVn5aVUP1kgFwA6UHJVUH
         b0qMFodMk+0gadMEiBJzZzcf0xe/lRitX656JXCtPU95n4pSWFOmFFArawlKtWtYEVES
         HBHNBwNxogLPpQ2beh9wzwd9XZhVY2GuulNg6k6MGgHyjgt65uppdInmIs9+LrKpXfWM
         jQpYNeWtYAIN8uDyoHzwAql5678qfBlV1rGvTv55UcaliU03YcUVEU9NS1KylXCFgeAv
         3C5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786695284; x=1787300084;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ITEm8CRypMtPNDaWKJLB67u4FZ2Yil9GXw3Eg3gJSss=;
        b=SGGzsFrcjd1WwHxkIVAn0q7+pQSmlyj/gD/YaE4riy6SLuolMo5FNGh5pTUCq7+GAW
         nNtP1+Jdl7pmLgpozqMSuflhvvJm+vqxVeC6y73zqR/O/iqg+f0WssTi4mfHtjfUtytQ
         eYVqWW+Nz6hJrwhPc5orgMj/lCX3I4ENOWKlbj3jSRMcRDnhFBcj1hK5zOY2nJ7XexRR
         d7b1gpM3du6sYJWmwPeApxQFCzqYWtI68/Ff9up0BadGOSW6JOLDRObqq3hlxn13yXY8
         VNCzpHjXBqWGyZbzCWEcKy4LuClNwcdwdP4/ki3tby8oR4dYUBWeV/HMn4HD0emniwsV
         qhSQ==
X-Gm-Message-State: AOJu0YxPqAVLnHYfUEZCyDwM0S5uyo9NMfm9iL29DMikYvmoGcIaieMJ
	N6C3Sfbv2ept8yBJF7jBnMzx8ybiNMwiegxnxzC5yU6gFBht0up9p8B5BcSW6ISOMjF/DKRJg+e
	Lp9qc/fY=
X-Gm-Gg: AR+sD12lyZ0jn8S1DKjqyJpO4TT3/76SCOjju+R8oSbVWnCUaYGIyFACTGfQRe2qF+v
	BsSyt226kgXyWJgQEwR6RP7XumCnchL1cdiTgaNfj/gv9epO0wHH9DNqS2QFThxpwfskaJ6JhDL
	h82h5oS+KybOCcB1nOpG9dPxWetCqvcza0G+Ph0QerqGROrNnwyiy70E8dNJo2lVAEW6DEWJqWg
	ednNvPcO8uKneDB4aU+Co8MTbZwuVK1EWltPoyEeFYxbhuMa7PGRB2JOB0T5v8s955dVUnl3Jck
	lUy5ub9QjCbY/byr/+LniW5mKim9nP0dAzp6ryNYhzxT/X6+d6GetevgDiBqDOvfpQGWPr7cT9Y
	CjK84b89YAFW6P1QP8auTNPplQ4fkmTWXaWr/Evusbnl3NFUaGy0dvSFmnyx2G+3gPHUsEwBtlX
	mu3m5pcJJIIUSGcElMgX3Xl2uBKUewB2Z649SjVzV1f9iGSJ32/X++chjMe6RC2zgwqGzlnkAVi
	ADKhxgFE+G0243lxKrPBOt+GugwiDTa/7+TsLBnKR3kUG++
X-Received: by 2002:a05:6402:458b:b0:6a1:f971:a20e with SMTP id 4fb4d7f45d1cf-6a38aabb7b7mr1892745a12.19.1786695284294;
        Fri, 14 Aug 2026 01:14:44 -0700 (PDT)
Received: from cloudflare.com (79.184.184.176.ipv4.supernova.orange.pl. [79.184.184.176])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a38d767e3csm425649a12.17.2026.08.14.01.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 01:14:43 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 14 Aug 2026 10:14:15 +0200
Subject: [PATCH net-next 14/14] selftests/bpf: Use non-trivial test payload
 in xdp_context tests
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-bpf-meta-inside-skb-ext-v1-14-767edd862656@cloudflare.com>
References: <20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com>
In-Reply-To: <20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com>
To: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
X-Mailer: b4 0.16.0

Replace the sequential test payload pattern (0x01..0x38) with
higher-entropy values that don't alias common protocol header fields
such as IP version/IHL or ethertype LSBs. This reduces the chance of
false positives from stray packets.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c | 8 ++++----
 tools/testing/selftests/bpf/progs/test_xdp_meta.c             | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index f5fbc19757e3..8bf586b5af32 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -21,10 +21,10 @@
 
 #define TEST_PAYLOAD_LEN 32
 static const __u8 test_payload[TEST_PAYLOAD_LEN] = {
-	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
-	0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
-	0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28,
-	0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
+	0x49, 0x20, 0x63, 0x72, 0x6f, 0x73, 0x73, 0x65,
+	0x64, 0x20, 0x68, 0x6f, 0x6f, 0x6b, 0x73, 0x20,
+	0x26, 0x20, 0x6c, 0x69, 0x76, 0x65, 0x64, 0x20,
+	0x74, 0x6f, 0x20, 0x74, 0x65, 0x6c, 0x6c, 0x21,
 };
 
 void test_xdp_context_error(int prog_fd, struct bpf_test_run_opts opts,
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 4c224d5fe1b2..b0ab7f4f7a1b 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -24,10 +24,10 @@
 bool test_pass;
 
 static const __u8 meta_want[META_SIZE] = {
-	0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
-	0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
-	0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28,
-	0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38,
+	0x49, 0x20, 0x63, 0x72, 0x6f, 0x73, 0x73, 0x65,
+	0x64, 0x20, 0x68, 0x6f, 0x6f, 0x6b, 0x73, 0x20,
+	0x26, 0x20, 0x6c, 0x69, 0x76, 0x65, 0x64, 0x20,
+	0x74, 0x6f, 0x20, 0x74, 0x65, 0x6c, 0x6c, 0x21,
 };
 
 static bool check_metadata(const char *file, int line, __u8 *meta_have)

-- 
2.43.0

