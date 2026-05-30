Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BAA34A76E;
	Sat, 30 May 2026 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780137332; cv=none; b=bzVsZl4RYPijAyhZf4e4tU8WmEBFNPyNUAQM7Rl587UQS+BO77/cj4654h/4MKN5+AJT4Cn7niWnm8uUBVvK3/mlMFbCxf6LVgkhBG3TZMfBskZq6Xa11JAeMtcWX+WT2nCg2znl3j56oFIczAxMUbCLoWElGF75UGpV4mfp9J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780137332; c=relaxed/simple;
	bh=11n+go22BVkAQgfxqeQx2BJRZaQQOuaukzdDdQx7cFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZExuigdovyo0/CdoxinKjX2f5rRMXP2sUSs8uXEjllagM+ETe6lUFH6oulwHFeRB0Mrq6h4NwyAqcOEN973OBem598jxCpV6gOKvlfy4Hb9LT6ii92MVZoGNq1CBTih5jurjSUACFxlT7cRK5HSBieeuFkFzhrnloRnMMxXgL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gSGnj75P5zKHMY3;
	Sat, 30 May 2026 18:35:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4EDB240573;
	Sat, 30 May 2026 18:35:25 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP4 (Coremail) with SMTP id gCh0CgCXrFhpvRpqo6izEA--.19629S3;
	Sat, 30 May 2026 18:35:25 +0800 (CST)
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
Subject: [PATCH bpf v3 1/3] bpf: Add validation for bpf_set_retval argument
Date: Sat, 30 May 2026 10:12:37 +0000
Message-ID: <20260530101239.590395-2-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530101239.590395-1-xukuohai@huaweicloud.com>
References: <20260530101239.590395-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXrFhpvRpqo6izEA--.19629S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAFW8Xw1kCF45Kw47Jry7KFg_yoWrWry8pr
	4fGryqyr1qgr4xWws3ta4kZF1Fyw40g3yfKr97X34Syw43Kry3u34UW3yY9rySyF1kGw10
	qF4jvFZ09a4jya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2HGQ
	DUUUU
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
  returned directly to userspace as the read()/write() syscall return value.

So add validation for the argument of the bpf_set_retval() helper.

For BPF_LSM_CGROUP, the same validation as BPF_LSM_MAC is enforced,
i.e. validate the argument against the LSM hook specific range, which
is returned by bpf_lsm_get_retval_range().

For all other cgroup program types, restrict the argument to
[-MAX_ERRNO, 0], which matches the kernel convention of 0 for success
and negative errno for error.

Since the return value type is always int, also restrict the argument type
to scalar.

Fixes: b44123b4a3dc ("bpf: Add cgroup helpers bpf_{get,set}_retval to get/set syscall return value")
Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
Closes: https://lore.kernel.org/all/567d3206-74a5-44e5-99c6-779c425f399e@std.uestc.edu.cn
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 kernel/bpf/verifier.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7fb88e1cd7c4..4948bd4bf9e1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10460,6 +10460,19 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
 		if (prog_type == BPF_PROG_TYPE_LSM &&
 		    env->prog->expected_attach_type == BPF_LSM_CGROUP) {
 			if (!env->prog->aux->attach_func_proto->type) {
@@ -10469,8 +10482,20 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 				verbose(env, "BPF_LSM_CGROUP that attach to void LSM hooks can't modify return value!\n");
 				return -EINVAL;
 			}
+			bpf_lsm_get_retval_range(env->prog, &range);
 		}
+
+		err = mark_chain_precision(env, BPF_REG_1);
+		if (err)
+			return err;
+
+		if (!retval_range_within(range, r1)) {
+			verbose_invalid_scalar(env, r1, range, "At bpf_set_retval", "R1");
+			return -EINVAL;
+		}
+
 		break;
+	}
 	case BPF_FUNC_dynptr_data:
 	{
 		struct bpf_reg_state *reg;
-- 
2.43.0

