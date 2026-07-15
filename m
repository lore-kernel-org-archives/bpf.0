Received: from mail-wm2-f1.google.com (mail-wm2-f1.google.com [74.125.225.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752E83C1F2B
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 07:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101002; cv=none; b=DGgwyF8wVK9Nfou6VXsiHMJKJmXpr+0s44rNG1FvFmVvLBDkE/OZBd9HJgsAdxfgpoWmiEpVUPUuCSBlMOEOTN2w68DAUYUb/eh5WK+8kkXMs9TT9sGefay8kcjEggcp+0kycyJ6qpYgqh5IPrONIYem19jSBaPJUUE7UPAd8Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101002; c=relaxed/simple;
	bh=J1D8oDp/CwlzXGufQucVcbkVb7dJhXqeZOznzUM2tjw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=H1rFnMBXoZrmDaqzDnkgqOpAkdgiXdiACejZOoylGb/bgyWKjfLaOx3Bp7gTWMf1RYILPrmNWx5tVnYp2gu9TuRBfWLIDC8k3B0AUYvySzcgRLmSJk5v3/ZEUgoOMgrBitXVI1JMIP7aLZehuKbdczhfKT13Za6xEMH7d6jWAgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDqGNpk1; arc=none smtp.client-ip=74.125.225.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDqGNpk1"
Received: by mail-wm2-f1.google.com with SMTP id 5b1f17b1804b1-493b7dd83e8so4257985e9.1
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 00:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784100999; x=1784705799; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=J1D8oDp/CwlzXGufQucVcbkVb7dJhXqeZOznzUM2tjw=;
        b=QDqGNpk1gz8Osg12M56lAYxpPtT6ZhTF5MsqY+QQmCsSU7KwnZtvvD4J6wMCdyIxQu
         2LMRnN6ntcJ5A8IuBjd5V65FjSLED5zYWCBEiPX7rw2l+nMXarF4qDvG9btUu+Q+RbRv
         kvpWaoFkDDKVTy5oD+rUYSvDSl0QnoKJrYipruW7RSkR7CWAbFx6Jdt8QohrByfOkulM
         hAQTozmLOCWs3tO9isEy9Qa22k2MptOA2YV/beL89k2XMogWrdrplZnJoQEfoLLPbTsG
         sSjpf5rWFpuiJnf1S6VAnJWPGx/uGhgLfORa1tlhYiqdKak6Ra5D5/omyUQnK2EwnSRt
         hEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784100999; x=1784705799;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J1D8oDp/CwlzXGufQucVcbkVb7dJhXqeZOznzUM2tjw=;
        b=XGT0ilipXRqN0WVOyW+lfP/eEtg8Y4CQwtukf9msm3upA50vCtf63hpNbdXOKlrsRE
         jHucvRkcSiQT6Pl+CsCq0ku18EPOUO9FqTVr2HMuGk1Ici/NPRACftmAcKGF8ZQDxus0
         yYtL+cvWh5xRGiv1Bfr3ufBM3plqDgZPxkGVntXyaew9ZnU9XMitKxp7BoRF5+UtLuH7
         CtEzwVdwuszRbikrTiJ7pRDvZqVG5EIUWKPAwWHx5lx8pIWiYr+XTBW35gj0WC/Yzpw7
         7Fzy7dbc5UfnWobWyCPdfiYPfSM+QrLY+y6vkf5xH5+Y0L7hneaAxdKhO62h5hxW3fKl
         6Keg==
X-Forwarded-Encrypted: i=1; AHgh+RoWDPPf/6e1LG5upB/lFQKhqfqLvLOewDKeySQPbM5VxsFD3l/b/uG4XZDb5I8fdwBaDFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAp/GhpELVj28V7uOp8lNgLFdtuG4exRtP5d2tHsg5XW8YJzKW
	IUUZwCggvxZEWUqf4+fkThnw/ymS7VsVqE/j0vqxW+f9Cn9QCUJShtbk
X-Gm-Gg: AfdE7clhxmVqtN1q3SMk9seI6cE4x9lKeHDxMXwCw7zPSMvDhfLKOzJQG24XUDFwXfE
	ZFeH5eHt3RDH8kdqVxpYmSeXB2ElCIp78Cs4tpR0VCtUTaU+Oxzz+6M7C+kppQKQDS9gy9+bRvn
	aapzRhSVyyJdbImpDALtVKKS8YD1hjd8N+1MpI4Q7tf4XRWPT5ATc50JR0tuu25zx+Onvz02D/O
	HfA4upTKEt0UubzY7PXj5jhwLgg6VBnvRmyvOggtZx11vdwGMzeBd+nodaoMGwmvO+CrZHx0sU4
	xln43uBV+DTzq2OjPiA7e5ej6xGBotVhM86OiyRa6KhHdbORZ5zlI7Qofd2HuHWDlfHenmrR80B
	tPS5XkG41Is5tRV52XeOn9cj84Eovh+lVX4zuBdB2OB0aQ+8/tj9diFcoe6NKD0IR8CaBWvbUU9
	mBHZIpaBwE8l9fqcOXpPVYpty9MiwCvFcRGlM2iub3qc+9OrsMDiwmIYKgxDwr3Hru67hX4oafu
	Xss2RDgXFmIKHyWciYvR+nOUoU/43L7UToKP05DAn+X3U5rUldJjwAnvmmnL+4toQ==
X-Received: by 2002:a05:600c:528d:b0:48f:d5b8:5b07 with SMTP id 5b1f17b1804b1-493f881dde2mr177320075e9.20.1784100998423;
        Wed, 15 Jul 2026 00:36:38 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953c59c9a2sm26357825e9.0.2026.07.15.00.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 00:36:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Jul 2026 09:36:37 +0200
Message-Id: <DJYZ0RFMPKWT.1OU6W2YGKQP4B@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 16/17] bpf: Report Verifier Internal errors
X-Mailer: aerc 0.21.0
References: <20260713153910.2556007-1-memxor@gmail.com>
 <20260713153910.2556007-17-memxor@gmail.com>
 <b7c1fef812fc5b0a353596e082aff28a67cfb018.camel@gmail.com>
In-Reply-To: <b7c1fef812fc5b0a353596e082aff28a67cfb018.camel@gmail.com>

On Wed Jul 15, 2026 at 1:17 AM CEST, Eduard Zingerman wrote:
> On Mon, 2026-07-13 at 17:39 +0200, Kumar Kartikeya Dwivedi wrote:
>> Augment selected existing internal-error paths with Verifier Internal Er=
ror
>> reports. These reports avoid suggesting source-level fixes and instead i=
dentify
>> the verifier invariant that failed.
>>
>> Cover non-overwritten BPF_PTR_POISON helper argument types and inconsist=
ent
>> kfunc graph-node argument classification.
>>
>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> ---
>
> Tbh, I don't think this is really necessary. There is not reasonable
> action a user can take based on the error message, except for reading
> kernel source and figuring out a workaround. It doesn't matter how
> nice or not the error is formatted. I'd just drop this patch.
>
> In case you insist on having this as diag_internal_error(),
> there is no need to have the error report function that logs it two times=
.
>

Ack, I will drop it.

> [...]

