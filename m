Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84362377028
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 23:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773272289; cv=pass; b=JnXl/8er5eLWFPoXGdkdHMSoIcKBdv7Bhtuk3PGhnX4XFDdz1pbqcjRKRy8dT9ArWBioFhOeZr6HQrKeBPBC74q0Q302gVOtvHkBoVexbrrSjgzxIrFAvaElSISQBAK/R1u1w571pBmrhSzZhN8zupzrjoAoUwFQZcwiIOWdBAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773272289; c=relaxed/simple;
	bh=PaEMK9G3SnpNNxiY44PYXbHAJqo1tfZ2/Na06xk0nbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rc14U9C6X1ew//X1qrzyYVbfUsKzu+itNm1rz+k40fjF98MgKp3UfJoZuHF4eseYpEgOiWVS+oJAzAx+d4U6Qqqnn5vH3h2Z+vwik0C/viMX3I0cXjNvtmQpb+syjyYsc3R4WFECm8NzP5uILYXKM0WDLoWriAoyngGF+yIfxIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkTKukxy; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkTKukxy"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3598b95ad7dso291255a91.2
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 16:38:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773272288; cv=none;
        d=google.com; s=arc-20240605;
        b=Dz98Q7bJEvyJdpaz76ZmzgeFhU//tzsqGL0V4HzWC7ijRzyIp5CHDaDRw69KWl6SHd
         /pIlZqCJxO+wSgS+WsW1rsHujSI9GyB7y9kH2tl+dhfZG2uEr9gnlq6Wli/eVlNL381a
         ltic+d6mO22vcHBziaxV0iCPwOnYd4hOSa+h043TwkAGFaOL1/wMKrjGTn2kWVXxNPBZ
         i/ALW1Zq+pH7UnWKkBpkPie4xcCAdtFY8KsQUDN8Hb6BBGU1NVB6py2i8FPe70fInbmG
         kKyNMlrYNOhRE073/Eu5+IhpIhavQsGrC8WxRp+Zz3/dLxad3kA0PmGNxzCInmjGFt2b
         W6sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lg1BSN7SZeN8e1s6TD+FypmlHZGZs1b9Ja71KqsAJ5Q=;
        fh=PJGYKXexio++gsWM7BREJm35TlAW758zSu7VkVujKDI=;
        b=fmyLH6+9hmrDHyvKKVJZKD2GHMRRbP8fqFMNXp9cm/sYtbAGO4Z4i+5kik4DxO4h0I
         X8q9FjEsOjp1+xswdW4q/A4sNW8JrKdD7tyc5pAfX7Py5PDg8Dk77HIsDRmFbo98KfTQ
         x133MS/JVrA7cBM2SSN7O3ShzvhS7DyBhodtCKuetluRJ2fYhRGUlZ1hUZyx/5DHUBVb
         oJs8TSCB976vZQdNHlnb4b3GICP/GF4yN4cuiwYbsSd1BQ4XeA466Dbc27tEGseCRHAa
         v1qVUpWT3YTFM+k6OMm7r3gSDKxK5YC3fJ4vBgWKilmwE56Qw0S6j+SbACZf4DHrXVYy
         uQ0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773272288; x=1773877088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lg1BSN7SZeN8e1s6TD+FypmlHZGZs1b9Ja71KqsAJ5Q=;
        b=SkTKukxywKGog+0ujyKaK9U4N07AkZyryhHP2ocyTSYi/jwkhcPxauFbHG6cKSLBPI
         rtrbm3UEpsjCVDaVIIRhn0Z7bznq5o+213b9fEnHNX2kAP25F9sGXYRxRyaWMw7vkhMS
         OqVaBvO0xZnY9VMopmQqicIp9bnOaPxg9ee7+epD722N1812gCuucPceVDEC8DPGNrAp
         onhOlqe0a7m/75enGzrWBd8eInR2YUG6YACTXvx791I+Qa3GgSk/cnDkhdQkKTx2y97B
         Yp0xQqt+NAWIbis3AeSvKSwWcs2OF8qYzbO7gb4V9T47X6opdWLJnLCMSbsWJJcBCXTt
         4PJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773272288; x=1773877088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lg1BSN7SZeN8e1s6TD+FypmlHZGZs1b9Ja71KqsAJ5Q=;
        b=Oan7SdwLYhLfkeyFMehPBtN1TplfGm7kYrhehOwbRVJpEVZzGwAt7wdlVIHBpm9EKk
         dDXrZMi/qp2uFgRYAn6XR2VaQ7Ldv5Mxr4rLuUjV4uBDfMC8Rm/tff6wx1ks7zkPVB+t
         pMClw52Ou2nYSODKfJ6rVPLIi8PHOAa2EqBm6jXHZaMgqXyr54p30aT+Dr4OvDROk4Jq
         3psKdjqEBacY0gBT4oc9rfbGSl2hCbcdH2t0cWogVZmC4y9LQf1yKgGAaTVEtU2VcJK1
         RSJn6QoH4sd5vKkT8IDNIjKOK0NChNVwnThoHN5Jn2Wc0PMbxt+PM0a63yaf26fTAZr3
         +UkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGdQ4Jti7eQz5QPrwJXJFHGOUC4Hkmj04xenvzgeE7T6u6RTigA5uEyxmm/ZoLlFJVJpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLQY/uIz3bvKcgIaNjppYIXBZJN1Tbi5H0JqCaoMl/H2qGSUdN
	ZseJwYVoGEbWGT4Kf2jy1n2zlsd6rmyqmLa9VPh7v9XT/S0qEDzapapQe6WPInFbqL5Iwu7vIes
	tqJDRy+1in7IUCYWQ1K5i+mercjR6kg0=
X-Gm-Gg: ATEYQzyY91ywdI+6KAZpGwVMj/LbArS6r+D6xOwmrwIN7fVWj8yIVvHykdEmTAb6JFs
	LCOm6DdBq0UtT00E+WP+yAT+m34Pu2V4Cz9mNe1Jmx0VOwYdzvjX4G3BvQJb5eZm0U2KeOYt3A0
	kEwqZkkW2NsaXT+aBmwA2gfCYvokWFmXriA7fQfRyAbCZYMDsmgv+IONtn7XAzcaVFco/PLn2ZQ
	+iqUiGFiR/Pzivxoa8X8iC5n5cgz0/QjLzoSKwSbT33LI8b7pS40av52fTU/Zo5LFgU2fvKCxfN
	5q3fviQ=
X-Received: by 2002:a17:90b:3d47:b0:356:41c2:897d with SMTP id
 98e67ed59e1d1-35a012ab2damr3994247a91.8.1773272287882; Wed, 11 Mar 2026
 16:38:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306113630.1281527-1-alan.maguire@oracle.com>
 <20260306113630.1281527-3-alan.maguire@oracle.com> <CAEf4Bza_kJowGmin4Hh2iOpwXZVgNoeGNniidSpZEjRjqWnVyA@mail.gmail.com>
 <128e9cac-c935-49ef-98df-30f3b6cd7822@oracle.com> <CAEf4BzZefR6qQwu1jENEMg15UCXXnfqfwHYRV5y4NAXWwuo4zw@mail.gmail.com>
 <50f76d21-ff5c-471d-bb11-208925778d32@oracle.com> <CAEf4BzatOXf0YgtQj0X+kQ=NSo_rFLAjQ0BHf-ZegFm+t43J3A@mail.gmail.com>
 <8294fca1-4d11-4c91-914a-c83d12f00ecc@oracle.com>
In-Reply-To: <8294fca1-4d11-4c91-914a-c83d12f00ecc@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Mar 2026 16:37:55 -0700
X-Gm-Features: AaiRm51gD5IW_TYNTs-zz5q3ENGT69qimtc2o9IOJwthhjDaC3kLaYVLVymQUC8
Message-ID: <CAEf4BzbNQhga9bQuj73yE3Eg0KDuntsr-EqNOLCjSz+9GgY6Sg@mail.gmail.com>
Subject: Re: [PATCH v13 bpf-next 2/8] libbpf: Support layout section handling
 in BTF
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 12:35=E2=80=AFPM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
> On 11/03/2026 19:21, Andrii Nakryiko wrote:
> > On Wed, Mar 11, 2026 at 12:17=E2=80=AFPM Alan Maguire <alan.maguire@ora=
cle.com> wrote:
> >>
> >> On 11/03/2026 18:16, Andrii Nakryiko wrote:
> >>> On Wed, Mar 11, 2026 at 11:10=E2=80=AFAM Alan Maguire <alan.maguire@o=
racle.com> wrote:
> >>>>
> >>>> On 11/03/2026 17:46, Andrii Nakryiko wrote:
> >>>>> On Fri, Mar 6, 2026 at 3:37=E2=80=AFAM Alan Maguire <alan.maguire@o=
racle.com> wrote:
> >>>>>>
> >>>>>> Support reading in layout fixing endian issues on reading;
> >>>>>> also support writing layout section to raw BTF object.
> >>>>>> There is not yet an API to populate the layout with meaningful
> >>>>>> information.
> >>>>>>
> >>>>>> As part of this, we need to consider multiple valid BTF header
> >>>>>> sizes; the original or the layout-extended headers.
> >>>>>> So to support this, the "struct btf" representation is modified
> >>>>>> to contain a "struct btf_header" and we copy the valid
> >>>>>> portion from the raw data to it; this means we can always safely
> >>>>>> check fields like btf->hdr.layout_len
> >>>>>>
> >>>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >>>>>> ---
> >>>>>>  tools/lib/bpf/btf.c | 309 ++++++++++++++++++++++++++++-----------=
-----
> >>>>>>  1 file changed, 200 insertions(+), 109 deletions(-)
> >>>>>>
> >>>>>
> >>>>> [...]
> >>>>>
> >>>>>>
> >>>>>> -       memcpy(p, hdr, hdr->hdr_len);
> >>>>>> +       memcpy(p, hdr, min((__u32)sizeof(struct btf_header), hdr->=
hdr_len));
> >>>>>
> >>>>> in all these cases where we have sizeof(struct btf_header), this
> >>>>> smells like a potential issue, tbh. We are silently truncating the
> >>>>> original header here, potentially. Which is ok for read-only case, =
but
> >>>>> do we error out if someone is trying to modify/write such BTF where=
 we
> >>>>> don't really understand all of it? Should we?
> >>>>>
> >>>>
> >>>> The kernel enforces that any additional data in the header beyond fi=
elds
> >>>> we know how to deal with is zero. We don't enforce this here, but we
> >>>> get a similar effect since we only copy the fields we care about. In=
 effect
> >>>> we wind up removing the aspects of the BTF we don't know about, so i=
f we
> >>>> read in such BTF, writing it out would not preserve any additional h=
eader
> >>>> information (say a new section offset/length) beyond the current siz=
e of
> >>>> struct btf_header. So writing such BTF after reading it in converts =
it to
> >>>> the BTF representation libbpf knows about (header fields + sections)=
.
> >>>
> >>> I don't think we should be doing this. Let's error out when someone
> >>> tries to modify BTF where we don't understand *all* aspects of it.
> >>>
> >>
> >> ok, so to do this I think we'd need to set a never_modifiable flag or =
similar
> >> on parsing when we find non-zero unknown header data, and then fail
> >> btf_ensure_modifiable().
> >
> > yep, I'd like some better name that would mean "there are extra btf
> > bits we don't understand", but I can't come up with a better name :)
> > if you can, prefer that over not very semantically meaningful "never
> > modifiable"
> >
>
> would btf->unknown_hdr_data work?

what about btf->has_hdr_extra ?
>
