Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7623BED23
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 23:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788565749; cv=pass; b=SnfAfnJR+IWO1KH3R0cIdKZO80HOlO9obhi292Bhq6F8jJv5vAxZdx8K2LxnjzFO92Kz4Blr1VBpxsTYcT8bBjRXIYCLg9y+SHO1duVBbMCEi+gHWzVkPHdZndvW0GhzeRk+1IO1/CrkzwhGiuiF56erohJNe3/DCoSpsUtLr0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788565749; c=relaxed/simple;
	bh=Jm8vdCNfd/Ay2He2k9+eSmGx7u4UaUwDvdHSixnhBK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GmzY/7mjvZ40i4C+D/Ws2dsNoe56Va2MwmmnudRZaGU6B1O5t0h8qfRup+Ix8Hf3Wc02Jk+1OiPRmDDQj/wiTtTNVe5Z8be1iweOAP+L2oBIaCh2Gi0BwFfxrQ36qOi4AKClU7ozHP3dK67wBrkLrAv3FzhccXVNqLl02LTVie4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/e9l7yX; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/e9l7yX"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cc891373e0so17063535ad.2
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 16:49:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788565747; cv=none;
        d=google.com; s=arc-20260327;
        b=Q0w/YYfUBpxSONhNq8oJrIHTZvpbQ25d7bSOlbCpDXUK0LCUrZYCoAEo1rdu/fMtVS
         U5XnNuR3WQ5ykXw6561IWuhSwRmE5seTwypmFdTZ4x+LDX4xtZRDWgBWKRYpjWl4Y78v
         6Wlo7RVbjobbL77u0akWqpiA6/qbMLgG0jdJ97Ch/M56JXDX4nRBkjLlR85ni0REBaNk
         qQz3Shp9pX4+X/IKVngSe8izaL9raxvP4IOtXUL320RNQcYOzOWd6F+t2XTYxxVEVdlq
         yiFxdo6YerOdySrDmy/f8IpdU2ftmoqaWsIrL6sV9ADUi/1aufX4gidKvyP3ULfL3M0d
         Zz8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jm8vdCNfd/Ay2He2k9+eSmGx7u4UaUwDvdHSixnhBK8=;
        fh=5VuA9plH/6DJNrmO24NsBgMYHnrGdflSI74GX69W8D4=;
        b=pGA4iA7epRpblaP4pS67TKLGsrk1zhjHJuQ0yVpK3rhnb5bdDbmE7Cnv3KfCO08BpL
         YvA0BOjGS9FYUHoTNO0P50pKMOgBNgKVsEDQUuGwdNCYeDrI0BGW0xaStXcJBirsBU0P
         dfotEeZEjm0UWiRDNcf6yXfOPjlRvLtWMECuH4hnfAkKZroQ9zocdNTCkeB7M1rWcjfF
         9+gSf9GVKcjoK9CwfBJ+c+5oki9WdCmGdJG11K/nz0xq5s9iPtHtZzatcNkj4HenknS3
         45OKKH9PnY8wdyD2pBLFwMLsAkVum4xB2nOGtxzSfXgSfzwek9avSZa+3u97L2vH2ipF
         nGTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788565747; x=1789170547; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jm8vdCNfd/Ay2He2k9+eSmGx7u4UaUwDvdHSixnhBK8=;
        b=l/e9l7yXREPCh4IL2BsYxGzRzv6HIN/7sDDrbSNI7F6L/6bMS1NVrZbSUIpQax6lKC
         6rqrckZuoo3iuktLyaE9VaUfNR/fQnLIIt7dasYIY689SklChjv5Gfwxbqp5IX2DdKm/
         Qj7hWsyu6L4r4CGfcDqWy/DlWLaFVe/v/xnLSuR/XGGGKlnUVznTnNdcwdHn6H/WmktP
         HWbHq/qSraoC8ESCLdd/gTU2qJo09nJoubgYyGnL+sxTfs0LzVuhS6hkrqtBugQgsDcy
         iM7rNOZ4eEDo29sn0uDfd7GR9FdNz/BIml5ESYp9LB+NQg18PSwMHa8kUvh/o6x49LE3
         ZCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788565747; x=1789170547;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jm8vdCNfd/Ay2He2k9+eSmGx7u4UaUwDvdHSixnhBK8=;
        b=mXm3IDXpes7uNX54MsYKSZhbHqBBXnekJbfYrIu3Mjju4Hnr2CeWvnAekv5f5VTJFW
         GzvFsyo7cdeVK1jQwijnpdjbV0dEflpnJxBiVTTt0tMV/gwzdD6qeV53gqeXUOaXGJwW
         H6AEECe+aBVp0ApmyOUhCotKmTCc2Lzya9vJtOyJEXbL5Wm3A1Q2wRj3Vpdk/MolRVGR
         Xx5KxfuHX8odUMu5SpES3DouBWnihTjQS4mFBRkmO/5jquSj5mGW7DRHf6Xs70ugxSFu
         buOTajvDihiY+/+WhjRIk3aqkm1sGIgE8yCAZnxOPCSXSdwAGVYk8arSJYhqto7EJQpb
         /oQg==
X-Forwarded-Encrypted: i=1; AKwUvBwZzQyw1z85R4n8F0tbwSo3X4gCQ/L1IeahENZwW0v2qTS7itPRLa4IDXL0ryzoD4AbdvE=@vger.kernel.org
X-Gm-Message-State: AFuF++lLAJff+D78PiJA2bbACqIUNZLxtyi5PxLuc27CzPHiAqe98dOq
	H7sGHuITUln9H76cR4zzdIBQist+cgrzZpQl5o8gk9jo1s7PhN2GTNHUfAaQpeZYbbBRo7W1AYB
	eC5Q/+m2MtNHXvzRpcgJvx4MVdUIHgN8=
X-Gm-Gg: AYBFou2PQeqKJwnrzmJYNw77PQhwMnkBJYigb2FJUVck+SMf3Y+JP/i2A25emCxDuzt
	r+BUyJJ2xvt+7yqodcE7gA7UpeHiS6v8QGfwjSpGVq6/J834RwWwuZJle3Cn4YurP9WkySAFeOO
	eZGCXS8Fd/gZzdhSpCtvLgrTYSXew9EUOR/nLc2wiXhhS7CemTibsiDC4+kqNEOfSqeNJ3DNK2g
	zWHQNpIDI3GKIxc0BKWswmBEbp7tyo669S5WK/9dn4UnPv5EAcSE3hhYR6043xVWb43/qHTr9TL
	KMQbgMRLD7QDKqUlU33WAwgEG+Pu0MBsMGcLRmtq/05XuXwmHHNaHrZ7QVswk4VKqI2lyn7EByT
	Ma26nfc7iiOTXvdKLlkoRD7NOFRBq
X-Received: by 2002:a17:902:f64b:b0:2da:eccf:751d with SMTP id
 d9443c01a7336-2db126b5ed0mr134284105ad.22.1788565746899; Fri, 04 Sep 2026
 16:49:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831090524.106845-1-gmonaco@redhat.com> <87se3sakgi.fsf@yellow.woof>
 <df6e9168cb06c35e21db7f9d17cfbca6bd87005b.camel@redhat.com>
 <DL5B40CU17WD.3KD75URQZ6RRR@gmail.com> <eb3dd8158942d663ec8ad4c529eacd666c5f96d9.camel@redhat.com>
 <20260903090211.50d15220@gandalf.local.home> <CAADnVQK8e1Qp9rf1zThZxb3vr4Gc_bpo0nqpEO2LdnEwHdKokA@mail.gmail.com>
 <20260904074317.01b2c0e1@robin> <DL6O0KLPXLTA.2HJJUXQUVCP5@gmail.com>
 <20260904123108.1fa1d815@gandalf.local.home> <20260904132421.111c0279@gandalf.local.home>
 <DL6XBKITK7ZT.3RXK9YGGUYZZE@gmail.com> <20260904194620.0c7a8363@gandalf.local.home>
In-Reply-To: <20260904194620.0c7a8363@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 4 Sep 2026 16:48:55 -0700
X-Gm-Features: AcwNN1UvoLinoXtZcq6itqX2kSBVjcDjcnqMchnOOVOg6FzMAYIbCDpQFn9LNIs
Message-ID: <CAADnVQJH1SYR_GN6gewF3w_z_Sex9HFE1T1oXkQe6+v18bDTWA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/20] rv: Add support for BPF monitors
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Nam Cao <namcao@linutronix.de>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Wen Yang <wen.yang@linux.dev>, Tobias Schaffner <tobias.schaffner@siemens.com>, 
	Viktor Malik <vmalik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 4:45=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Fri, 04 Sep 2026 16:34:00 -0700
> "Alexei Starovoitov" <alexei.starovoitov@gmail.com> wrote:
>
> > bpf in 2022 was surely less capable then it is today.
> > It took us 2 years of bpf core development to statisfy sched-ext demand=
s
> > and we're still adding new features for sched-ext needs.
> > If you're trully willing to remove 90% of kernel/trace/rv/ and refactor
> > it into tiny shim where all of the core pieces are bpf driven we can
> > certainly work together (like we did with sched-ext) and add whatever
> > is missing on bpf side. Then all existing monitors will become bpf prog=
rams.
> > But adding bpf as another 'monitor', sorry but hard NO.
> > If hardcoded monitors was a mistake then admit it and fix it by deletin=
g it,
> > if it's not a mistake then keep adding hardcoded monitors.
>
> Regardless of whether or not BPF can replace "hardcoded monitors" today, =
it
> wasn't a mistake back then if BPF wasn't able to do it when they were fir=
st
> being added. sched_ext wanted to use BPF for scheduling as module plugins
> were nack'd by the scheduler maintainers for a long time. BPF programs to
> handle scheduling was the work-around to that, and basically the only way
> forward. And it still required special hooks into the scheduler.
>
> The rv monitors only needed to use tracepoints for hooks. A module was th=
e
> easiest way to get there, as BPF at the time wasn't an option.
>
> If you want to use hostile language like "admit you made a mistake" then =
it
> makes it harder to collaborate.

If you're offended by the word "mistake" then ok. There is no path forward.
Keep adding hardcoded stuff.
