Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD223C2F
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 00:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769472144; cv=pass; b=X/juiQwYbBkUYZAeRWIHjDZbQtR/LKgSOKaOjNEYZzbzBOsbaQuHpfPd6K0MKL/cYKhRd0VYfgUlGEeH4z10DIFLsY+cr03KjxvOSBsVKRiY8qogqO0UhdauzmWWLoYQ9eTy6Hht43Z/M0Pnpqo6Y/iq6mBVoKKUbbX87cvVV+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769472144; c=relaxed/simple;
	bh=IIPXp/9TPKFTm3hZW6w44g+x65gkTeld/Y8DdUHzhBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oMrxW5YcKAOwvO7UJyAQpxVKe7dDqjTQnHaYRw8/6qawtZX1jUSym1reABpeFBpayrxEGBtYKatitLTy0HXabSejiOgdjfVlmNjmAyNnlgJALyXwkFhIoWYTikzD7Z+gT1vnSlRxDTTsH6Sg+KL/FiHCopwejq+UnLe/AlHTBbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGgKarFA; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGgKarFA"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c2dd0c24e5cso1641599a12.3
        for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 16:02:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769472143; cv=none;
        d=google.com; s=arc-20240605;
        b=Mu8n2hv0MmVmh27eKMdqw8Rns9ZELCaRAZUYOoZ/uzX2Pta3rWF5mC2oAHd1KlLHEI
         UKh0879S/cgvj6Skk3mNKxi7yz6nYOA0norp03apeh9T/MCjXEBkpMkkd746K/mQ1Rru
         Sa1Z/RMgMQx2JRU9nCtl2qtrZImPo8410p73i+5NS+NF0O6fPtEprpXzEKElYeUtWjlS
         HVyQ78lywLkS9AlfSYByNeB5z9p5DDMvHz98lFaUOvf7h9p08nBpiCNg7lgNUjmSqdJb
         YiZU7xNHpWPQ2iErKzb1OTzbUmVu7yiATWDvUO2dm6VHD7MgG+Vq2Xs4SNuC+Q/3zCxO
         AP1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IIPXp/9TPKFTm3hZW6w44g+x65gkTeld/Y8DdUHzhBw=;
        fh=V30d9EXvxT7qKJKX2frpmmYzaqXgQZ0GWaNK/mWBiCA=;
        b=aHC2RLi1VWydv0nMN29tvhwrZjM9lf4OVqw34TUOOoR/oZIe2B53pX/KyJMn3c2EEy
         81QNnb86eCM73jGWZGPXQeq9TzcsIDfWzpQiTi1+MUdHrMtQVsYNSGffHVLhzxGUr5pW
         xII8Ntndx1iSsMc22jxvgDzl0yWUdZRruQtx3jpuChyGKLpcWlrPSPQVPEov9PvddaAO
         Y5KLMv2BqpDflEq0mdeNKs1AjfpO3c04/8fQq5IyJPNQn621Qj3V9/XCtz9tak4Q8ljh
         ExlfXHsvQcR5I8c3WZFnfDo/iBjzrURuezv0Sh8B0nVeKQtcPWZ/CGa9I3ubVgM5syYa
         1MdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769472143; x=1770076943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIPXp/9TPKFTm3hZW6w44g+x65gkTeld/Y8DdUHzhBw=;
        b=GGgKarFAZEdKX4xMtQJ1cNsNbxku88lDMAlK+xWvC7urIgqNYcaqZ4nDJHU2Kw6F4w
         92/lXFdiaZu/HUZv7YcEcgSowGSiwajoHxhV0FRX8/jHvwqEdT+bGpEXCFc7ovqYyI1t
         srwsRVH7Ky6kwwAIbFgdAA2zEQY+tZpKJRBsUSI8frxOqnu4BSLpdoIMHzMbkL7+Mrks
         FXy4C4gseijhSS8HGA81bzdailMhG8t+a43uO3iCgj4yO3yhFjqsgd8tNp1zZXUcInZR
         HqVCGaHyN7uR3BvBh55jvcZ4y3lEJmyFqL5SyCq9MAiZUWn9QSJGSv/Lk3EN9NYRSOjK
         AlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769472143; x=1770076943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IIPXp/9TPKFTm3hZW6w44g+x65gkTeld/Y8DdUHzhBw=;
        b=MzuzaQMXTCMvzudR49Rj2AT/gSYROM0vZQrqJQ4lHUfn/vPrUTTnRjvcx3UDjaJUZ6
         zbaa32RltMX32W0Ob+ZI5DjukQ8B3NmLO30QKzpZ2m7BPyXFe5ikhFpB4qinSbZtrRah
         4nr9qU/dIFlcr3M/l69w6Nw3R2ZkpCS1EBSvapi/gfahxe6OXpvg1BlT3NIrK5Lp0YeH
         cGWkQx287gOy/7wUAb69667daZc0olL0G9sOysdo8XHs6l9kqsI4jebtewoK5eP0V6W2
         55OwxgRrToAcClGhWYRcT0h+MJqMXorpMmAkde/5x0ziSpZ+6ff8SP/lvyMJ7tLPm853
         GXyA==
X-Gm-Message-State: AOJu0YzTyOSPLbWwQpMOkrtiGKl+Fh8K+gJufPYax8Ro38JZmV6T4FCB
	ZdoaUOGUQYyGLmwPMx9JOggWErJtDvx8xGarHF64LPb4baPbfJfGmvB/0RHhdl7yx5pdAIDIL5x
	XhWfcIROX86U3wVcJrHxBg3FXsOZ+q1E=
X-Gm-Gg: AZuq6aLL7B4rQSCD4yOnM3G67ez+NklluFrS8KHjUtQ+VAzvRd7+15aBZ9Qv/dG9wV3
	U3ld8Rk9Wgsd/w0d43n1dnXNpQkGUjq8CLyNV2a34YlFkttdBy1ifRoxQ0SlFoRHeg3aBsOollb
	+fMABLUejuCgy+Te/wO00U4nuUzj7LtugqB8j8EvAOOFp2wAenNPEgRQSiohH8vkkaBdrEu2DK+
	H+qSOGA9N4K/gR/cwMhEKp+hp1TqsNKIcidQyg4gtZiv/yV4Kw3LZ9FrfG7JXXejcwI0OBiBB2W
	/0VgIhcZ
X-Received: by 2002:a17:90a:c2ce:b0:33b:dec9:d9aa with SMTP id
 98e67ed59e1d1-353c417d7d1mr4175053a91.25.1769472142603; Mon, 26 Jan 2026
 16:02:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126142118.2ea3cf13@gandalf.local.home>
In-Reply-To: <20260126142118.2ea3cf13@gandalf.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 26 Jan 2026 16:02:10 -0800
X-Gm-Features: AZwV_Qh_jrIpsCqz8qC4iF5N5xmk3OFIs7X-uIf6Ubcoe0q7vEvCtBelVa9SucQ
Message-ID: <CAEf4Bzax24jJVDs2bBiJuz1ZuuDihsb5Xq8pGcy18vLUMMLxbg@mail.gmail.com>
Subject: Re: BPF with deferred stacktrace and sframes?
To: Steven Rostedt <rostedt@goodmis.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Ian Rogers <irogers@google.com>, 
	Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 11:21=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> Hi folks,
>
> Now that deferred stacktrace is upstream and hopefully sframes will soon
> follow, is there any plans to integrate BPF with this facility?
>
> Would there be a way to register a BPF program to request and receive a
> user space backtrace when the task goes back to user space?
>
> Basically the API would require a program to register a callback function
> that retrieves the backtrace at a later time, and then during runtime (in
> any context) request that function to be called when the currently runnin=
g
> task goes back to user space.

Hey Steven,

So I've been thinking about this on and off, and over the last year my
view on how to integrate SFrame stack traces into BPF changed
significantly. It now is actually much simpler, IMO, which also means
much less complexity for the rest of the kernel.

In short, I think we should only provide a synchronous way to fetch
SFrame-based stack traces. We will only allow this to be called from
so-called sleepable BPF programs which can take page faults and wait
for whatever file contents are necessary to parse SFrame data.

The reason this is sufficient (and even preferable) for BPF is that we
now have the ability to utilize task_work_add() infrastructure from
the BPF program from any context (including NMI). So even though
SFrame-based stack unwinding can only happen from sleepable context,
it is possible for the BPF program to set up an asynchronous callback
that will run (through task_work "framework") right before the kernel
returns to user space. That callback will run in a task context where
we can wait for SFrame data to be faulted in, and then we can
synchronously do stack unwinding. We return data to the BPF program,
and that BPF program will use whatever means necessary to do something
useful with that stack trace. This all simplifies API design
significantly and we don't need to worry about any caching concerns
either.

So what we will need from kernel's sframe support side is just an
internal API to get stack trace, similar to get_perf_callchain(). But
it will be guaranteed to be called in a nice task context. No NMI, no
irq disabled, no nothing.

This shouldn't be a problem, right?

>
> I've been Cc'ing the BPF list (and maintainers) on the deferred stack tra=
ce
> work and did get a few comments. But I haven't heard anything about BPF
> utilizing the feature yet. So I'm asking now if that's in the works?
>
> If not, perhaps this would be a good topic to bring up at LSFMMBPF?

Yeah, we definitely can sync up on this during LSFMMBPF.

>
> Cheers,
>
> -- Steve
