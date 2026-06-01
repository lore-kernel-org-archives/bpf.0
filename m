Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E24311977
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 18:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780339293; cv=none; b=NuYjVGE8njncq4xJ6SaSzdMC/978cH6+5gskMUy5a99jPuvaXqymJG2BiWkfZM5MMFkOfTVqrlWKdep2QeGM7Kdi530rTfunOGy+bjMkxoqKamCgV9fpiOLDTLcu5tnWgNNDayrRRq5mbsNoVPiUUeC9O2/aeahQDZxWitwfees=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780339293; c=relaxed/simple;
	bh=KcYkINV1ZlG0Qamg5wYbsjaqYLLA239Zyfa4DeSP4mo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nYfrmaTp8XN6U1QKeASnWMOXASnRPhLC4BkRlf9hUl4IA5KUVStQL+w1eCSF3W0T5G6QbxEtslBTCqSTPQGksZhx5zqr9Rn18/X5JAMLjqWqSKz+JUN8g23DRghsYh4HHFlpJ+xEZljIdkYbGGdvF4xZ5oAaeGCRwaBZddTx5+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oELoZ0VS; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oELoZ0VS"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-304fb780deaso2662623eec.1
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 11:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780339285; x=1780944085; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T+WC2ug9yq79gIgrEeKHfSxVivYnKgk7AcPEO9gSSXc=;
        b=oELoZ0VSzCm5NMQpByzXUYPn7eTHlbrhv0DLdYXhAaXU8+5c6FXfRhzjXt8iNFxrgI
         DwowpYZee1Davg1lSbiGIHFwl01A2AAhZ5mOk30iIOKEL2TmkE0slyZL7nMwnibVsbtn
         QRz2ZkjLJHE/pTSGnusZJ4wClr51Reixzz0MlNe5HRGSwcUtZS8SZcHFJPVtlRMCTjuQ
         1vHZeF0MnTuH9kpBwyGPzWvUFeKejEXZB8Kurj/ihKDFm0V1OrWjpAKkeWyaFArLnYcd
         eweRcivQDy9SN5ZVq/QVm7+EZdTxBfcai56FUYY3tVjeeBDATX9wJJwXgZj8URaamwge
         q3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780339285; x=1780944085;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+WC2ug9yq79gIgrEeKHfSxVivYnKgk7AcPEO9gSSXc=;
        b=EcKrYUvzvCK5JwlyiaoIvJ3YDM/6LCwIJ+SA8rCp+uCa2vRDsby6m7pQ5HFQlz3mz1
         B0amgsoWLzolZoa4XmGCysmr/cWHESMDuxug7k2bMJ+Upuqrpvu2ZiaY9ArW1BkBEmSM
         JD4ekVIsf24P4T+n3VigQtw/9ixirDcK2bu1ohNCqL6MRt776kRtPZgfCNIs4FBR+bZa
         Kp4CwZZmRO+4PwL/X2GtPwNL4wg0BTu7OpcpenMrwqwHzgShxhobzvrmP+H1Sbss4iW8
         /1lq13H00QNC+1IMWD1yTRIy+kYS+gBfQtZT/RDUHeDt6TkKwKxJBgM04RS3uI5DFGVJ
         7j8g==
X-Gm-Message-State: AOJu0YwWbv7W9LQeM6/YvmVGQbxcysLlX2zP6wlu4b2hvY3qsmeMv88g
	0FBe3ZiIwnq5123qclhBDzmNrT1b6SE8ZZvML7wstwd6CKHkQieV6z5D
X-Gm-Gg: Acq92OH4a9p77VrtQLYnN91uaA7OAC3f6U/iu6VKR+C3l6BvLK3Qh2G3Yxx6sOKt1Vq
	W4iHmNYiRFGnTV7vU9pwJ9IMDVqAK/hJ9J2QmEwTS4WAFI0Ej0WJ2JD9Z2ln/YTXpbw0PX7EykA
	C8esybJae3k4DAJ5nwrPfZ4ko0aljXBCvD6F0tmeOAtcpRIK5avHMD7yoPTpQuZcUiN/fXcYypM
	2G3NeDvPbPHVoZVNgaNqseSrFD6bRl3F0qtKvmGuwNqqvXfCEkgtzjap2oyU1UJM+bAiBPsaRfd
	D5S0sDCyQ34jbiuL/vXIhLjtPHQOKppPpc4nZ/BZ89Cz9ScXJb+YcxTtUBZR06cl1AsRpnybjYY
	3BoS7lpRsGjtQgbj0cCbd0iCKhBNBQa5Ler5QwMRpTZYx+bq4klPzZ5U/tq8FXO821RVw5V/3Y0
	Vz/vCHYVd+MuMYTIP2RveisxtVzEeLALVGiiK47Il2f4xHz5C2LuV+EfgJZ7pXKkvCN7xjN6SBE
	MMzgJzQfRPlbg==
X-Received: by 2002:a05:693c:2c86:b0:2ea:b85c:153d with SMTP id 5a478bee46e88-304fa67b6afmr5705576eec.27.1780339285358;
        Mon, 01 Jun 2026 11:41:25 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:af92:b4b2:3f30:fe90? ([2620:10d:c090:500::96])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2f2904sm9588225eec.9.2026.06.01.11.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 11:41:25 -0700 (PDT)
Message-ID: <37d229e482df3367436d9475d6e9d6d69c7366a5.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 05/13] bpf: Refactor object relationship
 tracking and fix dynptr UAF bug
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, 	andrii@kernel.org, daniel@iogearbox.net,
 memxor@gmail.com, martin.lau@kernel.org, 	mykyta.yatsenko5@gmail.com,
 kernel-team@meta.com
Date: Mon, 01 Jun 2026 11:41:23 -0700
In-Reply-To: <CAMB2axNK9rf12YyLjfeUHWUpGEf=UrCtdHcgd2Tq6KcFY1ergA@mail.gmail.com>
References: <20260529014936.2811085-1-ameryhung@gmail.com>
	 <20260529014936.2811085-6-ameryhung@gmail.com>
	 <1bf1a11fa5dcb38287384833dd77c748f3a766b7.camel@gmail.com>
	 <CAMB2axNK9rf12YyLjfeUHWUpGEf=UrCtdHcgd2Tq6KcFY1ergA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-01 at 11:36 -0700, Amery Hung wrote:
> On Mon, Jun 1, 2026 at 11:00=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Thu, 2026-05-28 at 18:49 -0700, Amery Hung wrote:
> >=20
> > I think refsafe() needs an update.
> >=20
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> >=20
> > [...]
> >=20
> > > diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> > > index 877338136009..5945956a7573 100644
> > > --- a/kernel/bpf/states.c
> > > +++ b/kernel/bpf/states.c
> >=20
> > I think refsafe() needs an update as well.
> > Something like:
> >=20
> >     --- a/kernel/bpf/states.c
> >     +++ b/kernel/bpf/states.c
> >     @@ -886,6 +886,7 @@ static bool refsafe(struct bpf_verifier_state *=
old, struct bpf_verifier_state *c
> >=20
> >             for (i =3D 0; i < old->acquired_refs; i++) {
> >                     if (!check_ids(old->refs[i].id, cur->refs[i].id, id=
map) ||
> >     +                   !check_ids(old->refs[i].parent_id, cur->refs[i]=
.parent_id, idmap) ||
> >                         old->refs[i].type !=3D cur->refs[i].type)
> >                             return false;
> >                     switch (old->refs[i].type) {
> >=20
> > Wdyt?
>=20
> You are right. It needs to compare parent_id, but maybe only for
> REF_TYPE_PTR like below.

check_ids() should handle the case when parent_id is zero correctly,
so I think both variants are fine.

>         for (i =3D 0; i < old->acquired_refs; i++) {
>                 if (!check_ids(old->refs[i].id, cur->refs[i].id, idmap) |=
|
>                     old->refs[i].type !=3D cur->refs[i].type)
>                         return false;
>                 switch (old->refs[i].type) {
> -               case REF_TYPE_PTR:
>                 case REF_TYPE_IRQ:
>                         break;
> +               case REF_TYPE_PTR:
> +                       if (old->refs[i].parent_id !=3D cur->refs[i].pare=
nt_id)
> +                               return false;
> +                       break;
>=20
>=20
> >=20
> > [...]
