Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D05D3793A8
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 02:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790044268; cv=none; b=EJaD0a5QsidKsePtUvGw5CeHUt/Cnh75z79hVfr8lmC3vQubeyY/GamqOaPbBve3mS3Al717XjiZ91ACQtw4JB+F5Zu3vMCoqYKR4728BG94xEl5oBxVglTgSDaOXj77a2c2iyClVUJ8CsPH2hXpwyBqkcaCtE2o6pe6iyDNEho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790044268; c=relaxed/simple;
	bh=tGzn8woxVVbNd7+G6sT0o+euxQCYIFMBqkDVuwj+MHs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cUU0hxplFhkQA2xf3TlO0Or73hvFCkOWgfHb1NNuHz7otYBKBb52LC94iG7ya9xf7y7olx6rdlr9bpUCn3V4x4MP14ALgc63Oio0HyVxQSjkAXyEyBOEtg3KQNrIHUvfCuwE+zyPU+d555R3mnbDWQcEnkfDmGEn9zRwK3Ld1sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeiCllwS; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeiCllwS"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6e43b9d8so13095175e9.1
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 19:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790044265; x=1790649065; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TfXUua8Llmdxd1Zx7rSl+Uc8M5lcZVDCVfNq8yweuPA=;
        b=WeiCllwSO9YyEaZ8TKiXW27Zumw2iwJoW7Mgustb7x0zQhG7TGerDCWz8R8738Uudb
         NErrv/DZzNTbeIGsvK7Q8UwCtC/vsXWoUyN/gRl9ZO0SPnRT+QqvSf73l8KEfchvXVjy
         awCGv8R6CD1lJ2WkArCmMroNrZ5ZQs4sQgDuLYLgDUwmArRYffpDV/bvtqeQh1WxRPhH
         o33CO2UzXXe+vz3MaISfzXU6hNzJQOdh5We/6CPhdxD4s1W1xww3O7hLqOUd2HU8jZqA
         4hqnUKTjH64yauQ1uEUvmJ/R79uQebkRo7AbPqk2XmFL3XRRKJVhbm9oqKKoM5vVvMTL
         v2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790044265; x=1790649065;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TfXUua8Llmdxd1Zx7rSl+Uc8M5lcZVDCVfNq8yweuPA=;
        b=Z9/X1HngD9o0gkeYPrujMm+MDmoLuObZsVN5OuZ4P3VDMro9bPP2vyU5I/NY3U+aQe
         nJBhexl2gcaUM1ggWsyF/ZPH33Vk8D6kyHd4R66RcOoPzqa08jPyiHgOU4FE35aPxLhO
         hEa3Xhl473OImgBQgGcUilzLqdHVNQ/ui2TNqaUuxRHAZ8oHjK+xw/DM/iYsK4Oyw5Jg
         4e+YDBz3mAcHOJ9753vEg3u6iJLW3F4rnww4rgxI5ZW9mn7+5kdfd5sqKJEF/61HQuLv
         wCOXsyElG0Y0201+2nyc0hhxZgnr6fi4N/91YWP6kpTAWmaUw+r9kVHSkOHAZglV3241
         rjng==
X-Forwarded-Encrypted: i=1; AKwUvBxakxQcx9ORIvUXgpbJKoZG+ApTjPBC4mAtCQPkr92dtsaqv4COnYwCRR39A/ABy/5eWKc=@vger.kernel.org
X-Gm-Message-State: AFuF++kqXCdZSUqdCnBe294Bw3mbeUcyjVUFhUQmWKYeDQTC4Ns9Qlwn
	KJapUZpu0W6F6k1JZtWVuieJGTrEM2vDTYola2NQT9Yf+Shr59V4M2Hi
X-Gm-Gg: AYBFou3Za16nMAg4oxEiX279FCczDbNS78HRTvymf+de6g1oFNOypTIMopvqgIVJVx6
	5CUuH4F5FcAciNKTnbNCqdr7bN9RWF5wf81bGJ3CCi1VbPXX38178ve0fMV6CUzKcLfSkJ0gQzz
	ahey8n0zO30aWhsSPopQiBKY1pyYB6qFM+sbtuhK4sABtb21Tanqg6yDQW7yINNIP4Bz+pkH+IA
	fTugPtY/hqz5Sl6SdGyY304ytFCLVKm6rljkDCOfV2WmupGFg6tZSBaKAQ8py9h+LK4YIcuCPuQ
	QecdGruOq0K37+lF/+RuhPb2o1qfEEYICHXC4aa4T/dVabqewbDvs3x7Uqnq/KCLMFtHJpD0zEJ
	GC+xGOk4rO/vrJ6hC6teNz3ER6gdnNlCieQ2FjOUVyqnyEIxZ3hfUhA/qOgHeOuF8hhrmsdbh3H
	haScQi9aHVPLDvUyq1C/T6c4uP5i6/q4aIueibMsW2Ye7DEOTWUBGfkUMN5ivC6wQ39rHK3pow+
	afXWpphuWWgEKddKvhj80nNdkvSIPo9de775cHrjtGHCFZ3x5U9bCFUH5n0/xVMd8/cUFxbJ23E
	sMQLld8X5dCqCjOvm0Z/TWqTX9eZFx0byMg7HAB+jlUK
X-Received: by 2002:a05:600c:3b8c:b0:49f:bd3c:bc16 with SMTP id 5b1f17b1804b1-49fc572f58fmr225706855e9.17.1790044264588;
        Mon, 21 Sep 2026 19:31:04 -0700 (PDT)
Received: from localhost ([2a04:ee40:2228:a500:f8e2:3a74:69bf:2c6a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdab8ae6dsm25993685e9.0.2026.09.21.19.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 19:31:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 04:31:03 +0200
Message-Id: <DLLHQDZBGDUO.2TT8UBHIMZEFK@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v4 00/20] bpf: Run exception cleanup landing
 pads when bpf_throw() unwinds
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Yonghong Song" <yonghong.song@linux.dev>,
 <bpf@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
 <7e7076ce94e803403bcee003569d4b2ac7bc4e2c.camel@gmail.com>
 <DLLHFJDS6G5L.2B273FIKF9A09@gmail.com>
In-Reply-To: <DLLHFJDS6G5L.2B273FIKF9A09@gmail.com>

On Tue Sep 22, 2026 at 4:16 AM CEST, Alexei Starovoitov wrote:
> On Tue Sep 22, 2026 at 1:08 AM UTC, Eduard Zingerman wrote:
>> On Mon, 2026-09-21 at 14:00 -0700, Yonghong Song wrote:
>>
>> ...
>>
>>> Design
>>> =3D=3D=3D=3D=3D=3D
>>>
>>> A pad is run, not lowered. bpf_throw() already walks the frames with
>>> arch_bpf_stack_walk(); it now looks each frame's return address up in
>>> that (sub)program's table and calls the pad as a subroutine of the walk=
er,
>>> with the unwinding frame's frame pointer and its callee-saved registers
>>> restored from the spill its callee's prologue left. The pad therefore s=
ees
>>> its own frame but runs on the walker's stack, far below it, so nothing =
it
>>> calls can disturb the frame it is cleaning up after. The JIT turns its
>>> bpf_unwind_resume() into the way back to the walker.
>>>
>>> The verifier walks the same thing, step for step, so the resource rules
>>> are unchanged: whatever a pad releases is released in the verifier stat=
e
>>> too, and check_resource_leak() simply moves from "a throw was seen" to =
the
>>> end of the walk.
>>
>> I have two high-level questions.
>>
>> 1) The tables handling mechanics adds quite a lot of code to the
>>    libbpf and initial verification phases, while at the IR level
>>    it is basically an encoding for the invoke instruction:
>>
>>      invoke <target-function>
>>          to label <where-to-go-on-return>
>>      unwind label <where-to-go-on-unwind>
>>
>>    For the sake of discussion, wouldn't it be simpler for us to
>>    just add a 16-byte invoke instruction:
>>
>>     word #0:
>>       code     INVOKE
>>       dst_reg  0
>>       src_reg  BPF_PSEUDO_CALL or BPF_PSEUDO_KFUNC_CALL
>>       off      existing call meaning, including kfunc BTF fd index
>>       imm      existing call-target encoding
>>
>>     word #1:
>>       code, dst_reg, src_reg, off =3D 0
>>       imm      signed unwind displacement, measured in 8-byte slots
>>
>>    With an assumption that during normal execution (not unwinding)
>>    upon return from invoke the control flow goes to a fallthrough
>>    instruction.
>>
>>    The pros are:
>>    - much less frontend code
>>    - if in the future we would like to manipulate BPF program
>>      byte code, it would be significantly simpler to do in such form.
>
> I think the amount of code will increase a lot more with such approach.
> All existing call flavors and my new callx would need to wrapped
> with this new 'invoke' insn.
> Also rust generates begin/end across more than single insn.
>
>>    [1] https://llvm.org/docs/LangRef.html#i-invoke
>>
>> 2) The final goal of the BPF/Rust project is to consume whatever code
>>    rustc generates. Ultimately, this would require supporting a way
>>    to introduce runtime checks at arbitrary locations, whenever the
>>    verifier can't infer that the program is safe.
>
> so far all rustc code looks clean and definitely not arbitrary.
>
>> Such checks won't
>>    necessarily have associated landing pads. Meaning that the unwinding
>
> no landing pad? what? That's not rustc.
> You're talking about some random compiler that throws garbage.
>

I think you misunderstood his question.

What Eduard meant or is asking, was that (per his understanding), the verif=
ier,
in the future, would attempt to defer to runtime checks where it cannot pro=
ve
certain patterns in the program safe, regardless of how they came to be (in=
 C,
or Rust). Instead of rejecting the program from loading, in such a case, we
would emit some form of a runtime assertion that, for the remainder of the
program, guarantees a given value to be in the range the verifier accepts, =
as a
very simple example.

In such a case, the assertion and associated panic is being injected after
compilation, hence it is likely there is no associated landing pad to fall =
back
to and clean up program resources. Yet to safety inject such a runtime asse=
rtion
clean up would be necessary.

>>    logic will have to be dynamic as in exceptions part #2 sense discusse=
d
>>    way back (2022?).
>>
>>    The argument against exceptions part #2 back then was that the code
>>    is complex. Given the current environment, I don't think the argument
>>    still holds.
>>
>>    Hence, given that dynamic abort would be necessary, and that the kern=
el's
>>    rust code is already compiled with -Cpanic=3Dabort, do we need this s=
tatic
>>    form of exceptions handling at all?
>
> This patch is static exception handling for cases where compiler generate=
d them.
>
> We don't know and don't care what is in those landing pads.
> rustc maybe cleaning up the objects that have no meaning for the verifier=
.
> Maybe freeing memory (but since it's arena) we don't care,
> but we will still call all the drop()s because that's what rust as a lang=
uage
> promised to users and we cannot break that promise.

I do think supporting invocation of landing pads provided by the program ma=
kes
sense, regardless of the discussion above.

> [...]
