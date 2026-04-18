Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CBB1C860C
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 00:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776472702; cv=pass; b=t/AlsOOXcjmFHeH1uCPHgdMpNyq4J5gIXBdrWv9+F+FPyZiT1N2s0p1flTDTsg3WrUOUOX02rEQV4amjp4/Knx6Pk4L3zjatKG1KkNx/lTmNB6Uf0fauCN82587LlKL9bOfW7NcOJlT3a61O29XAO3HhE+FrVLfk2R2J+jMnhIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776472702; c=relaxed/simple;
	bh=8lxkLuu3KAefnO1/GPLtbPT61JCPVTwO5BbGKRm7Evk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qEL/XyyNXFIloW/+ErqJ3K/KdvESyubPwvqJL/BtJkspxPp4DxK+syu//JNwaEz/ZBX9H3L1aX0fwo+/I0aAoNiEj8kvtmiqpmk4xA1DXZg9SR9BE9P617J7T/dcxQSRPZGhJ6NiaEGAr9dIcGA0RKfOQm5mEwiMg24vOTKm/hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiPqDUw7; arc=pass smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiPqDUw7"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-60fd9b71745so482964137.1
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 17:38:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776472700; cv=none;
        d=google.com; s=arc-20240605;
        b=hgRdsF2rB57zgUGkQNwAfI+5P9dp/Q6Po7RIMSdOnhwG7rOITtH27cy+ld68e6/18+
         Uy+3XvzyE9rHMsKMLtWKve8VeqmaEqdBtrgf+LiY8IKnA9mCagDvyZ21/JBORB/8U8D2
         lLSap4XLgh7OWtl43qMfwFSuu74BzHXBH1A42ckrYRg8+0fiurKpgLl0buH+YJty8FNZ
         Bz4p5Uq3VtVakVd0sTPsTeDGVla1N0XUT/t3ODCNKc09TH5qJy3uB516f72luf3Nqesf
         yAxTsE2eZCTXQCLtpriK+FgiGZcgzy1QOffxhp65Y1jK7XP1b1leWki9N5svdRf1BiON
         +gpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8lxkLuu3KAefnO1/GPLtbPT61JCPVTwO5BbGKRm7Evk=;
        fh=ypw/5fet4CANHeQUz+kfgabEvSoH35hHHOlcI8B0sBI=;
        b=g8OUc+Idd1e9XWfVlJFf5v5l/k1UPe1n5zAyCBOgWvMwb2LJpKuFbykLRSyIka1YzO
         lFzGEG/KJizcqAUXfeuV18hiUPSTTDky3NMMnbmmLALRLk9KCn/Dhk/xZLuTZ903hMCe
         nhsmYeI2NoggwJd7EHRqJn1Wphrc8nng8DTyU4HotJrjGTOcBzvp3+uCI4MDrQtM5Ksb
         /rk682UYrcs39ctQaLKDRiAgY2EO4kEfGs5991p8NWRU4Z9zuFle00Vz8aJCKd8w7526
         pf2QJVsdLGz+23F1Pjuol3YC4o9AWoesXPd+5teDgJ5/45XfgVOkNzyV57zYxU4gSk0M
         xerg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776472700; x=1777077500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lxkLuu3KAefnO1/GPLtbPT61JCPVTwO5BbGKRm7Evk=;
        b=RiPqDUw7V0iPUGgcQYFGfqtnIcOGloxqLA9IRjlRc9eDOUA24OTfmqKpjI3S5QSvgW
         bZ/1yMq10pZl+6DXU2rL7grj8bZatfZnjIXIXSgmQ/D7up8wVi52IIEipMFD7/oAGQj2
         7kSQ+22K6aN7Q41oSbntUcZBoHuPMcRi8nB6ZLWHmJqR0dHZATNaF6uwBAPHOZH9C5ec
         sI9RlDeEpsX2KOzZyhMnz34xNZLylq0u005X9c8a52CuQL7BSFc9nA4s9CPpuTP4YWFR
         DHh7zsfEhk456YOuPHK5zXHKZvOxTGQHsfNCj35yr8SlDqSOWgLyoMJPEdkB45TopEAk
         hCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776472700; x=1777077500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8lxkLuu3KAefnO1/GPLtbPT61JCPVTwO5BbGKRm7Evk=;
        b=AtuQnGlZKvv2AE23zep1EpOrrl0fFT+DxEgevGtE4Rb7wQpykSOJKhlfOMtYlaxwpy
         uZVibofrs5Jg6P4CA6Fhrv+yDCOiu0JSvsL9SKiL8TLt6385wRCdwcVgyzdkdXr+ojAe
         qbuKf7UFTBz/KCDHHgyjRVJJ/pahfVpClzN5S16J252JwjrZfUSfvGI/JESDs+rrREBd
         tBZk1w2W5xSaKfl2xQabL68zMW0Nyg7GXKkS5D0KhhfKML9SJfACNlf2w8hCMYw9hQub
         BzjpaNC4cvJ72TaYVqcCDDhV+V/Wdgd8PTIoecucgKEvTSUoHLJGaLZiDQfcvC93n6Td
         q26A==
X-Gm-Message-State: AOJu0Yx7VnrYbPBWxoLlymxebR6UX32GdRmEfUYg04Bvz4i11QoTyCIR
	9YEVgpy7Z0Yyp+9u9PL/9BBya4FqUVitZWtsWdzkP4b8+nvDEMhThNBYUyg5TCr57kt7WV6VQ/r
	/SI0dposlMAQoGupQ5PU/oOf4tuxxQn8=
X-Gm-Gg: AeBDiev62enCZ7jA6qpZVhg/+qD8EUeBQ0+6K8LzTYLMETjHsJ7Y417yEvFdAWtyY4B
	do/ojgYPDmB7JcihQwCre0xk0EQHs6CqLbZ8J7tOcw9c58l8pFfMarEzjw8sj97qGZdu4I9rpGy
	k4gmrrVMn0clemoMZJJG6UDMhXSKGT6oXMNH8ZdZuJN60J0c9qeSGzWmFfSqEv3gkmbEV3qYWxx
	AIem6DAriK5X9iX+vagiUledsLJqXlJ549S+PBnKXS2Bp0cUC7JaQKsoL/GVWIfilhQdrej1Gbg
	cgdeDSKtMy8XNs28Ou2qxUAH3g2CAt4pwU+IK4FzPA6fh121FTg=
X-Received: by 2002:a05:6102:84d3:b0:605:19ce:9cc7 with SMTP id
 ada2fe7eead31-616f7c567bdmr2085208137.28.1776472699758; Fri, 17 Apr 2026
 17:38:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415160728.657270-1-harishankar.vishwanathan@gmail.com>
 <20260415160728.657270-2-harishankar.vishwanathan@gmail.com>
 <2ec3db2d2960d9c13577d630306f16873ebb53e5.camel@gmail.com>
 <CAM=Ch05O+m3gAAz=EW=ZPrhnTMrrMJ51ryMkwROnfkBMVVxnaw@mail.gmail.com>
 <f79d58337ec3628a52d41a09e2c35e598ab656f4.camel@gmail.com>
 <CAM=Ch07jcncdAA1D-uh66OuVXnROF72k8gunJy2cSMuvJNP+nw@mail.gmail.com>
 <f622c0166e9c1809184673c1bffda7e43ae495ea.camel@gmail.com> <ea37be7028d20e962816ff10631da383b5910c57.camel@gmail.com>
In-Reply-To: <ea37be7028d20e962816ff10631da383b5910c57.camel@gmail.com>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Fri, 17 Apr 2026 20:38:03 -0400
X-Gm-Features: AQROBzCmf2sZkuJ32i92iuT-15OwQ-24DQqfPJlNnRqiaj4r7WuOPjTID4t22DU
Message-ID: <CAM=Ch04tB7sXD_qmK-5NZ-aQZutJ6bYmciU+hzZZ8yJx-hbwLg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf/verifier: Use intersection checks when
 simulating to detect dead branches
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Paul Chaignon <paul.chaignon@gmail.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 7:19=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2026-04-17 at 14:17 -0700, Eduard Zingerman wrote:
> > On Fri, 2026-04-17 at 01:34 -0400, Harishankar Vishwanathan wrote:
> >
[...]
>
> Pushed complete find_witness() implementation in [1].
> cbmc verification passes.

Just saw this. I shared my complete implementation in another email reply
as well.

> In any case, please let me know what you think.

I think the ideas are essentially similar. We can decide which one to
proceed with.

Alternatively, might we also consider continuing with the pairwise
intersection?
