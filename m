Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7276236DA0F
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775132348; cv=none; b=aSYn2O2BOMJgDq7SD2kXjsz+eI0OL+POPgHQQO1ZVPI7TjBKiB0pA87PvW2g6OqkidPTXGP2SG2sq3AnBSi42o5n3d3Rj3rXohJxoOlZ8VEz86rzHApZ+G6debZlV/v3wey9MvDSGKOp4lNmLeva/cTTnxFe5fWRx6VQR0qPXm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775132348; c=relaxed/simple;
	bh=9FODWdXDEBuA5ZUj9L56F+jEupBPZePwiw5kABSsSb0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=PxWfZzK3S05/jTz1BoXJ1dkdxP7eQJ8ikNF2EGbc6fyWLnGyjg6FjeMkLbc+zpL158FJ9QTX+epSPvcaOGr1ZcUs+eEQNqPb8CL7U/Rkx3tJLFm9WwUY9/yk/ZuDEisZAbGckImWluiWoYRHUo0ij1GJDg1iknaCYr1+H4wfIws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=jzvI8BqM; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="jzvI8BqM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1775132341; bh=YjjCmZOrW4REFAVBzGGbqDrfiq8sy+usJO2oakX7oVc=;
	h=From:To:Cc:Subject:Date;
	b=jzvI8BqM9LAEqj0I/ZA6jvi55l7+4vWvThY4AIQxde5+86ucTTaFzxlurxfvf7N6u
	 htneIthfGgys4+8fOrvHl7RCzl3um8mYdanY8+TevL4ejnOGH1lMXNLDEe7xIQEmWb
	 gDynbgQFYBNYQhSJ8utRc9IJXzSkehDrv6Abrces=
Received: from localhost.localdomain ([14.116.239.36])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 4B98B2DC; Thu, 02 Apr 2026 20:18:57 +0800
X-QQ-mid: xmsmtpt1775132337t3vcv09eb
Message-ID: <tencent_BCF692F45859CCE6C22B7B0B64827947D406@qq.com>
X-QQ-XMAILINFO: ODafEzNm5Exjc75Go2l9u7Kntx5JFPywaNMbbiM0shFHskjksdMK18mmLdCtnE
	 bv69tXHzX38KjpTcJmWlp9rB4sQWRQldw2NYs5g3sW87hH5xOuqWXiGzpQZ0FHR+oRH8VOxK2XLF
	 abl4VdvSFr8ORCkGEjRi/pj7bl4OjOD8ivgx23b+0yaqFNhsZJChqkR3qaJn5+e2sD33jC9oqFc/
	 V6VVxbjKeu+0WJ7AJ0Cr7HfXxUk93VfH/u7dgK216zF+bcPtK66s8g6m0FYeoP/8VmryoYk+QedS
	 sMPOCAa2y8b30JE3wBc4JEPq2pAkz7kZi0QognbR2VRjt/IOJbtiRBp+GMDZc56Y4i+FRFJuMn6B
	 AqLJLcO+P2FaIt8Su2ST0nFAvtn3Y2fOG6IvoUk3xig+X8Zkwve5ll280/E9+Ol4fR/owJMZvdJd
	 TpX/tuxiXH02xvLIwbsZdjBxeJIES/dZ3xDL0kZCKdxz8jDYChG/SBGmxdLXAjzMg32HutUH2iUS
	 A2MSanxjzHAJXYC6iaqcjsoqQWjs9QA6vmzSYjpywPw7e1pygaRd5SxDySy5G19YNxdmt1bxCDUm
	 zB4s7aTwVLPzEBzTI18AHUcVk1737Z8TI9sP89D7rYjTmCNSneN58IOhYJG8C0kvhsAAysoMxV9S
	 uPU1Zh80DDgcGGktkbJol4kESIYfmFRUeB1MPwmTUaACWUuLCekoRllTGE2blpOhAIhwWy4dONdr
	 YFCs/WgAIJiAZWdC524YDMKYUXuS/2jEHCJE89tvKr4bA8VPjqlHZIrIqw7/OdAzgs/mjukCpSk7
	 7NejiqyEYblmSNQyMzJ6ja/fPfbCY5/udvyfjJvYGMhc8YqHwMdYVCMyO3L9pYmLmMj9/GT8cwkp
	 J44VxY0Y+X0/CKx/Dex94QDTEsa+9T0Q+gVfglokkTg4dmjXRpSaO2GHRypTZ12naGxSqX4rquVO
	 nK1+gqJ7pwYRHkDuU9SvYvRwvxZcRXrNV+5oesao+OafzwfVh+e1Ay9LnUagRWjXlFe37PTKyzDi
	 oQUEiB3CTRjOrHXGlxFqR3yvV7Qh0lVJFIR24mgxgdN90JRN8R2rlrw7LktBcgk2jBvTrX5nAf1u
	 OeJCgfdFSE6EK+yITtrN5zxlzT0W01zphzmA9b
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: MingTao Huang <1037827920@qq.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org,
	MingTao Huang <mintaohuang@tencent.com>
Subject: [PATCH bpf] bpf: Fix stale offload->prog pointer after constant blinding
Date: Thu,  2 Apr 2026 20:18:50 +0800
X-OQ-MSGID: <20260402121850.1382074-1-1037827920@qq.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: MingTao Huang <mintaohuang@tencent.com>

When a dev-bound-only BPF program (BPF_F_XDP_DEV_BOUND_ONLY) undergoes
JIT compilation with constant blinding enabled (bpf_jit_harden >= 2),
bpf_jit_blind_constants() clones the program. The original prog is then
freed in bpf_jit_prog_release_other(), which updates aux->prog to point
to the surviving clone, but fails to update offload->prog.

This leaves offload->prog pointing to the freed original program. When
the network namespace is subsequently destroyed, cleanup_net() triggers
bpf_dev_bound_netdev_unregister(), which iterates ondev->progs and calls
__bpf_prog_offload_destroy(offload->prog). Accessing the freed prog
causes a page fault:

BUG: unable to handle page fault for address: ffffc900085f1038
Workqueue: netns cleanup_net
RIP: 0010:__bpf_prog_offload_destroy+0xc/0x80
Call Trace:
__bpf_offload_dev_netdev_unregister+0x257/0x350
bpf_dev_bound_netdev_unregister+0x4a/0x90
unregister_netdevice_many_notify+0x2a2/0x660
...
cleanup_net+0x21a/0x320

The test sequence that triggers this reliably is:

1. Set net.core.bpf_jit_harden=2 (echo 2 > /proc/sys/net/core/bpf_jit_harden)
2. Run xdp_metadata selftest, which creates a dev-bound-only XDP
   program on a veth inside a netns (./test_progs -t xdp_metadata)
3. cleanup_net -> page fault in __bpf_prog_offload_destroy

Dev-bound-only programs are unique in that they have an offload structure 
but go through the normal JIT path instead of bpf_prog_offload_compile(). 
This means they are subject to constant blinding's prog clone-and-replace, 
while also having offload->prog that must stay in sync.

Fix this by updating offload->prog in bpf_jit_prog_release_other(),
alongside the existing aux->prog update. Both are back-pointers to
the prog that must be kept in sync when the prog is replaced.

Fixes: 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
Signed-off-by: MingTao Huang <mintaohuang@tencent.com>
---

 kernel/bpf/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7b675a451ec8..048d275accae 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1487,6 +1487,8 @@ void bpf_jit_prog_release_other(struct bpf_prog *fp, struct bpf_prog *fp_other)
 	 * know whether fp here is the clone or the original.
 	 */
 	fp->aux->prog = fp;
+	if (fp->aux->offload)
+		fp->aux->offload->prog = fp;
 	bpf_prog_clone_free(fp_other);
 }
 
-- 
2.43.7

