Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8100436F429;
	Sat, 11 Apr 2026 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775925436; cv=none; b=byK0dY/EdZQPzaHnmNNt4vcTV9omB1/XApdOKzxfxq2fpb+Beg7giT2EjHyQ/6XsGJ7kBAtTOSEYSCsii0FbxAoTehFAJMaz44vmqf5uN2SHO+3kSmD1JEiH8wbRomy0y2FnDmAhirT/41CTBfi08IZhm4AbvbxzEZMez1ubdZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775925436; c=relaxed/simple;
	bh=L+KtQRlTAXKx0PY/nrhPg1vIfuz/F2JMq9aQpHac9Zs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XW3DmyMff3DV853uv5HyfoaW/0WZwnshP3XzfQAHlzz4QLIQ422TUEDASrUa8ajc+WE+dq1/1Blz4OD3NGGLUgB6LZwofI3jb74fU6u/bxXt3UyduSyHTDb3HJdvHSwZH1JwnzwkM9nhMHMiIjP7/4AHjutMcrd26ntwN5fOEuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZMjs4kHK; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZMjs4kHK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=eUzfUMQPK//xfBW
	QZREaUf6agV2XbhSRUCuLJHx6UUQ=; b=ZMjs4kHKv2/NEzpsB0EdmW19wv5Psu6
	fb2P74c+g1tu7UJqCRihtLRWVr9GL3GbclJpdaHr1sqx/ERZBrnT6BhdzHn3NBrz
	5YMsQcMnyeNRwzXO7wuu2yDn14fXoYR8aRAjzMrqqTs47+TuGT5Kt6LO/WFNSYFk
	lqqUNsgspX+I=
Received: from yang-Virtual-Machine.mshome.net (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAn3n9ueNppX_iUEg--.31671S3;
	Sun, 12 Apr 2026 00:36:00 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	jiayuan.chen@linux.dev,
	leon.hwang@linux.dev,
	menglong.dong@linux.dev
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Feng Yang <yangfeng@kylinos.cn>
Subject: [PATCH v3 bpf-next 1/2] bpf: Fix Null-Pointer Dereference in kernel_clone() via BPF fmod_ret on security_task_alloc
Date: Sun, 12 Apr 2026 00:35:55 +0800
Message-Id: <20260411163556.8567-2-yangfeng59949@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260411163556.8567-1-yangfeng59949@163.com>
References: <20260411163556.8567-1-yangfeng59949@163.com>
X-CM-TRANSID:_____wAn3n9ueNppX_iUEg--.31671S3
X-Coremail-Antispam: 1Uf129KBjvJXoWfGFyDZFy7GF4xKF48Cr4rZrb_yoWDCw1xpF
	W5Kr9xGr4vqw47Xr1xtF45Zr1ay3y8ZF45Cr95uryIyF1Yvw1DJ3WUGw4jgr98CrW8Gw1x
	ta12qw1xta4UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jIksDUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbCzxFLw2naeHEbQQAA32
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

From: Feng Yang <yangfeng@kylinos.cn>

Using the following BPF program will cause a kernel panic:
SEC("fmod_ret/security_task_alloc")
int fmod_task_alloc(void *ctx)
{
        return 1;
}

[  383.899321] BUG: kernel NULL pointer dereference, address: 0000000000000b99
[  383.899327] #PF: supervisor read access in kernel mode
[  383.899330] #PF: error_code(0x0000) - not-present page
[  383.899332] PGD 8000000108a60067 P4D 8000000108a60067 PUD 104550067 PMD 0
[  383.899341] Oops: Oops: 0000 [#1] SMP PTI
[  383.899346] CPU: 1 UID: 0 PID: 12925 Comm: test Kdump: loaded Not tainted 7.0.0-rc6+ #1 PREEMPT(lazy)
[  383.899349] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[  383.899351] RIP: 0010:get_task_pid+0x20/0x80
[  383.899358] Code: 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 55 89 f5 53 48 89 fb e8 0b 98 0a 00 85 ed 75 32 48 81 c3 98 0b 00 00 <48> 8b 1b 48 85 db 74 14 b8 01 00 00 00 f0 0f c1 03 85 c0 74 27 8d
[  383.899362] RSP: 0018:ffffd3ca0ab13b38 EFLAGS: 00010206
[  383.899367] RAX: 0000000000000001 RBX: 0000000000000b99 RCX: 0000000000000008
[  383.899371] RDX: ffff8b2c85860000 RSI: 0000000000000000 RDI: 0000000000000001
[  383.899374] RBP: 0000000000000000 R08: 0000010754cf50c8 R09: 0000010754cf50c8
[  383.899377] R10: ffffffff95a6c000 R11: 0000000000000024 R12: 0000000000000000
[  383.899380] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000001200000
[  383.899384] FS:  00007f3eae907740(0000) GS:ffff8b2d05e5c000(0000) knlGS:0000000000000000
[  383.899388] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  383.899390] CR2: 0000000000000b99 CR3: 0000000106a94003 CR4: 00000000000706f0
[  383.899393] Call Trace:
[  383.899397]  <TASK>
[  383.899401]  kernel_clone+0xe8/0x480
[  383.899406]  __do_sys_clone+0x65/0x90
[  383.899410]  do_syscall_64+0xca/0x860
[  383.899421]  ? next_uptodate_folio+0x85/0x2a0
[  383.899427]  ? percpu_counter_add_batch+0x4c/0x90
[  383.899434]  ? filemap_map_pages+0x3b7/0x4d0
[  383.899437]  ? do_read_fault+0x107/0x210
[  383.899442]  ? do_fault+0x1b2/0x330
[  383.899445]  ? __handle_mm_fault+0x49b/0x7a0
[  383.899448]  ? count_memcg_events+0xc4/0x160
[  383.899453]  ? handle_mm_fault+0xbb/0x370
[  383.899456]  ? do_user_addr_fault+0x209/0x680
[  383.899459]  ? irqentry_exit+0x7a/0x660
[  383.899462]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  383.899466] RIP: 0033:0x7f3eaeb426e7
[  383.899470] Code: 5d c3 90 f3 0f 1e fa 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 39 89 c2 85 c0 75 2c 64 48 8b 04 25 10 00 00
[  383.899472] RSP: 002b:00007fff23a2c838 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
[  383.899477] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3eaeb426e7
[  383.899479] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
[  383.899481] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  383.899483] R10: 00007f3eae907a10 R11: 0000000000000246 R12: 0000000000000001
[  383.899485] R13: 00007fff23a2dbe8 R14: 0000000000403de0 R15: 00007f3eaecf5000
[  383.899488]  </TASK>
[  383.899489] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set rfkill nf_tables sunrpc intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pmc_core pmt_telemetry snd_intel8x0 pmt_discovery pmt_class snd_ac97_codec intel_pmc_ssram_telemetry ac97_bus intel_vsec snd_pcm snd_timer snd rapl soundcore joydev sg i2c_piix4 pcspkr vboxguest i2c_smbus nfnetlink sr_mod cdrom sd_mod ata_generic vmwgfx ahci libahci ata_piix drm_ttm_helper ghash_clmulni_intel video ttm e1000 wmi libata serio_raw dm_mirror dm_region_hash dm_log dm_multipath dm_mod fuse i2c_dev autofs4
[  383.899624] CR2: 0000000000000b99

This is because
1. The BPF program is designed to override the normal behavior of
`security_task_alloc` and forcibly return a non-zero error value (e.g.,
`-ENOMEM` or `1`).
2. User space triggers a process creation syscall (like `fork` or
`clone`). The kernel invokes `copy_process` to allocate and initialize a
new `task_struct` for the child process.
3. `copy_process` invokes `security_task_alloc`. Due to the attached BPF
program, it returns the positive value `1`.
4. `copy_process` treats any non-zero return from `security_task_alloc`
as a failure. It aborts initialization, cleans up, and returns the error
code cast to a pointer via `ERR_PTR(1)` (which evaluates to the memory
address `0x1`).
5. In `kernel_clone()`, the kernel uses the `IS_ERR()` macro to check if
the returned `task_struct *p` is an error pointer. However, `IS_ERR()`
only checks for negative error codes in the range `[-MAX_ERRNO, -1]`.
Since `0x1` is not in this range, the check `IS_ERR(p)` evaluates to
`false`.
6. The kernel incorrectly assumes `p` is a valid `task_struct` pointer
and proceeds to call `get_task_pid(p, PIDTYPE_PID)`. This dereferences
the invalid address `0x1` (plus the offset of the `thread_pid` field),
triggering a general protection fault or null-pointer dereference.

Therefore, for security-related functions, similar to LSM,
the validity of their return values is verified to fix the issue.
Return value validation for fault injection is also added accordingly.

Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
Closes: https://lore.kernel.org/bpf/973a1b7b-8ee7-407a-890a-11455d9cc5bf@std.uestc.edu.cn/
Fixes: 6ba43b761c41 ("bpf: Attachment verification for BPF_MODIFY_RETURN")
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 kernel/bpf/verifier.c | 114 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 112 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 56fcc96dc780..8285f626919e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18363,6 +18363,112 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	return 0;
 }
 
+#ifdef CONFIG_FUNCTION_ERROR_INJECTION
+
+/*
+ * The return values corresponding to the error injection
+ * types shall be interpreted as follows:
+ *
+ * EI_ETYPE_NULL
+ *   This function will return `NULL` if it fails. e.g. return an allocated
+ *   object address.
+ *
+ * EI_ETYPE_ERRNO
+ *   This function will return an `-errno` error code if it fails. e.g. return
+ *   -EINVAL if the input is wrong. This will include the functions which will
+ *   return an address which encodes `-errno` by ERR_PTR() macro.
+ *
+ * EI_ETYPE_ERRNO_NULL
+ *   This function will return an `-errno` or `NULL` if it fails. If the caller
+ *   of this function checks the return value with IS_ERR_OR_NULL() macro, this
+ *   type will be appropriate.
+ *
+ * EI_ETYPE_TRUE
+ *   This function will return `true` (non-zero positive value) if it fails.
+ *
+ * Since returning 0 from modify_return means not modifying the return value,
+ * 0 must always be included.
+ */
+static int modify_return_get_retval_range(const struct bpf_prog *prog,
+					  struct bpf_retval_range *range)
+{
+	unsigned long addr = (unsigned long)prog->aux->dst_trampoline->func.addr;
+
+	if (within_error_injection_list(addr)) {
+		switch (get_injectable_error_type(addr)) {
+		case EI_ETYPE_NULL:
+			range->minval = 0;
+			range->maxval = 0;
+			break;
+		case EI_ETYPE_ERRNO:
+		case EI_ETYPE_ERRNO_NULL:
+			range->minval = -MAX_ERRNO;
+			range->maxval = 0;
+			break;
+		case EI_ETYPE_TRUE:
+			range->minval = 0;
+			range->maxval = 1;
+			break;
+		}
+		range->return_32bit = true;
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+#else
+
+/* The system call return value is allowed to be an arbitrary value. */
+static int modify_return_get_retval_range(const struct bpf_prog *prog,
+					  struct bpf_retval_range *range)
+{
+	return -EINVAL;
+}
+
+#endif /* CONFIG_FUNCTION_ERROR_INJECTION */
+
+#define SECURITY_PREFIX "security_"
+/* hooks return 0 or 1 */
+BTF_SET_START(bool_security_hooks)
+#ifdef CONFIG_SECURITY_NETWORK_XFRM
+BTF_ID(func, security_xfrm_state_pol_flow_match)
+#endif
+#ifdef CONFIG_AUDIT
+BTF_ID(func, security_audit_rule_known)
+#endif
+/*
+ * The inode_xattr_skipcap hook is called from within
+ * security_inode_removexattr and security_inode_setxattr.
+ * Since these two functions can also return values from
+ * inode_removexattr and inode_setxattr respectively,
+ * there is no need to restrict their return values to 0 or 1.
+ */
+BTF_SET_END(bool_security_hooks)
+
+/*
+ * Similar to bpf_lsm_get_retval_range,
+ * ensure that the return values of fmod_ret are valid.
+ */
+static int bpf_security_get_retval_range(const struct bpf_prog *prog,
+					 struct bpf_retval_range *range)
+{
+	if (strncmp(SECURITY_PREFIX, prog->aux->attach_func_name,
+		    sizeof(SECURITY_PREFIX) - 1))
+		return -EINVAL;
+
+	if (btf_id_set_contains(&bool_security_hooks, prog->aux->attach_btf_id)) {
+		range->minval = 0;
+		range->maxval = 1;
+	} else {
+		range->minval = -MAX_ERRNO;
+		range->maxval = 0;
+	}
+	range->return_32bit = true;
+
+	return 0;
+}
 
 static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_range *range)
 {
@@ -18416,8 +18522,13 @@ static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_
 			*range = retval_range(0, 0);
 			break;
 		case BPF_TRACE_RAW_TP:
-		case BPF_MODIFY_RETURN:
 			return false;
+		case BPF_MODIFY_RETURN:
+			if (!bpf_security_get_retval_range(env->prog, range))
+				break;
+			if (modify_return_get_retval_range(env->prog, range))
+				return false;
+			break;
 		case BPF_TRACE_ITER:
 		default:
 			break;
@@ -25460,7 +25571,6 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	return bpf_prog_ctx_arg_info_init(prog, st_ops_desc->arg_info[member_idx].info,
 					  st_ops_desc->arg_info[member_idx].cnt);
 }
-#define SECURITY_PREFIX "security_"
 
 #ifdef CONFIG_FUNCTION_ERROR_INJECTION
 
-- 
2.43.0

