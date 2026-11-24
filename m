Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536292;
	b=092So9vhBVqqu5OjUOwgQHbZEwFiMx3rIUsDqs6oiRbgNA2E15n1vROAe21xkva4S6cQ
	 7dryueWz/KnUZL0Agt3W+lO08+SRUSNmvkZfj+ugfpl9ECtONqxLYNtICM7PRennT9nYE
	 uQQU/d3h/gjOCvpuiao+1JLNd7DFp29bjFbXNuRmLY9W8ejhFuswoKYchtCSKoXVPyQSn
	 gbmx4agIf27HEfAk35EpcngW6HTyMKAeVLXJHxXS5arSPq3m9MaOawmG47t7kpIsFNrkx
	 yahHGpRAOLm0Jd4ptAF2ClFSOka1GH9fzInmHOz3wLGWmf8lMxGja7HFeBOAZoAVl6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536292;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=KezQ9tNMTEpbIH1UNsI1azAaM3sJdlBpXzC0uPhlAnQ=;
	b=IhDkVgj9JkSKimG+IIg9TM7bOE88aoOMy5VerHXNBIRqJ4tSqzQ3huxiJNwaY9GbODVg
	 UIswtdmJUpOYN3wtYq7gP02ijoEvM4n50I6BKSTQI7erSxoVmCc3ygSJwjy8yTCkLxpem
	 HNCy/tEuJiqHCayRigqb/4XV0MJKqU2VCCT4mQcEGN0SmIWguQf8gAstcZZM0UsJIpkQw
	 tbO9bPG1ftexGe/oDkM8qn/4uJiXh5Pw+lXq7tkDBCDixFJwg2bUS2Y9vZf/Z54rLlAjQ
	 /xk6n2I8mGEPejDF1JmMC52vi7dB15uWWElNOsLTQxlqWDBlBGk5KarnpXO/cQSHRYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=H9x9EGYk;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0BB606A321
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 16:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA0BB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=H9x9EGYk
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb6057b333so22161265e9.3
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 08:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795536290; x=1796141090; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KezQ9tNMTEpbIH1UNsI1azAaM3sJdlBpXzC0uPhlAnQ=;
        b=H9x9EGYkczeeZK05aMn4VjlhU9YdFldQbjYtVqMu5/ir/O2dVv72A/hjCBoYVhkzlZ
         S0SILDC/kuHGmBYiq9eKfLFC20dYGC40nBEldfK4ix3w+FNm8+IPrFL6w34zAlnCRC1G
         KXcLO2PGipCXQpgyPUkRVmh7KHppZGU5PF1bw6P7tJDtSFpHQteZoX0fRmrTUAava8JM
         rdEg7CJaeXTLNdbM6mgQqP1AVCNCNWIS1BNyzfA63R8QgAohmb3N15EqcDeD6TgVBtFR
         Kfgsr9IAxtGK7PJsK4wgW4BL4crlAAMdBlek+D3k8JU+Q6BhUBoMM7b5dRK8IfNZCl8p
         IL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795536290; x=1796141090;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KezQ9tNMTEpbIH1UNsI1azAaM3sJdlBpXzC0uPhlAnQ=;
        b=x97d5QG86NTvF1u3eXgBmKtQgM1YBXTLw1jzo4lQNZOXaazyDdg+vRlA9jkG4T1YrK
         zs3zqgHsfAOyDlDt6gNPXvs0qSNuASMD9N7kfcM7QTh4/0V1CeTk1D2Cys2ykfROrbpN
         htpYu2XZ3tiNYlZS1cw6FXSVX3fbtjgbFEmRL3GOgV6cuLyHdDet8gA7UfPQvOvPvGtF
         0XIn9ZEKj6bJN/WXlEzKipjzOCnJTqRjRO4MDzb0YK6wHStY5IoQa9Bz5n6T0LLApdKt
         6Pk7Zj2Z+Fybr73eKSx0ioJFSPPupBauaK4kBLaX60ZrYF22mHwUjutKvhIZzZONcoTn
         WN9A==
X-Forwarded-Encrypted: i=1; AL+hErHVLtFJFrCv30tbkztQi1b6QAacQZBkkn3iBn3vy6m5QUV/2MUNbvlW1F5D/q0ZaiSFuIw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+NNJkxr07ugUF42nm0nY4e71S8QgMrP2tpl1Uh2p80CrJj4OXi
	yj76gpEFN5kWQ+Ha4yfW54epVA1gXaLGRZjL8hBMlxP9cqiEbVPWB//e+ZN4OHOlgjw=
X-Gm-Gg: AZFdTZfRzFkgJcrPjHKszTamzGhpYpf3GqFwKH2H0am713cTTr4dFqFcz+34WnLnAlJ
	1yPxWai1opK2HNBmbfPYoreGdTeWVKaS3Q4dea2eJgcWfU50FYG4XckRmOa001dbHpMBJXAvzwq
	r7EEDQb+dJVWrb4jP3qx9d4MBF2ckpF3x3iXh3sE/9hnf0vDxuYY4+sLBzV+BUwGdDZ325QWpoZ
	ZsMwI4FXmdxn+r6PtWVmcr3FzlY1HBNI5TpuyK9tbcDetOUpGBMw1SjBrrhWUKpG9i/XbIz7b3m
	UswCGQ6KX5sdf8zmjG+bjxF0i1kBv1RjG8RorhxBpC+7AAr2VtYylC0+G7hNBpFQEGhWv30NOYm
	Cj4nUoen1LExHEfjomfZ0sFXK22b52Q5CM8Qoebwx+FpkDYrJb6EydlfHWbzeooWcBgB8FgAUIa
	DhUSgvW0sXcfrmpKykd9u0N36c41KKbpubKC7WHNYyH80z6tFBCtJJT0CoAaHU5rAkfmBgH0gOo
	boYsfmECFvW9kvOAOgzx4ljfj/E0hQPkxRNQkWc+X/LXy9jBKK0lJlztHneDfkeHUKhSwhGVhIk
	g3+dHAWpX2pdwPz0uv67RgAB9/UatTyDVIni23/DG23SzS9Eyu82qBZoGYmJppH9VjjZtA0FMJj
	f80Kl
X-Received: by 2002:a05:600c:1c11:b0:4a1:e57b:667c with SMTP id 5b1f17b1804b1-4bb8881c357mr345245525e9.26.1795536290208;
        Tue, 24 Nov 2026 08:04:50 -0800 (PST)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8d4f9aa8sm405101745e9.4.2026.11.24.08.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 08:04:48 -0800 (PST)
Message-ID: <384d2102-c2e8-4363-ba4d-24c045524410@blackwall.org>
Date: Tue, 24 Nov 2026 18:04:48 +0200
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next 3/4] bpf: support bpf_sk_assign in netkit tx
 path
Content-Language: en-US, bg
To: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
References: <20261124151244.1423343-1-razor@blackwall.org>
 <20261124151244.1423343-4-razor@blackwall.org>
 <sashiko-outbox-231505@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <sashiko-outbox-231505@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/11/2026 17:59, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [High] bpf: missing L3/L4 protocol validation in bpf_sk_assign() and
>    inet_steal_sock()
> - [High] bpf: prefetched socket in netkit_xmit() not orphaned on forward
>    or xnet
> --
[snip]

Both are pre-existing and noted in the cover letter. They're not introduced by
this set.

Cheers,
  Nik

