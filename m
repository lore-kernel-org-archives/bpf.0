Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6C82868B2
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 18:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770316546; cv=none; b=b1j+Il5ZqoDtsX59pfKSa6GcKEWhUxjBB1TX1owglyWI1gqRhlIBSNp1AFdPCa6NAg+e+ZyBckauf9s9U8kykYbuJtBpGXilVAsg5nmWKzLYrDjhMyRqUW4yNOslvig8W6KMWpM5F/Mntht0VeaBttHW0KLdEeWWd/92uwbKhr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770316546; c=relaxed/simple;
	bh=m55Pe+R5VjpRH1rrRb8Gz+jVpvHwz4rdWmym5ebZFuc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dXSQFPuIaA8QxFxxKvj0NDikKHao9gv/SmNTEwdp4O75PPJDr2p5QdHeJfP3m8RmqtEJsMwzly2ucQTD8ZjVfkjJsZEy++LNEB3y4aRG8AhBJgNuAXJ1KSG8S1Rcb9cNaUgqATuPmwfJdCObCSsNkuSSrHVHoKEdGvZBUF6MWY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4l/d9yy; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4l/d9yy"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso9439335ad.1
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 10:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770316546; x=1770921346; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m55Pe+R5VjpRH1rrRb8Gz+jVpvHwz4rdWmym5ebZFuc=;
        b=m4l/d9yy8YYWPvIDdX2iHiUkcswDkjj3w0FyzTcHGKoARCMF7ZeHu9E1FLagxfWNHi
         2auPY5oyPynTXeBqSEp0CgkJS7LxJzFKfO41TwZoiTRo6F2cavkfY2vNrvFTQ3nUzHgF
         pPWdZg3qqSQancumclsGig0QrFpYZ6n7fEmUoYQ44M3xSHlyZ7aw/bRaNLZpGefd9VgO
         GUUvKVlL0AN6lsxD6prk3WhhvSedp3hHYZFkUQR06Kxjg7ElgnIyqb/Cu6XOZZ9BL00N
         6BRV4+eSRHojsZSaltLbpPJNlRg7ROqhyd1qGVWfy5D2HfmIoTKsEPQrtnL5GJbDVNmH
         xiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770316546; x=1770921346;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m55Pe+R5VjpRH1rrRb8Gz+jVpvHwz4rdWmym5ebZFuc=;
        b=nIk00ls0JnvX5A9U/6q6LNZwvhqORUHIaq1f7b4o5w6LcUFCTAACGWnjVYasgY5om+
         vjxGY8z+79hmVysRs+6XMcxrFzvXeHxoCmNFGgPkHMMIVVjz/7UO072Y3Q998haTDdOL
         /aCIlP9o+Tf8V5MC3Mn+uV47WXnmk0hlxCSlepwZ3rxzeiRBfRbaQbWtc75YVqdiKeuf
         g1u38kiSu5z9WmO9x2k1siySYlIMIRYKZK6/ftZ6g0HjV98t8MUk2dJGTnYhRiHooaHQ
         l15bBcILLrNnOrjVFnvdEbbHtJudH17fvIIKms8MWb0RztEwPMcCdWiFy4dEOuV9GPGd
         QWBA==
X-Forwarded-Encrypted: i=1; AJvYcCVuOLuqbGqWzqh4noHUppmEEEEtzDCIXLYOiorGi/2SeBQ4boSVeumpXnr09KIij6kLCxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR3FCzNu0KNXvrAeFdW79rCNM63lnGR2Z9HX6bptaR3DdQzfZu
	H6K8+zzYMzDi9ZyU9TjWvwZa4qsdAG7GNnDJlgab7m8oHfYIX0421/40
X-Gm-Gg: AZuq6aJOuqajXZQHqDeOwy8mbH9iZKMzsWgYOrn9ZzZ+JuKgQ4e67PQSdDpSzlGi6Di
	WXNOoMOkdAkH1561fL/R8PGiwh2sRRHCoJtx6NAttxKGk/1hhw8lUma0UEP1FKPvObklxYD3siA
	wX66ZfmXXpydSk2AaMGUnb9ucfWgngcHGS39ARscAOr7gtzPOQBGq1M95NOn7ZkcK67+9lCI7Js
	XQ0YicqUFEKO2FgaIKAPngcSO2lSOSLJWV4nHzE3nR/uMOIiCbVtSxpDA87mV6USYcmssaXUWpu
	rWtVDf8HRiaWjJ9O7RN1BcO7VAbwFgQb9oUU/rTW8FlGGYZLBzNpY6KcEgaXTa0GdWHxWUgLtIp
	R5T4KTIcUkWDmofbqnaDhniYEsFfkpzKGkylUYXkunAxdh0caSG6paODWlJ0WuYaQIb0DIJ9afa
	CaC8VQfZx2jmkRXXm9KQL/u6ANMzV4l3B79Vl55fcf
X-Received: by 2002:a17:902:e752:b0:2a9:320a:ec7 with SMTP id d9443c01a7336-2a95165735cmr2347215ad.26.1770316545858;
        Thu, 05 Feb 2026 10:35:45 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951a644a6sm885955ad.8.2026.02.05.10.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 10:35:44 -0800 (PST)
Message-ID: <0e05189fc901cc1952982fe422d11c565f01c7f9.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add tests for BPF_END
 bitwise tracking
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tianci Cao <ziye@zju.edu.cn>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, 	martin.lau@linux.dev,
 sdf@fomichev.me, shenghaoyuan0928@163.com, song@kernel.org, 
	tangyazhou518@outlook.com, yonghong.song@linux.dev
Date: Thu, 05 Feb 2026 10:35:41 -0800
In-Reply-To: <20260205052313.225076-1-ziye@zju.edu.cn>
References: <e316e3675ffae5f65f70cfc25d8c5e2522c97e09.camel@gmail.com>
	 <20260205052313.225076-1-ziye@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-02-05 at 13:23 +0800, Tianci Cao wrote:

[...]

> On a side note, we are also working on range tracking (interval analysis)
> support for bswap operations. While bswap is non-monotonic and hard to
> track with ranges, we found that by leveraging existing range information=
,
> range tracking can complement bitwise tracking (tnum) to yield a more
> precise combined reg state.
>=20
> Given that the implementation would be more complex than the tnum approac=
h,
> we wanted to ask if the community would be interested in seeing an RFC fo=
r this?

Hi Tianci,

Depends on how complicated the implementation is.
Is it just theoretical work or you see some real-world programs that
fail to verify due to insufficient BPF_END range tracking?

Thanks,
Eduard

[...]
