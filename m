Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639B14D9901
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.152.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785349249; cv=pass; b=mFRJNmkFsEqtzmvNSOjmW7F0VQH0FeO6X0CtlxHiWnNN9YOz5/TPe1rVeFSPvuSuUE6PUh0/YAJSpV3BAcOLa+a87zA6e+D0Zeu+Hzz1kAgmU9CoIGGrivl4tG7gHtbP7dmCct5x3zM04UoNxP9iLA4vYdSKu2m2l6kLjchCmRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785349249; c=relaxed/simple;
	bh=n4u6Lkyyb3K0KXlI8hsKysRf1EtEUR4qmTh5L+rzGD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2btz0VkjCKsW/pFiI5buutk9cAby6vmB3JkQZZAm79OgAqI7ohGb+nYABttD1LA+9+TSUPaNITaVolhXB1Pis59yYsj5HuTWCZZ0ZGRpEgOLE8buf9/aPUOlJgP0WIbAfPYjctFwuWIkaA396LoUO8yZzq2wM+9zxyRGkUU1gI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=iHY8BRF0; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=Seqce8dK; arc=pass smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="iHY8BRF0";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="Seqce8dK"
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66THGk3j2208174
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 18:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=PzM3c/AUdHEP/V1SQKl0uANVAZmgdR90jTajOWlVlhY=; b=iHY8
	BRF02H3ThfZf4HVBVFgcPMlLqm5MGMZ/VZQjSZBartJjCLg5o3zKCU5pw7m7TrEw
	9VsI3Vy/NUmtyVwR3vZpdSUIehqLxpvOyZwYBeBD/h4BcSPl4p8/dQ6iwoy+vdae
	7yXAkfVZvzLvZXDQTgjV8oGyZl+5A6wspnTXis57RqgBPs6AVOWXuqsBj5xAiIMl
	bsaVMPcPMCIhjJSmO3Ba/WZ8pKzJ4fTq9J1HawGG4ILIgjY8VeylAEv80pPLsDRX
	rNWKBmbO/wyvivi/YzVQPIwjHE3kLPmXylMyhJKMYNOdrXaTnxU68x8B06cT7QVK
	WMH3m8LPZ+VMJvJiiA==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4fqmcsgsae-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 18:20:31 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-81eedabbefcso42393667b3.3
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 11:20:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785349231; cv=none;
        d=google.com; s=arc-20260327;
        b=UlwMvucKukPwpsSDm4BIxuCOFF+uXsIdit36/JmL0YfoXtW6b2wuBLoMEW5nypXvo1
         2Ba2xU64R3pfWQvLwsOGARHd0xKHnzJMSG5B7W4b999v4fLgTYBGwBSehZEHtgeiZXKV
         /X7pf/mI2OuLYXL25Nz8qZnmEO0Rq9IHdRDDIMH+8wwUiTpCzHQ1Si15Lho+o6/VFOlP
         K1FH9VN1tOpOe+Mgvl1kzKg5+nOtozra4Us8N5IMuC0Yt9aqP0owSqtCseHf9paWKanu
         DLlyLowStbDqc/U8p9gJeNQwmjdFAJJChKh8YBr35aTJbtY9uvbHt8sP7vYbnJzNyHGt
         x+kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PzM3c/AUdHEP/V1SQKl0uANVAZmgdR90jTajOWlVlhY=;
        fh=EXRrKx4B0xAKfpOc67TaH7IVyvaASxoJdbElZfURoBk=;
        b=oXDPLF6B+qTOalZIHlSpFbUAdGS4nYWrGdv/2CRWfzZLgbvH+r3KbsjK2qAHDHeTZH
         sleng8njz8jmE0VuDHEieCQfpV0UVcwcFJ/iBzZh7nP7BP0qPD3CjNIYc5BZ1Yy7VHhm
         eWgLRo2xprJyAFKfUXSYyt8B7Zd1PEgaHPPaKSQs9xoaez1zWZbiD0JAwQdmqXnvuBsH
         s6hKfiD0ZGYK4A/2vzWP+wYS7n/I67TcMrYyjbdcWUTZdv8HnnndVcMkXmoV8zttt15d
         uObW/BemceLRd83ycSk0+NwB36nvoZbqmmXIz48tOWZ6edetXPhBjHPMC+mCnMjBGDDF
         +oQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1785349231; x=1785954031; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PzM3c/AUdHEP/V1SQKl0uANVAZmgdR90jTajOWlVlhY=;
        b=Seqce8dK1T1KrK1jY26btQ3NXgi3a/+1e44dJBu0R9V8vxn7LBGN6DRCzawL/mVzsH
         W+KD4ZBS7AJBN1J+c9Z+zRbOssWFG+EGb0hjcZOIE/hXpPeWwvzGq8uYKQGdlSPS02OH
         XojDu0BjyfM7G7kGexnIFXXNusHsecPJatK5oEaLO+wm1PcgbBZ0pPATsrdt9TBASNZL
         NDFUgFt59QWrPVN8ATChrnd8hARdx8oI6+Fi5u0fLNjmMbTajSOkASH8R7Csykinnzfa
         IlbQ5bIACf5vQNR1zGu8IP0WpcxrQenoYyqvGLakcyYrppzPJ6jIFGuiPvJmve2Jb0E/
         gwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785349231; x=1785954031;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PzM3c/AUdHEP/V1SQKl0uANVAZmgdR90jTajOWlVlhY=;
        b=kRX/lPfbPpa4vnmf3ANIyLgm5o+rYBSb2sTCrCrROzgpbLOuUT9sAxoOi5Tta77csJ
         7gV6lIzLkjrJYGfmcthJ6IkTXnc6kWHwezkAsLsGWqeyjwv6OTcUH7fw1U4BxetKFgXl
         iIfJ3p0iANTgEH+l5Dc2wth2mpojnrw8APNqwWP/+KJ3kcl2qH8w5WRcLKvHQWctrtmt
         A7/Dc0castyQCHJQB5Aq9yuVOpjK4l2gYZyvcXu+QUoybvlyB7Hn5OSBxUeTG4tDgYlE
         pCKNyOfAMYVcAHSVnRSomD/z5Te1F+my3yHj9/UO2Wqh1Y+l0BMHNCwbgq6eFcYFnQTM
         dMdQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp1q5qZGGnx8Xnxe34UefQJHDsmeCxDeKpgx7F5H1kuuK2ANRrZndpwbG2UhqL4jjvP5Gw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0rtQlx9TFdFsFBgiJdn/MpmtrU2kcsd08E7cHl0jnXhBYRhzj
	9sqHZIwexAapqBqxjR8GhqlL4H6kmchPjgl4Jx00Odp653RKc8o+psgEDstu5NLEyGOaU2CkZkE
	PB9d7UynBThFC/7H3m6FJ3jRrbFTGo+d7TQ2sUtR0OyPtVDuABvkGS6u0+HkUF9Yfs0AQO2Rf1L
	YIDzw+/ZBhiElPcLwaR0vaWoRpVkGs
X-Gm-Gg: AR+sD119fkYB+8zfIjPjrurvuX67DoUCd6jEyYUA65dZkC8fG9/H9frQCJLQL1tvTKQ
	W0e0prGlF9jPcuQyqkWXbisLxMiA7R/91fxI/0Jr80c6nWWf3rFjJzQsFZpyk9MfEZ3qJCni+O/
	WP2zFLIDuGMymmRcBSoArVFTVXD7hEYMzwfHvPPi+jbXYrRUwCpubR2YYj
X-Received: by 2002:a05:690c:9b08:b0:806:5a1c:d892 with SMTP id 00721157ae682-81f99362200mr38160577b3.47.1785349230766;
        Wed, 29 Jul 2026 11:20:30 -0700 (PDT)
X-Received: by 2002:a05:690c:9b08:b0:806:5a1c:d892 with SMTP id
 00721157ae682-81f99362200mr38160237b3.47.1785349230082; Wed, 29 Jul 2026
 11:20:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com>
 <20260729104114.04298a48@gandalf.local.home> <CAOu3gNgc0XHScgEf+yWF5Kr8sAm8Fsa4RBuwL0YE2EscSiBPrA@mail.gmail.com>
 <20260729113136.32af2a4d@gandalf.local.home> <CAHk-=wjzHTuomhTegkD69veDVRxprX8NB=i7A+BEB2-v6v5n+g@mail.gmail.com>
 <20260729133232.1e6c79eb@gandalf.local.home>
In-Reply-To: <20260729133232.1e6c79eb@gandalf.local.home>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Wed, 29 Jul 2026 14:20:17 -0400
X-Gm-Features: AUfX_mylfstO_nr2YAMR0KtoaEUkuyIT32SLYOev--K7OVQlRoslcyNqTeL-jhE
Message-ID: <CAOu3gNg6kNYp-Sc9Eme6yW7Nu7wV6hZ9=CG0eptROfhQ-H8nFA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] ftrace, kprobes, bpf: mark
 trampoline/kprobe ftrace_ops permanent
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, bpf@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, jolsa@kernel.org, naveen@kernel.org,
        davem@davemloft.net, mhiramat@kernel.org, stable@vger.kernel.org,
        linux-open-source@crowdstrike.com, mbenes@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: GvOB-HXvpl3M7-vsGBwfkmwOoy2vE2tl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDE0MSBTYWx0ZWRfX4VEatJyRZBRj
 Rl7w8phuG7yIIEw4/jPPU/JwdXpq+hqdau38X9h36+AncZAzFYyQDGvBy33zsLp+BgvWUtL28iW
 VIRND5Enod/HEkGRvX6qZw87VFPYYI/fCaIvrhl1kRdRVbtK7EcJ
X-Authority-Analysis: v=2.4 cv=fYudDUQF c=1 sm=1 tr=0 ts=6a6a446f cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=GCXdLZfFv8EKBZhKOxZ5:22 a=meVymXHHAAAA:8 a=Z4Rwk6OoAAAA:8
 a=LEQXHG-ZodL2_mGlm5IA:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
 a=2JgSa4NbpEOStq-L5dxp:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDE0MSBTYWx0ZWRfX7WYkZ6y+j6L/
 6VN5wPpDt3XBoSuIdCQFkHo+yq66peClSP17bdEuImcf66WDcpW42BZ/XusjJOGklAjUzGcyUlF
 qtUYq4SSuY45cXqt698rjTFisnF+IewUcojDicBLM1KqX31Jj2m3O6fVIt6nb7F4rL6AdPm7GI7
 Vb4c6LC3fUkcf8LOu1xREl6dXYXzFFVS9X4IPhwX3QodOcBsQrVXTjavtNmWl/TUSEch0e6FXTT
 BmPDpDZzjlxuPTcdYGz/Xf/nq7j7LhxxnGk9cdBDCSR2Fl0hKi6uZpSdeBwCH0wYRbCauSCMSFM
 I8YAh9sSksWVkdREp+g1lHSRXBRAtiRM6R0DRQKB5r/tXmpriPRBpwph+I7mc4qQBhYFzXHMArE
 GoqW6QSsRgCmIAjvZZdeV0TiWn0uwZCpdBmFTOP+/7U9oFGL94LppY9sByQIFTABO31hEoHE0vk
 8DdwbUi6UI9yt9uc31A==
X-Proofpoint-ORIG-GUID: GvOB-HXvpl3M7-vsGBwfkmwOoy2vE2tl
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11859
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290141

On Wed, Jul 29, 2026 at 1:32=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 29 Jul 2026 08:47:33 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > On Wed, 29 Jul 2026 at 08:31, Steven Rostedt <rostedt@goodmis.org> wrot=
e:
> > >
> > > > > Honestly, I would love to get rid of it as today ftrace has prove=
n to be
> > > > > rather stable. But as it is a user space ABI, I'm not sure what w=
ill break
> > > > > if we do. I wonder if we just make it a nop, and print a message =
to dmesg
> > > > > saying:
> > > > >
> > > > >   "ftrace_enabled no longer does anything. Please report if you n=
eed it to."
> > > > >
> > > > > ?
> > > >
> > > > Thanks Steven, if you and/or other community members would approve =
such
> > > > approach I would happily do this instead for a few reasons -
> > >
> > > It's actually if Linus is OK with this approach.
> >
> > The rule is always the same, and I don't understand why there's any
> > discussion about it because it's been stated a million times: we can
> > try to make any ABI changes at all, and what matters is whether it
> > breaks somebodys setup.
> >
> > If people rely on old behavior, it can't change. And if people don't,
> > nobody cares. It really is that simple. That is literally the
> > DEFINITION of "don't break user space".
>
> That's basically what I said. I was just restating it and not asking if I
> was correct. I added you more for the below information you added.
>
> >
> > Whether something is user-*VISIBLE* in theory is entirely immaterial
> > except in the sense of "be careful, this needs testing and may have to
> > be reverted". So user-visibility isn't a "don't do it", it's a "do it
> > carefully, and knowing that you may have to revert immediately if
> > somebody complains".
>
> Totally agree.
>
> >
> > So changing user-visible things is potentially a lot of wasted effort,
> > and needs loving care and follow-up.
> >
> > So everybody should typically avoid changing user-visible things
> > because it's potentially painful and developer-intensive, but not
> > because it can't be done.
> >
> > All that matters is whether real user workloads regress.
> >
> > And please make sure that any changed behaviour is really obvious, so
> > that people don't spend lots of time chasing down *why* something
> > broke. A kernel printk is generally way too subtle - and no, the
> > tracing "make the printk extra ugly with crazy ASCII barfics" model is
> > not an improvement.
> >
> > It might be better to actually return an error to user space so that
> > users can see that setting ftrace_enabled to zero failed and it would
> > show up in user logs. kernel developers may think that kernel logs are
> > important, but users seldom even think about them. Of course, that can
> > then cause even worse regressions, so there's a balance here.
> >
> > End result: don't do user visible changes unless you really really
> > care. And then you spend the extra effort.
>
> Honestly, I don't know of any tooling that would use this kill-switch or
> any reason to do so. For live kernel patching and for BPF, it doesn't eve=
n
> work. Hasn't for some time. It's now a "kill some ftrace but not all".
>
> Hence, again, the switch itself is rather useless.
>
> It now is starting to cause a burden, as there's internal code depending =
on
> ftrace functionality to always be working and can cause some nasty
> undefined behavior if someone were to set that kill switch to zero. The
> solution is to either play whack-a-mole and make sure all those use cases
> have the PERMANENT flag set so the kill-switch does not affect them. Or w=
e
> simply disable the kill-switch.
>
> But I like your idea about it returning -ENOSUP if someone tries to set i=
t
> to zero. Doing that and the printk should let people know why it didn't
> work if they do care.
>
> And yes, we need to be ready to revert it if someone does come back and s=
ay
> their tooling broke because of it.
>
> Andrey, care to make a patch to do that?
>
> Have setting it to zero return -ENOSUP and print a message saying:
>
>  "The ftrace_enabled file is deprecated and no longer disables ftrace"
>
> -- Steve

Gladly! As BPF users we can attest that this switch causes pain and
handling complications.

Should I also clean up the entire PERMANENT flag logic we now have and
drop the flag itself?

Thanks,
Andrey
