Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7212C3757
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 05:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776230211; cv=none; b=QndoZfGxFQkfKi0gagoyhCL4P72FQvm4VkJH/pB2G5yA+7OlUBxdxWcSnGgzI/IqJte/vE0QX5m3GEjc0D0Cw2e70mX++GMCcf4CCuKZeUuoYVhrZojyzch9AHqTV2NEA0knBJ2gwA5BqWmVbiaf3DbRWGekRfZzQPsrvk2BwHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776230211; c=relaxed/simple;
	bh=tgFo1z2fMNSv9Ao23iClYsdEkpYJjq/RUHzYfD4nB1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oSS8ru7SJQLwnANIDwPzyQhFNRrLp7D/5gbv3z4mA44CcMZVRomKmNFZSufUsXzCezljFgAeNw7KVHxdaFj467tJQ3+1UR0zIUFgG9vXCvgSJHYdxYK46ZJ6IBCxkHTDopUYyHGWKfOQZTkq9AmRs9i6vZoQ+u8pnamnY3kkPzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hF1I+Fuf; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hF1I+Fuf"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b9c745e18a0so928272966b.1
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 22:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1776230208; x=1776835008; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LtYWn/5vqGbTF8Sy05mjOO0I0DEauPdarmKJFlysMdk=;
        b=hF1I+FufvpZtSD3zKCItTpqG8zzGyEfwHeg7IBspfybd+dqgSCd+5vtEVDdDEjXFQI
         QiOXKDX6zfEBfl37aop/I+iGo3/m7Bz9pXHqqlgF84mJlt61e2yBfwT93JzPgbFw5oIW
         rBgoY16Ak/KGjkt6FKd4HaybExcl51MGCk/FU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776230208; x=1776835008;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtYWn/5vqGbTF8Sy05mjOO0I0DEauPdarmKJFlysMdk=;
        b=SPCjaPCaSJUjWQullssilzqRC9Y31USR/AlDEP9pBFiqMaHGhZcixenxVBeJrjOWdF
         ZNvgBC1dKrWwK9DGvXBZVbUxihZAWn4OEUrJwGQiXnbwu1YNS+6gYN1hEBbhbNkcZaxZ
         PY6XkKX0T1a46IDfAdtaWFEhSsF3TPKnNF9EDYNKQXM5TIdAXdr0N+je+T1SAt22fI6+
         QH6G+Httj49QNQaPwRXZq1D/gjEiX/7yBJIUuZhJ+KDf6PDRFocClwMOfaEjkW2iNu/I
         GhAuq9poG4rd7VH65HvXNOsLywUw7AZttS0tG0/m566jVr3AmL/cF4USOIN91CWtfpsI
         0JKQ==
X-Forwarded-Encrypted: i=1; AFNElJ+XPGkM8RaBXxtchukeKZ/EQslcAA66bsWUm1rqUzBeLqjkAUykafhVvNqlOfy7QXeUwPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJUikATSeIYgySW0UBvkYNLlOyEe35I2NL6skZ7oKygx+o3N78
	vUeHIzphA2rjF8sBg2KRCSf03Ayf94towjmke9rcXANyulO6H9IvwCikAUX16YEV1JVgh/zNgRP
	wjULRrz0=
X-Gm-Gg: AeBDiesBWxBY0Hs62wKFotEpNezXXjXQ1wE2iZ6V/+yqNvTeeoEd1Gc0O0HYvZZIzz8
	XBp3Fy1mN8Hg+E71P2aoE/U8al5foagR7v0H+Ubtgnz6snCPmCf2Ms3eZTybpFiRarHpTJ+R2Qn
	I9pRqGY2AWDJHGAAPS5UXfj8cFqpty7IHI/7XTbzk7+F0VwLiLfLf1i+kFJGXclWACHp7LZij76
	Z1JLqAp1kCN6eSNAxgwlx4wq4R7+IvOHGBj1eeQQoAgUbdzJBlkz3BakkaGIO77Z908ImEp5UZo
	ahVKj+/oelktdsVmTfXEQAXz7lSTceZzKW/qvpJve0rtsrHQ2LB69LNpCxR+37l/bPdqLe2csPf
	EnxjbuXNsSwrIolrsrcDMblDND67sbHgraxmm8hzau7VPZDkcGoAu0mzfU4OVCNH7OXNskU8slh
	c8yHnSkgxVcCA0CoYCBYU2QT4xaf+0UCqsMa726Vt0wzDkBocCZAX4D/pOipafHDMr8rXDaXECM
	NCQOJ6U7d8=
X-Received: by 2002:a17:907:6092:b0:b9c:34dc:d884 with SMTP id a640c23a62f3a-b9d7684d3e9mr876505966b.5.1776230208095;
        Tue, 14 Apr 2026 22:16:48 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba1784a656asm18168766b.62.2026.04.14.22.16.47
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 22:16:47 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-66d65646c65so3928572a12.1
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 22:16:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ91NWTa4PEQpFbXSj6kbSHTVLC/6kb4QDWHPjE0aUquSZJLiX9azenRqjf8HlwnkodxZAI=@vger.kernel.org
X-Received: by 2002:a05:6402:46d0:b0:670:a28c:4604 with SMTP id
 4fb4d7f45d1cf-670a28c46d7mr6219395a12.9.1776230207358; Tue, 14 Apr 2026
 22:16:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177601563477.7932.4081917600853246368.tglx@xen13>
 <177601564263.7932.2238613098642404049.tglx@xen13> <ad8OGZmCVRc1C-Ck@MacBook-Pro-49.local>
 <CAHk-=wj56cA+_m8YL-5HuHeSDsA_pvuH8Lu=K4JG82iw=G6bAA@mail.gmail.com>
 <CAADnVQK4MOCe=oJPgUXwZdwTu7ZK_WjmpO0jk87A+j0zJeaCTg@mail.gmail.com> <CAADnVQJ=MoiX4=guPWhL9vtnAELkpNx=GNm8RA1-aV424UFz2A@mail.gmail.com>
In-Reply-To: <CAADnVQJ=MoiX4=guPWhL9vtnAELkpNx=GNm8RA1-aV424UFz2A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 14 Apr 2026 22:16:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wipMj+0_Wr+LTqYcZ2jzpxTDSMa9Y2HsMp0V22C6jx0hQ@mail.gmail.com>
X-Gm-Features: AQROBzDkU3VgQc7dp_WlL5Km57Z5OjyYTjqSgLvxcU1oslpXrPg9wiVMg54XUus
Message-ID: <CAHk-=wipMj+0_Wr+LTqYcZ2jzpxTDSMa9Y2HsMp0V22C6jx0hQ@mail.gmail.com>
Subject: Re: [GIT pull] timers/core for v7.1-rc1
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	X86 ML <x86@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Apr 2026 at 22:01, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> and here is a fix mainly by claude with a lot of nudging
> from my side.
>
> Fixes the boot for me and looks correct.

Hah. This was something I had initially done doifferently.

But then looked at linux-next, where Thomas had done what appeared to
be a smarter resolution than the straightforward one:

   https://lore.kernel.org/all/CAHk-=wg8+BER4VyFKG3rnPi2gXxbf-jbHS=EU+xhFqGVQfbutw@mail.gmail.com/

and I picked that "smarter" one.  That seems to have been a mistake.

Apparently nobody actually runs linux-next. I knew it didn't get a lot
of testing, but apparently it's more like "no testing at all" than
"not a lot".

Oh well.

             Linus
