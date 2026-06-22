Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A2C23D7F0
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 21:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782163690; cv=none; b=onncRlDL/alZM1WMx/I/N3FkZ956KSQgX3rmzhup4SRyjmHQ6daFEjLlEgQ2JWmJJIc/phrnyuYNPL+56srlKYtOISEfgf+auymltHroDgO3P8zeHtpu0j+PwZ7++s1eSSMvcxcvVG/T2s/TvYTptZFDF6mAEOrVd1cWjuJPxeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782163690; c=relaxed/simple;
	bh=mYxsFEqatuqfwcXdCizKKI1fhpC8U1gkSogJsK7qKaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFbrgmNTJ/koKrITsB6oBv1QsxEJ78cXicJwdQ/O/8i7EuX5Nd84pNEvuuabx9MPoTAsBKPi4PzJPXckk7eqHQx7Di05lyFo9d212ftaBmTYQ/DsXsEsAhQgiPErbpv/Sg/IGzWMyrFsG7NNG8Gsk0Pmd9aYQu380DfejDsBj1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzT4cL7d; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzT4cL7d"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84231305a80so3020889b3a.0
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 14:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782163689; x=1782768489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JuqJabFFbQmPGzhmB4FLpo8sCHROklOUvbmq7PrEhNo=;
        b=HzT4cL7dY6KirZcZuIrqais75sr+JShVwwL7E1a1EKRB6Bj+8ULM54QFAMo1FjMAJZ
         ZJ4yYBgJNutECiFrgSoO7MWR+LCxOXDJcXIkh+aSYxkdm16/F3lFdX7Gt+qQvjAQu8Jp
         lwN1apRP16rWqkRV384NKgm4uRishIK26hBOyjmUowBAc5xYyYAIr7OyIWZ0Xtx5n8dM
         kfmQessewmGfmu8wJM9j1RU2plwp0kx/rt81jYpTd3JaUaSWInHawBUC3U1XaSR+UZP3
         HNhlu9cYX30z0rzCKv8XjiN8/GnhYFCnzGZD9DF+rpx8cZCPbb8DOEJiUI2uM8ZF4GAL
         jgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782163689; x=1782768489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JuqJabFFbQmPGzhmB4FLpo8sCHROklOUvbmq7PrEhNo=;
        b=j7NGb9dVBvJj5H3RjiQWbd1JTOmM2zLl5gpPaORebhg8rVWB+H3i1BjQDEELDq05zu
         IRxJG+4sm89e0g+UyFMO6yEX1QGI+uaofx3x2+0JcTkA9TVjvTGrM4BbuKDbYhDASZhf
         dXXWXq2+gvI67MwpOdzxDDZ5lDboqwneftS+tFZz9NzDP/1dkymOlK0vhKkNYFZxC2sC
         mdlpSqYFeOib0sbikzHy+MaatTwnWwM8XRg0qAHHCvBtgoXLwKQAVvVPGwbJtSj9iykl
         5WN97T+lmjAkqW/psHRA7nMo3Sjvm6BmWlP+eCYFYMeFGIu7CsODdxLC3OopQiMrAKHc
         iieA==
X-Forwarded-Encrypted: i=1; AFNElJ/BZvd5JU4VD5HXLbmYO20Xc384pD7IXjGk+6MUuBNJSCXXwIAbQfKtgrko3dlWWPom7qc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw88YIOBbDvdWXmL/BlavG0UQaaRSf1UDWD9p1pyFkwCkuU4KiV
	jQOBsUtSIgUVpnD5RQUm0TdqG2TALCusFrvzNGX5LmvI9DIWh7tPzGtT
X-Gm-Gg: AfdE7clYLtqpfDU+lcRmKxkjmyI3a88tkcsVjU6q0rzrMZ7Gvp9JToZrI1qNbEtVEp+
	QSL9sCQp7U7dAzIMnH9niZ0eKWw++P7Gp1RlVSDoo/xhB4NzqQNSFUc0MIKRjJ9yeSnA5IWfzVQ
	GvpbFq9bYkTRiV2xoGccyuTb/8sGCYeEEDu+AqrrWRt/zRIJfmnwdyPgKetlV6d9kU6SA1AXnRz
	blGwwMiBOuKG7lPF3n8GBmVHVRqQuUiZRDlv9QJq5s+Y6oRZQln0NPJp866vNFZ7iqP8g2IHNHY
	Sdi0a6VqJEkBlb5CJR9T7Xi2lAHze1cyaetIKAQDikwveJAE1+kpW5wPRTwea+shmYOeW17YVi2
	jOzf1T+GqPSkhGropDZieveiT5yOxog4Qj4fESs9E+GG0TAAMOPDTYkBBbkTq20xUcIm3eeF+H6
	BH6mK+Bi7MRLngw5enGrJZrno=
X-Received: by 2002:a05:6a00:181d:b0:82f:8e9f:bdd5 with SMTP id d2e1a72fcca58-8455075f2c1mr16724772b3a.1.1782163688727;
        Mon, 22 Jun 2026 14:28:08 -0700 (PDT)
Received: from google.com ([118.150.148.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ec335csm8459379b3a.49.2026.06.22.14.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 14:28:08 -0700 (PDT)
Date: Tue, 23 Jun 2026 05:28:01 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Pu Lehui <pulehui@huawei.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, luke.r.nels@gmail.com,
	xi.wang@gmail.com, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, jolsa@kernel.org, alex@ghiti.fr,
	jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
	bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 2/3] riscv, bpf: Fix support for BPF_MOVSX in
 RV32 JIT
Message-ID: <ajmo4VeTykr5ozBw@google.com>
References: <20260511221648.3251464-1-visitorckw@gmail.com>
 <20260511221648.3251464-3-visitorckw@gmail.com>
 <2ca2a85a-d4a9-4459-a534-6159de6e5890@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ca2a85a-d4a9-4459-a534-6159de6e5890@huawei.com>

Hi Lehui,

On Wed, Jun 17, 2026 at 03:30:03PM +0800, Pu Lehui wrote:
> 
> 
> On 2026/5/12 6:16, Kuan-Wei Chiu wrote:
> > The current rv32 bpf jit compiler incorrectly treats BPF_MOVSX as a
> > standard zero-extended move operation. The bpf instruction set allows
> > sign-extension moves by reusing the BPF_MOV opcode with the instruction
> > offset set to 8, 16, or 32.
> > 
> > Update the bpf_jit_emit_insn() function to check the offset field for
> > both ALU and ALU64 MOV operations. If the offset is non-zero, emit the
> > correct slli and srai instructions to perform the sign extension.
> > 
> > Before this patch:
> > [   19.549705] test_bpf: #82 ALU_MOVSX | BPF_B jited:1 ret 2 != 1 (0x2 != 0x1)FAIL (1 times)
> > [   19.551354] test_bpf: #83 ALU_MOVSX | BPF_H jited:1 ret 2 != 1 (0x2 != 0x1)FAIL (1 times)
> > [   19.552576] test_bpf: #84 ALU64_MOVSX | BPF_B jited:1 ret 2 != 1 (0x2 != 0x1)FAIL (1 times)
> > [   19.553542] test_bpf: #85 ALU64_MOVSX | BPF_H jited:1 ret 2 != 1 (0x2 != 0x1)FAIL (1 times)
> > [   19.554807] test_bpf: #86 ALU64_MOVSX | BPF_W jited:1 ret 2 != 1 (0x2 != 0x1)FAIL (1 times)
> > 
> > After this patch:
> > [   17.931172] test_bpf: #82 ALU_MOVSX | BPF_B jited:1 125 PASS
> > [   17.932198] test_bpf: #83 ALU_MOVSX | BPF_H jited:1 124 PASS
> > [   17.933039] test_bpf: #84 ALU64_MOVSX | BPF_B jited:1 124 PASS
> > [   17.933918] test_bpf: #85 ALU64_MOVSX | BPF_H jited:1 124 PASS
> > [   17.934751] test_bpf: #86 ALU64_MOVSX | BPF_W jited:1 122 PASS
> > 
> > Fixes: 8100928c8814 ("bpf: Support new sign-extension mov insns")
> 
> not a fix, the fixes tag should remove. And the title should `Add support
> for xxx`

Thanks for the review.

I did consider using 'Add support' instead of 'Fix' for the title. I
went with 'Fix' because when the JIT doesn't support a BPF instruction,
it's supposed to return an error code to trigger a fallback to the
interpreter. Right now, it doesn't return an error code and just
executes it anyway, producing results that violate the spec and
breaking bpf_test.

Regards,
Kuan-Wei

> 
> others lgtm,
> 
> Reviewed-by: Pu Lehui <pulehui@huawei.com>
> 
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
> >   arch/riscv/net/bpf_jit_comp32.c | 32 ++++++++++++++++++++++++++++++++
> >   1 file changed, 32 insertions(+)
> > 
> > diff --git a/arch/riscv/net/bpf_jit_comp32.c b/arch/riscv/net/bpf_jit_comp32.c
> > index 7396899ea276..f8509950fed4 100644
> > --- a/arch/riscv/net/bpf_jit_comp32.c
> > +++ b/arch/riscv/net/bpf_jit_comp32.c
> > @@ -974,6 +974,24 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
> >   	switch (code) {
> >   	case BPF_ALU64 | BPF_MOV | BPF_X:
> > +		if (insn->off != 0) {
> > +			const s8 *rd = bpf_get_reg64(dst, tmp1, ctx);
> > +			const s8 *rs = bpf_get_reg64(src, tmp2, ctx);
> > +
> > +			if (insn->off == 8) {
> > +				emit(rv_slli(lo(rd), lo(rs), 24), ctx);
> > +				emit(rv_srai(lo(rd), lo(rd), 24), ctx);
> > +			} else if (insn->off == 16) {
> > +				emit(rv_slli(lo(rd), lo(rs), 16), ctx);
> > +				emit(rv_srai(lo(rd), lo(rd), 16), ctx);
> > +			} else {
> > +				emit(rv_addi(lo(rd), lo(rs), 0), ctx);
> > +			}
> > +			emit(rv_srai(hi(rd), lo(rd), 31), ctx);
> > +			bpf_put_reg64(dst, rd, ctx);
> > +			break;
> > +		}
> > +		fallthrough;
> >   	case BPF_ALU64 | BPF_ADD | BPF_X:
> >   	case BPF_ALU64 | BPF_ADD | BPF_K:
> > @@ -1024,6 +1042,20 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
> >   			emit_zext64(dst, ctx);
> >   			break;
> >   		}
> > +		if (insn->off != 0) {
> > +			const s8 *rd = bpf_get_reg32(dst, tmp1, ctx);
> > +			const s8 *rs = bpf_get_reg32(src, tmp2, ctx);
> > +
> > +			if (insn->off == 8) {
> > +				emit(rv_slli(lo(rd), lo(rs), 24), ctx);
> > +				emit(rv_srai(lo(rd), lo(rd), 24), ctx);
> > +			} else if (insn->off == 16) {
> > +				emit(rv_slli(lo(rd), lo(rs), 16), ctx);
> > +				emit(rv_srai(lo(rd), lo(rd), 16), ctx);
> > +			}
> > +			bpf_put_reg32(dst, rd, ctx);
> > +			break;
> > +		}
> >   		fallthrough;
> >   	case BPF_ALU | BPF_ADD | BPF_X:
