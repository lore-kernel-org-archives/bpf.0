Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B4B312803;
	Mon, 22 Jun 2026 02:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782095198; cv=none; b=a1D/CdbE2wKHN8xddzf7iOFjdvo4Km/D9wedNxZ4T6Ck3JtPmzX8kqjnvs5CVzyYfVQy64RX20zoBJ/b6cB1ZgESf1+DM98TtzRgaSFM8S2IAuTeGpE+G5Ms2VPYKD17vT2Z4Y70/FncZe2BumsFISBmKraI6cBAiXr19svbLt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782095198; c=relaxed/simple;
	bh=jfX9bbXwEAn2RIE/tOqMtrsGH9uMCaFLjXlT9MmoLJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mIXoxr+r9AnN3T6iDPxdxANLcytafNrYhFSTAtXxxGEj5O/JbP7j4RCoXmirtcSFO6JXMpuoa+eOJHYMX3bzbKjuK2YgR0sixTRyL0S27ckgSn0WP4J1ZUeyl4GdEE3SRDHw8PR+/LaCZEjZqfcF3oyJuMlzb7ebOi4FTLSLR0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=oWnBGItJ; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="oWnBGItJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=QhPbn/Ffv7vIq715w4RbiIsqdEaBuGnIsw
	sZGv4+yKs=; b=oWnBGItJpzggIxAD+n8Zw8oSWB1CnZ28np9cygjNyWAudBEVhr
	W7ycx+ncUZrw/ddXJgM+Ae2hmc3ZBaX3MpHKvWJ/gD6FO6mWXOB47jhV0zj/pphK
	473Zaq9Vul/xmaNtuO/KbuH0vTjOeYCxttOP4RA1qc5tZoKJOj3ZZXfOY=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web5 (Coremail) with SMTP id zAQGZQCHQcEynThqj7qZAg--.19827S3;
	Mon, 22 Jun 2026 10:26:13 +0800 (CST)
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
	Viktor Malik <vmalik@redhat.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 1/2] bpf: Reject offset refcount acquire arguments
Date: Mon, 22 Jun 2026 02:25:51 +0000
Message-Id: <f5d4097299d00f3dc6bf93f01257778da828604d.1781979133.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781979133.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1781963957.git.chenyy23@mails.tsinghua.edu.cn> <cover.1781979133.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zAQGZQCHQcEynThqj7qZAg--.19827S3
X-Coremail-Antispam: 1UD129KBjvJXoWxurW3uryfZF17Cr15ZF4DCFg_yoWrtrW7pa
	n5Kr92yr4ktayfuwsrtF4DAr95G34Fq3y3CFy8Aa4I9FyfWw1DJFZ09ryjq3WSk34kAwnr
	Ar1093sxZw15CF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUd0b7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv
	6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEnc
	xIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E
	87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c
	0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a
	6rW5MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x0pEoGQxUUUUU=
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

bpf_refcount_acquire() increments the refcount at the caller-supplied
pointer plus the refcount field offset, then returns the caller-supplied
pointer unchanged.

The verifier records the return value as a base pointer to the refcounted
object.

bpf_list_pop_front() and bpf_rbtree_remove() can return embedded
graph-node pointers as PTR_TO_BTF_ID | MEM_ALLOC with a fixed offset equal
to the node field offset. Passing such a pointer directly to
bpf_refcount_acquire() currently passes the refcounted-kptr type check.

That makes the runtime operation start from base + node_off while the
verifier models the returned pointer as the object base.

Require refcount-acquire arguments to have zero fixed offset by carrying
the requirement through check_func_arg_reg_off() to __check_ptr_off_reg().
Programs can still acquire a refcount from a graph-node-derived pointer
after normalizing it with container_of().

Fixes: 7c50b1cb76aca ("bpf: Add bpf_refcount_acquire kfunc")
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 kernel/bpf/verifier.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2abc79dbf..f65eff28e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7990,9 +7990,10 @@ reg_find_field_offset(const struct bpf_reg_state *reg, s32 off, u32 fields)
 	return field;
 }
 
-static int check_func_arg_reg_off(struct bpf_verifier_env *env,
-				  const struct bpf_reg_state *reg, argno_t argno,
-				  enum bpf_arg_type arg_type)
+static int __check_func_arg_reg_off(struct bpf_verifier_env *env,
+				    const struct bpf_reg_state *reg, argno_t argno,
+				    enum bpf_arg_type arg_type,
+				    bool btf_id_fixed_off_ok)
 {
 	u32 type = reg->type;
 
@@ -8049,12 +8050,11 @@ static int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU:
 		/* When referenced PTR_TO_BTF_ID is passed to release function,
 		 * its fixed offset must be 0. In the other cases, fixed offset
-		 * can be non-zero. This was already checked above. So pass
-		 * fixed_off_ok as true to allow fixed offset for all other
-		 * cases. var_off always must be 0 for PTR_TO_BTF_ID, hence we
-		 * still need to do checks instead of returning.
+		 * can be non-zero unless the caller requires otherwise.
+		 * var_off always must be 0 for PTR_TO_BTF_ID, hence we still
+		 * need to do checks instead of returning.
 		 */
-		return __check_ptr_off_reg(env, reg, argno, true);
+		return __check_ptr_off_reg(env, reg, argno, btf_id_fixed_off_ok);
 	case PTR_TO_CTX:
 		/*
 		 * Allow fixed and variable offsets for syscall context, but
@@ -8070,6 +8070,13 @@ static int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	}
 }
 
+static int check_func_arg_reg_off(struct bpf_verifier_env *env,
+				  const struct bpf_reg_state *reg, argno_t argno,
+				  enum bpf_arg_type arg_type)
+{
+	return __check_func_arg_reg_off(env, reg, argno, arg_type, true);
+}
+
 static int check_arg_const_str(struct bpf_verifier_env *env,
 			       struct bpf_reg_state *reg, argno_t argno)
 {
@@ -11941,6 +11948,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		enum bpf_arg_type arg_type = ARG_DONTCARE;
 		argno_t argno = argno_from_arg(i + 1);
 		int regno = reg_from_argno(argno);
+		bool btf_id_fixed_off_ok = true;
 		u32 ref_id, type_size;
 		bool is_ret_buf_sz = false;
 		int kf_arg_type;
@@ -12114,7 +12122,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_MEM:
 		case KF_ARG_PTR_TO_MEM_SIZE:
 		case KF_ARG_PTR_TO_CALLBACK:
-		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
 		case KF_ARG_PTR_TO_CONST_STR:
 		case KF_ARG_PTR_TO_WORKQUEUE:
 		case KF_ARG_PTR_TO_TIMER:
@@ -12128,6 +12135,10 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_CTX:
 			arg_type = ARG_PTR_TO_CTX;
 			break;
+		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
+			arg_type = ARG_PTR_TO_BTF_ID;
+			btf_id_fixed_off_ok = false;
+			break;
 		default:
 			verifier_bug(env, "unknown kfunc arg type %d", kf_arg_type);
 			return -EFAULT;
@@ -12135,7 +12146,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 
 		if (regno == meta->release_regno)
 			arg_type |= OBJ_RELEASE;
-		ret = check_func_arg_reg_off(env, reg, argno, arg_type);
+		ret = __check_func_arg_reg_off(env, reg, argno, arg_type,
+					       btf_id_fixed_off_ok);
 		if (ret < 0)
 			return ret;
 
-- 
2.34.1

