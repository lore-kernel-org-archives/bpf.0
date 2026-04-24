Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FA4391E4C
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777045927; cv=none; b=JqPo/yVZ8ksdgypOmnvNPIDUluji7lrRQGlrCw4Tmu4Ddc2BJGp1jXfY70/R7U43B0/Vt5PbkxdgGdsG6ZachoZwdtKL+MLDweZouGeJwMwQBvs5Wp+bumgwVDjUhN1GUAiduQ5ahFWVtqmLSdJXMzbiL43EdS/216IuVTmQAEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777045927; c=relaxed/simple;
	bh=Q3t67leeswQbfHpqp0eums4/vkXiYlW7pS+Ion7RKLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oavk3tZ6H2m/RIbvAk3Az07R7u1gUbtL3AMN5zikOqlF2HG78zVO/3D+Hwsiy+izI1MMJj0gtVNCyPimneJjW4/KSGKCx/moJ71Nnk+/aHAMzMETfQWz24B9fA3zzvHqPBQcoI3MTYqA5sbDH1eBIS980K+OKu7AM77tpowSIBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtE8SwK/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtE8SwK/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D7DC19425
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 15:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777045927;
	bh=Q3t67leeswQbfHpqp0eums4/vkXiYlW7pS+Ion7RKLA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DtE8SwK/pJ6JFFS73e/pmrJPUZMIIhnJpSlRT5a7AtEcuA5TjvogYW+Kq4QmWOjNk
	 OGMnAxRPIuSUzcyXSCahz+oAOJUhQcyqobk2R7INzOJ/VnQiS9NJITiDvjCJVwBWHU
	 1v9jWzMpe3GakRN9gm1TGTy3WUx8wWbdyNsfCpCHZH3tZo7bG9XDG+fe0d5pjF3j/D
	 dl4DW6IvsHtp34eByUFBq6raGeaZQP/Z8JSUi6yJva/z/uCLDTnlryE4g7x4rlp+sj
	 kNEdhGpuhyUN1/b6pVeNZBOiFWS28r72ER2IOmgUA/p83WqKgjpGBAL9inBm++2hAo
	 jB8gwLcd6lbxQ==
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50e5bea4045so50478431cf.3
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 08:52:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+Zn3sYPjbgHPeVyqA0/CyRWnSIN0+qRtS3NlHKff6QIABN0Rzkwrw1CJ2NpY1D3DBWc0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCNu9pnKa6kM1+xWiywU9LzNXJV+lR92dLiRhqfAz8MCIdCEXG
	ir+vmftkgXt2MpNik9rFoQ2W7zJESxbSTJ2Hif46Z8rxtzHdIGK7unRUF6EeHrYnZID330j3Zge
	YEMOXM4G317tjNLXxgHw+s7HwIiUoUp8=
X-Received: by 2002:ac8:5d12:0:b0:50f:ba44:ce4e with SMTP id
 d75a77b69052e-50fba44d76fmr223489571cf.6.1777045926451; Fri, 24 Apr 2026
 08:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424153905.354922-1-jolsa@kernel.org> <20260424153905.354922-2-jolsa@kernel.org>
In-Reply-To: <20260424153905.354922-2-jolsa@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 24 Apr 2026 08:51:55 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5yaQknFEbEpgUCcY=-6BYxSC_ey3kNspuaCceV=biP-Q@mail.gmail.com>
X-Gm-Features: AQROBzAVtnyxqxfN_3xUoX52-BQR60ZtqeDjSuWopfcpUcBXzWKjx56oygONXm0
Message-ID: <CAPhsuW5yaQknFEbEpgUCcY=-6BYxSC_ey3kNspuaCceV=biP-Q@mail.gmail.com>
Subject: Re: [PATCH bpf 2/2] bpf: Remove obsolete WARN_ON call
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, stable@vger.kernel.org, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 8:39=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> The WARN_ON call in bpf_trampoline_update could never hit, because we
> direct the code path with (total =3D=3D 0) to out label, which effectivel=
y
> skips the WARN_ON call.
>
> The WARN_ON made sense back then when it checked tr->selector, but now
> with total being set just inside the function it's useless.
>
> Cc: stable@vger.kernel.org
> Fixes: 47e79cbeea4b ("bpf: Remove bpf trampoline selector")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Song Liu <song@kernel.org>
