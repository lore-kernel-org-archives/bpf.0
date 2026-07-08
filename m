Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30DB3EB0F5
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496031; cv=pass; b=UZs2TAbM9F39eXEfmherzOnttqPjqwnb1Zl5gEuI/RHgTorTbMN3DjM+3rlojscBi4pDrBxBebazg4L41vpxkF21RosUFEJOaNyK7u5vSfMmZlMmDa2XpQwHPgdeDx4iV4WIh7HOHAU29cZzvKEGk0dxhd/lbMhmCVmGIktvm6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496031; c=relaxed/simple;
	bh=XQ0CKD1oaGYVXmuFtDQenNgKBbAtArhAeMNfL6jguJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+VrXcd5jBUZRq65UKRl2CImxW6rYhuFqvcjqkAyXJULQpVJrSSeVdRtsYwvvuqtsnUOXdDvqR4Fxh4VPZtiflNLHlEOH+MYfQ95jyrDCXTJsvP8BBqQhPbaxuiV8wWjBREOJTCJKejzCGi6o5ESaIX2E0t13AUBERbLmCSgQIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vulnseeker.org; spf=pass smtp.mailfrom=vulnseeker.org; dkim=pass (2048-bit key) header.d=vulnseeker.org header.i=@vulnseeker.org header.b=uOZy8DiX; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vulnseeker.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vulnseeker.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vulnseeker.org header.i=@vulnseeker.org header.b="uOZy8DiX"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8484a0b998fso143757b3a.2
        for <bpf@vger.kernel.org>; Wed, 08 Jul 2026 00:33:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783496019; cv=none;
        d=google.com; s=arc-20260327;
        b=hozlZ6Uyea2cQglymiQnsrCY82+41cUQvH7K84hGAB9i5830jbe8RCWjJM4EMpHF5a
         c8SouoRWGQvaZgGEh1rRyacMSeOihhgepye6/lZRGKWe7pOXoOGpaEAOMEWwrfVPRNKQ
         nOw/noeCoGIEYhRKrp/mewUX/wdOASk6+bJk39ZVPDky9wPItEeWFgb92arhzY/2KcB1
         1iyjI5THreWklCXS53Cmlz/WOimF0bL3p9Ws+0MWjpjw9zUFIgFAumS37aII5I4CsHNv
         hZ//2UF5tw+lMzzJYXrpJSU9dTVBsAM252ELSHVTqiMpJAjpj7Oceq3pQjC5UbdjV67q
         ovUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KlMQd6zXc+b5QHrwlBayK+dOIb6p877m6hlMYxECNok=;
        fh=QgFQjNoLTjJTwLzdrD5jnqiTgZxPJaZQuG1OuaVXS7g=;
        b=jaB9PtRqlZyJPsk2bRbmODIn4O/4sW2BwSM7AI3W2U6rKtUpzhwsiuyJE+YiJNDaUU
         KerEk5Cxo4wcQFIhBOclaa4BJkYUKEKJcKFYGFURxPZ4riX1LOZQYOWmVej1lOaCxoCh
         i1laN2O+1/xnTx2Xkwev+4eTIxSJEhPurNd6Ys+1wdbDpwUl+iPpKlzRqAyXcrqOmBnj
         16v40slXGlzJUENNyW2xADA/OZlYCIkROLCYHapqX7FLhJg2/WzRLD8SxF3Izr7lWfVg
         7j2nGgmpF/CHdM/ijxcFkwtsiSJbcMMmTHKRz1CC7dAEJoKaX6BnVNuRXB+PQaUPEPOt
         sf0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vulnseeker.org; s=google; t=1783496019; x=1784100819; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KlMQd6zXc+b5QHrwlBayK+dOIb6p877m6hlMYxECNok=;
        b=uOZy8DiXhlmjZuUSXTOD4PQOO50RbSi/Pret6pZnlYgzjpl0CbsPdr1U0eV4MoBnvC
         rlDN5QT+cxUAuMNeeb1AgKcBA7pbLEcdruDb/LJwNBiSeGjROAXIXONE58Azkj30Fqrl
         1GY1EvB0/ixFmJ4Xp1afeypkR7nhomRGJuc9ho369b6pXXFZDsA8XIdu+9LBK/w6qt3K
         /IaPdWBE+SiYwAkcN+6xzZAeJ+Vl2/Y6dbD++mfhW7yUlLt/SlyAX41+TPsjHjI3Vsw/
         Y8UAQ0Mcxbdzm1euAOHsz3Q6FxBBxGOgYv9cM9TRFcBIeb57F8ftxgDH4HHpndLwU9yy
         yAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783496019; x=1784100819;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KlMQd6zXc+b5QHrwlBayK+dOIb6p877m6hlMYxECNok=;
        b=GXcIxEgY3NUEZdGEJ+88EeZu4CwEp0xqBhHUWSK9USjWLZGhW8QHOsmwSlySLGEfzP
         Z7cUD4YgntPTFVzaKybKhShiE+Yyx+NB8T0eAUqFRT+Rf12Lg8Snu0mIzC0X1cnUgwmn
         0BNFfUA8B4A6q6RRpUSNxVhdJBgbHuH6W9tE2KIbh6p9/zoMcjHDzd4CJ7C2kcENnRIH
         keatEJBcROrucrKUta7fPSNK3MWNmehXDdxRrXsD7t3CEQq873RUJrK5mpqM2IpL3UPb
         vF3FQmScOGvwy1S4Yr/a46lShrxgXzKAkRGj5p3qJs4BaspZePfyHrcgx9NChRFm7xBd
         eSKA==
X-Gm-Message-State: AOJu0YwkIkXjf4N+4kl5Gwo9lI2doC1BvZFVTY8FpB44P5tQjoNenyBL
	NMNmLVLhIUAM/ZOcPViL9aARd3WKHYgsVvUKYUb7evXRqikPvcubtdQo0m+A6q19+upQjcpupnM
	l8S+/+QPvQk3Z+rf9kcydifrutQDvhCozh7/93ttCZg==
X-Gm-Gg: AfdE7cnB1ZcAc6rUvEzAkvl3QZKOpyav1NoMSOBv8YLgvack5OgpCQxu9zQgijixVro
	MJ3JhbhcJSHlT5gL3GEg1svlAd3QmG6JNBUHxm/ff+BIZSZRSa8eSkxQy98JapDEFJXQbQHoUxx
	+s0lhtGrEU+C3ZISyep8WnUs76DPJNRFxB4dt9mJIxzDCSGN93EVHcGoJQbCIEhv3PT9yOkJIKp
	EHpJCHVEp1cAjCfXoqOK76QH+Dqe02VuXfufm1od0FHr4BwD7A3Fp7tox7oZZc56fvUfjg8
X-Received: by 2002:a05:6a00:2999:b0:848:46ea:bbe7 with SMTP id
 d2e1a72fcca58-84846eac02bmr1020274b3a.19.1783496018749; Wed, 08 Jul 2026
 00:33:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO_sQLjn=hghkb7SZr2UWexf=opgLTu5_AHR2uTQrJ1r13vpjg@mail.gmail.com>
 <ak0QM9G74dc3jpWc@john-p8>
In-Reply-To: <ak0QM9G74dc3jpWc@john-p8>
From: Vuln seeker Cyber Security Team <security@vulnseeker.org>
Date: Wed, 8 Jul 2026 12:33:26 +0500
X-Gm-Features: AVVi8CeKfNAMQDSajEbstb7QrPoVuuoy9USuJaLtHyzuCL9VlZMKEa37ovQagVM
Message-ID: <CAO_sQLiUn3K71BhvNE2XN0kCkpTwo+gvO1R6HSo6MNF+iLs8AA@mail.gmail.com>
Subject: Re: Responsible Disclosure: Heap Out-of-Bounds Write via Integer
 Underflow in libbpf parse_cpu_mask_str() (libbpf.c:14446)
To: John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a81b9b0656148622"

--000000000000a81b9b0656148622
Content-Type: multipart/alternative; boundary="000000000000a81b9a0656148620"

--000000000000a81b9a0656148620
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello John,

As requested, I have reattached the fix for the identified vulnerability.
Please let me know if you are able to access the file now.

Best regards,

On Tue, Jul 7, 2026 at 7:47=E2=80=AFPM John Fastabend <john.fastabend@gmail=
.com>
wrote:

> On Fri, Jul 03, 2026 at 05:22:30PM +0500, Vuln seeker Cyber Security Team
> wrote:
> >Dear libbpf Security Team,
>
> [...]
>
> >libbpf's CPU mask parser. An integer underflow in parse_cpu_mask_str()
> >causes a memset to write far past a shrunk heap allocation, reachable
> >end-to-end through the public libbpf_num_possible_cpus() API.
>
> Send the fix seems worth checking to me if we are already checking
> start/end. If some app is exposing user input to this then I would
> push a report to them.
>
> [...]
>
> >  - Any downstream consumer that feeds untrusted CPU-mask strings to
> >  the
> >internal parse_cpu_mask_str helper directly
>
>
> Not sure why untrusted input is getting here but sure if someone
> is piping user input to libbpf let them know. I think if you have
> untrusted user input hitting libbpf you have bigger problems.
>
> [...]
>
> >
> >  if (start < *mask_sz)
> >      return -EINVAL;  // "CPU range out of order or overlapping"
> >
>
> Send a fix. Thanks.
>

--000000000000a81b9a0656148620
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello John,</div><div><br></div><div>As requested, I =
have reattached the fix for the identified vulnerability. Please let me kno=
w if you are able to access the file now.</div><div><br></div><div>Best reg=
ards,</div></div><br><div class=3D"gmail_quote gmail_quote_container"><div =
dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 7, 2026 at 7:47=E2=80=AFPM Joh=
n Fastabend &lt;<a href=3D"mailto:john.fastabend@gmail.com">john.fastabend@=
gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Fri, Jul 03, 2026 at 05:22:30PM +0500, Vuln seeker Cyber Secu=
rity Team wrote:<br>
&gt;Dear libbpf Security Team,<br>
<br>
[...]<br>
<br>
&gt;libbpf&#39;s CPU mask parser. An integer underflow in parse_cpu_mask_st=
r()<br>
&gt;causes a memset to write far past a shrunk heap allocation, reachable<b=
r>
&gt;end-to-end through the public libbpf_num_possible_cpus() API.<br>
<br>
Send the fix seems worth checking to me if we are already checking<br>
start/end. If some app is exposing user input to this then I would<br>
push a report to them.<br>
<br>
[...]<br>
<br>
&gt;=C2=A0 - Any downstream consumer that feeds untrusted CPU-mask strings =
to <br>
&gt;=C2=A0 the<br>
&gt;internal parse_cpu_mask_str helper directly<br>
<br>
<br>
Not sure why untrusted input is getting here but sure if someone<br>
is piping user input to libbpf let them know. I think if you have<br>
untrusted user input hitting libbpf you have bigger problems.<br>
<br>
[...]<br>
<br>
&gt;<br>
&gt;=C2=A0 if (start &lt; *mask_sz)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return -EINVAL;=C2=A0 // &quot;CPU range out of or=
der or overlapping&quot;<br>
&gt;<br>
<br>
Send a fix. Thanks.<br>
</blockquote></div>

--000000000000a81b9a0656148620--
--000000000000a81b9b0656148622
Content-Type: application/octet-stream; name="fix.diff"
Content-Disposition: attachment; filename="fix.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mrbrdjbp0>
X-Attachment-Id: f_mrbrdjbp0

ZGlmZiAtLWdpdCBhL3NyYy9saWJicGYuYyBiL3NyYy9saWJicGYuYwppbmRleCBhYjIwNzFmLi43
YWI4OTMyIDEwMDY0NAotLS0gYS9zcmMvbGliYnBmLmMKKysrIGIvc3JjL2xpYmJwZi5jCkBAIC0x
NDQzNyw2ICsxNDQzNywxMSBAQCBpbnQgcGFyc2VfY3B1X21hc2tfc3RyKGNvbnN0IGNoYXIgKnMs
IGJvb2wgKiptYXNrLCBpbnQgKm1hc2tfc3opCiAJCQllcnIgPSAtRUlOVkFMOwogCQkJZ290byBj
bGVhbnVwOwogCQl9CisJCWlmIChzdGFydCA8ICptYXNrX3N6KSB7CisJCQlwcl93YXJuKCJDUFUg
cmFuZ2Ugb3V0IG9mIG9yZGVyIG9yIG92ZXJsYXBwaW5nIGluICVzXG4iLCBzKTsKKwkJCWVyciA9
IC1FSU5WQUw7CisJCQlnb3RvIGNsZWFudXA7CisJCX0KIAkJdG1wID0gcmVhbGxvYygqbWFzaywg
ZW5kICsgMSk7CiAJCWlmICghdG1wKSB7CiAJCQllcnIgPSAtRU5PTUVNOwo=
--000000000000a81b9b0656148622--
