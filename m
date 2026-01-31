Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3269333A71E
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 05:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769836177; cv=none; b=rmkEJ5CdebLIoH7Y2Zb8+e3IzQ6060XqeBv3al6L8KEho3TvUaRTFb7V5lS/NjYEr0oKAD76BvvDSMHtFUy5OF+FnYMn3giUg7f5RHkSgkt7YOuiCDJ3GvmHNYw5IUPLqCqwOuKPQw+ZYeNifBt2tf1iC4c2EyrO/67IcauGdWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769836177; c=relaxed/simple;
	bh=3iS/7iavCieY0vGjt3CSw+m+ZHXLXWxjaSalApUkmvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhJr7WURuL54KVN37zbBuvXl4dNVAmju2uMajNW6duiGdpU/DVsXQO2kWbh4u8d+yEQWfj6j1kqSDDIGCCTqvbvH3zswQIRkCHOcjGQRbXxXB9rVy9Xpe/OrU8gJwkGJel503B6GaGPLCUq0amrWmd7r/gzBZDl9Yf6cm0zdwHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anzbueIU; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anzbueIU"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-bc17d39ccd2so1112951a12.3
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 21:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769836175; x=1770440975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVecu991SVFveWbBZhAv7g6YYbwLWhpF7kmZTPpREKw=;
        b=anzbueIUVjJy9s0fxs6E6bvkYh0JV6n8Yo34BghbRCIgk3cMquDb/gCLNMdfIwXgij
         oMzrognigpYNB6aar25mIEg/rXyG4jikSDYMGJXwiifNLVhLDbF14b3KW5W2CEm2A/Ls
         /EOwiSmu6TUbrwppu8HzgY9LtV8bE6U3F72PZJDJSMzDlNM7GqNbepZg9GYlOlv1eYjQ
         2PngI6NXdBc2ac3r9E8IfWl89PgiJlR28OH1ogsTUARx20sL5Ui5COHXrYAXNSXEONhx
         tfvXLck/vBq+cZ5YBzSZPxfNC5ZLvY1L4T5ebMFSQ/FftQsEe5t6sr8ZCWZo2KcM3iBQ
         BcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769836175; x=1770440975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QVecu991SVFveWbBZhAv7g6YYbwLWhpF7kmZTPpREKw=;
        b=nFROvYdSBqrA/pJJl7inD8cgjCD4Gz0jgco3Y3oerwMufNAPhIZKjZdPT4HIujphm+
         GqIX0b+triFWMK2EWT2sGGyHZG9comvoQs7L2LR0cC7iK0q4bVzVbCtzMIXCnvYDjTIy
         D1C4fXbTzgxkDjzG8EWdJzLGTw9sF9SYposHVl9SPLPpBYDEEDCs+vQJ/r3t/gigGJfu
         fW01cbAiVG9SaiXqfhkH2ETIp67W42hm8oF1dlmIIMutWmv6ofCnHwLlBN2V1ogPUFP1
         gxXcyNEmmwyKaSNToHy8baPtvv62ppgA5rkwEkt3TBvoj+NE2uNXgvf2YpDzF/Jog7I5
         mh0Q==
X-Gm-Message-State: AOJu0Yw/I47myg2h06V009O/jmrNfTH1eJdqEJaU7+xvU86/Pw1oAvix
	e0ogU5rE0xK3IoGGLRA1thLRbyVYRQB6KW0z78R6vsPQqxQBp8L8PxAgVH1Xzw==
X-Gm-Gg: AZuq6aLzFTBnfuO94JeNPXhevpuzA2Z6Cg2ydAM779CPKu7nlQpq8KKVX4P8CJmApW1
	Md0qiMheOleHKMK7Rz+x3bl+vUYziWppGyCdOeP5TRtBXq7Y1BP9bXQxpONxL2iNB3sHnb0aIWR
	7hKqaGgW78jIDLOUWBSgMITt1Yah/0AQAX/reDCNZu6iCiDEf0IQseRSxEBMt+t7wc671pw3NMl
	l0hQ2fxq5QPefVV3paNJz3MMJIpe3wDXrnidj3pujMDeadjaUVBItotm28f7NAtPnazHFPo6SBS
	5CSEjMS8GWhNGh8mOjaPTjht/+9mg1IjcAfwFy1TuvJIXYKfpQVcUG6UcqHMhaTGVw+fBGut5dF
	Zc/0OiOacfKNjNs4U7t6FHCXf4ns0RirG42CjqjMU3Z3bOACFqjOTfBTZDALZ/mQuDmp/mPv4Ki
	a7
X-Received: by 2002:a05:6a20:2d0b:b0:38d:f084:e349 with SMTP id adf61e73a8af0-392e0143724mr4623459637.54.1769836175397;
        Fri, 30 Jan 2026 21:09:35 -0800 (PST)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c64277e4efdsm9123359a12.3.2026.01.30.21.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 21:09:35 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 12/16] selftests/bpf: Update sk_storage_omem_uncharge test
Date: Fri, 30 Jan 2026 21:09:15 -0800
Message-ID: <20260131050920.2574084-13-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260131050920.2574084-1-ameryhung@gmail.com>
References: <20260131050920.2574084-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check sk_omem_alloc when the caller of bpf_local_storage_destroy()
returns. bpf_local_storage_destroy() now returns the memory to uncharge
to the caller instead of directly uncharge. Therefore, in the
sk_storage_omem_uncharge, check sk_omem_alloc when bpf_sk_storage_free()
returns instead of bpf_local_storage_destroy().

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/progs/sk_storage_omem_uncharge.c   | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c b/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c
index 46d6eb2a3b17..c8f4815c8dfb 100644
--- a/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c
+++ b/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c
@@ -6,7 +6,6 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_core_read.h>
 
-void *local_storage_ptr = NULL;
 void *sk_ptr = NULL;
 int cookie_found = 0;
 __u64 cookie = 0;
@@ -19,21 +18,17 @@ struct {
 	__type(value, int);
 } sk_storage SEC(".maps");
 
-SEC("fexit/bpf_local_storage_destroy")
-int BPF_PROG(bpf_local_storage_destroy, struct bpf_local_storage *local_storage)
+SEC("fexit/bpf_sk_storage_free")
+int BPF_PROG(bpf_sk_storage_free, struct sock *sk)
 {
-	struct sock *sk;
-
-	if (local_storage_ptr != local_storage)
+	if (sk_ptr != sk)
 		return 0;
 
-	sk = bpf_core_cast(sk_ptr, struct sock);
 	if (sk->sk_cookie.counter != cookie)
 		return 0;
 
 	cookie_found++;
 	omem = sk->sk_omem_alloc.counter;
-	local_storage_ptr = NULL;
 
 	return 0;
 }
@@ -50,7 +45,6 @@ int BPF_PROG(inet6_sock_destruct, struct sock *sk)
 	if (value && *value == 0xdeadbeef) {
 		cookie_found++;
 		sk_ptr = sk;
-		local_storage_ptr = sk->sk_bpf_storage;
 	}
 
 	return 0;
-- 
2.47.3

