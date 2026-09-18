Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD33630CD9E
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 04:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789704716; cv=none; b=J8GjpxSejZw+Nu+sJyft8J8/DJ3zHCOlLmHpVFlSt/pBGfJ1gqFDpadNVogp8pLJBVLH9/fYcXyoKKEo6z398YDw2YC3EnHOnaaFwFh38BhCYWl5oWRvk6ublMRV0LQt7GxcJaRyOgP9c1fqkHtCVvwuJMqu0tVe3gzDP8KldxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789704716; c=relaxed/simple;
	bh=UEUGvWnLmOamu0pTBgkEFgMYD4FBYYk7egJy0kl7eaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H6LE80F3uKXwSV1BGxxwkfRsborWfhXMwmeIUCcMt7rfbWnmnNI7PliHa8Ei1NQOTSdGqZqfThaPhNRAlW0wrsioczLlhTab3/blfIzVBq1m3UAzG+zBJhpmYsVk3j8my6JObeYLxAVLZjcYngV6TYL8jhKv1GCXig5/Sv8KMf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p9d7womG; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9d7womG"
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-39b2ad83680so147311a91.1
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 21:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789704714; x=1790309514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k+XdyMw/cwUfbmJ3KUmFebC21zCmtXiVZ3PCKhns0RU=;
        b=p9d7womGPrpa1YbmZrfRaoHEQ6zQ1kyqmOHdc+LI5RhjAhSEigs07bTNzH6uWb/6zw
         X9Km5hCUc/pwGKj8qIPVOOmCokneXk3MA5AUyoNZwjJyZt3jKq2+egoiFUDx5hKsmcin
         TH9j119cg/3XF0yJmCvh5c8YJxr7mPleI5IVPfurPZl0+ehRdkIAOVN2mLxRu+2XEyq1
         gfZdalEZ76st897KWqTbUJM7riQtynzgjitppSK15VzlEEX06A734ZDm0tF/+Q0Si1rd
         baxCkpU/ix9KlxKiYel6HrBdE7MELDkzjDMWDIeM8c8aaFmPWQjgsLf78Za/xcEf1/Ox
         qP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789704714; x=1790309514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k+XdyMw/cwUfbmJ3KUmFebC21zCmtXiVZ3PCKhns0RU=;
        b=Cjx9sBD2l98/XQEo1MKExN3xneyj965C4w7Q2S6SMdGG9VuC/dqFO+MrUU+/hVECJh
         avDrAD7R89Bw3+b4dSPAfBFiazP1/hbrpnYFtAyO9SguBmyC44KK7TjNRiOr16sXRaSd
         UOS2V0ERoCsoodLYSakUcc2TVN1nOmv3x5yvdNkGY+xJ3liZ5Akde8qDkiXhAVDgvErT
         coCKCKtOUdjiWDXsGNS1sJV1TSsHn4sAaSg1+GH+rCAyG/tRc2Lz6sUGYKsOJtejlt6H
         PvRsZA4Y+QEfAJsRv8nCOg5sPjdzMfFpvjmKCCAC/05n/UIeFRugxNaUn5HYSAGGhnXq
         q6aQ==
X-Forwarded-Encrypted: i=1; AKwUvBzqjJj6mkt9phu0az85YSi3bPCAhpDdYP9v6iYTCI8B5bUbrVjuVDJZyBrIVL7ZKyNaouk=@vger.kernel.org
X-Gm-Message-State: AFuF++m6sgz8v00CzbEQMqeSsUnXjyw45Hu9OUQ/e/VyWWlP7TcpEwKB
	jyc2T7Kkj4/xE355lJDU0RAD5eLDHkn3qKmhpaiXp8Rvnj/YJ10J5NAY
X-Gm-Gg: AYBFou2r8sBsIoqSRQycZMStyhF61vmsS4YU20YKQDSp9egrZUpFeskFP4Yuyw9rGvj
	XSsxaK8766NgPRX0FNeqac06y4mBPvOjMywy41/dCjDzmdpT+TDnF2S9xRmPm8DRFpC7P1+45Ge
	XvIHzSkyGwQHNIQsMwdt7I9w1INnj5HvN9ZgIXmDxe1Dth3VrwOHBlRASziiWqhHeKj5KnY1lZ0
	yX7LgwZ0+EO/QfEJoos3m5noEpky05x+UmjyCSC+7U1T8dIFx7rPSdRD+skOE4f3PZ73KitIH4n
	xYzvtwu2rpOIFg+HbjWv+jZbL8K83CJ1cI6uDjhjxSdHaJRhPlVe0Aj8x9Jr657uuysO4Wm7h+R
	wKx9Vew4XG9KsiwQqGULWHC45HC9K+0VmgJNmK+4I4Zi3+K4X9RDkZx09ua/ct1WobcyG9LLYEV
	dBGeRIr0aQ/1kqpQBVKI2igmi4HnmMJp+pRlKKvEzogOkoqfNn3+2gezHyVZvJsTsezJWPsr9X2
	yjnVGPU6B5A9QclqsTfjowc7gzA8CjF0EUdM8PX99X4dlpme30kcbzIfqutzO1JxGKhX4E8KBMx
	ylB065wVzjuUxMbMJ1r63ei/8SHcBeZaskanmkoyelc14uXFoFX3jGXMaPxGtDt5Yg==
X-Received: by 2002:a17:90b:2b8e:b0:39d:efa9:cd25 with SMTP id 98e67ed59e1d1-39e54c59c74mr5120122a91.2.1789704713961;
        Thu, 17 Sep 2026 21:11:53 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144ce046d96sm1126081c88.11.2026.09.17.21.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 21:11:53 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] samples/bpf: remove unused hash_func01.h header
Date: Thu, 17 Sep 2026 21:11:45 -0700
Message-ID: <20260918041148.602323-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

samples/bpf/hash_func01.h has been unused since commit 91dda69b08de
("samples/bpf: Remove the xdp_redirect* utilities"). Remove it.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 samples/bpf/hash_func01.h | 55 ---------------------------------------
 1 file changed, 55 deletions(-)
 delete mode 100644 samples/bpf/hash_func01.h

diff --git a/samples/bpf/hash_func01.h b/samples/bpf/hash_func01.h
deleted file mode 100644
index 38255812e376..000000000000
--- a/samples/bpf/hash_func01.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/* SPDX-License-Identifier: LGPL-2.1
- *
- * Based on Paul Hsieh's (LGPG 2.1) hash function
- * From: http://www.azillionmonkeys.com/qed/hash.html
- */
-
-#define get16bits(d) (*((const __u16 *) (d)))
-
-static __always_inline
-__u32 SuperFastHash (const char *data, int len, __u32 initval) {
-	__u32 hash = initval;
-	__u32 tmp;
-	int rem;
-
-	if (len <= 0 || data == NULL) return 0;
-
-	rem = len & 3;
-	len >>= 2;
-
-	/* Main loop */
-#pragma clang loop unroll(full)
-	for (;len > 0; len--) {
-		hash  += get16bits (data);
-		tmp    = (get16bits (data+2) << 11) ^ hash;
-		hash   = (hash << 16) ^ tmp;
-		data  += 2*sizeof (__u16);
-		hash  += hash >> 11;
-	}
-
-	/* Handle end cases */
-	switch (rem) {
-        case 3: hash += get16bits (data);
-                hash ^= hash << 16;
-                hash ^= ((signed char)data[sizeof (__u16)]) << 18;
-                hash += hash >> 11;
-                break;
-        case 2: hash += get16bits (data);
-                hash ^= hash << 11;
-                hash += hash >> 17;
-                break;
-        case 1: hash += (signed char)*data;
-                hash ^= hash << 10;
-                hash += hash >> 1;
-	}
-
-	/* Force "avalanching" of final 127 bits */
-	hash ^= hash << 3;
-	hash += hash >> 5;
-	hash ^= hash << 4;
-	hash += hash >> 17;
-	hash ^= hash << 25;
-	hash += hash >> 6;
-
-	return hash;
-}
-- 
2.43.0

