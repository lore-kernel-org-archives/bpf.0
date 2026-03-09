Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2FC2C0303
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079935; cv=pass; b=FLaB3sUsm2WYcjck0VrSO1+WYF5wMTzHfvJ5Wp7zX4HuAWlRAqDUIZ5z0PbUgbj+9WjT5fGQxnxTNy0QNMUMhX6UhnoaIG9LbIyPDDMkKBnWZ/y7K3HmaursPEE2AmZvM3acGU5Y0kSnwLoJ6d7fn4Rt4IRA6keUelKpi0nMDp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079935; c=relaxed/simple;
	bh=VbnN0d+ZsN8iu+Q27vm50zGAamkjg92EXxi65PIOHyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXziaL9tS/KMHugAteqiifXn2c9sr7TSZpZGyrP6v47JvaA87owvRdrZFDMVjTAUxNIQq1b0+fBLjbJfqXenORu/iwtNCRux6KdVWbxzG+e6fgmyINcjs/gVqk0LXgUAzsubBjBJtY73WXBHlasaDXWUnU8M40dnAK9EBw2jX+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iz8CDAu5; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iz8CDAu5"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so22327595e9.2
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 11:12:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773079932; cv=none;
        d=google.com; s=arc-20240605;
        b=Ydz9mCUkN92Pj5dtY7A3v7N1SwsN38BGyceC1ddgVpvlZgpVq3VzdsLIqUUbFplcKv
         HCIPTwUqJwRjzvTr2gL2mamGo5lQLJ35cLLubrvmkRgHwEvnSRzBkQOyo61nN620efgZ
         tZ6Z1uRzlLaZ4aZ5TO4p4qsJJGg5sSTWE5IoKXB3OpxhIoRoVPHkh+KufG3EsL+YRmhv
         fK4IyIVnoiDaRr7LjfRAlkjQmtyq7dZoa6sdW+L3pGX606Idv/Xk2fU8pECQwHC6lsZt
         Jp3gPtltbgV/WS7Zigu87Y4/B9OcqNPS8F05cJefersyFcevz945Am9U3pU/Js8Yywd2
         aWYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VbnN0d+ZsN8iu+Q27vm50zGAamkjg92EXxi65PIOHyM=;
        fh=V+pBgdWCGc3eEx30o3EZqXHeWkGtRTtxD2uIo15vuaQ=;
        b=DPAsuxhfgF9VU0bgNkLL5PABH+TVz9SmKyypmLnnbxTx4NXCDiJTiqjtGvgCy5PKUo
         8D84jsR4L2Rh6Vx2fwn0bThcXrGPOCCcSz1gwLRr6VLH0koDM6yn99OY8ybOaEgQGH1w
         kCg5j4cBSdy4/ZRQgnVg5rh386sM0GFVKCl9RKG/DXuLDithGL2FO7u2oM6YnyZZAvby
         TC2zNvh0NeoM/DpR8L17CFpN3y+MNj8mcrKhpKTZ5N6FKAmdjYyJBLvWXq3oP75LFNOM
         Jye35W2b21aa2f91csyjhNfMT45PlENNaCb5DprSVmnfVKTHZgRJjqUCnZZjoh67RpJe
         z46w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773079932; x=1773684732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbnN0d+ZsN8iu+Q27vm50zGAamkjg92EXxi65PIOHyM=;
        b=iz8CDAu5HcH7RwN6wRGEUljkG0oeIkf5AEpR76ehVeWis6UKuzmuLcKbtSdLuuYsEN
         GbzLI5ofhzFmf9ag8UHHAaOtkXv8+crtex4sqI287rJdFCJh1qegeOwXoyaxczR1q1ii
         pNnpKGjdv2BEKiwBgjy6lO9dvl2IXw8iQZej5ypio7+zQhxlp3IG2pyry/oNNZilDksU
         WP8jr/8rHibPbXZyNZXRWrKM2sTfGPYiKItEqYoEFEgGf4uMxDOjbzCBpFFf+Ywqm3OQ
         a/WG/4sU/5H/QlkfmUf6kkoCB+gwskQ0SK+vIszynIMETrZr2Ry9FRWJBg6Su/D8Gtak
         V2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079932; x=1773684732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VbnN0d+ZsN8iu+Q27vm50zGAamkjg92EXxi65PIOHyM=;
        b=hjtuM72nol4NFcbhbobp9FnzmrVt/Se2FEoMJQY6PgswbQbl7Tqan4N8CU4F32vD3n
         vcuC4m7wjyevSjHwCqPYt592FGs8b68c/sjKX5riuIFBXU4olQwuGlj9gE+P0Fd5Dj4t
         z7CBsim2tLlx/nCTVPu7ayezPxf4dGFGdFLHCk/oBl5uPF3kkihVu1duboUddT/xYhxn
         HFvMNb6yCJCBsXaOBRYYLOtTV/iOD7m1/zay5PDDWMWXzbgzAAYbN2iwH/COnzAdMEQX
         dyj5FsubBlYHObEx51r7BuJxfBwSwzQ/1uKXev0MvCyeP1Rz8HRMBE/90IODEXlCdCKV
         WQnQ==
X-Gm-Message-State: AOJu0YzKHGQN4S0AKYeNeHiz/mtPPAwfos+Ejk5eQTO6we4PkArdt83T
	Ou9yuzoP2kr4/VACgJhzRAsTzmBk/ginI47vT/2io8biEEWmDxpSDfgID7W8u8B1B7XUFE6yEl8
	3PWtr1W06kVCO5eFTF//+Tcm0P1xlZCE=
X-Gm-Gg: ATEYQzzhFjyJPkZzd7ZgpqfL9e2EdTqFKRysMNMEXNc/LqnqGUwh1O2nbShyYvB5lP6
	EteFQJvS6ckDwvEf8fcNIFLq4pfa1B/5RHh4MXnGDO8TgR9VOJklDWiCTc1E/GQIsGKuxV/QJvL
	24hUXUKzNCp3QqTP0i+PoQvkH0QnmoooNsOVJv/tVlp7DzyV6zMFqApblnUHQexYliNZtkqq3pm
	xwadEq650+OHx3H5aedcwVe612CP6Mim2cu5ReCTcZi/nCL6qetyZLSXWKa/wdYGuHl+ZTUcKs8
	oN7+QjC4APRlecARmF0e87GhPfO/2P6mURu7R6qwhLOSDk3/dCpLO0R4Bxyd1tV21I09cReBfHU
	UBdKgrEGX0thfvxRU4/hPs7Zw+SSd4kUJchxA
X-Received: by 2002:a05:6000:18a8:b0:439:cee7:7160 with SMTP id
 ffacd0b85a97d-439da8a31admr19533393f8f.52.1773079932246; Mon, 09 Mar 2026
 11:12:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309155506.23490-1-puranjay@kernel.org> <20260309155506.23490-3-puranjay@kernel.org>
 <CAADnVQ+2FoGYUapuXQUcCEerjfxqFSSUc8vwg4q8TN0GVwaS=g@mail.gmail.com> <CANk7y0iD2hsfcYZ4eBHib0au_sZx_ziqXPR9cf7iAmqC73NgyQ@mail.gmail.com>
In-Reply-To: <CANk7y0iD2hsfcYZ4eBHib0au_sZx_ziqXPR9cf7iAmqC73NgyQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Mar 2026 11:12:01 -0700
X-Gm-Features: AaiRm52K0lH8Rz39-0C2bvpy3rrG6D4Fb6yV8V53xhLf1KOFP0RidWtAU3QlWl0
Message-ID: <CAADnVQK+qKy+39SWmOBE+si9NNJc7K9jzz1JcBJkv6Z45ufHxA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/4] bpf: fix mm lifecycle in open-coded task_vma iterator
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 11:02=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> On Mon, Mar 9, 2026 at 4:48=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Mar 9, 2026 at 8:55=E2=80=AFAM Puranjay Mohan <puranjay@kernel.=
org> wrote:
> > >
> > > The open-coded task_vma iterator reads task->mm and acquires
> > > mmap_read_trylock() but never calls mmget(). The mm can reach
> > > mm_users =3D=3D 0 if the task exits while the iterator holds the lock=
.
> > >
> > > Add mmget_not_zero() before mmap_read_trylock(). Drop the mm referenc=
e
> > > on error paths via mmput_async(), which is safe from process context.
> > > From hardirq/NMI context mmput_async() can re-enter __queue_work() an=
d
> >
> > hardirq can reenter __queue_work() ?
>
> No.
>
> I blindly copied from defer_timer_wq_op(), sorry for that, I should
> have thought more and looked at the lockdep_assert_irqs_disabled() in
> __queue_work() which means hardirq can't re enter.
> We only need to check !irqs_disabled() here as reentry can happen only
> from bpf programs attached to tracepoints in the call chain of
> __queue_work().

Exactly.
Please add a comment.
It will make agent's analysis easier too.
