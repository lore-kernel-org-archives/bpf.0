Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D4835F5E5;
	Fri, 29 May 2026 03:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780024575; cv=none; b=aYdKjYMNNYegivgaGOMlm3DimYFSoZL8W7nDciWBmhI/u3tgMit3qJUc2hT46ie1ihkAOWaoAu2AkECAA6PKRN1uK0R+m++XAmCyFrUmCQ0WLent6O409Plfbq4ddh9RVFITqt276KuMISXR8leL8aAzsUk0e8QluknDODiWB+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780024575; c=relaxed/simple;
	bh=6/ZwVssSp+W4X6/o9p3otG3dRffTDo/V0TX43jDZ38o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o2ObUhjRrojhZmxSFUpcKn1y4qCKQK+yax+nUvdi7kaecVHuuQ+2/2lyI1Wgkmp7zqZaDmm5A6KkgeyLYp3yQXjzS1Q1NGG2J5vsI9armauMzQ/zJDQfpPjXRGVZ+FviIavqZijyN5DDku+DpJSz3CBMjgjm8uOvqPhrdxMRhNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=UttDY9lA; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="UttDY9lA"
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 40433aa49;
	Fri, 29 May 2026 11:10:55 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: martin.lau@linux.dev
Cc: emil@etsalapatis.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	kees@kernel.org,
	joel.granados@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH v2 2/3] bpf: cgroup: NUL-terminate replaced sysctl value
Date: Fri, 29 May 2026 11:10:25 +0800
Message-Id: <20260529031026.2716641-3-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529031026.2716641-1-dawei.feng@seu.edu.cn>
References: <20260529031026.2716641-1-dawei.feng@seu.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e71b6a46d03a2kunm60a0b1e7a4154
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGE1CVhpMT0lNHh0ZQkwdQlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
	5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=UttDY9lAPe6MPlJvCM4XdgYP4+e6/XR2Dtrx5QmIqWFZxYFOE32FRZ4Up1yaicRT/pCuoA5Dwdj5jlQb7n1ggxiIT2i8oyrex1oB8wSLvgiMM9hv0Wuxya7/E8PukbKXGpYVJIe68gUYoyKNd9/+KDnR4X4zq0lifn1E8TU85ww=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=+Ijto3SdXKeXPrvddw2yO9U94NT/NXxtKGnu3Bs8Iac=;
	h=date:mime-version:subject:message-id:from;

When writing to sysctls, proc_sys_call_handler() guarantees that the
buffer passed to proc handlers is NUL-terminated. If
bpf_sysctl_set_new_value() replaces the pending sysctl value, it can
hand a replacement buffer directly to proc handlers. However, the
helper currently copies only buf_len
bytes into that buffer without appending a NUL terminator, leaving
downstream parsers vulnerable to out-of-bounds access.

Fix this by appending a '\0' after the replaced value to restore the
expected sysctl semantics. Since the helper already rejects buf_len
greater than PAGE_SIZE - 1, there is always room for the extra byte.

Reproduced in a QEMU x86_64 guest booted with KASAN while exercising
the sysctl replacement path with a cgroup/sysctl BPF program. The
reproducer targets `/proc/sys/net/core/flow_limit_cpu_bitmap`, fills
the original user write buffer with non-zero bytes, and overrides the
sysctl value so the replacement buffer lacks a terminating NUL. Under
that setup, the pre-fix kernel reported:

  BUG: KASAN: slab-out-of-bounds in strnchrnul+0x72/0x90
  Read of size 1 at addr ffff88800de57000 by task repro_patch3/66
  CPU: 0 UID: 0 PID: 66 Comm: repro_patch3 Not tainted 7.1.0-rc3-00269-g8370ca1f87cc #6 PREEMPT(lazy)
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
  Call Trace:
   <TASK>
   dump_stack_lvl+0x68/0xa0
   print_report+0xcb/0x5e0
   ? __virt_addr_valid+0x21d/0x3f0
   ? strnchrnul+0x72/0x90
   ? strnchrnul+0x72/0x90
   kasan_report+0xca/0x100
   ? strnchrnul+0x72/0x90
   strnchrnul+0x72/0x90
   bitmap_parse+0x37/0x2e0
   flow_limit_cpu_sysctl+0xc6/0x840
   ? __pfx_flow_limit_cpu_sysctl+0x10/0x10
   ? __kvmalloc_node_noprof+0x5ba/0x870
   proc_sys_call_handler+0x31d/0x480
   ? __pfx_proc_sys_call_handler+0x10/0x10
   ? selinux_file_permission+0x39f/0x500
   ? lock_is_held_type+0x9e/0x120
   vfs_write+0x98e/0x1000
   ? kmem_cache_free+0x308/0x550
   ? __pfx_vfs_write+0x10/0x10
   ? __pfx_do_sys_openat2+0x10/0x10
   ksys_write+0xf2/0x1d0
   ? __pfx_ksys_write+0x10/0x10
   ? trace_irq_enable.constprop.0+0x110/0x140
   do_syscall_64+0x115/0x690
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   RIP: 0033:0x447f37
   Code: ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
   RSP: 002b:00007fff01ade608 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
   RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000447f37
   RDX: 0000000000001fff RSI: 00000000172b1780 RDI: 0000000000000005
   RBP: 00000000172b1780 R08: 00000000004ca1b0 R09: 00000000172b1780
   R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000001fff
   R13: 0000000000000000 R14: 0000000000000005 R15: 0000000000000003
   </TASK>
  The buggy address is located 0 bytes to the right of
  allocated 4096-byte region [ffff88800de56000, ffff88800de57000)

With this fix applied, rerunning the same sysctl-targeted path yields
no corresponding KASAN reports.

Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
---
 kernel/bpf/cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index faadcfb9b5e5..a0b5f8cd8b10 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2342,6 +2342,7 @@ BPF_CALL_3(bpf_sysctl_set_new_value, struct bpf_sysctl_kern *, ctx,
 		return -E2BIG;
 
 	memcpy(ctx->new_val, buf, buf_len);
+	((char *)ctx->new_val)[buf_len] = '\0';
 	ctx->new_len = buf_len;
 	ctx->new_updated = 1;
 
-- 
2.34.1

