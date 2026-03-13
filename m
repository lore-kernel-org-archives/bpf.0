Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38371304BDC
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 03:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773372352; cv=pass; b=bmpPa+7q48RuUiCYlHCH6EdAAroYHIIQCZT5AhxS4GQIY630RSjGCIhq1gYb4JP/1Pao+E1DmjCvz2lqXc4flIP+OtbzxWgjOo57EktsTAGsCpZ7b0L/sZtdzeHZT8sqcCHmhHqMc4egEU2bWudxID58p2WePUd+zQ1vvErhR8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773372352; c=relaxed/simple;
	bh=jJS+hhpnUVOG/Ej47nAnN1GzIMfATuqoW3/771u/U+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+Nng16zf4y8KcbPlnIVnb2MGHvoqrXynD7RdB1aZPNfcg0ay2BMkaSlDj/vR8pMXNsy7pq7jmp2KjUYGkl2SWI/5nR9C1+3j2GNU0Uj4tRbswxLG0708gXOB1/uizuJ/w9f0BumQDhWfrLdS/jvNt4ABx64TRmUmuN/iZqkNSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euif4JZE; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euif4JZE"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so18735495e9.3
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 20:25:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773372349; cv=none;
        d=google.com; s=arc-20240605;
        b=ho3qsWuQw/VuWsNJ/Elf0HBFxs5lJBJ8s00m3Z/LBK04sOj4oj1o0wrtUX7WHl7E7O
         08p+Rlykf7PetMP/D+f3QfefeF665pYenhL/UdyLFRcQ/i6tjRhJGgI5v9cS+YeKP06u
         Cyecx0MfFA8WvB1j/90GPzQNJUGK5YXlJk2tXNPyKJKGO71qr9vnZjxIe7xY6XBOWL6U
         N4x4wPcSpTaW6cQDxj5Fl0uY2xrzG4Iu5PJOSwZk5YiTuryU2l8MmlviUy9yHDSlAJr8
         4ZvFswFCmhnyBWkPE7wIGuv5JbAkQfailmjviWimTEbsaNrG1AzZ2lLeZ3SvjoFMGnP5
         anYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DjdNkWmuFGHAULzlA4K3CXU4TqPSpjiv6ig00VxhSt8=;
        fh=J4/mukkHm1+4BsLTOwUvQ+tq8JCMeJiWAc+LhWh1PrA=;
        b=UwAdGxEDPYEITlxliikJOLns1YpeYK1XEhQug7aX2UImImhn/0xNCmxZeHK+DIDglD
         nuEtwrr8wnt4kZqc/jdLHc5+pNg57elVQ2gf9xMkOUvylCaZqmu2iwJ2u8v0UgLt056r
         G6LFjXBhd053JwqVgzT0bkeUr3Nu38lh5CNI+XmJadg3RE3wk7z05cxYno9QRDzDXSXn
         LSxcgU1Rl8GWVOIPPUDdC9006xNuefqH6N8fAVOt3LpLP7HqWA6lnwqKMvCHC+PBt2J+
         nxQvAtjB7mLC2EG1K6kaVH4irXMn704thWLanWVVMs3Zwe4UzkN6xJETh7NsQNNusgxM
         Z+Gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773372349; x=1773977149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjdNkWmuFGHAULzlA4K3CXU4TqPSpjiv6ig00VxhSt8=;
        b=euif4JZE+vjNViFVoElHdNGDKly03h8ZDMvwh1xvoBbdfEwiJru15jF6gQ+wdpsR0h
         zvISHzESYE/IJW2DhaJqkb/PmgsC+PEQp2HNgZfDmtjA6Be58Mql62r0J4yx6tfpBWab
         e5NAhb0RZ/ogEnSvDcVm8iKn8U6PB0Qc8Osqan9YqPkAjv04QJIWnx8h0+fFroBkM6ie
         scYZaMR0KIppwV9KgddshEe+5Mgjg118hNF1xNE5YSv0AfW90AzArPGLwy0TBwf252UV
         eVnv4gOuFj1mbahKHKSmS7RJI8DBCmT5r1XBAsQio7TMq5PfyVZehhkZLL8tSySpTckq
         Bylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773372349; x=1773977149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DjdNkWmuFGHAULzlA4K3CXU4TqPSpjiv6ig00VxhSt8=;
        b=tHhmFcT1Z0z5USs36lk1/9QQmtgVEnBAjz1Iu+AKQDICmVXc+1Sa50Ch1ODcDaJTrW
         DA8q3dY3Sh7Cg3M2DqEi74HLg/yeNyJ0BwpgDE4G9HzAC5Z14ZrNy0fj3o3k+Ob1+EB3
         3REIXjon6AtDxSkkgSUAs59oThy8AiE5PPUz0Cypa0WB2xo3ikfdDsEngjEORSYnkXjz
         XuWK1GA+m3eoTgxtygO6qvO1vYFwGJ3iA9Uz3tD7T2eEjeXL8cetSSOoAlyg983sUatl
         23hckN13tVK3n4XMBB1motNhTauFrZvCpCJ30Lq+v5hOnGmB3Imtg8pgbfWA0oAMasn2
         ES2w==
X-Forwarded-Encrypted: i=1; AJvYcCWCSPp1s8TZ3xEk1JKzEUFY6yqZEaZZlRz6VJ8o7JLVC6zAzvFg+LugBbXHWYiWg9a7yGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFr3sQkUr7cNURVN0aEynLTRzAv5V9s0c8d1RaAtzYFAmCFQNW
	ZAnUxiQvODbYKclnsLepgdE6Wb5QKBjDZEnMn9gi7EMSPku/TCIgoCLgdH0gF/Wsf5DxPs4GjrR
	uMZoSq+q8CQZSHEw8zsxJ/Hf/4lnc+o0=
X-Gm-Gg: ATEYQzxxir/xTqe5KuEgvWshkyj24vI7VL7tyKLAVMGP/U4r70CutFPfphTGae/aGja
	ScE7hgJyDCYTw+W7uF1kXbbMs4KizVJiyleXvrJD47ekHygB+sOv84CzzIvP5AGQH1+QugX7jqm
	6IoOtI+5iXfgTnAl54bumNiPiUP2pxRTRPP4wKMMqtBts++4XPwlHAfeyW8l43Sp8ecRfKxfgS4
	VX8eQ9ZqYhKi+Ee3x7yKTdMpOwtraMqxzyVl7qS+ewnJs4HKYVnk1LOkWaKQkx8J8OIYTNfeafT
	sUWMfFju1W+R9gmQmgF0zZAvY3WrYfOEsJqf0Lwly9hYanThy5HCZMc/oywJwlVIFFM=
X-Received: by 2002:a05:600c:19d2:b0:483:703e:4ad9 with SMTP id
 5b1f17b1804b1-485567027e6mr27457915e9.19.1773372349282; Thu, 12 Mar 2026
 20:25:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-2-ameryhung@gmail.com>
 <CAEf4BzZubPSaS8SQSEQJvTphwgbaBfdC0CYEhsfQN8CJ7HS3pw@mail.gmail.com>
 <CAMB2axNR6qPRVy5YCiMygVseS+k9JxY9DFONNHD5Lt8=wD9MGQ@mail.gmail.com>
 <CAEf4BzYTO9e-UAEd+W+ftqQZLUZCWHWXAYVnVjHeNtsZL1=Pdw@mail.gmail.com>
 <CAMB2axN+8+V+29r9tuoVF57ObpvkUE5d5_8jtd5iRPYq4_gLGg@mail.gmail.com>
 <CAEf4BzY1O1Ne9Rf+O2terCT8f9e6pNFr3N4hOv98N84ZoehCaw@mail.gmail.com>
 <CAMB2axN8Qe6r_siq5_6od7D_kDZPcYw_Z6KVOFtXNJVKzajqzw@mail.gmail.com> <CAEf4Bza5bNf6MsgNrr9WqE5ZKhRQ_PwtdCEwaWAVLJNmAZzv=A@mail.gmail.com>
In-Reply-To: <CAEf4Bza5bNf6MsgNrr9WqE5ZKhRQ_PwtdCEwaWAVLJNmAZzv=A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 12 Mar 2026 20:25:38 -0700
X-Gm-Features: AaiRm50PvuBQGkWhfwi1pHRbvVaBb5_HrvDIvQ0oA3BFbrNbnKznFi_Ct8lbq8g
Message-ID: <CAADnVQ+kQys+50hammWjsLFE8DK6FKgn1mPnKu3c9O_R64vJMQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 01/11] bpf: Set kfunc dynptr arg type flag
 based on prototype
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 1:10=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> > > I guess I'd suggest
> > >
> > > struct bpf_dyntpr *const dptr
> > >
> > > to mark this through type system? that is, *constant pointer* to
> > > dynptr, not a pointer to *constant dynptr*
> > >
> > > WDYT?
> >
> > I think they both make sense from different angles, but I am not sure
> > which one is better.
> >
> > From purely C's point of view. the pointer points to a struct dynptr
> > that should not be mutated so "const struct dynptr *p" is correct.
> >
> > From the BPF dynptr abstraction's point of view, the pointer points to
> > the underlying memory (e.gg., skb, file, ringbuf, etc.), so "struct
> > dynptr * const p".
> >
> > Any way we choose, I'd suggest that to be a separate patch. This patch
> > at least makes things consistent and fixes a logical bug.
>
> if we could rely on decltag, I'd go with that. But *const is unusual
> and stands out, so I'd go with that. I wonder if anyone else has any
> thoughts.

I think C is inconsistent in how it propagates constantness.

struct foo {
  struct bar b;
  struct bar *bp;
};

const struct foo *p;

all fields of p->b are read only, but p->bp are not.

So both:
const struct bpf_dyntpr *dptr
struct bpf_dyntpr *const dptr

cannot really express that a memory that dynptr observes is
read only.
So, imo,  btf tag is the only option, because we can define
what it means precisely.
