Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590637;
	b=D7jVsbVK9SUqQTGuknRFZiPhCM6Xa/a1DfzK4ENQusoG7SNEa4c88dXuATdNJa3HrKlj
	 tG/LcWvU2TcI0okXkq2h68muFUi28pH4yXhzCL6cfQ+0krImmBC1gRsbSMccjMOSoiqZu
	 Dytt8cpqWNmTH9UGrf4MJaPnFgXurrrExdJLYe9r8rGO3FGswiioJsrzd5vpnv0vdKA/c
	 7MUcQl65EQSVFrmDR6E3DjDEoeD8iayjA6uwX+rPZe8k1fEWhMVqCe88IS2lIsSIk0n0S
	 X4yj03e0dBnRHNKz8EA1gJ7qHoH8IpIHSebkPOVdtMGkyCMKhDelFbUwvtUvOQVWoUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590637;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=FzkOoXGCFo4V8dRiwtaucZu3WkzX5KEVRGTWnMaTb5U=;
	b=htgpH7iNAobXMLL1YrPeh9GAKCV4XLtk/XisjSkv6kxXrCxYEiB8YA3jw0haeKNGK6Sy
	 5kZfopIN8EntDvy9dN9n/OJCt+9AbkieLKUxUf4gSq+2NyWxxcr3Xr2pa7mHOdWRO0QUE
	 HLBB14E1Tb+2iH2iCVhXQ60z395t7aqs2PQzqEHufR/RVYXUnpYdWqoYESl0npUkn90EG
	 hI/RU0tweWKBSgq3nxNqcM2wrH7pkui+SwT+Xq9v/wAMCzkfQ/QU6OIMjOwvdlEu7I6CY
	 uuDSYN+5kTWKa5cQGW/I/C1em5+1nr6A+ekC+UrK4njPflcMb51TmcrqQpkSod2pvJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oYhr2IdF;
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF02760A381F
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 17:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF02760A381F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oYhr2IdF
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b0cf2c0785so13621437b3.3
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 09:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794590636; x=1795195436; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FzkOoXGCFo4V8dRiwtaucZu3WkzX5KEVRGTWnMaTb5U=;
        b=oYhr2IdFDJbYRa1kso/L7xALY5aJIebtoKOP4A8LXUTZEB0lDwQu5Ps2uKXgA+k4b0
         HOz6/KkW6F6dsWSYZA8fiCqKzYFym9Xme5G11ikuLPs1Q4TikkS06gc+wTnADFbcXZwh
         mLZqlgJmwIKpGzAXJIHeCJtWtfuUlze+BSk7IlXQIVLd1MFanBOc2Ij2CPWMp0FescUC
         RqmFuppxxav2Wyi1u1ACqEovSeUXPHOQ5rE3ExKUay7Fh6CREEjRGbOo1GQLUAsNas0B
         09qo/jAW7W6cnxmO9N/04IgG4Fl6/ygc9cUPFVa6VVz2WyTXQaN4wKhXZZXHwcbCr+Me
         lb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590636; x=1795195436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FzkOoXGCFo4V8dRiwtaucZu3WkzX5KEVRGTWnMaTb5U=;
        b=gw8OjIuxoHEEKlx0Biv0shSxYyL3HagHfKGF7sP+GGCuThu7yh8YGcqCsGQ9CFfISn
         AemMguBl6tc9qRf2XKIPaiJWNdB0nUm0BcUDBkmonjzOJvRQADlc8nbgCc4jeIRZH8TK
         264BacoSCOv06cTKFK/VUJqh87HV/Y0LLc2f+9n0vOZiFOYZwFu0QpbPi30BwBpDilim
         fueSw1SI6GnUjwBXKZWjSBQ6+3P929mqL9Pg/ZONn7Tz/ZPxHVs3/5kOerBsaH0Ua5Kf
         mtC0q8LoIaHcreEJctuQluPz+J0Lffc4i8IS8nfFZc0Dc24AbM56J9DrhYX7qEmWDOPK
         QN9w==
X-Forwarded-Encrypted: i=1; AL+hErH+0LztS3XMLW9mDoQ8H0tFbUvAmTk9Kz7q7Tin9ss1mh3+JVsVWKoo2Kjjk7zesJFwab8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+jBED7v/eGmUR0+vDTvTX6Sq3tagD70jMLvrUJDswaYHHbs8S/
	DbBwzpdh1c64wQOTLHBdVwXQjhVFHtsXBIKHpjRbKKeeGVgv10jMFuqX
X-Gm-Gg: AYBFou1KhYKhiaZnkvHUMDNNquLKn/fnx0Mx6aZtM+Wvw9gefZSpJmBQ+sLqfBkzBpG
	brbNwbRnYgm7R5SuJTnY2bqoTS4eXZehMU97jjBnB2rBMq28TVsrLq2cDHSeieCmeKcZmso5swq
	F5r0UmQkEazV/CaxRK6gasBRVf1dze+DVVluZq3H4R3v5H4y2CyT0neujj8dA2Cvq+2wlaZ8tIU
	UF1aB3NUsTMAnJrOgCDm7SAs68wJ/nYsIujEaZwd7jboMhJh+qPcIcMmB+mxj+d5qxO1GHcxGkM
	ZuFrZ7Lb2Q5RG5KMCmF5c05sw01y6J54PNk4dqStXkFprFxZZmdxAgRbr7xmvOffX8fgOyjbX6U
	i6cZvSBMq6sbHSnYaMHsTUtz57gh7xk72Y5afbJ3BsHf7NdJN5Up3li0od+iWzszxAJqyrNeXPt
	Pc5Tx1voktVKgvqiG5okmk3Y5FEqEpqIo0QpzuL3LIcQnX8Cca+x22L/8Z2eGMh28TEbggctFzG
	3b2h+rf9hbdVWz/idnqlx2LNJHs6RrCgeXA7yb6vBKqLe+5Hjx+aDviijn9xz/gpdPnR9q+DoGO
	RgXO7Sx6VMvQWEUx6WGYDM0Q1Vg/o2xnnes=
X-Received: by 2002:a05:690c:6612:b0:8b3:38f3:8644 with SMTP id 00721157ae682-8b4aa0c91aamr15651357b3.11.1794590635770;
        Fri, 13 Nov 2026 09:23:55 -0800 (PST)
Received: from [127.0.1.1] ([187.15.141.223])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aa9dc1c9sm25187277b3.36.2026.11.13.09.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 09:23:53 -0800 (PST)
From: Nicholas Dudar <main.kalliope@gmail.com>
Date: Fri, 13 Nov 2026 12:23:43 -0500
Subject: [PATCH bpf v2 2/2] bpf, x86: Fix sign-extension moves in the i386
 JIT
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-i386_bpf_jit_wrong_code_20261028-v2-2-1dd0b03072a3@gmail.com>
References: <20261113-i386_bpf_jit_wrong_code_20261028-v2-0-1dd0b03072a3@gmail.com>
In-Reply-To: <20261113-i386_bpf_jit_wrong_code_20261028-v2-0-1dd0b03072a3@gmail.com>
To: Wang YanQing <udknight@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, Yonghong Song <yonghong.song@linux.dev>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, "H. Peter Anvin" <hpa@zytor.com>, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, visitorckw@gmail.com, 
 Nicholas Dudar <main.kalliope@gmail.com>
X-Mailer: b4 0.16.0

RFC9669 defines MOVSX, encoded as a register MOV with an offset of 8,
16 or 32, as dst = (s8,s16,s32)src, which the interpreter implements.
The i386 JIT ignores the offset and emits a plain move, so r0 = (s8)r0
with 0x80 returns 128 instead of -128. A verifier-accepted program can
therefore use values outside the range proved by the verifier.

Sign-extend the low 8, 16 or 32 bits of the source. For ALU64, fill the
high word with the sign; for ALU32, zero it unless the verifier inserts
the zero extension.

On an unpatched i386 kernel, a MOVSX test program passed a helper a
length beyond the verifier's bound. It stayed within the bound after
this change.

Found in a follow-up sweep of the JIT sources for instructions that are
selected by the offset field, and by reading the i386 MOV handler.

On i386 under qemu, with test_progs built as a 32-bit binary from the
same tree:

  # ./test_progs -t verifier_movsx,verifier_sdiv,jit_insns \
    -d jit_insns_blinded,'verifier_movsx/*@unpriv' -w 600
  [...]
  #191/28  jit_insns/movsx:OK
  [...]
  #649/1   verifier_movsx/MOV32SX, S8:OK
  #649/3   verifier_movsx/MOV32SX, S16:OK
  #649/5   verifier_movsx/MOV64SX, S8:OK
  #649/7   verifier_movsx/MOV64SX, S16:OK
  [...]
  #649     verifier_movsx:OK
  Summary: 2/172 PASSED, 16 SKIPPED, 1/6 FAILED

Without this change, the five subtests above fail. The six failures
left are jit_insns subtests that fail without the series as well.

Fixes: 8100928c8814 ("bpf: Support new sign-extension mov insns")
Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
---
 arch/x86/net/bpf_jit_comp32.c | 51 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 012161da3e82..2ed3f8aad8d5 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -266,6 +266,51 @@ static inline void emit_ia32_mov_r64(const bool is64, const u8 dst[],
 		emit_ia32_mov_i(dst_hi, 0, dstk, pprog);
 }
 
+/* dst = sign_extend(src, insn->off) */
+static inline void emit_ia32_movsx_r64(const struct bpf_insn *insn, u8 **pprog,
+				       const struct bpf_prog_aux *aux)
+{
+	const u8 *dst = bpf2ia32[insn->dst_reg];
+	const u8 *src = bpf2ia32[insn->src_reg];
+	bool dstk = insn->dst_reg != BPF_REG_AX;
+	bool sstk = insn->src_reg != BPF_REG_AX;
+	bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
+	u8 *prog = *pprog;
+	int cnt = 0;
+
+	if (sstk)
+		/* mov eax,dword ptr [ebp+off] */
+		EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EAX),
+		      STACK_VAR(src_lo));
+	else
+		/* mov eax,src_lo */
+		EMIT2(0x89, add_2reg(0xC0, IA32_EAX, src_lo));
+
+	switch (insn->off) {
+	case 8:
+		/* movsx eax,al */
+		EMIT3(0x0F, 0xBE, 0xC0);
+		break;
+	case 16:
+		/* movsx eax,ax */
+		EMIT3(0x0F, 0xBF, 0xC0);
+		break;
+	case 32:
+		/* EAX already holds the low word; CDQ supplies the high word. */
+		break;
+	}
+
+	emit_ia32_mov_r(dst_lo, IA32_EAX, dstk, false, &prog);
+	if (is64) {
+		EMIT1(0x99); /* cdq */
+		emit_ia32_mov_r(dst_hi, IA32_EDX, dstk, false, &prog);
+	} else if (!aux->verifier_zext) {
+		emit_ia32_mov_i(dst_hi, 0, dstk, &prog);
+	}
+
+	*pprog = prog;
+}
+
 /* Sign extended move */
 static inline void emit_ia32_mov_i64(const bool is64, const u8 dst[],
 				     const u32 val, bool dstk, u8 **pprog)
@@ -1706,6 +1751,12 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 					emit_ia32_mov_i(dst_hi, 0, dstk, &prog);
 					break;
 				}
+				if (insn->off == 8 || insn->off == 16 ||
+				    (is64 && insn->off == 32)) {
+					emit_ia32_movsx_r64(insn, &prog,
+							    bpf_prog->aux);
+					break;
+				}
 				emit_ia32_mov_r64(is64, dst, src, dstk, sstk,
 						  &prog, bpf_prog->aux);
 				break;

-- 
2.53.0

