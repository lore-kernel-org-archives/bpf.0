Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BA939FCC4
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790970027; cv=none; b=NudEQMzdntRgCoRiF6L88XGWdppGwKRrOACXeBJPnRk86OFNP/1HeQzfd8Pb6j/VvZ+Rez+uUTLbv12CaLP+KP8wD4SX53kFTdFymbn8F58QNBiEkOtOIU8wehH/G7iRDOQny3uyC46ed/u8aPJyLYlErt9jQxKZGpmZ9LNsE5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790970027; c=relaxed/simple;
	bh=XdBqw55dqknzAzVoQjTguu9ow2UwUNSdoczNlNrWgao=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=rd54Qpyc/wjxXY7xoS8/ck/g1ATP9/4fpSJbx+Pvy4EUWtQULw/4cwNO+/aK8y0ILnFe0CaW7HRviudY5WdAkB8g591KMTdsOc227RbEw0J7EU1vR4XSlk4ndfdBHJoD73gqJ8AhVlTLyNKWJGhG+OLt3DvYBcuE1aZUJlAch98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ahMYmxDX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fO0CP2uF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahMYmxDX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fO0CP2uF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790970024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XdBqw55dqknzAzVoQjTguu9ow2UwUNSdoczNlNrWgao=;
	b=ahMYmxDXpWL9942IOCeFcVEr274hyoCCcjFnHxuIjdRRteorSk/aCeYF3DLyaLCFMg5IJb
	s22njEkvE1DAvJFR9Cmiq6AfoSNiMZ4obtRmxQfCQkAZt9LeLt9jqUwz9VkJe8XGmaiZOn
	zLYDo1yZUtEEEckiz3oSwQ7o2Lfv1uI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-QU2Lo5O_Pyu_OZIZ6aAwvA-1; Fri, 02 Oct 2026 15:40:23 -0400
X-MC-Unique: QU2Lo5O_Pyu_OZIZ6aAwvA-1
X-Mimecast-MFC-AGG-ID: QU2Lo5O_Pyu_OZIZ6aAwvA_1790970022
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a024bce773so2734815e9.0
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 12:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790970022; x=1791574822; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XdBqw55dqknzAzVoQjTguu9ow2UwUNSdoczNlNrWgao=;
        b=fO0CP2uFe4UWGrA340y4tZz5ZCUp1V1hxNss9Ae8zlsoKng6yw6Cp8YRQHiG5WTf40
         M8DGlIQTN0jNxtPFcIKlDTLxRePw7e/eVbhqba5XmYSzV+ovY9s/CdpASOK1C5YKEs1r
         4Eg1j9pNhilm2snSpfBE+Snrg9iHIuv9xAfAT94H//bwIbDwz2EeRKsvF2y+Vqi9SFqP
         JcHPqwWDqTjguTA1f5TzkQoxVvKkH+ktrf54EpmFTM58vGwKRk/VJwBNnEfnq/oYkkf1
         lXnRXIM9gaXGT6CHrvmkNHnA1GinJ5kWCczBcc0ds9X9KzUU/u6HVIQq7BHkLH3kKL82
         MaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790970022; x=1791574822;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XdBqw55dqknzAzVoQjTguu9ow2UwUNSdoczNlNrWgao=;
        b=oZIctgr2vekQ01F1qZ7zek8FbqUeRqkQFGv/Vqc4r9IvqhwfK+nCAAjYKGsaQb4jPw
         HEuLBqjb+Sp/2F95htuh12vB/uv+WoLBj0hNVndQ63JYIlKHM8HmRY5veotG9uoJn8Kf
         3pbkd12q5L5o0K2kM+Qj+PHP122fJypUFa1Ni1JDNZytk88Z9oiTANO6z3Bz7ZnzEJxP
         zPB1uQIhnM2Lm/OxzZROxdRcZacOjnjYfJxXKVOoW1EFCTu12p2FLv3JnKBtiL4sGek0
         3tB4hHuggw19YjMGIuVuPxkJdZW8Sy2LOanGidZPewt79VIDC6M9ve7fnhgZVKaGg7pP
         /Mdg==
X-Forwarded-Encrypted: i=1; AKwUvBxptN5U7g24E6onk2Wy4K026OAGhqFHVswNo7T9HC1unoP4tFW5ChR0RBGKlf/JfRmFDRE=@vger.kernel.org
X-Gm-Message-State: AFuF++mZekNeDhryk9tOFdVFeRm/veDa+3VJUtAuZysJaptmwES+votZ
	2ieLLRku0X4CeZWe1tsUtcktLtC4ph7wemVH8YVX17E1xRiK531aaaG3Aps+DH7djehtLh6V8H2
	YJVHHIe9s1w0ppw3o+dTfho/x3i7yO2PbIQj0TzJVxra3kCXueIzjqA==
X-Gm-Gg: AYBFou2zhrd5NjO865vnzFkz7elby6MWgb4oOJ/F1WaSVfzXNYd7Rrm2Fq7odl5YGsO
	2NWYoeRWCbKSK150gxQ8iJ4hvsTZcpUQPcMjBrU+cKd4wBqx68FYlqQ5Sl+gG9LgDvApCaEqGKp
	xZeXRj+FcmtHggRB3eU+UptBss1zDe5JmIQ5y+AZhWfAHPNT1VAnpoRlpjFrH86PYRCmBGRq0kA
	pJor3H10JWBgyLfjq0TQhO65zKZMOBsQRSD2ySF//vH63oN0XL9IxObeB+/UvTB7yT0X6tJxnUd
	UFpfCkCCpvhiScO4ycmaBgK69s+KnzlCUyysG8QVg1z7ethDVbBwgSHIK+BKPDcMPlfYkbkh63F
	CDIRJJTvKDmSWpU1mAGcuoJ2VZsdRDUiEYA==
X-Received: by 2002:a05:600c:c10f:b0:4a0:1fe2:d4c8 with SMTP id 5b1f17b1804b1-4a1680dd3f4mr4347025e9.5.1790970022134;
        Fri, 02 Oct 2026 12:40:22 -0700 (PDT)
X-Received: by 2002:a05:600c:c10f:b0:4a0:1fe2:d4c8 with SMTP id 5b1f17b1804b1-4a1680dd3f4mr4346845e9.5.1790970021765;
        Fri, 02 Oct 2026 12:40:21 -0700 (PDT)
Received: from ehlo.thunderbird.net (mob-5-90-98-35.net.vodafone.it. [5.90.98.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b380f0613sm8640050f8f.13.2026.10.02.12.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 12:40:21 -0700 (PDT)
Date: Fri, 02 Oct 2026 19:40:19 +0000
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Nam Cao <namcao@linutronix.de>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Wen Yang <wen.yang@linux.dev>,
 Tobias Schaffner <tobias.schaffner@siemens.com>,
 Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2 01/15] sched: Add task enqueue/dequeue trace points
In-Reply-To: <20261002191842.GA1259248@noisy.programming.kicks-ass.net>
References: <20261001152042.124445-1-gmonaco@redhat.com> <20261001152042.124445-2-gmonaco@redhat.com> <20261001154934.GT88198@noisy.programming.kicks-ass.net> <d75888885e2c94c1bc717faa864f609c43db874f.camel@redhat.com> <20261002102939.GB2823843@noisy.programming.kicks-ass.net> <56972260b9221128d7aaf5bb60f90611ec9d7235.camel@redhat.com> <20261002191842.GA1259248@noisy.programming.kicks-ass.net>
Message-ID: <6BEABF91-8CA6-4859-A426-D65F3CC6E13B@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



Il 2 ottobre 2026 19:18:42 UTC, Peter Zijlstra <peterz@infradead=2Eorg> ha=
 scritto:
>On Fri, Oct 02, 2026 at 01:55:48PM +0200, Gabriele Monaco wrote:
>> On Fri, 2026-10-02 at 12:29 +0200, Peter Zijlstra wrote:
>> > So mostly I flat out out ignore partial series=2E It means I have to =
go
>> > dig around to figure out the whole picture, and anything that require=
s
>> > extra effort goes on the 'later' pile, and you know where that lives=
=2E
>>=20
>> Alright, I guess I'm going to have to fix my to_cmd script=2E
>>=20
>> > Now, as to 3,4; I'm confused=2E If I search 'enqueue' I see there is =
a
>> > tracepoint attach thingy in the =2Ec file, but I don't see the
>> > corresponding bits in the =2Edot file=2E And per my understanding the=
 =2Ec
>> > thing is an artifact of the =2Edot file=2E
>>=20
>> Yes but only partially=2E There isn't always a 1-1 mapping with model e=
vents and
>> tracepoints=2E
>
>So the =2Ec files are no longer an artifact? That seems unfortunate=2E I
>thought the =2Edot file was fully descriptive and the =2Ec file was fully
>generated by dot2c=2E
>
>If we cannot fully express the automaton in =2Edot, we should look at
>extending the 'format' and teach dot2c new tricks=2E

The linking between events and tracepoint has always been manual, but yeah=
, it would be nice to describe the whole thing in the specification=2E

Though that would require quite a bit of work, deadline and LTL monitors h=
ave some more complicated mapping=2E

>
>> Throttle uses handle_sched_enqueue() for one case of dl_defer_arm, repr=
esenting
>> a fair task running not boosted, in the enqueue case, because it was ru=
nning
>> with another scheduler=2E
>> Boost uses handle_sched_dequeue() in a similar fashion to describe fair=
 tasks
>> that stop running on the fair runqueue (but may continue on another run=
queue)=2E
>>=20
>> In both cases I'm reusing an event that can be triggered from other tra=
cepoints
>> too, ideally to keep the model simpler=2E
>>=20
>> Then it uses handle_sched_enqueue() for dl_server_resume[_throttled]=2E=
 They are
>> both plain enqueues, in fact, so I could rename them to show what they =
are=2E
>
>I'm not sure I'm following=2E Will you be in Prague next week?
>

Yes I'll be there=2E We can definitely discuss this better=2E

Thanks,
Gabriele



>> > Also, IMO it would be *much* preferred if the =2Erst file would not e=
xist=2E
>> > Just have the graph-easy and the description as a comment in the =2Ed=
ot
>> > file=2E Then you have the whole thing in one *readable* place=2E
>>=20
>> Well, you make a fair point, I like to have it appear in the html docs,=
 but
>> obviously no one is going to build the docs to review a patch=2E
>> I may look into ways to get both birds with a stone=2E
>
>So personally I have 0 interest or use for html=2E Mail is text, code is
>text, we use a text editor (neovim is my current poison of choice)=2E
>Nowhere is there html=2E So then having to look at rst is just crap=2E rs=
t
>gets in the way of actually reading the thing=2E All down-sides, no
>up-sides=2E
>

