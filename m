Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A224F4D11
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792414095; cv=none; b=U0PbUKwTe9gQ/HIoHCI1YpwxBaTkna5EwL1vqALK7RpDyH6eq0alt8WBXVCTWI0/1ZnVoLusFvU4fP4M/9VCxMhzisFJ0IrJ3ZoXh2IhI0tBG2VlIBRSJ/0V5Mkxjd2W8dYPJ+yKmQf+NMnJkURXPptwMoYw0nZ3IeG5vMqVjcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792414095; c=relaxed/simple;
	bh=86nGS9uPfGg9gcq8r5vJAaUgJrDwOhpChhHeWKpARi8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JGaHjah+Tczo35MPDXh0Qxrgup9wYj89AwC30caKDj5KU0XQGw7ZcVPAjeI/FMkvBbbamAtayAUjB47vawK97uR83IsmExyT2DcT128LLBsHSYSFwKTUHoI4qPdqqr2SYDcR8Nvvm4eoFySad8KrtTC3x+L1uFxnVUQM/WAFFXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OL0Lv1iP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sLW5S1sE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OL0Lv1iP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sLW5S1sE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792414089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OLGg1AUZIaGlF5KY0eyTieD5+shq6f3blrp1e976rzg=;
	b=OL0Lv1iPpi1LpVKmsQXsWElG8baiKVWHJgPYAfJmmv/Tjy79Lppi5YIaj16s+tlarc95MC
	ZrZylymvHY60wQR2i/wPMGlJmAuCeCOyusTk7YDsULUhZAMosLpL2lsZJXZuHaV0Hks0Le
	SInV1OrJcN7Pfgacj+gR2Td700se+E0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-vPIp3eYaMa2eFVU23kFPtg-1; Mon, 19 Oct 2026 12:47:55 +0000
X-MC-Unique: vPIp3eYaMa2eFVU23kFPtg-1
X-Mimecast-MFC-AGG-ID: vPIp3eYaMa2eFVU23kFPtg_1792414073
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48dff112136so1444564f8f.1
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 05:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792414073; x=1793018873; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OLGg1AUZIaGlF5KY0eyTieD5+shq6f3blrp1e976rzg=;
        b=sLW5S1sEEbUz8fx3tROBGUFcflsNjQh/GZhT0iLCtzzqeJm4LmlQ56KYlz1+MHSA2S
         bi9CMRkBinwlmNCks+MTvFr/f/78jYY7TCLQSL1zi+ID47HaD2oeSwJ5lQiSjdNoXn0X
         Vg0hIOtsUwIJ/4dmaQrneaKyUNo3fPS05vE+Zbj8VXWhyKxkI7KzCfa5QK+OQAvvLNMj
         IrvlKfm5z/SR2S1IRT+cb6T28DpiGxv+vQXG6nRXlRDkKzCPbjtNJivy83xOWamyk8Qu
         re3v5cwvOrQ4umXgyk5Jfu9JmUFiKlQ3Cgf9XSOz1cQpbZBgD53nE3GqfWVYuGUTJQHQ
         gDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792414073; x=1793018873;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OLGg1AUZIaGlF5KY0eyTieD5+shq6f3blrp1e976rzg=;
        b=P0PZajNHVZPa4hDPokl8N/k+8+frv/I6qdX9o0dScAg3zbbpTMRZyVlL6Fq9Q+6KvA
         x8Ol27LGGIOgCx3tdmURIcG8TjvvEfH2wg2Q8A95HPovoN94XrUKePBi2mIPMqpG9B2d
         K8/Ua8q8PXFcWMqh+OJojjskQ5gu3U3nGJ64cTl3iQbTS5Ln/DKa770nRAZiKSCXTf3l
         2poUHykdGl/b7a9MEM1UxxEtSIakPt+oieCL/qZcikSCShdi3oWONR2zJ4ml5j+hIw8C
         iTsHahRY0JMXd8jPQZhmyu+e9V1ivxN4ZrkDwf9mZT9ZyfC4BUs81eiwTW/kmIi0OoW2
         1TDQ==
X-Forwarded-Encrypted: i=1; AKwUvBzGkfT30uLwvCV5r7wR4yBmyqiQmqhBVt5gCGXSYw6026LY8RE+K50g/gWVwH7YumabeeA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpgqVXgvMhPcIads4pElRNGJn6EL8fODtQKSCYdsBPQpZZFrB7
	drVRFbR6ZmIXg4GHphKEVE63tid61kQ6hrch8nz8m+QlhcF5K4gVvimJgs44NTwYJZIbybSyUN5
	fVkUJWGUnZ8BjQZUqoGdQr8AitcpMyfnjhGGDrp3ZT8/V4hpyXEhwvQ==
X-Gm-Gg: AYBFou0jsIEw8CaRLqP/p079KX+1NKD8l+t6CRQuDI3GMeHgLE+wX1+OH9gboLamNPg
	RXrU94dLRZGIgS+kCBwxVRTz1LF01s50tbf4NVRauF08iOrv/+1Ll88y/a7IbnxX7fkV14hzZJ5
	+KtadxCqMFWQ0UQegyzqvMgSl+koJE3Tj7m5yHIxmvHRYoclqmICrpaWfXxDcdv3bSTDNW7OX4q
	dL6lVP8jfZjvXa7ugy/2SYP281nuJFxQ1XoNWgxWzd1M760GkMb6rR6dZEKbadntu3YMBKRi+Ia
	JE2y06TYd6MGa2xHUU+nkbT7YWfqsIhpYH7hYX0Lgp7e1jcZC8qsAWUSXPjUA8FlwNqYLpvkxpZ
	1wo+rP9l86HfbM8+vYhrw2TzB+g==
X-Received: by 2002:a05:6000:1448:b0:486:f6dc:52c8 with SMTP id ffacd0b85a97d-48e07f9fae1mr14668787f8f.37.1792414073171;
        Mon, 19 Oct 2026 05:47:53 -0700 (PDT)
X-Received: by 2002:a05:6000:1448:b0:486:f6dc:52c8 with SMTP id ffacd0b85a97d-48e07f9fae1mr14668720f8f.37.1792414072521;
        Mon, 19 Oct 2026 05:47:52 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.134.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd5008e7sm22653462f8f.43.2026.10.19.05.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:47:51 -0700 (PDT)
Message-ID: <d2622f5c375ab26514d059b5949dee28f3f9998d.camel@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: John Ogness <john.ogness@linutronix.de>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Steven Rostedt
	 <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, Wen Yang
	 <wen.yang@linux.dev>, Tobias Schaffner <tobias.schaffner@siemens.com>, 
 Viktor Malik <vmalik@redhat.com>
Date: Mon, 19 Oct 2026 14:47:50 +0200
In-Reply-To: <CAP4=nvTc297yQHz8aumZFAQ3+JK=5Z_=416WdosT0S6nHEeNfQ@mail.gmail.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
	 <20261001152042.124445-11-gmonaco@redhat.com>
	 <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com>
	 <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
	 <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com>
	 <878q3xtptq.fsf@jogness.linutronix.de>
	 <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com>
	 <87bj8s8ih9.fsf@jogness.linutronix.de>
	 <DM78SVMBI2XW.2XHVC67VON48A@gmail.com>
	 <87v770uuyr.fsf@jogness.linutronix.de>
	 <DM7I2PYHNKXE.3AYY3N1HATXLW@gmail.com>
	 <87ik2zryzo.fsf@jogness.linutronix.de>
	 <0055967d4571e7c8549dfa476fa6b15b93013701.camel@redhat.com>
	 <CAP4=nvR2i092924zszA8Qh0UUYnwXfAsa+7KjPe-NpwC+bbLXw@mail.gmail.com>
	 <8580176d216258e9008c344e0529509117dcc18b.camel@redhat.com>
	 <CAP4=nvTc297yQHz8aumZFAQ3+JK=5Z_=416WdosT0S6nHEeNfQ@mail.gmail.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-10-19 at 13:05 +0200, Tomas Glozar wrote:
> On Mon, Oct 19, 2026 at 12:43=E2=80=AFPM Gabriele Monaco <gmonaco@redhat.=
com> wrote:
> >=20
> > > One disadvantage of using bpf_trace_printk() for RV violation
> > > reporting is that the event will be caught by every instance that
> > > enables bpf_trace_printk() and does not explicitly filter rv out.
> >=20
> > Yes, that should somewhat be mitigated by the glob filter, though event=
s are
> > still generated.
> >=20
>=20
> Do I understand it correctly that the idea is to modify existing
> tracefs instances when enabling an RV monitor to filter our RV-related
> bpf_trace_printk events?

Not quite. The initial issue is that the current iteration of RV BPF monito=
r
don't cooperate well with trace-cmd/perf. Alexei suggested we use bpf_print=
k and
filter out the desired events with plain ftrace glob filters (from trace-
cmd/perf).

I believe this would be usually equivalent to having a dedicated tracepoint=
 for
RV BPF monitors.

E.g. you'd do (roughly):

  trace-cmd -e bpf_prink --filter 'bpf_string ~ "rv: sleep: * violation"

instead of (with a new kfunc)

  trace-cmd -e rv:error_bpf --filter 'monitor =3D "sleep"'

Now, I didn't try either way and don't know what implications there are eit=
her
way (you seem to know better about this).


> > > I can imagine an RV-specific trace event for that, however, it would
> > > require a separate kfunc to generate it, and ideally also distinct
> > > labeling of a BPF program eligible to call that kfunc. The "rv"
> > > userspace tool could then iterate over these labels so the user knows
> > > which violation events can be expected to occur on the system.
> >=20
> > That'd work too. It's what I initially envisioned but I'm not sure a kf=
unc
> > producing a tracepoint is something BPF folks would really like (and
> > technically
> > any other unrelated BPF program could call that, unless there's some ac=
cess
> > control mechanism I'm not aware of).
> >=20
> > Not sure how much it matters in practice against the glob filter, it
> > probably
> > really depends on the other bpf_printk users (and a mildly better
> > usability).
> >=20
>=20
> bpf_trace_printk is already a BPF helper producing a tracepoint, this
> would be equivalent.

Fair point.

> Of course, that does not mean we want it, but it
> is something we already have in at least one instance. I know of at
> least one quirk: you can have a BPF program attached to a tracepoint
> that will call bpf_trace_printk(), and a tracefs instance tracing both
> bpf_trace_printk() and the original tracepoint. That leads to a new
> tracepoint triggering while another tracepoint is already in progress.
> I don't know how it is currently handled; from what I recall when
> testing RTLA's BPF actions, the bpf_trace_printk() event might get
> dropped by the tracefs instance, so I had to use a different way to
> signal to userspace in BPF actions test.
>=20
> As I said, to prevent unrelated BPF programs from calling the new
> tracepoint, you'd need to recognize and track RV BPF programs as a
> special type of program, similarly to what your original RFC did. I'm
> not sure if that's what we want, but I see some advantages.

Yeah, this last step is probably something we don't want.

Although it may not be such a bad thing: if we require enough privileges to
trigger this tracepoint, then the worst we get is root trying to mess up wi=
th
monitoring, where it could easily mess up with everything else already.
But it definitely needs more thinking.

> In addition to better filtering of reactor events, you could separate
> reactors from the monitors entirely: you could trigger the tracepoint
> unconditionally, and attach reactors as tracepoint triggers to the new
> tracepoint.

Something like this was already brought up actually and isn't a bad idea, i=
t has
its strengths and issues but would somewhat work in-kernel as well.
But as you said, that's a bigger reactor refactoring and beyond the scope o=
f
this submission.

Thanks,
Gabriele

>=20
> All of that adds complexity, though, and requires separate discussion,
> so it's probably not something relevant for the initial
> implementation. I just wanted to mention it so that it doesn't get
> lost.
>=20
> Tomas

