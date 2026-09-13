Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E78529ACCD
	for <bpf@vger.kernel.org>; Sun, 13 Sep 2026 01:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789262820; cv=none; b=Yanjtv/Zwr+UNPN8JE1faHrasJ6bHkgw/8NMXLyWXx6uxN1MNjfh1EWuM0lv8E6trobKRpgESuP/17qDE9d1ZhZM8JE7CNqOMfe4FeLUzB3wL1YJQK49lI3o7WiPinU0y15faYp37Qfrsfz6j5vBfU0KhtoAfot6m/511UpZeRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789262820; c=relaxed/simple;
	bh=TSHs88GMB6DHBXH5X+N97OQWghhZeYcRWgEaIBLM84o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lO5UGnD+VPk1Pa40nYJ2ZaJD1IWJ1c++e7oMqzHaMXgULNfWVDzbL0w3lJNnZ5vHiEWyunbs0EktvQf2sMZ9DfNEbKuYfsNH17Cm6ABpJmU0pdLIb3BUicpCLOlxEl2TOSSnsslG4GBkC3JZDPJLi91G9SJzoqixtFzTBtRQu/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1A0Tq4q; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1A0Tq4q"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6be1f18687bso1337376eaf.2
        for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 18:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789262817; x=1789867617; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TSHs88GMB6DHBXH5X+N97OQWghhZeYcRWgEaIBLM84o=;
        b=b1A0Tq4qeTahp1fZe74KI3PV5/kpr0BjIYOKlgrhpVIgvZctHXmrIKiDoUKMzgvfoy
         Ezv6LVhfXyQhFawgeYB73T5QQNtRgwDL7gpMca09Qfw686QJTGcJycl19HWP+Yc3UNhW
         uiAFXPkrGGCH3WgZvgWHmeo/faag6bKTZ3BcjBWgAw8/acS/KRyqBcaiG4rwRvupY8WK
         tXnPt/N52F4NJ8fqZqmuPCidrGFx76zT9RUWECuvUtV/Fuy7sKBlk28uAwCX/vGiewNi
         B0qWM2VPo0OjQdFlhPd7a3aVgG/sGU7iNXViVH9cRmPmyo13gtpxNc8fEwzVe5UcSiCV
         Qsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789262817; x=1789867617;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TSHs88GMB6DHBXH5X+N97OQWghhZeYcRWgEaIBLM84o=;
        b=M0LoOdrnIuLDXF8ygVC8wPYXIRwSAVDMZjOfbofmiawOawfKcLpBCDHQWVvzZyO0Cq
         GdxW0Lu10R+RhEcVAZIpeaFVBthQI4ahdvy46Eph7BZw2UZaNxa0BNQQFBnoan5jYnZN
         yUPimgRuBehPtUjAmFFg4K+WxVAdcOXOpyfJAi9/5I5PgtzArgrWKM/otTtVrdOD4j6t
         YCxXzO82b8Tg2gTlzD2oIPZQCiiYknJZBPrA8wPWA05FZITGcae0a39T+MAFgcFSTyzJ
         KuWHb8J1Jv6vp9It9ypcR2W+0xcgNcVTqp9m5Ydc+UvHJ4KdqYXYtfc/DZc2s/1H0UJd
         +thQ==
X-Forwarded-Encrypted: i=1; AKwUvByFObvyAh5Icls/KMdOA5XMKPSpZuqH9dmnEiwr/nvwfPGSdqsi+lHJBp4JGmsSWEqB9m0=@vger.kernel.org
X-Gm-Message-State: AFuF++kpbtIlyclYZMXaMmu8XWh6is10iecLDDXJcpgTuprDBuIG3nCC
	znFUIhQQNzKEt8BFJn7fwXPs6Wi9XpC8imSFLsnkziEHy7T4MnZ4Oe05
X-Gm-Gg: AYBFou1CTNbh2692/3GRgq2OWy1MaC/JTTREZd+0HbNorfSKym8M0lv93YCWkFWKi97
	xfaOQgp9ZDowAtoE8n2m99v9YvSAfds6a515I2oKv2np9/90gk/MM4LNTHL82VMr1g4WD/CDZNh
	Ab5hjlBydhe21r/LEiXwZP6TRAIVfJnNQcf/LntASO6fv4X6vFWwk6p1KSvv3mCbadoPKil0gIZ
	ALskpKq74+NAkG+QK1K0c99IgtxzQO0VszlQsEJor09K2m7a7CwbIn//tI67ApvbWY3AMQQLnzU
	RGaQAV0tjS2lHssIEUS69Lo2e0QJ71SYvW8ZO2sVM8r6fnxZo6gHAqP9VBaGb+0m3ZW4eZ9dEmw
	rtTQv9LC/zOGM31tH3/5dgXDqP+2Cqv6CxoccbWV7joq1Yk69B3SKuVgRcwTkLJYKvFfqKQMCLY
	NOrsslNmQrcdH1On92dj2TxA29RSZyVS94Yq+GhjQ/SpClrD6cuM2PDzk7YLhAxJcRXz3jtLVX3
	gaYhtypvNrD5CD/1B5q/vpOZ7yUfQj1jetaHWScGE04Kxu+eL3WMYxQcCDCR93I9w==
X-Received: by 2002:a05:6820:160e:b0:6c2:3bff:3ef6 with SMTP id 006d021491bc7-6c23bff5dfdmr3227980eaf.29.1789262817080;
        Sat, 12 Sep 2026 18:26:57 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:17::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47df90faa62sm5431368fac.12.2026.09.12.18.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Sep 2026 18:26:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 12 Sep 2026 18:26:55 -0700
Message-Id: <DLDSQDSVXFHF.18X2UQUL5Y42D@gmail.com>
Cc: "Nam Cao" <namcao@linutronix.de>, "LKML" <linux-kernel@vger.kernel.org>,
 "linux-trace-kernel" <linux-trace-kernel@vger.kernel.org>, "bpf"
 <bpf@vger.kernel.org>, "Wen Yang" <wen.yang@linux.dev>, "Tobias Schaffner"
 <tobias.schaffner@siemens.com>, "Viktor Malik" <vmalik@redhat.com>, "Linus
 Torvalds" <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 00/20] rv: Add support for BPF monitors
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Gabriele Monaco" <gmonaco@redhat.com>, "Steven Rostedt"
 <rostedt@goodmis.org>
X-Mailer: aerc
References: <20260831090524.106845-1-gmonaco@redhat.com>
 <87se3sakgi.fsf@yellow.woof>
 <df6e9168cb06c35e21db7f9d17cfbca6bd87005b.camel@redhat.com>
 <DL5B40CU17WD.3KD75URQZ6RRR@gmail.com>
 <eb3dd8158942d663ec8ad4c529eacd666c5f96d9.camel@redhat.com>
 <20260903090211.50d15220@gandalf.local.home>
 <CAADnVQK8e1Qp9rf1zThZxb3vr4Gc_bpo0nqpEO2LdnEwHdKokA@mail.gmail.com>
 <20260904074317.01b2c0e1@robin> <DL6O0KLPXLTA.2HJJUXQUVCP5@gmail.com>
 <20260904123108.1fa1d815@gandalf.local.home>
 <20260904132421.111c0279@gandalf.local.home>
 <DL6XBKITK7ZT.3RXK9YGGUYZZE@gmail.com>
 <20260904194620.0c7a8363@gandalf.local.home>
 <CAADnVQJH1SYR_GN6gewF3w_z_Sex9HFE1T1oXkQe6+v18bDTWA@mail.gmail.com>
 <20260904201741.2986efca@gandalf.local.home>
 <CAADnVQ+x4iRNXOg69nUmuJ53pB3-JtroePcyoReATy9+V1aRPg@mail.gmail.com>
 <228FE969-EBFF-4B60-B0E7-C1E4FD82FB8B@redhat.com>
In-Reply-To: <228FE969-EBFF-4B60-B0E7-C1E4FD82FB8B@redhat.com>

On Fri Sep 4, 2026 at 9:53 PM PDT, Gabriele Monaco wrote:
>

Sorry for the delay.

> Alexei, what I read from your opinion is: if you really want to do this R=
V thing, then you should just implement it all in BPF.

yes.

> like the panic() one. Something BPF just shouldn't do, as I get it.

There is a disconnect here.
we have one KF_DESTRUCTIVE kfunc already. bpf_panic() can be another one.
It will require CAP_SYS_BOOT.

> I'd rather discuss on what is the best approach /today/. And that's preci=
sely why I submitted the talk for LPC.

Excellent. We can start this discussion over email and continue at LPC.
My understanding of RV is primitive, but from reading kernel/trace/rv/*.c
it seems to me that it's a thin glue between tracepoints and monitors,
a bit of boiler plate code via tracefs to enable monitors and seq file for =
visibility.
What you're proposing is "yet another monitor" that is reusing this glue co=
de,
and that's my main objection. I don't see the value in kernel/trace/rv/*.c.
(kernel/trace/rv/monitors/* are useful, of course)

What stops you from attaching tracing bpf progs to all tracepoints that you=
 need,
pinning few "bpf iterator" progs in bpffs that will provide text or binary
output via seq files, run a state machine inside the prog,
and do whatever "verification" logic inside them ?
You don't need the rv/*.c glue. I see no need to introduce new bpf struct-o=
ps api
just to look-like-a-monitor from RV glue perspective.
"runtime verification" as a concept makes sense, so focus on that.
