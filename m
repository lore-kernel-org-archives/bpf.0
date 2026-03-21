Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC5628CF4A
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 00:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774053613; cv=none; b=FnJ3Zf0WF6xFA63QedmlaKX9mZOk3wG0eyHSfGkbBYe0CvGXtYL+pL+3cvMOtKKViET3kl70r/AeKP7J/KEmEqvGH9GEEBuYKP5cBB8/+s5UYj+wpdedcRoPufexPl3ujE8+cwbz1NwabhgweGFkftZTVvUL9+ylxuVQ4tBp4B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774053613; c=relaxed/simple;
	bh=MPzkA4rnkkQCuqpXpfd6+oMKFrOoPRYNMbYm4l8qyeQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ou4BWRaz8mTiZC7Nn+dXA3Uwi6/4H9dsgqZzaUsoJKHBnSJMMIVUEGbn/tlT0Xn5c2653oHF5nHyPZnvtGKDGshxKBDF0LV8w1xmmm5Mg2MbhXuV8TIB641VypPB55FD5cN+U/uprhI/iS9ruNk9a1wgaA5QsxK9DTjz2MuXzVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTtTFSRG; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTtTFSRG"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64eaf8aa893so770637d50.3
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 17:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774053611; x=1774658411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/PwzGRNcB1I/BsMsmiZ9vrYb18/9jvWIWVEOY/l1EY=;
        b=cTtTFSRGIIuDpUw8X/gx7Zqdjnqud6KXEz2MXf1xYtKtH0U8Xzw+H3bQTPGl3OZ/s6
         JBOUnohtef3UJuFpkYTODHHhTGWljjLFp2lmKV8itbhsOo9F4dLDUWgP13kg63WlXoHZ
         2n3TpTIdr+ufTAArB0xDHu+0AM9Y/pTrssXZNaZWdx7a8bgjEPcm+BVmJNto6DD3z7bV
         Gj0elr+31lxSc4rokDflltxzTFERDF48EI1lDQs1BMXonXIx+cebKmo6yJf2ya/TZEBI
         FpQHorTZI5oU+Xac/pj8XJa7icZRAIA5hWa5B9wQh017dOzBQx88SSq/ih8K/eu73Xb8
         5tAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774053611; x=1774658411;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P/PwzGRNcB1I/BsMsmiZ9vrYb18/9jvWIWVEOY/l1EY=;
        b=O9guMcbkazSG4Hdej4DuCYVJNzratOOYk/IASP7YGl+SXuwM/p0i7RV+9sI2lqeT/L
         kKeio6dTHItTMBu0oPLkthOXCjzD/4fpMb27GRnhBVXAFCn01++5Soq5P16nBgb+0Hbk
         +cKpGjnO3FiVfLJCKWCr97SzEZaKsco4sIPVQiB60AkDqJyJlgofD/UUnr8e7b6N7XZO
         R8we3CcCRt8umzzYuyCJXH7Cj7wbOVUFOgBwwoDnqUhro49ysMh2BOKUCJKpdbsmgOFc
         YLwz4klejHU5hokk4f/XSnHQVdgH+8G/GnxxYTtd136jVuLRr6MdmoPiEkRNFeqmzGjJ
         CF0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW5t73dZS/URhI45yzoi19d/eBKMGJuxeaz3wX7NbzsbUm2JTvyLc581OQdEl3rxZTwnO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2ED1WD5LHjboMTR/Yf/O15hFAChtMiZW2N6qmZUlh1YVjh8nW
	xLVpd4pHFfq9cIi1dnfl+8j0594WFXyMOUCoiIh5X4H4LZuATLu5zQ3d
X-Gm-Gg: ATEYQzxbps+J9rxJZjDcCyBCkNdci1KI/3DgzakAs7eASJ4TpXfUWvqR2HhIlZfZCxO
	aLkW9hC+bH5BzCXWdrVjsIVHISYLYAm5mrIwoBQ9py6Xg/uDNqAxR4ZBEb2lvpe4/qycwGpmH26
	Aa9fQ2fJT3D7m27GgAdUYx/ZuXPMEqDUWT/FxiWOSFLWnRqnmSXuZEY9LNY3eI1uwaJBQUMxZ9S
	nrborsOn1W/H7AOCaVtSsH81lzjwbM/93zDuU96hfKRVwf6xguaqa2f95gSqXWQ5vlRduSA41MT
	0FG4bQ5K+LZF2Hx3/UOm+jEomwyJb6bkD3UJp/hbP7ksdOfmAbjM6CFhjGChPZnQH/Q28DjLd1J
	19/Y4ofnaINjnfgyQT0hjqKeNF2DidXJVenaRyGd+HOgpXE5AW5hmU7lTmW0sFUm/K1A14j9fVP
	1Ks+xrrH4fSvA/MRn6I/l6ccLX6fz5xB5j0JHCe8+VPSI39IAc+tbJHp/VAc2SW/bO624g1Cvu1
	5QdjXU5QWkO4YI=
X-Received: by 2002:a05:690e:1b56:b0:64c:aab6:65ad with SMTP id 956f58d0204a3-64eaa77f16dmr4156431d50.40.1774053611236;
        Fri, 20 Mar 2026 17:40:11 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64eabea0166sm2590013d50.15.2026.03.20.17.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 17:40:10 -0700 (PDT)
Date: Fri, 20 Mar 2026 20:40:10 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Nick Hudson <nhudson@akamai.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Nick Hudson <nhudson@akamai.com>, 
 Max Tottenham <mtottenh@akamai.com>, 
 Anna Glasgall <aglasgal@akamai.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.14fe1e8b715a8@gmail.com>
In-Reply-To: <20260318134242.2725749-5-nhudson@akamai.com>
References: <20260318134242.2725749-1-nhudson@akamai.com>
 <20260318134242.2725749-5-nhudson@akamai.com>
Subject: Re: [PATCH v2 4/5] bpf: allow new DECAP flags and add guard rails
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
> Add checks to require shrink-only decap, reject conflicting decap flag
> combinations, and verify removed length is sufficient for claimed header
> decapsulation.
> 
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
