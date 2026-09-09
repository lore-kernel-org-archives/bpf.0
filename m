Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E945233C195
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 20:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986946; cv=pass; b=TXGXFbk9wFe4PUn6X5d/P6Sdl+T3qOWdTpaQDhE00EWSNf5+QdLTydVIWXXqZarJ/j/BoSRMyQyP1w4BC4lrsfXnEDCNdl5eI+Xd55fSj/lmU2G2ZU2F0SkxLM0dttw6mcttrjU73Sn5k+RlHVIgv5MPUaWaZOdi+d1pp+C+bs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986946; c=relaxed/simple;
	bh=nlZ5v9V/cll2+OXejBLbJSwiABI1eApIDJsofHpZE+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kekLianEyaeCYqXILAHyQJmHQ5Hsg1pJByB6TQ+DHc5OPnsAE5ISchR1Ffxeqq5/tns7d6EMbCRfCdsoyIzTBFhkU4Eq5dI8GXfcWhiPLng6AdWbRc0g3O1q5/IrsgDc8Lw9wAaEpFmNBw/yg7obOKUH7BZet+gvWvNbU5BsfnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrgILLxB; arc=pass smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrgILLxB"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6b12942ed04so5088273eaf.1
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 13:48:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788986937; cv=none;
        d=google.com; s=arc-20260327;
        b=oaSvi26aIMzwa5wPIIgMQfR33H+6BkWUO9mEs1oIGekE0PaWp5MKvwknvSJj28zLqe
         lPJvY9n7JCBuOnMDkQQMQ0LdojqxMHbf9ffINSb8HOxZx5j4qyt4A8yWUroICD4+lnnV
         F/AIunGG8HFDDgQPJ9FgNBAE94P6KI4BevJoQ82mociBnDvCYlA6Hb+msNpnOlpY+C/V
         Y1Pbe4sd4e22n21E+iCGnzgpYN/5kJZPNIYvzHkgowT0TmBBLdOtqFWT31HHmq24h3+K
         Q/WWla0R8O2JmZOmf9Q2tQW6RwQMekR8y4oItNA4ODBsacIWwRs6QstwF5quCyJS0OlF
         ei5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vqCoNx9ob5HcOJvwY8zjc6Vh89ac2goQ8yHc1FgFnwo=;
        fh=+iofH7kLhUIpDUAo/a2rUbKulXCH8Go9n65YHAt0kP0=;
        b=CLHwUjIli2lqkvK3Zdq7I8s2Jm3iYJ1M5RcOGmFZ6fC0Bf5lUvy/es0JVno9mxLs9C
         WmhaG+3c4Yug3oX+otMoY43sG/e+QSlQSN9X9c3ouddx5qWSB2Osl7+d7BtsIQvoLbPb
         e19HLhtcd+UGJD4jYJ3riqjuVcq2bg2ndrfdukM8lOHac+OXWuUu3qFV/om55nNsqj9L
         Vu++8tus/N7cWYTifs0lwNCFjuEJ8uvas10YW6s3hyrluNNBPoIGfB7ZRWJ5qL07mTD8
         ZtGL5zZ6PDTk3+mg0tcuwKLBt3G1bqg6hDS9KVMMYS5UXcvhYMyzlZxK4+PYVYHxeZEu
         sU+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788986937; x=1789591737; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vqCoNx9ob5HcOJvwY8zjc6Vh89ac2goQ8yHc1FgFnwo=;
        b=CrgILLxBhWxZOEBZDJ8Vxa/Uih/QXZO6C0F4dWC1qiQSidzWeKSFFTlMW4zEfAK089
         cgAKoMu4Qou6YOi6tbpqZeed01EcYAK2Y3X/YeG2piMtFHLsflQ+AG243tDU5ZHsMKN4
         MWH738sCU/axVSVgWtqUeCpJN41X0vjWYZr8X9l0tORdaRMSAHqIJL6qSQpyZiAPfLWZ
         J9MLScakq3mnPp/17uIfOXanSeETq5wi50Jcr1rtc+uWGU10Lz+MX5KMsMFJJvUa+C8o
         RhZNrm9X/Ay4rulnqY6oUTImbwT+LRObgF0GGbaaQtI4mwjqNVCdRzXiNUL4nUt0M80p
         XNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788986937; x=1789591737;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vqCoNx9ob5HcOJvwY8zjc6Vh89ac2goQ8yHc1FgFnwo=;
        b=Ch9z8CymcuBBW3DjjkupjKSaSrwNf1SjnbQMKpLHvPoo4vSG2f26zIT4PnlvUMzVoL
         0QrFaxc/HHAF56n5llOW/qHz9q0y+5iDsMZzTH9PN13aT68aFyO8/cHoswUQuVaCk8wS
         KlnWR0Y2Ivrn1Gx9i3jlMkR3nd4zeHFo/fsoAMtRm0IjlrzGWDpP/CMa3SSiftj2M/eN
         AZ7ohQlNUL+OKCmDkJcrGxG699SvH+FIjHpOlayBIHmv19qWvIYcokTH39Kmj0X4vmq9
         VcdCjAP6JnB7/iIbRo8prpjqWS57y4HnUzbFzl5hHeWQN58GLnBT59p9tT4bCNaOv98v
         ZE0g==
X-Gm-Message-State: AFuF++l53AXNA3WiixkHHqw5YhEIo7WmgPzAg75szg+upIs0bNCV5uby
	0KkkCjKWrqO9/xFwEMx5/qiew/PsaEpBZuuJAUVvBFgqNUXCoDywT6DZKt1A+nFWTSzLom24ixh
	nWRNn8DT+CHi1UPDCr6p3XISKFOlEF4PCz7qk
X-Gm-Gg: AYBFou2v6+esJBOFIUsF0pAMSZQanIXLC+cLp8YnvphwIuYlNdBWNVeF4SqKUbHXmDb
	43PNF4UKeXpWVN6bYuKueWMOEcD2ULHzvBGcZNufQKdWdyu60SCxdKe7pEToQdddM++B1QZK3xy
	8P//A0IZcWD/Rxno/Y/RLkkhkTf7CVn29wKivVE4IWBQ7QXQmilWgoLIK5uLuBm01dZtN8ItmVm
	frjI6IySOY/yoFgKUplDepNhObHIOMy25yuZTwWVk4OtuSL7gw5wF/9oU0aWkAkJZBNMfeN+qDy
	6UmVgxqXPdcgVnbdk3wdslwSq1ipq0d1Ezhyrn1Fnj/dtc7eMmjeWZ7nuqDuYr7K8Hl3Iw==
X-Received: by 2002:a05:6820:168f:b0:6b7:83c5:fdef with SMTP id
 006d021491bc7-6b783c66750mr18676109eaf.48.1788986936877; Wed, 09 Sep 2026
 13:48:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905220117.922028-17-ameryhung@gmail.com> <42bf7cbbe585cf05895199e9f39ee29f4e4e83c6f06ae84cfac7ed5dd984cd38@mail.kernel.org>
In-Reply-To: <42bf7cbbe585cf05895199e9f39ee29f4e4e83c6f06ae84cfac7ed5dd984cd38@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 9 Sep 2026 13:48:42 -0700
X-Gm-Features: AcwNN1Xj8k0QeArATpdwfQM--hPpmdBx1RNWpZnWhRfP55_vw68XUz1a3Fw79dk
Message-ID: <CAMB2axNR3ycNsRKHyYkr3hNF_XHpX5wwKt=mVyn9gmDv8T1tLw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 16/22] bpf: Drop redundant BTF pointer helper
 write rejection
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	kernel-team@meta.com, ast@kernel.org, martin.lau@kernel.org, 
	yonghong.song@linux.dev, mason@kernel.org, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 4:08=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > commit 5188979f5e68c2684632ba13facdb46febabed5a
> > Author: Amery Hung <ameryhung@gmail.com>
> > Date:   Sat Sep 5 15:01:11 2026 -0700
> >
> >     bpf: Drop redundant BTF pointer helper write rejection
> >
> >     check_reg_type() rejects a trusted PTR_TO_BTF_ID admitted by
> >     mem_types unless the argument carries MEM_RDONLY. This duplicates
> >     argument-specific memory access validation and is too conservative =
for
> >     map keys and input map values, whose read direction is not represen=
ted
> >     by MEM_RDONLY.
> >
> >     Since commit fa75b7c85b0d ("bpf: Enforce write checks for BTF point=
er
> >     helper access"), check_helper_mem_access() forwards the requested a=
ccess
> >     type to check_ptr_to_btf_access(). Map keys always request read acc=
ess.
> >     Map values request write access only when tagged with MEM_WRITE.
> >     ARG_PTR_TO_MEM prototypes must carry either MEM_RDONLY or MEM_WRITE=
,
> >     and size arguments use the direction of their associated memory
> >     argument. btf_struct_access() therefore checks the effective access
>                          ^^^^
> >     direction in every case.
>
> Is btf_struct_access() the correct function name here?
>
> btf_struct_access() in kernel/bpf/btf.c explicitly ignores the access
> direction; the parameter is declared unused:
>
>   int btf_struct_access(struct bpf_verifier_log *log,
>                         const struct bpf_reg_state *reg,
>                         int off, int size, enum bpf_access_type atype __m=
aybe_unused,
>                         u32 *next_btf_id, enum bpf_type_flag *flag,
>                         const char **field_name)
>
> The direction is enforced one level up, in check_ptr_to_btf_access()
> in kernel/bpf/verifier.c, which:
>   - rejects any non-read of a faultable pointer,
>   - for atype =3D=3D BPF_WRITE dispatches to the program-type callback
>     env->ops->btf_struct_access() when one is installed, and
>   - otherwise rejects with "only read is supported" unless the register
>     is a program-allocated object.
>
> Reading btf_struct_access() as the op pointer env->ops->btf_struct_access
> (same name, so the sentence is ambiguous) does not make the claim correct
> either: that op is NULL for most program types, and in that case the
> direction check is check_ptr_to_btf_access()'s own "only read is
> supported" rejection rather than any btf_struct_access().
>
> Should the commit message say check_ptr_to_btf_access() instead?

Right. It should be check_ptr_to_btf_access.

>
>
> >
> >     Drop the early rejection and keep check_reg_type() limited to regis=
ter
> >     admission.
> >
> >     Signed-off-by: Amery Hung <ameryhung@gmail.com>
>
> This looks like a bug fix for commit fa75b7c85b0d. The commit message
> explicitly references commit fa75b7c85b0d which introduced the validation
> flow change that made the check_reg_type() logic become redundant and
> overly conservative. After fa75b7c85b0d changed check_helper_mem_access()
> to forward the requested access_type to check_ptr_to_btf_access(), the
> early rejection in check_reg_type() for mem_types without MEM_RDONLY
> became incorrect, blocking valid use cases for map keys and input map
> values.
>
> Should this include:
>
>   Fixes: fa75b7c85b0d ("bpf: Enforce write checks for BTF pointer helper =
access")
>

It's not a bug and does not need a fix tag.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/339954=
42755
