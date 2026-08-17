Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FC945C718
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 17:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786986351; cv=none; b=JmzeHTRzilLYYps6U7iuf8knZ4R3QX3fsn28y2zWi6aDpgNz2c6+af3yV7jKmxAEHxvUyeYbRp8CQcJipgLLErLjPNZ4lZ8UZvadwZZ46gFVdzkCwuLiVhnME6POXx5eyUq5Rabrus69ypQhHW/bHJODrd28gcQw/7CiDtTUKQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786986351; c=relaxed/simple;
	bh=13/2L+hnyEvXqpBGuEVn7UVOgA2p2cB/JYiJG4w0uQQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jcRF6A0DZT04gXOuC7JbJXXPL04HLpbbCP+YX0vIZvnvpDIrF2t/ajMspwmOZutoFeGxKRdhW8bl3bip0xFkt36mp6RB+KhtbN/OvuyuDZM5PNxl3TAq8Si/rtaNI9+57GbfoB/ZunOAu+YTXvr6qduWT3fhPbk8LaK8I4AKGg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQgmF9kG; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQgmF9kG"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84e0688b859so333487b3a.0
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 10:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786986349; x=1787591149; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8kefpmgbmiMzHT+rDojl0+wdb+ZHY91nE1zaXmQ5wjk=;
        b=IQgmF9kG9Wfl6lAIqXyQwg7wAaZtr38wlGVBR7NKTkkRTjy55iphpYsNsC5GZZrDef
         lq8W8OBlJ12VYyujqlDoTiyGAC/Ftdzxxrtm77XPMUd9zuCNTvHSPt+7TUSrulbspZIu
         J+ryKSxyymKTYGACTCTDd9TIrWHl+0vuhvshuI4cNr7pDMLUKh6Ii9VJdI1U1N1Nrdff
         stv4Kyq3W9tPopmCoKlNvr/w3juNgoQeVktF5t2M7ljf78mZTnxH5LDCVNpiy93FhiqI
         ADmHn1hG2avhFtN/epXxJrwC1JagSlqi3IPI0FXnz6kWAevChddh+Obi6dcdSnJW/i11
         VD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786986349; x=1787591149;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8kefpmgbmiMzHT+rDojl0+wdb+ZHY91nE1zaXmQ5wjk=;
        b=Rxpv9W+du8v+pRdmkaIUYt44c1IymtX7F6RPL6tiSeLjA5AveFkAkGarx/H4zjvniu
         rFMg6f+afynY0wQbKN653pUN8Adum0Rxgiyd4HlHo9FyKSRpdR1aryD2P5lbNOJruvNW
         Iz6fcO4AhFRf0C+OxtHuSXTgrFWDFVy1nC53IZalzcjaOabSJHQk3UO2kLT7LT02hYlE
         DO8+jOsrluIEQ5i3OB1DyyR4iPE9juxczO4Q8WJGmFrpAgyBZQ70/JsJ3/iVKhFA1XY/
         jucn+x6HZLgajdscSQk2hciOW6RYIWAJEIaI/h6hfmmMkUpxrOq5PDWOYxj4e4Xu0XOs
         khkw==
X-Gm-Message-State: AOJu0YxmSVoYFt5MSGB8VczJKmYIC/Tgo9E4SGUZO7KEv+ne/W72FkU+
	85l2VV8eVFD0RL1uQ7Iu69JBuFFdqvficH0MvefPfby0x5+UzeOTZ+NF
X-Gm-Gg: AR+sD11Bs3McAFLfacZCnMF8LcIIS4siX9lNhPRHPpD3NSPK8rH6iOjoczWsBgK5d+u
	/4rbH5RFQ2t0tvpWosL1AXMzqiXhesOv5144sEXZUQq737Er3LcmMfVBElSnjRohD0jETDjMi5c
	cgm9zMePM/CDoc7K1yMwQ1Lxsv185bj+1Gi+LwBTSkVGYIl5iSMV/WT8xI0BZoZWbCht3sMOqA9
	c0Y5IPKdahrJoWqy3Iu/OJx1HiuiihmChR6hOZj0joF0NGXn8ADd4JkurMFWOTKCFIOB3z+kMgh
	N4JxnYZPAtnwDfIzTmJUMEwqQfDoh4cxcbjId/teSLqp2oyogcgyiQLWc4Bs8Fyk2PjAXgfh9d2
	lmcxGcWHooJDOBchNevDn5DdXW/LoyjD53FsF+btqdNsD1fMuXw3Z/mxEVfjV3tSikXPw5A2chp
	HXpmrAbMJmxrO5m0sOM6UoZeZC0C4asZiU6/mYLxswGL0+5Bvlfexs4tpPl1ED7mGBDDD7bMGSZ
	/+KpVjUVn+4v1KH3BB4AqQYMdY7JVX0/7h/7WRu639kmw==
X-Received: by 2002:a05:6a00:3a12:b0:848:498b:e0d4 with SMTP id d2e1a72fcca58-84fde7d2ecemr24058514b3a.38.1786986349417;
        Mon, 17 Aug 2026 10:05:49 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:b812:4416:29f6:d8f2? ([2620:10d:c090:500::6:7969])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851b6ff08a8sm646693b3a.55.2026.08.17.10.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 10:05:49 -0700 (PDT)
Message-ID: <c9a394fec9b3857dc2ab9b13644247a5e38b3c9f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 7/7] selftests/bpf: verify zext_dst
 annotations for various instructions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Min-gyu Kim <gimm78064@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, 	memxor@gmail.com, iii@linux.ibm.com,
 info@starlabs.sg
Date: Mon, 17 Aug 2026 10:05:46 -0700
In-Reply-To: <CAGKGUvmh9puwO6BLME1sZq1QCdvMk-P1qsBcwB0PyDs+Dpa2Rw@mail.gmail.com>
References: <20260807-static-zext-v4-0-b6c270013c77@gmail.com>
	 <20260807-static-zext-v4-7-b6c270013c77@gmail.com>
	 <CAGKGUvmh9puwO6BLME1sZq1QCdvMk-P1qsBcwB0PyDs+Dpa2Rw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-17 at 20:11 +0900, Min-gyu Kim wrote:

...

> These results confirm that the merged v4 series prevents the s390x
> verifier/JIT zero-extension mismatch exercised by my reproducer. The same
> behavior is preserved in the tested current bpf-next master revision.
>=20
> For the v4 series, my test result is:
>=20
>   Tested-by: Min-gyu Kim <gimm78064@gmail.com>
>=20
> Thank you for your time.

Great, thank you for testing.

...
