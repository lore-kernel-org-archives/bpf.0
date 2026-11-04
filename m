Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793766225;
	b=1cslmG7ICEzrN005HL7N52WAxZCPduhEvI4kM3DyKMkhsYt2XuR8eFbd0RgH+Bxxnz7B
	 cRhLHiiT2Qx9EM1I1+Zf6b9BwJymf6npLUGxceGATr6PA9WkDbTFiu2tQtgiUvvMxFKKO
	 GcitUuH7O1PbYjsVBuGqp0qw57AON7R6UFDrmeHQr86kpdC49Da5dAbe1RpAC4aOSp4QS
	 Ivkh2Z6OuPkVlsm4bTx9soG4kjobaLdjMGbOX2Fb3xzS0PDOuRo8R79l/cM1qaBohLjQ0
	 A0JK+ue5JIOTrRvYjJAR9g/PlP36xzILcZyrZ5oIJ/88rEhe9PDAZWW5t3Fuqdw5QkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793766225;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type:Content-Transfer-Encoding;
	bh=YRNZziqNeCRhg2/OKwe5SR/k0fV6elgIBlSt+p0bAm0=;
	b=M54vCh/DNay5kVNvBATYbU6eNkuZUVnH7OUNNZ651vEMJ2hRBZWIxdpzrvutWBDiepCX
	 x8Jf2b3Gp975K9QmcTqvXT+oePABugcAus9N+n0wSkv3Z7h/6mqIU+uAZpODzHVY0AoVc
	 r+5MMIvDj9/s7SFgqkwCmJVYvstqm9ddx9Sd9WQjzey+hx35pPYtVg14zdAWcgoasEU4I
	 AImFPe5W8zIqojseuqmB0ZcP1C0bwM11gUe4PGSBR4PiSVFXrA9HR5xpYdTcYZVxK7KAg
	 C/AkOcwxXm+uc/fBTjSdCuUfQ3n5m6F+kKaEcPMkZYSuc/3YjOY5T5RCtIWoiu8gqkg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fR6BXAGP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C485C606A31B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 04:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C485C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fR6BXAGP
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-535f598d126so104321cf.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 20:23:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793766224; cv=none;
        d=google.com; s=arc-20260327;
        b=oMOhRqoEOkJMlK0VjtD17QNCGqqLHLuAdNhXbmhwYrCMqBXTKll3YnG8YvYdcQUq6E
         +q6zbjJ9f6KecZ6j5FbVmxwmTIGVEpcy3bwbN0P0cFnrLbEJazmRyVxb6Mu+pAO4R6NC
         IPDoanLo/fqmQ+Mag40XnceLi+rJow1vbRbW6e5cgOL17qtsJwCmMFjUFzAs881g+VJ7
         GongIx6jfvwSNXRjNE9l0N1NXWLcZlXpz/NHU1J7L3y+WZ4Z8N5Z+HRrpwMzKbthn4Cy
         mrsznCq1yXASyZz0SEbdGnZqqbygrei/N379UrEHOz5lvFBYh08vRrfHw2eSrYgQKKjT
         HpmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YRNZziqNeCRhg2/OKwe5SR/k0fV6elgIBlSt+p0bAm0=;
        fh=dYYPb6QtIcemeuLy7cw6vcAzB5WvxCyQW9LoN9MtxV0=;
        b=Yw0v7lRa+lHc/dNKG1H2ObFbI/81CP1FgSsgxhzWZTDO/caGwt16e/yF9SQMEbL9W9
         CWndI+aP8TdbKCDbzX28F7jH4H0ExZUK/xloCQ0Wm0yIT0UlovS5mVKRofBpnpoNVQSv
         +2sXnfioDj8RlR3l38WGz9zv7XoSolW4Zz0qg8gsOuPKyF/warXQu0UCS8DkphVyuKro
         XzEbUdnciEoowB5TxsoWKfjB7bVx6OkTdOHVjHXSnxRyIt+Zi4qSRhg5RSHJcCeCcDBX
         bsppiDm8I3qVUFmoz01rM+h9OvyfLmelkSANkH4W973DIpJ8tT1jCtR7MRt4eyAf1484
         wn7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793766224; x=1794371024; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YRNZziqNeCRhg2/OKwe5SR/k0fV6elgIBlSt+p0bAm0=;
        b=fR6BXAGP/rO2SR67/BLSYdj14V4i1fTa+NE/DjoGSW1B7HKANQT7CR7qD74FxQdpOf
         NwKo9XHnikjAn4UAp7G4t04Vcm8+pRkRExNBzdb5Haq/ezLLl0iR7ucUemSoHGa01gio
         QUgQW7m+FDhXAXdg8eXJ34BSg2u+lYS+BG4pyk4pGN9z6qWPQ17uEVyOnD63uYiawdoZ
         7pz6N1nCVQTnnWXIwbhKKXAZyVN3yzAQdQY+0lUQzYtHwjGlJtjFZ45H/1KWK6GAuvOY
         x5yGcmfGjt26ALuU5Qxy8V+rTkSs42WaSWndNM3rJvGGe0Ak1DEJpMR+Yz4ei8TM+Zgu
         iPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793766224; x=1794371024;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YRNZziqNeCRhg2/OKwe5SR/k0fV6elgIBlSt+p0bAm0=;
        b=sxlbdTQf5aN4QyAOQtGr8dI9p9GK+7cgrTCTRk9cSk7OD2wlQK4VtdDSLO2CsJwRpZ
         Ba2Q5hF8NbUdIcB+mJRleb8+HcqcVeF89t+Oo/a1IzP3N7TMI0s8FEFASb4oFzR25c2V
         1akW/6odlq63EO+cPRSg0tOhyWjZBZzxbPUZva+kWYnOTz4GEcUvF0RXifBn+6VCGJ36
         3RuB0IZvRNqZ3XrPwo3Y7cxm1jLrFiIQRR20JELZiMRNKtdn3OntWYnHdMjLXaO4bOXt
         tvtD3IEON5HWCmBEaARd+BNFGO4Xm+x0+M0APrN8c81dc2gnCXLqwYYJr6op/80NjqSa
         mgMg==
X-Forwarded-Encrypted: i=1; AKwUvBx85MuzO1rCsEJUVg3XL2rMmhJlAC/hz8d95aj43gpAgMRJrH2Q2umE9ZxbI7HEfwLMV6s=@vger.kernel.org
X-Gm-Message-State: APuU4Z+SIINhyB4b3VEUhN09tDDyActu0IVX8x1O3GH61A10OqhUq5L2
	zwmov8Wq1Najh1nuC4LK+dtLKAWCb2qPMvWXNT4nA+J+9wONgdOh/qY9Ixh3fTNCxKVmxN3SWB1
	koaz6qiz5+EFNhacVJYcImTmW2uxroZ+3IRuciskN
X-Gm-Gg: AYBFou1f7umjxA22LVdN7WGQrNw9Pox3opm3i8QwTZ7kYm9sHF9aafLUwUlCDlBDAtO
	8tUWvocPgF1ysuUvHpQ9y0JOEhY2mFVf+Op51w/0OSD79Bdfs6vrr7y39bpKQ6LHl/BGxoFPhAw
	y2piOxAQQyA5ZR/GJwsm2Dn8m5G2MFC049SVJ0Eda12TjFJHWSPfaTvUiBCU81KauLi1sl9Ijbe
	mr0wmZwAhQeBHq+OMRGkUBc1cCqQ/V1KyDsvrq+epdxo/hyfHBbmCni2XO58bbXdQfJLhmtkxlc
	D42kEepikOaumaz8qGb2cehabC2Azp7jz+fiOMDZy0Tm7KkbMU3+zbWNBv+U9hCzdHkMIxfOkK6
	eoT4R+hniWLEpH+jPmVYjqtyTQdW7EktB4b8GqQ==
X-Received: by 2002:a05:622a:1b20:b0:545:7949:80a5 with SMTP id
 d75a77b69052e-54b829d9c94mr3580391cf.12.1793766223068; Tue, 03 Nov 2026
 20:23:43 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025215508.1237480-1-irogers@google.com>
In-Reply-To: <20261025215508.1237480-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 3 Nov 2026 20:23:28 -0800
X-Gm-Features: AclHuK-09ccaNUB_xQI1MlbkOynuoqVxYzBV14tH6-b6vEZf1TaXgfzq7UrUzCk
Message-ID: <CAP-5=fVsz3rX=T7_DAmdgDEK=LWGfSLr_7ZHJ8Z4-hehT035xQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf/core: Include attr.defer_output in is_sb_event()
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2026 at 2:55=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Events configured with attr.defer_output =3D 1 receive deferred callchain
> sideband records (PERF_RECORD_CALLCHAIN_DEFERRED) via perf_iterate_sb().
> Include attr->defer_output in is_sb_event() so that such events are
> attached to the sideband event list even when no other sideband flags
> (such as mmap or comm) are enabled on the event.
>
> Fixes: c69993ecdd4d ("perf: Support deferred user unwind")
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping. +Steve and Masami

Thanks,
Ian

> ---
>  kernel/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index c4217c996f5a..b43883a42566 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5347,7 +5347,7 @@ static bool is_sb_event(struct perf_event *event)
>             attr->comm || attr->comm_exec ||
>             attr->task || attr->ksymbol ||
>             attr->context_switch || attr->text_poke ||
> -           attr->bpf_event)
> +           attr->bpf_event || attr->defer_output)
>                 return true;
>
>         return false;
> --
> 2.56.0.307.g5fe7bd680c-goog
>
