Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA2440BCBB
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 12:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781006598; cv=none; b=CqmfqDhBg82phctzauvAf7Yf5/YCIZybcyDDKHN7/0nZSuS0tNfkJysflODLzkijfrFgoO2q4whOE/FiB1WevAmiaqqN+mACyZ/uAojoA6t+2uZtMwTo2COOZxNtTU8avtx56YNNz5BhGC9QG0eTtzGwrLz84ngf4seWtA2GXb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781006598; c=relaxed/simple;
	bh=KYOKqzvxVdLkyqmcf60b2kuYcjBVPIadLaEpXbLdVdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BPus8NSI0tDcxDSe64hTRoUT3CDjeSfLp1mlJRJgR3i3UEwIzTx2TXheU1Cy3GDBAkYbVnnSVsPEJR5DsMSslDRbgD+MbYYIhncGZCrZDZ0m5KxUcC5yPE8k7tHRDdhkdQxzY2xGwiz2UZZju2B6yi+DqdXCAKk9WdyqyiR+r+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jng5Ed6U; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tlfhyqQW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jng5Ed6U";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tlfhyqQW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781006596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u6DWBXCgC9aNmxDed7yrblpTHxFgCcNoc2g5n3N4dOo=;
	b=Jng5Ed6ULS+rGyCmf7w66BqhAr54fdSHrkqNRnO1j+R/dLgju8puWJ5YB08G076Ad4k9vK
	7sd7sghns/Ajy4ub3gYa75sDRCvbEFXVQSJesAseDGYw2msokVNQeNL5loN9jSvMdTZGKg
	WOz5IjeEGwmx+CJ+34gulhzCGGf32iM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-r2wf11D6PMqG1iWMubYVow-1; Tue, 09 Jun 2026 08:03:12 -0400
X-MC-Unique: r2wf11D6PMqG1iWMubYVow-1
X-Mimecast-MFC-AGG-ID: r2wf11D6PMqG1iWMubYVow_1781006591
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490c4f61a34so24069855e9.2
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 05:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781006591; x=1781611391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u6DWBXCgC9aNmxDed7yrblpTHxFgCcNoc2g5n3N4dOo=;
        b=tlfhyqQWgfBLsrnYXzEPzFm1+hWn6NRBk2wRtmGLmwrwHi2A5ud36FrGLjmdkmCc7t
         YLnMQtyKh1mSsZMuI1ENK6tf+itPvRW332Ln43HWTOvPntR2lsJLydAC0Od5kLsd02qs
         Caa1bm2oEF/w0JhvzxqTjblWktq1XktegFrGTeEzVYfp5pgHg6uY4OAVR4W+GadHpnUz
         laoVfV/XueNMKMbi4TEjKzW2XeCfbey55jil9RfHEzt1QREvb8EOLBLmYCW8v5s80BDc
         XRQg7qErpNAR67HvN36wMBMUFJgpfIWtLEBwuLCQj4WpWICBZ8MKdaNYOQHrKEvfFQgG
         EaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781006591; x=1781611391;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u6DWBXCgC9aNmxDed7yrblpTHxFgCcNoc2g5n3N4dOo=;
        b=Snowbo8Xib5PxzwEaO9C0kH0KvhrcY4b4aQqsxEBuwgjYEMWdzQCtJooRrsGZaa5Gd
         7EqGcVSJTwevO+lGNgTHGC2HPxYqTAr7F+zytx4nvm5fdA+j+y+ikU/ntvOSGUKK+DP9
         1oVKA00wY4FTutU8TaOICbespRVUxKK5B9NMMlvl+hhec6d2tCstxP4dOvO9ObQBXGnW
         4Enn8YTLzm4KkOoAM6d2VXrfCGQeXNbV57gwJ6fj8j/CUdxSfY4N1e7n+v0liqr/6Bgc
         ndx7szpvUbufpMajQG5E19PAc2g3/ZYjqWoi0JiTMxTdPlQF5APxHhuzysr/mp1HstdM
         f+5g==
X-Forwarded-Encrypted: i=1; AFNElJ8wUZKp8+MHPxHkiS/tR8MqV+Cn46Rp2UNO0iyldfzWVMzXah8TTFktRZ4maOKtn6dVG+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU8HXgoAypNXGKyTD1/IY4HsJPAH39aDsqYJXNWZAGmL5D+GM6
	Jg0mxCQyBtx/abJFo4OydpD2IA5T2Z0ceBpN26tSZX+MwPgAsOEsNUfh2zrMQT4RGrw0dJVHlR9
	EaVqR6JeIjNOUfRot8xXc8W2IOY1nCyphSM9bJhD/OX4pff+GUv+wfpYty1PEUQ==
X-Gm-Gg: Acq92OEjuLXfYaoG4Ti5xqR7clp48wuelYQTY/h1N0QEOQuQ8g7CGDtYFNIJMctfcJI
	L/VEXRyrZPt/xVqbwOC38McRLpQrzWEvCDVM9EeoGerL7m8aqnxvtHUA/05sPo7+i4mZPAeUd9n
	JfdPGrdaLCoiw+Uc3CDpmhE3G+bwCo/mcKh39fVjn6R3WqFE0xFtgCaTg3Yz0YpIJXHkW08L72I
	k03I4AJgbCguuvs9Uyyzj3jDTIhU8cAQ8t83qXUg/k1z6Md0BPcoX6VssS3sCGhZVGV6rzHFUGr
	Rnm3r8ofX8fdgyKjA9itXnBur4edCkS6MtXkHSzjsb1z5OeRDROM4eXn8rmQ6q2HUYwknuAhS4o
	gqvZAy4zmQqJKX5aGafMkQLV3j2t8qE94NEv6KHOMVTNa/znfWTuHpGXkyATMAl2wBQ==
X-Received: by 2002:a05:600c:45c6:b0:490:b9fe:e64d with SMTP id 5b1f17b1804b1-490c2612b7fmr333238165e9.23.1781006590840;
        Tue, 09 Jun 2026 05:03:10 -0700 (PDT)
X-Received: by 2002:a05:600c:45c6:b0:490:b9fe:e64d with SMTP id 5b1f17b1804b1-490c2612b7fmr333237345e9.23.1781006590316;
        Tue, 09 Jun 2026 05:03:10 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d5d2b4sm314279195e9.2.2026.06.09.05.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 05:03:09 -0700 (PDT)
Message-ID: <c04cc47a-c27f-4267-97c7-fafb80639f5e@redhat.com>
Date: Tue, 9 Jun 2026 14:03:07 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 2/2] selftests: net: add local ECMP rehash
 test
To: Neil Spring <ntspring@meta.com>, netdev@vger.kernel.org
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org, horms@kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 martin.lau@linux.dev, daniel@iogearbox.net
References: <20260604212246.265079-1-ntspring@meta.com>
 <20260604212246.265079-3-ntspring@meta.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260604212246.265079-3-ntspring@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/26 11:22 PM, Neil Spring wrote:
> +test_ecmp_midstream_rehash()
> +{
> +	RET=0
> +	local port=$((PORT + 1))
> +
> +	local fail_reason
> +	fail_reason=$(ecmp_midstream_rehash_attempt "$port")
Shellcheck complains for the above:

+	if [ $? -ne 0 ]; then
+             ^-- SC2181 (style): Check exit code directly with e.g. 'if
! mycmd;', not indirectly with $?.
+

Eiter disable the check or use:

	if fail_reason=$(ecmp_midstream_rehash_attempt "$port"); then

/P

