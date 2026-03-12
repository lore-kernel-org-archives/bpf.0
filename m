Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C7A3822AA
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 20:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346213; cv=pass; b=BjHqDOyAS+Pi+mq/RdDs3uDn1mUQ+qA45O9LxBVeiaKzMGJeKdmdGvDel/RP3szvZ60xGCMzfajyS3Psm7UgoIudPZnA/beY0W3zCYwfAH0NxT4AQ18YE2Btiysmq3VazFIAR2f3IqK4fDNqxMsfXBFTdqYAwkz6CRqG/TLL9HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346213; c=relaxed/simple;
	bh=YrKSTG/KUU+5EZU9DCzic7bdcxeYtSaba7SKVjTjUc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRzTPBzEAuq5OqweQT6NJg/SHTBJOs/w3QcwiOBjgCBUDslfzfWqhKWpG5/uKLDVMyTNW+r2FBdLtoVuL+5P6fgUuTyfVGh9wog83vfg/k06u3GG/05LxPzsOn7AIzTwHEzbv7O4vI4iVFaIaipAhhbvBcG6xzTFpApIyU9ewZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oo02eGGV; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oo02eGGV"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ae8177446fso11442035ad.0
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 13:10:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773346210; cv=none;
        d=google.com; s=arc-20240605;
        b=jBwNpSvqPqPcgYL9bIkNEzzlY/5fwFMVcdIuy0WnWl+ZssnZeyM7/CqyuhspHLOsUG
         jQNYaJIbqN2A6djnM6A4NdfnEVg30zZ8u8HDZZtr3gwduw/6UOUoWpI+8jGJKDTHspyZ
         R2uCQcuf/I5Dhi2ilNtQXdZ1rMmMuJOjiJwtb/FNgS4k6ditm6/CFwMvD+Lb8s3jYS1X
         xiiqs9/mArc/seSov0/9o/nxG3drcHSh2ZWpAEdsrWKXvNpOYPGnDlU1fHYUUcaWgnj/
         Sxt2tuKa1dgR8ptM3kqmc/lDzKDCy7zzYGAHmky7CRGky6WghNDrQop8UHK/bwAosOCN
         SReA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gm2FCxY20BE6uUQnf+f3bxv0y7OjLwyxJWmXnboau2o=;
        fh=HFezYODqB0dHS8ZckTal1iiWnuisbLhk4gui7Bi0T/g=;
        b=jOCEkHy2vJzfJ2JKyGml2qlLiInjqwmiPp+ZePfgv1i7rDwBKsdbDUypCUuiwsDANu
         n0h+1ll7/UblsVqSl0+zB2ctN7q/FgsrPjcRSR6ah+I0IVlRA8BAw9ng9Ter3pb6hlhw
         hOCW5m8RRm36MmisDET3Fmge6WN/LqtOGhzhG4TvR3gOjP52OTuAnx93pgSv7w2C/9Ft
         ZjnctP4P3vOqrPfrf5ezU4OOz3lP99ZXtgMPY4dzRkp0LxazrItxKtTOuO2Q2Z4M9EY6
         +tm0pJj96y5BNx5mIGAk6Qy+2eprx8s7tSOb9Mlqn/O5TRJt3yH6UxdD4G9Nxw7slaHh
         LBMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773346210; x=1773951010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gm2FCxY20BE6uUQnf+f3bxv0y7OjLwyxJWmXnboau2o=;
        b=Oo02eGGV9vYaYCscUNWSGh9KNd/s/AYWYRHCKQnK8gScRIWiUJ4uOZouaRqEewImhZ
         nJtaaEJLDYftiQ6t9pWlnyhFOrpgGVqvRsPsgaloQroirHNVCgjEP5Tq9jamLQf7IDeB
         Ol5Y1oeq4laq9WIvepmd980W3F9fNBi+ykmENJFY6O/MI+SXWjcLM5xbv1AVgfLUwQE1
         e3ft7GSs++VcHjmWcQhydoFDJTweh7BZBQNH8eklE9jr/pK+f+D9Dxr+5AFLsGI2gf3Q
         YLzLZbaQQnTNcQHp+SEN6s4bHf67535TR6hhbzK5ZsOqBsEpYs4WtrhimRAZoumEVVcf
         rC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773346210; x=1773951010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gm2FCxY20BE6uUQnf+f3bxv0y7OjLwyxJWmXnboau2o=;
        b=tjLi5qKp0J1C9RU3MIXp3EoQFnqWTHh8pLLYtRKRfn7v2rc7lSlGtr/aT1ohrkoPTo
         PieIYWiJr+jlyZW25hNTxaXX9cnh3jfSfaejRRThUMq3R8yKOCL/SKhdgcyLPl0xg05E
         baV86iRnxFS3SL2Xr/zTi3uqf+ZRKq7y5zPNfKnQog1vMqhHGQV+j5HMbjm4Eqw+hoWO
         lqUfTcQkwFovykBaQ9XGay2MBVeFh8P+4Jw4Q2lOiX2RqNcRj+mtWPj9DZwpOym/xoQL
         6abI5zB1YYmVEIuII2kAsRy60kpH+Ju++fSyEoDrVhbOM8zy7BtL+15126jdd8bJCyzf
         3LmA==
X-Gm-Message-State: AOJu0Yy5sGXHNLoU6bdkZHCV9bgfa8bTbQGoYz/LRvVze+OnXkj9hLBD
	N34KSo/VdfFQwB48KgWaY8+6tI4gGUDsPalN32ChYsINbygtlsEOkZiaVWYOfpu41CUaX6Vmv06
	IlzSJGTq3yenwlZuvALOzxu7OXzofqD4=
X-Gm-Gg: ATEYQzymDjtAvaaleA/qLlX+H0nVDrizZxDhTGhjzqDEaaROyz96G6FAUJwQ6qnwTss
	DOl/UNX6ncp8xS+3ed2b5q3ls+vQe9gQ2oGCytRv73N8Aj3e4XH3wg6b4GAN/fiWYvmxywLWOLr
	YABdioYkkS8sOBjUrMno/SzIrQCTK5WMuRc++R2cLEFufNQ5V2RiZThH3H8SRZMrrqKgNiIbF4Y
	A1SGeqDfIqCqSba3JnLYFujWTi7ounsheYJleqvnks68Esy2E8dDdu70cz++7oPhMdSCByHVD15
	twz0JmLEscq/A1DJ9kNQOM8=
X-Received: by 2002:a17:903:3c43:b0:2ae:5baa:cef6 with SMTP id
 d9443c01a7336-2aecaa26653mr6830965ad.19.1773346210204; Thu, 12 Mar 2026
 13:10:10 -0700 (PDT)
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
 <CAMB2axN+8+V+29r9tuoVF57ObpvkUE5d5_8jtd5iRPYq4_gLGg@mail.gmail.com>
 <CAEf4BzY1O1Ne9Rf+O2terCT8f9e6pNFr3N4hOv98N84ZoehCaw@mail.gmail.com> <CAMB2axN8Qe6r_siq5_6od7D_kDZPcYw_Z6KVOFtXNJVKzajqzw@mail.gmail.com>
In-Reply-To: <CAMB2axN8Qe6r_siq5_6od7D_kDZPcYw_Z6KVOFtXNJVKzajqzw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Mar 2026 13:09:55 -0700
X-Gm-Features: AaiRm53caXxCZkzH0tGBQHZIM52CG4FziCPGYuMyjIEkMB56W7YV4fcZ0enQXQ8
Message-ID: <CAEf4Bza5bNf6MsgNrr9WqE5ZKhRQ_PwtdCEwaWAVLJNmAZzv=A@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 01/11] bpf: Set kfunc dynptr arg type flag
 based on prototype
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 9:59=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Wed, Mar 11, 2026 at 4:15=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Mar 11, 2026 at 4:03=E2=80=AFPM Amery Hung <ameryhung@gmail.com=
> wrote:
> > >
> > > On Wed, Mar 11, 2026 at 3:37=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Wed, Mar 11, 2026 at 1:01=E2=80=AFPM Amery Hung <ameryhung@gmail=
.com> wrote:
> > > > >
> > > > > On Wed, Mar 11, 2026 at 12:44=E2=80=AFPM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > On Fri, Mar 6, 2026 at 10:44=E2=80=AFPM Amery Hung <ameryhung@g=
mail.com> wrote:
> > > > > > >
> > > > > > > The verifier should decide whether a dynptr argument is read-=
only
> > > > > > > based on if the type is "const struct bpf_dynptr *", not the =
type of
> > > > > > > the register passed to the kfunc. This currently does not cau=
se issues
> > > > > > > because existing kfuncs that mutate struct bpf_dynptr are con=
structors
> > > > > > > (e.g., bpf_dynptr_from_xxx and bpf_dynptr_clone). These kfunc=
s have
> > > > > > > additional check in process_dynptr_func() to make sure the st=
ack slot
> > > > > > > does not contain initialized dynptr. Nonetheless, this should=
 still be
> > > > > > > fixed to avoid future issues when there is a non-constructor =
dynptr
> > > > > > > kfunc that can mutate dynptr. This is also a small step towar=
d unifying
> > > > > > > kfunc and helper handling in the verifier, where the first st=
ep is to
> > > > > > > generate kfunc prototype similar to bpf_func_proto before the=
 main
> > > > > > > verification loop.
> > > > > > >
> > > > > > > We also need to correctly mark some kfunc arguments as "const=
 struct
> > > > > > > bpf_dynptr *" to align with other kfuncs that take non-mutabl=
e dynptr
> > > > > > > argument and to not break their usage. Adding const qualifier=
 does
> > > > > > > not break backward compatibility.
> > > > > > >
> > > > > > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > > > > > ---
> > > > > > >  fs/verity/measure.c                            |  2 +-
> > > > > > >  include/linux/bpf.h                            |  8 ++++----
> > > > > > >  kernel/bpf/helpers.c                           | 10 +++++---=
--
> > > > > > >  kernel/bpf/verifier.c                          | 18 ++++++++=
+++++++++-
> > > > > > >  kernel/trace/bpf_trace.c                       | 18 ++++++++=
+---------
> > > > > > >  tools/testing/selftests/bpf/bpf_kfuncs.h       |  6 +++---
> > > > > > >  .../selftests/bpf/progs/dynptr_success.c       |  6 +++---
> > > > > > >  .../bpf/progs/test_kfunc_dynptr_param.c        |  7 +------
> > > > > > >  8 files changed, 43 insertions(+), 32 deletions(-)
> > > > > > >
> > > > > > > diff --git a/fs/verity/measure.c b/fs/verity/measure.c
> > > > > > > index 6a35623ebdf0..3840436e4510 100644
> > > > > > > --- a/fs/verity/measure.c
> > > > > > > +++ b/fs/verity/measure.c
> > > > > > > @@ -118,7 +118,7 @@ __bpf_kfunc_start_defs();
> > > > > > >   *
> > > > > > >   * Return: 0 on success, a negative value on error.
> > > > > > >   */
> > > > > > > -__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, s=
truct bpf_dynptr *digest_p)
> > > > > > > +__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, c=
onst struct bpf_dynptr *digest_p)
> > > > > >
> > > > > > but kfunc is writing into digest_p, so that const is wrong?...
> > > > > >
> > > > > > >  {
> > > > > > >         struct bpf_dynptr_kern *digest_ptr =3D (struct bpf_dy=
nptr_kern *)digest_p;
> > > > > > >         const struct inode *inode =3D file_inode(file);
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > > index 6eb6c82ed2ee..3d44896587ac 100644
> > > > > > > --- a/kernel/bpf/helpers.c
> > > > > > > +++ b/kernel/bpf/helpers.c
> > > > > > > @@ -3000,8 +3000,8 @@ __bpf_kfunc int bpf_dynptr_clone(const =
struct bpf_dynptr *p,
> > > > > > >   * Copies data from source dynptr to destination dynptr.
> > > > > > >   * Returns 0 on success; negative error, otherwise.
> > > > > > >   */
> > > > > > > -__bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, =
u64 dst_off,
> > > > > > > -                               struct bpf_dynptr *src_ptr, u=
64 src_off, u64 size)
> > > > > > > +__bpf_kfunc int bpf_dynptr_copy(const struct bpf_dynptr *dst=
_ptr, u64 dst_off,
> > > > > >
> > > > > > again, dst_ptr clearly is modifiable because we are copying dat=
a into it.
> > > > > >
> > > > > > What am I missing, why is this logically correct?
> > > > > >
> > > > > > (I understand that from purely C type system POV this is fine, =
because
> > > > > > we don't modify bpf_dynptr struct itself on the stack, but bpf_=
dynptr
> > > > > > is a representation of some memory, and if we are modifying thi=
s
> > > > > > memory, then I think it should be not marked as const)
> > > > >
> > > > > The patch is just to first make the arg type determination indepe=
ndent
> > > > > from bpf_reg_state and make kfunc signature consistent based on w=
hat
> > > > > commit 52f37c4e0f11 (bpf: Rework process_dynptr_func) has laid ou=
t.
> > > > >
> > > > > Perhaps MEM_RDONLY is a bit misleading. In process_dynptr_func(),=
 the
> > > > > flag means the dynptr struct on the stack is immutable. Currently=
,
> > > > > there is no way (and maybe no need?) to specify read-only dynptr.
> > > > >
> > > >
> > > > are you basically trying to determine if CONST_DYNPTR_PTR is allowe=
d or not?
> > >
> > > Yes.
> > >
> > > >
> > > > > > > The verifier should decide whether a dynptr argument is read-=
only
> > > >
> > > > can you please remind us what "read-only dynptr argument" means for=
 verifier?
> > >
> > > Oh well... my apologies for the inconsistency in commit message and
> > > comments. It should be "immutable" instead of "read-only" here.
> >
> > I guess I'd suggest
> >
> > struct bpf_dyntpr *const dptr
> >
> > to mark this through type system? that is, *constant pointer* to
> > dynptr, not a pointer to *constant dynptr*
> >
> > WDYT?
>
> I think they both make sense from different angles, but I am not sure
> which one is better.
>
> From purely C's point of view. the pointer points to a struct dynptr
> that should not be mutated so "const struct dynptr *p" is correct.
>
> From the BPF dynptr abstraction's point of view, the pointer points to
> the underlying memory (e.gg., skb, file, ringbuf, etc.), so "struct
> dynptr * const p".
>
> Any way we choose, I'd suggest that to be a separate patch. This patch
> at least makes things consistent and fixes a logical bug.

if we could rely on decltag, I'd go with that. But *const is unusual
and stands out, so I'd go with that. I wonder if anyone else has any
thoughts.
>
> >
> > >
> > > >
> > > > > >
> > > > > > > +                               const struct bpf_dynptr *src_=
ptr, u64 src_off, u64 size)
> > > > > > >  {
> > > > > > >         struct bpf_dynptr_kern *dst =3D (struct bpf_dynptr_ke=
rn *)dst_ptr;
> > > > > > >         struct bpf_dynptr_kern *src =3D (struct bpf_dynptr_ke=
rn *)src_ptr;
> > > > > >
> > > > > > [...]
