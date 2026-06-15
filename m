Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF9930BB8D;
	Mon, 15 Jun 2026 17:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781545774; cv=none; b=RfvmmOTGlNlkbCg/pflYXoY7NR0+U6PDDSBXM+xOrBWv0ZZdVLUrM7y74cfmzms2TQYtfjUk4PLSqcetjhiTX8O158kyyodsTJMzH2GBB726xTw84t07dRFHh0mvXqVApE4c6YVXnikb1HuXqFtysRLAIjgbTGbJkExwdC5iwiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781545774; c=relaxed/simple;
	bh=UTmTZTZOwXgZOobnTVowPFBwvrOx/9Wf5yiI1jnlJOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vfr7B9kY2+ChMqmbqQYu68beiW5C65tenwRn2vj+ZZYdxW76dyalP9DoHT2VreWL+9KTPo+n415P7zw3uv5KmR6WqPR+opY+W/Fys9MFIQzHD+NAuxqVtzxDiu2x7Nfk52btg1cR2RTDaIhzLtmj2besAouQXHmKKk0wWMXgn8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=gYJ0/RQO; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="gYJ0/RQO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=Z8HwVSErWP5mj+aryLYszbJBMP89LtXq8a
	xQpesKxII=; b=gYJ0/RQOqLWT+/i9ABZKZMUp+235o1gIP4PuhWPmjvUid0ZdJC
	aPzLk7j/NE2zVSt2I/U42ch94Lu3xhdqda80DwdYulucl4JOI6p0VRXItLFm749M
	NExPFBXse7zimQ32SNEW36B/yANcA4zW8ua/7W8t58HjCfvlmPsYChFLw=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web4 (Coremail) with SMTP id ywQGZQA3SJ0XOzBqCjxLAg--.43171S4;
	Tue, 16 Jun 2026 01:49:25 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
To: bpf@vger.kernel.org
Cc: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v5 2/2] selftests/bpf: Add skb dynptr writer packet invalidation tests
Date: Mon, 15 Jun 2026 17:49:08 +0000
Message-Id: <7feeed42d8b97d0db0eab2c1c30aa86f110fe49c.1781539814.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781539813.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1781535194.git.chenyy23@mails.tsinghua.edu.cn> <cover.1781539813.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQA3SJ0XOzBqCjxLAg--.43171S4
X-Coremail-Antispam: 1UD129KBjvJXoWxtFyfWr15KF1rJw4DCFWxWFg_yoW3WF1fpF
	ykCFy7XrW0yFW7Wr17JrW3Zw4Fgr48Wr13GrZ8tFyxXFWUJr95ZFn5Kw10qrs0y3sxWrWa
	yFZ7tay5uF1kXrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Add verifier tests for stale direct packet pointers after skb dynptr
writes through bpf_dynptr_write() and dynptr writer kfuncs.

Cover global subprogram cases for both caller-side packet pointer
invalidation and local packet pointer invalidation inside the subprogram
body. These cases exercise the static CFG summary path and the precise
verifier path for unspecialized global dynptr arguments.

Also cover global subprogram bypasses where the dynptr argument is first
cloned to the stack, and where a LOCAL-typed dynptr slice is taken before
the original dynptr is written.

Also cover direct kfunc writes through bpf_dynptr_memset(),
bpf_dynptr_copy() when the skb dynptr is the destination, and probe-read
into an skb dynptr. Keep a source-only bpf_dynptr_copy() case as a
positive control.

Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 238 ++++++++++++++++++
 1 file changed, 238 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index b62773ce5219b..aa9374dbdb118 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -1232,6 +1232,244 @@ int skb_invalid_data_slice4(struct __sk_buff *skb)
 	return SK_PASS;
 }
 
+char dynptr_writer_data[8] = "test";
+char dynptr_writer_dst[8];
+
+extern int bpf_dynptr_copy(struct bpf_dynptr *dst, __u64 dst_off,
+			   struct bpf_dynptr *src, __u64 src_off,
+			   __u64 size) __ksym __weak;
+extern int bpf_dynptr_memset(struct bpf_dynptr *ptr, __u64 offset,
+			     __u64 size, __u8 val) __ksym __weak;
+extern int bpf_probe_read_kernel_dynptr(struct bpf_dynptr *dptr,
+					__u64 off, __u64 size,
+					const void *unsafe_ptr__ign) __ksym __weak;
+
+__noinline int global_dynptr_helper_write(struct bpf_dynptr *ptr)
+{
+	return bpf_dynptr_write(ptr, 0, dynptr_writer_data, 1, 0);
+}
+
+__noinline int global_dynptr_helper_write_and_read(struct __sk_buff *skb,
+						   struct bpf_dynptr *ptr)
+{
+	__u8 *data = (void *)(long)skb->data;
+	__u8 *data_end = (void *)(long)skb->data_end;
+
+	if (data + 1 > data_end)
+		return SK_DROP;
+
+	bpf_dynptr_write(ptr, 0, dynptr_writer_data, 1, 0);
+
+	/* this should fail */
+	return *data;
+}
+
+__noinline int global_dynptr_clone_write_and_read(struct __sk_buff *skb,
+						  struct bpf_dynptr *ptr)
+{
+	__u8 *data = (void *)(long)skb->data;
+	__u8 *data_end = (void *)(long)skb->data_end;
+	struct bpf_dynptr clone;
+
+	if (data + 1 > data_end)
+		return SK_DROP;
+	if (bpf_dynptr_clone(ptr, &clone))
+		return SK_DROP;
+
+	bpf_dynptr_write(&clone, 0, dynptr_writer_data, 1, 0);
+
+	/* this should fail */
+	return *data;
+}
+
+__noinline int global_dynptr_slice_write_and_read(struct bpf_dynptr *ptr)
+{
+	__u8 buffer[1] = {};
+	__u8 *data;
+
+	data = bpf_dynptr_slice_rdwr(ptr, 0, buffer, sizeof(buffer));
+	if (!data)
+		return SK_DROP;
+
+	bpf_dynptr_write(ptr, 0, dynptr_writer_data, 1, 0);
+
+	/* this should fail */
+	return *data;
+}
+
+__noinline int global_dynptr_kfunc_memset(struct bpf_dynptr *ptr)
+{
+	return bpf_dynptr_memset(ptr, 0, 1, 0);
+}
+
+__noinline int global_dynptr_kfunc_memset_and_read(struct __sk_buff *skb,
+						   struct bpf_dynptr *ptr)
+{
+	__u8 *data = (void *)(long)skb->data;
+	__u8 *data_end = (void *)(long)skb->data_end;
+
+	if (data + 1 > data_end)
+		return SK_DROP;
+
+	bpf_dynptr_memset(ptr, 0, 1, 0);
+
+	/* this should fail */
+	return *data;
+}
+
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int skb_pkt_ptr_invalid_after_global_dynptr_write(struct __sk_buff *skb)
+{
+	__u8 *data = (void *)(long)skb->data;
+	__u8 *data_end = (void *)(long)skb->data_end;
+	struct bpf_dynptr ptr;
+
+	if (data + 1 > data_end)
+		return SK_DROP;
+
+	bpf_dynptr_from_skb(skb, 0, &ptr);
+	global_dynptr_helper_write(&ptr);
+
+	/* this should fail */
+	return *data;
+}
+
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int skb_pkt_ptr_invalid_inside_global_dynptr_write(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_skb(skb, 0, &ptr);
+
+	return global_dynptr_helper_write_and_read(skb, &ptr);
+}
+
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int skb_pkt_ptr_invalid_after_global_dynptr_clone_write(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_skb(skb, 0, &ptr);
+
+	return global_dynptr_clone_write_and_read(skb, &ptr);
+}
+
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int skb_slice_invalid_after_global_dynptr_write(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_skb(skb, 0, &ptr);
+
+	return global_dynptr_slice_write_and_read(&ptr);
+}
+
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int skb_pkt_ptr_invalid_after_dynptr_memset(struct __sk_buff *skb)
+{
+	__u8 *data = (void *)(long)skb->data;
+	__u8 *data_end = (void *)(long)skb->data_end;
+	struct bpf_dynptr ptr;
+
+	if (data + 1 > data_end)
+		return SK_DROP;
+
+	bpf_dynptr_from_skb(skb, 0, &ptr);
+	bpf_dynptr_memset(&ptr, 0, 1, 0);
+
+	/* this should fail */
+	return *data;
+}
+
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int skb_pkt_ptr_invalid_after_global_dynptr_memset(struct __sk_buff *skb)
+{
+	__u8 *data = (void *)(long)skb->data;
+	__u8 *data_end = (void *)(long)skb->data_end;
+	struct bpf_dynptr ptr;
+
+	if (data + 1 > data_end)
+		return SK_DROP;
+
+	bpf_dynptr_from_skb(skb, 0, &ptr);
+	global_dynptr_kfunc_memset(&ptr);
+
+	/* this should fail */
+	return *data;
+}
+
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int skb_pkt_ptr_invalid_inside_global_dynptr_memset(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_skb(skb, 0, &ptr);
+
+	return global_dynptr_kfunc_memset_and_read(skb, &ptr);
+}
+
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int skb_pkt_ptr_invalid_after_dynptr_copy_dst(struct __sk_buff *skb)
+{
+	__u8 *data = (void *)(long)skb->data;
+	__u8 *data_end = (void *)(long)skb->data_end;
+	struct bpf_dynptr dst, src;
+
+	if (data + 1 > data_end)
+		return SK_DROP;
+
+	bpf_dynptr_from_skb(skb, 0, &dst);
+	bpf_dynptr_from_mem(dynptr_writer_data, sizeof(dynptr_writer_data), 0, &src);
+	bpf_dynptr_copy(&dst, 0, &src, 0, 1);
+
+	/* this should fail */
+	return *data;
+}
+
+SEC("?tc")
+__success
+int skb_pkt_ptr_valid_after_dynptr_copy_src(struct __sk_buff *skb)
+{
+	__u8 *data = (void *)(long)skb->data;
+	__u8 *data_end = (void *)(long)skb->data_end;
+	struct bpf_dynptr dst, src;
+
+	if (data + 1 > data_end)
+		return SK_DROP;
+
+	bpf_dynptr_from_skb(skb, 0, &src);
+	bpf_dynptr_from_mem(dynptr_writer_dst, sizeof(dynptr_writer_dst), 0, &dst);
+	bpf_dynptr_copy(&dst, 0, &src, 0, 1);
+
+	return *data;
+}
+
+SEC("?tc")
+__failure __msg("invalid mem access 'scalar'")
+int skb_pkt_ptr_invalid_after_probe_read_kernel_dynptr(struct __sk_buff *skb)
+{
+	__u8 *data = (void *)(long)skb->data;
+	__u8 *data_end = (void *)(long)skb->data_end;
+	struct bpf_dynptr ptr;
+
+	if (data + 1 > data_end)
+		return SK_DROP;
+
+	bpf_dynptr_from_skb(skb, 0, &ptr);
+	bpf_probe_read_kernel_dynptr(&ptr, 0, 1, dynptr_writer_data);
+
+	/* this should fail */
+	return *data;
+}
+
 /* Read-only skb data slice is invalidated on write to skb metadata */
 SEC("?tc")
 __failure __msg("invalid mem access 'scalar'")
-- 
2.34.1

