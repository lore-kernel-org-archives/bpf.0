Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F2B3E5A0D;
	Sat, 13 Jun 2026 12:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781354332; cv=none; b=DI8ijqakdIOJa1neV8nnZxTS63WjqbBg1S5RlBld2LQNe/7JGXy3fkzn7d0/J+Bs1kdqBUpLF3kZMVtZYn0A6W/UTczGnaBshLwre3tiuWLnSyTZCYQmaemMDKgVQo5tNtaIneUCgmxgFu7KjuDN8xvvsdYMyP4N7MiN94bDky0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781354332; c=relaxed/simple;
	bh=KIGyc5KzWwv9YcjYgoiZNtOE0EbVm9CnQH9yK621CPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nnWrRkBDwj0gTs3RLPq9KnXxQTk7II+cCjWh98stn7ys3o67ZDjj49YcnHM41Yg5aA7Swt1SJySQJLhIqu6hNvjleGBayi0MdZ+AMH6MCGqi8NsvJDAxCcDR+QFeRzSIsAGKI/C082pYfAzU/OSeDz05UZdn2KGibeDT2hkgUfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=pW6TLinx; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="pW6TLinx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=NESYAsjJCcQ6yGYmVNTlBi0KTvrki8h
	pxVE25uBTKH8=; b=pW6TLinxou9ukv5M+6r3TMYlASj+eKgEPqg8hWvl0fVHyJ+
	RdD8usjDSzG9Uhd5hSS77dQRLGTo7DJ7rxIDsMP2pqSWXorfLgJxeegVRGrR5tOZ
	dWoMpSHWey4xYG+4+XszEG5a0iS9lgn2f6CjDFVpCH/lB+RFW0poenCrMF9g=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web3 (Coremail) with SMTP id ygQGZQD3RJJETy1qoxlnAg--.6726S4;
	Sat, 13 Jun 2026 20:38:29 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Sat, 13 Jun 2026 20:38:28 +0800
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Cover scalar add from
 rdonly untrusted memory
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-f01-03-scalar-add-bpf-next-v2-v2-2-ce07bec3f72b@mails.tsinghua.edu.cn>
References: <20260613-f01-03-scalar-add-bpf-next-v2-v2-0-ce07bec3f72b@mails.tsinghua.edu.cn>
In-Reply-To: <20260613-f01-03-scalar-add-bpf-next-v2-v2-0-ce07bec3f72b@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781354309; l=2158;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=KIGyc5KzWwv9YcjYgoiZNtOE0EbVm9CnQH9yK621CPU=;
 b=TXmSScqMivKDoGpctwIHw5B07I4GKxwFg+W5bToqSjAhNCtgfibsI/qiI2E/NgaXaX+01liUm
 zH/45XWMUPWC8A/4L8MWbpA7BSgCU81eW1Kg8BKVeuD9byJQbZCtr6O
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:ygQGZQD3RJJETy1qoxlnAg--.6726S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyrArW7tFyxGFy8KF4Uurg_yoW8uFW7pr
	s7G345CrZ3JrnrAasxAayDuF15JrZ5X3yYkFs2yryjkF4UGr1Iqw18KayqqrZ3Cw1xurZ0
	vFWYk343uFW7AaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r4r
	Kr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc
	8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Av
	z4vE14v_Xr1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU0FksPUUUUU==
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQIRA2oshq+wtwABs4

Add a verifier test for scalar += rdonly_untrusted_mem. The program gets a
read-only untrusted memory value from bpf_rdonly_cast(..., 0), adds it to a
scalar destination, and then applies a bitwise operation to the result.

The addition itself is allowed, but the result must be tracked as a
pointer. The verifier should reject the following bitwise operation instead
of preserving stale scalar state.

Add coverage for scalar -= pointer and scalar ^= pointer as well. This
prevents the early return from bypassing normal pointer ALU rejection.

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 .../selftests/bpf/progs/mem_rdonly_untrusted.c     | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
index 5b4453747c23..67633129ed41 100644
--- a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
+++ b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
@@ -77,6 +77,58 @@ int offset_not_tracked(void *ctx)
 	return s;
 }
 
+SEC("socket")
+__failure
+__msg("R1 bitwise operator &= on pointer prohibited")
+__naked void scalar_add_tracks_pointer(void)
+{
+	asm volatile ("r1 = 0;"
+	"r2 = 0;"
+	"call %[bpf_rdonly_cast];"
+	"r1 = 0;"
+	"r1 += r0;"
+	"r1 &= 1;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_rdonly_cast)
+	: __clobber_all);
+}
+
+SEC("socket")
+__failure
+__msg("R1 tried to subtract pointer from scalar")
+__naked void scalar_sub_ptr_not_ok(void)
+{
+	asm volatile ("r1 = 0;"
+	"r2 = 0;"
+	"call %[bpf_rdonly_cast];"
+	"r1 = 0;"
+	"r1 -= r0;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_rdonly_cast)
+	: __clobber_all);
+}
+
+SEC("socket")
+__failure
+__msg("R1 bitwise operator ^= on pointer prohibited")
+__naked void scalar_xor_ptr_not_ok(void)
+{
+	asm volatile ("r1 = 0;"
+	"r2 = 0;"
+	"call %[bpf_rdonly_cast];"
+	"r1 = 0;"
+	"r1 ^= r0;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_rdonly_cast)
+	: __clobber_all);
+}
+
 SEC("socket")
 __failure
 __msg("cannot write into rdonly_untrusted_mem")

-- 
2.34.1

