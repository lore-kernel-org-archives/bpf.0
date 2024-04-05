Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3728B16F8EB
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330460; cv=none; b=WKXAtywAydB0cjHEmhEZaDNnmfLcBDhwYJRFM/Y5SVUMn6zsCZ/ZZQyi4vpWgboIO83KistGJhmBpshRJ6Fh84ykZGg05vd2oqKQkUdg/zLuI5jh8sL9rmg8iVbMptvXG7qAmJMobl3D7NsZ/xxM8y7gctXD/uOwcGVIgpNDnuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330460; c=relaxed/simple;
	bh=OdIy4eiybT+o9tsOuiW5xp6/53/7ZTVhnwBK/883odc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=d8PP1oaJ8fDjeJ6QnU2J6wuJeBLGv9CItKZPDISsr9aPEKUGDVjEeLEQ5e48n4ItIe3r1ZIq0W7g2HTia1MxLpIJSRbYXsjssmhdJBZe0juY7SizKgZkNbFqltWC2UaBeVMZeYrGbC14F6PvP3/WFYZlWjeYvy7Ti3IWrGuKrBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcvXQBB3; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcvXQBB3"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e2bbc2048eso15991505ad.3
        for <bpf@vger.kernel.org>; Fri, 05 Apr 2024 08:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712330458; x=1712935258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJQmOaO3p5KFIWQo7e9dcSFLyOpbKit//7W5OoEH2M8=;
        b=NcvXQBB3a4uUB/FYP1jhRb/46WXRPcHdw8Avsry5f4M3fF8tvhW+aaUTitc7cozhKb
         99MzaDntAipmYHuCqgoX3FSTfcQu6ZUyTwTcYtbgEMRcj028rXnewT+liGSX+pyKY2zY
         nG/NZ5yl/v5h2TTx0mgThuPzNHnJQv6bG86j09+EevsHiwT8XzN99HbZSeH88TVtyHJP
         drloamY4XT3dYz9Z762nJ39ebwsh01hJTCV+H6jRe0jUYynXk9/ClHAfv6XjOcx7tCgn
         NZQ+GXkIKSUYfhjfT0eUgAzxrAw5Xkahq0Bx4abwVWad+TDttW+mHYQbPAoR/JRdyQhz
         oZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712330458; x=1712935258;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sJQmOaO3p5KFIWQo7e9dcSFLyOpbKit//7W5OoEH2M8=;
        b=bHqCvXuMCd4NTj6ZRwWZi5bGhpGREwhwt4IaPMhOcwEwu+TcngOLB3Odb0PZBMkqeE
         V5R6dlc23u8filWPKc5EzyZJu0zxYyLhAin1U0KwbQRZySzwfTWfpBjT99DgeebZp5YR
         7PXbgWnQdBppnr2Hj3lv1ELkuU6TYPpGtEMFw1Fz2h0dSeaCchtUZNJa5jCrWVzh5YnX
         YwI93uB0LqgwecQCUla45gRlEAqGd3fMINI+a2PFdlixVs1FgGJnkGNJBYY/EsVPVEtw
         S13n9BxPkAFG7Wpxxz22kC2piM8/ezk6VP0s/8AIg4+APLzcLVgdJoHCmfl/12/DF8oO
         P9OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVB65/KTzc3nVWep8hgMZeRYaQoitDSMUavhq7A11poN2MfXIWC5FaepIs84VhyBhk2SbKogztYK0ylAv2/15LpvI1v
X-Gm-Message-State: AOJu0YzGv/0FUarkd8LUje00IzSTmvT2bxFZJMSrqHaUnpYhi1fAR/16
	7/KGw/zUQDLYNsZI9JZ5tPjkMHu/iSnyrtrUmHjX3xxBtXWc/b+r
X-Google-Smtp-Source: AGHT+IHIDlE+O9icswyuma9W6eztpAlHAgGulZ0GvHS9RKV5uF1da7S3Wa00m2Rus5O1PxXQ4yLRFg==
X-Received: by 2002:a17:903:278d:b0:1e2:a409:38f0 with SMTP id jw13-20020a170903278d00b001e2a40938f0mr1492414plb.19.1712330458392;
        Fri, 05 Apr 2024 08:20:58 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902e18400b001e0287592c4sm1690903pla.267.2024.04.05.08.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 08:20:58 -0700 (PDT)
Date: Fri, 05 Apr 2024 08:20:57 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, 
 bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 kernel-team@fb.com, 
 Martin KaFai Lau <martin.lau@kernel.org>, 
 Quentin Monnet <qmo@kernel.org>
Message-ID: <661016d936f87_58030208f3@john.notmuch>
In-Reply-To: <20240404025321.2212492-1-yonghong.song@linux.dev>
References: <20240404025305.2210999-1-yonghong.song@linux.dev>
 <20240404025321.2212492-1-yonghong.song@linux.dev>
Subject: RE: [PATCH bpf-next v4 3/5] bpftool: Add link dump support for
 BPF_LINK_TYPE_SOCKMAP
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yonghong Song wrote:
> An example output looks like:
>   $ bpftool link
>     1776: sk_skb  prog 49730
>             map_id 0  attach_type sk_skb_verdict
>             pids test_progs(8424)
>     1777: sk_skb  prog 49755
>             map_id 0  attach_type sk_skb_stream_verdict
>             pids test_progs(8424)
>     1778: sk_msg  prog 49770
>             map_id 8208  attach_type sk_msg_verdict
>             pids test_progs(8424)
> 
> Reviewed-by: Quentin Monnet <qmo@kernel.org>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>
