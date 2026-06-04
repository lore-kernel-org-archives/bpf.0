Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6631A3BBFD4
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 23:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780614965; cv=none; b=CWipb9c8VgY8dJ4hY4raDYSALZNj16gib/2LuYmNxhhgqpi2BQqcFt8Gtxv9QV9v0UwE/qpLAq0AVXlnN5BcqfW5V79/TzDyZ+w4coDcNa3XoJ9R5yanrXj7iAwM4qnXcwFSZ+Q7P+iHhA9dxlfPdUOuY95EFC8LDknZV/wuJVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780614965; c=relaxed/simple;
	bh=fWKSwmMJ5lkrGxj3ktHOoSj7S7W1R3k+j0rSCA1M+X0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EjbGntyEQiKEb7gs0JhIuS2Afc13NVgVq/VSV7RKqu+NLyi8gKPcTiwAZJkMv388Z6X23B8DVTELeb8cRvyMvYgE5fQ6d0fhi5iiofTWwSz9HLiwDHg0SksRKvUJg3bNlPiRQdisxgMwF/ExP+lYBx1hMJcBGyCX4UTfMow4sz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9HLeZFz; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9HLeZFz"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36babe2c4bdso864609a91.1
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 16:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780614964; x=1781219764; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fWKSwmMJ5lkrGxj3ktHOoSj7S7W1R3k+j0rSCA1M+X0=;
        b=j9HLeZFzTnakEYid8CsgKBoGNJoYeehe4u347ZVqIauAyH/dcPOQx+u+yZbT6U6sy+
         Rn2HO0Nbr5GCGVm5CExbc1Mt690tWpkPGnR/+ZdqhZZHY1xxujdOiywUY9SneWUt1IhL
         Hgh/UCWV8v0T/VkTFuJs8zQD/EsYzqygCoYTQPpykkPDsOoMSOJUhMzMy/ACVUhghKu5
         1dRweCteKHZ8yh3PQNFzB9ppRiMJCwn9sI0+E8dQMLK5YYI6Y8Xdupugo3bRMS9kgGev
         JmD6ioSSpVemfI1rcAObG6HSf0mQHYD17j6ePaMms0dF8NWbq+T8RozZgwSxokzBTpzC
         oW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780614964; x=1781219764;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fWKSwmMJ5lkrGxj3ktHOoSj7S7W1R3k+j0rSCA1M+X0=;
        b=RDmb2PaLPA/w0LMvahUnfv5VbIWaDxJXj8ojmkOSGPr9ADUHzmcJhLfOtGbxn9263q
         wguvTouX/hFDJMgwRIAY5sOn2SPHYD/qCS13xCU5kQLKN2lJt6QydM35czLdM89D7vHs
         JHLiFG4OoJWuBDuGBcz6IJKnkFb3UqdF9WyTqR/QJZdcIxQes8J2d3E2t5QMs3WHzclg
         VBq16kBV/Nsx14FL+GjpF5G7pff//9GdUCL+zND+oSxl4BmGdrLeVg9xbHs9AwAZ1Bpd
         uQ3fN5C6hWrSFW+uzudSLgjFXzkAg0KahMCpWXywRDVOK82stLdezftnMk7qWBL25XVz
         FhjQ==
X-Forwarded-Encrypted: i=1; AFNElJ9KyjjA8EFjU5eudCqNFvK6xGzO57mdBS4iT0/8pAOUaZQQkUR8sS2aoboEt+oNypgdw10=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIpLIdYPMl34FhhHZla5tB6y5hUbfLN812Nzb7ipk1RFTO/Z7S
	KhsT+9DNK2+uViFRNmE14RC81gvHETjxnmjrnV5/GnzzuNBV4IkUDlBA
X-Gm-Gg: Acq92OHMNHM7sJf2imS2Ag6yHJP2QZJp4aQ2bQ/A78ybg7PZ0LanPewgid/4hrbpf1M
	xEv8ldg3mkSmCC8yGKTD7GVUa8TR/w5XbWla+FK7k6TxDK/0EVnGLwRYepVhZjhADiGpb2NpJ+/
	FXlH2+ZCXIibNOzB4lrXU7C+JvGggneqrOc/q3g6aEkgF/+PB4I+6nS50+WvF4xdoy9G83b/OkO
	Dn3buGVSqBwMUQze5CEm702E+owkaWvkdg3dtS0Q5fDqBzNpsXPkSWdIFGikofWj5S3WTycpCed
	eWbFtRyzFDwt8x6OFaesxjkagy+c2lnBZltkjc3nfEQpDGOobbR3x+pc1+oCoSXEUaT1Vc7JNcb
	vnYLYHQ87W5gXqOMUkL9NRz4/SGUvxSeP0zg/CNRBVymLpZsh92SSY1wLDk/MTnvmoTnYIw/6Gm
	9kKZmAszsNU2DdyMUhzB+vSxwUET80wnAE4qKJCCzGd/KtjzxW5pj1kJae4fSKcA==
X-Received: by 2002:a17:90b:1d49:b0:369:1dcf:4a46 with SMTP id 98e67ed59e1d1-370f086eacbmr945034a91.25.1780614963599;
        Thu, 04 Jun 2026 16:16:03 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6c76f55asm4370624a91.7.2026.06.04.16.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 16:16:03 -0700 (PDT)
Message-ID: <ea9c2389b73ffa0625da6365b4f4e7fde3b3f6d1.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Fix dead error check on
 acquire_reference() in check_kfunc_call
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Date: Thu, 04 Jun 2026 16:16:00 -0700
In-Reply-To: <20260604220904.1032145-2-ameryhung@gmail.com>
References: <20260604220904.1032145-1-ameryhung@gmail.com>
	 <20260604220904.1032145-2-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-06-04 at 15:09 -0700, Amery Hung wrote:
> acquire_reference() returns a signed int that may be a negative errno
> but was converted to unsigned, which makes the subsequent error check
> deadcode. Fix it by declaring 'id' as int so the error path is taken
> correctly.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
