Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0162838D419
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 02:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043422; cv=none; b=XdSt6LoQI/EBxv9Ihwgrw7qB70m5NQ9Eq9okAQoFVJz1pT7z9M8PJsp8RuLQtogODU/wLGl9KKfocqFQcezas0mqZcjaLCKqnT5s5dstsbpEKq6Ht1MRQxbsbKGSnt3/gZR/dohnxoqldAKRPpV+BVIolfQsKBehlhQiGKviptE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043422; c=relaxed/simple;
	bh=kOu3srgIx2HV+4wXroZf4Uqp5munwcYCfF/XPuwDddk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=FYV+zJK7tN5Fe+xVxkdAffpqR7w36piCq3Di8b4miubFZrZLbkRTfgdlhNxfMr2pLFfdp/OLpqO5+mVsvnUDVp+SytOi+WDfczYMGZzrPz5p5kqwBlLu3866kcpsZNI3o9OSxwTznitRRlw+jTemscQeyrI9d9m38mrE+UR9M6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRw17rkQ; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRw17rkQ"
Received: by mail-pj2-f42.google.com with SMTP id d9443c01a7336-2df4aa80a73so14556725ad.3
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 19:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790043413; x=1790648213; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RLoMATi4pehTMQpEQ6ZWMFok6Y/WapCzwDc5b4OuQ4g=;
        b=mRw17rkQuFFG0Vgo1TIKnGoFR5YlaCXRIA5P8LmsVSS/JUuS3yMHoRQMUCvkcSIdxc
         SW1qV3V48IrkHyOtPHSO6gj/a8fpkVBOY7uAbyqHDx5K/3RbnldyVFXZWTzk4bDIEk0P
         DF3qxCePzagn5LbhR6bJPWorNTp1I3gd0kmbVXWJJ/DVfueyBYRSjTBoOtPpV1fW++tZ
         BQDSyfQuf2PsKw0IEbyuboRt2eKa8Fg05zpHbGCllz1TxhHRTr0ozesqPzCSu5J0Pgv0
         I5EpBf92ACANNesxm7VjnHle+3L6LFl8UTIZbW4EMf+kpGwauGu9HxxsP+8AXEpWw683
         8u8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790043413; x=1790648213;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RLoMATi4pehTMQpEQ6ZWMFok6Y/WapCzwDc5b4OuQ4g=;
        b=H8WOLGDZQDBFnMBOgxiFXgnl7Gx3pC9G8KijQyOhmITnrr8HLDzkoFMJ30kXe/akEC
         HnV+fm1MrnbSJYSQ11cdSziJeZ/scAcjfT6NtR/iVxVrzbFYNFnBKNLxynpcEqlJCjAJ
         hyjy2efgdgIjpGKDZyOso5ivsUWvgwh6qSultXteSpGWPfOGPfbYpCIKIgupd5/ZtyGR
         91Jzz7Y+cvQFVHPmrL1GW6sbjxmRWYTebzCowJTyRxM9wJXKyN6niz0qXvG0/uvQuGVz
         blWGjDmcg/I080xtWXXgS/8TjTbhT+YV0FUcns9P/uhi4W99RS7u5tIou5SOLff7MkVu
         6IDw==
X-Forwarded-Encrypted: i=1; AKwUvBxN64WTWEjIfSKUXoA+BzGIcIvcD/7otPV+/dI9ZbNpDXiI8d9BKO8KpVLZjxpnURZEZbQ=@vger.kernel.org
X-Gm-Message-State: AFuF++k1prtF3jl37M8CTA9wFqF3G0QrS8ENl6r9AT9hf8Om/QRA8keO
	fl8SIfzm7GnVvpAFYaA3cLgFahfnQIXnNVNVvF7cw2Bj+nm2Dug836JV
X-Gm-Gg: AYBFou3q29JsB+KhXrCipOuLnyEqn4ZxSRo6wLPAvaTJ/ukw1rFWMFmCL1UDlJDialA
	kjxk/+HvnIPXrx4hoAxbyQOzgntyCZ/XWfr2B+vhhmLCkFAk9K0jij0tmQ6Bkc5IpzWa6EUaoEl
	v47kxsv/lpKE08GdR63lmr/ULV2OL46Lg8BITlAhfpQ37dW2XSGoZAbjd9c7K4O7rHQe76Sgsad
	8M+znEE/yWsUXqlBSD8yRaZWi39NO/+qNlhRig+zey2v57ghdS2Xnn6cwYVuB0XMUMn2YGPA4H4
	mfrl/Uy4Abeakd1GdyI0TZAhpBIKJfXu6h9xywinDLwPpe7ziJCQkV20j2VA9lhZvi7wn4y0xOX
	QYZ7WE1rhPkCoKf3twwqKXdmxAdCDNcbfFcc5c/BR/KEbujzYK3tOSCp/zSbeWNqcRkcZ1xEGN1
	2KupUV5e0oc2M28flo8K8b2akJTCqPjQzlcd4mfjFjN1Rb2vw6jvdPq9+aZYTnJvZzQPEgCn6xX
	460lyA7AIkhFJ0TYf68xYd9oftfkM8o05aWj1XfmDbctwoaFk169XxcrEJ9aJl4gOAfB8T5R43d
	bC8=
X-Received: by 2002:a17:902:c944:b0:2dd:ad73:c980 with SMTP id d9443c01a7336-2ddb1b86d6amr173770185ad.24.1790043413476;
        Mon, 21 Sep 2026 19:16:53 -0700 (PDT)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5d056dafsm1370745ad.72.2026.09.21.19.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 19:16:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 02:16:52 +0000
Message-Id: <DLLHFJDS6G5L.2B273FIKF9A09@gmail.com>
Subject: Re: [PATCH bpf-next v4 00/20] bpf: Run exception cleanup landing
 pads when bpf_throw() unwinds
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, "Yonghong Song"
 <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 <kernel-team@fb.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
 <7e7076ce94e803403bcee003569d4b2ac7bc4e2c.camel@gmail.com>
In-Reply-To: <7e7076ce94e803403bcee003569d4b2ac7bc4e2c.camel@gmail.com>

On Tue Sep 22, 2026 at 1:08 AM UTC, Eduard Zingerman wrote:
> On Mon, 2026-09-21 at 14:00 -0700, Yonghong Song wrote:
>
> ...
>
>> Design
>> =3D=3D=3D=3D=3D=3D
>>
>> A pad is run, not lowered. bpf_throw() already walks the frames with
>> arch_bpf_stack_walk(); it now looks each frame's return address up in
>> that (sub)program's table and calls the pad as a subroutine of the walke=
r,
>> with the unwinding frame's frame pointer and its callee-saved registers
>> restored from the spill its callee's prologue left. The pad therefore se=
es
>> its own frame but runs on the walker's stack, far below it, so nothing i=
t
>> calls can disturb the frame it is cleaning up after. The JIT turns its
>> bpf_unwind_resume() into the way back to the walker.
>>
>> The verifier walks the same thing, step for step, so the resource rules
>> are unchanged: whatever a pad releases is released in the verifier state
>> too, and check_resource_leak() simply moves from "a throw was seen" to t=
he
>> end of the walk.
>
> I have two high-level questions.
>
> 1) The tables handling mechanics adds quite a lot of code to the
>    libbpf and initial verification phases, while at the IR level
>    it is basically an encoding for the invoke instruction:
>
>      invoke <target-function>
>          to label <where-to-go-on-return>
>      unwind label <where-to-go-on-unwind>
>
>    For the sake of discussion, wouldn't it be simpler for us to
>    just add a 16-byte invoke instruction:
>
>     word #0:
>       code     INVOKE
>       dst_reg  0
>       src_reg  BPF_PSEUDO_CALL or BPF_PSEUDO_KFUNC_CALL
>       off      existing call meaning, including kfunc BTF fd index
>       imm      existing call-target encoding
>
>     word #1:
>       code, dst_reg, src_reg, off =3D 0
>       imm      signed unwind displacement, measured in 8-byte slots
>
>    With an assumption that during normal execution (not unwinding)
>    upon return from invoke the control flow goes to a fallthrough
>    instruction.
>
>    The pros are:
>    - much less frontend code
>    - if in the future we would like to manipulate BPF program
>      byte code, it would be significantly simpler to do in such form.

I think the amount of code will increase a lot more with such approach.
All existing call flavors and my new callx would need to wrapped
with this new 'invoke' insn.
Also rust generates begin/end across more than single insn.

>    [1] https://llvm.org/docs/LangRef.html#i-invoke
>
> 2) The final goal of the BPF/Rust project is to consume whatever code
>    rustc generates. Ultimately, this would require supporting a way
>    to introduce runtime checks at arbitrary locations, whenever the
>    verifier can't infer that the program is safe.=20

so far all rustc code looks clean and definitely not arbitrary.

> Such checks won't
>    necessarily have associated landing pads. Meaning that the unwinding

no landing pad? what? That's not rustc.
You're talking about some random compiler that throws garbage.

>    logic will have to be dynamic as in exceptions part #2 sense discussed
>    way back (2022?).
>
>    The argument against exceptions part #2 back then was that the code
>    is complex. Given the current environment, I don't think the argument
>    still holds.
>
>    Hence, given that dynamic abort would be necessary, and that the kerne=
l's
>    rust code is already compiled with -Cpanic=3Dabort, do we need this st=
atic
>    form of exceptions handling at all?

This patch is static exception handling for cases where compiler generated =
them.

We don't know and don't care what is in those landing pads.
rustc maybe cleaning up the objects that have no meaning for the verifier.
Maybe freeing memory (but since it's arena) we don't care,
but we will still call all the drop()s because that's what rust as a langua=
ge
promised to users and we cannot break that promise.
kernel's rust with panic=3Dabort needs to be fixed.
That's orthogonal problem and definitely not something to follow.
