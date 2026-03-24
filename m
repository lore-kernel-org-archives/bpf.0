Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04C640626C
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364746; cv=none; b=a3iGUDxpnGSqT/5d3V/sfaLUPc70CfzHwoFiKYXF3QOEyIHua0CkQAYGqrjTpXixSQYkB7vnjJGQfl1Chw4lMg6FsN7pqMYkSJpclD217CRCQjw0CN41ymdvZfLKSz2opMZ8GyEpNNh+D600t81IaeLZ58hIZ+SbJHIex/NmA/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364746; c=relaxed/simple;
	bh=72MWYsOl5EJ7p0vRG75z7FYU25LgvlWXSOQQdyfu3Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0j0Z0VGerV7xd9tdb8ELEP9qFUhL1z5/HUlQhfXUB7iqal2SsVp1XtzhDCLLB+OxvYy6w33NjOKLdhcMCvY6ZQEMS+ornV1XswhjoaOmTCUdItsNiseh9ZsX8Mpko5SCjS5rR5GelfMOzNWCiqWcm6HutnLtv/SBdWBXcK8a3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uM25/9ju; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uM25/9ju"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774364742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z/gKO34+ktu/oc3xYij758qT5edGTskb/0z/xbIb/yQ=;
	b=uM25/9ju5n7ZYSfnHVP0zMNtRl7pjgMO24m7PVMIvee07Yb3GjteQyLaOByPmJNlo0oWWa
	ubxyTshQ7TTKv8hbqthIYrHkn+oPfkVLQVOYIFBP2ermB789dh8iwwrpb6K0WfLIcLjAwM
	iw3FUb0h5qFCJQ35JQR/cOSnigmDlz4=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Toke Hoiland-Jorgensen <toke@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 2/3] bpf: Disallow freplace on kprobe with mismatched kprobe_write_ctx values
Date: Tue, 24 Mar 2026 23:04:43 +0800
Message-ID: <20260324150444.68166-3-leon.hwang@linux.dev>
In-Reply-To: <20260324150444.68166-1-leon.hwang@linux.dev>
References: <20260324150444.68166-1-leon.hwang@linux.dev>
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

To avoid the abuse of kprobe_write_ctx=true via kprobe+freplace, disallow
freplace on kprobe programs with mismatched kprobe_write_ctx values.

Fixes: 7384893d970e ("bpf: Allow uprobe program to change context registers")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/verifier.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 12330466d58b..f8257bae6081 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6404,6 +6404,14 @@ static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off,
 		/* remember the offset of last byte accessed in ctx */
 		if (env->prog->aux->max_ctx_offset < off + size)
 			env->prog->aux->max_ctx_offset = off + size;
+		if (env->prog->type == BPF_PROG_TYPE_EXT) {
+			struct bpf_prog *dst_prog = env->prog->aux->dst_prog;
+
+			if (env->prog->aux->kprobe_write_ctx != dst_prog->aux->kprobe_write_ctx) {
+				verbose(env, "Extension program cannot have different kprobe_write_ctx value with target prog\n");
+				return -EINVAL;
+			}
+		}
 		return 0;
 	}
 
-- 
2.53.0

