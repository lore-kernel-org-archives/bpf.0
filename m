Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC1C36923F
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 21:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785705115; cv=none; b=TTpJEDAjIk3VuifC207po8KsvuIXBIzRCCSAtu6F6arns7skgo+APfTBRYHINRoAaUnKWZNsJGl8KRmm2vjufo0onKR9iWZK5lwT2xPR0ym6zWRVCt5j/pzH1G3PHfA3mJUO1v9XhUPE3SgNJYEm0PegHLe2+RpoeMr+B5kLM/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785705115; c=relaxed/simple;
	bh=8hoxeqcQf1ocDUY471MJQWUS4u5BTCv0FfOauckMx3o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EvMlSY2TzyK2V5/hEFXs7mcuLc78h7lXxVCcBQL2rfu2Tz6/wNGBJJOfXvqyvyXREb/I9SWCrLTbzZnSMhoCIuAqMFOC38NYEF83Fg//1KSFvkRjcxo+r0LDmitQnP300sO3RowA1ZwQ3lB5bzEaDDLfIvhHrbJRWZ1dbfwloR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=md3421vQ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="md3421vQ"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so1612288a91.0
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 14:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785705099; x=1786309899; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8hoxeqcQf1ocDUY471MJQWUS4u5BTCv0FfOauckMx3o=;
        b=md3421vQaDHVURM69+3BBphBBC86ySJTxc6CQme10yAUVib85DDNVmt46gjbe6B/i3
         mH4ebROfzeE8AAu9Ueq0jytKJDTJO+I/6c9rVJw49Lb8iGRvSmp0PMKkUVj4srb4RMmr
         BrzQmee3AUEjIs2oth+7vqPAdxiNHGNyJhSdBuuFCeKcmRj0mvjISl4V5pf5niBzLLYM
         n4qq44gIFyFp+K+WFhIkvpS1ClmF6WPhWOqdw7JLhSw9+yTjvksXbURlSaBTATOvGe5H
         dOhHxnYPe5Bhyj4EJUbORsV89Ye2lokssuUD1mkKOlhrrjT3nNGflJIs+CutVDInhhEw
         ZCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785705099; x=1786309899;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8hoxeqcQf1ocDUY471MJQWUS4u5BTCv0FfOauckMx3o=;
        b=oyZ9IznY55lP9zM0s0HrqBvK8vE6JDqvJ2y38yai6LVno6zlm3Aj9w+fuAqgqEXGfm
         tjdUuMloMmJUje6fC31Tr9zBLUx7T/BYvlyYGaUYls4FVp93aDfUR4zEHehvEFxnFcqG
         C9XmIsfdLueZzw/1mF/yMj0iWmB9QxdeXMhj6cRijiuEFLcpSxZYGshnSV8XfIh8caGe
         C0gwT6qQIDH4UT/VBFi1yoD8frNjN/2YHZORfeCcLL5oTQm+8+9lEM5SjmbQZ5C3gTxi
         K/ADxw2BhHObxchpCLunDtEesWyotZ1kYi+9eEXDc361tPQwvdCrQ3RWIjC9nrkY+eLT
         Y5Hw==
X-Forwarded-Encrypted: i=1; AHgh+RobOUuw1hZ5vZ9W5niDDJszVaFqhwrgNhUvxncxikxpj4R8n+xXlic2ex687SGuhhBQpx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiicgM991dsOBNRq/j14aX2pvsI8fTB8BIRb0+hx/soSc0vLBc
	d+9ZR1U0uKg8svW5gFrQQ+Xnm+JmhOWyluZxGQqTDatGnMwWIiheGNNx
X-Gm-Gg: AR+sD11A4VVBjJqdYh5FT6bbVMX6U2lN8Yicv7DRDnmMr7YPHjwbJjzvsoz/QqsExWf
	S2RYIOXyFZ9CHK8/qC6K5nFLNLYzlyevQl8z9crf8iTo0VXvP55BWlPuGdcQSXZdmU/MpWQ4KpD
	FMmr6nUWUVf0nGZ+xlpe3+v44MMd0KOxc9qMK5BH6rv+wbrAGMPRJaU69XgtER/pMtqkqvvPB7x
	QVGQdVWI+1eQrqq4ZetBukL4e6c9A4WuQ6qFLIJst+mDL18WzjX5cn88YbqySXZ7p/Ha2VUczqi
	KL/BrnCI7tMUpYSAtAoCWBIAObPE8kB+ZQP2TiL/qm4Gp/FxKkkGKmyT9Z0X1Kj/zijo8mpHIKr
	1YM810x2rg3wZ361szRU5XDpE+Kf40pHvIhmuhL6OBX9eQxBfsFoXzf/eq5Jx8vCX33d5rxaV6f
	+eRlfp7RdPY0AoZ07pGL/OBqlN0lUbBxu49ONxXoBYJjJKfvN9LogUwTiJ7KdzBU5l+oqmYhbps
	N81L4vmau/kU5Bu
X-Received: by 2002:a17:90b:1a8a:b0:37f:9e21:91d6 with SMTP id 98e67ed59e1d1-38fbcaa4192mr5853153a91.13.1785705098610;
        Sun, 02 Aug 2026 14:11:38 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2b8c5c5sm2313362a91.4.2026.08.02.14.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 14:11:37 -0700 (PDT)
Message-ID: <95d8960950ee42a77c2f62301cf4ffd31763fbe3.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] selftests/bpf: Adjust veristat stack
 depth parsing
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Sun, 02 Aug 2026 14:11:34 -0700
In-Reply-To: <20260801230400.850271-3-memxor@gmail.com>
References: <20260801230400.850271-1-memxor@gmail.com>
	 <20260801230400.850271-3-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-08-02 at 01:03 +0200, Kumar Kartikeya Dwivedi wrote:
> The verifier changed the output format for stack depth verification
> statistics. Adjust the parsing code.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Do we care about backwards compatibility in veristat?
E.g. I see it packaged in my debian system.
This won't be able to parse the output of an old kernel.
On the other hand, I personally do not use stack metrics,
so the change does not really affect me.

...
