Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBBA4A2E03
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 23:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780530733; cv=pass; b=e3LphuhotJg9CmgP3BLVaa4h/jZwrZ7UukrF9UZTPrtP1V5MGbFcCnN3nzHUy4CjIVxJoPxK1MHDWBw/LECaHXWVN9qG3P1K/ROuxneBIGNA1sKL03mf9RQPaElgotjsYXUlM7Mpg0T4Ycc2IIIGrbObyEtKxAMNxRwdn2jIVg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780530733; c=relaxed/simple;
	bh=FfS/kIbVyXQ8oYH5XuhRQq9azxEmzRp4crNgtSWViUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEmGwfussUIhsFzYYFKnOZcfKYDk0oXyRgrfAtDIGD+FFmtI0lkgNTTqDP/3AXP6ZVfDNy2j3JgeRi1auEroQvApRT6Qlx7HqFSgm4LR7pcxhnQFpJowTCsOlGqTlvmgSSvgWpbaSYgiZK8oC0XwFZ0iWgFunvUNRV+4IlQFfSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QX9nc0Tz; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QX9nc0Tz"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bec449cf976so9314666b.2
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 16:52:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780530730; cv=none;
        d=google.com; s=arc-20240605;
        b=jwkW6g6NaKMPRr1WWiAbnPI5dqa5jwYtwHoxHPjY0I9Wbtn5HRVm72cnH9ulVGmCGJ
         SHUjsdQFt46CylwKFXeaS0yi5i4bLj0G2XEeL/Q0eCT1hMwWj+UFRYNJz+PHhP4B7Uet
         +EHJ9+LZWwLBrHId3A5GCPWEBz0aFPrPDakjFlWJ/CKpdlPbr7yMf8nTWWS6IryRdKvk
         bUfy5S539tQIM9OQHCPl4ZOvLx8/A9VvfQpoPKR/GTEfdQeWNljv/J786T4mg0SvdxHk
         IrprUar8j/DM5SZNCPucs5SP0TlNTQvfwnMbMATGnaRc4krnmWS6MXZX9k57KYV5pmrU
         mlNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FfS/kIbVyXQ8oYH5XuhRQq9azxEmzRp4crNgtSWViUI=;
        fh=CEwvDXYamy3Zi1vdZR2Mkiy8Q+0/0Cms/rsOhWVWOg4=;
        b=Uu6Bn3zKmvGr+uXEKIiMYMydhm7cTZG4UTM7Mc1/qxTFIY/P4eqn1H5kRgvtb34dJD
         O8bKFcu36x43hN8R6BHeIyDlHvaGwTljKPkjbNIt6ONR9pOc3tQv+6VkRuuxlkwq6/O1
         lTPVnsxYMVKYoWD/Blc4qiQ/3uyCBielrba0Mrx341YCzU2HVI5sRWC7iIfb9UNUZxjZ
         mHcid24amcLbafQJ1gwZoGiynheYBaktxeUAjrFQ/FspPyqpZKb1HYuC19XGETieN6At
         7wlbkJbhg4Z3UkqIceY2wRFqwcrCtIF/yuejg9/qbL+KH2kwggIllxVGiFHglkLSz6e/
         cFhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780530730; x=1781135530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfS/kIbVyXQ8oYH5XuhRQq9azxEmzRp4crNgtSWViUI=;
        b=QX9nc0TzLhgQ2/GbHvsfMf1kEykLjokLa9+pdEzqbCO/ZUWpkclTZQMMOXen7vgZeW
         1jZ1M0Sn9LeMSExVTA1RSvPLWSZk67XA6iouD7BBduMY5Vp5rWquCKORi3KdB4DwlUST
         t1KisgywuGA8tcUO3auJV3PAJJt5BuDZPVAKvszMLEoj36+Lil72me+Swx4B3dmkyKBo
         +T2amXt2yf8bQQb6Y6wTRFInErhE/XvUFfZJHSpSO7rryjenDI4ioJRY7v+6gs+Katta
         lBXl1x5nPvzNKExaMWZCnuHLjkuo1L96P5tPF54FeHEipiPbmx7yAdYDd/d49C/PSjMi
         9KVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780530730; x=1781135530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FfS/kIbVyXQ8oYH5XuhRQq9azxEmzRp4crNgtSWViUI=;
        b=fvSo/KwBeR7w/8LY3NQINXeF+yvZ8AW+UD1x8jdZisENTrjZaTGkWaxaNpHW0YPC6Y
         IqF8mLrNv03avYaKzFwrFCjUB55quybFiW5fDLUeavxDMrm9tipccsinoE6KMKiOfhpv
         u37CHUbp6jKuPmrYbQjqOme4VkPCitAA3t2HSraF3hWnUM3CCmHlTmvYOOThJNNn0NOY
         MA2H5zdBAxDGOAWWJRSKJrBW/DyOenvzXD/0HWqDp/M19UExLNpddI5NqX22lH6tTqop
         6pByAsdu+0ptYqBpOObjRjJwW0ZBLpyl9QcWkGbFTd06LNuarMWJhTjYjCRlGo7pP0fY
         I7Pg==
X-Forwarded-Encrypted: i=1; AFNElJ+WCxCLodd/vJsDqauFHA/tDfrirCv6SbRcyVpVazeXE1tleQE9aIo36AT8ThtVbpAmAuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMm60l0jkf64NJKYDMJDgv2CY8UrzSnmWoB1mTVJX3AJ5X89XI
	NrotoxNxgtAzIkxZIC54wSYMfejJ7iNzFioIqVdP1YuPCvHUMreewrKC4aDXtnrCeJM4C5TNe2x
	uB3E4utQjWMBFcSnI/fBO4uz6Kf+F02s=
X-Gm-Gg: Acq92OH4bzsV1ixS3euDysS99SmEh34PGtj3DXi+NEW4wtgD85hBORUWBNlZ/5m515v
	3eh2+rzrJSW0/Tvvz2Jj/syEiVCf/KpX8zcOpgFyjobWrZS61xfLsAAqrZe1GGFHiiClsCPq1/4
	YQ4rM2M2eHSXwApIYjGuiqDTGxTnPHwXv5YN4pW3fP9xi2LUapwL/ikH0ABTjYirVYMUBKULypu
	0g1/DudTbNhGZXLzSop9Fch/yMhnCiRcdZobkuvGn2OlwvAfKM/ljsZuz376OqD9tnaDAfcfG0Q
	3QDeyk9dHkZn9eWT5a8ERJc7YXVejunKesJp3LALBme0eXqId3gcDU39FCrXbT/bpem7dkpiSTg
	=
X-Received: by 2002:a17:907:c085:b0:bea:2fbc:4ef5 with SMTP id
 a640c23a62f3a-bf0ab710b5cmr316516966b.44.1780530730399; Wed, 03 Jun 2026
 16:52:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-generic_tracepoint-v2-0-b755a5cf67bb@meta.com>
 <20260518-generic_tracepoint-v2-2-b755a5cf67bb@meta.com> <eed59d12-969f-4135-a84b-4965743692cd@gmail.com>
 <20260526215741.1e5b3e42@fedora> <CAEf4BzY5MTGJyys369qDS3b63-tKq3okCpFMqUdfzy0dXk7vLg@mail.gmail.com>
 <20260603185057.4a85d5df@fedora>
In-Reply-To: <20260603185057.4a85d5df@fedora>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jun 2026 16:51:54 -0700
X-Gm-Features: AVHnY4IUVNJqtXV9AScDfxOf1g8eA90hmIpGHvsbaa7lCYBS-3jVxavexcFRfWI
Message-ID: <CAEf4BzZFjsEv3aLktwdCZF6EXoCL+eefX+6xa3XGrhBmfO1SqA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] tracing: Expose tracepoint BTF ids via tracefs
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	Mykyta Yatsenko <yatsenko@meta.com>, linux-trace-kernel@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 3:51=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Wed, 3 Jun 2026 15:41:50 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > That's just to say that it would be great to have this in some form of
> > shape, so please help getting this into acceptable form, thanks!
>
> As I said, I'm not against it. I was hoping to find something to help
> alleviate the memory usage.
>
> I'll likely take these as is, but I'm currently on vacation and it will
> have to wait until next week.
>

Yeah, no worries, I was just going through my backlog and trying to
think if we can avoid extending the tracepoint class struct. Besides
the somewhat dirty kallsyms symbol lookup logic, I don't see any other
way.

Enjoy your vacation!

> -- Steve
>
