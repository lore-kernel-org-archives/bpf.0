Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6B22E719C
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 20:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773259298; cv=pass; b=iT8JWPBJn+eHQ++JldXq54FLGJAGWcDf8SGyEWEJjb+PlQZfnWzS4fZK6M5aMLxQ7BcW/fLVeFfk7QrZlSNMjFuY3JSmh+WE+72QjCTFOC2y2w78WegtokTclwYKssRmqsi9gxXkfeJPgXCK36UKeu1V9BFPt+ZJyLS5rxYQxWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773259298; c=relaxed/simple;
	bh=R+ZXp3/tqW/i0wREeECzf9YJ666Gdsm9vw9LNfjCxKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dvf9j7P+eiivAq74DU+jB0BE2OXnfmDD1SufF0wBEBnaxXsoMFFzqjVj+tMIr9HQc8V80ALFJz60+laEbFSNcNsl8qvjokPl5lir6Iy0NvMDz00tSCOvTkc7CPZ03MzTH6EmvkvFfkY5OqgN6vecFUQQILpeIloqIr1K5RFE5/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZT4AgJP; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZT4AgJP"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-40ea611d1a4so124672fac.2
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 13:01:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773259296; cv=none;
        d=google.com; s=arc-20240605;
        b=LDcjteKnN9eYHLoucv3VpiqNALeAdXiNzqHLW8vDXuZ+5uKb/vo5gdJ3xjAj08jm3P
         yomaOulkbb3l5h2CpvHZz1E9BHcHmdwvUFEWF91DMlJgv+nzri72PlWO+y9rTVDyhEas
         ixRvj+dXYXjRtVVjfAqr5ioeiDmZ55go4vhadZC59YWgTMdrzy2qR2sAcQFHwE/kGQHt
         2JAxaxZ6Ao/VQkYy7bsZZKE/WkVKy3uGAlixAvCa9q1rbsUDW/HMX2X0fogOAM32Pc1t
         vJzVZlKuVZXkcvFc+hyx8mHnaGv3wTovXh2q3s4vzdsSMSz+W8vnGmD5KUB43GVErJek
         WtMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fHPnCWsaqfvTp1UbNlu89sJKMGTnnSPPMuKtOaYd/aQ=;
        fh=6ElxuiIjr8MUw7uRyrqk6E+jhEPFMT0pHHkRrcSi3dU=;
        b=ItgDR1kQo2h3gV0kL/VxvmoTsKB+6QYTl1srD0ClFJCibo1PMMNfp801OCJzhzYDco
         yWKkjuMrcUapYITy1FVLh1Z81NqKA61Tu5PQ0wPQqHHyLnu3cJzVfQUh5pOzLl3jWx3M
         7fC9UEvXnpU0Uywt15dnayWdo3RXqWLNIM3DndKQCTEVuN8LhpiUsBzrMCNvXeo6Z5u5
         eaUdIOjsZIsllaWXMGdqaIByO5VnBeJsMErS8KSk5lD9WXM63PSURdSgMRMZ0LCobHrD
         O18gg7AWf0d6jS9Qch2iKbi+4COSzU1Us/jUtllW2j1A+4Mt8iedfkIBf9Mxd89LS5S9
         BBww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773259296; x=1773864096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHPnCWsaqfvTp1UbNlu89sJKMGTnnSPPMuKtOaYd/aQ=;
        b=SZT4AgJPxt1lFVtXCqbh0H1yOoqID7X4upyeAQK3ksKe8V6XrBlJWWQYzuAzlRGb66
         NuJt2B6YK+ILpb5PqXZ8e5rNG1bnTZmwl+zPrWMpEsPA/q7MBdZ9VahLgEv6fBflE+zT
         hLpfN+3ELlOvo9UHDgFcOfhkGJUrNKmfuQVhrtkQ4aHmL7TAKAiMOPkdD+fA4XlzkDEQ
         3iaBMb8/E6DpRaz56UIurfLwANkgZYMW+PcsZrzR4Nlu/rZkq88Y0KkUdYhlUmHK6fqf
         jKEzGbEAu7bR9jQwB/VLrYq5/G/8KA54rhFuG3tcbgomdhiA3ju6t/C9VasDcDUO6UVj
         muAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773259296; x=1773864096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fHPnCWsaqfvTp1UbNlu89sJKMGTnnSPPMuKtOaYd/aQ=;
        b=BFC3llZdEOg34RNVFN/HzM4p9d5GlMc6IItwA+ZRN5t5JVPO8Ngv6VuG7yAS+RnE+l
         FWtB8C7G1WfvfvmZCvkYFVcTKrrnu0SjDyTa4Bl/Ic5/a8FkSF2BVrEqER4h4JbEChpq
         oZlSgNIBcJJ6WaYXzhFlhOXz2EdmUzM5FrpowKKB8aObdwFqWGmulsZHtUastxh+/f6O
         rWUd+g1ihtO4ZYcXZQMpkPBFGYGOncWwGqdGOxhZisKdV6zX7OCrUg6oZlUwC2Yrap19
         Imj46PWmx3a8vAQ3Zghki9sGGT/BrGR6qU8OmHl6YiAvplqAUPVDfsbT71KbqmPBrSLB
         8Avg==
X-Gm-Message-State: AOJu0Yw1YuCyPJ9rL3uc8VPidwHfkHt/vUyLHq8bJvMByWS8tfjW+359
	EcJ5Xl+T6047/Vl3cvFN43AyO6yZSz7X062emtGFnZRqbMivAq7nySJ3FTpndoDQs3XKfhpFLKo
	R2p2mKWfo6eR8KxtOh2qGuKTRbbJ4rV8=
X-Gm-Gg: ATEYQzwrk5m0m6wreoFPz/vst7CGRr6TVe/PqQNVeqirbcbsdOsn43a2jVVXL5WUoic
	KT/jQORpXVEwS3mVj9MeOq68RjbixcekMXBO3eEMxPh8QeaHRVslFe2QceuNCJjRMup+Ndr85j3
	0aC4p0QMdbfM8rXHulQLWVAjiKjRGmzbBTDhPWeIwl01o9Lw5LQFHoYU1yiX6YkQ2gtddrJUYYl
	sXrSgTIeK72pqoYXGGaqqwujhIqWQqgn8hv2Xb/zSpb+BSW4K+zh2U6vESZyv6Ad3IW+7oZ48Ji
	9IaD/rA=
X-Received: by 2002:a05:6871:c303:b0:417:382f:c242 with SMTP id
 586e51a60fabf-4177c8b2f10mr2070301fac.18.1773259296417; Wed, 11 Mar 2026
 13:01:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-2-ameryhung@gmail.com>
 <CAEf4BzZubPSaS8SQSEQJvTphwgbaBfdC0CYEhsfQN8CJ7HS3pw@mail.gmail.com>
In-Reply-To: <CAEf4BzZubPSaS8SQSEQJvTphwgbaBfdC0CYEhsfQN8CJ7HS3pw@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 11 Mar 2026 13:01:24 -0700
X-Gm-Features: AaiRm52HnBR9tlmL7QySEZ_Sk1jcSBT-CpyZhFn0m48zVnwHKYssAOY6H82_17Q
Message-ID: <CAMB2axNR6qPRVy5YCiMygVseS+k9JxY9DFONNHD5Lt8=wD9MGQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 01/11] bpf: Set kfunc dynptr arg type flag
 based on prototype
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 12:44=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Mar 6, 2026 at 10:44=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > The verifier should decide whether a dynptr argument is read-only
> > based on if the type is "const struct bpf_dynptr *", not the type of
> > the register passed to the kfunc. This currently does not cause issues
> > because existing kfuncs that mutate struct bpf_dynptr are constructors
> > (e.g., bpf_dynptr_from_xxx and bpf_dynptr_clone). These kfuncs have
> > additional check in process_dynptr_func() to make sure the stack slot
> > does not contain initialized dynptr. Nonetheless, this should still be
> > fixed to avoid future issues when there is a non-constructor dynptr
> > kfunc that can mutate dynptr. This is also a small step toward unifying
> > kfunc and helper handling in the verifier, where the first step is to
> > generate kfunc prototype similar to bpf_func_proto before the main
> > verification loop.
> >
> > We also need to correctly mark some kfunc arguments as "const struct
> > bpf_dynptr *" to align with other kfuncs that take non-mutable dynptr
> > argument and to not break their usage. Adding const qualifier does
> > not break backward compatibility.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  fs/verity/measure.c                            |  2 +-
> >  include/linux/bpf.h                            |  8 ++++----
> >  kernel/bpf/helpers.c                           | 10 +++++-----
> >  kernel/bpf/verifier.c                          | 18 +++++++++++++++++-
> >  kernel/trace/bpf_trace.c                       | 18 +++++++++---------
> >  tools/testing/selftests/bpf/bpf_kfuncs.h       |  6 +++---
> >  .../selftests/bpf/progs/dynptr_success.c       |  6 +++---
> >  .../bpf/progs/test_kfunc_dynptr_param.c        |  7 +------
> >  8 files changed, 43 insertions(+), 32 deletions(-)
> >
> > diff --git a/fs/verity/measure.c b/fs/verity/measure.c
> > index 6a35623ebdf0..3840436e4510 100644
> > --- a/fs/verity/measure.c
> > +++ b/fs/verity/measure.c
> > @@ -118,7 +118,7 @@ __bpf_kfunc_start_defs();
> >   *
> >   * Return: 0 on success, a negative value on error.
> >   */
> > -__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struct bpf_=
dynptr *digest_p)
> > +__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, const struc=
t bpf_dynptr *digest_p)
>
> but kfunc is writing into digest_p, so that const is wrong?...
>
> >  {
> >         struct bpf_dynptr_kern *digest_ptr =3D (struct bpf_dynptr_kern =
*)digest_p;
> >         const struct inode *inode =3D file_inode(file);
>
> [...]
>
> > index 6eb6c82ed2ee..3d44896587ac 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -3000,8 +3000,8 @@ __bpf_kfunc int bpf_dynptr_clone(const struct bpf=
_dynptr *p,
> >   * Copies data from source dynptr to destination dynptr.
> >   * Returns 0 on success; negative error, otherwise.
> >   */
> > -__bpf_kfunc int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, u64 dst_of=
f,
> > -                               struct bpf_dynptr *src_ptr, u64 src_off=
, u64 size)
> > +__bpf_kfunc int bpf_dynptr_copy(const struct bpf_dynptr *dst_ptr, u64 =
dst_off,
>
> again, dst_ptr clearly is modifiable because we are copying data into it.
>
> What am I missing, why is this logically correct?
>
> (I understand that from purely C type system POV this is fine, because
> we don't modify bpf_dynptr struct itself on the stack, but bpf_dynptr
> is a representation of some memory, and if we are modifying this
> memory, then I think it should be not marked as const)

The patch is just to first make the arg type determination independent
from bpf_reg_state and make kfunc signature consistent based on what
commit 52f37c4e0f11 (bpf: Rework process_dynptr_func) has laid out.

Perhaps MEM_RDONLY is a bit misleading. In process_dynptr_func(), the
flag means the dynptr struct on the stack is immutable. Currently,
there is no way (and maybe no need?) to specify read-only dynptr.

>
> > +                               const struct bpf_dynptr *src_ptr, u64 s=
rc_off, u64 size)
> >  {
> >         struct bpf_dynptr_kern *dst =3D (struct bpf_dynptr_kern *)dst_p=
tr;
> >         struct bpf_dynptr_kern *src =3D (struct bpf_dynptr_kern *)src_p=
tr;
>
> [...]
