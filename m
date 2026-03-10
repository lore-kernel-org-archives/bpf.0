Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21A23A4F49
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 04:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773118575; cv=none; b=D6lol0m6V5+hK7hoHrbV41rZ3mKeOkAeBr0Os0rSTlPMnPorV/8N5T2cf1te4RSJKWOc3rqGS8+6FAAZI2ISeG9uk2WtsPP1ul1KacJgBn9Lnq5IO6Ni3HtB89Wf6vWaL5u1OHEwVn0nZBJ81o34Dhist2u4yEaFo9ObyiCn5vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773118575; c=relaxed/simple;
	bh=aogT13pYARr8rQK7bpK5fGUFk3CEcbUwIg3g9ISAtwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1wSLmFF1unk4Cuz2i0I/A4ApMlZKNqp+qpS1gvfYLv9xdi6+hcbnwWhjtqdlnoyoOsbJ4u48Su9Uu7qMjoH4OVnaf1Ud2tE6cwURp1IJ5U0cM4qK2GY361WD0yzxXP62kSBvjuPRpwuQpGTdhAlYP4r+GDaUNvH+3S8N8JyO3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByDttPSP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByDttPSP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE40C2BC9E
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 04:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773118574;
	bh=aogT13pYARr8rQK7bpK5fGUFk3CEcbUwIg3g9ISAtwk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ByDttPSPD1fNm7yo4fGxWG01HQs/vsBhykcycVEIlw6PpDauLC/xyBywTJOhVyRD7
	 fJbR4wasnYnwCNamAvtaQKdycqa5Rl239zGhV3Vn9V6kxU0i5xDP734Yta9CRDzHYE
	 Y9fmzChjDJQnWjZZaNNaPAGX+COcqZeTzFyR4ZuvU7BfnCRLm7yVvC0wYgJIrH+a6O
	 I0to46EX/4rXmxZ61Q+5tuahE1dAJOpPubgd1HbrOqVCBcwrY2n3zgJsvuhYq2pgDl
	 WCjYDeHd9XlQ2DExaeXqTLK/1oPRCAurDOom/XoD27BIjmbIm3FhKxGoXsaxbso/nB
	 qqGEQdDUje2WA==
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cd78a4ce8dso356562685a.3
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 21:56:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXY3Q1poY+X+LtS766f1jWFvlOiXR/xEAzsMfOXE3DQi7upFQDLILGByseG7ROPqUNO2/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaA5ighVKYmSUBX+Fr7ms3lMMeWKzGdW23HEFzaNEoTJncjOVJ
	stPp0DANCHWzw59q1WEU8BiR8Hq/7/Q31P/wzNv3NsGDppSNZkwgs7XWqPMn7XA7aufnJ/p5AVX
	KHCZDHySL9/GiD+t7rqtMpisiD7b3/to=
X-Received: by 2002:a05:620a:2549:b0:89f:8bb8:c103 with SMTP id
 af79cd13be357-8cd6d4b4f11mr1698855085a.49.1773118573780; Mon, 09 Mar 2026
 21:56:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309131635.302424-1-mahe.tardy@gmail.com> <42d449a1-a67e-4ebb-bf89-272072ade681@linux.dev>
In-Reply-To: <42d449a1-a67e-4ebb-bf89-272072ade681@linux.dev>
From: Song Liu <song@kernel.org>
Date: Mon, 9 Mar 2026 21:56:02 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7GWYoXJnadkbV2JbD5Mu6Ta-DdZcfhCM4XBsMr8DEJSg@mail.gmail.com>
X-Gm-Features: AaiRm53jO6ytbHaDiKngxLD2iQQrSJ4MoHATNJgrfy4WwD4k0TUpJvdjCphrgU8
Message-ID: <CAPhsuW7GWYoXJnadkbV2JbD5Mu6Ta-DdZcfhCM4XBsMr8DEJSg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/4] bpf: Introduce bpf_netpoll
To: Martin KaFai Lau <martin.lau@linux.dev>, kuba@kernel.org
Cc: Mahe Tardy <mahe.tardy@gmail.com>, bpf@vger.kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org, 
	andrii@kernel.org, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Martin and Jakub,

Thanks for your comments.

On Mon, Mar 9, 2026 at 12:29=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 3/9/26 6:16 AM, Mahe Tardy wrote:
> > This patch series introduces bpf_netpoll, a set of BPF kfuncs that allo=
w
> > BPF programs to send UDP packets via the netpoll infrastructure. This
> > provides a mechanism for BPF programs (e.g., LSM hooks) to emit
> > telemetry over UDP without depending on the regular networking stack.
> >
> > For reference, this was discussed at LSF/MM/BPF 2025[^1] in Montreal,
> > and again at Plumbers 2025 in Tokyo. Liam Wisehart mentioned this work
> > during his presentation of BpfJailer[^2].
> >
> > The main use case is to be able to completely dispense with
> > agents/daemons for BPF programs after startup. In the case of
> > Isovalent's Tetragon, the idea would be to be able to emit security
> > alerts or export data from BPF even when the agent is down. For meta,
> > according to Liam presentation[^2], this could replace logging via
> > ringbuffers which created cross-binary versioning issues.
> >
> > The implementation follows the established kfunc lifecycle pattern
> > (create/acquire/release with refcounting, kptr map storage, dtor
> > registration), for example used by the network bpf_crypto kfuncs.
> >
> > Further patches would extend the bpf_netpoll_send kfunc to more program
> > types. Note that network program types should not encounter recursion
> > issues as netpoll bypasses the network stack and sends directly to the
> > driver.
>
> netpoll may be an easy replacement for bpf_ringbuf_output, which can be
> used in different running contexts. If it is to replace the user space
> daemon in production, it loses too many things from the networking
> stack: routing, tc, etc. It could escape the current tc/tracing bpf
> prog, monitoring, QoS marking, qdisc, etc. There is still the encryption
> piece as well.

netpoll kfuncs alone are not enough to make a good solution. However,
I wonder whether these kfuncs can be useful building blocks to enable
good enough solutions for some use cases. These solutions should
include kfuncs, bpf-c components, and user space components.
Specifically, the user space components can handle security
handshake, and the bpf-c component can provide basic rate limit logic.
If we can create a library with the bpf-c and userspace components,
would it make a useful solution for some use cases (data rate not too
high, etc.). Or does it still miss some essential capabilities?

Thanks,
Song
