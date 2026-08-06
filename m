Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD3641835D
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 19:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786045676; cv=none; b=auIg3GM4yPq3TEeX0SI26bLdWs6/13jhNmCJf1Et5duT/ci5LB0cqz6psC7MeSRE0CQ7YzsBlq72er580UM1ioTHkqIezoVIzXNm4fBRK5oLDjVt5PV1WwxcYSCxI8asD5kSLHY8q/HtkYSOlE3m6iESkhlWyAAvpXFcZ4CTXpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786045676; c=relaxed/simple;
	bh=lsDK9lcIFOMRfbr/YMlgePOLaM/J8Ibj8blkAdOU8uE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e+tYxE7PTeIzX3BkwzomZLQIMl42PLV6eKHMsOMQfplTHxtKsR5xS8Ip9XYtrhAY3X7MAZooTTlgRioZqMe8jKT13Bx+qhrtlbpTOQdtniP3bWWQx/gmmyYsCdaEeJfzXOvkuj5xIdTdUJFllZl0Y9V8Los1bRdE/TTEbk7ZY8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlEwB8XF; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlEwB8XF"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cab973140bso36634575ad.3
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 12:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786045667; x=1786650467; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gpagyeNg5mdGrlGjQ9VRgQ5RWdHm2lIeKBjBzYmMwUA=;
        b=VlEwB8XFSGxG356TxBRg6hPBK/yenADTs19AjhTy4vcv+GJN8E+qT9rE8hpwFXK5PS
         LfREXsYryqHkkB0zCpH3RMFtSzJQWoAr9qqqwsVMxKiie5vGto3KRshBq0hLWAM6V2qo
         ssu7YZ9YbICAwp6lse47VGoygVNDiaaVKDo0RebTtwxIThUOFZ6U9Ya1mFSrLoQKUiLN
         tkd6dQngWWbgPbMNn1q7Tah3sDLPzMWW5fOBzA9jxYc9FIOSZuuHo/ArZObrHQN4or2u
         rcBQKcUDC4Ui7+sVwI1CGbFVcuwQyDI2UoOtoczr96L04UVDOwLxsaTwAKOIbQrQxws7
         Rnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786045667; x=1786650467;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gpagyeNg5mdGrlGjQ9VRgQ5RWdHm2lIeKBjBzYmMwUA=;
        b=krT1t6zQXqUZ32F9Fq7eK+NmxNwSlcm0nBHThC47IVyHQA8mzTLgOY1Q3iMEqQcWb1
         yFF4GBI7ip2eBPNaikapU58SX2gQLt1Oxw+0U6pSDd8cFpmW6fx8ohjP/EWmVRdtlnu9
         sZYciQA5CL0eo4+UvZu7NLaKYpfKBuIOUfhUVpOBL2WV/4Ugps14q9YsXCxJME6YKy5w
         jrTpeIN0XR7E3XuIwiBcIoyixt6PMYfwj/1TJjnj3kQtpcT8UBR5GV/BUD+tqzgSq+Fk
         PbA9M6krDkJme81Ci3H1tlUKD+yIttoJKny+OG+6udNmUCczLbvRsV4tLj7lxY3I3Lmt
         UZQg==
X-Forwarded-Encrypted: i=1; AHgh+Ro66AaUnCQjzFydDRj578tHNeIUxnuzuyZNoHCx3hILei8M/TJiwtw9JxUT+KUy6isB9EU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3iKiTDM+DBJK/mAXw1km7DiCWcaWXLLSjEfqXRnESddojzVWA
	xBoEZl4nWUB1XGFuFzq969jsXtVW0zEB5lTtMUXQzYov06hIM0/w6rnb
X-Gm-Gg: AR+sD10Zu5DyFEn11xnXUJ+g+/q+CNQiHZ+hvAb+DH03haTWLOMylpvNFST3bH6bnjk
	XoyGtS+3G5XbFQ/QMtjNc7dYpZmJ5sQKf00wzggKg++8NCkcLl4J0aRCetbkrgnxSgqt7CBnFQc
	Ty56SjluUKPfjPdLfsHkty3viCi+bPNQRGY0LNw9Fi9iZGWjFNdy+cbcMy/Yt2K13P6O4SRsx4I
	MXU6MC2PAPUOl4MFEx7JH5xFGzBx4HUIUhqpTYVwo822scXWDFGR1Wg1zvxZ5Yg4jAOYklWK33z
	lhT8ImmI0ipQ1rdzYBGwBZnXwEx43HyY9cKCIzRj1xsUdMDylSR7tLoLrcFHR0J5ThcCDUbunZo
	Ueok+wfWWyeLpJcC7W75lSBUXAayBtSvl4fz0FTypPlQ1FiBoI5l/HfMGCjyqjDVQK1X07zz7ZF
	OQoUtkiXwDzIEZKTeVP3Y2s1H0zEkLWPTRb+K34S6gCYKC0c032UkBGPvj8tPfgaBEPmSJn4PgH
	lTo8VuYZAN9QF2X
X-Received: by 2002:a17:903:37c7:b0:2d1:1a18:4d0a with SMTP id d9443c01a7336-2d11a184debmr23173235ad.9.1786045666892;
        Thu, 06 Aug 2026 12:47:46 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d120c2e98esm1300375ad.70.2026.08.06.12.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 12:47:46 -0700 (PDT)
Message-ID: <b695bed46f03b4cc1a819bcd0d63272923ba5ca3.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 6/6] docs, resolve_btfids: Document kfunc
 BTF annotation emission
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Date: Thu, 06 Aug 2026 12:47:43 -0700
In-Reply-To: <20260805230648.2354989-7-ihor.solodrai@linux.dev>
References: <20260805230648.2354989-1-ihor.solodrai@linux.dev>
	 <20260805230648.2354989-7-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-08-05 at 16:06 -0700, Ihor Solodrai wrote:

...

> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> index cbde86d082cc..c60fc574e8b0 100644
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst
> @@ -472,6 +472,14 @@ type. An example is shown below::
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 late_initcall(init_subsy=
stem);
> =C2=A0
> +At kernel build time the ``resolve_btfids`` tool discovers all kfuncs fr=
om the
> +registered ``BTF_SET8_KFUNCS`` sets and emits their BTF annotations into=
 the

Note that this is a single occurrence of the word BTF_SET8_KFUNCS in
this .rst file. Also The wording "registered" is confusing as the
above code snippet shows the usage of register_btf_kfunc_id_set()
function, which is completely unrelated.

> +kernel's BTF; these annotations were historically produced by pahole. Fo=
r each

I'd skip a note about pahole, it does not convey usable information.

> +discovered kfunc ``resolve_btfids`` emits a ``bpf_kfunc`` BTF decl tag, =
a
> +``bpf_fastcall`` decl tag when the kfunc is flagged ``KF_FASTCALL``, and=
 the
> +``address_space(1)`` type attribute on the return value and/or arguments=
 flagged
> +``KF_ARENA_RET``, ``KF_ARENA_ARG1`` or ``KF_ARENA_ARG2`` (see section 2.=
8).
> +
> =C2=A02.7=C2=A0 Specifying no-cast aliases with ___init
> =C2=A0--------------------------------------------
> =C2=A0
> diff --git a/Documentation/process/changes.rst b/Documentation/process/ch=
anges.rst
> index 1ca8c5f73ad0..6d1dbe4abf0f 100644
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
> @@ -147,10 +147,9 @@ Since Linux 5.2, if CONFIG_DEBUG_INFO_BTF is selecte=
d, the build system
> =C2=A0generates BTF (BPF Type Format) from DWARF in vmlinux, a bit later =
from kernel
> =C2=A0modules as well.=C2=A0 This requires pahole v1.22 or later.
> =C2=A0
> -Since Linux 7.0, kfuncs annotated with KF_IMPLICIT_ARGS require pahole v=
1.26
> -or later.=C2=A0 Without it, such kfuncs will have incorrect BTF prototyp=
es in
> -vmlinux, causing BPF programs to fail to load with a "func_proto incompa=
tible
> -with vmlinux" error.=C2=A0 Many sched_ext kfuncs are affected.
> +Kfunc BTF annotations (the bpf_kfunc and bpf_fastcall decl tags and the =
arena
> +address_space(1) type attribute) are emitted in-tree by resolve_btfids f=
rom the
> +BTF_KFUNCS sets, so they no longer depend on a specific pahole version.

Just drop the whole paragraph?

> =C2=A0
> =C2=A0It is found in the 'dwarves' or 'pahole' distro packages or from
> =C2=A0https://fedorapeople.org/~acme/dwarves/.
> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> index a1812985a61a..717e76ce96a7 100644
> --- a/scripts/Makefile.btf
> +++ b/scripts/Makefile.btf
> @@ -14,6 +14,9 @@ pahole-flags-$(call test-ge, $(pahole-ver), 125)	+=3D -=
-skip_encoding_btf_inconsis
> =C2=A0else
> =C2=A0
> =C2=A0# Switch to using --btf_features for v1.26 and later.
> +#
> +# kfunc BTF annotations (bpf_kfunc/bpf_fastcall decl tags and the arena
> +# address_space(1) type attribute) are emitted by resolve_btfids, not pa=
hole.

What's the point of this comment?

> =C2=A0pahole-flags-$(call test-ge, $(pahole-ver), 126)=C2=A0 =3D -j$(JOBS=
) --btf_features=3Dencode_force,var,float,enum64,decl_tag,type_tag,optimize=
d_func,consistent_func
> =C2=A0
> =C2=A0pahole-flags-$(call test-ge, $(pahole-ver), 131) +=3D --btf_feature=
s=3Dlayout

...
