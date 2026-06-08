Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E883563E1
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 20:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948909; cv=none; b=prE168pkCGyX8Ld/xMKyZRZsF3pX0Zr+EOzoq+YUYtINpWnU4zjsavXP6iqPGSIfx+C7t8fqYzp3Vklt5sV3yJlmKJpv4ff7jmP4RvFlzw2trrcJP+DROWezAdXV5P3+glC4nnyvqIfGtN1QyOftNWHhTJ3MyAcGdhzMTqdt43k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948909; c=relaxed/simple;
	bh=TXnwBHRGekJNCNs6l6QYmnGYpiNGy3SB2AnSS2LrOcw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u9JtjitqMsWgqOqY54kMGar3n8OOistN49yuO31UHSwNG2ZrMxnGZBXo1nmYznnTbUmDkxriVVuA52FdCTO0lrMSpcTrp5yDvwHW1FW/zWmuflvCAxM2Vl/F8zzIDkOcHWMZOfBXrKIQkpvcIlmKWNJm8rqWaXm87o/8IWLTqsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZAWrj49; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZAWrj49"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-304d0ac5e3cso8532937eec.0
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 13:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780948907; x=1781553707; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TXnwBHRGekJNCNs6l6QYmnGYpiNGy3SB2AnSS2LrOcw=;
        b=eZAWrj49hX9Vepu8XP/+7VQF2hp1DhvY6a2SyjcSfGxiXmIhrOyVyLGBTC4+a95NOX
         dybKpvV2fygRL9pDl2uxIewFpkXphr1zQTomJ69RXdKRlwaZBLLdaCItNDXrsU9jM11H
         Sm+e+hqJks3aGhkRrgreGdILe5lCo4K1/5ZsmvBlLwy50MvJJqniyGsc9FBcWTUCpXH7
         qLF1Zs8qL5cwYt1RLNSVZwB43m8N9D/s60DvRf8EGS4pNb8i+PdRqNIdPviskJi+Y0pm
         mJq6HxdbBiSKrKRI9J+APV4KTJWG78qZbIpP9Y1IrjyPta8uA0QAJ17N4O9w30MuulKU
         1v/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780948907; x=1781553707;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TXnwBHRGekJNCNs6l6QYmnGYpiNGy3SB2AnSS2LrOcw=;
        b=U1vpz9vf8hZOD1REaTMqD/Nt3rqMk6KJgVV0gQR1+KStFJrOv5121aXiGiGEBaw/fz
         koiHU/sAN+pcCacyOXKlt2SG77JYXUGdytUExuY8qpaIg8YaQJXVhL0Moco8ADOBltZp
         sY3CWIGZy5diq4KhjHFeuSVgvmL4T6L/gfvlEdbroj8/FC/WZ6g8ecvepfr9aViGcUfu
         8WeEDP2IB9jelfUZVrB4AnmztTAw5EIsw+nWeh6OWG2E5dtypyo32fV+AiSW5v2njbgI
         XiM+Ea7dyCFyhNXOFrhGDFhUlDklfh7PLAcA2Pqh2rpCYymvHEUhiDtZd+ygaXdJXgFn
         u7PQ==
X-Forwarded-Encrypted: i=1; AFNElJ+W7XCIhTg4ZoV91f1l4XaqHmofGOuX81razqGoJA5fXHiokJe+9acI8uNThjaIrSOhrMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYr7CVwufT1DnxYNo8o4mFGri+lxxho7srqWQiPeYd5TsKm8GW
	tSM7GOAjGe6IFIvd6fSpFUwdOgWpoEnH4bEIhDbU/r7aqIJLUJ3CUfOu
X-Gm-Gg: Acq92OHNVzRFJ+GZDvu4e1xcRnwTkfJvaFi43N5TVxE3y5RpVcGSL3xHLn5MoaDZcze
	wiX6PA5ErwldvUsnxuL21YsEpyjV8hh5k6ju0qFP4hebngbwlO80AqlvPeNgUArSUrTB2cuoVP2
	S5jFTomeNKC2JN65HLjE64u1yTyMD60Myyhoqz/Us7ay2IDwiE3ryiG3h878XBEruqyxDUvvJn0
	ejISx5nKWnHHdazhq01WISFAZJ4S7ejbFcD6pBpOSLi0Sag4s0wTzDoji/Tz+5V5KIudXcUXyXg
	AdqVa/GliMK/KDxGN8ag/cMrot6xXAcDwsMJ60rw/tHt1CbnuaTLdL/ZbxbyJUsVKGIXtdTCs3f
	FutnFJy4hdDnJGtQjkc2IAn8dSDyfMVBQWCDA7qtbPh0XU/wdTwCvg0N3ak0k0BI5d4sfioV3Q2
	7l/Kt9zAz+um5CGT73jXvKVhVegQMF81GpOTQROAnoy9AgQau19PO7ql6wuYrbuB4EZGZxnwteG
	bTE5qqPGfMw4VzQ
X-Received: by 2002:a05:7300:534f:b0:304:d32e:65f9 with SMTP id 5a478bee46e88-3077aee8646mr9878346eec.6.1780948907037;
        Mon, 08 Jun 2026 13:01:47 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1875:35fb:3a7:e87f? ([2620:10d:c090:500::3:d25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3078c1ac378sm10521461eec.1.2026.06.08.13.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:01:46 -0700 (PDT)
Message-ID: <189a79443144cacf4a257f0627586f917d8d18a2.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: Validate BTF repeated field counts before
 expansion
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Moses <p@1g4.org>, martin.lau@linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com,
 bpf@vger.kernel.org
Cc: song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	houtao1@huawei.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 08 Jun 2026 13:01:44 -0700
In-Reply-To: <20260605234301.1109063-1-p@1g4.org>
References: <20260605234301.1109063-1-p@1g4.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-05 at 23:43 +0000, Paul Moses wrote:
> btf_parse_struct_metas() walks user-supplied BTF during BPF_BTF_LOAD,
> and btf_repeat_fields() expands repeatable fields from array elements
> into the fixed BTF_FIELDS_MAX scratch array used by btf_parse_fields().
>=20
> The remaining-capacity check performs the expanded field count calculatio=
n
> in u32. A malformed BTF can wrap that calculation, causing the check to
> pass even when the expanded field count exceeds the scratch array
> capacity. The following memcpy() can then write past the end of the
> array.
>=20
> Use checked addition and multiplication before copying repeated fields
> and reject impossible counts.
>=20
> Fixes: 797d73ee232d ("bpf: Check the remaining info_cnt before repeating =
btf fields")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Moses <p@1g4.org>
> ---

Regardless of the sibling email I sent, I think that this is a good
defensive practice to use check_{add,mul}_overflow() here.
Having said that, it would be nice to have a selftest in the patch-set.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
