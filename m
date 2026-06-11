Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAF04DBD96
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 20:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781211546; cv=none; b=dzwuh41JfRgLes102KOor7jrgWX7gYzNHtEnXNaSs3N/2f2blJzD5CcvQ+C5tDRJ/c6XRKziF5fb8xxblfRh7/2NxNdbi7AVCVEkjUDI9NkVbLCPTZV4i4S7tWLQEomTKho1ZKDyFMzo1anCLeG5dAZhClNC+Nfq5o296+gP+NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781211546; c=relaxed/simple;
	bh=XJ+ja/54XWFissrUkUu3n9x2odHK0qJ+G6SKeMvhhvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhqvZmnwuClbKBgT4t7VzMMc6A03DRU00hyxo7hbD1aObanwhxONxfDTFyvIBcOg03KS1eBw9TNM795GM754A+4g+DXGa2ZA0TRG9p2LpFTrOjunh8yVqdlKPDb8APE94R96WrC3MWx59N75awnrq+Ip0GOfTJuVGHjKeH5qFho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io; spf=pass smtp.mailfrom=multikernel.io; dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b=OWhyqt0a; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=multikernel.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b="OWhyqt0a"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-307d0405e07so482215eec.1
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 13:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20251104.gappssmtp.com; s=20251104; t=1781211543; x=1781816343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MUGEJTphEZFGdBsrL1Ap3pgZRMiQ/Bb3HajFXRKP6PA=;
        b=OWhyqt0apsb5ldefUQUx0QDXAeUCvu828Usuw4DYmK7mnUs1hf0w4Bp/OGBSxip9as
         25BF4piEcq7qlQvwAgcuID8W0ZwuO01+rORm94NkPF6NvdVOKPX9uJD3EoxhMpNCyuY6
         BiHXM7mulpSEwGvatodRJtVmNnEJqpGuwKDsep2XmhYwAvC/xGZ8cfkGxs8NeQtoEcE6
         vio/Ppk6wMh9y1odvbZoweuX8Ic/wALtDaV2IbzkCo/8Nwt3DhITXbvf8pPaPeP/w3sW
         xxf3YMsNkQCDTLOFAJLfpA7QKeH6AbQfA9T0APFzzK+8lwCRIkfFRfauaBElKIBQQGPb
         k3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781211543; x=1781816343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUGEJTphEZFGdBsrL1Ap3pgZRMiQ/Bb3HajFXRKP6PA=;
        b=Sp6HYOzN56gQoYy9XrIIBnXLStRoyAQFEGDFPIaocwNoGRXIBr23DUPcjTR6CaDtMe
         0u+9DQRAnhwvONLwRRIqji3C9sz1yRVK4N+tyY9soXuwFGpbttTnZYE+/1kpCzBBrocP
         Y5LV55u1N65WRPbHn3b3ioQTb6HYhkHc8Ljgam3+tadhK+3/ujXKpFKuZ1ZYn+WM4KP2
         oav7aW+FgPHCb2Fd/ve2O1jcq8P7aUulUl04GA5zFMDTwkDfW3LtyXUMGejR3iafgCNH
         dz4CgVbUGNXex2tBWWxFp93+iuelRBZXAZ4OywM6SKZr2mWDRZaqsCOlzNgsHEC6jwPJ
         jnvw==
X-Gm-Message-State: AOJu0YzXv8z8HbO2aO+YLFpq137xAUZFzt6JKsxqW4D7jdQ4VbhgEXi5
	ekUqg4q8QFWL/Q5y34CnMMjkKXZvu1AQF8wuc0U/zypLHn3N32Z4UQr8qd1PRnSXJpg=
X-Gm-Gg: Acq92OEOVIo2p1eubty5aJD5yUl7SAm0XfLnREqYJTGn8dMxEg8XMn8HhGZh/RJtQdI
	a4FW+CoeMosqMrYJ2ik6gNWwCxCdMN/Z/olNEL0w5gSqdfXOcn1ehbHTsKDg00BZg9KXy8d+VcZ
	tcyURSoFfQ93KDSUFLKsI+iBORTXGxx68dk0uuNkPLWh403t53K5EKlozvLzOzHeXcF8Q1G7YYu
	9WrK+SIAigYT3aXB0/SHdG9cOYWYwALNFTJRlE9kuM3pSmQg65tnXJKiFmcw8Igshgae5EFoQqR
	0IahY6zMu/SrK47Lo4oG/om/clTBAvE/mte8YIqZfynGwcqLorZnag939dJGDHgH8C8/I5CuaHB
	L+bUHW0og5Bd+xqxcoPjF4Y5edlmwJDsKK1rwvbx7MQVRB/0v8TLcmTZRQw6oMlIkEz9LcRCTEQ
	m64iX57Hzgtec4P27EMQvYCFgeNrTjorYGYSLgfSpEcAUBxg5SNwfnVQ==
X-Received: by 2002:a05:7300:2393:b0:304:b93a:511a with SMTP id 5a478bee46e88-30804b8d667mr3459122eec.28.1781211542621;
        Thu, 11 Jun 2026 13:59:02 -0700 (PDT)
Received: from localhost ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0828sm416981eec.10.2026.06.11.13.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:59:02 -0700 (PDT)
Date: Thu, 11 Jun 2026 13:59:00 -0700
From: Cong Wang <cwang@multikernel.io>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Shuah Khan <shuah@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Cong Wang <cong.wang@bytedance.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v2 0/7] bpf, skmsg: some fixes for skmsg
Message-ID: <aishlHQXerhy6Mio@pop-os.localdomain>
References: <20260611123538.156005-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611123538.156005-1-jiayuan.chen@linux.dev>

On Thu, Jun 11, 2026 at 08:34:08PM +0800, Jiayuan Chen wrote:

Please wait for 24 hours before re-posting, this time you only waited
for about 11 hours:

	Date: Thu, 11 Jun 2026 09:35:43 +0800

For your reference, this is the rule in
Documentation/process/maintainer-netdev.rst:

```
tl;dr
-----

 - designate your patch to a tree - ``[PATCH net]`` or ``[PATCH net-next]``
 - for fixes the ``Fixes:`` tag is required, regardless of the tree
 - don't post large series (> 15 patches), break them up
 - don't repost your patches within one 24h period
 - reverse xmas tree
```

Regards,
Cong
