Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E803630AD;
	Thu, 13 Aug 2026 12:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786622482; cv=none; b=cF4BrhP7/YoPL85m8Km+mna+MuuZ4S7JDvSoIiGo4mGGkGcdUr+blJBl+TrtzWiI2StbwJMX0NLqBCpXiAIOXiIzmgyGU0XpPlFrX07wkyS/vtCxHohj5uvE4ndEkqDlhqDsc26Zq3PqgzPmTnVUZAz7Edos224HYxB0ywNWldY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786622482; c=relaxed/simple;
	bh=SadDlS2PnkPWF4BBgT4udo6zw/CIXbGksAEbMwF7c3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q4pZBu+9Dd7SiyaMIUY5oEutbzY9m3wuTcueUe5DJF1sMSEtKKvCLtswOgagu7hiwU+CakuX/VfA6Fu0zrIzyEiNsvsSmawYi2gdhc4ehEsUcsqrwx8iUQp2NzE+Q1ui+X/NxnTmpAIxiwnr/j0stt2S79/bbYVupsU34HlBOtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=CHWFW1fN; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="CHWFW1fN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=mhmg0jz4epF+mQMXviAL//brfEBQt1P
	V3NeoVdN0B7k=; b=CHWFW1fNEUFTrFagg+Z9vSzAmnbZFDqNU8yIAPcmhl/heMg
	h3yFV2Q4MD69Dy+dkIBJclymrMDYcmc6xgIR2fH85CX+KQlCQJstO9OL4aPbZYI8
	K20d6Ep3zctvDvboXCI0e37JDim4Q3hzHxqL0h2pnFNJzOZ8+3eYV7HAmKHA=
Received: from [172.17.0.4] (unknown [101.6.30.195])
	by web3 (Coremail) with SMTP id ygQGZQAn+BbosX1q_MyTAA--.65327S3;
	Thu, 13 Aug 2026 20:00:46 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Date: Thu, 13 Aug 2026 12:00:40 +0000
Subject: [PATCH bpf-next 1/2] bpf, x86: Normalize narrow kfunc returns on
 IA32
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-bpf-next-039-ia32-kfunc-return-v1-v1-1-37495ec632b5@mails.tsinghua.edu.cn>
References: <20260813-bpf-next-039-ia32-kfunc-return-v1-v1-0-37495ec632b5@mails.tsinghua.edu.cn>
In-Reply-To: <20260813-bpf-next-039-ia32-kfunc-return-v1-v1-0-37495ec632b5@mails.tsinghua.edu.cn>
To: Wang YanQing <udknight@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786622447; l=2921;
 i=chenyy23@mails.tsinghua.edu.cn; s=kernel; h=from:subject:message-id;
 bh=SadDlS2PnkPWF4BBgT4udo6zw/CIXbGksAEbMwF7c3s=;
 b=HqmqozPAkMGLtZ43esDle7cF+qJ+mSkEOaGdrPWJekfXMchm2kdzN8equ1g6CfyL2N4/Lc6sN
 mkf7QuXui0iBrdSJNZMmb1FMQi5KtrHLFb0Es4WtOvzd7bRCVTpXkN1
X-Developer-Key: i=chenyy23@mails.tsinghua.edu.cn; a=ed25519;
 pk=+Q11PEDVzoU+87KHlIeNWKwv/GiutzE5094ej7opM+s=
X-CM-TRANSID:ygQGZQAn+BbosX1q_MyTAA--.65327S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGr4rCFyDAFW8uFy3GrWruFg_yoW5WrWxpF
	WakFWfCF1qg343Xr1aqr1kZw4rJa40qFsFkrZI9347W3Zrt340gr4aka45Xas0krnYkr15
	GFWY9r1S9anrZw7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBS1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r1Y6r17M2vYz4IE04k24VAvwV
	AKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6x8ErcxFaVAv8VW8Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrw
	ACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wrylc2xSY4AK67AK6ryUMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_GrWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87
	Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOq2NDUUUU
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

IA32 stores each BPF register in two 32-bit scratch words. A kfunc
returning four bytes or less currently updates only R0.low32, leaving
R0.high32 with its previous scratch value even though later BPF
instructions may read the full register.

Use the BTF function model to sign- or zero-extend one-, two-, and
four-byte returns into EDX:EAX, then store both words of R0. Keep the
existing EDX:EAX handling for eight-byte returns.

Fixes: 797b84f727bc ("bpf: Support kernel function call in x86-32")
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 arch/x86/net/bpf_jit_comp32.c | 53 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 852baf2e4db4d..017cc9e7e4e2b 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -1620,13 +1620,25 @@ static int emit_kfunc_call(const struct bpf_prog *bpf_prog, u8 *end_addr,
 		/* add esp,"bytes_in_stack" */
 		end_addr -= 3;
 
-	/* mov dword ptr [ebp+off],edx */
-	if (fm->ret_size > sizeof(u32))
-		end_addr -= 3;
-
-	/* mov dword ptr [ebp+off],eax */
-	if (fm->ret_size)
+	switch (fm->ret_size) {
+	case 0:
+		break;
+	case sizeof(u8):
+	case sizeof(u16):
+		/* mov[s|z]x eax,[a]x */
 		end_addr -= 3;
+		fallthrough;
+	case sizeof(u32):
+		/* cdq or xor edx,edx */
+		end_addr -= fm->ret_flags & BTF_FMODEL_SIGNED_ARG ? 1 : 2;
+		fallthrough;
+	case sizeof(u64):
+		/* Store EDX:EAX in R0. */
+		end_addr -= 6;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	jmp_offset = (u8 *)__bpf_call_base + insn->imm - end_addr;
 	if (!is_simm32(jmp_offset)) {
@@ -1637,15 +1649,38 @@ static int emit_kfunc_call(const struct bpf_prog *bpf_prog, u8 *end_addr,
 
 	EMIT1_off32(0xE8, jmp_offset);
 
-	if (fm->ret_size)
+	switch (fm->ret_size) {
+	case sizeof(u8):
+		/* mov[s|z]x eax,al */
+		EMIT3(0x0F, fm->ret_flags & BTF_FMODEL_SIGNED_ARG ? 0xBE : 0xB6,
+		      add_2reg(0xC0, IA32_EAX, IA32_EAX));
+		break;
+	case sizeof(u16):
+		/* mov[s|z]x eax,ax */
+		EMIT3(0x0F, fm->ret_flags & BTF_FMODEL_SIGNED_ARG ? 0xBF : 0xB7,
+		      add_2reg(0xC0, IA32_EAX, IA32_EAX));
+		break;
+	default:
+		break;
+	}
+
+	if (fm->ret_size && fm->ret_size <= sizeof(u32)) {
+		if (fm->ret_flags & BTF_FMODEL_SIGNED_ARG)
+			/* cdq */
+			EMIT1(0x99);
+		else
+			/* xor edx,edx */
+			EMIT2(0x31, add_2reg(0xC0, IA32_EDX, IA32_EDX));
+	}
+
+	if (fm->ret_size) {
 		/* mov dword ptr [ebp+off],eax */
 		EMIT3(0x89, add_2reg(0x40, IA32_EBP, IA32_EAX),
 		      STACK_VAR(bpf2ia32[BPF_REG_0][0]));
-
-	if (fm->ret_size > sizeof(u32))
 		/* mov dword ptr [ebp+off],edx */
 		EMIT3(0x89, add_2reg(0x40, IA32_EBP, IA32_EDX),
 		      STACK_VAR(bpf2ia32[BPF_REG_0][1]));
+	}
 
 	if (bytes_in_stack)
 		/* add esp,"bytes_in_stack" */

-- 
2.43.0

