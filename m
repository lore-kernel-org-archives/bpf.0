Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2772E368D59;
	Mon,  3 Aug 2026 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768288; cv=none; b=gJeU2KHmiOAkJDvPwqGUaeP0I3L8DvbpHNzI1uf8ECPJod6lto0qjFQ/iK0rrHVTBAWXMGPCqXwQQolXF7SUzZBOUzltBTrrr4t7/so767qOnklCKW0udEajhwcvUVEFTFLymRElP7+l0KYceFeBJdOkcr9d/wl10cHq6vMae/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768288; c=relaxed/simple;
	bh=cKci1TH0Ez5V7bHDCnmcc02yMbytcHg/z6mm5mPDOAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DXhK/A9vxUa+DVq12jy8u1+ZvJNVLuD5vUSoJWeW49HAr+8Fws65BkhYy+vcEgk3pvHuEmZdlHbv307j/TB38lMFD2n9F8hZghIcqDFEZDP9qvVDD0UenYbt24+dsEsOaqQuQsQZ6L/vzjMMXcbUA7rS/1wCybWhx1jUVDAruEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=Tk9j9fuB; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="Tk9j9fuB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	To:Cc; bh=BuFYpnazeC9wBh0083FQMdu+tEEZaeoj8Txamw5fU1o=; b=Tk9j9f
	uBWErLkXReytXBU8b4H3TiA0cc3EhTlnOG/7tFCgOtFdoXuLGizZkNob8nYTGMjM
	V2PfvaCOPuP/7lFq/PvBmuyLn5agU5eLicPfecv2G1pdiqX2iguIsslR9YjDu+XR
	20Tn2r8athiza6ZaMacrTbZ3s8dr8/7qOrIRU=
Received: from [172.17.0.4] (unknown [101.6.30.195])
	by web1 (Coremail) with SMTP id yAQGZQC3WspHqXBqgy0HAQ--.34642S2;
	Mon, 03 Aug 2026 22:44:26 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Date: Mon, 03 Aug 2026 14:44:20 +0000
Subject: [PATCH bpf] bpf: Fix sanitize_err() register selection for BPF_K
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-c3-035-sanitize-err-v1-v1-1-93e5ff61731f@mails.tsinghua.edu.cn>
X-B4-Tracking: v=1; b=H4sIAEOpcGoC/x3MwQqDMAyA4VcpORtoGxzFV5EdWk22XDpJh4jiu
 6/s+B3+/4LGptxgchcY79r0UzvC4GB55/pi1LUboo8PnzzhQuhpxJarfvVkZDPcA1JmiUUSpSL
 Q481Y9PiPZyibwPO+f+4DOMVtAAAA
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sashiko AI review <sashiko-bot@kernel.org>, 
 Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785768267; l=2164;
 i=chenyy23@mails.tsinghua.edu.cn; s=kernel; h=from:subject:message-id;
 bh=cKci1TH0Ez5V7bHDCnmcc02yMbytcHg/z6mm5mPDOAg=;
 b=1yBvR9if8q7FnaAaQOXmwkmfPZmMlj0CiPFAv6/sz6mJ4HrCrzKG+O6qZW1wy1wzC1IJP+VnA
 fPVXB6M2cJXAvlKfnJAi93OLieW10BlOb1ipwtO1ZDzdZ404OOlW5WM
X-Developer-Key: i=chenyy23@mails.tsinghua.edu.cn; a=ed25519;
 pk=+Q11PEDVzoU+87KHlIeNWKwv/GiutzE5094ej7opM+s=
X-CM-TRANSID:yAQGZQC3WspHqXBqgy0HAQ--.34642S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4kGF18GrWDWr4DZr15XFb_yoW8trWfpw
	48uwnxtrWktr1Uu3WDAa129ayjka1fAa13uw1UJ3ySvr9Iyrn5CFWIgrySqa4Yyry0k340
	yr4F9rW0v34UAFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9q1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28E
	F7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzx
	vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_GrWk
	Jr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5c
	I20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxE
	wVAFwVW5XwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4rKr1UJr1l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
	4UJbIYCTnIWIevJa73UjIFyTuYvjfUIKZXDUUUU
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

sanitize_err() determines whether the source or destination register holds
the pointer by inspecting regs[insn->src_reg]. For BPF_K instructions,
src_reg is zero because the offset is encoded as an immediate. R0 must
therefore not influence the register reported for REASON_TYPE.

Treat BPF_K as an immediate scalar source and select the destination
register for the diagnostic.

Fixes: a15970d916b3 ("bpf: Simplify sanitize_err() signature")
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/bpf/20260729153536.F3E2E1F000E9@smtp.kernel.org/
Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
This follows up on Eduard's request to special-case BPF_K when selecting
the register reported by sanitize_err():
https://lore.kernel.org/bpf/a9475d6a37b2569aaa754c5b2186ba53b37c405d.camel@gmail.com/
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fdc5fbb1f78ca..e5a8547ad7231 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13562,6 +13562,7 @@ static int sanitize_err(struct bpf_verifier_env *env, const struct bpf_insn *ins
 	static const char *err = "pointer arithmetic with it prohibited for !root";
 	const char *op = BPF_OP(insn->code) == BPF_ADD ? "add" : "sub";
 	u32 dst = insn->dst_reg, src = insn->src_reg;
+	bool src_is_imm = BPF_SRC(insn->code) == BPF_K;
 	struct bpf_reg_state *regs = cur_regs(env);
 
 	switch (reason) {
@@ -13571,7 +13572,7 @@ static int sanitize_err(struct bpf_verifier_env *env, const struct bpf_insn *ins
 		break;
 	case REASON_TYPE:
 		verbose(env, "R%d has pointer with unsupported alu operation, %s\n",
-			regs[src].type == SCALAR_VALUE ? dst : src, err);
+			src_is_imm || regs[src].type == SCALAR_VALUE ? dst : src, err);
 		break;
 	case REASON_PATHS:
 		verbose(env, "R%d tried to %s from different maps, paths or scalars, %s\n",

---
base-commit: e5fd3f514e27db1f05fbd72ba615d74941e23c51
change-id: 20260803-c3-035-sanitize-err-v1-3aef2bf838bf
-- 
2.43.0

