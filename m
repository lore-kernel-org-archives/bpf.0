Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E80D57ED8A
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 22:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790201405; cv=none; b=jeB3aXi8WYMGh5lFRNh/oQrBNmMnWoE1eySCGuQBAwl32GOvDGe8Len5+Gda0Xm6HSERsmNx/DV18IVaEip8ML9jb2s8Xyf1M3RbPtWT8+PhUuDIZNli/UZ8WWVHIx1FJAKdWZv+oatj2HkVmvVql7QPgrbbV9E4cvLQfzf85hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790201405; c=relaxed/simple;
	bh=ltQkJYQHa23Hs0S80jVmKhTthQEdLRSQXoicmGuutMU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=PpAK5GFMd7AaY71o0SKFpgo9g3R5uFFwMPhcCUjTUTageIulTQNURdO5L3S21pEh6N2pxfs15kqcTOEIutEaT3njt4XGuD3WWzpgDx6BIrBRTsuF94oINs9au03SWiHFjCvvpsOaRX70DJk0wxHky1ZHGjTWtSsXdERu7pTOJB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWlFZig0; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWlFZig0"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccb65437so897791a91.3
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 15:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790201404; x=1790806204; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vazAApMWjs5z36i7g2ly9rbbUctt29bMM9cQXerSLE4=;
        b=XWlFZig0Keee/GY26Qpqn7hdieuKssImmJw0oJrOPL7oXkS5RhmO4LKTq7jKfILabh
         U+aL/ydbeepMs3AqHdAp8e18nMnY88N2IbzeKv41rMi1NjqId2vdhZbQg5jHxhK2aSTV
         wqhuRWXVe9sCEkBQCOL/zJujssVCEDf9bophHdl9EcoDD8IZyOoSiv+dXxpfErSji8gw
         L88wo2M3mLmi4wu3g8a7/wuSXSpFjrnG/FSsS2r54b4VewcsVU2H7LSB5diioloY5s3M
         07gE6N46vbYbJ+8uXAamjM6/bKMcHi+eSLo9/HRJvCNo6YsLTJkO4x2j0BXhoW4YeBx7
         ZuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790201404; x=1790806204;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vazAApMWjs5z36i7g2ly9rbbUctt29bMM9cQXerSLE4=;
        b=IKYxr8KwV5eZLBvKzbPOiji7YJtT9EG7F9YMIFxjLoD3pDuJgQGiTvHvmn1hkDxaey
         SBY72k0rc7SgCCGjNfQ6HBPJJmEyP2VLLyhNGUrPPkmuVOCR1EO64RBH9yuK2O/jNOez
         JuXv1EmPjrmUBId/YyNEsdiRTnkzIEodeArTaMOgo7HdQPyH6RBkFSqmnmYyxJdPEVSc
         eG+8JhFeakGSQwhCrjpchw6iyjecdjmbK7r2ftnpkaG9zjmHw1ukVqqop7X//tuxDZ3T
         v14nql3u+NSshNEdXndR4uOGqV6b0GAxkcJmj2QdRZQ+IxonUOAJhAd7OT2+IUhYy6h5
         HYzA==
X-Forwarded-Encrypted: i=1; AKwUvBwrdHsQ2ShuYXmxXx5gtjSGkgkqwHen1Jsd8A4ZI4tlrBDRZw3DDla9Y9GbC4axj8fbM+A=@vger.kernel.org
X-Gm-Message-State: AFuF++mC6cZwNDGP0ZUPPRRnnMFL2oK+RWnLJUybU95AwBhHbXGVwiKm
	j/CUo/ZSVYPELH+7QDDvXEYTUwDITKmgxJYuzsRabEwL7MRnnuf1bDt2
X-Gm-Gg: AYBFou00B+yNS2hRjv1NkMjqWm+8ByuZeGbracTDTZBTFw0Q2ZXs+RiJW/5M+Te2q99
	S5ioD37VlqIA3kIwBfuUKW5wkrjc6bdcPZkEYSP228Z5YhF3a521DQC0d7gvJ+rlMatu/1EC7Co
	q9kzqRCFUAN1I6P03cQayWsmMc1ABxcqKd70vAvICMButJ19eiQ697+B0QZHeebg7q+Q3U7w82N
	JSurqpQzYF8lrNa7WH8Fu6fahsZUFEiHwp0vvgTULvaD37ukkrddXDPZzKW675eWoANpqnugH9Q
	neFkHSqLW34K7IIJo/xTsyC4gOMzMHqq/u7ZtWWpSG+9UCRYKh6KjjJ+IDvlZe01SwvQX3BkZYA
	7/+zyEKZa89PxGY0BuwPjPiBl7uleze2ncwAtg736sPM9u4CgMI3DOar0ELfpQnurXONH7eBTqs
	jx0GK72KIrGRtrp5SzZPaGM+esMwW8j23kYaFiA0iosihZu75n8suuTR6oIIjZDAJQamX+odVPS
	zsFELHPibs3gFcxRqke1M29tOvXhcP70O6EI5BeDor8YJCcCVvZBfeynBIDcUk21EcuTQK7dxGt
	vQAQ
X-Received: by 2002:a17:90b:28c8:b0:3a0:7d90:1e29 with SMTP id 98e67ed59e1d1-3a098e2bf88mr340676a91.58.1790201403179;
        Wed, 23 Sep 2026 15:10:03 -0700 (PDT)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972b15f1sm1031781a91.2.2026.09.23.15.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 15:10:02 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 22:10:02 +0000
Message-Id: <DLN1FMQGC8YJ.J9N5XFXJYJM8@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 1/2] bpf, x86: Support fetching AND/OR/XOR
 atomics in arena
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>
In-Reply-To: <20260923165301.3463007-2-puranjay@kernel.org>
References: <20260923165301.3463007-1-puranjay@kernel.org> <20260923165301.3463007-2-puranjay@kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Sep 23, 2026 at 09:52 AM Puranjay Mohan <puranjay@kernel.org> wrote:
> +	branch_target = prog;
> +
> +	/* Load old value */
> +	fault[0] = prog;
> +	if (index_reg < 0)
> +		emit_ldx(&prog, BPF_SIZE(insn->code), BPF_REG_0, dst_reg, insn->off);
> +	else
> +		emit_ldx_index(&prog, BPF_SIZE(insn->code), BPF_REG_0, dst_reg,
> +			       index_reg, insn->off);

can we drop the load in the arena case ?
lock cmpxchg puts the current value into rax when it fails,
so the loop can start with whatever R0 has in rax.
Then cmpxchg is the only insn that can fault and there is
no need for the 2nd extable entry and num_exentries++
in bpf_int_jit_compile().
