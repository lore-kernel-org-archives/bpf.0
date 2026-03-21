Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0347E309EF2
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 00:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774053590; cv=none; b=a2119wKMBY2Eu5Pr84IkkKDrjqXyDcR6gX7EawmXg6i7ZV+xR5i2PFLsGS2nvjU8npOZUEvjijqx9OnwEiepx0O8RltGQ4ZwAABvymBaw54FrzEX+GZELnRZYG9Tvji7tt6iKXa2Xi4RClsEINcKUivOI+86WuU8QEAT+hN5HAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774053590; c=relaxed/simple;
	bh=SS4Yt3zFzImyyeOq4jcHWSPrcqDrkh4/v4ZlbJcO+xA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=k2WUddm0eztjJ6emQybsiJ2bpjGqnkKijuxWEnlKJTlrknY7fxLaNYgR1i+1wq9CxiPDWAiNxhncRzX8N359Ja+BlYh13OA6rTC9iZpiUhESFvrb3G+uhqBadN0nQq/zuKUkcISH9UgETeiGBqLBqwZA29ZRoKPx+JGH4H86NNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5OoxHkw; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5OoxHkw"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79a4e5caad6so27328077b3.2
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 17:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774053588; x=1774658388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0ZPEi4qQzDtpNwH8vlSQQ5rqmko0ODy6PBRiyAMQkQ=;
        b=B5OoxHkwxnlvaTLoog/dopbf6FL7vyOwZl6qc4KY0bejmGuou9k3PaPllfMWKMIs1M
         4Sq3a/N6EKprxtha/yYj++FvJDGqmh2JVedadp9OfgvoUVt6PLuos/QxW80xZqQThcKF
         G0pL3LTOGEPst6WONBG57fqAxdk/GzERD6wDpuxR3Jelqca3WjT905+XHQpQZeAgxNSj
         P0819ZSxsCkirvwkYH+HGnElbQ7I5wxuXqdXvkr+NhsqG0GJgwX0dZOZS7l5jvrDoT6n
         bMClmVlWD4AuuLR//s1tBqC/nCv8pKdB7izePi5AM0hYdID0YK5MlX2gjXc558nWuMP7
         73XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774053588; x=1774658388;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e0ZPEi4qQzDtpNwH8vlSQQ5rqmko0ODy6PBRiyAMQkQ=;
        b=aFEkV2i4JeV/ysdVwlSrRXZA7ARYBAQIhaLWON8IyGDPMD10UdIUQG8H3VsdhIvhOq
         VBNv0+zrxLMyqWGtYvY8/Okmr+wzOBnLlAawf3fPXBqywff7Z/n/qMSLRBOoAXY/fQLO
         oTAc2RJtvgZIU+gA2fM+JG6iPnBdH1o0dCP2B/bikgrQ2dWgK8ypJIiu9Dodl316TEVm
         ePnJqatCiQYRILMk8QabmAdoHr/68vdRSYocMRJyib4cAWvIFLhGzbvaPNu2SNxxciCi
         mFRpVsST3m+U2I0GhRiuoqQ5q3nXiST6PZl41TsHEtteuVEXZ8aCIcVdq83DFVzWgBOe
         WdFg==
X-Forwarded-Encrypted: i=1; AJvYcCUMYKWZcpgoBAV7WnRRr50it8PPJhSMm39V5DSZeNavzRKtVZQFvJzkMdAZKcpEVvrGyFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Ibq31snZF1bL82kbGUiNinDr3DSrQGXvqO0fpvRrP/1Q0iex
	0CvQ0oKa8d4844asAZbKETgGxNtsjBIvBQop8WLYihudxc2Ng+VJcPMh
X-Gm-Gg: ATEYQzyD5OmT/13T6je1GGDRni8aELqR73hcxew0zcQLZxldlalj7Vu4fWT7AEn9r4u
	q/bkbiBy/H7ZmFJc6eQjF8UwuBd7f7/t5VecgIbdC/T7fxQJ4MEWUj9Dkb4pY8o3NAWz68EPXPI
	G6L1TTgSwzsS0gh2EclTgbn3nuLNcHTQrqE2yqdQNa6+Xu0VxLbk2OS2Rt14lHrtuJnQkS6Za6s
	LKruDkeiSc39SQ9HDz5NVWV7j+cAFTLnmQChatFLyat499Kf3LO2xUsG7zPkZlYGs7XSoQMP7u6
	qYy4Qn3r3J91kZ9A9BebzOE+fzNHKJ3NUpDhhSdSeh0ujeaSumBgwMhHna7vXB/51DL3nfPegBm
	1zLh3eXxBR8eqWJelhBHB/5aG0JYFaMM6FRjDIDd3XzCA0fyL6BJXZX4bcBxDVI/V7wP/YbWliT
	beJSQ3gpdomb39bd9gekaJ0Rc70ulKmeATlPyIyAeP0daYyTmejgKik5z9y+ymYdXJLRq72YYnl
	lyX
X-Received: by 2002:a05:690c:1a:b0:79a:42f3:ff9f with SMTP id 00721157ae682-79a90c1cd7fmr52792637b3.56.1774053587704;
        Fri, 20 Mar 2026 17:39:47 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79a903a2d78sm24684557b3.4.2026.03.20.17.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 17:39:47 -0700 (PDT)
Date: Fri, 20 Mar 2026 20:39:46 -0400
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
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.37ed1c90f7b55@gmail.com>
In-Reply-To: <20260318134242.2725749-3-nhudson@akamai.com>
References: <20260318134242.2725749-1-nhudson@akamai.com>
 <20260318134242.2725749-3-nhudson@akamai.com>
Subject: Re: [PATCH v2 2/5] bpf: add BPF_F_ADJ_ROOM_DECAP_* flags for tunnel
 decapsulation
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
> Add new bpf_skb_adjust_room() decapsulation flags:
> 
> - BPF_F_ADJ_ROOM_DECAP_L4_GRE
> - BPF_F_ADJ_ROOM_DECAP_L4_UDP
> - BPF_F_ADJ_ROOM_DECAP_IPXIP4
> - BPF_F_ADJ_ROOM_DECAP_IPXIP6
> 
> These flags let BPF programs describe which tunnel layer is being
> removed, so later changes can update tunnel-related GSO state
> accordingly during decapsulation.
> 
> This patch only introduces the UAPI flag definitions and helper
> documentation.
> 
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
