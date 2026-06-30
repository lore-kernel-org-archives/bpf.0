Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE91F29B8CF;
	Tue, 30 Jun 2026 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782808943; cv=none; b=NWgPbFppnhMtQWcLMdO2LE1Azea2UJ9Z+cIOjFfEXkqqeLOjhxQ/eIaUxiDWmfAoDf3RZaUOyIXnHY9iOWuUEw2qlZoi3JnkebCX0PJFIDuqBFxK4x2MvITBTG9f4tmsBfDvfF53WV/cmC2SQhCtA2j2uNJ69HSlkoEGXKxuPXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782808943; c=relaxed/simple;
	bh=X0mL+MCWFGQ8o3bjWYJPdAks9bEruodMkT8VS1n2P7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XcqO7fAr6eGopxPtgZz/Lbkk9KV5z+Wh3CxRORjhR4eo5wnkBTNWLLTTXfWJg53RpIh+jDnHiaszVdOaC43suQAWpfm0aDaksGlQH7ia4STA4pwSTNZmhTXRJm/1Rbdp81cEbnIHaG9e6qeJytEVR2iGCtE4sTGYDNIBrbZTltg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=R/QaHGUH; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="R/QaHGUH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=UfDTMYjnftXRRhLuKDKW3+ZZLn8Bg6qoGh
	/+Kq2sSmI=; b=R/QaHGUHz7qsdsf07Gsa6BJzEHzW+zhhT8sjum7hJ5x0dyw+33
	NJiDxXvZ/zOLjBaSQ+3l6RrQWqzH2T10fyj8ROC0ilHd/BbV6C3bo2RZMnS8O5II
	W6+vtroi0eTmz8Iqm5ybReDLTo/rnL3ZxKSg74lRuRkV8sbC+qlTj3UEI=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web4 (Coremail) with SMTP id ywQGZQCnbKE5gUNqiZafAg--.37989S4;
	Tue, 30 Jun 2026 16:41:56 +0800 (CST)
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
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Cover MEM_ALLOC access past object bounds
Date: Tue, 30 Jun 2026 08:41:27 +0000
Message-Id: <e36fd5d2f4047809f0e5da46a7077083297e64db.1782807039.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782807039.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1782807039.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQCnbKE5gUNqiZafAg--.37989S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyxuFykCw4rZF1fuF17Jrb_yoW5JFy5p3
	WkK34Yya4fKr42qF9xWF47Wr4rWa1vqrySy345CryUAr43XryDXr4xWFW0vF1fArZa9rn3
	Za4IgF9xWr4UJ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHj14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_GFyl
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUnpBTDUUUU
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

