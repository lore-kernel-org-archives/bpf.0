Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E773A16A1
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140571; cv=none; b=KcaaTnDdHbFNukCXMrbusjPcs4ejervFFa5Gnl2FfjrrOSly72qQoBjj6FVfH9z+gppcP1L6MTOJl3DUWPv1KNYbPwLaBErLzOAHEVtrmrNTLS3FhVRM31Z4I0On5FP9BTnAzIjhVJohAXSB2cPqcLXYMLR70Hz8y+69kIht4dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140571; c=relaxed/simple;
	bh=OAhI7gs+kphXf+PD1T34gRTLOMAJwXUxKg9WHDf3eQE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FZLwitgfjadQTRKoS9UpdJIHgx9KoLKd/OqeYfXkAN4bYDPsbs6wLA0WVtZfPKxDO20TEkg3XoYBOhglz21oRDF31hBuVuiPVALovDubEKgBWjpvyL8R491RnU/EF2HtRcnPjTtN9LJ1BlcMbSofedYQBHc8QmJJrtEvj06piEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lewxSlht; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lewxSlht"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b4afc8465eso1536693e87.2
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 08:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789140567; x=1789745367; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OAhI7gs+kphXf+PD1T34gRTLOMAJwXUxKg9WHDf3eQE=;
        b=lewxSlhtPL1hbtTwb6TECxzuDRnrEvLjchSOKpza/hIVD+4FUVbu1j8tkyDsFWLA0h
         2N6UR4dgiStWsdB35VbHKLao5l6VKhCmUHyJRAotShSUv5gNiv2zzuXk6wJ149TE0eTD
         kX1Fs+eOVzfG857D2SPBWKLINqVWWS0MMk3posOKTULsC2pPIRrP/Vyp4L8kuqQ2vhFl
         sckw4/nhqu+bsCYpMawxZPOOMOfbexQrbi8dRlAsMeop3F1uHR/oMaMigO9FKy9WU5d6
         wTVyfr08k0tzbZFPXQYTNOp8BHdj3mxarUFjirvpxfcYPFsLzZ7+BTRr03bptmCSQvEf
         X41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789140567; x=1789745367;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OAhI7gs+kphXf+PD1T34gRTLOMAJwXUxKg9WHDf3eQE=;
        b=PkUxuAGUiBt8RPOE6CX7hiwlMX5Kd3arPSdG7pkLNX5vO2i1KTEIxlldkFIzofa9gk
         /EFIM3uuMEQkAopFZjPHERMikT/mBqr+ts8TQo2txh9ScNY7wWr5asMf98Kw84Vz8P2V
         8nZLzXl9Ny4toAU9DqFL2DO/zWiC8Yo6EnsrUJmO7feuuGuXt33Txp9j646tqXj9tDjY
         z7Bba+oIcc8Eg2FcQd6D8x4PSrYMeQBOSWQ4WO7JhMs8XE4hvmSPvqxFplhMRlVJz0Hv
         Pk1tDW7p5rm+ZDHrzrjIcfy1j+xhFSOvssD4URcdgFurkK4kUCsdYYTwXwyQAzoGPzL9
         1geQ==
X-Forwarded-Encrypted: i=1; AKwUvBxvQGjbS96JHUVG9SJgUYmOomCLEHXn8y/VX6SbgkuVMyK6TxS9AiMMFJ90yRkSymsfxhw=@vger.kernel.org
X-Gm-Message-State: AFuF++nzL75qVKRUdpnZw4v7NmRbDl1eA6Op6hPx1n5BQZ4lPLWjfr9p
	V0vQH0Ny8vyd7lenUSTNMGxfiU503gYhIq2TTrZ23fQjTlfpLRf0/AU6
X-Gm-Gg: AYBFou3woqYAX7gW4lSZ0uVQuwRN859OfrAf60SUW21jQRUFdDFZA+Q4QzADd6PV2fG
	HSvdaq2WSs9DLJWnXT6gu0hVUsLBsLV1cJ6H5mJ4yN6m+Dsyxz9pp0rVmx8nPhkAH5u9fSG4ifr
	QTAkWNIOHe1ByekA+hY7s03mMNjq3GjVP6mImcXXC0sVuIKHT4WnFxD11PJk2H3f2CielDACQz9
	jLH5fLJvQXrN3kV0kDV79F5Y5D/NvHsK91NIcZcWPCk4Cwpp3TWXyZZcvMHIYsTXltOrndyn9Ka
	OFAgEQ3vcrRPAIpo8QhOg27qEK8PCT4N+ZSWgToiMgITRCI2j6sh/Kv/Gv1z+my7eNzip4SKXe9
	Km+tOp9au3XRb5Wj95Sd36u3gpVtvMEJ9WREnLsPVPTS4bEpHcHnIAMr5wQy4331/ZSgjfJvdBA
	BRsZTphTYpy7ZLLRDMhHXFxNmpDlNonf/3h/QFLb4ZjUFGwlUD7octBFrXOm1+ielduPUoNw/T5
	mlBBoW8qR2GK+qlfBuCpUzV6Yu8RFK3fROSksq3VKxiaJZGu4mP5eH4cUfp55lcHjyRc5LgxJ4=
X-Received: by 2002:a05:6512:39cd:b0:5b4:9dbb:71d0 with SMTP id 2adb3069b0e04-5b8a0303b30mr898325e87.23.1789140566769;
        Fri, 11 Sep 2026 08:29:26 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:8::])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a0461ee3sm690597e87.40.2026.09.11.08.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 08:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Sep 2026 08:29:21 -0700
Message-Id: <DLCLEB5Z7HGS.1X65OY5VVEF1U@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Yonghong Song" <yonghong.song@linux.dev>, "Song
 Liu" <song@kernel.org>, "Jiri Olsa" <jolsa@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Pu
 Lehui" <pulehui@huawei.com>
Subject: Re: [PATCH bpf v4] bpf: Fix UAF due to concurrent consumption of
 ttrace lists in alloc_bulk
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Pu Lehui" <pulehui@huaweicloud.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Hou
 Tao" <houtao@huaweicloud.com>, "Leon Hwang" <leon.hwang@linux.dev>
X-Mailer: aerc
References: <20260905021139.4116529-1-pulehui@huaweicloud.com>
 <6b43a2a9-7e71-4af9-bd56-1bf0d39405d6@huaweicloud.com>
In-Reply-To: <6b43a2a9-7e71-4af9-bd56-1bf0d39405d6@huaweicloud.com>

On Thu Sep 10, 2026 at 6:17 PM PDT, Pu Lehui wrote:
> Gentle ping~
>
> Hi all, Is this commit looks proper?

Sorry. swamped. It's on my todo list.
