Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565584A33;
	Sat, 20 Jun 2026 15:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781967889; cv=none; b=jRVcQyFAKVgEjjdFe3MJljCvek6/ez3yF1JeetrGebp4Cm0OjccRdUOHcx9NxlUsjMVpOfcrw8okJMhwhStc+WkEyl9Bt8HP9SCc+syrK6dWYRbGZJhlJNCf1haIJYYCo4cC14eNFTZNkmv8PbNVxmwlVBAZpWMu5e9O2Ao2lOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781967889; c=relaxed/simple;
	bh=YuGasS3D3LRWWFlLtX5EqsC5xUidBHqBp+10GdwPc30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OYboes+fgOZS4p/budQix30FlIQFMsXvEQiMF04IivYL3TaWmsnhpuLbXaem5JoQsxIKOn9Jhp2w45D0AcB6EQjly6rhFw5/YzbMLv0S5iCWSmXxNEd4lfXuFzGpP1avgrDC555APmUljIeGQZDcZsIS88U5xjf16SUUD0aKMFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=pknDpS4t; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="pknDpS4t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=1S3qMxpVdADiN+oMZfZhz1ytC8296YyNSG
	AdCQBpK+c=; b=pknDpS4tvciQJ6MOwn9KMfCIQBmyBb5UFagvGJMFYIyHsPGc0g
	dyv6ZrO9jN7b8oddbQo0214fOy2Sc+3PzDFF/k+89xuNsyUWWcMrsa38mDtUU3PW
	tBDTCibphvPCE6uCsxjYyBxuvpdwB513TC2vr2TCxlYFmdt0HUyVyUHgE=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web4 (Coremail) with SMTP id ywQGZQBnep_zqzZqVGBnAg--.37531S3;
	Sat, 20 Jun 2026 23:04:28 +0800 (CST)
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
Subject: [PATCH bpf-next v2 1/2] bpf: Reject offset refcount acquire arguments
Date: Sat, 20 Jun 2026 15:04:17 +0000
Message-Id: <faad6ed6ab46008e1b0ca5c490a706dbebb80ea8.1781963957.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781963957.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1781852308.git.chenyy23@mails.tsinghua.edu.cn> <cover.1781963957.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQBnep_zqzZqVGBnAg--.37531S3
X-Coremail-Antispam: 1UD129KBjvJXoWxurW3uryfZF17Cr15ZF4DCFg_yoWrXFyUpa
	n5Gr97ArWktFWS93WqyFn7ZryrCw1vq3yakF1vkw1xZFy3Jw1kJa909r1Uta4Sk3Wvyw1q
	qF1j9rW3Zwn8ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUdjb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIE
	c7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2
	xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2
	jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5V
	A0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_
	Wrylc2xSY4AK67AK6ryrMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
	ZEXa7xRAl19UUUUUU==
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
 include/linux/bpf.h   |  3 +++
 kernel/bpf/verifier.c | 18 +++++++++++-------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7719f6528..b9b7d19cb 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -859,6 +859,9 @@ enum bpf_type_flag {
 	/* DYNPTR points to file */
 	DYNPTR_TYPE_FILE	= BIT(20 + BPF_BASE_TYPE_BITS),
 
+	/* PTR argument cannot have a fixed offset. */
+	PTR_ZERO_OFF		= BIT(21 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
 };
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2abc79dbf..b41aee8c6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7994,8 +7994,11 @@ static int check_func_arg_reg_off(struct bpf_verifier_env *env,
 				  const struct bpf_reg_state *reg, argno_t argno,
 				  enum bpf_arg_type arg_type)
 {
+	bool fixed_off_ok = !(arg_type & PTR_ZERO_OFF);
 	u32 type = reg->type;
 
+	arg_type &= ~PTR_ZERO_OFF;
+
 	/* When referenced register is passed to release function, its fixed
 	 * offset must be 0.
 	 *
@@ -8048,13 +8051,12 @@ static int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF:
 	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU:
 		/* When referenced PTR_TO_BTF_ID is passed to release function,
-		 * its fixed offset must be 0. In the other cases, fixed offset
-		 * can be non-zero. This was already checked above. So pass
-		 * fixed_off_ok as true to allow fixed offset for all other
-		 * cases. var_off always must be 0 for PTR_TO_BTF_ID, hence we
-		 * still need to do checks instead of returning.
+		 * or when the argument type requires zero fixed offset, its
+		 * fixed offset must be 0. In the other cases, fixed offset can
+		 * be non-zero. var_off always must be 0 for PTR_TO_BTF_ID,
+		 * hence we still need to do checks instead of returning.
 		 */
-		return __check_ptr_off_reg(env, reg, argno, true);
+		return __check_ptr_off_reg(env, reg, argno, fixed_off_ok);
 	case PTR_TO_CTX:
 		/*
 		 * Allow fixed and variable offsets for syscall context, but
@@ -12114,7 +12116,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_MEM:
 		case KF_ARG_PTR_TO_MEM_SIZE:
 		case KF_ARG_PTR_TO_CALLBACK:
-		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
 		case KF_ARG_PTR_TO_CONST_STR:
 		case KF_ARG_PTR_TO_WORKQUEUE:
 		case KF_ARG_PTR_TO_TIMER:
@@ -12128,6 +12129,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_CTX:
 			arg_type = ARG_PTR_TO_CTX;
 			break;
+		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
+			arg_type = ARG_PTR_TO_BTF_ID | PTR_ZERO_OFF;
+			break;
 		default:
 			verifier_bug(env, "unknown kfunc arg type %d", kf_arg_type);
 			return -EFAULT;
-- 
2.34.1

