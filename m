Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602705;
	b=XAaEVocHR0fPkujvDsjsJbjHPghpTX74Hv8WOKxdJ0S9GYVIxGLQLhKZymqCbB/yS2nW
	 mC+Y3HJxD85+Zayk/c/ldgm/tgzRlrJPRNFRAcj0TZtAbuuGHM1AyZvCkjUlh4WHDegJV
	 JlLUrldzDMcWncVpC2fjxwwtYeNqMGNRybj5210RzLazuwza5NQLME6cbk3hmjLikk60h
	 FMmdCrjVHbd83OiWV6b9Kx7RU1vLdKDM4SHc/s1Xmnysdf4GnFlhMtPpYBBQqv6/KKeSx
	 KTHG0q1WR9sVdmtXYxWH99EHMmbYtNQN74M9VH5dtK9iOL5ovueMuPe2QKdgUSLp+VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602705;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=kWSErL8M0Zrcc9bNez1sKQXL8Q35fI7UYN2RBWREyKs=;
	b=4CiT/Cqgapw1WqTH4usaCzHbh4/Khrx0qVBog9Hqqvll3y1hcwHM8uUWdN6z2FH38Z6V
	 YqHwRkQldVhfrFzGPnoFkV5RYxndhw6y6lfZ/FzIvIvt/0akzTR8K8bUY4x8ggiivselT
	 qnxkzoC/+R2M+jqds5wlRbUYX4Cp+1H5zMGyopgZf52pHBFuvFu20DFjWdF5gEvIB15hL
	 bzFFJNkNi4p1hco9QXWfXIqiEPE1jDk+mBKRl60KKu91kK6WuINRNVFRfCJSGCZCJk9y9
	 OgNic/WrCM3ByIZJmJXPmpcEEexOCu0nSN+R0S07AXkDX55eyA56G05APXljQtWwhhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AaMus1hV;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BDC606A31E
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 17:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34BDC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AaMus1hV
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e8b20a899fso5634335ad.1
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 10:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792602704; x=1793207504; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kWSErL8M0Zrcc9bNez1sKQXL8Q35fI7UYN2RBWREyKs=;
        b=AaMus1hVio6zg/9LoarIIBEkDnFMQdnQoGlqR0h/7EEarLlw794dPT5byofFFeCznU
         aFOeoFbIBXEWYPlqa9PKU/ss5RIKGIpjKiVwkALyTQmh6g+ehnGjcVskUgvi20N9nxjA
         ie5bN5DsO3RjDzjjW4WSDezD+249TU3rMb7+Pg3GXUO/NmXiJiBCiUZIKVFf5cn2Dp3N
         ySBH0E2hckaGBBaHCKAw7hMOBSSQhIvSMWJQQ68CNoHpnVB8I1MwlvIKRM2swZxQf4hL
         4RX+rTXJImXC5AwGt/asVYdYqu9mn1+kEXAmr8ruJU7WNU55+SgesHMMv9RUEqpG33zd
         4PNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792602704; x=1793207504;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kWSErL8M0Zrcc9bNez1sKQXL8Q35fI7UYN2RBWREyKs=;
        b=O0u3lwwWAEDRhTCgoQgnZPx2FPkffDNaiDFmVhrA5yKh12wUo+0hCV0QWDKQ8NJV7z
         /zsZl4HunGnHLglVGFwHBM8VXHcSUXA4K9x1yn98b/mekGxCVDrY406RwMWf81ppg8hj
         L0S5ghVtyDCC4DCFTSwCsgAms1UbWmUAaqqbmewdulDN2e1JU8IE4Pn2J+JT6Unnu5ZH
         JWE4+7uHmRr4C6cq/uLVCgzsyb51QEcqyuTBIEYg8Ho1QNOnmMH4wYSrMkErLrZoka7k
         CzHkKuTxCMZ1ysD5AQAU93MUkUygKUHD1hWimmJxCl5/UpoVdaApjVTZTot2XkpRtwtS
         FdnA==
X-Forwarded-Encrypted: i=1; AKwUvBxWSwylvsMH/764b9xUlYT2aovSHTbufo9NWJkWk+BtbfAowl/YhD5v1rLu/XdYQk7dG+8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZTLbBRi86Qj6JaRxZKf7EUYMlS+3ayLDs5fFA6acL1tejym5t
	HTu6p/yUguIiSyXZ3DIzx77GOmceSDnC/uEVooVX/vNIQds4VDRgnFMM
X-Gm-Gg: AYBFou1CSEmOXrqvOg9rQ75ZMLXIVGi/iErCc24GFE6sQwWT9rgnnvX9wMiLlt13qGM
	GDRfqK9oJeJd8b04PVXeEJhElG7TDXarYsHorP95foCB5myzJ+fA465gaze701Ago5VFDHOtNAT
	RMiKGJRDH2jWSoLyvRyuQdUpdtw/r0hQVRjudCxmHQorE6C/UweqnkWci7TcA7wmLlBVRaNgDZ2
	ifWF35EetkWTW1NrLGHomJJJDcUQo31nFC44zAJrZOpgJWQmIe6XHY8DTGCL2M5WfGS3HZk14+Q
	ho/+D3Yitj/RKc3bUwXmu5WZWPvGkOzEohtsitzO4g2N0+CFQryicO5xpYVrT82peLiX8gASZu5
	Kw+R+ox0RfhY2x1jzcP7Xq+0MGCzb5Mjq1x5XdlnYs4Ml8kjWuxY1UnxzWlzY4PApTk5gnjMv9R
	leOS/2fHXRVurdNYDCFZtLhY7oYVniiDSlXpHLCIAVR1vSwHS0valgVQAVxjoPqcD0AhQQONPrH
	H7g+ywlgTYKtnQanSQPK6tzxLYq4onx3iGlNc3YPPhCB1JT0zI8nVj3TuwBkWvh074azONDcAaL
	vZagszZbc9k4AfJiCzaAqi6lWIJf9G98RRLlyAvZ/oGkuRRlWBm2ejM+7HgPLA==
X-Received: by 2002:a17:902:fd8f:b0:2e3:1776:278f with SMTP id d9443c01a7336-2ea43f52371mr22587935ad.42.1792602704368;
        Wed, 21 Oct 2026 10:11:44 -0700 (PDT)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b43478csm14601635ad.28.2026.10.21.10.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 10:11:43 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 17:11:42 +0000
Message-Id: <DMAOMH0CLDLX.127F7BRYUOQEG@gmail.com>
Cc: "John Fastabend" <john.fastabend@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Quentin Monnet" <qmo@kernel.org>, "Puranjay
 Mohan" <puranjay@kernel.org>, "Xu Kuohai" <xukuohai@huaweicloud.com>,
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, "Pu Lehui"
 <pulehui@huawei.com>, "Catalin Marinas" <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
 "Shahab Vahedi" <list+bpf@vahedi.org>, "Russell King"
 <linux@armlinux.org.uk>, "Tiezhu Yang" <yangtiezhu@loongson.cn>, "Hengqi
 Chen" <hengqi.chen@gmail.com>, "Johan Almbladh"
 <johan.almbladh@anyfinetworks.com>, "Paul Burton" <paulburton@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, "Helge
 Deller" <deller@gmx.de>, "Hari Bathini" <hbathini@linux.ibm.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Naveen N Rao"
 <naveen@kernel.org>, "Luke Nelson" <luke.r.nels@gmail.com>, "Xi Wang"
 <xi.wang@gmail.com>, "Ilya Leoshkevich" <iii@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "David
 S. Miller" <davem@davemloft.net>, "Wang YanQing" <udknight@gmail.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 <linux-doc@vger.kernel.org>, "Tianci Cao" <ziye@zju.edu.cn>, "Yazhou Tang"
 <tangyazhou518@outlook.com>, "Shenghao Yuan" <shenghaoyuan0928@163.com>
Subject: Re: [PATCH bpf-next v2 1/8] bpf: Add UHMUL and SHMUL instructions
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <tangyazhou@zju.edu.cn>, <bpf@vger.kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "David Vernet" <void@manifault.com>, <bpf@ietf.org>
In-Reply-To: <20261021-bpf-hmul-v2-1-88e260099f7d@outlook.com>
References: <20261021-bpf-hmul-v2-0-88e260099f7d@outlook.com> <20261021-bpf-hmul-v2-1-88e260099f7d@outlook.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Oct 20, 2026 at 10:40 PM tangyazhou@zju.edu.cn <tangyazhou@zju.edu.cn> wrote:

> +static inline bool bpf_insn_is_hmul(const struct bpf_insn *insn)
> +{
> +	return BPF_CLASS(insn->code) == BPF_ALU64 &&
> +	       BPF_OP(insn->code) == BPF_MUL &&
> +	       bpf_is_hmul_variant(insn->off);
> +}

Patch 5 adds this check to 13 JITs and nfp to opt them out.
Lets make JITs opt in instead, like bpf_jit_supports_callx().
The verifier checks it once. x86, arm64 and riscv patches add
bpf_jit_supports_hmul() that returns true. bpf_prog_is_offloaded()
covers nfp.
When JIT is on and it doesn't support them the prog is rejected with
a message in the log instead of silent fallback to the interpreter.
Then patch 5 goes away and only arm64 and riscv acks are needed.

Like:

diff --git a/include/linux/filter.h b/include/linux/filter.h
index e0218e6..6ee8d1a 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -152,6 +152,13 @@ struct ctl_table_header;
 #define BPF_ALU32_IMM(OP, DST, IMM)				\
 	BPF_ALU32_IMM_OFF(OP, DST, IMM, 0)

+static inline bool bpf_insn_is_hmul(const struct bpf_insn *insn)
+{
+	return BPF_CLASS(insn->code) == BPF_ALU64 &&
+	       BPF_OP(insn->code) == BPF_MUL &&
+	       (insn->off == BPF_UHMUL || insn->off == BPF_SHMUL);
+}
+
 /* Endianess conversion, cpu_to_{l,b}e(), {l,b}e_to_cpu() */

 #define BPF_ENDIAN(TYPE, DST, LEN)				\
@@ -1281,6 +1288,7 @@ bool bpf_jit_supports_kfunc_call(void);
 bool bpf_jit_supports_callx(void);
 bool bpf_jit_supports_kfunc_ret_reg_pair(void);
 bool bpf_jit_supports_unwind(void);
+bool bpf_jit_supports_hmul(void);
 bool bpf_jit_supports_stack_args(void);
 bool bpf_jit_supports_arena_args(void);
 bool bpf_jit_supports_far_kfunc_call(void);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f29b0aa..90c30e5 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -34,6 +34,12 @@
 #define BPF_FROM_LE	BPF_TO_LE
 #define BPF_FROM_BE	BPF_TO_BE

+/* BPF_MUL off values for high-half multiplication; BPF_ALU64 only. */
+enum bpf_mul_variant {
+	BPF_UHMUL = 1,
+	BPF_SHMUL = 2,
+};
+
 /* jmp encodings */
 #define BPF_JNE		0x50	/* jump != */
 #define BPF_JLT		0xa0	/* LT is unsigned, '<' */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3030beb..e17704a 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3405,6 +3405,12 @@ bool __weak bpf_jit_supports_unwind(void)
 	return false;
 }

+/* uhmul and shmul */
+bool __weak bpf_jit_supports_hmul(void)
+{
+	return false;
+}
+
 /*
  * How this arch places a by-value kfunc argument, or NULL for one that has
  * not opted in and so only takes an argument of a single eightbyte, which
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5601d20..9a3c97d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21194,6 +21194,17 @@ static int fd_array_get_map_idx(struct bpf_verifier_env *env, u32 idx)
 	return -EPROTO;
 }

+/* The interpreter supports uhmul and shmul. JITs opt in. */
+static int check_hmul_jit(struct bpf_verifier_env *env)
+{
+	if (bpf_prog_is_offloaded(env->prog->aux) ||
+	    (env->prog->jit_requested && !bpf_jit_supports_hmul())) {
+		verbose(env, "JIT doesn't support uhmul and shmul\n");
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
 static int check_alu_fields(struct bpf_verifier_env *env, struct bpf_insn *insn)
 {
 	u8 class = BPF_CLASS(insn->code);
@@ -21249,6 +21260,13 @@ static int check_alu_fields(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	case BPF_MUL:
 	case BPF_DIV:
 	case BPF_MOD:
+		if (bpf_insn_is_hmul(insn)) {
+			if (BPF_SRC(insn->code) == BPF_X ? insn->imm : insn->src_reg) {
+				verbose(env, "BPF_ALU uses reserved fields\n");
+				return -EINVAL;
+			}
+			return check_hmul_jit(env);
+		}
 		if (BPF_SRC(insn->code) == BPF_X) {
 			if (insn->imm != 0 || (insn->off != 0 && insn->off != 1) ||
 			    (insn->off == 1 && opcode != BPF_MOD && opcode != BPF_DIV)) {

pw-bot: cr
