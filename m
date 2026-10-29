Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793233681;
	b=GU+wyKrMsEzO+S1QvQzpLt9+KKkSQvZB8/1CknQH7MDeYxTHTENkDn6Z74PSMNPCoJEZ
	 0qCBP+2H4bKusk2fNQY1FWBFytViS5rYni58p9qw0CEtpNCeGwRx7R0b3pWe2RVT/ybyM
	 xFo+GHxUf5hCxCCIR7BKiYQPxlneayArOGNFDh+ycrP8zuJ097aHSOUOJXtSC1OAAXX3J
	 LJdRKoNCGsBSkhRT3mBG0fuoDo0O1e+Y5bx33AgCaU2Ax+7eIySRm1lQOepQ1sQjtR5EW
	 hKAMRC0QTdlJPBVMv4E0AXQbx51mSbH9I2oo5b6PWWCz7iVeTBSdZd6nfMRmD++fgTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793233681;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To;
	bh=pQk6oAX7+MLyCVigu4scI6cqCYjv8Viw/VpBQ7oRJTU=;
	b=opnY2Ssd3cjpqPLKex5dcc2/eyhMJT0SL2fSlz/EZmhMKCperMcn8loYy/RCvrtw8YXC
	 zNkrO1gFX6KO77m3hxZmi6doNS7tAQb+pY4qktpOnzlYFJj6gtVdZ8XPOrdmsWB3QPTpZ
	 T9p2/SmBTsmgBnf2qg7Y+zDxp+GbQqzEfaRwPTGvhljyZ0tHCAFcF/v+XCKHTGAKkhf0D
	 9IS4x0FeHi8GB1WXH+F1qDcRJ0fYFF2czUknT0+/i8u0GAXrOJxwcle0bGTCjUX0P1Fiw
	 kqL54XBvBZjWb94f1lkpn9XafWOjBb7RFPb10eHYt9P3h3YPErT0qqL3sT57MOikuDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ikbgy3W+;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9736D606A31C
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 00:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9736D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ikbgy3W+
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso778524a91.2
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 17:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793233680; x=1793838480; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pQk6oAX7+MLyCVigu4scI6cqCYjv8Viw/VpBQ7oRJTU=;
        b=Ikbgy3W+2PxU14VHNKKhG+ra5clYgdfEyR1zCAOZWXx9iSlyOQvfBImvS3iXp918lZ
         71PBZhC13Z6/PTs/70lC5TPAmYTh3KCymDAcsDJJzDXSWFtyPfqj+UsK3HtWu+68rFZN
         XtLJMC/CLEqFTVJzTUfVg4eK4lSzJbBMYMNO+HVqp35TxmtLiCLL30PQwXjC9Bf4ylAE
         3wCXaykiZvNrG34EH/pS2AqpQPNGpmhtSR6dQ1eSaAsS/lOo2NrHw5EIaRgY6dYph+gx
         5fATlhUYlWIHoDTmNi+pS4HfMrP2YNn7XVREvdJxIh4+D5FnT7xrdR6RT06UGGaHOLF1
         LklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793233680; x=1793838480;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pQk6oAX7+MLyCVigu4scI6cqCYjv8Viw/VpBQ7oRJTU=;
        b=PotSug+kC+gIDSHaRykV6v+YmgX0lMius6VwWUkdhqDuPpK9VcU0/qlJT37yZ54MCJ
         QsBSdanrBw3D5xLSCWKQM8vfg8Vmfkg7hIMGOR3U6CbIFDHseIyaDIxaahodleddwdy4
         q+NKuZ5bD4aaqmN3HuaVhyKfVS4BAUH1LyGx5mhb/mM/ocBmqwcJEtnI8qPznxKNNb4Q
         j0y5xRYAb7CZQ3O7SvQy+9xkOYaj1w1zq4qxl4f4Bd4KfCvlpt6cHmbtnnKQak815Jm/
         zmIHU1WDy3a7sAiqMl9c8DjvXpYa5dWmjR6ODloXf0A3BgNyAsw5kK/tYPVg9uoYbmmb
         YfBA==
X-Gm-Message-State: AFq9FYJQ/kRwvHciEvBf3XzDSFljk5rzgC10CXv7qyc7ff/4TkeYpoPS
	R+9ghsCMb86ckQG049bH5XUFyCjn5Hg5cJR+ZM8zWXf/AI26VQ+ZBnH9
X-Gm-Gg: AYBFou36UM3S+G9UDVDQxSMptlCwiH3aI606p6vJ7/PPaYXWOQIqv3tzmDAWn/lkJMf
	jHYMPv6isD2Gk9Ff/9UQ8UMVgIKURJaugffOq7qZ5q85C0jozU1KU2i9adSI8ujkmm6leqvz9m0
	1eJYO04O7cN09HmbaS0XWwTPzWKAPfzEz7eHxXg33SewaepV7VaHUWKWk1Qx0f75xwMwkekQWdb
	HaLYW6nTuo/gHQ1KkssyP1Kry8C3+4vNaAMwKfleD0X+MP32Na0nBj5swNlBcoGam5oH9uz7Kpk
	rgtecMbG0NxWqifmOSPLph1KlKNo9t+SHTjUeyAGGOZiDZzgjtOI5Yzcb0WaKfhVgzhBqvukeyZ
	TNgwCahHy7AE8vfYUo9HZHNsARYhiyuUoFV5UE85MUz15WzoTKSlGHBOjiWrXeFEVzgo0CMcvbQ
	jOgGiIFaDBgYXe1bvCQC01qiomty5ia+Eu+50CGsdsyru5eEtHc+VTEqYRMEb2hIPpCndz406To
	bKlkJLHt0R/Gsk753IUJf1wJEq4hV9xpzL1bB+5IBDxO7fRYN/puxePu7Bc941uksMYUqkCpzUe
	eymuYnMjXMjD3Un6VOrVBUrH3N/jGlLbItIWjKzqpEayApbIQOhdBdUSoW7dRAWJDZV/TOFzhMV
	uVezf3cLa/peVZCTsAuBk07SCn/lHDHsTAg==
X-Received: by 2002:a17:90b:1c8b:b0:3a4:6e84:e7d8 with SMTP id 98e67ed59e1d1-3ae58145078mr2999600a91.54.1793233679564;
        Wed, 28 Oct 2026 17:27:59 -0700 (PDT)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e874bebsm1414510a91.14.2026.10.28.17.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 17:27:58 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Oct 2026 00:27:58 +0000
Message-Id: <DMGWAB4NG738.305U5MP8YSGY7@gmail.com>
Cc: <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>
Subject: Re: [PATCH bpf 26/81] bpf: Support BPF_REG_ARENA_SP in the verifier
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
 <20261026025943.404450-27-alexei.starovoitov@gmail.com>
 <CAP01T76dRouzrPOZS8AQ4TMnJ0GzyRm8cPJ8RYUTu01bQgf2Xw@mail.gmail.com>
 <DMF694XH2TJO.P59A31VE6GWP@gmail.com>
 <CAP01T75HAHkP4bzdGzeazN4n_FNd5w1Pckd3GBN68V0n1PNe_w@mail.gmail.com>
 <DMFUDQAC6N4S.1CNBGYKG58DMR@gmail.com>
 <CAP01T74C4bBZntDNLrCxe02prWiF3pnUfYMFTUU6-44O0zbnPA@mail.gmail.com>
 <DMG76G7GIPN7.HQJKZIE5J8R6@gmail.com>
 <CAP01T75pOz8Nj_YG13quoVeniq6908sY5og4RadfM9-tz5j7PQ@mail.gmail.com>
 <DMGPC9G5ZT9O.2NN1B6B3K7STH@gmail.com>
 <CAP01T75Edpdne_VV_0XAKEw-ijCh5ShXJQq1MQKpKVf9fRQzUg@mail.gmail.com>
In-Reply-To: <CAP01T75Edpdne_VV_0XAKEw-ijCh5ShXJQq1MQKpKVf9fRQzUg@mail.gmail.com>

On Thu Oct 29, 2026 at 12:07 AM UTC, Kumar Kartikeya Dwivedi wrote:
> On Wed, 28 Oct 2026 at 20:01, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Wed, Oct 28, 2026 at 04:00 AM Kumar Kartikeya Dwivedi <memxor@gmail.c=
om> wrote:
>> > Sigh. This is not a good response. If you do not want to have a
>> > discussion, what is the point of posting patches and asking for
>> > feedback?
>>
>> I do want the discussion. That's why parts 2 and 3 were posted for feedb=
ack.
>>
>> Maybe I missed, but so far I didn't hear an alternative proposal.
>
> I was not making a proposal. I don't even understand half the changes
> yet, it's a long series (81 minus 16 patches), and I haven't been able
> to digest it yet in 3 days. The only thing I was trying to understand
> was the motivation for the split stack, and it wasn't (still isn't)
> clear to me why it's necessary.

That's why the first thing in the cover letter:
"
Where to start
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Patch 69 rewrites Documentation/bpf/verifier.rst. It explains the algorithm
with 11 examples. Read it first. Then read patches 47, 52 and 53: the join
of two states, the new main pass, and the switch to it.
"

Re: stack-in-arena.
rust routinely needs 32k and in one create it needs 65k.
The kernel stack cannot support it.
private stack, the way it is today, doesn't work either,
since it's non-recursive, but recursion is necessary.

>> Only worries and concerns and "there must be some way".
>> I expored all ways I could think of and listed some of them in prior ema=
il.
>> If you have a sketch of not a 'stack in arena' approach, I'm all hears.
>
> I think it will take time to understand and reason about all this.
> Decisions on where to place .rodata, how that interacts with the
> examples you showed, how the verifier works now, what the compiler is
> doing differently...
>
> But if we don't want to wait, and you feel you have already explored
> the solution space and all of this seems fine to you, it would be
> wasted effort on my part. So we can continue with what you have.

Not quite.
_We_ don't have time to wait.
If you're saying: I _have_ to spend a week to read the patches before
I can discuss it, then yeah we're not on the same page.
I'm asking to do 'Where to start' section.
It will take an hour. Maybe two.
verifier.rst and commit logs of these 3 patches are well rewritten
and easy to understand. They are enough to have the discussion. *now*.

We might throw away all of it, so spending a week to read the patches
is a waste of time. Do not do it.

