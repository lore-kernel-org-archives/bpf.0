Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1359439098E
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334485; cv=pass; b=csoslBtvRQ1Rbj4QAJuaQgJxs1kR1EtLmcSgzKDwPyaf8/5Oq4WXr1CVBY/0rQSSPVfE6n82AokVJ2vuylDzipykGuPajSDAGdUYdvh3P0o3Rq1vTmpO83uFQLmIcSOBTxxGdCThf7zG++hziMOJPY03lOmb5hJHPIHJQFsUu9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334485; c=relaxed/simple;
	bh=0ivvtg/7i339ZQR+9yPgWn9tEIiWD5JfW0IrpKNu4D4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3YCi91R+5bAnc3pO4T1k1sqdm2NvLO7xWR2id8mjQfOVChpkFBZjo/iyIetrF3ldqR6pSvKuFUVO4njV3V4HC7pljs3R89lS8XGpV6/+piZ5MEZX9iFdQeT9lZ4rMBLQEHdH6PKoFAK/IVXgY711K9FeSEBJZpdua7B9HBljtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFrQITnb; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFrQITnb"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-358ed696623so569887a91.0
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 09:54:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773334483; cv=none;
        d=google.com; s=arc-20240605;
        b=FvMC8bW9ZVrmngR/4LjgIago0fOAn8XS6R42miWmnyG4HSCPADeE4aF0rTLMvBP8Wf
         jTB5OsHqiM8YOXSGlhZaa2opaRWv0u18unO/njmVH5cr6PzpFoxRjfc5nnJiTvv6YQI1
         lNE1lmmppi67XgTSaD7P7O8u3op13AhYNZx8nDzGXTvg44/lb3UmqQcaHuOvppr1fMwq
         uy9djHm/y6upSv9iyy38s9E1zdh7i84II1flKSTr64Mu0+LX3ZReWR+IJyBTIVetUx4k
         LK3M8QCYZoJUjMgkUVbZTEVSkr6YU3Pz42QUXPcno9T3jWsQVXlVoAVZg1ioGZJxOQRo
         YkYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+kWy5KRAZzJ0k+gfnUe4+KiD3cukw8nZMNARL7dWDnQ=;
        fh=w9e1W82qp51GWloHrbm8MPkH2RHC0+PoR8Y0corA6L0=;
        b=HMS3fPwDUFXjYCt8iBNaSNNzNG/LSyFnWdhcJVZyEx2PD/nLYrBM9tu6MYjvXne/Za
         vWhQ9gNv4VSGfLd2sO/7T3LuHcfLHkFL8adnr1MZuOMgBXjyq0ZcS0iqZ13YF6NYExTz
         rGkyjAUH5bnmocvnMbAUl4UYdqF6EZ2v2pih2HzSg0qjY3qCjeHLhi7ub4a9qZK4wnHj
         96bphlDZLLnL7SvZUyMpyZvKp396tdqplvtsLY0Hb2/umL4xBGcZP5WrIBMEUI9DnKvn
         whzmVtXSv0q6rAMf0IGdPttLFlvDtmEkQDuW9eR5ov+k2pEBxk8Pl21cI6tqzPXW74de
         492g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773334483; x=1773939283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kWy5KRAZzJ0k+gfnUe4+KiD3cukw8nZMNARL7dWDnQ=;
        b=kFrQITnbSdq6fGGAo1Qs91MmVTz356ySgdYWMhoXz+qDA2sI5h/kKKPobud1lef9Qq
         Vnjg2VUjWxY13G90CmzMMLIGG1mhAwthMdOZYeJon+O+0g87Kr6AJ417GKQwYBg4ntGg
         crbqh1wylitW5W3iDY0c9cFEY7XSz1kk+X6ijp5ETi+DfQfNFfcOE0+jm8SyHkpkeZCH
         z7cnWY15WdETUtxAXisuTIbTwonAFvkgAQR0r46HDiAaLCOdaFl6hAZomSDbAEI+l/d2
         UjnUvLY2rcGWyZPKGUWcqGXGW+Udo+G6jXAxvhMluPCc79Lf1wiRS3jOdfepdDepHnRM
         dA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773334483; x=1773939283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+kWy5KRAZzJ0k+gfnUe4+KiD3cukw8nZMNARL7dWDnQ=;
        b=O/SL5efy8qpHBHXdi2Dy4PLU1K26ce3kG4io4zLzHVAOeEousPogDF5vOREIw1S2Cj
         mIk+/u7FQXgPqLPU+3AFX7XCP+Oa4zyBYBWFe1IDM/KrcqBhejB/ElF7pd/QNQV0Ykdi
         MGOU0Ll51l4KyR5FzW0SMMXoOF4c/3qWHfbfwALBtX51RfF15AE4DWuzObxHNLgCZrsa
         AZPHOpf8YWDPcrPNRJ7wavUbmAyA1W8YWxWO+oLbxlBuuKzB06x5XmCGW+FIeG5LSMGi
         ZG37krcOMVLLXQTWUv4PPIquKiuHunPQ1Y5SzuD8sert8117XTEDOXR7lg8JStGadESe
         QkvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpktPh1nJFMqpIaISa3eI5HSbW4wbh7X+INRtxDS6BQBFolTO96MMtJCcboR+LCHgY9iY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWE91v8gVOz36iIKWL1iegFKeHhZL8I1vMbFPZ/S5PZcPXHnn0
	B1anF/7UWNfCVZRHiq+eZ6UCznO4WF0AqxAajdq6l4vjD59A1TqPhPNW229XVXUSRx5rx+04muy
	2kMjak9KyWqNJKDcriH9AwA514XuhY8c=
X-Gm-Gg: ATEYQzwuaNryjR9uhODx1Jefh3pf4OtxqBVWodAxAFQqRj5L7bdIjCwwKUG4/SqAJOY
	k2gmS4PYOsB9xLviq/HhGrkWmWYheY6mCAn3wxfGSCsiGok/U/7od7Zm2SlptL/ikmLdzD5RgMX
	bKYnIN5LR+mhPGrv2Mj3+zYu5HvluhBPpQVWLnXVA3AhDAtWiZWD9RPKr4JVyB/JGhzYBFw5Tud
	umly4VS2Nkl59qdtzKLDnGLpF3NUWkjNdajQnxa3c4EJ5M/Q6EsPYA2cx71/vd3y+lADmjMlhgi
	GnpvQIoYAPbYlM2b2HXVntQ=
X-Received: by 2002:a17:90b:288e:b0:359:8d0d:5905 with SMTP id
 98e67ed59e1d1-35a21eba194mr250522a91.9.1773334483388; Thu, 12 Mar 2026
 09:54:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <1e3c2830-765e-4271-89f7-0b6784b37597@efficios.com> <20260312112354.3dd99e36@gandalf.local.home>
 <219d015d-076b-4c80-8f63-88569115fdad@efficios.com> <20260312114041.5193c729@gandalf.local.home>
 <1becdbce-2c01-468a-bbab-42b5dea9fdf8@efficios.com> <CAO7JXPjnnruhM5oC6xMgnYaQ9efzYFqMCFiJLNM3HCQ+ZeCiJw@mail.gmail.com>
In-Reply-To: <CAO7JXPjnnruhM5oC6xMgnYaQ9efzYFqMCFiJLNM3HCQ+ZeCiJw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Mar 2026 09:54:29 -0700
X-Gm-Features: AaiRm51tg7oVvkVGab0X55k0oYxIuUltKNvtNsrbO-Cw57of2y67mwv1ziUvJS0
Message-ID: <CAEf4BzbnfyhCqp0ne=2gRnVxp-mdGmuZwDeFRyhRYH+eDcz2-w@mail.gmail.com>
Subject: Re: [PATCH 00/15] tracepoint: Avoid double static_branch evaluation
 at guarded call sites
To: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Peter Zijlstra <peterz@infradead.org>, Dmitry Ilvokhin <d@ilvokhin.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	io-uring@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Jon Maloy <jmaloy@redhat.com>, Aaron Conole <aconole@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-sctp@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net, dev@openvswitch.org, 
	Oded Gabbay <ogabbay@kernel.org>, Koby Elbaz <koby.elbaz@intel.com>, 
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

On Thu, Mar 12, 2026 at 9:15=E2=80=AFAM Vineeth Remanan Pillai
<vineeth@bitbyteword.org> wrote:
>
> On Thu, Mar 12, 2026 at 11:49=E2=80=AFAM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> >
> > On 2026-03-12 11:40, Steven Rostedt wrote:
> > > On Thu, 12 Mar 2026 11:28:07 -0400
> > > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > >
> > >>> Note, Vineeth came up with the naming. I would have done "do" but w=
hen I
> > >>> saw "invoke" I thought it sounded better.
> > >>
> > >> It works as long as you don't have a tracing subsystem called
> > >> "invoke", then you get into identifier clash territory.
> > >
> > > True. Perhaps we should do the double underscore trick.
> > >
> > > Instead of:  trace_invoke_foo()
> > >
> > > use:  trace_invoke__foo()
> > >
> > >
> > > Which will make it more visible to what the trace event is.
> > >
> > > Hmm, we probably should have used: trace__foo() for all tracepoints, =
as
> > > there's still functions that are called trace_foo() that are not
> > > tracepoints :-p
> >
> > One certain way to eliminate identifier clash would be to go for a
> > prefix to "trace_", e.g.
> >
> > do_trace_foo()
> > call_trace_foo()
>
> This was the initial idea, but it had conflict in the existing source:
> call_trace_sched_update_nr_running. do_trace_##name also had
> collisions when I checked. So, went with trace_invoke_##name. Did not
> check rest of the suggestions here though.
>
> Thanks,
> Vineeth
>
> > emit_trace_foo()
> > __trace_foo()

this seems like the best approach, IMO. double-underscored variants
are usually used for some specialized/internal version of a function
when we know that some conditions are correct (e.g., lock is already
taken, or something like that). Which fits here: trace_xxx() will
check if tracepoint is enabled, while __trace_xxx() will not check and
just invoke the tracepoint? It's short, it's distinct, and it says "I
know what I am doing".

> > invoke_trace_foo()
> > dispatch_trace_foo()
> >
> > Thanks,
> >
> > Mathieu
> >
> >
> >
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > https://www.efficios.com
>
