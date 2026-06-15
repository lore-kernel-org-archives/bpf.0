Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A693F8891;
	Mon, 15 Jun 2026 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781532889; cv=none; b=hMK4KgZLpJYKJa0WUR65sanLnfxL0ut7TQrGMpXvgVwAk+d2TXPm/6643kxsfWQhVE0BQZqqkTiAZ/TgpngGI7bL/3SYSUqz2CbFwT4+s6ZSVDPeJuwn2GmAH5kUyQLyGDCjhKEFXEjOAgS26/30U7v/OXnR6cK/c+1GqLYZ4Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781532889; c=relaxed/simple;
	bh=pInq6Cx4zlRuwINHMy2s2CQbF37KI3oXLJ9dPcf89Wg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yoab0aHTyL7MKQkdGs9iz9U4uOwt/rRjgRZ7QavubV/bvQUFCkKFBRNg34wvIfRaci0dp5BEN5BqErVEySwj28YoVsCxbCcCkAvJmd916WimTk6GZajLasb2sXgsijFMnKExvRz9+SwEk3gcGdT5utBbFhwsK2wKOxqHq2DXi7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=DfOl+wWr; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="DfOl+wWr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=+8kiVJGk/0znkRnjZ/BYOCYUTvheZTq0eK
	LUsWO/PN8=; b=DfOl+wWr2JGPABu1/CUdAekKr7LDZ78QSy2d7w03JlzIavR3iw
	PUuG0ubbo3WOo1tYbEwE72XxR93V11w5PVDhP8ienMMDApM2429TaNMBUhK1r8vv
	1dIwHdj59LpF/40eb6/y/iT8MK3yK6aXmh3FNUMg0dIn5Yz1qDFziC6qQ=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web4 (Coremail) with SMTP id ywQGZQBXaZ69CDBqq7FKAg--.53046S4;
	Mon, 15 Jun 2026 22:14:35 +0800 (CST)
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
Subject: [PATCH bpf v3 2/2] selftests/bpf: Add skb dynptr writer packet invalidation tests
Date: Mon, 15 Jun 2026 14:14:07 +0000
Message-Id: <a1d20415eb52b56575ae0908bfde1264ed542a38.1781531784.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781531784.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1781525896.git.chenyy23@mails.tsinghua.edu.cn> <cover.1781531784.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQBXaZ69CDBqq7FKAg--.53046S4
X-Coremail-Antispam: 1UD129KBjvJXoWxtryUJw45Gr4ruw4DXr1DJrb_yoW7AF48pF
	ykCry3WrW0ya13Xr17JrWfZa1Fgr4rXr13GrZ8ta4fXw1kXr95ZF1rKw10qrs0y343WrW2
	ka9Fqay5uFykJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUH014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_Xryl
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY
	6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUjPEf5UUUUU==
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

Add verifier tests for skb dynptr writer kfuncs that must invalidate
checked direct packet pointers. Cover bpf_dynptr_memset(),
bpf_dynptr_copy() when the skb dynptr is the destination, and probe-read
into an skb dynptr.

Keep a source-only bpf_dynptr_copy() case as a positive control, since
copying from an skb dynptr into memory does not mutate packet data.

Add global subprogram regressions for stale caller packet pointers after
a dynptr writer call and stale packet pointer use inside a global
subprogram whose dynptr argument may be skb-backed.

Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 140 ++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 344fb2aa0813d..d79cef5342d67 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -1274,6 +1274,146 @@ int skb_invalid_data_slice4(struct __sk_buff *skb)
 	return SK_PASS;
 }
 
+char dynptr_kfunc_data[8] = "test";
+char dynptr_kfunc_dst[8];
+
+extern int bpf_dynptr_copy(const struct bpf_dynptr *dst, __u64 dst_off,
+			   const struct bpf_dynptr *src, __u64 src_off,
+			   __u64 size) __ksym __weak;
+extern int bpf_dynptr_memset(const struct bpf_dynptr *ptr, __u64 offset,
+			     __u64 size, __u8 val) __ksym __weak;
+extern int bpf_probe_read_kernel_dynptr(const struct bpf_dynptr *dptr,
+					__u64 off, __u64 size,
+					const void *unsafe_ptr__ign) __ksym __weak;
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
+/* Direct packet pointers are invalidated after a dynptr kfunc writes to an skb */
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
+/* Global subprogs with dynptr writer kfuncs invalidate caller packet pointers */
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
+/* Global subprog dynptr args may be packet-backed and must invalidate locally */
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
+/* Direct packet pointers are invalidated after bpf_dynptr_copy() writes to an skb */
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
+	bpf_dynptr_from_mem(dynptr_kfunc_data, sizeof(dynptr_kfunc_data), 0, &src);
+	bpf_dynptr_copy(&dst, 0, &src, 0, 1);
+
+	/* this should fail */
+	return *data;
+}
+
+/* Direct packet pointers stay valid when an skb dynptr is only copied from */
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
+	bpf_dynptr_from_mem(dynptr_kfunc_dst, sizeof(dynptr_kfunc_dst), 0, &dst);
+	bpf_dynptr_copy(&dst, 0, &src, 0, 1);
+
+	return *data;
+}
+
+/* Direct packet pointers are invalidated after probe-read writes to an skb dynptr */
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
+	bpf_probe_read_kernel_dynptr(&ptr, 0, 1, dynptr_kfunc_data);
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

