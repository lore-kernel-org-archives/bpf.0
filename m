Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550973DA5C8
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 09:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123381; cv=pass; b=m2ttbOu4ONbNng2Xaekpp+rvUWF3/EuX12IFwxWOjY07tei8P9mnrTqna48C8FSRAIlyV/5VAacKBy+F82iekeCDx+N+zpf0i1g8JgALHhA9LPkTduK6WXPkQ/cMfUvT2Df1cvoS1zANcyborMvYr1Bopbm6KUAP+bRocWUwXCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123381; c=relaxed/simple;
	bh=z5FpIBQQ03mUsmNHF2ialIHYPEm8eRXWyZLlR0AYPFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFFfW2uQg6fHk8bU4qXwmZmPqdK409bfDktFrPm7uvkLU0H1+WGMwWJM22nNH0EyFYKuhTWXl9k8cIYF/BizBkIM2gXnW35i9L5IN4ZFX3Dv5z3PVE3bOoFCLeYvJv0WorEDvIVkzTJFQz7VMU+UlF8Rf7YcWBHPazrnkwwdids=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LWpDCS1V; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UOBaqdFG; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWpDCS1V";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOBaqdFG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775123375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z5FpIBQQ03mUsmNHF2ialIHYPEm8eRXWyZLlR0AYPFg=;
	b=LWpDCS1VjflzmgDG/PxwXOMQq+9TmI6g72ySxcoGjYJx86B22ZGpBNNOGyczK0CLBpFoh4
	Z+boYVlLSfcLF2qNjIQDZH6tN3GhXS47XzQRCSPvdY9SQIbBadL5ecNnIqA5E3IremL6A8
	MDNxBAG1/5rJDanUEPB46P3Pd5oNAHU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-KupG6fo_MkaZCC9NfkuOcg-1; Thu, 02 Apr 2026 05:49:34 -0400
X-MC-Unique: KupG6fo_MkaZCC9NfkuOcg-1
X-Mimecast-MFC-AGG-ID: KupG6fo_MkaZCC9NfkuOcg_1775123373
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b8ff07df5e4so61992566b.3
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 02:49:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775123373; cv=none;
        d=google.com; s=arc-20240605;
        b=fjUoxz1hz5L7OwzkE/EZhP0wE75TMwRuTprBdJ+Slb4R9gZmK12odgL+N+gGuNd662
         M/rlPg2ZL/SvdZ8a2+JZQCP4PP0cFSIp0XrHeDsToRJhm6xqSsN9gDXFFtMM1hXtvpEH
         FZS8158eG8cDuNJRZupYe/Z0hZsoVe0mD+zTd13UvbPnS04iPXgtykeKPfD5k2SY/0QD
         g95GOUKIheSXePZsPDm9zjkwlbLMDb7gqf0FZsN9JEbAbdBlTlvjTuMvSsUzuA3FFTpj
         9QLpDlKiniVvhy/SmIBtBrEP9EzspPDbC0/1Se5GF9mBJ7kiLXvpxqcI9eNtFgA+nVTP
         KS5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z5FpIBQQ03mUsmNHF2ialIHYPEm8eRXWyZLlR0AYPFg=;
        fh=RSpN/peVUF39+e4r5Lx+1WBxUn8QiaB0qpLfC269y9s=;
        b=BMcKjV9rn26L+ZE8Q9HHzWmzZTujhR0Hiuu81ynoA9lJDQuMEXRa+3HJU+tFLYDcKR
         Lt4AxBZI191ON9jiBlSjLCFpUBDT3uFDPuxK0BCa2xkDf1ZVsTOwox734bQ31B7uy3rL
         /K0cUYVRELeXa//AeGa+9jo+fhKYf5NumI+eAqFTQ0Dyzv3C6xZZVIdWP1li6bvDy/St
         pl8DxbFJx3FeeJyrf6xhIeGjjF5CG3aVBxrXHJOFjZ2vAWUjwhrTl2wMMJDEovpfxF8+
         yWvsTdOYMCe0oJUYoL+tUvSB/dsPLX71TuLKfrq3IHGv+nzRUESmKkAcNXm5cWfhm5cc
         TqMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775123373; x=1775728173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5FpIBQQ03mUsmNHF2ialIHYPEm8eRXWyZLlR0AYPFg=;
        b=UOBaqdFGTixDkdR6S35LVJjoFbXZ5cM2ZGgDD2OKMOrb5dXOS99tH6hYnIB9FMO31j
         W3m4oqmXQVWZkuTX4oU5da+LG4bfp8WKh5eHuorBEOw8HPAKoN8YjguP2zEJs3Qy53Aa
         UHu6VA9+QkhuwqHdjW2qw0MTzGH4gBJX0z9TwXqAvhKZXNcU9G46DspqjGbdJYTwGqCe
         4aa0i/yIVs8EH5wAphwGc8TUHyce31EXOiCY9e5s1uuRmzpC/wHS0dJ8KIYvWi7E8E4W
         O5SxzTTb1PbFk7/YYfhnWTaEDCrrKlnaIOmuCVM8YBgEWRe0Vw1t92KGJb+aQZEJKkce
         MYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775123373; x=1775728173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z5FpIBQQ03mUsmNHF2ialIHYPEm8eRXWyZLlR0AYPFg=;
        b=LsfYyT6CVGy0f6rul581Zm1F6Vv+0lH+JTHf+cq64bzcB6sSz9YSwf0npo9DxPeGX7
         1q9/OATnD+fZikHic611B4LxfyJ/8gRxPQDZTKut5Vn2/x1vl1CrhaxhFOBICY1co2vT
         /pFOu2yz4PWj86Klfxi41eWBUGG8oM0mlPVy6gS7TH+mEHfb+uUbpd7AI7Am7133q7Gn
         ce4itQPHku2rLBnwpHzn5DwlcHi9+y1Kiimp2Esh9ABp9JKgapMxytVJ/2UDM6yCNpeQ
         kDktMXXe/yRhq3fNVc9LQeGCu7WMaunLvVFAqnKYhJdO2OiynIx8+Ifcm1p6XK7rOSBk
         40Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVU1JEHgy4TR7OWZagOy7EE4+yIgTsRQ1E/jedpE9AMjpBgrXea7YNZgJ1cDo7cG5oNccM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlJ49O9+L8I8clCgvpwGPuZ6XF7+XWinnqo0tZmQgdRiseyhw7
	D5v+y83svKUdwFlDTfqOwuG/c5oQBQL89U4kV2Ns4Je6CorulIWBzF/2wl8Qbp3SG5v+TI44Zm7
	d0A9vnKlH/9qQOmQS7xBMIPOFp07HeHd0RoO54Adm2vwouSUKATJdHMUP0uaxMO78CFu8yp7C4O
	GHjgsverRzIJAsIH2RaIrdehSfgM03
X-Gm-Gg: ATEYQzx0EYGZJUBAuW0a+ZC4jvDRY0OWcMj2liOG3Y47vwl0z/lmeqUdI2FlZAW5V0t
	12tO/jXB2l8Rs+vowEBAQOCQyLmK/cACfgrLgvBPZhl3p0ey/hnIiI0nDDWXiqFKpJkHsJWrJYY
	jxVcHMTkFdoyNnxfJMeha+bkCh86T3NwTqud5T5nNUOX1vXdhI00yOwSU/V20Dt3DuqYd0XE3SO
	y/++g==
X-Received: by 2002:a17:906:6207:b0:b98:2d0d:fc00 with SMTP id a640c23a62f3a-b9c13b0b08emr475388766b.24.1775123372907;
        Thu, 02 Apr 2026 02:49:32 -0700 (PDT)
X-Received: by 2002:a17:906:6207:b0:b98:2d0d:fc00 with SMTP id
 a640c23a62f3a-b9c13b0b08emr475385466b.24.1775123372331; Thu, 02 Apr 2026
 02:49:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <22ffc044-4cc7-468c-b11d-9b838c92e82b@siemens.com> <20260401165841.532687-1-ionut.nechita@windriver.com>
In-Reply-To: <20260401165841.532687-1-ionut.nechita@windriver.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 2 Apr 2026 11:49:20 +0200
X-Gm-Features: AQROBzBJw-tLhM-lD_x8-woUH2LWxJHrMMtqB3L4YgOqRmMqBGl5_Aj9bKxBLJU
Message-ID: <CAP4=nvQehXtd2AEFzuRzcqfXOmU6U3LH9M-nQTvNkdCtAV8YTA@mail.gmail.com>
Subject: Re: [REGRESSION] osnoise: "eventpoll: Replace rwlock with spinlock"
 causes ~50us noise spikes on isolated PREEMPT_RT cores
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: jan.kiszka@siemens.com, crwood@redhat.com, florian.bezdeka@siemens.com, 
	namcao@linutronix.de, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-rt-users@vger.kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, frederic@kernel.org, 
	vschneid@redhat.com, gregkh@linuxfoundation.org, chris.friesen@windriver.com, 
	viorel-catalin.rapiteanu@windriver.com, iulian.mocanu@windriver.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 1. 4. 2026 v 19:08 odes=C3=ADlatel Ionut Nechita (Wind River)
<ionut.nechita@windriver.com> napsal:
>
> Separate question: could eosnoise itself be improved to avoid this
> contention? For example, using one epoll instance per CPU instead of
> a single shared one, or using BPF ring buffer (BPF_MAP_TYPE_RINGBUF)
> instead of the per-cpu perf buffer which requires epoll.

Neither BPF ring buffers nor perf event buffers strictly require you
to use epoll. Just as a BPF ring buffer can be read using libbpf's
ring_buffer__consume() [1] without polling, perf_buffer__consume() [2]
can be used the same way for the perf event ringbuffer; neither of the
functions block. If you need to poll, BPF ring buffer also uses
epoll_wait() [3] so that won't make a difference (or is there another
way to poll it?)

[1] https://docs.ebpf.io/ebpf-library/libbpf/userspace/ring_buffer__consume=
/
[2] https://docs.ebpf.io/ebpf-library/libbpf/userspace/perf_buffer__consume=
/
[3] https://github.com/libbpf/libbpf/blob/master/src/ringbuf.c#L341

That being said, BPF ring buffer is not per-CPU and should allow
collecting data from all CPUs into one buffer.

> If the consensus is that the kernel side is working as intended and the t=
ool
> should adapt, I'd like to understand what the recommended pattern is
> for BPF observability tools on PREEMPT_RT.

The ideal solution is to aggregate data in BPF directly, not in
userspace, and collect them at the end of the measurement, when
possible. This is what rtla-timerlat does for collecting samples [4]
where it was implemented to prevent the collecting user space thread
from being overloaded with too many samples on systems with a large
number of CPU; polling on ring buffer is used to signal end of tracing
on latency threshold only, no issues have been reported with that. To
collect data about system noise, timerlat collects the events in an
ftrace ring buffer, and then analyzes the tail of the buffer (i.e.
what is relevant to the spike, not all data throughout the entire
measurement) in user space [5]. The same could be replicated in
eosnoise, i.e. collecting the data into a ringbuffer and only reading
the tail in userspace, if that suffices for your use case.

[4] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tre=
e/tools/tracing/rtla/src/timerlat.bpf.c
[5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/tracing/rtla/src/timerlat_aa.c


Tomas

