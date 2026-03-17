Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F061375F6B
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773754060; cv=none; b=uIPWIz3LMqNpy3996jIQo3HTvkQ6EODxSJEswsXqgnmfZpZSqo8zH6a959ZmpY7/lYI4dxDZrVn03YBleTxQEmyEhuB4EjXtiKRxq8F21+u5LxvbeEEsFQzCeEUMJJS/0bQ6TZ/+670Ty7WTbpEXLcjgL5Qi4M4E0LHOXszmyic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773754060; c=relaxed/simple;
	bh=ikDInS/569fx0TmBO5b0XgY/qVS6a9yIqKr7YcNt69M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=cmBcPZjA36amnRZiYupE3JqwLqtT9tAdAjNxBJPsQdCY7dWuaqII2Jt6EMWz4RpKYLKdQq6uPcW/vbf7GwK6TYTGavRwlNmLgWmjslIVMJf/H2YsalAPM5cG/MDLeQK8DWXCgYRyrf+D6KeRJ5ooemr0TVnxdihgBNi4oA1T1gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fykOq1YD; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fykOq1YD"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79a40fb9890so23845937b3.1
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 06:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773754058; x=1774358858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMzTHu1aP/+ryEaVbORN4NuS7FAdq73GkOmHjCB3Qz8=;
        b=fykOq1YDsCuzQExBmRkeWYHLL/uMsCji1tf9a+zwioGt9b0OM0HkagM97OZvVHcfk7
         QXLPpwjw1hEdyd28aSyiu5dszi3dvR9y2lC344HGjlrPU8tM7hkVxD6V1DHUqZFzMBz+
         LHhIHn9JUKklJcI66cVaOhEVY1vzGGLapvbQb7pBdVErWIcN3LDA0PohhFthRnAb3Mg0
         9PrtXMbQLwKDwlBDMbB3FBWb/JDgaB8SkqJsbpkFtNwody8FfD9Wi+HQ6IUc9XBnU/LN
         2POBe7FY1fQwHxhq+A0bmUE0JesbmxzPT2uu0yjTBMLz6hHxe9dIJOgBTUxHBXLcrX5h
         tTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773754058; x=1774358858;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fMzTHu1aP/+ryEaVbORN4NuS7FAdq73GkOmHjCB3Qz8=;
        b=M+ZPVprcGs1WumTRxaqmi8DO2sfKf1IYkK1YadnJwKAhZbnzSyTn/cy2odB72YvUVy
         Nr5b69KkNGIDEkmMxOap9N7PguRGSUuFJz2tzItFivDSRS7D0q6TvPWPDtBEoEIhm5hs
         t6CpnSac4wT7fNVjdxZxO7qIHtHlu94O2H2m2yy9Rs9NrrEwtVmbnEZnVb1YNomHSyQk
         7+q12iTNkRmhfYZ09OCAr7BQEBxyXvwBJjsIUcoXEkinyYGD7B5GqOPjyWJVIeA2njFg
         YvXNtzYQWeOb35PeviYcaGEi3vJ3Se/9RRC1hjErOquQYygk7rhZQczg3iNZQmFmVjoB
         rLmw==
X-Forwarded-Encrypted: i=1; AJvYcCWkW0+d94mOp7mamHRYzvcjl5trLub68fcUZHtpAjAR5pwW48F0tszUjhaccFvDYA9gjfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOPtj4O6LExteCccsueVDXxMhpCk2YpgjCHLB3vc6htdYKuv67
	yHhVoqTCeZ5ufQ51saVjnAxwRuNE+zCiwfnYHZhQZJnxplC6OqjFXx66
X-Gm-Gg: ATEYQzwSSh3lTat5HYI0jwL0vzxtR6LOPsaebRbvM6kDRv4XwC5foE//DYa16fjzJRy
	zvG80FBtL3GO+7CnZ/4cgfj9nRQS4SfHTHv5xoAAOxXmKCQayHM7S8c0CkrfChGJRyt7DZfiYDc
	odcZA1Tnjx4ItEgvvE1tQZZI+G9Va0axS9YY35b98QEiLED6R/s/DNJc/7x+BZXnLhfIo1aAMFG
	8Un88y0A31Hvjg7SiiXBGdz1lNNMpkiscbJTUDlhV/XNypnIzmZv3sTiGIJk+0Z/X3r+i57JZgS
	P6fZ7UIEPS1WRc9QDA4DXacZw5YIopThwLwrE0HhAibD3Qe/lhw4IJl4xf3+/es/0otWRCaViDR
	EQG1hrV9YkgrXt9YM3Agn9G6MCa1P2S0S3kP7T5g3L0pKEWe1kCJ226d3sXEJDmFxJEfGsIVNH/
	364+2D1/dc2yELQnP62JYvF0pAbIMRMzmWyFoKECeXp96W4nZRlk6yqY8r8K4e3zO8s9bXErCXu
	Juo
X-Received: by 2002:a05:690c:698f:b0:798:613a:2efa with SMTP id 00721157ae682-79a1c1a7074mr176740827b3.40.1773754058231;
        Tue, 17 Mar 2026 06:27:38 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79a51b4676esm28742607b3.40.2026.03.17.06.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 06:27:37 -0700 (PDT)
Date: Tue, 17 Mar 2026 09:27:36 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Nick Hudson <nhudson@akamai.com>, 
 bpf@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Nick Hudson <nhudson@akamai.com>, 
 Max Tottenham <mtottenh@akamai.com>, 
 Anna Glasgall <aglasgal@akamai.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.3102df56d5f64@gmail.com>
In-Reply-To: <20260317121429.2399539-4-nhudson@akamai.com>
References: <20260317121429.2399539-1-nhudson@akamai.com>
 <20260317121429.2399539-4-nhudson@akamai.com>
Subject: Re: [PATCH v1 3/5] bpf: add helper masks for ADJ_ROOM decap flags
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
> Introduce helper masks for bpf_skb_adjust_room() decapsulation flags
> to simplify validation and keep flag handling readable:
> 
> - BPF_F_ADJ_ROOM_DECAP_L4_MASK
> - BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK
> - BPF_F_ADJ_ROOM_ENCAP_MASK
> - BPF_F_ADJ_ROOM_DECAP_MASK
> 
> Also fold these masks into BPF_F_ADJ_ROOM_MASK and per-path flag
> validation checks.
> 
> This is a refactoring/plumbing change; functional decapsulation and
> GSO behavior updates are handled in later patches.
> 
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>

Only patches 3 through 5 were sent to the netdev list.

Please resubmit the entire series (after the customary 24 hr min) to
the full list.
