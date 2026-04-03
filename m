Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD951291C10
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 20:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775249740; cv=pass; b=gtnxODF9n6f+E8m+oyXr+Nhzc5/oZQq94FHraZ4N9J7O4KW1uPZtM3WYi9GxyWVz8JKS/W92MA5wjIVgaXieG+0VIfWxL/OTrSuy0Ju/DuQOU6z9T58QaEz29yRRNX7OIhhmKW95l+RHR2LJArQoMaBNtcAMrY69ehfG9A5DMAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775249740; c=relaxed/simple;
	bh=sTUwcd1bS2S1zzg6SweuuUmPEJiJW90biTuK7ZrcV0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQ/RiXvj+xryknqsW1IZ9zwiFox5AJkwjKLRFNWxnkk7m3zhlJrBOMlKUJdGAq650rmR6G6yCODN0VB6tZu9T3PvgTsKtTFCT5RDJWzIl5QIB6WoXGGZYQnNc3YF5jOqI8JNf4X17xGLa94XY28d+quUm0oKkidnJ73ofroaoVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mUvAmWKp; arc=pass smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mUvAmWKp"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-94e2ad66abcso683995241.1
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 13:55:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775249738; cv=none;
        d=google.com; s=arc-20240605;
        b=DEgcGKk5vi4xS8mjYOl0dqi3++8v72jLQ2nq+vKMPPTRVOpfrxn7U6wQv8WlnxBE7I
         4xecjkjG6Xf+kDOhDOdgNev7POvnKIOi/5Mk4H5FHXa+d6VUq/YzEGObYXL2O8P2KOuN
         2B9nlZmYwU3cCFiUNAAisLe9caO/ThlFGVYIScJP7PWZvUurjDsTEgm7NBdNjD3+FGMj
         LIkjr6Jr2iZtLN2FtySDlek83+SdK6f3fN/BfYdkoapqFc3Wv0ASEExiRImJkalHRVDA
         HqxCZifQhnyP/r2uLuUviBlbt1Nn5nahg0Nk9jE9jsJUxj36j+BvpP/L4xaCtTR65IoT
         3ofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sTUwcd1bS2S1zzg6SweuuUmPEJiJW90biTuK7ZrcV0Y=;
        fh=D0U7xkmrpq3vpbucBdB5oaK0w2+LJrL/wExdhlU6JuE=;
        b=FspA7iqyQ0Nqv9kSmza2nMXK9BpEB+UEObQXA2gmtd3+ZKVWfbuaO+cXjP612xW1aV
         AwBLeppFAV31+GRpkDf5ZtrKoRwsFAIySE0fTmn56IEVuqikH+CSYII5ZpNRlTQiarxD
         BUxQ31+zx8iYlv9uRImNSyJBV3qWIoxSST4T9bMc9PxSaLVniVOX9Wf3bG9J43VIq9VX
         xbfYAprbqHFu/VTpV/JufVbMkAsPqFyUeXKnLCZIIhOVM3UD1bLISXwoWAHRoXUX50/e
         Dv0QmJFbkfHXYrGKmhPrSzWCUmOwUlBbke7UWTo2AxsL3pJb4+zreNoxwDjxcwe+BOWe
         966A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775249738; x=1775854538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTUwcd1bS2S1zzg6SweuuUmPEJiJW90biTuK7ZrcV0Y=;
        b=mUvAmWKpvN/9LbApy+wztqY3qewQZwuDLW3ValldzBtNBP0+fu5uHtoGWZ0sGlTCwx
         zOUMdcFVPwFvdyK8KbddaZIAHpbesm3s0VY857T9dH/eyQ+eEngRz69TwzB4n87ykIn6
         LW02Lx4OSBBalkO9vXDfbfjppm1Si+yX7rfCULkaSsR50CAAcH/v0JZ3LGxROuxKkMvj
         7dEEu+5JV57dqwxxbU61QqhHEW9jggHwG35XnJT0fzGIptpPPUdXIA0bCAIn2JXiYjp/
         gqj3mgy668Npm0GmsrxL6t5fnF+FFAs8Fhr1IZBD4rp7LyfaoYgFG6oeuQstnpltgag5
         5Wxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775249738; x=1775854538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sTUwcd1bS2S1zzg6SweuuUmPEJiJW90biTuK7ZrcV0Y=;
        b=C+5ow18goTuXw13bc158cJ+MO55kXxp/mdIcg2+BYGRNmX5SEQew65p07HHA3qbia7
         VbfWgoNzvxH71RfveIUE6AXm/axpzbwqBZZ3MdnpDhNQYPzJIAL3aGsm5cuvDcCkyIb0
         MpNReDO5EBCyb3c86w3OOgygfz/vGFhGe0BVLae4RflS9ye52GLtSR7i3Xxd3wk/iwId
         6CxokdPs49TSlev+tiw4OQKYB/rXINysKe1QFuUnKCrqod/ziYnup79NJdt2pcIw4TO+
         0Q6CpM/cefUgpCYpxMS16/1sBpJ9Vx3EXeV5boN3qRXnSkgwcxjJPhhyZL77G10xpssM
         89ow==
X-Forwarded-Encrypted: i=1; AJvYcCX92mivomDODo0gb+6IJcvp6tV5zCiNJS/zqDyge7u4xwQD43BMA0rbkIB8C6aN7VTx4vc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6SiUlXqTtFGPQu59FeyKwtW760NP2Sidqki4SyffJKlXJn4+B
	Iz9yWieVyEvxQti2BsGPXTzwysrFRd5htiTAR5H0vKHGQqKm1YOv7pU6h/CIDkaMPHue1HEaklK
	ch+mMipfFkpqQhHK4n3ycdeTIk9T2FfjRo+v8oP2S
X-Gm-Gg: AeBDietKTscCQ+NhRXCrT/exBEQ85Sz5fIuv7NG945Z/F+Byw8p64VQeuS8yMVZdL4E
	qqiltkVdByQiOXgxH3YvCW3wTmGpcY4SnOC1mXdpTIl7kEhzanXIuHx/kkgsPAzyQZxhWqxAgaa
	M2acx/ppR9CSvBDU5Tlx5UMPwkyt2+bDKh1U78MNCtA+sbhgBKAHWSPqc2nQRDIK9MEv6GQ2bpV
	AH6QlMOSLflx5wumhN7mzYrBn1pkjXNDQyWWWL4sBwNKnl8BDrkr/vibY3oZKiHOyinbDxOqLl8
	iImz3yEnDTo6QxfGxhQ=
X-Received: by 2002:a05:6102:b14:b0:605:26eb:cc1a with SMTP id
 ada2fe7eead31-605a512c49dmr1509501137.29.1775249737225; Fri, 03 Apr 2026
 13:55:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402092607.96430-1-laoar.shao@gmail.com> <20260402092607.96430-4-laoar.shao@gmail.com>
 <CAPhsuW51Hh7XfN6xXm_uMAoDXBBQoNQ5ynqom+wVNdqCt81f2A@mail.gmail.com>
In-Reply-To: <CAPhsuW51Hh7XfN6xXm_uMAoDXBBQoNQ5ynqom+wVNdqCt81f2A@mail.gmail.com>
From: Dylan Hatch <dylanbhatch@google.com>
Date: Fri, 3 Apr 2026 13:55:25 -0700
X-Gm-Features: AQROBzDS37OjmfrI7p7dlg7HXRfbNYrPo6MbDjUEgtIBQmy-W82lfbmdNqsszdI
Message-ID: <CADBMgpy3e25EH5xbKMN5GeOK47jE6uzviknbt35V49_Y7zFj8A@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] livepatch: Add "replaceable" attribute to klp_patch
To: Song Liu <song@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, jpoimboe@kernel.org, jikos@kernel.org, 
	mbenes@suse.cz, pmladek@suse.com, joe.lawrence@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	kpsingh@kernel.org, mattbobrowski@google.com, jolsa@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, yonghong.song@linux.dev, 
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 9:19=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Thu, Apr 2, 2026 at 2:26=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > Add a new replaceable attribute to allow the coexistence of both
> > atomic-replace and non-atomic-replace livepatches. If replaceable is se=
t to
> > 0, the livepatch will not be replaced by a subsequent atomic-replace
> > operation.
> >
> > This is a preparatory patch for following changes.
>
> IIRC, the use case for this change is when multiple users load various
> livepatch modules on the same system. I still don't believe this is the
> right way to manage livepatches. That said, I won't really NACK this
> if other folks think this is a useful option.

In our production fleet, we apply exactly one cumulative livepatch
module, and we use per-kernel build "livepatch release" branches to
track the contents of these cumulative livepatches. This model has
worked relatively well for us, but there are some painpoints.

We are often under pressure to selectively deploy a livepatch fix to
certain subpopulations of production. If the subpopulation is running
the same build of everything else, this would require us to introduce
another branching factor to the "livepatch release" branches --
something we do not support due to the added toil and complexity.

However, if we had the ability to build "off-band" livepatch modules
that were marked as non-replaceable, we could support these selective
patches without the additional branching factor. I will have to
circulate the idea internally, but to me this seems like a very useful
option to have in certain cases.

>
> In case we really want a feature like this, shall we add a replaceable
> flag to each function (klp_func)? This will give us fine granularity
> control. For example, user A has a non-replaceable livepatch on
> func_a; later user B wants to patch another version of func_a. Then
> some logic can detect such a conflict and reject the load of user B's
> livepatch. Does this make sense?

I agree with this. The ability to reject livepatches that try to
change functions that have already been patched seems like an
important safeguard.

Thanks,
Dylan
