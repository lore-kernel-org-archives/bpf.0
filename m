Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D508450AC33
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790874305; cv=none; b=fKDfUX5VM2w6B84LCGt5F64Wn8xgS8XFkMpVgRRPqKvO+g/kR4FZDQVlPPv3IVZ9+L15NAAymZulFK70nbTBnTaERo9pWpJGP1FQuFxN9WYn//bFVk0ZoLeLsCSgpd6LMS3ULh0zAQiRVv6qS/rEquk6o/CubRxmnV9lqNdr8ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790874305; c=relaxed/simple;
	bh=YcQDuTEhiIHLPGehWyOnNgYb4N2LsAYjJvT2wrN5O+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apptmyGkv+YyS5ib4VaSPicnHJDrh2zyo++SiaEd9ws5ioghqFjVzu3et08QNRnuqARN3LS7X+oOSVWUYSsqwj3xA5SIpnFjP5m7dmpllhGsKXXG9gW8bsyqpUcKK1lCP2dDb8yh2LieSniIXlIDwEW6vqbJmah1dXA38abV4+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oK36QDXw; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oK36QDXw"
Received: by mail-pj2-f11.google.com with SMTP id d9443c01a7336-2df834eb96fso36390375ad.0
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2026 10:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790874299; x=1791479099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=stLdMF1HFFKlJP7EW7qqWefqncCa7xTHqwJgtpV2KKY=;
        b=oK36QDXwlyYFp3GbVh4y8K3gebagaXmINoLaZQ3FWKrfZ+gk4OFlMB7lqqqa7dAz3D
         yT7EVtHcIfWZtb0cMoz6eVm5u/Hs4mzIQboiprjSEMGflLbrFqwxqeTNMvHRKFVZBZLz
         L/+QcVf43Kcth4wZ5bL3Uk5pvKKt+CskaL8ObhU0xv3x0Nb7A0hk8cqgMnHff40hncaz
         Za+tlVKn53xZ02LcfuACUgq3urwZnWi0CeoQJ0UV3RQvrTwULja2laXKbwb8iX9EIgHS
         +9ROdi5/P/OXl+c7qcR+ujBgQVx6Lnxnfi+43o+CGho+6WPDADWbRqTmtTUb6JzrTWz2
         u4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790874299; x=1791479099;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=stLdMF1HFFKlJP7EW7qqWefqncCa7xTHqwJgtpV2KKY=;
        b=Wd/KJB+i+ShvnUTB0FEr8uB572Z517w0Mv50VU7OiMcxFYtWyGviJ+mamK4w1sgmGu
         GqlNi4lcKfL4Cm28ISCjdRoGpCcr8G6BpIzGxSeMLQ2TbVF2vTKrUj6NKZZP0Q3/NYzg
         cDAybgLAki84Yaw/EIm2Ib63Kp0sAmjsI7iZq8KHa1PJHA9DwGmvpOEf9yS5TDoru7jO
         j2aQYjZTcfRiESLtHYgU5/+CKOCXAGKHlsMstmfIb4+JWhk6K24RR1jBy81ygC4G+hYu
         RjSS4HOd6R0Sh3U2rzxnamezt9DmgzMfnRtBzW4GCFcrniBDpGqsprMv/03FwjF9B/83
         oKEw==
X-Forwarded-Encrypted: i=1; AKwUvBxZPzCfR2J3+ah5YQRRrkqUuRyNQA/j8hIT2YVDrSHlU0EwNFUBw3oIhrZU6PW2ODu2r2k=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJJduCpput5yV4j0Iv+7SyyaFXmmBLzxY/yI2FlUx/l9dlz04s
	wvTKxHKsL8un0uIifJtPOBao1BjhWcfjxzIx5VkOQ+ksMK5Q2Ap1lv7T
X-Gm-Gg: AYBFou3i4NAt5r6Ep6hQm4MLksa+oHed7MgQj8PgcrwJj2qiiv1Ncs1XzqfBeBv6AX8
	J41tpziV79WqRIQj79MV5elIdnhFQdt+fm+UXi6Z/cDxu/psK4q3XOfnZXEYI/tJw8Ug1F3wl0E
	ofdC9W6s3tMXgPpkr0YRldT25CvrcQ0JsoYjEchKnHcCVew58zV6bN7DfRsJ8qV3lHQKqg8A+ym
	u+UftAcPN6N8xkFR66+zE6MBv//ZPi7SYWzWbfoeJIkRoNNE87S+LKQqGAT8yHXsYSooVnIVIEn
	YMr/8B5ENb0wcODyRn7IJEmwZNkTCWYOCx8z6r2QU4Aq9PyLK/i/eCalMeBXMFAA1NjUBArH0N+
	PpHlOumEuCysKWrkTbdQSifPnfqmk5osz6kcrmQ6nmp2h4zphr0ssKL5vbqQKhDtVjbYWmehM6q
	1ZZQOQ7C90DUJE+sFuPCBHYg2e7zREkc2MB0TWGKURg7hcXw77jQq/hBCYQCvlmUXf0l6CHs9os
	w==
X-Received: by 2002:a17:902:da87:b0:2df:7fe1:72b8 with SMTP id d9443c01a7336-2e49b64e34bmr641665ad.16.1790874298566;
        Thu, 01 Oct 2026 10:04:58 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e300b06afasm13879785ad.49.2026.10.01.10.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 10:04:58 -0700 (PDT)
Date: Thu, 1 Oct 2026 10:04:53 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, ap420073@gmail.com, 
	bpf@vger.kernel.org
Subject: Re: [PATCH net] net: make dev_xdp_sb_prog_count() see programs
 attached through a link
Message-ID: <ar6SryEPDgA25zKA@devvm7509.cco0.facebook.com>
References: <20261001012559.297751-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261001012559.297751-1-kuba@kernel.org>

On 09/30, Jakub Kicinski wrote:
> ethtool refuses to enable tcp-data-split on a device running
> a single-buffer XDP program (which can't deal with the payload
> landing in a separate buffer). dev_xdp_sb_prog_count() only looks
> at xdp_state[].prog though, ignoring bpf_link integration.
> Get the prog pointer from dev_xdp_prog(), which will consult both.
> 
> bpf_xdp_link_update() needs a bit of a touch-up, too, since
> ethtool calls dev_xdp_sb_prog_count() with just the instance
> lock (for ops-locked devices) - we now have to make sure the
> link updates happen under that lock.
> 
> Spotted by AI while reviewing the XDP propagation series,
> verified and tested on netdevsim with a C test along these lines:
> 
>   link = bpf_program__attach_xdp(prog, ifindex);
>   system("ethtool -G eth0 tcp-data-split on")
> 
> Fixes: 197258f0ef68 ("net: ethtool: add hds_config member in ethtool_netdev_state")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
