Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D4E3B5846
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772636234; cv=pass; b=NSyCbbFXMzpqgvpiyTby/gJjoLSO/Uu/po7v0dHWuEjMDWK/pIO5QWHxMk9+u75vQGg/SshjOWOtGnw8h2aDxThL3HkuUVKTieDwNEPPIZMU3ada7xjdoqeuTCndYAQ0izD+R4oB+cy3YfNc+E0p2wIsZ8RaY5ED6RQG+nxpaFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772636234; c=relaxed/simple;
	bh=oHGf015O3HEFczpp/doR7GCeyn5AXcOYhDM9+nhRjvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owMtiLfXX4xbz+9Liiq/TrmpCwyVPWFe9jvzazjEvQaCdQWj+fIgQBrZtxDGArJrawIz9ROyfwsgwLAdbW5R/5WtYhLSibuDaYheWd/d+9fV7xzI9P3ahGDyziZ8G6HNegd3lBa6wM0HpSEXx73/FoF1O43OqZ4amiYa1sifepc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rjlq/pwA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QC4pu86N; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rjlq/pwA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QC4pu86N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772636232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NxcuwNQEbPJtChtRmmX8bmzTS5j+ytdkrBn203bf/CM=;
	b=Rjlq/pwAQb8KdSp311PkTqi60i/RDVbtDqJxOBaGW56ev6XWVm3wvalGrhuRyCfjlrmzq9
	qR4ZJE4OTtLETejRpxIw6XnccxJB5atCA6dix0M9Eb6MWZPWv7QJEoFx62ipnOjhNrXJuT
	gVYF/W7LHJG62k1wFGcsiNmwyVqtRdQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-yh_pjF_uNuCo0y1ixQPyRg-1; Wed, 04 Mar 2026 09:57:10 -0500
X-MC-Unique: yh_pjF_uNuCo0y1ixQPyRg-1
X-Mimecast-MFC-AGG-ID: yh_pjF_uNuCo0y1ixQPyRg_1772636229
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b844098869cso698445966b.2
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 06:57:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772636229; cv=none;
        d=google.com; s=arc-20240605;
        b=PKLW1fdLGMI0zBisnKsiX/AK0d0DhaHZQ2Ph+uI2KOYV96VEQD2AWGBBmeXwvKOyf1
         EAnZmL7E9zcs2EoMJ8VIZ8hrYvCJ+CGsozBsk+aHA/yoD+Qr8iCNgzieFcQEvDYZT9up
         kzoADes3X1gCtGlWQtTnqLR1VgjLhHJoy9U/giLIsCmUZPyaRD6Yhw9mjdZyAzKxJ1Ko
         Q8SHByhbKUUKEm46KFEv8zAI4WdMqzdzGYN3KnQuq1QgDQVxWRTDOrVXqYc9pGJhGJ6H
         d4Yee4p2ViQrOhJcQZ8uMGfaCcrGrnsvE/1xVtZ2VoGx9Xg8leLu+cdEpn2Ahm1oYSWA
         HI5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NxcuwNQEbPJtChtRmmX8bmzTS5j+ytdkrBn203bf/CM=;
        fh=dTIhBjNrlnuewY7bigIR1Ze8jwuj9ViDDtr3yg+lmxs=;
        b=hvCn2JLpAxy8vKmpm4TXRLFLOc6epxoz9+U8chLuoSLJHQd6zEBsUdRhFexEuRgfQE
         MbXeGbjEQ2au9hG+lihL5Jj/gz+dHBVDLEFVX+/FR+7YMUOu+erknKkqZ1vNfVWUNzg/
         Sh/eVD6gZvcQwGQ5qIjIClYF3gy1YuwDIsdLKY/AB9dj+otVzwz92S36A67HsSMM0ftU
         RVQorl0RjgphL9VmhLpl+lALyu72kJVQ7OJW/ktYDBNQEzhexzXfHItyPwOnOK7/fGSj
         WvY0610f3S/3yQoIynturFTQ+mNNvDlyyBevmU9zHoRQx2SbxSzoLQnpWH2DWXURVypB
         5eWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772636229; x=1773241029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxcuwNQEbPJtChtRmmX8bmzTS5j+ytdkrBn203bf/CM=;
        b=QC4pu86N/vuyjfS7kiaifo1n5ppTmVnzlq6DvIMRK8LxQtQXZoS1TJmpLc3BQ5ac7E
         90XbEwFb/PvCUrbLJ1zinZMW5AHQ/uOnm+QJYELdlQuQueh431LHq4f+VnS2YJU9uiq9
         ZefXy8wh9Fc0OHdhuEgC1l/jEUb8ZZXXQ/8wnRosQr17RD0NRjAyMxUz99TkyeERaU0u
         ny7oXcVXiWN0LACQ9Tqwxt5jMr7nFMf79DAd6T+48Q2xXTDOZ0zHMx+i7ylMHEIWR01V
         zbDXJuX3AiR0FY8f/22QSMHKhK1HPHbR9PwLdnLUG8qZIy2SvFS1BjUqcUEXHW6Gga4B
         6yrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772636229; x=1773241029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NxcuwNQEbPJtChtRmmX8bmzTS5j+ytdkrBn203bf/CM=;
        b=DIA3qCgAFdxiG0h7QEYq7ZCQnVCsTKsW7Bzx7yC29rScLmzR2gSPHKgnQC2h0CY9q0
         gg3oXnHq3qLo6IoSIuhIRTZeobdo+Sm/YBfk5cy+DnnqFqyyeoCLADpUGDJFevCQEufH
         JhO1q4i/4EhtFRoLH4oKif+PMlDO3lewDxsEjimhDg3Lr7fApqlq87X+5hN4chS2KUcS
         iUp6aCWQ3bLj1ymxuOvb4Cazi5AKWPi75immCTCqNTJ3yw0ycVgZF+nw5ktGeAtAYbBR
         uYwLUnC9h87M2/FzHvpLkzKY1eDTCtoS46GSL9NUupwavYMvz6fZPXrh+pW0oRZDgL3N
         qusg==
X-Forwarded-Encrypted: i=1; AJvYcCXU+OoB50K6+WLyJuih0CtuLjgEaFyp75blkOoMEa7ideVrWFezcx3GKTYhMCEJARwgdQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2lCIDSbECJL5cTSQ6ZTSpqXPzzBtuEBHIYoYeK+5kggkhVryX
	89CMTSSoiGijpGv7cJUHkT1iCTapzN5AGFYwA1oZsR3j+RmNtlZ3VJ9ENmjDddJAPCwIdgtgI1b
	cWQvSAvrOuyuJKPNYqMq5qk4+rtkiQ0fJ0gmjyHdWX/hZgAdkhw/76Hpu2CYQFDh9ju9Jvyxofc
	UccwT3RDi2upvP+Ye2AATZuyKBBMct
X-Gm-Gg: ATEYQzxOcIEBA44T+uOSwhnfuiAGHL0m5qG3ZTg8QjS7EP9aTrqntNfOPcktNNItZXE
	5kADn3afzB0OUppvywREnpONIitSZ2fhxPS24YeDRUU2ZiGByYT2ju53SFa/DNoMQ4jGmw9eur3
	GBiE0+Wx2LOaWLTc7eCrK0gWKzYEm826Ncv9cJwInJ2habrqY2+6LfbhvNIgY5qFncAfQmm+SYY
	W0m8w==
X-Received: by 2002:a17:907:d18:b0:b93:a3db:a6b9 with SMTP id a640c23a62f3a-b93f1584a51mr122660866b.53.1772636229391;
        Wed, 04 Mar 2026 06:57:09 -0800 (PST)
X-Received: by 2002:a17:907:d18:b0:b93:a3db:a6b9 with SMTP id
 a640c23a62f3a-b93f1584a51mr122659466b.53.1772636228844; Wed, 04 Mar 2026
 06:57:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213115234.430232-1-costa.shul@redhat.com> <20260213115234.430232-6-costa.shul@redhat.com>
In-Reply-To: <20260213115234.430232-6-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 4 Mar 2026 15:56:57 +0100
X-Gm-Features: AaiRm53z50JmqmT1o6Ph_54puJ9QJQq9UavtQvA3Nx1tVw-urpPxa1yu1HVK3Tg
Message-ID: <CAP4=nvQZT9GB85cHkkFBL+BRzsiU+15RG7a1aQ3jp4BPA+1Axg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] tools/rtla: Remove unneeded cpus parameter from
 timerlat BPF functions
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
>
> nr_cpus is a global variable available throughout the codebase, so
> passing it as a function parameter is unnecessary.
>
> Remove the cpus parameter from timerlat_bpf_get_hist_value() and
> get_value(), using the global nr_cpus directly.
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  tools/tracing/rtla/src/timerlat_bpf.c  | 16 +++++++---------
>  tools/tracing/rtla/src/timerlat_bpf.h  |  6 ++----
>  tools/tracing/rtla/src/timerlat_hist.c |  2 +-
>  3 files changed, 10 insertions(+), 14 deletions(-)
>

Is there a reason to have a separate commit for this? The change fits
into the "tools/rtla: Remove unneeded nr_cpus arguments", which also
touches some of the functions in timerlat_bpf.c. It feels strange to
have some timerlat BPF functions cleaned up in that commit and some in
this one.

Tomas

