Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8927946D08C
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 19:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663065; cv=none; b=m0RpDVZ6XhDAOw0NpELo4SczhDX6lATTglIwrQsxlev18y+GJ0Ubzfv/yxyngSO6aTbyMeVvioV/aOABYanU3cz/Z58XuOwmFUDCFvwHuUElao29OSEoAOKoBNzV8r1DYwWUI2RJPoDD5nvhZda6Ihu2tI9Oue+0qIr9oHcUXb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663065; c=relaxed/simple;
	bh=wNB9eaLGichIrF407lXC91sdLTgFfNTxKaTb73FP9AU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=d6yOT6TzXdv3fkudAtzK5cjY/U0Ips4fxL0c0TTbMFYsduY9jIcLU8B/8DjkpuSSVLaFHk1MP0AfCJp7/uWrgyM120GL/8G/xjRuZZuthiZ54rsz7VsRtopV+V5nk2C5UVTmTIyM4riQap8nFW07Csm7UhAGONvsacQqdMFeZR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvhwsCHP; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvhwsCHP"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-473ba029526so1173207f8f.0
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 12:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784663062; x=1785267862; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4TfZyNSsFF/kFGOiqlXhDm8eBgtcovpMS9Ai/8/zxBo=;
        b=DvhwsCHPJnpbbsS0TKN57PTPoDiYfSH+g3blUtA2zH2/1uGoMNzg/ghnjQ7JVULr6v
         FtrghUcG6Q1tXWje80K3IKw1sScp/iJsbPczYE/vd0uEwvimN5TjBaCOqz3M1NJUeleC
         mSeZY2LCqOu6TqV2fGYmIflPJUd45LTNt/0w7frozY3pHonq6y3fHSNfmLoioUCCvrqN
         0JVEckkbpU3JgXeCjqOTQaHAyyEtuK35wm/6u3idrkdHJv0xFT7puhspGIZVg8vJNNEy
         ff0a1MYfAYfN7AQ4acd5JA6X6vEi4iuxEOJyKs07jHG1F37rJFNddvIQ8FB7Hr4WiOCg
         QuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784663062; x=1785267862;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4TfZyNSsFF/kFGOiqlXhDm8eBgtcovpMS9Ai/8/zxBo=;
        b=rMSFmyWG6c39m9DwISxcHoZ16sieVjEK9FwXs+UZEszGi0fodKbzA1DkjjicXs6U59
         ucgoH6IqLN2pTF0YWMORpb8IgiXPvSjsI1v8xNTE5EgfaWNRB+k3XIm2650n1ZyFkrMV
         5POJQSrri9ODPYVxKICfCWCZY+KmFerpktyRrxlAVjwgFBloszrvG+2kLO9XKSAFJcqd
         r8/CZ76VnlObws/ULbiWIx6d7xYvP/kkVkSwlBqN7MTUYFxE0I45M+5wyHl6Pkhh7xG5
         uWl7n1HqZTjQUOglCZ7740YolN28ssiPeac/yS6b6C+5jQfFE1P1SDSiwWWz6ZT9T9fU
         W2fw==
X-Forwarded-Encrypted: i=1; AHgh+RpubbbiKHw/lVuEHligsWT8elpkQu632uzJng6ITSBzdDtYKJnEyUQ3IOzTCzXWJky6wZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgG7ujgtY7f/V5ZHH4mPzFw2+TEdUHKPXVhYdW2qo8HGhLXh0w
	zyXDLjYzd6xQ09GZn+wmyWqRcMEO2tRq6KeuyDLe/+bChHH9MCxBSS20
X-Gm-Gg: AfdE7clE1pziOEat+SEmsPKbPZjLjPwQFHYoBWPibDX4GRvSAJjzdeK64U2SZDc2U0I
	btuTBWc9O20AgfiwsEqf43mk0nz65fsa3ZPkKyHL3ranCj2LVNJZfIwdxpUtMyvdpCAcSABcU/h
	p4Ln5mr/ULn6nCU8Nx8tvv6pqCWDuJMx3tEb3SFhA4hU6kiPwAvYxu84kk4MajOPNPGknHhPaDY
	TypNpEVPyC0mZ7Mr0gQqwM++BD9LXfo93AMlakgZh1jIBkjvM/5PVbq6E1vx4dxHZJrDEYkuQPO
	P8uzZV8/nFUWDkyLB5MLepUcrnr2XOlqmpo6MNu5ABZkl8YTjVAVrYLfzkNCyHUOaO/N1jLvr1L
	2rI1D2+cRE2wG9C2rs4dse8LueTSQVaeB6blx1a6aD5bMjTgiZDPqkrSFvG4KEMLiCXi8u9DcRS
	Fe7RfRFBpTtyIWvl0Qp96eKS/8xJAd2QBXxunhB+zGsdmd8vnoy2fzY1XHdN2vuBaB9nq+byNZ/
	bPE3C2+Ugb0Bnl9CpanJLjsPW/W1TBzwd2JWjZv8+Zk
X-Received: by 2002:a05:600d:8449:b0:495:6022:5a23 with SMTP id 5b1f17b1804b1-4956a51d5c4mr13525275e9.19.1784663061533;
        Tue, 21 Jul 2026 12:44:21 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49565373200sm85700775e9.5.2026.07.21.12.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 12:44:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jul 2026 21:44:20 +0200
Message-Id: <DK4I97UIL347.3P2KEBO828JK8@gmail.com>
Cc: "Lai Jiangshan" <jiangshanlai@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, "Josh Triplett" <josh@joshtriplett.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Oleg Nesterov" <oleg@redhat.com>,
 "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Namhyung Kim"
 <namhyung@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "Mark Rutland"
 <mark.rutland@arm.com>, "Alexander Shishkin"
 <alexander.shishkin@linux.intel.com>, "Jiri Olsa" <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, "Adrian Hunter" <adrian.hunter@intel.com>,
 "James Clark" <james.clark@linaro.org>, <rcu@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-perf-users@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/2] uprobes: Switch uretprobes_srcu to
 SRCU-fast-updown
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>, "Puranjay Mohan"
 <puranjay@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>
X-Mailer: aerc 0.21.0
References: <20260706172744.3920417-1-puranjay@kernel.org>
 <20260706172744.3920417-3-puranjay@kernel.org>
 <CAEf4BzaDSeUxeZmHjXRYXnXDZj8Obwd3rmOsfNygjcXJ0yy5bA@mail.gmail.com>
In-Reply-To: <CAEf4BzaDSeUxeZmHjXRYXnXDZj8Obwd3rmOsfNygjcXJ0yy5bA@mail.gmail.com>

On Fri Jul 10, 2026 at 11:23 PM CEST, Andrii Nakryiko wrote:
> On Mon, Jul 6, 2026 at 10:28=E2=80=AFAM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
>>
>> uretprobes_srcu currently uses normal SRCU, which issues
>> two smp_mb() per read lock/unlock pair. This overhead is
>> paid on every uretprobe hit.
>>
>> Switch to SRCU-fast-updown, which eliminates the per-reader
>> memory barriers by moving the ordering cost to the
>> grace-period side (synchronize_rcu() instead of smp_mb()).
>> This is acceptable because grace periods (uprobe
>> unregistration) are infrequent compared to reader-side
>> uretprobe hits.
>>
>> The updown flavor is required because the SRCU read lock is
>> taken in prepare_uretprobe() when a return instance is
>> created and is held until that return instance is finalized.
>> The traced thread returns to user space in between, so the
>> lock is inherently released in a different context from
>> where it was acquired: on the normal return path via
>> uprobe_handle_trampoline() -> hprobe_finalize(), or from
>> ri_timer() (expiry) or dup_utask() (fork) via
>> hprobe_expire(). srcu_down_read_fast() / srcu_up_read_fast()
>> are designed for this acquire-here / release-elsewhere
>> pattern and, unlike the same-context srcu_read_lock_fast()
>> variant, do not carry the lockdep read-side tracking that
>> would warn on it.
>>
>> The short, same-context SRCU sections in ri_timer() and
>> dup_utask() (which guard the uprobe against reuse across the
>> hprobe_expire() cmpxchg) instead use guard(srcu_fast_updown)
>> for proper lockdep coverage.
>>
>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>> ---
>>  include/linux/uprobes.h |  5 +++--
>>  kernel/events/uprobes.c | 29 +++++++++++++++++------------
>>  2 files changed, 20 insertions(+), 14 deletions(-)
>>
>
> Very straightforward replacement and will improve performance, thanks!
> LGTM. Peter or Mingo, I assume you guys will want to route this
> through your tip tree, right?
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>

Hi Peter, Ingo,

Gentle ping for this.

> [...]

