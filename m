Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF1F317173
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 03:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783913373; cv=none; b=ai/xLV5aEX112dkL3um4nVwZmkC8nlkW7/bNuMJoxAvgG982bJKAqO+VBugb00EOuQATMpboDqb5teA1i24FxI7hL739DE3ulZFRdY0gVryumVvqgbAQuUaZzIiK+EcxN/zN2VauBmjNQgcIfpFafFMfuzbmZdMp0l5UXA+XJ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783913373; c=relaxed/simple;
	bh=yPcb2yhm4K2GOkEJfjvSUv790XphbvJ6WzOdoBRLa/g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tPs3RpIyptoqLA+5A/mN6f+TDEEwC/2FwY1zSadXItiovpGciAMoMVg31olwOZ60Z0RDMOGFwoinlVkQcgqZHX+eZYxnA4Iy3qfACzbe+XVj31DM2oixqj+q5WpzSmSz4/UAY5eeaKR/yAV1q/HPnXHY/3iiXoMkG8LLT+GxUt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abWHddLW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abWHddLW"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cc6dd436c6so32550245ad.2
        for <bpf@vger.kernel.org>; Sun, 12 Jul 2026 20:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783913370; x=1784518170; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N5LwUqjbpPHissd18BCl9UcC6YRNwOX+ZmfwwTb7nug=;
        b=abWHddLW8gruXrxJtTArQg2G0cJAjmJcTESDjp943KYljubchkU1a9PALBxN50vj69
         N0u6t3ou/ROShlxyary2jM4S1K9/pdHiVenqpRg52bMx8xlOrT81j2nJNKSLUjH2sekN
         BMiYLwwJq4Ux45SMyTzvy//pobtLpND14rQmgfKMZZIQ4Y8c4IcVhyo2JjYsP0DJtMHC
         3lLYqfHAcqtUgSW5XjqGyxGuk6VYXoSyROf7CUduOTo7lt9oUNrQhP4UEkdl7dVnbPrg
         OZPzuMAqMfcoFyV06J4RaHbb/Ne93xqUJ7hEj0q2+YBzZfMC1ZGTJvxyAce7kCfEQ7qP
         aEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783913370; x=1784518170;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N5LwUqjbpPHissd18BCl9UcC6YRNwOX+ZmfwwTb7nug=;
        b=EEoRUGQGd8DypLp8IzM+HDRN9CCjczy6xgA68ytIu9RMz8OSN/pcQpGYuTfZ8I+g/W
         JQy2lTvHkIJ04epV8gnwPCAzaTArzbDBFVrn4T3zWBtC8d8KPJwxwrxl5k70OerBuknU
         ynTxLy91EM3JfaGFZVjTv/6WqqSKwMJ3ds89+EAJX3COfcMcNuH1tBlwbvd+i40YucaP
         NV+IG0lx1H/QmTRIJ6sMSsg3Er6or5AKpjkxmjXJ1GHxdR4w/7u+LZfW122jGxMJAsc5
         Cf8CVVQMc3TcpPATtenANIdyRZr1v12qp83NB6AC6EYS4Cb3t2Wsc0uqzAWux5fT2Npo
         880w==
X-Forwarded-Encrypted: i=1; AHgh+Rr+C1NqrdrlNF1pGOncCi45XxZq+2O1b6o80xu5+Okjj9ShzICfK+8XMllaannPyPMw6Mg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp9e74GCvyOl5F4NLn8rtg3YkBfMqsf2GvqVbpvJbsrjmYQDLS
	DvE0ocDi9rNsxSXe1bE1Io2C/aOWI9+kGw3+PVTBV+AWN6hur8BXB7mq
X-Gm-Gg: AfdE7cn82ybippwWyRh2bSA4DvaXtl0+z3SNysJjGRhX/mv3hB9L7yymT/FNtiA8Udz
	XFelaCKRvtRj5rv14kLb4Gj7V0PK3c/pzDxL40YY4zQHTD3tnF5nu5rGQYW8G6467xo0beJ+8XV
	RXdcdAKONRakJK+7Xbsh/InSJ6bc6QbiV4apjA5kkflwOpOyWZq3i1iFTHYW/3SoLnyA48g+j1u
	zXOS78fkh3P4oXOziF4botSk7bKlfZ/MbHGbu0NGo+2kMmicsbCf4XPv6uDtXF1u0LfoHVzBOQq
	VaFuKStl6lqqvMhGOMDNtCfQjHlfAXbv7vVACoLNX1+qsLVRqBnTN8RvqO8veivOpulLWX/taNI
	ICBZG+20GYf3KKaCvAg1xWYRG+VHP1CEsbRa3Fi1UdaGAG1FyEYjiJAUqmoru+XD4yDEcTx1oFs
	iBCKdnAgsQS6i6bH2g2MpozRAj
X-Received: by 2002:a05:6a21:4d8f:b0:3c0:9c1a:894f with SMTP id adf61e73a8af0-3c110b33403mr8114739637.71.1783913370254;
        Sun, 12 Jul 2026 20:29:30 -0700 (PDT)
Received: from localhost ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b84d6ce15sm26187778c88.5.2026.07.12.20.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 20:29:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 12 Jul 2026 20:29:27 -0700
Message-Id: <DJX4IFO55D9S.3IV3K5XICJAEV@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Shuah
 Khan" <shuah@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Kees
 Cook" <kees@kernel.org>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan
 Kara" <jack@suse.cz>, "Jonathan Corbet" <corbet@lwn.net>, "Jann Horn"
 <jannh@google.com>, "John Ericson" <mail@johnericson.me>,
 <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] binfmt_misc: bpf-backed binary type handlers
From: "Farid Zakaria" <farid.m.zakaria@gmail.com>
To: "Christian Brauner" <brauner@kernel.org>, "Farid Zakaria"
 <farid.m.zakaria@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260711-binfmt-misc-bpf-v2-v2-0-d6591ceaf207@gmail.com>
 <20260712-abluft-brutkasten-aufladen-c8063a4a1a0a@brauner>
In-Reply-To: <20260712-abluft-brutkasten-aufladen-c8063a4a1a0a@brauner>

On Sun Jul 12, 2026 at 5:32 AM PDT, Christian Brauner wrote:
>> This is a continuation of Christian's bpf-backed binfmt_misc POC [1], wh=
ich he offered
>> to hand off to me. I am carrying it forward. The kernel design is his an=
d is
>> unchanged. This series rebases it onto his binfmt_misc locking/cleanup s=
eries [2]
>> and adds selftests (+ fixed from the one's shared), and therefore does
>> not apply to mainline alone.
>>=20
>> As for motivation for this whole change, Christian did a great VL;MR;
>> write-up [1].
>>=20
>> TL;DR: binfmt_misc can match a binary and hand it to a fixed interpreter=
,
>> but it can't match programmatically or compute the interpreter per binar=
y.
>> The Nix community would love to support relocatable binaries, where the
>> correct loader can only be found relative to the binary itself.
>> This adds a 'B' handler type: a binfmt_misc_ops struct_ops program that
>> inspects the binary and picks the interpreter with one new kfunc,
>> bpf_binprm_set_interp().
>>=20
>>   bpftool struct_ops register nix_origin.bpf.o /sys/fs/bpf
>>   echo ':nix-origin:B:nix_origin::::' > /proc/sys/fs/binfmt_misc/registe=
r
>
> Thanks! So I've spent some more time working on this because I had some
> future ideas that I needed to make sure could be accomodated by this
> (currently on vacation but hey...). So the version I have givex this a
> better design and has future extensibility in mind:
>

I also enjoy hacking over my vacation. I'm often told to take break but
some of the best ideas come when on vacation :)

> - The single sleepable load op is split into two ops:
>
>       struct binfmt_misc_ops {
>       	bool (*match)(struct linux_binprm *bprm);
>       	int (*load)(struct linux_binprm *bprm);
>       	char name[BINFMT_MISC_OPS_NAME_MAX];
>       };
>
>   The non-sleepable match program runs from the RCU entry lookup
>   walk itself, exactly like magic and extension matching: same
>   registration order, same first-match-wins semantics, and it can
>   only rely on the prefetched bprm->buf. It must be free of side
>   effects since the walk may be restarted.
>

Is relying on brpm->buf enough?
Right now that's only 256 bytes I think, which is not enough to read
segments we might care about. That worked fine when it was just a magic
number but the idea with the eBPF program is to make decisions based on
more data.

In the selftest I provided, the `PT_INTERP` segment is already at file
offset 0x318 (792). I was imaginging NixOS having to support
`PT_INTERP_NIX` in order for the produced binaries to be backwards
compatible with older kernels.

The other idea would be to make the `match()` broad and select
everything but then nearly all ELF64 binaries would match and then pay
the price to `load()` and ultimately `-ENOEXEC`. Seems like it would
make multiple BPF binfmt programs less useful.


>   The sleepable load program runs once the walk has committed to the
>   entry and does the file reading and the interpreter selection. Both
>   ops are mandatory, the struct_ops plumbing enforces the sleepability
>   of each, and since bpf_binprm_set_interp() is KF_SLEEPABLE a match
>   program cannot select an interpreter by construction.
>
> - A match is a commitment. A failing load program fails the exec instead
>   of falling through to later entries. -ENOEXEC keeps its usual meaning
>   and hands the binary to the remaining binary formats, for a handler
>   that discovers it cannot serve the binary after all.
>
>   This kills the part of v1 I disliked the most: the skip cursor and the
>   leave-and-rescan loop in load_misc_binary() are gone. The walk is
>   never left and re-entered, and 'B' entries need no special semantics
>   against concurrent (un)registration anymore.
>
>   Your v2 changelog note about keeping the bpf retry loop in the
>   __free() style is moot as a consequence. The loop no longer exists.
>
> - The load return convention flipped: 0 now means success after the
>   program called bpf_binprm_set_interp(). Returning 0 without having
>   selected an interpreter or returning a positive value is treated as
>   -ENOEXEC, other negative errnos fail the exec.
>
>   So the "return bpf_binprm_set_interp(...) ?: 1" idiom from the v1-era
>   programs becomes plain "return bpf_binprm_set_interp(...)".
>
> - The handler name moved from the offset field to the interpreter field
>   that field consistently names whoever supplies the interpreter, a path
>   for static entries, a handler for 'B' entries. Offset, magic, and mask
>   must be empty:
>
> 	echo ':nix-origin:B::::nix_origin:' > register
>
> - 'C' is allowed now, v1 rejected it. It behaves exactly as for a static
>    entry. The setuid transition stays gated by vfsuid_has_mapping() in
>    the caller's user namespace. Which makes 'B' handlers usable for a
>    per-binary loader over setuid binaries. 'F' stays rejected as there
>    is no fixed interpreter to pre-open (I have other ideas how we'll do
>    something like it later.).
>
> Nothing changed in the exec patch, the fs kfuncs patch, the kfunc
> itself, or the registry/namespacing model.
>
> I can send v3 in a bit if that's ok.

I don't mind at all you sending v3 and in fact I've been enjoying your
involvement. I didn't know what to expect when I offered this idea up to
the community.=20

I'm happy to keep co-developing this with you within a design you feel
acceptable with. Please let me know how I can remain engaged and
helpful.

One last thing I was thinking about is that we will also need to support
$ORIGIN in the shebang path, however I just tested it and this current broa=
d
BPF solution can largely handle it [1], with a small wrinkle.

  $ printf '#!$ORIGIN/interp\n' > /opt/app/greet
  $ cp ./interp /opt/app/interp     # any interpreter/loader
  $ chmod +x /opt/app/greet /opt/app/interp

  # stock kernel: binfmt_script opens the literal "$ORIGIN/interp"
  $ /opt/app/greet
  bash: /opt/app/greet: $ORIGIN/interp: bad interpreter: No such file or di=
rectory

  # with the handler registered, $ORIGIN resolves to the script's dir
  $ bpftool struct_ops register shebang_origin.bpf.o /sys/fs/bpf
  $ echo ':shebang-origin:B:shebang_origin::::' > /proc/sys/fs/binfmt_misc/=
register
  $ /opt/app/greet
  <runs /opt/app/interp, the loader found next to the script>

The wrinkle is that it can't express today is the single optional argument.
(i.e. `#!interp arg" -> argv[1]=3Darg`). We might ned a way to express
that in the load.

Anywyas, thanks again. All your ideas made sense modulo I'm unsure if
`bprm->buf` is enough to make a decision...

[1] https://gist.github.com/fzakaria/2e1e1c44fa488a951674f8761c672366

