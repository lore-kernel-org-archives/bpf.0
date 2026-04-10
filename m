Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A0E261B92
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 02:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775789643; cv=pass; b=U5Wn+bYCeiDxCN6mIM+zIPp+IJeKy2fgDRvFeb5d3/FceTQTLYo7xNKo3KaQWuC8Mf9Q5cbrTF7RlZwMRWY6dUTNogDbCh6sCBQbrY45utk7TGbeKsLWAI+QHqVSw2hyHLUtSATelUx0Tcp+ZsLeeB2bIBjuRw5aCAbfnxSVB1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775789643; c=relaxed/simple;
	bh=+U8n9VxXQerj0YbIEJbEzjVe9qw9ti7gbbPDnGl5yrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecTdLEqyXeU3vT/C7PG1og6Fu9DWQn1sPneGW1ZYybHybFWYb0XkXR76EFaqc7KbOd1inUBjkvXm692AuVvXgBwZnhxrAPToOho1As9kfQzp5b66ikDrlGYfJxuqiA7gHlzvTXX1iHtycillWShDrsWdWgN5nh55ppA3E6sti3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlqAAExB; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlqAAExB"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82ce09b4197so806818b3a.2
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 19:54:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775789642; cv=none;
        d=google.com; s=arc-20240605;
        b=lylVZ0qY5oAntuTAB6blL8q1RLbq3cQfUtfMdLawVjpKDOYAii/JmBuC0cPY+peNIV
         koQFx0DqgHO9LKKnmVG45idvUCMqy3VQRhyGtwuyHX13TG24BAAcn3eNQHsQS2RWSAqw
         3ZyBfK00pYXYH/AOYxh/7EyPLpSX2F3kvGQf3s+8e9wFi0KmIEoJkk1XBTAsWCcqQFMU
         6mx8DSa/ipsDKe1MQ+5v1uI/f8Nh+1YEtMr7V1G6ibbNheR971fEc0DKjzwTc935r3dM
         oq6QYnvd1ZTvU+YF0f0CylHp9AH6ptRib2+dRlVzS0tmmhVV7jPU1/NECqtS4SaRM23l
         Jj6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5SJS/n4iIi0naoS3i40eqv9YxxpAjXCExGdo+g7IVjU=;
        fh=9xGsnuFjI0vhhILUL0FLMXON1JjU0bep/hnEbakHSUI=;
        b=GrSjz7f2XSr+esx7+FX643yKBpEMnXu7jybnkgCAqM7Aq0n4zbSg8wmw/opPUzZoLM
         dZkiIR1Y6RZ7orfUHFaXUrPPKp6bSFcLJEiRGd5sQOmTiRib9vkDxgFrDXkxUS4d/AdM
         +LI8jFlD3dvc2N/66+sGx+PSE7VWlwyn0NNGtzgRUCvY4awinPVc+tQ/j/VNPreFHOhc
         b6BS+QY5AWTvUoVBTxC+Bk5MA3HhQoeNJcx4W/65I3ydhJ/99AFhWVGZcVt2hW3bjjmM
         aLdsBW3xxwqAAM+qFOUTcxlvGHGHKRZq74J6rgAzswgREGialo104KM/LPIPRf9ZTGRI
         zkwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775789642; x=1776394442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SJS/n4iIi0naoS3i40eqv9YxxpAjXCExGdo+g7IVjU=;
        b=VlqAAExBBL/FeM/5U0iEfNLpcfOD7w2rLKdd7SQfw4doii9etKrVp3veGCktK5hMdZ
         hJXELi9JHAPuA01ET+s505c58trHk7cnyZUh5en/e81JNUb8jgWJdzDfs9nzCyGWbRkw
         SOJz6pTaYGXObLh76K8UW88fdwxxHXJGMFcXJ02JGC1OrBMfnYOHUwNVyGgjuSU3k9J1
         CccQIOlp3V67aZp0Gw3P83zCvF/B7VSsWd8MXKAeiAN17N9ZEuH6dS2xnB0AI6DSr5hf
         9DkShi0fgUvZlnzXnHEEi/IgCVu/fjur6dN7cJ9J0Q/8Cf8DcyQNgAfWBarPu2TPpypb
         gmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775789642; x=1776394442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5SJS/n4iIi0naoS3i40eqv9YxxpAjXCExGdo+g7IVjU=;
        b=CSiiJI5IB4t30dzhA49xS9Ixo67r2Kr8T9XHEflm3sVQa/uovNsVivWW/ncZMFHY2l
         7BtXccr90i7XR90Wm74XyAJ9Gdi9TMouYivYrAcTrNJVXp6JHQbr/ggag+QCjnwH6KGt
         O+b+YtzDgVW/52D+JEr5Yca+rSsaUEx8X93GkuJjKVO2OPOM4J2Bqwh+XrjvesxWumXt
         bbYLVdfVUViEithgwVQVCyqAjnd9EYkR8t/4FtfY0eQqkBM4+tOyj3N8Z652bnOuU30J
         HkGZKOTfx1UeJo3ADpQdcQim16dZTd1WrhFjpwW4suqr7Kfs7h5tNeiGu/i7qr98ZPng
         6lLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXduJAr1C96JEKHHKDh0kQOWXMyKma5CAco/9uZ+ohnClIHzlgEQ8Hi4BvWIzsGQ+N8oYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCSB8qCZOVDgpA+BH+S52lu3Bbt2gYv5WCrSJWB7m4fjmup4gi
	z/pokryrIq4x1jDaku7RHK0eNZPuPVN7Z9anEoLO1WcJ9yEY631EjbDoarUoiywchX1Ai7UEJId
	ZHICjxrJ7yint6UtuBsFf3CreNZ3VsMU=
X-Gm-Gg: AeBDieuW+4k6hliQH8iIyA2/S1UHmgCffVLMDsj68fg+SOOkptn+ULMSICQ/VeQDX3R
	4bUr9yF6s9pRfBp+TeQwQEqu8xKfDsoJ/a0PJGT9T3CgGSrqUrCIG2hjm0jO5sPu+e2R43/JCXF
	VCv7+pY9wT5e5zzDDVhpQAy7YWTsuJslbMDg1cIbPmWKMkFjR/V3kK+N2MZKjbqOTKCziY4avCM
	+wKZP8CsOWkb2X64Xn9dPJft0tKOF9f5W1Z5aJ8ChuWTSP+e1XJbn9twN1rkc0O0W+mgafalbyL
	rmC1QqP/fXKID/91
X-Received: by 2002:a05:6a00:3e2a:b0:82c:e4b4:b04f with SMTP id
 d2e1a72fcca58-82f0c278753mr1652567b3a.47.1775789641934; Thu, 09 Apr 2026
 19:54:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260329140506.9595-1-pilgrimtao@gmail.com> <20260329140506.9595-2-pilgrimtao@gmail.com>
 <CAADnVQ+xS4ti=cSqAnG4ePmjEZXUb-8Ss9cjkWiiWgtv-_NNVQ@mail.gmail.com>
 <CAAWJmAYxbEX0M3JFJn11WOfvRoLrxnuXtkDp5omt-FJYwc8mpg@mail.gmail.com>
 <1fcda49a-caeb-42b9-9727-d1ab3d07d84b@linux.dev> <CAAWJmAYNS-NaY-57Pt=GC5qSpbfJLKwydVXfem6ckwgFW9aTnw@mail.gmail.com>
 <82148eb1-f270-48f1-8900-e0becc6384e8@linux.dev>
In-Reply-To: <82148eb1-f270-48f1-8900-e0becc6384e8@linux.dev>
From: Chengkaitao <pilgrimtao@gmail.com>
Date: Fri, 10 Apr 2026 10:53:50 +0800
X-Gm-Features: AQROBzAk4S_eu-LaCn6--bJXN3mHeRr3qnSGVSwJC9tEDVFcDAV1pKx9RIzY8lg
Message-ID: <CAAWJmAZQHmgKXgr0xN5sHWUGyu43xLyg4eG7yBrMDi7YALrKsw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 1/9] bpf: refactor kfunc checks using
 table-driven approach in verifier
To: Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	leon.hwang@linux.dev, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, memxor@gmail.com
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Chengkaitao <chengkaitao@kylinos.cn>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 2:41=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
> On 4/4/26 3:38 AM, Chengkaitao wrote:
> > On Sat, Apr 4, 2026 at 12:49=E2=80=AFPM Ihor Solodrai <ihor.solodrai@li=
nux.dev> wrote:
> >> On 4/3/26 10:41 AM, Chengkaitao wrote:
> >>> On Tue, Mar 31, 2026 at 1:05=E2=80=AFAM Alexei Starovoitov
> >>> <alexei.starovoitov@gmail.com> wrote:
> >>>>
> >>>> On Sun, Mar 29, 2026 at 7:05=E2=80=AFAM Chengkaitao <pilgrimtao@gmai=
l.com> wrote:
> >>>>>
> >>>>> From: Kaitao Cheng <chengkaitao@kylinos.cn>
> >>>>>
> >>>>> [...]
> >>>>> +
> >>>>> +/* Kfunc family related to spin_lock. */
> >>>>> +static const enum special_kfunc_type bpf_res_spin_lock_api_kfuncs[=
] =3D {
> >>>>> +       KF_bpf_res_spin_lock,
> >>>>> +       KF_bpf_res_spin_unlock,
> >>>>> +       KF_bpf_res_spin_lock_irqsave,
> >>>>> +       KF_bpf_res_spin_unlock_irqrestore,
> >>>>> +};
> >
> > ****** Purpose 4 ******
> >
> > It pushes us to untangle messy verifier safety cases and make them modu=
lar,
> > so they can be expressed as parameters to BPF_VERIF_KFUNC_DEF
>
> Again, I agree with the premise that verifier safety checks could
> become more modular where possible. But I think we should first
> separate two questions:
>
> 1. What kfunc properties should be declared centrally?
> 2. Where that declaration should live?
>
> While I'd like to answer (1) with "all of them", I am not convinced
> the answer to (2) is .BTF_ids or BTF. A better C side declarative
> representation would give us most of the benefit here without making
> the BTF tooling more complex.
>
> Here is how I think we should move forward:
>
>   1. Your bpf_list_* work is orthogonal to BTF_ID refactoring, so it's
>   reasonable to first focus on landing it without changes to generic
>   kfunc handling.

There is no consensus on whether the patch below should exist at all.
[PATCH bpf-next v9 1/9] bpf: refactor kfunc checks using table-driven ...

Should we drop it entirely, or limit its scope to the is_bpf_* helpers
that contain a large number of btf_id =3D=3D special_kfunc_list[*]-style
checks=E2=80=94for example by reverting to v8 or an earlier revision?
https://lore.kernel.org/all/20260316112843.78657-2-pilgrimtao@gmail.com/

cc: Alexei Starovoitov, Emil Tsalapatis, Leon Hwang, Mykyta Yatsenko,
      Kumar Kartikeya Dwivedi

>   2. I plan to send patches (soon) for resolve_btfids, and then for
>   BTF_ID macrology to eliminate the enum + array pattern. You are
>   welcome to join the discussion and review / test the patches.
>
>   3. After all of the above lands, we can come back to the general
>   BTF_ID / kfunc handling discussion. If you are interested in
>   developing this further, I suggest to re-think the approach and come
>   up with a "single kfunc metadata definition" that doesn't require
>   significant changes in .BTF_ids section layout.
>
> A slightly off-topic comment: the usage of `_impl` pattern for kfuncs
> should be considered deprecated. Any new kfuncs that work with
> verifier-supplied arguments should use KF_IMPLICIT_ARGS mechanism.  So
> the `bpf_list_add_impl` in your seires should only have one version:
> `bpf_list_add` marked with KF_IMPLICIT_ARGS flag.

--=20
Yours,
Chengkaitao
