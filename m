Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EFF414416
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 16:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488477; cv=none; b=jr91eT4WNM/uf03fN51tw/yxyjqNxQ0HpVzKz3RtIbzawmqmciRTIY0OeHqY6iPbT0cPxban1dzBkgtE8KAUT0F+KWnNA11vor/V1hKj10OIFhklpJfp4TAu+YjYYSRsfDFycf3EVyDWKPIuA0Ktx8JIxVmWWRgVJX3f9sWZOFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488477; c=relaxed/simple;
	bh=TaD3IKHcoZf0PQ+wUUh3mHvOgYZf6uXYuUZRFHNcE+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kcQXQHwF5WJJ7ZNlao7zB8zI220fgb0sJvE+kCz+VplAYHFFVKSuLdhaiHTKXtMuAdn1XRXT89bBWSpyouH/pRrpX+bUeqpPvqDE/VHT22m0j6c+l+OQZV0NtHYBe2R2pFJ4gXdzOxG4CgWwx6Xwn6EpIVDs6iqETVhPKb48Fa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=agmq+AGs; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="agmq+AGs"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c293c683202so503051766b.3
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 09:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789488472; x=1790093272; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cj8iWYGkmy9fr6Sp+MjBMi0cvssqzarl8Tgut8FUMEc=;
        b=agmq+AGsR9ewjxAqeJxWV21/cUDT6fr+gu6Q34cLYJxN631pWIb+MIN045yqFXjaEf
         v8D4B42ulM3vTyxukkh03Sj9kSMqPO64XjZ+ooLzGTqQVBZ4rQneuNqw5ICAc7m7UX0r
         4JC8/HKuho2msW5kYnGgGWgklkxJnQyCmIsdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488472; x=1790093272;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cj8iWYGkmy9fr6Sp+MjBMi0cvssqzarl8Tgut8FUMEc=;
        b=RRsmvN+PvVsialJ00lh2W1GN9Vm+Wv1eXX6AVLweEF6wLwY2B6oCLWq2TFmynFG/Ov
         i8BmU4FRSZCOM2Zb0xrcob101KKyt4WRZvfHfsY5NatoJjPIoXwCMoUdilMhdhRrAfVA
         PPDmtfVl2UBUvWeKxJODm3bxcuZAwVDbCP74dk+9VRY/+OlXb8+gLdYfvEIDEHpmBIf0
         pODpf63YhXh1LgNd7FHuCSqyRsBYoyx1CIWzh/NXVrawd5kj7WRvOGX2WSLN7PVK7sFk
         MQpXLMxZ4iEIF3QyA6lmtPCnqE08uRFakWzePVwWmielOwMUFwLRWFGJwrjXg6Lhgg0i
         K7TQ==
X-Forwarded-Encrypted: i=1; AKwUvBwgV61gAc/PfFVrhKPW6YJdrawXe9yRurFxXIm1tjZ7hJU6NyZZplI5qx18FvCymvbwCuQ=@vger.kernel.org
X-Gm-Message-State: AFuF++n8UxAGqPmF8iR6JEW3w7urpI6POzhrxXtYUDmGs0wlZkFDb+of
	Ojcnuj70P9qvv3xOHA5cEyHt1kdpJpjPJs6HZMTHcGGCxLZPLP3+oLvgU28p3q33Y/XgGC11y6m
	ah3RBfFE=
X-Gm-Gg: AYBFou1hQrKWKF+hCfn2Rln1SSPPVvRKXAMsuvp5DM/XHLmkNDOK2KRWMlaf/lwPmLK
	nK/S7yaO5NUYBgZyW1f+JciJDCyh8JxFOFXV/7jbCu4xONN0qaiwMfODoptIq5wmFSzno7cZOYt
	q81UWEoxUGL9gKYqiLylgL/gn4hHeJ84VEI04ldqRu2bf0MUPDDIpGtobyYBYAUTSk0AEY2wNRs
	FvLIB0KHmzTc9pHHfCnUsYXlMTc7loERsTI3vqHxZBgzplpzJhT1ZMygS4DLZ07K+LAPJX6Frkv
	rQsUxjrfpH6AbMrzg38/dO2kRDFDkxF/TVCa6507KDW6D8Za741WD6GXn7qWmN4Fq8Ne6H1jVP7
	vx8LRMT9nZfxGUz3cT9/rJlhsU7I2jA5BUz550uUIQd/z9vvQq1rPfhNcGM1xAQlgV0R1jznWla
	GLN3RldbvwMafHsGo4wnotj/wPe6jkIbZHv7vZCbVpH4I7742YGaNTG7OqYTErraLBUYIXfcGR2
	AlbZ0CloSH96cedUj7EEQ73gy6QIvc1ihBWDxFwdghIUzOptQ==
X-Received: by 2002:a17:906:c112:b0:c26:2ff1:cac2 with SMTP id a640c23a62f3a-c29b86f9353mr506769766b.31.1789488472342;
        Tue, 15 Sep 2026 09:07:52 -0700 (PDT)
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com. [74.125.228.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de63a7c8sm360566b.51.2026.09.15.09.07.51
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 09:07:51 -0700 (PDT)
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa4c24cso538118066b.2
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 09:07:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwuK0yHw67amQtINopRT1McXMwszUk9GdKWY8/RJdWrDM+Y/DcNsKZGDWFOJmPwJqwqdT8=@vger.kernel.org
X-Received: by 2002:a17:907:cd0d:b0:c29:439b:d5c1 with SMTP id
 a640c23a62f3a-c29b86141b9mr553591866b.16.1789488168046; Tue, 15 Sep 2026
 09:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 09:02:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
X-Gm-Features: AcwNN1WK06t9f9BcKFBIanysXcyUXK4eRICuH4x14s60AdlpF6ijCATIYaYAAvQ
Message-ID: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
	David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Sept 2026 at 04:31, Christian Brauner <brauner@kernel.org> wrote:
>
> TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> allocates a descriptor like get_unused_fd_flags() does and records it in
> a slot on the task. fd_stage() attaches the file to that slot and
> returns the number.

Honestly, I am *not* a fan. At all.

I think this adds complexity rather than removing it.

The diffstat tells a story:

>  106 files changed, 962 insertions(+), 861 deletions(-)

in how this adds a hundred lines more than it deletes.

But to make things worse, it adds them in bad places: low-level
architecture assembly code.

Those extra lines are *not* making complicated code simpler. Quite the
reverse. They are taking fairly straightforward "just deal with errors
with normal cleanup in the place where it makes sense" and makes the
*straightforward* case simpler, while making the big picture more
complicated and subtle, and adding new code to places that are not
simple and just blindly do somethign that makes no sense in that
context.

IOW: it's more code, and it's more abstraction, and it DOES NOT HELP.

And yes, most of the well-maintained modern platforms (read: x86 and
arm64) use the generic infrastructure and they don't show that
low-level asm effect. So for those cases, it's mainly just  that added
conceptual complexity and a new odd rule - and makes a *successful*
system call go through that "extra work" and indirection phase that it
didn't use to go through.

So it just spreads out the work, and moves it to a less obvious place.

All for the very questionable advantage that you can now randomly add
a file descriptor without the few lines of fairly straightforward
rollback.

IOW, I do not see a single real upside to this, and I see immediate
downsides to it, and a more abstract complicated machinery.

I do *not* see why we woudl want to make this be a "every system call
exit" kind of thing. If there are places that think it's complicated
to do, they could have *their* local little stack of fd's pending. Why
force it onto the low-level system call entry for every system call
when there are only a small handful of actual real cases (the vfs
itself, and random ioctl's by odd driver subsystems).

              Linus
