Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795625055;
	b=yu7t6Riwh+wPOMWaiZRuj+Y1LytQSpFDWf2O3X+f6iv1nHRNRmP3PdDuazZ5tYzU2dp0
	 9PezfFJ1DTSE8+7S7CweEVXK/wM8QCoNIv/jfRRxuL6Mti1/A6Uk4+Bo9Fgv2RFMlepcy
	 lVipeihr+TP49Yir99qf9NbMMivOKj4Mfl76+7ChGQFXgzKLmvMBnMyiUjMVP4io6HgnO
	 FWfYFI8uA70M/YD5LxXyQ11Lbs38yepY1QfDM68quiwS7aZ3xxTttVQObiELyWwhMxL4D
	 AZ2w5lrr8SwGBYkldfP56rjuvfkzGtw5ED8tdoTdEH9kW0Se5xKn/e8jKUtGQN7FYfA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625055;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=II/aro/lwWCAag041h9klo86GZWrpoxtriGNBQNlDMw=;
	b=KZIhzftOL+Df09xDaH9RQzx598k1mlwW+S7HInbjKeo5Ulpv5VrV0FDk7etNr5e+tcKo
	 V0Rc85Sazrr0UeCeq7SWj8CE/Nt/2h9zvm2RPnBDiFPrC0qrxz+hWjXF52kHnqYmf+wWY
	 Dez0hC2W1OMNSLbO6sDd1Qfg6gepEbQzXAT+iDAqyrcF+Wb5U1FenmibIZuyX69s+vFOK
	 +GYbAtCPxnZ507XuR9RS7o+lxYUBbewgDBKzqf0r6YTuVi0r3nLUXP8C87G8HuC1tnCy4
	 PRZtVI9AuEEZUP1ES9emccDpoYjTN3JpjulZRKFrkYWUw6oIYhEsCfQlVoFF8KrkWzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PKZ23RQe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71388606A329
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 16:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71388606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PKZ23RQe
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4cb6834eaaso127066166b.2
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 08:44:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795625054; cv=none;
        d=google.com; s=arc-20260327;
        b=IwoTTqnF4OVj2r8J4JVpS0MC9rWI9PwX5jrA8hx0OrqxoASnhZJOcN8HT5ScOnPod1
         Em9yGWC0q63kbzrHAsaWnyRz63XAVTIK1aKx5A5HBP45euDRp+O9LoxZVJyYHyjMPvLC
         jj0+8AbAU9/nHEhZWz5CdJfonQWOj63Kyng4XgTolCgKQk6JnBbQzqeDLxO8uAVZoKTN
         KZ2Wv9EkH0Sc5yB7ywbyGZqMW7el7cMuYw5WL9AaLGS9RL9yY32pgU41N8SlKQtL8AN1
         pLMjmP/wKVT0B7wW/FNvNNFk3GFyocj3LxJ0t6bdGALHqNTwazDYpswjt//Oz5mah8SN
         R2YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=II/aro/lwWCAag041h9klo86GZWrpoxtriGNBQNlDMw=;
        fh=MIy7r8XiXHcGuZ9Lu47LUua1/9cgBrTmrSL1hKMbNBg=;
        b=X3h0oyLwglRTTJhmWr7Qx1xqHmCAfqpzr5v4QkcCFuflDQf5dEvUpNTJ4SXrxislAa
         ws7yyLjajC3X+hUFXZXJc2UQbLGCOLWiwc2yT/FV6WP6SUoSb2DGGw4b8eTvv8lvk3On
         YXLfB0lqU4cOunSWo0o+yzNsuf1xWreisTC8ZEO9hEcPO2BKo+00z5wtJ534mmnhdAQ7
         S+0CJLXxA+ToS71n7Vq9fZipSQRCvwQaCvqk5HK6CvWuLBV+9m42l1SXzVFkKSwCACeJ
         fhrxeTfv1X6Y9DvnYa3Oglng1UWo71rBpuTqJR7RiqFqL/OwQ4I1fmf9IYc6xKuyjHai
         X+qQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795625054; x=1796229854; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=II/aro/lwWCAag041h9klo86GZWrpoxtriGNBQNlDMw=;
        b=PKZ23RQeMEttotX4OBPRP2DbbrMEB51nwAQlsHi3Clsl60+KLwydytyVzIwS3CPrsp
         gMCa0qLojqUmZPTj1WgDWb2vfDDzy8I3ouZC6AtzVQzGhYkAtsdS7I194LfKbKzPHVBH
         9FjnQKv/TdlaTy27yqxtS+FRu+TCtlSdjsR4QOyB9tkMnDrs00BEwfTTEGdJNrrE0d1S
         i0G3BgU+8ocwt4ScMKi+JN47+02WlDqK9aHu8g0fQCVcWCnmaTG9N306L0mPKog4H/f4
         BgsXgGhnHP8RFqRdmh8kRVgxVbHO2JS8qa43xqFnpf9P4Z4Esbd1QfxvoHuOMiibIYtV
         4BnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795625054; x=1796229854;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=II/aro/lwWCAag041h9klo86GZWrpoxtriGNBQNlDMw=;
        b=Ix9E9/tDnB0qjbhv3NLrqnhQQM8pho1yZVEhFFe6mg9+UGMY1NRH/9EplSGIzxO6A6
         jGjKAQ+PSwhaTK7Qu44Emt/yQrYRuxsPj3DQ2C4ev/tY/1A3daHwoZZ4WEV6+gt+qR6+
         e4yUu3Qj2ClpsmGQSe1rPXv4OCdUz9fx8uy8ujmXgS5CnuNOl8SvgckFK4kk8M+SpmX+
         LS68mjqr1g5HFkwMJQ3kQ43NKxVIJUu/fFwrpa3Cu+61c73pmkUeMnRd79QpF8YncWS0
         i1kfM0xeDtiiyNVxSeL7bT6fwNISTNL6sqSpD+aKNMi3mFsP5g99a3gAHAOV6b+v9CA3
         RPaw==
X-Forwarded-Encrypted: i=1; AL+hErGjdxUmTHRIAKosajgTFQES7TzMLEuV9KKjoGEVuzkyHKesJJY/XyyFnzNGLT0VUD0cIgY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+z4BVYLGV7bOT18CbsyemLiOK6MT7Xuo4EQFr2TSyXbtIZAHJ5
	c6ZmcCyMhjQRiDl75x2GjVpa7U6mYCWxe1U2Z8WTZNO+bVkY7O8f3R8W9JYgm38D+CEEey6uUfp
	0RJMUWfhJkmZqsjjM5REKw2qwux2t2ZmDNYeY7YC+
X-Gm-Gg: AZFdTZcdmXVLHwP3Ufi+TtqaXOEnatdg1A98nigG/hbsH6hhLMX+fs2WwLrZ0QvbZx9
	AFd4KYjus73g3EBQj706nw8uEfInO3utLmiJBFlT3a64e7l4A0rn2jvsZBGPR6Qv2n3ZIHjAaSU
	ykq6CxY88FAOKSnrW6rkrjVfR9Bbmjo1eOXc29QmQzaHPTmUopYC0tYAWeZNxeHYa288g+QfkHy
	3fRzbRwD50ikNkENKFHguXDq/6NbV7euYCGNpfRNW2z68jEUx6siZMfFeAndqopaMcC/+nItF/a
	3fxLss1DPSB7ih0kLM3QAlyjezTjyco+8lxQEXwtE46wD4ET4ZKl+WX/DpEmtrlBW5HwDHjposm
	a0InDyfyeHGN8U1P+R0R6XtRqW6hmiLfg8aIbBR6P399h3tcFAqv7L8py5slo9O59WJw9ppJtQJ
	fGlMimX3e8SKJVXjk0xf9GHjTXbCBkp+hcmxYcfzXb6tByn/LUKkE=
X-Received: by 2002:a17:907:6d22:b0:c51:40e:847a with SMTP id
 a640c23a62f3a-c513a1e6fdfmr1639688066b.0.1795625053094; Wed, 25 Nov 2026
 08:44:13 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ac22215d-3e58-4aab-851e-47c30836e058@app.fastmail.com>
 <20261027231728.1466446-1-jthoughton@google.com> <32fad21b-5bad-4640-97df-ef0f638cd9e9@app.fastmail.com>
 <CADrL8HX5vb1PGDpWzp-eR0rNfsMCVUhFa9vp_WZZx2eJZ+dfXQ@mail.gmail.com> <1a99e5fc-129e-41e3-8420-101bcf04b366@app.fastmail.com>
In-Reply-To: <1a99e5fc-129e-41e3-8420-101bcf04b366@app.fastmail.com>
From: James Houghton <jthoughton@google.com>
Date: Wed, 25 Nov 2026 11:43:36 -0500
X-Gm-Features: Aa3M54qTCDON0Zo2YJDXp5pBtwrXjTcYjv8NoqDjQS_XV_tl8JrBb-LQVlKEL3Q
Message-ID: <CADrL8HUOZs-vWRyM9p+Na-=arRU+Gx_cWMLbxHmUYnho4fAUXg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/10] uaccess: Refuse and warn on user accesses when
 current->mm is NULL
To: Arnd Bergmann <arnd@arndb.de>
Cc: "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Pavel Begunkov <asml.silence@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	"David Hildenbrand (Red Hat)" <david@kernel.org>, David Sterba <dsterba@suse.com>, io-uring@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Kees Cook <kees@kernel.org>, kvm@vger.kernel.org, 
	"Liam R. Howlett" <liam@infradead.org>, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-perf-users@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Lorenzo Stoakes <ljs@kernel.org>, Chris Mason <mason@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@redhat.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Mike Rapoport <rppt@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 5:02=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Tue, Nov 24, 2026, at 22:10, James Houghton wrote:
> > On Wed, Oct 28, 2026 at 7:14=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
> >> On Wed, Oct 28, 2026, at 00:17, James Houghton wrote:
>
> > So now in v2, the _nofault() helpers themselves do not check current->m=
m.
> >
> > I've uploaded a draft version of v2 here, in case you want to take a lo=
ok:
> >   https://github.com/48ca/linux uaccess-v2-wip
>
> I read through this now and it all looks good to me so far.

Wow you looked at that really quickly, thank you so much!

> >> Since in principle every user access should go through both
> >> access_ok/mask_user_address and current->mm check at some point,
> >> so combining the two as much as possible should help long-term
> >> maintainability.
> >
> > You're right, and v2 has been restructured like this.
> >
> > - The check is in access_ok() itself: the generic version, plus the
> > arm64 and riscv versions. __access_ok() remains a plain range check.
> > - The callers of mask_user_address()/masked_user_*_access_begin()
> > check current->mm explicitly. There are about a dozen such callers.
> > - The unchecked accessors, __copy_{from,to}_user()
> > and__copy_{from,to}_user_inatomic() (and arm64's
> > copy_from_user_flushcache(), which also relies on an earlier
> > access_ok()), keep an explicit check for now. Once their users are
> > converted to the checked versions, those checks can be dropped.
>
> Ok, sounds all good. If we get more than handful of mask_user_address()
> and masked_user_*_access_begin(), we can always revisit that interface
> to make sure the check can't be skipped, but for now this seems
> like a good tradeoff.

Great!

> > Compared to v1, this also covers get_user()/put_user()/clear_user() on
> > arm64, powerpc, riscv and the asm-generic architectures, and arch code
> > like signal frame setup that uses access_ok() followed by __put_user()
> > or unsafe_*(). user_access_begin() no longer needs its own check.
> >
> > What's still not covered: x86's get_user()/put_user(), which do their
> > own range check in asm, a few architecture-specific paths that call
> > __access_ok() directly (e.g. on alpha and sparc32), and arch code that
> > calls __get_user()/__put_user() without access_ok(), mostly trap
> > handlers for user-mode faults. Probably best tackled later.
>
> ok
>
> >> There are probably few enough of these that we could address them
> >> by either adding current->mm checks or converting them to use
> >> the full versions instead where that is an obvious change like
> >> that usb gadget driver.
> >
> > Sounds good. I'll send a separate series converting the obvious ones,
> > starting with the usb gadget driver. I think that will be useful.
> > Let's see how far I can get; hopefully I can drop
> > __copy_{from,to}_user() completely.
>
> Ok, perfect!

Thanks, Arnd! FWIW, there have been no syzkaller issues so far with
this WIP v2. :)
