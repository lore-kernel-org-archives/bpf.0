Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D07820ED
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 00:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770250339; cv=pass; b=muZgA6RSsS6urEFtI87OhZ5EazJ23kFZmFkfTYPQGt8tIsGbtsqRJKe61228ozVpVnIiT7UiL+TZQlXg9ZM2PaO/DudCMwDtUaOSuez/pwrEEztbZ6199ZoNf0jV3nreCo4AIF1zm9867jkrVbgNv6hjg++SK2eaLPrRyEZMbhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770250339; c=relaxed/simple;
	bh=dueItlYq6x/3RA4QCzPH10/edbeT+WAi2o9IqMdoae4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0g5BRjbcZ4nkI56L/ufMhpKDExh7/PACoU3/P9YswDcywjtGdWXp2imYwPhPxqvajG0dt94osORMJ13zVh8vkEnG7B2MQp8CyjyD/FW58m0tScKhRlIDpoZminP2hlGK6mORl1hxwMDG1NWlWi6dkgctSXafqxLWSNyfcQulwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpZOcEFY; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpZOcEFY"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42fbc305914so389194f8f.0
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 16:12:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770250338; cv=none;
        d=google.com; s=arc-20240605;
        b=TPyD6iHWlR31RyI0cnyK9PH3fxudg9oll0PHc7SWLnGqXv2lCu83pwFCIsTnSOGCeS
         n6FgM4yomq6Sh6pJNZR0Umliw3bmNeo18jcU4PIOeSTZ0EJHxfQZYUveVDp4aKmPheIe
         8gibiM9IHRxUr1vUfny0ZyeekjnFBBz3ygSkwXtwiuZ4MuOmyJxUOAvQADj2SmqoWeiA
         /XbE9YB2PRBiNELXYLAFhG4sWB13SCZBP0JJPzy0yCuT7yr9tmf2CKHkuzVJtgTdESJS
         HoTfnVoYfAiV715SltfDyeo+4kaY+QH82qw9eqPOA3TCO1ZXw5foxvhjjJs9Vq5GovdG
         ts/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cbqBiMbQ49M69l8l8/udUstIypJQFYsZ0pw/N7ocq14=;
        fh=jDyCfjM4YoAclwxs9z1IFA+vixttK9nQpJh1gXovjLE=;
        b=jL9N18a3BtiR0vSBIm0pEg9KEsCPvokkdRCpL5cDvjq7PvHJE1mGyKmFiB3udSjuZh
         FfCUIfYnrHX1VGAxfKBYe8OYt9Nlj0gLt9v0OS0kiS60kXdHyWBr6z145ULLDp50V+pN
         C2V6etGMldrHTdc01zU9RaMDDbJPj/I8hllAbjPaElDaoGlCPvMADFpSJL5oPOKMhAei
         8EdEBIEp/h1Ecw4vTnjTYGgm0/lg8nGFklHB1C0VC3ywV7Sz4zfpNo/pWayw9Jlv3oTh
         QXs8x7LZ6oZIEsmLSa3BzgNfN3jaWym1bokoy3CQCSi+3kgsUgds7SqO/8mIKEZs1RQs
         v4Yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770250338; x=1770855138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbqBiMbQ49M69l8l8/udUstIypJQFYsZ0pw/N7ocq14=;
        b=dpZOcEFY/hSmKcMkHIDEDv+EXsS66PEWz2B4akHPKPvkgrCnYdCjX8qc7rSCruU75/
         FuncE+/crUc2ALCV6qKHdZ88+lL+RheI9n88Pf4d78xLfvJmWOtStHhwZgYHwzQwmHKb
         ZzZzP1GnquGannzTCV/wzXDeM11DBAVXgg+8n+Muioms6EvbLwuPKGf+yUedTH7tu2BY
         AJt3bRNJ8e4RKu++pq1Hl3jowqo+0Hq/iAh0/TeF0LJxMTZ5w2h5kA9GHWq+sOWKPdHI
         uL6/5gJbiIDcO+1IiVSXYgDd/CsEB6Xm4HxrRRqw+haTNEvqCxbEFYMeRHBs5ZwKnaMo
         Dsvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770250338; x=1770855138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cbqBiMbQ49M69l8l8/udUstIypJQFYsZ0pw/N7ocq14=;
        b=DxhLyyvnme++P8GuOXzukVJ3qvvrGx/kYgazotbT6f7DhlhZJtwuKqeKGAR4TEttfw
         9N5XJYyU3UqFPOdpkRfdgW2zhMPWvss6AMVjNKFvFwJyveySKqmmsdrTu2loGYWxF69T
         YZv6Hd8b+jpP/YQHlkFwzhZB2FjYUY+MDni/ak63PM0w1vzf2CzYTdKot0PeK/TV/ifT
         ZkYeTcHysZrS6eW+gq/lyuapSpJw9wBWxXghL+hQjYGdQEOwkprBjLKVAZxxCYGIRQ08
         TPvKVmTFKfwjbAg7ex3p87KT7qBmZHkPcTPdslre6ZaaJq2VmfCMPu32RhmtIUuvWyM9
         0mLw==
X-Forwarded-Encrypted: i=1; AJvYcCWT+SBGRPMr16zBgG71IGXZuHox7IPQAffriZfKg3cwrX+Cf4u4RlR5YaYMsfguLCsjWFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkXRyrDU4fFTv7dHraq0xjT/kOvssHqJRohKygj65i0ZY32q+q
	G3xhSus9YyjzQvtUL7kyAnM3e+/QltS+3WGHmY7mfluYTyWrM/spKc9iETbxkeQ415keGc1UFiP
	BWZykpWwdntHuUX36ighAct8+A9oeaYc=
X-Gm-Gg: AZuq6aL1PU4IqZNmrry9YS34QCxmg8cWRNDjS9rqRX3pxd70zhVZz8gr1EXZ3NLh30K
	z8K0/mtwLVNbPPO/ltfFIDChOrFuk1TCfVEhduV8eqNYzGoMS2dUBi4zTEfknaqZh3PBnGAmJBH
	mkDWY9yaODPCHnrQ/v9Cjz9fWWu0gd2TBIzERZtXWdlEsVBhNYwqMrka+38I+GkZyLjEzt9qAsG
	gb/ZdcmiUaZ5qAIj0RyG63j++h9Ijt+yO7ISmj5J9go86mWSX6vDkGotpzaG8Cuqj+iQI3wmQ65
	+uHcDTEUuU08HEnpZPz9NjhlskDb5llUpS58nq9T6gheM1Nwhs+DnbKgQiltQruOaoAs2+5Sklv
	qxIqR0Cxo2xTqVQ==
X-Received: by 2002:a05:6000:3110:b0:435:e54c:985d with SMTP id
 ffacd0b85a97d-43618058117mr6974136f8f.44.1770250337441; Wed, 04 Feb 2026
 16:12:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
 <20260127024421.494929-11-roman.gushchin@linux.dev> <aYA4pH_nIBZ-ZhLL@google.com>
 <CAADnVQL5g8imKNGbHGQ4HA8_qNT4MYwM8P3aCTFUG7uwiuTeuw@mail.gmail.com>
 <87jywuwumq.fsf@linux.dev> <aYH21HhwNvWnFB8O@tiehlicka> <CAADnVQ+uF4cTVYYOYBEDWrkLXJJkru_FaRttFskHRUpamktMJQ@mail.gmail.com>
 <aYMLJv64GOh7coMK@tiehlicka>
In-Reply-To: <aYMLJv64GOh7coMK@tiehlicka>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 4 Feb 2026 16:12:05 -0800
X-Gm-Features: AZwV_QiXQ7VARzO0Kw77iUD9Tf6J5RQ7jc_wSjITSQIkFU7PeCfR1uomK_hzU0c
Message-ID: <CAADnVQLF3Rrxo=0s5orrik4_A41N9ivbHswGnJSen-1VpbExhA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 10/17] mm: introduce bpf_task_is_oom_victim() kfunc
To: Michal Hocko <mhocko@suse.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Matt Bobrowski <mattbobrowski@google.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, JP Kobryn <inwardvessel@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 1:02=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Tue 03-02-26 08:31:19, Alexei Starovoitov wrote:
> > On Tue, Feb 3, 2026 at 5:23=E2=80=AFAM Michal Hocko <mhocko@suse.com> w=
rote:
> > >
> > > On Mon 02-02-26 16:14:37, Roman Gushchin wrote:
> [...]
> > > > Michal, do you feel strongly about having a dedicated kfunc vs the
> > > > direct memory read?
> > >
> > > The reason I wanted this an explicit API is that oom states are quite
> > > internal part of the oom synchronization. And I would really like to
> > > have that completely transparent for oom policies. In other words I d=
o
> > > not want to touch all potential oom policies or break them in the wor=
st
> > > case just because we need to change this. So while a trivial interfac=
e
> > > now (and hopefully for a long time) it is really an internal thing.
> > >
> > > Do I insist? No, I do not but I would like to hear why this is a bad
> > > idea.
> >
> > It's a bad idea, since it doesn't address your goal.
> > bpf prog can access task->signal->oom_mm without kfunc just fine
> > and it will be doing so because performance matters and
> > static inline bool foo(task)
> > {
> >   return task->signal->oom_mm;
> > }
>
> OK, so my understanding was that BPF can only use exported
> functionality. If those progs can access whatever they get a pointer for
> and than traverse down the road then this is moot from a large part.

bpf could access all kernel internals from day one 10 years ago.
We made it more ergonomic over the years.

> > If anything changes and, say, oom_mm will get renamed whether
> > it was kfunc or not doesn't change much. progs will adopt to a new
> > way easily with CORE. kfuncs can also be renamed/deleted, etc.
> > You're thinking about kfuncs as a stable api. It's definitely not.
> > It's not a layer of isolation either. kfuncs are necessary only
> > for the cases where bpf prog cannot do it on its own.
>
> It is obviously not clear to me where that line is for BPF progs. Where
> is this documented?

See Documentation/bpf/kfuncs.rst
Especially "kfunc lifecycle expectations" section.
