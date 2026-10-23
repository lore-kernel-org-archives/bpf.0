Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792772611;
	b=nPWQY4A0UBdmBr8olyYUTP8R/Kvjk1mipnY1t9EA4eUset5ErFT+8V70wj5GrV2zEes3
	 OD8E/55PHy2hIPuuvH4lciAlC6e/hwuD4G9I9SxPavVFSQernK6qYOK9V5gguh/w+crhj
	 Fa/aHbgU9421JOfU55nn8iGcYAwLwtLiTa/sfCixdgjT/Oy18AsxXIm4kMli2EJXFd2oy
	 kQ07A8fbh8xurHHvEYNoYnFvGDq5VjWhGvnT7HajxUE+0t9EFz6aVRfTOBp5Q3UEBPi+F
	 WVIYYOaMkwGfTias6F3PfM0uaIUV7VZ9N1vFnvKPK7K8j5q6frf3+ZJ+l06HcnojtFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792772611;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=IvW6lHo8Sx5oQOPcXTpclDnDsRsDSJE3UXLgFvW7AWw=;
	b=vhBCU+dT3v/ZlR/wd8iZi1OMis14lIrafkfYORL9WMg7T5P5Xg3z9azyUJ8k3Rsjj+EM
	 w4xbEpwD7cDiveZXyX5QRcFsVRMKit7lkKckbkU3TCvWhFdqjsQ8aVEvpMMHWNFLvYnL3
	 EmPIF80vd/uyCILNVbTmhVALlRI8NuAfwCNgk59kCRKGOFui6ceCPCV1Y7Wj4WfEJz+7n
	 mFDlakCc16g+rl9xayPSDMeu9km2Wct6L/ix5cdX11geyNod8VDuy8v9/p0tv1KFKLDz4
	 +Z3252LLn2nS8vXmfGdu3UN4LXpxSpBzHY3OvR5JfumqEMQ13oSolJKwTguY5FqFqJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y0bYFay5;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05F9606A31E
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 16:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A05F9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y0bYFay5
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso521321a12.3
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 09:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792772610; x=1793377410; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IvW6lHo8Sx5oQOPcXTpclDnDsRsDSJE3UXLgFvW7AWw=;
        b=Y0bYFay5rd5Colmv2O3UNeuLmTZNXFLIC/MvK8TKv0S1BpjdZ0yre/J8qNF3u9ElSg
         02Tq04Ah+coJxqKQSKeaKl8qHFBsmIDKOaz9RhgdtLHAKJpXn45LWy9crKwQ5jhaEsfo
         EfF8cz/coLGrDSNKhfFbdUdIb7ZlUJTpMtMO9PfGugI1m1HXnJFDUir8sc2FCkYQr6Cb
         eeEpe8tiwmfvUzGgfdV/fZI+LdK0afmyM8nfde02KMJCboQUEwoYV+ZIoFdxcsRGwsEI
         8jS2GEc25AYmn3VV/D5WMNsyPwX/QXCPIghs4JtIegf+1mkHEMs5RuTsNIz90k0x0vtr
         1QpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792772610; x=1793377410;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IvW6lHo8Sx5oQOPcXTpclDnDsRsDSJE3UXLgFvW7AWw=;
        b=H41iZGVzcSarPb4vZTRg+yk00qEzUD6KCEyni8TdHTBl/9/r6jER4Fof+QGGuFizvE
         VIQoZWH/l+ny9LvN5zGB8djhr8IojAZn50KTAe11Fyepy8A3Pj299SwPGXuDHnbAezXq
         pwcLDaNS4tZQniSnauzFREPlnHVAwXPz6uKzwP1dgqwty1CIoG54ymMJ+zzu1VQpMa7S
         W5eAjTTSIaIM8UgCmSACTlW8Ham/nCqUSbKTZcqf+IzGSwOSYLf8Yg7wKJk1LEICdoYZ
         p1tHE9KTnd1SHOwJTTHSRsF6gGBHw5yulpZBu5PE01sKStGPM5kzg028rndcX3n2ogCO
         QreA==
X-Forwarded-Encrypted: i=1; AKwUvBx0fqf+/HpFx4dRD9r8/BCEes87K41ERMI08CxIUxKzP0CpGDRMNFBVoenwnBTp3M4RkG8=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6I5Q55botibcG0d7V3QGnULAMxp3KvyZEJkxhbWtvbvYn5cbk
	gAQUDduz2bbgFOuHgF+wNtBu4B81cuTMekqaLanxaRn9aRShdzb/4k+WQ2nF9w==
X-Gm-Gg: AYBFou15Ai5rXnxHCy51WZaT0h1bsptkkrRGswwKXbHMOrUoQOIBVBhlP+4k5OV87KT
	HvHchAOcz/k2uFkh7cqWCCYFsaB91EkCUQl4A86GOPU8FS0//kcaqD8shjEJrXKXfd12Kx/niXg
	2LUs/wYnsYXpe/p7Nh5LzzvMnvWKeIs/O4wnoo+Xwv3Pu6TSq4jsXSP16rmlXEuw4GAgTgfJyHu
	lVNmIwhfiJIFGL4RldScBKebmJttT9ddxX4aKoN30VMCBVhWim2FwOwLZKKSyxbM7Oz4L/69Gnj
	9Ipi6RjSqpDj8dVWaHmh+uTYTi740+YOcauJ86IN972atfnQXTzlB2u6y3Q+2PQPR7D5oemhkQt
	vsUzihjbdFq3cIs+Na+gBiu1JvzaYZ5vT1u4fzmU1LyremddwfVkjFzSqlOzQCyLTILRr8nWPbc
	2omifqGRzMj5836klgbUJuzIq2A3Dzu51h1wEdfHUAqKWZZcPDdl/N1MncKX18UN4EzJgbZ7TSj
	fyWykz5UuhJks5FXuFTTtcpMIKw6BSl4quZ3Io5Oj0TXQZR6N7eKMsoSREngVE6E23F6qijbGhV
	/CLI6HXECA/b1Kv3mpjbXPh7KlU9TgiuT6GH1Xz2QKfWnH8cF+oLwyfAxcES
X-Received: by 2002:a17:90b:3dc5:b0:3ac:9176:e837 with SMTP id 98e67ed59e1d1-3adce0cda5bmr2496299a91.50.1792772609968;
        Fri, 23 Oct 2026 09:23:29 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3addeb6608bsm702851a91.14.2026.10.23.09.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 09:23:29 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Oct 2026 16:23:29 +0000
Message-Id: <DMCCUMTT05PZ.31P1L97OUGHA@gmail.com>
Cc: <zouyipeng@huawei.com>, <zhoujinghao24b@gmail.com>, <rafael@kernel.org>,
 <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH] cpufreq: ext: serialize BPF registration with
 governor teardown
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Hungyu Lin" <dennylin0707@gmail.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20240927101342.3240263-2-zouyipeng@huawei.com>
 <20261023083131.58291-1-dennylin0707@gmail.com>
 <DMCCFYFSY28Z.2BL8TJ1R2QZ1F@gmail.com>
 <CAGEkeHeCssw5FhSwFuKyQP7K-aZwL5diyBH+cd-6KaEZ=hZgeQ@mail.gmail.com>
In-Reply-To: <CAGEkeHeCssw5FhSwFuKyQP7K-aZwL5diyBH+cd-6KaEZ=hZgeQ@mail.gmail.com>

On Fri Oct 23, 2026 at 4:17 PM UTC, Hungyu Lin wrote:
>
> I'm withdrawing this submission and will take it up with the
> RFC author directly.

NO. Stop spaming people.
