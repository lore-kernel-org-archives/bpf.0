Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795664324;
	b=06x2JO5OUXfNNKiHCbQ93nu42HjZMU/6+3NGvK9TZhB+HanC6IrAnsxXZDD+0VMS5iNp
	 akhsUgreq3HyN69CvFKq3NawSkMALat30tLYNksfyQRXPeEe32Xn0Ic/elAADUWFP3AQl
	 1vD3I95FGIgBKOoxOlTyk2Fd3zxK6gBz+D1Db2kabw1vyIFjaxg9xg5Uym37VFyjSgbOM
	 hPDttNTQPG6iJrBUV1PChIN4aeqano41WRLOWenx8vfMkaECqrmq5aoR5ZCf88hNPXK8K
	 CXQ3rP5y7SNexYB7py3nC3tOCEFxtnSVX5+B33DHB0d6cAX01hCTeBXpJzFRvfXGDGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795664324;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jGA6xSwvJEknRammBn7700HNucWiAq+vSETg/tu4Wyw=;
	b=ZgZRNJ86oJbAfYQ1bXgyTzDHvhfms+JTZseUaMDOIoyTRLEcu6WnoOw3J92xs1MTTQsI
	 UbZpF9NVM4TI3Eq4s1ewMBXQ0zd7tBQnOEglLIyUxmiIl1CWMYQuGficVk5WZnNLi+qHl
	 kq9Oalksd2OsLuz199nkvFnWiO9MyQY8gdlg8hbyab1yDAhdulCdxv1V9m7Y46cUtFtID
	 8d5VVIhQxTJaVcNBECaLMoQ4wxO09N8EhudX3jZkAWMY0yHYM+duC5ISXlWaIobytsufp
	 wkIFZHYW6E6no6dKaRJ9dttyNH3X692FOe3SwouN08VBDMeiDOs/GqsKKM6+daU4P9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zRUyH8Fm;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB05606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 03:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EB05606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zRUyH8Fm
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2f02ee04378so52479395ad.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 19:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795664323; x=1796269123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jGA6xSwvJEknRammBn7700HNucWiAq+vSETg/tu4Wyw=;
        b=zRUyH8FmY/yCaOmUK5bkUjQg8sP/F4OyHkAn+GwJ0J0uSfC1hYHxUt5N/PLf5jsZCW
         8oTK18mJhWxWlh75kwEzVQbhy9hHxGfGuJM03cK+Zc6c3sg2JTEcGgPTMBmB28OpgING
         U7eEVMzHTp0b1mKhmWI4yAJ7CbDIGw8Jtee2edfDQQgeQWoBVpG9NWYarDKzs/ycGboF
         SFThm0H+TkRG7//5b0QvB444z3PC2+F3zbo8lNUCSvfuRYD2dtBn2M+T8nF0hR76J4UD
         ApEk65llpzuYddv20ltpdFu0GFbmXMU2BAgyiEiyoYWyrxvGVWxls2ao0zwNzgm3ctNl
         znzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795664323; x=1796269123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jGA6xSwvJEknRammBn7700HNucWiAq+vSETg/tu4Wyw=;
        b=gcMuuERv+Kll8q68+buS2xvP3MGarpKM57eic0naMtCPtLumFLjcIGEtGMTRM+qkRq
         TLnIoNnaycubtMyZoA/SF1nKIIPUMXNU0hnSe329xA46hdFmkEk8ZuG2i/Jmtt/9qZtA
         10vG7QT3BII3Mf1904bW+tZB848u+qLO9HIoBksElSiK4hTwKQsA3kIGXuWk7Mpqqm1K
         hOkMeIusOVIqKu5U6f41HnORrbfFpzAI6mPrYbomfGY79QNWU76ffAHmADeI0r40/Gqu
         Pob9PRP/H6xRwlDOKXI7nHESf+mmNbc+Z7OrAI8JT8vWfCWWdD0uwbV/mz7PvtxyM6CG
         GUuA==
X-Gm-Message-State: APuU4Z/80NRPhJULy+bfWOz3F+g5ZiL8H+vmsr//Bpeh++ixjk+oYPNt
	NaVZVsLZuJTLbSAEsylHukaHXRlieXRWRlM7igsWyHUiGjHRVh7LHxOQ6+7itA==
X-Gm-Gg: AZFdTZcOXVbCbyLWl98IRyz/HNhGuVwIQD4D0AA89PTAZkO6v2gs9kY/1N00pctInak
	wSejXuao1sR6NjfGXPCddlRNCvR78GePkp4pSMCig4utM80/0xmfhPK588BLFTPStWwj+jHV89b
	RHM2MieCuFQnWYpHbHI5fzH61wGEFjsNqiY7P7MidOY+HvGWS1Fy1QJ2OChVIW/h6H7uiNEO35Z
	rYWzW7PMD1jVZ3q+e0Rm7vYUCXXgt5NjxqNJ0vAexPWmESvU+5fUkLfCwiDKLvOBpAmOAoLHTOb
	0tYFmongU/bzfe+p7wW22lqO5u9WtFub3gMUzZ5H0CQO64S8vMtaAAaZd2FQztemcVQ5JBzZJDG
	DbIcEYhhGspbAkgUzB4eRa98VheokjcKPEwBlJzi7Dz7dA+6qXJYxfQCZ1d/1sADsXtLbsaMb15
	b85jx/KWB+Zetuy9ZPaNE0WtDMrFdivcuc7kj80uN0d4oZeE1j+cz7oGakAsqha/ewK/z0FVY8T
	idliKmrEdNoq4DPAU1RPZvuZGdnpDjF0qjpceR2fmbNSsiFEalwQ/idG9zXOtAKKTV5d5CNK72z
	1fZ9BbAZjnKeBEnZNkfBmSr/WV20dRgWsvqEyFipi4QyNEgKAxdrhhupsBuU2GQXYrW7eMKZzVz
	nonfhOLb2C6+2SDfzdTp5aNwYKxlu5926B/RHRj5Jo5VV6dk0jYgbdvnScbYiFyfQcP5PbssCkv
	/u/sxdzgYsH5NRsoMM4mc=
X-Received: by 2002:a17:902:f547:b0:2ef:dc8b:7c0c with SMTP id d9443c01a7336-2f03f256468mr236024645ad.52.1795664323414;
        Wed, 25 Nov 2026 19:38:43 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee84027sm96142775ad.7.2026.11.25.19.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 19:38:43 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	luis.gerhorst@fau.de
Subject: [PATCH bpf v2 4/4] bpf: Emit nospec after calls and atomics that write to the stack
Date: Thu, 26 Nov 2026 03:38:16 +0000
Message-ID: <20261126033816.4124847-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126033816.4124847-1-alexei.starovoitov@gmail.com>
References: <20261126033816.4124847-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

check_stack_write_fixed_off() sets nospec_result for BPF_ATOMIC insns
and for calls of helpers and kfuncs too. do_check() ends a speculative
path there, but bpf_convert_ctx_accesses() emits the nospec only after
BPF_MEM stores.

Later passes rewrite a call and need its aux data. Put the nospec in
front of the next insn.

Fixes: d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1")
Fixes: 880442305a39 ("bpf: Introduce load-acquire and store-release instructions")
Suggested-by: Luis Gerhorst <luis.gerhorst@fau.de>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/fixups.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 9d5f2774bf8f..8c3a17a05a4e 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -911,6 +911,7 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 	const int insn_cnt = env->prog->len;
 	struct bpf_insn *epilogue_buf = env->epilogue_buf;
 	struct bpf_insn *insn_buf = env->insn_buf;
+	bool nospec, nospec_next = false;
 	struct bpf_insn *insn;
 	u32 target_size, size_default, off;
 	struct bpf_prog *new_prog;
@@ -994,8 +995,13 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 		enum bpf_reg_type ptr_type;
 		u8 mode;
 
-		if (env->insn_aux_data[i + delta].nospec) {
-			WARN_ON_ONCE(env->insn_aux_data[i + delta].alu_state);
+		/* A call or an atomic gets its nospec in front of the next insn */
+		nospec = env->insn_aux_data[i + delta].nospec;
+		WARN_ON_ONCE(nospec && env->insn_aux_data[i + delta].alu_state);
+		nospec |= nospec_next;
+		nospec_next = env->insn_aux_data[i + delta].nospec_result;
+
+		if (nospec) {
 			struct bpf_insn *patch = insn_buf;
 
 			*patch++ = BPF_ST_NOSPEC();
@@ -1102,6 +1108,7 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			delta    += cnt - 1;
 			env->prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
+			nospec_next = false;
 			continue;
 		}
 
-- 
2.55.0

