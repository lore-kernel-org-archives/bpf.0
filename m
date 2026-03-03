Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AB6366577
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 17:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772560288; cv=none; b=lCdlFZBc+x+lpJCKdrYhmcLCWliECDej5CtF5BhTCdG0I35jReh2wsgg8+DygJeznTsbtHvcsCv5OtN9qjVP9L5KnPDbCbF2ojjHHBwDpBFDcuHKEAAqTLR0SlA18TH1esaSFZrHUk/qQTctbUD0lsr5rp+CMl3PL7iQQ27yfj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772560288; c=relaxed/simple;
	bh=wa0DDvSpgqzIR7XKe12gUqcapLKvD1q6/6H749AX3KE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tFuHqOLmVO51wQdYmkkzLflwhXNB1a6zCv9jdvRXnsIQX2O4ThRNFBagkGt3+cgrzMrIYVTBv0lxxS8PDeoC2gd2AbxqxpP4lm6FawKUQLEhYLMOXs/dSd/rIpFBmCR4rth3iAZQDmn+N121YXY/V2rjo5OwBQYZXqlQwuC71iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQPIbDlo; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQPIbDlo"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12758ce1e8dso2500435c88.0
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 09:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772560286; x=1773165086; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hb+ZQQYUSH9P5SPHIhEBmU22f+nTIRnQal4xAi93UAg=;
        b=TQPIbDloSwxJTsNok802IiSMQZIEPmpqA9AydhG9AddDgaOjyUqTcAnMpu8y2sNlft
         ncno4bGidlxtTBVE+Xk4VzmoFQ3H6T0QPLOHE3CvlUlrJUHYV2KfwEGrZ7/38awiuUpD
         ZNkfh1TGR5kRAPhiNimZrjha5WOLvUa/ggL9RwlH/05LNiCHPA8ZNKL6lzDZebYafOng
         CQuxSZ1b6stv9t+app9hkXd4LC/hBHuxOQKdAHoyxjD4WhbWVq9i8ibCnhi9XgIua5Ls
         MSuLzLrRw5iWWcfh2SWiQfNq1UtTUGA3DvfYvw+DTUzmyyV0XoCMp2GKs7yQeJYY0ezn
         neuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772560286; x=1773165086;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hb+ZQQYUSH9P5SPHIhEBmU22f+nTIRnQal4xAi93UAg=;
        b=H81BeyKPEXvZYmkfGayJUwH5xSMHgh0MRcIFq1n3pK0Ev9ug0rKW2oGTY7AlHT1rHy
         xA2IYX2WyNEdaNjsONMbr+DBVpVhmk0Yfxap8nZ5YGhP40esG6sVQySNTE1CsFltPl+b
         VzWJT2SgKcnz+EzvzsofEwKi5ggPzOxcQziMQgdC2aFBGeL74Rr1/PjQsdjnfgu/BowX
         VRo1oKRBt+9tVsZ39ltJ5Ft+/JL48mOje35Z4MM0uS0SNPBXj6ENO3DGCBYaaSVgyF4v
         /e5WHiH09AedlA2jPq3YxNJPsKBP8SahTkVy1fa6OwGE98uDctru7NcRnidnGxJJVPso
         KJlg==
X-Forwarded-Encrypted: i=1; AJvYcCUtGfkHin8kdmNr3u1DoBNtDTa+M46nLJqipEEnsJfv6wbnmnjFl/v6gk2dAIWWNxOfr7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg2OXBtLB3kpO02tFaSjMPEwpz5RLJNsTOEcoxG7Vlzdm5tPX0
	9QVEjs54sZyYXGvw957NfUQH8O2VQW1YoxJt23iJNmF9shJ1UvprJIhg
X-Gm-Gg: ATEYQzyVO3cagc2jzP7gkkHODOhSvKAxHHaBtuoq+qOAra52wWU/5gBfxtM4Z0zcdWZ
	90GskVrucd9Rf38ryuQxNqOE0yoPlVhbxuCz/oLnziYL5l4THPZMpayaTLtGOv9KjvLVVytUG1Y
	SHYtn/nBV9XdnTzaCz+Pihj+KZQqRH0NaJB6h/YAUYCxi5AcW0h0Jg2pml9fz/vHyo2xaLpJ68Q
	ZRzgSjqsMsMU8AIGE7NhQ/4QAh84mFqjXlNAysMU6aYstnDY5FZw6buX3dRxOJ97LV1bUl/LR38
	kV5CqPggvFhtr5QxdjXkaFZ+hdEc78eXa39F53cEom3n79z27mHNPnqmU/gC9kyjQoGoAFp4u0m
	2nBiRw4ifKORnHmbShaA2dLBXGkCqiiM2ZgJpmttUspg7Zg1arFm7pefXMlvQ7xillttjoxPaeP
	KO3BlrMjn3T5JeYyADNSfgz4pL8NaL4d4R+G8rI7FniB2Q/u6tHWr0Up9+lof/rDGf+PPYWcdqa
	jD0MFc+
X-Received: by 2002:a05:7022:128b:b0:123:331d:bdbb with SMTP id a92af1059eb24-1278fd44a68mr7424202c88.22.1772560286416;
        Tue, 03 Mar 2026 09:51:26 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:bf8e:1331:ef2b:145d? ([2620:10d:c090:500::3:4473])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be249ed6a4sm1423352eec.11.2026.03.03.09.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 09:51:25 -0800 (PST)
Message-ID: <d1ae1d1458f5b49f4c05d6aa5d04a5a1fbed8a55.camel@gmail.com>
Subject: Re: [PATCH 1/2] bpf: detect non null pointer with register operand
 in JEQ/JNE.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
Cc: David Faust <david.faust@oracle.com>, Jose Marchesi
	 <jose.marchesi@oracle.com>, Elena Zannoni <elena.zannoni@oracle.com>
Date: Tue, 03 Mar 2026 09:51:24 -0800
In-Reply-To: <20260302161736.156685-2-cupertino.miranda@oracle.com>
References: <20260302161736.156685-1-cupertino.miranda@oracle.com>
	 <20260302161736.156685-2-cupertino.miranda@oracle.com>
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
> This patch adds support to validate a pointer as not null when its
> value is compared to a register which the verifiers knows to be null.
> Initial pattern only verifies against an immediate operand.
>=20
> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> Cc: David Faust  <david.faust@oracle.com>
> Cc: Jose Marchesi  <jose.marchesi@oracle.com>
> Cc: Elena Zannoni  <elena.zannoni@oracle.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
