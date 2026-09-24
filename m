Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2F646E01D
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790249009; cv=none; b=M8jbpuqceAN+z1VM361NfE6uF07MCMGMQtpR2/sbGk6/pmiTTayjDgL2hZTfXqN6GAGJjfW1koRXkvt5Fds5zL+pcroqUL6z8Bp1rDBKudaSIvR8mQ/Yy7PIGFxOOG2rtI9/Yiv6qaDccoPvnSF+qppJFqfkiBnCK7X5M4dfDas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790249009; c=relaxed/simple;
	bh=tZUd4B+l/yWunNQIY+ZJIho41qAzK/3+syJlrXZunwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jjwPF8pgC2kWmL6USfNWf9uZvCgpazCPEYqf7uwXMoGBdDly7LXUi9iAdlpQqWVBiYwsv5WmWdw765+h/T/0oLXsmhzwT/DaVlouWQrnrULTg5AfJ0aUmDnjEwfxpRYV4cVJ1c15wAsiN8Va1qvArpnH4EoGF4xUmodCOkl25WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ObnIzt6o; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QrUB5/lJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ObnIzt6o";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QrUB5/lJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790249006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+uE5rBvrti+pPPlj185x2L2aTe3IHJgFjAYd6EKuC0=;
	b=ObnIzt6oHganyNAMJaE46uqe1HzG9SiXPTvk+aGU4cE5XrQGIR/W9keTTY0/0VfFzXNFWT
	uaZ44Y8G1owTiIzsWXmB+fGMqzOfGqG5E/EgoGuRiR8au/6PCJsoJRxfxYa/R/KfGx6oGd
	1Vv78q0PegzR/SxDDsfnB9MPinplB14=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-Lw6KaXG2NrSHqKBintjILA-1; Thu, 24 Sep 2026 07:23:24 -0400
X-MC-Unique: Lw6KaXG2NrSHqKBintjILA-1
X-Mimecast-MFC-AGG-ID: Lw6KaXG2NrSHqKBintjILA_1790249003
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-487057d8a3eso204523f8f.2
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 04:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790249003; x=1790853803; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q+uE5rBvrti+pPPlj185x2L2aTe3IHJgFjAYd6EKuC0=;
        b=QrUB5/lJdzhqAqElYsCYl8E/DVBdYOgQPudGrV2EHr8gz830M1jxltfkj6VblBnEcG
         kvUT99gOR+ZifCA8vjFCrS9QruEmUPXjWo7iz4qJ2P8O4Nmdx9NFqTKijoTjRKDVfdpw
         77gEDBDo5qV3bPCptCMxSfzhVjd6t1uAO+kGsoDQnQMqn+666URx5VdWOmlU+deuCa94
         YdybIc9o7myK9jfzK9MfTds5grDVP8FiXETehLS2h9j5Njy4jPHX/VL/6HcChycGIHFS
         6ncPmEvaxjWZBlU+Q6BrSXV8nqwYO5jlAqfUfmERjpCwAilklCUpjXzouavuMHL7l9qm
         aqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790249003; x=1790853803;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q+uE5rBvrti+pPPlj185x2L2aTe3IHJgFjAYd6EKuC0=;
        b=aOIWjKleLeMMsJSrt8PPAmDoQQXk7nwqIbUVaT83vG7QM7stqS0DkzMQyzv8i9STpm
         zPrV416zD4gXRYyqfD7tk3EQspXnyUZxs7uIXIfvXumYbrHsdEoPASxIkLIi7Kqxbrzh
         EyzVOsnlWEqP7xgDfhygw+uTckk7WeHhiDeUb4FAbQoTtUfn5AVHnGWVgDcqI0x9ymW5
         PR9Vf2B9MnGyq1+Sc6HNT56RVOhQw/m/fXc4DwVqWaH4vAe5z16YBY5mwZ9wPe6DoGw9
         2XoSMCCX21aQvF/lzl1D/EVqVMPXT9sWZt/oD+9NPO1pp/jkukTV1UMklDFcuzymvYDU
         oj7w==
X-Forwarded-Encrypted: i=1; AKwUvBx35cSDfEo/fsbdfANw2J/BE5GepYkMl1hY8CkKCtq56GbUVGOcLZJZAyr47RwLlxPbMQI=@vger.kernel.org
X-Gm-Message-State: AFuF++mSPZNYP18ORhQELzkaoE3pX9F7HqnGU5VUYz3yzQkb/qKTv9br
	5jh1kOxgzKz8o4i0OLD+0gHAx1kQvSy10LfCSP5i4FlDEsBWWnFWLnwM2yTq+Xfz3QbmeIViV0U
	VF4VusquOspToRpp2y7EKrG/GBONTz7fXavB+IAYQu6a8D7rs4iZ2AA==
X-Gm-Gg: AYBFou0pyKHd7WFqmp3i0Z8pto2g0MKlz4S2saCILErbQubqvGRxDeaE8J7u53xcRhl
	gKsooBV44Q/en2+nVdzkHss6iVjSi3w7Ep/nrg+eSb+aBx1pOChBdk7m6nctDfErWUVENQsQYxM
	OKuRb+NUmzIDmcGZ2mN8xx6X8ksu/Bm0zyNnzdZykDQa7orJwAXpudv7zDM5mNQ3hKhdl1MVxIb
	kN5ZwWEhlXGRO42YB/Zo44t8cG9LCUPd46etQComRcupimXcorrDl9wS5SWH0+mIHH+L2T8vP1H
	XZKhs2v57tWHxjPi1om5vM7BBD9QVCBO4G8/7q8+3Yl6GgMAdyqCfyP2GMMq5MFnn1BWwGTrGaX
	gIgp5SY2rSwhg8Sou+A4i7UEi5L7e9Dn2aivw81dskyh63Iqjl/mdmdjMfiHphGdPUW4HKtEpIQ
	==
X-Received: by 2002:a05:6000:705:b0:487:bef:31cb with SMTP id ffacd0b85a97d-488716ca7e9mr3595372f8f.22.1790249003247;
        Thu, 24 Sep 2026 04:23:23 -0700 (PDT)
X-Received: by 2002:a05:6000:705:b0:487:bef:31cb with SMTP id ffacd0b85a97d-488716ca7e9mr3595325f8f.22.1790249002827;
        Thu, 24 Sep 2026 04:23:22 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886876c64dsm14440667f8f.21.2026.09.24.04.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 04:23:22 -0700 (PDT)
Message-ID: <b67609c0-d640-47bc-b25d-d40bb59f237c@redhat.com>
Date: Thu, 24 Sep 2026 13:23:20 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/8][pull request] Intel Wired LAN Driver Updates
 2026-09-18 (i40e)
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
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260918212458.550425-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/26 23:24, Tony Nguyen wrote:
> Maciej fixes various issues with VSI setup, cleanup, and rebuild paths.
> Notably, keeping q_vector allocation synchronized with channel-count
> changes to prevent threaded NAPI reconfiguration failures.
> 
> Chenguang Zhao fixes AF_XDP multi-buffer handling by correctly copying
> and attaching fragments and cleaning up on allocation failure.
> 
> The following are changes since commit 46bc52d13594848023e681860df8700c8db14354:
>    ipv4: fib: fix data-race and stale genid check around nh->nh_saddr
> and are available in the git repository at:
>    git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE
It looks like clashiko has found a few serious regressions, worth a respin.

/P

