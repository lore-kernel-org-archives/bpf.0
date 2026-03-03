Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748633B8931
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 18:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561580; cv=none; b=GRzWnrh8HOItWqE5lBks6/tsQuY5dHqEKJydOAbZJS/ffHnUX/rPv2AfdrDsBRv1WSd7kI/Fn70WgSF/t/EmmLxsVLToyiaBC+yUxjVNHLQ6gfM0GkDM34c3Gpuunp5s62jf+FIJsS/ddkgaTEIbkDld8J59g45E/y4XygjAsjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561580; c=relaxed/simple;
	bh=xNht/T+WscIS5Q8ag7MUrZ8GHvj7xpgUTyaWnBTqcHw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XjXU6lo5chwS7pXrVJsj63hY8rQGNY6z6ztSjM036UqMrIL9vNsrkATGVKNPSL/65oXaLWMVzO0pfevRVyMgBZw4s9zCA0p02o5l7KgqKaMzSOIHjpGJKC4v7jT35elyrGyHKQlfErhB+3xrZSz/9lowkqBpBo3xTWpuMOhUEEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEkF63du; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEkF63du"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12732e6a123so2613609c88.1
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 10:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772561575; x=1773166375; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bs6G5u3J0O0JY2hFZLUxi9LFHLPH8cYrQrqnv/UplR0=;
        b=CEkF63dupfmI2tS25+vmLYnl5WZ4XvOXPut0wsM9q55RruqJlgSfLT1JFKUAAEuJED
         kbyeovKpnC0ox9HGsFRDyYGpjBBdEYXRIsA+Ib+tFM3KHQwH7ozF9F+bLERdIj9/b1M5
         eLH3jb4npx1T1+DNftQijSmxPhN+JpU4pDVYZPbPMlnsEjnrk8rn7VB5tXlcLVwGjC0u
         YKZj9tEui7re3p1E5vkOXbixWvlaYeJP/o3Jaawn/TNd+tyFP9T+szaZWAr5R2jlRGRa
         8t2PHf93n7OrdLj5b5ruSQnfwyygFGeUULITNqiitueSJmd6EzOdhkPpR44Gsylp2bal
         +Zsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772561575; x=1773166375;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bs6G5u3J0O0JY2hFZLUxi9LFHLPH8cYrQrqnv/UplR0=;
        b=sMWFusQ5TxRBrA64lhoBvzB4QagPdi2wB2Nz0dowTOC06ObSg+74pJYUKwA5EM2DKN
         JIMG6hw3qrztHVqZfAELb/eIfCxwv5jqCgBdaH5yjamXF+mGPiIM0u6QUCTX+7jbXPp4
         1K4frFysiE1HXDkyXdOcfpEezH62MeLQcrO/Pg7ZX5OJkLqoTlwehqBiXC66bFflfuuj
         Q06ADJgZtDdKzOt9SXlrquXwtjksR8G87lWBm6oe8ozi+EGy5MbXa0Lu4Y0kcOeapjcj
         d/pRmmCGWPjL9PB81L369u9tv8xO0EufPKG+Wv9lW1V120bzwRVgI3KT4IB2ryMn6JiT
         DAIw==
X-Forwarded-Encrypted: i=1; AJvYcCUt4J2gUqgWAVAj83JP5VHcDSrGBHIRjJJ9QSKnOtcYX1Tsh5NRxNpbbSF2WX64bS597Jk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7otTdByPKHTlbsERelIjbyWRZluAEm9OycvBmIWB06aNn5v+C
	7vwt7stBkZ7Mu9JfqrsYi4CC9jnU/BHpMkGqfHYryyKqwmbdy1889S1J
X-Gm-Gg: ATEYQzxgPJbgTqyCsPAzIA1XmhIpoAORRhQ5IKXu/s3bVkcO9S/0QU6BYYSH+mP+0p+
	iMga7YF8zlDwfkbkhsmNIpV10gdzOBGexG2Z6XVcafgcVFQMd5WMGBSjbs7Av8DDizyPHue8SZ/
	Syot5hCqeIwsk9xWCYZxaEygtaYb/3DnpnUWOOGNrfzz6QLwxbKLnNXnsrWxeJwPdC7uM/4uRkM
	bio69NLfUM6NQD9NMRA/M/GHdCU7UtsvNTGGKgK7WlstXj2zneNofaSalYEGkbr2BEyE42jhMEb
	mEhzfYNXL71+4Oq5Uvnfs/f5jbWBd2RKaXgzh1R+lDWWy5k8iaNehol032U9eGaZ2Zozm3HYb8p
	J+Cjqu1HVMmqA2VSH3cUM6R2FI5er+SY2yaJSkFAX3N+idFV+eM1O3qnyx2tD+3XGbQWlDG3vWK
	UAJFjxvHjiZ6iaF+68uRyivsyXDWG2NuLD98QTDU/W01h/UThKgbDFFHhdEJnEEt1rZ7Y+qFZFV
	C3JIQb+ozMGmtugXD0=
X-Received: by 2002:a05:7022:128f:b0:123:3bc6:1ffe with SMTP id a92af1059eb24-1278fccbe64mr6646779c88.15.1772561574941;
        Tue, 03 Mar 2026 10:12:54 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:bf8e:1331:ef2b:145d? ([2620:10d:c090:500::3:4473])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899d49ccsm20035712c88.3.2026.03.03.10.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 10:12:54 -0800 (PST)
Message-ID: <f68ad995294f3223d6bf3eef0176193b52ae54f9.camel@gmail.com>
Subject: Re: [PATCH 2/2] selftests/bpf: tests to non_null ptr detection
 using register operand in JEQ/JNE
From: Eduard Zingerman <eddyz87@gmail.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
Cc: David Faust <david.faust@oracle.com>, Jose Marchesi
	 <jose.marchesi@oracle.com>, Elena Zannoni <elena.zannoni@oracle.com>
Date: Tue, 03 Mar 2026 10:12:53 -0800
In-Reply-To: <20260302161736.156685-3-cupertino.miranda@oracle.com>
References: <20260302161736.156685-1-cupertino.miranda@oracle.com>
	 <20260302161736.156685-3-cupertino.miranda@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-03-02 at 16:17 +0000, Cupertino Miranda wrote:
> The 5 added tests are copies of the already existing tests in the same
> file, but changed to use R3 instead of an immediate 0.
>
> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> Cc: David Faust  <david.faust@oracle.com>
> Cc: Jose Marchesi  <jose.marchesi@oracle.com>
> Cc: Elena Zannoni  <elena.zannoni@oracle.com>
> ---

I think this is an overkill, these tests check nullness propagation
over id chains etc. For the purpose of this change something like
below should suffice:

+SEC("xdp")
+__success __log_level(2)
+/* to make sure the branch is not falsely predicted*/
+__msg("r0 =3D *(u32 *)(r0 +0)")
+__msg("from 7 to 9")
+__naked void jeq_reg_reg_null_check(void)
+{
+        asm volatile ("                                 \
+        *(u32*)(r10 - 8) =3D 0;                           \
+        r1 =3D %[map_xskmap] ll;                          \
+        r2 =3D r10;                                       \
+        r2 +=3D -8;                                       \
+        call %[bpf_map_lookup_elem];                    \
+        r1 =3D 0;                                         \
+        if r0 =3D=3D r1 goto 1f;                            \
+        r0 =3D *(u32*)(r0 +0);                            \
+1:      r0 =3D 0;                                         \
+        exit;                                           \
+"       :
+        : __imm(bpf_map_lookup_elem),
+          __imm_addr(map_xskmap)
+        : __clobber_all);
+}

And maybe a variant of this with `if r1 !=3D r0` or maybe not.

[...]
