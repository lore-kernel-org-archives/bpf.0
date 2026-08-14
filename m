Received: from mta1.migadu.com (out-152.mta1.migadu.com [95.215.58.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427863F823B
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786728791; cv=none; b=uGQT6/ymG3imLlROMPaCSsrBGq0LK8mzdSEHI1AswMAQ4covRs+XI+nIsOctHDZQQwBrRcUu8M9/c2XEcDOMqvHHOZd758cPmIX5uKhu6At9vX29uNFHEvqEcpehINv0LdwaPzt6aODszjGgrp5MO6OFmk7JoFsKVA/qETmw6GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786728791; c=relaxed/simple;
	bh=X/Wf08dMIeGqoZzDfSAheCpZcEAqUr9lovxr1cZYSCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ou+fVA99rwTyFj+XtZK0BoffGne0QIRdZkCLlEDWf9AUZlPBVlu1cpfUwP7W6YxcOSRYaXjUcbw89FPS8VlyldGUt3kudhdImQlaRndVWQUELa99MN9u3XjwKiK8pT2V0ZOYCnAnf4ddh5kSFFov0n1Kmq62iwaF6yo+DUPSJ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YT8VHQUh; arc=none smtp.client-ip=95.215.58.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YT8VHQUh"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=X/Wf08dMIeGqoZzDfSAheCpZcEAqUr9lovxr1cZYSCE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786728788; v=1; x=1787333588;
 b=YT8VHQUhLFvVy8m9XeNPpDFXwmp7uKNE/bXYfY6tI3tjkUITINU/0dkLRp8vxVdjuFU7MY0M
 xassRJii8s+2cfs5Kn7ON7Ss1uYZjtnuhjEC1gyEJ4s+1rOphpWTAw3hYT2UftBTHHDcT1wHiYs
 rMFmhDkdGbphy2PKVfvIWsyo=
X-Envelope-To: bpf@vger.kernel.org
Received: from .linux.dev (117.20.149.103)
	by smtp.migadu.com with ESMTPS id fcea059e5b30813f;
	Fri, 14 Aug 2026 17:33:08 +0000
X-Migadu-Flow: FLOW_OUT
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
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 5/5] selftests/bpf: Improve readability in iter test for percpu data
Date: Sat, 15 Aug 2026 01:32:06 +0800
Message-ID: <20260814173206.93082-6-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814173206.93082-1-leon.hwang@linux.dev>
References: <20260814173206.93082-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original 'offsetof()' + offset is equal to the new 'offsetof()'. Use
the new 'offsetof()' instead.

Rename two variables btw:

* offsetof_num -> num_off
* percpu_data_sum -> sum

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/global_data_init.c   | 6 +++---
 tools/testing/selftests/bpf/progs/test_global_percpu_data.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
index 2f0dbeb88934..c6d055b9457d 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
@@ -348,8 +348,8 @@ static void test_global_percpu_data_iter(void)
 		return;
 
 	skel->rodata->num_cpus = num_cpus;
-	skel->rodata->offsetof_num = offsetof(struct test_global_percpu_data__percpu, struct_data);
-	skel->rodata->offsetof_num += sizeof(skel->percpu->struct_data) - sizeof(int);
+	skel->rodata->num_off = offsetof(struct test_global_percpu_data__percpu,
+					 struct_data.nums[6]);
 	skel->rodata->elem_sz = roundup(sizeof(struct test_global_percpu_data__percpu), 8);
 	skel->percpu->struct_data.nums[6] = 0xc0de;
 
@@ -372,7 +372,7 @@ static void test_global_percpu_data_iter(void)
 		do { } while (0);
 	ASSERT_EQ(len, 0, "read iter");
 	ASSERT_TRUE(skel->bss->run_iter, "run_iter");
-	ASSERT_EQ(skel->bss->percpu_data_sum, 0xc0de * num_cpus, "percpu_data_sum");
+	ASSERT_EQ(skel->bss->sum, 0xc0de * num_cpus, "sum");
 
 	close(fd);
 out:
diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
index 12556590b647..175c44000753 100644
--- a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
+++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
@@ -64,9 +64,9 @@ int verifier_snprintf(void *ctx)
 }
 
 volatile const __u32 num_cpus = 0;
-volatile const int offsetof_num;
+volatile const int num_off;
 volatile const int elem_sz;
-__u32 percpu_data_sum = 0;
+__u32 sum = 0;
 bool run_iter = false;
 
 SEC("iter/bpf_map_elem")
@@ -82,7 +82,7 @@ int dump_percpu_data(struct bpf_iter__bpf_map_elem *ctx)
 	run_iter = true;
 
 	for (i = 0; i < num_cpus; i++) {
-		percpu_data_sum += *(int *) (pptr + offsetof_num);
+		sum += *(int *) (pptr + num_off);
 		pptr += elem_sz;
 	}
 	return 0;
-- 
2.55.0

