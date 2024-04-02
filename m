Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AED160279
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 13:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063891; cv=none; b=HUpp8WFZzwD3a3BrQt3kM6ci1TSeUCJZdn4+AugPL8+ZlJP6wb2PgZMn2aYTB7h/YVgHo+qt4eWblS2FT5hN5tzCfsz42NiKMzpaNdvnu+ake6eO1A1YKMh7k6DLWPrVNvTszTcRkURtvUeyDkxrz4T9LMTl4qzSSTNEVqML57E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063891; c=relaxed/simple;
	bh=OVCLk3u32JzOpr6+9dU5/06h69+enA1CRI1uTGJUSeU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qJ19bMyuNGg0KZh8CBsTd7oGdwyrDKChOZRCrVocV9GZhY159UKSGw3JKpgAGy3qD0rz0gRjdYCXelwVrVcorUyR4ZDGdjLx2CSxYiC6NF8IGDj9ePkbtQTdmjof0ySWDGGM8kdyPARBdzJCWPv3L4ZwB9JrCBwYhvS4+ufhFpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1kRAsvd; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1kRAsvd"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a47385a4379so1087828666b.0
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 06:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712063888; x=1712668688; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OVCLk3u32JzOpr6+9dU5/06h69+enA1CRI1uTGJUSeU=;
        b=j1kRAsvdOu0CM5aREn+oJzmbS8jIc7kCpWyc/O482ekVYWRVNGKt7zozP+Jm5UHA82
         FlOiz7ZIYGlZoaU5lWoHrNs+7hdXGrKwMA7Nk1f+dYbNk1f8xHwWCxRRl0Dc3ZgmgosX
         jil67m6Ej5TYsuN0ENW81TPBPGSRtxf8erTcTfDsJ7coxZueCSxesz14CP4wVSoP030o
         yhK4c1lUQO1P76rmzkFBSvk7NzwkHGaxJNdxxcvF54aDs/AW93ibqxpOv96DQcqwS3Ld
         Ms1sHK5sWGvh+2D7eWZxqLZx0fBvSLLOWwyvQt8SW7+vB+n2/UHX4JrjL2RWsS8OzQA+
         mTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712063888; x=1712668688;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OVCLk3u32JzOpr6+9dU5/06h69+enA1CRI1uTGJUSeU=;
        b=RLzFQ8G8yL/fxMw8vC+h7e8enDnSw0dUG/rSxtSBqsieNQOqnW5ukekBOTo3OIl9of
         G5FfwrXeI+jLmP3dtRulYkzmOtx81s3oijfHbL9tmUVA27Vl/IuDd24Jgou2Xo1S0wB/
         J+9jfMlv9kWAOYUVXNILBDEiOR24bZXwm/WD9ADx/aVKON2rVY4UVMMzZsnf3hv4k6V5
         jtGndP8toaVTZ9Ul0KmqEm8/RDjymRAe0uRzUk8V/+FEpk9NNt8w4fnFreVfaUcVZENX
         ga3zumhXLIuyxkGC03xcm16WwkILY9Ndy6l7gKMu1hwbfphSSNObhqmYS2WZjmzJtSUD
         9FCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWiwFkEuBzvVNnSrujMbE67ufAXH3cZtVnQKG77SkppT4nAVIQTc93Ky19jwOZeDx8vJlRS5ZFylGg5SdLl3Ml4ZzV
X-Gm-Message-State: AOJu0YwxZxxHqwBKBd58XDYKRa7Pb3wzrWNbZ7zIm7e3rrEgAIbEZgCT
	Mh1pjMArpQdDLqxFfZdLAFjKMdS1OXV91C25sZQaaYP0OpIwNIY1
X-Google-Smtp-Source: AGHT+IHko1AvAUmvH5v+zqN8zoWVVSYcqPR0zPYieMJbMooI0PNIPPDdgHtvVGApu09s/fOaGnOWxw==
X-Received: by 2002:a17:906:d286:b0:a4e:70ed:e2c6 with SMTP id ay6-20020a170906d28600b00a4e70ede2c6mr3977258ejb.31.1712063888480;
        Tue, 02 Apr 2024 06:18:08 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id la1-20020a170907780100b00a4e8e080869sm604581ejc.176.2024.04.02.06.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 06:18:08 -0700 (PDT)
Message-ID: <03f8ba3fd8f3fe0f66cf401356b81559822ec0f9.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 4/5] selftests/bpf: Refactor out helper
 functions for a few tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Jakub
 Sitnicki <jakub@cloudflare.com>, John Fastabend <john.fastabend@gmail.com>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
Date: Tue, 02 Apr 2024 16:18:06 +0300
In-Reply-To: <20240326022214.657480-1-yonghong.song@linux.dev>
References: <20240326022153.656006-1-yonghong.song@linux.dev>
	 <20240326022214.657480-1-yonghong.song@linux.dev>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-03-25 at 19:22 -0700, Yonghong Song wrote:
> These helper functions will be used later new tests as well.
> There are no functionality change.
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
