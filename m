Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3DB37D10E;
	Sun, 26 Jul 2026 15:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785081108; cv=none; b=eMwtVYWrQYHnRR8OekGHA1urmeyIg7DTw+Nhq1LVlkdyCLR0yldC6lHUEQ5ir10tZqykLJPGxR3SSt/+wbJpwWGDb6oV8NENXa5tThlbnlDkTkwj6sXysTg96zSuUr8zveQhr/gCrv+Iqf14ZN6JDzgapB63cPThj4T54xowgsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785081108; c=relaxed/simple;
	bh=wVu5+AybVkKW/ekXTHFNcvKrI1dt3s36wepGDW/Angw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RB0Be758sE/kB4XkOq/HsTdQ1zZ5g/kgoaIR638UW1UzHmqunJsvQ9AdkE5qJJnorYS7Hv+5nTQjjf3/NwZ+4LbTkdlQWlrGlqQrpNm0Pn2qliMcuetNVqcE1wEmODRYa8sMxDR130NvTKXF7tjPcwIfTz1jnGE0m3AbcW0uIFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=mBN/oNnB; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="mBN/oNnB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=YOHUbWsqlHTmdywBtUx1iov15YH5r4+
	SYDS+MiM8TVQ=; b=mBN/oNnBVODgQhFFbx1sIK/xkbhbhk5GGNToEnQC+JYLSJV
	TTj71HlGjsS2y/BD0gax7bN0bD1KtYAOEW8P3dP9yZ2L5SVGOLM0zKTUQ5Rp0g3f
	Jw6EwAfwCN8X2muXAyg8cmFUwOHSAlyc4g6yB57wCKRGpjwLvaf7FILw8SC8=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web1 (Coremail) with SMTP id yAQGZQDXcsL_LGZqS_CgAA--.34846S4;
	Sun, 26 Jul 2026 23:51:28 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Sun, 26 Jul 2026 23:51:18 +0800
Subject: [PATCH bpf-next 2/2] selftests/bpf: Cover RHash special-field
 recycle
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260726-f01-23-rhash-cancel-bpf-next-v1-2-6e5e1131d885@mails.tsinghua.edu.cn>
References: <20260726-f01-23-rhash-cancel-bpf-next-v1-0-6e5e1131d885@mails.tsinghua.edu.cn>
In-Reply-To: <20260726-f01-23-rhash-cancel-bpf-next-v1-0-6e5e1131d885@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Mykyta Yatsenko <yatsenko@meta.com>, Shuah Khan <shuah@kernel.org>, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785081088; l=3390;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=wVu5+AybVkKW/ekXTHFNcvKrI1dt3s36wepGDW/Angw=;
 b=2PmZY17KXHwpGIdQBqX3cKhibij51WpLNFBRhtmqBeVvc4flNosEJwQ2m7U34kSIsC2bXUwM1
 25Dli46m4EEAwqCbK/HszLs9W+mBHZ5F5jEviU+bejwnfy6rghy8TOq
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:yAQGZQDXcsL_LGZqS_CgAA--.34846S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAFyfJFW7urWxJr1UZrykuFg_yoW5uw43pa
	y8Xw15Kr18KFnIgr1fGw4xuF1Sgr1v9FW8tr93Kr9akrs5Jry0qw1xK3WUtr1fArZYgF9I
	vw1I9rW3CF4UCrDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBS1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r1Y6r17M2vYz4IE04k24VAvwV
	AKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6x8ErcxFaVAv8VW8Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrw
	ACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wrylc2xSY4AK67AK6ryrMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_GrWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
	Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5yxRUUUUU
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQEAA2plNzTZTQABsa

Add regression coverage for RHash value recycling with referenced kptrs.

Store a referenced task kptr and update the value with BPF_EXIST. Verify
that bpf_kptr_xchg() still returns the kptr. Then store another task kptr
and delete the element to exercise the delayed reclamation path.

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 tools/testing/selftests/bpf/prog_tests/rhash.c |  3 +
 tools/testing/selftests/bpf/progs/rhash.c      | 81 ++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/rhash.c b/tools/testing/selftests/bpf/prog_tests/rhash.c
index 98bb66907b7f..5bf2de828361 100644
--- a/tools/testing/selftests/bpf/prog_tests/rhash.c
+++ b/tools/testing/selftests/bpf/prog_tests/rhash.c
@@ -180,4 +180,7 @@ void test_rhash(void)
 
 	if (test__start_subtest("test_rhash_iter"))
 		rhash_iter_test();
+
+	if (test__start_subtest("test_rhash_special_fields_recycle"))
+		rhash_run("test_rhash_special_fields_recycle");
 }
diff --git a/tools/testing/selftests/bpf/progs/rhash.c b/tools/testing/selftests/bpf/progs/rhash.c
index fc2dac3a719e..d28d115cb74e 100644
--- a/tools/testing/selftests/bpf/progs/rhash.c
+++ b/tools/testing/selftests/bpf/progs/rhash.c
@@ -19,6 +19,11 @@ struct elem {
 	int val;
 };
 
+struct special_elem {
+	struct task_struct __kptr * task;
+	int val;
+};
+
 struct {
 	__uint(type, BPF_MAP_TYPE_RHASH);
 	__uint(map_flags, BPF_F_NO_PREALLOC);
@@ -27,6 +32,17 @@ struct {
 	__type(value, struct elem);
 } rhmap SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_RHASH);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__uint(max_entries, 4);
+	__type(key, int);
+	__type(value, struct special_elem);
+} special_fields SEC(".maps");
+
+struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+
 SEC("syscall")
 int test_rhash_lookup_update(void *ctx)
 {
@@ -246,3 +262,68 @@ int test_rhash_delete_nonexistent(void *ctx)
 	err = 0;
 	return 0;
 }
+
+SEC("syscall")
+int test_rhash_special_fields_recycle(void *ctx)
+{
+	struct special_elem val1 = { .val = 1 };
+	struct special_elem val2 = { .val = 2 };
+	struct task_struct *task, *old;
+	struct special_elem *elem;
+	int key = 0;
+
+	err = 1;
+	if (bpf_map_update_elem(&special_fields, &key, &val1, BPF_NOEXIST))
+		return 1;
+
+	err = 2;
+	elem = bpf_map_lookup_elem(&special_fields, &key);
+	if (!elem)
+		return 2;
+
+	err = 3;
+	task = bpf_task_acquire(bpf_get_current_task_btf());
+	if (!task)
+		return 3;
+
+	err = 4;
+	old = bpf_kptr_xchg(&elem->task, task);
+	if (old) {
+		bpf_task_release(old);
+		return 4;
+	}
+
+	err = 5;
+	if (bpf_map_update_elem(&special_fields, &key, &val2, BPF_EXIST))
+		return 5;
+
+	err = 6;
+	elem = bpf_map_lookup_elem(&special_fields, &key);
+	if (!elem)
+		return 6;
+
+	err = 7;
+	task = bpf_kptr_xchg(&elem->task, NULL);
+	if (!task)
+		return 7;
+	bpf_task_release(task);
+
+	err = 8;
+	task = bpf_task_acquire(bpf_get_current_task_btf());
+	if (!task)
+		return 8;
+
+	err = 9;
+	old = bpf_kptr_xchg(&elem->task, task);
+	if (old) {
+		bpf_task_release(old);
+		return 9;
+	}
+
+	err = 10;
+	if (bpf_map_delete_elem(&special_fields, &key))
+		return 10;
+
+	err = 0;
+	return 0;
+}

-- 
2.34.1

