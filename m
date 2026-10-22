Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792644398;
	b=Gq5/M8QdHWgVi0kTwFjcmbCu26M8sRpndSVPVKmh/zvd4ODa3FgU/oTnf2VgfCoAx7Dk
	 kKxJqV+80vPJKU8GucZHU5GVsdHFT8+3E55qhTUszihjtlzgPG+qCnTzreHepAFZjw9lo
	 nyEGAejwmMJEfeHp7+r8qJr2LqcZLlfmCu/iQo4OqdHKsZWSwetEbolKLqOnmU7prN/+w
	 xto82llM3E4b2EJKUOnLBFySvdgqaff8BhItr1c1QKhocd9iJWc9g/7TNASZ3p1tGYpIA
	 +8u3oEYlDjLJUad6UJpvXiBBEQFugnnQUXVCSY5krYmaAFf/4OW2H6lSuS4BZRLBEcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792644398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=5+SumxBfrxjsgvn/QRWIFxElRphz0iCgG1RZWJvYrNA=;
	b=e8vh3W5aUkweOQQaOxvy9D6sc83pRPEzTje9CM5Ed8Nqp+NvaqjMsr4NBNdqkXuihHD0
	 3sdYOX8UkPsLIkwOtxpNR7PjgedtF2CNN4EB0hFBEI/uUevRdqq8ECWTgCm+1Tu7oD7MT
	 2yJocaere1qRnCeSyd09RjFdZCGoM8eWoDTlaNiBe7fctcsxmjyTwwd1NdPO3K4Ypf3rZ
	 6Mp7Y02x2hK7mRB0r9kigHbkMrTZIC3PEA9UHSSbqdomJceh/X6azPogcfpTpW3v1JvRl
	 jMQ1s98heCQ4IGSYY9msJ1Db4yxjzmIhF2S5RUUjPOk0Whi/eCnJKXumDdobablLqBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cWRKB84X;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A947606A319
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 04:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A947606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cWRKB84X
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e8fe8e343fso9595355ad.2
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 21:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792644397; x=1793249197; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5+SumxBfrxjsgvn/QRWIFxElRphz0iCgG1RZWJvYrNA=;
        b=cWRKB84XbahQi2H3i46ML90oKr8CoWeebcyTgeT4j29KM45JaBHNkY3VVfQToaWRCY
         BGNsb8PfqrzJsbVEzZvQCYt5KGMeUYhIhPJNpLzQSbuy1vGgt9seEBMk4IpgKNd6djdU
         vqSr/AcJTa0uq4ffUsVtNbx/0nhEePAqgJUPllxtYC8LA8rdxYXo8Ii0M1jSkPbJNKTd
         2/by9H4JWo+P4e4Lt4Dhn9wL5ezmyy0QNutBAnHpxeX09Zx6cgFu7/DoyBc/o7Ou8MRT
         7D9IdTPjmWfRm6Anb0/PpfQKnsabgtQ5SoXX3gp+mGf25XKu3vCamXHGCAb6wLLe0lgp
         117w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792644397; x=1793249197;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5+SumxBfrxjsgvn/QRWIFxElRphz0iCgG1RZWJvYrNA=;
        b=LkZkw+Xm+V63b2TrFA/IitZLvLlEJbGh6vwsuvEJCBPikBRENiyvmKfTouLIKcBWjV
         KRUcPan+7O3diNObjxCj1moLRNPU7fWnSg1VHLpH3XOLD0ocNmgTh0GLP3uoHZ7lCRrG
         VZmVM6rk/RHfq/CzPqyl9rip8q8xBRW2RTmxYtM2pLRqa1jECLjdzcAjZ80eK65iTUmm
         /SAclfqdMaq3yMxJzFE2sDRQnwYLT6YRT5jQSfNVrjzygNyjZkDBcXrbC/TRrkEk1DyC
         +xDbhEw1b1TgG+EdYiO++DeL33VgInBwdMI/dEUzm4rNYLaClDXY0WXEsQsdXnJeGCyB
         yxWw==
X-Forwarded-Encrypted: i=1; AKwUvBzlMkQ9quSrlPvW3LD5G+EoB9/rFlAnER4tqwxLsJ9F6TXWuMVfQvTR6zJYcB5kQolUWnk=@vger.kernel.org
X-Gm-Message-State: AFq9FYI72+xJt8tMJEOXCCOOx4rhb1XNOPVfUppoi/5VpKBCOAQI9dYq
	6d71JVcaDMRJDtGRTb1tk5E4HlqIeWcQv40/tgZdha4Ae4N1V+qDOPrh
X-Gm-Gg: AYBFou2QiCttHuH7lG/XV6Z2CdiooS7f/ILgU0P/XuS7kZF4JLH4h1u7mQoRqjdnHrH
	3xl/2/0tcBEyMN14FsqRiftwPBCltp/0cov353uTqDKbCPFAhGQe+QLjX19zlnacMnQxJ17PFMd
	oCkUxuftVtQ9+xy9IjV2ncRirQamr4JMVr081t5yyHct43YP/YEobPOvkbHygecfqohQZg3d8hd
	meSHbLtUofHJdOclxRUAsWxmGMidjGnCv+9WGv8ox+7UcLLVgciTrknyIJWLGox0fSkSZr9lvpP
	rCPxiH7/lnPuC8YYpfM3Dca44+sYZXQLutVsK6B98EkWZ8YfPGxsvR6QfGd+5Nuv0LZivXpnWMT
	8Qo9tLF37gk/mCSoEv3dQueHrAzaGsZF7LutxIFuFKUJZhL+gs8KRSL0Y3VDl+kjGVXfIY+SIoh
	BRh5TDH4lonLI/0Aofv6KAs9RvY9sMYEFo8QLFEpx98eqT3EwPl5Og36gvqeeoI4sFstS/7NKze
	X4wFnumW7jxwzlHxkq3uIeDBjPH5M2Lul6m+yB0ZQADdv7QnU4L8ov1T7x2QqtP2n38/EHdS5xZ
	Iybg/IVp8w9bidGSNJj0Tkr0MrKH6X56H5dr3ETjMoz3x7FdYUojOKXs23veTpRC6mdMwbjw2bx
	rCI5acg==
X-Received: by 2002:a17:90b:28cc:b0:3ac:86a0:5764 with SMTP id 98e67ed59e1d1-3ad86f43109mr3159843a91.64.1792644396689;
        Wed, 21 Oct 2026 21:46:36 -0700 (PDT)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada490e5edsm2287101a91.8.2026.10.21.21.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 21:46:36 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Oct 2026 04:46:35 +0000
Message-Id: <DMB3EIGZSALV.3C9PAPO7TB923@gmail.com>
Cc: "Amery Hung" <ameryhung@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Nicholas Carlini" <npc@anthropic.com>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v2 00/11] bpf: Scope callback arguments to
 their frame
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
In-Reply-To: <d2369629-846e-4fd8-b567-a0fd8863256c@linux.dev>
References: <20261009202759.50520-1-ihor.solodrai@linux.dev> <DM6EVHTVM3IR.3RCFLKV9WC80J@gmail.com> <d2369629-846e-4fd8-b567-a0fd8863256c@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Oct 20, 2026 at 11:32 AM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
> Slices are not reached. A slice's parent_id is the dynptr id, and the
> walk from frame_id finds that id only while the dynptr is still in a
> register or a stack slot. R1 is caller-saved, so the bpf_dynptr_data()
> call that creates the slice usually clobbers it.
>
> This can be fixed in your diff with:
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index bc12df55d2e2..57859c3baeeb 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11470,6 +11470,7 @@ void mark_frame_scoped_arg(struct bpf_verifier_env *env, struct bpf_func_state *
>  {
>  	if (!callee->frame_id)
>  		callee->frame_id = ++env->id_gen;
> +	callee->regs[regno].id = callee->frame_id;
>  	callee->regs[regno].parent_id = callee->frame_id;
>  }
>
> i.e. the reg is its own parent again.

got it. you're right. Let's take your one-liner.
I think the reg->id != id hunk can still stay out. The reg is
invalidated in the same pass, so the second pop of frame_id in
invalidate_reference() finds nothing and the loop ends.

> I don't quite understand the concern with the series as is.
> I'm guessing a new weird REF_TYPE in refs[] which is not an actual
> acquirable object gives an ick. Or is it the plumbing?
> I take it you agree that we need some kind of frame-tied lifetime
> tracking, right?

Yes, we need it. I guess it's the plumbing that bothers me a bit.
The id belongs to the frame, but refs[] is in bpf_verifier_state and
the callback runs in a pushed state. That's why setters had to move
out of setup_func_entry(), take a state argument and handle errors,
and why refsafe() and check_reference_leak() need REF_TYPE_FRAME
cases. A u32 in the frame needs none of that.

> I added some refactoring patches in attempt to avoid growing
> bpf_func_state vs v1 (Eduard mentioned we create a lot of these
> objects), and that is what you've just suggested.

Right, it grows. With padding that's 8 bytes on a 960 byte struct,
880 of which is regs[]. I feel it's cheaper than patches 1-3,
but I don't insist.
