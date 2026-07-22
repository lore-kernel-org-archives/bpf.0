Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C1336DA03
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733608; cv=none; b=qQD9lx0aUnesX0PLTjmgNTRVUmcWAVPsF0J+p0EZ2WgI885ueYgiBr0dChwpxs57uy+2ie3BJu1ChRc4kMyQeXbQFo/bUEmd2c2X8bb2bjJi/aLnCquqI+oKFDY2/sU5qcwuZSHoLqCfsF9jQUHMWWe4St7OpqBJaT0PX3QuXwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733608; c=relaxed/simple;
	bh=AUK1CkpWB3YJ6nNShoGFre6CvyeNBldHZzibhJ/Kzeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFI2jf4ZChphuH11SBXzSgP5Tgfh1jHnXsXs59962WA2TqRnmB2+y6SW9WnrX//xohbLKyZVeoGbtdpdL3B0dQWAOmFX6dGYz4PDinySfK2Q39t5VIq9v4MLnJG1ODQAtAgD79w8B/eWpuuEXrwNDzf/CfsJk8y/cmhrYdGI9ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I4iVSPb+; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I4iVSPb+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784733600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bFhLnlSq59bbqBUiEsR5Lhpwh+Img+fmsgmvB5qeBwE=;
	b=I4iVSPb+soza6UkOzJZmzaLTqG5jkBczDdixfC/oNqLiS7N2yZfnRpTEOMxtjRfkgMePAU
	3k0G5dyoDgbZw9mb1bGlVuoodtecHvBFXovPq3qTmI6AHSAzt03Jhex6jnzLKMmknBAM7p
	Y3EHFDpQAKEuTy+rCjv9EMYYQjpRZNI=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Jingguo Tan <tanjingguo@huawei.com>,
	Pu Lehui <pulehui@huawei.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Lin Ma <malin89@huawei.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Verify no warning when close fexit link
Date: Wed, 22 Jul 2026 23:19:09 +0800
Message-ID: <20260722151909.69142-3-leon.hwang@linux.dev>
In-Reply-To: <20260722151909.69142-1-leon.hwang@linux.dev>
References: <20260722151909.69142-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a test to verify that there's no WARNING when detaching fexit link by
following the repro steps of previous commit.

Without the fix, the WARNING could be triggered by this test.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index c66037162da5..c5c9d6c359bb 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -13,6 +13,8 @@
 #include "tailcall_cgrp_storage.skel.h"
 #include "tailcall_sleepable.skel.h"
 #include "tailcall_callback.skel.h"
+#include "tailcall_bpf2bpf2.skel.h"
+#include "tailcall_bpf2bpf_fexit.skel.h"
 
 /* test_tailcall_1 checks basic functionality by patching multiple locations
  * in a single program for a single tail call slot with nop->jmp, jmp->nop
@@ -1907,6 +1909,50 @@ static void test_tailcall_callback(void)
 	RUN_TESTS(tailcall_callback);
 }
 
+static void test_tailcall_bpf2bpf_fexit_links(void)
+{
+	struct tailcall_bpf2bpf_fexit *skel1 = NULL, *skel2 = NULL;
+	struct tailcall_bpf2bpf2 *skel_tc;
+	int err, prog_fd;
+
+	skel_tc = tailcall_bpf2bpf2__open_and_load();
+	if (!ASSERT_OK_PTR(skel_tc, "tailcall_bpf2bpf2__open_and_load"))
+		return;
+
+	skel1 = tailcall_bpf2bpf_fexit__open();
+	if (!ASSERT_OK_PTR(skel1, "tailcall_bpf2bpf_fexit__open"))
+		goto out;
+
+	prog_fd = bpf_program__fd(skel_tc->progs.classifier_0);
+	err = bpf_program__set_attach_target(skel1->progs.fexit, prog_fd, "subprog_tail");
+	if (!ASSERT_OK(err, "bpf_program__set_attach_target"))
+		goto out;
+
+	err = tailcall_bpf2bpf_fexit__load(skel1);
+	if (!ASSERT_OK(err, "tailcall_bpf2bpf_fexit__load"))
+		goto out;
+
+	skel1->links.fexit = bpf_program__attach_trace(skel1->progs.fexit);
+	if (!ASSERT_OK_PTR(skel1->links.fexit, "bpf_program__attach_trace"))
+		goto out;
+
+	skel2 = tailcall_bpf2bpf_fexit__open();
+	if (!ASSERT_OK_PTR(skel2, "tailcall_bpf2bpf_fexit__open"))
+		goto out;
+
+	err = bpf_program__set_attach_target(skel2->progs.fexit, prog_fd, "subprog_tail");
+	if (!ASSERT_OK(err, "bpf_program__set_attach_target"))
+		goto out;
+
+	err = tailcall_bpf2bpf_fexit__load(skel2);
+	ASSERT_OK(err, "tailcall_bpf2bpf_fexit__load");
+
+out:
+	tailcall_bpf2bpf_fexit__destroy(skel1);
+	tailcall_bpf2bpf_fexit__destroy(skel2);
+	tailcall_bpf2bpf2__destroy(skel_tc);
+}
+
 void test_tailcalls(void)
 {
 	if (test__start_subtest("tailcall_1"))
@@ -1974,4 +2020,6 @@ void test_tailcalls(void)
 	if (test__start_subtest("tailcall_cgrp_storage_no_storage_bridge"))
 		test_tailcall_cgrp_storage_no_storage_bridge();
 	test_tailcall_callback();
+	if (test__start_subtest("tailcall_bpf2bpf_fexit_links"))
+		test_tailcall_bpf2bpf_fexit_links();
 }
-- 
2.55.0

