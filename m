Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794382539;
	b=UbFZQCxCgn0lkkY4JXcOPzL7qJAmxI8UcmdgDvnS3gq/3mZVLfFE2K3tm7EorZAHKXdP
	 YcrnWHuK08WYbBFikxtd6wqtLpdsk/kaji7IMJkGbyU0nlZFB9g699vNd0dFdezG3wlPW
	 Mrhf6zVunlSSf/mMp1xOue5QA4UeSgceNZkKEj8hXG6DVZh+ZnlJnxM34GABSXv5mb/SD
	 3CetOn3Y3W80F02gjF7FK8LSHb7pZCDAwbcUtTDCeo7UccQO/eCl1I/piUPAoxUwkCkA5
	 Q4ES2UyyRPlr7WTK78wdkUyQbc6BUAUM/BaevNWRIn7KLM2NpYEWo2iBEofNDAldnsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794382539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NgL3StqkmoZikoXpv80FJYJalx8ySs4tPeli0UX+OHY=;
	b=RHz5xdpyCf3bvHTysx9rUqj4QyHhpk6qOlSR8tL/7fcsaI1YFkZWhw6010yTp9oAL25L
	 Uo74r0oB76iRfWGTGO7OwCQq0uqqMfTE0XXRJxuMIwkxytwCSw5cz92Jq3rFGvFPgJ5NJ
	 hP97DfRCC2MRR7X4YJ6MCtlESCW5qoUNmp8VFUHvVWwFEiSGOezK+C9csPCpdlBjRnqgM
	 HLn7jn5zlcJYiZuCuNv1b7fa2S9CWBne2vJ/0zCXSZtAzBuPkl57NjwEM/75ixbKjj794
	 d94P5Yljd6QL+u/o2zNbzZNWzkm2BDYV1yMclXPQrF8ywUisenm38sU6+fItMLARlEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Bs9eM0U7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69961606A326
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 07:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69961606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Bs9eM0U7
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b2d14968c9so32145647b3.0
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 23:35:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794382538; cv=none;
        d=google.com; s=arc-20260327;
        b=qfMrKTOQJEQOg9PHjHI9XSpmnus2AROb7b1tOMz/yGqzxlofSMY5PYqmQ8h2jz+HUQ
         ym41kh+O4z7cw7odFsl40ZwXR2jNojv1u5TFe6tFmrxi0Zsdgyne2nsrx3ylyI3i4ktn
         EtrJL5Gv6dHW2MsG8rQeNFfrQROZ5tSFoSjj3duMN1Pq0M84Yn7OAQeuzaBD4nZUIYeh
         q33WpEIeneUdkSZabWs0pp9mItUJY8xbHb0hH9dZIodH/kzD4dRsSwcnwBOmTdb+dxS7
         EdriWtgjP5yT7uaepJdk4+D17EzbB1AUkhR0hQQ2YwTqY8npX+xmIeZtgb59HzUK3aLJ
         lsGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NgL3StqkmoZikoXpv80FJYJalx8ySs4tPeli0UX+OHY=;
        fh=vF8AW64fMqZ21N0bou2O1O5qdAc6rLClTJ7MGdkBd2g=;
        b=aOHYBMQ1g8nufSM+UHy8xGUQqRGCT46pCKx82WfPm8eoJa0RZPAXSGUxgLvBjPHJbV
         wZSwC1clCYSwkJocyoDtGE4F3UinTxXIyjshbE/ES0gXH9gcfMYn6nxmxA5oc10aVkji
         aCvu48ZVssqSf9xItp4pI8npMgjZRYsie9GTpQHDXj8VAIPTmUIxTI4cO/ygHmM8LyZW
         2IgcLryVwY5N7fYyvkDERXtkJEWRWKAsV3aKR41gTzrvevNJ8wKoFKpMRBweZ2I4yAhb
         lCdgOWSiAuUP5hR0DYQqEVsWu2pTZBOzSHkw9kz/JuZj8pDvwSHxUABrT6TXBE0bVExF
         wUBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794382538; x=1794987338; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NgL3StqkmoZikoXpv80FJYJalx8ySs4tPeli0UX+OHY=;
        b=Bs9eM0U7T9Dcv5j/5o6EYk57qJQ9YereO3VjDhNRI7o0jefiQBCYSZvkDuzs5EwpBN
         blRufjR4fCW8K+7KZdBTktL1Oysu96mn3f33wyPmfUtrTyjJovE4HraeAPJacqdqXOpf
         c+UMmNoEWg6tqorJMjC//jzZDfGvuXeJCVKCwGtXLIPNIp6sEN3Xw28diurSQC6zziIy
         +vZrkBN1glEIUn+b+JGhdsLZewUBhUhy4GOrq2OAiXlhw6oR3XJWl3EcyCQn0thlZwvU
         MM3TgPBc/rYX70fGGbaYOt3JF+YcjSCUi+iJtenLk966aIlfbcD7Cb27P626B9thBRBE
         o9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794382538; x=1794987338;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NgL3StqkmoZikoXpv80FJYJalx8ySs4tPeli0UX+OHY=;
        b=wRiuERWv2IxnVM51n6gyJdA0/KuuGwj3lePWFmGXqGIadoKjyvRIx0/V4qhOHjcq85
         4sZSsklXQBEiTg+0hdytX5KzNDQ5Xw1WSoI1CF7rUUj35xIVRhh3zjLHKPbFiZl6d1YU
         BLIugWV/zXLzfm/eDp1CagE3xcIzoC8N3oJQnXm4oKNJhSpZ9UD+yheCsWhgkNbSgKnP
         Kqvg4dmmxT2HolMrrj7sNVon3w7zUoJjGG5kKf5ZmeltaRtkGeUCswPU7vEo+Iyxu0Tf
         5IdEaYD7jU/lyqVxz9br8tN8d+SW4OSAimKmRfCIYR+9R9DwzNdxEDJwrS2tqpVFTYa5
         iycw==
X-Forwarded-Encrypted: i=1; AL+hErHv+VZkVVyWJHURMHH5AEKtvWfErMyUFzt0IkJ3yPoSCaYPQRuzpqgwSsEDFOFj1L3BNSA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+sbZyphZ6uLVDLHO1DJcEH0ld8BGcUuKuPFqKp0JF4axZhYG4
	Y9F8lA15eIg6KjXMMQ/17Ycb0PCJpCFB3q2FKZHe+YwJd0a/z0fT85KzbEhKbnDz8XkcwQA7L53
	FX1OB35jxZwTbOmUU+e+HMsztgmYh/BukTeAeaohv
X-Gm-Gg: AYBFou02t9vNjEmkQ/s00FeMIJo0E8YvSZwnzZ4Yt6bjJzD/6zcto386QBrps+bF6bJ
	/HSEcVJAq/+M4G2JOPuhAK8EqEpN47S6R6RWjDNFtLY6u7FUQVHDW7dy77P/OyT/1sK10NRL17x
	Sfh4weDHxMIJwbFfutqGtIZH583nfcxe15MDNNXjPV2qpAull07r7hGpnLXyRFZ5ZLXyDdyulJu
	CDIaPvTb9Ya/Yuvl72gW6O4PHf4lZ/FIAlcf+8xkNqVn7qZUAHtqtmxMoVJzQ+EFnZYWzykN3Bh
	EJRm4G+epfVQMb+R6jbU0CmiVRkfBC9Xl7keCzW27bOUZeODR3plgakGch2l+HdOE9WD6+ZH6RN
	t2/RMXiueKeD/BI86ekF99QKifjLlKifeXjQb
X-Received: by 2002:a05:690e:4504:10b0:67c:7c1:bdac with SMTP id
 956f58d0204a3-67c6801c387mr697001d50.58.1794382537762; Tue, 10 Nov 2026
 23:35:37 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106-lskel-struct-ops-v1-0-a4486ffc79cb@google.com>
 <f5a22a46-0fd8-4739-bf11-a20e0b3a443b@linux.dev> <DMR088J2OR6L.9TOD4IDBHTZ8@gmail.com>
 <CAGn_ityW5Z+JEcTL9wKnQOgLXhjXxC357Q=h95AgR9xP+pcmjA@mail.gmail.com>
In-Reply-To: <CAGn_ityW5Z+JEcTL9wKnQOgLXhjXxC357Q=h95AgR9xP+pcmjA@mail.gmail.com>
From: Sid Nayyar <sidnayyar@google.com>
Date: Wed, 11 Nov 2026 13:05:25 +0530
X-Gm-Features: AclHuK-gFbPnqlWbdZN8aht-FIvpFP1KgQo9SMmyTpNb0jJxnVbTrvwFSqbrNnA
Message-ID: <CA+OvW8ZADPDZJYURT+a2kwvWcsgdJvzP5Q9sJuvXnnL2kgZ2dQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/7] bpf: Support struct_ops in light skeletons
To: Anton Protopopov <aspsk2@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Giuliano Procida <gprocida@google.com>, 
	Neill Kapron <nkapron@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 6:43=E2=80=AFPM Anton Protopopov <aspsk2@gmail.com>=
 wrote:
>
> On Mon, Nov 9, 2026 at 10:40=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Nov 09, 2026 at 11:46 AM Ihor Solodrai <ihor.solodrai@linux.dev=
> wrote:
> >
> > > Andrii, Alexei, wdyt? Any other ideas?
> >
> > The loader asks the kernel for ids, sizes and offsets only to pass them
> > back in the next three commands:
> >
> >   the loader asks                   and passes it back in
> >   --------------------------------  -----------------------------------=
-
> >   id, size of bpf_struct_ops_<t>    BPF_MAP_CREATE
> >   id of <t>, index of the member    BPF_PROG_LOAD
> >   offset of data, of every member   BPF_MAP_UPDATE_ELEM
> >
> > the kernel can match by name instead.
> >
> > The kernel has both BTFs. BPF_MAP_CREATE of a struct_ops map demands
> > btf_fd of the object already, and bpf_struct_ops.c doesn't use it.
> > The kernel can find its struct_ops and the members by name,
> > like btf_parse_kptr() finds the type of a kptr.
> > Then the loader passes what bpftool knows when it generates
> > the skeleton:
> >
> >   command              the loader passes
> >   -------------------  ------------------------------------------------=
---
> >   BPF_MAP_CREATE       btf_fd, btf_value_type_id and value_size of the
> >                        struct in the BTF of the object
> >   BPF_PROG_LOAD        attach_btf_obj_fd =3D btf_fd, attach_btf_id =3D =
that
> >                        struct, expected_attach_type =3D index of its me=
mber
> >   BPF_MAP_UPDATE_ELEM  that struct with the prog fds in it
> >
> > The kernel rejects such BPF_MAP_CREATE and BPF_PROG_LOAD today.
> > Nothing changes for existing users.
> > The BTF of the object is in the blob, so the signature covers the names=
.
> >
> > Then no need for a helper or a kfunc. The 4k buffer, the fds of module
> > BTF and the offsets at run time go away.
> > map->def.value_size, prog->attach_btf_id and prog->expected_attach_type
> > don't hold offsets into the blob.
> >
> > The diff below replaces patches 1-5. Patches 6 and 7 stay.
>
> I like Alexei's approach here, it fits with shirudo. I also have tested i=
t.
> (Patches 6,7 weren't tested, shirudo uses libbpf without bpftool.)
>

Thank you Alexei, Ihor and Anton for the reviews.

I agree that the loader's efforts to find out ids, sizes and offsets
for STRUCT_OPS maps and its members is wasteful since it only passes
those values back to the kernel. I will redo my patch series using
Alexei's proposed approach and send it out for review as soon as
possible.

Regards,
Siddharth

> >
> > [...]
> >
