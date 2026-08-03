Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F8D2B9A4
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 05:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785736650; cv=pass; b=DI0wsxuRiIyIz1bOYChq4wUvcTtZc7qawJCMViwyq4ZEn4FrHrZ0VfYKRshVAaMl6/GoiokLG7oh7dUh68wnWaBOJC5CkKVi7zSckX6i32U2rvnjIKlrVP8+w5YK/pgskSqejhJS78ultuHxi9569pwpeRqIXWK1sZcsEtdKiB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785736650; c=relaxed/simple;
	bh=rvSvmnmoswdqdFu2nIrDG8h0Xgi1LyhEtPzyNKn5bxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YMKJGCu+X+YKcIqiFwFFbDwTSvjmi7uUhUi5x0qhXK9OkTDDMdt1mNg9a6vS4zmiSx/OHj7r7AAoge++gsfHV2oxF7k0C4SYGXoTLFLGBR3MOsjqpaObBNvRCpi8VLCsLDT071aMEVlXKsEqaMvLY0WrB+AVgm6Va47zwnQNnsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJ2894+u; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJ2894+u"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39c7ce122c7so26066861fa.2
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 22:57:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785736647; cv=none;
        d=google.com; s=arc-20260327;
        b=gEMN4k5Wa4/42WgJ60CRJ5+rfcwH+0cDMr7R2wO8FcgTWK6rWOItqIDiVMbZ/7I7Pi
         dffBYBF4Y5PIM6pigt+pjX76R6Y8p6eTYbEMXonSe2IHObU/VOz2Gw7fMTu/h/xB1Zri
         T+lhsr4nLbaGtGRrlX0PLCozKYCZ/UktU8UAPyVrNyCJPOIWmbVgmUzjCtEdbsbG8S7z
         2p+aYf3m8CpWIjqKyKHSt6uTYPUydxe787Xzi38BltTPqdYdpFFjkf7wAxJCgSJ8ZLF4
         xt13xJwmo2h2uRvW7b+w0RviQU+YmsFPixmrTRixG6Ax6ggU98QmNqhrcqelk++i4cQf
         63fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rvSvmnmoswdqdFu2nIrDG8h0Xgi1LyhEtPzyNKn5bxA=;
        fh=8GAb1Mb+qxtIOVEZVrf3J2AoChRw6EceRUAOI6TxVic=;
        b=Nat2Zsvvb97eb97+TrbYm0APsDvsLun4YZqI2t1UrNaCSncHBjk5Gd6xvFzejFgHiT
         LOz5IDkQVwMfDiPxMm1sbIyDZmbcW9dkDXb+8BLzwQG3doRyCnwFRxz9jPvo/7Ls9FUR
         lN99VWi+Dpj+Flk56jIL0djWaTkKqpOEGArF6rrxpPgcuUtDNk01QtYNBccX4ihfElgY
         oqw+aIHloGXtdQyB3j7vAU9D6yJ/8it9UUhmmhQDm02sJRfk2EpJx8B9wl6U+w2Wqmh8
         2o2AOeI+/J6mKwmROniuQAteLjxHzM0VUz0EhMS2Gi/2mEPQ0hFDBUp9cOnWp64dl4kw
         WHtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785736647; x=1786341447; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rvSvmnmoswdqdFu2nIrDG8h0Xgi1LyhEtPzyNKn5bxA=;
        b=nJ2894+uz/OxRuqNOt5Fbo6Tvs0N3zswnapjf2WGoO6+g+wgvmW1Xg3Eov1+uufmOk
         jw1VAylmd7Wmx2ZFdhe3VfM/v94HLOsq6WoX+y7A8Bbhh03R8ybFTy8GB6FXSb6T5fRG
         FFVGXX+h7lFxq87AMUZxj1aBiwO/U7WEppgIShXCR7FGXiNkgD7HAKHfaLdh3XJBgm/X
         rZ4TkrB1NeDtc/p5w8bQzK+x261Z62W/5mryKD6aMEJi8QYf8PNAnaG4Ghy2lnBXwn3j
         Bo9KsW6cU+BOUc0nXIAtNvPHplo35kuujReTGC3/lnR3jpMd8TBXTMOusCPdVIKUkt0G
         1lhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785736647; x=1786341447;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rvSvmnmoswdqdFu2nIrDG8h0Xgi1LyhEtPzyNKn5bxA=;
        b=VgNAM/82/b7DowJTn4ceqlyF62BLFrkC6zXUcw8Bc6qAbbzTJg1zIR3pBsz3hC9gqn
         Knu95X2VYK3afPZwy9qYDeiVzxT01dPCzWptCHL5cLtrGyprydEVRLe0ivSWG/xGjgPK
         keFwxurEYOk/aDrl9jkUOVB1DNYLFPBlw7uQ1fGamHVHR/wwsyl+4bpdVnvPZ+r+fQyQ
         J6FdZ6wEexQ7NeuYLZJ9fqle2pLDoRyiDdjH8Bye/S/BZ0AMiuZwxHtoFfqceDBE4/g0
         9+5ek1lJdYWXXqc4+IPDXXI4UTpXCdVkAPUnqolZwijtfMI5BKi23BcbVrGTTMRstUcF
         33hA==
X-Gm-Message-State: AOJu0YxkkZkdZUThLv7/avWLflyBcnijwIY17ZDf/1uqC+hAETp8DfH3
	dq4a/F9NFw2uHCGGRYF7fyt8PYbvHfVBYDawlATGLZ4iLh/VIpPIopYjIQ8fnN3N0n1AMDUkZEX
	B1VlqV262YXeIqvxOF07WLcxY+yfcJvM=
X-Gm-Gg: AR+sD13MMmIENrfNaGIpqMPV0yL82YfRYmnydZZopyzBrX3c4C0tHICjsTqEMBcoXeC
	h/LhaFoukf8tb9PoABQBRCAOlYQWz5nnZhktBC/37XOdne/ey3a0hsmoj79ZTK6t6Tmzi4AZ+JD
	NMwMgeLjbvdrIjcDoSQx5e9Qx76SXCdmtitgFCxYxXpwaleC1iofvwAAnRkKXDO/5qGn3uldZh8
	EQOWsjKOpCZBc01DMYwxnbyfcG7vGHIkojI4vTUPFfMBEyz9umat83s3ckTrlDWr6E9vSFRj8N2
	CCH5WV8jCZWyo6ZSLsAFPLxaKL5B7sVF84PiGZCikun/cAc=
X-Received: by 2002:a2e:be1b:0:b0:39b:24bb:c62c with SMTP id
 38308e7fff4ca-39f861489a9mr12710361fa.14.1785736647020; Sun, 02 Aug 2026
 22:57:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726235030.1152542-1-dingning04@gmail.com>
 <20260726235030.1152542-3-dingning04@gmail.com> <DKEUKIOKSY28.2XVQVGCKLI40C@gmail.com>
In-Reply-To: <DKEUKIOKSY28.2XVQVGCKLI40C@gmail.com>
From: Ning Ding <dingning04@gmail.com>
Date: Sun, 2 Aug 2026 22:57:15 -0700
X-Gm-Features: AUfX_myJMvSx4DlvgrHBQHDD9HIdk4fyeSWw5DFFbwPNfEdLOd9UQ3A63W6Dpyo
Message-ID: <CAJP4iuuYfqFChH1P2=3Q6WxHbMTNnAkCagR2k+Lr4W155gCj3A@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] bpf: Reject untrusted pointers in refcount_acquire
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, martin.lau@linux.dev, 
	davem@davemloft.net, greg@kroah.com
Content-Type: text/plain; charset="UTF-8"

> Same comment as the new set; split kernel commits and selftest commits into
> separate ones. As for the fix, I think it would make more sense if
> type_is_ptr_alloc_obj() was fixed to PTR_UNTRUSTED by definition, instead of
> having to add extra checks on top.

I tried this change on bpf-next 60781269e26c. It fixes the
refcount_acquire case; the focused tests pass 43/43, and the
list/rbtree tests pass 176/176.

But here is one concern: type_is_ptr_alloc_obj() is also used by
type_is_non_owning_ref() and reg_btf_record(). In particular,
type_is_non_owning_ref() is defined in terms of it. After the final
RCU unlock, a graph-object pointer has MEM_ALLOC | NON_OWN_REF |
PTR_UNTRUSTED. Excluding PTR_UNTRUSTED from the shared helper makes
type_is_non_owning_ref() return false.

This also seems inconsistent with d8939cb0a03c, which allowed extra
flags, including PTR_UNTRUSTED, for metadata lookup.
