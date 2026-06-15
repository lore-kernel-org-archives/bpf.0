Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011943EB0F1;
	Mon, 15 Jun 2026 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781526523; cv=none; b=JBHb9vo73w6XvlSViqkZI44jmNJDc77XWoELT2DxLwjRmuSNfH5aF2DPaPTsUjhR+tVHXtb7HdUTc8bPWFaCx8lAp35fL4VbPZR5lNAm+F8w2GXAQgrqsuTRG+WbEeMkzK22La7cQhksdOA2GWRqc9Se8tpKTutapVuDJvylw5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781526523; c=relaxed/simple;
	bh=o4OF3T89yh3n/KvJHVrYByEsxZLSfxZP8XKF+OR0BxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PrHa1CABlfzS0YgdfJ2FaJtqV6ZTmopzlMpIYVrjTDNjJzgQQpg0eVYbfDZ31X6xqY5cOGD3TZxzCIFKCyMJPiivqQUMJ5U50yixGMXEHtBqw1hnUhKpeX8KKbHtuvsmrQ3f1kP67ACamE249AaBJQskhjT0duj9RRiDAtJO31k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=ImzSGBm9; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="ImzSGBm9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=f6sJp9XXQ39SQ9gDK+R7GX2y8JbFcSlaPP
	/hGOR86y0=; b=ImzSGBm9olBRXoPPDVX+kT3tyjdC2fwUv6BMY7W4Z6T4caCwLO
	w/AWODWnwgSwhIe7BM8MiMR3wx0LYqevfxeqieyXsZ5pLah40CB43agVYUBIxkWN
	/9yIG2BIuBpi8zgbjHN9GPv1x4HRlWA+okGUONZFp9x1iBVM89dkJou9w=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web2 (Coremail) with SMTP id yQQGZQAH4Jfb7y9qtBtQAg--.40734S3;
	Mon, 15 Jun 2026 20:28:26 +0800 (CST)
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
Subject: [PATCH bpf v2 1/2] bpf: Fix packet pointer invalidation for skb dynptr writes
Date: Mon, 15 Jun 2026 12:28:09 +0000
Message-Id: <72711041414b27e996c6a25f6fd72903acee589f.1781525896.git.chenyy23@mails.tsinghua.edu.cn>
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
X-CM-TRANSID:yQQGZQAH4Jfb7y9qtBtQAg--.40734S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXr4UGF43XFW5AFyfWw4kZwb_yoW7JFW8pF
	4rGasI9r1rta13trnrJF4IvrZ5tr4Iqa1xC34vgryfur4UWr90vr1Uuw18J3s5tF12yr42
	v3WIvrW3AF1UtwUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUdEb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv
	6xkF7I0E14v26rxl6s0DM2kKe7AKxVWUXVWUAwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0x
	vYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY
	1x0262kKe7AKxVWrXVW3AwCY02Avz4vE14v_Xr1l42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJr
	UvcSsGvfC2KfnxnUUI43ZEXa7xR_UGOUUUUUU==
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

skb-backed dynptr writer kfuncs can mutate skb packet storage.
The verifier currently treats kfunc calls as packet-changing only for
bpf_xdp_pull_data().

That leaves direct packet pointers usable after skb dynptr writer kfuncs.
The helper path already clears packet pointers for bpf_dynptr_write().

Mark kfunc calls packet-changing when argument 0 is a writable skb or
skb-meta dynptr destination.  This covers bpf_dynptr_copy(),
bpf_dynptr_memset(), and probe/copy-from-user dynptr writers.
Source-only dynptr arguments are left unchanged.

Fixes: daec295a70941 ("bpf/helpers: Introduce bpf_dynptr_copy kfunc")
Fixes: a498ee7576de ("bpf: Implement dynptr copy kfuncs")
Fixes: 5fc5d8fded57 ("bpf: Add bpf_dynptr_memset() kfunc")
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/verifier.c        | 62 +++++++++++++++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 39a851e690ec4..c7d0c20a4961b 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1448,6 +1448,7 @@ struct bpf_kfunc_call_arg_meta {
 	/* Out parameters */
 	u8 release_regno;
 	bool r0_rdonly;
+	bool pkt_dynptr_write;
 	u32 ret_btf_id;
 	u64 r0_size;
 	u32 subprogno;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2abc79dbf281c..5ea51bd284f84 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11016,6 +11016,16 @@ enum special_kfunc_type {
 	KF_bpf_xdp_pull_data,
 	KF_bpf_dynptr_slice,
 	KF_bpf_dynptr_slice_rdwr,
+	KF_bpf_dynptr_copy,
+	KF_bpf_dynptr_memset,
+	KF_bpf_probe_read_user_dynptr,
+	KF_bpf_probe_read_kernel_dynptr,
+	KF_bpf_probe_read_user_str_dynptr,
+	KF_bpf_probe_read_kernel_str_dynptr,
+	KF_bpf_copy_from_user_dynptr,
+	KF_bpf_copy_from_user_str_dynptr,
+	KF_bpf_copy_from_user_task_dynptr,
+	KF_bpf_copy_from_user_task_str_dynptr,
 	KF_bpf_dynptr_clone,
 	KF_bpf_percpu_obj_new_impl,
 	KF_bpf_percpu_obj_new,
@@ -11096,6 +11106,27 @@ BTF_ID_UNUSED
 #endif
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
+BTF_ID(func, bpf_dynptr_copy)
+BTF_ID(func, bpf_dynptr_memset)
+#ifdef CONFIG_BPF_EVENTS
+BTF_ID(func, bpf_probe_read_user_dynptr)
+BTF_ID(func, bpf_probe_read_kernel_dynptr)
+BTF_ID(func, bpf_probe_read_user_str_dynptr)
+BTF_ID(func, bpf_probe_read_kernel_str_dynptr)
+BTF_ID(func, bpf_copy_from_user_dynptr)
+BTF_ID(func, bpf_copy_from_user_str_dynptr)
+BTF_ID(func, bpf_copy_from_user_task_dynptr)
+BTF_ID(func, bpf_copy_from_user_task_str_dynptr)
+#else
+BTF_ID_UNUSED
+BTF_ID_UNUSED
+BTF_ID_UNUSED
+BTF_ID_UNUSED
+BTF_ID_UNUSED
+BTF_ID_UNUSED
+BTF_ID_UNUSED
+BTF_ID_UNUSED
+#endif
 BTF_ID(func, bpf_dynptr_clone)
 BTF_ID(func, bpf_percpu_obj_new_impl)
 BTF_ID(func, bpf_percpu_obj_new)
@@ -11229,7 +11260,33 @@ static bool is_kfunc_bpf_preempt_enable(struct bpf_kfunc_call_arg_meta *meta)
 
 bool bpf_is_kfunc_pkt_changing(struct bpf_kfunc_call_arg_meta *meta)
 {
-	return meta->func_id == special_kfunc_list[KF_bpf_xdp_pull_data];
+	return meta->func_id == special_kfunc_list[KF_bpf_xdp_pull_data] ||
+	       meta->pkt_dynptr_write;
+}
+
+static bool dynptr_type_pkt_data(enum bpf_dynptr_type type)
+{
+	return type == BPF_DYNPTR_TYPE_SKB ||
+	       type == BPF_DYNPTR_TYPE_SKB_META;
+}
+
+static bool is_kfunc_pkt_dynptr_writer(struct bpf_kfunc_call_arg_meta *meta, u32 arg)
+{
+	u32 func_id = meta->func_id;
+
+	if (arg != 0)
+		return false;
+
+	return func_id == special_kfunc_list[KF_bpf_dynptr_copy] ||
+	       func_id == special_kfunc_list[KF_bpf_dynptr_memset] ||
+	       func_id == special_kfunc_list[KF_bpf_probe_read_user_dynptr] ||
+	       func_id == special_kfunc_list[KF_bpf_probe_read_kernel_dynptr] ||
+	       func_id == special_kfunc_list[KF_bpf_probe_read_user_str_dynptr] ||
+	       func_id == special_kfunc_list[KF_bpf_probe_read_kernel_str_dynptr] ||
+	       func_id == special_kfunc_list[KF_bpf_copy_from_user_dynptr] ||
+	       func_id == special_kfunc_list[KF_bpf_copy_from_user_str_dynptr] ||
+	       func_id == special_kfunc_list[KF_bpf_copy_from_user_task_dynptr] ||
+	       func_id == special_kfunc_list[KF_bpf_copy_from_user_task_str_dynptr];
 }
 
 static enum kfunc_ptr_arg_type
@@ -12214,6 +12271,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 						  &meta->ref_obj, &meta->dynptr);
 			if (ret < 0)
 				return ret;
+			if (is_kfunc_pkt_dynptr_writer(meta, i) &&
+			    dynptr_type_pkt_data(meta->dynptr.type))
+				meta->pkt_dynptr_write = true;
 			break;
 		}
 		case KF_ARG_PTR_TO_ITER:
-- 
2.34.1

