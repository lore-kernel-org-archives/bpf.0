Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021782EC0B5
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 02:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772764088; cv=pass; b=tWdLgeoTnUMVsKKJ6TGMc2jATkwl3evKxBm++0Jymwo2eG9ZcYToOWnEbgdk/oS8T3v/Li+7QONe8CAaS+Z3gMZath34XB0ZNw36O0I24kG+pk5drblgkJxl4HE3luGE3hT2eOvQmf/lbM5kUwbg5FAod+eAlh3Ch/OKUncqNNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772764088; c=relaxed/simple;
	bh=B2KdgKc3ZvG/UaXzCHXzFbOt9fsK1ZB/lv5DSzHqXIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/tVlPEzS0kOCi1r3XMpgyyXYvvwkGgnZyjWBcF7iDGhpVLPvfdPYSU2QKBUnIUE2NqXMKD75pxf/QL+JbJUZW/NxHbqSIIOZcMv4gpGuyQCzjYlTLzQOPgmGElBZqrvvwdKQdhIOjexPjpzRxvgd/rwTLMLnqFKyw8DT5FtyPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddoU+qD8; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddoU+qD8"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64c9fcc24b3so6659682d50.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 18:28:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772764086; cv=none;
        d=google.com; s=arc-20240605;
        b=igZaSmoMNcVAeDqnRNudT54yi3R+8GxjtXixARGi4j83s4uacywqQ33yTxPhb4QiXO
         7kheOZqpWbZ9kjGKdyEDdZ2W0lJl7KWC5lR70GtH/PJLpIGF7x6LXKgg9yW4koUw5Gwe
         zaqeJQQ7BzIUSBeUAk7at0xv9z0FU4oCuKryixdjLJwLNO5SZA/dHfIk+tjgAxV9syAX
         Vsc01sLM98qAN3y3AtURYqwCPtBiYlAgQc3MkwKHxiM4aYsUoq92iANu+lRURj9kyiHa
         /YRPKtTXBncaReojXTM2/CVtd0uEe6jLJG11w/y+uMEYQlvWZBETu1niQKXCTzF+TBql
         fI5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B2KdgKc3ZvG/UaXzCHXzFbOt9fsK1ZB/lv5DSzHqXIk=;
        fh=pdLved/9qLiviS9RwtyxyhY//5qEBeffBdt3wAxWc7E=;
        b=CCEV5Hge5yBy9dkLO2tQ/jeldZmO66pdzJSTCANko9NJiAZT9VFdsYy02s7QAQ5s6O
         ozsALE2QXDOcHq72X3mSQW778O5QxRzhOeHxvfwvS4cbX9XMp7FFf4Q5w0L2aJseW3wj
         yn6A9nRbq6K6kTQ4eCKwcSp26WB2dG0J1DiYr1I9ssikKJ/Vp45wwHwM3IlJD+RjL5SO
         YLBOP9y+znrpyQYzGgXHC8mVrrUAQYr1E261lzWT4Z4cntDyb4TDvzuJrtiUk7Z6jjLp
         f9yDQkxE4ATC3PZ61rN7/F28ktcBPaomcM0AZQFIEerC2R4uCdzqD2lxnDzEx5NgIXfJ
         g1aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772764086; x=1773368886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2KdgKc3ZvG/UaXzCHXzFbOt9fsK1ZB/lv5DSzHqXIk=;
        b=ddoU+qD81IUqSzi2WZnYxPpsNcMYlWz4Ioigi1uccJImq+NjPcxigw4Nsx8qdqylyu
         +cTEZYc2EiExLmNQQP9omAEgFjXpYDgl+2i1cFbi8XK2lVs43nkc335qH2CCiS5NrwKq
         u9h6ln73mQV0gU7jPOQcv73wpyMqS+fJtlEz65aHsohzjFQqfEnT+0ojWglQYsHlfD+C
         Xlb3LBrkTVqKtxaRn7SRaQOWywe0TiDdnScsh2xU4+jeuiQyQUvyBLqygQRwgSfL3D8N
         OF1GGmzSU5Li14djic0Zg38k/RIaUzZYNECU11yuZAQ2gcM/2X3dDD+0Yxv87kiSmlkZ
         Z2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772764086; x=1773368886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B2KdgKc3ZvG/UaXzCHXzFbOt9fsK1ZB/lv5DSzHqXIk=;
        b=GoF2y69jV2d7cHybd3UeEwsmtHC06yn11DSJYiRZ0c8BxssFR/PaJgkIyHg0xMm+k9
         sOzppX3AiOxHIVA9YM+BCuR1zuI7pc90BN652hOTFHfu4e8DmmSSHSeL86PoS1pWuVu2
         URKlKA57Tzy5vzhX4AZ9E+GQGWiNcTvV3siZN/1ywQgnNfJBoTjScKRWSlKEZQlWJ4XH
         S2hgn/4E1LiMymWGQurQmiyuQs/h5mTLm+AvDmB+iCxNt1o5kS6U0YDaWFVB/jQxKAl7
         hd2+WIOYianeXKhdQhCVFhe1pA7zIoHo77YczAcXOPgHCDYmVm86gRBjEbm6AaQqmEcn
         Fcdw==
X-Forwarded-Encrypted: i=1; AJvYcCXpZOFqkESeEEydT12ed4gfrvzYsSFIZ8L8iy5Hja0FlvbOl89+0pNAUUq/yxd8DsDUGhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKPeTbveikAaIIdIY+zO7aNpqADKPBmmG6PnvwBWWA3DUcnPYa
	/Xwy1tZP4MPY8/HLDQkyJsrQbeGyZx+saCkYNwck/GtZ912HPvHdx9HmqDxvzjXXhgEGUW/KT05
	Cu6gl21iQMQIYSpaUDhyxv8SNDiAvE3Y=
X-Gm-Gg: ATEYQzzryNJQWpgiFKBiDG8u6ISLQ+PyYrqDkJa4U5jy5ZRo0GFZLWGRxUY2h02fWD0
	D/RRIVRhtM4O9PeAbr8U2gS/l+GgrbqZRbmYgMx01eFoNqIOZLYFZyDLajT0+NSEE2D7RBmqTyQ
	bMdKH8EUYpvVnLydt4r403GcfN5Ilqomya1BEwAcpADhhBizO8g7QoL6ka1wuIn0ivd3727G5eS
	an1xugLsy7Z6um+XcrHoALOctMgdanTdAvqMTH+B55N2z36NrHTGNhbBweKi5UEyoPMQEs/SCMJ
	K1WTuoGj
X-Received: by 2002:a05:690e:c48:b0:64c:b7c9:dffd with SMTP id
 956f58d0204a3-64d14279b0amr631804d50.58.1772764086027; Thu, 05 Mar 2026
 18:28:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304074650.58165-1-laoar.shao@gmail.com> <20260304074650.58165-2-laoar.shao@gmail.com>
 <20260304090249.GN606826@noisy.programming.kicks-ass.net> <20260304095415.4d5f2528@pumpkin>
 <20260304155742.7b4de2d1@gandalf.local.home> <20260304214447.3e5817ea@pumpkin>
 <CALOAHbCOynnRdc8JkNJHb-nyoerrz0K5GUhnD8OR2hv4x==5LA@mail.gmail.com>
 <20260304212802.458b878e@fedora> <CALOAHbBA643_QOsnTmrfjKE71hSa+v1cToiELvGk+vjtcgJsxg@mail.gmail.com>
 <20260304220019.3efa12ab@robin> <CALOAHbA4Dtc3cXs2JiQ=kxES3kT+Acb=amUxkOvQ22fns-Mqgw@mail.gmail.com>
 <748e8e0d-5164-4c8a-9bb9-110874c5daa0@redhat.com> <CALOAHbAsiVNC7COL7rCJBdaC-8oZQvg+pjudR4QexQQaYLBmgA@mail.gmail.com>
 <c58807dc-74ea-469e-9c21-0300b80f2a82@redhat.com> <9e4e356e-25b0-4ac5-8d25-ad093b241b94@redhat.com>
In-Reply-To: <9e4e356e-25b0-4ac5-8d25-ad093b241b94@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 6 Mar 2026 10:27:29 +0800
X-Gm-Features: AaiRm51pzOPVYlr4bRz9IM4Ws3QgVJ-mXjKQiEBEVWnxK9TajtP8CzsG3fc6_I4
Message-ID: <CALOAHbBM_4dNRFb28M9-cQG689broOc2QtfYYEM59CjxG3wVkQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
To: Waiman Long <longman@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, David Laight <david.laight.linux@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, will@kernel.org, boqun@kernel.org, 
	mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 2:45=E2=80=AFAM Waiman Long <longman@redhat.com> wro=
te:
>
> On 3/5/26 1:34 PM, Waiman Long wrote:
> > On 3/5/26 12:40 AM, Yafang Shao wrote:
> >> On Thu, Mar 5, 2026 at 12:30=E2=80=AFPM Waiman Long <longman@redhat.co=
m> wrote:
> >>> On 3/4/26 10:08 PM, Yafang Shao wrote:
> >>>> On Thu, Mar 5, 2026 at 11:00=E2=80=AFAM Steven Rostedt
> >>>> <rostedt@goodmis.org> wrote:
> >>>>> On Thu, 5 Mar 2026 10:33:00 +0800
> >>>>> Yafang Shao <laoar.shao@gmail.com> wrote:
> >>>>>
> >>>>>> Other tools may also read available_filter_functions, requiring ea=
ch
> >>>>>> one to be patched individually to avoid this flaw=E2=80=94a clearl=
y
> >>>>>> impractical solution.
> >>>>> What exactly is the issue?
> >>>> It makes no sense to spin unnecessarily when it can be avoided. We
> >>>> continuously improve the kernel to do the right thing=E2=80=94and un=
necessary
> >>>> spinning is certainly not the right thing.
> >>>>
> >>>>> If a task does a while 1 in user space, it
> >>>>> wouldn't be much different.
> >>>> The while loop in user space performs actual work, whereas useless
> >>>> spinning does nothing but burn CPU cycles. My point is simple: if th=
is
> >>>> unnecessary spinning isn't already considered an issue, it should
> >>>> be=E2=80=94it's something that clearly needs improvement.
> >>> The whole point of optimistic spinning is to reduce the lock
> >>> acquisition
> >>> latency. If the waiter sleeps, the unlock operation will have to
> >>> wake up
> >>> the waiter which can have a variable latency depending on how busy th=
e
> >>> system is at the time. Yes, it is burning CPU cycles while spinning,
> >>> Most workloads will gain performance with this optimistic spinning
> >>> feature. You do have a point that for system monitoring tools that
> >>> observe the system behavior, they shouldn't burn that much CPU times
> >>> that affect performance of real workload that the tools are monitorin=
g.
> >> Exactly. ftrace is intended for debugging and should not significantly
> >> impact real workloads. Therefore, it's reasonable to make it sleep if
> >> it cannot acquire the lock immediately, rather than spinning and
> >> consuming CPU cycles.
> >
> > Your patch series use wordings that give a negative connotation about
> > optimistic spinning making it look like a bad thing.

Perhaps I didn't phrase that well. I do understand that optimistic
spinning is valuable in use cases where we wouldn't want to disable
CONFIG_MUTEX_SPIN_ON_OWNER.

> In fact, it is
> > just a request for a new mutex API for use cases where they can suffer
> > higher latency in order to minimize the system overhead they incur. So
> > don't bad-mouth optimistic spinning and emphasize the use cases you
> > want to support with the new API in your next version.
>
> BTW, for any new mutex API introduced, you should also provide an
> equivalent version in kernel/locking/rtmutex_api.c for PREEMPT_RT kernel.

Thanks for the suggestion.

--=20
Regards
Yafang
