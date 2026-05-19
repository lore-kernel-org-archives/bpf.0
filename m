Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B6D341077
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779221653; cv=pass; b=V+W6OBkjNhpYH3E+oC+jD8afqVnHokOM/tysJ8eX/RCv4WsuSUZ8smBEDAW8BmhWAp4eU24WGB/8XZrWiBqIn5ZQ9ADXGL2WGdmX/Kwz91OWEQHiFlvnojfisR3Cc/IdzHoKctMjIDLdLvTs8N/RaoadWtoWxZstI0aPmocTH64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779221653; c=relaxed/simple;
	bh=l0Hwh+rQk6VbMYcCuvHAesejiXWdL0/E12fRLHc2C3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NytLPoPuqOH15ZoQFULEnTQqVhg1ozbhh9s1PKRnFOKpZfAouUPa8+MJmyZSX0zqMHAHq0IUcwJ0oiRdP90Cm0HzIt178ggpmFPkND4g5Z3DLvvRUD6TxiHaLAq62BnAdu5ttSibpHOF4xjUNkmSp23bNFc40oLAeOzPlZ8R9Do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caaB7PHg; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caaB7PHg"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7b4ee3a88e1so36931957b3.1
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 13:14:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779221650; cv=none;
        d=google.com; s=arc-20240605;
        b=h67FZkaAkT8C0Rd64wUPMwDSAXjKfrOCr2dePA7I/XMPlXqEpfMOOQ1Ts41ufjEl8C
         CAxzVRz3Spdj9SkDpjsQ33Q7rESSfYAIWkMrOao19unQPY4aF8X19Fb9HEme4rjcj6na
         D1GJL4URmQvztg/hMA8eQw8L4j6rCES771zqb6NWw8CCe3wX9mF2v0n+f+IMg0+I5zr/
         VF9FNtt/vTMI/BgBJ0FAapbGv/JErnyJ4UYcctvVo4xSt0Z4TGTVV5rHaiGDW1Zo8bgG
         ZEaFH8FhPB0PWRp3pAAUzmRUqJZUkhNT6SLuwgxOrKsrB0TB9HH5QuSYw4MwCy/xbX+1
         A4cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3nosRLmHk2ET0pSmZ9ZmsHhZau6rH6IKXdg5ARnOeJQ=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=Ir+Ahid93WFWS300zKffvGYrN7cAs+dFBjMdRFpAtkVbhNJtHJEoQtGt9nvNE7fDA3
         PMP4Ww/6U4FnABke1SRV1TmeCKhuoAWliVb5/rPPDPCNva5bFSlDrxlEdhdRKeCUF9eB
         QaHFanYs+2eYzW47mnTH+XgrHLjA4pPGDJKRX+nsbqjPRHm4ncn4nDv8xvjLphhrYxwe
         lFh0F+apbsi5Pk3jPNUh52Lke3G1AZ/KY1FTkWjBfft862ZBMvGyMScjyPWzQAnWpXXN
         DaZWR0dNPhKMUR5VejxuiyS0ZhBe2eJ3ZA3gI5BNFVX5yAyhxoMnffG7gbAvEtto5I7X
         FTYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779221650; x=1779826450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nosRLmHk2ET0pSmZ9ZmsHhZau6rH6IKXdg5ARnOeJQ=;
        b=caaB7PHgJOXRvn4bdvBkbpBUpqwEucVulzzIMbsArKb3W7duRQOTrpv4NykCxvyTzU
         rdW5H44+kHDp4/pv42dClRQ6n40benZSDTxsPpxMGT0BEkCXVYq5Ru2JPvkdp0N8koDI
         B9p4owxGtjBaSHkZlyM+cJfbw4tcbI1Hn51fnfcmtCIlx1qWE24l6kELfoHw9mcCqc8d
         J+43FB5FrOnP+hU699ur+pcP8FjPkhOa0u4NoZ2W8WGhYGhbdg99Arj8BcZHIMVXI5H/
         Twxt0C1Ud//c8GMsIqhcxK3/GZl7M+JQrpX6Jz166RoWPaq77PLZPXnmWI7yyLwj3lbq
         Pabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779221650; x=1779826450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3nosRLmHk2ET0pSmZ9ZmsHhZau6rH6IKXdg5ARnOeJQ=;
        b=hhyW4tqiT7zgV+Iv9dS4yawtADGYKdeU8qIIWamJ91MaqWlLuoNto+ioPE0yP2UNkk
         0zxLUJ3aWvZL1mnUlXlo/JcyeCazhq9zQUk3rv1dw8+y/PAf2a04mddeDF7h4GPjdqPY
         XzQ3qsUA7Xn4GpGBCADduop2u+3rHWi7iVFl6TIVsJuB/WvyFDKoxTlCSyuJYy7nKO+P
         MWPIqEYnxZbknY8DwAa8Ix3oDucxnb1AuepzPJcPgivWpTqvAomc4/wxtOvSd36gzxkr
         MEDFt0bFkYsf7jJkvdQXeunCKGsI2bHeAGe7gON4S73c61HJXnCDZcbWJ8tQj3VjxSqZ
         KCUg==
X-Gm-Message-State: AOJu0YzmzGpGZLvnXPklhanp41i35CxQu6K4NCriIG3UHl9xVqPm9Emy
	kvJ7e+wXsPpl42Gnd1Cb5bICc52W2kYlQB+ISqo6XLe2HOGsX5Cx777FPDHFcwtJZZXgD8zP+YC
	8MsmfUJ3/z57JZMmkC6B53iUj6fT7BQcCQM5I
X-Gm-Gg: Acq92OFdhM0hKTAyabjHpOMeQkbnV3rzv9WPP/kUF88YHU0dpM+7Dz2oIQQR5xURCaY
	eyNQbtGbrbnn1YakdYZncAAasGjUcK3AJPVUYMSqoqIgBOFxK9fiUSy7O0kLOculFms/QGCA/X6
	7kuePE7hARe2LOK66xbKLOOkEzRZ4O1E40SUbFr4jnnyOaqXRFSNHhdcTuwFHfAmFOMZXE12Tvf
	camPkONB/79Zjd1kJj20ACjiZ+kwkxZ68gW2SOF8ssRG/YPkIxR4UGa9gQyJ+qpNmQ9RlUZT/EX
	DcNnR6rPXvoDVDaB58AvEdFZF8CG528=
X-Received: by 2002:a05:690c:6e87:b0:7b2:7dc9:35f6 with SMTP id
 00721157ae682-7c95d1d90d9mr235446167b3.45.1779221649856; Tue, 19 May 2026
 13:14:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519181314.2731658-10-ameryhung@gmail.com> <20260519185952.DF0181F000E9@smtp.kernel.org>
In-Reply-To: <20260519185952.DF0181F000E9@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 19 May 2026 13:13:56 -0700
X-Gm-Features: AVHnY4ICog8fdZWJZkMlNJ-vus4YmpFdWGzSQ4dn3MNE6Ws9EK4IofdUn09OOdg
Message-ID: <CAMB2axNsE9gdE+g7OCcnpwm7Y1Q-Xv27t6-X9Vi5s74AfCq5LQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 09/14] bpf: Fold ref_obj_id into id and
 introduce virtual references
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 11:59=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] check_reference_leak() incorrectly rejects valid struct_ops prog=
rams that return a pointer derived from a virtual reference (e.g., a casted=
 pointer).
> --
>
> commit 4171c91972499af3939593f911ee11b4fbbe778d
> Author: Amery Hung <ameryhung@gmail.com>
>
> bpf: Fold ref_obj_id into id and introduce virtual references
>
> This commit unifies pointer identity and lifetime tracking by replacing
> ref_obj_id with id. It introduces virtual references to serve as lifetime
> anchors for objects that share the same lifetime but need distinct identi=
ties,
> such as pointer casts and referenced dynptr clones.
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> [ ... ]
> > @@ -9854,7 +9920,7 @@ static int check_reference_leak(struct bpf_verifi=
er_env *env, bool exception_exi
> >                * kernel. Type checks are performed later in check_retur=
n_code.
> >                */
> >               if (type =3D=3D BPF_PROG_TYPE_STRUCT_OPS && !exception_ex=
it &&
> > -                 reg->ref_obj_id =3D=3D state->refs[i].id)
> > +                 reg->id =3D=3D state->refs[i].id)
> >                       continue;
>
> [Severity: High]
> Will this correctly handle struct_ops programs that return a pointer deri=
ved
> from a virtual reference, such as a casted pointer?
>
> Since a casted pointer in R0 receives a distinct non-reference id while t=
he
> virtual reference ID is stored in its parent_id, checking reg->id against
> state->refs[i].id might fail here.
>
> Could this cause the verifier to incorrectly flag an "Unreleased referenc=
e"
> and reject valid struct_ops programs? Should this check also consider
> reg->parent_id when the reference is virtual?

There is no struct_ops that can return a register derived from a
virtual reference, but to prevent such false positive preemptively,
the condition can be changed to:

              if (type =3D=3D BPF_PROG_TYPE_STRUCT_OPS && !exception_exit &=
&
-                 reg->ref_obj_id =3D=3D state->refs[i].id)
+                 reg->id =3D=3D state->refs[i].id || reg->parent_id =3D=3D
state->refs[i].id)

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519181314.27=
31658-1-ameryhung@gmail.com?part=3D9
