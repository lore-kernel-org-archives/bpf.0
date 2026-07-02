Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37790306B1B
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003026; cv=none; b=mEgJOaxyAl57RtKpyiQ8xp2mYWXqJUBG4FqVI3eGcCJ9sE/Ja1rXEESulAijJJIWiv71koLDH/qhYBHxGhi9rDmZY3mRmkZPyQDD73ExnxxgeTO7ba/YrzLV9z1KoUjkqA7GO//pDUgdNGgUDhzu8gMKUmYeqfTcbwAKE7qEVZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003026; c=relaxed/simple;
	bh=YGUpJjjYZIMK60SO0/e8fJeywgh3J6c3ZknkQK4h/gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+KT5XFx3w3OUUbYFsjbwebBQC/X2w1xBbMtxLVieAPjmbaEHeRfaxku0o2EDVFGJrcvQoUnwpbfbAO8ckbqKePzX9b3VdDWU3Z0IaIBatA01EpdhWLHLlVI8zYNZ4XtOWSh9dxdaSNzo/WjITKGV4zum2EmNs+mb8+arqaTXh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Axd_CNd0ZqbvEAAA--.5330S3;
	Thu, 02 Jul 2026 22:37:01 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxaeCKd0ZqzkW8AA--.30423S3;
	Thu, 02 Jul 2026 22:37:00 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	KaFai Wan <kafai.wan@linux.dev>
Cc: bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	Leon Hwang <leon.hwang@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Subject: [PATCH bpf-next v7 1/2] bpf: Introduce jit_required flag and refactor kfunc path
Date: Thu,  2 Jul 2026 22:36:55 +0800
Message-ID: <20260702143656.28845-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260702143656.28845-1-yangtiezhu@loongson.cn>
References: <20260702143656.28845-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxaeCKd0ZqzkW8AA--.30423S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kw1UuFW5ZF18Xw45ZFWxZrc_yoW8KFW5pF
	95W3srCr409wsF9F9rJF4xZrW5ta1UKw17KFWkCryFgr4UWw1vqa4kGry3Zas0qr4vkF1F
	vrnFvrW5ta4UZacCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jr9NsUUUUU=

Introduce a 'jit_required' bitfield flag at the end of the
flags group in struct bpf_prog. This bit tracks whether a
program strictly requires the JIT compiler.

Set this flag to 1 when a kfunc call is added at the end of
bpf_add_kfunc_call().

In __bpf_prog_select_runtime(), check with fp->jit_required
rather than bpf_prog_has_kfunc_call() to unify the logic.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Suggested-by: KaFai Wan <kafai.wan@linux.dev>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 include/linux/bpf.h   | 3 ++-
 kernel/bpf/core.c     | 3 +--
 kernel/bpf/verifier.c | 2 ++
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ba09795e0bfd..4e2b059d71f3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1880,7 +1880,8 @@ struct bpf_prog {
 				call_get_func_ip:1, /* Do we call get_func_ip() */
 				call_session_cookie:1, /* Do we call bpf_session_cookie() */
 				tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
-				sleepable:1;	/* BPF program is sleepable */
+				sleepable:1,	/* BPF program is sleepable */
+				jit_required:1;	/* program strictly requires JIT compiler */
 	enum bpf_prog_type	type;		/* Type of BPF program */
 	enum bpf_attach_type	expected_attach_type; /* For some prog types */
 	u32			len;		/* Number of filter blocks */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 649cce41e13f..5fcd19ccb41a 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2619,8 +2619,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct
 	if (fp->bpf_func)
 		goto finalize;
 
-	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
-	    bpf_prog_has_kfunc_call(fp))
+	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) || fp->jit_required)
 		jit_needed = true;
 
 	if (!bpf_prog_select_interpreter(fp))
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 25aea4271cd0..f496b45b9da4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2765,6 +2765,8 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
 	desc->func_model = func_model;
 	sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
 	     kfunc_desc_cmp_by_id_off, NULL);
+
+	env->prog->jit_required = 1;
 	return 0;
 }
 
-- 
2.42.0

