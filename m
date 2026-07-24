Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFCC4908C7
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 01:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784856439; cv=pass; b=tFeU9TUauH7DzW+jG2R/F7cDxpwEbUEAGPMF4XGd82int8ATw1D/FVrflfUItsW6wSi1d3B0Kv3GlCuHnHP43jTpuzmbMjUxucpl8stSd2S32OU6UHipR3hEmGKjzY/SWe12x7Y4QDj2tIllQzpWzb8cjBpWds4fmkMZHT4lLOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784856439; c=relaxed/simple;
	bh=i6FbKyiX8wil2mCAKiEVuMZRT1biF82RHk6t3HD5eKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fEuQKyQl1JSihRC1mpRN9HheyAJd7hUbP24CLFsWKvVEAu0K4uexSRIj2dctxadaa7LKFcteYDzXO44ItZj9b8EpxiFsoQ68DfUMiYN1HxTiFYGpA8WzrWKTFSdo9cXZxlXbP3U+sk18S9/Op4EFCJ9N264BIjRIJirXg0sNxR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XT8OIQHC; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XT8OIQHC"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c1670dad7a8so204853766b.3
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 18:27:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784856435; cv=none;
        d=google.com; s=arc-20260327;
        b=E9iaASXfRaxf4dl5kAKMkPYr267oBAb/gU+OXBAOHl/jq7HjOIEobDK/RxgxXr7g/K
         UWuQRvOlKbRCtGuQhIVr10y1tFsL/MzcrYbCI+QuewUjXd+NeDdNM9JR1WkF2e1LKPZ2
         bq4b+9tMYoXp1W4FGHHquajbrSAfSGNLUPiY81Xng7Se9ja9ppnqCB3PjhsrM+mSLVhj
         OUd6rn9AIckFOVFAUFt3mZBU09SuJTXkAeRM1kmOlgnSas5tsypgpt71zW27XK6bKyJz
         axzTID3D4RNRHtprjnPR5HvvHPDdAnvzwf55QqGlomjzz42ZWevTt4PlzY5Pj2cuk5MP
         ae/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pfH6OzkyUnJg8mgaz8oWVr3UEOINj5n1NOSEE96CHHA=;
        fh=FthGvuR3K9/4OOpgmQJp7FB64mSmSiZB6V3xeZ/77Q8=;
        b=jZxUVaXYSB4epVhzj4PrUT3DG20Hj9BWFV/cgMY+rnvdCZxqT8v0UL26zkO9mAJm5F
         c0ri7w4ILk4w9a2FYwQSzf3Zb74+hx51ZoksR/qOQJBLJw+GrEOLs70JQjRafm0oqz8K
         lglhyYmj2dHWoqhEk6/TMXWhgTvrDBZguVHOOpUO8gFQYD7jGrVGUm4L1TdC4n1+gJs/
         0wY6nkIayhJp8zlgHNJ5HutavOZS3frUnreN2Xczhy+a/UtYmZb6CKSvdHNNVjNbFmAn
         1Zf6sksTUqgMNM8LeqXRhpAMIP26mfOQtcGRQ7fy6vbYSxtb5OLLoOGtnKnbHsdm8CD/
         lxqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784856435; x=1785461235; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pfH6OzkyUnJg8mgaz8oWVr3UEOINj5n1NOSEE96CHHA=;
        b=XT8OIQHCU71b5uEGmjMyn51IIeJCOcIRnqxTNUUdJO1bLfGSvisTCsH5deWP0064GA
         zRy73LxUW7bvP6+GB7Wi83rqijVjiMfaNLxoTn89sHQxXBzZs51VLv6eyEJ1Koz/54J9
         tDzeSrL752yBckU4q3geDHjUj7OskATiVlLsZM9aDMsbH4n+PsIk6uYiQ4KEJakXcHHx
         pgjS7OhvG7pcRhH1LDYYRzeeX5ow8SHdW3q1WWSdEtby5tCcDRVdGFwjRQPBMh1e4I3g
         D2WZ7QjoxRV+Bv1v7FXbITXA/unybGuYMiShZ8yokvk74XwG2W8jj0yz7m4KyUH6hgD8
         vUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784856435; x=1785461235;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pfH6OzkyUnJg8mgaz8oWVr3UEOINj5n1NOSEE96CHHA=;
        b=ZW0SInsQIJPxk2GVm+XW5HheB+G4mjnJZZikqQChrYyfZSRAqQMeqLX352J9lIGlAQ
         lgGY1+m7kmhgnY0bSuIqDRZsVyNXeUT52csxiaL84bm16Aw3ARs6Xbqig3DhVIJI5WrF
         Uiyt20H4sEQt5I5leSsoGGlBvB3Zbu3S1wphSRIF7nDk98vDu+aO0pYFyUQjSHMhbh1q
         maqwQNahRLsgVHYShpismTUmla8SXw/rz5ahZGcFt4MnO9nburr2Sst0QLdOKk3nX85X
         B+1CyEIKgCZuRj999wLPyi60+Jx0s3O3Ne2YTpnNlM7NB3+oYJ0WCySWKUbwcVP4fVpw
         8Mrg==
X-Gm-Message-State: AOJu0YyNGCK+SZt1qXGXPJ3KASgWUBlzjgSZZ5hwNJQ9urwZmDPkc33g
	MutRWATAXMa3dCggI+WXUUz18Dm2eMYmv716hTWW3YXAyqhgBOuS6EDMQ5TpUnH7wzcwybFQsQ6
	6RDgCfjWF/aQ2pSx0zMrAvXDOr3zcyLM=
X-Gm-Gg: AR+sD13s+Guya8l9c5YmQjs/QByaxT4Mn6ZPjMIF3f4TnCQ6wMn3o2kvGe89U7QvrOR
	FwPMNbukxcilG0gC/QnM/yH2GaMWexYFfgGXkzeRQu5NS32+cpAPMSv+ZQXvclQF94Ud4YkyATW
	FTO+qrR/uH23DUpC7QBFoKnvcg6SiT0Zyjufac+qli7nEvKq056rK5EUpBSeCqQtb5lNN4QTq4h
	YAKYtKDLqW+0TxPNVKgZlRnVZLiGZJUyALPwt9YcLfGYsqxYp2Agyi73gLIV1kgGg/R5h+0I7OO
	6aIncyShXd13WbiQUtQ=
X-Received: by 2002:a17:906:a348:20b0:c15:fc9d:cf3c with SMTP id
 a640c23a62f3a-c1c50bfe071mr159764566b.42.1784856434951; Thu, 23 Jul 2026
 18:27:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722040830.387979-1-nickolay.lysenko@gmail.com>
 <20260722040830.387979-2-nickolay.lysenko@gmail.com> <1ce45b3ac7411e585d3554ee12489dc5a56bfd41.camel@gmail.com>
In-Reply-To: <1ce45b3ac7411e585d3554ee12489dc5a56bfd41.camel@gmail.com>
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
Date: Thu, 23 Jul 2026 18:27:03 -0700
X-Gm-Features: AUfX_myWVuLhyPKYqP57ZHQ172Q40ov2J1gEANR__YTDIW3nHk0851MTaFDv_Cc
Message-ID: <CAMtxOX0ems30XebDVfVnhkRmwmV3bevgT_Pw2kUsKVPUL8j_pA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 1/3] selftests/bpf: extract BPF skeleton
 generation into a helper script
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 1:04=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2026-07-21 at 21:08 -0700, Mykola Lysenko wrote:
>
> ...
>
> Overall lgtm, please see some notes below.

Thanks! All five notes are addressed in v4.

>
> >  tools/testing/selftests/bpf/Makefile        | 99 ++++++---------------
> >  tools/testing/selftests/bpf/gen_bpf_skel.sh | 97 ++++++++++++++++++++
> >  2 files changed, 125 insertions(+), 71 deletions(-)
> >  create mode 100755 tools/testing/selftests/bpf/gen_bpf_skel.sh
> >
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selft=
ests/bpf/Makefile
> > index 55d394438..09e5be201 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
>
> ...
>
> > +$(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_OUTPUT)/%: $$$$(%-deps) $(BPFTO=
OL) gen_bpf_skel.sh | $(TRUNNER_OUTPUT)
> > +     $(Q)BPFTOOL=3D$$(BPFTOOL) ./gen_bpf_skel.sh --tag '$(TRUNNER_BINA=
RY)'     \
> > +             --name $$(notdir $$(@:.skel.h=3D)) --infix linked        =
         \
> > +             --skel $$@ --subskel $$(@:.skel.h=3D.subskel.h)          =
         \
> > +             $$(addprefix $(TRUNNER_OUTPUT)/,$$($$(@F)-deps)) $(if $(P=
ERMISSIVE),|| { \
>
> Rant: I should have voiced a concern with the PERMISSIVE patch-set earlie=
r.
>       The level of it's invasiveness is appalling, it should have never b=
een
>       merged. How are we supposed to write the makefile now, allow each t=
arget
>       to fail?
>
>       Here is a follow-up: make it so the selftests are never dependent o=
n host's
>       headers to compile bpf and drop this PERMISSIVE bs.
>

I'd be glad to send the removal as a follow-up
on top of this series.

> > +             $$(RM) $$@ $$(@:.skel.h=3D.subskel.h);                   =
         \
> > +             printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; =
})
> >
> >  # When the compiler generates a %.d file, only skel basenames (not
> >  # full paths) are specified as prerequisites for corresponding %.o
> > diff --git a/tools/testing/selftests/bpf/gen_bpf_skel.sh b/tools/testin=
g/selftests/bpf/gen_bpf_skel.sh
> > new file mode 100755
> > index 000000000..0b237f639
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/gen_bpf_skel.sh
> > @@ -0,0 +1,97 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Link BPF object file(s) with "bpftool gen object" and generate a
> > +# skeleton (or light skeleton) header from the result.
> > +#
> > +# Usage:
> > +#   BPFTOOL=3D<bpftool> gen_bpf_skel.sh --name NAME --skel OUT [option=
s] OBJ...
> > +#
> > +#   --name NAME       skeleton object name ("name NAME" for bpftool)
> > +#   --skel OUT        output header ("foo.skel.h" or "foo.lskel.h")
> > +#   --subskel OUT     also generate a subskeleton header into OUT
> > +#   --lskel           generate a light skeleton (bpftool gen skeleton =
-L)
> > +#   --sign 'ARGS'     extra "gen skeleton" args for signing (-S -k .. =
-i ..)
> > +#   --tag TAG         build-log tag, e.g. "test_progs-no_alu32"
> > +#   --infix STR       intermediate file infix (default: linked). Calle=
rs
> > +#                     generating both a .skel.h and a .lskel.h from th=
e
> > +#                     same .bpf.o MUST use distinct infixes, or parall=
el
> > +#                     builds race on the intermediate files.
>
> Let's drop the --infix parameter and construct one locally based on
> --skel --lskel --sign --name etc.

Done. The script derives it: "llinked" when --lskel or --sign,
"linked" otherwise, which reproduces the old call sites exactly.

>
> > +#   --no-determinism-check
> > +#                     link the inputs once instead of three times.
> > +#                     By default the object is re-linked twice more an=
d
> > +#                     the 2nd and 3rd results compared, as a regressio=
n
> > +#                     test for the determinism of "bpftool gen object"=
.
> > +#
> > +# The bpftool binary is taken from $BPFTOOL (default: bpftool from PAT=
H).
> > +# On failure all outputs and intermediates are removed and the script
> > +# exits non-zero; permissive-mode skipping is the caller's business
> > +# (see skip_on_fail in Makefile.buildvars).
> > +
> > +set -u
> > +
> > +bpftool=3D${BPFTOOL:-bpftool}
> > +name=3D'' skel=3D'' subskel=3D'' tag=3D'' sign_args=3D'' infix=3Dlinke=
d
> > +lskel=3D0 det_check=3D1
> > +
> > +while [ $# -gt 0 ]; do
> > +     case "$1" in
> > +     --name)         name=3D$2; shift 2 ;;
> > +     --skel)         skel=3D$2; shift 2 ;;
> > +     --subskel)      subskel=3D$2; shift 2 ;;
> > +     --tag)          tag=3D$2; shift 2 ;;
> > +     --infix)        infix=3D$2; shift 2 ;;
> > +     --sign)         sign_args=3D$2; shift 2 ;;
>
> So this passes sign arguments from the makefile, let's keep this a
> boolean flag instead and set the sign_args internally in the script.

Done. --sign is a boolean; the key and certificate come from
$PRIVATE_KEY and $VERIFICATION_CERT in the environment, same pattern
as $BPFTOOL.

>
> > +     --lskel)        lskel=3D1; shift ;;
> > +     --no-determinism-check) det_check=3D0; shift ;;
>
> This flag is never set, let's drop it.

Done, the determinism check is unconditional now.

>
> > +     --)             shift; break ;;
> > +     -*)             echo "$0: unknown option: $1" >&2; exit 1 ;;
> > +     *)              break ;;
> > +     esac
> > +done
> > +
> > +if [ -z "$name" ] || [ -z "$skel" ] || [ $# -eq 0 ]; then
> > +     echo "usage: $0 --name NAME --skel OUT [options] OBJ..." >&2
> > +     exit 1
> > +fi
> > +
> > +base=3D${skel%.skel.h}
> > +base=3D${base%.lskel.h}
> > +t1=3D$base.${infix}1.o
> > +t2=3D$base.${infix}2.o
> > +t3=3D$base.${infix}3.o
> > +
> > +fail() {
> > +     rm -f "$skel" ${subskel:+"$subskel"} "$t1" "$t2" "$t3"
> > +     exit 1
> > +}
> > +
> > +if [ $# -gt 1 ]; then
> > +     printf '  %-12s %s\n' 'LINK-BPF' "${tag:+[$tag] }$(basename "$bas=
e").bpf.o" >&2
> > +fi
> > +printf '  %-12s %s\n' 'GEN-SKEL' "${tag:+[$tag] }$(basename "$skel")" =
>&2
>
> Let's also drop --tag and move these printfs to the Makefile / Makefile.r=
unner.

Done. The recipes use the usual $(call msg,...) helpers.

>
> > +
> > +"$bpftool" gen object "$t1" "$@" || fail
> > +final=3D$t1
> > +if [ "$det_check" -eq 1 ]; then
> > +     "$bpftool" gen object "$t2" "$t1" || fail
> > +     "$bpftool" gen object "$t3" "$t2" || fail
> > +     if ! cmp -s "$t2" "$t3"; then
> > +             echo "$0: bpftool gen object is not deterministic for $sk=
el" >&2
> > +             fail
> > +     fi
> > +     final=3D$t3
> > +fi
> > +
> > +flags=3D
> > +[ "$lskel" -eq 1 ] && flags=3D-L
> > +# $sign_args intentionally unquoted: it is a list of bpftool arguments
> > +# shellcheck disable=3DSC2086
>
> The shellcheck directive is noise, same for "intentionally unquoted" comm=
ent.

Both gone. With --sign boolean the signing arguments are built as a
bash array inside the script, so nothing is expanded unquoted anymore.

>
> > +"$bpftool" gen skeleton $sign_args $flags "$final" name "$name" > "$sk=
el" || fail
> > +
> > +if [ -n "$subskel" ]; then
> > +     "$bpftool" gen subskeleton "$final" name "$name" > "$subskel" || =
fail
> > +fi
> > +
> > +rm -f "$t1" "$t2" "$t3"
> > +exit 0
