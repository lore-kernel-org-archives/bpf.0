Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D045F3F1679
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158385; cv=pass; b=bpj0xsc4PH1iHEISvvbH2Pmk7/mDyt0UefUsm4toysGVX2xCyTmHxlNSXVo+e/loh2f+lTrXsIxtD2PzCcxRho29A9ViYICB1sgiloz/aCSF/zs/wKZo42IyqcE9m5SQhoX6gdsy97T6M+K9pawvwb5V2I0/+82r8tBMqFFUl0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158385; c=relaxed/simple;
	bh=x82l6NaRoY/SIZgBDU99w/LVd7FiucMtpTcSpiO2/1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4WmoDS1IrfxpPHC33c+MtH+YKsX8rXnCyRd3LV6tDZTnRcSD+iEtj+Rt/R4zXhRzbYIXH5Dery8q75E92zlW93U0UdbGKPtg6Xsjw6tSDeniQWm9KSJTf/O5zNknT5glX7AP0c+iXAGwYrCR4TYPIsvM4ew7E6RnpdnZ/nKp8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKC3/A8v; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKC3/A8v"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7bd9f61458eso5980637b3.0
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 05:53:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778158381; cv=none;
        d=google.com; s=arc-20240605;
        b=HKBX6Jwl5NRJVWKpNmIiGDzHrystaE5rDCrHp3rUD92NEIujPUPOnpZfLCli5sE7Os
         phWc8M9bG587r7V07pf94zHzsPm3pSkyXKo4Ycn44HnP0tpP+ksjwnaj8PAujElmAOC6
         TAUXmcZ2TGivDMsJER70fE9aA3ePC7n6WnejOjz09OrmCtJm/MxHLqRwAkq0WYXHpzGf
         8WG+B7Urb2OrarLzbPwSK0gb3KppXz4iai9uiWRZr+7LNWTGwseHT1Gwk8H+dRYbK8X/
         irm/RRmBvELkwZcKrQS9svcW1Qfwj4o50Uu+5elL9HCKRj7V+BicwdOhscS+ZBV2JQBM
         pjPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PrmNq2ynRuCEdYKNPCryM4xNScgxSx9BUckn5/WYdnM=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=FGPoNIM67k4REBtKsccj93y15niOr3ackb+YMWo5UJlm89TyHSYeYee4buveJ6DYFZ
         1zxvONm36lfByLhKTVUmVw5qPPb0wYlk1wKeubMAcFuD9FimZFAlUTuyD8GkLIW6Pfem
         n24yCTtsQrLGDFHcG8Ms11xDhQNAe2kK4dIv1Aaqy+xxva6HRHYr9BRSoDYsKcToXUw8
         r0KvC7ie165ceaHnGhP+mZfEbVxFO5RODhoh3LO8A41iI1y6ubFZ7s7q7s//Y7azeecE
         R/3wA6nIbllw/0K2IK4tZy97ecaXt6rF9xoW0jlFL+nDH2qYbClHaOQeO6hZUlLUXZqR
         dawA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778158381; x=1778763181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrmNq2ynRuCEdYKNPCryM4xNScgxSx9BUckn5/WYdnM=;
        b=fKC3/A8vpys1DezFe3N9dQXGE4mUhwz5KNr+8xP8qC8uWK8MHxL3iwiZqlcCDFygIx
         cvIIzTB1y7jIgZfTMzs5oHhy2VSyZVkd0EL2NEogXDRIC2c8iBtnhd8X1pRc+gWiMVVl
         vqV0jHL6QBH2Ued31XN7MjHZV13BF9RU5FyDWPlqiZA2gsnQ+fYI1AVk/aXms+K5ZLw8
         xpANYH2x9v9EQ1TVaWuFJ540WhuXTH5xgnvvBoZX7WMeAoT//DBMMpU5ae/6DJydqnET
         p92VmSj+zoXk5AiTYdoY+EbSlgv9kKAwwOI8NJ1L0N/nCJS8ERwF7Zbi0HyqZLwSlbMv
         dXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778158381; x=1778763181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PrmNq2ynRuCEdYKNPCryM4xNScgxSx9BUckn5/WYdnM=;
        b=Rox+AXBfDuJlB2OsJmbs3nmVoXNVXHCroGDVDF59Al1aKsSoZeQ0bAZuiSB36ii7uv
         JucauZbAFu5Xt8B0vIOWzj2jSRvtb3l9IRKXLHCAWfwNXmrFEhG8bTpgH9yj3UMKnRHF
         24xPFMS/wJKKZ6tS0SSZq+ixdnDNJOWjiPs/xqzfu3sR5wCJYIvRU7Pk/NWDcWgrEXvI
         RQvXClE+XPg4qx3FhbHdHJnVOCSZ/641DL8alJdm49EsnQrVj132pBj5d5ds9VBgUVgW
         7Z2X0Qb3Bm+AWIxOOMc9WvhRH6kTd6Cr5MmakzZZfBoeQNX/kC/1JbynlXc75SlhI12N
         JUQw==
X-Gm-Message-State: AOJu0YylKbk9PEjhXk8p/s7mvEKMi7e90Ig/X8MKCAqvDPtJ2YztV+yf
	gCseYccHCNPnS7/kBpyMAWLyFs2bWEEuR260/zG/yKlAFxXK6fWLV0nnOmbHWP+V2xAAAJBWNXt
	nhkHcF9Mf2UwIqKaZUZr4iDO2IRALpAbK4lChpYg=
X-Gm-Gg: Acq92OETqLUwzZ7PyGntENdrOu1Izo4uSSJzkIhTGDmb0bNSYFwhiNFEPo3/bgqLk2o
	3YVIGNoagD9z1APiIV6haDTu/TkybGk6Cr8SN4/1fQ8Kgg0FS0OAseNOclVaVI0dAxX0giELk69
	0qYVMEuIJdOWGGMr9sPjoT+BIqT/ip+JKJJn5pWxzJQH/lmgNM/O+6M/tS1jBKbug6hJ3YBXu5c
	1ZCWbnzqPhujjniiX9qbNCOceGlYExIQfPlZHjeJewv0zHO/zRTjY+CZzDaGRYdmOlvb0dP+/Nm
	11nREqDctTA0lNEyFNk=
X-Received: by 2002:a05:690c:8e14:b0:7bd:7c16:170e with SMTP id
 00721157ae682-7bdf5dfcaf5mr71836127b3.22.1778158381112; Thu, 07 May 2026
 05:53:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506142709.2298255-6-ameryhung@gmail.com> <20260506215438.45B98C2BCB0@smtp.kernel.org>
In-Reply-To: <20260506215438.45B98C2BCB0@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 7 May 2026 14:52:49 +0200
X-Gm-Features: AVHnY4I8dLh_GNOSbdb9n4dj8p957fKTD6_O6e-_45ZqHDnU2U17zK6YoYBLQic
Message-ID: <CAMB2axO5ubguhhGTVRZ60odvHLHgyc+YggeiD8Fe7KDyP32YfA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 05/12] bpf: Refactor object relationship
 tracking and fix dynptr UAF bug
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 10:54=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Critical] Dynptrs constructed from referenced objects are assigned a `=
parent_id` of 0, breaking cascading invalidation and leading to Use-After-F=
ree.
> --
>
> commit 5c82adaba693d44fcc105cb9d8d86e76a67e2a64
> Author: Amery Hung <ameryhung@gmail.com>
>
> bpf: Refactor object relationship tracking and fix dynptr UAF bug
>
> This commit refactors verifier object relationship tracking by replacing
> the PTR_TO_MEM-specific dynptr_id with a general parent_id in bpf_reg_sta=
te.
> It updates release_reference() to use a DFS approach for cascading
> invalidation when parent objects are freed.
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> [ ... ]
> > @@ -11804,15 +11810,10 @@ static int check_kfunc_args(struct bpf_verifi=
er_env *env, struct bpf_kfunc_call_
> >                               }
> >
> >                               dynptr_arg_type |=3D (unsigned int)get_dy=
nptr_type_flag(parent_type);
> >                       }
> >
> >                       ret =3D process_dynptr_func(env, reg, argno, insn=
_idx, dynptr_arg_type,
> > -                                               clone_ref_obj_id, &meta=
->dynptr);
> > +                                               meta->ref_obj_id ? meta=
->id : 0, &meta->dynptr);
>
> Does this code assign 0 to the dynptr's parent_id instead of the actual
> parent's ID?

Yes. In this case, the parent is not a referenced object, so tracking
is unnecessary.

While we can track parent_id unconditionally, we should avoid doing it
now until every obj, referenced or not, has an id. Otherwise, it
becomes hard to reason where the parent_id is valid or not.

I will clarify this in parent_id's comment:
parent_id is only tracked when the parent object is referenced or is dynptr=
.

Although for a slice derived from a non-referenced dynptr, we don't
need to track the parent (allowing it to be accessed even when the
dynptr stack slot is destroyed). The slice should be destroyed when
the parent dynptr is destroyed in the dyntpr's mental model.

>
> For referenced objects acquired with PTR_MAYBE_NULL, the BPF program must
> perform a NULL check before passing the pointer to the constructor. Upon =
a
> successful NULL check, the verifier clears reg->id to 0 while preserving
> reg->ref_obj_id.

Not any more. See patch 4. Hence the following comments can be ignored.

>
> Consequently, meta->id appears to be unconditionally 0 when the dynptr is
> constructed here.
>
> When the parent object is subsequently released, the DFS traversal in
> release_reference() searches for descendants matching reg->parent_id =3D=
=3D id.
> Because the dynptr's parent_id was initialized to 0, does this cause the
> dynptr to evade invalidation and remain fully active, leading to a
> use-after-free regression?
>
> Should this pass meta->ref_obj_id instead of meta->id?
>
> >                       if (ret < 0)
> >                               return ret;
> >                       break;
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506142709.22=
98255-1-ameryhung@gmail.com?part=3D5
