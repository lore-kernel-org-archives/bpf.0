Received: from mail.189.cn (189sx01-ptr.21cn.com [14.18.100.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65680326D63;
	Wed, 21 Jan 2026 01:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.18.100.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768960588; cv=none; b=LECkY9kYmEoPLGcXLcYChIN2bHlgEvbc2OLkVflGtujqqJYgt+W1Wfmh5K1hzV2jmxZXuPMJkY641bFfYIElAilowA5fEtOQrj+fAqZ44gnQ0mfzT3DFK5Q8Ckse8wjJZIewjjXe9pOGbK2bwm5TMTo5m/gLcpFpKNjg/TPCWxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768960588; c=relaxed/simple;
	bh=ne5xqhK7lf/PdSgqL+XWMOaWEM6iW0X1L5/SWSqLSuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EQwHH2kDHsiPh2ydT4oLicgPUKCwkIkGyVoCJI64LqGQKQRv6pvA8GO7zczdoSgAF8/Y2hzqN/0QUS2Nzgme//95kB15Gc12WX8Lx9eDL70D1oReeFBo2W1s/aJMAYMZoPmLops2/cZWYHcZYMUMft3/sobR/CUcxAx1BXz1Luw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn; spf=pass smtp.mailfrom=189.cn; arc=none smtp.client-ip=14.18.100.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=189.cn
HMM_SOURCE_IP:10.158.243.220:0.1028407851
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-221.238.56.48 (unknown [10.158.243.220])
	by mail.189.cn (HERMES) with SMTP id E41E240008A;
	Wed, 21 Jan 2026 09:52:00 +0800 (CST)
Received: from  ([221.238.56.48])
	by gateway-153622-dep-587d8f56d7-fmbcm with ESMTP id 34ae48e4b0cf4a329f69e5a6c7593bcc for martin.lau@linux.dev;
	Wed, 21 Jan 2026 09:52:01 CST
X-Transaction-ID: 34ae48e4b0cf4a329f69e5a6c7593bcc
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
Subject: [PATCH] kernel/bpf/btf.c: reject to register duplicated kfunc
Date: Wed, 21 Jan 2026 09:51:57 +0800
Message-ID: <20260121015157.7283-1-chensong_2000@189.cn>
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
 kernel/bpf/btf.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0de8fc8a0e0b..1f3879fe163c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8498,12 +8498,23 @@ static int btf_check_iter_kfuncs(struct btf *btf, const char *func_name,
 	return 0;
 }
 
-static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags)
+static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags,
+			const struct module *module)
 {
 	const struct btf_type *func;
 	const char *func_name;
 	int err;
 
+	/* check if there is any duplicated kfunc in vmlinux */
+	if (module) {
+		func = btf_type_by_id(btf_vmlinux, func_id);
+		if (func) {
+			pr_err("kfunc %s is already present in vmlinux\n",
+						btf_name_by_offset(btf_vmlinux, func->name_off));
+			return -EINVAL;
+		}
+	}
+
 	/* any kfunc should be FUNC -> FUNC_PROTO */
 	func = btf_type_by_id(btf, func_id);
 	if (!func || !btf_type_is_func(func))
@@ -8757,7 +8768,7 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
 
 	for (i = 0; i < kset->set->cnt; i++) {
 		ret = btf_check_kfunc_protos(btf, btf_relocate_id(btf, kset->set->pairs[i].id),
-					     kset->set->pairs[i].flags);
+					     kset->set->pairs[i].flags, kset->owner);
 		if (ret)
 			goto err_out;
 	}
-- 
2.43.0

