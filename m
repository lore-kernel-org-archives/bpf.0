Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFF0EAC7
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 00:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775693730; cv=none; b=ZpwSvasN2/bwm5Qtfeqppb/q2tlp2cbXi+9+awD9x35mfS/S8a6SDvWTG9Cl4cS6sOk5cx44atkOQNmVk3KfMffkVuy9Z3yiU/SFUNet1V0kHRimfWyzMphkRRmcYoirJRpJ+sx3p75UH+B6gOnc2Gynm8iEqVX/OhJ72LckHxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775693730; c=relaxed/simple;
	bh=rHlzbWbYZXfwmF0IIw4bC5rtuhPyVpPXZcVRQBqx5J4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UTwIg6E+StscWuMmsZMQWdbPYqyevteboQyCYRGsibmrBvHk5OkII4eTp43j9ngffy0C+8rOZpEg0ndDGi94J0MWkpOprpd0Ad1XjwPYf2AoKUWgaLNvZhHqwGLr20L/v06hBZZgStvEve7WdwI3hcgsxrlur4Z0JXN8n6UmX6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=qs5NZu8b; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="qs5NZu8b"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2c15849aa2cso194448eec.0
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 17:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775693727; x=1776298527; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQeVVNPgPW5qkN9z3xGFvzVAeIz9Lqrjhyp+UfAwxIo=;
        b=qs5NZu8bZbgq66WQW1uBP2dMDWOuhH7x9l3J2LGGgOXC0KlMvLmeS70N9JmKrb/GHC
         5Qzmt5dKjb56m14G7Lzi2FKdHUVLk83S2Mt3Y74OPEflrc3bZfQbx1lnIt+KTqWcaGOw
         Y+QMOke4DN50dQYOnXio0mR2/rDiAIH/CUVlgj9qqN5fUodEmAJt9fOjA3owxB2umVuk
         cQVkg2HpkvkZjr6x53C+G9061JCWtaX7L2HLZHhgnTHYQWrdp3L0f9GVAnbFawyuIsG4
         uEvqJYSjDt1aK+PpKpuTL8m/ZcK66fN1L9fdLT+Ao/C/q7K8NDmBwgYLdmntWZAH7ffL
         n+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775693727; x=1776298527;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lQeVVNPgPW5qkN9z3xGFvzVAeIz9Lqrjhyp+UfAwxIo=;
        b=ZDETHo3Ys2oMQGJyhZX352KEoRPzsg9mIR8M9ZIVMkp9NE7lS99FejDdUN4D8noG6u
         k1VpEEwXjxISyZw+wskCM3qcxR+QGUippmI2EKri6rhW0ECUxN0wFgKGmwFRH9msJjsm
         uOKEr9yp9jWA5PxiMX3c1S6RHzvu5YmZ2qOqgI69+aTXCl/agijZWkbKHKZWIselcA3C
         9xHji9lZoNT+jJtJkGEEdrmyF+qHK094Z4WKiraqc3kKsfiV5RjcPDQ76FFd/PSADrbD
         pWyl5DQJ6bZRrGY0kKQbp3lAhmF/8QG+5lqLsoMW12VWXe8NHHACQrKwumgvt2v8L0eY
         uJ6Q==
X-Gm-Message-State: AOJu0YxEkC9sKCfyzlQBzDLZ28o2N9mk0XJFw3ufmFRvxQMKydgvUe66
	UHchmUx/LX0jPAfiDAFDPvEEuckFvLeeJTy7dkzWbpO7ttKl2PkLb5C4q/4W7/hYhQ0=
X-Gm-Gg: AeBDievFzR81792FXrgXNvjA9vgWsVusldHz1oTuWh7sfExfqYrqQe3iAMwfjpO3QBN
	+OvJOhkhMem+vkw/zXKnghSnAceeT0JKMICQ+g6HP/xanQ1JD1g5WNxdIra/v0bHCFUMFHzrsDP
	iiC/Mf6vS+cwnk9G8aZGpDfE2CkUM2NPVWDFvs9zExtPnKoIO/EBKEjT1XbsdIpxxTLRxnJcIiZ
	fX6RY1wMJ76QvAen4LqM1LEPePYXc/GN7HzHvbJ/BhXlNUiVNmOA3jpAEaGtMH0/FqszGk2kzPp
	IIV62ssl8012Z8BdUMj6bpUABCZAyvvCdZegQkLfvu0eDrXgGMs3p3uzyWlz1dzF++vQBwIX9m2
	Kr7RQcAPq7Mb4cnZVLTMMgKaR88470qHfhn3fN7z6xpzq17zK/6MZ+TR3A8PwvO8DkszAGaficM
	LXU1Ck
X-Received: by 2002:a05:7300:cd92:b0:2be:171c:5048 with SMTP id 5a478bee46e88-2d40c20b95fmr813395eec.5.1775693727494;
        Wed, 08 Apr 2026 17:15:27 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::68e1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cc0c6ec215sm21425855eec.4.2026.04.08.17.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 17:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Apr 2026 20:15:24 -0400
Message-Id: <DHO6W3RC1IV7.QYXIRM4V8A2V@etsalapatis.com>
Cc: "bpf" <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard"
 <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>
Subject: Re: [PATCH bpf-next v4 1/9] bpf: Upgrade scalar to PTR_TO_ARENA on
 arena pointer addition
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260407045730.13359-1-emil@etsalapatis.com>
 <20260407045730.13359-2-emil@etsalapatis.com>
 <CAADnVQL5Aheo7GrVtxaE0F1xOcUN=6aifGgh8RE9m4Orj0H19A@mail.gmail.com>
In-Reply-To: <CAADnVQL5Aheo7GrVtxaE0F1xOcUN=6aifGgh8RE9m4Orj0H19A@mail.gmail.com>

On Tue Apr 7, 2026 at 12:10 PM EDT, Alexei Starovoitov wrote:
> On Mon, Apr 6, 2026 at 9:57=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>>
>> The compiler sometimes stores the result of a PTR_TO_ARENA + SCALAR
>> addition into the scalar register rather than the pointer register.
>> Handle this case by upgrading the destination scalar register to
>> PTR_TO_ARENA, matching the existing handling when the destination is
>> already PTR_TO_ARENA.
>>
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> Acked-by: Song Liu <song@kernel.org>
>> ---
>>  kernel/bpf/verifier.c | 27 +++++++++++++++++++++++++--
>>  1 file changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 8c1cf2eb6cbb..30bb71f90477 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -16297,11 +16297,34 @@ static int adjust_reg_min_max_vals(struct bpf_=
verifier_env *env,
>>         int err;
>>
>>         dst_reg =3D &regs[insn->dst_reg];
>> -       src_reg =3D NULL;
>> +       if (BPF_SRC(insn->code) =3D=3D BPF_X)
>> +               src_reg =3D &regs[insn->src_reg];
>> +       else
>> +               src_reg =3D NULL;
>>
>> -       if (dst_reg->type =3D=3D PTR_TO_ARENA) {
>> +       /* Case where at least one operand is an arena. */
>> +       if (dst_reg->type =3D=3D PTR_TO_ARENA || (src_reg && src_reg->ty=
pe =3D=3D PTR_TO_ARENA)) {
>>                 struct bpf_insn_aux_data *aux =3D cur_aux(env);
>>
>> +               /* The compiler sometimes stores the result of a SCALAR/=
PTR_TO_ARENA
>> +                * operation into the scalar register. Properly mark the=
 result as
>> +                * holding an arena pointer.
>> +                */
>
> No networking comment style in the new code. Please.
> Can probably drop the whole comment.
>
>> +               if (dst_reg->type !=3D PTR_TO_ARENA) {
>> +                       /* Can't do arena arithmetic with non-scalars. *=
/
>> +                       if (dst_reg->type !=3D SCALAR_VALUE) {
>> +                               verbose(env, "R%d pointer %s arena prohi=
bited\n",
>
> How agents suppose to understand this message ?
> The comment right above it is more meaningful than this verifier message.

Ack (and generally for all reviews patches, I am going through to address
specific points only as needed). Do we want to modify the other
messages below to be more expressive as a followup?

>
>> +                                       insn->dst_reg,
>> +                                       bpf_alu_string[opcode >> 4]);
>> +                               return -EACCES;
>> +                       }
>> +
>> +                       /* We have a SCALAR_PTR_TO_ARENA operation,
>> +                        * propagate the info to dst_reg. */
>
> As Leon said...
> Also SCALAR_PTR_TO_ARENA is a new enum invention.
> I say, just remove the comment.
>
>> +                       *dst_reg =3D *src_reg;
>> +               }
>> +
>> +
>>                 if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64)
>>                         /*
>>                          * 32-bit operations zero upper bits automatical=
ly.
>> --
>> 2.53.0
>>

