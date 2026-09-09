Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AE23921E6
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976473; cv=pass; b=XH3AjQvjZ0nqB3n5FFU4rXPlfburL75qChVV8AbkWmqi2mmj5XBKOF3dUrEUQd/dHcx6odYAW0tc8aBTZiXtyaa88YKc/GcuJfl9Cao86ajiBgq/XkLHG3B+nFM18LJykBvN+5DhZ0CetbBh54CB9zzvjxqYh6nW+o6rIe0ptF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976473; c=relaxed/simple;
	bh=/LafidsCyeqiSc8t/CHXLnG7Q4tnongMjUQKgD2sOeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AxGY5sVKwaL566VmSgnBi7/cujM5q0S1+hj1/7bsL9n9GsiFe+hQB9058PNOxnPmT82I3uL/rtoA8R7TADE3LqDPoKGL5jX/FGBg8qbAo4F5EIPIxJ1BsyI6ekEd4nv+WVJCn8UKRjwUHhwa3fnmrGD4InWmME+21xDGH7pH39w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUHiDPvN; arc=pass smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUHiDPvN"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6b1b9c3af5cso5014730eaf.2
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 10:54:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788976468; cv=none;
        d=google.com; s=arc-20260327;
        b=VVGCMSlBs0EMWSt9Ffeh5m/+xOtJ/jbtoSXwgAWNCEV4aaC7pZYyTXUfAD4+O3mzBH
         nTRz8SWV9vaIOCKqqdmMb128I3SInfkqj7lLgN9IEnoAancEDAQCOBO6/scWukW4yyyk
         5lqTX6eLQ7re3kNcD2ex8hMT7d4F+nJRhbgtSP76EAANaAuYtbi8vubnZA0p97fatnZQ
         jXChF69Ryef2t7B1l4o+9Bs+OaiiA+gQLbHxaru7WuiJwM0K1Gnvg8UmC5TMfRgtVrRb
         8Lne+9kelli/wxn+afIKZgd7Q9GP36CwIetqWigPAl8nD0JFQZ7xpYiHD4xVeqwK9eOr
         JNMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tHifi+n0YLlzsfRl71RQEmNfJE62xqGzn4SHM9nhIkw=;
        fh=+iofH7kLhUIpDUAo/a2rUbKulXCH8Go9n65YHAt0kP0=;
        b=qqzpjfyqq2pR9zExohedjQtLUM5LvmBgDEpPajHXofitua6LgNCpb4nzlhzOXOClIW
         KCXwACU06kL6yQjzixkGPmumZCEcofjQWo0Buq4ZbN/7KAvG/8eb2Rhnn1Q9CoefjBiY
         jGh5OQcsgiU4hTRqDyhZ2aRJVj2/bMXlxgSDRFZqsRnOqOTiuM4OACrWgutq42WI7qZ6
         pxlEu9kNsq5ynxMoHj7OJgSAs5/+QjIYK2S9iaAbizo1GpdNnDsB/8HryZ9w5kE8VLDA
         DxpE/rAlS3Fz8Ph1bxtl5QWlLeOzJXYSfbra9caa1sypcaqnDCX+mHoS8+iJKYlin1R2
         O0kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788976468; x=1789581268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tHifi+n0YLlzsfRl71RQEmNfJE62xqGzn4SHM9nhIkw=;
        b=LUHiDPvNeLf0O5+OYNpc5HffhEaaqFj87dvT2PrYvgSdT2Fd+ndTug00Hbhk4TYDIN
         vDjElLjt5DMDCrBwErcaGdPQWP9tJPfQ8OwqusNeMOKdVlgAtmTlr6XwIDqN/nc60kXj
         9wnVYWsbpgti2tgZjmq39wZJYU3XESIa/lUXdskuKp+qBR3rR9PpVys2d4WLGrT9hKeO
         QVo5Naa8mYp6qfD+8F5qBmJ2K3jcjeXe3+3M6mvoJGqpUHP3L0U8sG62mUGkZLbJRqpK
         LZCxgc6yTpeM1klLnfEermEHZSyRjWTHk0XrHj+hqTCPNazKWQwXCiUTIhqiIq/Q5m1g
         ddhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788976468; x=1789581268;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tHifi+n0YLlzsfRl71RQEmNfJE62xqGzn4SHM9nhIkw=;
        b=goZw/fIbVh0kicS7I2bi5pMsX0NlboHG7eeaVEfpbwL3NuRhoKdHyg2bN4vF5tdaw5
         AtjoYey+XWE6aMv5AOAR7N4FXkt6ujWzgHAq+JewXkCL0nUwm0CygKq8zBaGcS3NIdZu
         XRYrBs94PJ5E9+qiAYNaHDELSBfrxQMA/LSbHvC+c0Enyx53KCq0WtXGvtlkCC1bt83x
         XhxPm80Qk6+l0Br5ZGuQRpNDVmp1NFQvq3V5eUVw1loBz8AKx8e5qK+cRm+TCu+o+y82
         XcJwiYF6QYWW2NOh4Vn9Qa9zJh2ssOw4ud07hFE/B59KYCHgkmkoxieidNFuXlCQo0u1
         H4Vg==
X-Gm-Message-State: AFuF++nrYZh8SNag29+wBF0+GwoYb7YwYGHCItuVG+z35HDSNCjpimOO
	S/GoN6Q8bUpcSo89K4/jZ2zKrJLT6xxBTJieEb6p3coptOgQzvbz5b2GT+0Dl57xzZBRec0xFXf
	Z4ZGIHOve4J+eKXkvaaU+XMXh/79NCHQ=
X-Gm-Gg: AYBFou0aPbTmVR1fUTsFwrqxlQyaMaqS57iVXwC8A4y4o7OtKZPwIsId4/442aOWGNY
	GG8tGB7pqEb/Go5e+fHdAlmz3dlUM8B5DlD2JQPn64dJQA3oMfu7RBQhNSrxE2II7NQCc0r7DR+
	5C554RiSO1KnanWn8VjWLu+uRws8txoAdiMoyHBOPDcdENptu1J4Kb9ZwKDVU5PfJbydLBsE5WF
	BLHWRA2uitMotmjEAk3BoPoAig2vSimPma+PRgQWp6PR+APVmVG4RaJV2Yz/YkmfaeQFbzA8URC
	L237bbF9g8JI6/tvoEH52AtQigtWWXtmWrt5tyTqhHNemg365A0OfL55fU5vyXl+7t0jGQP5XGg
	9I/iC
X-Received: by 2002:a05:6820:162b:b0:6b7:46fc:1cf with SMTP id
 006d021491bc7-6b746fc2ed1mr19740954eaf.46.1788976468244; Wed, 09 Sep 2026
 10:54:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905220117.922028-6-ameryhung@gmail.com> <51c890fd762298bb1e73a112953c44751f6161de741b57e9239067ed8d19d75f@mail.kernel.org>
In-Reply-To: <51c890fd762298bb1e73a112953c44751f6161de741b57e9239067ed8d19d75f@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 9 Sep 2026 10:54:17 -0700
X-Gm-Features: AcwNN1WBW-yBvC4t9Ud5kn8kkHuJZ1Um5UyeHg3SoRHe8BxlYP6PnvQ13OXvcVs
Message-ID: <CAMB2axMbqtto=XniD3m0TnSLMC7_AUY0Ls3ennm9nsYQnz_1Dw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 05/22] bpf: Rename ambiguous function argument types
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	kernel-team@meta.com, ast@kernel.org, martin.lau@kernel.org, 
	yonghong.song@linux.dev, mason@kernel.org, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 4:08=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > ARG_ANYTHING does not accept just anything: check_func_arg() accepts
> > an initialized scalar and rejects pointers. Rename it to ARG_SCALAR.
> >
> > ARG_DONTCARE is the zero-valued terminator for the fixed-size argument
> > array rather than an argument whose value is ignored. Rename it to
> > ARG_UNUSED and stop helper argument iteration explicitly when it
> > is encountered.
> >
> > Also pass ARG_PTR_TO_MEM when checking a global subprogram memory
> > argument instead of using the prototype terminator as a placeholder.
> >
> > No functional change.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
>
> The commit message says check_func_arg() "rejects pointers" for
> ARG_SCALAR (formerly ARG_ANYTHING). Is this claim complete?
>
> Looking at kernel/bpf/verifier.c, the rejection is conditional on
> allow_ptr_leaks:
>
>     if (arg_type =3D=3D ARG_SCALAR) {
>         if (__is_pointer_value(env->allow_ptr_leaks, reg)) {
>             verbose(env, "%s leaks addr into helper function\n",
>                     reg_arg_name(env, argno));
>             return -EACCES;
>         }
>         return 0;
>     }
>
> and __is_pointer_value() short-circuits when allow_ptr_leaks is true:
>
>     static bool __is_pointer_value(bool allow_ptr_leaks,
>                                    const struct bpf_reg_state *reg)
>     {
>         if (allow_ptr_leaks)
>             return false;
>
>         return is_pointer_regtype(reg->type);
>     }
>
> So a privileged program (one with allow_ptr_leaks set) can pass
> PTR_TO_MAP_VALUE, PTR_TO_STACK, or other pointer types to an ARG_SCALAR
> helper argument. The pointer check only applies to unprivileged programs.
>
> The later commit in this series, a490f49b0c4e, acknowledges this
> explicitly: "helpers retain their privileged ARG_SCALAR pointer-leak
> behavior."
>
> Could the commit message be more precise? Perhaps: "rejects pointers
> unless the program is allowed to leak pointers" or "rejects pointers for
> unprivileged programs"?

Since now ARG_SCALAR is introduced outside of this patchset. This
patch needs to drop most of the changes.

I will only rename ARG_DONTCARE to ARG_UNUSED and change ARG_ANYTHING
to ARG_SCALAR for global subprogram.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/339954=
42755
