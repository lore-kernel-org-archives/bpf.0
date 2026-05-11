Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063EA2701B6
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 21:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778535133; cv=none; b=S1yqj3D7nihpPdbhKgnDY9GD2fs7EKOH9M9u8mru3gq6ch2wzIo6VaLSmZwreb5AMr0irvTyd04CCQ7D9rm57eUdwXWEbH9SKRmPBejtlPs1qzjdaIbQRkDkUNd2hvGRzEj0K7+sPQrcaOOajYMnV4fb3nRn+hO2UbRla83SPBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778535133; c=relaxed/simple;
	bh=mJtJbJUTpQ7d3fg+DS1a6CipA6izkFbDqaY3PXGtlxQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lk0kLRBzrDT1nGYPvAibuqgKFlC/o/fjcEjS5QfyFeJqY0XeEysTmDZmqyc29ozdnbCKp48OhI4oUL84K1wrZh9BaCuhWlGGAiaZz4Yi/anJ5+wiRrLfHrJ8qAugLxU3iJgUc6DQpy2q6d6YnB3+IMdvtbbDC/l+xxuF5O/2slI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2y9gkDX; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2y9gkDX"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c70fb6aa323so2078561a12.3
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 14:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778535131; x=1779139931; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mJtJbJUTpQ7d3fg+DS1a6CipA6izkFbDqaY3PXGtlxQ=;
        b=T2y9gkDXrilVfvgA6e6123+PJ3wjEgQV1BPlAt8gXLvYeNdFaDCphZx08xL4HzrNiT
         ENX6q6kyhBgvlApti0Whh/Gt0NML5BbgvPckglRqOBTANv2FH2EQUy7Y0kaTdMRBnJgl
         XCrbR74XC+kx9IoSZI4EIVb10PB6bxwTTUveySULMyvapb7WnTo4vryXtrN87+cYOnb8
         vgzE/oclQdFlpOlEVZsmc8QeTCWUGVj4Z1aMJDikFzM7HvkUk7h/xYwhvQfKa5Xy+m1r
         EEkNG/PcyhesZrvcf/bD1HPYMunkB/oeoeNVB87W1W+JKHzBCSTvDQWdBLIXy0pAIkjk
         AoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778535131; x=1779139931;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJtJbJUTpQ7d3fg+DS1a6CipA6izkFbDqaY3PXGtlxQ=;
        b=eg4ryC/DPSJYYPc+w//66qfyD1B8NVzYyh8jDC5b7ge2vwBWo9z8s14syi6GarGxFZ
         tEnc45IaRFL7yEHOeOujLGjrC5BIqBXPJpSYTVyjUOvfJB5gOwElSO277YBO8MiykTMj
         0UPb07r5/R/cmL7i5bE3/AJFG6/0KVI5O7t6/n4VqlLMyfZ2knWUhY0yaeNgZjP5awhl
         RxPWiXBKNijVuPHanRRaDbcaWW7Olx9wlWzfPsEKfk9vn6CJZe3FT/8WV576IhbIHKRq
         limAjJ45XFpHVmgIQaZiBiGmDkT+bQ3BViaa10Cra7tTopu5lYuOk3A12hI+Qonen/B4
         Wipg==
X-Forwarded-Encrypted: i=1; AFNElJ8hhDKb2fMCfiYt9hfRgfzRvdP0bJh7l5i9fxwdRyd8W7vvhe0EgUDFqR0+fMQjlLbWKv0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5TyzmsrRiR+c67fA/Z0ap+oL6DIZ3YoKmbMzdutTbfbBrXL8H
	tL2wI2yQ7J1aE1diqK4iRh4NofeIJl8oaI4/qz6TTyCIw9brKHoj+sna
X-Gm-Gg: Acq92OFbz+tBuoIn8JNkzi/WdTUqw4haGny+jGLCJEjPLdOVLLeTqbiT6ktsQSY82lq
	jlktl1pJeBvZ6cWSVD42dLWbvPIdHmkKBpzaCNlENhNf3CMK9MU6PyJR6aj/XfMRiMxmfq+7nsl
	U/vIm6YyMgE2x2UPj0uPTlPUZahEU2y03Peq1E2rHFFVuC/LCEdVU4AGT44DMpwXZ2ZUwr9G4mz
	zoRCdGTAmmq/YG3Vx1YTh7styX8nE7JBJN2ZZRQqc2Uj8FdehP+wc/FQFaQFyKYTOJGs9bBpqCu
	GsfZlIKGl4TsYsUAHQwfI4IiCVkra1zESdnCy1/5wc9WbQuKrBX/IwGW5FJD3CBG8zOvD/qhix8
	qu0uisB2ZFLWuDWAdwJ+Ob8XzU1IGbUKLtWk9TBWOjaU0W99Ljn/eIMg+MrY3H9Y2XHCj2v/1LG
	nIVUJChKxQnhu5kFO3MCf8J1TCSz6VntWqs8R6JQ2CGBxoqnlpIxmx
X-Received: by 2002:a05:6300:8b0f:b0:39b:dea7:5624 with SMTP id adf61e73a8af0-3aa5ab0fd90mr29046701637.47.1778535131400;
        Mon, 11 May 2026 14:32:11 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8267688fe2sm13220236a12.9.2026.05.11.14.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 14:32:11 -0700 (PDT)
Message-ID: <ec274df02803a681bd85f4db57aee5fe0477e80a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 03/12] bpf: Assign reg->id when getting
 referenced kptr from ctx
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Date: Mon, 11 May 2026 14:31:38 -0700
In-Reply-To: <20260506142709.2298255-4-ameryhung@gmail.com>
References: <20260506142709.2298255-1-ameryhung@gmail.com>
	 <20260506142709.2298255-4-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-05-06 at 07:26 -0700, Amery Hung wrote:
> Assign reg->id when getting referenced kptr from read program context
> to be consistent with R0 of KF_ACQUIRE kfunc. skb dynptr will track the
> referenced skb in qdisc programs using a new field reg->parent_id in
> a later patch.
>=20
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
