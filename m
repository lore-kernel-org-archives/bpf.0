Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB7A5FEE5
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 08:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712134040; cv=none; b=cPDILhH54MfzoezepNEwbyctU/qMmx8O04yP3phWBLDcGvW/Stx6ODcqA5M/sy5m9Lbh9fMZPd1KEqSZgzHsZM3UYADe6ZS/7GS6oi6/5tySOWSrK1BPdoTnoxtsjE9XZDpPFpM0OMREhT8Gg0uS4UxT0povPb2IU3o+AKD4ecI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712134040; c=relaxed/simple;
	bh=eBvhLbLX4/TnMQo1CV7W0+IZO/aYxwwpmwxEleXEWBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDSnfHVb/QiJPEzvS52aKmKwVBBqicZEYjprn2oV3+ZBzUGetLQD3Snmfuj6Wa5PXdwG5ask3eji5K9j2scLRrmp8zBRoqoabN1bzq7AuASmm74r0Q66Ix8YWxmO+B7IXx4rOQl8WtUGBHkVuOzQovrT+vx/u1ebUIA2iWTUdRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ru2YtW5Y; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ru2YtW5Y"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e277154d4cso85685ad.1
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 01:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712134038; x=1712738838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBvhLbLX4/TnMQo1CV7W0+IZO/aYxwwpmwxEleXEWBU=;
        b=ru2YtW5YD9WcakjznNpLTICb6e2//OB/Hau3Z3khOMDnnMpr5dm3pqhkRBCmy345St
         gBVfoGMMZo6X1s6oa2miyhJS0a8B6Dp6Ps88+8UrL+lwto9oSyHQpjUBQZ+9vIaVPZ4E
         9n/waf4Su1Wh1kQNIdJtFQFQisURa+P33107noW2RpwjfweCRnJ0gsdVzxTn/neUnvWv
         9hMhQ8hXvpM1ClnhR9Ne0CGyibpr1npIceQHj4UOBVLOhQAVyVbuhHWVTMRTYWVrAjdo
         kzVWuUv3KkXWlJGnGez8YPGXfbdBLz1G9P9sDhxswYWdQDIBKDK3JWGqXxzAMtl1Rk5I
         7MhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712134038; x=1712738838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eBvhLbLX4/TnMQo1CV7W0+IZO/aYxwwpmwxEleXEWBU=;
        b=A8fyXSvx6No5G0qwWAt7LmAY5brVsgXVsw3GiET6IEi63udKu3sc1v7lnz+SnFlpU1
         EeNCBCME/6bdnUYHV1Uq+XmEdo4nCYBA1J64MZ41Gx3gwAPJ+CeRkKivfRl+qJHw2XaW
         BlgYUdWBWFbQJt1+kxyrzRPN4VxBUW1k2YFJ4qeJ0Eu4P6TDwsaGRrn2QdO3/5ynkjyP
         ZtHvXguitqwnvSvf1HBRTYLfXL+0Hr/xHnAinaOJnMeUs7WRpNN8mzNeWDjiSiE+cEG+
         eva6tTM+z8HDo0KBmhEvnOpiuycqyla1myOILxvJRA+CqxynqdCjATWOpspyUqioe3K0
         cRrw==
X-Forwarded-Encrypted: i=1; AJvYcCWxwY97vDbsEH9Wq0HRQZHc4YLu8s1lxNxx7aqCdM7MRglNrCOO+C1hbJNR7mkx8r7q/ERIFa7FHj97P6LLbU2HcqkB
X-Gm-Message-State: AOJu0YxfKDSBiI2CsfXNUce7mhqK++zxBhbX0PzvAA6YUbujnwoJX+1R
	kWfzj3wvIrY2vqb6BYbQ/+HESI91vKPmf5AQux12wySpbU7xVfiDJo0tVPtVTLvMi4qbJvLjDkP
	i8voa/bm/jqsZp5ikJEPavvYGmoiZr9zE5ZqW
X-Google-Smtp-Source: AGHT+IEiBb5D9qd3I2D88fJuBpuM9WiVMChpsPcpGqlzadOkT0g0yJH2m0q80UOP9f8weaXlNTBAw/blwMTr5rhDh+E=
X-Received: by 2002:a17:902:ea04:b0:1e0:a0d1:ade8 with SMTP id
 s4-20020a170902ea0400b001e0a0d1ade8mr141144plg.7.1712134037992; Wed, 03 Apr
 2024 01:47:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000f9ce6d061494e694@google.com> <2ee098ec-a46f-44fa-8719-049331c4c206@linux.dev>
 <CANp29Y4WcXr7vd=cvdtxRWaPxOKzr97f9L+BXtm07AGGiW2j2A@mail.gmail.com> <02d29315-13ee-45c1-984e-13c98e88247b@linux.dev>
In-Reply-To: <02d29315-13ee-45c1-984e-13c98e88247b@linux.dev>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Wed, 3 Apr 2024 10:47:03 +0200
Message-ID: <CANp29Y7WXm58E=Dv5WFivKuSz-OSCjMQLhBVdPA=ZpNmwcMitg@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in trie_delete_elem
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexander Potapenko <glider@google.com>, 
	syzbot <syzbot+603bcd9b0bf1d94dbb9b@syzkaller.appspotmail.com>, andrii@kernel.org, 
	ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 5:59=E2=80=AFAM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
> On 4/1/24 11:36 PM, Aleksandr Nogikh wrote:
> > Hi,
> >
> > On Mon, Apr 1, 2024 at 8:55=E2=80=AFPM Yonghong Song <yonghong.song@lin=
ux.dev> wrote:
> >>
> >> On 3/26/24 12:00 PM, syzbot wrote:
> >>> Hello,
> >>>
> >>> syzbot found the following issue on:
> >>>
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >>> BUG: KMSAN: uninit-value in trie_delete_elem+0xc0/0xbe0 kernel/bpf/lp=
m_trie.c:448
> >> Unrelated to the bug itself, with KMSAN is enabled, qemu cannot boot m=
y vm
> >> any more. Anything special I need to do in order to boot a KMSAN kerne=
l?
> >>
> > Does the kernel print any specific errors to the serial console while
> > booting? Or nothing at all?
>
> In my case, nothing at all.
>

If you're using qemu, please try adding "-machine pc-q35-7.1" to its
arguments. Otherwise it's known to have problems with very large
kernel images.

--=20
Aleksandr
