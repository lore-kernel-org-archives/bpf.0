Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71712E4257
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777988578; cv=none; b=ViuPi4jZkam2v0Z+kP/Q7mBO3Am6QFpBjBNtrLOR2SeqlfQG9aYu6eqU0f+i++P0MqFw6EJZ5/ZlRH1TF1Gd250cQA9FS6jlvYBE5GLkkKqXnGwzUEot1yfz7DSp0RBgn6VgO4icHRSPFkGAeV9dzkgZs6/11iXWDsZtLGB0iRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777988578; c=relaxed/simple;
	bh=KoGS6aWgQmyghW2+RcilZE/a4UalTY9FWST44iSCrmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cfApXyQE4p/PEf/n9VRwnTQ3yFf1TK2i2YZTE9/YZTJstu4YFS8/KPG/0fuqSFhDeYd83wfjitbM9/zhd2VnzK8enBrGOox2Sz1if6nkuG6ropGViR9TlQ4vufFNZ9KU71NEbGK57s9G+IdodWZwMs1lSE2lpmNNLdqFAfm8Vao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jLU+PSNs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XiYgCUaa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jLU+PSNs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XiYgCUaa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777988575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+U+GpGXOrL0cMnQRbFcA7ylLjvJDYXi4Fcpm7XE5qos=;
	b=jLU+PSNs/XPYvX/fzeZgU5j64/amEMenJjiW6Q5lxrEFAsZneh5iBALkwac4Mwutdu7TFx
	X3gn4K0zBXKs5zqle9f0TiXwVD/cjhaACIn+wGwsCmqH4UbwZDAPW0wKlHIqrFeafiylVr
	gQ6w3bg1PKOMPA+COhREgX42dd00QhM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-H0pOfHnSP1-Qmgny2grMmg-1; Tue, 05 May 2026 09:42:54 -0400
X-MC-Unique: H0pOfHnSP1-Qmgny2grMmg-1
X-Mimecast-MFC-AGG-ID: H0pOfHnSP1-Qmgny2grMmg_1777988573
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44f56d5523eso1238446f8f.1
        for <bpf@vger.kernel.org>; Tue, 05 May 2026 06:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777988573; x=1778593373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+U+GpGXOrL0cMnQRbFcA7ylLjvJDYXi4Fcpm7XE5qos=;
        b=XiYgCUaamZm6WTSI43K90aaOEBA5Nx5HVT+DagaNvt4YXFGrM8PC/hruoust7T0UOh
         /JjptZ6ZEWwSE/YaFAa1nL2d++YeXMdcGUapz/E9Nj6ERAP4LeEBEb/BwxZlhLRMjPnM
         RjSYKiQycZbwL/Sm4Aqbs7A8LZi+XRKYp4rKVh8Hqp0cWeiAbOyla7MiRj8r9A2U2ZEO
         gUf4q4fcD0EEwWP++lGtlMPSDvksWAM77zE6Pf5pmJyQLfX6AX9uoMLg1tBSDninDQNc
         JKr+HKgQaDzGm+rYUt3n73FIInQIqZbZMAcuckIrFPHYxUbV5SMqfPzbnf3YLzQcOCZd
         Ol+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777988573; x=1778593373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+U+GpGXOrL0cMnQRbFcA7ylLjvJDYXi4Fcpm7XE5qos=;
        b=ZhiHLKm2Ts0/sSCK932PHXOWe0x2mkvtbPRcJM0IcHXXO39sdqUaf8zB3GbtWD3LQu
         UAAn4PHsU94wFML5yoVNHaDmWa1/q71767ovtHHfJ1kMVPWblst6ofBauUqVyzt1/AHr
         ONB9ENXaRRVioJtgamfhsAqZw1tl6e9/QkOMOf5FsYEP3KjR7yNAUOXErbepnpxT/LOG
         i0QFVEIxDoCRxtKwa3ouwo9TbMIqyEs0npjtYgu/pZQ2pD9jHeyZIrV7NIuBe952X6Ut
         lSUagJSv5M1MbdaOoBYGJ68K3/0YuciS8MvGkNibvbU/gf2OYcUyI0e7FuxT6duoz6pb
         RZOQ==
X-Forwarded-Encrypted: i=1; AFNElJ+vZnWaVdg71vrsCMTkniXF3nGE+6ROu1KHHiTiDkk2+gYnmV4vcYwffAMcb3lyqVuF76M=@vger.kernel.org
X-Gm-Message-State: AOJu0YymtXpJglMPwhVHv47KMwdwssmZDOtUMA9cwEUYCo9GaAO3AxWW
	1QNOR3D1HM2rYcRfaGMM0tgxRuCAbStjhCRb7RhM8coLRM1NRmvqKT2KNHeh+3UKCz4R+o6TxDE
	bA+oNQPvVTu3cycYGIYIvGheC9Vb4z5pqhVNvV4UreZQzFv8qh8IHAQ==
X-Gm-Gg: AeBDiesso6twvLVAyIAjWKNrxg49/Dgkh1cUvydd5/z6cdp056obwNOh3kH5gHuvlQ1
	frfXCEyZ8lq+yLppiNLgIWlfgjjTzdCLX1s2vt9bNgEe7SUzL59hZmapBOAWzMZKF/lYLI+LY7m
	pav4EYH9bVOxmZbuzHeScX5PUtiHSobDmpBRLVQA0HKgKmYSIuRB/GwtS9ToGw31gFbSTG1q69a
	sbq/ZNPvs9vniswm41Dy+dJlJUtiAQb1koEcgHjuLXueVNoalExdJRMfy0nunDkkKq7Z6GWZxqQ
	U250Wq4A+0LBvg0F9XrcELdS2IrrkiPvuvNe4gCkFis2mcj2lLveNqnwvSTb8Hh+EW/pM6TLfIQ
	xa3DSPdfmUK+iMmHn6Zk2G+DZ3zQ56SxxrzvnlAqiKDwYraJjcN0iycWHFf+JInxZOXc=
X-Received: by 2002:a05:600c:a30a:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-48d18ce275fmr36490285e9.21.1777988573098;
        Tue, 05 May 2026 06:42:53 -0700 (PDT)
X-Received: by 2002:a05:600c:a30a:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-48d18ce275fmr36489575e9.21.1777988572565;
        Tue, 05 May 2026 06:42:52 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d149d49acsm30503175e9.1.2026.05.05.06.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 06:42:52 -0700 (PDT)
Message-ID: <30f588ad-cf80-432b-bde3-13b3c0d5a124@redhat.com>
Date: Tue, 5 May 2026 15:42:46 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net, v3] net: mana: Fix crash from unvalidated SHM offset
 read from BAR0 during FLR
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
 yury.norov@gmail.com
References: <afQUMClyjmBVfD+u@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <afQUMClyjmBVfD+u@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/1/26 4:47 AM, Dipayaan Roy wrote:
> @@ -73,10 +74,28 @@ static int mana_gd_init_pf_regs(struct pci_dev *pdev)
>  	gc->phys_db_page_base = gc->bar0_pa + gc->db_page_off;
>  
>  	sriov_base_off = mana_gd_r64(gc, GDMA_SRIOV_REG_CFG_BASE_OFF);
> +	if (sriov_base_off >= gc->bar0_size ||
> +	    gc->bar0_size - sriov_base_off <
> +		GDMA_PF_REG_SHM_OFF + sizeof(u64) ||
> +	    !IS_ALIGNED(sriov_base_off, sizeof(u64))) {
> +		dev_err(gc->dev,
> +			"SRIOV base offset 0x%llx out of range or unaligned (BAR0 size 0x%llx)\n",
> +			sriov_base_off, (u64)gc->bar0_size);
> +		return -EPROTO;
> +	}

I think that the additional fix suggested by sashiko is really worthy,
but should go in a separate patch. @Dipayaan: please follow-up on that
one, thanks!

Paolo

