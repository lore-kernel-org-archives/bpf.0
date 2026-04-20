Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972FC3CB2FE
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 19:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776714321; cv=none; b=Wpg2uxv6/gcUBTnWBbesa7XH5+NE0d9qs80YgOemBbEvpZqyYsV73OpRn8IQE3YDJaCNq+iZe0DqMWsFlaLJBO+nCroKTS+MkN1L/bfFDj/25rgLZQsYU+VA6gwZqFaY4fP4i5LIi0JGkTg0fyviqr1/JDfJ1/DzHZblsSCrGfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776714321; c=relaxed/simple;
	bh=MPzkA4rnkkQCuqpXpfd6+oMKFrOoPRYNMbYm4l8qyeQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=b2Zh2WzEUKf9zusmIMQ4RkgsO8Ywuij7e6l7j0rOWTOWwJcZ1Mvegx9mBJQ46gDtU4GJB75Lv94LlPz6J5ZLw+vgcGsONn/8NO70GzQFu3CVUCh3zykR16hBJZa4pq4SPkiavq6gPjxtKglsTNR+TW7gBT1ScbBR70Tyq3xDaKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4sxpCKM; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4sxpCKM"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7b186dfc1d0so49057877b3.1
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 12:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776714320; x=1777319120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/PwzGRNcB1I/BsMsmiZ9vrYb18/9jvWIWVEOY/l1EY=;
        b=K4sxpCKMNDsg6x3v8IfBU1nV8n5/+TPYf2qxk7GXqCNLGCgqdILEe5cXtgccPZa8c1
         LGAhcF+dpvLWVWc3krMTdKMo5KOt/+DKa3eeFMq7rO9W06uGINA85UVULPlldrKZ0eD1
         D/OCiggRDTPtUWzssx2Kv7AccjR0kkN4L/vT/wVBzmmFo6weOECUubNRBE6D+Pj1uZEd
         HobOiak06Gvl7g+XRXoiLfk90/AWccPQIAt2M/fylfYeirwarfuchF9UJbC0qiuzUDaL
         vbkgWncfh2dvEf3ZtojDCk5jwX8VQw8xD7ofvAUGv38FEChKqN9h87pD4SyOG/uh7P+y
         RdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776714320; x=1777319120;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P/PwzGRNcB1I/BsMsmiZ9vrYb18/9jvWIWVEOY/l1EY=;
        b=WhzPkTR7UWeE5k799nDLUo6DXWJ8W2EnNcEMqw1Vz1gwdZvRpZiDrKOHXv/INaHfng
         fSShpfZvXw30n7zfDmpUof+QgzkuLcqxiytXaORu7CJC2huoTdwVoz1Bsh3bom7jHhf7
         xidG6C1nxb/Kar5yu+PBu392jQ31LoKzTyGjtYxQFuCgu2xmviMs3ER1LFppJZg6adBf
         M2vltuq3CPcOTVifY4QwQU1FR8Im1os2jaeZ7KPnWpZ8mdkEKSCNwSN3HeVxgFmOzElf
         Atk09k3IwKu6Nf6UY7f2cniFW3i02ytnHG1Wjjs6kpzp6LwAWxenpfcsNIdmdslcEkO1
         ttZQ==
X-Forwarded-Encrypted: i=1; AFNElJ9+fW63enxnz9u3GYMIN5OM1fs0NXHacIaExOw/YhRK2wVjqy5dnvbWji10aGprgrVFl6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws12H1qNhHTfSLYdSNGIqJ1uTinL0GrC6ZzgpZILEzGHXOEioI
	kPmDmieouMA/Hz86gJQ1bKbbs/CeuqvkOfnZCDl1JnTfhIqSPvzVrqjH
X-Gm-Gg: AeBDiesTJknE7joD0ZukjxLGbma7ABpSfLY1Ai87Hx3ds4GxZIHp6XyNslHKPVYHKhj
	HZI7djwkoweni81f8IesTeEPmt7FbDkIyzqcAM8XFlCZLMAqHJhVZFi0WR6xQBoP2Piz4RveH03
	C0VKJPj2FxfwrjD5+rVrpygtYAUYQIoJrJuL/2LNtgR4ILo4HVTNB41SIklm1qVyp4h/IpMF3LQ
	Ap9JrIIbUj+cG0SBuZiKf60asbIkfkZd2XSuE6yadCNG4J/xHgfpTVa1KT3MsMXOBdGyggg7C9X
	Fwaqao2l3C4AHg/ZipEbM0F7QAOGuPERGmNA6X0SvyzWlM1ep42LvrktTTCN1JXwYwYrZMotbST
	qUJfFrTla7Pa70y2M6QXzqDFOdhEQu77XxNb6HE6XQerdVQlCurwzs0xPYAOWpYEepAu2xiSOWU
	UBPCNWqfGCvEU1F/g5cNRC7IQ2OATONhC6hATpftX8NhvbzRWiHsWGqixjG/FHNwfRqtAJFq6i/
	zp3CnHAdUG18go=
X-Received: by 2002:a05:690c:c50e:b0:7b8:567e:d536 with SMTP id 00721157ae682-7b9ed29c6f1mr110198987b3.2.1776714319748;
        Mon, 20 Apr 2026 12:45:19 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee99bb09sm49116397b3.32.2026.04.20.12.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 12:45:18 -0700 (PDT)
Date: Mon, 20 Apr 2026 15:45:18 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Nick Hudson <nhudson@akamai.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nick Hudson <nhudson@akamai.com>, 
 Max Tottenham <mtottenh@akamai.com>, 
 Anna Glasgall <aglasgal@akamai.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1ccbc2a02f0bc@gmail.com>
In-Reply-To: <20260420104051.1528843-5-nhudson@akamai.com>
References: <20260420104051.1528843-1-nhudson@akamai.com>
 <20260420104051.1528843-5-nhudson@akamai.com>
Subject: Re: [PATCH v5 4/6] bpf: allow new DECAP flags and add guard rails
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
