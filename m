Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7B4313527
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 16:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619588; cv=pass; b=IELJFJIuRZ0EpC+uVT+wAHDv3p3vzODpv/rxq7pInJvjPFk3MfS7Jaa+CYpEbZfIBHtJoWzUJa+u6PebMTgRCaDfi9bq+N2EZNM+yfpjt0hGI2B0Xx0RaNwQmkEOkMWCpvgm1CW2CNMXFv+fobH1VrK9zj4K/0a0SSt+vabG/zU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619588; c=relaxed/simple;
	bh=R8ynwnXKpz0vw5o5hNyIwOQqePswhwikzffZ1I9kkgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+hqC50em7Jxt1VMzApel2gSgHzJEt4kk4BJ7HJhj28kfR0neaSiVVfeW46e3JRfvZZWKzwOMbaFZidTEx80EIOg9EbHoR3jqBPruSesMBP9AqSFW6ZHRIqvhnBv6v78BvripLyyxelL+vKASOg6X4+EJe21BRyDRsny1v/5Xdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OY7Xp6Xd; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OY7Xp6Xd"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43284ed32a0so48138f8f.3
        for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 08:59:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769619585; cv=none;
        d=google.com; s=arc-20240605;
        b=YupevNFZlLedrJnXSdoIsmshOzc9oLZxxJt0UGN7NDifd0ZwJv5eA0kLzdS8kL4/Ey
         6quNnUneSaC9wf24Qo0V6lrYijYxzYXzj9iCHPwL8RDsZppt+/Z7pWYd8JUUDP70ryVx
         wugrgo9UXtsv/7PLOGmDpp2x8LZASzfm3qWNEUanbv09mJYt338GqsOkID3o82pNv2sB
         WElCqikRw5nTz+ertoUX76yA4u/AVQMtLamKWbwVIrgmZPLyLvZicB0Di6/ce3cquf0/
         Fopg0dh3y027k+6wWGoLXseLmfJBp0c2c4JJhiNCbaPLLQc6oy5P4mTxAjxV27aIVRnV
         eUOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R8ynwnXKpz0vw5o5hNyIwOQqePswhwikzffZ1I9kkgk=;
        fh=ZwUEQy3tAGecBr6I+AVxSaZw8wxDxY7BC/1FMx64TgQ=;
        b=f2LB7cC9pZJjMPIr24DzeT7h0p3+U7uSjMds+WLeOhY8FvUj6fFcK9ZmduNB3v2vlI
         quedxHr/N3uF+SF2R3S7Hb1eqxpc4iWOdPH0caLiZdXFnvlFDWaaoFZXyIsP9bb2DB7C
         oEwNHt9BV9/RsDYpQxmG4b9i+LtyXyV78F7b7RWpJYN5V36+4y3tNLkQlxnaJ4n/siX+
         pp8b8srqTJGphn0Yd0y6AXriEFUgRzaPe6VTKIObFb+l+n5qG4E7/+t2i+3PIHyYuUgz
         mO8ichX/swHwp2IVK94tQb+FscVnquhGKAvfJHsVuKJgRiQ7S5zcFB1ltiqGKOGzjFq/
         +cyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769619585; x=1770224385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8ynwnXKpz0vw5o5hNyIwOQqePswhwikzffZ1I9kkgk=;
        b=OY7Xp6Xd3ej3qhV+BF7zCapeQeKPer9DlIDhAHIJBZ+rUeBYBv+K0Dgjcw4755tBYV
         zAX008Mjkbj+1XdzM5w6U20w7qRHxhT/Z/SyYbSkKZxv1t02x5ppB9XItqaMr3cT6ZYy
         ubppos9HdOwbtZD4suLCmQ0E43ay+5c87WV9y5VcEcuIsD7CvquhmTox7TfrMvRYu0Di
         SNGbBCEVnJLUsMyAxekYntUWMDf7/o+BiVR5OCCFRlI6EGGGGLFNrynAM+hmVVz5rKZH
         cjPgGwGp8O89YD8D8E1Rn79VZ4oTgXprFj7XFkxmKBrt1rfO46xJwc32uaBwvTA8YRAu
         0auw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769619585; x=1770224385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R8ynwnXKpz0vw5o5hNyIwOQqePswhwikzffZ1I9kkgk=;
        b=i5/qhkl0uZfpJ86tatKNrPrDUhJteLKsUc8gBGXG4dRdmQtsjLi+4jHF5lSZq/AQ+N
         t47AoK6FEZeMuFN4/fJP3gmeOadimz6e6HMj7ervl2w/JNC5P1nj3fWiGRhntH078AqS
         BnuZSDt71oR4lEFcC+WZpHPeQ8+xRllMyO3o0QhaGvhI8yJGA2vx4NGjWRWuhX6RbYcQ
         y3O4dO0nWiDfhQnlZMbYLCZq9pg0KLSZhaXom76cIL0Xy4gVw16koJYJvYRpDvSNIkEI
         QA7lAGFsQyOF3zu2NsDDNWeN6s88X2QycqvfnKGRROyNHoa8m9gYHeM8d+YrIB4zUBod
         mzMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaz3ZyxpwVPXoP74eGgOxHLaRGCBUniwn+smIsUu7l/wbRmkbO3LvtDw2D/U43MFBGkDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxprimEyKmnaNIQCMk9f8uBm5TINUTU1wykt1c1Pb0krNZyTsCG
	xGdPMkD1TsqVHISXQ73Hnelz7P+59eH2OvoYSN9ANzjxoKeAIftz35EdIhz3FGwhr9eSiAIU+A1
	Tq6AM92cs8h8InV6XTLG47zapK+ahu+Q=
X-Gm-Gg: AZuq6aIoT13mHe1uGK+5XiafVkfhoR4s31eYitUJ2HxUzql/rf1RlnYxOLQgMmNlGvN
	k8KsWp01qvWMx5lLeDfX1u8BCUjbJnkcg3L01rCpbZAdX6/WwMRp9zblndqI5d2qR6bkfhX/2bU
	IMlxVQMcYmg2+IJh0hUuyrDcmUN2kl7U38h0hBr417yt+VbPl0SbBYaqGC2LLkDbmEycYl+90i9
	fjBzjCXyFLwUH+knYCtexGGaFeNwF+SvgdcUFrKSR8z01Ww1+LqDNQwfbb3ywp9GloM69eEAyUw
	XI7nESYEnFPYISZII7NhuyBNRZSftdZU+ApyY6u+pmht0cP590SjFoYMv9ZG0wHDGsiwO/3VW+3
	ZsiB1AJ1+08YlMw==
X-Received: by 2002:a05:6000:613:b0:435:97f6:4f44 with SMTP id
 ffacd0b85a97d-435dd1d8cebmr9330589f8f.56.1769619585046; Wed, 28 Jan 2026
 08:59:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
 <aXh_LpTzDhvv20uB@tiehlicka> <7ia44io6kbwj.fsf@castle.c.googlers.com> <aXnDdkYmtipGwSjK@tiehlicka>
In-Reply-To: <aXnDdkYmtipGwSjK@tiehlicka>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 28 Jan 2026 08:59:34 -0800
X-Gm-Features: AZwV_QhfTbIzyHtilkrEQ2Z-0JECgEQt__ywu-4_XBgXY2AoFHuz3-NaKL7HAiE
Message-ID: <CAADnVQ+ghTc5FtJCjm4ya3y3xVpSuJe-7ctdT-thowqWguc1pA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 00/17] mm: BPF OOM
To: Michal Hocko <mhocko@suse.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, JP Kobryn <inwardvessel@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 12:06=E2=80=AFAM Michal Hocko <mhocko@suse.com> wro=
te:
>
>
> > Another viable idea (also suggested by Andrew Morton) is to develop
> > a production ready memcg-aware OOM killer in BPF, put the source code
> > into the kernel tree and make it loadable by default (obviously under a
> > config option). Myself or one of my colleagues will try to explore it a
> > bit later: the tricky part is this by-default loading because there are
> > no existing precedents.
>
> It certainly makes sense to have trusted implementation of a commonly
> requested oom policy that we couldn't implement due to specific nature
> that doesn't really apply to many users. And have that in the tree. I am
> not thrilled about auto-loading because this could be easily done by a
> simple tooling.

Production ready bpf-oom program(s) must be part of this set.
We've seen enough attempts to add bpf st_ops in various parts of
the kernel without providing realistic bpf progs that will drive
those hooks. It's great to have flexibility and people need
to have a freedom to develop their own bpf-oom policy, but
the author of the patch set who's advocating for the new
bpf hooks must provide their real production progs and
share their real use case with the community.
It's not cool to hide it.
In that sense enabling auto-loading without requiring an end user
to install the toolchain and build bpf programs/rust/whatnot
is necessary too.
bpf-oom can be a self contained part of vmlinux binary.
We already have a mechanism to do that.
This way the end user doesn't need to be a bpf expert, doesn't need
to install clang, build the tools, etc.
They can just enable fancy new bpf-oom policy and see whether
it's helping their apps or not while knowing nothing about bpf.
