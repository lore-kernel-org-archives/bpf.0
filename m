Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577BC36075D
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 21:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773696206; cv=pass; b=p5RvTRFZGCAamJxtSCvpRQJEV562xhNKng/S8vN2yjOMF2S3HHXKS5KHz7+Js/1niLiEhSFegetTB9QrcYz1ddb+Y3+GfoekOngsL4LaVYQrpjZqUpJYa4IaAdDc8byTyBIkdP+3mFNucyAZnHpi0YPZXlHJiGVaJhXRMTnQI4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773696206; c=relaxed/simple;
	bh=/8sIoW4MjsdYYnujR5VehRV1+h4N8zwWl5eyao4AHJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPJ9N+vhVLFQsnQS5LfLVXRFwFy8aL+Q4mqxL4M4ZHoVk4m2wHQ886CoYMSGbb29c2KQEi7hrkeg2Yd+ejy4+OICin528lq2d2KJd0+zK2pJ/BEZSDT80funK4nNb8g5ptYoBWtpsRRFwDzVVZxDAB1RC8smhcnuBUx9SI8muqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ceo688Z8; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ceo688Z8"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6615c461d3fso6337593a12.2
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 14:23:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773696204; cv=none;
        d=google.com; s=arc-20240605;
        b=QL/EPbVac5GSQiI1BavjeSjT+3bnM9ehw3tlKdEqj9mzXwqdFakkgJOsgo/2FxhiUy
         oFoLdHKpveZhEhJx+lWtmMfAIwX8ziyjL0yYqN7mt06eWxJAKcT4RZY9lPFwjB9941Mx
         HkjSOCXqMXd0vi5me316mvD/xm9TJyT++dWvzz0y6oEwFJAcFzYsv+TMGTw7RpenRs01
         Dl53svNB0Ouw5V/Sggo4gpCVqhBi4bnit3mCWcuhgnleEOqOq6JdjJavGIyFkFQHylju
         EYvr37eIqds7Zz/zpQdBhW2UdvMA5SR+MNk8bmb763a1jrONs2igffzj7Ivb/gC3Vxjx
         a7Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RtshWmELDHLhHkvCZQKJ0YpTfAaXFcKMwe324rRtIfM=;
        fh=sPxNXiBvGRnZLzxnh/75Btba6jyCwyrwDBvysukaCyk=;
        b=HmwTihZUhhwprm5TyMSMWAIE8Ej8YuFDG8nP634QJBi7COEThcjletS4MEH0+1OZmE
         v3DFkhrGCGggHIiqRyI3Mi4Pb9slE5zlOoIA5GunUuUPYq+PDCFYA/C4T6EQnP96LVYj
         PodQj0v4Ov2AgEt7/W/1dzq1GsdmsGfLe8SZW4KL6D4fcUY4F3eupk/ksQ6pkiwoTWlY
         wr3H1MNMhYzp0no4o0WVUjNzp0krk+FSWAvtBjApurgxdmI0XUwGirtw8K2RZHQagK9Z
         LwhsL8kHY+P/UklYcsc0ElMu/iRG776GeqX6FMYHDsb07kJjeQ6uNDuqw8VQfsCrFaFX
         0RSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773696204; x=1774301004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtshWmELDHLhHkvCZQKJ0YpTfAaXFcKMwe324rRtIfM=;
        b=Ceo688Z8jsQHqGSh1+quQ48ESGgte0FikUV8TtZ5H3tFRqnzwFgyADjtyRJZ2XPZu6
         1XmPWC/qwcTLgO5lvPlp8aafIHPjqXObA42u3j5hysU5FDZMUceq3T76+VDYcE1MxqkA
         E9zg/uz6XPNVciNhmp1AO5EHWb1dB++3lnXZuWZUklEVmiUw5t8xSd6bCri9zcCht/dJ
         4MUYLGve53XRm1pqcTrteEOhuCNhGk/iOgV/+EC9fwuS1nk6vacEGxSpowTV3iq8B6G9
         BtXlgU8Ecn38nYgjV4mCjRbPbbnyLc+NdiSFBlI54jjtjyJrpz3judMJC1S/uVqmTtB0
         UN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773696204; x=1774301004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RtshWmELDHLhHkvCZQKJ0YpTfAaXFcKMwe324rRtIfM=;
        b=inEFjZocjdWPccZR2WDbPTPfEkKHXZOUyKg16AuubtAyAUSUE3YD8AzpdrEqN3f5IE
         bibHkvkaZvLN8SaOS3D70PwwfC1vIZrXhtFSP6F1LS6VjdtPQVcFWriWxfxW1YBDO+Rq
         tHzHItoq13yN57BUbG+0r97BQd6y1Ru/WgZ1Ss2fZOXy/KFou47bpFdWxEHTRW8rtxAB
         nSR8Z10k0Csv7hzxuDlw37MjV5bSZ3RGPO1yHr2Wm0OG6WQvtFrcLu2nRPO6G/PnFdQs
         +WdvXFaiZcxiFRlDfvBNEQTb5JKU+CuvP8hX5n5/Be62hi99kXuwsJqSvO7ayNKwjQTr
         sxtw==
X-Forwarded-Encrypted: i=1; AJvYcCXEGOUfewTtSOKPn3UESCfAiVxFCB2gyeFx/4D42qBAaXrSumd0q3d2a9QQJgAxdTCvn3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj0aAvkJHB7C6p/Sq8LIFKSUqUzIM8GG+EhJidfwLYDr1YaeMV
	52U6EBiorP9qDxDGvNeMkD3cfu0m4CDxGL7IzoejSeCdR+Ke1lN9fsRhG7PON+35EJCxdoLgl34
	CMD23t9Xbj4d7vMfsNahczAjNAXGr+0U=
X-Gm-Gg: ATEYQzxfQ3zFrcH8VEq0cXDMWtTkavFPPreRXZu7uNL8umJZST0824cuS7xsFtncvQZ
	5jewMylA9OyQ/JOEaM9A9cslj8EtgDntnsn3bgSv6phx2ixRLtVUvrMO/6m15+deNCh5CGfgSHY
	hBCYq7EGDztPlVWCHW67914Qb4kGOWPEWUgyI2J8JE6fIvfqCMTJ6gj+pDr2zk9QA/jnAxh99e0
	NubYyYCY9FHc2pfxFeT2OSINhXYe9frSoOFRE/Jb6vZQ4uqCve72ZnFTgNM3t3/vEGJu3h6kClb
	AziLt4RBmi9WPQRD2ZF5EZt9s/WnIag=
X-Received: by 2002:a17:906:68d:b0:b94:2ca0:3bfc with SMTP id
 a640c23a62f3a-b9765376548mr751806766b.47.1773696203274; Mon, 16 Mar 2026
 14:23:23 -0700 (PDT)
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
 <8294fca1-4d11-4c91-914a-c83d12f00ecc@oracle.com> <CAEf4BzbNQhga9bQuj73yE3Eg0KDuntsr-EqNOLCjSz+9GgY6Sg@mail.gmail.com>
 <0f3acfd2-4dc8-4059-bc08-aa1ec90b04cc@oracle.com>
In-Reply-To: <0f3acfd2-4dc8-4059-bc08-aa1ec90b04cc@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 16 Mar 2026 14:23:04 -0700
X-Gm-Features: AaiRm52163ROjK-hsL3aQfhsZuqARVFzNgSpxWz2OOroQNRyS0WuEewPYaLp5G0
Message-ID: <CAEf4BzZqJztLD9spavE_+xJ0k5QpJV7s=bvGJAz5+6x3X1L=XA@mail.gmail.com>
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

On Fri, Mar 13, 2026 at 1:15=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 11/03/2026 23:37, Andrii Nakryiko wrote:
> > On Wed, Mar 11, 2026 at 12:35=E2=80=AFPM Alan Maguire <alan.maguire@ora=
cle.com> wrote:
> >>
> >> On 11/03/2026 19:21, Andrii Nakryiko wrote:
> >>> On Wed, Mar 11, 2026 at 12:17=E2=80=AFPM Alan Maguire <alan.maguire@o=
racle.com> wrote:
> >>>>
> >>>> On 11/03/2026 18:16, Andrii Nakryiko wrote:
> >>>>> On Wed, Mar 11, 2026 at 11:10=E2=80=AFAM Alan Maguire <alan.maguire=
@oracle.com> wrote:
> >>>>>>
> >>>>>> On 11/03/2026 17:46, Andrii Nakryiko wrote:
> >>>>>>> On Fri, Mar 6, 2026 at 3:37=E2=80=AFAM Alan Maguire <alan.maguire=
@oracle.com> wrote:
> >>>>>>>>
> >>>>>>>> Support reading in layout fixing endian issues on reading;
> >>>>>>>> also support writing layout section to raw BTF object.
> >>>>>>>> There is not yet an API to populate the layout with meaningful
> >>>>>>>> information.
> >>>>>>>>
> >>>>>>>> As part of this, we need to consider multiple valid BTF header
> >>>>>>>> sizes; the original or the layout-extended headers.
> >>>>>>>> So to support this, the "struct btf" representation is modified
> >>>>>>>> to contain a "struct btf_header" and we copy the valid
> >>>>>>>> portion from the raw data to it; this means we can always safely
> >>>>>>>> check fields like btf->hdr.layout_len
> >>>>>>>>
> >>>>>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >>>>>>>> ---
> >>>>>>>>  tools/lib/bpf/btf.c | 309 ++++++++++++++++++++++++++++---------=
-------
> >>>>>>>>  1 file changed, 200 insertions(+), 109 deletions(-)
> >>>>>>>>
> >>>>>>>
> >>>>>>> [...]
> >>>>>>>
> >>>>>>>>
> >>>>>>>> -       memcpy(p, hdr, hdr->hdr_len);
> >>>>>>>> +       memcpy(p, hdr, min((__u32)sizeof(struct btf_header), hdr=
->hdr_len));
> >>>>>>>
> >>>>>>> in all these cases where we have sizeof(struct btf_header), this
> >>>>>>> smells like a potential issue, tbh. We are silently truncating th=
e
> >>>>>>> original header here, potentially. Which is ok for read-only case=
, but
> >>>>>>> do we error out if someone is trying to modify/write such BTF whe=
re we
> >>>>>>> don't really understand all of it? Should we?
> >>>>>>>
> >>>>>>
> >>>>>> The kernel enforces that any additional data in the header beyond =
fields
> >>>>>> we know how to deal with is zero. We don't enforce this here, but =
we
> >>>>>> get a similar effect since we only copy the fields we care about. =
In effect
> >>>>>> we wind up removing the aspects of the BTF we don't know about, so=
 if we
> >>>>>> read in such BTF, writing it out would not preserve any additional=
 header
> >>>>>> information (say a new section offset/length) beyond the current s=
ize of
> >>>>>> struct btf_header. So writing such BTF after reading it in convert=
s it to
> >>>>>> the BTF representation libbpf knows about (header fields + section=
s).
> >>>>>
> >>>>> I don't think we should be doing this. Let's error out when someone
> >>>>> tries to modify BTF where we don't understand *all* aspects of it.
> >>>>>
> >>>>
> >>>> ok, so to do this I think we'd need to set a never_modifiable flag o=
r similar
> >>>> on parsing when we find non-zero unknown header data, and then fail
> >>>> btf_ensure_modifiable().
> >>>
> >>> yep, I'd like some better name that would mean "there are extra btf
> >>> bits we don't understand", but I can't come up with a better name :)
> >>> if you can, prefer that over not very semantically meaningful "never
> >>> modifiable"
> >>>
> >>
> >> would btf->unknown_hdr_data work?
> >
> > what about btf->has_hdr_extra ?
> >>
> >
>
> Perfect. BTW I've been exploring an approach to do libbpf sanitization co=
de testing
> on upstream kernels. The idea is we make kernel_supports() __weak in libb=
pf so that
> tests can override it to simulate old kernels lacking features using test=
_progs
> own version of kernel_supports() in btf_helpers.c. Tests set a thread-spe=
cific key
> (so no parallel test interference) if they want to override behaviour, ot=
herwise
> we call the real kernel_supports() in libbpf. Would give us some extra te=
st coverage
> around sanitization (and potentially other areas which check kernel suppo=
rt) since
> we'll have more to do in that area for inlines. What do you think? I can =
separate it
> from the current series if it seems useful.

ok, that seems contained enough. Just __weak on kernel_supports()
doesn't seem like a big deal to me
