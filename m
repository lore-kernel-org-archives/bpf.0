Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701ED381B0A;
	Fri, 19 Jun 2026 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781885085; cv=none; b=BgbVo5e6fs6qntFNTqZ54aqC8T3O34pjy7zEbix75y5GUXEL1ksFCpmFrFCNMTgs8XqXp/Pfv8j23/wlEOgpx3VfcBRvVy+RFCKtmqMbtVOQ3uR5IV0HdsidOQUt0ZO/Fre/X7Heyl/zWxTJwmlOnaJbT2U3L5f00iU6DUNx/sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781885085; c=relaxed/simple;
	bh=+ALnsabsfDw796u9v7VhMx3HaQ/hih2C+iNPiz96QNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u7IyVp/pJuueanyO1hG3f9B28rkntvvboZwdqLO+Sua12GTro4TaM9N7WZ5h7qNsjCzr0opV6dV478E05jilEoI4I+iAXiHnBdWxD332Xvckaf/PH9GrjCL1vZyZk1NwCq29viMuVJITM5mniUXiMgi6GmjKfNYkaQkgRs+f0cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=pu4qPx09; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="pu4qPx09"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=n4Z5foOXU961pSMWUAwF7GkXTuYcfGs
	U2F6wupf6PWU=; b=pu4qPx09zzSAiPsRKInO9Rq4RHkAtviXvuDU/LgNw7FDM1y
	8SAvEJvCubLTKS21XUjcxjrcPLAMUe8dFE/bY6PGlWs/NdumRWvy0UvUXAmqCC3F
	Gw6K3LB5nr0EFXm89v1KWFE3RZYrfJ3GhMnx6EIoA0OpYiAd7o7SvaZZNFBc=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web3 (Coremail) with SMTP id ygQGZQCn8o+RaDVqIeaPAg--.58650S4;
	Sat, 20 Jun 2026 00:04:34 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Sat, 20 Jun 2026 00:04:28 +0800
Subject: [PATCH bpf-next 2/2] selftests/bpf: Cover pseudo-BTF ksym load
 capability
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-f01-13-pseudo-btf-id-cap-bpf-v1-2-f950f69fe60c@mails.tsinghua.edu.cn>
References: <20260620-f01-13-pseudo-btf-id-cap-bpf-v1-0-f950f69fe60c@mails.tsinghua.edu.cn>
In-Reply-To: <20260620-f01-13-pseudo-btf-id-cap-bpf-v1-0-f950f69fe60c@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Hao Luo <haoluo@google.com>
Cc: John Fastabend <john.fastabend@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781885075; l=2145;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=+ALnsabsfDw796u9v7VhMx3HaQ/hih2C+iNPiz96QNs=;
 b=C0r7Pk8rXNzglQotCY+ndSSlK+Ga6yP3f83oYxLv0Myss8P+Ggiagkkf95mlnKjhXBRLQkyAo
 sAx6xzt3YASAzLF6FNC0Ni1CzFNkYAhWImBnV0RDzJrDuS0RR8zg9SU
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:ygQGZQCn8o+RaDVqIeaPAg--.58650S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWfCw4DtFy8Jr1fGrW7urg_yoW8uw45pa
	4kJ3sxCr1kGr4SgF93AFWUCFy5WFs7uw43Ja10vr15Aa13urn7tws2kF4UGFn5Aw4vvw1F
	vanrA3sxuw1DAFJanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPm1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAaw2AFwI0_JF0_Jw1lnxkEFVAIw20F6c
	xK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E74AGY7Cv6cx26r4rKr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVW8ZVWrXwCY02Avz4vE14v_JwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
	x26r4rKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY
	6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZE
	Xa7VUj-B_UUUUUU==
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQQDA2o0b7D6BwAEs9

Add verifier_unpriv cases for a raw socket-filter load of the typed ksym
bpf_prog_active.

The first case verifies that a program without CAP_BPF is rejected before
the pseudo-BTF ksym is materialized. The second case grants CAP_BPF in
the unprivileged test-loader mode and verifies that the same load remains
accepted when the capability requirement is satisfied.

Declare the typed ksym in verifier_unpriv.c so these raw verifier tests do
not need a separate selftest header.

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 .../testing/selftests/bpf/progs/verifier_unpriv.c  | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
index c16f8382cf17..90e7ffc426ae 100644
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
@@ -77,6 +79,36 @@ __naked void dummy_prog_loop1_socket(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("unpriv: pseudo btf id ksym requires CAP_BPF")
+__success __failure_unpriv
+__msg_unpriv("BPF_PSEUDO_BTF_ID loads require CAP_BPF")
+__retval(0)
+__naked void pseudo_btf_id_ksym_requires_cap_bpf(void)
+{
+	asm volatile ("r1 = %[bpf_prog_active] ll;"
+		      "r0 = 0;"
+		      "exit;"
+	:
+	: __imm_addr(bpf_prog_active)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("unpriv: pseudo btf id ksym works with CAP_BPF")
+__success_unpriv
+__caps_unpriv(CAP_BPF)
+__retval_unpriv(0)
+__naked void pseudo_btf_id_ksym_with_cap_bpf(void)
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

