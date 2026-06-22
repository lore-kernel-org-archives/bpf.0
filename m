Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2361C351C28;
	Mon, 22 Jun 2026 04:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782104225; cv=none; b=fWgUAHMte/X5SuxVgjJYumAryeKEWfbfwrDNJnC03+ilalKKF0t8d8HhJIqxc/0lmhAnhpU/vG2JGnSPCZhWxjiQjZa+VBNB6m882a9oJBfLOfGnTMNXXm9QXuFWum0JbOQ8PeLLPE5jpK1X02A20tf4hKccMPUFgVNI72rLK08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782104225; c=relaxed/simple;
	bh=0QR9z2k3MndvGlo5qozB4yq4K5o8S+ow/FPW/i1WvYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t8xqO4Jz07Toj/x/aJy0u6YurgVQtm8nr5cOCN7J4b6goY7+3If7YuedbdAx+uVpwdkpgAQP9XNQjdXoS0CjcSPo61IcAnR966g57/xIu3SlBqOA31CvrdHTDh1X995wP1Aa/iqbnnpCqtMlUc7y7cZR/es3Tx5gYZ+egLWLbMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=SVBD9h1l; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="SVBD9h1l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=O2g1qcFOseX+EHgjpDAC8BuSreMFI2XI5D
	48K3p6JQw=; b=SVBD9h1l8HXoVjmGbINeDckvmszrttiM6Hmx/jFDt2PluBjObQ
	tf/cQpEVpC2XVQFH55h8Y9O/LTNm9xNaZtURFU4yjTV0dBqZRjhiXfuQqYeJUBwz
	5fHCSLqmtRovqdSFZXYGHZW/MLtJ+xE8Iuj5yyQhAW8YT1rLUO7DwO7Ww=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web4 (Coremail) with SMTP id ywQGZQBHWZ6GwDhqUmtwAg--.53540S4;
	Mon, 22 Jun 2026 12:56:51 +0800 (CST)
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
Subject: [PATCH bpf-next 2/2] selftests/bpf: Cover flexible-array allocation rejection
Date: Mon, 22 Jun 2026 04:56:37 +0000
Message-Id: <5b0ecdf774f8f5de5c1d8ecd56368720afb5a14d.1782100805.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782100805.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1782100805.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQBHWZ6GwDhqUmtwAg--.53540S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4kGF1DKw1DKF1fuw43Awb_yoW5GrWxpa
	4kK34Yy3WfKr42qasxWF42gr4Fgan2qryay345uw1UZr43XryDXr4xKFWjvFyfCrs3urn3
	Za4IgF9xWr4UA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUH014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_Gryl
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUjg4S7UUUUU==
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

Add a linked_list negative loader case for a program-BTF type whose last
member is a zero-length flexible array. The program writes through the
first flexible-array element so an incorrect allocation-time acceptance
would leave the verifier to approve an access outside the allocated object.

Use the explicit _impl kfunc forms in this negative test so the case is
scoped to the allocation type check and not to implicit kfunc wrapper
resolution.

Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 .../selftests/bpf/prog_tests/linked_list.c    |  2 ++
 .../selftests/bpf/progs/linked_list_fail.c    | 23 +++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/testing/selftests/bpf/prog_tests/linked_list.c
index 8defea025..49c250132 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -68,6 +68,8 @@ static struct {
 	{ "obj_type_id_oor", "local type ID argument must be in range [0, U32_MAX]" },
 	{ "obj_new_no_composite", "bpf_obj_new/bpf_percpu_obj_new type ID argument must be of a struct" },
 	{ "obj_new_no_struct", "bpf_obj_new/bpf_percpu_obj_new type ID argument must be of a struct" },
+	{ "obj_new_flex_array",
+	  "bpf_obj_new type must not contain a flexible array" },
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

