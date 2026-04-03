Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327B33CE4BA
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775233717; cv=pass; b=gGeSgV56Lddzb4LMnJp9lwZvkA8L6CfnFocqQNp6iUYCmSer+ol78sIMeOm20guEiopAJVzJVhw0yJxfnm0XwDfML5Ph3cXTtr2/lTAEWRH7QcHaFRyHZQ+UQfHDAKy4B/VDFhUO46egsB4Cwh8XNZuA+Db6C+aVNw8APu3zgfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775233717; c=relaxed/simple;
	bh=QU5nQFj9zTMuLvpMp7ysPwBJAS+h8cyhyd8jT8E2Q64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rz4qkfbpAqGG3n49a70AoNW4AUZWwF+Ps+vO5KkHPmXLHjTcv8zyaNnXPGN1kkDdWfk6HIUHZVenc1vtfLOEoCOEoG1IWV5GH15EGrlCiqlP8CYyGw28We1qSgvzS1VBf7EcOYin3knAw9ksxC/VHP2ghllIlO5qjxNIAhX17EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ExYWp4nG; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ExYWp4nG"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b936331786dso218448466b.3
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 09:28:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775233710; cv=none;
        d=google.com; s=arc-20240605;
        b=ag0SfAP3M5f1wZollsPpYNAWwHwA4ZiahXW3ZJuLjjqlIyUuLYeTW3jY4N0X+keUgt
         7sKjuXGFTO3GmIjScea3tJvWHZO+U8WI82ySKT1wNpF2TjZPWpmUafIMn52MSqohMqsy
         7UkpBc1QHlOWGEWhOyhWajGe7AkP8Je3ozFGyEp4JjTrtDiwXH8q7zORiDbsFKqqee9Y
         m1PWKvbVR/osmu43BRiwTiO0ZLKAdqUYKXL0DtxSOZJOLpGGHEXj/N/uyoRKL7m2HKgD
         FoMShD1iK+P1AWSPWuHd04laQJj2boiQjE3uATyYLbb2cZEuIMkXWOMO6eW4tZQjKQP5
         PzkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QU5nQFj9zTMuLvpMp7ysPwBJAS+h8cyhyd8jT8E2Q64=;
        fh=NXaaRedzBik92O49rhN7AM/q1HExdXYOSM248Qjvdxs=;
        b=dmBOdiDaXassHUHauVUHjQb75w2gY/HG57GrjGA2xXE8EnMcXYO+bYiTVOlpWECD1b
         CYCa2jTYtV+RgUayw6uj0UMQ/renUGB1G6mMypmJ0OtFWzBG0S50K0xRL6WuC99u5q9M
         fMxoguPswbtQ6ire28Jji5fHwccruleTdblMAcFQFR5ntkEjtmHn9ytldtHslwxCLgkc
         +LTzQCeOdKoNdFJkso6d5+lAm1ILNYFIETtTNUN/HqTUcYQcqET1S8m8dsf+k18lGt+z
         pCnYr3ttIrfeAgzFteDcq4pSeIScJkOuw3ee1B7thPex2s/BRRlgxNtwCfCKQHayzHgs
         wm3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775233710; x=1775838510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QU5nQFj9zTMuLvpMp7ysPwBJAS+h8cyhyd8jT8E2Q64=;
        b=ExYWp4nGM9cQ3l9TK67XwcYGcZLHX9WAISx5F3IlSLTucjgqBu+VFC9zmxXKjJsEsY
         ycWT02+ujpvuc0mz5Amxcu3fuItNSABe4dwnXTsLP5oRDute2hhYrEEe6smDU/QCZ34G
         5rCDXFaUD3DG1ROyBREOpXtya9UkL7Gu0hxQx7ylTg9uLvMWDCBURZFcHsf4kH/HrQUa
         TjnFLD1sDtHixWtho3WeWWAWV2FrOnUgj8AmWz40gyjkBU4Sd44BrgNq0VqdqPMMzbvE
         XYhfHrxUTLeEqObdbjHXUeMOnSBKoztbGb/VAFG+IQ1vVYDr7h3tdjN+tTY/g8ps63gh
         nqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775233710; x=1775838510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QU5nQFj9zTMuLvpMp7ysPwBJAS+h8cyhyd8jT8E2Q64=;
        b=QfRp96AM2WyfYdbwf38T6eqV+QeZVP167aR6a/LRugh7/MYI000rxCCCjGIthUsBGS
         smHAc7yXZwsyMlrUCsxOFMsDyCPNyWuE01SpwfAaRpMdlUx9hikfk4303GsGVS9R4Rq6
         m4w212UUd8H1GSl83MRQRNhPZiMLsHncxL5+aO0XmWov+n39yJbTxfyui57xqwojfncF
         k+vhB5Ok4QXu3YxAIorG86heFYSY8gXA/y5EWnZfMQPOTxcK0Vm1SUhvFUV9EBEtTnp9
         knUx4ew26445PFOKjBJGlLy+TLzf007uJyPoUTDwlBg5JbnkuWOSYupjS2agT4wfZkIy
         sNSg==
X-Forwarded-Encrypted: i=1; AJvYcCVm0My0xhjc6q55rCotvTMrLH4X3dh1HqXMUsjz14vjYYBr/AxymfygEaDqaE83i7HV0u8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6TjbQGzLRGMEXXvvmgH6RXO/rKPES1fEFiSfeJazuhGrCxEdz
	7bWSQbtCjBv8AZxliHNYvhHlJVVX3WTaVPLmppAmIPGjxD5vt7nvA67c+dzUtKhVdePdix7n3s+
	XVDn0VS0gbbaRiOqJTA8VtZ1NbxfGMl/uabqnHN33
X-Gm-Gg: AeBDiet+ca6wEvfw1IrnG2O+WQo0L8V0jfVUE+Cu8GYos1SbumrfpVZ6fiflpJOwHdw
	HP1J9vOKMRwS+op5xRp3EJodLkRBA1PjBASw7/zcEDBXt/gDsWPwAxnOzm6/9uKuOkefnL9f0T5
	3Nn3uqcLo198ahSRSXKyeiZaCk5wwcos/AS9PmK58CgX6sm6E/Jbz9eBir+Q7IVNh3guYzjGmkj
	F1iaJ308krNM8EkMgZ8DoFqMXRzqji5H5LxZRzZjXUfxMUs73bWnrFyjQ7dPNoc0j+lx8yBSl6H
	QXlfg5M9Ad8dQ0Ymrgb+TOrbO3P8RwMFbr9RYktLW4F1P4GNjLVs
X-Received: by 2002:a17:907:984:b0:b98:4f24:a6d with SMTP id
 a640c23a62f3a-b9c672d41acmr191528966b.11.1775233709065; Fri, 03 Apr 2026
 09:28:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331153413.2469218-1-wusamuel@google.com> <2026040136-ocelot-simply-8981@gregkh>
 <CAG2KctokEVVuhrs6tYuMjFF4ALR=tX80iZHrt4bhVvEKyoHzRQ@mail.gmail.com>
 <2026040236-kiln-carat-bb6d@gregkh> <CAG2Kctpr7vBm_=Xz4H5FHYAfFxg=bDt35j6B4EprfUGio=Ftew@mail.gmail.com>
 <2026040357-undefined-gave-c98e@gregkh>
In-Reply-To: <2026040357-undefined-gave-c98e@gregkh>
From: Samuel Wu <wusamuel@google.com>
Date: Fri, 3 Apr 2026 09:28:16 -0700
X-Gm-Features: AQROBzBqCMHYMQgCewV6iBEDIM5gfYH7CX8XlpEk6-JJdgIOB-Bl687I7GX7WKY
Message-ID: <CAG2KctqOLeYm_NFUjGdXQcBo1KhSZpXFQxQdM-DQBV4Mn0ahTw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Support BPF traversal of wakeup sources
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 3:04=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Apr 02, 2026 at 12:37:12PM -0700, Samuel Wu wrote:
> > On Wed, Apr 1, 2026 at 9:06=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Apr 01, 2026 at 12:07:12PM -0700, Samuel Wu wrote:
> > > > On Wed, Apr 1, 2026 at 2:15=E2=80=AFAM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Tue, Mar 31, 2026 at 08:34:09AM -0700, Samuel Wu wrote:

[ ... ]

> > The data is fundamental for debugging and improving power at scale.
> > The original discussion and patch [1] provide more context of the
> > intent. To summarize the history, debugfs was unstable and insecure,
> > leading to the current sysfs implementation. However, sysfs has the
> > constraint of one attribute per node, requiring 10 sysfs accesses per
> > wakeup source.
>
> Ok, as the sysfs api doesn't work your use case anymore, why do we need
> to keep it around at all?
>
> > That said, I completely agree that reading 1500+ sysfs files at once
> > is unreasonable. Perhaps the sysfs approach was manageable at the time
> > of [1], but moving forward we need a more scalable solution. This is
> > the main motivator and makes BPF the sane approach, as it improves
> > traversal in nearly every aspect (e.g. cycles, memory, simplicity,
> > scalability).
>
> I'm all for making this more scalable and work for your systems now, but
> consider if you could drop the sysfs api entirely, would you want this
> to be a different type of api entirely instead of having to plug through
> these using ebpf?

Almost all use cases want all this data at once, so AFAICT BPF offers
the best performance for that. But of course, open to discussion if
there is an alternative API that matches BPF's performance for this
use case.

I'm not opposed to dropping the sysfs approach, and I attempted to do
so in the v1 patch [1]. I'm not sure who else currently uses those
sysfs nodes, but a config flag should remove friction and could be a
stepping stone toward deprecation/removal.

[1]: https://lore.kernel.org/all/20260320160055.4114055-3-wusamuel@google.c=
om/

Thanks!
-- Sam
