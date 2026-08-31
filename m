Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690B73ACF10
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 02:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788144239; cv=none; b=XhOF997j6eAeUvCm6C8C633GA0Df5hH0apSPTKypa6mwFCl1Qrlr3oUxiU7V58XLu4o2GCJ6Qs6vVGDrIwqRc4wGX/XYBKuJHno90Dm/JbHX4FGkJq2lqh6XopK+bkHaJ/yVPC7neLhRQ80tt3V7rkF5dg49dspkONlSXNrxZvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788144239; c=relaxed/simple;
	bh=MsdmLVRegQiwqggtnxMkuCIHzVN4jOC7xy523DaRM50=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fBWuynb2/2BRxiJEa6K7PL76x+6Br1wjOjr0eTVKxvi+kk+x92kZOqwUiUMZpmLDUlEqKvliB6NRdiBHni0J8PawxQE8XsRWFcwI7OBEXEDjyFNMqSAbOsYEZhLBRyFsvNProjLvT7pdHX3O5Yzfg7Rv7FScbzGGw5v0gxd/F4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxzG66uV; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxzG66uV"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49ccea58fe3so6808815e9.1
        for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 19:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788144232; x=1788749032; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ymc/NdJXhMPL+BOqGNmfc6XPTw7UulT/4bPOKgW49BQ=;
        b=gxzG66uVpaYteYedDIeU58PpYVxZZI1lUxYXTvk2b6mn/5peyBi19S5WaIKkXytpcP
         IhLBL2p1Qt2v5CMPNiiBoG6WHV5AE7m40yybsaR479Urku7fr+lA12Tdgq/yEDmfwbUR
         Ft9tUzvl/HDFbxvFuiBbsHp74S0l0E7wg5u3DDObPArypuhYtIpNYB6gIMEMdv3iJ3d0
         JILPYFgF3KmInQVDrau3I4VPjJrahmifiSA+n8y/C2ksK6uze0V5kOnqaSkEDyR20YLA
         rMliR92uXe2AmCIYTGzIqILvMp4U7BhQkSPRY/fjGGX7WKBxqSIhXksbNHhMFHfEsvT+
         We9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788144232; x=1788749032;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ymc/NdJXhMPL+BOqGNmfc6XPTw7UulT/4bPOKgW49BQ=;
        b=bJO2qYvPI71NaSihuVFoteVorN/a7sT0SXOj9XwVoE4U7/mv9uhBu6r8Av9YKkDV4u
         ys0a1JMacxUIORZpeHMEYKnNfNkRoon5tdhtxByYyVdxKWQf+YT7jDpIU4TQel+YNp7a
         CLhD59JQKHfr+S+D8sFXF0DLsLptoLJb6KPUBG37nEQb9fyEnDvKf2u7/tt/Q61vZxZZ
         4T9ez4LXipYcv7ig+YIkTTkJO21Hu/4echgCL7Gmi2MFjF8+rSq8A72azWfVYObyEeg/
         8OA6CT4ZaBZxm6mmEOb+iJlHd//MR+6jrjhaJGDqH0PH63TY7JeCeEUmcA+xnd/aCLkR
         8RFg==
X-Forwarded-Encrypted: i=1; AHgh+RoM0E6gWyfmV9J7KilU6HVcTmfElfyKTGeP76kMRivslLjGLLelnTDcrbTKHzvLjt0dRqw=@vger.kernel.org
X-Gm-Message-State: AFuF++kpyBNIj5rQESoSvkcnwy3fZVvoJdXGhlLNoLVsauqqOP4V/Mw7
	vMvpZ1x3erFL7bcV6JbA4SH6PA/7AD0n+QO4hQpFh1kv8L84wfXNO1OK
X-Gm-Gg: AR+sD11J/RzcDvok3waeyeAx5TOGeB2Y75FQ1qpi4VSdk0gBDs/Wt48HU8CU63xD52x
	b1nsAMI7tZ8Oqh459Ccb3HzfNDMeVLFKI3BhcQa2FHISXeumIA3LX5Vy3Z4gTRAZBEONHESWqrO
	i2jlV6LKciQIkn80iu/MIIHPxwxuh5Q+gAnSt7Rf6r3j/lI8FrnG9LEaxijvbiSRCKKi6kYKuzC
	R2wGu/BXhKCdOZcLpfa4c/dQAW3X74VuVz6LJLcXQOaX9TjdPueABsVo3/D+Mdkxjy8fp89x5In
	nqAGcprxXjt4NllZOJ5sKa1PblLM7TzdPcLqsekV3Dwyp5nwjxpyV7MFvyfYNt1wP9jnPFKUTH6
	6rNLIAdN2PkjdIGMFJHNsAoQhcBT565XHZ4/6UhEMozIEy0rFmRxrJ6Yp4Lof2l4/9t39CUoFUh
	txcPCap7mq0Hb/18yvutSmLfGV5UhuZ1U1lWrT8kb91z6TREmS8N8l2JIIPTFHJHl99skkhY9PW
	WzSJKA8fDmkF+sBMO2n8Occ51/YeJ1574iMvHzlfqMKDzzfahgeMaaMJoXZ4Z+/z87y/2wnoavI
	AVY1nm/RpHkj0ZOZqXNJOE65aig=
X-Received: by 2002:a05:600c:8b27:b0:49c:d27f:ed81 with SMTP id 5b1f17b1804b1-49cd27fee09mr141280485e9.11.1788144231971;
        Sun, 30 Aug 2026 19:43:51 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cd8b9a2efsm13744795e9.3.2026.08.30.19.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 19:43:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 31 Aug 2026 04:43:50 +0200
Message-Id: <DL2S878KSOI5.1SZMLIAWMCNUJ@gmail.com>
Cc: "Florent Revest (Anthropic)" <florent.revest@linux.dev>, "bpf"
 <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "KP Singh"
 <kpsingh@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "John
 Fastabend" <john.fastabend@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, "Jose Fernandez" <jose.fernandez@linux.dev>, "LKML"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: Keep progs alive until the trampoline image
 calling them is freed
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260819122252.1782790-1-florent.revest@linux.dev>
 <DL27QZ6SEZKT.1CV2HAX4A3WI4@gmail.com>
 <CAADnVQLxi-R1KDUXJJjpq69SpV8UcNJVqBi7uicO=V0WhAvyQA@mail.gmail.com>
In-Reply-To: <CAADnVQLxi-R1KDUXJJjpq69SpV8UcNJVqBi7uicO=V0WhAvyQA@mail.gmail.com>

On Sun Aug 30, 2026 at 3:21 PM CEST, Alexei Starovoitov wrote:
> On Sun, Aug 30, 2026 at 3:41=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
>>
>> On Wed Aug 19, 2026 at 2:22 PM CEST, Florent Revest (Anthropic) wrote:
>> > bpf_tramp_image_put() makes sure a trampoline image is not freed while
>> > a task may still be running in it (call_rcu_tasks() + im->pcref), but
>> > nothing similar is done for the progs called by that image. Since
>> > commit e21aa341785c ("bpf: Fix fexit trampoline."), detach patches the
>> > return path so that a task still in the original function skips the
>> > fexit progs when it comes back, and counts on the prog's own RCU flavo=
r
>> > to cover a task that is inside a prog. On that basis the last prog
>> > reference is dropped right away and the prog is freed after a single
>> > RCU / RCU tasks trace grace period.
>> >
>> > That leaves out a task in the trampoline glue itself: between two
>> > progs, or already past the patched jump but not yet in the first fexit
>> > prog's enter helper. On !PREEMPT kernels this is a few instructions
>> > that cannot be preempted, so it did not matter. With CONFIG_PREEMPTION
>>
>> I guess it would make sense to highlight why it may not have mattered. I=
 think
>> the real reason was that on !PREEMPT kernels, the execution in the tramp=
oline
>> image counted as (implicit) RCU read section which caused program free p=
ath to
>> wait for someone executing the trampoline image? For non-sleepable progs=
, they
>> wait for RCU grace period already, for sleepable, RCU tasks trace has im=
plicit
>> RCU grace period wait as well, hence this never showed up on !PREEMPT.
>>
>> > a task can sit there, in no RCU read section of any flavor and holding
>> > only im->pcref, for longer than it takes to free the prog it is about
>> > to call:
>> >
>> >   CPU 0                               CPU 1
>> >   in image I, orig_call() returned
>> >   [preempted before lsm.s prog A]
>> >                                       bpf_tracing_link_release()
>> >                                        -> bpf_tramp_image_put(I)
>> >                                       bpf_link_dealloc()
>> >                                        bpf_prog_put(A), last ref
>> >                                       tasks trace GP, A's text freed
>> >   __bpf_prog_enter_sleepable(A)
>> >   call A->bpf_func
>> >
>> > On x86 this is an int3 in poisoned bpf_prog_pack memory:
>> >
>> >   Oops: int3: 0000 [#1] SMP NOPTI
>> >   CPU: 18 UID: 0 PID: 94573 Comm: x169 Not tainted 6.18.44 #1 PREEMPT(=
lazy)
>> >   RIP: 0010:0xffffffffc0601d8d
>> >   Call Trace:
>> >    <TASK>
>> >    ? bpf_trampoline_6442515411+0x1a4/0x21b
>> >    bpf_lsm_bprm_committed_creds+0x5/0x10
>> >    security_bprm_committed_creds+0x5f/0x70
>> >    begin_new_exec+0x2d6/0x410
>> >    ...
>> >
>> > We hit this in production on preemptible kernels when progs attached
>> > through trampolines got detached while their hooks were busy. Adding
>> > grace periods before the prog free would not help with sleepable progs=
:
>> > neither RCU tasks nor RCU tasks trace waits for a task that slept in a
>> > prog and then got preempted in the gap after it.
>> >
>> > Fix it by having the image take a reference on every prog it calls, in
>> > bpf_tramp_image_alloc(), and drop them in bpf_tramp_image_free(). A
>> > detached prog now stays loaded until the old image is gone, which
>> > reverts a deliberate choice of commit e21aa341785c ("bpf: Fix fexit
>> > trampoline."). Detached fexit progs still stop being called right away
>> > since the return path is patched.
>> >
>> > Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")
>> > Assisted-by: Claude:unspecified
>> > Signed-off-by: Florent Revest (Anthropic) <florent.revest@linux.dev>
>> > ---
>>
>> Overall, looks good to me. Thanks for the fix!
>>
>> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>>
>> Note for whoever applies this: please add Reported-by: tag for Sechang a=
s well.
>> Optionally, wordsmith the commit log with the suggestion above.
>
> Hold on. I don't think we can proceed with this fix.
> It defeats the point of fexit jmp patching and keeps progs
> pinned until a sleepable kernel function that were attached to
> will return. Which means that the tracing prog attached to "unlucky" kern=
el
> function that sleeps for an hour will stay pinned for an hour.
> Let's think of a different way of fixing the race.

I don't have background on the original commit being fixed, but is that rea=
lly
realistic? Or worrisome even if it happens in practice, since worst case th=
e
program refcounts remains raised for that duration?

We have similar worst case for programs too (e.g. using bpf_copy_from_user =
on
user controlled buffer in, say, LSM progs). At least here we won't be exten=
ding
any RCU flavored GP.

That said I will think about alternative fixes in the meantime, if we accep=
t the
premise that we don't want to pin program references in the image and keep =
their
lifetimes decoupled.

>
> pw-bot: cr

