Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C020B233920
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 04:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791261553; cv=pass; b=k5oxDoxq5c543v5msKJ47gbJuEFCHZ2wn+22hVJU93GMf+dBugLq4fEWdUct3hCn0dvk5S/volqf6YSw23Fx0cTNDmztCqFYJY+1qiWB67H8SF1i4FGlWhIXsYGV99p7WOMAeNlmQNv/gix0NS+O5z4TEFfNYH9Mf1NwXoAaI3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791261553; c=relaxed/simple;
	bh=0zD50AresuS4NxZBuKlzPnhqOGy0n6PBx0KxjwkOhVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=peEPA0sf/VKLieMUNDizTMusfLFJemV+PDRsOZBaWFyWotGSBgd/y/kvITSt99Ys7wjOp2w0kG1vxH5rC9o0Lef/qR+2wD54k7+GTawUoRlXquG5GI1+/mNhH00l/FKXA/4ot5IbnCoahh6lZSasiJF0R0IQqvlIM9s1sMqinRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5RwE6jx; arc=pass smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5RwE6jx"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7c1916da745so385257137.0
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 21:39:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791261550; cv=none;
        d=google.com; s=arc-20260327;
        b=l24IMdDc262btPsCvv7SvxxyrgF4EcM258jVyp4LbrV4Mxwm9cq4VElwcXxkxwX3TI
         ONZLkK0cnIMdofaIAIK2i+6WjSAbyk0l7+inDoMhRm67d36rhDe0qX/iEabGAcmVA+Hm
         s2Y9HtDtSNPuI3SilDZnasEf9yMiOcPXd+AkRwTAWwYW1tyQVgMnc8Z2jgkMyOzPoHcg
         g23WRbH2kMGDG5d5tCVRo0ZxB+aWXnZ5U8GGLAVEXLVe6wsKqLalibHF6g9z2eKTH9lj
         3zfUT7bI2H1vz5qKQNEu8Md8D4vDG5zXz1wt3axQeVN+o4TBppb/1wWmiu7c/NQrRRsl
         apVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6ONq/W5i5EZtiMOmRR6KrqFCqLA2jXIPffovyR6fm2U=;
        fh=h0M772Wc7yw1MAJ3BAMyKfp1RpxQhbByCeBn+Aysib4=;
        b=J6o0PheghhWsZxwWb+YR3bLiIrS1RST+oEYwvS76HAklsDQpAx+731AbI8pkQ0Dq3t
         qYmVMTCulxP7J4Fw0tNTXDj73LVFjxofgzmEBS65QWHW98pgqNgoNOM0NDzLoSYPFseL
         zjm9ILF+0RPWfkL3Hvr6bFSMsshH+OfuGx9Q+PoWmh72KGyG4b+jdnFX5axOQ+JzUUZU
         2nb7lKvNlpC+u9uvTo5ou3fECTHvffBLr+7sTgpaKIaIkyyaimnsVlA+ZyXinPsJOhze
         1LKYBIWowPFpEjpeFCT59SckrbJv1+rS6EC5Yc1htDD3DpApu+BOLfy+Qr3j5AwpX6Sq
         Z28w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791261550; x=1791866350; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6ONq/W5i5EZtiMOmRR6KrqFCqLA2jXIPffovyR6fm2U=;
        b=i5RwE6jxZ8pJVbQ7LtveVV7LOVpzXmXQvvIjIKbTRAvMCPJgzyiHqdOWY+lkSV7p6k
         8uF3GLcoNXwLwUPUlmF51ODRRxtCvBYzrY+5Xssrnc9LjzywXPxZ+6tNNkA4hjc8cOlL
         UUsQJSsLFhWBicLntwCQ7i2k6Nc8ZPcbWOLsPCJT1H2+rCjPW0Vmd1yeLL5v+sGYM/iu
         KaMDaMmwOJnI9dJSJZnc23yb03Ukdju5lSenYzAJKgsDjeK1WHiczTxvzzhsHTdPCwZF
         f/DgnSMHSmJgVMR1QJL/iDQi1WUUrXlJuSY8AQ9fpEwpNdDk0Fh6LmaZiNqb07Oesls4
         KhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791261550; x=1791866350;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ONq/W5i5EZtiMOmRR6KrqFCqLA2jXIPffovyR6fm2U=;
        b=NU8FbRAHtG7Ookqbb6rZg0V6u3KJ3ZYQLz2IQXCLkgP5QThnghF1K+5WUBuauCAYG0
         HuOmePs8ESSIP2oGE4rhuZIA40xwlbjQt2y8bgXobqtw88Xt61S7/mnnLTRWCejk1QiF
         1rvXQbj9GJhuBedelwSEXKzFaus02aIwj7XbkSPtTshh1Gy2AOt2QDYCMPnFX/J1pUbo
         Aa4x+3Ve0dD8SpM2h4PFrvdxmVsH8otILWQp0A5m4k0M3uysufwAiOgqPg16dL+Eirde
         x8M0QCcL4+FGC/fXhObLGiFt2xz1vYlsOTqN9K77Z428U4RtZnQCut9JjBITZjPHuRqs
         E8pA==
X-Forwarded-Encrypted: i=1; AKwUvBxJG6ku3IzGTno/LloJLpIxomDmzrPKlteYODmRk7IZtL8Ux7GdAHx6uG4FF71Nl/Dyg7c=@vger.kernel.org
X-Gm-Message-State: AFq9FYKI+oGQqtGaFLvJFCUlYY80OPa1O9LWE1b8HQSpcHgXMV/kmtZ6
	R2Mtz5SpatGtVpEBLBPdNrlzHJ1e4FUSz4yzX7Erby/AvbegPq9Jh9PZGZumD+FiSY8bxkuHN59
	0J20pB1l3bT6IDvo1NHUrJONA6OGy5Pg=
X-Gm-Gg: AYBFou17v3onJ8FGVtRg4dFFvenr163ECqzs10ViR5OxE500EgxF24UDptkf19fgQyk
	2U2HepMP0OJL1YNlDP0TbHhzHadI3kxIllWkQp//u92zAAkBXrdvQ+vDKTJn0Jo+dDgwuLhBwr5
	RCSG5Zn/VkkU9CE6dvBw1EbGzwStKseFX4RB7ot6omj5hhMhH1bfpXoNE91t6SOIQHDFTDPM8xE
	AQ+xEWZovxsvZ4c4QWkbkp5YlRlOCT0ytnIhJwfrk663zwqLQF1nLTqRvuzCnyNFIFh1FplDCeL
	ZcjDhfgOXVQFprpNCjiucQb2gn4dQm3U7+IOPQmeM1bQh4phmTIqPFvvkVeDZzJc/oFTSC3CCyP
	x9DUjnPVsHFbT6N0SO6WB88IvRRqet3ekKgv1obw9JoC2/G8MwUa710abwfgXJ0qvKoL1yv6naU
	z8vDLF9yM/2LNL1DZ+IawtBjwnaK71Z5V0KgF0UGeL1LSk39UUISWedUo=
X-Received: by 2002:a05:6102:4421:b0:7c3:874d:60bb with SMTP id
 ada2fe7eead31-7c87a003906mr20133137.5.1791261550653; Mon, 05 Oct 2026
 21:39:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-xsk-suspend-teardown-v1-1-a6cac8c030be@gmail.com> <179083158364.31693.4968269038838216649@kernel.org>
In-Reply-To: <179083158364.31693.4968269038838216649@kernel.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 5 Oct 2026 22:38:59 -0600
X-Gm-Features: AclHuK8x-oUXR4AyeZa7c0_2JwPWEPKzLN2cv4VlS8Xre1iikpXXL7wBlRrMRYI
Message-ID: <CADvTj4oBtxJM5Xj8ThVn_2cW6RCAx+ohc78idqaX1WUP+AM=Fw@mail.gmail.com>
Subject: Re: [PATCH net] xsk: freeze deferred pool teardown without blocking unregister
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Eric Dumazet <edumazet@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 11:13=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrot=
e:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

Found by source review of AF_XDP teardown during system sleep while
working on the larger stmmac MTU/resume recovery series. Further
unregister issues were identified during follow-up review.

>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

These are code-inspection findings. I have not reproduced the
suspended-device access or freezer/unregister deadlock in a running
kernel.

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
