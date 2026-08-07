Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC267393DEB
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786113191; cv=pass; b=LrgrMwG7ZtZzTLSdxTWGwYfIBrkkUjQbEyGdC2hSgbZLkBydfSogEmoYoyZGaOOeT4c0ktyCaOSDl5pNv9UiX8UGzVU8+LsH21i+jX0WsQqN78MT0uCCmTHaZECUDE7+98Kpq4V30iXEn0NyH7lOQ0fq8W9qXkuEC8Mqpa3PDpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786113191; c=relaxed/simple;
	bh=YccBFGTTYtE+pByX+TnsqBnpsyvc+9fDzsZqfxshfOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/aba6ICCCJN99rpTU+iszjo4qBASRKx+0IcPDZ1E+XByTE3TlfI8SFjCy0s4V+iSlYHI4z32Ys+YOwzW/rQLISs2jXMTznD9f3vG8S00oDWCTXCiaY71fKfupR6dlMI6JYCB05xu3eyWL6veio+t2nSEcOsehe3oW5GWAFAXvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khORmEYz; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khORmEYz"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15cd3fd760so374848066b.2
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 07:33:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786113188; cv=none;
        d=google.com; s=arc-20260327;
        b=RFmkn7sKtg254nN8BSPKQAdyLj8nHIDXkwfWwWOaUl3HPtQWZdtuF/iSXp/cL4sNfM
         ViHq5nszppFHzqlbKsFhoaWTRCXibS6bug1OOuZ3Kgcm/3F4HiSCW88TqrVpS54ZZHcs
         itRsQTtQ3fXFa/T2iSe3QKZBkPwSH02vwCRtzhzIXh8h4363hr1CAx9rl//vCvm4SaD9
         Js9S0uZKbuN+7H8Y58W41gTi9JavhEVvP/vnzO2wR4rF2D2RbPJKYrNoV+HLsKiFqaNY
         Zy1UHHzZ/PP2jEj/DdpIyVq/yOwc4yJAlcXH1ggykNg/8HbDZUarUMSH7WoEHPVEFapf
         zRSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HpOmJpx/ADqA+1gbMGirD4LpSKVgKnj37zwmvfF6jPY=;
        fh=OsB3RjrRHETMshCkzmHDGbua/2QmLgD0rcKgRgcQfwg=;
        b=n0BSSiwQKTOLlW3zJhbIR4mB/epk0h7t4HVqQFJu85S7TDAL0qazKGQhalq2ogYwjr
         o0sO5ZGXXNFlayF8le9x+nd2+gdstJNV7jxdKmLRkMQELesXc4jg0v2/hp3t8T1vCqnB
         M+U27RqB24T6uRxu8B4EyG01LK0PU4r+0QxF4vQpM/3b6IXdn6PDdHrocz/9v7LBzlUo
         /KZNrro6Bep1EwB3IH1Y/8KueX8Pq/wjzXUoV39D0btYlTkrjMACENQje4ZD8P0RVkHo
         lDdtIIDhPhpB4r7KdRmu4a2M9jH+T/0fQOPcdYMMucTZXa/vKWJMNY0ypyHIBzptfUXe
         /I1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786113188; x=1786717988; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HpOmJpx/ADqA+1gbMGirD4LpSKVgKnj37zwmvfF6jPY=;
        b=khORmEYz+b30IPLjLbHSBbBqMdsRPJe3/BqdTr+MId4MJJwUAczNoL2myoRytt/LHf
         cExp517N/G8c+Mz/hwlP6convcp5ffCKH3g20zHiRHHT6ixlnPnOZGb5cAtWep8VfZMa
         pR1LEWFFHYLvuFB5rjVYJWvMkfFuU0bTdu0JJvG7kDyBaxBpjyBKwQxke5Nc/5D8WSgX
         azcHoQWZJUQKWJSDlq7CqKLTpYH9qXjHnUAN9eL57dI74i9EkLOhfAZhdROZqZXF4sGo
         v1s6TXU/WFUPg5ADdspjj9wMK9wnWwpzCjorWIc47GAI5TBVS1zNc3VAzImnD60K62pa
         N6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786113188; x=1786717988;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HpOmJpx/ADqA+1gbMGirD4LpSKVgKnj37zwmvfF6jPY=;
        b=JpPN3mhCMi1dfLU6ff3z+0nGg0GlzC/dgUTIuyPFMmF3YkPVUBYAk6ai818O//FFM6
         ZOQV6/3HvhR4DB5tAidjE0sGWOrOw8qvZzU/+W2lWEA86QVBSnf0XcspP/ki/Z1NHL7k
         LVUPugbATwAjR/RU50COUdZeOOMeuW563oMmUn5C7eR7lUTDySgbXlySXfXSRpW7IvKo
         BndpE5XqsMJhkPVcKMocCWOfAXNGV/qVpHTNjbFdMnbYkFLvKjT/wY/U1wLjse5Tm4nL
         pN5r1g559JvsbTpGzu4pHPSM9VaxpionR41HFpJ/eiMoj71CEP+LEdlhGAUefwHWpWNu
         uSqA==
X-Forwarded-Encrypted: i=1; AHgh+Ro5nSmC3nSYWFxrncHb1CA5u0XX9cNh+BZHkjOYplIBaaii4n3Co6fLXb6czze9bOkG2nE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTNpmPUxhmglJ5vRYur5qDw58/RgCka/M3B4yYaqj4li+cCsc6
	thru2d3vEAJ9qLCQITWDNb+H9GI2yOf2kv57LSmsO5cwBSB7OChEmhNmP1aZVuQQTmAW1FevabW
	BmV9pW8Bkk/SUgvcKCVEejFCGvi5qHoM=
X-Gm-Gg: AR+sD13mfhDF5wOBvC9Pk3tI5B1WCESls6BMJFahCUlv4quorrNVpr3dfjzy8VDsXob
	w8+jz4dzkEvVSlfgm66SPKjPLisyezv74ySz/q+pMBlug75c3dK5vGNYRxieEo4RnEmxknKv1is
	MYv4EkpIuU9wDCMclsiljiwEztHrmKu19WYkyQScg7S2QGD5M7zdqnWzf7j7/e4EdfzRd8Fn05W
	cGlUrnwDBqsxxMhB4Ay62T68xRyKv6o+PfHThaMCMsYzdx6skueJTYeKNqEXjtpLAlGlbBX9dIt
	Pc1N8DuMskTa11GFmV8xFbru2s8vZImV5VIBZViu289ghmcvAi/KOPZ1W8T/
X-Received: by 2002:a17:907:1b12:b0:c20:191e:89f3 with SMTP id
 a640c23a62f3a-c2039c563admr1000445366b.16.1786113187576; Fri, 07 Aug 2026
 07:33:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806135224.3267890-1-puranjay@kernel.org> <20260806135224.3267890-4-puranjay@kernel.org>
 <20260807102932.GU776954@noisy.programming.kicks-ass.net>
In-Reply-To: <20260807102932.GU776954@noisy.programming.kicks-ass.net>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 7 Aug 2026 15:32:53 +0100
X-Gm-Features: AUfX_mxyzLraY9hB4bhCgklGOwwZVl4fSNPtqGoxIfRbh3s6Vi-E_Sl4h_YJMAA
Message-ID: <CANk7y0gxiQdKsGKrF2xhp5nS7Vc6zGBVVSb_US_x_Eb6vyZjhg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] perf/core: Clear the whole branch entry in perf_clear_branch_entry()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Usama Arif <usama.arif@linux.dev>, 
	Will Deacon <will@kernel.org>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 11:29=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Aug 06, 2026 at 06:52:23AM -0700, Puranjay Mohan wrote:
> > perf_clear_branch_entry_bitfields() clears the bitfields of struct
> > perf_branch_entry one by one and leaves from/to alone, since callers
> > overwrite those straight away. The list has to be kept in sync with the
> > struct by hand and has already fallen behind: new_type and priv were
> > added to perf_branch_entry and never added here.
> >
> > Only BRBE writes those two, and neither is written for every record.
> > brbe_set_perf_entry_type() leaves new_type alone for a branch type it
> > does not recognise, and priv is not set for source-only records.
> > arm_pmuv3.c allocates the per-CPU branch stack with kmalloc(), so such =
a
> > record carries whatever the slot held: uninitialised kmalloc() data on
> > the first pass over the buffer, the previous record's values after that=
.
> > Both reach userspace through the branch stack. Nothing under
> > arch/x86/events/ writes either field, so x86 is unaffected.
> >
> > Clear the entry with a single struct assignment instead:
> >
> >       *br =3D (struct perf_branch_entry){ };
> >
> > The bitfields add up to exactly 64 bits, so there is no padding, and
> > every caller assigns from/to immediately afterwards, so zeroing those a=
s
> > well changes nothing. PERF_BR_SPEC_NA is 0, so dropping the explicit
> > spec assignment leaves the behaviour unchanged. Nothing needs keeping i=
n
> > sync when a field is added.
> >
> > The helper no longer touches only bitfields, so rename it to
> > perf_clear_branch_entry().
>
> Fair enough I suppose, but then why not write it like so?

Yes, that is better. I will use your version in v7.

Thanks,
Puranjay
