Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8642915ADB4
	for <bpf@vger.kernel.org>; Sun, 22 Feb 2026 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771769774; cv=none; b=Dc/CEzNGdc7DrjwiPs21Zjvtek+3eixMoi2qD4zmqWskwL69upxeYXleWQRZ1AKHrUE1KT+Jlu4ijVY4JJiMSNxtY+YPZAchc3xpREIZNvbVXwvQdIMBgcLrFLOMr4Q1tBn/3WQOGl7snfbzHII6F7d70gIKgQVnJTvtkRftzA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771769774; c=relaxed/simple;
	bh=P6+x2JCI0XgY8eTiHkzC1Ih09fcwNts0YCHdq7vCkUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HpAThU3PZ6ixa+fKUGpjysce0Fsg10iPCJ09+HGRwGmNUZtZL06MGiJvcEgogf4vqrzcjIj3xHhVRc0IzADKZRfroiAK9rzgEvXvdNtg5hQQuVcfx6CPzkZvZhHLTbUBlrxonqAT+oFLhqucm0+FjxQgvLvCznRZK+OQuJCoJkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jRksPRRn; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jRksPRRn"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771769760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JTcE7cImlUfDma6jCiahvSoAx7rEh3DKwZ/3MHwndRc=;
	b=jRksPRRn+1bSynHR/MMSvRzbVCzPTKdbEDNUA6pUfmmleMjh6YH9/YgaPy1uP6a2G70mw8
	2EheG+xd43rgG3/l4uKXxgXD6TfkUv5Uy5Kasw3KEbZpENdsjUYkYqAQbxsq3j3SNmDTQf
	e9Qx4Ki9cLfiNPq/aEO5yFRy01PJN9o=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] libbpf: skip compat check for session kfuncs
Date: Sun, 22 Feb 2026 18:59:47 +0800
Message-ID: <5968554.DvuYhMxLoT@7950hx>
In-Reply-To:
 <CAEf4Bzb6ay+gLD0gqZ8j8-=9onZE396YQmyGX-ZLELqF73iDGA@mail.gmail.com>
References:
 <20260211125737.1315848-1-dongml2@chinatelecom.cn>
 <CAEf4Bzb6ay+gLD0gqZ8j8-=9onZE396YQmyGX-ZLELqF73iDGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/2/12 01:20, Andrii Nakryiko wrote:
> On Wed, Feb 11, 2026 at 4:57=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > The function prototype of bpf_session_{cookie,is_return} is changed in
> > the commit 8fe4dc4f6456 ("bpf: change prototype of
> > bpf_session_{cookie,is_return}"), which is not friendly to the old kern=
el,
> > as the libbpf will fail on the compatible checking.
> >
> > Therefore, let's skip the checking of bpf_session_{cookie,is_return} in
> > libbpf, and just let the kernel do the checking.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  tools/lib/bpf/libbpf.c | 31 ++++++++++++++++++++-----------
> >  1 file changed, 20 insertions(+), 11 deletions(-)
> >
>=20
> This is not the way. Use bpf_ksym_exists() check and have custom
> legacy bpf_session_cookie___legacy() definition with old prototype.
> You can then detect whether
> bpf_ksym_exists(bpf_session_cookie___legacy) is true and use the
> legacy version, otherwise use the current version.

Great! I found that there are already similar usages in kernel.
I did some tests, and it works well. Thanks!

BTW, do you think that if we need do some wrapper for bpf_session_{cookie,i=
s_return}
like this in case that someone else don't know the compatible problem?

extern bool bpf_session_is_return___legacy(void) __weak __ksym;
extern __u64 *bpf_session_cookie___legacy(void) __weak __ksym;


#define bpf_session_is_return(ctx)								\
	(bpf_ksym_exists(bpf_session_is_return___legacy) ? bpf_session_is_return__=
_legacy() :	\
							   bpf_session_is_return(ctx))
#define bpf_session_cookie(ctx)								\
	(bpf_ksym_exists(bpf_session_cookie___legacy) ? bpf_session_cookie___legac=
y() :	\
							bpf_session_cookie(ctx))

Thanks!
Menglong Dong

>=20
> pw-bot: cr
>=20
>=20
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 0c8bf0b5cce4..71bdd1c1ac39 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -8557,6 +8557,12 @@ static int find_ksym_btf_id(struct bpf_object *o=
bj, const char *ksym_name,
> >         return id;
> >  }
> >
> > +static bool kfunc_skip_compat_check(const char *name)
> > +{
> > +       return name && (strcmp(name, "bpf_session_cookie") =3D=3D 0 ||
> > +                       strcmp(name, "bpf_session_is_return") =3D=3D 0);
> > +}
> > +
> >  static int bpf_object__resolve_ksym_var_btf_id(struct bpf_object *obj,
> >                                                struct extern_desc *ext)
> >  {
> > @@ -8617,12 +8623,13 @@ static int bpf_object__resolve_ksym_func_btf_id=
(struct bpf_object *obj,
> >         struct module_btf *mod_btf =3D NULL;
> >         const struct btf_type *kern_func;
> >         struct btf *kern_btf =3D NULL;
> > +       const char *kfunc_name;
> >         int ret;
> >
> >         local_func_proto_id =3D ext->ksym.type_id;
> >
> > -       kfunc_id =3D find_ksym_btf_id(obj, ext->essent_name ?: ext->nam=
e, BTF_KIND_FUNC, &kern_btf,
> > -                                   &mod_btf);
> > +       kfunc_name =3D ext->essent_name ?: ext->name;
> > +       kfunc_id =3D find_ksym_btf_id(obj, kfunc_name, BTF_KIND_FUNC, &=
kern_btf, &mod_btf);
> >         if (kfunc_id < 0) {
> >                 if (kfunc_id =3D=3D -ESRCH && ext->is_weak)
> >                         return 0;
> > @@ -8634,16 +8641,18 @@ static int bpf_object__resolve_ksym_func_btf_id=
(struct bpf_object *obj,
> >         kern_func =3D btf__type_by_id(kern_btf, kfunc_id);
> >         kfunc_proto_id =3D kern_func->type;
> >
> > -       ret =3D bpf_core_types_are_compat(obj->btf, local_func_proto_id,
> > -                                       kern_btf, kfunc_proto_id);
> > -       if (ret <=3D 0) {
> > -               if (ext->is_weak)
> > -                       return 0;
> > +       if (!kfunc_skip_compat_check(kfunc_name)) {
> > +               ret =3D bpf_core_types_are_compat(obj->btf, local_func_=
proto_id,
> > +                                               kern_btf, kfunc_proto_i=
d);
> > +               if (ret <=3D 0) {
> > +                       if (ext->is_weak)
> > +                               return 0;
> >
> > -               pr_warn("extern (func ksym) '%s': func_proto [%d] incom=
patible with %s [%d]\n",
> > -                       ext->name, local_func_proto_id,
> > -                       mod_btf ? mod_btf->name : "vmlinux", kfunc_prot=
o_id);
> > -               return -EINVAL;
> > +                       pr_warn("extern (func ksym) '%s': func_proto [%=
d] incompatible with %s [%d]\n",
> > +                               ext->name, local_func_proto_id,
> > +                               mod_btf ? mod_btf->name : "vmlinux", kf=
unc_proto_id);
> > +                       return -EINVAL;
> > +               }
> >         }
> >
> >         /* set index for module BTF fd in fd_array, if unset */
> > --
> > 2.53.0
> >
>=20
>=20




