Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA7133893D
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780674826; cv=none; b=elGa7cqr4s2O3fKw1E8oVduLA320dp5HNjCEi0U+og8+TSr5j6G8JFim3zZzbtVKt4NSVUmyYWQ6umyu3zF1MGBJ5LWiGsv7yINJeQfBg3ChBru+Xo5ouUzCZ/9gdt/Igpd0slsnM9KotjThfS+utu9BpIOUu6RFr8Sl08OwV2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780674826; c=relaxed/simple;
	bh=/eRNs/ogIIaKVyWyFlMBj4uvfykEa3kuZQ9piENK1HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2RwmDwfv9G3aRxgnWMkTH3QgrH9y/8WtjaGM7KRPfDQj0jVNkE0DRp9HMz+CJ2loTGPqHZ1U59jubUHdO46rzCUi16hp3tT1eUJ/6X3NLqyUun9wRIOPrV92AXkBS9FnVJBVbiZkKRasKUHe2j5D2cdeIc7YcIjrQvGClm2jPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FUelMOxN; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FUelMOxN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780674823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ejoApRDr1nYqC2TLGz3CjwySzcrXPnhgjJK5sQw/7I4=;
	b=FUelMOxNDA3Vxtz4qala2bE3P46Zz15ScWMTqktSjNIU8QCbS5bGc6M25DZl1p3M4RnpUg
	uyw9gRHcMNJnqLK1nZEzq4+JWmHc6f+ME0dEPF3EasaVnjg+x9y983D5sMw+IVXXpbC70V
	wD/Mj8D32JXhPQsyrmt0bYSaKpelZEA=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Yuyang Huang <yuyanghuang@google.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com,
	Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 1/3] bpf: Check tail zero of bpf_map_info
Date: Fri,  5 Jun 2026 23:52:47 +0800
Message-ID: <20260605155249.20772-2-leon.hwang@linux.dev>
In-Reply-To: <20260605155249.20772-1-leon.hwang@linux.dev>
References: <20260605155249.20772-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Since there're 4 bytes padding at the end of struct bpf_map_info, they
won't be checked by bpf_check_uarg_tail_zero().

pahole -C bpf_map_info ./vmlinux
struct bpf_map_info {
	...
	__u64                      hash __attribute__((__aligned__(8))); /*    88     8 */
	__u32                      hash_size;            /*    96     4 */

	/* size: 104, cachelines: 2, members: 18 */
	/* padding: 4 */
	/* forced alignments: 1 */
	/* last cacheline: 40 bytes */
} __attribute__((__aligned__(8)));

If a future kernel extension adds a new 4-byte field, older userspace
programs allocating this structure on the stack might inadvertently pass
uninitialized stack garbage into the new field, permanently breaking
backward compatibility. -- sashiko [1]

Fix it by changing sizeof(info) to
offsetofend(struct bpf_map_info, hash_size).

And, add "__u32 :32" to the tail of struct bpf_map_info.

[1] https://lore.kernel.org/bpf/20260513224823.6494FC19425@smtp.kernel.org/

Fixes: ea2e6467ac36 ("bpf: Return hashes of maps in BPF_OBJ_GET_INFO_BY_FD")
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/uapi/linux/bpf.h       | 1 +
 kernel/bpf/syscall.c           | 5 +++--
 tools/include/uapi/linux/bpf.h | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index bed9b1b4d5ef..e1730f449d9e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6733,6 +6733,7 @@ struct bpf_map_info {
 	__u64 map_extra;
 	__aligned_u64 hash;
 	__u32 hash_size;
+	__u32 :32;
 } __attribute__((aligned(8)));
 
 struct bpf_btf_info {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 31a3b70a0b5d..89f020a44fc9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5406,10 +5406,11 @@ static int bpf_map_get_info_by_fd(struct file *file,
 {
 	struct bpf_map_info __user *uinfo = u64_to_user_ptr(attr->info.info);
 	struct bpf_map_info info;
-	u32 info_len = attr->info.info_len;
+	u32 info_len = attr->info.info_len, len;
 	int err;
 
-	err = bpf_check_uarg_tail_zero(USER_BPFPTR(uinfo), sizeof(info), info_len);
+	len = offsetofend(struct bpf_map_info, hash_size);
+	err = bpf_check_uarg_tail_zero(USER_BPFPTR(uinfo), len, info_len);
 	if (err)
 		return err;
 	info_len = min_t(u32, sizeof(info), info_len);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7d0b282ba674..7caf667e86fe 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6733,6 +6733,7 @@ struct bpf_map_info {
 	__u64 map_extra;
 	__aligned_u64 hash;
 	__u32 hash_size;
+	__u32 :32;
 } __attribute__((aligned(8)));
 
 struct bpf_btf_info {
-- 
2.54.0

