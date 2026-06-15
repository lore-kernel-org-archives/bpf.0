Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C68E3E5A27;
	Mon, 15 Jun 2026 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781525319; cv=none; b=PQsc9GByny3LA+066Df6RNWKYIMjFyQMsvd8L0OIktp9U5ivlNSi5367wmBIR1HnksZkJ+djDU542QJmyChg3Aheiao6dPip2hU8Hd1F1rKGcB7nkhnECqekPp1MbKKekB2eqDAq971bqQgbZ0iI1NXn7ZlMoSRKQZMqzqN8nlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781525319; c=relaxed/simple;
	bh=xENrRWFNXuS6xq/5GkioW3KfKBBoBO3WYjsm4D8fsSA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q1TE3T3hP3jMwuTVGB57u35TbFSlTJS4kLttiOqxaOAgzHgv5WpXgKzYmVgFik1h2M8ocYLQ5HxqLKXth4jBIOKfEb2qL9TDWwRRFWaLmKH151jeujBwUBa5xiBr03Lt4SBeeViGK7BE8je2z0xwxUEyRg4Oudfdn4ngKt+4N7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=Ag5MBtsN; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="Ag5MBtsN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:MIME-Version:Content-Transfer-Encoding; bh=3ObGa
	VQFun/9BcHL7UjFxf26skvy0iZtdy+4Fcepbas=; b=Ag5MBtsN6Ge6U1SBwUBGE
	Byy8LGVc1gK5LF/hQRuXhTpHcO2UozM1A9kG/e4maqVrLJj0eZ6KwIgvauCJglsG
	Tdf0h4N9JzmgjoLOQcqr65wYiKoS61stWgva4Dr8JJctaXhkSbhgzgJoCfrYBVp4
	24wXVK9mwjfAfaKa+/xp9c=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web5 (Coremail) with SMTP id zAQGZQCnX7846y9q0ZFxAg--.40573S2;
	Mon, 15 Jun 2026 20:08:29 +0800 (CST)
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
Subject: [PATCH bpf 2/2] selftests/bpf: Add skb dynptr writer packet invalidation tests
Date: Mon, 15 Jun 2026 12:08:23 +0000
Message-Id: <20260615120823.156382-1-chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zAQGZQCnX7846y9q0ZFxAg--.40573S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1xtF48XrWfKFy3Gr4Uurg_yoWrGw18pa
	ykC3y3WrW0ya13Xr17JrWfZa15Kr4rXr1fGrZ8ta4fX3ykXr95ZF1rKr10vrs0k345WrWa
	ka42qay5uFs5JwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67
	AK6ryUMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbjg43UU
	UUU==
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

Add verifier tests for direct packet pointers kept live across skb dynptr
writer kfunc calls.

The writer cases must reject because stale packet pointers must not remain
usable after the kfunc can mutate skb packet storage.

Add a bpf_dynptr_copy() control where the skb dynptr is only the source.
That case must continue to load because it does not write through the
skb-backed dynptr.

Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 344fb2aa0813d..bd51c9b93742a 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -1274,6 +1274,95 @@ int skb_invalid_data_slice4(struct __sk_buff *skb)
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

