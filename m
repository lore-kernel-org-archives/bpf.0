Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE704252A7
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 20:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784750667; cv=none; b=JA+nIUIxbB5ROcaIn5cPzytLEX/5GYv2qTkiyfq2R3qZlGFUSlAnIWE+vE6iBFvYThR6hraDhGN3v5J5LrQw/0g8+g1ptzeozLLp/2olKm2yV10yTBLUsUnEN6oEIeUx7/rm3XuGC18rc6lPMExEZcPkYzuRQborQGFXTRuc9y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784750667; c=relaxed/simple;
	bh=pIjcWlM5/CgYav7MZHObfJcabQ9j3QwZIt1j0Cijh1s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ltJ66AMPyoLjEoULH1w/IqjBdzUehPFgwklN3ejysds4BTIh5iZfM9nhZ/KWfqswlVv8EE59k23HU6MtHuqSKbMBZJNBqFwHLEL4dLPa4kAzglIdtTDutLTGmav+dEE85ukPL64QcVCcvXrphALqjIFoLilmgWQF6MwEKja0awE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qzF720pW; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzF720pW"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c9fe3c9bd5fso4222131a12.0
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 13:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784750666; x=1785355466; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0SOlgOEitAgYO12VWoGRqOO8vUzHZ+DrnB7f3Z1kBfw=;
        b=qzF720pWOS741Xwt/ZrPvkrJHy6oS3w98MgZk7/xTwni+D89/A4+R8O462Mo5wgu0L
         LbCiVVMiefHMQgxk0fI6is/i1mxkdFD/KUJG6zrdr4Cg1xOhdgGTDApOpOpJW33awv+W
         ijuHPxY1kUTqudDNdIQXELwv+lHs0LLpBr9J2g4zem6h/fyr52ruHyxyxIPeDuAl2OVQ
         iW75sOuQYREWj0WhsGiWVo9tLMePwklLUg3OAiO7wzicpam6NWqDI/Ron069elviAvRH
         slNAWoz/6jSLbNo+pPa+KdGd5QlkCSfLcGRP0GuNst6oNzu6K/cmGYrGEqoio/bDB0ds
         Bxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784750666; x=1785355466;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0SOlgOEitAgYO12VWoGRqOO8vUzHZ+DrnB7f3Z1kBfw=;
        b=kuvL8y3sp2Ld3pB/vhda/YxvM+ASvbg2zRdsB/8wpB00eYV1py89mniBCuZYTXCyxD
         h3EGfv/4/NbkE8naHxPzknzOm8akJwSGlWx0Fs/mPfzlDpHxZB6cf+dec5FJ8PW7hWnw
         NYrHYteeZ3rJHIDpBiO83xWWBpFic3TiOnH433a3mPmtJNl0Q5V9xjfGhlalrVoME8FT
         pRLHxEW70K61vORP1IUTFdgdqQQm8ylIc3z7jMJQCKl5HP6ZpG58TXi1dW5bJWzJD7TO
         JTBlv/uOuyMvRE9cj1WGXM511TZVuTiGDztKC5EaaigoLXM3wdQhwDWf9D/CAZSqmFLS
         2FNw==
X-Forwarded-Encrypted: i=1; AHgh+Rpl2n8k/TNQEATIpYaymk0i7JlVmdTC7j3rhWb5aO8Ju2jAZikZ6LrgYzxrB8oUmG9P3O4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM7lwgifyzocud47og5wQkV/9SF9N89ePXD7KJIkQ5QvDWL8tK
	Z963sWz9kaKOMiWeO5p/bGSaItjwRVUcH/TGUNgoRGNshd9n+5S9Dxc9
X-Gm-Gg: AR+sD134P0x/fDnmEZcAhUciwUlJYosfx8UEr8xA/ET9RQebtxqXSKhDD8M1dgQT7PX
	qYc9epPJZLVl4pEsZ2pey2xDEG3JIIKsEP1mLQp904mqfyPxb/fYnguaB2RvrijgXnYxMjjOWsz
	nuv23inN6HxyE9HMdPZM2v338CMCl3myoFzn3w4pavAAh3U0VrrHt+LABmPxg2sKHa3ms8WsUuW
	5Hr83pCDzOKL1oFSzeFrPr+UhCei45ihMqs2Mc1m6N/Fo5ZQMDtJpYbgLdxK1eEfPUzDfzbpad1
	5nqOMU6pfjmi07yoOpfSITOxELmjVqjxENX8LU/NM/0FSxFbFALbcO2FNeaDDZKKSHTksCctft+
	PjudB3O/6EwWlVlKxIBoqYnrVqCuRr+k6mQzabormVvr7TSb1DoQ0NeM+5WQVoXM6zyYgy7KkKk
	ghEiqjXwNKsp5yYXrx8qjqO/mYVdnNQ9UgPYEWrZWLynDm6qRcjABVAVmTTvo=
X-Received: by 2002:a05:6300:2209:b0:3b3:3506:cf3f with SMTP id adf61e73a8af0-3c42922702cmr5513927637.1.1784750665629;
        Wed, 22 Jul 2026 13:04:25 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:d806:89cb:d651:6dc8? ([2620:10d:c090:500::1:d474])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147df097e0sm12616941eec.17.2026.07.22.13.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 13:04:25 -0700 (PDT)
Message-ID: <1ce45b3ac7411e585d3554ee12489dc5a56bfd41.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 1/3] selftests/bpf: extract BPF skeleton
 generation into a helper script
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykola Lysenko <nickolay.lysenko@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, 	song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, memxor@gmail.com
Date: Wed, 22 Jul 2026 13:04:23 -0700
In-Reply-To: <20260722040830.387979-2-nickolay.lysenko@gmail.com>
References: <20260722040830.387979-1-nickolay.lysenko@gmail.com>
	 <20260722040830.387979-2-nickolay.lysenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-07-21 at 21:08 -0700, Mykola Lysenko wrote:

...

Overall lgtm, please see some notes below.

>  tools/testing/selftests/bpf/Makefile        | 99 ++++++---------------
>  tools/testing/selftests/bpf/gen_bpf_skel.sh | 97 ++++++++++++++++++++
>  2 files changed, 125 insertions(+), 71 deletions(-)
>  create mode 100755 tools/testing/selftests/bpf/gen_bpf_skel.sh
>=20
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 55d394438..09e5be201 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile

...

> +$(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_OUTPUT)/%: $$$$(%-deps) $(BPFTOOL=
) gen_bpf_skel.sh | $(TRUNNER_OUTPUT)
> +	$(Q)BPFTOOL=3D$$(BPFTOOL) ./gen_bpf_skel.sh --tag '$(TRUNNER_BINARY)'	\
> +		--name $$(notdir $$(@:.skel.h=3D)) --infix linked			\
> +		--skel $$@ --subskel $$(@:.skel.h=3D.subskel.h)			\
> +		$$(addprefix $(TRUNNER_OUTPUT)/,$$($$(@F)-deps)) $(if $(PERMISSIVE),||=
 { \

Rant: I should have voiced a concern with the PERMISSIVE patch-set earlier.
      The level of it's invasiveness is appalling, it should have never bee=
n
      merged. How are we supposed to write the makefile now, allow each tar=
get
      to fail?

      Here is a follow-up: make it so the selftests are never dependent on =
host's
      headers to compile bpf and drop this PERMISSIVE bs.

> +		$$(RM) $$@ $$(@:.skel.h=3D.subskel.h);				\
> +		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; })
> =20
>  # When the compiler generates a %.d file, only skel basenames (not
>  # full paths) are specified as prerequisites for corresponding %.o
> diff --git a/tools/testing/selftests/bpf/gen_bpf_skel.sh b/tools/testing/=
selftests/bpf/gen_bpf_skel.sh
> new file mode 100755
> index 000000000..0b237f639
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/gen_bpf_skel.sh
> @@ -0,0 +1,97 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Link BPF object file(s) with "bpftool gen object" and generate a
> +# skeleton (or light skeleton) header from the result.
> +#
> +# Usage:
> +#   BPFTOOL=3D<bpftool> gen_bpf_skel.sh --name NAME --skel OUT [options]=
 OBJ...
> +#
> +#   --name NAME       skeleton object name ("name NAME" for bpftool)
> +#   --skel OUT        output header ("foo.skel.h" or "foo.lskel.h")
> +#   --subskel OUT     also generate a subskeleton header into OUT
> +#   --lskel           generate a light skeleton (bpftool gen skeleton -L=
)
> +#   --sign 'ARGS'     extra "gen skeleton" args for signing (-S -k .. -i=
 ..)
> +#   --tag TAG         build-log tag, e.g. "test_progs-no_alu32"
> +#   --infix STR       intermediate file infix (default: linked). Callers
> +#                     generating both a .skel.h and a .lskel.h from the
> +#                     same .bpf.o MUST use distinct infixes, or parallel
> +#                     builds race on the intermediate files.

Let's drop the --infix parameter and construct one locally based on
--skel --lskel --sign --name etc.

> +#   --no-determinism-check
> +#                     link the inputs once instead of three times.
> +#                     By default the object is re-linked twice more and
> +#                     the 2nd and 3rd results compared, as a regression
> +#                     test for the determinism of "bpftool gen object".
> +#
> +# The bpftool binary is taken from $BPFTOOL (default: bpftool from PATH)=
.
> +# On failure all outputs and intermediates are removed and the script
> +# exits non-zero; permissive-mode skipping is the caller's business
> +# (see skip_on_fail in Makefile.buildvars).
> +
> +set -u
> +
> +bpftool=3D${BPFTOOL:-bpftool}
> +name=3D'' skel=3D'' subskel=3D'' tag=3D'' sign_args=3D'' infix=3Dlinked
> +lskel=3D0 det_check=3D1
> +
> +while [ $# -gt 0 ]; do
> +	case "$1" in
> +	--name)		name=3D$2; shift 2 ;;
> +	--skel)		skel=3D$2; shift 2 ;;
> +	--subskel)	subskel=3D$2; shift 2 ;;
> +	--tag)		tag=3D$2; shift 2 ;;
> +	--infix)	infix=3D$2; shift 2 ;;
> +	--sign)		sign_args=3D$2; shift 2 ;;

So this passes sign arguments from the makefile, let's keep this a
boolean flag instead and set the sign_args internally in the script.

> +	--lskel)	lskel=3D1; shift ;;
> +	--no-determinism-check) det_check=3D0; shift ;;

This flag is never set, let's drop it.

> +	--)		shift; break ;;
> +	-*)		echo "$0: unknown option: $1" >&2; exit 1 ;;
> +	*)		break ;;
> +	esac
> +done
> +
> +if [ -z "$name" ] || [ -z "$skel" ] || [ $# -eq 0 ]; then
> +	echo "usage: $0 --name NAME --skel OUT [options] OBJ..." >&2
> +	exit 1
> +fi
> +
> +base=3D${skel%.skel.h}
> +base=3D${base%.lskel.h}
> +t1=3D$base.${infix}1.o
> +t2=3D$base.${infix}2.o
> +t3=3D$base.${infix}3.o
> +
> +fail() {
> +	rm -f "$skel" ${subskel:+"$subskel"} "$t1" "$t2" "$t3"
> +	exit 1
> +}
> +
> +if [ $# -gt 1 ]; then
> +	printf '  %-12s %s\n' 'LINK-BPF' "${tag:+[$tag] }$(basename "$base").bp=
f.o" >&2
> +fi
> +printf '  %-12s %s\n' 'GEN-SKEL' "${tag:+[$tag] }$(basename "$skel")" >&=
2

Let's also drop --tag and move these printfs to the Makefile / Makefile.run=
ner.

> +
> +"$bpftool" gen object "$t1" "$@" || fail
> +final=3D$t1
> +if [ "$det_check" -eq 1 ]; then
> +	"$bpftool" gen object "$t2" "$t1" || fail
> +	"$bpftool" gen object "$t3" "$t2" || fail
> +	if ! cmp -s "$t2" "$t3"; then
> +		echo "$0: bpftool gen object is not deterministic for $skel" >&2
> +		fail
> +	fi
> +	final=3D$t3
> +fi
> +
> +flags=3D
> +[ "$lskel" -eq 1 ] && flags=3D-L
> +# $sign_args intentionally unquoted: it is a list of bpftool arguments
> +# shellcheck disable=3DSC2086

The shellcheck directive is noise, same for "intentionally unquoted" commen=
t.

> +"$bpftool" gen skeleton $sign_args $flags "$final" name "$name" > "$skel=
" || fail
> +
> +if [ -n "$subskel" ]; then
> +	"$bpftool" gen subskeleton "$final" name "$name" > "$subskel" || fail
> +fi
> +
> +rm -f "$t1" "$t2" "$t3"
> +exit 0
