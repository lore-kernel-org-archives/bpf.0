Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD08440A0A
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 21:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790199264; cv=none; b=gAppvVk3vKTchceh9qC82YDm/ngAagNKCW1HnkoMvL8Cu6FqlvTzmDKqNh1d9PEfbdd8zN7WsixBpN+e96Duawl7E6MbxkqZne/NGoV2q35KbNc7jPNZir6whFee0f+CGQp5mKL48qeOAyjtmnTfHKyS9gKsJs2iZP1Kgt58+sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790199264; c=relaxed/simple;
	bh=hCjA6hT150Fr5EXgey98L1Rmb0ZSdrHBHTyvU2FmCzM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YCKrEX6th4JPzXrxSPn+HmdI7Umhnh/XCf1b8e1Jr9YGLCI0mF6q/FP9yhA9mALc1a1VyQZjj109gsaBJD0AUYs3ZNL3vvwqqn81m1X4gu3fPI3GtrZogA1EO02Ee8vPd3lH8yd301tT7gC2IlgymAvdbAb4LWci0g2aisj460Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsbRAUZW; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsbRAUZW"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc50bcf87b2so729409a12.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 14:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790199262; x=1790804062; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TKfea148yvi254UpE9LgHTWcQAwc7ZQjf5xowxiJDkA=;
        b=TsbRAUZWG0nJv+E1Rf09itTw8k13pw+IN+oveK6yzDfWme9Bt0k15wgWPMBN45l+Gr
         N+mY5EA5kFznr8/L14ji7REQNnwKfiKg1Z8UGE5js7njXormaNk8jXBO0TfrvWfVFRLI
         /UP1q65FVvFkNKyA+bliV5SiVGwa9oDTfI3i83a/BrleQqr65vDUvPgCvqAnHjfmBuoW
         OgyT8zSEHh2JRgYREGJO1hm1TcyBQSyvyz6sK5/WKVGhWYprXh881RKAF1eiewO2X9UO
         xk2Nc0uLmzGc6wR/f4bViyn6LcVI1m4uFXsGwe/a3yrJ2NqpbMwTYsQPuzdu2Ful/7r5
         SWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790199262; x=1790804062;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TKfea148yvi254UpE9LgHTWcQAwc7ZQjf5xowxiJDkA=;
        b=XoFGSVkOXack4ZOCNB5Ed8fKo/+m5lnUZXRV6gqkc3bY6IoMiD/DF2PeqgFdObGTQx
         fdf4yvQ+AL/A8ge2/DkuWGUSjXxHRhgt0/75P4f5B5t4CUOPbI0nuLpnoacjz3Y1iGKw
         DbuIKaIXLSU4Y0OzAxjBfP6ULm1qZ+/pULGhK6sustYoZKtWAoH4v2sooXo9I3owVi3O
         M2qPs8RktVqL+pQq8yQk9i+/wjmYx+jcP2LYhBT0CX4FKRmQ4G5keb6+Mjv5X74W2rWN
         2nckZv798ZDDf0q/CHB52bxat4kikzvehxz0bCuG3D9HgREyVX0ykDfWkcQONnUW9KMY
         rgxg==
X-Forwarded-Encrypted: i=1; AKwUvBx581enKz71DMWllXaeiSEkXAgQDUhgvUSHOUePvK5FTBNuEE/9vLkNU9vZV5RCtxk2PZs=@vger.kernel.org
X-Gm-Message-State: AFuF++l7X51YrSFWFtkxzJF9+k9qKvXJQ/F5S7+Wi5tMYPIx6Cd59rqm
	5pXLplkyXRAkPnkJM/Lew3NlawFwal9zXLcO1nbDW2j3KcTIlwh8ADm6
X-Gm-Gg: AYBFou3F6aKPI4Fj/7xZ41iv+KWcZiY0l10bCiq6ke0wICmNIIoZsei/S6mmYUnMM8j
	W7U8NdSiDWhdtHdxA5NX8xcslFn0sqdfWIhxckzrwgeLsADGEAQ+Mu8JftjOCWuxQcG05Yv8bqD
	Wju8cskJ81M//SBjP60F/H9JIbBaWkn9GEB/1O101WGxc6vZSNYh+5/9IH67FUIkCDWIxTHrIQe
	vQiNazP+1YclqVz8X/70GLwoO7aCIi7cnUDlEtiyDfk2y8d0C4NBg9dBuItQK1Jxl2+aBbqrH/P
	LetM6/KkE8O7/pqWBgEVlg9gv3EDcNItD1KyWj1Hma99QLXPKj27XQzg7C/SeBlLa16Rfv9kLEE
	7dyXeXxyNf/tqOwgsvRUwPhFO/DS2bxzRhzQzjJmyr7QO32zHIKoCjgT18Z6HPF3sRlq+1gdyBe
	jQV5OJ0O7lXtXCr2dWpoo7cM8/QLjICEu+8ek6MX8STTgJsS07vQT6EEFdy7qJQU/01oQPYyI4F
	/gbc9ITD++Ig7gvYvqkUoyCVe5DVcfD2golxTrdHcAqsCvAn8/cxZIugsNilSj9JBQCWIMVxaXT
	Dr18
X-Received: by 2002:a17:903:1b28:b0:2dd:89b1:7fdb with SMTP id d9443c01a7336-2df7dc02b1bmr3807795ad.9.1790199261982;
        Wed, 23 Sep 2026 14:34:21 -0700 (PDT)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5f965esm16427995ad.75.2026.09.23.14.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 14:34:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 21:34:21 +0000
Message-Id: <DLN0OB4STWN9.1101L0OPX69QV@gmail.com>
Cc: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v4 00/20] bpf: Run exception cleanup landing
 pads when bpf_throw() unwinds
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Andrii Nakryiko"
 <andrii.nakryiko@gmail.com>, "Eduard Zingerman" <eddyz87@gmail.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
 <7e7076ce94e803403bcee003569d4b2ac7bc4e2c.camel@gmail.com>
 <DLLHFJDS6G5L.2B273FIKF9A09@gmail.com>
 <7eba4eb055e15d5c78f463d013fa98bb21d7b494.camel@gmail.com>
 <DLM6BVU1G0V3.29T5BPPZTZ77Z@gmail.com>
 <37e53199dfda608de30a31fc51d22ed2b25d6d2e.camel@gmail.com>
 <DLM8NP9S8A4E.1YIS9HRMSR62@gmail.com>
 <a9c4ebe0c1a08d7025179b1ec2297a4d975cd072.camel@gmail.com>
 <b3a29c0b77ada6a7eff101a5d8b4e83021a3052e.camel@gmail.com>
 <CAEf4BzaStrSG-hGERB8J=mt3agEq7d9L8+L9rsr4Z+=68gtA-w@mail.gmail.com>
 <DLMY4E5MYGQI.29MKOKECHM134@gmail.com>
In-Reply-To: <DLMY4E5MYGQI.29MKOKECHM134@gmail.com>

On Wed Sep 23, 2026 at 7:34 PM UTC, Kumar Kartikeya Dwivedi wrote:
> On Wed Sep 23, 2026 at 9:24 PM CEST, Andrii Nakryiko wrote:
>> On Wed, Sep 23, 2026 at 12:04=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
>>>
>>> On Tue, 2026-09-22 at 17:04 -0700, Eduard Zingerman wrote:
>>> > On Tue, 2026-09-22 at 23:37 +0000, Alexei Starovoitov wrote:
>>> > > On Tue Sep 22, 2026 at 11:08 PM UTC, Eduard Zingerman wrote:
>>> > > > On Tue, 2026-09-22 at 21:47 +0000, Alexei Starovoitov wrote:
>>> > > > > On Tue Sep 22, 2026 at 4:27 AM UTC, Eduard Zingerman wrote:
>>> > > > > >
>>> > > > > > Total size of executable sections for all Meta BPF object fil=
es used
>>> > > > > > for CI veristat testing is 10Mb. Of these there are 30K non-h=
elper
>>> > > > > > call instructions in total.
>>> > > > > > So we are talking about increase by 8 * 30K =3D 240K ~ 2.4% w=
orst case.
>>> > > > > > Note that the instruction encoding optimized for size already=
 hearts
>>> > > > > > us in src/dst registers department: we have no room for virtu=
al
>>> > > > > > registers, which would have simplified e.g. register allocati=
on task
>>> > > > > > for ARM64. Point being that optimizing intermediate IR for si=
ze is not
>>> > > > > > always a right target.
>>> > > > >
>>> > > > > I wasn't talking about increase in bpf ELF size,
>>> > > > > but the amount of the verifier work necessary to double the num=
ber
>>> > > > > of call insns.
>>> > > >
>>> > > > I don't understand what you mean by the amount of the verifier wo=
rk.
>>> > > > Traced program paths would remain the same, only the encoding of =
the
>>> > > > information about exceptions changes.
>>> > >
>>> > > Any new insn requires plumbing through out.
>>> > > imo ld_imm64 encoding FD inline was a mistake.
>>> > > We should have went with relocations through out.
>>> > > Much cleaner to extend.
>>> > > Same philosophy here. Landing pad is a metadata.
>>> > > It's not a good idea to encode metadata into assembly instruction.
>>> > > bpf ISA is not a high level IR.
>>> >
>>> > Here [1] is Yonghong's series repackaged by codex with the following
>>> > encoding:
>>> >
>>> >   call <subprog-or-kfunc> // regular encoding
>>> >   unwind <label>          // a new instruction that must follow the c=
all instruction
>>> >
>>> > The amount of the verifier/libbpf code dropped from ~2K to 1K lines.
>>> >
>>> > [1] https://github.com/eddyz87/bpf/tree/unwind-postfix
>>>
>>> I want to highlight this once more, before it gets buried.
>>>
>>> Whether landing pad is metadata or not is a matter of opinion,
>>> seeing the program CFG from it's source w/o a need to consult
>>> additional tables is definitely a plus.
>>> Same with ld_imm64, and yes it adds a few checks in the verifier,
>>> but those checks are trivial.
>>>
>>> I looked a bit at what other VMs/IRs do and it's a mix:
>>> - JVM has exception tables similar to ours (begin, end, landing-pad).
>>> - GCC (gimple and rtl) have landing pad address attached to an
>>>   instruction / control flow graph node.
>>> - LLVM has invoke instruction that takes three parameters:
>>>   what to call, where to jump on success, where to jump to unwind.
>>>
>>> With that in mind, I think that the rational thing to do is to choose
>>> based on the implementation complexity. Compared to v5 [2] of this
>>> series the branch [1] allows to forgo:
>>> - UAPI to copy the cleanup table from user space (patch #2)
>
> We will still have UAPI, in form of new instruction, so this is less sali=
ent.
>
>>> - insn_aux_data changes for cleanup_pad address (patch #4)
>>> - simplifies check_cfg() handling (patch #5)
>>> - simplifies main verification pass (patch #9):
>>>   - throw raises unwinding flag
>>>   - varifier interprets `unwind` as any other instruction,
>>>         jump if unwinding, fallthrough during normal operation.
>>> - dramatically simplifies libbpf part, dropping patches #16,17,18:
>>>   - no need to collect cleanup tables from elf
>>>   - no need to relocate these tables
>>>   - no need to pass them to the syscall
>>>
>
> All of these do make sense.

Sorry, all I hear is a knee jerk reaction to a lot of slop.
yes. a lot of it is not needed, but invoke approach is no go.
As I said couple time [ip_start, ip_end] is not a single call insn.
libbpf patches do a bunch of unnecessary copy paste,
but that's because we didn't do insn_array support cleanly.
From libbpf pov bpf_cleanup section shouldn't be any different as
"one more section with pointers to instructions".

Sorry, we're not doing new 16-byte insn. We can chat about it
during the meeting, but I feel it will be a waste of time.
New insn doesn't reduce amount of slop.
Ed's example 1k vs 2k is a counter example.
This is just one llm vs another. Both sucked and both slop.
Just different amount of it.

