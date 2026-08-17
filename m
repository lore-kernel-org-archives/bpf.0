Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EE73BED7A;
	Mon, 17 Aug 2026 20:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786999748; cv=none; b=GBW5su6WeBbH/VXyxSsUGSnjCrYYf5DwyUrYTA4pPRTxqxoN4Orcy8Q5/V55/vF8sJpwSVQzsYSjyjQjZLUj6IWjN9Og1bHPWpM0EBB8L6iMHjC9od/+Z8jBKqsJoRu3BYvAN+NAmQPuo0DnR8JphmzdNg7fO+XcfLhMSmiABmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786999748; c=relaxed/simple;
	bh=glOUblceaLvI7ca7icF5rrafZtiHEer7PTjtN+3Li6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o2glJUB2Crma8OMgUzWUmWL1d3tZpDTsBRmPSFdpOvieUyR17bOiEibhCp1ymYs1d9xYR3Y268QZwRrq2yBUgS/+7vwIVEDVZnZGVz3x2tHc5Sd6NNCtNK7xXhbZuJp57kPxFNHgUqlIi8O+O2KRBHHAbOEuHaSqYAktcew2bb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=C/EAmr7W; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="C/EAmr7W"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FAGUgTLVVxhP85fTHj7eiWn2oMK1HrsMNU8JsUjGXBg=; b=C/EAmr7WlOgy1DRgNSIfY57U/M
	eJPPI/WpegRtsKsp10VrM7uebhmFL6VxxygnJqnXg14Y6+x6PxT1YcmCk63mebU2Y6c/6JaQ+fEOG
	M21/Bbx76yywH/vKjEzADmlr/V8oD1RiczWYHBTMpIlSHfDlycFYy88GcidVyHeF9CrtOjYG1i3Yr
	/pj+dTB7H2gPTpCAHWY+q+aW8HjE5klCcWnrOSerEfaR1U6wWfJs9+itnMEgvJWdaomqWYddkzUpv
	unLGVEaHLt8dfc/ZJLEzgES+swysyw2Aq+DJFFhsPC8DUrJju+RC/VcPy/l6M89pRwH3cFX/xyqML
	PRtKw6Nw==;
Received: from [151.115.150.205] (port=43084 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1ww4GP-0000000CoBp-1uyh;
	Mon, 17 Aug 2026 22:48:57 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH v2 1/2] bpf: reject stack-argument callback subprograms
Date: Mon, 17 Aug 2026 20:48:11 +0000
Message-ID: <20260817204812.1637171-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260817204812.1637171-1-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260817204812.1637171-1-Jeremy.Jean@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Helper callbacks enter BPF subprograms through bpf_callback_t, whose
runtime ABI supplies five arguments. BTF validation nevertheless permits
static callback subprograms to declare more than five arguments when JIT
stack arguments are supported.

This lets verifier state for a callback use outgoing stack argument slots
prepared at the helper call site. The helper does not pass those slots. On
x86-64, callback loads of arguments seven and later therefore read the
helper native frame instead of the synthetic values checked by the
verifier. KASAN reports a slab OOB write.

Reject callback subprograms with incoming stack arguments when processing
callback calls.

Fixes: 0f6bd5e7a804 ("bpf: Support stack arguments for bpf functions")
Assisted-by: Codex:gpt-5
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 kernel/bpf/verifier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fdc5fbb1f78c..5fcefc0eaba0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9285,6 +9285,8 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	err = btf_check_subprog_call(env, subprog, caller->regs);
 	if (err == -EFAULT)
 		return err;
+	if (bpf_in_stack_arg_cnt(&env->subprog_info[subprog]))
+		return -EINVAL;
 
 	/* set_callee_state is used for direct subprog calls, but we are
 	 * interested in validating only BPF helpers that can call subprogs as
-- 
2.47.3

