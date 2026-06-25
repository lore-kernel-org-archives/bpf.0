Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EFD375F8E
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782405866; cv=none; b=cq4PO23J4WV4oJ3KuSWY2x6eHbIcEB5itjsI4d/ZhyQThgbcEiyCsN7Q391i5DjUsUwKM1IFifyfEza7ZRdeHHxrDbHkQ/bzdK9hu3DHVn6OxbfHlN3UUErvMZm36HdFqwexPwbvvaeeX0hXXkTPO0A47t/ST3CSewFlhLTI0Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782405866; c=relaxed/simple;
	bh=P2+ReacPCeqU/fKo9jBbrql6rfmKkcgJUzlpxwAN/o8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=a7rHnm0z+KNI+3qhWaxBKAzSuH6V3cQzoz5ZljNtGfqk67qS+EwqUUUfrgpT5ODNIScn8GKhBSsfqt/L4Rd94cvYe6jY7g576wN9p5kCdwQ79aZoofaoh0VUkvmsNgAVzk/FOajWyxaMDJQ/MTsUJMZVCJncRGhutRBpPB2f5q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMJMIzE6; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMJMIzE6"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6a0e4f0342aso8284eaf.3
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 09:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782405863; x=1783010663; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7W/ggTwnqmzWBnV2WV1SHqoLx9vAqZSkSoEPfkHk5g=;
        b=EMJMIzE6YZ9QJzbgGckgqJ4BcvpUQQv61rNrBh7KyGzS+927hCTboE4mKXsWuZpPwv
         yZs2FP+wZpxxmf7LMIduAZXhhj9SezF4VF4DXQPFZg369DINm2bK74N1FgmCHQq+ULkl
         qp+wXlYwzLgNlfO4TssOI9PbeSTqds5WFxxx9WBkrpPF/xw6HaFabsm10Lmu2hQ3jp72
         NlueDYdo9Czm17ifriUAc+FqLgdiUxI+tQQRyZkDodGl9JDKHbLmcrOBeB5fO2LHRGAQ
         iIKtd8/u4CD1NEKyRAX61Jd2d7mYv6egWzzHD9qDe53TPjClS13YhGUJQncRLmXp+a6N
         SfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782405863; x=1783010663;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t7W/ggTwnqmzWBnV2WV1SHqoLx9vAqZSkSoEPfkHk5g=;
        b=iDqBMJuKVUSkGIDxlB88FRsHbF3xVmrhnPE76fCeIi4AsB+xZRpO4kSXsQFvxRQTQM
         +DiZvP9ZcfEa4MjuSuuyzuGDrtifGae1dSEoqaYdWl1OLjhgOQd4YkRrzynbdW+GizAR
         Gq1rOZhooZq4L/P6NzEDL6Q/Mr3zIAdgM5lFEZig4JyOUfMqv01AWVKV8UMTIM5yRiG4
         C3muSy7sbVXmwUOjZJVXEulMd4pL5DpIYdHrqO2nPfMTvE0Z1VONpsBCctdYoameowQF
         hDgxpLiKDHK53BicvDtWnHcFSiZoCJkovEEH2Rr2FHjIhByNzP+LKu8vD59Pr1lKUD0P
         k6Sg==
X-Forwarded-Encrypted: i=1; AFNElJ/a5pokbCzrePKCg9IVNdU51h36b0h1Z8WZn95gug4Qn9RXYRir2cgI/hQDpbI2jjlbJiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFcqUI6Ne7mBAjXyrkE8qOlANIWVDjrG0x2WLPOKuZr6WcexsZ
	XT7y4D80bkqc/OUVlwPT8gdRIELkUFoIbFwbj0Td5iS1Jci6nQKJgaJu
X-Gm-Gg: AfdE7cnnVsdLchQEhTMm9gkZ9PCT4h03rOhM4gQdrfVLupKAXjXGbbYAqX+j5HAHtgj
	LabjkwhVABsoBmziJNvnk6Aen5KblJNlRDC2Tj1wd6F0WMXUtfcEzm75G0+IlSxGMOk3Y/23tYG
	nEIL1cilN4WP6po1hk10EcfOXvkCsAJ8Yf8isLvdHvQtcpnQXimCMhFigpL31/XwRq4jGK89D1T
	s4I0CQ+bra0/lwejuWtxn8rqRlZ5ZojEvR8tcGrUnuH3IuNyoGqo7CbymQ61w1t6yRDhN/X7mnF
	6h65GtyF2AmkG6dKVpZY1uy06W3yZDAHZHkkfCZMlsGn7aTRjgvJC2rF+dMV0gD1hD/1S0i7gET
	aJPZUOya9MVcG46w/5pEf5fy5UTVkOfPJ+jFRAaZ3EbAirDtF6GUeTXZY/E65ddA7nz2UhVuF2y
	fEXu7C88wbwbnzPaHgFyVYn8DMQ9IkUcucd3wiz8NyJQk1a8wAD3iyDrZMWaeQCm+FTopJyDoII
	FbjsIw+2Ra+LlzpRg==
X-Received: by 2002:a05:6820:814:b0:69e:ab0:3f4e with SMTP id 006d021491bc7-6a13522493amr2720037eaf.46.1782405863009;
        Thu, 25 Jun 2026 09:44:23 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:10::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a0ea0c378csm10370966eaf.10.2026.06.25.09.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 09:44:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Jun 2026 09:44:21 -0700
Message-Id: <DJIA58WBML8S.A897NKI06DV9@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jakub Kicinski" <kuba@kernel.org>, "Siddharth C"
 <siddharthcibi@icloud.com>
Cc: <ast@kernel.org>, <hawk@kernel.org>, <andrii@kernel.org>,
 <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 1/2] bpf: preserve rx_queue_index across XDP redirects
X-Mailer: aerc
References: <20260620121321.45227-1-siddharthcibi@icloud.com>
 <20260620121321.45227-2-siddharthcibi@icloud.com>
 <20260624185432.32d90aa8@kernel.org>
In-Reply-To: <20260624185432.32d90aa8@kernel.org>

On Wed Jun 24, 2026 at 6:54 PM PDT, Jakub Kicinski wrote:
> On Sat, 20 Jun 2026 12:13:13 +0000 Siddharth C wrote:
>> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
>> index 5e59ab896f05..8f2d7013620f 100644
>> --- a/kernel/bpf/cpumap.c
>> +++ b/kernel/bpf/cpumap.c
>> @@ -197,7 +197,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_m=
ap_entry *rcpu,
>> =20
>>  		rxq.dev =3D xdpf->dev_rx;
>>  		rxq.mem.type =3D xdpf->mem_type;
>> -		/* TODO: report queue_index to xdp_rxq_info */
>> +		rxq.queue_index =3D xdpf->rx_queue_index;
>
> Do you actually need this or you're just trying to address the TODO?

It's a 3rd if not 4th attempt from various "people" to address this TODO.
We should just remove this line instead.

