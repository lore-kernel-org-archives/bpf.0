Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792651607;
	b=Qqig49pDGq4tuq6YppP+zq5Yy4Hwsq63T83Q8r91X2eORiv7NNrWFa30TLxNZ3/T1OsG
	 M4m+g22fsB5rUr+jvANqpw0I867758P+n1gNDuJmXc/bHX9pQIshPhLJHUFW+CayLnKmU
	 T0mge/ZN2CeHubNCAaFQCb+aHZ3krCT2GU83/zqfdPZpG4fZs1XUhpTChipXtQ5tjn/1A
	 fwFyCWKC9VHew5bd1RWY/bntdqvIYkGtmf1m/FoxmlFEgPtC9BSzuvxH3eczoyWY2Fa/P
	 wyiOEC3tRWKejs6hqGbHfpDidIBEZDdEI9BT/HLtDzSkQWoAC+/7NK6EcWlVDZPB+TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792651607;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=TKtpG0ZG3GV7aCNX13qQJC+OLUZxo8z1O02EgwHPjyE=;
	b=bKIWqco1OiU5grV9L1eMacrScxkudJJYC5u6rJXC9RBjJ0jnu2nagvefwDfKgD8VeYCh
	 OpvSSw9p8s203bTgsaBRF1Q6uA68A40U8t72ZLokVg9hqcz6ovtMfLK7FM9yyzbGenrf3
	 7q9TF0LQ6eeDVc87DtXwjyz6t1rPVtXpfp7g5uo+EizZI5KroWOapqdFJM6WIWTWFYqg/
	 Ug1ErFvBrhYU9DIqBYvVeXDOsyLOeUuxud6trLnhi5E8dRhNyWIgONnTEkLcIham6OZZn
	 kodmO+K2T5LLFul6nVoHOa6PNrp6rMVLenp6jYgT+fhJiGtClFnAMgQb9jPiGPvwxnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fMI5v+Bn;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Y3BfEey6;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8B7606A32F
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 06:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C8B7606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fMI5v+Bn;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Y3BfEey6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792651606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TKtpG0ZG3GV7aCNX13qQJC+OLUZxo8z1O02EgwHPjyE=;
	b=fMI5v+Bn9trqXkvWKIV78QHC9NDmRLqsK+4DvqyZM58VfIskk3jHLoGtCu2fejjfDb5z/g
	8ZwBeMvpSgM2obqHNUiGPrK8/vPRJZSx+WXtY40Q7nTzeSNsTGNUgUIvVCbNJVSlg5brhN
	eLYHeB9Qy8j7AHaP4YtPX4GDyeJre94=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-FuCyqg7QPF-pl2VoixFW4A-1; Thu, 22 Oct 2026 02:46:44 -0400
X-MC-Unique: FuCyqg7QPF-pl2VoixFW4A-1
X-Mimecast-MFC-AGG-ID: FuCyqg7QPF-pl2VoixFW4A_1792651603
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48df02b91f9so305414f8f.1
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 23:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792651603; x=1793256403; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TKtpG0ZG3GV7aCNX13qQJC+OLUZxo8z1O02EgwHPjyE=;
        b=Y3BfEey6N8msn+41QVUavFWYnbJoP4nREg7/9BXIXfXA+yFBO7Kc8oWI8t0tOiAUSc
         DUKHMPiA0TK1mm3k6Z5rWF3HWbMoszgyVz3zJL8f8fMdnxG/yvi6nIdiEBpJx+oxbyYa
         e5/qoazr8OrWoiXBh4kcsrAH4123p2AHgWGd7hGDymRp/b9gsnCYRJ187wCqAlja6PRJ
         SAl53I6dLPNgkPqj4ezSRVwj3UZBjPMFAdl6GXR20iPa/elcrj+F1cAZgnO9HlSBVJaT
         gn1a8HEnCwZPnCq9dDhwhUhap9xs15HdKipE4O5GmUdTKhPpEDeyYX2kcMSCsYtqj7c1
         REDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792651603; x=1793256403;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TKtpG0ZG3GV7aCNX13qQJC+OLUZxo8z1O02EgwHPjyE=;
        b=dLWlfqxi6Qc+WoKroKIvdlbMEDcCbonr6iu8E/cOtTluigYsAcySdU0tNr18TdWh63
         m2Ni7NoOKHui/6mh+N+ITiCoD5SdpCgSo/r4/cNqyD0urQnIviFajWC+5CcCWUZuKLLx
         xiZRz4oVrsRPpaNemiGJHgL7CZWl4kbGAcgdWw1Ncs/CdkIvJpGUjHJEI/2MLkX0VJbi
         Q/Yi8jLVKReyE/YtuGUldalwe7oKaYTXVz5Y5rJ5K7ckQCe1Fi7QtMwbJ8ZT6iJQ9UdB
         99whSK9BvqQgVroLi8WFCgoTzSVmNDVGgyM6OqRmv7wC8xaL2BFP+xiW7B0GdfXPjUpi
         SiDA==
X-Forwarded-Encrypted: i=1; AKwUvBwdBtz6zLfubZWsnzBRcI80ClcfpRnfZa5lpjZwcOv4MWoa0A3mqhUsprxtoahtfwTGpAU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIlc4FsvCbMgNPbJNItHJ39ZzeIGxDlBiA50x1P/CyAEuTuLmpU
	NSxUm7138J+GHVVbbX6Jw227Mm7j3uxusvz67tWLOY7ns4q3MgbrocA8Kb3GaQxqrYRV3JvSvQd
	swDGDIJbjHEovqWnNfkIA7lTFzJ979boMNH3AXRxi0Yiuz48zFGrGmQ==
X-Gm-Gg: AYBFou2M44PC8QR4Ll1LYB5Jqq0sNkQT9xpP1cQT4zcaRTbx8FMSIjpCh8uiG6xy0jN
	lmIdHW5FwSZt/jpBfi6x8XYYMPmYMxx9/y0p6/rZaTn+182dDCgLmhxCu8CH3QR9EUFRdYQrq4j
	q2GbHmsRsiyF0rnItX0hCzWDdsVtfT6VREWr3wIzTwsXvQuMSmCsVO8VsYPN1eDXNUj0WKW2pZo
	i+oDpNjd/BlA/30abXZm1Hn1fM5ELJNJ40PWPwEIKrPEXgntwufLp6oXtHg+mqM+VGBKn3KKp62
	Vpc/mmjDsLwYHEybmys/7Xg37aZma5XXpW7bVJZhs2XRAXy6O3uDLRngEWBZMxGZZI20GFdPf5z
	Gy/05URXBxk32N0ZtwyO+i4wwqyjr
X-Received: by 2002:a05:6000:4b11:b0:48c:54ec:ea3 with SMTP id ffacd0b85a97d-48e2d24e4acmr3010775f8f.13.1792651603092;
        Wed, 21 Oct 2026 23:46:43 -0700 (PDT)
X-Received: by 2002:a05:6000:4b11:b0:48c:54ec:ea3 with SMTP id ffacd0b85a97d-48e2d24e4acmr3010732f8f.13.1792651602647;
        Wed, 21 Oct 2026 23:46:42 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.133.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25840115sm10061810f8f.48.2026.10.21.23.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 23:46:42 -0700 (PDT)
Message-ID: <f147fa9dfc553767ce92802b66723a85cf804e46.camel@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: John Ogness <john.ogness@linutronix.de>, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>, 
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Wen Yang <wen.yang@linux.dev>, Tobias Schaffner	
 <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Date: Thu, 22 Oct 2026 08:46:40 +0200
In-Reply-To: <87h5ifvw3p.fsf@jogness.linutronix.de>
References: <20261001152042.124445-1-gmonaco@redhat.com>
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
	 <87pkx5q1w4.fsf@jogness.linutronix.de>
	 <0d4f11b1999588ddba9d855db43fc492eda32de1.camel@redhat.com>
	 <87h5ifqy6w.fsf@yellow.woof>
	 <a8d8b080f403eed617242a3276717706b4081ed1.camel@redhat.com>
	 <20261021094853.29b9f7be@gandalf.local.home>
	 <fb5c20f226f723cbb4df5092462dfcf5f2686367.camel@redhat.com>
	 <87h5ifvw3p.fsf@jogness.linutronix.de>
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

On Wed, 2026-10-21 at 18:53 +0206, John Ogness wrote:
> On 2026-10-21, Gabriele Monaco <gmonaco@redhat.com> wrote:
> > > BTW, I'm curious if it isn't possible to keep both in-kernel and BPF
> > > monitors? That is, for those cases that do not change often and has a
> > > well known model, to simply keep those as modules and hard coded.
> >=20
> > In my opinion it is possible and I'm designing every change with that
> > coexistence in mind.
> >=20
> > I would say we could only drop in-kernel if BPF does such a great job
> > to cover every single technical and non-technical requirement or
> > use-case, AND if it makes maintaining the whole thing easier.
>=20
> I am wondering if coexistence should be the goal. For example, the
> monitor classes (DA, LTL, HTA) are only implemented in the kernel and
> provide kfuncs for the state transition functions to be available to BPF
> monitors. I would expect that this would allow BPF monitors to have the
> full functionality as in-kernel monitors, since the events, errors, and
> reactors would all trigger from the monitor class code.

Well, this would be yet another hybrid requiring BPF monitors registration =
in
the kernel like I proposed in the RFC [1], which was the main point of
contention (that fully shared reactors and sysfs interface, by the way).

For this I would argue, though, that such monitors would be BPF just on pap=
er,
we wouldn't be able to use many advantages BPF provides (e.g. BPF maps).

The current implementation already shares the header with in-kernel monitor=
s, so
the actual logic is shared. What isn't shared is the storage type and some =
glue
around it.
I used BPF maps because they offer some nice flexibility especially around =
per-
task and per-obj monitors. On top of using more battle tested code.
I would like to keep that.

Besides, we'd need to be extra careful on controlling the callers. Right no=
w
handlers are static, so it's easier to make sure no rogue caller messes up =
with
monitoring.

What else definitely isn't shared, which is the main point of this whole
conversation, is trace events.
Those could be kfuncs. And no matter what you do, BPF monitors will need to
share the trace events (unlike in-kernel that have separate events per moni=
tor).

In short, I don't think this would be easy to achieve and wouldn't earn us =
that
much. (Plus I'd lose the hardly earned Alexei's blessing ;) )

What do you think?

Gabriele

[1] - https://lore.kernel.org/lkml/20260831090524.106845-1-gmonaco@redhat.c=
om

