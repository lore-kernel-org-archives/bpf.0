Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20C439098E
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 16:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334765; cv=pass; b=ur8u02ldx/FcUssn/a/fzuRZRava4+H+AWxI/rkhGGxIpfHvntLTuNCXOyveauiE9ol5Cw7d05ybB7Qiy0+fCeg+viNIRMRKQQKj3rdncE17oZy2KpJ8PIgxxz076su1P3zuh5kh4tFW+Ky7ttkeXDgmud64skXabDMalWP9ofA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334765; c=relaxed/simple;
	bh=M2iymQZKX+8vHWjM+sGVXO0KItugHB5MFB2eFn6DzUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LSUxGzzfwyDarIbk5gASliHRtCsf+j4gMTA9TPieoKyR34fxN6D06lLL5KYZlOBtHX6MvNmqrgOZPJMZ8+M2MiMTsbYZTBt5Lq2hoywSDPIc+d2duYcKDJVqO4cBX3BSWdc+RrnG3EMKFwnSvIiH8R0u3qG44UAzKyxj83ZtTNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWCSX92D; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWCSX92D"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-794719afcd4so12747797b3.1
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 09:59:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773334762; cv=none;
        d=google.com; s=arc-20240605;
        b=k4dNkIF6O+6DozeSiiv2OD5PbvKd98N+yQM0em40R4XcTgPvLMivIHjwEoAnemA46/
         Dy/mVaKS87GRBSz2Q22oCOwM8FlGfyy6r6OwBpES9uei+Pfj5U/k70Zp/IFry6Q7oUrA
         sMsGQ5i0CEbHRY+fQaK9P6braS19xn0cuvao50XGO6C+KM8pp4CIWK14+sNH3+nXB2Fe
         fK/auQfAEd1b5E9O+xE2IEoYR9i2Ps8oC2QAPu7c6kh5fpf7Pkk35x44Mdaxk1AkNHsP
         oJmlzNk6uX+h0vDItpbcEa9bHdSWF1DP40CXyufiRdKxaW9h3KRt2h3Eh/UR1a8PYxsd
         6vpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RmhvuLaKjTTuQXwRd83noFpknqFUxs50sL6rs4k8AXI=;
        fh=6ElxuiIjr8MUw7uRyrqk6E+jhEPFMT0pHHkRrcSi3dU=;
        b=lFM+iXPtn6Pefs0812440Aj+rWHL/SWFls5+hCODPD/uagNS4GMCP2axPVZuZKyAH8
         EtYNono9ygwDqCXDybgZabnv/o3bcrq5n6InoM5tn5Zc5X8MQ7IAB14Tn26CFceTyPyU
         f52P/zbBV3HBFLyc196YwEh/9UPCG4TyLT5mKwPlvrN1hZW5krxYB2VWWjPKxnEEJMSa
         Rj5ep2O2/7yqXjPv1O9rGlDw/0xx6bF3N7cACeTno7o6aHcl1W6o4qzJE8rm6UHn1OG4
         QbPGx7MVEFXFGf3zXOOLf3+z5DO+Yy5aLX4BqQ6gvHKUmgTWKFDad/Zumpo9t6QPQSe0
         1ikg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773334762; x=1773939562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmhvuLaKjTTuQXwRd83noFpknqFUxs50sL6rs4k8AXI=;
        b=gWCSX92DxRzsHIArEfcyFHW1BcfGsf4MTfVadaYPiInZHJSy//LNws/N47+3iZbVeZ
         If6eZzxrP9PAluwd8KIFKsQ9hE7+y0gWOS3lWjw/8oifly41rVrtf88/4lUB86Rhydxy
         mf26a8CC+UGfgpvZhpkmSYywbkwlVebSHt81+sH2Ug0063exXBXzgiwib05Lljd6h58O
         AHyYoByEy5y7OM4lbUyaBE5Lxfn78MjW1CcQIF7biPdrUee+eLeYufz7luROimahmkK7
         45GNU7LRWrJ49jbze4q07mcas4aOkRNm212rvvGxd5ngT+PNbKs9nO7OzCbkVxWq+1ZR
         90pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773334762; x=1773939562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RmhvuLaKjTTuQXwRd83noFpknqFUxs50sL6rs4k8AXI=;
        b=r1xri2z2WmsZepbB6sZd6bEG8FmDUiiL3GV5bTRooXkoZtfiP3DHj/DdiScYdBzc9j
         SiX7vLQYYMxSBUjpry2YS5RG98bBDq8ZD0bK/0mMuZP7r0SrT4pHHHlcM4SW3d9ra++L
         W4WpX6JVAfaSYe4FIknBc7yLkgHkkF0R2tlach6unwupTCrCeDmYq3/W0xrxQDkG6v+P
         z2wvtaapOQUKlbrsUB0Xlkv5OxZtYPWx6wUxwa4+SG7wytZzCC7kFybDbiSiOWEFqvF8
         fdergRd+32nX/OnqwmM5GkphccM+uuiZ+hbgIEIC6lMPl7Y+JM57R1XR/18OrM7x9POt
         CFKQ==
X-Gm-Message-State: AOJu0YxjdRs51dh9drGlr6V2vIx3QwcYAV2ulTMMlnwd+dtE3Lij6m75
	PLVzl1XusEt+GCmqjq1zIuvAwy1P59pkjMM/SJDOj07Sd0/2d99jwR2w0+LwzOXJt6oiPHSUUab
	7GWQF14dOvYu+1Ay4AOkUx9UMFwlvYCE=
X-Gm-Gg: ATEYQzyM2c+i5jxQZyKgHEs9p4xY7G1EXhoPmPUyt2X4lj9DfEL1QROPHSDY3WEqdPV
	aYgsqu762qqH2Lbe+UW8YVXm1gdUNFMLg1sYZkmVQdb8aREwwPYgXfNt6fKhE1UDZZ3dAqfJpME
	c3O8A/xSUadptCwADyIQL9ejLKORT0s6BZxGjzaSCUrGYBNDaHJ6p2o2Jz2Ge4Xo8CM4AVxEC98
	nW7TlmqM9LY33eBxIDnbymVWdmxLyQDgjL1U+DtExGyLU8IAxjpAQHsNlIe7CVFqKT3nS31w3tF
	vK83/66Y3RiqPtriTD4qpyI=
X-Received: by 2002:a05:690c:f06:b0:796:4235:ea1c with SMTP id
 00721157ae682-79a1c1881a6mr2948747b3.40.1773334761723; Thu, 12 Mar 2026
 09:59:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-2-ameryhung@gmail.com>
 <CAEf4BzZubPSaS8SQSEQJvTphwgbaBfdC0CYEhsfQN8CJ7HS3pw@mail.gmail.com>
 <CAMB2axNR6qPRVy5YCiMygVseS+k9JxY9DFONNHD5Lt8=wD9MGQ@mail.gmail.com>
 <CAEf4BzYTO9e-UAEd+W+ftqQZLUZCWHWXAYVnVjHeNtsZL1=Pdw@mail.gmail.com>
 <CAMB2axN+8+V+29r9tuoVF57ObpvkUE5d5_8jtd5iRPYq4_gLGg@mail.gmail.com> <CAEf4BzY1O1Ne9Rf+O2terCT8f9e6pNFr3N4hOv98N84ZoehCaw@mail.gmail.com>
In-Reply-To: <CAEf4BzY1O1Ne9Rf+O2terCT8f9e6pNFr3N4hOv98N84ZoehCaw@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 12 Mar 2026 09:59:10 -0700
X-Gm-Features: AaiRm53ZaiCWGNz9hMLXMLHUgWZMOtoU8omxpXk2jjffjeh5iM3eI87em5sVbOU
Message-ID: <CAMB2axN8Qe6r_siq5_6od7D_kDZPcYw_Z6KVOFtXNJVKzajqzw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 01/11] bpf: Set kfunc dynptr arg type flag
 based on prototype
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 4:15=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Mar 11, 2026 at 4:03=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > On Wed, Mar 11, 2026 at 3:37=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Mar 11, 2026 at 1:01=E2=80=AFPM Amery Hung <ameryhung@gmail.c=
om> wrote:
> > > >
> > > > On Wed, Mar 11, 2026 at 12:44=E2=80=AFPM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Fri, Mar 6, 2026 at 10:44=E2=80=AFPM Amery Hung <ameryhung@gma=
il.com> wrote:
> > > > > >
> > > > > > The verifier should decide whether a dynptr argument is read-on=
ly
> > > > > > based on if the type is "const struct bpf_dynptr *", not the ty=
pe of
> > > > > > the register passed to the kfunc. This currently does not cause=
 issues
> > > > > > because existing kfuncs that mutate struct bpf_dynptr are const=
ructors
> > > > > > (e.g., bpf_dynptr_from_xxx and bpf_dynptr_clone). These kfuncs =
have
> > > > > > additional check in process_dynptr_func() to make sure the stac=
k slot
> > > > > > does not contain initialized dynptr. Nonetheless, this should s=
till be
> > > > > > fixed to avoid future issues when there is a non-constructor dy=
nptr
> > > > > > kfunc that can mutate dynptr. This is also a small step toward =
unifying
> > > > > > kfunc and helper handling in the verifier, where the first step=
 is to
> > > > > > generate kfunc prototype similar to bpf_func_proto before the m=
ain
> > > > > > verification loop.
> > > > > >
> > > > > > We also need to correctly mark some kfunc arguments as "const s=
truct
> > > > > > bpf_dynptr *" to align with other kfuncs that take non-mutable =
dynptr
> > > > > > argument and to not break their usage. Adding const qualifier d=
oes
> > > > > > not break backward compatibility.
> > > > > >
> > > > > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > > > > ---
> > > > > >  fs/verity/measure.c                            |  2 +-
> > > > > >  include/linux/bpf.h                            |  8 ++++----
> > > > > >  kernel/bpf/helpers.c                           | 10 +++++-----
> > > > > >  kernel/bpf/verifier.c                          | 18 ++++++++++=
+++++++-
> > > > > >  kernel/trace/bpf_trace.c                       | 18 +++++++++-=
--------
> > > > > >  tools/testing/selftests/bpf/bpf_kfuncs.h       |  6 +++---
> > > > > >  .../selftests/bpf/progs/dynptr_success.c       |  6 +++---
> > > > > >  .../bpf/progs/test_kfunc_dynptr_param.c        |  7 +------
> > > > > >  8 files changed, 43 insertions(+), 32 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/verity/measure.c b/fs/verity/measure.c
> > > > > > index 6a35623ebdf0..3840436e4510 100644
> > > > > > --- a/fs/verity/measure.c
> > > > > > +++ b/fs/verity/measure.c
> > > > > > @@ -118,7 +118,7 @@ __bpf_kfunc_start_defs();
> > > > > >   *
> > > > > >   * Return: 0 on success, a negative value on error.
> > > > > >   */
> > > > > > -__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, str=
uct bpf_dynptr *digest_p)
> > > > > > +__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, con=
st struct bpf_dynptr *digest_p)
> > > > >
> > > > > but kfunc is writing into digest_p, so that const is wrong?...
> > > > >
> > > > > >  {
> > > > > >         struct bpf_dynptr_kern *digest_ptr =3D (struct bpf_dynp=
tr_kern *)digest_p;
> > > > > >         const struct inode *inode =3D file_inode(file);
> > > > >
> > > > > [...]
> > > > >
> > > > > > index 6eb6c82ed2ee..3d44896587ac 100644
> > > > > > --- a/kernel/bpf/helpers.c
> > > > > > +++ b/kernel/bpf/helpers.c
> > > > > > @@ -3000,8 +3000,8 @@ __bpf_kfunc int bpf_dynptr_clone(const st=
ruct bpf_dynptr *p,
> > > > > >   * Copies data from source dynptr to destination dynptr.
> > > > > >   * Returns 0 on success; negative error, otherwise.
> > > > > >   */
> > > > > > -__bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u6=
4 dst_off,
> > > > > > -                               struct bpf_dynptr *src_ptr, u64=
 src_off, u64 size)
> > > > > > +__bpf_kfunc int bpf_dynptr_copy(const struct bpf_dynptr *dst_p=
tr, u64 dst_off,
> > > > >
> > > > > again, dst_ptr clearly is modifiable because we are copying data =
into it.
> > > > >
> > > > > What am I missing, why is this logically correct?
> > > > >
> > > > > (I understand that from purely C type system POV this is fine, be=
cause
> > > > > we don't modify bpf_dynptr struct itself on the stack, but bpf_dy=
nptr
> > > > > is a representation of some memory, and if we are modifying this
> > > > > memory, then I think it should be not marked as const)
> > > >
> > > > The patch is just to first make the arg type determination independ=
ent
> > > > from bpf_reg_state and make kfunc signature consistent based on wha=
t
> > > > commit 52f37c4e0f11 (bpf: Rework process_dynptr_func) has laid out.
> > > >
> > > > Perhaps MEM_RDONLY is a bit misleading. In process_dynptr_func(), t=
he
> > > > flag means the dynptr struct on the stack is immutable. Currently,
> > > > there is no way (and maybe no need?) to specify read-only dynptr.
> > > >
> > >
> > > are you basically trying to determine if CONST_DYNPTR_PTR is allowed =
or not?
> >
> > Yes.
> >
> > >
> > > > > > The verifier should decide whether a dynptr argument is read-on=
ly
> > >
> > > can you please remind us what "read-only dynptr argument" means for v=
erifier?
> >
> > Oh well... my apologies for the inconsistency in commit message and
> > comments. It should be "immutable" instead of "read-only" here.
>
> I guess I'd suggest
>
> struct bpf_dyntpr *const dptr
>
> to mark this through type system? that is, *constant pointer* to
> dynptr, not a pointer to *constant dynptr*
>
> WDYT?

I think they both make sense from different angles, but I am not sure
which one is better.

From purely C's point of view. the pointer points to a struct dynptr
that should not be mutated so "const struct dynptr *p" is correct.

From the BPF dynptr abstraction's point of view, the pointer points to
the underlying memory (e.gg., skb, file, ringbuf, etc.), so "struct
dynptr * const p".

Any way we choose, I'd suggest that to be a separate patch. This patch
at least makes things consistent and fixes a logical bug.

>
> >
> > >
> > > > >
> > > > > > +                               const struct bpf_dynptr *src_pt=
r, u64 src_off, u64 size)
> > > > > >  {
> > > > > >         struct bpf_dynptr_kern *dst =3D (struct bpf_dynptr_kern=
 *)dst_ptr;
> > > > > >         struct bpf_dynptr_kern *src =3D (struct bpf_dynptr_kern=
 *)src_ptr;
> > > > >
> > > > > [...]
