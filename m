Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C48B313540
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772632662; cv=pass; b=Tho9j9jic9WzumZg1EPBJ7g8JPZAi5dXyjESzErDBxY/xN3HaY4MJESN2vmnAyNtWWpQwr8D23Uwk/zAZPLZi1o7DLOK+tCAbD72LTyybjP41cyMuAdRIGZ5iyP8ACSN6toOI3oeKggBYSAaHlBwTPrWeCSljk/BCXtrYy3WqOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772632662; c=relaxed/simple;
	bh=cYloBhpvurhtJuftD7mo7c+dIKZCjU4qg99tSf1La6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OoO4Fz0gAnH2BNb/3rkYj69wchz34JmjZzO2K7x5kr+SerTJPTqjoiBBdHmpFYOsfTo4t472VhXP1tQZWh7O/V9aDoM7fcruF/BAFwZ4qDrFcHr85C+ERs8ZAzccwMJ9hjjD6GR4G4fpllBFPHsV2wW9KN93V1wKLQ3gSeCcDAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VMDRqcqP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jpwV/ac5; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VMDRqcqP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jpwV/ac5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772632660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1W/srayQRvqMo/yxxutNDTdINw68flwZKgc3vV8bRQ=;
	b=VMDRqcqPwzjCHqx+R1OiVseZXv6E6pSkRZMEVIDsxaxPYcQ9CbIViQSdYEJHKKcPQVWocT
	FkpIBcvACTnNeIbTVZJwSS/ro5CxmnkuuNDoFXzS/vl9o5O1UqLizetJew9YrUTufYYoev
	+ExFgthoDqaKbE6eg1wSW+n+ApfjKUo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-QoFx1O1sPrqsqdh6HT48dA-1; Wed, 04 Mar 2026 08:57:39 -0500
X-MC-Unique: QoFx1O1sPrqsqdh6HT48dA-1
X-Mimecast-MFC-AGG-ID: QoFx1O1sPrqsqdh6HT48dA_1772632658
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b934e96af9dso794539166b.3
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 05:57:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772632658; cv=none;
        d=google.com; s=arc-20240605;
        b=YCQFZK1ABzsEnlVG7lY9jljEjkBmBRkZuGAfalfdvYrWAxMapA6N7XV7kNaMvQMiHS
         0bv0KjL3hyuozCShE5FSjnWpd7LZJ8BBbwBXzkFpwCic8/YvjMKnbqIe7RplvAoWlDqd
         bnYRvm5FqtfIOS4CgBVRwSYY01MsPfWW4JQhunibdbA+2Y5WronKxobho25ZQXqh25fA
         O852TLBv7Tdc5UZCXPEGVD8qKV9Az4xYHsHF/x7UwxKmgp2Uv/3rKGXkaE5DAfF1d8wu
         lubCaZ02XgkJggS0VSPFb1vSjI+AXyNPg9Z6YRjM5aOUD9UiJnXGSPNtCqNpg26HexGZ
         uFTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y1W/srayQRvqMo/yxxutNDTdINw68flwZKgc3vV8bRQ=;
        fh=YDAYeS64cadZHLR3/kbv2248MYMPCnDXuY63ko+R+eY=;
        b=kdoC18ziAZUAcLBYTC3Ab6JxHBXyaXoReAK12l/VNYFlcPZU4mL/5b8KB5C1V33nb/
         lf4iZCElNu9XKKinMQbQmXeMhsS7HcnLHhEkYf8B7g90T8pQVZBP3SNCLJN10fck/fS7
         5YaWCW6iR/MMRFvdtCB+TrXeGg/gb2xdSRZm9NFnJYlg9yaawcAW7SpC7oqvga8qFCKO
         exDPdewkBjiGveM/2uG5OhqMwz7LgSYnDw/gOVbgGfcMC/ntURabDDQ0OMxzI/as/jBI
         XSxeJRy4opPE8SZbgSyvtqDoq2WgwWCK46w/y8tMQFB4htivhXK9RlGsoXXG0NnZVm3b
         pRbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772632658; x=1773237458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1W/srayQRvqMo/yxxutNDTdINw68flwZKgc3vV8bRQ=;
        b=jpwV/ac5ErjoX2hpn/qP9zH1cU/ZVpruDHDC01x09zAanEIsahNbgKEIGBVW9dU94P
         BtEDypwPJChWXlVmYqUrJtKuJG6MdUISDdW8clrDtsRu0FWYjO5S6ABguKb5RKqLp8fq
         g8mCbBIImjPjKO5Vh7X2La35SXUNH4RA2DIUxnN5jyVsbH0MFl+MIXUlSfMmpAF3yOvM
         7Mxo9F+HtExW+4I3BccARPkQ5bWtszJ6FOBeG+xKMxNhtC+sSAIQDRVRWLG/J+toXqpJ
         JDuJ6/WARBnhdHMH2FcD4GT5wHDyWVmCLNnF08n6X8sGY4IOCy2dmCvd/jNb9BcKQpYl
         g8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772632658; x=1773237458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y1W/srayQRvqMo/yxxutNDTdINw68flwZKgc3vV8bRQ=;
        b=o/sX+pZFKagJo3szg6oR+N7RGIe6liQ+6FajXrLtcGTLj5S0QVmHep+2f+ro1pGpyF
         fAfWewGJuKdQM7Q284C78F8SnyIgV8haY+kjaSqhD7kSI+HQiwfGBcYIWApZg+8puw4N
         yfqTclecbRK+A+OwNjd7H0Hzs+WQle0ndKVFpFkUMFM9r5iYlyfSMYZvbWLPcyL/4FKC
         YI8J4pIb9ZljUqXHJsZCaAX589n5JdYcPPekA1gtC4L5S2Cb19B1o8GLBP5Wd1Y3JRbj
         SdUfJVz0Ae7nkg79zvzoTSJJnbCVV3P8+ZrRs5bb0cnBHhyQUaBK5gDb4byswND6Yhyx
         kV3w==
X-Forwarded-Encrypted: i=1; AJvYcCWrSTCuqJFbw1nIzCXYQ+MnuIDpgnC51skB6QNja03AmISs4NCfma7AZr67JVhJScjUGJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzqRL0EVPgIvIefbzbD5enO5/x3hfSwJo+LuE75BCivDsjbowq
	GXMPiutJBYBqpb431jbOUHvUZ0hU5oFrbG8Z4mlxG3CFeOTuP7gnQMp3ximjPLGi1TPMf4E0uW3
	rJSc7fSCpmYA4LN7N9riaASWXYQb12s/8Fdk/3NaYVn1yf3+B870ZDq+11IORlARGmsdsmWO31Y
	nvlPESTNKzQjkev01Js276icPv+aed
X-Gm-Gg: ATEYQzxB1EbycZ0i96gbEtttnjSK2C2KU/6pm0u3xdc9c/pnS6k1O636m6wBHstyvle
	ap5ikg04mqlybpOyZrsAdZuR0A++tND9DqotR/AMWZq8p6aOg/+agohH6DGbq46JsHIvTCNuolE
	tB2ZpUvHAlXhN8MPr58oTzGzD8Q1ujQl5/WTEdoo8JGdTDN7ZrStA7x3BQO/fdVfsy9wALTKOSV
	HWTNw==
X-Received: by 2002:a17:906:fe07:b0:b93:edc0:e2e8 with SMTP id a640c23a62f3a-b93f159439fmr145723366b.48.1772632658219;
        Wed, 04 Mar 2026 05:57:38 -0800 (PST)
X-Received: by 2002:a17:906:fe07:b0:b93:edc0:e2e8 with SMTP id
 a640c23a62f3a-b93f159439fmr145721766b.48.1772632657806; Wed, 04 Mar 2026
 05:57:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115163650.118910-1-wander@redhat.com> <20260115163650.118910-13-wander@redhat.com>
In-Reply-To: <20260115163650.118910-13-wander@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 4 Mar 2026 14:57:26 +0100
X-Gm-Features: AaiRm51TaSP-CtGOs_BAIrz9wnpPv_k_RqmwkVJkfgloDvwaLNludi8u4LP6WhM
Message-ID: <CAP4=nvTZ-k0QGsr_oyGmsr+gy6vbjmKv6TDVnUzQw=Av8YkEUQ@mail.gmail.com>
Subject: Re: [PATCH v3 12/18] rtla: Enforce exact match for time unit suffixes
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Daniel Wagner <dwagner@suse.de>, Daniel Bristot de Oliveira <bristot@kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 15. 1. 2026 v 18:28 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
>
> The parse_ns_duration() function currently uses prefix matching for
> detecting time units. This approach is problematic as it silently
> accepts malformed strings such as "100nsx" or "100us_invalid" by
> ignoring the trailing characters, leading to potential configuration
> errors.
>
> Switch to using strcmp() for suffix comparison to enforce exact matches.
> This ensures that the parser strictly validates the time unit and
> rejects any input containing invalid trailing characters, thereby
> improving the robustness of the configuration parsing.

This solution is incorrect. We need to be able to parse deadline
priority correctly, whose format includes two suffixes:

d:runtime[us|ms|s]:period[us|ms|s]
(see manpages)

and is parsed like this:

int parse_prio(char *arg, struct sched_attr *sched_param)
{
...
    switch (arg[0]) {
    case 'd':
    case 'D':
        /* d:runtime:period */
        if (strlen(arg) < 4)
            return -1;

        runtime =3D get_long_ns_after_colon(arg);
        if (runtime =3D=3D INVALID_VAL)
            return -1;

        period =3D get_long_ns_after_colon(&arg[2]);
        if (period =3D=3D INVALID_VAL)
            return -1;
...

Your commit breaks that:

$ rtla timerlat -P d:10ms:100ms
Invalid -P priority

Tomas

