Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D0F379C33;
	Mon, 15 Jun 2026 12:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781525297; cv=none; b=I806qZphqX/dbGCqYxX2+DLJx4Wv6MKCY5tKpm5+wv03Ov5KsakDB0jZW5P6RQsCyiX4kl4r8wH+eHqxmzqfpJGy7oS8nJesXEgV+BHZLrnc0xzIalZjqanFvkya5dLbHEfNO004CKzWAC+Mxb8V8JGHM/6uCX+MtxtTxg2Uciw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781525297; c=relaxed/simple;
	bh=o4OF3T89yh3n/KvJHVrYByEsxZLSfxZP8XKF+OR0BxM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l9Jkr6Yuf81brpK2oYial/BY2ZZE7Ir0Y7y6G7Ra7gfF7WAVgSdBHtxkbgYdgiUVe9JWVBMo7aB3R7+qjDmVmXBF8EYJNS2PXAbIBBL3bquIyHxsbV2QiJL5JlEgATg3MA20Uck94nIeprCZtmKkcxUBFURiTZ2vpQSrToAK4jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=Qgjavn+I; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="Qgjavn+I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:MIME-Version:Content-Transfer-Encoding; bh=f6sJp
	9XXQ39SQ9gDK+R7GX2y8JbFcSlaPP/hGOR86y0=; b=Qgjavn+InTAwWReCGi+cN
	s7HWwTyMTHdWGvOgvl1UZqRXZTyZeJQac0F/S538R9qgKXH/N8MixUGmcONPebqs
	cxBSxvnsx8F70I/ILSW+jtss/VyLI+F6qF1Fio8QzjnI9+Dxfo8AOCHHM/I3FeB+
	O+FMg+Gw950kcaWKSOF7dQ=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web3 (Coremail) with SMTP id ygQGZQCX45Ai6y9q1g10Ag--.24949S2;
	Mon, 15 Jun 2026 20:08:08 +0800 (CST)
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
Subject: [PATCH bpf 1/2] bpf: Fix packet pointer invalidation for skb dynptr writes
Date: Mon, 15 Jun 2026 12:07:52 +0000
Message-Id: <20260615120752.155006-1-chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQCX45Ai6y9q1g10Ag--.24949S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr4UGF43XFW5AFyfWw4kZwb_yoW7JFW8pF
	4rGasI9r1rta13trnrJF4IvrZ5tr4Iqa1xC34vgryfur4UWr90vr1Uuw18J3s5tF12yr42
	v3WIvrW3AF1UtwUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK67
	AK6ryUMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sREf-BJUU
	UUU==
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

