Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0D530F816
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 00:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774053601; cv=none; b=YIYyQGRAB6+Vv1umpFbb54o30pcFPxvmRa4zfnqJZZ0m+xcfBgduCSNvsUhnyJWSAUyp9aV+t12mANZDlz7b6xtP5VTFXcaSDSOCRxD3u1eVgP2gPFS9xOQ7wRmKn5l4bhdXSPUg/nuimKqykOya/2I8xxkJChjuuO/f1rVO/CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774053601; c=relaxed/simple;
	bh=yXs+s4BvdFYJYm2dbaHRIlcd9JxSNaE2rtcDi14iUJ8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=SblTc7BQPONUcj/X+4DMlkNoWdRvpratNKpbeNqMosm/86m8wX2hIQfq5GqF2bbE+8lpPXNhD4rGo4Ys+5jWSb0jukY0e0LaSba9i9R0XVmJvoN+jgSsJVRtwa61x5VXjcQwbSMyQ2vXNoST//FsDmlKjAS7VAVJZ2zwNf2gtIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jo6ZdL+P; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jo6ZdL+P"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79a46260385so26551407b3.3
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 17:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774053600; x=1774658400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZYPe3Fzt4XiWBzmxWxCmd97onqN8khEvECVztrT0eg=;
        b=Jo6ZdL+PPtu42RMyQ181vEsfhHNF+Fxqa8jwHlH41ms8mjuDU91yNYiMbxeWJb3wxG
         fZ4mmdIt3UdXZpTxtp46RYazm8aNFYraf11bQw0reX7EX6vja+LBg7UlTihtSsnrcNgI
         ruQGFtZNSvUUn+8J+Q3wEAFDcbOhHQqX32JuNcEyxnq5K65eSpTYMsw+fgbzrWRKUfF0
         mgChHASSkTtCSH5UN5KuOgu6HCfLPyThDzNyXjAwBhjJK6xcH3WQ0acG3vdasJkuHsLr
         7L9ReioOhdS1q+eShGt0QcIKtroAQjXvnUXsHG86vkuAiyvUS+p+5Fh+xr/DpyKlBq4f
         DCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774053600; x=1774658400;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fZYPe3Fzt4XiWBzmxWxCmd97onqN8khEvECVztrT0eg=;
        b=fvqV9+hJ70laSm3qRJuP5h/ZZvcMs/dU4GDiyz898xA6aoblDeaC0qL5FUgIE+u8gV
         MJ6EPB40/vMossFBha6ZD4bXwk3XJ6Do8D+ZiZR6CF/9vD6FCZ5PUfVRuK4vl0zm/S/P
         0U2Ae5gt5tjEfy+xnFVRCjmvlKYVpsnhYI7eXnaLPhdpRqvM/BRkMyH0HCM2a56j3YFn
         8mGC6PKB472iyQZLtCsz6LNv+LZXlaVB/ZDIicQNqFoywopjrm0Un/hlKqPcuF6mgyjx
         Ic4Lu/e2uMQv5fQ5WhndOb2zUc9U0U22hgzyTk1zaCtOiQ8DGeyDq3NLd2uG4BxRUpyo
         6HOQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7ijJHQfGSyCVy617IUDOg70npKCffzGj1lLw4VzyHKyggTg86kGtpvwuOPuPgHMvfvqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4imCON5+WjipfKhg5Tb+PTbkcEYYPwHx0j/FDzKC9Chzm54Eq
	uLXQ8Pllc0LOkJvGSuXDKZBjIVOMvZD5qRmA1yCMgiMKPhLtRScAXft3
X-Gm-Gg: ATEYQzwgOsroNt0buYxXL5jZL1rkOyPsvl7Q+ybf4teoTiMtOIATTm+BCPGVlqbJpMe
	Tas0rYSyex0bPkzRk2BqiOYCMloNb5B8ZwdKNYzrsGjfZ8pJtlDnQIKiW+dDWJLb4IEdLnF5cvg
	WnrsU6HqozJf7RB6hqJjvD978KHzFXDeuI1TJJhHqhDp1xPTvNtA7YONGdOZIRhHzhUO2rTcYqg
	lNXLiClZFD+QWodkYckTCv1OkQatv2E028zWJpxaCMpYWct0TgfC6xmhMEDl2Ysc/UyxJ3XcnfV
	YQ2EeE6y+QGectRMwAQ9B7jzxQzTh/A1eB1lDOHlI/4WugomZ8t/I3YnCaPw8jhf1FH0yExTFRY
	5S+4UVaCSy8jpGkvqWPi33sUFGRR4yLVC9V7ZGO+bK1VvZ+WiRgxR9wYliT86Qd068XsLk/4KK/
	7jZRgZsvZup8j5DFrzkHOQAGPHrg5tBv4sVXwRGwHJ2MQxd+6qh91G0mXZ72zvT7oeNizlpZjoh
	8YU
X-Received: by 2002:a0d:dc07:0:b0:798:5b22:ecb0 with SMTP id 00721157ae682-79a90b09f20mr37919447b3.22.1774053599741;
        Fri, 20 Mar 2026 17:39:59 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79a9054ee5bsm24336127b3.31.2026.03.20.17.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 17:39:58 -0700 (PDT)
Date: Fri, 20 Mar 2026 20:39:58 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Nick Hudson <nhudson@akamai.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
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
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.28a05bcb1c591@gmail.com>
In-Reply-To: <20260318134242.2725749-4-nhudson@akamai.com>
References: <20260318134242.2725749-1-nhudson@akamai.com>
 <20260318134242.2725749-4-nhudson@akamai.com>
Subject: Re: [PATCH v2 3/5] bpf: add helper masks for ADJ_ROOM flags and encap
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
> Introduce helper masks for bpf_skb_adjust_room() flags to simplify
> validation logic:
> 
> - BPF_F_ADJ_ROOM_DECAP_L4_MASK
> - BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK
> - BPF_F_ADJ_ROOM_ENCAP_MASK
> - BPF_F_ADJ_ROOM_DECAP_MASK
> 
> Add flag validation to bpf_skb_net_grow() to reject invalid encap
> flags early. Refactor existing validation checks in bpf_skb_net_shrink()
> and bpf_skb_adjust_room() to use the new masks (no behavior change).
> 
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
