Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793487058;
	b=A2w4HoSdled0009Fdzug1cqGB+emvm0HYjtlQpHW75bIJKI8S5lhm26m1XHpk3DUSSVg
	 cZAdcreTA6wR/KG0wVNzdE3Lp7i/Jzr6/26t3lE1j1gYbToelO25aT4RB8Js95MyVA29/
	 reGxnJgejXe2tgKjMi7tQYIB3/J4/0fYYL05/pvW0YwBml5i+l0b4DGo8BOxr+YWVVvhU
	 Jlh9I36dDU5quYecNw35eNupEqnJb9EWxX0FK467fm68FJRI5FU7ezVxqxj2HuUP0NKWS
	 SpwaS2nIUAhnby+wNSMZKZPoxE4dhovwzVWByghBBkcVLcY19N1cOpOVEyh3Irjf9UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793487058;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=uddHcZbA5Vt6jVr1+E/asUAMMwwahwgCQqJdf7j5c6w=;
	b=z+3eP4QzOtnNhx4iCscFU3IBW2IenlY7iZB0KYXsbJktqpWuNAybcb3O2uEDkbRk1QKr
	 iQlRmfNboCBl1PP6DhV4Qmb+v5ZSFRg0REbWHYpLYwNqiE2uZDWzhwwam6tomr1DxCoM7
	 PeFsqHcLQI+nXsKHq1WA55IbO4d+cexF6imBEi+6+nFzQ/txvQ+p0IR1b/n0ogIoQs/47
	 Oag6rj0N5PxACry1/JxG+pSzXuDWCMvMLjuhK/8u7a93QBN0CBy9SdQYLoE2TT5KZ0Jya
	 VkAXc2bKSydNUl2+M70z9GtA4pBj28PIF8NLojg2obW1SlaHBYn0asqWyT6aJ7H4GCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pDIfYkLj;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD3A606A31A
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 22:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACD3A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pDIfYkLj
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3acb512a7a0so1174422a91.1
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 15:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793487057; x=1794091857; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uddHcZbA5Vt6jVr1+E/asUAMMwwahwgCQqJdf7j5c6w=;
        b=pDIfYkLj0HttQQYcCxn4XvjSsnlgrJ2YqsHFBB0vtUdjxH0elaJijWiYifHkYCGLmJ
         a8ZJ/vp5L5WsdTeE7vwZBoS1EQ0v61kOMg82uOvq94dckZ0tEn39IXuCn/BGQNE3Er6m
         Rax4hmGjT51cw27lw4rblKCmv00X32kbRoevmK2a9zuQ2nlsb4/ltkmxvMMSvO8C+tqc
         aipctoU199khSMNBc6SHlaaM0QS0wTAFg7MbviRcQi69wyttV222qsyAmb1ze6YXC5/1
         PYyHSL4AlttmIo40/0mUinK89J2XPOlKRpTfpAlMhfU0Ii7vnnghUwNMNDxIUERhOwg3
         s0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793487057; x=1794091857;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uddHcZbA5Vt6jVr1+E/asUAMMwwahwgCQqJdf7j5c6w=;
        b=Ey2BQ30WGD43w3C6bAoBCJIQiiiZuaX21obGGEZOusdEODM2v1XZOfKcy7XsSVICKP
         PIbte8Az3Q7PPsUsJEWZ2ud905T0Brf1+ilXnKrhDUk9phOupUIX9hDUEqMCXcckMCf2
         jhj+/hHzfJkp7W2g2QaoiaJx7qf3RyexffWwr1JUBbBJE8G/O5D3zhNI2r9tBdjW1Pwa
         i2r9k5qROWsY+EhKbDu7jFdRU6Hvx8oXhnDMSHpoC2Fxq+MliGLoj1/+knPqT8pgrOGZ
         tLjrHx+KRolr3h1nhU0yxdWod2QsuGpYhqkHvj7qzxZEBAKItcr2VNBBY/VAd7ppUU4p
         wehA==
X-Forwarded-Encrypted: i=1; AKwUvBzO6O8CxbGKKA38am0PZVAQJXpwYV3tznbkAak9WNTx/GUU2lLDCuGgbMOriAj6G+QiCqI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKdgb4Q5NiF79SMEr6vOuHR97ABceOvuB/lIr1H516IhJJj82Ux
	cyLzK3T3VwoIo0Xkd4D2bqhvzWwyXuIkK2aWoDrY/XId+LoUo1Fap67/
X-Gm-Gg: AYBFou2mMHb1QWttHvbeDth3jXRJamNA5DTSdYJNj3Q2ICHcY9kRy01exDaib1s2Orm
	KFC87INiClyuSIhFeGWfAsXLC1BiTJd82plAMKBDm9HsiXb4k23Nq7hVG3Zf+71Nfq6359OdTQQ
	AoEcHdSEO+W7LBHW6TLcwdHryxzJDRsUVj6+Koh1+aCl7CYhaakGD9B4TL6f3Sm+uB/xL+L47iW
	CtG05UxHhaV91f9GdMA3pLBwYCFcnholcAExyBejwiEPAHocxlUCuFv4LMYwRCQpDEtOIEmNwbi
	8pNDAuCBeRd6vg1UhvkFeS+nTMn3LhKp5nsfNSgIsCOGAIvasd0gdvjZDSJNtcZUut3DU+jU+eZ
	+J7ngObcGIBVxOtquGygCEYlfR9CIOu3uxAkAwUi23NyviR+MQEpF3tUIaAsBXteNKI8mzLhu0f
	2mQt8gYQj7FSCROwsCJKqXeasOGgnKSXtZXdzoP6XTSopot3iVlCHV4zHVsLT12+CaU+FQd2+gZ
	IiYZ3B3sPkrkQ41LmRfG9SHUyq8arFzkQQ0vhAoyqA3oobf+IvPo0AdURGfE+PRYQEOmkWOhJQs
	o8/fZ7fpGCI5ZX2BTiA8sngEU3E7wQPOLSzGMJsdcufJegQLhfw6HzupL7aMalLyah/ZBoscA3+
	JLiTDoFbCWgp/pTGGDOIQH5S6qplxstUEDQ==
X-Received: by 2002:a17:90b:5745:b0:3ac:8741:e2e4 with SMTP id 98e67ed59e1d1-3ae897bafebmr4856933a91.52.1793487056969;
        Sat, 31 Oct 2026 15:50:56 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85cb91e5sm4575724a91.0.2026.10.31.15.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 15:50:56 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Oct 2026 22:50:56 +0000
Message-Id: <DMJE3NBR6X6U.3GVU51X8XF6JM@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@kernel.org>, <yonghong.song@linux.dev>,
 <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf v2 7/9] bpf: One may_goto time slice per prog
 invocation
In-Reply-To: <73b8a2912eb3c15e4721bb685bf2231afec7537b620367e257ee1a0d41058a19@mail.kernel.org>
References: <20261031215543.682284-8-alexei.starovoitov@gmail.com> <73b8a2912eb3c15e4721bb685bf2231afec7537b620367e257ee1a0d41058a19@mail.kernel.org>
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

On Sat, Oct 31, 2026 at 03:37 PM bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org> wrote:
>> +			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_0, timestamp_off, 0);
>> +			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_0, owner_off, 0);
>
> Can a nested invocation of the same prog extend the time slice of the
> invocation it interrupted without bound?

It's already explained in the log and in the cover letter.

> Should an async callback be protected from main-prog invocations too?  For
> example, the main prog prologue could leave count and timestamp alone while
> owner is set, or the async callers could mark the prog as active so that a
> nested invocation of it is skipped.

Same limitation. Both ideas cost more than they fix.
