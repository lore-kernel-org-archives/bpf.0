Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC7413CA92;
	Mon, 10 Aug 2026 05:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786338454; cv=none; b=nMmNbUD/PENxQzQpRNn1OhuRKn9eIWVR+3nKzCCygXvgGmmienYtqy8LdD+x7Dwi9qD/tPGqAlZwPCIIkePD7ftnNPhCSEt8Wc1PQvzxiREO6lodxNuxOfLzI5YkzcsLdVhXETbyxPgEI+fzv7kqZ0wTbbfmGiXcHu3aqqW6UBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786338454; c=relaxed/simple;
	bh=9X25qya7SNr1zhDe6Wq+1YV8mO8PfLbyBgJqrJceQ/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1c0D7MK/pKw747YSnW5JlcWI+0osGygD4qY9SlZQXqHESEentPfyHlLj1rmCimddy3lUiLWhlkdCKJJ8Ejn3Px3CfxkZ0RV9PbNVmoaT6zecyXpGFED2eiWtS40ry8IwH+FArFas/xLecC6h2eQkIP/YOMEALqQWrP5MHwMtOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IGx5L+Fa; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IGx5L+Fa"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786338448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=85+Wqti5tF31EKLUux8+xnx/ktVBpC9xlOSOD6wh6Ow=;
	b=IGx5L+FaDU3XSV1do/QbiR76f7N+bnZl37HkLeMnYh24hcHJQh9xf331HlwlpY968+kvhb
	F4SeuVpXE6EnWKO1XzoyDZsxiFGLB293Mx8kO/FCoHR71OKRcc2QLNfVuQ/0cnInPbgspt
	DS1IPFg8HWXp0P5Rb/93QE/E0D0JDaA=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Yinhao Hu <dddddd@hust.edu.cn>,
	Kaiyan Mei <M202472210@hust.edu.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Shuah Khan <shuah@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 1/3] bpf, tcx, netkit: reject offloaded programs
Date: Mon, 10 Aug 2026 13:05:59 +0800
Message-ID: <20260810050621.82035-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260810050621.82035-1-jiayuan.chen@linux.dev>
References: <20260810050621.82035-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

An offloaded program runs on the NIC, so its bpf_func is set to
bpf_prog_warn_on_exec(). tcx and netkit run programs on the host with
bpf_prog_run(), so attaching an offloaded program to them hits the WARN
on the first packet.

Both tcx and netkit go through bpf_mprog_attach(), so add the check there
once instead of in every attach path. Only check SCHED_CLS programs, so a
future mprog user that wants offloaded programs still works.

Fixes: 053c8e1f235dc ("bpf: Add generic attach/detach/query API for multi-progs")
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
Closes: https://lore.kernel.org/bpf/64d8e2b5-a214-4f3c-b9e8-bcedbcb2c602@hust.edu.cn/
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 kernel/bpf/mprog.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/bpf/mprog.c b/kernel/bpf/mprog.c
index 1394168062e8..0b50464ec902 100644
--- a/kernel/bpf/mprog.c
+++ b/kernel/bpf/mprog.c
@@ -222,6 +222,14 @@ static int bpf_mprog_pos_after(struct bpf_mprog_entry *entry,
 	return tuple->prog ? -ENOENT : bpf_mprog_total(entry);
 }
 
+static int bpf_mprog_check_prog(const struct bpf_prog *prog)
+{
+	if (prog->type == BPF_PROG_TYPE_SCHED_CLS &&
+	    bpf_prog_is_offloaded(prog->aux))
+		return -EINVAL;
+	return 0;
+}
+
 int bpf_mprog_attach(struct bpf_mprog_entry *entry,
 		     struct bpf_mprog_entry **entry_new,
 		     struct bpf_prog *prog_new, struct bpf_link *link,
@@ -237,6 +245,9 @@ int bpf_mprog_attach(struct bpf_mprog_entry *entry,
 	};
 	int ret, idx = -ERANGE, tidx;
 
+	ret = bpf_mprog_check_prog(prog_new);
+	if (ret)
+		return ret;
 	if (revision && revision != bpf_mprog_revision(entry))
 		return -ESTALE;
 	if (bpf_mprog_exists(entry, prog_new))
-- 
2.43.0

