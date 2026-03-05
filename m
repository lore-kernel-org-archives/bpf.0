Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DF345BE3
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 02:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772677067; cv=pass; b=UKvoAdUub+dALJ7hEBvTjXodbI7HykUHSrwbS/1Qf6L3/QxidyYiujAPZEb2aNAG5wQ1BiWcofXJ9L9Uwpl9yTCXQH+1RHrwBMIKGEalgYpSTyhZw+M5PY9tRYTB3kPrtBkizyc672FTqzTLHM5/JfUjnO1N87gZMGCG/JMlmNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772677067; c=relaxed/simple;
	bh=AnImdXsVFvgLb5gdQL2K8lpR3s5gIBl6dS0AXo925Lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZolZDvuz4BnODKiFedoErCGWi3NEQizRLlaLt9fmHo5lIsmvxeV/afr1Ix5qYrmyZR2Ld4fq7EbAZmeUR+9oGt9EOC2Zh4yW4wLPtVDrJxKOoSH3n1bVFjBAPKJOUBFj7W7s1FFrcu0DzjFvzHda17Pcjn7aokVhQSm09FlO3oE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIeLP0ui; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIeLP0ui"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-798617c0ad5so41420537b3.1
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 18:17:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772677065; cv=none;
        d=google.com; s=arc-20240605;
        b=SowGcRWA29AN8CqkmEpO8oI5ygrT+t1kSUhXH3VUuHLOk6rDy7MByhrJhfIyXbU69q
         eO5QVTON86lXB11taxpBsOQl8Zda2NpVhkmT/tYhGerRpE7JS6NanvAhfLZmrVCFmmBm
         wj5gsL23UsC1E09gn72ghPxb9V27rsFQCcHv2YM9nNh22ocHvLqqMtPzxCopUix/g+oS
         lmKb3ZPb4Z90wR/4O5DnEI4W9NvNi5T6qQoBOkMaOEu2edYK76xlvQ5rsGv3z3Z7UIKY
         Q3FBcgCu58/UBKZsuTA43UIbMb56AlFji8mZ5dDok2ueXsHCGP+iXL7syjfUlfjB/CiC
         IGQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wf6PBwMbIBnUQRk0bp0BIzPLAUcj7RdN+ZKVe4spH0M=;
        fh=Fzu8dE+Qi8A/VZA3EEF4UEbc61bCcIaiUCcduUCNc5k=;
        b=bHREafUM0JEkitUq7LDZTD2x+UkiJh78pxopB4RrdfHoXguLDO0Q5oOrSH1NrGU8JE
         56fj+4jTMLRrl6QuD+Edf6TqkOt9+7N0ZChInW5F9qlkkjEcxaRYBma49GLg7oatXPWQ
         7vojmWfdO27SeuZZlkUa4pbksRkxaTjGxXU9MkdWl3dXikfaQoHz1TW3YIJmqnYkFykB
         /evjKdCPghKd+6wxRzKs7wVvS7BImd9e6O0/Bl1wIQ8WfekGwY1qoTbMv4ePNZQo5LeO
         ujC2SfN2tO0jZSwndraCEDOIoMOojNB+SN+0Dsz9P926u8GeL/0mWA9gFmxq2p1cCGer
         uwQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772677065; x=1773281865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wf6PBwMbIBnUQRk0bp0BIzPLAUcj7RdN+ZKVe4spH0M=;
        b=CIeLP0uiXioiAn+yJeMS+VZxBUBQHDAPMiP1F0lhw5fDCIE/T+z7PbaOwq2eotoevA
         Zfl+wkHFL0t82IHyxI5Ybs+n4ZHlnFMeuPT41R+vPXzy1sDzK8OzjVtec0KqATdb8JaS
         vN3QUQdPwXwcZByTBdEhTBs51eY9lXMMECO2qnu6F8jriN7MecT6JnkBfzMLyJoLQ59l
         tFpmZZDO0sTPJAv4H7kuNwD9zY28QXLhlrmmPYmwSifOK+1Up3nPxXitX6cGlV01MDfm
         XpE9HMUaxGdjtAmhpXyX8NHE8zS/BFHkThttdnHCTdOR5gGNIOrmMDLJZ8mwJpVKVvJr
         74Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772677065; x=1773281865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wf6PBwMbIBnUQRk0bp0BIzPLAUcj7RdN+ZKVe4spH0M=;
        b=O6+5xSsq286YI0xi1lxYyFFov20fK9G724WYep5QneqIUYrd+p+sjQ2p1mU+LWRbBX
         3+BePWyxlP2Ph08pX99XDB9P/G+Z744adnVIpKwC3UZF8Ff9KzC/fTRr8Ur6GDNKdcpM
         +nxgjhfUb33VHmk9kUMIpnHA47d7Jd+C8H9fitdNvrMOmCBueRWBW/jWd9L6YIQKVEyG
         7se62EnBZE0lecCEOKY9ON494B4oMQncpp+D7cN+tkUDZkqEWgisPrqULWk4mH3oN8JS
         6LCfggrttqZH+Axt3jvOwfDgSuJXKV5h3u08nDwsfq5sJ8KfRQAYYhN+IHQF/DyZzEJo
         tdTw==
X-Forwarded-Encrypted: i=1; AJvYcCUZbU+plmVb50gNUg0D3KXw7CR3nf3M0wUQBdLQzDxTqNSAbBAfWNhKwMSdLOWsZoVlmhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTlwtku6IBtR2ZHvBBhHSw0ylnAf4flDFvRg0B/ctqOYmWJUtH
	hG1BGz1Lbjevwikz2KyWLiq/sAKy9vcDo8eipOSB85oDSOfNYqLOb5lU4ApmbQeLAG9nifotjzk
	9U4RdD/Ge+NT3lepyhzQe1e+eWnTEmBM=
X-Gm-Gg: ATEYQzw5/P63XBAmwf2ELLrMAWyDMr5jsuIplwCAeh5aJzyP8snS7vwXaMEHxEcUXBa
	abk+fp8UUFX+ATfgN7cJEnPNXWeE1G9l32a6mfW+VbCJmiryFzwcO6tQGxvZmULkWT7kv0w3pUl
	jYHhr7hBuJyxGxRr+KGB9W3bbgjl/onfimoP+7lcP1SZjsD6zdigJEXCGvZJhPr8W0ZTjLzpdy3
	PVKgvFA/faP6zKEe0a0G+D58q12rEJWUGpZ5xRAPock4DAoPLAGHxAiYgKC4MbU1dUkh/RDbyoL
	1Ae568Wa4u0K0fr5038=
X-Received: by 2002:a05:690c:6983:b0:798:806:2c7c with SMTP id
 00721157ae682-798c6a3d49fmr38703247b3.0.1772677065588; Wed, 04 Mar 2026
 18:17:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304074650.58165-1-laoar.shao@gmail.com> <20260304074650.58165-2-laoar.shao@gmail.com>
 <20260304090249.GN606826@noisy.programming.kicks-ass.net> <20260304095415.4d5f2528@pumpkin>
 <20260304155742.7b4de2d1@gandalf.local.home> <20260304214447.3e5817ea@pumpkin>
In-Reply-To: <20260304214447.3e5817ea@pumpkin>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 5 Mar 2026 10:17:09 +0800
X-Gm-Features: AaiRm517NI-rro-7jVK939vPf8BuH7oxAu9WZEv4kjAdWxvubVT-CJWzMHbZ090
Message-ID: <CALOAHbCOynnRdc8JkNJHb-nyoerrz0K5GUhnD8OR2hv4x==5LA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
To: David Laight <david.laight.linux@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, 
	will@kernel.org, boqun@kernel.org, longman@redhat.com, mhiramat@kernel.org, 
	mark.rutland@arm.com, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 5:44=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Wed, 4 Mar 2026 15:57:42 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > On Wed, 4 Mar 2026 09:54:15 +0000
> > David Laight <david.laight.linux@gmail.com> wrote:
> >
> > > That might still be an issue if a high priority process is spinning.
> > > But a %sys spike doesn't imply a latency spike.
> > >
> > > Is this using the osq_lock.c code?
> > > That will have problems on overprovisioned VMs, it tries to find out
> > > whether the hypervisor has switched out - but ISTR that is flawed.
> > >
> > > In reality a spin lock shouldn't be held for long enough to cause
> > > any kind latency issue.
> > > So something in the code that reads the list of filter functions
> > > needs to be done differently so that the lock isn't held for as long.
> >
> > It's not a spinlock, it's an adaptive mutex which spins while the owner=
 of
> > the mutex is also still running on the CPU. If the spinner CPU triggers=
 a
> > NEED_RESCHED or the owner goes to sleep, the spinner stops spinning and
> > goes to sleep too.
>
> I think half my brain knew that - otherwise I wouldn't have mentioned
> the osq_lock.c code.
> That all reminded me I've a patch that optimises that code a bit.
> But I do remember thinking it ought to have a 'I been spinning long
> enough, time to sleep' path.
>
>         David
>
> >
> > Honestly, this still looks like a non-issue or a corner case that I don=
't
> > think requires these changes.
> >
> > This looks like one of those "Patient: Doctor it hurts me when I do thi=
s.
> > Doctor: Then don't do that." cases.
> >
> > Why is a production system having multiple users cat
> > avaliable_filter_functions to begin with?

bpftrace is a widely used tool for online debugging and dynamic
tracing. However, sysadmins may unknowingly run multiple bpftrace
instances concurrently without realizing the potential impact on
system performance.

If this is your answer, I believe we should clearly document the
following warning:

  Warning: Do not read available_filter_functions concurrently, as
doing so can significantly degrade system performance and potentially
impact production workloads.


--
Regards
Yafang
