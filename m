Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E48B3C277B
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 14:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772636373; cv=pass; b=jlJaSiQ/pHiFN/k8pW4H3Eb6brEH6t8uA2f9JLCjjIKCjoK7THfUH2is42d9+q7tb8q0f0HqlBw3UbUNT43XQFrmzIJmOLU5R6wvIPSTTaaS3Kt6ghVvuEM2IADueN7mbfQshIpOw+V14sYoTHpnxYN4XT8wJNkBkNUC7rQhJ1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772636373; c=relaxed/simple;
	bh=uSoEjVTtH2yRYHNI1qWfneOd15mGjWsNd1Rs+aqDNf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qyu1eH53+eQIWOlI0L1f+FETAJT1s9pDhWiu11tCUTeVFwup8+JNgXY6B0BzPqYWQVRkE2PyAChRR5rMPxVvVTpnHy+TEqiOve70lfvU8R1qYo4gsMK3KZNn/AaD/cwUAyehrdUuTPYPScXLVuPLuh5WhCq6ftZAn/DZseJwLtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L7/78VVx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=otUvRu+X; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7/78VVx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="otUvRu+X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772636371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bj/5yMdBDWJkOXTC2Px92RyAUlsr+FjJIWAonYXQ57U=;
	b=L7/78VVxxaFjNOZenbXMf+4Ubo1kN2vPQgc2CEh7H+UB3lSd1KA1SPx79zr3kXk3sUG2ax
	lyzvsn9Kt/Zerlhhpr+axgWUGPos3ukIXqRtQapx90jum3nAGm/WLRBR6LtNS6leEkoorU
	fn5rmsDlKYaBX73AZ6xoxxrbLT0rPxg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-5X3wI-vpNUimj9a_GKaw-g-1; Wed, 04 Mar 2026 09:59:30 -0500
X-MC-Unique: 5X3wI-vpNUimj9a_GKaw-g-1
X-Mimecast-MFC-AGG-ID: 5X3wI-vpNUimj9a_GKaw-g_1772636369
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b935cf0a2e2so764778966b.2
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 06:59:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772636369; cv=none;
        d=google.com; s=arc-20240605;
        b=gBuGf2QM6+7uWunYF9C/NINhQik0a3lO7c7HcmSj/gTsk+XSJKT0CALsXkQJkErvx/
         ln9BoQoGG4bYbh+KCBIJ4ywyqin1MWC79BKJDEWGitk87VmZCzRr3WmdKLmX8EQM3cv+
         AVgwDtK9FlxW+VupmwMLNASP6RScznH+2IV/guzXgYf/gz5I4bqNZC9gtZiAhZN7e7jB
         Dl++nYqM8nOxL6hyQpb/UYVP3T4eNX1moDn2uOvDJh8vcwF9tLU/Gv7FUJKNdBJAY/Sj
         StsGOjiI23P+kOyQktvZoKvm4P+jveizOG5RJYBHTeon1YZibyEj6IjSTbaBK3YjcmsU
         Re9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bj/5yMdBDWJkOXTC2Px92RyAUlsr+FjJIWAonYXQ57U=;
        fh=awS1NUzTYg6fLVob7jSNRoabUIyVwdS8KYpuIl1LNqU=;
        b=OvcB0l9pKbKKVv0sIPEQimr1Mu4hMOT7dZQn175rzlVfA4qQWMYCDGfMCN46lndejD
         ZXdJ+5IYAonX6g+CPsjGGw1CH8lQugo2BdbC9jVbk/+qJ82nJCQTk8HiaShcL8mkA0xS
         kFO+GGIHLKQ4Sd3S9gPQS+qFS4Bp5AW7N8cHeUe13d1csIR3NUHuZWMYglV/KOtQYyhb
         +2cq/Z5A9gXEaR4lTaxLAxouUSwAtRAkYhpe5RZMBA9u0931ImwBUwHRk7AmKfCndEyW
         TxOu5XHXAmP7AE6pM/E41M5jeFhO9Z/BqbTuMcRWN2Q2z0pVcDfOvxtDH8OtMUQVPWo9
         Hamg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772636369; x=1773241169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bj/5yMdBDWJkOXTC2Px92RyAUlsr+FjJIWAonYXQ57U=;
        b=otUvRu+XDCtYAq6zdZxt9/hWkoe/++Y2NGj2gOjAx2zTjZAIOGYodi+VhubaaT3+E3
         YIs64kCdIYEUFmCKQlN5d50U5TnPuIhCFVicmETW3cQ3DnF7aXCEFs8xVbaStr4PiTvE
         MBZ5fqCyqLOU8d0SHqJOLwDZ8w+zYC14ATp35x+rjYbUuJsYFNkp6mI64L55O1036Z2t
         YUOCTW4giQgAG+CLsfaBSVg76eLFoesVaJM9Z/Rb1cmIHCqUJrxm2DmJmBBXQL8zv/69
         2ufMLO/DeGzG9brtcriChUVEt4SG6a6LIg6QF9KD37/lhAR5eT9NIXqo3dzA0v0uhyDQ
         Utmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772636369; x=1773241169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bj/5yMdBDWJkOXTC2Px92RyAUlsr+FjJIWAonYXQ57U=;
        b=V3IsxIc2wLwplVqeEUzHf+XkbqakTwAHPER94J8evgrqsTEXGDLpx9tE6Oz9C8mWAR
         W1Iso1hcXBQNXq5nskn7dHD8In4ulJkIqv2KOnEDc8SslDiv/Vs8rd6rDaefO/ck5+ep
         1/OcmnQq5nN/oImDiqd/WXOK1mehdPlCHQy08Uz8DASOQBAlgitQSfYT7cv5QCUiWoXW
         Vv/Q3vidc3iBFk33oGsd3IchMc6AwGrHHHR0fjVO/8OLiCI+WaLKZ763CDmgjov0KP7d
         X4ptQWt5XhQrXkBEtEeCPwCbJNXQ1mnYAKAZJQli/rO2C+LREpg+DF/LMtUXYN/9oz+N
         7j+A==
X-Forwarded-Encrypted: i=1; AJvYcCVtwC1xoXRGyB8qjDCCoYz3qi+BgrxvicP7XV96CggGD1H0vZalnaeVE9KTZyLq3S24k6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YztkdRk+JSE9k0yY2lXlOunc7YigjFzlvT4jWOeTWcY9RHCXDBP
	MV/EeT3vKEvtNTVXR/GPkP/eU2IiXN7+s8xjAmC797XywpXlUqWjz7AuG1hraHXcDe/bZxiHbxo
	kHZsjvkLPbJ4iKWaOngG2wf7dtfme6SIjRhGGOn7j1C6OZ/fS6AD1lN5cM/SqtyJtbqySCZuOHZ
	YzEul2ju8fblXzv5/cn+QnlreVifEe
X-Gm-Gg: ATEYQzwpjV4qxX6/F7HnkpPgJGRJux9PdhLM28BEcQbcfgeMMBdG4Bt99ORtVK9FS5A
	XRMoRfx3NnahsXxYc4yGS3A9fviTS81Blb7xYz3fTvGc3Yv3Zir6d0Gbjlv34A7yYb1DKpNs8IZ
	C7PCy6Oc0sXXdvH4ZGAK6p5eAFoG1DLrB+Z70I66uRTjBZz2Qrjdcn82IAcA7Jrh53Z2z24Vnc8
	PECAQ==
X-Received: by 2002:a17:907:3f9d:b0:b73:1634:6d71 with SMTP id a640c23a62f3a-b93f139a117mr151528766b.26.1772636367756;
        Wed, 04 Mar 2026 06:59:27 -0800 (PST)
X-Received: by 2002:a17:907:3f9d:b0:b73:1634:6d71 with SMTP id
 a640c23a62f3a-b93f139a117mr151526466b.26.1772636367284; Wed, 04 Mar 2026
 06:59:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213115234.430232-1-costa.shul@redhat.com> <20260213115234.430232-2-costa.shul@redhat.com>
In-Reply-To: <20260213115234.430232-2-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 4 Mar 2026 15:59:15 +0100
X-Gm-Features: AaiRm50W5XgcVaRxDrrDhMzIx6wWJ0AwKH3P27IrG89izS8ysvSoNwR-P3e5lK4
Message-ID: <CAP4=nvQ8xFr2mD4z01e656hfE9btiFRu8xrqHiR0zGkDYsiVSQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] tools/rtla: Consolidate nr_cpus usage across all tools
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 13. 2. 2026 v 12:53 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
> --- a/tools/tracing/rtla/src/common.c
> +++ b/tools/tracing/rtla/src/common.c
> @@ -5,12 +5,14 @@
>  #include <signal.h>
>  #include <stdlib.h>
>  #include <string.h>
> -#include <unistd.h>
>  #include <getopt.h>
> +#include <sys/sysinfo.h>
> +
>  #include "common.h"
>
>  struct trace_instance *trace_inst;
>  volatile int stop_tracing;
> +int nr_cpus;
>

This should be updated on top of the unit tests patchset [1] to also
include and initialize this global variable in tests, right? Without
that, unit tests fail to compile with undefined reference.

[1] https://lore.kernel.org/linux-trace-kernel/20260119105857.797498-1-cost=
a.shul@redhat.com/

Tomas

