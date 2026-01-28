Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A182368291
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769612612; cv=none; b=KMbojulci+VNXCREKG/OZJ7n1JGDLNDZVNeoD9rCs3+1zjFADopMUSRGbkERHKgSeGCupHh0pJWzmU0P5pV1IM2XqbFE8F0KsFZRSkmv7Q7Uqvnd5CCh6Dh9SZUPIyIdztjozORvENSi06cTPAFNChY66BXvhKoXkIAj8y3N1Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769612612; c=relaxed/simple;
	bh=OWA1YjMlbP6yBecEmzg+WV4nt0CAwrahfMEwVc/TD8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dee/FJ0d3EWV3Wu1ajV5thppJrAviV8ufo7PFS6J1/rauaE+h7YWpNxxYTFHDev88xoiHNHtNXVVTbRK6W4RD9vayEfl2FhOSHf7LfpxYW8TqlZeBOIBP7UDreB14xwByZuDCIgpyRp4Viy4Dh1gW8quAIk+rHoYHlMczW2AQdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YgizllKU; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YgizllKU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769612587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oUoEHsnonw/X1gF+pNDCWHBKb2h1ueBFFTn7C++64W4=;
	b=YgizllKUStdsTkFhhKJFPYu0nNN1z0IDe5B1HoMN0LGs9j4TgAOyi7gM58BHzMdIR1hbbA
	dETBH5RFRniJjqQvGRV711yH0D6LgaHhlrkB62suVi5UWFF7fl693EFQMmsih/cfX1b9Yz
	pbFoeZQmZ0L6KuE4wpIyHcLW416o3EQ=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v2 3/3] bpf/selftests: Enable get_func_args and get_func_ip tests on arm64
Date: Wed, 28 Jan 2026 23:01:12 +0800
Message-ID: <20260128150112.8873-4-leon.hwang@linux.dev>
In-Reply-To: <20260128150112.8873-1-leon.hwang@linux.dev>
References: <20260128150112.8873-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Allow get_func_args, and get_func_ip selftests to run on arm64.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/testing/selftests/bpf/progs/get_func_args_test.c | 2 +-
 tools/testing/selftests/bpf/progs/get_func_ip_test.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/get_func_args_test.c b/tools/testing/selftests/bpf/progs/get_func_args_test.c
index 0a3236a7a109..180ba5098ca1 100644
--- a/tools/testing/selftests/bpf/progs/get_func_args_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_args_test.c
@@ -167,7 +167,7 @@ int BPF_PROG(tp_test2)
 }
 
 __u64 test7_result = 0;
-#ifdef __TARGET_ARCH_x86
+#if defined(bpf_target_x86) || defined(bpf_target_arm64)
 SEC("fsession/bpf_fentry_test1")
 int BPF_PROG(test7)
 {
diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
index 65f7e1f182bf..43ff836a8ed8 100644
--- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
@@ -106,7 +106,7 @@ int BPF_URETPROBE(test8, int ret)
 
 __u64 test9_entry_result = 0;
 __u64 test9_exit_result = 0;
-#ifdef __TARGET_ARCH_x86
+#if defined(bpf_target_x86) || defined(bpf_target_arm64)
 SEC("fsession/bpf_fentry_test1")
 int BPF_PROG(test9, int a)
 {
-- 
2.52.0

