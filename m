Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDFD318BB3
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 02:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789352667; cv=pass; b=JOYDqffTlVsV5qE7+BZwDBj/UTd5qZmkT/OZE9sKvOZOkrrQ9P+//DSYV2RflxWvkF5RJmNPYijnd5kHt7ZMfwwJjiEV7po9Ix9+YOS2wiBqJFXAj5iYWq45eTlVDDrlT5zwRDJ50XprY5hMgb3ICjBPBzuqqE26A0EPAIEl8Bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789352667; c=relaxed/simple;
	bh=tr92RxUfetBUYnectTORLM72uF0Ccm/8PlWorGu06k8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T14OK/sUktrdGKuu6ygADu67IFh4sVht2QVABVD6OmSjpN8yhDH0p78Stxm17mwsMdZQUyr46ss+llXqFaTI3BTEOdpVj6aAaw5rGTmd9D1wsHddH1CpAKXDg6fcRpUpEhS6A2YtTWk6nf8LY/rQ3jtnFbb97CV4wM1ET+ZL0mM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxefRYVc; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxefRYVc"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-86a25369f16so2101419b3a.3
        for <bpf@vger.kernel.org>; Sun, 13 Sep 2026 19:24:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789352665; cv=none;
        d=google.com; s=arc-20260327;
        b=VE/Zd78eTAAW3TjF81ttReIZRQ3x64jd//cjcSP2o4KySvQi+ddqsX9ahS8JSNsd6x
         nQD96DxqmMob9Q8WWpxGyq6HN2WsnX8CyTUVLoL1yJlivTSkK3u5vc0RuB09s47SRcfJ
         LpZlbEbBUZ1CMiR6kmttagroA9b1eyjPyeNVpDzcW3fuvo6kh9spMd6rqKIQBWgWBDut
         YgQCwSXQPRMD/TNiZHMLZBqPE3I6KMooTBEOwVD+rBaWCCsggny5X5XxGQFSgrqEWQ9y
         qx9nc4Ac6v0+aFDMq1hpGzqRU3RhZ3nFdFIYec9oMIS0ZtI3XYHXkWzY7MFXHXi4DkkJ
         goaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=robbY/RJvD+ycB/sUyfcCcbZu7QGUhf6dyHtU9h8Jsg=;
        fh=gEUU6XoGIYlT01QAYC8TfmvKamnXYNYOH/VluaIO5Eo=;
        b=VyqGoTenlhuYTb79wyq4sYTDKYxBnoi/WP22FfbnrrsyLXl+i/aQwpWokqee1nMZvz
         KPVfmV+AdrPy6Xy9yuw0RCX9mXJTFjKeOlOS2NAqwlHY6TGUf7abhI5GQOCSXo11joEA
         tTnft7ZWbq4lqXZDBaBozUEWAEcEBScjFXuhau1AMfY7/lSSvcIr8txR+U7Kh0YuFyGy
         dGzgrk0wPFjXRnWEkE1b0oVPz64i8wVjLq8ES1K8vuiG+fAoAHNtVgK2aHExfBZW1NLw
         izpiiYRIIdAicuGT1qKVPvTCDGBoYmoH+iPgdRttEXW8TV6NuP7v9lMJr8kXgC3+2WtM
         uRaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789352665; x=1789957465; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=robbY/RJvD+ycB/sUyfcCcbZu7QGUhf6dyHtU9h8Jsg=;
        b=cxefRYVcVolJqBSAHxTT7ytIlBcVR/yupayD6e8vgXDHIfSjHnzZLl5EGG1RE0K+1a
         vRfTAvTGGm1zjOOzer8bTitRH40nkprMil9toRIt6h4lqZv8vmIrY8Jg0iNAWFtCbqUz
         SUuqbYD/7huIZp4Xf5yKSgcjCbUM5VetnSiHLThNHL9xOcw+yYFW7EBN3cYBHWXKdsHf
         Ep1eAC4PguvLiTT2mN/0lDgdSjRLd3SbiRaa9cbQ6ZjT0hYqKs9aMBZ/rLAeZ4cDKin1
         2ziMfEBx6o6L8lQssQHjFCwloTJliFCcsHUi2jS8Oau36n1EdkXUXp8QLIkHDReqARfh
         ayeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789352665; x=1789957465;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=robbY/RJvD+ycB/sUyfcCcbZu7QGUhf6dyHtU9h8Jsg=;
        b=hH69gADDEiHULd4OyieKPKlIJloF7+Mc0uvQxHuxIl2g47R7DpgVBYkVvbHL/PPS9Z
         u3i3qPSJo92fVisLWEIkBC6CEBDGopivy3NajOiahvW+UHT5WUbjKaTtAZdm1EfkWELC
         wrGK6bEh3GMiKJZCkEEXykvKjjSfPKfRm7RC7FZKJDSs37yH9wVjZMe3PJx18n6VGhl8
         Aq1P0qid2wMNhD9aKdiM3E6xGROqkaQx1b2yDMUuq6CGFAQRQ4jzsuZQdD6a5gBr3d7F
         Oi0XHahatC4AlGmLh3c3acv3wrYq6bMos0kqrLWSWo+hOQRE6QEQMGpUJ2xwYdwG3CQK
         djMQ==
X-Forwarded-Encrypted: i=1; AKwUvBxYudkauw43/nZp2AphzlY4frlFTStV7RSgzrIe9x59pwH/Hlh12VqjZmwvUAXxXOSCLAM=@vger.kernel.org
X-Gm-Message-State: AFuF++km9AGgmaxLlZd/TLO1lwX0pOXCCfsOheTKJGdDSF77FcmdATcj
	k2O0qIMyAukT2H6RqLV6vOC4xZHDLIt3+O1babSDveVAdD06ikQ09G84GCCsMtXQxVyKQvpTN5c
	ZeD+Ir/CNoA0iCW3oHp/VwqtiUgF27rU=
X-Gm-Gg: AYBFou1oN4LtLjG4tIb3kVCX+OGzK2HlwQAd4JUltShH1C3ENPmHKwtqgfjZYKvsWh2
	DzVrwkACAjsOneED2W9xoXR38Ll8m4k123YIo7BeiKuV0B0MFn0v9zQU1RTqLAzNs8aWGPDqURl
	gzP5w6x/qU0GX9l7vvL/G3mmQlEz7Behspy1uw14hLlg9DP12CGyuQfKYPVMl7qcAupwIFwzI4D
	kIGnJ8+0KAPGurJk+f/Ebxfp+Z9M8DwvZF74wlNo1JygRZlOl5Xnc3xWrKVnAg3GR/s9m8Bhdfx
	UH/OX0ErB0f6sA7THwthlfWXTZSqE4sG2//6OybDHoeumG1QiFqdhoVu1MuIZObxvA1OnKsvZy4
	XURzZLuTqo9gXZTFqSZ5xDRlbhvtqq/MrsdBXFaE=
X-Received: by 2002:a05:6a20:e290:b0:3da:6bdd:2308 with SMTP id
 adf61e73a8af0-3db4053d966mr790488637.18.1789352665301; Sun, 13 Sep 2026
 19:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909193719.518517-1-utilityemal77@gmail.com>
 <20260909193719.518517-5-utilityemal77@gmail.com> <CAHC9VhQHZ+ngFdzKqmnzBh341CGEg-jexu+QYU8=1qXK=u-x-Q@mail.gmail.com>
 <aqHUw6k0Mf83CGFT@zenbox> <CAHC9VhTM7emi9vxs+5Za8Hrc_e9dg7fZx+Z6BGUc4VQ1qhEAUA@mail.gmail.com>
 <DLD0VQ3D8CYC.3V5ZT8HDMY4IH@gmail.com> <aqTZdCz6JaoK16Fp@zenbox>
 <DLDL7KK3FZKU.17ADLLWJVXB5F@gmail.com> <CAHC9VhS0JckwfomqLTUJkZZkDSgeRXYOjMmPQYErgYynQYqMKQ@mail.gmail.com>
 <CAADnVQJCJjy9Eiwn6-88c0iOk4LfgPU6KBv+w0JZdBzmXBMUCw@mail.gmail.com> <CAHC9VhTh446SkpPF-hUiLYOHipuurzkgju_nH9LsRGdERSAL1w@mail.gmail.com>
In-Reply-To: <CAHC9VhTh446SkpPF-hUiLYOHipuurzkgju_nH9LsRGdERSAL1w@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 13 Sep 2026 19:24:14 -0700
X-Gm-Features: AcwNN1VHje-1mlgyoqyzgACqg1pNN767AgvJcvGzVCEPYAVsQlnEZtYN4fUz1O4
Message-ID: <CAADnVQLZscKkCxvK5puuOE1aN8nW6PnaS+_dx_zBQjjP2T-DFg@mail.gmail.com>
Subject: Re: LSM boundaries. Was: [PATCH bpf-next v3 04/15] lsm: Add the
 bpf_lsm_policy_release kfunc and policy object destructor
To: Paul Moore <paul@paul-moore.com>
Cc: Justin Suess <utilityemal77@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <matt@bobrowski.net>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <kees@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, Jan Kara <jack@suse.cz>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Tingmao Wang <m@maowtm.org>, 
	bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 5:10=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Sun, Sep 13, 2026 at 7:25=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Sun, Sep 13, 2026 at 12:41=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > On Sat, Sep 12, 2026 at 3:33=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > > On Fri Sep 11, 2026 at 10:26 PM PDT, Justin Suess wrote:
> > > > >
> > > > > If fs/, mm/, drivers/, net/, are permitted to have kfuncs, then w=
hy not
> > > > > security/? kfuncs.rst doesn't seem to forbid this.
> > > >
> > > > because fs, mm, net see the value in bpf. bpf helps these subsytems
> > > > to focus on their core technologies and moves policy decisions out =
of
> > > > kernel and into bpf.
> > > > while lsm people treat bpf as arch-enemy.
> > >
> > > It's amusing to read this when just this week we merged a patchset
> > > into the LSM tree for the benefit of those writing BPF LSMs.  If you
> > > look at the discussion around patch 2/2 you will even see a reasonabl=
e
> > > exchange between Matt Bobrowski, a BPF LSM maintainer, and me about
> > > the patch.  Alexei is obviously welcome to his own opinion, but I
> > > would encourage those reading this thread to look beyond his comments=
.
> > >
> > > https://lore.kernel.org/linux-security-module/20260904-lsm-mount-idma=
ps-v3-0-920a1963675d@amutable.com/
> >
> > And that's an example of unacceptable land grab by LSM folks
> > that I'm concerned about.
>
> I made sure that patchset was ACK'd or Reviewed-by'd a VFS maintainer,
> a BPF LSM maintainer, and the Smack maintainer before merging (I
> covered the LSM and SELinux parts).  You might want to double check
> your definition of "land grab".

You're still missing the point.
Christian could have landed it via vfs tree with your ack for security/*.
You have no power over lsm hook changes within vfs.
