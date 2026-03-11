Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F008230FF30
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 19:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773256910; cv=pass; b=Q0FCoP0HiuU4YB8V+yWpX99klCcm41HbS+izunRG/a+gedLpl3go1hc1+wx+Za6NK+DQvgmp+N4Om4/amadQDSnkbznwiIWQmRaK5cXnfKQEN0eic3l5TgmIapMVUHrKDX/ROQVsVE2JvkOyte2LWGRCvSHRJC2YHWz3J9sIzM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773256910; c=relaxed/simple;
	bh=PfDN3H0MtIRwTwaW/WNroMLSH+6j7sDSS6Z5FQKjSJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChWhqTGBN719zJ7gtwYTQKvM5W3DoDqa+vxlZNcNha/LXl3sQwhI3imvfT44j+JgvsaGJDI9T0/yHtQ5lubg/PqH/FPpGW6Noe0I5ggtKw4ETRm9GZFyXF9Wd0cGC1Dl+6mCr2z0ZJrZuw7D5v/RFnnTbi59ZrrwIs08CBoXepM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaDbTpuY; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaDbTpuY"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35a07ed3ebdso88926a91.1
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 12:21:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773256908; cv=none;
        d=google.com; s=arc-20240605;
        b=UnsrVhsuitrz/kls21iz7omBQoV/7lSrMXwIvJMTVdIfEvOhG7RPouWhpVL8AM8Frh
         AdeyXgIS7j8hOC5AeeGKzNpvYDGWUsWnEP3RQRHa2yjicnevq9BjGAemNDF+a2IKHLVz
         83H+RLsXat/CFgRWKroPFHKqia0+IAXDTAMzuSiMXKuUNE9t7hw0ddRhGWdxYtcyTgvT
         IJtXaMLFfm+bOyMSYnGzyrGofGRFW6yVesL4Bv1uvhhdQ/Pf2Bl2MPCPHZ5WYGxh+iOq
         wd2irpTFHt7GnUnkGrWXf6CMl3zijekzcWKDAbxcvqRBZLGk9/6DLSPq+asVZ3pJdZ+R
         RKCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ra0CAVuCzs/P1sfTzad2r9k485GOkvfEpIrrqXxEkvw=;
        fh=yXExmN6nmBVgtcdu4YUlOAAuPo66azH8sT5BOeKaxZ0=;
        b=XJAEj8lNTbYpPgRZf3YrKw7Le8Gz21ORzYcg+VY78t9uqKSrfoGwq+oAWqKFQcnh5x
         F81IIFqypQfJWOL6hHnWwrMvwdSK949pb6cFQnh9VEhQN+k+DGFXGXJE/XHPRRot32iu
         U4sG1m/GdbQYX5SayY/zMWA/wJXYn2lERlHMstTklGufmXAttpMggpt8XfVEDSMhqB0H
         S9Z65ENPAbznfkwIVsOSI0okeOZdRopPHYR/NkA7vhL/YGvwGJL/E6p+voVD33glieBT
         x1PZPhJ8ed4wlLAvnUiV9yYX8PoqhxyI3uFtGR3c00OdW4fDmp9P73c3HGr9EtV/hUhF
         HkFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773256908; x=1773861708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ra0CAVuCzs/P1sfTzad2r9k485GOkvfEpIrrqXxEkvw=;
        b=QaDbTpuY3uw2UyPbubQP9BDGn+9/b8H4fjvB+BKbVAPAop9JueCuTC6Ah4U1iGctY9
         d/J0eGy9RNc5dKqBWOdhVUduec5iX2img/gDhwzZDv+oGPaMPvpBv8LFd/kr0JBfnz9Q
         vFYOjRVBECBO+WvtrfpHHj6ZbTMowukqGyydeMzG/tY0k6BxPSTCsvEUUFrXY4iyG7M4
         J4KBCHlDCH40/1ZuPohBoMM1Bka07+3ZW8mTbB6EEBLJmq5Ajr628aIBGYOQSW+HH5GL
         souAwYmdsVUz6kV5h/RR1zKwmxfMCzJbcJfWvXIwjCDuzZv+poAZMDLCPxKF7iLVnPbs
         EVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773256908; x=1773861708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ra0CAVuCzs/P1sfTzad2r9k485GOkvfEpIrrqXxEkvw=;
        b=UbqtGSejU/FEZmPymy6jCw24yDxzoi0WoQmyb4Fm6iR/UsGzs0dje+tmfuFsai3z4f
         Wu/pNgP6qDQRF+UjPxCNWB7OlAQluawLxbimmbpTKle9WQYpVpsNs3A6KhqIZZgs4Z35
         lBq3tgzF++6Woi2eoL6U42YTnSgDvKiXvSejH5KLtDYazgQzuIVRLZGN/zY44ZsVuYQ0
         QSivPiW14uK0IOxPqRRUYOI92L016vqc1W0kzwiZa94jVdxQHIeEERJSSIVWIfYHUqGV
         XVibErnnmJn3dbKOscXpvb55zHUC0QfPT46gn2xI7XP7U/lameyI8oCsLdN7o+PyFcW7
         Kxow==
X-Forwarded-Encrypted: i=1; AJvYcCWupK0m2iXsGqRMqQ5hHKPurnYJ3kmKV+rgPQGiq9JoDb3cO5wr125OXkDbv/TZULWvxgU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4qwPow/znSfFpkKC1GNau23NZZeGAhucTqvOD9TIQTSTxR+U6
	F3+QkX26qA4DxOaAz1dKqYkgl9NGlIceDSGSaMvcZoqio9dcpWcY66tuuA1eajQJtFvFEbwUWM5
	weD4ESvbcIP5aR9h05h60Sn8+P7UHvDE=
X-Gm-Gg: ATEYQzziROsn/dSUDnJ74MHFVEcEX7noDvqQBueRYFBn30xIUe2+CF5SmpmWjaY1N1o
	bTn4mDRR/nfps1bWHLKNWgTEDTvQXayUtlFh4kn5avv5wlqaM2CtNtpS80/zc8snjRxGv1KzeCA
	LX6I9wR+TB7er4qHuqcwkOfwpc1Fa+axrvrmLI9JFK0uK+a35PUFxGLPSpXf3D49q2osKGMvKIw
	7t7vebL0Cw5XrUwErX7D3YWPzPbP/cxc9Cejd3MFy2WIOGm6p+5skdlpwyTTdOy7BgU8b4e0mP1
	e1mfiv0=
X-Received: by 2002:a17:90b:1dc9:b0:353:6373:590b with SMTP id
 98e67ed59e1d1-35a011d4a77mr3342669a91.7.1773256908252; Wed, 11 Mar 2026
 12:21:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306113630.1281527-1-alan.maguire@oracle.com>
 <20260306113630.1281527-3-alan.maguire@oracle.com> <CAEf4Bza_kJowGmin4Hh2iOpwXZVgNoeGNniidSpZEjRjqWnVyA@mail.gmail.com>
 <128e9cac-c935-49ef-98df-30f3b6cd7822@oracle.com> <CAEf4BzZefR6qQwu1jENEMg15UCXXnfqfwHYRV5y4NAXWwuo4zw@mail.gmail.com>
 <50f76d21-ff5c-471d-bb11-208925778d32@oracle.com>
In-Reply-To: <50f76d21-ff5c-471d-bb11-208925778d32@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Mar 2026 12:21:34 -0700
X-Gm-Features: AaiRm50a2ylX_W-HW57tX1hx9UtdhfBK9Qc9ksRO5ZAlERX2q8qnay9r9sifQE0
Message-ID: <CAEf4BzatOXf0YgtQj0X+kQ=NSo_rFLAjQ0BHf-ZegFm+t43J3A@mail.gmail.com>
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

On Wed, Mar 11, 2026 at 12:17=E2=80=AFPM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
> On 11/03/2026 18:16, Andrii Nakryiko wrote:
> > On Wed, Mar 11, 2026 at 11:10=E2=80=AFAM Alan Maguire <alan.maguire@ora=
cle.com> wrote:
> >>
> >> On 11/03/2026 17:46, Andrii Nakryiko wrote:
> >>> On Fri, Mar 6, 2026 at 3:37=E2=80=AFAM Alan Maguire <alan.maguire@ora=
cle.com> wrote:
> >>>>
> >>>> Support reading in layout fixing endian issues on reading;
> >>>> also support writing layout section to raw BTF object.
> >>>> There is not yet an API to populate the layout with meaningful
> >>>> information.
> >>>>
> >>>> As part of this, we need to consider multiple valid BTF header
> >>>> sizes; the original or the layout-extended headers.
> >>>> So to support this, the "struct btf" representation is modified
> >>>> to contain a "struct btf_header" and we copy the valid
> >>>> portion from the raw data to it; this means we can always safely
> >>>> check fields like btf->hdr.layout_len
> >>>>
> >>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >>>> ---
> >>>>  tools/lib/bpf/btf.c | 309 ++++++++++++++++++++++++++++-------------=
---
> >>>>  1 file changed, 200 insertions(+), 109 deletions(-)
> >>>>
> >>>
> >>> [...]
> >>>
> >>>>
> >>>> -       memcpy(p, hdr, hdr->hdr_len);
> >>>> +       memcpy(p, hdr, min((__u32)sizeof(struct btf_header), hdr->hd=
r_len));
> >>>
> >>> in all these cases where we have sizeof(struct btf_header), this
> >>> smells like a potential issue, tbh. We are silently truncating the
> >>> original header here, potentially. Which is ok for read-only case, bu=
t
> >>> do we error out if someone is trying to modify/write such BTF where w=
e
> >>> don't really understand all of it? Should we?
> >>>
> >>
> >> The kernel enforces that any additional data in the header beyond fiel=
ds
> >> we know how to deal with is zero. We don't enforce this here, but we
> >> get a similar effect since we only copy the fields we care about. In e=
ffect
> >> we wind up removing the aspects of the BTF we don't know about, so if =
we
> >> read in such BTF, writing it out would not preserve any additional hea=
der
> >> information (say a new section offset/length) beyond the current size =
of
> >> struct btf_header. So writing such BTF after reading it in converts it=
 to
> >> the BTF representation libbpf knows about (header fields + sections).
> >
> > I don't think we should be doing this. Let's error out when someone
> > tries to modify BTF where we don't understand *all* aspects of it.
> >
>
> ok, so to do this I think we'd need to set a never_modifiable flag or sim=
ilar
> on parsing when we find non-zero unknown header data, and then fail
> btf_ensure_modifiable().

yep, I'd like some better name that would mean "there are extra btf
bits we don't understand", but I can't come up with a better name :)
if you can, prefer that over not very semantically meaningful "never
modifiable"

>
> > And also you hinted at another missing part: BTF layout info
> > "sanitization". Check bpf_object__sanitize_btf(), I think that one has
> > to drop layout information if kernel doesn't support it (unless kernel
> > will ignore layout info).
> >
> > Either way, can you please manually check that BPF object having BTF
> > with kind layout can be successfully loaded on old kernel that doesn't
> > yet know about BTF layout?
> >
>
> Good catch, we'll need to do this sanitization since older kernels will
> reject layout info in the header for program BTF that contains layout inf=
o.
> I'll add a patch to the series to handle this (not needed today but good
> to have if/when program BTF adds layout info).

yep, thanks

>
> >>
> >> That seems ok to me, but I guess the user might want to at least know =
this
> >> was happening; would a warning or similar when encountering additional
> >> non-zero fields be helpful maybe?
> >>
> >>
> >>
> >>>>         if (swap_endian)
> >>>> -               btf_bswap_hdr(p);
> >>>> +               btf_bswap_hdr(p, hdr->hdr_len);
> >>>>         p +=3D hdr->hdr_len;
> >>>>
> >>>>         memcpy(p, btf->types_data, hdr->type_len);
> >>>
> >>> [..]
> >>
>
