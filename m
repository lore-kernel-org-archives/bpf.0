Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793792282;
	b=COVI0doK8sD5SfK/Anws+X0I2VdQA4TdIQZ0yS0MdKyfBqsvwgfP8IfCaQacBS3EfTih
	 Chr6DDfMg980N29Pr4KWEQieAHjou5hONzxTIZG6YdZ2OHDrxlnPyAzEfjGTDLZaxsWTe
	 0LjVnmU2zYbEVuvhWB18y7wm4DqgAFKSZo+SFj46TuT5UDzEAlQt/hRYowFV0ulnZGbfr
	 kKk8inVbv/bDtip/CqL9t96uQls6CI7ROABl2KfLqtN82fHnBSWxyww/D5mEGZH33XL9t
	 hfOD5rVpeq/Yt3GzmQJguzvz/aPFnYmTCOqITkINNf2SyzTgrJUXTIt3dDYWxL+6xCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792282;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LC6o94h33PMpBSRX2oT9zIzB0iubJnPS2+w0Nf9vLoM=;
	b=idvptYh8Mqfb2+LZdfjkrd3uNI2kG8APHSQz8h+UslDmjqrA9u8yZjyklX3kksdto9T4
	 b9wCw9tvwUGe0jY+McytukyiYbYklCbtvoKvzpQfhbEb8+IjMYSFdWfiop8GcQklsEdA1
	 Vq2+l7QuTNcxYmjeIX1KQ8ySi/o5Jxybaogi79UigGT3DFSnxLVcLgLakq3am40SiitFx
	 yOmlVQtaMMmji4fQBahUQW+H1cOw2P6M9957J3kyIUcasnPWXBFMXQ6a/wlyYEorxT6L0
	 Ia266j30s26zXAH/E9aVVqnsSIPTnWkN9Krfa7GWd7gHYVDjSVy/kFj6c/PgOPd8TWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UC6X/1jn";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23450606D803;
	Wed,  4 Nov 2026 11:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UC6X/1jn
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793792281;
	b=s4xEzx4PNDVgcIK/2w/pqnPsK6PehLv+WfMBJx26MPTUdB25B1C7pF481XMU6LS7UE+J
	 vkvREbAr3LHNaTvojOxSwglwsAIrD+o2TdjEOf5eYy2RoxpCiTWSsWwSmvmw9ErPyaX2Z
	 8Hc+WB3enCPGWIf0zd/FRBGQ/nFDYgM+6Wuo+zmzcNz9ylvq80SuzXGiNLt7yRJCvcM2E
	 qIJntiSVJXl0wtUkbVEkeVMwd8AHUlbg4RiGNZvAA7sf//jqXF98cWw/DkIXzmOy0RvmU
	 x2bkvdJjg3BODafhaZVUnGdUAenqnPJdsFEiZzXTJeqEC56Y1WtbatyKBpmRtdPhusg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793792281;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=LC6o94h33PMpBSRX2oT9zIzB0iubJnPS2+w0Nf9vLoM=;
	b=URTvLy8t6QnwDT2GxSAb2JzYeuUWFbMq/rTBOJv5srPLbmyveYh8QadlCvNp/jlIfbeG
	 NgZhrPfPN9XSnrX3UX6AqZZLlxExhESk+RsEKUPcv5Z/7XVwCTjGT/+gzoSPcaMcDddgT
	 iBpNgxijnAjcgLq+7sL+y2H4M/kW1nxcCgCOS7ScOWjn6aVm5XtbtEYN+Z3s4SnjkneDj
	 PS80/OXor0OxAEPkqds5n9H56BQwGmIG6pdcqMS56Ol6LUjoQfzxdqRQu9mvU8r4wHqR9
	 FrMgwjazgxe6M3gsDChQsEaoPpLnsQfB9RLPk63nr3p4iAP6hhQQyElderJjm7lpd3w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A5FB71F0093A;
	Wed,  4 Nov 2026 11:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793792281;
	bh=LC6o94h33PMpBSRX2oT9zIzB0iubJnPS2+w0Nf9vLoM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=UC6X/1jnj0FBJzHgDXczgjhxylwC36AVJd0eP0+9P7HGvyBdEcG5ypnEK8neLXk/p
	 zItQtP6Br1ixCJ8cbt1aTrWNRouchiEjozPKPKyWWVraz74JLi06NE/udio3A1rc4s
	 NMeiS1fBO+ac5kRgLZccXMpO5bsj9POdgQPTKPJ050KKcWG7K4QFSrFvM5GCLm8viW
	 4qsSSYd6qP9M8LADnJFM79Zv4iTYKfcwl14iTFOYcOuUzIjU/xgylSSPm70wPouiSK
	 dT33cZSDjCAu/19KYk/DgSHxJQ5G17ChaI6vi6aa+0xXeLXlRbxWo0XL1xSHkUBnMC
	 LiB10kWWBkWXQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1DC5746DF3;
	Wed,  4 Nov 2026 11:38:00 +0000 (UTC)
From: Jonathan Bastari Thamrin via B4 Relay <devnull+thamrinjonathan.gmail.com@kernel.org>
Date: Wed, 04 Nov 2026 18:37:58 +0700
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test local storage max value
 size
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261104-local-storage-max-v1-2-c836731bd184@gmail.com>
References: <20261104-local-storage-max-v1-0-c836731bd184@gmail.com>
In-Reply-To: <20261104-local-storage-max-v1-0-c836731bd184@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Amery Hung <ameryhung@gmail.com>, 
 Slava Imameev <slava.imameev@crowdstrike.com>, 
 Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793792278; l=3581;
 i=thamrinjonathan@gmail.com; s=20261102; h=from:subject:message-id;
 bh=sbS2w6xefcyYIn4G7cqCv6ZgI7XpeANsGRjBwSGkGqU=;
 b=rQNa/Dfm/Af0QN97+0IUJCG2LTuk806TrnWh4gLHs4MVZbOhOj4RJN8w/7QgzeYew77aLlQPF
 kYTu0cA8q9fCKNr6Vm+AFguOlIPuDj7IYejHwIMbyRCNFfTsEYdjb4y
X-Developer-Key: i=thamrinjonathan@gmail.com; a=ed25519;
 pk=mr0q5PZVaUIrv8WvTxIfK7QVcAiRSYI8hOByBQL1ZRo=
X-Endpoint-Received: by B4 Relay for thamrinjonathan@gmail.com/20261102
 with auth_id=1383
X-Original-From: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
Reply-To: thamrinjonathan@gmail.com
Content-Transfer-Encoding: 7bit

From: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>

Add a test that finds the largest value size accepted for a task
storage map using binary search, then checks that a value of this
size can be stored. It also checks the size is >=4096 to make sure
the limit is not set too low. This test fails without the previous
patch with ENOMEM.

Signed-off-by: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
---
 .../selftests/bpf/prog_tests/task_local_storage.c  | 87 ++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index 5b2b56cc3a4f..c7e9fa6743b9 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -495,6 +495,91 @@ static void test_uptr_map_failure(const char *map_name, int expected_errno)
 	uptr_map_failure__destroy(skel);
 }
 
+static int create_task_storage_map(__u32 value_size)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, create_attr);
+	struct btf *btf;
+	int int_id, char_id, arr_id, err, saved_errno;
+	int map_fd = -1;
+
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "btf__new"))
+		goto done;
+
+	int_id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
+	char_id = btf__add_int(btf, "char", 1, 0);
+	arr_id = btf__add_array(btf, int_id, char_id, value_size);
+	err = btf__load_into_kernel(btf);
+	if (!ASSERT_OK(err, "btf__load_into_kernel"))
+		goto done;
+
+	create_attr.map_flags = BPF_F_NO_PREALLOC;
+	create_attr.btf_fd = btf__fd(btf);
+	create_attr.btf_key_type_id = int_id;
+	create_attr.btf_value_type_id = arr_id;
+	map_fd = bpf_map_create(BPF_MAP_TYPE_TASK_STORAGE, "big_ls_map",
+				sizeof(int), value_size, 0, &create_attr);
+
+done:
+	saved_errno = errno;
+	btf__free(btf);
+	errno = saved_errno;
+	return map_fd;
+}
+
+/* Return the largest value_size the kernel accepts for a local storage
+ * map, or -1 on an unexpected error.
+ */
+static int find_max_value_size(void)
+{
+	int lo = 1, hi = 65535, mid, map_fd;
+
+	while (lo < hi) {
+		mid = lo + (hi - lo + 1) / 2;
+
+		map_fd = create_task_storage_map(mid);
+		if (map_fd >= 0) {
+			close(map_fd);
+			lo = mid;
+		} else {
+			if (!ASSERT_EQ(errno, E2BIG, "create_task_storage_map errno"))
+				return -1;
+			hi = mid - 1;
+		}
+	}
+	return lo;
+}
+
+static void test_local_storage_max_value_size(void)
+{
+	int map_fd, task_fd = -1, max_size, err;
+	void *buf = NULL;
+
+	max_size = find_max_value_size();
+	if (!ASSERT_GE(max_size, 4096, "find_max_value_size"))
+		return;
+
+	map_fd = create_task_storage_map(max_size);
+	if (!ASSERT_OK_FD(map_fd, "create_task_storage_map"))
+		return;
+
+	task_fd = sys_pidfd_open(getpid(), 0);
+	if (!ASSERT_OK_FD(task_fd, "sys_pidfd_open"))
+		goto out;
+
+	buf = calloc(1, max_size);
+	if (!ASSERT_OK_PTR(buf, "calloc"))
+		goto out;
+	err = bpf_map_update_elem(map_fd, &task_fd, buf, 0);
+	ASSERT_OK(err, "bpf_map_update_elem");
+
+out:
+	free(buf);
+	if (task_fd >= 0)
+		close(task_fd);
+	close(map_fd);
+}
+
 void test_task_local_storage(void)
 {
 	if (test__start_subtest("sys_enter_exit"))
@@ -521,5 +606,7 @@ void test_task_local_storage(void)
 		test_uptr_map_failure("empty_uptr_map", EINVAL);
 	if (test__start_subtest("uptr_map_failure_kstruct"))
 		test_uptr_map_failure("kstruct_uptr_map", EINVAL);
+	if (test__start_subtest("local_storage_max_value_size"))
+		test_local_storage_max_value_size();
 	RUN_TESTS(uptr_failure);
 }

-- 
2.56.0


