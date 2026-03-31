Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB59450903
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 21:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774992966; cv=none; b=oMLv3iWOpl0+O1H3f+FefaVUBgvIGouxaSZDxaf7N/yEoE75unKuUChasK3xSUqcHe9JZ+8MOZcHtBvRfhIBY+GQjSriK+OcpqNZQlHu/pedBHb5wUXtI4nZRX4OVj6/umiDCb7aBnjlXoD06C28x9voJ258XCl6FZIQdUSruqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774992966; c=relaxed/simple;
	bh=XG3Ko+TiaAsO38YXfVIZ8ztcLOJRACa4EKxVspX6XAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3aei/RzCqWmJUWNGI92R4xlZe7VSDWK3+q2FNnK9apQUftjcPhIt3RMb6evsRSJwqL61Jul8d9OGr0zZYaeIJ3PL8mUBKj+Z/aLAvv2xhcwa6aPQkNxKP3Ng901qDHwEKeZo6nLGSpFnw/JhO97VCRBNLaSriKi73GgBNmfqBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFdPBIpO; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFdPBIpO"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35d94f4ee36so2192335a91.3
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 14:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774992964; x=1775597764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umNVLkKdeST432Jn7RU/5GJ63Qjob+WuV+wYnVktEIk=;
        b=mFdPBIpO9OYuqRfkrkiBchIDeOMDd7xF3t0jGT3Xn/8KRg45E9Skmd+9ypzDxof+E+
         hqWVS24gjzPfdmFR7XbTjD3YMuESoSMMh0UmgXs+SBFc0ZNHN8bY7Gw5+U7aEpyTeGFE
         gV/RDtQKhbZV5AE53607okequ9z9e9VpqjPm7XzJJGpkawQFdRhNLT+X5wOw0PuK1NfR
         s9JdWyYeGhUzgl/WEN+wySRzYIBKzvuDg8cg56qsTZUg9FupKRpFI/4e6QFIxfvQ8IMW
         oQqFl0oqZ1ZH2VNE6qre4Tx2hbNUj4+wCdtIj1VEeSSCb6qGdqE1ZjUsA3mt1R32Fh7D
         rseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774992964; x=1775597764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=umNVLkKdeST432Jn7RU/5GJ63Qjob+WuV+wYnVktEIk=;
        b=DN5RiSSeiskii65QD0zqHW6hQn9rrhmjyEv9L7duF0ezxXbzUKdzm/2hXekdypgiUE
         y93perq5KrUm+KGebkAztPlBH/8WTNsPuuTTIjIn6RMu0gyZzqJIrILhQ4L9zOLJaVAP
         142/eeLdPe1N4/6kkYJPFhw+niPGcgIWD0Mp5RsKtjohC5zQKMPNwY0queSjHD5dekfa
         k7U30mktBURp0C5D9qEYzg/ypMig+ChopIM1yVm+54LLVHgVt+8O5FpqcGhE0ZGyt3n8
         /ErRSyPn351ih6V+Q4bV1rLc+x/RfeLBWquRR33aoiGZHfws11SZ10l7mMGehbPr0zlk
         VApA==
X-Gm-Message-State: AOJu0Yw5S0XHRYKK9duyB3coDCF1m3ncCSCbvw7K36ef4T7NtZOozfpb
	xy47JRpWIEcuKsXEHlaed7kXOmU8WUFIRT3I8EV1jTKIpwxtsP2NEWQyELZX5w==
X-Gm-Gg: ATEYQzwcmNiO0ebP+VV5oBbcZX0Xu3GeFepQA0hPj9gOMcIc3FVQN5+dI32ytRy1vet
	F7ZEcRucKDUzQtkPW5XYF0f0r/t+Fp7Tz2HhJ+cvmRtcwq/6Ni8dzfL50TlZFZvP4M49lRWt0JC
	qjvOzJ7daw11u/6nAPDzZrewYN3oZ7bHtCjIQNvKk5jF0mXjgzRzL60VWLHmZHQp31bHlYIQ+mY
	wsM6b7nHy4+2kg4+i9O99wzc0HCviK11eKU8Uh4AAXzeho6hWcCMWPWw9abRQC9OQTpLrWDdHEn
	fSd99hBjGRI4ecqyyVti5sorgHpFnq3VTyFm4pbadyXO1PSfCYIJ9asGXfqY8ZWrqfGZYrHZgV7
	qiYKg7bDC6ZHogP9orAPCZSAmGlRrILI1vKejr3LOcBN9rrmnajoI5zNsQaos5sG/e5RTtSgJnN
	k7koJk2lh18gYdVA==
X-Received: by 2002:a17:90b:4e88:b0:35d:a2aa:3b05 with SMTP id 98e67ed59e1d1-35dc6e7ab50mr769543a91.5.1774992964555;
        Tue, 31 Mar 2026 14:36:04 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe937925sm3633255a91.12.2026.03.31.14.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 14:36:03 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yatsenko@meta.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 5/5] selftests/bpf: Improve task local data documentation and fix potential memory leak
Date: Tue, 31 Mar 2026 14:35:55 -0700
Message-ID: <20260331213555.1993883-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260331213555.1993883-1-ameryhung@gmail.com>
References: <20260331213555.1993883-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If TLD_FREE_DATA_ON_THREAD_EXIT is not enabled in a translation unit
that calls __tld_create_key() first, another translation unit that
enables it will not get the auto cleanup feature as pthread key is only
created once when allocation metadata. Fix it by always try to create
the pthread key when __tld_create_key() is called.

Also improve the documentation:
- Discourage user from using different options in different translation
  units
- Specify calling tld_free() before thread exit as undefined behavior

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/prog_tests/task_local_data.h          | 25 +++++++++++++------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
index 91f3486439bf..1e5c67c78ffb 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
@@ -22,14 +22,17 @@
 /*
  * OPTIONS
  *
- *   Define the option before including the header
+ *   Define the option before including the header. Using different options in
+ *   different translation units is strongly discouraged.
  *
  *   TLD_FREE_DATA_ON_THREAD_EXIT - Frees memory on thread exit automatically
  *
  *   Thread-specific memory for storing TLD is allocated lazily on the first call to
  *   tld_get_data(). The thread that calls it must also call tld_free() on thread exit
  *   to prevent memory leak. Pthread will be included if the option is defined. A pthread
- *   key will be registered with a destructor that calls tld_free().
+ *   key will be registered with a destructor that calls tld_free(). Enabled only when
+ *   the option is defined and TLD_DEFINE_KEY/tld_create_key() is called in the same
+ *   translation unit.
  *
  *
  *   TLD_DYN_DATA_SIZE - The maximum size of memory allocated for TLDs created dynamically
@@ -47,7 +50,7 @@
  *   TLD_NAME_LEN - The maximum length of the name of a TLD (default: 62)
  *
  *   Setting TLD_NAME_LEN will affect the maximum number of TLDs a process can store,
- *   TLD_MAX_DATA_CNT.
+ *   TLD_MAX_DATA_CNT. Must be consistent with task_local_data.bpf.h.
  *
  *
  *   TLD_DONT_ROUND_UP_DATA_SIZE - Don't round up memory size allocated for data if
@@ -110,6 +113,7 @@ struct tld_meta_u * _Atomic tld_meta_p __attribute__((weak));
 __thread struct tld_data_u *tld_data_p __attribute__((weak));
 
 #ifdef TLD_FREE_DATA_ON_THREAD_EXIT
+bool _Atomic tld_pthread_key_init __attribute__((weak));
 pthread_key_t tld_pthread_key __attribute__((weak));
 
 static void tld_free(void);
@@ -140,9 +144,6 @@ static int __tld_init_meta_p(void)
 		goto out;
 	}
 
-#ifdef TLD_FREE_DATA_ON_THREAD_EXIT
-	pthread_key_create(&tld_pthread_key, __tld_thread_exit_handler);
-#endif
 out:
 	return err;
 }
@@ -203,6 +204,7 @@ static int __tld_init_data_p(int map_fd)
 static tld_key_t __tld_create_key(const char *name, size_t size, bool dyn_data)
 {
 	int err, i, sz, off = 0;
+	bool uninit = false;
 	__u16 cnt;
 
 	if (!tld_meta_p) {
@@ -211,6 +213,14 @@ static tld_key_t __tld_create_key(const char *name, size_t size, bool dyn_data)
 			return (tld_key_t){(__s16)err};
 	}
 
+#ifdef TLD_FREE_DATA_ON_THREAD_EXIT
+	if (atomic_compare_exchange_strong(&tld_pthread_key_init, &uninit, true)) {
+		err = pthread_key_create(&tld_pthread_key, __tld_thread_exit_handler);
+		if (err)
+			return (tld_key_t){(__s16)err};
+	}
+#endif
+
 	for (i = 0; i < (int)TLD_MAX_DATA_CNT; i++) {
 retry:
 		cnt = atomic_load(&tld_meta_p->cnt);
@@ -353,7 +363,8 @@ static void *tld_get_data(int map_fd, tld_key_t key)
  *
  * Users must call tld_free() on thread exit to prevent memory leak. Alternatively,
  * define TLD_FREE_DATA_ON_THREAD_EXIT and a thread exit handler will be registered
- * to free the memory automatically.
+ * to free the memory automatically. Calling tld_free() before thread exit is
+ * undefined behavior, which may lead to null-pointer dereference.
  */
 __attribute__((unused))
 static void tld_free(void)
-- 
2.52.0

