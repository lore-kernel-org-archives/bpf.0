Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBCF21A0A
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 06:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712039821; cv=none; b=EYBJ+b7W1IfhT9GwlzLkHQohHorOe4CQZkINFPHlB6X/tN+uqkViLkXZxNKpdoDEDeD55iZYOX5ZOjoaBO1wnpNyDHYv0H7FruKx2rm8ZXJ/KXd/OgX8K3GGtwnsj0+hrpWFjLD//bcxgQamHdsf34Oj5/4Zk5765AWB3vcnQoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712039821; c=relaxed/simple;
	bh=h8a0KAn+MZnFGoNEOgIGih+DjI3NRQeEw1chqipA2bk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZnA73cmAGeMhsGri0zPd3Tyiv7/I6SfdMO5E1h68Q4co/WxAfvAdCXpQ09757tNnplU29dGuYmLNbRV2GKPbZxT4bBouqiyX4BrJY8/A8PLnZ3wKy+2C9aIAAsEOxbtcJjifvMVTkbNcGxjkBMe3eYQMgMWiYXQwIORitsVtIJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fQ1JLCQ4; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fQ1JLCQ4"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1deddb82b43so522125ad.0
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2024 23:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712039819; x=1712644619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8a0KAn+MZnFGoNEOgIGih+DjI3NRQeEw1chqipA2bk=;
        b=fQ1JLCQ4oWQtcYn2cpCEwh47GKZCoC+C05ScG6RFFSwQs6JJkcHwf26WNFwVabJuGh
         qdEQndr2U7kDZMjnE5zb34AE+oN+vHt3rr2ENkXEAT/OVS2YRp91mv5tDW6GjcDiF4TO
         s3n6JAYTG1nn8NyjYvPRgaxgUfy46IH94ghJeKx2TQm7Z8hvWllY+1E24vXkWWFgVqjm
         xFG8xVs1o7qcbTo2qXlQH+PYm9/6JybdMJw5SPeK+tk6DzFV9dkNOBZ9u/T82h4CHiru
         e+XCN0ZyNeKbURxM1W0bHDXJ2AsU2j+nBfHMquxFzP/XLU8oBz/osjI4fZX2afsJHRGc
         luhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712039819; x=1712644619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8a0KAn+MZnFGoNEOgIGih+DjI3NRQeEw1chqipA2bk=;
        b=HoTtMipzCKIV0klBMVaDZuZDefzBIS9wVPY8AfNqswMSkgCDaAs3tmaILI0liYVpB2
         Jiy0RSjczcWlvy9/GwnXAzarnEa6K+4PCpNaxTDOybbaYmj7nZJSBzZj9fp0XMbWu4K0
         XD4TOoWHNU/8BcW/muQXt4tG5rW3fXOuonPP4pe5qM4mnenWobnld8SuQFayhlVJhgM2
         zNAJnKWdfJsCD1Mm+KPnQO+Xf4/41N6j3j46xZ4DNDsQoismBSnuSlmdS9bdVnxpkKFt
         031Dd5/sNLZih1jHXhw4qTSTirfT8T/T4eZCssc+tcGGTZCytOYBQ9umiojK8X7O3TJ0
         On7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6rVGmCxDdH3ANx1BrGqQ10yx+NbDkXHSEaeIMuTXc9wLUJF3khTPDVKXyNrLkR94JzT5rlcQjAND/YQogu/yVGNWc
X-Gm-Message-State: AOJu0YxuQo+Gj9O7iGjZi6T5en6cdn64GaJO1PvujBGM3QrODuptpZch
	VYgCq/RrFaFkRtlzWvZzCQQIYV5+1yvvyKRLyWL9aHCfyu885SgahSPxQmw1WXGWIw8kNSTSu9G
	mFK4uc4ftM/tnMYkoptcfaVK5i2BCu5ax+rpm
X-Google-Smtp-Source: AGHT+IH1D3EvNP2RfVkhzg6uErgJllKDJPH5Iq1dkh9LIhzec3cd/ilQ70sNT+BjVKJJdnN8gztjWnT089iJ+9EkoMw=
X-Received: by 2002:a17:903:11c4:b0:1e0:94bb:c4aa with SMTP id
 q4-20020a17090311c400b001e094bbc4aamr728537plh.11.1712039818767; Mon, 01 Apr
 2024 23:36:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000f9ce6d061494e694@google.com> <2ee098ec-a46f-44fa-8719-049331c4c206@linux.dev>
In-Reply-To: <2ee098ec-a46f-44fa-8719-049331c4c206@linux.dev>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 2 Apr 2024 08:36:44 +0200
Message-ID: <CANp29Y4WcXr7vd=cvdtxRWaPxOKzr97f9L+BXtm07AGGiW2j2A@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in trie_delete_elem
To: Yonghong Song <yonghong.song@linux.dev>, Alexander Potapenko <glider@google.com>
Cc: syzbot <syzbot+603bcd9b0bf1d94dbb9b@syzkaller.appspotmail.com>, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 1, 2024 at 8:55=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
> On 3/26/24 12:00 PM, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > BUG: KMSAN: uninit-value in trie_delete_elem+0xc0/0xbe0 kernel/bpf/lpm_=
trie.c:448
>
> Unrelated to the bug itself, with KMSAN is enabled, qemu cannot boot my v=
m
> any more. Anything special I need to do in order to boot a KMSAN kernel?
>

Does the kernel print any specific errors to the serial console while
booting? Or nothing at all?

--=20
Aleksandr
