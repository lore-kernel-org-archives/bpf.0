Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792772265;
	b=wGSqpr9NJenU1c7phQGNjQY1oElNLkQ8NHIm7DVFA++vxQ4BRqk6F/XfNAr2pioI9mn2
	 AhsvRFuMIyDQcNZcX6lYm42wH0OTZ0Ale5YsavEh04TtN7hpGJbCeuV3ShubHoMLLMEON
	 KMvaAx7ZeoDHayFixPd6eGM9JTUlD9ghyyalHkpCFA6SxFmuX9QgxdDpQ1n9C7s3nSQ8I
	 EmzL1TzPvjcw//xMosDQfZXe5hkDjgWOmjp/guQYAibklxQa2EDYNGczXFfQjFF1WCg6l
	 6v+HW9za1aba605x/l6DV/Gs7fgYd0f1i+xeHsXuSNz3bCU6bHWw0ZdaGHDURVytcXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792772265;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=kk6dztlU8lxyrbeDpfPrRQq90LrZJa6ERbiS1+e51K4=;
	b=tEgRwiltM52LB1J4WyByXS32WREMajetN5QI/NHomvk+6J6F1mMAuj79PNL2QLs9WGXV
	 4PIQoeIT6hONGDI7g9/8fD/CHOMrdlht1BIe2cRo6ZyRMk3EptIS0nU2ocx/DGmR1RbuI
	 GIhsjTT1PneQZQEslmJgUn5fRuvdctNIOFWxrG/QGqSQ4ZJAU5lnJ6XSmCTXOO5LPruTP
	 8RGm5Oo9ZtKbz6BupHILGS1UyaEc+GrTlFHPLh3/EDKPtl92SSuFWY9vquhaAVeoE9EDe
	 TW94L5WtyvVxS/BamHnHtzhz4fXCyuFqvaqSoUjsTyH+1RXlBjGqHNUfHYHPhRVR5aA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i5O9TycN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.75
Received: from mail-oa2-f11.google.com (mail-oa2-f11.google.com [74.125.231.75])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30645606A31B
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 16:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30645606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i5O9TycN
Received: by mail-oa2-f11.google.com with SMTP id 586e51a60fabf-49e404f72f2so432683fac.0
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 09:17:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792772264; cv=none;
        d=google.com; s=arc-20260327;
        b=fc7tD6qqeMVA8nFjM8zCmtNsXplxwAarFjyNJIh0j/VJtv5WMRSX0F4jfOq49TMH8K
         SaHMfhqNq/m3n4DkaIu+VGG4upwNUomuvGS5/cBDswPxKI+pVobSfHtuSbUNqUzK1gMq
         qcWAefoYo5Ir/bDVNqIAdoXjK82g7n3qEyuZvto9exSuV84PsxDFL3BrJWkWorUZsQwy
         kvHuEps/O+mJ93uR9iCf92A7zllmknWvjmD0PI+wY0aTezVir/I+v2vD43Ui3KqCco1Q
         VSyaBHJhC+u2GE16P3K0sgSVpC/idRfhzx5mTHs3uOWxUiwzSLpxiRKygnYZyLLv8+7t
         ADHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kk6dztlU8lxyrbeDpfPrRQq90LrZJa6ERbiS1+e51K4=;
        fh=8y8UrY6+MhGFlP1rx40/DQXix2BdF4eHtnFQS4Olz/c=;
        b=eDy6aUEo0VdmAG0ejUaWfCOJk0JGalXc8mBpZyBDmA3fbQWNUPALERp3rnxyxEzqad
         TkdGn5S6rVntutBBUbGaDXaR7/upmbUqxyGw0tFkxC2pyrxoPm2z89gCLPKx7OWg166f
         Otgg7kmf9lv92UgnhvLXePHXaZDq28HcLwWYXkNFaXydgE0G28bEI2meIJfSnBQfiaBs
         ARrkl4kc/SSXNYde3RIhYq6utAKJhyLL3EH2Xu4xJgPtlkRi4DskYJjtFl0Jz+z4IVnC
         RKqMOwn3MpSzAH9wQdccmxs//knl2dmfvNEfysxcYtmxce4HozPqXWcw3/k+7k3OuayQ
         RpoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792772264; x=1793377064; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kk6dztlU8lxyrbeDpfPrRQq90LrZJa6ERbiS1+e51K4=;
        b=i5O9TycNALY1BZIpkyHGSK/BZI5fq9bVLALXBv3dD2VtECWddPfjMtp7LO7uneJNwy
         mn6H9nCBgdBqqqqu0Hoat3ejWMwxIX1A1bFfcWBi5AL4ysuhIjPpjt4jtuK186WdQaAC
         ULvd7EsKZol7cG3OBT82lbsFK9HjLtbeCXGv09PJiUOANpo1IOVaRIA0YnGJPUqnfDD1
         lSvXZnRscDnfRUZIy28TO6WvaNCoT5utwzD410lAN3gmgbS7Gy8iCAyeKpk4GMzzGxq8
         fmAn9v56X2NqSHKuDNoX5kpWqTjBG2xfZMPO3XXmzvDjFvaWp1ATnee+fYobfauxr1pc
         ViFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792772264; x=1793377064;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kk6dztlU8lxyrbeDpfPrRQq90LrZJa6ERbiS1+e51K4=;
        b=YSyOxNGMmDFjFCus9HhI9gdWqCohT0kmsINkReJWiLzdi4HRZ7XR2Cn/0/+mMssj/H
         +9hWbHulahIBdZQdqZyzP+2kVluMVwONvVsGAh5yg2hxT2HSwfHOrqnkklCp2B7OzBz4
         m0iWXYFdIPZVgpVAJftMzODjo0HNWftwlToXj8yQjfrsb4ITnbdp/dGGzr6u99b4RRwo
         Wb8pBDv32h13ZDh+sXSEjgYbrLx1lkY4q/CbxjZi1yvRRNzQJ+Ej3+oQjSHRTIU16zhx
         d0dbd4JyEdqdirZk1+VSouCNZ72vfzPXyvRoBwUZ7hKqscR1xCZytFUVD2ceHSwaDTku
         vvUw==
X-Forwarded-Encrypted: i=1; AKwUvBwK8riqwH1yP4xbNuNfCp428mD76XRtzTTRFqhp3RDO/NXxf8tfXb2maF1tGjqv5bV84hE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKEw5/ABhPFXxtiSPLG/qfnesZsF0zsM7DPE0jbpuUkupA/LhuD
	n+JzeqY+5fhaFcJ1YwP2SuuolifUBkF2rYXyqbg0ZZw8yu56axq6rgOzLcEnj/z19AeGKkzSBoS
	YdrtugNg2FH2Lso7UNTw1ivbG3jVl+ww=
X-Gm-Gg: AYBFou36jBJR73v1SPseCW1oI82OJTr6SYUNX90sr7iP6x34hWC/ABqyp8BqgKaYUBN
	TzClRX7cGW3ZUKTyBziYvpzpnyV8VyJXiX1+F4rUnlcoTs8iklrpRRDDQOj3nT0IxES0fE6WkMO
	pR6XfO3oWLet0LmPgbyuWPCHepWogDEz1RUzZQA6+AUIwv10LhW9CIP5kLbzHT+xcrkxZXKHctC
	6Bvp2dqmr6Nyyuj/YaTKjdiSl8DOwEzBlX9pGER7SJ9q07Zhc8wnA5HVnGsoxVPnsgWpSrrKVap
	W/azf4r8tcxdpK9KSdOwDeX12RkQf/Hb4JoITmYUapAB5bU4EQGYVaDlEZthe2rIetQBR7GUspX
	gE/lfm0YawptKRMOXSqT74Q+OAwfiXcyAWmufXj6/3BCpZSN2BaCapuvM3ghYc1ulFleTGmU=
X-Received: by 2002:a05:6808:6d93:b0:4c3:4e34:c69e with SMTP id
 5614622812f47-55be82a0e7cmr1678472b6e.8.1792772264048; Fri, 23 Oct 2026
 09:17:44 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20240927101342.3240263-2-zouyipeng@huawei.com>
 <20261023083131.58291-1-dennylin0707@gmail.com> <DMCCFYFSY28Z.2BL8TJ1R2QZ1F@gmail.com>
In-Reply-To: <DMCCFYFSY28Z.2BL8TJ1R2QZ1F@gmail.com>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Fri, 23 Oct 2026 09:17:33 -0700
X-Gm-Features: AclHuK8R8NIoDhHIJiBhNow1L18mAl-RHgwoXkj9e8ljaI7N0Dvj55tMdbdtOeg
Message-ID: <CAGEkeHeCssw5FhSwFuKyQP7K-aZwL5diyBH+cd-6KaEZ=hZgeQ@mail.gmail.com>
Subject: Re: [RFC PATCH] cpufreq: ext: serialize BPF registration with
 governor teardown
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: zouyipeng@huawei.com, zhoujinghao24b@gmail.com, rafael@kernel.org, 
	viresh.kumar@linaro.org, linux-pm@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Oct 23, 2026 at 9:04 AM Alexei Starovoitov wrote:
> drivers/cpufreq/cpufreq_ext.c doesn't exist.

I got the submission route wrong. This fix was based on the old,
unmerged cpufreq_ext RFC, and I should have coordinated with its
author before posting it to the lists.

I'm withdrawing this submission and will take it up with the
RFC author directly.

Sorry for the noise.

Hungyu
