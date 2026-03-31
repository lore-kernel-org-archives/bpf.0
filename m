Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07D53DDDC7
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774968879; cv=none; b=V3nG+m6ujtDenTyw8E8C+/jhh/ttgPdtZgvt80MzP1aVllRycmyYYBaJHVq4NfoogtS9MLFZyApx+J+djxS2PTtyr8hDkERr+ENCV6S0WUS+dAUP14K8pYBpRy6Hi1C4+0lk/4houyjyaGyRQDUvps2PhizmhNQJHABaNzTqkhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774968879; c=relaxed/simple;
	bh=wsizVL+qipW1oS+MnNqgqJiUL1L1zQMvNsK9MqvXbWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZpjunLg6+NnSKcHf93dHuRQqP4Wc3QRidYcWxLbJ8RCfART3o3jEFbxXJx+/zt/FiX3v9/SRwelVvZ24mpRE62xHC+vCc/IreR7rJrdTXzzRLGaa0FHG6xDpgzJsyJlVaiHzI3b3aN9d+ae/b3AAS8pg1h4jPktDzx49rAh/I+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HGephv0u; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HGephv0u"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774968875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KDMByIchSdvZ1GTL3+7haZlQgAA8E2m7T8HepMwViZs=;
	b=HGephv0urUlmqblzp/1whguYJEFghFQPlCd2lLvJHYsxfi6q6lJ7GiUfhx78y8dwWJdJZA
	utb7zIxdcYJqZk3nCWKyQvc3eUcFebY3Xa4c05zmz+7kttgv15ZyUDdseSQZ9cNje5Nd2K
	hqhCefjrGJpHoG3f6mU6pSNSEvmC+hk=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Feng Yang <yangfeng@kylinos.cn>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v3 1/2] bpf: Fix abuse of kprobe_write_ctx via freplace
Date: Tue, 31 Mar 2026 22:53:52 +0800
Message-ID: <20260331145353.87606-2-leon.hwang@linux.dev>
In-Reply-To: <20260331145353.87606-1-leon.hwang@linux.dev>
References: <20260331145353.87606-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

uprobe programs are allowed to modify struct pt_regs.

Since the actual program type of uprobe is KPROBE, it can be abused to
modify struct pt_regs via kprobe+freplace when the kprobe attaches to
kernel functions.

For example,

SEC("?kprobe")
int kprobe(struct pt_regs *regs)
{
	return 0;
}

SEC("?freplace")
int freplace_kprobe(struct pt_regs *regs)
{
	regs->di = 0;
	return 0;
}

freplace_kprobe prog will attach to kprobe prog.
kprobe prog will attach to a kernel function.

Without this patch, when the kernel function runs, its first arg will
always be set as 0 via the freplace_kprobe prog.

To fix the abuse of kprobe_write_ctx=true via kprobe+freplace, disallow
attaching freplace programs on kprobe programs with different
kprobe_write_ctx values.

Fixes: 7384893d970e ("bpf: Allow uprobe program to change context registers")
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/syscall.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 51ade3cde8bb..e1505c9cd09e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3733,6 +3733,23 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		tr = prog->aux->dst_trampoline;
 		tgt_prog = prog->aux->dst_prog;
 	}
+	/*
+	 * It is to prevent modifying struct pt_regs via kprobe_write_ctx=true
+	 * freplace prog. Without this check, kprobe_write_ctx=true freplace
+	 * prog is allowed to attach to kprobe_write_ctx=false kprobe prog, and
+	 * then modify the registers of the kprobe prog's target kernel
+	 * function.
+	 *
+	 * This also blocks the combination of uprobe+freplace, because it is
+	 * unable to recognize the use of the tgt_prog as an uprobe or a kprobe
+	 * by tgt_prog itself. At attach time, uprobe/kprobe is recognized by
+	 * the target perf event flags in __perf_event_set_bpf_prog().
+	 */
+	if (prog->type == BPF_PROG_TYPE_EXT &&
+	    prog->aux->kprobe_write_ctx != tgt_prog->aux->kprobe_write_ctx) {
+		err = -EINVAL;
+		goto out_unlock;
+	}
 
 	err = bpf_link_prime(&link->link.link, &link_primer);
 	if (err)
-- 
2.53.0

