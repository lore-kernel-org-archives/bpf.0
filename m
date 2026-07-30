Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCFF3B2FF8
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 08:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785399959; cv=none; b=DCgBNsKblMn+/4BjmaSAh05G/nQr0tvZd2vj+ZQ3W4TsJdt/qXQ/X0kXUl1lEFH1R6YPT6w8oUlNkyaQfmHyS8sv0hnk980oxER3HCDg2WMFcBFIG7Tnjq0kWr5vjZZCHC3l6YGOrMY9S0vAuIs5Jr9BAKvRG8/eeywtpgNY8Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785399959; c=relaxed/simple;
	bh=C4Dp81+yrf8RNuNIOEBP8kLYNnF4h2mYnD9L4fn2tnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVjq4zltG9gu/Fw4qh2AvyjnYRThALC+do6ZwBs6UTY89AKdGmJDGg4OaLd0Uvf5VN+R+Yu7lZAppx+xu/kCLWzzc9L48DKT8AF0VVuJNbdjLEb8vB4eHD8/8tPaD0c36PqXvZ93gkmXP1nF0DUN4eoHXR+NAOP9nS4u8LtYCxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YyGmLfRl; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YyGmLfRl"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4954aff6088so17002025e9.3
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 01:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785399956; x=1786004756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+khihSFp8xIqvD5iaqe5AnFSih+L44scJGPk6G96Z6g=;
        b=YyGmLfRlW4B2nNd4BLXk49a7u1JpGiHkopgEEOcL9UUwm4YzJNkbcDyU6jfr2iLFy7
         o2kwSU5yTioK4mV9hDxv4Qa+or6nbBgd2E0I3jTQqt4SgdZ5BPfaqjvKkR0tbKPTFvfx
         XvU9ssaMb5r+y04cD7eL3LyC5l0GOh1gZU7F8/QrdZm8MEii/2lnTbL6PNFvYKQcm1b2
         JCDnocvX+4z1vCzbGHFcEpy3uXlQ9HUgIOk7Z9ZhIRYNt2MOkHPn5Shmg2UOZmB3PvTI
         1/qH3Ua57tBr4cQ6H7k1f24BsZOYnRqODrgWNHPZ0eptcnSHvV1qcTOw87XY2cz9K/bD
         3YNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785399956; x=1786004756;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+khihSFp8xIqvD5iaqe5AnFSih+L44scJGPk6G96Z6g=;
        b=TPjfod+LhMoCzWUR2uL39aUXsIq/aB6L22gtVbtRVEH4o4vYjMp0lmUf7vfvE3dkHQ
         evXfIeDGgzwWp/xAfG/XFxohWvcwP3QgZq8wwz8hOqo1jTGZHrBImLs7U0mJRJM+6S+D
         ErXmIzyp5Jt2YQDnFe21lW1taxVbliJ+L9+bZeo+vvuD5Vjbw3/hdScOFBddp/VBHCxp
         kAsk/YtQX62poxZqg9mJKllLtYhBDmKd22TR0Z+UZhye7VdzdHgoN5UUiV4gdD80Pw6e
         YmNeGhDD8YEOTOnQlBVNs1GvPzwsY5pl3o4rY/0lrFm9QnQjz04eSv4WRUYAqMYiU9KL
         kOoQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqow6wwaCp0/3mhDN26vfAzlB9pw6Lf7OdjcAdABW8ARKjhpew47+TCaRHV8AYXAjo7PzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjZtBt/4YZ5azwwgUUq9UEDbQWoHtb9dwKF92iU+yZWKoaJtg0
	I+ojaU38MTRVb7JYnZ56ckTfmIP4S+eTVUi/AnFlmys6MX/rt0Af1Pr6Tqjpe8QcZEI=
X-Gm-Gg: AR+sD11SEnBs+DPn9UR7kZ/DL7Gde8wrdoe3Ri44STnvTroZUUC8mib0D+nIGq8rigp
	StLSCmRknWBgunh5OM71qghfk6A0rTJJ8jIvxpOBqUR/+wd6MtjFDXmGSICJjJrIrR85KLjMxS2
	19m4M3IQKw8YVg69aAz+axTOmmpDauZ8dLGvGj0zUyX+QFAgjgb10CFjGL9gjDGzoZt4RZQ8Aqu
	tvFavxMTwOrc7Y9SR2TwyTs4byRVHrKmUdxXw1D3ThERfzZqM8P5zo8Ux32Vfuni+7K03/DN8+L
	c+RKJ7nuowIUKD4+opDW4G1aPOIJKzMu1a+IWVP1BydPZOBGlDkn7tLZ4S5vYkRjoF4rh26z8FM
	vDNhqXoaAYQVBPIxlGlZW2HwwgS+H5Ue4DhELq3DFfSwK25EUxGAc6+NDH2nZqA/EuHoqEAIEqK
	jfvWh4m19hZ7bBUsOvIaOemddnqj7hMgW6UPDT9k4B2dmAFiKHoPgk4bDUKe1IWsbqeo60wHwrN
	TwwgD5KeM0jXBs=
X-Received: by 2002:a05:600c:500d:b0:495:4e17:cad5 with SMTP id 5b1f17b1804b1-49800eac18amr18818185e9.26.1785399955724;
        Thu, 30 Jul 2026 01:25:55 -0700 (PDT)
Received: from u94a (61-227-70-26.dynamic-ip.hinet.net. [61.227.70.26])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504927a7bsm20164432eec.0.2026.07.30.01.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 01:25:54 -0700 (PDT)
Date: Thu, 30 Jul 2026 16:25:47 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: chenyy23@mails.tsinghua.edu.cn
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Daniel Wade <danjwade95@gmail.com>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf v4 2/4] bpf: Preserve pointer state for commuted
 arithmetic
Message-ID: <amsJ3D8P46GcsKwp@u94a>
References: <20260729-c3-035-public-bpf-v4-v4-0-8ee297e2346b@mails.tsinghua.edu.cn>
 <20260729-c3-035-public-bpf-v4-v4-2-8ee297e2346b@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729-c3-035-public-bpf-v4-v4-2-8ee297e2346b@mails.tsinghua.edu.cn>

On Wed, Jul 29, 2026 at 03:18:28PM +0000, Yiyang Chen via B4 Relay wrote:
> From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
> 
> When scalar += pointer is handled in adjust_ptr_min_max_vals(), the
> destination register inherits the pointer state from the source pointer.
> Copying only selected fields is fragile because pointer provenance is
> tracked by several bpf_reg_state fields.
> 
> Use the caller's temporary offset register to preserve the scalar operand
> while replacing the destination with the full pointer state. This preserves
> the frame number for PTR_TO_STACK registers and keeps parent identity
> fields consistent.
> 
> Fixes: f4d7e40a5b71 ("bpf: introduce function calls (verification)")
> Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
> Tested-by: Daniel Wade <danjwade95@gmail.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
