Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792663757;
	b=DcsGkS3oxW8bm1Bhq9F33ylAyFlha1dzL9m6yDQVTAytjJGNJyGRU5uSL9ZeezkFfE/Z
	 jTdxXIBS9ezEX97foow2z1E0HUR6k9LryysXHDNB0k3cY0tED5YAPr+YpUpeSXYa99E4C
	 pxlWG2LEe8WNUEIs8hTuLh/KrxFEOipCwKgNWBbc0D2JTRL1cmk0BfEnHWRCsRcOrF6eP
	 KAV7P5lrDkQNBNuwmm6TsR+C9MjR9+9bnaUGd8Af9059kQx4tWoaFUdRY6mBFChJHxxlw
	 fLuzh58bmZZ+qCLWRQxRqVcUsK4fl9Gq/OtZkOM0UtA5BHUeao7QjCF2uZy8gQl7nxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792663757;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=wETKfdVYHHqHUakW4mnAiN0SXgO8jkk0A/c3OyTHhsI=;
	b=U0tBMqVbbASzczhrjhqyCyTsQiupagWfQGY1Cwy6EhPvrkvDuqTWVCbw1MNjEZXdzEAT
	 g/GLojthxbq6g32u5zqOpXDhgqHSU75laijieJ7Y3biBNqpf1GH/rR5ZKnC0StCYORhrU
	 h6TgyyT8nHmsHuUmLOWD6k2iduf+JQoVNYExDQMnqdX41dAjmsD6cFR2a4Jrc/oRGHOo6
	 Ubjr5D9F5KwnS2u9NYBzqqL5p3vZ8HyGE3fbzeVWn8WwpF9e1jnBRbR53LIW4a3SJ9sHA
	 U6UCre2Br1uml/b1L+F2KZgPfe73U1/AIn/riLjGMaEJe+oCYdVLDfeJ7rnDRvGGjsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="WLH/tWnj";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=R0wb0W0s;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E63C606A31B
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 10:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E63C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WLH/tWnj;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=R0wb0W0s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792663755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wETKfdVYHHqHUakW4mnAiN0SXgO8jkk0A/c3OyTHhsI=;
	b=WLH/tWnjT4m21skStwE7bP3R1zxOBOoSgLHTmo6MAQYgYmDGSGsvXfAk4AUFhf1QggDEO9
	m//5yUMqZPdRAL6SoMS0aStCfxYWQi608k/Ig7p09b1bHmA8WNl45bVkCPWPgJpoQq48aZ
	lKkZwvLmhwpcIZT0hWYhmIUFsmdMWwo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-mjjY1-B8Nb-IOpwl29RF2A-1; Thu, 22 Oct 2026 10:09:13 +0000
X-MC-Unique: mjjY1-B8Nb-IOpwl29RF2A-1
X-Mimecast-MFC-AGG-ID: mjjY1-B8Nb-IOpwl29RF2A_1792663753
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e0461e040so1311942f8f.0
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 03:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792663753; x=1793268553; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wETKfdVYHHqHUakW4mnAiN0SXgO8jkk0A/c3OyTHhsI=;
        b=R0wb0W0svtOM+Nj94fsuqxAm2Lv7+CSJpoodPkccdR8PBRUL/HLn5wDT2W7bHzWPNW
         1lBwQYDTlJm8sg3s+SKx4HFc8PbChZiXdUOvhIgLFiMV8cPMdZSWLMbf6rVnDa9oJixJ
         qLmiyNj6h46hE1mn18dsj+u9Qut8FTfPjjj49LiGCKRHVAYm5GL+THPWPvTwOl6BReZb
         AemRsnTHfGVUzmSRkvrX0McJ9nWJbMg7aWCP0lEPHkLtxRBcPkmb65wCauc03T/UF7rE
         jSQG2Bn31FCo+c2Z5YWIqzmJZTUz0CDxD7Vks/2dKguEnI/sCMxA0mKDaMlCy5GlLJns
         X9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792663753; x=1793268553;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wETKfdVYHHqHUakW4mnAiN0SXgO8jkk0A/c3OyTHhsI=;
        b=I4DOlcFn0pbV3RQwfJXwTphaZ00WIXANLRFvHNL4RJpoB80Sc75g7Aojbuj52+LIFa
         8B5Tu5/YN73hY8Fq1LazPPEf4FikIfwHYOXn5+owrDRPI2zYI11h1kjqVTJ1xcvvDX6A
         K/RWU6zHb0IrQG+CKnb7MxhSL6u9y6Dqj08QxpB1LINyiPpVACSVQRpRwKaz/8aQ2/mu
         CAwS0qPkoj/fXWtqoraJPMU4Rh3b6TyCbUr7fMhXwIWuvD82X3WL2UD6JxpT6lU9ht9U
         IQz/gezUBheWEey6KiCsRKjS/REeznoXyaBLjTyyhOdO72og/HpLwT4Hy402Z8M6jmWu
         3uGQ==
X-Forwarded-Encrypted: i=1; AKwUvBwqSKPFP8sqsIw2QSbJZWFjm1QRUSonJeUuip8tsxhbxVD1l85KN5x3UKBph7kVm8OZSiM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLqzx+yLweJgTp+EqiGsA51TdgfaGaCTaR8Cf6TcEzggRbY1IVR
	wVvFcBiFWoTBNUi/Vfx/mnvQ+p7h0WTZ+d2wjVWqUTz8JmNwug6J2QTyS38AIANu1lyA0qKfrA/
	AlwgCyccopsxAOTyZummzDV6HwEcXuspEb4pnRmKZbLmjt0QnygB5QQ==
X-Gm-Gg: AYBFou2904cdqtm9fhayiIdMVO8TsqF5qYGmnmwS8ZsTZnuPElxBko3q+Y1dkBLfqbJ
	kOp8BAueWkNzeUX6qsOucE8J4pkwmMUZZJVemQ/PjPdSCK+jxiCVxM2S3684p8rfxNrbTed+P/M
	FEbo0H93/wf7fEvfx4iiBANLZgCYtkKX7vXiZlll5ZeeYKhO4q31c6Z0i3xoe9IggdRNMtvFBb9
	WW9aGcVAOSXQSKZ1D29D84DUvmE9cZqGxfWruIbe6C8WvgOw0fadyfLqhoxzNfuT71tCHHCuuxQ
	ddkarSkgzICgfwUbVksBcJti/mqag/o8uPkw/QkAvt1LS0ulrRmT6OI7FepmCxpyRXNMk5uDhBU
	jgKLIPOFw913VFqRbOefnX27hIqAg
X-Received: by 2002:a05:6000:4026:b0:48d:f36e:ccc0 with SMTP id ffacd0b85a97d-48e263a7b5amr10031859f8f.0.1792663752686;
        Thu, 22 Oct 2026 03:09:12 -0700 (PDT)
X-Received: by 2002:a05:6000:4026:b0:48d:f36e:ccc0 with SMTP id ffacd0b85a97d-48e263a7b5amr10031814f8f.0.1792663752215;
        Thu, 22 Oct 2026 03:09:12 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.133.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e258420e4sm10833840f8f.49.2026.10.22.03.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 03:09:11 -0700 (PDT)
Message-ID: <e778bbd7d5e2d2fc07ee365f37db59af04d9a36f.camel@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: John Ogness <john.ogness@linutronix.de>, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>, 
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Wen Yang <wen.yang@linux.dev>, Tobias Schaffner	
 <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Date: Thu, 22 Oct 2026 12:09:09 +0200
In-Reply-To: <874ieetakx.fsf@jogness.linutronix.de>
References: <20261001152042.124445-1-gmonaco@redhat.com>
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
	 <87pkx5q1w4.fsf@jogness.linutronix.de>
	 <0d4f11b1999588ddba9d855db43fc492eda32de1.camel@redhat.com>
	 <87h5ifqy6w.fsf@yellow.woof>
	 <a8d8b080f403eed617242a3276717706b4081ed1.camel@redhat.com>
	 <20261021094853.29b9f7be@gandalf.local.home>
	 <fb5c20f226f723cbb4df5092462dfcf5f2686367.camel@redhat.com>
	 <87h5ifvw3p.fsf@jogness.linutronix.de>
	 <f147fa9dfc553767ce92802b66723a85cf804e46.camel@redhat.com>
	 <874ieetakx.fsf@jogness.linutronix.de>
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
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, 2026-10-22 at 10:21 +0206, John Ogness wrote:
> On 2026-10-22, Gabriele Monaco <gmonaco@redhat.com> wrote:
> > > I am wondering if coexistence should be the goal. For example, the
> > > monitor classes (DA, LTL, HTA) are only implemented in the kernel and
> > > provide kfuncs for the state transition functions to be available to =
BPF
> > > monitors. I would expect that this would allow BPF monitors to have t=
he
> > > full functionality as in-kernel monitors, since the events, errors, a=
nd
> > > reactors would all trigger from the monitor class code.
> >=20
> > Well, this would be yet another hybrid requiring BPF monitors registrat=
ion
> > in the kernel like I proposed in the RFC [1], which was the main point =
of
> > contention (that fully shared reactors and sysfs interface, by the way)=
.
>=20
> I think there is a difference, because the registration could be via
> kfunc interface rather than requiring kernel patches. Similarly, the
> kernel is able to load drivers that it does not know about it advance.

Adding kfuncs requires a kernel patch nonetheless.

We avoid a STRUCT_OPS and craft our own way to register BPF monitors, but I
don't see a practical difference.

> > For this I would argue, though, that such monitors would be BPF just
> > on paper, we wouldn't be able to use many advantages BPF provides
> > (e.g. BPF maps).
>=20
> It seems to me that your main motivation of BPF is to move the
> RV-machinery into BPF. For example, moving include/rv/ltl_monitor.h into
> BPF. But that code should not require the flexibility that BPF
> offers. It is the monitors themselves that I think benefit from BPF. For
> example, kernel/trace/rv/monitors/wakeup/wakeup.c
>=20
> I do not understand why you would call it BPF on paper, when the
> semantics of the states and transitions is all coded in BPF. Everything
> that makes two monitors using the same monitor class different from each
> other. Only the generic state machine (with its tracepoints for events
> and errors) and calling of reactors is in the kernel.

Alright, that applies slightly differently to LTL, which has actual functio=
ns
inside the monitor header. For DA monitors the monitor header contains enum=
s and
a "function" field which is essentially a matrix.

Functions like ltl_atom_update() , ltl_validate(), etc., the actual monitor
class logic is shared in the ltl header. Those are the things that I'd also=
 have
in BPF (and share when possible, see more later).

I say BPF on paper because the monitor state and everything it stores is in=
 the
kernel.

BPF maps offer some flexibility and stability that is actually useful, I cr=
afted
the per-obj thing myself and I'm sure there are more bugs than a simple BPF
hashmap.
per-task monitors use a static field inside a task_struct, we have a limite=
d
number of those and obviously the size is fixed. This is great for use-case=
s
where verifying the code matters (i.e. can't use malloc), but a dynamic app=
roach
as the one BPF offers rather simply can be useful for monitors that need to
store something else. The hack used in [1] could be simplified drastically =
using
a BPF map.

> > The current implementation already shares the header with in-kernel
> > monitors, so the actual logic is shared.
>=20
> When you say "shared" you really mean "copied". If it was "shared" (in
> the kernel) then the whole tracepoint/reactor topic would nearly solve
> itself.

Half and half, I say shared because I include the exact same header, not a =
copy
of it. Then some things down the path cannot be represented in BPF (tracepo=
ints)
so I re-define these.

The logic that translates the DA function[curr_state][event] to an actual
transition is shared.

> > Besides, we'd need to be extra careful on controlling the callers. Righ=
t now
> > handlers are static, so it's easier to make sure no rogue caller messes=
 up
> > with monitoring.
>=20
> That problem is orthogonal. But I expect kfunc flags, capabilities,
> and/or signed BPF objects will be the direction to take.
>=20
> The reason for my suggestion of a "true" hybrid approach is because I
> feel like you were trying to completely relocate RV to BPF, and now due
> to the tracepoint/reactor requirements, we're trying to find some hacks
> to somehow make it work good enough.
>=20
> I was suggesting to take a step back and consider an approach where
> there are in-kernel pieces to leverage the benefits of in-kernel
> (generic state machine, tracepoints, reactors) and BPF pieces to
> leverage the benefits of BPF (freedom to define the semantics of states
> and transitions for any domain-specific monitor).

I'm going to consider what this implies when I get back working on this, bu=
t it
still feels cleaner to me creating kfuncs for tracing only, if we consider
bpf_printk a hack.

Exporting all handlers functions is probably going to require a significant
redesign of the current RV internals.
Handlers have access to the monitor headers (everything is static/inlined),
kfuncs wouldn't.

Thanks,
Gabriele

[1] -
https://lore.kernel.org/all/96c7ee8abbe9b9b840ca6e112744b5c74f0e9b8f.179174=
5088.git.wen.yang@linux.dev

