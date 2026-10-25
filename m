Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792934588;
	b=hWiE9pzznhwar83zowX7J03pfmtv/dCpAcBmsZxB7Ir3TZm/8FaLiXyXZ3owoU+gPEjg
	 qV/OEE+0YLAfabIEkME3AinZ17taONB4y5e8RUP0r0430gQ8tIqeh0RMQ8TUxxwNBIW5u
	 dLpD65U3jXxsuu7DDZulC0E6h6kE0IhsGdlEze+TBR7f8FrTTM0S7NUo91hDkl0iiPkno
	 MzuIsdpH8P00/udVnxt8kYagP4tdmU01Db+utKj5NoWzZ1kj89DiglmV048y4QwHGlCs7
	 E8YhEB56gV4DIEpls1KgmLqurO0ZeMP1UaJM1cS7H8hKuT3MkEup/Wcyfd7qBCaMmQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792934588;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=X6vbMJkh4xPzuEcl9o4UTbdDi9m9a6y5s+AAwaTb/VE=;
	b=1/suA2A49Rq6xdKgBoKHNDTiBCwg7DdULG69cX+RwQ/m3s94FDTmrbDfP/ugZy9SkpRV
	 JQIQcXxbS3eO4SscOiRb+OZ83TtUs0WrPkWYu0PmB3l/B5D5/YCuKB1ZmEJHTyYBRG7OS
	 Acm7NrNlmqBayRxLR3YI79tVk/xgx2VcG+Ew1c3qWGxNnPyWh/sO7AdjWue9IcPigPq4R
	 pOmPJ5LNF1sLoG2zAb3XY9st4gKWLtadWYwNKcXY5Y2IKRlV2MgV999lXdkp+mDl/9/cx
	 b/M1kSH30HeGKBiqsYFtgZwxg+QS/UVNHuqwmy/IH9CMl7H4RaFhYVsq/NOR+CAiuyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jPKsLWh1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FA9606A31B
	for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 13:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50FA9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jPKsLWh1
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91b55859245so13209166d6.0
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 06:23:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792934587; cv=none;
        d=google.com; s=arc-20260327;
        b=gturA8+d69XrXrhrBxNVSzQO1D652kGKsZP+OopFeRxVqKBW1XT2WhzwyyIXjL48rw
         MqUzOIovmhwuBkufSS2KpV5rODCcKm6zgjfnIE40sUFJwPV/AB0H1rRkZR3q3z8tDQt0
         My5fH62xp3qzisXVxLwHykKddUh3RvFXcrDtl5jx78R5OWogWsEoTQGwP2G9hzQokzWd
         mKU9kzUAImSG9nDnxlLEnfA2XAt5Grx2OhaVEdwpl8TEQZ+W4UJgIYOFa8NmcjR9Z6WH
         XUuZ/rwqacRFWz8X6DLwqUcQ4T9PfqC21YnHP+zZiC8GJCNU9wyCiGD0SBVMs7rm4WDt
         utaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X6vbMJkh4xPzuEcl9o4UTbdDi9m9a6y5s+AAwaTb/VE=;
        fh=KQiOw23zBCsv7fl0SxToe1+AsqIO/+K6sYEi2ZtSCdA=;
        b=hxSJ5K3kSaBJyLHz32gdYIY8h2doXtmyxjFeeWFffui3XoMj/WnUFd73IWmhAEJJm5
         isMUqJ+XPetHw2afoHlAk6i/SJdZwJKlgWssS6JEECbJyQAO8Eenxz87PyFSGbRACowO
         qmS+E7wdT7rLm4fKSTNQWI/mwNokwE8bj31H2B2R0kL+ereFhjKvNr8lr4jZv6yY+LVD
         OOF+zQZD1MFdc6DnBt8EASgUDTq4JRo6CbcIM4D6WVTtxXwiiLBzy97gwFuHBAiP9EZB
         XDL7qp3r0JzaopkSOHBVMi+LGduPbodDRIHV5DD8i0iLdi8VIikn6q7NbqjxkwJrcptG
         mzew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792934587; x=1793539387; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X6vbMJkh4xPzuEcl9o4UTbdDi9m9a6y5s+AAwaTb/VE=;
        b=jPKsLWh1wQCx+uFkDMaGoQAlzMDmG0XPhV4wljunZLrs09EJyBKRKiDA58n7EuJ/4V
         je2zRLXEtjn1PhsqD28scCYrTMNv37rUYlCCKHjmP+gT4bsRCiOOOEyB14bQkkJ+OgdW
         RADNOn1ivHmCwSQ1sGI/l7e6xuwW/Gpdm2UHqe2TOEQ8on+feWUGlDCprsBXttntqwcv
         ALq9IW+2izLruIIjjsX2CbLCXSzafBAHmkmV7kAQhcM6h2DfnpxJw5CFdp10njk3vDHb
         mfxKOsQgrAX3CcjwG/Joa2GQFssuEbcS2WIHTr3cvhdk35eCu7wCsMeMNYb3UiA0FwXa
         oHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792934587; x=1793539387;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X6vbMJkh4xPzuEcl9o4UTbdDi9m9a6y5s+AAwaTb/VE=;
        b=JDBH8LY34SZWE7SCGnCxJ83u+wxrWjvS+D4V+kOzydOJOfiztt9v0H/Y2A/yHPDAxj
         ult4Q/E/0Atj/Y2lEoniJ0RgGfjjEjjd4aRjEbYTX6Rk1II3o8CoCyM2AS1MyTYtubq5
         c1RV+iAEkG71jzqJ0svVWKTWDwnKXjx6pKQzWyupMkznm+yNCrcG9anvCSlCBep21bJz
         pibEAu0D5n6KEAWi7UvKW9zJLLnozag5H8QCuWpXBSdGfxtt1hD87yD5Dlrfb2VUwuej
         xjNI/UEo1edExacOe4w1llubNqTTPvJOewr6I8B+FYwfGRft2Seo98OaFNNGJS5dWIXg
         9m5w==
X-Forwarded-Encrypted: i=1; AKwUvBxCI0NauVXiPzZRbp3FO+sA2fJU5uDDMW17j9Wpba0qv8Xi0hPAmSlS9DnhRw97yxBGJ8I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmjC2pOq1/qhSuKXiiVXXtvv05u3SmsgNr7PlZCPVhiufcmwmZ
	4fmcgSoLPamtofC5lurvLS0rgaD0U0wFFSQflpya+8/mqAv9JdrfP4xs1ketpPNoniW/fS1MQrB
	9F+Y38AZ4/OQmm7awO7CGeB4QZFb7BM0tzEq3
X-Gm-Gg: AYBFou0V1yi5RezHg5LneYJzJF3c2/LBKTfRRJ7JWRI9tKcvvOlNf1SM+AB6iCM6WNb
	UkQyLAjNLpRTuDgquO8Wci0/9+BYOxxhPxvkf29ZoD0rjh7ZVyYvhJmt2tJ/JZM01uWPmDmpFyq
	zH6GFze2BMc2+EbMN3JUXID7hnXADuCpK+GzdWv8Y0AzSz8ynzz4SlG8oXrOKMbgALq9thBbb89
	WBehNlr0GIb5gKhlzR5j1o0egeNYVQ0iR22ajWeaRcFI3lpRRXlq8zzDRhN7ljItFdCOAAHk8cC
	TTRyDuy5wU/yK8vD4I/TWX6Uhy8kPmHPdCcVi3WzpL9gFdcpq7IIllABkalAIP49ar7oPNDRAB4
	RmWO0yLJdO65Oqm4deqxt2Bxr4pHLEfoNKpzSy6WbtN4CGZngV2rjGx3v3V5RTh54Y5fOWvRaZD
	ftJz5TdxJgk/zSzsc/ZgQQGW9tbhw/WxinifixR47t5qEw2vtmFgKrHxrKiq+eUVMEZaMyE2ML
X-Received: by 2002:a05:6214:53c3:b0:91b:b26a:9791 with SMTP id
 6a1803df08f44-91c48f150camr69861666d6.56.1792934587195; Sun, 25 Oct 2026
 06:23:07 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022013432.2638010-1-gr3yf0x87@skyn3tlab.com> <20261022014811.2803450-1-gr3yf0x87@skyn3tlab.com>
In-Reply-To: <20261022014811.2803450-1-gr3yf0x87@skyn3tlab.com>
From: Daniel Pereira <danielmaraboo@gmail.com>
Date: Sun, 25 Oct 2026 10:22:55 -0300
X-Gm-Features: AclHuK9yewKN0-UZdNUV7XZr57BksERgCEoIcvborAR-JnzTIy1oVpZl5H1ou6Q
Message-ID: <CAMAsx6dgDhfNvw+3NWD1pBxyJfHTa7rUD+-9Y4L5K2FpDXJS6A@mail.gmail.com>
Subject: Re: [PATCH v2] docs: changes.rst: set the pahole minimum back to 1.22
To: gr3yf0x87@skyn3tlab.com
Cc: corbet@lwn.net, federico.vaga@vaga.pv.it, skhan@linuxfoundation.org, 
	rdunlap@infradead.org, ihor.solodrai@linux.dev, eddyz87@gmail.com, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026, Mark Severson wrote:
> Set the table back to 1.22, in the English document and in the Italian
> translation, which carries the same table, and remove the Italian
> translation's copy of the paragraph that the English document no longer
> has.

Hi Mark,

I went through v2 against the tree (docs-next at f857ff5bf):

- In Documentation/process/changes.rst the table says pahole 1.26,
while the text below it and lib/Kconfig.debug (DEBUG_INFO_BTF
depends on PAHOLE_VERSION >=3D 122) say 1.22, so the table is the odd
one out.
- tools/bpf/resolve_btfids/main.c now rewrites the prototype of
KF_IMPLICIT_ARGS kfuncs itself, which is consistent with the
explanation in the changelog for dropping the 1.26 requirement.
- The English document has no KF_IMPLICIT_ARGS paragraph any more, so
removing the Italian copy brings it_IT back in line with it.
- You mention that htmldocs was not run, so I built
SPHINXDIRS=3Dprocess and SPHINXDIRS=3Dtranslations/it_IT with the patch
applied: no new warnings compared to the unpatched tree. The
undefined-label warnings that show up in these two files also show
up without the patch in partial builds.

One process remark, which I leave to Jon: "Assisted-by:" is not a tag
that Documentation/process/ describes in docs-next, and checkpatch
flags it. I could not find the "Attribution" section of
coding-assistants.rst that the note mentions in this tree; it may be in
another one.

Reviewed-by: Daniel Pereira <danielmaraboo@gmail.com>

Thanks,
Daniel


Em qua., 21 de out. de 2026 =C3=A0s 22:48, Mark Severson
<gr3yf0x87@skyn3tlab.com> escreveu:
>
> Commit fd5425b67355 ("docs, resolve_btfids: Document kfunc BTF
> annotation emission") removed the paragraph saying that kfuncs annotated
> with KF_IMPLICIT_ARGS need pahole v1.26, because resolve_btfids now
> emits the kfunc BTF annotations that pahole used to produce. That
> paragraph was the reason the requirements table lists pahole 1.26, and
> the table was left unchanged. The text below the table and
> lib/Kconfig.debug (DEBUG_INFO_BTF depends on PAHOLE_VERSION >=3D 122)
> both still say 1.22.
>
> Set the table back to 1.22, in the English document and in the Italian
> translation, which carries the same table, and remove the Italian
> translation's copy of the paragraph that the English document no longer
> has.
>
> Checked by building linux-next 20261021 with pahole v1.25 and
> CONFIG_DEBUG_INFO_BTF=3Dy: in the vmlinux BTF,
> bpf_task_work_schedule_signal has four arguments and the bpf_kfunc decl
> tag, and bpf_task_work_schedule_signal_impl keeps the
> struct bpf_prog_aux * argument, as Documentation/bpf/kfuncs.rst
> describes for KF_IMPLICIT_ARGS.
>
> Fixes: fd5425b67355 ("docs, resolve_btfids: Document kfunc BTF annotation=
 emission")
> Assisted-by: Claude
> Signed-off-by: Mark Severson <gr3yf0x87@skyn3tlab.com>
> ---
> v2:
> - Also remove the Italian translation's copy of the KF_IMPLICIT_ARGS /
>   pahole 1.26 paragraph, which fd5425b67355 removed from the English
>   document only; v1 left the Italian text contradicting its own table.
>   Found by the Sashiko review of v1.
> v1: https://lore.kernel.org/all/20261022013432.2638010-1-gr3yf0x87@skyn3t=
lab.com/
>
> checkpatch reports the Assisted-by tag as non-standard; it follows the
> Attribution section of Documentation/process/coding-assistants.rst as
> published on docs.kernel.org. Not run: make htmldocs; the change keeps
> the table's column widths and removes a whole paragraph.
>
>  Documentation/process/changes.rst                    | 2 +-
>  Documentation/translations/it_IT/process/changes.rst | 8 +-------
>  2 files changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/process/changes.rst b/Documentation/process/ch=
anges.rst
> index 28f2ca633..13093c5c2 100644
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
> @@ -53,7 +53,7 @@ mcelog                 0.6              mcelog --versio=
n
>  mkimage (optional)     2017.01          mkimage --version
>  nfs-utils              1.0.5            showmount --version
>  openssl & libcrypto    1.0.0            openssl version
> -pahole                 1.26             pahole --version
> +pahole                 1.22             pahole --version
>  pcmciautils            004              pccardctl -V
>  pigz (optional)        2.4              pigz --version
>  PPP                    2.4.0            pppd --version
> diff --git a/Documentation/translations/it_IT/process/changes.rst b/Docum=
entation/translations/it_IT/process/changes.rst
> index 0be1292a8..b4accd428 100644
> --- a/Documentation/translations/it_IT/process/changes.rst
> +++ b/Documentation/translations/it_IT/process/changes.rst
> @@ -57,7 +57,7 @@ mcelog                 0.6              mcelog --versio=
n
>  mkimage (opzionale)    2017.01          mkimage --version
>  nfs-utils              1.0.5            showmount --version
>  openssl & libcrypto    1.0.0            openssl version
> -pahole                 1.26             pahole --version
> +pahole                 1.22             pahole --version
>  pcmciautils            004              pccardctl -V
>  PPP                    2.4.0            pppd --version
>  procps                 3.2.0            ps --version
> @@ -149,12 +149,6 @@ Dalla versione 5.2, quando viene impostato CONFIG_DE=
BUG_INFO_BTF, il sistema di
>  compilazione genera BTF (BPF Type Format) a partire da DWARF per vmlinux=
. Pi=C3=B9
>  tardi anche per i moduli. Questo richiede pahole v1.22 o successivo.
>
> -Dalla versione 7.0, le kfunc annotate con KF_IMPLICIT_ARGS richiedono pa=
hole
> -v1.26 o successivo. Senza questa versione, tali kfunc avranno prototipi =
BTF
> -errati in vmlinux, causando il fallimento del caricamento dei programmi =
BPF con
> -l'errore "func_proto incompatible with vmlinux". Molte kfunc in sched_ex=
t sono
> -interessate da questo problema.
> -
>  A seconda della distribuzione, lo si pu=C3=B2 trovare nei pacchetti 'dwa=
rves' o
>  'pahole'. Oppure lo si pu=C3=B2 trovare qui: https://fedorapeople.org/~a=
cme/dwarves/.
>
> --
> 2.43.0
>
>
