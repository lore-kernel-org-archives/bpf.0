Received: from mail.189.cn (189sx01-ptr.21cn.com [14.18.100.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1023ACA6F;
	Thu, 22 Jan 2026 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.18.100.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769072659; cv=none; b=U7n7lnqHXRXkpbx109yRPrucO1cx7C3gQ5AB38TGsPBN8RXe/0w9qsiDDPdYg9MLpcsOetIdD9j23eeACmmQ+4NNlUyvJfHerl33duzLtfBA3VSJ19yGHkrmZDzFHXU2eEB2EvmJ2ExsTkdDEgcB8QZPTbEGalbmzow8kn/ZsC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769072659; c=relaxed/simple;
	bh=PZCudvqwWkQ21ryHtvnXzkKSBq4YeYOaQ4GwcfigknQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iDujyLOCLG902My9CNAYosqD4eVIvI4FHfNB47p+qvDhCHX1UFWKAH2FzdBevDhib5HtyN/O+vLNL8PjA8+1KlpvT7EAhPUn8qLVO8vviwSlVM2ksxyZ0CkrK3co5M2IH/jyrtnltF13Yl60RlIQX39ip8Wgs/ZsJQaUgFQdcSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn; spf=pass smtp.mailfrom=189.cn; arc=none smtp.client-ip=14.18.100.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=189.cn
HMM_SOURCE_IP:10.158.243.220:0.451004908
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-221.238.56.48 (unknown [10.158.243.220])
	by mail.189.cn (HERMES) with SMTP id 469D7400088;
	Thu, 22 Jan 2026 17:04:06 +0800 (CST)
Received: from  ([221.238.56.48])
	by gateway-153622-dep-587d8f56d7-fmbcm with ESMTP id 0c8ca397d8964d76aed76a7263bb81d9 for martin.lau@linux.dev;
	Thu, 22 Jan 2026 17:04:07 CST
X-Transaction-ID: 0c8ca397d8964d76aed76a7263bb81d9
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 221.238.56.48
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From: chensong_2000@189.cn
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Chen <chensong_2000@189.cn>
Subject: [PATCH v2] kernel/bpf/btf.c: reject to register duplicated kfunc
Date: Thu, 22 Jan 2026 17:04:04 +0800
Message-ID: <20260122090404.15553-1-chensong_2000@189.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Song Chen <chensong_2000@189.cn>

I had an ebpf program which calls a kfunc defined and
implemented in one of my kernel modules, they were working
fine in 6.16, but was broken by libbpf in 6.19, the error
message was:

libbpf: extern (func ksym) 'bpf_strstr': func_proto [5]
incompatible with vmlinux [94389]

yes, the reason is there is a new added kfunc in kernel 6.19
which happens to be the same name with my kfunc. However the
error message is not obvious enough to address problem
immediately.

Therefore, this patches searches duplicated kfunc in
btf_vmlinux before a kernel module attempts to register kfuncs
through register_btf_kfunc_id_set, it prints clear error message
and returns error code if same name kfunc has already implemented
and registered, then developer knows at the first place.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
Changes in v2:
    - use btf_find_by_name_kind to compare kfunc name
---
 kernel/bpf/btf.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0de8fc8a0e0b..f0158c9c103c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8498,7 +8498,8 @@ static int btf_check_iter_kfuncs(struct btf *btf, const char *func_name,
 	return 0;
 }
 
-static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags)
+static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags,
+			const struct module *module)
 {
 	const struct btf_type *func;
 	const char *func_name;
@@ -8514,6 +8515,17 @@ static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags)
 	if (!func_name || !func_name[0])
 		return -EINVAL;
 
+	/* check if there is any duplicated kfunc in btf_vmlinux */
+	if (module) {
+		s32 id = btf_find_by_name_kind(bpf_get_btf_vmlinux(),
+					func_name, BTF_INFO_KIND(func->info));
+		if (id >= 0) {
+			pr_err("kfunc %s (id: %d) is already present in vmlinux.\n",
+						func_name, id);
+			return -EINVAL;
+		}
+	}
+
 	func = btf_type_by_id(btf, func->type);
 	if (!func || !btf_type_is_func_proto(func))
 		return -EINVAL;
@@ -8757,7 +8769,7 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
 
 	for (i = 0; i < kset->set->cnt; i++) {
 		ret = btf_check_kfunc_protos(btf, btf_relocate_id(btf, kset->set->pairs[i].id),
-					     kset->set->pairs[i].flags);
+					     kset->set->pairs[i].flags, kset->owner);
 		if (ret)
 			goto err_out;
 	}
-- 
2.43.0

