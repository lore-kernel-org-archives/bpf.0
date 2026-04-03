Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B3233123B
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775241779; cv=none; b=IN18VyXW/nIZbBFrUrWprwJOzH9c3iy+8vW3zTeUBCIzMQMW9myA6Hz6yUoQaYgjS173LF7Oo7qlBvzm2wjda0DPsy1Vd8y9d0+OaP57FbsM1a2oHmOMRbEMiYZa719Z6XfkCLCFJZXzudwnxMxmXt+N/KUczkKHhHX1eY6WGG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775241779; c=relaxed/simple;
	bh=YDGAXnp436uvK1j4HddHB1hSeEPBFMwSlx4EZeXZKuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u87Cc61IPtUyXdM3SxQ8eMKe9pycbZRnHKRCZT4gRKusiazRi00F/UOAe8ohW4VBCO5TXVVVN0f79JO53enbbujEgL75XYdZNcwIY7ogKSfPtbV0GRq9FuxEuYd1OyCvsdahmjUBq8b525SrHdMcv45YhnBgBcZG1NoQ/pZEIXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tb7+gND+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tb7+gND+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0468DC2BCB0
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 18:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775241779;
	bh=YDGAXnp436uvK1j4HddHB1hSeEPBFMwSlx4EZeXZKuM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Tb7+gND+m5BygNBtIjCJYz8R2lusxwtewP9hBENZ/bOWmFNQ32HsbS/0G+xWqOtle
	 NYjfUPmqInitogkwJCieMQOqQ4ltLFYjRRSsvhaSXVoywHbAzunLAJudwOyVBikWqn
	 fdoWioubDOy12EhdICIULUYd2oarEhBvsol+XwVTKtzXFOSISq2Ou++c69PXQ02u7F
	 +oqDPB5M/+w/aTYfI0NAyYa4+n1oHzybhfPyOWvsa+8qgyTOh9FuqNmLqOzB57O68V
	 XiqQziH0AsEwz3TiSj9wMj/dAELVP4TruZHuUALBaqKgqNDpSes1dj36cDpaCW2tWY
	 13VIvyX/NSInw==
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-89fc4147f2eso32033956d6.3
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 11:42:58 -0700 (PDT)
X-Gm-Message-State: AOJu0YxT+IC/JlLzatpCldey0oCo0fxgcE2UoUrF4E4S0uQjTXjGvM1C
	TVlf00Q9zTFYV8dVorXjqwSHiTmVXdNhaDJPBKBJLYlhHajGZ5C8YxI+dirgoMYV729m1G3WWf1
	6Vhstfr4EMTfBIbCG55T4sZmLajy+Nf8=
X-Received: by 2002:a05:6214:4611:b0:8a4:c1ef:d72d with SMTP id
 6a1803df08f44-8a7022bc2d5mr64717436d6.6.1775241778125; Fri, 03 Apr 2026
 11:42:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403042720.18862-1-emil@etsalapatis.com> <20260403042720.18862-2-emil@etsalapatis.com>
In-Reply-To: <20260403042720.18862-2-emil@etsalapatis.com>
From: Song Liu <song@kernel.org>
Date: Fri, 3 Apr 2026 11:42:45 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4v5jxnO0g-+DDBvppM09ibjKL-a8a7q02-WWu+iLbWrA@mail.gmail.com>
X-Gm-Features: AQROBzB6yGmkMl3cZ7lJFrUAemPdSzEZ2aINET_24AHuqwheWDrruh576ftn_mc
Message-ID: <CAPhsuW4v5jxnO0g-+DDBvppM09ibjKL-a8a7q02-WWu+iLbWrA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/9] bpf: Upgrade scalar to PTR_TO_ARENA on
 arena pointer addition
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, memxor@gmail.com, 
	daniel@iogearbox.net, eddyz87@gmail.com, Emil Tsalapatis <etsal@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 9:29=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> From: Emil Tsalapatis <etsal@meta.com>
>
> The compiler sometimes stores the result of a PTR_TO_ARENA + SCALAR
> addition into the scalar register rather than the pointer register.
> Handle this case by upgrading the destination scalar register to
> PTR_TO_ARENA, matching the existing handling when the destination is
> already PTR_TO_ARENA.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Acked-by: Song Liu <song@kernel.org>
