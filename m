Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BA13C9EF7
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773329961; cv=pass; b=pPaSsZMhmKoY3CCxUx81nxjN7pkY65w0dZhE3oJ/moNgeB0uGx+TyWpbuuFqa95RYpWpEOqQrAmQkOsC3JjZ1UozU3iUqGFkEavslThRV9c04Q7M1mEVIubVk0VrZOOK7NON0Aums99KKe14++DecqEbK74kln6TWbCAJCwqDCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773329961; c=relaxed/simple;
	bh=4tNFTOMSBZ1/Qp5RW7o3J5ezE7GBWsXKNJ/prrgOmk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGXssz+S0EM/nbr52H6Rr4B5lpOitvjOFPBOeCfkmJi19vBZbfy9rPSjRlxt41IkI03o4nzzS4Pfx86bDA7HK1zU31WSDGcyGJji3j87RTmUAQL/GpfHDu/laEf1wLJkmkLnNUa2fiR+CzgNMWo5LJX3v0619qbdVzjxBV/WTe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=e3vaIiIY; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="e3vaIiIY"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64937edbc9eso1229185d50.2
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 08:39:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773329958; cv=none;
        d=google.com; s=arc-20240605;
        b=i7OR22gY8FS4T4wuDXETY+vgVGBpNm87xXFaa/arDQwAL0fk2TmaSDvbg5YhJDzE9y
         8wJWG/A/5Sy18zRTF1V1Nv7KsZ6/wU16oAwlqt5dircATjjqeuIBslIk4+NonLIMGHiu
         3hKtGalc0i1Adyx0zDH5KDXDHD9OBkm3jcc/gfOB9KwK9REgOXYGT0UvQ0agzar5eMAi
         ZA3GK+5cor1tbVjjr92GBy+kXHa1ul00mgiUnEuOilGt1FIpdNmDEcOcIY/PRMDgj2tp
         Kd01gmgeCAzFqr+z6vBh+8BVo92xZxcm2c+3MTvu0rSti3xV+Y7NzbQAxcoacuZdI5UF
         1O1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xV1lSatIeQOkkUeHEjEALGO2gUG7BopBUXrJE33ZDos=;
        fh=+vd4U8vEcqjenQRUpYDcdgPgMZ4cvhdSvDYcyYVx+xY=;
        b=AUYjf/K1XPWLl9DY4w+I7K7Qjnx6r6Ibiim90oDCWsuH/BAK17Ckw32LDijD8Z2pjU
         hJMATB6QqT40EB8zf5zoSmCOY7DG9vv5wqCX6WceyJg8R1sGONFoQHZh6pIirYIWwemK
         SarUGwtVtvgD21cXn1sB9EzECV7rBDC8RRfpYMrRqbJ6CHhlVNveCIS3x37J3yqTKes4
         +2JDaThCqAk2hI26T+faBdkKFy5EJy2pdzqcWLt9s/wBVsfajl82oDB5i/bPStPlgGPv
         X64WsyMDSuagqdIDXMe/yJ87I85emYQHsef15dB+QmUFEiJv64BgJF1AuEoqosFS6DKp
         4gBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773329958; x=1773934758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xV1lSatIeQOkkUeHEjEALGO2gUG7BopBUXrJE33ZDos=;
        b=e3vaIiIYGWUOtCfN3v0i0XwlQU8iKw5tKJiDxrs5BpZgUFpI7tsKG3ZooWaPnqOdPC
         Z8SAY5DTLTvpjaOB6s9bQ3ZxX+LcGGgsdf6NZnIPHM+cPfYf7mdvQUxOUB0MAZatRAPX
         OPlQ6GS038tCrg8KJ4MGW9OOzjznHa++hyHmoFietr8QqWOe5FW8fUSSVZIetM87CB5M
         jIZEMQ7uYMS4Ig4PCqqRV43UmxiY9EVL0EW92WOQZ4YI2E2FPpEUlNbyASWYFFksXS3t
         9mACIIHPFuYoU4rBir3aqJDHbJg+APFP1wB7a8eG0Ml1cARiYuzc0pJgDxzADpeGYDNg
         MfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773329958; x=1773934758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xV1lSatIeQOkkUeHEjEALGO2gUG7BopBUXrJE33ZDos=;
        b=qsxhoNhK/4xZGqHljkCryk6oi+v9+yLM0Kx4qimAkmKkXf0ECoEGd8iZo11rpcs+00
         TuqERabYb860GScetOTpTz5KLJfFDyVaye0pDy1RAAGy6FRQrpAlIboXHtU2cCSB8AWk
         eC7uQsGStXbWTWXsHBCPh+5nA8uMoran9g9745afwJ4yHgFFOT48H/IlOJOtr9iJFcY7
         ZlQ7QrEIHZ92+rVIPz4HRMoFoyEL1FsrDH7OyLSSAg9iziQMpkLwg5Fk5pujWvMRfuoC
         GKT7v9A/vFgB5+IRgHHZx2YuXWFH4JM1Asfjprynblv9D28UrY+aydaVRXIIXaXh+7ji
         dolw==
X-Forwarded-Encrypted: i=1; AJvYcCUpYWVfu0R5E/HFUUNumvgBM7TH0qOnM1g2EKBXFx19w+oHKsl4hzYEaOntsNyQ0Qv8rXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3fhz68jZG5oPxt72w0Mjgi1ZBvbHzk2iQNe9Q7mIqR/8tCChT
	HderU9Ks8lixAzu3Ncy9yhjxnAg4MimJFf43AcRAdXPw13pm92mKT1ofI45ZVwhemAqTluwAlq2
	iTvgJiSk2y5hjZbrKHh0zi0qe4v6QsARmcC+5n5MLtw==
X-Gm-Gg: ATEYQzxPZDG69/yanLB6qh2fdwumwnftQftCqKYbJrSGH8sCKd7LmBSs2dLRgGhRQSc
	fRK+FPGdhOneJcv2qNCw3V7dET+TIOTgi2bZk14jhQfFit5DZWqZA930aMOg0PCWiLBkZh2R5mK
	KC48Yir5XDOm9Oo08xV3TiZdIqjbki+1Y8Bee7MXwskPcXDl89csWWtntCu/BiX/ArzvgqmWB5o
	25iWoqoJRxFlLK3UJWsYO7Ef3rWJNyu/G5i44sljKRAauBIkxr6xWnxjQlnResXhxQrU59E0F51
	LuB0MRjslodLHG9EGA==
X-Received: by 2002:a53:bb8d:0:b0:64d:5742:5ab0 with SMTP id
 956f58d0204a3-64d6577eb37mr4463263d50.43.1773329958142; Thu, 12 Mar 2026
 08:39:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <20260312150523.2054552-2-vineeth@bitbyteword.org> <20260312111255.7925b4e2@gandalf.local.home>
In-Reply-To: <20260312111255.7925b4e2@gandalf.local.home>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Thu, 12 Mar 2026 11:39:06 -0400
X-Gm-Features: AaiRm53MQsKCFNMcydaZ5MLANW9ImopAkQThe-DUzJ0WQT8Ah4MCG48E4vTQfog
Message-ID: <CAO7JXPhg-Etspj9YahZrq8cmZ2K6AGWDrMnHO+oD96P_SmOLBw@mail.gmail.com>
Subject: Re: [PATCH 01/15] tracepoint: Add trace_invoke_##name() API
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Dmitry Ilvokhin <d@ilvokhin.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
	Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-sctp@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	dev@openvswitch.org, Oded Gabbay <ogabbay@kernel.org>, Koby Elbaz <koby.elbaz@intel.com>, 
	dri-devel@lists.freedesktop.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Huang Rui <ray.huang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Len Brown <lenb@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, linaro-mm-sig@lists.linaro.org, 
	Eddie James <eajames@linux.ibm.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, linux-fsi@lists.ozlabs.org, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alex Deucher <alexander.deucher@amd.com>, Danilo Krummrich <dakr@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	amd-gfx@lists.freedesktop.org, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, linux-spi@vger.kernel.org, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 11:13=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Thu, 12 Mar 2026 11:04:56 -0400
> "Vineeth Pillai (Google)" <vineeth@bitbyteword.org> wrote:
>
> > Add trace_invoke_##name() as a companion to trace_##name().  When a
> > caller already guards a tracepoint with an explicit enabled check:
> >
> >   if (trace_foo_enabled() && cond)
> >       trace_foo(args);
> >
> > trace_foo() internally repeats the static_branch_unlikely() test, which
> > the compiler cannot fold since static branches are patched binary
> > instructions.  This results in two static-branch evaluations for every
> > guarded call site.
> >
> > trace_invoke_##name() calls __do_trace_##name() directly, skipping the
> > redundant static-branch re-check.  This avoids leaking the internal
> > __do_trace_##name() symbol into call sites while still eliminating the
> > double evaluation:
> >
> >   if (trace_foo_enabled() && cond)
> >       trace_invoke_foo(args);   /* calls __do_trace_foo() directly */
> >
> > Three locations are updated:
> > - __DECLARE_TRACE: invoke form omits static_branch_unlikely, retains
> >   the LOCKDEP RCU-watching assertion.
> > - __DECLARE_TRACE_SYSCALL: same, plus retains might_fault().
> > - !TRACEPOINTS_ENABLED stub: empty no-op so callers compile cleanly
> >   when tracepoints are compiled out.
> >
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> > Assisted-by: Claude:claude-sonnet-4-6
>
> I'm guessing Claude helped with the other patches. Did it really help wit=
h this one?
>

Claude wrote and build tested the whole series based on my guidance
and prompt :-). I verified the series before sending it out, but
claude did the initial work.

Thanks,
Vineeth
