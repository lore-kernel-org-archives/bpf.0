Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8153F4DD6
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294493; cv=none; b=Q01z8zWFt5A6Y+6AVuzVDysDJwvm1CUq41BGZo8S8zVMfH748lfKLxT5i84GAWE7GqZJA1Fumi3lO2Ecx4d16Z2VdmHuuk78I6gsjg9IFDS88qG5BhpnhD2jpPi9wBdi1LhjBwqu15wXHbzJkWc69INKoBpwsAp6diJWtEUK4Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294493; c=relaxed/simple;
	bh=ES7YxmPnDFzUUbbeuT/pFvekD4p0hCCj++N15Dr+Ljc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rgErrkskUlx/IeWK8G3vEzEiGGei16Tp9e8A842SAzNZj+Dg1xVETIoTpl8xGDXCAJdPbZZd3NTrZp22L/X5gKD3tBvMyGNIl3v1chmpYK0uIJah9forxGRjqjyF1gLOZR6z6nuDIk7bpPbqKhiSnZZyNr22dRPpZnzxpizQvf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egYmVf9H; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egYmVf9H"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bc763e2ba8so24395195ad.3
        for <bpf@vger.kernel.org>; Wed, 20 May 2026 09:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779294491; x=1779899291; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S/2ozl9sGqUSrHRxDaydNsPYPMwiguh1yPS1e/2sQKI=;
        b=egYmVf9HIvMeT6ih0BgUBj3UIGk+Bvu7b9en7dQAZbMmiCFZzDpgPBwD4sPySGGJcn
         dyf4zRVNpKP4PYG/n08eWnk4rMyWaGxdqiKSGgMwd27ExjykACiWReCizUkvY4ZGeN1J
         8edAozeUpDl7wkXIUqQ2QHB9TEI+9LYT4EQV4WlFwFDvkhTaPc60+Do8YiXtw6cZ2FhH
         Txk63pJoomM7qJ7I37p7PzJEzKugNqnsFi+Jp2imtfeclpJvI3q6zN6yhzUTQ/eLFPfg
         BD4+J2eRWZrpNz2w0OEe8fAsjY8UXsRajU8PBRoEmnhKnAOXjh30zjpMBOutZjGXGX+B
         RyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779294491; x=1779899291;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S/2ozl9sGqUSrHRxDaydNsPYPMwiguh1yPS1e/2sQKI=;
        b=EY3TKQde1IsXyyV8LMJyNBkeYU9HYxJjauLYxTU5qingdDReB/4tB5toT1DyaIesjr
         aREJh0AgnKVtgiCPp5Ud6xyJfOYGeSmLhipr+k/Np7zGKSeb8HJv4JYR8hfBAGs93Q8m
         xbo3ETvpips9Tpmi/2GoCZz/Kydy8/9SIYZqsOgSZ7JUjj3zI4DkZZgq/9GZ0dUVvpdF
         kGSBjqEHcrN6gciV/OCoiaP5hyECdGqvSDV2bvtyrGtUQKMMEMs0o+8V/AdlEoJBFzRv
         O1qKUuEQqYkzoh39+00aIlHRLfjVLJc/FYDrkZV8kSNlnWRlpKlSo+2aiVt6uFMn8M4a
         x2IQ==
X-Gm-Message-State: AOJu0YwR1cqkF85rdx5+FsWcPLdlJy3Ti6/HvMrajguBT92h71tDIbxF
	pvEcHZ4adrP8YhbDCDDe+Gr++GtFnQDR3WA57abMPEXp1gjgVGum41Rm
X-Gm-Gg: Acq92OExNYOvw5w/zkrOZqtr8aGqP7I2ad6lu/cOstA9WqGHgEF+5GWOPLZ8ErJiNGf
	SgnCtzw4SZc0rdC8T2tdDvrKbXi7Hb2YlcoBFF5Cvnnyd6wnpyorFBpO+HOWtaj3GA6buQlaILz
	mLMLb8VwaMzfsMzm+9TUVvvvOjdMka3fDe6Qiq3RvLhTlFRCKBMOKHttK4NLJpVpjnaGenEJG0B
	w6DLr1+0sHTN9zkJ6ow7UwzZ5IhwYuH8Gj8RNcqTwi1bzm3l9X9U1esbL5mw1cjhL8yauILWZXr
	ChbSPtMk0u5P27JuXg3ESz55R7H1Ti0HrlX44kJZdPbgiBJ2X9jMW8PcTe6+QoDoHfasd6dH0EV
	BGd/FEvlpDc1Z2KDkgqcrbloTOIrOFyvWMWUX5VUCqef4mDA3S3qvJGIdfDIMOou1tUtxir4p61
	1qYbjan4eFPME1y7GLA2l4+f9f4SWPdfMqL1sdo94IoGTMhZrVnq6VbgEHzUaghiU=
X-Received: by 2002:a17:903:907:b0:2b0:5ae9:ee4 with SMTP id d9443c01a7336-2bd7e8ae548mr266212465ad.5.1779294490473;
        Wed, 20 May 2026 09:28:10 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d0f94c6sm228572925ad.56.2026.05.20.09.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 09:28:10 -0700 (PDT)
Message-ID: <c7d7e50f458fd11c9a9172d01714cec1d80eb435.camel@gmail.com>
Subject: Re: [PATCH RESEND bpf-next v10 2/8] bpf: clear list node owner and
 unlink before drop
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kaitao Cheng <kaitao.cheng@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, ast@kernel.org, 
	memxor@gmail.com, corbet@lwn.net, martin.lau@linux.dev,
 daniel@iogearbox.net, 	andrii@kernel.org, song@kernel.org,
 yonghong.song@linux.dev, 	john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, 	jolsa@kernel.org, shuah@kernel.org,
 chengkaitao@kylinos.cn, 	skhan@linuxfoundation.org, vmalik@redhat.com,
 linux-kselftest@vger.kernel.org, 	martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev, 	bot+bpf-ci@kernel.org
Date: Wed, 20 May 2026 09:28:02 -0700
In-Reply-To: <47b928ac-25d9-481c-8764-8f840c2dcafa@linux.dev>
References: <20260512055919.95716-3-kaitao.cheng@linux.dev>
	 <da95f45b43d94d17796b19abc4c555e35daafab7d5e1cdca3714fe0f54ab8cce@mail.kernel.org>
	 <e141699dab70282d811ec30bbf2aa8279706817b.camel@gmail.com>
	 <DII0TT9LXYCX.2GMM6QA4Q9BPZ@gmail.com>
	 <0fb2d99b-b122-44fa-a8bc-9befe6e350bc@linux.dev>
	 <7fa6794161a8bd4fdbc21dad68e86e9770c873cc.camel@gmail.com>
	 <0171629c-bdd3-4661-a4e6-2698dd623c3a@linux.dev>
	 <d5961282-d41c-4e54-8ba2-cd08823a8c77@linux.dev>
	 <782833db5da77e4aa9761fc410827e7abe8583c8.camel@gmail.com>
	 <47b928ac-25d9-481c-8764-8f840c2dcafa@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-05-20 at 17:55 +0800, Kaitao Cheng wrote:
> =E5=9C=A8 2026/5/20 06:56, Eduard Zingerman =E5=86=99=E9=81=93:
> > On Mon, 2026-05-18 at 11:02 +0800, Kaitao Cheng wrote:
> >=20
> > [...]
> >=20
> > > > > > The patch does have a bug, however. To fix the issues we are se=
eing now,
> > > > > > I propose the additional changes below and would appreciate fee=
dback.
> > > > > >=20
> > > > > > --- a/kernel/bpf/helpers.c
> > > > > > +++ b/kernel/bpf/helpers.c
> > > > > > @@ -2263,8 +2263,10 @@ void bpf_list_head_free(const struct btf=
_field *field, void *list_head,
> > > > > >         if (!head->next || list_empty(head))
> > > > > >                 goto unlock;
> > > > > >         list_for_each_safe(pos, n, head) {
> > > > > > -               WRITE_ONCE(container_of(pos,
> > > > > > -                       struct bpf_list_node_kern, list_head)->=
owner, NULL);
> > > > > > +               struct bpf_list_node_kern *node;
> > > > > > +
> > > > > > +               node =3D container_of(pos, struct bpf_list_node=
_kern, list_head);
> > > > > > +               WRITE_ONCE(node->owner, BPF_PTR_POISON);
> > > > > >                 list_move_tail(pos, &drain);
> > > > > >         }
> > > > > >  unlock:
> > > > > > @@ -2272,8 +2274,12 @@ void bpf_list_head_free(const struct btf=
_field *field, void *list_head,
> > > > > >         __bpf_spin_unlock_irqrestore(spin_lock);
> > > > > >=20
> > > > > >         while (!list_empty(&drain)) {
> > > > > > +               struct bpf_list_node_kern *node;
> > > > > > +
> > > > > >                 pos =3D drain.next;
> > > > > > +               node =3D container_of(pos, struct bpf_list_node=
_kern, list_head);
> > > > > >                 list_del_init(pos);
> > > > > > +               WRITE_ONCE(node->owner, NULL);
> >=20
> > Is CPU allowed to reorder the stores in list_del_init() and WRITE_ONCE(=
)?
> > If it is, I think there is a race here.
>=20
> Thanks for taking a close look at this. You are right that there is an
> ordering issue here, but I don't think the specific sequence illustrated
> by the example below is problematic.
>=20
> > Thread #1:
> >   enter bpf_list_head_free()
> >   acquire H1 lock
> >   list_move_tail(pos, &drain);             // reordered
> >   <-- ip here -->
> >   WRITE_ONCE(node->owner, BPF_PTR_POISON); // reordered
> >=20
> > Thread #2:
> >=20
> >   acquire H1 lock
> >   n =3D bpf_refcount_acquire()
> >   release H1 lock
> >   acquire H2 lock
> >   enter __bpf_list_add()
> >   <-- ip here -->
> >   cmpxchg(&node->owner, NULL, BPF_PTR_POISON)
>=20
> Even if the stores from list_move_tail(pos, &drain) become visible before
> WRITE_ONCE(node->owner, BPF_PTR_POISON), node->owner is not NULL in that
> window. Before the WRITE_ONCE(), it still points to H1. After the WRITE_O=
NCE(),
> it is BPF_PTR_POISON. In both cases, __bpf_list_add() will fail:
>=20
> 	cmpxchg(&node->owner, NULL, BPF_PTR_POISON)
>=20
> because the old value is neither NULL nor expected to become NULL from th=
is
> part of bpf_list_head_free().
>=20
>=20
> However, I agree that your original concern about the ordering between
> list_del_init() and WRITE_ONCE(node->owner, NULL) is valid for the later
> drain loop:
>=20
> 	list_del_init(pos);
> 	WRITE_ONCE(node->owner, NULL);
>=20
> Here owner =3D=3D NULL is the signal that the node can be inserted into a=
nother
> list. Since WRITE_ONCE() does not provide release ordering, another CPU m=
ay
> observe owner =3D=3D NULL and successfully acquire the node in __bpf_list=
_add()
> before the list_del_init() stores are visible. In that case __bpf_list_ad=
d()
> can link the node into H2, and the delayed stores from list_del_init() ma=
y
> then overwrite the node's list pointers and corrupt the H2 list.
>=20
> So the fix should be to publish owner =3D=3D NULL with release ordering a=
fter the
> node has been fully unlinked, for example:
>=20
> ```
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2279,7 +2279,8 @@ void bpf_list_head_free(const struct btf_field *fie=
ld, void *list_head,
>                 pos =3D drain.next;
>                 node =3D container_of(pos, struct bpf_list_node_kern, lis=
t_head);
>                 list_del_init(pos);
> -               WRITE_ONCE(node->owner, NULL);
> +               /* Ensure __bpf_list_add() sees the node as unlinked. */
> +               smp_store_release(&node->owner, NULL);
>                 /* The contained type can also have resources, including =
a
>                  * bpf_list_head which needs to be freed.
>                  */
> @@ -2607,7 +2608,8 @@ static struct bpf_list_node *__bpf_list_del(struct =
bpf_list_head *head,
>                 return NULL;
>=20
>         list_del_init(n);
> -       WRITE_ONCE(node->owner, NULL);
> +       /* Ensure __bpf_list_add() sees the node as unlinked. */
> +       smp_store_release(&node->owner, NULL);
>         return (struct bpf_list_node *)n;
>  }
> ```
>=20
> The existing cmpxchg() in __bpf_list_add() is a successful RMW with retur=
n
> value, so it is fully ordered and is sufficient on the acquire side.

Hi Kaitao,

Thank you for the analysis. I agree with the smp_store_release()
approach, could you please respin the series?
