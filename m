Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793855930;
	b=tYjhD3wBKNbsw3yVAPXn6xicTBQ0kBH5EEDWqouz9qsBUlGbbvBvlxCrBEUErMY/B+t0
	 OCv0Ml8iYAorNfWNxTxdEyOr1cKEORQaLdaOdcV2iPzzi+ZvoTtI0iq7IfDSdT9jNZvdK
	 2F2HZleV3J65hJhvU5Nn7MieGTU/8NnZPOOFRTGTC3QeZL4Kk5deRy1x1gWorRqYaGH0u
	 We08d4BlarHAN4O2IzqsLilOOWM+44iUsHQwt8Eeb/UBXxGOT7yQI+t1InBt3Al2zrL8V
	 D+9GnT/l8ssNI2hXfNjV9U1Q2WzWgT5kH/b/n0gMZWS3dAl4zVUFf6anFIgHB9BeSdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793855930;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 To:Cc:Subject:From:X-Mailer:References:In-Reply-To;
	bh=rlYQXXtVW/GHUXiTSX/d/W1MLwKEaP5IBpluVfBfScQ=;
	b=aASRL+wSwL+9newbn3QF6OHsK0OBnTackb+0K4lkUS69l43tcUfiThX1w6B+o89a6QYz
	 qzcLAUJARfd9BcR8Qf5ncfA3Nkc3tVnfzmfBfEfGrjQhV4grxeWi1c6pAfCZ1Rv6bQtWl
	 K8rBkuG/mOcKBq5VsadOZ8r/kTM7Rrgu/eJaW2p1NcL8Do+ngd67RWMCgTTxJYkF6gq7p
	 jFj+diVMCzEWeYSEDL/k8ulv41Xzy0cWc6gLa2OXY4JHBo0KDrW5uPu2AyoTV8KttbLDp
	 PpxodmmHhqm2qHtWweL9ul8JJ5PPm5j1UuC1VmCXvfGZZecON52LY7EX9m/sB/HwMSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WKwtpAuH;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA9E606A329
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 05:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FA9E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WKwtpAuH
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc52c1b8286so130786a12.1
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 21:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793855930; x=1794460730; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rlYQXXtVW/GHUXiTSX/d/W1MLwKEaP5IBpluVfBfScQ=;
        b=WKwtpAuHMlpIAChAw/SfvJ1rdirTSs7Egq4NIjvP3WY6cZvURIgJ1OMFcIvwdKdRHD
         c2Y8Vn5y5roQZoW8I5a1hwPq1y7tCh7BD0vIODJE7M7B3n02amaXravnjDNXPcIXPdRg
         Bu2WGOKR8nuUWmvT45WkB1T1vEsSSwawTUPAuXcW7H5vEIXpL+EH1VaHIhfuWWCYh3Nq
         koAxaMwSPycrkl/cZyOX7SRtRZlizo9BzIAXZ7kDPmq3mPW2ouVyJGVvAXDwjUiKm93v
         iBEA8PxNL2bH82y+lOt/y1q7e5e32OSGHrKeefK4grz7+SeRJkkyhgQvLzM0NaG09R8m
         mL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793855930; x=1794460730;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rlYQXXtVW/GHUXiTSX/d/W1MLwKEaP5IBpluVfBfScQ=;
        b=HI7J7y635FN7hpdQppB3IpvDh9H/M93evRyqIGDZQkCGpT8jQLjxB/oEiJ+qIQiFkT
         YjnxwB2X799hj7bS8v4NBZrlYOkN4/1VbFOJcZBkeScNNTAV4Pv3iTJJHWj4bS6EtFZB
         MOX9Qwx+B6v5hrZiXtN6nnaKLw+RxMmiGSbY2l8DXmuEZxz+wJ7hFztSHXGvKl+1y3Pg
         SXFbAAtSUJI+5YnA5x0xxU7BwBuEdMDfQE911NFvOmIGwJvbpQHxQ8Efq8zObLIuBfxD
         HTTS2ezk338b3TCdtvvCDbXrz9rWmUA3eljvLCaqrC/PekYCgbF52Yt5S6o6/3OL1bLa
         1uXQ==
X-Forwarded-Encrypted: i=1; AKwUvBylgMVlTubbYdD6/2qamBClw7tc6tFdrfHY6ukcvpUGXz6qgsiD3awPXqeMNDPG4UmeC4A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+264QOAM1IzNAe9R7zRSpaeYEsuLvwZPFpOwT4vfLgw1Dy6CNJ
	APOxTLwiU1l16g0N4ULEBK4lwF5asBDN0Y//J3O3QTGGQFVXd9V5YL4x
X-Gm-Gg: AYBFou3an89EXnT07RdwZAEypw3vNwCTmbuLjfJX2WiMWQ4uN54G7X4t8MocsB/4KmP
	ky7Cf/iA7XsdTYWPS7GY7oFJ/laKU7ez6gHEhdfOord+r9EZ9++iJsqqBYtorXO35YxWf/Kbymp
	rCZNPQD2Kx2HDEL6PBpBTMCrQmDe7eNPfDR774Zh2OtPJ2iuJtbbqTqa6eWdzAeOJ3H82bt5SZS
	uau/BH+oWQizRuXGggJu0wV5xTBvATkZOmd+ulvNOyehydteCtcPxOGkFh3cySpMO5znTJqEZwZ
	fN5iNjmuiyCorCCuWL1+UTRhZjagtOIyswaBbsHotuNx+2B0wKG4eUU1NgY9CXAWZDcpz/+xVOq
	ZYd+t4PL+fAG86KpF+rJQoblrMElYLgZiAd7jD2HkbEXJ4wiXJwJUm8kXRBFEoZYuJDMwstpUqA
	qnsyED+Qx6FInzTXbS4ZP+UpVEr1DT7rdQ250ktSyRVSakhmZZcY4hYDm8x8aTRfE972Njl3fNu
	0kRz1M99uS0P7T8UVg/W1hSplMNzkcpqNTJV48krKaH0ioP0ZAhtVNwSONu2PvcKFUtHFhnvyf8
	tRwbvjuqfgE64rQkjqOaVWnGTRa7k658ub1Kw5dVRFEQjqvX+ORTIU0VztRMg61pBFPB5jHja0k
	AwzTUp+SGAcE6HUzyDHSTalg/CWOz+pxZaMC3cm9R/qW+LtVMM+aqsnE=
X-Received: by 2002:a17:90b:56c8:b0:3ad:dc36:c3d7 with SMTP id 98e67ed59e1d1-3b0afdf2b12mr1020541a91.24.1793855929364;
        Wed, 04 Nov 2026 21:18:49 -0800 (PST)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b2cf80c9sm2002505a91.0.2026.11.04.21.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 21:18:48 -0800 (PST)
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
Date: Thu, 05 Nov 2026 05:18:48 +0000
Message-Id: <DMN0USP1E59A.34N710IJOO0PJ@gmail.com>
To: "Martin Kelly" <martin.kelly@crowdstrike.com>
Cc: "Mike Bazov" <mikeba@sentinelone.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "Shuah Khan"
 <shuah@kernel.org>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, "Steven Rostedt" <rostedt@goodmis.org>,
 "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>
Subject: Re: [EXT.MSG] Re: [PATCH RFC bpf-next 0/2] bpf: Do not let
 preemption cause false recursion drops in trampoline progs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261025-b4-bpf-trampoline-preempt-v1-0-198dcdc0c6ac@sentinelone.com> <DMIIV9CE0PN4.309YUGIXQUZNF@gmail.com> <CAPnbwjrB_je6jXt3BGD-1q1yFs_wFd-Yh9KzixKzLK_X3Stuag@mail.gmail.com> <DML75890DWIX.EYB690LPBM1O@gmail.com> <CAPnbwjpv3bkGAKVjc7Eywgo-H4X6uDLYPJWFuSakGs_sBdgr3w@mail.gmail.com> <DMM2FJ2SNYYO.24TEJ05OOR08E@gmail.com> <CAH=2mMABxvf+GNr7vUKNkGvyU-gmaXKMGNJHg4URUCW_eyuxGg@mail.gmail.com>
In-Reply-To: <CAH=2mMABxvf+GNr7vUKNkGvyU-gmaXKMGNJHg4URUCW_eyuxGg@mail.gmail.com>

On Thu Nov 5, 2026 at 1:12 AM UTC, Martin Kelly wrote:
> We have noticed this issue independently in testing of our own security
> agent and have hit the same false recursion skips on 7.0 and 7.1
> kernels. More details and measurements below.
>
> On Tue, Nov 3, 2026 at 6:24=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> Today a fentry prog never runs twice at the same time on one cpu.
>> Existing progs rely on that for their per-cpu maps.
>>
>>   task A, cpu 0                     task B, cpu 0
>>   buf =3D lookup(&percpu_scratch)
>>   fill buf
>>   <preempted>
>>                                     buf =3D lookup(&percpu_scratch)
>>                                     fill buf
>>                                     output(buf)
>>   output(buf)   <- data of B
>>
>> A plain (*cnt)++ in a per-cpu map loses updates the same way.
>> Today B is skipped and recursion_misses counts it.
>> With the per-task check A sends a corrupted event and nothing counts it.
>
> Our programs avoid writing to per-CPU arrays because of corruption on
> PREEMPT_RT kernels, where trampolines have always been preemptible and
> thus can corrupt these structures.=20

what do you mean? the reentrance prevention counter works on PREEMPT_RT too=
.
per-cpu array are not corrupted there.

> So for us, an opt-in flag that allows
> preemption (instead of skipping) would work well and not regress current
> programs that don't opt in. A verifier scan for per-CPU arrays could
> also work, but it would need to distinguish read-only vs write access to
> those maps.
>
>> Add bpf_preempt_disable().
>> Your test forces the preemption in the middle of the prog.
>> Explicit bpf_preempt_disable() will fix it.
>> And you'll have an easy way to see why disabling preemtion
>> for the whole program might hurt your own production.
>
> We tried bpf_preempt_disable()/bpf_preempt_enable() around our hooks on
> a 2-vCPU 7.1.5 VM with HRTICK under an open/close stress test load.
> recursion_misses for the locks_remove_file fentry actually increased
> slightly 29M to 31M (this may be within noise). As far as we can tell
> from the code, the trampoline takes prog->active before the program's
> first instruction and releases it in __bpf_prog_exit_recur() after the
> program finishes. bpf_preempt_enable() calls preempt_enable(), which is
> a reschedule point. That reschedule happens with prog->active still
> held.

pls try _no_resched() as I suggested in the other reply.

> In a process-heavy workload on a 2-vCPU VM (~1M fork+exec of
> short-lived processes, ~606/second) we recorded the following number of
> recursion_misses on a 7.0.9 and a 7.1.5 kernel. Both kernels use lazy
> preemption with PREEMPT_RCU enabled. The miss rate has increased
> significantly, which we suspect is due to the HRTICK change.
>
>                                   7.0.9 (HRTICK off) 7.1.5 (HRTICK on)
>                                   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> security_file_permission fentry   1 in 61,580        1 in 1,568
> security_inode_getattr fentry     1 in 59,242        1 in 1,707
> do_file_open fexit                1 in 813,983       1 in 2,503
> sched_process_exec raw_tracepoint 1 in 1,000,816     1 in 500,408

Thanks for the numbers.
Are you saying turning off HRTICK is not an option for your production?

> We don't have a preferred mechanism and are generally open to any
> approach that would help reduce these recursion_misses. Whatever the
> mechanism, it would be ideal to cover raw_tp programs too, since
> a46023d5616e made those preemptible.

agree. let's come up with a design then.

