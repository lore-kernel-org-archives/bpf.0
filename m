Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F59442105
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511856; cv=pass; b=koSpf+VG/zlmfHVtkg5aEK/BS9PkPrA/gHQ9AcVQqQcXOy/2Hpqq/ucPqp13/0joUu3Ci9CrC2mK+sQapMQSbgt9n0ZCOtWYhLjZ5/Ss56TNeKMmicR1oBWkYIM+x0TD2NPvYPVMITst9VkrNzLv25EsluHCvgcJzmzCoJEsiOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511856; c=relaxed/simple;
	bh=ewX5vll4eCT221KLiCyTQCA4KARdLxwkCYF4FuZzmvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VoW2kNsujitlyF41vrUNZHInbZ+Q0nMcGpsW3cEeZNFsKFNWEPNZUSHT2qsdpxh0IP8otlEDZga4+6yWbAEIycLfPnFC4T0Wdtu7Z3MmHGWWw4UBcBOH4PnJzEw0dhZcTQxpvKo/PU5hiRKrhDfrKVL5lhtvVP6As/8s8OyWN/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dv7almrz; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dv7almrz"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51e4ba1cfb4so6649831cf.0
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 08:30:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785511851; cv=none;
        d=google.com; s=arc-20260327;
        b=dPdAUvC28S8Pt2VQa4JOudYYeHDsRURcc4AiTYcbJgGjJDSGzEDQXKI97ZcSY9qeu4
         +u0/nZNq0QKJi7ONGzwowW1ld5H955pJk1w//OiSHppAjzxEKeiZra7HTHG2jkuw2UAQ
         Y2foftpIormQk0XC0RKryB1Pq1I8LiLcMuZeLUGKJvMH0rZgYyhvoGXOo1zio4txXJtg
         uLdig3swn5MfkcUjsend9gQuAHFSiRnIbJMcSU1PCKz6zQaGf3+jECSi4/gtTJBkfvmu
         3BaXEtR15VLv+uHhXE6fw0BFW3wDanRVSO1pXzoSBw/XRP3+8/nOatiCPBGKqAmC12Lm
         iKRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ewX5vll4eCT221KLiCyTQCA4KARdLxwkCYF4FuZzmvE=;
        fh=4juwBXzK9TqNdhAAoTdeAIgBZP6t7h+bhTvGjqn4z80=;
        b=aY87Rgv8cMVC2V4o0yGbxyBDm0Dw1yzyR2E1Jotw0cuUo+18FGHBe9XAx9HYWEY/Ww
         mLjXKzT4OTB8ZUPjVf+UwcIV3Xmt5xQ+1M9XUodB999lwremyAoC2lRkC7v6awKJNztV
         ItM5aKbLrkNDdwe4HF7RrIRS6ydHr5c9/w18lsZorZIrK4viLq4Lr0qNTo969ClQxqAc
         da8QcwN+yvCVfOWDpBm7mLDVP4oT0Jb9A0NH+grv+TdVlVYbYbci76SXu4rNjsSuXcgB
         0Vwg1pItKpu3uH46crYzEY7ZNxbQmQGUs/thu3sNWVdw+e+gfYdKt29QDrbFuCBHx9XQ
         Gnig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785511851; x=1786116651; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ewX5vll4eCT221KLiCyTQCA4KARdLxwkCYF4FuZzmvE=;
        b=Dv7almrzLgInu2aUvUTgDuu+AvSYoQPoJXwtqMKfNk2NvNgNV0ChgtOEbKITkDLxY+
         IK3lol9An0jJKwGRheMIA+9coU1UPxmoAQXv745nA3ijvQYWSKJZRN8CRoniQeol38ty
         TMd53QOjEyExUV3Dj2NhzYMcIEB2SYh1p/oTzzwX2fZkKSSZpAtVpZs4neDvUFx3FpTD
         vXMdnAtoW/r+VnbMyBqM44EFfSx+s6qUJbqq9+5447JTkLT55aJd+QYldBMRk5bXcXUS
         vDUN4pPibTIVAwUfmZ6U2mv9dGMTQrLPcQD1aCC+5XDH/zI3oiiwu0b/0yey5Qx8xxjK
         0a5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785511851; x=1786116651;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ewX5vll4eCT221KLiCyTQCA4KARdLxwkCYF4FuZzmvE=;
        b=VcUQ0bVpG2ZhvoQLeVzFN8lwxywH8fWY9IAz2oS1clHGCOhzvRpRIoskWNoDEm2VW0
         UWXBifiZccNUn5zffNkyT7x3zCbLXy5vpzCrSBRXx3k3C0rIdp+YBBttmKs5Nlw9Vsrn
         JqDJ0MwVVHrf7W6RS8dKsRbHv7fTsTl00hZnxI0Cn3jzRHEd9xQo/iP3mMR2eDuffObL
         ips7rvjWbsdnNEpJ1AfmahaZX9QLXw4EEZOpxbq69Bhvr8uJKo27av3OREO5854E4neB
         geazd3tN3hg+yAEVkUQAOey5ysEjqbwXZwAf9OlQ373MZSQQD+mdMC7ACkivbxilWvU7
         e4tQ==
X-Forwarded-Encrypted: i=1; AHgh+RpMnfc79krBJtbVqFOR/kJ2qh1gXquYqmMLuHQfxoi4EVh6ujjl2N4tFJ86h9HrmqHZrDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCot+8Hf9D0oNtJu+mRm34CNbqdVEAbCJWnbYQnujuxrvcJSUW
	z0kTRuh92RTG7OnxH3xg1iGkTDG2S0SuiFLuiJkGfLSdPsCtbqrzqT0NVvJfzGhPZ9OOckleqp2
	g0K6/e1SeLXW4TaxH1kLow+EDK/oVZ7c=
X-Gm-Gg: AR+sD12B7HpA626TBCEc5FUBzS5xUmkDFmiPYbNFJfR0XVgmsEvvuc21qegHV5EPgRq
	aSz5IEuIPr9tZPZKz6dE7aVBr/ap/2RhtHcO23jE079034s5yMpAxUdD4COnT59pYaDKKTxuYGL
	nG8xCRS5MSkxKkHdr+KpBUo35pIk4bK58sED7qeP2LE7SbM7GwMDxl/8xbXayDK+12fE3BSyyEq
	fMhBPc31IT9UqC1hadzA2gf3ddronejFehnVgloQhkuTCuRXf+OKadDKZ6ID3BWsp0qCoFtyY5i
	Wr1C7631bDm0Zmr/QUkMsa6HL/H3lYwPm12kamFkrdRtkA8J6MFb4FOZ74xbGJ3ceP4AvZOh2+o
	=
X-Received: by 2002:a05:622a:2590:b0:51a:8c79:a2d with SMTP id
 d75a77b69052e-52b56673ed7mr13843131cf.1.1785511851030; Fri, 31 Jul 2026
 08:30:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com> <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
In-Reply-To: <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Fri, 31 Jul 2026 11:30:39 -0400
X-Gm-Features: AUfX_mwCzstzsX_jENhs2p3EGP2HH7m68AkpKrdRcMR6AmexYou-kWEv9wNOVLk
Message-ID: <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Paul Moore <paul@paul-moore.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
>
> Okay, it looks like there was some confusion/misunderstanding.
>
> My understanding of Kumar's comments was that he was referring to the
> exisiting LSM related kfuncs that are located in fs/bpf_fs_kfuncs.c,
> not necessarily the new kfunc you are proposing in this patchset.
> Kumar is welcome to correct either one or both of us, if we read that
> wrong :)
>

Yes, after another reading, that does appear to be the case =3D).

We'll need v7 anyway to fix the ocfs-related UAF the bot found.

> However, regardless of Kumar's intent, speaking as the LSM maintainer,
> my stance on this is that the kfunc you are proposing must live in
> security/bpf_lsm_kfuncs.c to be acceptable.
>

Ack, will do this in v7.

The Landlock series currently up for discussion [1] is proposing
placing its kfuncs in a new kernel/bpf/bpf_lsm.c. Should these maybe
go there?

[1] https://lore.kernel.org/bpf/20260731022047.189137-1-utilityemal77@gmail=
.com/

> --
> paul-moore.com
