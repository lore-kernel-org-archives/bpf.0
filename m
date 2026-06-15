Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A805D401A36;
	Mon, 15 Jun 2026 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536579; cv=none; b=bf+R4Y6Y2W8w6zFZcnBd1hsmluU6clr6IIi/no17B+5HOP3e6u911A1DNw4jNLpSS0KOQ8KE8WxAMzu7MzUn2PcHokTbfWYON/HTWoT60FIvlBLBWSiSBTN/VgjR10ox3gLckCpikYuJHMTjOcFy4q0ZuDD6VqgU+CAjDpB14Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536579; c=relaxed/simple;
	bh=QqqfXJ9HH4u5xDa0Pti3jWVJafeUhtriKpciO3BrL2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CMIRyAPs0nC2DBYpOkAQtbjyt0oTBWAOFTSd+/O7LdwS7e7918XzJgD5jr1lv/S2ykKWOdQ4czKqYRExebgBKRVW6hb2BLF+3+d+R6tNMrO7TGOoudWja5uon0INQLJZFfyOin+Ew5B7g5YhOCaERHdftkPZcyhszEZWWrilldQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=gKuFFndN; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="gKuFFndN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=PwuM/XsN5XcenQTNng8pXB6BgMbvxx/HeQ
	/8im9muJA=; b=gKuFFndNRvGHRA4pWqgRtWiAfUpg9iYOQ7dBrzuQb8S/wSx/Nn
	T7Wh4Z8Yjr71RESYgdS2vgK8jn1sX9GSdKW9rQpWhFB/V9TVBWRrM1UY3dAs3ZjP
	l8kwaS9E1QvAJKd3pJHVaorXfiy2eHS/GYuusktk3/hy2kC7wHwUVkfUQ=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web5 (Coremail) with SMTP id zAQGZQDXj78mFzBqGxJyAg--.21012S4;
	Mon, 15 Jun 2026 23:16:09 +0800 (CST)
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
Subject: [PATCH bpf v4 2/2] selftests/bpf: Add skb dynptr writer packet invalidation tests
Date: Mon, 15 Jun 2026 15:15:49 +0000
Message-Id: <5a2ca20101d9446d3a92815a8a3cc27b84db1754.1781535194.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781535194.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1781531784.git.chenyy23@mails.tsinghua.edu.cn> <cover.1781535194.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zAQGZQDXj78mFzBqGxJyAg--.21012S4
X-Coremail-Antispam: 1UD129KBjvJXoWxtFy3Xr1rXry3WF13GF4DJwb_yoWxJw4UpF
	ykCry7XrW0yay7Wr17JrW3Za1Fgr4rWr13GrZ8ta4xXFWDJr95ZFn5Kw10qrn0y3sxWrWa
	yayIqay5uF4kXrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUH014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_XrWl
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY
	6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUUBHq7UUUUU==
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

Add verifier tests for stale direct packet pointers after skb dynptr
writes through bpf_dynptr_write() and dynptr writer kfuncs.

Cover global subprogram cases for both caller-side packet pointer
invalidation and local packet pointer invalidation inside the subprogram
body. These cases exercise the static CFG summary path and the precise
verifier path for unspecialized global dynptr arguments.

Also cover direct kfunc writes through bpf_dynptr_memset(),
bpf_dynptr_copy() when the skb dynptr is the destination, and probe-read
into an skb dynptr. Keep a source-only bpf_dynptr_copy() case as a
positive control.

Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 183 ++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index b62773ce5219b..f8bd0483b68d0 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -1232,6 +1232,189 @@ int skb_invalid_data_slice4(struct __sk_buff *skb)
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

