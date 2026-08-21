Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D73E32E696
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 01:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787275225; cv=pass; b=k8Yv+g8bf5ZVIfpGU52EMyXvFjHYunaGL02vhEzD53OJIQIYuNmeW2WtNROl5yOr1tEwE8E6DlG7ztk4WIenyFbh+P5g5x9Gr79gohZHCmDph7cGFdTAN/jElGSbQimlNpO9jKKh/T1mX1YzcBRP1II2XqJawegBU7byo2xHCGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787275225; c=relaxed/simple;
	bh=beEVlsUuL9o5hYoikgcqc1vZjOkeGxTIGhmngv+9k8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LbDm5Y4zOVU4aXICl3+oCM0XJJ3uKuk7ppgmINvknnABNzI7C4lwIgDgKiVWyc9FUf73h9jCJ1Kye4QEAyHMIHGgbUW9q1LhmfpyBKnnS3062kXleewfsCBIVAfcPn5s5fPkc3sh/STi/MIG/8HkwuNvyy5lieMsfkyj7JfO33o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StO3cSkM; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StO3cSkM"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66c83e34212so607919d50.0
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 18:20:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787275221; cv=none;
        d=google.com; s=arc-20260327;
        b=j4yl/nZ8ZRjmhSDNqSX4ugFSgck7LTyD6fCM/I52YQRxJksMQ3yyR3qRKSyo/ZvRQk
         g6v6fs5IorjZLqddzN2HlffXZ8DAq9hnZPi3gjpL7a9NunVbB7Jujat/PkVB8STPp6cQ
         DKq/EXwxjhyxGZpTSKi7zaP2433Xex/yA8ZfwmOe4HP4uVvVpTF1nC7OTcikc2aNX4nU
         WYrLwr7i0J4ux1alJF8QDtKY+meYRbo2ktz3oEgCKOY3vs2tl9F5Um7DAJZ29KaVIEk2
         50lNMLUEWGPOmJkLBmZr2ATC0yr369iA5GUbOytjN6FvpfBDAwv5OCQWLX4LnFTtkNJ4
         jVeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cc/ydSvi4LcaS7pHjzjdCQH2bbW529bELwQ3mNa36YE=;
        fh=wZ7UE3wwTqWCGbz/g7f5I/nT8a9VThwZj9JuonDM9Ks=;
        b=cLx8jly75CkT9KeTjJiri+kRoDg0UNYVwY8VPPawdhXIBKg6IjJzQ2p1bPrrsTTSfr
         /8dkhLI9TavpJw5E+ngzJp32fGoQnmnvbh2Xid3NT3Ua2WncL9PiUpsU12seSTSIEe87
         t6yduAzmbLAthow27UUt3z98NlEGcXsVhMileTTneSDuGGx+TVWifCcpqnjp0VcpDjto
         PhuE5y8VT2n6UZBS+jOEAfxl/0FI4CnC0cFDj7Be/qSL0Plb3WZPnLZnNE7fAxWyEwb6
         8CJjh5dSw8l5clkPZMFlmNIFRP2mpVzwm1BOLMwzci1UiQu7rp/A4dlidUiTZBS4mK8e
         lJVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787275221; x=1787880021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cc/ydSvi4LcaS7pHjzjdCQH2bbW529bELwQ3mNa36YE=;
        b=StO3cSkMRrkerKklAjGzm32z470HVenfFB21qn/HFzuepkklYWB0MvZhgKynrNdpUC
         OmlGZdFXpNj2LptWUYYRuMGmD+T7UgvEnYMSH8Ibj4XMYCdd5h12zqCU9gBuxkyGeqzS
         PF3aja90ZJvyr7a87wja02sZTiOZUnG2msi81cXlXKFKekGHsNTv3CSGZCLPxNQZ9f4/
         jaWAgjPrpMs1bMUdz7ArUsClK38d1ycA3vGG7JMQgM1i/UrJdvQokQPaFcuuuxVC5XqS
         zkrlywmyZE8/vYyIN2n5ZSD0DboWn9+a0cm0MjbY1SNAJFTyaN1H9EGBmD5WU07lH7KQ
         R8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787275221; x=1787880021;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cc/ydSvi4LcaS7pHjzjdCQH2bbW529bELwQ3mNa36YE=;
        b=m5cX9gdJXaGz+5+yUWoBgiXm9PJXGtrHOp9osEi2Bi+/845VpDrKzFeS8G5O6tMOdc
         LhDiHY4zdIyj4+i7Fny3dJ9fOhK+IINka9O/QTnJ5JfNR1jLQqlbOWHdn4TRxZh39gii
         63Vx75bstobGjMHMGp0z4LTwFn3YSQ2eXwlg5wCRUYabwkP74Db3j82Wp57JgDxkeHSL
         CtLT0u+vPi/HCgr4C7RKdPpaxcKYi10/8+g4q/Zs0Cq0ETSA3AlFocw8FYos6lrZWi0O
         Tdd0/DL3giG9/bJmweECUmas6j42eEvCV+X96jMJ3u5RdlPGgVexNj0S5k9ETObtyJ5b
         kgiw==
X-Forwarded-Encrypted: i=1; AHgh+RpUAR6PiDahC5jmGEn3/1hZyBBi9sVbkgNGjl7EWT6SGX1+iQU/NeDEIqQDYzBBWpVJXfA=@vger.kernel.org
X-Gm-Message-State: AFuF++k846J23e88BYyY7/CsYtevPsRMOTbBa1Jq5aPcMMkopvb/Ckz2
	0ss9FR3o453y7dODhhNKYqVAM2kaUX95XGhSdEunaymhbLX/lCo62fkz/R4zNebMDCpTp7ewGDV
	Sj6pkejATNpk15XY5dBVyjXvy2N1uYYI=
X-Gm-Gg: AR+sD13LVWuVG1XenYkdAZ6CGcebHsZ+hOA4FovrOkCIjlPHP3JT/lhRU3qYy2ryzX3
	Vr58yg5HaEn3S4SDImCcevGOrWwnupDJhFVAqLWfS1OtUzuA1ConfMNS23LBMZRrePu4Sj4kwWK
	xSSE4gx9ueH9GvU2HTIqMCC04Cs9b0HPxIBhXdV9eKoxTpMJJKRvzBO8JhfbP6OG69MpBbudTNs
	QrdgOE0plPy/renNaq40Bz+xviqG4cw7J3LwC+sSJd6lDJTkcL74+XIhQ/kBlkjs5xvc3+huxkJ
	Ge/lC2Z+VrL8sXOiVwZwlooog8NHvUF5xoiYL1pWbp1sygIwhYfiDofp0n0FVb+1gwc7iBMMeVK
	iD/WYNr5Vl5sTY4LmjZTaNnTqDQhjIAhoOtc=
X-Received: by 2002:a05:690e:6ca:b0:66c:9d32:46f2 with SMTP id
 956f58d0204a3-66ce4b91cc5mr837296d50.54.1787275220801; Thu, 20 Aug 2026
 18:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813060528.365959-1-kartikey406@gmail.com> <20260813110522.GD1246887@noisy.programming.kicks-ass.net>
In-Reply-To: <20260813110522.GD1246887@noisy.programming.kicks-ass.net>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Fri, 21 Aug 2026 06:50:09 +0530
X-Gm-Features: AcwNN1Xq-0u97UfSOxijlYn8NWJaauIW_R8xaQQaZYfAs9qafwmGEF-mflXoBV8
Message-ID: <CADhLXY783QR01JkL8C1sJh1tBrud-6d=fmovg8wzTqzDzE_PEw@mail.gmail.com>
Subject: Re: [PATCH v2] perf/bpf: Fix data races in BPF perf event handling
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	olsajiri@gmail.com, irogers@google.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, song@kernel.org, kpsingh@kernel.org, 
	mattbobrowski@google.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, 
	yonghong.song@linux.dev, emil@etsalapatis.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	syzbot+651d2774bd1d8395595f@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 4:35=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>

> As I said yesterday, how can perf_event_detach_bpf_prog() run
> concurrently with __perf_event_overflow()? Unless you answer that, this
> patch ain't moving nowhere.
>


You are right to question this. The KCSAN report from syzbot shows the
race was detected at runtime:

I don't have evidence to prove this race condition.

> > 3. perf_event_alloc() reads parent_event->prog locklessly during
> >    fork() which can race with a concurrent detach clearing and freeing
> >    the prog, potentially causing a NULL pointer dereference or
> >    use-after-free in bpf_prog_inc(). Fix by holding bpf_event_mutex
> >    when inheriting the BPF program. Make bpf_event_mutex non-static
> >    and declare it extern in perf_event.h so it is accessible from
> >    kernel/events/core.c.
>
> This seems like a separate issue and should thus be a separate patch.

Agreed. I will split the perf_event_alloc() fix into a separate patch.

Thanks

Deepanshu
