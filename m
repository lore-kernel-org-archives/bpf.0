Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ED7437479
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386958; cv=none; b=LdVU+m7Gt2R7PyXSWZEgBRIP/0QhCzjcpJ3d5cIP0pUuudyMj1MQxfQDdTs04WjzO1nW4L7RAhSb1WvBXKbD5+80+c0rSOybZgzTFVSoVqY6JMJDrjjeZKuIMMk7syAlafPZBU5PwOF/JOprHLeek0h8FjNJn63XwltyLnUFlZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386958; c=relaxed/simple;
	bh=ZYUXC9ZCR9/rWG9taTTSNiMU973B/OZYYTLibocIZFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EA69PcZEvbso/FwA2KKMSytqd66LeAiGHXAKxTlS5nr3t/qVRkZwsBbwkAkyOqhIM4VIYH0qGuJ/6/7DErYPIF/c39nGmbC626TWOSBeSPEV9WARP7KylpPH09P36mlI56Wv9+VWIL4YijY13/tGoxTadcWYKHq7pBCrDKHCX4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHewxEPE; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHewxEPE"
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-380feaa05dcso17391a91.0
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 11:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786386957; x=1786991757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nhslA0jkldnpPP+YQhiwhTMBXASBp0nWG2npEOZu6Bo=;
        b=KHewxEPEl7HSBU8BXHOVyZPEDaViFEvJArXGJj7JBwFdvvjhIB3FlF5vYiNAIHoGJy
         SfYNXJdVs9yzZYKJSGDpUqZC66mTKwnUUqQV+L4zEbnSDcPbaoNbUGQN7fE2ek8/goix
         76TUT4XL6JHwYf6LNBre4DReoy5UVq2ebkPb370y4vLWHkmoiqKunPoPMu5c0PoN9C7G
         jVU8MKz8OznQgwvbPyLCupykHDfPxBoq/DxTRNZPpc9HfG134GxbWhstcs4BDPZXpc9U
         /NIuIvBAJYPX0MiRCKYb6STgXOCFlbKLh83W9TKCJ4MG33dvWdNMwFwuElsKGjktpj1+
         jBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786386957; x=1786991757;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nhslA0jkldnpPP+YQhiwhTMBXASBp0nWG2npEOZu6Bo=;
        b=AOHwyr6wEi6pYspTmzO7+o9Mc2cddrPNmf2b0kScOtklqKWfOhsZJDKJe4h1qR/8ND
         prekSDOJVBWPPTh+3X6JMdHIVLI+sDvkJnG30jb0F5BzDY4IYUtuoB57ECBgHYhUI/Dt
         VSBiOL3fBwWwGLsFO96/sHPnYQR+kS4t1aHpQWVL6iTS2hm8Ct10vNpyEWdDx1oGOAGo
         G4MIsry67jwgajvjtnssrC5G8bq1D3paMmv6MEIEXCu5EEYFqIbangL6n5/YN1VF8wta
         nxrJu8VtHEiW6pCjf+w8lHAyuqRjOqAuRfE/BvfoCEi+bCcmIEo1IzxwWbgCka4Pax2L
         CxuQ==
X-Gm-Message-State: AOJu0Yy46Yovy2uSyIhcCZ3NeEF1f9dcY2pAKJPL009SE3BeNZZc9iy+
	y6ICm5a1vXrBQZwpJfLU3OAQdyCqZ3NZ3/u8Jl+7fhlWaW/PUsIw7p/C
X-Gm-Gg: AR+sD13TSkio5hLbTJCuUnuL34N2slG3Ce27+K0qIo7r2hJxUxUWmf3plCtMVyZt96O
	x4j9KrtOCii4YEcGhH3SEkqv3KtsY5rzraGdDrGP3UTOA252ursQ/uSzoOGXwg9LvkJekD/kXLN
	RJhPHzxtvCzO+2QuZERONjWi65FgTIrRQv+zdS01bjTvG75j5h5rpErSNEAIxBH2XHEkWZoqJqE
	3PtPMY8COKo43axKfnjShh4VYkCTRavHbGB1f08MoxVn9SbS3hgccj2dDJGxpuGPPv53cEWGhDH
	j/j5L5tEyV6beyvaNRgmWv50VWPFoB92njz59VkOM/Dni9Dh4MH+iveAkRyv51UvQUoZG6hcfxb
	Lzjk5VTz7qKwlI2tTaGjfxPoZgAvoOKd9LFfETjIaFJOSGUPOdLbGbLVn1YxYLQ7iMRm24fcWio
	BNX3JfBs6SzbwZOlOj6lC6XdxKSxZJh4f2NUdA5tbjP7ytr/WI+hP8NA==
X-Received: by 2002:a17:90b:528c:b0:380:9f17:6df3 with SMTP id 98e67ed59e1d1-3903c5448dcmr47307071a91.4.1786386956804;
        Mon, 10 Aug 2026 11:35:56 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d51c2a39sm576472a91.6.2026.08.10.11.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 11:35:56 -0700 (PDT)
Date: Mon, 10 Aug 2026 11:35:44 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org, liamwisehart@meta.com, 
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org, 
	ameryhung@gmail.com, kuniyu@google.com, memxor@gmail.com, jiayuan.chen@linux.dev
Subject: Re: [PATCH bpf-next v5 5/5] selftests/bpf: Add ksock test for async
 callback guard
Message-ID: <anoZ9ygbuSZPru0G@devvm7509.cco0.facebook.com>
References: <20260807171532.125149-1-mahe.tardy@gmail.com>
 <20260807171532.125149-6-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260807171532.125149-6-mahe.tardy@gmail.com>

On 08/07, Mahe Tardy wrote:
> Because the kfuncs are going through LSM hooks, allowing their use via
> workqueue callbacks would expose the wrong credentials. This test
> ensures the kfunc are preventing any use from these contexts.
> 
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
