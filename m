Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6E0531AF8
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789059182; cv=none; b=J63Y8Iw0oIrQa+OeNbOcSAu9qrtbB3G+hK83HcmuHtOkGgQLX1Q/pSAzjSrqsf5X7NZRQmd9+/SPRtrR7CIZQSqqKrVs5NlHsInwsNfX8ZluEXwjygwhod9Ro+bc9AwNneav6qek0QksjhppK8q7TT+kAa9qToEaYtXLpiPIH4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789059182; c=relaxed/simple;
	bh=IUh1cWchmC0vld51ke7tyVFS0qPx15TlB96mZ8dNts4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gANOQsOvE+YSneA3b6y3uhQgfigzUmdEAJ42SN300hQbxmFrayJUcqDN4Dkyy4B+FN+8elrYOrMjr/QMgOT6QH58ijU6cvT90uwYIeKOXm22nTB+Wxxjp06jCPs/Wmw3nhvkMWimAewBLu0vzVPAXVLW7vhIP+dV5ytmYZuHzI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0xTAEql; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0xTAEql"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-39b9a99469fso3224985a91.3
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 09:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789059176; x=1789663976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tyS0dUys65sGsGrVA9hi3CkVbRxamfGAlz/CIe+hAe0=;
        b=Q0xTAEqlQHR+lhWxzbXufxvdVq9tgLfjuV09WToxglPDJnPDwieUvc4jeXzYda7y43
         rl+/PQLWpHwtgnaFgEfNu3tbL/n48o7nmp8qbnCQdliNuF9zikCoTznFG5kWumjiPnri
         yTaiNDh49EWz2qjwhYgv8p+ga2a4G+BMWuMdOVy3JBKBloQITSl7bb0I3iCVNQCimCsV
         kfbXgqSvXjg8ZoIE7PN56wwUParWGpuJaWPomflRLa3sVZATienHN3LKrJZa3HNAhynz
         MIMOItOpzvjAzoamESmQ0uTKpPnu1W8MH/ERG7L8dnGxL+0hvIcPKmsG1CftmHNwG1go
         n+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789059176; x=1789663976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tyS0dUys65sGsGrVA9hi3CkVbRxamfGAlz/CIe+hAe0=;
        b=gAq9Y2D9bNIYmUy20mM6r/OnEXoYvCQ/J6iymYDS4TZinU+7P2nRpGHRRuvpwrH5gp
         o7bVj6K59H3tvkaqhCKATB32dTyxS42EOk1yKb9B3oGdOSsDnBJGw5U/9rCGBdeAEBZk
         eA9EU3ws1w2/bQKk+Lt7MqLUuKfOWgyd8L1fr4M9G/TAG3cq9sZEA1goiHUEho1PUspx
         JGiE0dCEP0/ila3gDrflEteYtguSkKELGAnuVRLsQx76yUxhB56ndFnRqN3Mak5NzCVq
         9LuMiFnj4W8WOuNGftrXpN1sC5VaxREFS+o6urPaS25ie1EOxxHLa4npr7/zvkgg8sdF
         IxRQ==
X-Forwarded-Encrypted: i=1; AKwUvByvqJhIB9BG387gDVVZIvzNRMRQvVTQRnuZ6sMzjGIKb/8jJnpzdPT+ujLfGuon4d9Y5lM=@vger.kernel.org
X-Gm-Message-State: AFuF++lX4+6HshYpsTTR96X+R19gkuZtTCgxcyFx8GVu9ykp0hLt9Jkr
	jaL9r/dVm32w2jpuDYSrExXXbYGjBjCEwjUrPVL7osit7pK4LmcIVVqt
X-Gm-Gg: AYBFou1ZqCovj/7reCHCZ67EtaogoFKO6E1kdN0xU2vmGTP9/S+f4YvoRZCV/cLveId
	CFdjHcq5qBRdca5Ih4tdmKOGvep/mck4aCb92ofQbDNx7bWSThskGziymB7uSjBwW7n7MS0sIs2
	2584RQDTKZc4WaKWowLgt/ViMUHuezYSaq2vBIU2wYMgLA/8ggfvCdXNNiyFjPuswA7PHgHtHKB
	eIzNOb0KLwnlLLdih9lKClvBlnNVD4axOqf1TAaG790iWrac4vT8XF+O0bfkp9hAgc0Qmp54iZz
	XRBKVKdwtzDUovCoRi4r53uXDXJerc+bG2w1twwBNlaE9zMt4hYPSohZrhLXpz7/pwASYFvxf9n
	WQZ6k2ocNLTBAg8WwwBTWFvLYhLAxAYF0FYo2AEUsCQbD8yiQeu9P1HNeAPnuVDkK1zXRmkSNLZ
	QBGdePy/lfUBO6xYK2iU/OQGTnOsKhZ+77LRy8MKCbb0CA4MKO8TzC6GOx3jyXSSP7ZXF51uYw1
	d0JFJOEoRjolXhsoTC6kOIPaL/sM2prSfNPuH0OQJgJ6c9cvxsu/h2CGP6piUuzHGt4crV1RHEB
X-Received: by 2002:a17:90b:4fd1:b0:398:bd37:6a49 with SMTP id 98e67ed59e1d1-39b261cfd8cmr63877483a91.12.1789059175828;
        Thu, 10 Sep 2026 09:52:55 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com (202.176.229.35.bc.googleusercontent.com. [35.229.176.202])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d98e602d8sm64821a91.3.2026.09.10.09.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 09:52:55 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: song@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	akpm@linux-foundation.org
Cc: jolsa@kernel.org,
	ihor.solodrai@linux.dev,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	emil@etsalapatis.com,
	mathieu.desnoyers@efficios.com,
	hch@infradead.org,
	jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	marscheng@google.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 2/2] Revert "lib/sort.c: add _nonatomic() variants with cond_resched()"
Date: Thu, 10 Sep 2026 16:52:21 +0000
Message-ID: <20260910165222.1186628-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
In-Reply-To: <20260910165222.1186628-1-visitorckw@gmail.com>
References: <20260910165222.1186628-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit e2a33a2a3258794891cdd6ca4b1318da6594d157.

With no remaining users in the kernel tree, remove sort_nonatomic() and
sort_r_nonatomic() to clean up dead code. This effectively drops the
wrapper function __sort_r() and eliminates the may_schedule branch and
cond_resched() call from the inner loop of the core sorting routine,
slightly simplifying and optimizing the code.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Build test only

 include/linux/sort.h |  11 -----
 lib/sort.c           | 110 ++++++++++++-------------------------------
 2 files changed, 31 insertions(+), 90 deletions(-)

diff --git a/include/linux/sort.h b/include/linux/sort.h
index c01ef804a0eb..871775978af0 100644
--- a/include/linux/sort.h
+++ b/include/linux/sort.h
@@ -23,15 +23,4 @@ void sort(void *base, size_t num, size_t size,
 	  cmp_func_t cmp_func,
 	  swap_func_t swap_func);
 
-/* Versions that periodically call cond_resched(): */
-
-void sort_r_nonatomic(void *base, size_t num, size_t size,
-		      cmp_r_func_t cmp_func,
-		      swap_r_func_t swap_func,
-		      const void *priv);
-
-void sort_nonatomic(void *base, size_t num, size_t size,
-		    cmp_func_t cmp_func,
-		    swap_func_t swap_func);
-
 #endif
diff --git a/lib/sort.c b/lib/sort.c
index 52363995ccc5..8e73dc55476b 100644
--- a/lib/sort.c
+++ b/lib/sort.c
@@ -186,13 +186,36 @@ static size_t parent(size_t i, unsigned int lsbit, size_t size)
 	return i / 2;
 }
 
-#include <linux/sched.h>
-
-static void __sort_r(void *base, size_t num, size_t size,
-		     cmp_r_func_t cmp_func,
-		     swap_r_func_t swap_func,
-		     const void *priv,
-		     bool may_schedule)
+/**
+ * sort_r - sort an array of elements
+ * @base: pointer to data to sort
+ * @num: number of elements
+ * @size: size of each element
+ * @cmp_func: pointer to comparison function
+ * @swap_func: pointer to swap function or NULL
+ * @priv: third argument passed to comparison function
+ *
+ * This function does a heapsort on the given array.  You may provide
+ * a swap_func function if you need to do something more than a memory
+ * copy (e.g. fix up pointers or auxiliary data), but the built-in swap
+ * avoids a slow retpoline and so is significantly faster.
+ *
+ * The comparison function must adhere to specific mathematical
+ * properties to ensure correct and stable sorting:
+ * - Antisymmetry: cmp_func(a, b) must return the opposite sign of
+ * cmp_func(b, a).
+ * - Transitivity: if cmp_func(a, b) <= 0 and cmp_func(b, c) <= 0, then
+ * cmp_func(a, c) <= 0.
+ *
+ * Sorting time is O(n log n) both on average and worst-case. While
+ * quicksort is slightly faster on average, it suffers from exploitable
+ * O(n*n) worst-case behavior and extra memory requirements that make
+ * it less suitable for kernel use.
+ */
+void sort_r(void *base, size_t num, size_t size,
+	    cmp_r_func_t cmp_func,
+	    swap_r_func_t swap_func,
+	    const void *priv)
 {
 	/* pre-scale counters for performance */
 	size_t n = num * size, a = (num/2) * size;
@@ -263,9 +286,6 @@ static void __sort_r(void *base, size_t num, size_t size,
 			b = parent(b, lsbit, size);
 			do_swap(base + b, base + c, size, swap_func, priv);
 		}
-
-		if (may_schedule)
-			cond_resched();
 	}
 
 	n -= size;
@@ -273,63 +293,8 @@ static void __sort_r(void *base, size_t num, size_t size,
 	if (n == size * 2 && do_cmp(base, base + size, cmp_func, priv) > 0)
 		do_swap(base, base + size, size, swap_func, priv);
 }
-
-/**
- * sort_r - sort an array of elements
- * @base: pointer to data to sort
- * @num: number of elements
- * @size: size of each element
- * @cmp_func: pointer to comparison function
- * @swap_func: pointer to swap function or NULL
- * @priv: third argument passed to comparison function
- *
- * This function does a heapsort on the given array.  You may provide
- * a swap_func function if you need to do something more than a memory
- * copy (e.g. fix up pointers or auxiliary data), but the built-in swap
- * avoids a slow retpoline and so is significantly faster.
- *
- * The comparison function must adhere to specific mathematical
- * properties to ensure correct and stable sorting:
- * - Antisymmetry: cmp_func(a, b) must return the opposite sign of
- * cmp_func(b, a).
- * - Transitivity: if cmp_func(a, b) <= 0 and cmp_func(b, c) <= 0, then
- * cmp_func(a, c) <= 0.
- *
- * Sorting time is O(n log n) both on average and worst-case. While
- * quicksort is slightly faster on average, it suffers from exploitable
- * O(n*n) worst-case behavior and extra memory requirements that make
- * it less suitable for kernel use.
- */
-void sort_r(void *base, size_t num, size_t size,
-	    cmp_r_func_t cmp_func,
-	    swap_r_func_t swap_func,
-	    const void *priv)
-{
-	__sort_r(base, num, size, cmp_func, swap_func, priv, false);
-}
 EXPORT_SYMBOL(sort_r);
 
-/**
- * sort_r_nonatomic - sort an array of elements, with cond_resched
- * @base: pointer to data to sort
- * @num: number of elements
- * @size: size of each element
- * @cmp_func: pointer to comparison function
- * @swap_func: pointer to swap function or NULL
- * @priv: third argument passed to comparison function
- *
- * Same as sort_r, but preferred for larger arrays as it does a periodic
- * cond_resched().
- */
-void sort_r_nonatomic(void *base, size_t num, size_t size,
-		      cmp_r_func_t cmp_func,
-		      swap_r_func_t swap_func,
-		      const void *priv)
-{
-	__sort_r(base, num, size, cmp_func, swap_func, priv, true);
-}
-EXPORT_SYMBOL(sort_r_nonatomic);
-
 void sort(void *base, size_t num, size_t size,
 	  cmp_func_t cmp_func,
 	  swap_func_t swap_func)
@@ -339,19 +304,6 @@ void sort(void *base, size_t num, size_t size,
 		.swap = swap_func,
 	};
 
-	return __sort_r(base, num, size, _CMP_WRAPPER, SWAP_WRAPPER, &w, false);
+	return sort_r(base, num, size, _CMP_WRAPPER, SWAP_WRAPPER, &w);
 }
 EXPORT_SYMBOL(sort);
-
-void sort_nonatomic(void *base, size_t num, size_t size,
-		    cmp_func_t cmp_func,
-		    swap_func_t swap_func)
-{
-	struct wrapper w = {
-		.cmp  = cmp_func,
-		.swap = swap_func,
-	};
-
-	return __sort_r(base, num, size, _CMP_WRAPPER, SWAP_WRAPPER, &w, true);
-}
-EXPORT_SYMBOL(sort_nonatomic);
-- 
2.55.0.1003.g10538fe699-goog

