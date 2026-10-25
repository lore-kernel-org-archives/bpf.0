Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792891468;
	b=5t36XPn/e1OQZZDB0AGT12Ngguh5PRBCkAPeaVPqW0yoeTzoSqvm7as3n0vuhpmHgkOp
	 g2rMwpMmUsg15btNyRZuuw8bMHNNOztwX8K5o3lt9ok7pceag2z3SY5Qj1I2my5UgBT3L
	 CYjp7BWFTc9t9wXC9ZOWQHtcZpES5hDkGS/gB5zZOfnSnN7GVjz3vBg4oFWHLNK/KIMoE
	 nnkRC+F9SVmjvkNIfzgOVReEBb71NsDTGo8R2yYS68MC+atdQQXX8G0VxTPmFfDtAO9q0
	 7GDuRbyFqWbDV5px/qX6BpjzpzTq2R26JEE0vuWwGIiZPwzFGPYGZzp7VxAEI1I59Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792891468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=kjk3HQ5pmnor69OHDVBXj3DXr5voHadCRcEdtt6RVdw=;
	b=YvrNE+ntjZ3H+XqXeJu+UD2rYt3+b3sx0ws220IJ2duXxPVXg7kFkg+GFd3DN2EllSm6
	 rQQjFk1yti55t09cEg8B8JQ4vI5YS8VY3huW2CSB+5Lc8MzzqzQZtPtvOlHVxbYQ7ZGwU
	 TsPEcDq2ZH59Sxzr+9nk7h6LmPlIQ7ap5s8XmmXzkFLJcl1khlIJZEGeMLu9b5d/1Fl+/
	 Oprj7mSofiqDDTCT+zeSYgaWVDQbwuQMKu5nxUtRJS5pTW9oJEgTaz2ch7s52wvnesDFN
	 P04s3/1Fa8WjdSFyh8v4HQnDGdZV8jszpsW/VTQsJ69hDNx08UVNGigAZZsE+YDowQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AWQO4Jsd;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BE5606A31B
	for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 01:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72BE5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AWQO4Jsd
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3acb512a7a0so1034342a91.1
        for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 18:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792891468; x=1793496268; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kjk3HQ5pmnor69OHDVBXj3DXr5voHadCRcEdtt6RVdw=;
        b=AWQO4Jsd2Ql0N6elr3cR8ndGEbNZjitxsMtIZw7liE1Y7QkZ7nAZa7OJ0RtJzxweTb
         V9Fd7anEavAkOZxEpnHNYcr4jKw3zEf5kJvPd3l6Tke7QeZQlQcX6UHMtkIjmxmVUR9l
         WmpFlt1PYviRXqGbxlsqGhphm7IeuIcyoBezLElVlIjcue29fV5OVeWIhnNAUfkG4Haz
         XFZsX00VhsxuUpPAXolWziXf5vmH282/H9kvqNiSRi3AEPzX/6j/m89crCx34YL50IMS
         qb4FAVNGxUl4zCOJ8WR0EY8cDb7fUPAYCDCL+8Eua2h+V72tpEX7smUIBmYv0lGx84hG
         3idQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792891468; x=1793496268;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kjk3HQ5pmnor69OHDVBXj3DXr5voHadCRcEdtt6RVdw=;
        b=NpCK2IaoSe52CHBbqMD17Z6n9qqr2zmCYmR9LmXxvzc+nsNkbUWjvphr7gWiwHhx1H
         eZTyHjyhfUxCSbKM+QFnyiY3oRBBRrQyhhQDvcQG7QCFVhmjsBg+NG+foj0i49r6PtYH
         UEaXrS6JjxVpWXl+ENzJiAvOQebOwxQPb54IEn9ePociQuu2m3h9q1t31YSb8Amz8MgZ
         ESo+x59ccBsBWa/Kiqpu5kjXknrELlvslIpG3tD6WCWBEsuh++f0wkzKKbMESHutZNH9
         vDlnU9qNFg2RJru12u4dv4JRdOSWf5sh4v7bxZmuNjX/jeasHlJacEV8/jX3vLZCCm0s
         DHWQ==
X-Forwarded-Encrypted: i=1; AKwUvBzIKPjDqV09GtynFUgLBRrMCyXHpd5nPQM4ex1NrHvOomeezgkPU9j+JuZ7Nm3cBZNdKJw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLpkEzUR8rnv2dXDQXyKNJH24Gjj5o58+iJ9TLCbjam9FbJYyrf
	cJZviCE7mMqY+wZPL/D6eDgKuLmaU4Ee7iLeYkLdm0o2INyPi8DoUukM
X-Gm-Gg: AYBFou3q/7NCWqjVhX5YEQsY9oDas/pVDg1qHYXLkhHUfrXs+FLOrJdiBDJ7PZLrRQt
	7HP40G7yZJBtn+6T0gIr7KcT3XsLoAqBbmwxdolJgSmiAJbrNwPlDUiz/nCnE0UQXbSIdxLm/Go
	cWUWua2nqGvUAlLQsA5NlQP5mvl49MloZtk4hiRm+mj+XywfXFzuWNj1mzqF5XWNjYOAuc+gmLz
	e27QKKFjXz3KhLzoPDx0FJrYzh8RAlgiTVQth7iSoXY9XdNJYOJ1afBJDrGrRGfEsgvMrCyUjpd
	DeE39PFcPNRUR0lfvy/QJMjtlMQX3CnodFG79qlB4f6RSW93LXsRL9KJs+o5u7PPUzXQOOhJhfM
	oMTT+qR4/2q8i3qANB2yA+l4yyhgo59CO7EUpB5MB+/qAGr0WTMNEPfnHiDgm0cpIfSmPp+7XJf
	e504F1vrE1RTai2GDdhr5M7tv5aIuxqKziuM92HvcTGNjk/JXH/6cPuiGC0skZWJIo9v7OOnBn/
	pnlo7d7+WOVtgMkJsN/cL8Cl6uFTaBFu6+XsVyL2+Sj2fkXbcTJXrMSvqgqp2eAMNAFUwU7/bEY
	aOJH0aT6X7yYkqZ6HUKNm146wDsE49tRaRxS9Fx/thif3Pkcwe4xu85b1/BW
X-Received: by 2002:a17:90a:d010:b0:3ab:189b:6980 with SMTP id 98e67ed59e1d1-3adeae6caf4mr3034108a91.39.1792891467732;
        Sat, 24 Oct 2026 18:24:27 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebe6af0dsm4014945a91.5.2026.10.24.18.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2026 18:24:27 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 25 Oct 2026 01:24:26 +0000
Message-Id: <DMDIZDAS0MXY.3SBEZOHWHM0V8@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Wang Yibo" <szwyb123@gmail.com>, <bpf@vger.kernel.org>
Cc: "Andrii Nakryiko" <andrii@kernel.org>
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: name the failing
 registration in bpf_testmod_init
In-Reply-To: <20261022080500.100-3-szwyb123@gmail.com>
References: <20261022080500.100-1-szwyb123@gmail.com> <20261022080500.100-3-szwyb123@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Oct 21, 2026 at 05:07 PM Wang Yibo <szwyb123@gmail.com> wrote:
> +#define TRY(expr)							\
> +	do {								\
> +		ret = (expr);						\
> +		if (ret < 0) {						\
> +			pr_err("%s: %s failed, ret %d\n",		\
> +			       __func__, #expr, ret);			\
> +			return ret;					\
> +		}							\
> +	} while (0)

pls no macros with hidden 'return'.

I also don't feel that the whole thing (patch 1 and the rest) is necessary.

pw-bot: cr
