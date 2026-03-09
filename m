Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D1A2494ED
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 16:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074734; cv=none; b=JzY0PlNSMZKT+1RBEaEJwCx6PGLZIOY0hWP0Sk6c/JdYOwpA7awBtyEqD3u/osMZWiOKTwX6oIyde9U5qjbk+Yu3iaT+oUmnRaaDGGfS3JfCla85PZKGOyHWMabvf0DPZUk9j7EkDJCYxbFe11Yxh28ALsf6YZU+ii/qQkEL4Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074734; c=relaxed/simple;
	bh=zAR72wDXdxq5C9PjPsyeD4QQxyEK/1hXtEl2Xpss9d0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WmZCcU9bFaP27HjCdyFzN8WHwB+Z6DozVEW7jX1H8kGHf47SK14bXxKaT/kL2gxIijMrbjHRbP8u4ZyYl6vkQ/yj3cnbedjgC69fB1T9ZZq0wVM+Jl0hL6svyy2secxCb3+FU7Q7eC82vncgdXU1XoT6dC/7vfucvf47gISpvtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D5jINIZ0; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D5jINIZ0"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-660ea6ceb5aso7979903a12.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 09:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1773074731; x=1773679531; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5aGclf2D5Ad+FZRYNo1Igm1i3XSKWX/TJgjzbw+i9o4=;
        b=D5jINIZ0SJ1eMjToj0ZyLoC9gUATikIGHw+K7PJ4ARcB2lO6P6aIWG++AydC/803J3
         rQaV/nbkGTwjwauzC69iZVXrCSKMjf+yWD354zJ3DhVUgZ3QV1FHTbwDXRcAF7PC2uRk
         BKDB82EcvJ9j40pt/XPVMt6OQ4o+YXW2Yapfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773074731; x=1773679531;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aGclf2D5Ad+FZRYNo1Igm1i3XSKWX/TJgjzbw+i9o4=;
        b=wUpfNSumP2wzzTYUaIoYGB76aK6aMdRDC8UETvDoel8CW3Y3Uvvb/IlEi/aVENZdoo
         umwwlvbuGbKaCK1s6sTcrr/BLvu2D80kvWjHYybWEtRMsNbgWLhyGxvEkT73lRf/AY2r
         Y+xDTS/F1cwxMWnsz6f/NvTQPutrfmVpS1N54eezBMNIk8o3CS2mitbvstZSUUhBtZDZ
         +FNhxS8ohzkeEzmPrnZzD6zK7II5RIYdUGBvLWYqIgpga6FmHV1tn8vilOsef9IFwdgO
         ChI8HC6rOJ4VwiMaa62XlU/usvXzU+M+D2pRSec2vtyc5Y0oaOU6O76LZG6lM8Qyv1+3
         NHQg==
X-Forwarded-Encrypted: i=1; AJvYcCXuncI6xWj7URuZJD+rbpv7NOOKvS0FPulZv8PexdgjeTm7g/VkwWM9v0DdF7buv9OPMyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+WLgNGPPEJ9SRZfehZm44aY1t4myxSSisv18iDYMeAvJjOj/s
	08WqvcBKZ+gTq6ERc31NSfO+eMf4sRfw9k0RRa7FNkk1eK7GihDiTIR80Yrq4kIjiAVH42vtg6t
	k4mFgekA=
X-Gm-Gg: ATEYQzyJ6mm0EALeKSQw9QnH5xMLA2RKJ0dFdOzKyd5gJ4pNjkwOQxf0+WQHY0kz6wp
	WR3QnNxNKA97/1ZrgSHWsojNB+CySPrlU68I0h0HBEP4GJpNlm9AJ6UES+5Rc5k4rBe8EsO062k
	/aPsuhgnj+pzRAJwyzojBsSeMI5rxKmwHhai1Sfrd7l3gaqKaP7HHc/hyViKh85KuVZq/GPfv/D
	r778PUGtijxWW0pgbjUE3GB1uCI/wFi8CYOL6hfpc3HWlzimWb+NpYvghHdetGQycMD66woGEil
	7AKCBwR8CJeqSI3X9sTFSSpRda01X+sY5/zDCDCD4tZP7d2aEiZSDFFAqPasrsNv/OnqUmRZKkQ
	Z238CmTs7UPzlnca/c2b2kQyTHKk6yn+IAd0w+pBMwZxjND5X+Fzy4VhUwRB/yGwooW0KNBlRrl
	56yQQJHzHMWdp2hOl/bklm/XXRFTUxmBOXIK1JzLVWlzt+5X7si6W/yW3VzruQ6VY9spJbAk8q
X-Received: by 2002:a17:907:6ea2:b0:b8f:dec3:6606 with SMTP id a640c23a62f3a-b97119cc65dmr14662066b.23.1773074731213;
        Mon, 09 Mar 2026 09:45:31 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942ef47ae5sm378504766b.5.2026.03.09.09.45.30
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 09:45:31 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9423d62cbbso456330366b.1
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 09:45:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhQGki2kd030THw6LOM401BlsA2Nk4NRutiQtZNej1ArhWBQoUdP+supXVffz33S8400s=@vger.kernel.org
X-Received: by 2002:a17:907:3e10:b0:b96:e1de:db04 with SMTP id
 a640c23a62f3a-b9711a1fe33mr14904266b.18.1773074262570; Mon, 09 Mar 2026
 09:37:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1ff1bce2-8bb4-463c-a631-16e14f4ea7e2@arm.com> <20260306-work-kernel-exit-v1-1-8f871f6281cb@kernel.org>
 <aaroReSCj1qXUeQb@infradead.org> <CAHk-=whCiPr-cR3hVv=46Qo0Nw_vN422YUxqU0GmNai+KRtg2w@mail.gmail.com>
 <aa7qson15uJpL-BL@infradead.org>
In-Reply-To: <aa7qson15uJpL-BL@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Mar 2026 09:37:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_kwtWt4Swi=k2zJTnStoBaw3vneHz8ccVNDyVD1nvWg@mail.gmail.com>
X-Gm-Features: AaiRm52k8FmvIAxaWFSwelL44z7-IyhgZowK3grBWDh2zbSjeLnGfYwalrLVlLs
Message-ID: <CAHk-=wi_kwtWt4Swi=k2zJTnStoBaw3vneHz8ccVNDyVD1nvWg@mail.gmail.com>
Subject: Re: [PATCH] kthread: remove kthread_exit()
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-nfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <raemoar63@gmail.com>, Christian Loehle <christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Mar 2026 at 08:43, Christoph Hellwig <hch@infradead.org> wrote:
>
> Because it can't f&*^ up the state of random tasks.

Christoph, you make no sense.

"do_exit()" cannot mess up random tasks. It can only exit the
*current* task. The task that is running right now in that module.

And exiting a task is about the least effed up you can do to a task
when you are in kernel mode.

Compared to everything else you can do by mistake - like just
corrupting task state randomly - it's a very benign operation, *and*
it is obvious both in source code and in behavior. It's not like it is
some subtle operation.

I'd be *much* more worried about actual subtle bugs, not somebody
explicitly calling exit.

So what is the actual problem? No more random rants. Explain yourself
without making wild handwaving gestures.

Now, there are real exports in this area that are actually strange and
should be removed: for some historical reason we export 'free_task()'
which makes no sense to me at all (but probably did at some point).

Now *that* is a strange export that can mess up another task in major ways.

[ Ok, I was intrigued and I went and dug into history: we used to do
it in the oprofile driver many many moons ago. ]

And since I looked at the history of this all due to that odd export,
that also made it clear that historically we used to export
complete_and_exit(), which was this beauty:

    NORET_TYPE void complete_and_exit(struct completion *comp, long code)
    {
        if (comp)
                complete(comp);

        do_exit(code);
    }

so you could always do "do_exit()" by just doing
"complete_and_exit(NULL, code)".

And yes, that function was exported since at least 2003 (it was
exported even before that, under the name 'up_and_exit()', and that's
the point where I couldn't be bothered any more because it predates
even the old BK history).

Yes, it was indeed renamed to kthread_complete_and_exit() back in
2021, but that wasn't due to any fundamental "it has to work only on
kthreads". It was simply because nothing but kthreads used it - and
because that was also the time when kthread_exit() started doing
*extra* things over and beyond just the regular do_exit().

So it was a practical thing brought on by kthread changes, not some
kind of "exit is evil" thing.

And that "ktrhead_exit() does extra things" was the actual bug that
needed fixing and caused nasty memory corruption due to subtle lack of
cleanup when it was bypassed.

End result: we've never historically felt that exit() was somehow bad,
and when we limited it to kthreads and made it special, it caused
actual bugs.

            Linus
