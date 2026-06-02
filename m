Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945E630C159
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 00:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780360900; cv=none; b=F7kxmq0X8B2LbVGdWuWLHmmUYtVe+LudngTviDAys5dt3OhxXz2KfOpBP2xMS8BTIcwtkxRXZE/+dfifjoqGsngIzbk8Jwdz9nX4OWtOCyeD+wK09wf/XKfcwSe0TOCUxSWNKeoqV05ZxIBvUohCP8rU7hdfyLnEQ5/K/nttWxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780360900; c=relaxed/simple;
	bh=5a1oVTUhDljv0ClgO3v7wSTQtgaZUS2tMy5HNEWTM4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYpettVfO5FAAumdC7W9mZRnOKkj9+BOtNenmzv0X3aqYMgDzdLzpxIQRSWvJTr7xSktnWX91rud9jPKIW9I3CgqiNkGxCRVZ55+3v+sM/OmLYk4PlvfgwhBDePqHCLNNnVMI/coYtyY2UoVkPaCaAmr6X57OxzPfETQzF8voXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=PFeOVzRO; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="PFeOVzRO"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-304e83724bfso4973157eec.0
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 17:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780360898; x=1780965698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xy850NneD4r4zouvtuvarurekKw/+ZCNnUETv83CMOo=;
        b=PFeOVzROxFX3eQ48M4VPDIMBXygKs/G4sPM+nsBzFC9t3kZ7lXlXllEx3qH+fILr/P
         21tkCUV/Ndfe23dg+CowPCPM17nbX8GSVbYNS3uiC9MZhb5fpQ7CE10qgPv/f9bku22X
         QS+q+b3jWoojTaYD0Yjj6+u1qR9hFX6oiPFYxmMXrjW0m3fcysFXnhWLl57ffLftZf3K
         9gsyYTdYlm7vnFY0C60g3wbZDHr8axlqh7M7ZN0rNCjSjhVWUabL6RFq6qBuGaAuszbd
         Ag4Ksp0DUB0y/JZc3l+RVtwTqMpL4fka1Vh5F2y6jKjw7Qs2y8XGMAdmTdQrYZ+7RZFF
         ArjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780360898; x=1780965698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xy850NneD4r4zouvtuvarurekKw/+ZCNnUETv83CMOo=;
        b=GqVkahzZX/fq6MlUxQYJipgOGvtH+73bnBZDeq5ejYOkcB0jszm2ysaGdrABxasfD3
         0z1odsxR6zxmzXCP1b/9S+6Qiiask2m0+OluVE+hBz6eSecaAuD8JatI8Bk3YYKqB+9N
         LpLsWfnVYB0ZrHQ6ehZ70HWjO3D6Fx4QasL4Q470Oy2Tu0jQ9dtn3nOx+bPI9SzNeTZM
         pk5ww5JzdOiq4cI3QWwCDfnKb/2NdqyBmm7zaDXLF0PRrgtr21iClR7eVhAHHvTR1qCu
         w2cSBWhG933yLk+yLWrDkQZ9SZ5m5rdwCnaBpzxiP5RrHGABZvfD9cykvfi2dQLw7gmv
         NH5w==
X-Gm-Message-State: AOJu0YxKBV62gsI4bflixD+vNOO5ctiKSCl/qfY7lAJgPlgXaFfnFQKR
	kOm1OLH55wdiKYijLx7rOVSi71Nzd2kwzH67VmQOxpLHAb4m12ZpQKAfasrY8SAFN7QLFrJgcnH
	SzIXjiE+9UgWe
X-Gm-Gg: Acq92OH5Sa4KrVTlWCB7AhA7UXmlulUAmUI5dj7ny+xiBWjpzQeqzxJ5AFwq0hMrc/4
	OOiWO6IVbhYa26l9yl9X4mw3/JngNDe939aveehcILo9CSWHVpceyr3eYyqfJkL+NCcjPiokikh
	vZEcy+wHru0l9/OpKf8fBZSGarPxbtNewkXEEe5VA4QiShXz+OLTMl4S074ZONkehX6snJwOVH+
	h+LP46f1n5PpzGb665m6j2UDKYEiP2v/1W+UvTTGmktOp+ezNNs86Ozf5ZjjkdTSrxEHhsgVC8/
	Od63AAyFnyTo50lB0alrZ/3eaV7tp8h4L5Mo6612qxPC2Ip5cUqi0bO955mp/0eRX3AD7j5DzY6
	SaT8be1HRt5t2UJjceK0D6ZQh4GN0jYo5LN8hQAYIe/O1QMrQ6W6mNdvVpQNObKg90R8WC9CHzf
	eLQOkMfd0XpE0Rj5+D+De0zlYpnKH1GA==
X-Received: by 2002:a05:7300:6da3:b0:304:997c:d47a with SMTP id 5a478bee46e88-304fa4eded0mr5594184eec.10.1780360897643;
        Mon, 01 Jun 2026 17:41:37 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::4f12])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5d5385sm10172018eec.28.2026.06.01.17.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 17:41:37 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	mattbobrowski@google.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v3 6/6] selftests/bpf: Add tests for the new type-tag based __arena identifier
Date: Mon,  1 Jun 2026 20:41:20 -0400
Message-ID: <20260602004120.17087-7-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602004120.17087-1-emil@etsalapatis.com>
References: <20260602004120.17087-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests that combine the new type-based __arena identifier with
the volatile qualifier both in functions' arguments and return values.
This way we test both that they are recognized as arena arguments and
that they are not sensitive to the position they are placed in the type
compared to other qualifiers.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../selftests/bpf/progs/verifier_arena.c      | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index 89d72c8d756a..df0e22d1a29b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -607,4 +607,71 @@ int non_arena_ptr_add_to_arena_ptr(void *ctx)
 
 #endif
 
+static __noinline
+u32 __arena *check_arena_arg_nonglobal(u32 __arena *arg)
+{
+	volatile u32 val = *arg;
+
+	*arg = val + 1;
+
+	return arg;
+}
+
+__weak
+u32 __arena *check_arena_arg_global(u32 __arena *arg)
+{
+	volatile u32 val = *arg;
+
+	*arg = val + 1;
+
+	return arg;
+}
+
+__weak
+u32 volatile __arena *check_arena_arg_quals1(u32 volatile __arena *arg1, u32 __arena volatile *arg2)
+{
+	*arg1 = *arg1 + 1;
+	*arg2 = *arg1 + 1;
+
+	return arg2;
+}
+
+__weak
+u32 __arena volatile *check_arena_arg_quals2(u32 volatile __arena *arg1, u32 __arena volatile *arg2)
+{
+	*arg1 = *arg1 + 1;
+	*arg2 = *arg2 + 1;
+
+	return arg2;
+}
+
+SEC("syscall")
+__success __retval(0)
+int check_arena_arg_ret(void *ctx)
+{
+	u32 __arena *page = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	u32 __arena *arg = page;
+	u32 __arena volatile *arg1;
+	u32 __arena volatile *ret1;
+	u32 volatile __arena *arg2;
+	u32 volatile __arena *ret2;
+
+	if (!arg)
+		return 1;
+
+	/* Make sure we use {arg, ret}{1, 2}. */
+
+	arg = check_arena_arg_nonglobal(page);
+	arg = check_arena_arg_global(arg);
+
+	arg1 = arg2 = page;
+	ret1 = check_arena_arg_quals1(arg1, arg2);
+	ret2 = check_arena_arg_quals2(arg1, arg2);
+
+	if (!(*ret1 ||*ret2))
+		return -EINVAL;
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.54.0

