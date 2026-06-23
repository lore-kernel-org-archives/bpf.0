Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FB935E1CE;
	Tue, 23 Jun 2026 10:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782211435; cv=none; b=o+bY3NBKeFie8LflTAJH/rsy3EHVn+PLfZiSG2Ysd6JvYAywC+TuBlkNI5xovBi/6fL2DVUjmycR6H3llUYAYJILY5MljhyELTZhH+SxJ/oHGHBwoZrmAhzGo8whzpGBsdLFYvObnOz6QBItvDsMJ69tiZMD1cNayk/mQHGHG3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782211435; c=relaxed/simple;
	bh=4hImI9muLGOWjtHbw9wXBYXS8B+t82nmuOekNU7+OL4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O2KLCd2V+ysvAXh0m4pXNstq275LwqTaMYbDM+LSUkTcOk8c8ROTnw061L2uxoLnzGdSt3kneHyOi0djbc/FF5zYSiEcRLZDPiXwrEM81OpgLnGLiIIpCewPfowkE/3ruZFclSO7xH4Lt6wmUE2K1LMDS/cDiO3/1EKVlPFjQPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=BUemMeGL; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="BUemMeGL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=wqDq6XmZpV6jbPwxHCl+8hTpBr7pghp
	Vo1eO+QXH9sU=; b=BUemMeGLdYSLfzYrcpMM8jXGcNvACoGc/O1WQpbK1Abh+4w
	CW5Fe9yo7+UI0UdL1nZWIQp0FZGBKZhNp5UeeiZ7uyh6ftSndhq8LydIx2Mv3JN3
	a4Wo448YPsChyqefzBMzQHqvqpzZpIGSVx87liIrvLlUIgG83vYRbj7h6nok=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web3 (Coremail) with SMTP id ygQGZQAHU5BbYzpq5jGnAg--.34960S4;
	Tue, 23 Jun 2026 18:43:40 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Tue, 23 Jun 2026 18:43:39 +0800
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Cover pseudo-BTF ksym log
 masking
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-f01-13-pseudo-btf-id-cap-bpf-v2-2-a190ebb8f3e2@mails.tsinghua.edu.cn>
References: <20260623-f01-13-pseudo-btf-id-cap-bpf-v2-0-a190ebb8f3e2@mails.tsinghua.edu.cn>
In-Reply-To: <20260623-f01-13-pseudo-btf-id-cap-bpf-v2-0-a190ebb8f3e2@mails.tsinghua.edu.cn>
To: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Hao Luo <haoluo@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782211420; l=1618;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=4hImI9muLGOWjtHbw9wXBYXS8B+t82nmuOekNU7+OL4=;
 b=8khwAfKg++3IJbRUt5zE4EkvKP7Q9CTBLuwYK+0lrGwPqcZNgZkPO0L/I2xDSRB3VM/F+C6/6
 juBKEkk3PbwDegpD4pDgLcztzeIMRoVNTL8zfbZpdDtEIvltp159Exb
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:ygQGZQAHU5BbYzpq5jGnAg--.34960S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFy5XFWkXry5uFyftFW7CFg_yoW8WFyxpa
	4kC343CrykCr4Sg3Z3AF4UGFy5JFn7uw4Yya1Iyw15Zanxur1xt392ka17JFn8Ars5Xw1F
	vFn7tw13ur1DAFJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2kKe7AKxVWUXVWUAwAac4AC62xK8xCEY4
	vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VCjz48v1sIEY20_GrWkJr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxkIecxEwVAFwVW8twCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
	x26r4rKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
	0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMI
	IF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUCdgAUUUUU=
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgQHA2o6NDluRAABs0

Add verifier_unpriv coverage for a raw socket-filter load of the
bpf_prog_active typed ksym. The test verifies that the unprivileged load
remains accepted and that the verbose verifier log prints the ldimm64
immediate as 0x0 instead of exposing a nonzero kernel address.

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 tools/testing/selftests/bpf/progs/verifier_unpriv.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
index c16f8382cf17..16de1595f015 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
@@ -6,6 +6,8 @@
 #include "../../../include/linux/filter.h"
 #include "bpf_misc.h"
 
+extern const int bpf_prog_active __ksym;
+
 #define BPF_SK_LOOKUP(func) \
 	/* struct bpf_sock_tuple tuple = {} */ \
 	"r2 = 0;"			\
@@ -77,6 +79,23 @@ __naked void dummy_prog_loop1_socket(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("unpriv: pseudo btf id log masks address")
+__success_unpriv
+__msg_unpriv("0: (18) r1 = 0x0")
+__not_msg_unpriv("0: (18) r1 = 0x{{[1-9a-f][0-9a-f]*}}")
+__retval_unpriv(0)
+__log_level(2)
+__naked void pseudo_btf_id_log_masks_address(void)
+{
+	asm volatile ("r1 = %[bpf_prog_active] ll;"
+		      "r0 = 0;"
+		      "exit;"
+	:
+	: __imm_addr(bpf_prog_active)
+	: __clobber_all);
+}
+
 SEC("socket")
 __description("unpriv: return pointer")
 __success __failure_unpriv __msg_unpriv("R0 leaks addr")

-- 
2.34.1

