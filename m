Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0E33C3F76
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 08:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400276; cv=pass; b=opK+wm1je/q8Zdn9gXua9FE3K5KMVFV8NudewUsvmLkRe/xHFCRSKpdm3W/EWjnYU8jwPOB+jnGPa3jHSHwcSwjLBZj70aoV9zSo0torwLlKrq43rBFymVlDXp1862DmsDMHKbgnnuSVJ2KV99Ubza3cM5WMNVHgZIfOPGHjix4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400276; c=relaxed/simple;
	bh=UyGpFZHBuLi7sb7D2H3adTyPghwkWlzs4kttoVoTpWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUYZlLp+cDAvg02u7p9xINIrq2s43/7Uzb2Wq56ePjTUMJa7a5fzCGnHjudPucyJLO6RlWv/F0KVcvF7348S7nnW4MZ59aa+QBZWBx0VvdQtFcSp9inU+gfdGrVBdZGgKzxasvX3MfBDudn/AMkNBeOxGf6KDVb1U2qlPxI74CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQgWoJ0B; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQgWoJ0B"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69f734cd461so252820a12.0
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 01:31:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785400266; cv=none;
        d=google.com; s=arc-20260327;
        b=m/nCQVTBLaLzM0uOAIFE5eQFykZ7M+Uen6TbGLM13kTxKDSabSVcGQw/8jdkYFGkFQ
         IvclWPxEl6mkMeQU6SuqRIKMMlgetv1AqDNKwUbw+nMQOgw0Ny6nC7XYIPdiSHMy4GI1
         gwSbON1gCYMAvxoRQyviJ7UqkwN7EhwMUXxOegq2ik7cIhKCnSzHDKFypfBZmnmPwgFg
         BDuw+JitLeGxlIaMziMbECE0W4vIacNjVs8xxG0zawhq8IXHpoPztXEkHqQo3F3GYVru
         ZCvzcpLCbz+se/nfMEWwIH5mEy6d3rBmLBcNgijiYUtduJg0euXERC10jA88jtoyC0vm
         CbpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UyGpFZHBuLi7sb7D2H3adTyPghwkWlzs4kttoVoTpWA=;
        fh=aSPAvcB54LVMBTwimS/ysizhe/jGjmg19xHIutrTTMM=;
        b=nSsj7M0Uct/meyMNEXrApd56cfZmpW5xeP0Ba8v9bmXNYMS2QLRzrZDs3Iftw0GyOC
         gCBEQcwfk5CyXH9+mmmawYDo9qcDttDILmR8cQQ/k0CDCSSx7zAqgPLc1+61Y0A3xS88
         XPtxAH7TZxrlBwHxZf7gx+cYag7Q0gyf4eZxp/QtFiehuSuCx/OxwDwKRtO1g7/hthBx
         cm5l7PuJe248OkkovC0JAtDArBUOBCkeeqH2Wwhi1hZYOt162VzosKLTQbuvScw7gNPj
         EyGUV1KyqTmUnELBIBkjN3Jrn75vlw5JSmr81TY0V9nK8TzgCHrFKGTOU/9s8zIKfkLj
         HEFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785400266; x=1786005066; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UyGpFZHBuLi7sb7D2H3adTyPghwkWlzs4kttoVoTpWA=;
        b=FQgWoJ0Ban7tkpBIKsbVb1GhdVRoDo24YlMgFlki9j0l/FrFMU0x90zTbpVnvDiDYz
         a48u9VKaiivILVKwNQzBUdLJU2aMhJaaK+rk45p1OC/D/CCTBIlNUVkC9lFaIdWIwWkn
         G9VFtal4QUBUje+zolTUwBtxivKmgWV+9ImN7csnM6AYp68ZOD16BaFlw9A0AD0MablN
         mjCSr797LW5khJOUgofZt1MFtI0J34cO//1I2B7VKKVpjcOqIDijSfYVyMWn2SUWQ7HW
         by7YM+2W2FgkJHHd6414dS4i2TWsVYGD+NcFFlu6Oy+3B77GHCnKLWoGbarBEMHkhm38
         4/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785400266; x=1786005066;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UyGpFZHBuLi7sb7D2H3adTyPghwkWlzs4kttoVoTpWA=;
        b=l0DxrSGCAOEbqo/KWsPwUjJ3gsHEqoQYCUJU9Z+gBLFibSNXGt8m5sV5zPWfAExVUG
         jpoWnJca+cFC4XJa+VgUnrC3zoOLAhv5HwpA/sVLqBwI1csxoRKZns73KgXDDUj4s/pQ
         DLYxkrssBL8fGqsJJNc4vlrxAtRiYV2OYMkjWO+rHqzfw+5g4xEVtn+CaOIMLhVTkBMF
         YukCAqOrCmtGCfMcjy8RmI29JOtJwN/Ri+I1oGKmciNqAbzMmtxuIE+I1bzovxQFq4D8
         emGZj3dLRKID/LWreTzvqEuyykQqH8iAKp2RCMrhjtVokPhdHRuOJXxNA7OAxHNwZ56k
         GRVA==
X-Forwarded-Encrypted: i=1; AHgh+RorvWUHZOXkL8m0xzqr/tbKDzm6y7TTEkGIcn5/Hup03/toExZwkoeKWcZem+5qFnJwgWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOSQD9YLK630VFFb39h4KDOKuPPxQMJYJDYcUFrRaIpVSnu+QH
	8uNo1fUtaCfDmbhWbtdXKuIDK3XNWxLBLhdRRAnuunyLhOh7g1MNRIXUfAYJLDWDX4kE7v/qIeY
	kkM4HJ66ZQrfBMiOEFxscs7lXXUtl+JM=
X-Gm-Gg: AR+sD11yXhjErjEipF1Ru7w/ICpK7B0auBgl2wD4grlRvZnlCfPqviPYMrFmTmEAxD6
	H71UdRGLhEgH/3Llqiz5KloqWFnV8Ksi4k3zVeiSbXDLbly2drS8ZxXsMixAzF/aKDOvWOss2YX
	KQQmTLEsv3UEnujhvifySouKNGpDT4cpfQMY7QqzLhPyhYZZHCknCbePIDbNdcWF4w6bSwbciwn
	YY2OkYvO7B23CQ0Zs7eE8L34V3QyOYy7D2Qrj8AstcWrP5jLNXPDtodYM4277moDR93Jpe921WQ
	glwj1LUnpjXQhe+XohJ1jxo56VzPkAsVaXuTuiCtQgFNlxnSMqlCvmHxaN94IXRcMDXnIc4leA=
	=
X-Received: by 2002:a05:6402:2792:b0:6a0:eb:ae4b with SMTP id
 4fb4d7f45d1cf-6a07b53987dmr789961a12.0.1785400265443; Thu, 30 Jul 2026
 01:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729163141.213611-1-nicoyip.dev@gmail.com> <DKBP6A3V5I02.3GNQ1SEZST1F0@etsalapatis.com>
In-Reply-To: <DKBP6A3V5I02.3GNQ1SEZST1F0@etsalapatis.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Thu, 30 Jul 2026 16:30:53 +0800
X-Gm-Features: AUfX_mzP2_dgrdwIJfpJtiwvx7D1iQ4FEUItWv_JG1MEc41mX0jP5E3An5U4l64
Message-ID: <CAAo+4rWZAdy=6HAHiysb86E5eFmXsWNZACtf_eBzFNqg=9EJhw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix netns reference imbalance in conntrack kfuncs
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 2:38=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
> Sashiko is right on this regarding all other fields of opts having the
> same issue. While they can't lead to a crash, let's still snapshot them
> at the beginning of the function so they don't change from under us.
> This is still far from ideal - we may read an inconsistent snapshot of
> the struct - but it's backed by BPF program-controlled memory so AFAICT
> this is the best we can do.
>
> pw-bot: cr

No problem, v2 was just sent.
