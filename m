Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377E338947E
	for <bpf@vger.kernel.org>; Mon,  4 May 2026 17:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777914882; cv=none; b=nP1mW4RYPa8OVMXmWnx2dIEcnILC6CVzsmPR+OBm/03+P2gYu92olNrsyaRkxFY0YhSPNgmnvLVbty076XlDsWLJs0slLFLlPxEY/xFYR+6G6CdiXRV7wc1e8XHKGtGYXwL6knZPzdnOPJ9M3O5tImMnWPvxm4ldEUKr8lTl8L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777914882; c=relaxed/simple;
	bh=gGhv5aBvag8GkJJw8oK+HvN5ptj86XyPHMattSfFigo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=oog+00XJEhvjrFRL3/i/pMdaE3leEjBKGHjvw3wcf2RLmyY8Mr7/66kWrDBLUgj8lQMlXtQ8oO+OuaO3pAI96GpOenAbE3SMzeS9oXx6Nx83p6G6Fqf0Bry2EQ83TblOvUsS0YDJzgQipNMs0b9p0xLzGChkgVKbx60gd6CuRwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DI14WPC2; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DI14WPC2"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-65c477a3278so1836759d50.3
        for <bpf@vger.kernel.org>; Mon, 04 May 2026 10:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777914880; x=1778519680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ar9A5QrYRWGb5NIZabW3eNiZEMmSWnS35Z/zWd2ipnM=;
        b=DI14WPC2wnkewoRYZry85ZxY+ipIWLtEYITEHtf283ICw1sHSz3p/TiAqWEXJDd59F
         /BhFrabnLgIRwRsEmPg4w6tF60HHxKOpXn82PQ+ss1hJSzIvXqpzBdFm5OU6Uz1l2YQi
         QAXnA9fub1TVdUMGE+oEisUTVDJ0xN4l4FNWAZjTypSEXEv1NjUZltedFZZdmkq9slzm
         tZhIPCmy/sT2X942gaoVGepvErELv7KhVzXD7/B1SrE/85pIbGaN8NVlZB9ws2IEKQxj
         OJhLxh1b+1gT/KcdiSfNv++109GpFnseMArG4WZMiZSAL5129FaCx7QQLJ2oyCnUt03/
         zvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777914880; x=1778519680;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ar9A5QrYRWGb5NIZabW3eNiZEMmSWnS35Z/zWd2ipnM=;
        b=rV7fvWvvvS8peKP9BBs/5iK2gxWNbYDZWrt+UT0rQIJKvDhtO/BPW1eHHg4GPAddtk
         snhO8O+sAwZHQQHzW8TZA7PBHs3tKuYBDbbmnR9LeqeRnrGTWLYMlwqWUGD9vItQ//S0
         G5TK5db9c5XHlu8xRcOIwkNXtIGPPUKET0WqLOWSctk+pmdLylZi14PFG/lYW0Q8PTCu
         I60d5tTv/uUb3e1f+Np0+4oAmhMbvFeBcNt8hEi4WVraZ7BYCiw26ZnELrHUGiTRPT/O
         4flXcr4wMbV6205MGsJlIieeWtzpZ+62rX4xz4UhNdopGjJRVezn0w6HNwYSOedPbyja
         +HVQ==
X-Forwarded-Encrypted: i=1; AFNElJ/XcnJoalft4xzQhvGaHUBCr9jgOUvIOzdSwCGgm0jae23PW/vRoHykVfceh7f5XxDXyBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2nLYeQHobDZ3xplPCwyJ8kVus8iECRtRu0LfIL+ixmtEWL3tt
	YbwKB60SR5/L033KzYBoCoFPPw/bbxwpacI7kBU6X2nWWnYb5xKeRLIc
X-Gm-Gg: AeBDieus2Ny1SBtkcWU7S8lVHEurui5jpqRotL/09QAbFWlanaJj6A6NSVgnsWWtTfE
	IiOhiN83/HsuF7XAACH0qnRv0Hn6pTUB1tIhsJeKCwFbmHbtxqA7atBabGBDILPLPcvU+H5FQ5k
	FNklobmMV6vhiV+EXAb1/H4P7M/cJQ7mB6y68pedExQXzK+BnQ3jRJBFCBPJUbdzvXzhvgfRZKQ
	kLipd/m6YIuTZD1REEYuZCIQjkX+1IXWX9qgVXTk4oWbgvzFJeDUb4NxMSECU+t+iw262Z6aCZ8
	70gd+uroaPskI7Dqvn2ulTFgKdbX+DvRYxIV7F5iGYwruxL/IiQkMUwP3BFF5qt26bnrq9ST+Yx
	2e8zqAxz9TBVur7llw/faqIiD3CZp0XgTFj/U0llTKFPoC5d79CWMbWXSOS5R8ueY3ckuvS5AVw
	JEtAXbJsl8anhAOtfaZtg0CCoWM1Mx2xy+cD8bmwPNDZC2t+hjUaIaJLmNU7tSWfgWkLI61pOYL
	NeE3ZWpsz3TCdhSmx+en2qqQw==
X-Received: by 2002:a05:690e:d41:b0:651:b13e:f9ef with SMTP id 956f58d0204a3-65c3d9a2bb6mr9826363d50.14.1777914880194;
        Mon, 04 May 2026 10:14:40 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65c2e1bb5adsm5751702d50.7.2026.05.04.10.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 10:14:39 -0700 (PDT)
Date: Mon, 04 May 2026 13:14:39 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Nick Hudson <nhudson@akamai.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nick Hudson <nhudson@akamai.com>, 
 Max Tottenham <mtottenh@akamai.com>, 
 Anna Glasgall <aglasgal@akamai.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.3bdd02f2dd7c@gmail.com>
In-Reply-To: <20260504101759.3319427-3-nhudson@akamai.com>
References: <20260504101759.3319427-1-nhudson@akamai.com>
 <20260504101759.3319427-3-nhudson@akamai.com>
Subject: Re: [PATCH v6 2/6] bpf: refactor masks for ADJ_ROOM flags and encap
 validation
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Nick Hudson wrote:
> Refactor the helper masks for bpf_skb_adjust_room() flags to simplify
> validation logic and introduce:
> 
> - BPF_F_ADJ_ROOM_ENCAP_MASK
> - BPF_F_ADJ_ROOM_DECAP_MASK
> 
> Refactor existing validation checks in bpf_skb_net_shrink()
> and bpf_skb_adjust_room() to use the new masks (no behavior change).
> 
> This is in preparation for supporting the new decap flags.
> 
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
