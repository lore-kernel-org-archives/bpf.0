Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E331C37204C
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 18:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780598704; cv=none; b=can5BNx3x9/DUAYI0C/yUgQm/w4yvDuYJ0X/QuIXsigLFnKtnS9aL/EyD1vut+lV3wOvaMlAclFf3UzZEaGE1LWLZlVOPXhj3xBJrudyziu/U56E+imyK02BMh+mGcl/NLFyn39vopE3fOEAPliEfVyXn902+DdSeOLH+aWjaKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780598704; c=relaxed/simple;
	bh=gDTjLkmb5w62N7AWqsRF/gUbSPcl9BQmkXqZRv4kvg8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=beITapyj71YlUV9OaemKRVenXAgsQ9cWCtEx2964HigMtja++RsiECKVFG11bW6Zl1A68PSx6s5OIvxl4NzImJS4Oe2M2/yM758bq26FSXmHcc4m+9XAAflTLJxO5aFqxAuL7+r5gmEky6L6rACxd1WjPigbOYFgOO0RpTClZeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyRVk/p+; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyRVk/p+"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8421f0e9c5bso511659b3a.3
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 11:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780598703; x=1781203503; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gDTjLkmb5w62N7AWqsRF/gUbSPcl9BQmkXqZRv4kvg8=;
        b=ZyRVk/p+ASo1GgExt/3M6ljWjv/ne4/nZfCKX/L5vUbiqmmNGyg2QhQAsFv0d2iNhP
         ig6zp7UAWdTvoW8BEEBIUFjsHMnmDO5ZtSad+S76igpMa1f7sAlHTAXVpBPjJkdRAHtO
         dhAOyfre35Hqw/fW9yAHkM3I7pFvJWyiRWh5XbBHkOcekuYB8D7DM7/TsTrbtHOu295n
         8YIrOGUeNfKkZuNXxZQKvjEWpu65VgXPzOW0I1rgKfRYvFd0+kIz3TuzWw5xLgPMKwOL
         1hXy3XakcIDe94mLsmO437JbqOaZQ3DSSv3vhIPvNfBHj7a0Sad7mIKx5PNx46ory+24
         /aGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780598703; x=1781203503;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gDTjLkmb5w62N7AWqsRF/gUbSPcl9BQmkXqZRv4kvg8=;
        b=J0ZYPzvxddeVPIo32+fPpTCMnArlvxmNRUAxUz1XLhMhPP8KT2Jd+4XNKDD+ppPXTW
         GM2Zna7z8wbw7pDQ3UeTA7QEsvUztXucbgIWJVN3FaFlXi7mD8+YhuMvjS/UCtBy874/
         sxn8ekRNVdoPYWUlovyo2SpZUEpOgxN6GpvVBZPRwK8LcA052U8UMUXGJP7Xx+7FGzW/
         R8Wot2349nscGAGwa8Q+twqJyS11J8npqjQoTpEbyURolm1h8A+Ly4ZuJOhtdrTXr+Cp
         EM7SMYOhDZx38ZVawZpUf0CV23RgOJ/+DkBkuFNtgz7WlRYK+70XIK1Y2wQ/VO87RatR
         k5Uw==
X-Forwarded-Encrypted: i=1; AFNElJ8bUaEBpqr4ICDbxmcEdrWRMRSUqQ85Tz2aOSODvUQa1Qf0iVAoCKgVRo0FBftWAvr4P5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYUYkamfBj/VV6xIC0BVYUl/6ZHt1gUNDaGKr9Fi81F99lygN5
	rzQykMkbBZzMZp2r9+n+LpDhRdNFA9jtwF3a3jIc96DBYzDFpPr84JeZ
X-Gm-Gg: Acq92OE8NtTZ5kD1rJncJHqQQXBPyPjzPYLt+fTRYUzUdnho9lXYzIAxsGsiLDimEl9
	XyzBxymrfnEBPpZgbReDZr76kciUBIhA3v2Yos53yJRMA1IpkRMY15r1LHdN3Z1gcUOA1lubpS3
	VpbodrP6rchG2BOwFAdVOozyJJJU1ACsADoinR1N50QtGb7pD5pQgLLk3A3R78BkgHpy0aGdOh2
	P5hA4agn4eTQrKoElYrWBd4bobGg5FpVNSPc77MXAEHXdqmkFtbQuesgs7yH02kxO0AdNsmz0c/
	ac5IOulkCISoEOMM9BPMkSvTnPw9ovQm8/hkKrNgS/RGxm/nKBX7HoHEjKl6S8JiDeNHNZGOrqE
	RRIa6hfwb7l1O5CELfywvC2EQzr3nWZwKKiFZWAIX1o4FmUrTelhbDKfnRV+sMtBdBpaXZpyqQf
	sFvEQhxXLtnrfdMPskrA/ikp9BwM1WLRGbF6SkLIidXyLgTJ+mc5L3WDiRrwSW9lc=
X-Received: by 2002:a05:6a00:10c6:b0:842:732c:5687 with SMTP id d2e1a72fcca58-84284eb0067mr8706446b3a.22.1780598703122;
        Thu, 04 Jun 2026 11:45:03 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828fe634sm6947953b3a.52.2026.06.04.11.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 11:45:02 -0700 (PDT)
Message-ID: <0ff70da688806c3ef7e1377962f9374c1a5b06b2.camel@gmail.com>
Subject: Re: [PATCH bpf-next] MAINTAINERS: BPF: Add self as reviewer and run
 parse_maintainers.pl
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, memxor@gmail.com, daniel@iogearbox.net
Date: Thu, 04 Jun 2026 11:44:59 -0700
In-Reply-To: <20260604184252.9917-1-emil@etsalapatis.com>
References: <20260604184252.9917-1-emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-06-04 at 14:42 -0400, Emil Tsalapatis wrote:
> Add myself as a reviewer for the BPF subsystem. While at it, run
> ./scripts/parse_maintainers.pl --order and reorder the BPF-related
> entries in the file accordingly.
>=20
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
