Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFA343636A
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777988996; cv=pass; b=rX0cXDBBQf1JNiNE50+cpDOFnY7qVk0UYbIpYsU5zZPtjmDVYOHQMclj94D+Wmskx+VezS0H5/TBQ91+Mj+JRdMSWRDoJJ4Trfq1dmpfTORVOUFACWlUBJ1YnA5NNlL8/oIx56C18PJLua54LkU9y/VQWSDIbHsgkQYSfX5VhEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777988996; c=relaxed/simple;
	bh=dwtJGGtWfivJTDnEUkDart9O2ukOCksxaNnx6dZ9xy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmrY5weIYHQI2xOaJbJv6NYzQUV4RaQRWyV2WPy6Kl2mWlvAMapISCNRVO0vN4InMdY52Q6kjSwP7kKxZtdeeb/mZkqOD9TCpr3ohWYId9WkYzuFOYaGgFe719olKcDpReJH8JwfPwz164bVudbO+vC4dErpdSIGKrzwqq+HT3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=frbFmbFg; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="frbFmbFg"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3651fa24c6bso2128826a91.2
        for <bpf@vger.kernel.org>; Tue, 05 May 2026 06:49:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777988994; cv=none;
        d=google.com; s=arc-20240605;
        b=ZOe+Sn7z++jaT2AZuaF/S6hRNHfwgA3Q6u21n0rMYwnOYuFm8m+eXEuHna+Xi9T4Yp
         KnM23X5B8SyubFxffEMcSLFm79NqAAHzSVQCEweTu4KF0vG8fCNNHk89TV8Tr8leOdUt
         dirIPZHRRqgQdLjueXju55rB8SxkXuzWpVJeTpQBzf3J8q2s9GpYThaUbvxBOld9epvq
         16zmEM0Y1xsLvzG4JXm4jp9s74lb9lRerz1eqYZJvFEUqFMseKl2SBD2GMTZ1nnyjlTD
         x9oVDKN270q5CGYJW1k07IONBcte/3W/EE7GqMzFYYCCmU5lVdrMIBBQE4mxsoBdEIZm
         jPwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hqf6lIUgsNlkAq08zxsjQWbzrMpXMe/Oxc4pqEJz68g=;
        fh=XOtnwTiS6oFEBbOexWCP80yuH9+9PIfkcXGnxACluR0=;
        b=gj2le1t5WTsnokHmfGa49BGSkvOkeWqmQw7BDnzYMVyjebtJwHRxnkkTZWaLR5HRVp
         hDwB29uPhuvfjUCBbkqCq/c5PAURDb2v6Z9vb5o7MJ6QluR9Ar65//IskJI8Cea5Gf3V
         0g2C15JPW76WjOCyTNNeq43rCV8xMVnM7wiuiQVqmZUtY1oAzsmQ0PEWZy+lib9ZCK2/
         TpTBDwJoSifx0C822oHv4JWRv05E5F7S5cUwS/64l61n1xTh/IJrkS5lBA3sVdrgQQmO
         9YGjfCO6ZwaLa8ASMFrjhOBQtozP9Yj8GPPJDXvejtm2mjOGgD+HtAXvqYminGSEkeUN
         yfwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777988994; x=1778593794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hqf6lIUgsNlkAq08zxsjQWbzrMpXMe/Oxc4pqEJz68g=;
        b=frbFmbFgOy5VDj09J4f62miUa6qVAKlhZG3/8HfPOneejt5h6GUtQh+bJQcYyVXcJy
         OmsPiOMuN59cYHOycQHeT/fex5uKz0C3c9lNgZRI5cWhWaf/YgfV3zrNKOTQvhctF7/b
         SsxJo8VaIiPaynadx4HM4POuFQY7HM3sNWB3aP6pj6djFe1joxyMQF/ThxZnKM3T5tui
         olWtUGCea0udn3tlMK8N80eYwbORI2WLMtMKL0G6v0P3OTM6azccnmnPrJCmunmrLZ93
         RPuZFY0oa1or8jPs4empxBo4YHxMqqLLDwDL19QSzLbL4rVWxUp9aOEvIlTWfpe1qw18
         Fg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777988994; x=1778593794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hqf6lIUgsNlkAq08zxsjQWbzrMpXMe/Oxc4pqEJz68g=;
        b=NnU2F6ssJEiGGcxp9T8cLAOn0ddqlwPONqPbZb8phP+n8omG53rAKRPX7DHvnKjwKK
         mEc1hEyfFreS7bJ2L7ia8qgunrp5+TptUNHReCFhycMv38/fXMjBb8FXrbJY4ZSpi86q
         i3NCLg4vD1cl5c6+ELViALBYhUWS5YcWpvKupuTSI0TCfwWY7LCogaLco56Z//VgItjv
         slolGuhbYpYb+RMGL0gAxwgGV9tikLRdJ1LMgMLw8YFyIFqIPPKJUyIYvt8RGVfQa7GA
         Y5ewcQ7Jjrty6UoB/3l66xO+gDVNJPUPwJzWz/4FZHfQVYQNiRJtLEjM3aWFrm6bABwO
         H7MA==
X-Forwarded-Encrypted: i=1; AFNElJ9DTevvZzc4kxS+KGVhIlE+UeDus8XxXqVJkisOdcWP8OZp18oNs1EKyVCIOEv1EefMWaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOvLLXGQYNXu6uVN1gVaOSuzyUmDQdYpSWqfUTZD7AHYKuVj38
	m8WHD9g83h8MpAh/VOXBW7/Z/FWUOWWJJAzTNqUpFmTc5+sHi05Q0VRofP7MykIvsup9pQCkwiC
	Lzg5GPlMrgEmQovn+j+PLc6WrdL5eJDBP7JgQFt/6
X-Gm-Gg: AeBDievnRewUtb4WCxlgnG9pKJA1D1B5rkB82Zildvijb7eY9HHjPGYSTdx0Tp9jhyF
	+HYA0aEtALzfH7DQIJiq930br1LIxEMsqjNG7E0nvDGeuVSWRliCmREIDhtahlWuT+9oIBY/gow
	PatKffbZmM2xF8W2Pzypv74Os4LucZOP6u88sjqmEZFUiXJs0mWIQD+Gwzz0XdUQhR7r4SQ+EP+
	n+fc/n8MwAU6WA57zAlBQ4ofqAotbSfNAuiU3jtThlAt85G/5K4P9ooLsCybjnu0AUvVS1oES3o
	f19oO5qwAfP1rU8Ikw==
X-Received: by 2002:a17:90b:3a84:b0:361:4521:d311 with SMTP id
 98e67ed59e1d1-3657747cdadmr3159694a91.18.1777988993821; Tue, 05 May 2026
 06:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503211835.16103-1-dwindsor@gmail.com> <20260503211835.16103-2-dwindsor@gmail.com>
 <CAHC9VhSy5K5nQTtFUE4BScy1Ur61v7eZW067vTcUYDQeJb13Bw@mail.gmail.com>
 <CAPhsuW6sy2cdC4B7Z48-5A-yVX6fmVWxS_fWVjQxiX95KeUguw@mail.gmail.com>
 <CAHC9VhQLN5NA_ZMMNyUdMCZVdwC3VM4PUnzka8xDK5rpR2a3sw@mail.gmail.com>
 <CAPhsuW5nDaLAV5UfAHeX6QPeF6bs-WDkFYOzYO7Q9_O6v=jEHA@mail.gmail.com>
 <CAHC9VhRx7L1WXYgQvWmGN0a7ssSaDKx4JPhup2E3W161sdp74A@mail.gmail.com> <CAPhsuW5zRktottTujy_O1=8VkdJGDO71M3DVVM4ezffwT_dm+A@mail.gmail.com>
In-Reply-To: <CAPhsuW5zRktottTujy_O1=8VkdJGDO71M3DVVM4ezffwT_dm+A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 5 May 2026 09:49:42 -0400
X-Gm-Features: AVHnY4Kdcn8NUgT3x3TCJLSbVA7TxZZZNO16IatME0SS0-imLL4d0tdSq1ceCGU
Message-ID: <CAHC9VhTWpFbK30ueZw5zTgNfMoABLXcbny=_eWOV17+1ebFVKA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Song Liu <song@kernel.org>
Cc: David Windsor <dwindsor@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Jan Kara <jack@suse.cz>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 5:00=E2=80=AFAM Song Liu <song@kernel.org> wrote:
> On Tue, May 5, 2026 at 4:02=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Mon, May 4, 2026 at 7:09=E2=80=AFPM Song Liu <song@kernel.org> wrote=
:
> > > On Tue, May 5, 2026 at 12:42=E2=80=AFAM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > [...]
> > > > > > Perhaps I'm simply not seeing it, but is there a check to ensur=
e that
> > > > > > there is only one BPF LSM calling into security_inode_init_secu=
rity()
> > > > > > at any given time?  With the BPF LSM only reserving a single xa=
ttr
> > > > > > slot, multiple loaded BPF LSM programs providing
> > > > > > security_inode_init_security() callbacks will be a problem.
> > > > >
> > > > > I don't think there is such a check. Also, a single BPF LSM funct=
ion
> > > > > may call the kfunc multiple times, which is also problematic.
> > > > >
> > > > > I think we will need to make the default bigger, and also introdu=
ce
> > > > > some realloc mechanism for the worst case scenario. This should
> > > > > work, but the code might be a bit messy.
> > > >
> > > > Thanks for the clarification, that is what I was afraid of when
> > > > looking at the code, but I was hoping I was just missing it.
> > > >
> > > > Increasing the default is an option, but I don't think we want to
> > > > support a dynamic reallocation scheme for the xattr slots, that wil=
l
> > > > likely get extremely messy with synchronization between the LSM
> > > > framework and BPF LSM hook registrations as well as special code to
> > > > handle inodes with lifetimes that are disjoint from the BPF LSM
> > > > programs ... I suppose there may be a way to do it, but it will sur=
ely
> > > > be ugly and come at a cost.
> > >
> > > BPF trampoline already handles all the synchronizations, such as
> > > add hook, remove hook, etc. properly. So this is not that hard.
> >
> > How do you plan to handle the issue of disjoint lifetimes?
> >
> > > All we really need is to allocate a new array, copy pointers, and fre=
e
> > > the old array. And we only really need this in the worst case
> > > scenarios.
> >
> > Oh, is that all? :D
> >
> > Keep in mind that the code must also handle arbitrary ordering of
> > LSMs; in other words, you must handle a BPF LSM that isn't at the end
> > of the LSM order.  While a BPF LSM at the end of the LSM list is the
> > most common, and recommended ordering for the vast majority of users,
> > we've been working to make the ordering as generalized as possible.
>
> All the BPF LSM hooks are called together, so it should be fine.
> Maybe I missed some corner cases.

I was thinking about the LSM framework as a whole, not just the
potential for multiple BPF programs attached to the BPF LSM.

> Either way, I agree with David that we don't need too many xattrs.
> Since BPF LSM is reserved to the privileged users only, it is safe
> to put a reasonable limit, say 4 or 8, and do not handle the realloc.
> If the admin would like to brick a system with BPF LSM, there are
> many other ways to do it.

That is definitely the easier route.  However, please add code to
ensure the number of attached BPF programs is limited to the number of
requested slots.

--=20
paul-moore.com
