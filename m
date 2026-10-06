Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8837D390618
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 23:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791328213; cv=pass; b=NjoNyGREwVxoEq1f9/x1Bu7BQiqs9SSFPFaWv/mvf2vZO5Ttwd7qJagVft9vH87cP+Q5W9toGxtlgBcMWahrxi7UFeLcNPmeZbU15ufuCik6pUYlvKcYl1S+7gAUhpyf35hd0ZmVHpQoDP++pbbWHA5liPkZuVWh9Ae9s52oqVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791328213; c=relaxed/simple;
	bh=ibmYYYozCbtMLN39HWQw3hos6Pppwape+/pVJp+rgBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RhOWm28KFazFUi8Pu2oFP++en20lcoZa/q6BUKZ0XToJZ7OLZe+M3hq9teEHrAq1JFpyJm3DA6sm3C1csuJp5I/Lf0e9zrmALz0V0FTKiaeM+8JFK9y62nlb7RWKgQvitmYg+LXCEE7aHHKNnrjEgFbIZxTi4BSpG+Eoc2vqCzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deH1s8cr; arc=pass smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deH1s8cr"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4c27f0df6e8so1558838b6e.0
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 16:10:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791328210; cv=none;
        d=google.com; s=arc-20260327;
        b=Jyi9wLiVjOogrAnffLoyY5AIKpDLtFHnqp+2m8uChRfln5Er82dWJIV+4Zoc6k0zOr
         kaWUv0KpzkUR3cyxHVkwwhrV+F5CwARPAqxHhgPo3mLaCmjSsjY+KxkiwgqZOuZouV6F
         eO+l/QxSHwcKqVXwO7IykwyM/AHaeLK2S0iNbRjkM+JMAIbn34PpPQcuHzgUX4P4seSn
         zr3ebotsiKjfNXhgmODod4nPk5nqimARjGpJde/ngG23TIVIFWzGb+Yt+RoiS573J4+E
         TGG8nwd7OP/BEaBbQhVyw3zANTaSVbt/srdiHewWzNfqWodVIhCGIet9nwKgvLURHr8v
         gtuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ibmYYYozCbtMLN39HWQw3hos6Pppwape+/pVJp+rgBY=;
        fh=xEtUg0CazM0KPNsZhnjqZdHWGOMSEcJ3RKTpIiYqwQk=;
        b=R+k2wSVmnizZ7krirv5WI9pgkZy2BNIR2wa58ld6kM+PQYMSVD168ltiyxKh8oIuRZ
         44vFv5ORyWyhCRnmH8RIZHOiKLx1WEA7wZFG+Ig3QRBU/1N+o0664nscEzKw8OLuok1r
         bpCU8FliekuaIWWBTEBSRyjbDeLkgoKMzPTBRTGOAsq38EuXHRcFlZtDOLmXrx7EJe4R
         rVdTGGS5OEyeu74T9IS/KTrv4ULjSTDpx2ttAG5FkF3/AcsnbCY09vB7eFauQS3OfgQT
         s5BL5T8gZz8cffao4v6r1jtSFg0dSENPZTIYKbqPyGg5viKqIDtqZDbUaVuzzd/wBPD5
         r5xQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791328210; x=1791933010; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ibmYYYozCbtMLN39HWQw3hos6Pppwape+/pVJp+rgBY=;
        b=deH1s8crQXnQgolX7TgpfqOz6ebUlY+QmZUxEzdP0M/GUajzCnkgvBwdgy0jpoq4kQ
         cL/5BBQ1Rmou/izfL6NF4EJcRKupVouDv1z+0rrVtPvuvCXnDkcfyVHFXGwWPDUHECL0
         EUdMk1hGiiCb+lxhcmRdApEiFgQSK1m/tpqqRnh+EMtrw+n6BGVSlgliLG3F+RAZZinZ
         TGdHrw30HI2sN3tezoEP6Ftw2uA7+DF6LT4Ddklk8a6E9qYEJvr/3WRBod8FVxAJQO/N
         Eiyy0lwaQUGr+f8asLiuHbou2HEw56ItQ3m4G4lRhd+kZZgAvahVg9z3gGs4SAeB+mW9
         kAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791328210; x=1791933010;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ibmYYYozCbtMLN39HWQw3hos6Pppwape+/pVJp+rgBY=;
        b=aR7prPfskNbFe44swSndIGvO5HToiB6mAyPikdL5x4vWjNEdoDZ3504K7zckzntiks
         7u2bCFutf2I+uuQ4RZq9GxqJLRRyTJc8x6MHNrJkDPfaaMaOV7QBBg8vXOgiKnXdRT6y
         13WxuEZ2fHYFaRZltvQpGnmzpFsR7R1wryULtAGL8eL5dIPjEsBACmg2LxZtwWwBqKiU
         HLt11Mh8Y5dT3v5lNCYQvwOMK+UQkhlxQDEu5UuMpzaCQKuQWwN4FceY+LZMDWxu7wt+
         6/K0h+ZLyIS4ZyPOZTXlUi36cnnxVr2geI134OlZ1N9t5O6o66Ie2dOz735dY1AgTTop
         ErnA==
X-Forwarded-Encrypted: i=1; AKwUvBzizFlry7CCaBdLh+k+W9HRkcQ3sdR2uy9cftj3zpZqGq7f3zdr0zlKnJ6vOeBN+4cE9k8=@vger.kernel.org
X-Gm-Message-State: AFuF++nOUmZZ7EXAtXOF9bEEm00rjAi8ozEiUQr+z7jvbgaPTrYIS0eT
	F8yZxrr/ugIrR/7kbfxp2SqYCRtSPxrI+Bqjb2YaIe7waC2t1YZ5l4n3oQ+/EOYW/WyMoC9w0Bl
	FmHQ5KDkK4N/nTCPDCXAJffx41MXVECM=
X-Gm-Gg: AYBFou1tM2v8wmwaGehhVGvGhFOL7CyBSu0O2g3AfjFIC/8KhpHcA/EQyN4jQsQ7gO1
	3HzpG8wHrTst33dyVBEVnDrUn2ty5VCzEq6KDkTn04AFXlsG2kDP9EFBn8wYGwOBCRbAvTfg76n
	F8lWeJiaAqFIA54cYwrc+fOOwEiBZ1UERVbty3yzeKMZUJ0aCbp1am1cPfLFFhc1hl5Ikw8szdc
	EiZ8i0L9F6Rxi41S+K11G+iRHumkDbbi3dc7r1cBms+HcekkpNZYFgdN1vT7jReEQRVz7l5JK+p
	MG8Cj0mxwcPHsHEYl/dPczWWBcK82XAaDzahrNoR7KaM7VTYMV5JuoTZ
X-Received: by 2002:a05:6808:4f2b:b0:4d5:27da:a498 with SMTP id
 5614622812f47-4fc4648102cmr846517b6e.50.1791328210398; Tue, 06 Oct 2026
 16:10:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com> <20261006192601.1875100-2-kuniyu@google.com>
In-Reply-To: <20261006192601.1875100-2-kuniyu@google.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 6 Oct 2026 16:09:58 -0700
X-Gm-Features: AclHuK-l4-iuHEPHyn3LL449FCmDh-CgW2cSSbCWIUk2Zw4pNN2ae4cxCj033rg
Message-ID: <CAMB2axPPyap2KDGqMqhCw6sBdqWb2G_68D9D7z_ow0YqYzpdpA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 01/10] bpf: tcp: Convert deny-list for
 bpf_{get,set}sockopt() to allow-list.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 12:26=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> Currently, four bpf_tcp_ops callbacks are not allowed to call
> bpf_setsockopt() and bpf_getsockopt().
>
> However, the deny-list is fragile, and when a new callback is
> added, we might re-open a can of worms. [0][1]
>
> Let's convert it to allow-list.
>
> Note that it can be written as offsetof(,X) <=3D moff <=3D offsetof(,Y)
> but clang can optimise to similar code anyway.
>
> Link: https://lore.kernel.org/r/20220929070407.965581-5-martin.lau@linux.=
dev/ #[0]
> Link: https://lore.kernel.org/bpf/20260421155804.135786-1-kafai.wan@linux=
.dev/ #[1]
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Amery Hung <ameryhung@gmail.com>
