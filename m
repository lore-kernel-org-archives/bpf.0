Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119573;
	b=uGq/MTsM0w2rhaSzsmBCfV3I9877DLBGutKDr4AgujVeulUgKrOAfhy9pnar5zGrnRed
	 7n+G5wc1Bf1SvFTIHL7Bleqh9YK1lj1VculQal4Z0Ji2SIg9YyNxobf44gpm0ulZ8oqAm
	 vcfmA8v5YmL6eQauwVOicJ9ql3gltBPH3QZfPNuRLWrFCLhAMrQ3mg4sl3Z2mgJum6hY5
	 Nq1d7FtdOwcJ2BTISvlgLpcW/uK2yeGWP5jfi/MPcpr2pgh329UazVAA005R2qYGVx4Fq
	 GxPkkrpCPPA0qt9uiBOjxP7T0pQZBaicnzspFrm8dHhRXwILZfzsfIRSPRzUlUOiHkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119573;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=ULD6mg2UF3aqGiRVnTtgMfjAq+CS0Bj3WcB7vl1Q6SE=;
	b=hrHTVcy5m5bzvKgsiyIRVZlV8zSxqT3ZpgrDVv77aySZjPmY11XPNt1Z0VOQ1tCOhhsk
	 qGzuUyR21AImB/+JgjaWXloHexDRmNJ0CiF24cdY9ErQrSVyl+2zMTZ1MU6KKB3dznkyK
	 BrxZ1saNgD7Z3v1ZNMkkrh+j8v6/b8szgCAh0F3b2DUu9X2yFVjeNLPq9PPPTZh53XStN
	 QGbtFk3NkEXfcKBEzWdXOSO6T+i/YZKJizAiP8UrQVD6rNG9ABKXrnEb4MIDvBYsHTMk9
	 0NPHEg6YQ9brH118JAqPjFO3zSU7B8FURvVQqGXU9pdsxfMEPfai3gXyzV9fhTcv+IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d6c5qIvw;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BC8606A322
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 16:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9BC8606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d6c5qIvw
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ab41538192so91072a91.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 09:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793119572; x=1793724372; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ULD6mg2UF3aqGiRVnTtgMfjAq+CS0Bj3WcB7vl1Q6SE=;
        b=d6c5qIvwE3V/cG0JsfhmIWnhvHTGilA3d6rRGHpFtN2pDCjgYwTtiF6MKaIQEa86tr
         nlAW0FgkGspl4soDpJ1hdbeLXGpx2T+VHmKZgqr7ehw+5rifVKJVaTDzRwDk2tW8zU55
         /5ZjyFjP39zS6iVMQ066uQFFdViUSG3Atmp7eC/wlaCgODLvZ8eVhWTruqEVEQkEbcT6
         jNAJc1nNY8c9uNfaSWXKEoN8ADQ3dGReijp18oPUc9W1gDySmMXRLg/CsDpA/G0YkkbA
         GS5NBxSc9KFxAV1CilPPCWWgGzJ00QhIm5vm7EKEAmyz9lu5NQv9Z8vvPz4OKx6jKPqJ
         lGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119572; x=1793724372;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ULD6mg2UF3aqGiRVnTtgMfjAq+CS0Bj3WcB7vl1Q6SE=;
        b=PQ7Y1e5dAC5DRNzzOBOez+EiuMwPknT+2HS8pvDPT4FAO2wNs3Dvyjuh8UpGX3LNsF
         Dt/879qFlmowHeNXsWpwzHRPHimqKj5KiSQNgqAfJ/SrDLd1jIeeFnRLD5i+FEEMWuhh
         YqfZqL16CURux42bj3xoYQ8yosAdP3ftk+nGU3nbmYUuFJv7YCAavNKJSouvc4OPUTFD
         lg6k60UupK1lqXGDF6fXD4I4AFiljX0lyHlUQapiV2LBVkQzkgg/7uFtjb/h19lfCdIi
         nqj90k9Zvs/demBYRzBAMaylkX4fV4O9KgbEPfG7tjHTFl41Qu13PLdGhNyBS4XFc/cS
         4HgQ==
X-Forwarded-Encrypted: i=1; AKwUvBzHsLikis+ykg/mhaCDCxIFyh7Mh3gfiXciszvwNd+UnGH/QBCvtGtYXX2m4XRBQsF0bSU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKsaHK1/1jri43NhFtNeSNwb0eTIsbhpPUPbUdRijergPzOwGdO
	BsiOyStr3RwNTCyDNST31JFbBRr8qlktIGp9N0YAGusYRBGgga9JT4ID
X-Gm-Gg: AYBFou2fkJBYH0+ikKWf6SdJv6oy4LpvwT8t+UanboM3QBcyy+HmCUcudrmsiUyqHwv
	l+Rg6UypGbzKvzqf+UjFk3BnpLPS8R43AWoUAjUlLg73uwUwPcUaWzrzdoC/RrEHb0o5k5uuzb/
	bYx5PNIz/GacwEkXu2rxsHDjiXm64cFowsORdYmyx7saW8Y6naoySQ9hfgYQ82dFAVFp7ZjvrUc
	ysF0NSMe2WtRiN+n9/4lrgkd8iTpE24eotNkt0D2CMiaf9EGoDU+MtdmqQvO+C0meb5eo5awKww
	dBVdyLH1xmUMu48RPcZ7UArPd2Na2E1VOZnV09yAxoDMKO1BGWZV96hkJJxoUUj/S3JsGDJpRce
	dqX3Ssefyf0EDicEnHMN8mlv6hTfUXanKtk2I6xdau7K55qTDAZUpCdX4YGz7DBYq3qvVKocPzw
	LHedskEt/W2dlrmU3TmJTGjG94LnYHpxWc8zqtNc9Lk3hGkdHhyULnpRXQfrUIF1drsaN4iXISg
	4plQJOHZ3hBZB+mtfGeCQRrKbKgSOgtcG5CDElUPSQEwYnNMJBT5w9qYXbnhXBEoaA6UMgLhbV+
	891I84dOZVWNVLMGoxSIkn8/SS2fFFpa3BHxwYv79LIXC6dgabnDDQWwKWcY
X-Received: by 2002:a17:90b:3e4d:b0:3ac:403d:6232 with SMTP id 98e67ed59e1d1-3adeb120167mr9427553a91.55.1793119572168;
        Tue, 27 Oct 2026 09:46:12 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae404274b2sm4410849a91.5.2026.10.27.09.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 09:46:11 -0700 (PDT)
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
Date: Tue, 27 Oct 2026 16:46:11 +0000
Message-Id: <DMFRU74YCDSH.1WJJT7VL3MEYE@gmail.com>
Cc: "John Fastabend" <john.fastabend@gmail.com>, "Jiayuan Chen"
 <jiayuan.chen@linux.dev>, "Network Development" <netdev@vger.kernel.org>,
 "bpf" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v2] bpf, sockmap: annotate the psock teardown data
 races
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jakub Sitnicki" <jakub@cloudflare.com>, "phx" <phx0fer@gmail.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20261021155629.68813-1-phx0fer@gmail.com>
 <20261022054811.35008-1-phx0fer@gmail.com>
 <DMBHB0TQOV1L.38MECMYFGUS5B@gmail.com> <871p9g6ym1.fsf@cloudflare.com>
 <CAADnVQLTe611mm0iJEf5gJi2GtW42kxNHH3sUPevD039FvzL7g@mail.gmail.com>
 <87v76o63qv.fsf@cloudflare.com>
 <CAKvCo-zf6=ABrMEn_8r7rJFFvaaXQrz8GAUQ9Uz4h0Ze9gY68w@mail.gmail.com>
 <87pkwv5cj8.fsf@cloudflare.com>
In-Reply-To: <87pkwv5cj8.fsf@cloudflare.com>

On Tue Oct 27, 2026 at 4:33 PM UTC, Jakub Sitnicki wrote:
> On Tue, Oct 27, 2026 at 01:10 PM +08, phx wrote:
>> Sorry for the long silence =E2=80=94 my laptop died right after v2 and t=
ook the
>> local mail and the working tree with it. Agreed that the ordering fix is
>> the right one; please go ahead with the commandeer, Jakub.
>>
>> I do still have the reproducer (a KCSAN selftest for this race, verified
>> in QEMU). Say the word and I will post it, or send it to you to fold int=
o
>> your respin.
>
> Feel free to iterate on the patch once you get your dev env restored.

I very much prefer if you Jakub will take it over.
'phx' is a clueless bot that sends spam across all subsystem.

