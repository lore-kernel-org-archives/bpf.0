Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256A4336881
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 05:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774502682; cv=none; b=FmJyQXiEn1QMiO8MEXKFZcaPIOikVKXJCei2JTQPWXGrjm4yCi/PVFbBRhx5hED4Yz8znpz3rvVlp8UTfQAKf4wuLXSDYNpegN12dOwpc7RGvCACWZmSvmtgZFF73WJLNAfxHLC9IWOOjakoz6eZ4hhnhkjkO3ZZi5VYZUzq6aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774502682; c=relaxed/simple;
	bh=Zjn5tc7qnRWZW3prS5BBUQx6Vtyf3u9Ap3hr5Lwpf74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLlLl4/bDe7ShYDy2hh9oICjR8Gu2Yal40BzCoJPejZAHhx6LRco327kujmntYrzIlQ0WB+Yq9Roc6PnJw2481xgU/aJhysIIoPZ6yY+mUYNkW6VApz+80yI4N3sjmdGT0tNLmXpbNZ9+I3fXWocssgoyQRWHY6AjKthk4KTFOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4J2DkrN; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4J2DkrN"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-829b8b6c4d0so535760b3a.0
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 22:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774502680; x=1775107480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHyeU4nBukiA8DY8OX0cJeQ7AQx9FWpqPwDNTCp5uio=;
        b=F4J2DkrNME5sgMZPkjT0SOCU5qzB92NoyzU48I9cCn6/889gnfkQEwVkFnk0NI6akP
         5bSuXfBuL7a6Kz+KUSNpNyhennet10Zw/xU2GNg9sHBIc6zpBApl7Ryzdb91Bl0QcwHZ
         kOHkguBTPsmF2h9p9UpW1Nroip6mhK4MsIa75x6CIOxdJJJTkifnoARZi2pVdMyFdGJp
         EABCLuQ3G10T1Nb6abvwvRwHwYanaGU4U9RJOd0lGEb1pd980nai2aA4C1O5WwFsWj0z
         hySD+7Im/Ni9dIWS0PCgmdafifcwv2gbexE9ff0n5H/qwp45+9hNIQzqzDHsYXe/NvdG
         yc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774502680; x=1775107480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wHyeU4nBukiA8DY8OX0cJeQ7AQx9FWpqPwDNTCp5uio=;
        b=UiqPBOaOgnfmct2kBngNkLBNxfGRydmWDNptIJpkeyssnEiTLTOYYWX2JFDY66Jy1t
         Qv8rEYuIBUk1RD+YL/JWMWCUadwzi4pBHlhpVcF9YHNLrXaW/ABISDO7Ae/DjO7KOFPY
         GX0Sd0DZ86dAOU3MkvT85zow10njSUCuspGB8EZuKtP47T7GpywijQ4/SZWJKBzxOO4p
         qU88zZORUYVTjYTMMKTI6MKIgs2mae2e0OkKA2pqcQps9zH+TP8aepvF7N22KZ376q2x
         7rxcTV4hJSwgix7ZpcD05v4BMsmQz5Kk0ApxNJvBYzKaBesibC9FsYUCagkGKpgXMIEo
         9fNA==
X-Gm-Message-State: AOJu0Yxq3Ea4SyFNdVwe3erG2IVxentlIINHLI+q4LEkjFpFBfV32SV9
	mQvotNk2uIHJpxUItDW/bv2d6yrCfS86Nw8MpUVLxz8U86Hhs0tmSWTZgiNBgQ==
X-Gm-Gg: ATEYQzwySpgzN9OwpAOkKZVEaLSSnZAo57VV6naQjcF/HgD71a9Dt720Cv1yL7d2VEx
	z3sUwlCyRYUSOt8T0DFSRbs+YVfJq4yDwQmeIeGN32ffkQrFZcEnxXMpTwtE2Q+5/7BbuvYqOJq
	ug0MFa8uwpfZ1QEI4UQQE04yARqA6VigOddhJ0PTRb/mFOomNozTCGUkm+SFnlAMtVWwpvs6C+G
	s7aw+70lTkMilEbhRbWTNdXsSR4Zau56qO3TM1BkWQxG5u0SAwEhTsuFOxbgXPEWBNaqhSmMJ08
	gWw1HzM0E3LqMz4DOeXLGcqLgD66Sd71S56GFb8jYzWGGUoDMwinHT810gRBtDMM/toeAH26IAu
	PHMR1TfUt6LpgnxD5hc0zYok60SeC4D5dkerAE9aYNP+pDlwdeGnfE9A7VZj5esz7yw2qxicmgv
	IFEN7f4WC7jFgU
X-Received: by 2002:a05:6a00:390b:b0:82a:687e:c048 with SMTP id d2e1a72fcca58-82c6df8e77bmr5814918b3a.30.1774502680267;
        Wed, 25 Mar 2026 22:24:40 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d3ca803sm1398521b3a.50.2026.03.25.22.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 22:24:39 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/3] selftests/bpf: Fix task_local_data data allocation size
Date: Wed, 25 Mar 2026 22:24:35 -0700
Message-ID: <20260326052437.590158-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260326052437.590158-1-ameryhung@gmail.com>
References: <20260326052437.590158-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when allocating memory for data, size of tld_data_u->start
is not taken into account. This may cause OOB access. Fixed it by adding
the non-flexible array part of tld_datg_u.

Besides, explicitly align tld_data_u->data to 8 bytes in case some
fields are added before data in the future. It could break the
assumption that every data field is 8 byte aligned and
sizeof(tld_data_u) will no longer be equal to
offsetof(struct tld_data_u, data), which we use interchangeably.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/task_local_data.h       | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
index 7819f318b2fb..a52d8b549425 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
@@ -90,7 +90,7 @@ typedef struct {
 
 struct tld_metadata {
 	char name[TLD_NAME_LEN];
-	_Atomic __u16 size;
+	_Atomic __u16 size; /* size of tld_data_u->data */
 };
 
 struct tld_meta_u {
@@ -101,7 +101,7 @@ struct tld_meta_u {
 
 struct tld_data_u {
 	__u64 start; /* offset of tld_data_u->data in a page */
-	char data[];
+	char data[] __attribute__((aligned(8)));
 };
 
 struct tld_map_value {
@@ -158,6 +158,7 @@ static int __tld_init_data_p(int map_fd)
 	struct tld_data_u *data;
 	void *data_alloc = NULL;
 	int err, tid_fd = -1;
+	size_t size;
 
 	tid_fd = syscall(SYS_pidfd_open, sys_gettid(), O_EXCL);
 	if (tid_fd < 0) {
@@ -173,9 +174,10 @@ static int __tld_init_data_p(int map_fd)
 	 * tld_meta_p->size = TLD_DYN_DATA_SIZE +
 	 *          total size of TLDs defined via TLD_DEFINE_KEY()
 	 */
-	data_alloc = (use_aligned_alloc || tld_meta_p->size * 2 >= TLD_PAGE_SIZE) ?
-		aligned_alloc(TLD_PAGE_SIZE, tld_meta_p->size) :
-		malloc(tld_meta_p->size * 2);
+	size = tld_meta_p->size + sizeof(struct tld_data_u);
+	data_alloc = (use_aligned_alloc || size * 2 >= TLD_PAGE_SIZE) ?
+		aligned_alloc(TLD_PAGE_SIZE, size) :
+		malloc(size * 2);
 	if (!data_alloc) {
 		err = -ENOMEM;
 		goto out;
-- 
2.52.0

