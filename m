Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD163EC808
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266988; cv=none; b=N1sH5QywSiKf8//dgiQsz5YbrgpiQQlC86L0APpD3vain3PeSL4q8UCD6Cokhpxh2qZ3Ys6t+Ues4tBNOFw2qA0++MU5PPLUKv444um5q8mU2HsloVbbrKaiEqFr/SWuBbX834HZZztAKv1sNfyjf1gyKVRO5so+uEjDVXNBW6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266988; c=relaxed/simple;
	bh=gdBaaAuVvnM1fOrZSUdmVCPPGsh2yptCELRNndskSw0=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:MIME-Version; b=rq7IvZHnqcVD00ffldGhJCX5Q58OTQciq4C2IFADFmG0thBEaUPfrS0Tul/eA5UEN/RtplKgR6MPnh34dCrwn9QXj9G+J3DGFhgaGE3cz87i7D4d3ghOa9oUrycNROU/cGMHgQcM4hg1GO25ItaXYDHNvuZkVMVy6iw64ZRRC8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n2g1jrf9; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2g1jrf9"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d43db0c16so30883737b3.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790266986; x=1790871786; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MNhDhUdLhnZ0EhgnCWFh0cnaf4Iy1+Bj8wQSmMfOu5M=;
        b=n2g1jrf9WWwJaPlFqmwbBmDeodwEat43JNtHxPL3iyL1/5aGneXXC6Hb6xZ/D2OFSu
         oX0d4oCkCDH5foasZ1Rau29JioSeygI4s5WjEfOB4G+Qf+2iXpnY0OF7GndLxgXg1k8g
         4Td0+y7xwDgRW5+Bo5Sdhl+1uDTOQbSe5CCIy2qOqauTQfi3wbCigqgNvVOHHNtuIFeF
         AfEjLuNFrmmi+iwdOfclE5NutCUQbgg0M3f3qXUKs4yfue0xTsvN8sorF2wXXL0xgPzc
         j9tjA7kdK/jn7awcwNGOUnDD3vac2aUqfEzWqzVLd/A5+0IZtz9uLcPuJA79KuOxAhRU
         B1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790266986; x=1790871786;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MNhDhUdLhnZ0EhgnCWFh0cnaf4Iy1+Bj8wQSmMfOu5M=;
        b=BgTzqk/qIrFtvhKRb5wjsLFH0Y6LKdyw9/BTVSZGtT7BieFME5Z8g0E3e60RGxI+kj
         DuIafAWtcPdB4CbphvZJulnWKFMkTMwpfMEXYymTc+CTZYFSrfm7cUnGcNp6TwL38nbN
         0vxEr9NcdQukzXsi7fOPfrEjx/Y0q00oeJKjaEE11AVWYkFlBdLnOh0QYsSUsNVmXaSV
         kaQgdHBQ+3KGw+5cVTb2baY1DPOwicnNyjw094vvBGj/YSyvgjsVLl0FyQpV3yZsVOOK
         OkPqCcqq5R3E01xbAnlvjUFWxizsJm2sg9ErbOigC+l5iIKL5z2vh77Ikk4okEt68gxb
         vQ3Q==
X-Forwarded-Encrypted: i=1; AKwUvBy2eoylEZvBU/zSg8bE2pyZ4imZ7vYR7sHptVKOhvyJq29XoxoXb0WgisZZAY2h1RaSm3c=@vger.kernel.org
X-Gm-Message-State: AFuF++nCLU9++4564HkGSs4pAbg5IEzuGIEf0tsZqbcFI8bKPOweN3SP
	G2B4iba3vKNU3OXi1F2WeeCq01MfdTG5T4AJHac4YUPsu869/r/Xh2wG
X-Gm-Gg: AYBFou3IUuTOYVqb06enQGnb9II6YJWDlyQ7MpSTKIgrRrjT7uUxt7z6wNcMCbl1uWw
	xDqKJb9E9riiVn0Y0I1OqbNjmUAJOM5aaBhQNUXNEfDY5sFqFpNDSfis9OqwmjScROZ0DpfB9lY
	pT3gFfI6qd/wIU5/Hs+rRvg0QTZsZQ7oqys/9T2QciKB6HQDE45D5C9D77KYJ9EIfWMShxiE9Ec
	YBNiJ8DiqpbyB3tiX1rlGpUc71VQMnkSAUuDccR5mhqSMNPTpd2kF0Ni+aJ2xUbPOYFxfNGg++e
	OGfBCw+RORHIlj1k681JZnpXRHQryMLwLM0Z/CD+GAcbQc1xoX+/g2Z1CK0pMbjk48SKaLIHgR2
	yBRnC08f+nL9ez4qOUbL6D3yJO6aHws2gwEq9LbX0ypRaFujoaPIUU8CG0qiRyTjd78RgkQ2llG
	wZxcbPZqvmJ4YmLqSFjbZLk2ZXYkJVj9WSwlLuHZjq7Kn9JEtpXyjOg8p+C8GhqtG2RLfdVqjaY
	JfTfgnEmiihN3/os4HIxfO1M8LBReaH2R5JHpDYEQPwsgIDv3Eey7e13ijLrGv/EHgV/HpqKlIj
	PmHKle6557FgwPE=
X-Received: by 2002:a05:690c:4d07:b0:873:5c6b:a307 with SMTP id 00721157ae682-8a64af46da4mr14598477b3.53.1790266985556;
        Thu, 24 Sep 2026 09:23:05 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a6525dc675sm10606637b3.34.2026.09.24.09.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 09:23:05 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 16:23:02 +0000
Message-Id: <DLNOOHZI19HP.21MNO7HWX5P5T@gmail.com>
Subject: Re: [PATCH] bpf, x86: use 32-bit zero idiom for shorter encoding
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "George Hu" <integral@archlinux.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Thomas Gleixner" <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
 <x86@kernel.org>, <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20260924160154.12807-1-integral@archlinux.org>
References: <20260924160154.12807-1-integral@archlinux.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Sep 25, 2026 at 12:01 AM George Hu <integral@archlinux.org> wrote:
> -			EMIT3(0x48, 0x31, 0xC0); /* xor rax, rax */
> +			EMIT2(0x31, 0xC0);
>  		else
>  			/* Keep the same instruction layout. */
>  			emit_nops(&prog, 3);     /* nop3 */

No. This breaks tail calls.

xor is 3 bytes to match nop3 in the else branch.
Every tail call jumps to prog->bpf_func + X86_TAIL_CALL_OFFSET of
the target prog, and that is a constant 12 + ENDBR_INSN_SIZE.
With 2 byte xor a tail call into a prog that does tail calls itself
lands one byte into the insn that follows 'mov rbp, rsp'.
Without IBT it is 'sub rsp, imm32' 48 81 EC. Without the first byte
it becomes 'sub esp, imm32' and clears the upper 32 bits of rsp.
With IBT it's the middle of endbr64.

It was xor eax, eax, nop2 and offset 11 before
commit 116e04ba1459 ("bpf, x64: Fix tailcall hierarchy").

pw-bot: cr
