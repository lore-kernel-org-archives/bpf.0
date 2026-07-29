Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7346737B415
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 02:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785292207; cv=none; b=uh6Kybwh3ghbeU69oP69YWgvqO84BfWm7TOeYf8uxItpujqwa+McORdTWBZzz+84pqLKustqxx9BIqL2f0KQ1YCc1hsHnsxA3IdBaSltiNW5Ul0UhH7rn72APdQ859QM5fydYep2kwvsakEQ86JN+fB7B2rztqBxRNq/+jETLJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785292207; c=relaxed/simple;
	bh=tfibGxz0XJX6n44B08uCWbwXFGjI5QbiyI9apBrtUw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oTq0MpJpRK7muJ0mfnYBSolvU6RktQYU7+L37xNX8ArWEgA2tBefbqVXlX8P/D/dtVOCrZpaKifmuYE1MFI8TDxUVyqItZgxVgxvoSdJ4Eta4v7vMyH4M6X852FWHRGK8OY4Y+ULWapwJUL7KCrnVlr+7ChGiEQINQx3Ys5xD5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PzI9IsDN; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PzI9IsDN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785292204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qAASdMbAix766JMY6rGnTjUWgneduPNfJDipgEoCKMs=;
	b=PzI9IsDNMp1rUxhacYQ2Z/77IvpJbv/fK2JRjN44FdLIxhlUVPmNg6k54qtJD/0Qwld3xa
	1CddTkZWp5wsRnnO6xTfmpqsPEY8lK/9tw48paOQgJAE+eoyJDhMGMTml0JPiiOhRwYwDW
	giZ9gL7sS90JIBG51d8YYOkgppErphw=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yangtiezhu@loongson.cn
Cc: hengqi.chen@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH v4 3/4] selftests/bpf: Enable kptr_xchg_inline test on LoongArch
Date: Wed, 29 Jul 2026 10:28:36 +0800
Message-Id: <20260729022837.355549-4-chenguang.zhao@linux.dev>
In-Reply-To: <20260729022837.355549-1-chenguang.zhao@linux.dev>
References: <20260729022837.355549-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

Run the kptr_xchg_inline functional test on LoongArch64 now that the bpf
JIT can inline bpf_kptr_xchg() with correct memory ordering.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c b/tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c
index 7def158da9eb..1215d6edd590 100644
--- a/tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c
+++ b/tools/testing/selftests/bpf/prog_tests/kptr_xchg_inline.c
@@ -14,7 +14,8 @@ void test_kptr_xchg_inline(void)
 	int err;
 
 #if !(defined(__x86_64__) || defined(__aarch64__) || \
-      (defined(__riscv) && __riscv_xlen == 64))
+	(defined(__riscv) && __riscv_xlen == 64) || \
+	(defined(__loongarch__) && __loongarch_grlen == 64))
 	test__skip();
 	return;
 #endif
-- 
2.25.1

