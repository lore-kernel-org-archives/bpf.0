Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FB92F7F15;
	Mon, 15 Jun 2026 08:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512282; cv=none; b=iYNPA2Ylj+wTLxwEKWksBao+htfoxuj/LH0HJluuakIpDpC5Ky3bySGsM4mOb20+WLEUqjsrxQU2laHcrwueJjvbEgbOKfHYCwN2c9ZBZrVUK77/l7+wWYpM+wBcM+UwpHcPjcxuC1A/FhFYE90Lo8z6reU3+bPuXi7wup1fe+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512282; c=relaxed/simple;
	bh=w9TgtjeoWg1QRC8HtVLI/HGroA6AaS7WzzbbfIu42s0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IgSl1d2xy/PKkWZdL8/bn8FWWAcGlF+CZtfMxk65m/31vCB+SaI+J2v7G3ckeB1dXLSLtGnZp36hE+cL1KwmsDStiXOOqHe3ePcQ3RVJeN5BlFlCv8+7Aa3xxFAWdW209WrwhjMQLL4fwHbZEH5kp7NegqCRjWCLAIYZVNFhVmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=nxDOZOm7; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="nxDOZOm7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=Pn9vM5BBoMlYJ1DxDQ2zsk7QezY4+f5
	JZSm7cp8EMik=; b=nxDOZOm7WGcA29mH8vkNbzxkAQ+MEOwgCsHEhIjF+CRpYYg
	yIV5d4oJUk/oIB4n5CRRFqXZqSKgugxKK95W0IlMN+fWi14st6VGySZhjkoZPPnR
	K57xm5yj/rMnu4hH4zOxehG/1ExrlV5XrWodujqigHRyHZfF5lUi2/Wfb/Ug=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web5 (Coremail) with SMTP id zAQGZQBXEMBFuC9qh8JwAg--.40355S3;
	Mon, 15 Jun 2026 16:31:02 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Mon, 15 Jun 2026 16:31:01 +0800
Subject: [PATCH bpf 1/2] bpf: Gate dynptr probe-read kfuncs like helpers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-f01-07-dynptr-probe-read-cap-v1-1-e626cd61a381@mails.tsinghua.edu.cn>
References: <20260615-f01-07-dynptr-probe-read-cap-v1-0-e626cd61a381@mails.tsinghua.edu.cn>
In-Reply-To: <20260615-f01-07-dynptr-probe-read-cap-v1-0-e626cd61a381@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, 
 Mykyta Yatsenko <yatsenko@meta.com>, Shuah Khan <shuah@kernel.org>, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781512263; l=2543;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=w9TgtjeoWg1QRC8HtVLI/HGroA6AaS7WzzbbfIu42s0=;
 b=9oC4nFMAc2/qDOnnO8YhTh0NWtB657zd8o3qwF9cPtod9fj52R46R0iiCHZamncVHzLk0+N/N
 7H5BYEUYPEpDnnhiI5nfAYM4D8OwnTP2ZXeH1n2x9/yWxm0Jop9Qi81
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:zAQGZQBXEMBFuC9qh8JwAg--.40355S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4kXFykuw47urWrtw4rGrg_yoW5Xr1fpF
	s5C34Ykr18t3Z3Zasrtws5WryFyw1kJF4xCFn7GFyxZw4vqrZ8Z34I9F15Jr93Kr1jgrW3
	Xw10v3sI93WUGFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xS
	Y4AK67AK6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JjcIDcUUUUU=
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQQTA2ovr0IOQAAEs3

The bpf_probe_read_{user,kernel}{,_str}_dynptr() kfuncs provide
probe-read style nofault copies into dynptr-backed BPF memory. Their
legacy helper counterparts are exposed only to programs with CAP_PERFMON,
and the kernel-read helpers are additionally blocked by
LOCKDOWN_BPF_READ_KERNEL.

The dynptr kfuncs are registered in the common kfunc set, so the verifier
currently allows them with the generic kfunc privilege gate. Add a common
kfunc filter that mirrors the helper policy for these probe-read dynptr
kfuncs: require CAP_PERFMON for all four nofault probe-read variants and
apply the existing lockdown check to the kernel-read variants.

This preserves the existing dynptr copy implementation while aligning the
capability policy with the legacy probe-read helpers.

Fixes: a498ee7576de ("bpf: Implement dynptr copy kfuncs")
Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 kernel/bpf/helpers.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9ca195104667..fbef89196f85 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4961,9 +4961,41 @@ BTF_ID_FLAGS(func, bpf_dynptr_file_discard)
 BTF_ID_FLAGS(func, bpf_timer_cancel_async)
 BTF_KFUNCS_END(common_btf_ids)
 
+#ifdef CONFIG_BPF_EVENTS
+BTF_KFUNCS_START(probe_read_dynptr_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_probe_read_user_dynptr)
+BTF_ID_FLAGS(func, bpf_probe_read_kernel_dynptr)
+BTF_ID_FLAGS(func, bpf_probe_read_user_str_dynptr)
+BTF_ID_FLAGS(func, bpf_probe_read_kernel_str_dynptr)
+BTF_KFUNCS_END(probe_read_dynptr_kfunc_ids)
+
+BTF_KFUNCS_START(probe_read_kernel_dynptr_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_probe_read_kernel_dynptr)
+BTF_ID_FLAGS(func, bpf_probe_read_kernel_str_dynptr)
+BTF_KFUNCS_END(probe_read_kernel_dynptr_kfunc_ids)
+#endif
+
+static int common_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+#ifdef CONFIG_BPF_EVENTS
+	if (!btf_id_set8_contains(&probe_read_dynptr_kfunc_ids, kfunc_id))
+		return 0;
+
+	if (!bpf_token_capable(prog->aux->token, CAP_PERFMON))
+		return -EACCES;
+
+	if (btf_id_set8_contains(&probe_read_kernel_dynptr_kfunc_ids, kfunc_id) &&
+	    security_locked_down(LOCKDOWN_BPF_READ_KERNEL) < 0)
+		return -EACCES;
+#endif
+
+	return 0;
+}
+
 static const struct btf_kfunc_id_set common_kfunc_set = {
 	.owner = THIS_MODULE,
 	.set   = &common_btf_ids,
+	.filter = common_kfunc_filter,
 };
 
 static int __init kfunc_init(void)

-- 
2.34.1

