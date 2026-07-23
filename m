Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08352F1FEC
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784802006; cv=none; b=K93PBuTOVif10FsQ2oGQh/LYlQ2XYF7RFM87+JWZNhJoxjerrrVrIqVEz880oLW1xEzEj9LqCUNxTUEKXfkhRNx9VNawF2dqFyDrQN6J45BnuYtsa++UHLOsrMYHGzJ5uRbWyqcB++DEN0NOmBtkPlnjeg0zaGKOB3BTN6jMCAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784802006; c=relaxed/simple;
	bh=zkE1CxynhhuX45SZ6JJT+YmMZiFe1viNbE9YBLAS9Uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NFjqZzJjy+RQ0QyimHbfQOf311LgScPqxmdWCDvVNeszsNVQTusuUa/T0n6z7sjCl8/YI4Lg528bwkNOiZSegv0bjxWs8NGYJ5bztMhWfxoOGPM0fzuBbc03YQMMdzsoS/g1pZOJrHYsbnOxiA3qBWi1mGMVA2d262S42o13XYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O3WJQhNC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nyv8cTFq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3WJQhNC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nyv8cTFq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784802001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c9dgMMoQ1YTrpRt1/B5y0R7DlFAMJKah05nee02sPkU=;
	b=O3WJQhNCGvRqAQP+rDL2UTHi+hD7rvAJkQ3RKHY31FXTGhl97QSBLmyuLVVoWOgGC+Dioz
	6Iozp3xDo/EJPFpbeS67rcGyvpv1lRYKpn2WDpPYUI8a63IvnEvScx/EcwBI1kUd2BnDS7
	Z6gbh4GVYEyWPgrzWcro+vM3UgN7R38=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-Z_o5xSh2M5m2Sm6A3Tkzyg-1; Thu, 23 Jul 2026 06:18:28 -0400
X-MC-Unique: Z_o5xSh2M5m2Sm6A3Tkzyg-1
X-Mimecast-MFC-AGG-ID: Z_o5xSh2M5m2Sm6A3Tkzyg_1784801907
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso4516025e9.2
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 03:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784801907; x=1785406707; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c9dgMMoQ1YTrpRt1/B5y0R7DlFAMJKah05nee02sPkU=;
        b=Nyv8cTFq6wSkw9CFQGc+//PSIWnzoPn5H/e48wHEr3Pee2m2t8sfuEdKXoNR1f2HOG
         OYUzltGeNuGWsGLWewvuSYuRcH5RAkOvCn7Q4Ea/g/H8/Ge0SB1O+I31RfgT4KaYb3qb
         7A6cFWMJTiPiFF1vQDKuJ6kI7rVfIAB/kvfrou+vhW5OjQy3O8U9rr4BDr2bKvJjSwKr
         E238Co3rmqPohu54YH4nnW2gzQR5lDY3ysz5wmPFTVQPjhYIYgRZbN8gPJaJe27WzTKC
         I3N/TiNtHxa4yVzvhpHCoobLTVxNFkv1v56C671Ki/IxWFQWnHspCBM0hh9zY/mX78gH
         ficA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784801907; x=1785406707;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c9dgMMoQ1YTrpRt1/B5y0R7DlFAMJKah05nee02sPkU=;
        b=EEfcbv0XId2IWLJpE25XP2MKLlkZjImE3AyxffXiJlFjhoLBjtRUYmtrcwkbsdZRlG
         kOTyYHhKhSUszeiUwGVDT6dxt1sRwTdKvICE++3qr6Ae4eEd6x56ETYPGgjhOALF/kA6
         2os7pOKlAMhoYUCqJoboC7a09GkSxc/2TvITxjMhVAv/5jiYbp1lyf/zH/dvoH6IZLky
         pG+axh6i+VjUZMvXXt9rId6fVpGaVTS3asmUAWoApZOpb4E+7/4qFfgqcPfZLlaH0W9R
         IGfTtXrrazc6tNvNrtElf3dt68OqUF+Fyr+o/+ijN2HNrziroFySnvVsdrFjkfaoLCP+
         UCVg==
X-Forwarded-Encrypted: i=1; AHgh+RrOTnv5asmPwNVPMlTbh0UQlTX/HmbZC0lzFCM62G/nKzkH2QxEWg+LBi8zjNmSgBqwK2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUjvb4Y4ngzAmTq5rOcUd2MBUCzYx1kjWwDQ5aYW1lHLajeeA2
	Mq7sjHWErkKaYsy8a0RNftAETbfWnSW7rwGknHCGkY0+YJhhDUqMTdTx30agOqrf7LzE1hiHqxU
	CsELSVQR48Dsc/BJE2kLzVmW39KGuTy6+JKDn2EL8nih1lrvXg2a51A==
X-Gm-Gg: AR+sD13l3cCupen8r1vzpYCItgWE1rQ3FJTJRBjyFLtIg9ttnbLcWuqnS/hMI0SeUoN
	SUUYihK8SxAP/gXmJ7azHIqK2JqybxCUPDRgKpq6tN9iu27EdqP3SEwWVhcJiyTdEBOwj5cGGtT
	JPByjN9ouWFXIkF7QjzPwD6LIEalKdMSxSye2IVJ6jNtVqYuidmPRC5xVGarBgLJorH+4nCz/xv
	nYzr0Jffvueqz2nRrzlAM3DvER/d85gzUS2J9FLqae85xIbXJZe3sJYTYIkTTFQMKmmSP6guhxM
	MdQyloSrPo9Qaf3wdtwGMzQKhr5xJ3bTvTZ323XHHzOHk3T82leCcCJd8Sn2fMHhPl4JpFV3Bid
	52/Lun1wo5skkiXIDqyzKltXSU8TwWcMvn2BhOzG3/EJQyczhl0+6/RK9WlrzALf750CnUBKhhe
	cmzA==
X-Received: by 2002:a05:600c:4ecd:b0:493:c77c:108a with SMTP id 5b1f17b1804b1-49573d218camr25163895e9.36.1784801907444;
        Thu, 23 Jul 2026 03:18:27 -0700 (PDT)
X-Received: by 2002:a05:600c:4ecd:b0:493:c77c:108a with SMTP id 5b1f17b1804b1-49573d218camr25163275e9.36.1784801906974;
        Thu, 23 Jul 2026 03:18:26 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a6354a3sm218761215e9.10.2026.07.23.03.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 03:18:26 -0700 (PDT)
Message-ID: <d2014044-d410-466a-ae66-2a173dbdba82@redhat.com>
Date: Thu, 23 Jul 2026 12:18:22 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 4/4] net: mana: recover port on attach
 failure in ethtool operations
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, leon@kernel.org, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com,
 ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
 shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, stephen@networkplumber.org,
 jacob.e.keller@intel.com, dipayanroy@microsoft.com, leitao@debian.org,
 kees@kernel.org, john.fastabend@gmail.com, hawk@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org, sdf@fomichev.me,
 yury.norov@gmail.com, pavan.chebbi@broadcom.com,
 schakrabarti@linux.microsoft.com, gargaditya@linux.microsoft.com
References: <20260711041415.3008868-1-dipayanroy@linux.microsoft.com>
 <20260711041415.3008868-5-dipayanroy@linux.microsoft.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260711041415.3008868-5-dipayanroy@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/26 6:10 AM, Dipayaan Roy wrote:
> When mana_attach() fails during ethtool ring size or channel count
> changes, the port is left in a broken state with no recovery
> mechanism, requiring manual intervention to bring the port back up.
> 
> On VM SKUs without a netvsc fallback interface, this results in
> complete loss of network connectivity to the VM.
> 
> Fix by scheduling queue_reset_work when mana_attach() fails. The
> preceding patch ensures mana_detach() always completes its full
> teardown (netif_device_detach + cleanup), so the reset handler's
> mana_detach() takes the "already detached" early return, preserving
> port_st_save for a successful mana_attach() recovery.
> 
> When mana_attach() fails, choose retry values that maximize recovery
> chances: if the operation was an increase, fall back to the previous
> working values; if it was a decrease but still above default, fall
> back to defaults; otherwise use the minimum supported values.
> 
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Tested-by: Aditya Garg <gargaditya@linux.microsoft.com>
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
sashiko gemini sees quite a bit of problem with the above approach:

https://sashiko.dev/#/patchset/20260711041415.3008868-1-dipayanroy%40linux.microsoft.com

Also, changing user-setting in case of fallback is quite a bad thing to
be avoided.

Skimming over the code, it looks like than pre-allocate all the
resources and to a replace instead of detach/attach() looks feasible. I
suggest investigating such path. I also think that this last patch (and
possibly 2/4) could/should be in separate series.

Finally and most relevant thing; AI review comments should be explicitly
acknowledged by either debating them or addressing them. In both cases a
reply on the ML is expected.

/P

