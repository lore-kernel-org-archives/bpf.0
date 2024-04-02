Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5088F15ADB1
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 21:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712094216; cv=none; b=uUytsViTqx4SO0DQnyc5ccrL8AL7tVuBBCIlz6rmV2fxcxtZhy8+DCEsgdI2bWv+IbEq3VQgotOIqreHjTApjuQ1/l1QtnLnUUDIv7LA4lDXhwgd2ZDhzJQAJC2dqgPunnH40n20mb36I588naO9A7DeXlZVqy1HS0cx9Pu5dxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712094216; c=relaxed/simple;
	bh=3r920r3sy9ONvV4TZu5TnTf81AgbCvB0ASdhZe2r0D8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tDC14op2VzkUUqW+JEokQhfdHTqDAf+Rr2ZLO+yvoprXF/E/IW4jJKvkz6qkjn9gURxS1P7gsGK6FPrHSnayeGQBMYHl+GkzCiKPZ4oeYqH6mOEUVhjUQs5Y5z//mL/x4v+jpq5OpgrZ6fXklTil0uxgNSDBhZDIaicPETUvQIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DSBI5n/K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSBI5n/K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712094214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fVL0aLiqcK1KzUfmb79yjYH6UEgJji5kSbpVUcLouhk=;
	b=DSBI5n/K5r7xBZpC4PQasdlcEdb4Q0vxQiJ5kk65WFxmzIUrDjpK/UMTQXc6eTU4QBpvcU
	Bw/+MzmIUxlKTsHqSk060bo7nuFdbD3HDt0Hr6Sxz78H1loRRnn9VdIVhCHUkmUoID7S3X
	GkQIuKVBiPuOnM89Vmv41jvV97/Ifbo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-AKTbG7qBPGaPg6RMo_3dZw-1; Tue, 02 Apr 2024 17:43:33 -0400
X-MC-Unique: AKTbG7qBPGaPg6RMo_3dZw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41558e670d5so1482075e9.1
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 14:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712094212; x=1712699012;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVL0aLiqcK1KzUfmb79yjYH6UEgJji5kSbpVUcLouhk=;
        b=uPLJv00LLWYzCKoQFZP2mHe4VbzTFaVOGcemt3QFxJIL6tDgjMSztQl7XYDDZxeXTc
         Oxdb02NqQMzwXF2HlVU2pj6f+dA7EBzwSolx3IHpLbnTWmjiizM1p8u3qnrHNiKPDi+q
         jUDquJkxwjp6RK0V7+3nK+tYg2QfrVRNa5ekX0XqzDPm97OiKhGz/uqZZq2WYLHZEcoh
         5GF1I1GfvRpt9imPWmsEz6PRPvSQWHx++w7GT3/K0DqPJ3anEB85wWQr14G3fZ6glQ9W
         hOZs9mynuZaDyvzWIasHdq/U5euaiv3iXFCaYjPV4K1MXadx6EK10H4culFidPFHrKOF
         UKjg==
X-Forwarded-Encrypted: i=1; AJvYcCWPozGK6E8EEaFmfTmWuL+i4r/EYqSLHsYRv3aglNlFo9vkqmH3Qw0pcketrx7DR7li6GJM/yOr1U9yGpaR5YbM92us
X-Gm-Message-State: AOJu0YxS7GYRSu9S44+V5ohhpuJsuGoPM+WZ6jf0lUhK3Jno2oun0WcR
	iGORWJ+TjBRgyT8ie0inTg8D3KlEJNdI35qX0yjh5+TU1LCrmCArXKgnDj/CuFc7fxoYuSc6UP1
	N2RvxMQ2AWV/mH7kshXI34JOgexMjpWX1f5AcQe9WBB2OlzORKA==
X-Received: by 2002:a05:600c:5198:b0:415:6e79:91dc with SMTP id fa24-20020a05600c519800b004156e7991dcmr593806wmb.15.1712094212057;
        Tue, 02 Apr 2024 14:43:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/ASZOCZD4KwlBc+fiI0YXbidwMFqieDhzHwYxi6KPCQ5cxE4ZJjXpRsZKcHCLucbIsfEU8Q==
X-Received: by 2002:a05:600c:5198:b0:415:6e79:91dc with SMTP id fa24-20020a05600c519800b004156e7991dcmr593790wmb.15.1712094211655;
        Tue, 02 Apr 2024 14:43:31 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id bg3-20020a05600c3c8300b0041481207b23sm19458402wmb.8.2024.04.02.14.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 14:43:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D64CD11A2284; Tue,  2 Apr 2024 23:43:30 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com, anjali.singhai@intel.com,
 namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com,
 Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, tomasz.osinski@intel.com,
 jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com,
 daniel@iogearbox.net, victor@mojatatu.com, pctammela@mojatatu.com,
 dan.daly@intel.com, andy.fingerhut@gmail.com, chris.sommers@keysight.com,
 mattyk@nvidia.com, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v13  00/15] Introducing P4TC (series 1)
In-Reply-To: <20240325142834.157411-1-jhs@mojatatu.com>
References: <20240325142834.157411-1-jhs@mojatatu.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 02 Apr 2024 23:43:30 +0200
Message-ID: <877chfmoe5.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jamal Hadi Salim <jhs@mojatatu.com> writes:

> This is the first patchset of two. In this patch we are submitting 15 whi=
ch
> cover the minimal viable P4 PNA architecture.
> Please, if you want to discuss a slightly tangential subject like offload=
 or
> even your politics then start another thread with a different subject lin=
e.
> The way you do it is to change the subject line to for example
> "<Your New Subject here> (WAS: <original subject line here>)".
>
> In this cover letter i am restoring text i took out in V10 which stated "=
our
> requirements".
>
> Martin, please look at patch 14 again. The bpf selftests for kfuncs is
> sloted for series 2. Paolo, please take a look at 1, 3, 6 for the changes
> you suggested. Marcelo, because we made changes to patch 14, I have
> removed your reviewed-by. Can you please take another look at that patch?
>
> __Description of these Patches__
>
> These Patches are constrained entirely within the TC domain with very tiny
> changes made in patch 1-5. eBPF is used as an infrastructure component for
> the software datapath and no changes are made to any eBPF code, only kfun=
cs
> are introduced in patch 14.
>
> Patch #1 adds infrastructure for per-netns P4 actions that can be created=
 on
> as need basis for the P4 program requirement. This patch makes a small
> incision into act_api. Patches 2-4 are minimalist enablers for P4TC and h=
ave
> no effect on the classical tc action (example patch#2 just increases the =
size
> of the action names from 16->64B).
> Patch 5 adds infrastructure support for preallocation of dynamic actions
> needed for P4.
>
> The core P4TC code implements several P4 objects.
> 1) Patch #6 introduces P4 data types which are consumed by the rest of the
>    code
> 2) Patch #7 introduces the templating API. i.e. CRUD commands for templat=
es
> 3) Patch #8 introduces the concept of templating Pipelines. i.e CRUD
>    commands for P4 pipelines.
> 4) Patch #9 introduces the action templates and associated CRUD commands.
> 5) Patch #10 introduce the action runtime infrastructure.
> 6) Patch #11 introduces the concept of P4 table templates and associated
>    CRUD commands for tables.
> 7) Patch #12 introduces runtime table entry infra and associated CU
>    commands.
> 8) Patch #13 introduces runtime table entry infra and associated RD
>    commands.
> 9) Patch #14 introduces interaction of eBPF to P4TC tables via kfunc.
> 10) Patch #15 introduces the TC classifier P4 used at runtime.
>
> There are a few more patches not in this patchset that deal with externs,
> test cases, etc.

Unfortunately I don't have the bandwidth to review these in details ATM,
but I think it makes sense to have P4 be a conceptual entity in TC, and
using eBPF as the infrastructure to execute the programs. So, on that
conceptual level only:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

[...]

> To summarize in presence of eBPF: The debugging idea is probably still
> alive.  One could dump, with proper tooling(bpftool for example), the
> loaded eBPF code and be able to check for differences. But this is not the
> interesting part.
> The concept of going back from whats in the kernel to P4 is a lot more
> difficult to implement mostly due to scoping of DSL vs general purpose. It
> may be lost.  We have been discussing ways to use BTF and embedding
> annotations in the eBPF code and binary but more thought is required and =
we
> welcome suggestions.

One thought on this: I don't believe there's any strict requirement that
the source lines in the "BTF lineinfo" information has to be C source
code. So if the P4 compiler can relate the generated BPF instructions
back to the original P4, couldn't it just embed the P4 program itself
(in some suitable syntax) as the lineinfo?

-Toke

