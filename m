Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E143C553A
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 19:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776714256; cv=none; b=RM2gg7BqUTsEF2zTrPhvP6yxLLXhk4mIc5IqubsGt1O43HNpLIGpUAWDnAEkBGxgDr/PuIqbhu0VpUKVeo6fKBr/kXlTDaZXB3aZj/hF04E/U20Irh6TjbwOewJWDuC5zU7RuUqlzvh8n0N+w6Ud0jKUF2gwsIYQk+extXrK4ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776714256; c=relaxed/simple;
	bh=SS4Yt3zFzImyyeOq4jcHWSPrcqDrkh4/v4ZlbJcO+xA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=AsquxyJfQFJDVnOEHqpSLyPUFtytI6E8UilxayzOPXc0tg+nefit8Dy796Fp/475L/hNjfkqgroozeIvXHGhcd2n6LnTBdZAF4UYIAv7FOnbrrNFFuAvESBhuYRD1b507W0M33r38etDPg+7dLocvaAd5ApHOe5FK75wm+RiWkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9BKgjEf; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9BKgjEf"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-651bf4a4140so3567793d50.0
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 12:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776714254; x=1777319054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0ZPEi4qQzDtpNwH8vlSQQ5rqmko0ODy6PBRiyAMQkQ=;
        b=V9BKgjEfchSp8tkqQZ4moMzjp/rIHnE+icTZM29dJt6hR1Oi7LejriM3J8t8JT9zg2
         A4OPL3T1seoHqVeZi7yCFkfy873Cp5tzQq65wSVPJ/VhLoyAwIWKEpezU57qEJ8o6Nqr
         WMu1gmz2xnO3w8+JII+d/RFONcP52Iwdg3lFWvmO0vD6plHfwsnNY2NOiRmeUo4S/r4J
         YdtslDkp0UBuGd2rbVLlRkaTeW7C7TqM6DjsfE+UF53soDu3XJ/BmBnhIXPzPXqMxlNC
         h5P6nLSGo6WQ/uElOF1el+a3CBp9cl/BScFw6cYCxzUhcl0AhpDJBpZMYC1yAwDgjyDd
         qKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776714254; x=1777319054;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e0ZPEi4qQzDtpNwH8vlSQQ5rqmko0ODy6PBRiyAMQkQ=;
        b=ft0E2YZcT10qmdn7dBjErttDVGJAWVBG4Lm+C3U0Y5RGk6GFKcnOPGkBjU3Tyz4tAd
         H1DrNZApnfK9Wt1vglFQeRjkJB699064thN6u7IxiasZjUqhttkyHDQ7DgpDv14bIKFs
         loqnUzAScHANFL4qi8tZK9zUX2lxrRCi73y8riHSWLaDsDq/6G+C44B4hEbsrO27LQuC
         LNDwR9kx3OyPxeKEytqpqPJrW0RHwEvRir1LE2K6ynJICZBvs27rrLSTpf+fJo2SAk+s
         sPZQOJ6BhhAw4ndW2aAmLDXjaSn8gu/kdG76jsknco+IXRgwRK8OyStaNNJqLd83htLn
         9sEg==
X-Forwarded-Encrypted: i=1; AFNElJ97CVoFubP4biFIDpLdSRI9JjjzSgv88+OtWpagBGII02Q460wgGLDA1ZHa7IOLHx3JvEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YydxcjotRAfro1pA2xz2M+8JPK43ZwFpCDT+Nh5zmVsmmYL5mTz
	am1ok6jvl+f9/5NCvfKI41xIZG/BvkOo9vkd15i6S53AixsImXmoprW5
X-Gm-Gg: AeBDiev1b/kIOh//LqyyGG/2rZjGUdHbRUWJ8e0KgocGzjGH9iQSLuxggsdWeaJtEWX
	13JUfQIVlmHBcdJZI6LwIFCSyloQLT3g59ikY14522jAJaZYjQLzio0fUD5ZgTCAjLkYiZek12R
	0ftv36eNEjvQC74ttdJkEy3PVswa0fZZZMhDQKDGpit6rEJVjcsiHzEVHmoR9HEBeDs3J8HR8EX
	lN3D5gLON8KHPE7ahmtkBlXfDyf7x7uhGfwv1gxkU83wfltHUk+wXqIgSOcuS0i1Acv5aJX3h1f
	M+u4MxnBlmhjhRVqHG7HnIltwN0Ii8uT8maI2VawLLHZbZIYX5qSHb25cyPtWwt17ApYXFkwDUu
	Lf7ZyzraohRMzXoGmTqHnhCgPC8KwbvE0vMkhhrgVHgRzdUgVOJiXt3B3up+skzR9cR0oDLKn9m
	p51KTnUdDESzVmU1RvLYRC0TUDu1WvZAwdUvzQ8jJVD89OP9oW9J5E6Cli6kbJgGeg2jGqoufrQ
	iJjUpTPKUI0dk4=
X-Received: by 2002:a05:690e:130e:b0:64e:bfdf:454 with SMTP id 956f58d0204a3-6531056e7bcmr14161558d50.0.1776714253941;
        Mon, 20 Apr 2026 12:44:13 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65314b63174sm5737205d50.6.2026.04.20.12.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 12:44:12 -0700 (PDT)
Date: Mon, 20 Apr 2026 15:44:11 -0400
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
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.33c89b87c9822@gmail.com>
In-Reply-To: <20260420104051.1528843-4-nhudson@akamai.com>
References: <20260420104051.1528843-1-nhudson@akamai.com>
 <20260420104051.1528843-4-nhudson@akamai.com>
Subject: Re: [PATCH v5 3/6] bpf: add BPF_F_ADJ_ROOM_DECAP_* flags for tunnel
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
