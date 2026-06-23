Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD37C3D0927;
	Tue, 23 Jun 2026 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782211438; cv=none; b=IeOLX5/Ks/kSpAgNLUEaw2JybXHuKAIWRJ6pcZ96xM3MA3kz5Cg0y70o6qCMwtds80EhZfJ91mcsHYH5gn5xn8eTG0NZkpGtZvl/K743re9ODQfvL43SS2L6AflGh3gww97Ym8sncQbt+tTgFuou0Bk4ILmDeuTyb8Me9t/aknc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782211438; c=relaxed/simple;
	bh=P90/nQWLBFgBW/bQMpXUIz8zBfHF/V2eZjQ1j7cTdiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eg3325A6oORn0SlpLhjNzArDH3TxbRzjCmzMb/6aR9ZqTSUIX2E2FnhsH+Mr0AXF6yoR6WGZkeCuNb7hXSnu/Sod5oPr81dYJxuLZ2rnEJnDHzgwdESnaAAffJ0b8c7EL/c96R0+aJrKjH9DGkan12cJ5z0YbxVWJ1InrJ0+f9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=i7waSXMG; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="i7waSXMG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=pKlqd1vPObc0GFvIwFLpczCo1z5jMKr
	ZGHHKGY959oc=; b=i7waSXMGwbAyBl5S+dsvL5eEG3kyl4gWi31JK4R+juHFh2Q
	ulPwpf8kpttTbyAUTr7j6kpSVTgl9WQMchgZHRVhnf/TMEAKvQ9VLL4btQnIO+2t
	5m/wsyWCIOi4z08mtHUJ97os9L46tKz+3hQUFLKrMKXCllk7etA8mzK0THUY=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web3 (Coremail) with SMTP id ygQGZQAHU5BbYzpq5jGnAg--.34960S3;
	Tue, 23 Jun 2026 18:43:40 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Tue, 23 Jun 2026 18:43:38 +0800
Subject: [PATCH bpf-next v2 1/2] bpf: Mask pseudo pointer values in
 verifier logs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-f01-13-pseudo-btf-id-cap-bpf-v2-1-a190ebb8f3e2@mails.tsinghua.edu.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782211420; l=1395;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=P90/nQWLBFgBW/bQMpXUIz8zBfHF/V2eZjQ1j7cTdiw=;
 b=WjHmM8kiiOtQJh2lQk3CnHihE3w3hm+QWmFu6NKNEVCoswClXmlRL55ezmOJj6s0w5FsiTLp2
 pIyHr25WtmUCOvTIuIF5/wBmVujTVlqbrMRrjWkY4z6N9E4BKvwEiCT
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:ygQGZQAHU5BbYzpq5jGnAg--.34960S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1xJryDXr1xXF45GrykXwb_yoW8GrW5pr
	s3Gry0kF4DAr1j93yDJwn7Ja4Fg3yUG3WfCF9rArWfAw17Xws0q3ZFgryxJF1ak340gw1k
	tryDZ3yFq34Uuw7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBq1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
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
	80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1sXo7UUUUU==
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQIHA2o6M-xuXwADsq

print_bpf_insn() masks ldimm64 immediates for pointer-bearing pseudo
sources when pointer leaks are not allowed, but the mask only covers
BPF_PSEUDO_MAP_FD and BPF_PSEUDO_MAP_VALUE.

BPF_PSEUDO_MAP_IDX, BPF_PSEUDO_MAP_IDX_VALUE, and BPF_PSEUDO_BTF_ID can
also be resolved to kernel pointer values before the verifier log prints
the instruction. Include them in the existing pointer classification so
the log prints 0x0 instead of the rewritten address.

Fixes: 4976b718c355 ("bpf: Introduce pseudo_btf_id")
Fixes: 387544bfa291 ("bpf: Introduce fd_idx")
Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 kernel/bpf/disasm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index f8a3c7eb451e..0391b3bc0073 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -323,7 +323,10 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 			 */
 			u64 imm = ((u64)(insn + 1)->imm << 32) | (u32)insn->imm;
 			bool is_ptr = insn->src_reg == BPF_PSEUDO_MAP_FD ||
-				      insn->src_reg == BPF_PSEUDO_MAP_VALUE;
+				      insn->src_reg == BPF_PSEUDO_MAP_VALUE ||
+				      insn->src_reg == BPF_PSEUDO_MAP_IDX ||
+				      insn->src_reg == BPF_PSEUDO_MAP_IDX_VALUE ||
+				      insn->src_reg == BPF_PSEUDO_BTF_ID;
 			char tmp[64];
 
 			if (is_ptr && !allow_ptr_leaks)

-- 
2.34.1

