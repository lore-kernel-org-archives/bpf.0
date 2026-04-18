Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83813AD24
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 20:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776544782; cv=pass; b=KNuTUMbL7wjZNI/Om25HobCbWnnFI/T63yX1G4BFpyPSjHyGmPhYWjLF2Iw760CqWODu914uctdPRbUYkT2PJpOX4EI5MzKxmCLltfEptLt5GQm3fDRhu4HUo6Mu5hn96sPPRkULGVO5hSSdhltT4nQZOwauiE+8GuUbHlYun9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776544782; c=relaxed/simple;
	bh=O7jSSckOMonLy+xozcAIybQRnRv0FKN0G1JX+qfr/8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NCy7cUG+fykQrSL4A9egyz90fhwLkpXFjhGVQWgt//+GGYt6haGSlVqcGQGvhtMZFEmmLqPmaq3PbsXs8H7VpUCixZpR29L65vLmaXuTgDk28UxitTTGSCcpmDUFAc8NyJZxgtCZyPGAM7/LwViADzmF2ufTB7PBU2k1HCU5YYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGGZ3Vyq; arc=pass smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGGZ3Vyq"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so26108545e9.2
        for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 13:39:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776544779; cv=none;
        d=google.com; s=arc-20240605;
        b=OZXNGoq8eYtjVdUBqKlYIugm4nPV66uZ6fvO5HJ5jl+GW9gzxJjXttUmda/BEsFWw+
         K2B+tLdQgkp9k81YoEnniDAh6jXcMNrQ5gSaTerA+5/NYfcKl+0t+ZnDDV2DURzXrl0N
         PHVCkVN0Tsfky/NP88M168PRXdIOsSNlfOoKf2TniKck9e0oXRWU+vRk9YWuyNV8uRte
         yLPZ30CqNDCS5G9o+JDWELppvJ3y21aGr7TyzHE4Ugb16pxFKl9lWsB7udAkUNXJjFOd
         TNjpxVcxZ7jFaW+DYabtf1JoC14QnIMfX94yScnYBNEZZPCKutywQzBxl28ZiduHhBkJ
         ba0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O4FQDs/qamdC/a5Shtctq+JV+X2zZ2gGxNGHIOGI/9k=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=KnZ3tEVCyETYkKUFPM/YWKkq+wK9947beGREei+fKE0ls50xfW29+0HHW87oO4uBw5
         qClpQbBsUR4klIFUp5L6J7A7vmikfpXiw83WAeMDxp653opVh2DTGHOl5O2yxZYBzlL1
         Hmz6Aus2YStQhMEeXhb0wvdVPWVQ5az4Hn0mSb8EnNwtuOoVoH7oGbnY67JAaUZltn4E
         FUC1GTvss3WM5V49tYrmsOfr8360WQNZ8FyeCrUHG5+86CcmtLDkkETzeaJjR/4gXMOG
         D0oxHvdNWZlmh+3JATBbt1IB2rTwAOc+OmbNfJnbpEAWyuXJScgSPqXybqtlBrJw24e9
         st0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776544779; x=1777149579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4FQDs/qamdC/a5Shtctq+JV+X2zZ2gGxNGHIOGI/9k=;
        b=XGGZ3VyqygQzjAlsij6NJW8Y3mqwnX+l3kNX5EJvGl0kyH40IX5/tQemPtK073ORj3
         fEMfqRnf9QY30x5xWuhBfDVe3PcOrVrSks5YKZ1IHqFQK4ONpyQWlMDiFYBYr3SgWROq
         2bU1pD3FusbsdoZVpMMdVE6gmUjk9qny0Xr4Y7G0tTmMkc6z7zHsGg60c+6Ds3HEZIeq
         Sq50QUAaddNQCAm9oCBaLuLBR5DtcLVNFFqToyU3jKSCYLoesRvqVZYX+Rqjm71RUn6m
         VW40xqew96bZXiv/QCWwPy6pb9FlXs/LpCm1d/X1kuWW8LoaAfW1ml/YIICnLL32ytU/
         Z+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776544779; x=1777149579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O4FQDs/qamdC/a5Shtctq+JV+X2zZ2gGxNGHIOGI/9k=;
        b=rHZ7P2pCb4arp9pSctXueIXUUnHmg2P/prwiR/jKN9kDOKaJrDQIZgAdIOIm7hGCfI
         LmTzxRN0Xut5ByMdgdNA10ULn4VNyTY423atgn9us0XD7kPWmF/EoYnqJuJajv/GvCHk
         +ILI34KSS+PvnuDdbCQS3AgtDBTjFuRMZ9/e00hIECO3NGPwtOOcLG/ODAk4lFvUrvb/
         Fo0G8N00lLg2hqDf/idIPusQDvnBxIJpg8efwLn4rAfHa1TzMvJyXWxM4P8Z8bbfFw8z
         Idp/QwGsgfZrsTNR4yzKX32GJV9083olK7IYXXq6rhkBwSVQ/1FcIKG5FVop7KJr5V3G
         1oiA==
X-Gm-Message-State: AOJu0YyjhTOAm3jXIfs0A55prfay85PLZAlE5KWBFzMA0vz/4ZMwhHyW
	Hr8JwyXmfyoPXtE0N7S3MW9t2/t/OPs8/Aw4q0sWsMrubzU6ea9bziC36fXoK7Or4a0mpOIZ6qq
	Sx7hmEVR9xQLw07US21JwbdDpgkXlJyQ=
X-Gm-Gg: AeBDiesiCNZgw7WXcUyVJKdQaPgMLX+//uov7NZDPMvb9s63pfBvkEu9H1f7GnWmFcS
	LvH5chubRgcF+L67QqJtzfY6JDf6URlVUm4hFsjtfKJu0rJNLxtpC7AP6KLtiqKjDsmrdzx/icq
	tQMNT9LTHcac+hkHXtx9oErdAChXyzH+zmTEBIoIkbqyN8KQa3tK3p3qpoocSqjmOb0BiWjOSHf
	2l+gZdC320XTF5uTay17wIa2qJwgY/yLFvgdVTrkUDdscMJcl3FNsrHc493krTb6B+SrISETvzg
	DUESxl0wd2+eZHETto2lKwFyqlXhUshqi2R3sq/lCEMhFOKGxtsDADW3Cs+uh/O9PPzDFUCFuBe
	2foI93VA3yDhhXkLRDEkwizCc8OXh9CBQ3eLKo2BlHUcdRt6QO8c=
X-Received: by 2002:a05:6000:24c7:b0:43d:740:fb37 with SMTP id
 ffacd0b85a97d-43fe3dfbe4emr11719802f8f.24.1776544778694; Sat, 18 Apr 2026
 13:39:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418171701.610025-4-memxor@gmail.com> <20260418183505.C472CC19424@smtp.kernel.org>
In-Reply-To: <20260418183505.C472CC19424@smtp.kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 18 Apr 2026 21:38:59 +0100
X-Gm-Features: AQROBzB6SMZ2S6lrMon_R5EKDogFQZq-M437qqtBZ-YPOIMsNYojGUycMEw0UC4
Message-ID: <CAP01T770m0vig=uxJw+GU3_km=dS6ShF2RM2XYrgSp90LxERew@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/4] libbpf: Request verifier warnings for
 object loads
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 18 Apr 2026 at 19:35, <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 3 potential issue(s):
> - [High] Valid BPF programs fail to load when a custom log buffer is too =
small to fit warnings.
> - [High] Massive performance and memory regression for valid programs gen=
erating warnings.
> - [Low] Empty debug logs are printed for every successful load without wa=
rnings.
> --
>
> commit ba31f1c82128deb94a4d629517c67a68ad69c567
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
>     libbpf: Request verifier warnings for object loads
>
>     On kernels supporting BPF_LOG_LEVEL_WARN, have libbpf request verifie=
r
>     warnings for BPF object program loads by ORing in the warning bit.  T=
his
>     keeps the existing log_level=3D0 retry semantics for verbose logs, wh=
ile
>     still surfacing verifier warnings for successful loads.
>
>     When libbpf owns the log buffer, use a small buffer for warning-only
>     loads and flush captured warnings through the print callback. Detect
>     support by probing for BPF_FEAT_VERIFIER_WARNINGS in enum bpf_feature=
s,
>     and document the updated kernel_log_level behavior.
>
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 3a80a018fc7d5..c7b00c0976983 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
>
> [ ... ]
>
> > @@ -7936,7 +7940,9 @@ static int bpf_object_load_prog(struct bpf_object=
 *obj, struct bpf_program *prog
> >                       log_buf_size =3D obj->log_size;
> >                       own_log_buf =3D false;
> >               } else {
> > -                     log_buf_size =3D max((size_t)BPF_LOG_BUF_SIZE, lo=
g_buf_size * 2);
> > +                     log_buf_size =3D max(log_level =3D=3D 16 ? warn_l=
og_buf_size :
> > +                                        (size_t)BPF_LOG_BUF_SIZE,
> > +                                        log_buf_size * 2);
> >                       tmp =3D realloc(log_buf, log_buf_size);
>
> If a valid program generates more than 4096 bytes (warn_log_buf_size) of
> warnings, won't the kernel's bpf_vlog_finalize() detect the log truncatio=
n
> and return -ENOSPC, causing bpf_prog_load() to fail?

Good point, will check this corner case.
That said, we only warn once for every kfunc, so it would require 4096
unique kfunc calls.
In any case, will take a look.

>
> [ ... ]
>
> >       ret =3D bpf_prog_load(prog->type, prog_name, license, insns, insn=
s_cnt, &load_attr);
> >       if (ret >=3D 0) {
> > -             if (log_level && own_log_buf) {
> > +             if (log_level =3D=3D 16 && load_attr.log_true_size && own=
_log_buf) {
> > +                     pr_warn("prog '%s': -- BEGIN PROG LOAD WARNINGS -=
-\n%s-- END PROG LOAD WARNINGS --\n",
> > +                             prog->name, log_buf);
> > +             } else if (log_level && own_log_buf) {
>
> If the program loads successfully and generates no warnings, load_attr.lo=
g_true_size
> will be 0. Doesn't this skip the first check and fall through to the else=
-if,
> causing libbpf to unconditionally print an empty debug log for every succ=
essful load?

Hmm, good point, we should strip BPF_LOG_LEVEL_WARN for this test.
We will always set |=3D 16 on newer kernels, otherwise, we keep zero as
the default log level. Thus, the second branch is hit only if the log
level is non-zero.

>
> >                       pr_debug("prog '%s': -- BEGIN PROG LOAD LOG --\n%=
s-- END PROG LOAD LOG --\n",
> >                                prog->name, log_buf);
> >               }
>
> [ ... ]
>
> > @@ -7981,8 +7990,8 @@ static int bpf_object_load_prog(struct bpf_object=
 *obj, struct bpf_program *prog
> >               goto out;
> >       }
> >
> > -     if (log_level =3D=3D 0) {
> > -             log_level =3D 1;
> > +     if (log_level =3D=3D (supports_verifier_warnings ? 16 : 0)) {
> > +             log_level =3D 1 | (supports_verifier_warnings ? 16 : 0);
> >               goto retry_load;
> >       }
>
> If the kernel returns -ENOSPC because the warnings did not fit in the buf=
fer,
> we hit this retry logic and bump log_level to 17 (BPF_LOG_LEVEL1 | BPF_LO=
G_LEVEL_WARN).
>
> If the user provided a custom log buffer (own_log_buf =3D=3D false), libb=
pf will not
> resize it before retrying. Won't the second attempt also fail with -ENOSP=
C,
> causing a valid program to fail to load simply because its warnings didn'=
t fit
> the custom buffer?
>
> Additionally, if own_log_buf =3D=3D true and we failed because the warnin=
gs exceeded
> the initial 4096-byte buffer, retrying with log_level =3D 17 will allocat=
e a 16MB
> buffer and trigger a full instruction-by-instruction verification trace. =
Won't
> this cause a massive CPU and memory regression just to load a valid progr=
am?

Sounds similar to the case earlier, I will study it while addressing that.


>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260418171701.61=
0025-1-memxor@gmail.com?part=3D3
