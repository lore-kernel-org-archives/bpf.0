Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248464;
	b=PmOaQ5pMZ3vGhT4o0crMUR9Sh3i6CQuoXlbqjWXUSl80jnSbI/5l2m1QVo6BsvzHSFqp
	 3cTg0+8JknQPMRDmIBahUf8TriGSbhXxkHb0Hb8D3PFz7CdzKMnTFFmlSVZMHPdnZlFeD
	 O5JRkNrCg0fD55rBPDEfmKMgcLpgTQhsKtiiPed1sPY0/dTNMVb0wahqTDbYGOw9Uralu
	 yslw0bIEBjj6Oy26qOE6n4hShrwNKrkWUZErG8vXMi5elzenA/m9gXiQldRFqtNE9en2d
	 pbuvUqyReucIvwvLxGwDjFZ0Y+m+nmaffeYmtypAVIALEkuTEm8fSF9C7mIaujyPg6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248464;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aW1PwdLq8YhnKXFZp/jbdW/UQrQ9Ivloyzj/ci4zMGs=;
	b=LEF5+7SSK70mJgIOxQ1xC5FTmRDCVLrgupaZMuAP0JsTOkpvW/LXlzA77ZG7MGHS/M+6
	 0nJGkb2/8GpPwA1HGbL7vsSVoBLYsEgXCeSUX4YV7mqcb/D0bLOeZ89NFT1c/q4Lujl+5
	 r37wjzCKeuADpaJCY2gqqxYDY90ljoCSZM7RH9d8UWNoUTQnpSPp+hTA5petAAXVwGYRU
	 ic57x+fnPXQfTW00J0XkzLQhEQd3A7Pyl5gts78XLgUC64g6zm0153fd91Q2Z6T6XKpRF
	 VZKn9Z9zsTty/aX5oHaHXsvnU3/5tjbWL0gtD4Wvw0D2f8lbH0S+5epVfyrJXEtwYww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b="lo1jT+4/";
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EA060A261E
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 18:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85EA060A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=lo1jT+4/
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b155f50c24so680879a91.3
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 10:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1794248464; x=1794853264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aW1PwdLq8YhnKXFZp/jbdW/UQrQ9Ivloyzj/ci4zMGs=;
        b=lo1jT+4/V/FDTgrwc2NZW8mTvUwX9CSTqy3/f8jxAsbYv3O/LgtCuMSOGO6kQOoUzN
         2eW6LBaHOubd7FeyEubSDcXut0dPFrzzj/SCuZIIrCtJiSvuhVTwt7VJtelpFSIHxZq3
         uOteeb1CeTqjSq+ZGoK4hHIUNU4mkXmTJ6SrWt5m1TIV8AS7zxelMQcE0pZhQKLkdrTz
         mOhRbPFrbn6GINkh3nU8lIwwgKqgvVaivs9UvYyspApyPUq1phPMxys5SODH+7Q35RBB
         NuxBbTb16vWZOPzkFzfRIMDNklvK62xaxxFfVtJ5eRmFyTuRVOP/m1nwyfdX160DGEYR
         W2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248464; x=1794853264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aW1PwdLq8YhnKXFZp/jbdW/UQrQ9Ivloyzj/ci4zMGs=;
        b=LCIzblAJpCLTQaF6LZYxLAuABVc3rT4Lqo+CfAwaYK1v36koeC4mLjnEbTtXwKbfR1
         AFmSnSfFEcBLVRabB5T1v9GmdkPuG/HSu/ykLTy7b/kGtK9nVnfgFw/GnXvlM9Q8HX+K
         SZF7RbScSmJcFGSYqtpjq17oYvSJPkc9HOmSg3BnqfwMf4TCPVkvzYZNBRUOoc1PRCvN
         hNkMv8sjOHveaPl5zGkclONx4DmSO/gpCymltmIy5goLdMSRA78AzSaEsJuBuTlsQaZo
         5dUYqKv7AYu4ywr4uI5UCFMwes1YWZiL7pyvxicr2xCSKEuR20A2Er3juLt4wGDM5cIO
         NNTw==
X-Gm-Message-State: APuU4Z/YaEHNslLUx16Gpu9BBpW13pXiQkIVOkkVOVZEBdCjgwFi1CMU
	+I751m8PEAqVU0HTbuEwl3i+EDW71ppQUCLJJxd9PBeP2hP4bFiLNrnQbDGiv+9AqICiUWPOLK+
	fQbTJQOE=
X-Gm-Gg: AYBFou0gxeyyjzLBd+osvd9EJ1W3hU4Ul/E0sCpu8i/KI2xDhhGNCUL8DCeyyhWOHVK
	Coo3DxCiEQe0CWOJH6neRaf5p5djBxK0a2m523HSPwi38AKVml5/UDWJRJqvxpvbEiLqicMAKji
	DadWm515DATeybnGFp+Rzt/fymsKm89QyOyeFP76lfthyIz1GGRSNjsOWvH3/sO6puRJFzSDH+A
	5XqR3WNJHX53BCTUNlfBY1ZcgG3pR7l/3ySZuZQJsG2tYz8uRCUpjYvVHqNmFZs13JyRslwfNmW
	YdZOtzieVQYzL8ro81CQ+Pb4Kh+ezkU38/i1pxlBJ7H+aoIK5AJv9+zQfMjSShoSSf+2+n1Roxz
	oFfdgcGhUeN1eiEGIVekjqLmPqahkgXZCTJW2pN2GZx7MW1n4g7iSETH4xzOJCAAl3YQqiGAb+T
	c8V+0Hhu6RKnnJi9iHy6plSoUv2wiupVQA9Dr3KrhnROk0OwCRK77MC0V1bu3UgMsZlxF1mMtO4
	B4tEHuswnjqhJhHzdidczMbEqgc8TXz+OlIIS4KFD2jMcPb0/oG+WDvoDk4urYV/8//FSs6iY7D
	skVfWi602l2ILoe8bsSXnwLIKMAyDzZpwiQhjR8vTAzuR3APCn2ONVHgFVqdbWInv8xFTftsdT+
	HgtHFn+ccm1KOmiKNex8y8MhKfHkDbwKeuxUDQpinAavtr9yx
X-Received: by 2002:a17:90b:3848:b0:3ab:4f1:4f7e with SMTP id 98e67ed59e1d1-3b166ca06e1mr496307a91.28.1794248463728;
        Mon, 09 Nov 2026 10:21:03 -0800 (PST)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1676e2974sm474860a91.9.2026.11.09.10.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 10:21:03 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v4 4/9] selftests/bpf: libarena: Raise arena spinlock CPU limits
Date: Mon,  9 Nov 2026 18:20:49 +0000
Message-ID: <20261109182055.7581-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109182055.7581-1-emil@etsalapatis.com>
References: <20261109182055.7581-1-emil@etsalapatis.com>
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

Bump the maximum number of CPUs supported by the arena spinlocks
to 8K, up from 1K.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../selftests/bpf/libarena/include/bpf_arena_spin_lock.h    | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h b/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
index 560ee18fd287..230bd112e8d5 100644
--- a/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
+++ b/tools/testing/selftests/bpf/libarena/include/bpf_arena_spin_lock.h
@@ -77,7 +77,7 @@ struct arena_qnode {
  * 16-17: tail index
  * 18-31: tail cpu (+1)
  */
-#define _Q_MAX_CPUS		1024
+#define _Q_MAX_CPUS		8192
 
 #define	_Q_SET_MASK(type)	(((1U << _Q_ ## type ## _BITS) - 1)\
 				      << _Q_ ## type ## _OFFSET)
@@ -109,7 +109,7 @@ static inline u32 encode_tail(int cpu, int idx)
 {
 	u32 tail;
 
-	tail  = (cpu + 1) << _Q_TAIL_CPU_OFFSET;
+	tail  = (u32)(cpu + 1) << _Q_TAIL_CPU_OFFSET;
 	tail |= idx << _Q_TAIL_IDX_OFFSET; /* assume < 4 */
 
 	return tail;
@@ -509,7 +509,7 @@ static __always_inline int arena_spin_lock(arena_spinlock_t __arena *lock)
 {
 	int val = 0;
 
-	if (CONFIG_NR_CPUS > 1024)
+	if (CONFIG_NR_CPUS > _Q_MAX_CPUS)
 		return -EOPNOTSUPP;
 
 	bpf_preempt_disable();
-- 
2.52.0

