Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD0B38BDAA
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 02:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769049705; cv=none; b=Cza92UJXW8+Cfx/1jXF6X76b0akgFH4F4MD2SRCVLP/ZbpVD9M37wEWCs0NBu0ygODUg1TEmHk0y7hI1HfCcNC3b4bwPTkC5fsNe+RgR+QeaLXEGW43f4LtldcmtDEoSEjoR0GmNhZmT+JUcc8H2Xgbnw+YgVJ728lZ1ewksQB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769049705; c=relaxed/simple;
	bh=PPIRfhsObAkcW33f+gZJWm44KZAjxYqIRZTHnqcd1mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NRBsw6/+NGMvU1bgrKoR1gxJiXy+LwhGpdUKTWdFDWD/NdJCK9qgurWkYrg+WObtRWuPXQqQx9FTruS/Ubeky4CRk69X5tEpGihx/wsHpFgHd80qvlI48Z+vbt7jpPsfswPrf94sPCfv65bHLbofdj3YG94mQHiwelKR5XRFUZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HSkXtBgx; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HSkXtBgx"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769049684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PRZGbegubvTtb9X2xIuQVHiTp3mLxqiBK8qzoGNvCYg=;
	b=HSkXtBgxBqnteiND5xUaLE6W3EMbrOuDTogxB3fkCBwpLL6ZAm4p82W3nU1LJWwS+j4WCd
	vVRVrAsBzbPQq54I1cdmku3CTr+k30OOenm5E3CHXQQJDASVM8d8kSS07dFX34/xRllvgK
	VBZ6eusEmoH3RNv/BzCUbWaWkNK0XkE=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v10 07/12] bpf,x86: add fsession support for x86_64
Date: Thu, 22 Jan 2026 10:41:04 +0800
Message-ID: <3026367.e9J7NaK4W3@7940hx>
In-Reply-To:
 <CAEf4BzZm5uenrYO3ZXiGB8qXCg67Ov7crNvZtsj=Be4XEm6OpQ@mail.gmail.com>
References:
 <20260115112246.221082-1-dongml2@chinatelecom.cn>
 <CAEf4BzYop1GT1v7qxNQi44dsEebjwnLp-sHDp-HPzVrj69WzTw@mail.gmail.com>
 <CAEf4BzZm5uenrYO3ZXiGB8qXCg67Ov7crNvZtsj=Be4XEm6OpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/22 08:22 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> On Wed, Jan 21, 2026 at 4:06=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Jan 15, 2026 at 3:24=E2=80=AFAM Menglong Dong <menglong8.dong@g=
mail.com> wrote:
> > >
> > > Add BPF_TRACE_FSESSION supporting to x86_64, including:
> > >
> > > 1. clear the return value in the stack before fentry to make the fent=
ry
> > >    of the fsession can only get 0 with bpf_get_func_ret().
> > >
> > > 2. clear all the session cookies' value in the stack.
> > >
> > > 2. store the index of the cookie to ctx[-1] before the calling to fse=
ssion
> > >
> > > 3. store the "is_return" flag to ctx[-1] before the calling to fexit =
of
> > >    the fsession.
> > >
> > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
> > > Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> > > ---
> > > v10:
> > > - use "|" for func_meta instead of "+"
> > > - pass the "func_meta_off" to invoke_bpf() explicitly, instead of
> > >   computing it with "stack_size + 8"
> > > - pass the "cookie_off" to invoke_bpf() instead of computing the curr=
ent
> > >   cookie index with "func_meta"
> > >
> > > v5:
> > > - add the variable "func_meta"
> > > - define cookie_off in a new line
> > >
> > > v4:
> > > - some adjustment to the 1st patch, such as we get the fsession prog =
from
> > >   fentry and fexit hlist
> > > - remove the supporting of skipping fexit with fentry return non-zero
> > >
> > > v2:
> > > - add session cookie support
> > > - add the session stuff after return value, instead of before nr_args
> > > ---
> > >  arch/x86/net/bpf_jit_comp.c | 52 ++++++++++++++++++++++++++++-------=
=2D-
> > >  1 file changed, 40 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > > index 2f31331955b5..16720f2be16c 100644
> > > --- a/arch/x86/net/bpf_jit_comp.c
> > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > @@ -3094,13 +3094,19 @@ static int emit_cond_near_jump(u8 **pprog, vo=
id *func, void *ip, u8 jmp_cond)
> > >
> > >  static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
> > >                       struct bpf_tramp_links *tl, int stack_size,
> > > -                     int run_ctx_off, bool save_ret,
> > > -                     void *image, void *rw_image)
> > > +                     int run_ctx_off, int func_meta_off, bool save_r=
et,
> > > +                     void *image, void *rw_image, u64 func_meta,
> > > +                     int cookie_off)
> > >  {
> > > -       int i;
> > > +       int i, cur_cookie =3D (cookie_off - stack_size) / 8;
> >
> > not sure why you went with passing cookie_off and then calculating,
> > effectively, cookie count out of that?... why not pass cookie count
> > directly then? it's minor, but just seems like a weird choice here,
> > tbh

Hi, Andrii. I think you misunderstand it here. The cur_cookie is not the
same as cookie count. The layout of the stack looks like this:

  return value  -> 8 bytes
  argN          -> 8 bytes
  ...
  arg1          -> 8 bytes
  nr_args       -> 8 bytes
  ip (optional) -> 8 bytes
  cookie2       -> 8 bytes
  cookie1       -> 8 bytes

So if the bpf_get_func_ip() not used, the cur_cookie is exactly the same
as cookie count. But if it exist, they are not the same.

The location of the cookies is independent from the context, and the
cur_cookie, which is the index of the current cookie, don't rely on cookie
count too and can be bigger than cookie count.

PS: the location of "ip" should always laid before the nr_args, as we get
it with ctx[-2]. Maybe we can optimize it later. We store the index of
the ip the func_meta too, therefore it is independent from the ctx too.
Ah, it looks not make much sense ;)

> >
>=20
> consider also just calculating cookie count out from bpf_tramp_links?
> would that work? Then "func_meta" would really be just nr_args (and
> I'd call it that) and bool for whether this is entry or exit
> invokation (for IS_RETURN bit, and maybe we'll need this distinction
> somewhere else in the future), and then invoke_bpf() will construct
> func_meta from scratch.
>=20
> It's relatively minor thing, but as I mentioned before, it's this
> hybrid approach of partially opaque (from invoke_bpf's POV) func_meta
> which we also adjust or fill out (for cookie index) is a bit of a sign
> that this is not a proper interface.

Yeah, the current approach is indeed not perfect. But I think it's
a little not flex if we construct the whole func_meta in invoke_bpf().
=46or now, we need to pass nr_args, is_return, cookie_off to it. And
we need to add more function arguments to invoke_bpf() if there
are new flags occur in the feature, which is not convenient, right?

So what do you think?

Thanks!
Menglong Dong

>=20
> >
> >
> > >         u8 *prog =3D *pprog;
> > >
> > >         for (i =3D 0; i < tl->nr_links; i++) {
> > > +               if (tl->links[i]->link.prog->call_session_cookie) {
> > > +                       emit_store_stack_imm64(&prog, BPF_REG_0, -fun=
c_meta_off,
> > > +                                              func_meta | (cur_cooki=
e << BPF_TRAMP_SHIFT_COOKIE));
> > > +                       cur_cookie--;
> > > +               }
> > >                 if (invoke_bpf_prog(m, &prog, tl->links[i], stack_siz=
e,
> > >                                     run_ctx_off, save_ret, image, rw_=
image))
> > >                         return -EINVAL;
> >
> > [...]
>=20




