Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC3B3A3804
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 23:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773270947; cv=pass; b=A+VFIfcESNJaLUapnPaS70jAXHQ+yaHcRrSo2LPZemOA474FoOkG761GGzVEFXmhWb9TJ34l8LaKzh8kSI4d0ikEjXx/9gfolaXtYpo50JWfrswBOS1PswVuNQwJrqj7aBihfiQDELG9JeO73gI64OE6sDeUoIaoy17gZTFEZh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773270947; c=relaxed/simple;
	bh=nSmnfI47vHMiBpFxxOG/S59YEPeHsgHRJ9Mzsi8WylA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fE6rCEp5rTJOahH1Rs6CCO68g87zbMkPp5zV0dWWbhEZ9lDAH+szqz4V3HNBxyCei1znMeH1C8hXLzqZz6D4moUsPKRcbnrZ6Y96wGsEBa4+ZeOCS7MjxJPKZkuI87gQq6yhARamWB2MXPfx7FBJMCqwdsJROtGwrJ4YJuv2F20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGkxeh4T; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGkxeh4T"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35a04d6aeb0so229381a91.0
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 16:15:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773270944; cv=none;
        d=google.com; s=arc-20240605;
        b=aPyWUvX9HIHtL4kctwgPr5TrALNn2sTr4cboHpLIKc2eL0sZ+g1H/vQO9mT2oa4FrL
         XytFBol/sLlfjqnf6/ktYdJtcmlsdXiAFqBRQkyNsbTxLpBLJ2PG7DndXdsy/bw3RwS/
         nwWE7aihmSJCQGJz2hzzgt9Ig/bBTjpPGEIXde5ixw5oFRnPC37Iwc6fhHsJy5+FSoVt
         wJw24Mlr2TfsDe8Nn7hLqwpFRfDjabyhbZ2YnEgUwLW+IydkHCuS3F0awc1w/ZV6GbUk
         CnjWeSYY51stY+yPa8pe2GChrKCv78N3vNYITD1VmmHKS7egdLQMkyjopL0iiOpZwLYt
         Ay/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M6+PvKVMOamsJ/SoYC181vL7TcbAdXReF8gR1dckpDs=;
        fh=HFezYODqB0dHS8ZckTal1iiWnuisbLhk4gui7Bi0T/g=;
        b=Xry2P9ySXUzOZwsy8rj1d5VpVsIGMaMO+xZfrHG+t/8sXoz/P/VG7bTJccDg/0ogG3
         KQFCh/S8+pggWfgv9lWbX56KoR2G/57rNyAT9hVpq4qc+dNPlYRkDYYlS0Knjy2SICTG
         Sv7BKr41aSjm6INHnn7/7E45EhqhrmCsYTt9T+xuksAQZw0D+aoJnNaaiSEnj0BMbKgY
         YvqToOE04P73MYg2sm1SqAoXoQUbOmlw5DloQ1alk8eROrFpXzJYXl74C+05LlKX0zFi
         HDCMBIaX8Us1YpfDBT0r6IO3h+JdiO38TO3XZSJzW0i+e5EiTxHUzbJyFE1qzTpNbMhr
         IymQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773270944; x=1773875744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6+PvKVMOamsJ/SoYC181vL7TcbAdXReF8gR1dckpDs=;
        b=CGkxeh4T3t9ZJRyXBdBVLUESXBqWBHYQv5lJhfc2Ln+pe1XBl61OAEbsCLAPWENXXC
         G+y4lxGVV/6obXb4IPwJ5iPQvz+F4jaVY12jdfy6q8IvVrykllAkj5HoIP7zoiuDLeJV
         TCVZ0rnakCHJcsHPDp0LaluSFOxDj10WHrsrGXKW5MxXzDVoaVDx8sPa4Y9cnlO5cwjE
         gkBjtuxf2ATK47JKlWvrKIqrd3LLiq9A7rLMwhfmfPL8MEAlnHb+UOpkklvA1QIY1R7S
         /QgnqpCRlxcmCgiW0JX1nTVY0+wjbC1meGgCUefDcA3MAuPrLcogSVr/H44oR/0oLYPY
         j8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773270944; x=1773875744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M6+PvKVMOamsJ/SoYC181vL7TcbAdXReF8gR1dckpDs=;
        b=vr1U1Q5tn33MTADI4+zQbuTvouO3Tnwuj4vrEnkhqOzwe4haXo0sHNBDUGppoW+ECz
         qbCX2pScmiUNsnTyUWrOi9ea8kEQTtRP7UAUPvM8HB7B+hVwGeom8q05bsqiRxG6sDOK
         N0btR1OhsTZJcDh9e6GFpbjW/Z3Ao4kUMSV3Nf+iyTiFs8LInIGSi1nROVxw0SZ1iyyM
         Amq0SLGOpX+UUf0/MxnQofOBatcsZymhiQs4mUQ+psVnlpd2JFFWN1PMMm8EUsRjDdrP
         JlQ/R74wPCHRGLk6DJX4RTBRMH3ivCXIkNgTQgexlEqwoYe2uVwf/x0d2PfCP3Ff+Aly
         XDxw==
X-Gm-Message-State: AOJu0YwWyrHN1ya9EwATrnB5k3k0qmYBL6KEdiJB/jCqPJD3BfGZ0+ky
	Fim2/Wrw6fh+AlDtzeViTwaNDU2nOUPqgHK8gDh02jNP/dwX1mVCZFDpMZxB8+pHX5b79gwTaMV
	Bk0a/7CZf3Thi8/8vEw+Y61e0Ut9RYUs=
X-Gm-Gg: ATEYQzyKkgRAH1IbBUH9Yefg5+hRDdH/Y8vEzrux87phb4SykEn+pb/cOr7MIF1BPCB
	iih3AWqsPJJINebSCR3lNhi7zK96AKhn0rgui82Y9/82r1fcpaDjBAEm0D267znuQCUuVDCT+vI
	caC2dCIeD7tyofv55YcJpDzjBpQFt17L6NU8gFhjFuI/+DgVRT9BEpyTetX7LjDrLRb96uBLXjn
	iVpZ6m1ZjghWCE5v5i1cO38rP7izHzjCrODsL1wKH6/Wi3yGbWOnriKe2N4Qji7Wdj+/WOm2+QB
	H8DLnXs=
X-Received: by 2002:a17:90a:ec85:b0:345:badf:f1b7 with SMTP id
 98e67ed59e1d1-35a012cbadfmr3770969a91.28.1773270943706; Wed, 11 Mar 2026
 16:15:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-2-ameryhung@gmail.com>
 <CAEf4BzZubPSaS8SQSEQJvTphwgbaBfdC0CYEhsfQN8CJ7HS3pw@mail.gmail.com>
 <CAMB2axNR6qPRVy5YCiMygVseS+k9JxY9DFONNHD5Lt8=wD9MGQ@mail.gmail.com>
 <CAEf4BzYTO9e-UAEd+W+ftqQZLUZCWHWXAYVnVjHeNtsZL1=Pdw@mail.gmail.com> <CAMB2axN+8+V+29r9tuoVF57ObpvkUE5d5_8jtd5iRPYq4_gLGg@mail.gmail.com>
In-Reply-To: <CAMB2axN+8+V+29r9tuoVF57ObpvkUE5d5_8jtd5iRPYq4_gLGg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Mar 2026 16:15:31 -0700
X-Gm-Features: AaiRm51yJ0u0juKG9fWYP7eI6FVhFH7X0uPQ8g8NpFoQk31xTypnakOrgWGLMBM
Message-ID: <CAEf4BzY1O1Ne9Rf+O2terCT8f9e6pNFr3N4hOv98N84ZoehCaw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 01/11] bpf: Set kfunc dynptr arg type flag
 based on prototype
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 4:03=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Wed, Mar 11, 2026 at 3:37=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Mar 11, 2026 at 1:01=E2=80=AFPM Amery Hung <ameryhung@gmail.com=
> wrote:
> > >
> > > On Wed, Mar 11, 2026 at 12:44=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Fri, Mar 6, 2026 at 10:44=E2=80=AFPM Amery Hung <ameryhung@gmail=
.com> wrote:
> > > > >
> > > > > The verifier should decide whether a dynptr argument is read-only
> > > > > based on if the type is "const struct bpf_dynptr *", not the type=
 of
> > > > > the register passed to the kfunc. This currently does not cause i=
ssues
> > > > > because existing kfuncs that mutate struct bpf_dynptr are constru=
ctors
> > > > > (e.g., bpf_dynptr_from_xxx and bpf_dynptr_clone). These kfuncs ha=
ve
> > > > > additional check in process_dynptr_func() to make sure the stack =
slot
> > > > > does not contain initialized dynptr. Nonetheless, this should sti=
ll be
> > > > > fixed to avoid future issues when there is a non-constructor dynp=
tr
> > > > > kfunc that can mutate dynptr. This is also a small step toward un=
ifying
> > > > > kfunc and helper handling in the verifier, where the first step i=
s to
> > > > > generate kfunc prototype similar to bpf_func_proto before the mai=
n
> > > > > verification loop.
> > > > >
> > > > > We also need to correctly mark some kfunc arguments as "const str=
uct
> > > > > bpf_dynptr *" to align with other kfuncs that take non-mutable dy=
nptr
> > > > > argument and to not break their usage. Adding const qualifier doe=
s
> > > > > not break backward compatibility.
> > > > >
> > > > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > > > ---
> > > > >  fs/verity/measure.c                            |  2 +-
> > > > >  include/linux/bpf.h                            |  8 ++++----
> > > > >  kernel/bpf/helpers.c                           | 10 +++++-----
> > > > >  kernel/bpf/verifier.c                          | 18 ++++++++++++=
+++++-
> > > > >  kernel/trace/bpf_trace.c                       | 18 +++++++++---=
------
> > > > >  tools/testing/selftests/bpf/bpf_kfuncs.h       |  6 +++---
> > > > >  .../selftests/bpf/progs/dynptr_success.c       |  6 +++---
> > > > >  .../bpf/progs/test_kfunc_dynptr_param.c        |  7 +------
> > > > >  8 files changed, 43 insertions(+), 32 deletions(-)
> > > > >
> > > > > diff --git a/fs/verity/measure.c b/fs/verity/measure.c
> > > > > index 6a35623ebdf0..3840436e4510 100644
> > > > > --- a/fs/verity/measure.c
> > > > > +++ b/fs/verity/measure.c
> > > > > @@ -118,7 +118,7 @@ __bpf_kfunc_start_defs();
> > > > >   *
> > > > >   * Return: 0 on success, a negative value on error.
> > > > >   */
> > > > > -__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struc=
t bpf_dynptr *digest_p)
> > > > > +__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, const=
 struct bpf_dynptr *digest_p)
> > > >
> > > > but kfunc is writing into digest_p, so that const is wrong?...
> > > >
> > > > >  {
> > > > >         struct bpf_dynptr_kern *digest_ptr =3D (struct bpf_dynptr=
_kern *)digest_p;
> > > > >         const struct inode *inode =3D file_inode(file);
> > > >
> > > > [...]
> > > >
> > > > > index 6eb6c82ed2ee..3d44896587ac 100644
> > > > > --- a/kernel/bpf/helpers.c
> > > > > +++ b/kernel/bpf/helpers.c
> > > > > @@ -3000,8 +3000,8 @@ __bpf_kfunc int bpf_dynptr_clone(const stru=
ct bpf_dynptr *p,
> > > > >   * Copies data from source dynptr to destination dynptr.
> > > > >   * Returns 0 on success; negative error, otherwise.
> > > > >   */
> > > > > -__bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u64 =
dst_off,
> > > > > -                               struct bpf_dynptr *src_ptr, u64 s=
rc_off, u64 size)
> > > > > +__bpf_kfunc int bpf_dynptr_copy(const struct bpf_dynptr *dst_ptr=
, u64 dst_off,
> > > >
> > > > again, dst_ptr clearly is modifiable because we are copying data in=
to it.
> > > >
> > > > What am I missing, why is this logically correct?
> > > >
> > > > (I understand that from purely C type system POV this is fine, beca=
use
> > > > we don't modify bpf_dynptr struct itself on the stack, but bpf_dynp=
tr
> > > > is a representation of some memory, and if we are modifying this
> > > > memory, then I think it should be not marked as const)
> > >
> > > The patch is just to first make the arg type determination independen=
t
> > > from bpf_reg_state and make kfunc signature consistent based on what
> > > commit 52f37c4e0f11 (bpf: Rework process_dynptr_func) has laid out.
> > >
> > > Perhaps MEM_RDONLY is a bit misleading. In process_dynptr_func(), the
> > > flag means the dynptr struct on the stack is immutable. Currently,
> > > there is no way (and maybe no need?) to specify read-only dynptr.
> > >
> >
> > are you basically trying to determine if CONST_DYNPTR_PTR is allowed or=
 not?
>
> Yes.
>
> >
> > > > > The verifier should decide whether a dynptr argument is read-only
> >
> > can you please remind us what "read-only dynptr argument" means for ver=
ifier?
>
> Oh well... my apologies for the inconsistency in commit message and
> comments. It should be "immutable" instead of "read-only" here.

I guess I'd suggest

struct bpf_dyntpr *const dptr

to mark this through type system? that is, *constant pointer* to
dynptr, not a pointer to *constant dynptr*

WDYT?

>
> >
> > > >
> > > > > +                               const struct bpf_dynptr *src_ptr,=
 u64 src_off, u64 size)
> > > > >  {
> > > > >         struct bpf_dynptr_kern *dst =3D (struct bpf_dynptr_kern *=
)dst_ptr;
> > > > >         struct bpf_dynptr_kern *src =3D (struct bpf_dynptr_kern *=
)src_ptr;
> > > >
> > > > [...]
