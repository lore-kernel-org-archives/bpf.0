Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C68241686A
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 11:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788521020; cv=pass; b=R646KZ0wQmRvILqkQ8p0dUmoHQHtuVGOyU8HT8gjxIYZEuy/smZnczs418hYBmbPMo0PIkYDUfVjbROU5593HBCHhcSmEjDTbDmu2VGVqQPIqYO6ulsj7eu8xfRx5yEU1A2IclkB61fymfsUJzuOo8bdlSSDBJnH56/HyjmaLbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788521020; c=relaxed/simple;
	bh=2lecvDZ/BSD8c+InIe90+zaCIL0CBuMX3DDlyXPCoFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yy6FIfww4gUyxPgSHXF0JAyIgXKV8oKiggbT02xg/ewIWxwHFxURFFRkW1xkIFBTYT+9S2HIHu5SULtHr3puPb5pgIZW6J4UbHXKuiC977f4gaWK8MLYnFPgBx5pTABHJr4oYCkZQlSk20SJHAuZ7IPStr/iOq+Z7/NqMvN0XeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JpbfwTfE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XedHL495; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JpbfwTfE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XedHL495"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788521017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2lecvDZ/BSD8c+InIe90+zaCIL0CBuMX3DDlyXPCoFw=;
	b=JpbfwTfEygfYIPFgeSHUW+AceD6XzXdd/UcHdZKppLUOvJh5EYXIF/Bt3TpiicItIq3FfC
	y+Lk3d7BLC/7JqKynX/m0XTgut26/ig6NbRHox7RYs5z/GMNlhH5o0aglOTWJKCGZzxlmX
	rKhKNShPTZP5XT+rbnhRjX1hRNGAJg8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-l8jxMcwkOrmO7OBSk4Q1Rw-1; Fri, 04 Sep 2026 07:23:35 -0400
X-MC-Unique: l8jxMcwkOrmO7OBSk4Q1Rw-1
X-Mimecast-MFC-AGG-ID: l8jxMcwkOrmO7OBSk4Q1Rw_1788521014
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c1c232fa136so126165366b.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 04:23:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788521014; cv=none;
        d=google.com; s=arc-20260327;
        b=r7OixStBGVDDGPMpQT00cIxZUr8IFhlMU24CYh4l3le1S8gZt+A0dHn3oy5LTJR9q1
         Dh12SK6HO4WmQPP2pmPuQ3UWCgCyXtoK7o54GfGeXCHLFxNtCyb0FtIUXpLzoFltwohg
         8nhBtTmlZdI9KxMsyzZK4qZqcCOXK4gkdVXV/OcYF23IiCxCXnrISvfT673QAkNho/fU
         IhKcwUgOSo488KNT9NIGAfPV7vQhK5lpMXKSBTyaUZEGhwE8x2HJ/NJ3XIePePtuAg5e
         Oo4P9aX7tPsYEkjy/VlezPXh6JGUfI1OzSXzCx3r9Kdr1shSUNH/hvYAJeJKXQ7hJxRB
         4uRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2lecvDZ/BSD8c+InIe90+zaCIL0CBuMX3DDlyXPCoFw=;
        fh=xaz2scWHMrzlVYufXCez+SLdm62B8InCfH0s+8Ul61I=;
        b=RgpLd/jLKzWjMrnDi+Z6MKsz2i8oI1thBKlBSTO3bVj86JPhBVWTzg+9heQbmtilXg
         7I1B8KNoLXUllOiIJNukKGQeu0ifO4a0L6w5Mzddaj2dZH9ljULqflkEl15CL/wwe01B
         1hjmsxZLen54yLCv9C6m/+udd8f0coi6SoyhE6ip3pfx9HsGepVsTHaQz3eAizt22efS
         OQUr06w+gJh/NiJ8FULZoaVUmjQQ9X6F3r3Y+G75pn84+e2Fsohu6Bk/Nm4WOT3Bt9cb
         AUR0LlJPQaFETV46I5PVqbz6Izl7BzSYlaGpuE+lySIDra0sUrn1QKiFuGucGQKAhdcI
         Nn+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788521014; x=1789125814; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2lecvDZ/BSD8c+InIe90+zaCIL0CBuMX3DDlyXPCoFw=;
        b=XedHL495aN1euvtg/tQbZR1o0yTOVFgVa0MHTkz68PbUZMmtVmb8RAlebWhsj12cUp
         KJcA+sxNGORfZwlicbqQ1aMnr1Knv4bgcHTl6wO7g09Gest1ZVq8XopTR8PDvCGNAmRC
         81g+2WnkgkzewYG3EmCiZsQyqNSKEdoWDUiiOqt0vctHcDXzZNTBbHu+iiQPUu7q8t8P
         07Cln05gns421lQm+To/SH4XCqRA1PJWvtFrCZ9SYxRMHUO4KIElsE+LPejKABnfG9R5
         08CHjg0qzSox1Z8g4wJwl9llwvnAJskWBGtPN8E3jUJ/a0x7pQXiMrB2EbrOkIyJpJOS
         3jmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788521014; x=1789125814;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2lecvDZ/BSD8c+InIe90+zaCIL0CBuMX3DDlyXPCoFw=;
        b=edRQGNouHghtcarYfbB7tgURQbP5LmG2YtPgZEDc+prV0aC/bT2cMhHhHIaG/LiFjO
         9AEM6zxDRFUm6z/CBC/vXFPmzE87ZB6RO6Wqh5GGQefo6P6uJhZ+V3Tqr4VcS276ZHHC
         OiBY0uYRSD0C7GzuyykDAuGWoTn81exv1+s9xEDqnp5KGVhQkpImoZ51GBZIXrbfPmI2
         q4WbU5BaWRPHhI8c+jZOwbs5D8VtQVImb5TTXHxMpJqzvqkwRMzRuydVurA4RXJSIIuo
         BOxsb9mlP8WBD4b9Z+91e6v19sjeeZ/SuCeuuSPwzrf20lvJnbXdCSUi38NFolmnwyjT
         g9Tw==
X-Forwarded-Encrypted: i=1; AKwUvBzpyYI7zdMsZB9Q25UxCpNqZzgyrNq9QnXS9e+AzzYg6wyYNPB7TbLAFnRr362bl0RnWyw=@vger.kernel.org
X-Gm-Message-State: AFuF++kwYDLQD8PvhW7PNVmfmWfJ4ELb/lkZt69M1hIEkfTRhm4z22CQ
	lmo1AUaA7gHr6sNvj17VpzlC4rT27UHNy/x3N72TLo/uG4Rxal54AEUAwyzE3JobCvotl//W3Ke
	tLr7ahj7t+qfNk0jf9eXW/X/qbK3AW3pQbMmKu32ZuGOkC5s+QiGj3sB04rEsi2Y3TJRTDVZ3UN
	+mNQGeLq97lB9lfkDdZsEzmSRfCGtl
X-Gm-Gg: AYBFou3dK18hs8x2bRgLlPY7fwY6DQZkK4gnASEW92dEIRpbhzVvxHLpHhKuWlolzkp
	Y1WTmY0kNKJ1dSzghBGGwfJ53u09T0CTdBkJcIiSj/DymqZRGpN6PD9WzBueBnXs1nNWdIUtGQ+
	Dolyi1id2N4qtzCaSCPzXHQg+H4udTK+vk1VCXLVB4eSiyGBO9of3JrNNu90UYLVY2Hpsx0PPhg
	myJ456qd1tsMzo=
X-Received: by 2002:a17:907:c50a:b0:c25:8b1e:3750 with SMTP id a640c23a62f3a-c2610474a62mr161182866b.12.1788521014280;
        Fri, 04 Sep 2026 04:23:34 -0700 (PDT)
X-Received: by 2002:a17:907:c50a:b0:c25:8b1e:3750 with SMTP id
 a640c23a62f3a-c2610474a62mr161180766b.12.1788521013862; Fri, 04 Sep 2026
 04:23:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831090524.106845-1-gmonaco@redhat.com> <87se3sakgi.fsf@yellow.woof>
 <df6e9168cb06c35e21db7f9d17cfbca6bd87005b.camel@redhat.com> <DL5B40CU17WD.3KD75URQZ6RRR@gmail.com>
In-Reply-To: <DL5B40CU17WD.3KD75URQZ6RRR@gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 4 Sep 2026 13:23:21 +0200
X-Gm-Features: AcwNN1VYWiS12e-wX0_oY-0KV9RCS33pApbGhM3jUchKS91T2uscR3QBMlp3mw4
Message-ID: <CAP4=nvSCxbFTLBSvXVFnv-smMyFd9fNFXjodJGEqah=_GEuXkA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/20] rv: Add support for BPF monitors
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Nam Cao <namcao@linutronix.de>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Wen Yang <wen.yang@linux.dev>, 
	Tobias Schaffner <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 4:03=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> I don't think bpf fits here. I haven't seen active use of RV and even les=
s
> so of any request from people who want this kind of programmability.
>
> So Nack for now. Sorry.
>

A major application of RV is monitoring the combined behavior of the
kernel and an external application, see [1] [2]. Adopting RV for these
use cases is difficult because the monitors are currently built into
the kernel. Blocking BPF adoption because it is not widely used risks
a deadlock: RV not getting enough users, because it cannot use BPF,
and BPF rejecting RV because it lacks sufficient use.

Of course, I might be entirely wrong: RV may not end up being
interesting enough to users even with the BPF hooks in place, or it
might grow enough with only in-kernel monitors for you to take it
seriously. However, we cannot predict that in advance.

(Note also that the idea to use BPF in RV dates back to 2022 [3].)

[1] https://lore.kernel.org/linux-trace-kernel/20260827072400.45734-1-tobia=
s.schaffner@siemens.com/T/#e8a8b21136a60ad7c8f67b07c66f71de0ec0c1075
[2] https://docs.kernel.org/trace/rv/monitor_rtapp.html
[3] https://gitlab.com/linux-rv-tools/dot2bpf

Tomas

