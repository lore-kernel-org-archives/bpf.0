Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742954;
	b=Wf/FLYTzsj1P4dsq2H5HHgWLnVbDVgg+yuooWamB9ik3j8Mrjh33W97XL/V3NJIfn+5f
	 bRRR7DN6wDZ5NVMNDJyvml32K3jZl05Q1qddRy0IgR9AEg2/q2/OP3sQ8nWaNfypvm092
	 oaNDquEYqhkTMR6jBxhkxQgqZFYghJBbEuM9hnEI5vReSTx/SdiY4X6Niul9b7yBpd8Xn
	 YQiNK9yHMvr2DtLajQ4bZuc3+BqRicJoO2EuGPV/20Jsxlw8EW2K//R2UloAS+pLj2cak
	 85RZOxfh5dvFKka//fYGs9Rs1Xp1lh2zz4P9qjJFUrqynIXwFCJbTnI72JivHCfyCrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742954;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Uxnt8iGFrfRR2RqBEZ3KeYSljAR2LUdExAhrd9BxOE4=;
	b=wKJU0KH2Hbm0WzBdEOgboA3ObD6AjehOQp9zA+S9KFUR7DZ/zE7kWU5eZuFd5C8vg5lI
	 JfnuHUC+3UlNDKoka61nTcnrH5e+mWWtpNKWRKhGX3KcknmaQnFrY1pwKazXucNvvP4ii
	 4BLpUwWLTDKOLIDvPm7DNkCqQWTFw8+VwWPyFoMh73slnJOpkwrZgWATO47e5rwdIZtv6
	 8vePphQxnB2XwSi1c0ZzGrvT1fQo5kJjCjKj1qOKS581PtUTEbLPYoDfR8CESeBrLf3IC
	 m8nJpx2phnZzdiYUM7KaX+boeL6r8/1g99QdDn8moinAltov1CDRcWJ8Dm8/ZuTmOcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sfuNBzzN;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8521C606A328
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 21:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8521C606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sfuNBzzN
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-368c26de2e0so1228286eec.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 13:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793742954; x=1794347754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uxnt8iGFrfRR2RqBEZ3KeYSljAR2LUdExAhrd9BxOE4=;
        b=sfuNBzzN/UPokfGhMFu7uaQLMXvaErnOcSaFw2i3bFhGkgbRskcKeni8N53tr/B4WI
         +boW9bxRpBvOUiE4wWizeSWbRvN5zEt4A73maTA/LhcdeO1KuKwFdLMEkL0VCr2NPHx2
         0c0z0J/lzfmH4L6dj4TEzzwOsZQ/FBo6LAIr72HvRiUqNIN0jW+RNHA7LuSwUzbgrNwj
         HyeR0ginrwv94KBDVPeF6hKIglgoX+LoEOaevgMT2vgy2lRomtXkYwIOer/Rl6RULaZQ
         oEpKMyiPK1719m9OvaU1G0OvijYckCFUYvGpYXGohwjNa3gBDqROKfN7kYQWwvPf1bie
         Ib4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793742954; x=1794347754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uxnt8iGFrfRR2RqBEZ3KeYSljAR2LUdExAhrd9BxOE4=;
        b=y40g1+0rr+YMhzs4AzYoDVDTw4aXfh8RZOmGvnJRnjvVNxPo5mspx5rFweaVhQb8eO
         tUwuiyANuUWeNpn+ZGybNiKHICUt1lmuK+dUiqug1qYRA9EHza7KldCk6wXyib7Fj99T
         WmJn216Cmz3QlPVwYxHLcM1VimRZWG6dVXL6d7lSwyjWXGqRHZxBNIaFkiw/Q3OdELhW
         fdcEwUzt+bIVidgSHp8t0nUR5TxuxseEcD31zlRTaXDEIWHlyFA0I7TkizfI4/b6jtPS
         TA4INzk+o866+i0Ozs7WMWKKdjyOF+uOp/fALPS4FLMPwLgk57YSb6KRKQ8JUOvgkOxY
         lMAA==
X-Forwarded-Encrypted: i=1; AKwUvByY/tL37DjN9ZCv+aufKngNz3kxia5RhhBQ8QTQ7ANwIIaX22PYZ0UZOg4GG57dmbvOkw0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+SIiKfDE3Bh60KNs1+wqEFl0SrhBIY7e0hWW65QEOSmFoN7CXe
	tHeURtMZ3DkOtwpxP6SqbKyRhbg1S2IEhNzsGSjwFuORuUKpobMkS2A5
X-Gm-Gg: AYBFou0mIx3f23i76dDNd+YAVowimk+Nn7QyCyg6qxTD7ohXoH+Ag4s7O7c4LJ6v16D
	BaAE0x1wOyaUFHP0QjdZRK2hrzpu/4PdrJQzo2xiKjHr55mCYdm3WcffUfiBG44ueRTgrbsI1uv
	RypHP/aIoAbKMx3S3/0kbR5f5vIuznfNpHNAQAcMGscOtykAkQP35QBLp/MJQYJ+JAMNbNYWSUs
	T1ug8fRXNKus4zFXvi+lvzYoZurTCO2E7WKt4d1FbR/0GW+eIiibVchiXmjU0glOQ/Ca2G3HDdL
	t5Sui34fNSAsKIRECn+37w/ETKSe9gnx5absxA0zjz/NQEbGorvDUfqS7EwOkQhSyohT30mx3X+
	xH/mCDhbQX/vfmBcIEQWgF8uwqsE1K+7armid0EsU9gJmbt9gMUaI8kjQuGA3fvgmH0HjCshDdn
	z/dgoHWgkiSAKhr19HLACmPRDyrDSXqYq5qHt9xbTca5sxCteuPdjv7EAX+KJie5eKDRcoPXRxT
	bRYs8nRYlW3VfDyKTQD0+D5cJgOF8h9mOru18tHLrvzyj+3kzAfQmDT6mb911jJ2766NuAXTdm5
	WivscXCRl7AaWl0iDdkv8ZKaW6GV/+jWo6yAKagUVPS/XWcGDrLYF6hSZ/KslWc8U8PLzF6X/n9
	l2w9cAVuwMswJWfau5WCPzXcqfstP+YbopNdoXg==
X-Received: by 2002:a05:693c:6090:b0:36a:4a68:84e5 with SMTP id 5a478bee46e88-36a4a68851cmr22202818eec.8.1793742953533;
        Tue, 03 Nov 2026 13:55:53 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3958746sm867414eec.22.2026.11.03.13.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:55:53 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: ast@kernel.org,
	bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	iii@linux.ibm.com,
	bjorn@kernel.org,
	pulehui@huawei.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: Account for zero extensions in patch list expectations
Date: Tue,  3 Nov 2026 21:53:09 +0000
Message-ID: <20261103215309.19950-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

patch_list_insert_in_front() checks the translated instructions around
the call of an inlined bpf_loop() and its callback. On s390, the verifier
adds zero extensions after the two 32-bit register writes in the loop.
The call is therefore at instruction 25 rather than 23, and the later
instructions checked by the test are also shifted by two. The test
fails despite the call and jump offsets being correct.

Use the corresponding instruction indices on s390 and RISC-V, whose
JITs request explicit zero extensions. Keep the original expectations
for the other enabled architectures and retain all branch offset and
callback entry checks.

Fixes: 57fae4059380 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf 7.4-rc1")
Link: https://github.com/kernel-patches/bpf/actions/runs/41696128762/job/126138168160
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 .../selftests/bpf/progs/verifier_patch_list.c  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_patch_list.c b/tools/testing/selftests/bpf/progs/verifier_patch_list.c
index 581b75b7b5c5..a9ad1dc56c3a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_patch_list.c
+++ b/tools/testing/selftests/bpf/progs/verifier_patch_list.c
@@ -298,6 +298,23 @@ __arch_arm64
 __arch_riscv64
 __arch_loongarch
 __success
+/* The verifier adds two zero extensions for these JITs. */
+#if defined(__TARGET_ARCH_s390) || defined(__TARGET_ARCH_riscv)
+__xlated("25: call pc+7")
+__xlated("...")
+__xlated("32: exit")
+__xlated("33: r0 = ")
+__xlated("35: r0 = &(void __percpu *)(r0)")
+__xlated("36: r0 = *(u64 *)(r0 +0)")
+__xlated("37: if r0 != 0x0 goto pc+2")
+__xlated("38: r0 = 1")
+__xlated("39: exit")
+__xlated("40: r1 += -1")
+__xlated("...")
+__xlated("51: if r1 != 0x0 goto pc-12")
+__xlated("52: r0 = 0")
+__xlated("53: exit")
+#else
 __xlated("23: call pc+7")
 __xlated("...")
 __xlated("30: exit")
@@ -312,6 +329,7 @@ __xlated("...")
 __xlated("49: if r1 != 0x0 goto pc-12")
 __xlated("50: r0 = 0")
 __xlated("51: exit")
+#endif
 __naked void patch_list_insert_in_front(void)
 {
 	asm volatile (

base-commit: d4bf9e34e299e45af8da2b0457b0ac3efbd7ae8d
-- 
2.43.0

