Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6934399F3;
	Fri, 24 Jul 2026 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902489; cv=none; b=Mwgu9lq673leWfLVxiyNj16EraUiGUfoDilV7VNJXCf5pA5vRShyKPkweyaA4Jg8jY44ChtHrlwpHQuP3UMavX+wG66ya4Ll1iNwbzEp+1YfpWZYv3Mf+z/TWVLKIjI+Ojg7XZXeqBOGJGxbAjE+EaJgDYhDOJSO7u75tHQC7j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902489; c=relaxed/simple;
	bh=JCpz07QMIoYkgWlFbFkBXaMEQIeBpd6j7HAefVsL008=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ho6n9Qp1YuAoPQ2eMNTokk72U10T3XNjQwmPS5fO+xW3UnopcngphZLTUWvdNKiQ2E8GzyIJvCkiNQMXzL0p8VZPnzcX0NjBmalBUgynOdV2RYsPyhosN4eqTDsIadPH4WoIc0QaaTxyxzGccykxkytctoPQZcKapIBDxAzkHP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SHacB/p3; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SHacB/p3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784902485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CtBv+6DKpRgeUFFG4TgzRtR+eRItYzi9T1OzkhCupJw=;
	b=SHacB/p335Ksp6x94cwKEounO35MYO6UNiaadteJdmJOK6XBUmunYbgvq4+bGzeEpwrNVB
	7PCRRvldTxswTNOa3q/yVHZzGJtUvVMZHmb1mTKQlQBxz5DTsQd1KBmICwG8s4YKiqgJDO
	MOBCyETxKzHxS2a4pTie5MnPmZceY94=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
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
	Shuah Khan <shuah@kernel.org>,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Varun R Mallya <varunrmallya@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Viktor Malik <vmalik@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpf: Fix sleepable check for tracing prog
Date: Fri, 24 Jul 2026 22:14:21 +0800
Message-ID: <20260724141422.10463-2-leon.hwang@linux.dev>
In-Reply-To: <20260724141422.10463-1-leon.hwang@linux.dev>
References: <20260724141422.10463-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When CONFIG_FUNCTION_ERROR_INJECTION is disabled, a sleepable tracing prog
is allowed to attach to '__x64_'-alike prefix symbols.

It is because the verifier does not verify whether the symbol is a kernel
function or a bpf prog. That said, a sleepable tracing prog is allowed to
attach to a bpf prog target whose name has '__x64_'-alike prefix.

For example, a sleepable fentry prog attaches to a '__x64_sys_nop' XDP
prog, and copies buffer from a user pointer with bpf_copy_from_user()
helper. After attaching the XDP prog to lo interface, the kernel BUG
could be triggered by 'ping -c 1 -W 1 127.0.0.1':

[    3.460756] BUG: sleeping function called from invalid context at kernel/bpf/trampoline.c:1324

Fix it by disallowing sleepable tracing prog always when its target is
bpf prog.

Fixes: 16d9c5660692 ("bpf: Always allow sleepable programs on syscalls")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/verifier.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 52be0a118cce..40d567b90d24 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18935,13 +18935,16 @@ static bool is_tracing_multi_id(const struct bpf_prog *prog, u32 btf_id)
 }
 
 static int btf_id_allow_sleepable(u32 btf_id, unsigned long addr, const struct bpf_prog *prog,
-				  const struct btf *btf)
+				  const struct btf *btf, const struct bpf_prog *tgt_prog)
 {
 	const struct btf_type *t;
 	const char *tname;
 
 	switch (prog->type) {
 	case BPF_PROG_TYPE_TRACING:
+		if (tgt_prog)
+			return prog->sleepable ? -EINVAL : 0;
+
 		t = btf_type_by_id(btf, btf_id);
 		if (!t)
 			return -EINVAL;
@@ -19324,7 +19327,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		}
 
 		if (prog->sleepable) {
-			ret = btf_id_allow_sleepable(btf_id, addr, prog, btf);
+			ret = btf_id_allow_sleepable(btf_id, addr, prog, btf, tgt_prog);
 			if (ret) {
 				module_put(mod);
 				bpf_log(log, "%s is not sleepable\n", tname);
@@ -19575,7 +19578,7 @@ int bpf_check_attach_btf_id_multi(struct btf *btf, struct bpf_prog *prog, u32 bt
 
 	/* Check sleepable program attachment. */
 	if (prog->sleepable) {
-		err = btf_id_allow_sleepable(btf_id, addr, prog, btf);
+		err = btf_id_allow_sleepable(btf_id, addr, prog, btf, NULL);
 		if (err)
 			return err;
 	}
-- 
2.55.0

