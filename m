Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=131.188.11.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194186;
	b=ifppsKAmEBiJc12AW/Ye2SzbfygY2j64hW0Wfm7NPXnYp6bI0mr9nO7N2mabsYBe3rk4
	 v8JkoVOoThwLIZF5ScdT+rEliPiFmG2RM+lh4S18iLw97Ng9eiULGQmodDVbwTP/yT+w1
	 nIL1JngliMccoehkpnZvK+Z6wY3k+cOhuEkaVj5tbLv9+5qjiVqtrywEnUG6NUmU5JKQP
	 f1hEUSlj7pWjabNtzKpotONJroy+gZL1xAncg9WuM9pFZ/A5JXcIABaVuDG6LDvNW5e33
	 ZobNlqhneMBmd4ZFgoZUgQPt3n+VAEkJaLDkYsyfOx0Q0ipSWENhXepHbfDYIyO/CgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194186;
	h=DMARC-Filter:DKIM-Signature:Received:X-Virus-Scanned:X-RRZE-Flag:
	 X-RRZE-Submit-IP:Received:From:To:Cc:Subject:In-Reply-To:References:
	 User-Agent:Date:Message-ID:MIME-Version:Content-Type;
	bh=BGRmCHtTBLixUE+Eb/QtBkcTBXuwCY1+msHUfe8k0FU=;
	b=5N3GKCbyTOouZf8z/3PkfVWxAR6APWIz/VPjDBAetnBjpEWP+zFddQBTT1KgHEN+dl+u
	 07JGJfMj3gQHg0uR9Cn9EUiEGQ5QDnh9QWf0bo8LRrLcLi4IFeFDiuA/IeKPDVHLcEiIb
	 q2GYAjpuKhwhf3QZ3suNJnB7tnLO/+I1J25lVIjQW/b6H04ShX0/ZHuc6JsyYwUfHmseJ
	 B+ggF/6R5S8nyAARxF6UUYMY+86JOgtf68YNQR6Qcdx0edHsZhfAoehHVAIkEnJmnrBak
	 QOAUt9dBgl2jaqwXiGHxvIjJwST8SkrfaTo04CnDBEozEKBSDY6M/ovPSkN3Sob5lUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fau.de;
	spf=pass smtp.mailfrom=fau.de;
	dkim=pass header.d=fau.de header.i=@fau.de header.a=rsa-sha256 header.s=fau-2021 header.b=xVKNXpeZ;
	arc=none smtp.remote-ip=131.188.11.22
Received: from mx-rz-3.rrze.uni-erlangen.de (mx-rz-3.rrze.uni-erlangen.de [131.188.11.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79E1606A31F
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 13:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D79E1606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fau.de header.i=@fau.de header.a=rsa-sha256 header.s=fau-2021 header.b=xVKNXpeZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1793194176; bh=BGRmCHtTBLixUE+Eb/QtBkcTBXuwCY1+msHUfe8k0FU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From:To:CC:
	 Subject;
	b=xVKNXpeZ/q6sXDpU258bX4zACfqHfs8rg7C6UwHgwYy3UepCOEWXLYzVob29/AKhQ
	 LkfuyKhip++Q4uEppqmYhzjcATzMs0DLTRh40NNEzrDb96RAzcF6Yw6E7ApJqr+hWE
	 IyXjomOTIKROanyilScGc9SMUqFOlSbjwyACycNmu3JTSkdD/s94WYMNo9OzS5TNy6
	 ajHhXqJ3e7KZkZjWNtRrjQ/K+qJ6ov9D9gbU4Ae0ju5Jmeplhiof6pwcIv/yZ/Kt3q
	 Dxqq6mvd2MRUwWH0Zl3j8RnLXNh0iFSA2tMrD0d8Ki3ZfNZ+Tk4Oa4sQTwXyTZeqRZ
	 M3ZbAphJENVMw==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4jF7WN4fZBz1xwB;
	Wed, 28 Oct 2026 14:29:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:620:618:5b8:2:80b3:0:13d
Received: from localhost (unknown [IPv6:2001:620:618:5b8:2:80b3:0:13d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1/taKHf93pmFFmQnwizh423hMzCYhr+QRg=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4jF7WK3ffNz1xxW;
	Wed, 28 Oct 2026 14:29:33 +0100 (CET)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: puranjay@kernel.org,  memxor@gmail.com,  ast@kernel.org,
  bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 03/21] bpf, arm64: Emit ISB SY in the
 speculation barriers
In-Reply-To: <20261027182445.1156335-4-daniel@iogearbox.net> (Daniel
	Borkmann's message of "Tue, 27 Oct 2026 19:24:27 +0100")
References: <20261027182445.1156335-1-daniel@iogearbox.net>
	<20261027182445.1156335-4-daniel@iogearbox.net>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 28 Oct 2026 14:29:32 +0100
Message-ID: <87h5i6uf5v.fsf@fau.de>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Daniel Borkmann <daniel@iogearbox.net> writes:

> The Spectre-BHB loop of the epilogue and BPF_NOSPEC on cores without
> FEAT_SB end in an ISB, which the JIT took from
> aarch64_insn_get_isb_value(), the template of the instruction matcher
> with CRm 0. The Arm ARM lists every CRm other than 0b1111 as reserved:
> those encodings execute as a full system barrier, but must not be relied
> upon by software. Emit ISB SY with CRm 0b1111, as the assembler does for
> the isb of the kernel's own barriers.
>
> Before/after:
>
>   d50330df  isb #0
>   d5033fdf  isb
>
> Fixes: 0dfefc2ea2f2 ("arm64: bpf: Add BHB mitigation to the epilogue for cBPF programs")
> Fixes: dff883d9e93a ("bpf, arm64, powerpc: Change nospec to include v1 barrier")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Tested on ThunderX2-99xx in KVM (BHB loop forced on).

Tested-by: Luis Gerhorst <luis.gerhorst@fau.de>

> ---
>  arch/arm64/net/bpf_jit.h      | 2 +-
>  arch/arm64/net/bpf_jit_comp.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
> index b2fe6e6dcf44..af570c34a96d 100644
> --- a/arch/arm64/net/bpf_jit.h
> +++ b/arch/arm64/net/bpf_jit.h
> @@ -341,6 +341,6 @@
>  /* Barriers */
>  #define A64_SB aarch64_insn_get_sb_value()
>  #define A64_DSB_NSH (aarch64_insn_get_dsb_base_value() | 0x7 << 8)
> -#define A64_ISB aarch64_insn_get_isb_value()
> +#define A64_ISB (aarch64_insn_get_isb_value() | 0xf << 8)
>  
>  #endif /* _BPF_JIT_H */
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index febe072a8af2..7d5eb949cdf4 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1026,7 +1026,7 @@ static void __maybe_unused build_bhb_mitigation(struct jit_ctx *ctx)
>  		emit(A64_SUBS_I(true, r1, r1, 1), ctx);
>  		emit(A64_B_(A64_COND_NE, -2), ctx);
>  		emit(aarch64_insn_gen_dsb(AARCH64_INSN_MB_ISH), ctx);
> -		emit(aarch64_insn_get_isb_value(), ctx);
> +		emit(A64_ISB, ctx);
>  	}
>  
>  	if (is_spectre_bhb_fw_mitigated()) {
