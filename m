Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE9E364953
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039639; cv=none; b=tZayCxlli9qfgpz42UGCRH9pB+h8UU05Qo/p4bXh8c8QT/6UOEuGXmOx9RQSqF64lqnm5ROEMUvfgtyEkyJe4tRA+MQAV8p+XNkrWKhUR0WeEGgJpbf8fb0r2JxhmERHou+1Q5KXTQEE0PfGzLCer9d1/9RUmLL0buhLF3XiFbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039639; c=relaxed/simple;
	bh=1pwrmGoI2znFs9aA7z/jNtpCwf4SCSIbos4sJ//NoFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jiTpQ7htiM+7D/KVu9RE1+PNLeJU5gSzIGNcRvLHXsrCNYiByAyp15vtERAjvvEA1TBvAVJgyCWhQJdx6JUv2HJeooAQEm1LCzmElZsT05kx1XIEJ8k96NDQsEFB2cXdTB1ZTshDdj2lWaddXfmgvkvSaSVVovHeWcyza44AtUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIHojT+y; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIHojT+y"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39e03468a5fso3169550a91.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 18:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790039638; x=1790644438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nBv3mxUr3KmVR5YmKvrfuZHoT+cn5SyjpG93qzw9qDk=;
        b=EIHojT+yFjDRhtaoizxcRZuDk5mTXfCjihHX15Jwb0ajpC4nazzZgCwuJ6F1Fu9rem
         m2YjkJ6j+oJNiJoOBe6p5T7whHvqwiVyQgCIftXCJDsuPE1Mv6ZG6Mt+0pYC6X29q/uS
         gR40p1cclC5Taxu45kAbhqnE5XrvdHx/twZBM2oFuoOex3qcS66awyEcRRSsZfKjLRSG
         eG9xpR0lZcgkToZ/FtEGYHHXgKMa9pqg7wNwugxpoUkhdJ2Gr+QebEsfy2x6T7+/3F7b
         M5Swk7bSFb4+foIiGLGXahm9k39Eu+74RovujNp9FFNFaaCOqQ/xKNUZe8CAU6kpqllT
         wDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039638; x=1790644438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nBv3mxUr3KmVR5YmKvrfuZHoT+cn5SyjpG93qzw9qDk=;
        b=xJU6ET72rHM733yzK1PJL4ZFAhKbtGUw4TZ1bpzEnNenrNzMZyHiWqVQttdarV+2Re
         f7QGbExMRty/0CZN79PDwYV9Z9U4XkLaqeqBiz4xQZUd+KxG510OYHPhAN2qKZdhHhVs
         wi/FjHf16c7oQmNgkO+iJy+N9zObdqdEXZKKUuo6k0tRDMIAMWFTRfjwmaYuWp5jajPO
         nEn9d5kLAKGaFK97YaPSZZXrxm2/zEZ7tG+r/1adCpwOso1pN4YdQj+kt/E/4OsJautx
         43eeVYSkfgu3x3UzGCH69CzmrJpSM2nD/QBd1Fip1FWVWPOZKjNxGHHD58ZMLf3Jc2HO
         FSig==
X-Gm-Message-State: AFuF++mzKWizF6T6DNh10iTXfF40ladIKLtF8isafEXtpiwiEuz7kh7w
	vppFSWvBalbEVbKw2p0v8fNFa43scHSsqVag2GPRvVhz1Y98llaq+1GAHFdVWg==
X-Gm-Gg: AYBFou3pyzgmu8YCbiONWPqtvpkFFX3etDTBlOY98z68ITANlm+DSpzAXy8fhluAuhh
	UatS3+W0XjS//QY/NT+4gmPp84KNzywZln5rut3b/c/+mK8Oot2Ga+S9dfb0/dye/i3dv7UmQvi
	iIAWhfFmzxzbqg4YcE4ckttkJUiZMg76rYjweOLd3Tq8l2rBVyEo/Ycrszrfe48gbCtHEhDgs4T
	scVP4VJtPFbO69/oPsLzAvggZiYstdXIciGT5Q2XqbhuxioFoCgv4xd33vwLXoaDFatdkq3oA4V
	8gFFUjn2E0qdYk7gvjjpOCSS+lAAtQaOD5mOvTUWVkORqlwsy5HAfa1YihT+m8uPnXuaUgPtZ5s
	/f3ozEKBrwI1ks56u3SHl/cTpZsrY4kRWRwIfK36xvGBeJHEgVPafCX2iCGjKUTWidF+ePKTRaY
	ZNskODQm1iEvpZ0mOfBxGrAnLmaNm0llnY1DV9q9BIvb8AaZRzCBF0g3g9YsOgWx2V6o0+bp8t0
	bMYwn7Wy1wDtnEPqWsnFGKxVHFxsyWFJbcoMWUVftl5dxPz1zCv+pZ47J3wytSAscEJ/n0M0LAV
	LROp/n9kCIcQfy5/OQW2RUjzpA9cw2QO2h7UGWw5bAw=
X-Received: by 2002:a17:90b:540c:b0:3a0:516d:9f7e with SMTP id 98e67ed59e1d1-3a06af631cfmr813108a91.45.1790039637809;
        Mon, 21 Sep 2026 18:13:57 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06e5a5e7fsm240315a91.13.2026.09.21.18.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:13:57 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH bpf-next 08/17] bpf, arm64: Add JIT support for callx
Date: Tue, 22 Sep 2026 01:13:14 +0000
Message-ID: <20260922011323.1298619-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
References: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Emit callx as BLR to the register with the address of the subprog and
move x0 into BPF_REG_0 like after a direct call.

That's what a direct call of a subprog out of BL range is JITed into
already. bpf functions start with BTI JC. The arguments are in x0-x7 and
on the stack. Tail call counter ptr and private stack ptr are in callee
saved x26 and x27.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 6c04fee46876..9544b2f483e5 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1789,6 +1789,17 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 			emit(A64_MOV(1, r0, A64_R(0)), ctx);
 		break;
 	}
+	/* indirect call of a bpf subprog, dst holds its address */
+	case BPF_JMP | BPF_CALL | BPF_X:
+		/*
+		 * It's the same as a direct call of a subprog that is out of
+		 * range of BL: the subprog starts with BTI JC, the arguments
+		 * are in place, and the registers that hold the tail call
+		 * counter and the private stack are callee saved.
+		 */
+		emit(A64_BLR(dst), ctx);
+		emit(A64_MOV(1, bpf2a64[BPF_REG_0], A64_R(0)), ctx);
+		break;
 	/* tail call */
 	case BPF_JMP | BPF_TAIL_CALL:
 		if (emit_bpf_tail_call(ctx))
@@ -2485,6 +2496,11 @@ bool bpf_jit_supports_subprog_tailcalls(void)
 	return true;
 }
 
+bool bpf_jit_supports_callx(void)
+{
+	return true;
+}
+
 static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_node *node,
 			    int bargs_off, int retval_off, int run_ctx_off,
 			    bool save_ret)
-- 
2.55.0

