Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AD4379EE7
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 09:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791971535; cv=none; b=qFKXVbU3zqSWGfv+QmyKeoGGUH8XNw6n/P0OAUNQsqiVshq+TbMTFFEO7/ew79YSebBq+7hmj25NQlBK4PeXDQs0F/yWU6DUXdyDSUFLSlageEr4iwoS/GGxoQHkSnKz++Pzj3LCy2m4ORvMINQf+Kh8ijFHmBWLwf27fWz89fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791971535; c=relaxed/simple;
	bh=uXYzMefJOP+aHO3bNqIlMQmN18rqz1b+wDrH65TOCEE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pUQ3L7VUkF2QEp755xeQWrdDf7Tp5nIx86LW7uPgB56La1a6wPHD5o/iPkhyOdl+CbwIf5g1hERENRBQlCJ7PqVuVpG0xGz9ezqTjZnWMb05NjWYqjtv1qEQV/A/7O1LytQ4+t2Xa6DdVP2srjLqJlt/vVWfhOekUtFl5lqSG7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QNiHo/+v; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=P3yOk370; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QNiHo/+v";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3yOk370"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791971532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ew/yEA9efwsEsgTzBND1D0weZnW/cI9Jw/YyC/suOs8=;
	b=QNiHo/+vzy0HQPpJOnuwxaetnoPbgfqAB1WX2EOLPLdLjr5llFTdj8SEPpkMdtUj4TmlI3
	xXbmkzTGmUi3KSDfpeHAhTl48GUIRtB/uq+R8hsRhz516XtwZKSIU3dTyp7qGqAK90dYMz
	xKduoozd2JwK4K/fqO2EJTVBoSOhDm4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-3bkGwKDfNkOMahHGBKFAEw-1; Wed, 14 Oct 2026 09:52:11 +0000
X-MC-Unique: 3bkGwKDfNkOMahHGBKFAEw-1
X-Mimecast-MFC-AGG-ID: 3bkGwKDfNkOMahHGBKFAEw_1791971530
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4870142f030so2321105f8f.2
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 02:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791971530; x=1792576330; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ew/yEA9efwsEsgTzBND1D0weZnW/cI9Jw/YyC/suOs8=;
        b=P3yOk370FYz3ds2ok6YIQppHaZwq2rD3XJE+j7bvH/HbBvVGIPHc5NBeH9tVfjAnvT
         4ZE5hsW5Eovx8S28G7YXtHRAvdnsVpMihc1M7h1T6v4axXNCTc/BdYdI3DFW9BYb8hJO
         GWWYU4DLNemNyb/uj+sOVQgouIaAU34wHhxOK0yU+OoErewWWHN8gtNVA1vR2tXGPXH1
         n6BcF0IOt+deQUSlIZzswmBeWQRQway1VnLArZWTvMKGX+VpNBvKstJmPLRU4RkCqNoQ
         mXM6IQEZJX5y20Fi5m5304HrJdkDRxwH49h9zv4rBauENbjsRRRcOwny2BU/ZRCzPoNt
         XZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791971530; x=1792576330;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ew/yEA9efwsEsgTzBND1D0weZnW/cI9Jw/YyC/suOs8=;
        b=xQvsmaTBukgMFFZFsjX0PNQZkUi+k7xMWuAW9Iv69O1u6csRmnPvYjWpuKq2CsF2/r
         Lj3DKbuupL+OEHKv5a43QfpZ4CVPTz+OY+/ZdrUymEiSCLjybo1s+m7aqEwiPoYb9QgK
         +hMy8cDuq3Y3gUAkOded1AyToAi8DQt+SHKf2xN3BXqGDBKS2zzEkpK55BToIprp/1mG
         RfXWDva5OdtL4QH+zAoQLqNKmBmPg1HvOPNBX2A8u6RNpmH9q9cxMXQpc3pvHHwOv6Wo
         ja3RHID3dOt1pM4SP7UiuRhTQiXE1VCLwB7JSJ+uo+k7QksnOvSDPXJbbi7rqnZ+u+J0
         dbXA==
X-Forwarded-Encrypted: i=1; AKwUvBw/hYOd89Jsx0HUqlx2C4rRIeZ8juFiusrrSxlWeyEtSg8FplRJha2oRf4nRXzZLeeKqgI=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/vjp/WZsq+IMrDTjGUF+65J1Dlmpm0OaJnzWe+DWVEfvtTyVQ
	3qnOkjZ0b08N760pEoni8369kTakVKqaPdNLuERoEDp5PfZ3zhykyCiwfwfZNlb1qVbL6aK6bji
	al1sqv+xS04DPnStpYHP0EqrSNxSRx4Tlk+Crx864LzBi0/B0BO4DdQ==
X-Gm-Gg: AYBFou11yYriuxIX9BhKyaJWdllqEXCR3L1g7zYwv0+z2r9ab88Ym2EPo9EvkUwjwbX
	TiyEVVO44TAGIytNdtoLmy6aSeY3GoMAEwEvDcA/7D91ceevDt10XVGtMP55cDUvzVzyZWo6Xs/
	cDYkQOeVIa3PlInfK0//B2yh9o3mvcCiTeTPaN4sBaZgFL97IfeBl7Y5LJQlZkkdqRAPH4G9V1C
	jIfS6mtvSWseKgmTI8qHqAsJQuHNevnuDUbqHdiFG4NAaQjL1DBoCJK5HVjZPk2KwX+NIjM5rof
	mjrncj82nN7QkR83YW86TCSw8MLnorUZC0LB4jmTtJb8piDr3mavGelXsCOlPbeCj+wsLRMGkYp
	QVbJHLVdwhZLfkbnxDHYNqSa/ugO0
X-Received: by 2002:a05:600c:8b70:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4a18e4a01acmr312576245e9.9.1791971530368;
        Wed, 14 Oct 2026 02:52:10 -0700 (PDT)
X-Received: by 2002:a05:600c:8b70:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4a18e4a01acmr312575565e9.9.1791971529966;
        Wed, 14 Oct 2026 02:52:09 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.135.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be97d1esm679092125e9.8.2026.10.14.02.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 02:52:09 -0700 (PDT)
Message-ID: <1ff1999324ecbbfe9a36f8c088d7d4122ae59177.camel@redhat.com>
Subject: Re: [PATCH v2 04/15] rv: Cast result of model_get_*_name()
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: Wen Yang <wen.yang@linux.dev>, Tobias Schaffner
	 <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Date: Wed, 14 Oct 2026 11:52:08 +0200
In-Reply-To: <87jynmgm94.fsf@yellow.woof>
References: <20261001152042.124445-1-gmonaco@redhat.com>
	 <20261001152042.124445-5-gmonaco@redhat.com> <87jynmgm94.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-10-13 at 08:14 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
>=20
> > Functions like model_get_event_name() and model_get_state_name() are
> > shared with BPF monitors, however those programs don't play nice with
> > string pointers without fixed length and the event_name and state_name
> > arrays need to be defined differently. This gets the compiler to notice
> > those are const char and the above function discard the const qualifier=
.
> >=20
> > Drop the warning by casting the result to (char *). Note, a cleaner
> > solution would require to modify all callers, but that would require
> > changing every single monitor's tracepoint and the advantage is minimal=
.
>=20
> I prefer the cleaner solution. Just mass replace "char *" with
> "const char *", and manually fix up a few errors and we are done.

The reason I initially didn't do this was that some lines get beyond 100
characters adding the const, so I'd need to break them and make rvgen even =
more
complicated to generate things (TL;DR still laziness).

I'm actually taking a different approach and storing everything in macros l=
ike:

#define DEFINE_DA_EVENT(name)						\
	DEFINE_EVENT(event_da_monitor, name,				\
		TP_PROTO(char *state, char *event,			\
			 char *next_state, bool final_state),		\
		TP_ARGS(state, event, next_state, final_state))

So both per-monitor trace headers and rvgen get simpler and if we ever need=
 to
change something again, it comes for free.

Gabriele

