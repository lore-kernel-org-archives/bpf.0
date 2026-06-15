Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE203EB0FA;
	Mon, 15 Jun 2026 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781526524; cv=none; b=V5Or6RWXEqqitmkHKN2TQzodTeqE7kQV2GR5OA0BgaoagREGxcy79Qw4RBqdLNWTZtCyeJev+XhcbmJNDWEURML+Irfp9q7gzhPpu2LVXuKwWYv0p4HHYLClwQ6MclNqAFKyk5kG2kPnAqE+2FrhoPAwMpyiavqW+G6HiRjgN4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781526524; c=relaxed/simple;
	bh=xENrRWFNXuS6xq/5GkioW3KfKBBoBO3WYjsm4D8fsSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l2o4LnE4lgTIANIL/k/jGYagVCtWD82lMt2d/rjl2a6WqMT6h/XmZ1h3Ce2EQ0D6d/Hr9xD5V+3R+M9goLKdXj+xELhBWzMNmiQvN2cdMwMNEBoRVI0EqlwuzBb8YjgnfOaZYpX96Y0oMtm1rg1shgtuhpj9ar4sbLQN4Eexpio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=EzjZdKW3; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="EzjZdKW3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=3ObGaVQFun/9BcHL7UjFxf26skvy0iZtdy
	+4Fcepbas=; b=EzjZdKW3V3EgjxDYRV1P0NQomrtoRr3JZOyGnBpA708gtyAWUL
	phAht185F36UcKGWWL52/Ed3XtQWsvi5IVFYd79It7jHAjzuNOC+X7epZ9LRXaf8
	yiojqpjh4OhP6Tzrue+0bL+yUOTmmdScCWvSVC5mwmaurqjjM+Tr6WBq4=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web2 (Coremail) with SMTP id yQQGZQAH4Jfb7y9qtBtQAg--.40734S4;
	Mon, 15 Jun 2026 20:28:27 +0800 (CST)
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
Subject: [PATCH bpf v2 2/2] selftests/bpf: Add skb dynptr writer packet invalidation tests
Date: Mon, 15 Jun 2026 12:28:10 +0000
Message-Id: <9591bc15599a4c09a0aeb1815f1a7cf72c84c01f.1781525896.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781525896.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1781525896.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yQQGZQAH4Jfb7y9qtBtQAg--.40734S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1xtF48XrWfKFy3Gr4Uurg_yoWrGw18pa
	ykC3y3WrW0ya13Xr17JrWfZa15Kr4rXr1fGrZ8ta4fX3ykXr95ZF1rKr10vrs0k345WrWa
	ka42qay5uFs5JwUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUljb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv
	6xkF7I0E14v26rxl6s0DM2kKe7AKxVWUXVWUAwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0x
	vYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY
	1x0262kKe7AKxVWrXVW3AwCY02Avz4vE14v_Xr1l42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JF
	I_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr
	1UYxBIdaVFxhVjvjDU0xZFpf9x0zE1CJ_UUUUU=
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

