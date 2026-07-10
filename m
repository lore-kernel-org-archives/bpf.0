Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9942370D6C
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 06:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783664040; cv=none; b=D7jM5FcR4bcH0REuyubpN1faL1KtfW5XowdEEGQbzBqtLmK0CJptTMaG7om7Z3wIFXvrhIHAur4PN2GwKSQ6neQPF6Yk6aVbfA8ay1MZMhf9qekgXQ9a2Us1JGKed8kaLh0kmlJakXQM7nLfVHJNhI1Rq1bXvUAMiUW6xEO5o0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783664040; c=relaxed/simple;
	bh=/1vSScoZMhzWwOgDlowE6Tvo3DJduGEKGOtEEMsqrJw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lu7U4u5rJER+gLaeskCIgB0yAaHrnX6/efbmE3MG4eM9BeWbWkyrRX5iK/S8gKDep7ViJ4mhk0qtsuV26JRLF0NW5IVdphA79FaDX9CC/9d9eAVVjL61RnkMpbkwrTqF8yudwLUFGdXXRYwA+eom4xNRmwCbvQAko59ekGDmo+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+aYeQBT; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+aYeQBT"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c7c61b5292so9023225ad.0
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 23:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783664038; x=1784268838; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/1vSScoZMhzWwOgDlowE6Tvo3DJduGEKGOtEEMsqrJw=;
        b=f+aYeQBTtPDLvRogHSzTW2d7ZZmx6ePSKBrt3JZXTbFvTo7TfTLMqhRdxAo0ADIX2S
         7uL4NATCJXtxxW50+YJKbqbjzJRNk7Zs/JhVVZNdnWlPDwOtJiMDOBFZOE9fvDW5jH3P
         3yKUrlwv3JDg4Pe0RVF/WhVkAsc7ug/4s4TmT2bvn4qrxEFbu2LHzFqfSkt7/H6sJm+6
         efA4W9pV4xeZsUvDmJUTGGKvQjvn/SHO5St3pf4VGQXaBTxmgR9ZgHF6A3GowU+FexKx
         0RR2aeV9Lrt6uuLIdIN7SctwJk98F/mLj9uWGxmw9DCQO3i9kdR3w495u2AB2seoBiae
         1JjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783664038; x=1784268838;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/1vSScoZMhzWwOgDlowE6Tvo3DJduGEKGOtEEMsqrJw=;
        b=dJX2sBjUb0nbQWGAugrQuzZV2ajnFc4Q06WF8e2VOKzpLCqe+w3ehG1Kp3Uwq1Nwc0
         eX4AOsMfH09Csqw1lOvWiDIbc/65rX7BS0Q8mLnIu5auL0uUzYWLYsdRN8FIU/HY68k0
         NgD9xCyrqKcyPPk/PZcL5YN2+7pwyfttYZTitQn9eP/Hh/0Z09ticQAjDUhZ2TsfFZYh
         BCqtL33Ej6nEFk9rbtAjRtcfXz4uhG+g+IkE25uf1ueSiJQOowyOzXgpMW7nHJAMoMkF
         y1jNVqfcpFG+X5ap83ETlv5QCiQ8CId1FHdq+akXDRmY0Cshx1/b9ANG6ab6Qxwimxmb
         71Eg==
X-Forwarded-Encrypted: i=1; AHgh+RqLqdfLKtEL7kqVAXpTiIdLeQt/Qv4JptpnUeuRKeutLUyxma0ZppWx04QJBLcdjypV5N8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIxMkGNAxMbp+5GHMuiWa4iJSvHfNtZnrE/zDZWipu8lS7cRgw
	Xil/J9fFZNBdP/JZlSSE3dWf5V12v9BLwW56W0sVpWzvKzmb7xLQYJ1f
X-Gm-Gg: AfdE7cn5Iu1C59iBeuYmJXvwBMAq0Y7W1yVOJaIFnn2fjJPe7LNpS+YVOnBCtuw7yJm
	Wc6OohpA8piTUcgd35YArsnkC+O7uwym4fHhDSyNKn8dP1SdiaxSMijW6bMcbX4Q34QFOZ+7foC
	Hg7E9bVIDM8idFCUZjgTKonHiUVTGqw0/RHHVmF0Y5fkwSlIQu3cYZMbVNbzgMpkWKR/AzIr9N4
	YlGQiQ8u6FTvzN5HP1kpf7D+HKqdNAoseTgMd7lhgDS0nIHFUW3GaRs9cUW4xmfe9vBEtHePqDa
	TqX/iPa8y24Q0Y7bjn+4mv03kNGoqf7z4UHtlBjs96gFEscOKkYZQk8qY1cEmbdDhDxSiRsks0J
	cFe2LF3UwTHOI9MIBtnpyixIhqISD7vxQr13ui3mkEsh24KV5zRPNwZEHh4hflXGTBf2HE5YnNV
	QG/fMmevBfdcRUlhuf/n2xTmICq0jUz8eUa1TRyuEf
X-Received: by 2002:a17:903:1b0f:b0:2c9:c95e:5836 with SMTP id d9443c01a7336-2ccea2a5748mr105802515ad.5.1783664038094;
        Thu, 09 Jul 2026 23:13:58 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf92bfsm54539305ad.28.2026.07.09.23.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 23:13:57 -0700 (PDT)
Message-ID: <531d227058b25adf099dbeb467d32507b95d8062.camel@gmail.com>
Subject: Re: [PATCH bpf-next 00/12] bpf: Support 16-byte return values in
 the R0:R2 register pair
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Thu, 09 Jul 2026 23:13:55 -0700
In-Reply-To: <29c790dc-2e14-4ffe-8231-db8dba4de0c1@linux.dev>
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
	 <b364ef0ad5425d97180220af23be238a4c4281d7.camel@gmail.com>
	 <29c790dc-2e14-4ffe-8231-db8dba4de0c1@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-07-09 at 23:00 -0700, Yonghong Song wrote:
>=20
>=20
> On 7/9/26 5:56 PM, Eduard Zingerman wrote:
> > > On Wed, 2026-07-08 at 13:09 -0700, Yonghong Song wrote:
> > A design question regarding to how this series handles local
> > functions:
> > - It relies on the BTF gate to decide if function returns multiple valu=
es.
> > - It also prohibits local functions from returning pointers as a part
> > =C2=A0=C2=A0 of an aggregate return.
> >=20
> > I think this unnecessarily adds an additional discrepancy between how
> > the return values are handled. The practical experience shows that
> > existing differences between local and global functions are already a
> > constant source of pain and confusion.
> >=20
> > I'd also argue that lifting the above limitations for local functions
> > would make the implementation somewhat simpler.
> >=20
> > Therefore, I suggest to:
> > - forgo the BTF check for local functions;
> > - always copy r2 from callee to caller at EXIT
>=20
> Not sure about this. If r2 is always copied from callee to caller, and
> interpreter still only supports return r0, then this will imply interpret=
er
> will never be used? I know interpreter will be eventually removed, but
> at this point, people still use interpreter?

We can detect this statically from compute_live_registers().
If any r2's are alive after a function call the jit_required flag can be se=
t.

> > - forgo the scalar struct requirement for local function
> > =C2=A0=C2=A0 return types.
>=20
> I think this is doable.
>=20
> >=20
> > Wdyt?
