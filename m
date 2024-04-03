Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E48155A24
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712166099; cv=none; b=DpegmF7hzHmUT47dx6bu7ZxBfMvTtIR3MVCVqIE8Qnc9sZi0ScVGfqcUlBpe4P351LGgBkwBrlE0LqkvU4VsuHDtGZ3s8QXfhoNc0uWIMbe8vrd8m1633PDUwq0jKPHntBcDBxWEUgKDcdFpv+WE+8UG2vRRL1DUP3Pks1qZPBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712166099; c=relaxed/simple;
	bh=Hl05smtyxhlFL9OSmMWdjJWCBITqoET/8zyE9LmBrMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6HzVBau+vhKf3SgVRwA/eNXVD4E+tZkDZB6yWXelYgB8X11cCvOYuKnWHznutXUV0St/T6Roc5BtWN24EuY8UA9m/eVePTRSToP7kla9SZKbn16dkODW9R+9zB/OKiXsa4BK1OPrctpYb7eD77fc/Z2D07TlJst9r9XDOgMR8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLbfsHYW; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLbfsHYW"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33edbc5932bso26354f8f.3
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 10:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712166096; x=1712770896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7IN1xjabH9ozQvHzKMJK/SSb/jgSZEWgrlJbU6e1jY=;
        b=WLbfsHYWpQ6u8iyPHJimkeJYDffLfHEmFfO80QFgGDl1VC0c4sXjcCabvcmeUfW8DR
         r+DXQpg2Anq4j7h0GK5eeMBTnklD/zmTdMsuwhsmXFElh3hRfzwaLosDpthzKP+8fGJx
         HVpVMNIem3wthuU22Nxsj5UaWl+oU6N+ApugdERMb3SDGyBxxEHTrFkwaSBMFbDRSFVL
         v2a5BkS+REuhYasf5ZmTm9uCszW6RNMICzNkBuLxQzhFXYJTbBVtLKG41RrdEHfT808H
         gV3/ErFDK5f7XE2/kzjXDIzQt8r3EdGgtL+QMZ/wWtWBLT/BuaVzO9NpDODV7ZvXqo1j
         Z2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712166096; x=1712770896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7IN1xjabH9ozQvHzKMJK/SSb/jgSZEWgrlJbU6e1jY=;
        b=jN6HuO7ZDxEH3XtvgMP7mEDfa/bpS9C3Q+Xh/XR5Xc+7m8u4NaU7wzl4RupgExzwwd
         T9dKl1qoDzcCkflrTgxlDLrzNJ2FtALFfnu5ueJddJK4DXBsW0TPJQk5aX/wyvb2RB0P
         WVq0k6ZVP8GZx0TWMSwZiH9XZWXHhJ3K5a/dwlOfOL1r9ITrA14ObVpa2RDmXsd2g1VR
         7oLSlkdwBzcce0L6/idYwcUUCPkdjdarIQxc9dO7tHpdzOcUmbBLf6GPtIj67Z45xsp3
         nPg7XO42tvePOKC5S4sToTB/HMAocxuFwajfj1+d3OyJ2C6J4u0CexW0QI12cR9QZNcg
         wNDg==
X-Gm-Message-State: AOJu0YxLPGjH8IP3NNFehdBvoLA8hMU7/2M+0jyopGjhxsZ7Gj9WZdRw
	B1gp3rPR2+fBACpRDj/Nx9atkWQIr3k91GTuiZ2Ll35CWABEhp2whxgUJoR6FPU23z/6kSpsH2f
	jLv2l7TfTCOClKJSQlpRNlesXH+4=
X-Google-Smtp-Source: AGHT+IHWkN7bZTH3DRYhw2ael3ZmafWNUvYpMiyUCikoyl4evjb9fAJwgBnDxafuAC76ltdXGUmzIWC+jvlJtGUPRp4=
X-Received: by 2002:adf:db46:0:b0:343:7884:fb52 with SMTP id
 f6-20020adfdb46000000b003437884fb52mr132281wrj.50.1712166095514; Wed, 03 Apr
 2024 10:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402021307.1012571-1-andrii@kernel.org>
In-Reply-To: <20240402021307.1012571-1-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 3 Apr 2024 10:41:24 -0700
Message-ID: <CAADnVQLDBhypHuyS4UXnsMYGP7xCLWGBB9jdXuiqG+ddoX95Mw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/4] Add internal-only BPF per-CPU instruction
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 7:13=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> Add a new BPF instruction for resolving per-CPU memory addresses.
>
> New instruction is a special form of BPF_ALU64 | BPF_MOV | BPF_DW, with
> insns->off set to BPF_ADDR_PERCPU (=3D=3D -1). It resolves provided per-C=
PU offset
> to an absolute address where per-CPU data resides for "this" CPU.

Fixed the typo s/BPF_DW/BPF_X/ while applying.

I'm still a bit worried that there is no BUILD_BUG_ON
for 32-bit archs while both array and htab perpu gen_lookup
assume sizeof(void*) =3D=3D 8 in few places:
htab:
        *insn++ =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);

array:
        *insn++ =3D BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
        *insn++ =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
Worth following up or I'm overthinking this?
