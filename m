Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88390438488
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 11:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790249121; cv=none; b=VYO9C6YR/16DKUa2Eo83scVEw7W+MfDu7r314kPTzIOjgYn8dqZYuxgGkbykfRHNRk7cZyhcCrymLzanHdaiT8BOAFPNDmfbmW+chHbfOhXUd/aSVIQIbKy1A7wuG4leyA+UagYtt4Dk8DYI+vZsdAbT4OHC6TISv6SJU6fDVrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790249121; c=relaxed/simple;
	bh=s4zEvtiau4GorLBY4zClj5gQ6h6CC0gUWGuyhG3J3Ec=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=A7Zl+pm8YVTSq81RzRDLCnxW1xg2M/ELCJGQpVsleOVE9tndu/B938Q5SWY5gACm0rnVcPBK30lBAB/wEAyclysdfRMtfofi6YtDMXSxdGVfNtzItijCoB4hXhl+zdsZnVOyphxv9S1dOc2gtVGjX100xtl4PUffxrV02+Ejybk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XL8zW9L+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eDU2gHmR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XL8zW9L+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDU2gHmR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790249119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s4zEvtiau4GorLBY4zClj5gQ6h6CC0gUWGuyhG3J3Ec=;
	b=XL8zW9L+uIKMySj5q0u23kdR2442mOCrUQFPYRpI5l6Zi/lb6q4RqqnPiQiNXUMRMMFYjd
	xzzmsq+nL3f/4j1RdsXbY3S63u0KhLsTCPk3xLp8P3928muaaFKsBAtAsXys+DWEOCLp0u
	GoqW7uL8/lIGMKozLU6VGVKTYEsfic0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-rKqMgP18Nqy7YdcHgL4zGA-1; Thu, 24 Sep 2026 07:25:18 -0400
X-MC-Unique: rKqMgP18Nqy7YdcHgL4zGA-1
X-Mimecast-MFC-AGG-ID: rKqMgP18Nqy7YdcHgL4zGA_1790249117
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49e65f2f1baso18605845e9.3
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 04:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790249117; x=1790853917; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s4zEvtiau4GorLBY4zClj5gQ6h6CC0gUWGuyhG3J3Ec=;
        b=eDU2gHmRFI+JR2kzQ7NM3f0T3x35ypYqSTB4Ll+Vttl30vIKpIKmzdQ4wBqEKp9SRG
         d/4r5u3+oA4miQtNSmWhip/eBjk/JoA+48OR4i5HLROMASXYhBkcXfxKVKgTQcNHIDET
         2dXqRhbELCOBtE2Bf4JCLReFNdl0ZXPiICoVc4bjlt78NiNIkX1egWkBr2cQx95n6RkZ
         5JNLixPYoV4p5ZCvDoywtxX1zdni7rf3o9GXqaJyzWbHYdA5Ijq9K+AIL3SJTLcSpUWw
         QDKSez1eYVN3a0rXsRzt41WzX8KAODwVPMunBkipzlVqdS/GXPfo3LP8E7si0gRtZuOk
         baHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790249117; x=1790853917;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s4zEvtiau4GorLBY4zClj5gQ6h6CC0gUWGuyhG3J3Ec=;
        b=JZ4BzbBtUrm5EK8iL4YY84ZmcGLU6ICBQEEsPTJKuzZtzwr1s4VXmNLDKvPwqDTWpN
         vBJmmnxtbYjq25XcY0PY7fw7cT+ROHYbFc/dNlwzKmnjlmGAMa0c8Y03TngjYLeLbKK4
         1HSjb+JhLpSIam2tNqqtuK2amlXe8Vr/3kiQTCW6Khe4H3AKjwtoxCT5JkVfQnr6VC7r
         +dZU1cSqrt6tNyWSVSE4j014ECMYFHIRJcyEkVIG2QAyTI1nnkpuGU1gFJ1mkAV6CgNn
         emZSZCrpmCgIlc/J76H1Np33BItjVW5CyYfC1g/CSV/CqbIIsFnVB0vkd8pVA4uug53q
         HG6g==
X-Forwarded-Encrypted: i=1; AKwUvBzhUwjEHVKvzRuhaF8uxxswFPbv2b4w29k3mohAK9hj0AaMqzo8V3UGFPz21Z9VzkFgI2Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mzgC9MooOnms84uqm/gpUsMjNnPAqOB2hp+TsOxTlMgM8vU0ej
	tWXKKU7O+YLIw/TYk8zjFHYAvHfsLywc6x9yk9wP1MhKc+HBQ+kV0Cg44RMNwy/VEP18SdjUEy7
	DQ1yDllZXAsI8x3ZFYykttZ5gf/sYjTBUo++vIpKwdHw5sdW+92xyqA==
X-Gm-Gg: AYBFou2cafJJzyLXCeLYEMixTmjEPyyCI9Zjyf9Yaa9Z1Tk3nlZGZtXLody5r6cxo10
	nFS1Kb1rzDpHui7ErF7Rnre+/vt/KbcKwPNHmIjEfYRfvCdKiB+2mxkP5TecCc70QGfUehfHEHt
	BGHw4IJu/ye8BLEiFNvLQVwRmXK9xl1TmohZlulyBUkZa3Nb1AHzIvzaoUdylVayOJtIq2dAQIF
	g5fXIPXuiVSr1M9dzGMIfHYMYz8GSZT0cVc4pZCTx8aCXE7i0qVaEKMul59faTIpFANE2zV9AcL
	yzDvD0hYUGBjMPnWJEkFo+c26j6olaUnzuqexL+E8uvd5vIG7n/wJZ0Cj5nSMLW/kEjlYFH+gYk
	QILqu3qUzCwnJm2Z7+OR6ZfceOFoQ5Q8ZHmdq/d2tdZENQ+ovwuhOdiG6mDuoSSOhugSLmy2x1A
	==
X-Received: by 2002:a05:600c:3b8b:b0:49d:39:90ba with SMTP id 5b1f17b1804b1-49fe66c301dmr40127385e9.3.1790249117042;
        Thu, 24 Sep 2026 04:25:17 -0700 (PDT)
X-Received: by 2002:a05:600c:3b8b:b0:49d:39:90ba with SMTP id 5b1f17b1804b1-49fe66c301dmr40126835e9.3.1790249116588;
        Thu, 24 Sep 2026 04:25:16 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5b9c16dsm90528915e9.3.2026.09.24.04.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 04:25:15 -0700 (PDT)
Message-ID: <b5e4e86b-356b-4ec8-b6c9-e5ef6a3b2d50@redhat.com>
Date: Thu, 24 Sep 2026 13:25:14 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/8][pull request] Intel Wired LAN Driver Updates
 2026-09-18 (i40e)
From: Paolo Abeni <pabeni@redhat.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org
Cc: maciej.fijalkowski@intel.com, zhaochenguang@kylinos.cn,
 magnus.karlsson@intel.com, jacob.e.keller@intel.com,
 przemyslaw.kitszel@intel.com, jbrandeb@kernel.org, horms@kernel.org,
 kerneljasonxing@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 bpf@vger.kernel.org
References: <20260918212458.550425-1-anthony.l.nguyen@intel.com>
 <b67609c0-d640-47bc-b25d-d40bb59f237c@redhat.com>
Content-Language: en-US
In-Reply-To: <b67609c0-d640-47bc-b25d-d40bb59f237c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/24/26 13:23, Paolo Abeni wrote:
> On 9/18/26 23:24, Tony Nguyen wrote:
>> Maciej fixes various issues with VSI setup, cleanup, and rebuild paths.
>> Notably, keeping q_vector allocation synchronized with channel-count
>> changes to prevent threaded NAPI reconfiguration failures.
>>
>> Chenguang Zhao fixes AF_XDP multi-buffer handling by correctly copying
>> and attaching fragments and cleaning up on allocation failure.
>>
>> The following are changes since commit 46bc52d13594848023e681860df8700c8db14354:
>>    ipv4: fib: fix data-race and stale genid check around nh->nh_saddr
>> and are available in the git repository at:
>>    git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE
> It looks like clashiko has found a few serious regressions, worth a respin.
I almost forgot: please note that the current expectation is for you to
address the clashiko comments on the ML.

/P

