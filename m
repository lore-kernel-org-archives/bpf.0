Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5C6340407
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 21:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788472089; cv=none; b=sDXgKQOSzcyFkFquIlkjyUr54HFuBfdiDIHSOIqZDYCN1UKuZesfZcxTeHBW08Fqsi9KN3rfc0JX+i/5Oi/Bn4fFoirSGIjVL21cW9zLCvQ+nqAZxDDWL9l04phMgwBRoFLyfCBUP2lfJwTEjijvGkGXZ1Le+OyMWkOUJw+lK3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788472089; c=relaxed/simple;
	bh=nXF/HMVZ5fOJTxAQKxJY+Kin+NIS3LVNQkLWBPye16o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+PQpNOwQ0tHl9AbJA0OMfFbb3eZqSGh/6aObIdDl+TNn8M6rBhNR91WbgcHNtKtL0u/Beo6NrjKW20cWW6QNfPJ5Uw7P8EAnA7x2yr2w/AKTsFWQqGzBYDKMmVuymb6YhxKQfNHRKf8AUbEuZnNqHWngv1OziuW6MScRHZRimU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=raEyIxDZ; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="raEyIxDZ"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-499aaf0a723so1016535e9.1
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 14:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788472086; x=1789076886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I8XlN4EL4v/w0cnAVt//ozwnfIlsZD6l/AAx7KptJxM=;
        b=raEyIxDZcBnRV0gLJj4J1M05ROKf5gNeIJ8DN0PEFzqeu2wD0WnpYUYGOWpwNSdJ3O
         b3zja+bUfHMzTeZz3cYd2i8r3rubUd/EY20ILHtStxAQdhj1FjpLgPyj2VBuA8nY97o/
         r2UzvzPFwGRCuzk66aiGLL5EBAsoHZsCZlt56vKVH4ypHQ54AJxGls2ZqD5GLrKYP/GV
         hNB8aWTWiwIMwQk8NHMuGb1oOuNno2cdxxARtRvCZUH6zLhSLTQ81vPi3zLJJ+A6+wUy
         BqLX+k7qvGqTB+/L5hf28P22fA14JikFAwPytFlGmfXjs8z/kzgEWQQiXBhoyVlibdIw
         VydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788472086; x=1789076886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I8XlN4EL4v/w0cnAVt//ozwnfIlsZD6l/AAx7KptJxM=;
        b=JheAaTVd1VXqtCj4Nu9RMdWKrAs9PdP9k+xEdF8ddoxho5sEfMSEyhgm0fg8wEEzPm
         Jv0WPRw7wM+K+aAZP/0xQqEASMCUjU1fZO06IAPCFL8aZuChUtaIJ4e7yZBPrvyEmXw5
         n1GozA5FFM+zKwSxUTGwUSE2BqfAr+eTtLXy1isV17598LdzHfTj7pNcfSCCymTA17tx
         fJYUJxE7WCKkOUimGKIk3BoAnNLkBvge9NiSwDk5iX70SqTnNXr6PxshG4/58XrWUC84
         Sx1Qe9o8b7MRXGGYkZiDWMRGoXbgcaElK5jKnLDeWzHAWuNme4U98RXrDvY73YHHX3e+
         9JJg==
X-Gm-Message-State: AFuF++nE7HEkK5RDyUlJVdFFWvVs9i1RFzDHprWksB81A/YtU6VmwUMs
	rt2Hqz7KbtbR7Ga0DYq0bW/uOwqloYgpoJIIacBTbtEA4vRyZ7on6CK11MgJPlNm
X-Gm-Gg: AYBFou1zsjNepDNBK59Ax3gEViRQuZbqRd3JkMrgady4hBLpdeNt9g68awjXSAgkRgL
	kwc8P8+dS3b+IEZS9u0GtsWsgeAjWF3I92OS3qpO3IogWbzJMRZ7IUfttzQg5xWUZ0AlX1ejJvX
	OC7lW0Q+0fURe+f1iyZ8oUeXTHyuvlEXod17lYmxrWzcVYpDtWjp6uZqMxn5qBD73ugnXPSQRb+
	dn11EFGauaXuRZqyV7nwfWr2OnZfMwZuIRydH9hpMXWdjOQLe89RmtNPNHtF+h21k8XPddwzZS5
	bcxBIZAXfMuA5/R/GYJ2abuyz90HnxzNhhsECeWXMKYZC0pRJwqyYzicWRvKcpj/ZLjAxwSFDLO
	x3wRQ2v+Gsb7z1IU7mckXz7oUxVZ5v8YSU3exi38YMR6Wuuwf4JfPIVggdtBkmtEnMIDoozCDZj
	uWc2LGoyPCrTZ5lGVScl+uDtW4X9TmR4vs+6PdA9UkixR6Zh6fQiIPcR8HMwUKn0HsxqEclCi/N
	nXHMgEMfHF+sKovuNhbDwt2O8yPxNOZeHPhnFJAeQP5N6moSNxAHMipB+JpbbXx5Wyp08t8uz2u
	dBkzuXuAlby9jY/50DHz+IcTOKYSVYYd2hVHPNmS
X-Received: by 2002:a05:6000:460b:b0:484:46f9:7adb with SMTP id ffacd0b85a97d-4858709b1e7mr4046406f8f.26.1788472085710;
        Thu, 03 Sep 2026 14:48:05 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485881350b1sm1712230f8f.4.2026.09.03.14.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 14:48:05 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 4/8] selftests/bpf: Test btf lookup helper sleepability
Date: Thu,  3 Sep 2026 23:47:50 +0200
Message-ID: <20260903214758.2727663-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903214758.2727663-1-memxor@gmail.com>
References: <20260903214758.2727663-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1980; i=memxor@gmail.com; h=from:subject; bh=nXF/HMVZ5fOJTxAQKxJY+Kin+NIS3LVNQkLWBPye16o=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvma5asezN13bd9nCom1B4bsPKkwIqIPzZZATbyn7asn 3dB8wR3RykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACZSdIORYd3R6z/2Rmosu7Dh 076ax5tvcp/R29JsyvAi4n6t0bLHtWGMDNt7XDatV3KZ99Ar0X/y4/1pxdYp5+9GdW84yPhu+bQ vEUwA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add an expected failure case which calls
bpf_btf_find_by_name_kind() from a BPF timer callback. Without the
helper prototype being marked sleepable, the verifier accepts the
program and the load unexpectedly succeeds.

Also add a positive control which calls the helper directly from a
syscall program. This verifies that marking the helper sleepable only
rejects it in non-sleepable regions.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/progs/verifier_async_cb_context.c     | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
index a7c84d3fa4c7..e0926767bbd3 100644
--- a/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
+++ b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
@@ -108,6 +108,30 @@ int timer_sys_close_prog(void *ctx)
 	return 0;
 }
 
+static int timer_btf_find_cb(void *map, int *key, struct bpf_timer *timer)
+{
+	char name[] = "task_struct";
+
+	bpf_btf_find_by_name_kind(name, sizeof(name), BTF_KIND_STRUCT, 0);
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("sleepable helper bpf_btf_find_by_name_kind#{{[0-9]+}} in non-sleepable prog")
+int timer_btf_find_prog(void *ctx)
+{
+	struct timer_elem *val;
+	int key = 0;
+
+	val = bpf_map_lookup_elem(&timer_map, &key);
+	if (!val)
+		return 0;
+
+	bpf_timer_init(&val->t, &timer_map, 0);
+	bpf_timer_set_callback(&val->t, timer_btf_find_cb);
+	return 0;
+}
+
 SEC("syscall")
 __success
 int syscall_sys_bpf_prog(void *ctx)
@@ -126,6 +150,16 @@ int syscall_sys_close_prog(void *ctx)
 	return 0;
 }
 
+SEC("syscall")
+__success
+int syscall_btf_find_prog(void *ctx)
+{
+	char name[] = "task_struct";
+
+	bpf_btf_find_by_name_kind(name, sizeof(name), BTF_KIND_STRUCT, 0);
+	return 0;
+}
+
 /* Workqueue tests */
 
 struct wq_elem {
-- 
2.53.0

