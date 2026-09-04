Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EBF38838F
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 16:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538593; cv=none; b=fgJVFvKmq5hHrzE8Z81doTIxd3ngcrCAqTr8Fr3GoT22JSmLT0n7bPa4JOxPBP4QdjhyF84+iheKzHK/6fJrTZ4q/usUumTJ+LZ10nVOhRLVW7jhSayMS1X0iaacPrGP0tiDcs8LuoOWDvUnBAvBM1ZUjQlbhfBTaoyppQU/BAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538593; c=relaxed/simple;
	bh=S3ktW0mgvYiUuy41pETr8cIXqy6mtnT30IxPC+xLG+0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=me+hNbDGxiXIEZ7FGFb4TsJ7ZT+B+0AclUQKYRkCLhWcIhljvCgkCiysEGoXPXbSOqa8N3qxJ+jkLVDute8bULzcBF4+b+rtk6SLFl/W2NVCIFRcBSce/w1RhqKJEaZoH6pSXN4hdPCl3rLl3sao8gkbcszKbHuVUrKNhqDQ8K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5LIOVc2; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5LIOVc2"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-98089686ee7so788121241.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 09:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788538591; x=1789143391; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S3ktW0mgvYiUuy41pETr8cIXqy6mtnT30IxPC+xLG+0=;
        b=Q5LIOVc2jydu3NQfKcT4lyGyOMiNWV2OoAgdGHXlHq35NzwAYSfwepheqYbQhZK7dS
         kQefbZAhXLuNLnVQTkwcb2DkK2G53gHl0EGJq/MiDaFyJ1qGupDaWxxbpv/kwG9e71QG
         J5KH5NBxa6ngviZBotoOFJceD4CQZdzEjCnE7EAWzlwbffBE5YeC7MTMj9vJhAuDMkX2
         M34YBHZrj3PhD5dtgdJwZnkChRcAUlXDbP5Q8q/vQexjGYODJaT5oZYBVQ4pAXR3idWi
         BWov1SJIFPc5emxphanmC5umsA3G0mzMWaUQgRDM9MNVY4XPDR7A3OtxjfiSZNxS6YKT
         D4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788538591; x=1789143391;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S3ktW0mgvYiUuy41pETr8cIXqy6mtnT30IxPC+xLG+0=;
        b=GdNB/suWEUsCJYoxE4FRQnM06Uj9i5r5DUEyTiy+/h/04BHGJF6Dr+ZrV+yik0TZ9w
         HeNQLvgvsTsqBryWiBKYEp9ercmPmERxLM3hdpyV6LWHF3z91LiUNnMnJAjf2wrL9ti4
         7qUUnlN/yI2AnPG/vi9DHMc3QT4WyPg3V7wnL9wSDqNM0XmV63K8c575xLPyOZwQ/o0J
         17t8TDASlDEPp6ntHT8CSrJcoe/vV5dspXiT/t1VBpAq4bHVMe1+GXEzvYHSVAoM8gSh
         zoH2x9jWokFxHPgHcpkp3UyV/lfJEHGfuNXlPObEWTI+jxJskGC7u9xonlK8erQeOGpj
         tf7Q==
X-Forwarded-Encrypted: i=1; AKwUvBxVmpCWAj5ujrXD6MwaxFcJxOeoCt4bpmP5botte9vHilX9LdKqDkJQZ6MimSy8hLeYg7s=@vger.kernel.org
X-Gm-Message-State: AFuF++nUdjaPjJ2hr1xYf+NXP+eINgR3a0rl3kOcch7LUoVbB6dIE4e2
	oqq72ibJA9MHlGDZMOdN2+3rbWqVzF8oR5KnFnIRresH1jefGXHJ0nx8
X-Gm-Gg: AYBFou2mrGdypvuQlhjmotBXItniSfpMRdpGoJMPE66zULwXaaocg76HawYz3RcRLkL
	+DUIxPgVKuX9u2i9RKjIjvWa0F41Srg1jtM76iAzMEpjk/UWlvEP5qjEGwG7c/TJu773482nEHh
	xXV0EFp2OYK0tF5b4fp60X4jMq6n8fm6YdanizdrbjGqsaPL9TaQjFp1Cx+TCFG8g9Y10FqB9ga
	fJZY/QX1ifycybcLUeAI2RSTCivZfwxlz4Z9GgS/1ZKj6slwpx4EQT5YB1aw96Cd9RdpQI7NXRu
	73289GZwub/j44Ic1qu5u41fzgwe7B60kZGrrYnp8ScYhpYpHCNGBMPOO338vAz/aFiIRF9KE9I
	c64HWGIqC8lavWNAtKVgXJAhAaCGJvRcOqNyboLmARhqr2Ppq1UM8UXwUwnQdwYTViaskQHHhkp
	Sd4skeB+q7BJYpYUNtUmdBQJBEOo8G14GayNDP52guu4d7jdBwC8vRNoSiukhoM4XDn6cDKfahd
	Tgy2KmqKbEoLvCuYvHX8+1FwjI/MtmRLku+IlJwC5hoI4sJ+gSFzvI=
X-Received: by 2002:a05:6102:3749:b0:785:eb33:87aa with SMTP id ada2fe7eead31-78a4a8b86a5mr2672910137.5.1788538590614;
        Fri, 04 Sep 2026 09:16:30 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:1b::])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-78a4764e321sm2244966137.0.2026.09.04.09.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 09:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Sep 2026 09:16:28 -0700
Message-Id: <DL6O0KLPXLTA.2HJJUXQUVCP5@gmail.com>
Cc: "Gabriele Monaco" <gmonaco@redhat.com>, "Nam Cao"
 <namcao@linutronix.de>, "LKML" <linux-kernel@vger.kernel.org>,
 "linux-trace-kernel" <linux-trace-kernel@vger.kernel.org>, "bpf"
 <bpf@vger.kernel.org>, "Wen Yang" <wen.yang@linux.dev>, "Tobias Schaffner"
 <tobias.schaffner@siemens.com>, "Viktor Malik" <vmalik@redhat.com>, "Linus
 Torvalds" <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 00/20] rv: Add support for BPF monitors
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
X-Mailer: aerc
References: <20260831090524.106845-1-gmonaco@redhat.com>
 <87se3sakgi.fsf@yellow.woof>
 <df6e9168cb06c35e21db7f9d17cfbca6bd87005b.camel@redhat.com>
 <DL5B40CU17WD.3KD75URQZ6RRR@gmail.com>
 <eb3dd8158942d663ec8ad4c529eacd666c5f96d9.camel@redhat.com>
 <20260903090211.50d15220@gandalf.local.home>
 <CAADnVQK8e1Qp9rf1zThZxb3vr4Gc_bpo0nqpEO2LdnEwHdKokA@mail.gmail.com>
 <20260904074317.01b2c0e1@robin>
In-Reply-To: <20260904074317.01b2c0e1@robin>

On Fri Sep 4, 2026 at 4:43 AM PDT, Steven Rostedt wrote:
> On Thu, 3 Sep 2026 20:30:19 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
>> > > On Wed, 2026-09-02 at 18:57 -0700, Alexei Starovoitov wrote: =20
>> > > > I don't think bpf fits here. I haven't seen active use of RV and e=
ven less
>> > > > so of any request from people who want this kind of programmabilit=
y.
>> > > >
>> > > > So Nack for now. Sorry. =20
>> > >
>
>>=20
>> Ok.
>> Please add
>> Nacked-by: Alexei Starovoitov <ast@kernel.org>
>>=20
>> when you submit it to Linus.
>> Let him decide whether bpf maintainers have an authority
>> to say where bpf is used in the kernel.
>
> When this is ready, I'll be happy to inform Linus on the pull request
> that you NACKed it, if you are still against it by then. He's Cc'd on
> this conversation now. But you left out any technical reason for the
> NACK. You basically just said "I don't see how this is useful to me".
> That's not a valid reason for a NACK.

You added a whole bunch of hardcoded "monitors". None of them were
necessary. The whole RV is imo a waste of kernel code.
All of that could have been done via existing bpf tracing functionality.
One can delete kernel/trace/rv and do the same thing with bpf.
So I'm strongly against bolting bpf to RV as yet another "monitor".
It's a wrong design. Keep adding hard coded monitors and don't mess
with bpf.

> Gabriele will be presenting this work at Linux Plumbers[1]. This will

I didn't vote for it. Other bpf maintainers did. Hence it's in schedule.
But my stance is still a nack.
