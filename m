Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133263EFD26;
	Tue,  9 Jun 2026 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016253; cv=none; b=L9LfG3s0jVPmRu31f0fLKFkDVHzc6SOpLIMkhFI7u3XTCuAUoV26qoH3TXu2lR+1pUnYBOamX6m+0QDrD8VAxBqn55uVNKcR1h+ZBhKaq4icGXck5yPPq+r4Im2gFo+qD+ssBSB6KZqjnFVhyUt49vGopgbDhxW7/hGF9dMhDtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016253; c=relaxed/simple;
	bh=xqk9KgZBaEPu2shwKK1bu3XFXlcpEBgLridTtQ6Hy6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dU3+FPXdPFDSu80EV0zZIXwKzCsejKxQvsK1G08h4wb5sjkZxSocjzhhk7M4nsaL354WSYIi9cMgDeo9WpEs2h3HX5jBt4dmKa7SIOpMkOp/mgdH1fVfIY0duIrq+Y0UiTZLrD8qrPJX23jJt6p6e0F+ccYVIioFVyilk0kzVuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=MGCcJKJ8; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="MGCcJKJ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=ThEMKlBMDXM7Mc4KGjL+vCXZAWAbge7
	f0xOZjWjdBec=; b=MGCcJKJ8xt0VpeO73qgCcjv8mOWrUSk/Z/qthhBTVBcfqcv
	SOMxJ28q+CrnC6or47SIxMOH2urU0DhFNYiALidgbodvAr5Xvng0GrazsJfIwNY2
	TqSshAB+DubGg+FbYanyYtPqWF5WuNysZAF20+057pj7XWqXGylxAuhE6rbI=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web4 (Coremail) with SMTP id ywQGZQDn+6CpJihq+OUeAg--.58007S3;
	Tue, 09 Jun 2026 22:43:53 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Tue, 09 Jun 2026 22:43:50 +0800
Subject: [PATCH bpf-next 1/2] bpf: Enforce write checks for BTF pointer
 helper access
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-f01-04-btf-writable-arg-v1-1-f449cd970669@mails.tsinghua.edu.cn>
References: <20260609-f01-04-btf-writable-arg-v1-0-f449cd970669@mails.tsinghua.edu.cn>
In-Reply-To: <20260609-f01-04-btf-writable-arg-v1-0-f449cd970669@mails.tsinghua.edu.cn>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Yonghong Song <yonghong.song@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781016235; l=1621;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=xqk9KgZBaEPu2shwKK1bu3XFXlcpEBgLridTtQ6Hy6M=;
 b=ft3Vl5Y9t5CXFqugr2J41d0o5Mi45nv4TAYDMeidC9V5kekU0KDSA0wtxL4dMgm2tUuxTlcuC
 y2mFTn2FTE4ASobatmIclk6mulNWolRM5ragGN0MYYyPlNy5svYk7zQ
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:ywQGZQDn+6CpJihq+OUeAg--.58007S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr43tw17KFWxur4xZrWxXrb_yoW8WF1Dpr
	WkGry29r48t3W7u3ZFvayIya45Wr1rJrW3Ga1ayryfZrn8Wr1qqrZ8XrWjvFyayrnYy340
	gr1jyryavw4UZrJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBS1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2kKe7AKxVWUXVWUAwAac4AC62xK8xCEY4
	vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VCjz48v1sIEY20_GrWkJr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxkIecxEwVAFwVW5XwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
	x26r4rKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
	0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMI
	IF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87
	Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUxNtxDUUUU
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgINA2onzACbagAAs+

check_mem_reg() verifies both read and write access for global subprogram
memory arguments. When the caller register is PTR_TO_BTF_ID,
check_helper_mem_access() currently forwards the access to
check_ptr_to_btf_access() as BPF_READ regardless of the requested access
type.

This lets a BTF-backed kernel object field pointer pass the caller-side
writable memory check for a global subprogram argument. The callee is then
validated with a generic writable PTR_TO_MEM argument and can store through
it, even though an equivalent direct BTF field store is rejected with "only
read is supported".

Forward the requested access type to check_ptr_to_btf_access().
This enforces existing BTF write restrictions for global subprogram memory
arguments as well.

Fixes: 3e30be4288b3 ("bpf: Allow helpers access trusted PTR_TO_BTF_ID.")
Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ed7ba0e6a9ce..cdff3e6eb96e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6777,7 +6777,7 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, struct bpf_reg_
 				zero_size_allowed, access_type, meta);
 	case PTR_TO_BTF_ID:
 		return check_ptr_to_btf_access(env, regs, reg, argno, 0,
-					       access_size, BPF_READ, -1);
+					       access_size, access_type, -1);
 	case PTR_TO_CTX:
 		/* Only permit reading or writing syscall context using helper calls. */
 		if (is_var_ctx_off_allowed(env->prog)) {

-- 
2.34.1

