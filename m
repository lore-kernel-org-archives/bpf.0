Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEE53F5BF5
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033685; cv=none; b=XzvWdtytyGaCqBNgblpPRiFWSn35kWU+PFzCSETJPDbnI4s+ud/yhLH/1SWNLirXT86WwjY3VJjlq2j96b8it3QaM4aI69baXTegucWXp4mc9U6gtxK8OTKsYll7EsM7MewpjKSYU76n9SZiIvqKKFnpoXx/SQRWa4WzCsvH8/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033685; c=relaxed/simple;
	bh=QYuOBm2CqLdlM7TrFTz39mvN4Ht6QnmssFnzzfnloyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sdHgfjTMlkedD2fctIQucCiXqtDJ1c9/BArC8Cgj3ydc9B9Q7Z+9BH38VDu94m+X/aZm2AsKg0LMqGua8Vrr21KAhg+/UF+pFiEuKA+PhKT2dWF5x55kU9F2RHprHS1eN3ykRdtcWZ5vsbP9u44f/w/LVcNDzMzxWnGyxNGJbak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fEDYeGOR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=M8aFjA1B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fEDYeGOR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8aFjA1B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789033682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I6SGvSRdswv+E4pXtxp1ASKfEHGRGHA0m8GCzf8rxt4=;
	b=fEDYeGORJcyPmzosqo7dL+K+SYUQOycJCi2mGhKHaYZSU6GoSD9H+W+twrDnXeMAbj/lXH
	/pm32T3uG35jsUuf1dyqc4YftOqUx3cfNB9+yvHvDM4lQNR29dHUivI/YuOIpYZlw6Zx6T
	Qo1TY1OTyPSuAiEfI8UHWJF9z0DG9xw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-aLzPkw8aNu6ZDYowb6q2OA-1; Thu, 10 Sep 2026 05:48:01 -0400
X-MC-Unique: aLzPkw8aNu6ZDYowb6q2OA-1
X-Mimecast-MFC-AGG-ID: aLzPkw8aNu6ZDYowb6q2OA_1789033680
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-495569acf8dso40722095e9.1
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 02:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789033680; x=1789638480; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I6SGvSRdswv+E4pXtxp1ASKfEHGRGHA0m8GCzf8rxt4=;
        b=M8aFjA1B0TudiHPCHaOUepKwm7vECszlrZqExzCEWQMGguJ+HVYuxhnH1Y2ufaw+/u
         uCVRvSNl8JRsSh0J4bINs5RL5creeOtpgEaPyEXZtKDS5xlLVbc9yb/NrteihQ/XqeyN
         56vCnwHbSfs0ZJep5ZCMZWRZt06//6ex1ifz5JEZ7vkJv27DaRxS4M6ymziUpaY26LLs
         MVteymX3iVjDey7olfWCF9F62dsYzXFkxbjZzSwkxjKROf4l6VWts3yJ0QmTOZr+jUJn
         p0dcv2sG734hT2SodwDfns4aY33u0KzXMu8FEzV4/z7QFjeq3J8BOdyZHaD4IjqN+sZR
         0/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789033680; x=1789638480;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I6SGvSRdswv+E4pXtxp1ASKfEHGRGHA0m8GCzf8rxt4=;
        b=PVPBStrZfeOLmQA0bsfiL48bHaQfQLphqNME1IFPulOr3uF6W9QrFtPOu8J+UAeYC4
         dsxnmWT3DgYNZBKKKMqPeOgica49NDbsXenp8m6NBIChIu1jHX57ndPXwnypYY7yH2eF
         1tqyV3Bzss+0i0q6d3O8E9GJctJ5RMhkJ5ULEHLpSTDN6hMNGP5jwaxULep6uS3dKmOU
         GiIAsoUJ6f8a3LF4IGVk5l5I+z2cBQBRAQ69XtPGagAAZ7mwEuygQI9MJUxw7uqgWtTE
         dOLvHDC7iQ0YLCEBdSb4HBBfyGdEtb3nG7d5JrsEHGbvAqjjCqbkFbU3LmVZzArrahvs
         CLzQ==
X-Forwarded-Encrypted: i=1; AKwUvByAvim8EmUheeCZoRbPjW6LgbnH3sYYR63wSMF6ze/E2jp570dSH1trsKsm4Sws4/wVFWg=@vger.kernel.org
X-Gm-Message-State: AFuF++nI/5d1zuJDC2GZL5A8CV0nESigjK4grXBw227/Nr9YpEMtnI5k
	9+n/6hKpi9LfaXCuEzrETROL0cYq8dCqfYk8cxxg22Bn0x1fDiQF3TRQHJuR0tDN8k/H4oeaz/b
	uYjNvQHTKCWqIQcatp2L9FXzN1SZi2kuu04oUAcund3Cn+0sj/+mKpD7+4Zy1Wg==
X-Gm-Gg: AYBFou1g8KMLp5ojJg+PdTazxIPaVnIHqXbz27/6xogTcEgZqVH6G0Y1sHrodHYGFtq
	9V3oF4bj/MrVRiSVe0y/y+couZmIpLiL/hSPkrqc0zk66owxO2u5M8BTJ5/0KGGZw6cDCMNmc+8
	6CMFYqk9tJ7C7i4z3qt8OVVnw3TF7m8tGIrWNI5OhCOGV0wsZc29EIa5Es8O9XXJLYiK84z8NE3
	zoWKZiTSPriwm6nKfi54sbIBXxoVxQX02CtoM73GcisVKlMVEUjIz08ZxC+O2eahyG79XcsUYYp
	qAyR4jEfwAk+W338Zki1LDt+zJNw+1Q5Y5zTkKdok/iGTuTH6qXZ+pPxrbvagGY3x5qMlbj1b1M
	DfK0LXym3A77DQdnwSpWAxOF1ik2pUrgnSSpA4bs6qtebXNppE9fCqQcTyxd8F8YTwqiRIBtH5w
	==
X-Received: by 2002:a05:600c:b93:b0:499:8174:9f39 with SMTP id 5b1f17b1804b1-49d1f0af3d1mr167199175e9.0.1789033679813;
        Thu, 10 Sep 2026 02:47:59 -0700 (PDT)
X-Received: by 2002:a05:600c:b93:b0:499:8174:9f39 with SMTP id 5b1f17b1804b1-49d1f0af3d1mr167198445e9.0.1789033679428;
        Thu, 10 Sep 2026 02:47:59 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c2985dsm113481895e9.6.2026.09.10.02.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 02:47:58 -0700 (PDT)
Message-ID: <9a4f9408-bcf8-430f-adc8-f69c771f333b@redhat.com>
Date: Thu, 10 Sep 2026 11:47:57 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] selftests/bpf: Track test_xdp_features DUT
 processes
To: Bochao Cao <bochaolucky@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260904-xdp-dut-process-lifecycle-gmail-v3-1-5b7eee4f7009@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260904-xdp-dut-process-lifecycle-gmail-v3-1-5b7eee4f7009@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/26 6:44 AM, Bochao Cao wrote:
> test_xdp_features.sh waits for any xdp_features listener to appear and
> uses pidof during cleanup. A concurrent test can therefore make another
> test proceed before its own DUT is ready, and cleanup kills every
> xdp_features process on the host. The readiness loop also has no timeout,
> so a DUT that exits before listening leaves the test hung indefinitely.
> 
> Track one active DUT at a time, wait for ss to report that exact PID with
> a bounded retry loop, and reap it after each test. Consult the shell job
> table before signaling the DUT so a stale PID cannot target an unrelated
> process. On failure, terminate the shell job with SIGKILL and reap it so
> blocked I/O cannot hang cleanup. Install an EXIT trap and signal handlers
> so failure paths also remove network setup.
> 
> Fixes: 4dba3e7852b7 ("selftests/bpf: introduce XDP compliance test tool")
> Signed-off-by: Bochao Cao <bochaolucky@gmail.com>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Since the goal of targeting net-next is allowing shorted turn-over for
the conversion to driver/hw, I think it would be better to include the
latter change in the same series.

Also it would be possibly make sense to take care of the last sashiko
comment (about signal handling).

/P

