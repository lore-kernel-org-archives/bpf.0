Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E4756C626
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790192065; cv=none; b=T65O/NOgfNXIZvPAj6FMNBcHnRFCt1ua6rBFdPsr5lw6uLLlc4ouTjzssdxWqC/vAuUglQtEkZBS6hPO2NkDTsXcwjB+AOpyIKzRgSW6nFnqx4/QcKkbas5OvvNWvxnR1ujORx4Dp0WAUTsdUDbsq1PQ706PjJs0X9ZL4msKaWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790192065; c=relaxed/simple;
	bh=VP1ajhggTUN5U0pxlyZxwR9gC6vuJs/L6GUxnqBw07k=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=VMcnLrJvBVeNwXtGDhjSP/KQU1o0Cwt7zaahRZFQ62OTlBbqHFUtC3EGss6iwpywURZi/W/YQMZWkPSvelssGMuk3YHnR2x6J3lsUr6fZVHox0GnfH6I3LzwozY29X3QbgriIl6WmdZ1NjZ6T0sD1i4/CvtPEKxmP6iyXZGXT5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chisfprT; arc=none smtp.client-ip=74.125.225.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chisfprT"
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-49e667e3c45so2334195e9.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 12:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790192059; x=1790796859; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oVaSV1VptcSc0vEwB+5Z9hjRp8TRzEMmoCQsJSvhNBU=;
        b=chisfprTTerrc4WJ1hq+D5M8F0Rl3tGxQv/E4pc8tEISJ3/2z3stQstntmBrXTD6oW
         1WdVBXReUltCnqkL6bU4angihFJZiHhKL+ByD+5mjuWkvB4K8lTE2Gwz0Rqrisyx//md
         tUKpQZ+0dykMsDsMlKigw7RN8eRGtOR/VHsyyUJMe4m6oRxb91sx9TncaKGV9a1oFFNw
         0yA88eT5LhwBE0DWM6V7bhPL8U7DdBD44OP3E1hSgWmFa3zZIsBpzPyghKmi5uJ/UW77
         UlFiWFRQvAJQ4zoRBIDSxzisiCmGAn3RnM4FXZvlAS10IQF6w9DNV24n8NdAisGGcSst
         xzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790192059; x=1790796859;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oVaSV1VptcSc0vEwB+5Z9hjRp8TRzEMmoCQsJSvhNBU=;
        b=j1UP6cATaI6Wt7JCAcKPC0IMqS0tBx9htiKAntRvolDVV9biKBc7T0AHpuqAl4EUwu
         YoSNHDG9JU+muKf5g7flndb0ggubLZdT6jcfn7BHtYL547UcLQ+BJ1hJjflcinxIm3tB
         ry+3OHzpyqfbpgyL4dqpof9PUWOooGPkwQUKX8Oip3vhrlo6/imMpDCOWhndJ7eaBdqO
         GvM7FdYmmFu31kygtPaWNpeZxdVkdMWnrMtiOjxxTSZwdBXHuRppBsC9NSIcIReltvPJ
         o9Wexpd7RpzDZTC23gyh9FdZt3gEtbSwwco+bx/m/2dT6SgUvrEkUnAKKbN9VdF1xcI0
         yAEA==
X-Forwarded-Encrypted: i=1; AKwUvBw+P/UGwwzvv7WvyKRCZmcZWctFUxubHd/8Z8dZ3XnsTUCj59EI+D+a0eLneHXdKNk1Yec=@vger.kernel.org
X-Gm-Message-State: AFuF++lYewYy53zufeFEsk//jhSyWqwa0yPT/8hzB+kcHqtEcaZJLWxl
	qL7nouQeXQWMdkbCzBjiqxrQOO6ZkIrSLhG05a4I6Jc5iSvJUVtCQO2U
X-Gm-Gg: AYBFou2rGkS9H6Gn4o+Rv+tGLG72SFC9hGV1RSa9jDaRr5tseYQ0+SykQPqy1TIxBpT
	i7O2NOeE8ltw24zy2F1BWjNTc/vpQLyn4OatMzWUoOfGEeu1WAFZOnN3nvpLAup6/feN6l7bV9E
	2N03I3ScfuFjUhXI8C4GLKhSjiKwDEXYJVQU8I9avfFIoanlnowBkYBsYLyYq1vwJk+8mu6sntX
	a+4fmxVOuy6iVyy0GbwOwg3rLzdOOuhd6dVqeURoQkkkJ8K3//Up8/ieWD8B5YXMWOO3QgrRdGZ
	NpdNkw+PCQztGHHTkup/sfka09FZonUCPdzAGNcwgyO4ulniA3MC0CHqBBnHlVqejfeLFC6mNld
	wZy0Knn+GRs6pyhzAnP1eTZNZL6n+EOSK5/jHl6WmujjAog3dVPX+OJfE6fx3IMtWvxrR6LgKsP
	2VTACWH6ghY0FuUTJ+1W25hBZuLExTmM8HM6JNwZfVjGaiUE7ZzTnvD9iPHJCxr8snfStdwjFrP
	WtREBOzfLRMqpXLt6C6UECqC+gLvSG83JC1ay6pH+zgV9KyuamGTKt95cuNsaqkKuBjOaW40qDv
	jpUXzTEWQAlyGncQCUeFR//aUk/3IoYE+MipGOzMqji+Pm18
X-Received: by 2002:a05:600c:138f:b0:49f:cbf3:551c with SMTP id 5b1f17b1804b1-49fe66cc5camr3557395e9.12.1790192059160;
        Wed, 23 Sep 2026 12:34:19 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48868889926sm12302321f8f.36.2026.09.23.12.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 12:34:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 21:34:18 +0200
Message-Id: <DLMY4E5MYGQI.29MKOKECHM134@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>, "Eduard Zingerman"
 <eddyz87@gmail.com>
Cc: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Yonghong Song"
 <yonghong.song@linux.dev>, <bpf@vger.kernel.org>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v4 00/20] bpf: Run exception cleanup landing
 pads when bpf_throw() unwinds
X-Mailer: aerc 0.21.0
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
In-Reply-To: <CAEf4BzaStrSG-hGERB8J=mt3agEq7d9L8+L9rsr4Z+=68gtA-w@mail.gmail.com>

On Wed Sep 23, 2026 at 9:24 PM CEST, Andrii Nakryiko wrote:
> On Wed, Sep 23, 2026 at 12:04=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
>>
>> On Tue, 2026-09-22 at 17:04 -0700, Eduard Zingerman wrote:
>> > On Tue, 2026-09-22 at 23:37 +0000, Alexei Starovoitov wrote:
>> > > On Tue Sep 22, 2026 at 11:08 PM UTC, Eduard Zingerman wrote:
>> > > > On Tue, 2026-09-22 at 21:47 +0000, Alexei Starovoitov wrote:
>> > > > > On Tue Sep 22, 2026 at 4:27 AM UTC, Eduard Zingerman wrote:
>> > > > > >
>> > > > > > Total size of executable sections for all Meta BPF object file=
s used
>> > > > > > for CI veristat testing is 10Mb. Of these there are 30K non-he=
lper
>> > > > > > call instructions in total.
>> > > > > > So we are talking about increase by 8 * 30K =3D 240K ~ 2.4% wo=
rst case.
>> > > > > > Note that the instruction encoding optimized for size already =
hearts
>> > > > > > us in src/dst registers department: we have no room for virtua=
l
>> > > > > > registers, which would have simplified e.g. register allocatio=
n task
>> > > > > > for ARM64. Point being that optimizing intermediate IR for siz=
e is not
>> > > > > > always a right target.
>> > > > >
>> > > > > I wasn't talking about increase in bpf ELF size,
>> > > > > but the amount of the verifier work necessary to double the numb=
er
>> > > > > of call insns.
>> > > >
>> > > > I don't understand what you mean by the amount of the verifier wor=
k.
>> > > > Traced program paths would remain the same, only the encoding of t=
he
>> > > > information about exceptions changes.
>> > >
>> > > Any new insn requires plumbing through out.
>> > > imo ld_imm64 encoding FD inline was a mistake.
>> > > We should have went with relocations through out.
>> > > Much cleaner to extend.
>> > > Same philosophy here. Landing pad is a metadata.
>> > > It's not a good idea to encode metadata into assembly instruction.
>> > > bpf ISA is not a high level IR.
>> >
>> > Here [1] is Yonghong's series repackaged by codex with the following
>> > encoding:
>> >
>> >   call <subprog-or-kfunc> // regular encoding
>> >   unwind <label>          // a new instruction that must follow the ca=
ll instruction
>> >
>> > The amount of the verifier/libbpf code dropped from ~2K to 1K lines.
>> >
>> > [1] https://github.com/eddyz87/bpf/tree/unwind-postfix
>>
>> I want to highlight this once more, before it gets buried.
>>
>> Whether landing pad is metadata or not is a matter of opinion,
>> seeing the program CFG from it's source w/o a need to consult
>> additional tables is definitely a plus.
>> Same with ld_imm64, and yes it adds a few checks in the verifier,
>> but those checks are trivial.
>>
>> I looked a bit at what other VMs/IRs do and it's a mix:
>> - JVM has exception tables similar to ours (begin, end, landing-pad).
>> - GCC (gimple and rtl) have landing pad address attached to an
>>   instruction / control flow graph node.
>> - LLVM has invoke instruction that takes three parameters:
>>   what to call, where to jump on success, where to jump to unwind.
>>
>> With that in mind, I think that the rational thing to do is to choose
>> based on the implementation complexity. Compared to v5 [2] of this
>> series the branch [1] allows to forgo:
>> - UAPI to copy the cleanup table from user space (patch #2)

We will still have UAPI, in form of new instruction, so this is less salien=
t.

>> - insn_aux_data changes for cleanup_pad address (patch #4)
>> - simplifies check_cfg() handling (patch #5)
>> - simplifies main verification pass (patch #9):
>>   - throw raises unwinding flag
>>   - varifier interprets `unwind` as any other instruction,
>>         jump if unwinding, fallthrough during normal operation.
>> - dramatically simplifies libbpf part, dropping patches #16,17,18:
>>   - no need to collect cleanup tables from elf
>>   - no need to relocate these tables
>>   - no need to pass them to the syscall
>>

All of these do make sense.

>
> All of the above sounds like a pretty compelling reason to do the
> invoke instruction. 16-byte instructions is a fact of life due to
> ldimm64 anyways, might as well utilize those extended instructions to
> simplify a bunch of other stuff. Not having a bunch of arbitrary
> ELF-side conventions is a big plus, IMO.
>

IIUC we just need extra unwind following the call, since it already has two
control flow edges (target and fallthrough for what it would return to), so
it might be simpler than full blown new invoke.

But yeah, we didn't shy away from adding bespoke instructions when it suite=
d us
(may_goto, etc.) in the past.

> Unless there are some technical reasons why metadata table on the side
> is objectively better, but seeing that we have precedents with LLVM
> using same approach, seems like it's workable and shouldn't paint us
> into the corner design-wise, no?
>
> Given a rather lively interest and discussion, perhaps we should do
> one of those long forgotten BPF office hours and go over this in a
> more face-to-face-ish way?
>
>> > bpf ISA is not a high level IR.
>> [...]
