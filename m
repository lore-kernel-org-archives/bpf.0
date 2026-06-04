Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E969A478E2B;
	Thu,  4 Jun 2026 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579690; cv=none; b=QDBvqVCg0xQhnSuaGpDqY+9yfCoIdu/ijjzJiOpu9EyIthPZwOwnH9om3mjUtdat3FRQMRU70bx16z2T265KmjYwgcpLudC6soKQEV9LxfCgM7ROKsqtQm4Pm4x/6PMc2fNO647JPnQeA6PAefLElkZVEc64GfNylxdV4/QDUgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579690; c=relaxed/simple;
	bh=HGFWqzfX/8kHLdfVqAY+rikQ+O//j1v3bdQfjSLZOLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqHfpNJ5C8+FDHkOnc2mlZPyzC3fR59QK6LzXenVAQ+hYtC9GJIJ4CuyOQZFiSN+Nj1KXQld256nFUDNqm3JwEhXr6WOHGQRDzudZgZ6oGVazvOPQOk7C1NbqkRHgdGmDzpB6CEpiHKwPbUMan+J2CMtUzUAkb7Iac2zbzdDjrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gWQNK1WyYzKHMZ2;
	Thu,  4 Jun 2026 21:27:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id BB4F44058C;
	Thu,  4 Jun 2026 21:27:56 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP2 (Coremail) with SMTP id Syh0CgCH_oNZfSFqyEtmAg--.28555S4;
	Thu, 04 Jun 2026 21:27:56 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	YiFei Zhu <zhuyifei@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Quan Sun <2022090917019@std.uestc.edu.cn>
Subject: [PATCH bpf v4 2/3] bpf: Add validation for bpf_set_retval argument
Date: Thu,  4 Jun 2026 13:04:57 +0000
Message-ID: <20260604130458.617765-3-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604130458.617765-1-xukuohai@huaweicloud.com>
References: <20260604130458.617765-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCH_oNZfSFqyEtmAg--.28555S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar4UArWfZFWkur4xCFW3Wrg_yoW7ury3pF
	4fGryqyr1DWr4Igw4ft3Z7ZF4Fyw40grWFkF97J3sFyw43Kw1fGr1jgw4agryayFykGw1I
	ga1jvws8ua4UZa7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFSdy
	UUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

The bpf_set_retval() helper is used by cgroup BPF programs to set the
return value of the target hook. The argument type for this helper is
ARG_ANYTHING. This allows setting a positive value, which no cgroup
hook expects and can cause issues, such as:

- BPF_LSM_CGROUP: a positive value from bpf_lsm_socket_create bypasses
  the err < 0 check in __sock_create(), leaving the socket object
  unallocated. The positive return value is then propagated to the
  syscall entry __sys_socket(), which also bypasses the IS_ERR() guard
  and ultimately causes a NULL pointer dereference.

- BPF_CGROUP_DEVICE: a positive value can be returned through cgroup
  device bpf prog -> devcgroup_check_permission() -> bdev_permission()
  -> bdev_file_open_by_dev(), where ERR_PTR(positive) produces a pointer
  that IS_ERR() does not catch, leading to a wild pointer dereference.

- BPF_CGROUP_SOCK: a positive value can be returned through cgroup sock
  bpf prog -> __cgroup_bpf_run_filter_sk() -> inet_create() ->
  __sock_create(), where inet_create() frees the newly allocated sk
  via sk_common_release() and sets sock->sk = NULL on the non-zero
  return, but __sock_create() only checks err < 0 for cleanup, so a
  positive retval bypasses cleanup and returns a socket with NULL sk
  to userspace, triggering a NULL pointer dereference on subsequent
  socket operations.

- BPF_CGROUP_SYSCTL: a positive value can be returned through the cgroup
  bpf prog -> __cgroup_bpf_run_filter_sysctl() -> proc_sys_call_handler(),
  where a non-zero return bypasses the normal sysctl proc_handler and is
  returned directly to userspace as return value of read() or write()
  syscall.

So add validation for the argument of the bpf_set_retval() helper.

For BPF_LSM_CGROUP, enforce the LSM hook specific range returned by
bpf_lsm_get_retval_range().

For all other cgroup program types, restrict the argument to
[-MAX_ERRNO, 0], which matches the kernel convention of 0 for success
and negative errno for error.

BPF_CGROUP_GETSOCKOPT is an exception, since valid getsockopt
implementations may return positive values, as allowed by commit
c4dcfdd406aa ("bpf: Move getsockopt retval to struct bpf_cg_run_ctx").

Also refine the return value range of bpf_get_retval() so that
values returned by bpf_get_retval() can be passed directly to
bpf_set_retval() without extra manual bounds checking.

Fixes: b44123b4a3dc ("bpf: Add cgroup helpers bpf_{get,set}_retval to get/set syscall return value")
Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
Closes: https://lore.kernel.org/all/567d3206-74a5-44e5-99c6-779c425f399e@std.uestc.edu.cn
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 kernel/bpf/verifier.c | 54 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c8d980fdd709..32b4d88c5b32 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9790,6 +9790,7 @@ static int do_refine_retval_range(struct bpf_verifier_env *env,
 				  int func_id,
 				  struct bpf_call_arg_meta *meta)
 {
+	struct bpf_retval_range range;
 	struct bpf_reg_state *ret_reg = &regs[BPF_REG_0];
 
 	if (ret_type != RET_INTEGER)
@@ -9810,6 +9811,29 @@ static int do_refine_retval_range(struct bpf_verifier_env *env,
 		reg_set_urange32(ret_reg, 0, nr_cpu_ids - 1);
 		reg_bounds_sync(ret_reg);
 		break;
+	case BPF_FUNC_get_retval:
+		/*
+		 * bpf_get_reval may see arbitrary value passed by bpf_prog_run_array_cg for
+		 * CGROUP_GETSOCKOPT type.
+		 */
+		if (env->prog->type == BPF_PROG_TYPE_CGROUP_SOCKOPT &&
+		    env->prog->expected_attach_type == BPF_CGROUP_GETSOCKOPT)
+			break;
+
+		if (env->prog->type == BPF_PROG_TYPE_LSM &&
+		    env->prog->expected_attach_type == BPF_LSM_CGROUP) {
+			if (!env->prog->aux->attach_func_proto->type)
+				break;
+			bpf_lsm_get_retval_range(env->prog, &range);
+		} else {
+			range.minval = -MAX_ERRNO;
+			range.maxval = 0;
+		}
+
+		reg_set_srange64(ret_reg, range.minval, range.maxval);
+		reg_set_srange32(ret_reg, range.minval, range.maxval);
+		reg_bounds_sync(ret_reg);
+		break;
 	}
 
 	return reg_bounds_sanity_check(env, ret_reg, "retval");
@@ -10290,6 +10314,24 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		}
 		break;
 	case BPF_FUNC_set_retval:
+	{
+		struct bpf_retval_range range = {
+			.minval = -MAX_ERRNO,
+			.maxval = 0,
+			.return_32bit = true
+		};
+		struct bpf_reg_state *r1 = &regs[BPF_REG_1];
+
+		if (r1->type != SCALAR_VALUE) {
+			verbose(env, "R1 is not a scalar\n");
+			return -EINVAL;
+		}
+
+		/* CGROUP_GETSOCKOPT is allowed to return arbitrary value */
+		if (env->prog->type == BPF_PROG_TYPE_CGROUP_SOCKOPT &&
+		    env->prog->expected_attach_type == BPF_CGROUP_GETSOCKOPT)
+			break;
+
 		if (prog_type == BPF_PROG_TYPE_LSM &&
 		    env->prog->expected_attach_type == BPF_LSM_CGROUP) {
 			if (!env->prog->aux->attach_func_proto->type) {
@@ -10299,8 +10341,20 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 				verbose(env, "BPF_LSM_CGROUP that attach to void LSM hooks can't modify return value!\n");
 				return -EINVAL;
 			}
+			bpf_lsm_get_retval_range(env->prog, &range);
+		}
+
+		err = mark_chain_precision(env, BPF_REG_1);
+		if (err)
+			return err;
+
+		if (!retval_range_within(range, r1)) {
+			verbose_invalid_scalar(env, r1, range, "At bpf_set_retval", "R1");
+			return -EINVAL;
 		}
+
 		break;
+	}
 	case BPF_FUNC_dynptr_data:
 	{
 		struct bpf_reg_state *reg;
-- 
2.47.3

