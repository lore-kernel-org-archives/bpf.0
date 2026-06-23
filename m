Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578752F7F1B;
	Tue, 23 Jun 2026 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236087; cv=none; b=UkaJfKKe7kDrV8jeZ9IdMBjac5JYlHEbOvu0zATkZ3zSBE5NDDFBRcTHsAfSE9nIYPdTCy5HwcISagpkY7HOJn73NiyLB/RBjvkgNwJD715FJ0iOJnGLydz+T4Pz7s1UgeCuimG7olgzSqYPPwDMLm4bUtZCcard9uWwnlEsO/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236087; c=relaxed/simple;
	bh=X0mL+MCWFGQ8o3bjWYJPdAks9bEruodMkT8VS1n2P7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jbeKPox7kGIlapmpP7VsmJ+R7XBoUhZbDrMO8hPmCxbQXb46b/R2CQv4LTWyGl7tentQVGsTtZGeILCjoh7W9/sBNAUTjky8xQPNDpjq/jo3U6vrF2Qhg3wBqLNj9oFMdorD8edmIcgpvWlaniLiro51MU2EKegDZnukGOGIFeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=Awj3WMhF; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="Awj3WMhF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=UfDTMYjnftXRRhLuKDKW3+ZZLn8Bg6qoGh
	/+Kq2sSmI=; b=Awj3WMhFgmjJT7oC9/3PMFu43EG66ofusgVlQ78SAVHxDqDPLR
	G340vmzdbiBKCQVN46aQCbuLilZd3JefR3beNeS2OXhbv6u5PLap5ym1F6h4D8QC
	78AlUdiyXzKGofyDfmoQ7KV7H1f/j9uwmHUwLwgPwK9/EI0b2KL5OGjGs=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web2 (Coremail) with SMTP id yQQGZQBnP5eYwzpqIo19Ag--.49585S4;
	Wed, 24 Jun 2026 01:34:38 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Cover MEM_ALLOC access past object bounds
Date: Tue, 23 Jun 2026 17:34:13 +0000
Message-Id: <db76fcbfb38f2baa03f9a06efbdc2ad74df872b6.1782197377.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782197377.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1782197377.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yQQGZQBnP5eYwzpqIo19Ag--.49585S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyxuFykCw4rZF1fuF17Jrb_yoW5JFy5p3
	WkK34Yya4fKr42qF9xWF47Wr4rWa1vqrySy345CryUAr43XryDXr4xWFW0vF1fArZa9rn3
	Za4IgF9xWr4UJ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4U
	JwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
	AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
	IFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_
	GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUznQUUUUUU=
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

Add a linked_list negative loader case for a program-BTF type whose last
member is a zero-length flexible array. The program writes through the
first flexible-array element of an object allocated by bpf_obj_new().

The verifier should reject the access when the BTF walk reaches beyond the
static size of the allocated object.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 .../selftests/bpf/prog_tests/linked_list.c    |  1 +
 .../selftests/bpf/progs/linked_list_fail.c    | 23 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/testing/selftests/bpf/prog_tests/linked_list.c
index 8defea025..c3d133c6a 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -68,6 +68,7 @@ static struct {
 	{ "obj_type_id_oor", "local type ID argument must be in range [0, U32_MAX]" },
 	{ "obj_new_no_composite", "bpf_obj_new/bpf_percpu_obj_new type ID argument must be of a struct" },
 	{ "obj_new_no_struct", "bpf_obj_new/bpf_percpu_obj_new type ID argument must be of a struct" },
+	{ "obj_new_flex_array", "access beyond struct obj_new_flex" },
 	{ "obj_drop_non_zero_off", "R1 must have zero offset when passed to release func" },
 	{ "new_null_ret", "R0 invalid mem access 'ptr_or_null_'" },
 	{ "obj_new_acq", "Unreleased reference id=" },
diff --git a/tools/testing/selftests/bpf/progs/linked_list_fail.c b/tools/testing/selftests/bpf/progs/linked_list_fail.c
index ddd26d1a0..031e77a28 100644
--- a/tools/testing/selftests/bpf/progs/linked_list_fail.c
+++ b/tools/testing/selftests/bpf/progs/linked_list_fail.c
@@ -167,6 +167,16 @@ CHECK_OP(push_back);
 #undef CHECK_OP
 #undef INIT
 
+struct obj_new_flex_elem {
+	int lo;
+	int hi;
+};
+
+struct obj_new_flex {
+	int hdr;
+	struct obj_new_flex_elem cells[];
+};
+
 SEC("?kprobe/xyz")
 int map_compat_kprobe(void *ctx)
 {
@@ -230,6 +240,19 @@ int obj_new_no_struct(void *ctx)
 	return 0;
 }
 
+SEC("?tc")
+int obj_new_flex_array(void *ctx)
+{
+	struct obj_new_flex *p;
+
+	p = bpf_obj_new_impl(bpf_core_type_id_local(struct obj_new_flex), NULL);
+	if (!p)
+		return 0;
+	p->cells[0].hi = 42;
+	bpf_obj_drop_impl(p, NULL);
+	return 0;
+}
+
 SEC("?tc")
 int obj_drop_non_zero_off(void *ctx)
 {
-- 
2.34.1

