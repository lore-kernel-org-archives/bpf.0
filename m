Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5742C3768
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 22:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780526528; cv=pass; b=YivZGnffCQgsy4rqWE3J0gOTInxJBvdmlARJnCvVSeYmnpkU1ZbDHCF1ZFs8SHrw1IxkfX5NzMAO+5TZaKTwyPy2j6/Zks9y1niNx+F9Zej4Wic1I6bvIxmgd3+S1BYirCgxLVnhfro8++wH6cD7lBtCoA0+hURdP37uJpO8Ess=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780526528; c=relaxed/simple;
	bh=mlfM9AEMvcEfxPBVJ7L7dsmWt64ZgjO4Ruo7lQhMZqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+xhP0z3sQSAIoBlUiEieicf2gFByPzULGPQ839cmltLi4vIXpLr+uILMOsJPaqlaE+EVBDBwIDXOFQCXKReW4FpO1DqIqbSVQusr2Cmnm1DWj/hjhVCTa2Rhqmn1mICWdawNlXMIVfY2DmQX7tXU2PfG4/mS1KV8L/FuapPDiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSqZg/he; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSqZg/he"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-beb44f97561so6884066b.0
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 15:42:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780526526; cv=none;
        d=google.com; s=arc-20240605;
        b=RPeEFtkWo4BSv6g4IJ/xnRtyBjcPUm8SkmhDmANaz1xN9cQ1gLCSXDIGiWvvV11ctS
         baliPO14Y7HNNhuMMXIWieuMB2cw4NB0bSGK1sfkhHQHB1f9bivm0UzPOYVq12siaNS0
         sEMJhAcQ6yg0UFr5I7hfVAwa/saVihXzBusgdNgmanbT/NW9LwvYq8UYkEi2wrNrj7Ty
         h37xF2FIWhzVlw/DeUpAdQ5yZ0/bdjTr9nxf4QSOj3g+EmLCoFka13fEg4XonBmnZUQv
         UG+FuEd4+UOg50thfWhKntqZMX3FRi9ONEvbv+x/ZY42i7sThfoKR3VXeFEdUIPF0XfJ
         EfeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pwVbCGWyVitlFmHdRUWGc0ezDR+78ZvpePoMrndDp5k=;
        fh=lLgwWelH5uA4CH6gijIYZv0+jZ8BcmyvpTjpBe9Rsi4=;
        b=aHKMaSEZF9PlmFAx+aqUdSrMnZ6eA2yDq03RJilRpAOMq227BeF71nJvBWChaGO9G6
         6y2UI+dGkLOzcKAUEQt58GUG6OGTuVfDsKf/ZpXem+U52gF63elwpzICN6fbyi2Bql5s
         M+G/QcsFpAAx4bL2x7hlEvS2d7hX2GRvNZGJg1n/vrxwOLNVZfnGsZpQffROccWRqeEz
         9U+pqYSMZo9pvlaeWDmBzq8LCJ5EvjPQJn6mN0mUhHL7XnfDZJ9dDSSE/qLKuWnLWpOW
         bN8/Xb4p8/hEqUdZAFxynhdpFpGONdFON7D7NveeYmT8nIxCU+Ma5aQtSvwCtm2UfSfp
         Pv6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780526526; x=1781131326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwVbCGWyVitlFmHdRUWGc0ezDR+78ZvpePoMrndDp5k=;
        b=mSqZg/heWp6aSiHv5nyKPeWQr8YV7o07T3FdO5ah8eWu6Zctjt99Z9o3TNszwXjHdM
         ysIbW0c9RISSVBiYSoE9/r8K3SH6erB3Rw4GbHnMkescY0FtwoyBaji9FOzouDLMgal7
         4rLg8INWFvkFvNpbr0Q8S9GsCn0Za5Dcrlme/RtPHx4uhhwccc1XL52X4tBKoTeNugOv
         RxgBxxUmgGTdAx+dGoIar92t+lJ+Ag2hdkwQ9UzWJghRlvdL+R6d81Ha5BFcsR3mx2wz
         R8Wk5a/EJdokO3ocITh0vTFbtn/fOZtzdcQ1RE3jFRzvnBUZz23pMC9vQppi/zDQai7g
         bDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780526526; x=1781131326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pwVbCGWyVitlFmHdRUWGc0ezDR+78ZvpePoMrndDp5k=;
        b=WKOmH1xLrbi0ov2aABfkBgYWF8jZWSSHtEYkatcrzit7h+4WCbKIRAzk1OpTwwxUtk
         hz7SgrkzEqgUGrllI04e9CgRdZICLgz377W2ByV8N/vg4CmWtblzY/dAbDApCmMkv2aj
         3uE6sGq6d9p0Z3G8aB//HpUH9AL5d58YCWkHlOHezmbZLHjFAIN2U+PnnTew3+VwPSyf
         w/YBsfk8xSuvAF6f3TFzNMMO6C9klmaQAeO7/8clAGn+9OsQKgGOH3qYBLK5p0XvUpSH
         pDLsVuoeRGqymKqUw6HlOVKRmpQuYXyIDF6upTjJJgQ/5JQISeOyN+YWwIFtk/HxuOk/
         FtiA==
X-Forwarded-Encrypted: i=1; AFNElJ9vbSZGEKVN3DmO8xctKhoaKiUo1RFXrvtkEEbaYgk97TWSa6sL561oJrDcSEY8K7Q7sFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6zvA9XFqfIGmMietREaMcGBmutzyvV3pVo/TYFzi+8sQ58pqJ
	8tHRcYARRAjmGEl30B3GQZBUkT6vUBmulscO1krTTAyxZJKGz4Sop8pECTDNGKQVjdvTuJoBJgm
	jbZBXzcAa2lDvg7pJcYVoJ72W9N7Vrrg=
X-Gm-Gg: Acq92OFhpd9ZQFdPe2qq96xFoGqc0GrbqeRDXi1LfpX+7Xl5x8dOcSTRy8oaKg1Rhfa
	KmFY3dYJknslh1NLS9svOt/v0+BitdTea7eNGd7I3sfzD1Lr7eFBWItND0BM0nj5V2n4QrZh/EN
	1gYBAplrvwPV6UTOsCRCOqiTgWAvm7Weaxu1VNW0kvKfcVhqVsn7AqwlblqHKIqLrLM1DfyGAli
	Lgqu7NSz8dYn9j52I4Sg2N6fksXGrUdYIPFtylm41BVjCaaub1SdXDTLHRezbIVSu7tF90OSl26
	YmTuy5zGkdSMaVyG1DOYYAKLFEKI
X-Received: by 2002:a17:906:30d4:b0:bf1:6366:f8c4 with SMTP id
 a640c23a62f3a-bf1637645abmr130076766b.15.1780526525532; Wed, 03 Jun 2026
 15:42:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-generic_tracepoint-v2-0-b755a5cf67bb@meta.com>
 <20260518-generic_tracepoint-v2-2-b755a5cf67bb@meta.com> <eed59d12-969f-4135-a84b-4965743692cd@gmail.com>
 <20260526215741.1e5b3e42@fedora>
In-Reply-To: <20260526215741.1e5b3e42@fedora>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jun 2026 15:41:50 -0700
X-Gm-Features: AVHnY4JO84lm1Jm4LRIslikLFJmoC8aT5bml0xtrkTJBA4XifWgRoPCj9tn2DeY
Message-ID: <CAEf4BzY5MTGJyys369qDS3b63-tKq3okCpFMqUdfzy0dXk7vLg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] tracing: Expose tracepoint BTF ids via tracefs
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	Mykyta Yatsenko <yatsenko@meta.com>, linux-trace-kernel@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 6:57=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 26 May 2026 11:07:56 +0100
> Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:
>
> > Hi Steven,
> >
> > Gentle ping on this patch from the series.
> >
> > Since this part touches tracing, I=E2=80=99d appreciate your thoughts o=
n the
> > tracing changes whenever you have a chance.
> >
>
> Hi,
>
> I've been looking at this and was wondering if there are ways to not
> extend the trace_event_class structure. It's added for most trace
> events (actually each DECLARE_EVENT_CLASS). Although when things like
> BTF is enabled, this is a very small amount of extra memory.
>
> I haven't been ignoring this. I've just been thinking about other
> approaches, but haven't come up with anything. Of course, I haven't
> been spending that much time on it, as I've been focused on other
> things.

Just in theory, what alternative would there be besides having one
extra pointer in trace_event_class struct? Some sort of lookup by name
or something? E.g., if we know "call" part at runtime for any given
tracepoint for

.btf_ids                =3D __bpf_trace_btf_ids_##call,

we can probably lookup symbol from kallsyms and fetch BTF IDs that way
without extending the struct?

FWIW, this type info for tracepoints (classic and raw both) are very
useful, because right now one needs to do a bunch of work (subject to
break due to kernel type/name changes, etc) to find this, and for
various generic tracing tooling this type information is actually a
necessity to be useful.

That's just to say that it would be great to have this in some form of
shape, so please help getting this into acceptable form, thanks!

>
> -- Steve
