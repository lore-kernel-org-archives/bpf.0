Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA891C84DC
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 01:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786669284; cv=pass; b=p6wdiD9utHuAhpm7ydvR0A9pB+n/SGRESejoqhtT/NbRQIwTh2iFW6QCl0qose9tv9pdFsRzB2pm5+j1eWqPc8NY8NHxlTn3NbrCV+C1D3+Pot4SkOeWpF11MZlCqQkKrkSLFlcNTcWXjgfw93vkrkDt3WsELJRbIuE+jwQ7wBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786669284; c=relaxed/simple;
	bh=L87+y9CoVqRC0hpuMGywi6kNUXCz3SnYGNTWdYb4VAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O4YUvRFS7xM5nwc7dUzSAZLSPAWEe1SR+1GKjGsLHlapyUXMnYugELsbPx75KQT2/rIgegsrBBgKW3N+gssaIetoAzKOxPkTxZFx0koUn4wDIHY813IsyQTBjbfdPkhbq2AJdp/PFSM6iUm1HK02V8pj0W4OTx/9qZsMELYzvW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJsK4v0W; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJsK4v0W"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b29599b81cso532204e87.1
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 18:01:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786669281; cv=none;
        d=google.com; s=arc-20260327;
        b=gDXmbrj7WMZH2UVoM5eBF+CPNlEQgouS5euVgLhuTQyHUd5l1+2EOnnEBeLsRl+tUC
         DkXwfZ6NhAadnEIdKyhCd23utU2Ienj8udPJ4MjZcaPA2IQ2G+7heOYbMa8BD7XDVudv
         l4fXDocrMKjzTzrMqrtvmW7rna/BklvcIbjkqIh9p9h8IsDs4mE41qWe8sPv1SZF78sx
         XNLb6U16RJeU72OswMJXXvaYMV1rtGQP1SyYUGFPn0/82LhxtNn1NzKtyaJOziYmEr5q
         30AEvMQxNnCQeW9eiBu38nxJrl5VNZ+OVgzhxO0EFua5U/I6xcKVOAIgnA7xtECZZjlb
         uuUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ewa2mMlihLLuJ1RCLwygIaMUaUZ/BWCoiTIjU/NI918=;
        fh=eSo/0f2A816lqDFAwzItmSDpJnsHR7ihJW8vEUvj/48=;
        b=l443tJ+m8EzAhEwWyScqm2478FYLohRZ6eXVQrkqetkHjLNgWB8MTWaEhjrPewFabR
         otbvFNg0d3+oxmkIfNSZhnCR3DKNnx7fT2AyWVViqxB6iiwT50UfM5hTh4xqTf0pxw/3
         HEKXUO1p84D0fYgt6U+EVnX3WEOvs/ps42AV63f46Tm0x/g9NFbhsP6gbZ/AOxuo6g5m
         3iQsuB2ByluaEZqIP1ZDQVmFpBBTSCGl2ZibAi1HL3YADBke88lQzZDwPl3wvwpM5S1v
         pkB7TFf1gmX01mPkyRx9E6Wvw6hZXs+1gD6N5wLtCYWme8RRpfr6ssKgHogv2bKD8wxD
         +2Qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786669281; x=1787274081; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ewa2mMlihLLuJ1RCLwygIaMUaUZ/BWCoiTIjU/NI918=;
        b=VJsK4v0W/BBVWVNbMlBsJh9107qnx/xgCsKiMnf56AET9wAWZsJs/GxcF/cBq8ge8T
         jk+0Bmb2T4Cnz6Km8mmY3LMFibHwNGPqjEk/DZmo10vOXzvIqCTuOruVS16eNSVeaA/c
         S52t4+MGt2/1MMtmupOeN35P+UgL+Ugk4V4Rcz2PefPrUJDRUVHYXwkZ5Vsem484eDuO
         2S2klHuLI0/Z/XlFYqpA8hmj22UoOZFTKUdwG0wUmSwCq//DhQNInRajQR4zeC+5MarQ
         qU1zzXPUdV77l8vLLztzK3bqYmApUBNG5qnUa3MehQul+OyvgGylSl2QRhbzDP+zAOa+
         RcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786669281; x=1787274081;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ewa2mMlihLLuJ1RCLwygIaMUaUZ/BWCoiTIjU/NI918=;
        b=KLSuosWMKCF3a9VI3W89aRXds9njXxbmqv7vAWKSdeR8CRHKSjw2A44rgXSrntTcfw
         zKnT9NV7ck6CBoXYssWn+VVo/NTcmaPTbNjAfiwtwL71hIdx5cRGa0AmMJCle29G4yjc
         qgRCW7MywuCZ0j2U/y16fk16l2aKOOUeJC4xzRkjnMEGsB2tTDINaw4u1Dyz7fzKz2LO
         kiTsCfzkhlIRn6ifN/CPubmF2nW/XrZLXntRJybRW5YVqDlSTZxcKoPljLP6vzpTYqM8
         Mm2pmhh/KEuXfNu6iWMGcltymMX4uoc4nj3cEY3csjlZx4re4/5CkNcBG7ZBTl8lp2SF
         1wXw==
X-Gm-Message-State: AOJu0YwZBIKT0fJxLPUGtQt+3SYIBR80HhItCSqRRjZWG9Rba300p2VV
	JTsE4uCIjofBdjiTEJ6mGBoy1IBrVvoaoPKbcOyxHFV/CnXe9BMRyGhurLGwC/l55pmj8b9xxZX
	Nv/fOufmPGXcRd5lTnitthVx16i9Uass=
X-Gm-Gg: AR+sD12JmmH7pSK2ino33zaNjJj0CdDpDU63fvzaexplUIffXqor4jVGA/Koye5WNcY
	IpR2o1FR64VMouPSPpyab5W2ZqQhbXu8Hr2bqKt2HGTIFoGGLlztHPBQ5EzEwe0IRRyfzXgIWqs
	Ovg0C8KrVrNj+La8NVBFbe0vCPAATw4wp+xL+ck/6EzMSOnohC1xFX2oQfJuGHRDNordMoJoeO7
	/Jmd/jvQXIqRa1+o0MRNtYS0K3WPsyt3F9mVNWiuAuQ4dlpi+53CaqG2J0ZGABVKnRKu1hQ61Uz
	TA3fDJEKLK9yCVoZGdZAgBqEdkKEJjVzKFarbOvpbPjoKQ==
X-Received: by 2002:a05:6512:138c:b0:5ae:a0b4:5013 with SMTP id
 2adb3069b0e04-5b4590c5726mr258854e87.0.1786669280449; Thu, 13 Aug 2026
 18:01:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813211533.290256-4-dingning04@gmail.com> <678eb16ccbeeb3d38fba26d20f6a7f3f2bb99f7bc9d7f5bc6bf2fb1d5b9ee87f@mail.kernel.org>
In-Reply-To: <678eb16ccbeeb3d38fba26d20f6a7f3f2bb99f7bc9d7f5bc6bf2fb1d5b9ee87f@mail.kernel.org>
From: Ning Ding <dingning04@gmail.com>
Date: Thu, 13 Aug 2026 18:01:09 -0700
X-Gm-Features: AUfX_mylj9AIRpVCjzozB4ZFkYgl9UXAM2f1QG1yjoejxk5y_JA1rOiM7gM55ik
Message-ID: <CAJP4iuvscW9X=7MjTkRF4_x_o5cDAfNQB3te-JhpgU4BSwZTbg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/4] bpf: Reject untrusted allocated-object pointers
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, memxor@gmail.com, greg@kroah.com, 
	sashiko-bot@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, eddyz87@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	davemarchevsky@fb.com, linux-kernel@vger.kernel.org, martin.lau@kernel.org, 
	clm@meta.com
Content-Type: text/plain; charset="UTF-8"

> The immediately following invalidate_non_owning_refs() only acts on
> registers where type_is_non_owning_ref() returns true. But after this
> patch, type_is_non_owning_ref() returns false for registers with
> PTR_UNTRUSTED.

Makes sense, I think the thing is, callers do not have a consistent
contract of `type_is_non_owning_ref()` (same for
`type_is_ptr_alloc_obj()`). Some of them only care about whether a
register has the NON_OWN_REF flag or not, but some callers assume it
also should not contain the PTR_UNTRUSTED flag. So if I make some
callers happy, then other callers probably will complain because I
break their assumption.

Then I think the previous approach, which preserves the old semantics:
`type_is_ptr_alloc_obj()` only checks the flags it declared in its
name and doesn't care about whether other flags are here or not will
work better. If some caller explicitly need to ensure the register
does not have PTR_UNTRUSTED, they should check it by themselves.

> The commit message states untrusted pointers "are still allowed for
> BPF_PROBE_MEM reads," but does the BPF_PROBE_MEM conversion actually
> work for the NON_OWN_REF variant?
>
> Looking at kernel/bpf/fixups.c, the probe conversion logic has:
>
>     case PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED:
>             /* probe mem access */
>             ...
>     default:
>             continue;
>
> It has a case for the plain MEM_ALLOC|PTR_UNTRUSTED type, but no case
> for PTR_TO_BTF_ID|MEM_ALLOC|NON_OWN_REF|PTR_UNTRUSTED. So a load
> through the surviving register is emitted as a plain load with no
> exception-table entry, which would fault in the kernel instead of
> returning zero.
I didn't consider the NON_OWN_REF combination case, but I think that
should be a separate patch for fixups.c?

> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index bc021c8c8fbf7..c3a11c98cd451 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -5820,7 +5820,13 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
> >                       return -EACCES;
> >               }
> >
> > -             if (type_is_alloc(reg->type) && !type_is_non_owning_ref(reg->type) &&
> > +             /*
> > +              * Skip this referenced-ID sanity check for untrusted allocated objects;
> > +              * the access check above already rejects writes through them.
> > +              */
> > +             if (type_is_alloc(reg->type) &&
> > +                 !type_is_untrusted_ptr_alloc_obj(reg->type) &&
> > +                 !type_is_non_owning_ref(reg->type) &&
> >                   !(reg->type & MEM_RCU) && !reg_is_referenced(env, reg)) {
> >                       verifier_bug(env, "allocated object must have a referenced id");
> >                       return -EFAULT;
>
> This change allows the demoted PTR_UNTRUSTED|NON_OWN_REF registers to
> reach mark_btf_ld_reg() instead of hitting the sanity assertion, which
> opens the path for the read-through described above.

I think for the exemption, that is intended, ths bad thing is about
the fixups.c does not handle
PTR_TO_BTF_ID|MEM_ALLOC|NON_OWN_REF|PTR_UNTRUSTED.

Overall, there are 2 separate problems:
1. type_is_non_owning_ref should be fixed to preserve the original semantics
2. For the exemption, new cases should be added to fixups.c.

For problem one, I think there are 2 approaches:
1. Preserve the old type_is_ptr_alloc_obj() code, but for any caller
who wants to verify that the register is also trusted, they should
check themselves explicitly.
2. Change the type_is_non_owning_ref:
static inline bool type_is_non_owning_ref(u32 type)
{
return (type_is_ptr_alloc_obj(type) ||
type_is_untrusted_ptr_alloc_obj(type)) &&
      type_flag(type) & NON_OWN_REF;
}
