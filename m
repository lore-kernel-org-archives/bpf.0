Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793232862;
	b=h5mJGw/ycGGjrGPHSsQrER84qQuGKbqahDyeZyqtiO0nzKia5WMLZCXRgFazEzugUSKo
	 yRBvP3FuG0x4r3KWJ7v0mOPjT+vUj+w4TszGDPH2hlfLaUnpX+LmEN13B23u6ewus34DQ
	 lx+2Tquc8HMeMDApkEPY5oG+ia3C1Rtf+M/z03UFFVAM68ddXCKSJhDQqMDbzcVxZGM4M
	 kDQ0J3XvqrgtRftfccxLqi5+bcyvUHUjF/2EGJ5G9JBpmWSfVzo9iLOADUSKufIFMDYo+
	 eujY3fOsYBzinXPMnytVmjNTb9w1c5+jB3B8TU43NMPrzW6Hj92rb2m52/Jrx1cfF0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793232862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To;
	bh=FdKKiWyB90eS21YswIKzqn0RjEeygCBAOFE1/GSl7/I=;
	b=GRSaby2M40eip7kVvyMQ6gGwrF2yxdr/OwqhxIEdoT6Hm1RCSccT/dK5dM8eIxJRMQZP
	 ZCjT98UEDGVK1R28g0bX66xodI1m2bPTHkIngXrITD+JraDztclDUN6/jsk/jCTFlP21+
	 EdUHET3Vxtl8tvHtJECOcCxW/Lux6LUfYIAhrPwFsc9HfYork8WZYr+yKUiI9DOwNoF1l
	 kLhQ6Z4gSwk6IGEF2W1i0t2amjlLY8daiJ60lR7x2OC6KciATN0JbmbrnAI1B04gdfL2U
	 JbkGoNvncMiRbsP9Uo73qSVF2NYMwSchps5tYrq7RpGe/JaNkEjiQoPlQdfo9FwWPng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vHpque1F;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BE9606A31D
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 00:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71BE9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vHpque1F
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so693818a12.0
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 17:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793232862; x=1793837662; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FdKKiWyB90eS21YswIKzqn0RjEeygCBAOFE1/GSl7/I=;
        b=vHpque1FZZNVBsxtFB3jwnTI8sdA+Yohr31G+VUVHYijGYhCX3OcQyE5nW7ssksYQK
         GuxRI/m5qR35uA/jzVmLo3bVaKsDfdygHjkYdFCJ6JkkZFVj27ehIqkHTTA8T/2dbiX6
         m1ED7hUsQFj8fJZhv7beCgKHdpbjj+iCDWOeOoThkqIeT6FIkXRGpmQkFPbcVZCOP08u
         dZYXtLNPoNV5ObQHepbtH70c0rLW2nbJeP3qoV0G4cxy5k2HCkBfVdNnzo82N+FBeyDS
         eUR1COV9XYixclP9wV3dUsHOB/VgduC0alrX3+EreW41/vfJYgHpy0Q9bq2EsdyxDlcy
         /u1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793232862; x=1793837662;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FdKKiWyB90eS21YswIKzqn0RjEeygCBAOFE1/GSl7/I=;
        b=O2HwrWRF3Cz7MyyGIYtA2m5oFpioktgroSipQtT5A4ogSdgKbuq3GKsk8piXsneayF
         +DBZdJrv7xpiAM0uW08ROQeCq0Cm/GJXzTQZ0YziavioQIUNObqnFpu5wQxXXuWOCI+N
         j390PAvEbihw4vPLu6mvwqLwpSKj73v08HNZuZGR8bB+1qquDhGYAWb4nBRv8GNP7APo
         OKyrcNItwaCWM6ECNTI77SSa90ZsNqV2Ho+35FNrcaqvaEvQ5VrzCP0O9zprGtEYBQww
         tKcoq4VY//lh8IHmlE0vqYrPy7HeuJGDIG2M/YsCiEt3pOFu5zqbBb2kXAiIfvQKEMQt
         FHpA==
X-Gm-Message-State: AFq9FYJUTJcdo8bQcS4RJXTC90fr9ljSbQ6Zjoi8Uxe1La1qq4DztHaQ
	FBYIr4xRnaJ6WMyWWpK44lkSyKNpjeUnrZNFjsVBHu49dGuid31MlXrQ
X-Gm-Gg: AYBFou1XuD/kMY0S/OwqlN5CDTYak1W3W0pOBTX/REgm06uman1e1gQHZqUZhMiAz8b
	c1fe92VTrg9ddI3YqBTJuUWa4+yn2pEVpbjKfh+zkENqvqb/jGSQ0tlfquDJQTOOfbDeoUeJWIG
	VuTqz5ehuFs/6eNvjna/OtbsBAeR8ENFF9TEMniBCoU4ddiJMiysK+234UmG4x03IyP6ahZpkBj
	N0hXRtV+RtU/YG8rPsoY88VR/wAIPvK6sUcqPkg9P8q74czaVJmwaRpeuy5LNnwEW/VD8iY3VON
	W3KioGmp33fMS8HAWH/v8IcX0HJ0Ih6IIaRQ0oMwd+uDe3xsKkEpItWfb4SROd/HmU6QQKkK7Z3
	Twdz/DUvasx6y0EHw3WFCa3Dwbv5EakPa+3p5K8tTp/Q6JZ2o2MBTaoGYXpb5A/fY3LRRmNiN+q
	Hvup3g8QJFW/Qqblm5+ikz+LDwXwbbNf6S3g6pddRLfVKpKPdRSkMl4dI4Fv6zTAUibO7rJKnmc
	BUTAvps161F7ppx6L5ra5tnwgux0c8iNVpdRQSKo+CNC1yYLkvAnYQMA3USOU52YuNtE4eU8F6d
	j3+fLfuv0UlxHYRlgq2d/AfV2GK8cyby1Ei8/FDmKlnUuzrAMfkHF3UwW3SofXWubpJsLl6dPL/
	Om19i8abBkH+G7CF8eLFN1b/RQM6IRTTKDg==
X-Received: by 2002:a17:90b:2641:b0:3ab:f38:2b41 with SMTP id 98e67ed59e1d1-3ae5822f75cmr3026046a91.39.1793232861666;
        Wed, 28 Oct 2026 17:14:21 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae55d1650csm2259292a91.1.2026.10.28.17.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 17:14:21 -0700 (PDT)
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
Date: Thu, 29 Oct 2026 00:14:20 +0000
Message-Id: <DMGVZVI383KF.3S8YFXWL0UZOB@gmail.com>
Cc: <bpf@vger.kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 "Ihor Solodrai" <ihor.solodrai@linux.dev>, <kkd@meta.com>,
 <kernel-team@meta.com>
Subject: Re: [RFC PATCH bpf-next v1 00/11] Unwinding for synchronous
 callbacks
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <cover.1793147364.git.memxor@gmail.com>
 <DMG7KVUM9TV8.3QO4MU310J4CU@gmail.com>
 <CAP01T76uO4ULjNOQ217jXTLWtP5XT0rvB7PZxt8MJcoc==GBEw@mail.gmail.com>
 <DMGQY7IH5Q3F.4QQNA0FDUWY6@gmail.com>
 <CAP01T747BOE7DHMfUSqFXEVFr20x=mzBbU3W_E04+kNfvUQ44g@mail.gmail.com>
 <448f52ebf21a0d86c5eac836bd99e4bb0892e10f.camel@gmail.com>
In-Reply-To: <448f52ebf21a0d86c5eac836bd99e4bb0892e10f.camel@gmail.com>

On Wed Oct 28, 2026 at 11:12 PM UTC, Eduard Zingerman wrote:
> On Wed, 2026-10-28 at 22:42 +0100, Kumar Kartikeya Dwivedi wrote:
>
> ...
>
>> There are other various other misc. cases where it is more appropriate
>> or necessary:
>> - Software CFI-checked indirect calls to subprogs (basically, emitting
>> a check on an indirect call (say with pointer from arena) and aborting
>> the program when the CFI-like check fails).
>> - If runtime stack probing or recursion limits are hit, the program is
>> aborted, instead of return 0 (as done in rust-bpf).
>> - Making bpf_spin_lock() just work and aborting on deadlocks.
>> - When writing actual programs in C++ or Rust, inevitably, panic() may
>> be seen (but may not be exercised) in code that is unwinding. The
>> verifier will just reject such cases. In both C++ or Rust the behavior
>> is to panic=3Dabort or std::terminate(), which is a good analogue for
>> simply aborting the program.
>>=20
>> In general, it serves many purposes, has analogue in every other
>> virtual machine runtime, thus is a well understood idea, and
>> encompasses what various alternative proposals for some of the covered
>> use cases do (fast-execute, etc.) but with better semantics.
>
> I agree with Kartikeya on these points.
> Unwinding and terminating execution is a well understood and common conce=
pt.

I agree with it as well.
My objection was to 'Eliminate spill overhead for bpf_throw()'
as a pointless step _today_. If we can make bpf_throw() into works-everywhe=
re
mechanism then let's do it, but it has to be that first step.
Polishing 'spill oveheard' is very much optional follow up.

> It is "in distribution", so to speak.

'in distribution' is so early AI lingvo. I hope it's obvious now
that 'in distribution' is the opposite of what is needed to
build secure sw stack.

> The new verifier series would benefit from it instead of taking quite
> unusual and unexpected actions, like inserting additional control flow ex=
its,
> or returning 0 from a subprogram that doesn't have stack space to recur.
> "If loop runs for too long the program is terminated" is a much simpler
> concept to work with compared to "if loop runs for too long the program
> is taking some exit from a loop".

Yes, but the base line is different now. goal posts have moved a lot.

> 2K LOC is basically nothing, if one assumes that code is maintained by LL=
M.
> There are much more invasive verification concepts atm, like freplace
> for parts of the program, or tail calls.

it's fine if it's 2k->20k lines too.

Before we do the happy dance pls read section 8
https://lore.kernel.org/all/20261026025943.404450-70-alexei.starovoitov@gma=
il.com/
It needs to support all 3:

1.
  do { p =3D lookup(hash map); } while (!p);
  return *p;

2.
  lock(&v->l);
  do { v->cnt++; } while (v->flag);
  unlock(&v->l);
  return 1;

3.
  rcu_read_lock();
  do { p =3D lookup(hash map); } while (!p);
  x =3D *p;
  rcu_read_unlock();

The patches I sent don't support 3rd yet. I left it for the follow up.

I'm more than happy to drop may_goto approach,
but I want to see the patches for bpf_throw-that-works-everywhere,
including 3rd case above.
And bpf_throw shouldn't skip rust landing pads.
That's a bar.

Also time is an essence.
We cannot sit and debate things like we did in the past.
If there is code that satisfies the goals that we set, we should be landing=
 it.
How it achieves the gaols is a minor detail at this point.

