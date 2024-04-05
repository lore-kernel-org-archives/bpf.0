Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C6616F850
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330427; cv=none; b=laWlH2ZAA97szDbynLrFzzgk9SxBHGBy7cYsSoS1Y/bXyFfMccbDju/wwMw0J6PQVTP8MXqsp13+ekto0QeQPPy5RxtInn4uDifyswqqNfdJgszxX4zsaRFeOxsNoyxGFeaUFWnA6j8u8cpdX7rixmm1ag1dcIkXbJcadqN1kjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330427; c=relaxed/simple;
	bh=UZjaAFnvheNmrWurX8yCb6mGBktKDAjudC/vJFSJZa0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=jc52nTEO64s5yK8cEdsy0Qc150/cX5PVLTGRgbTwXQpSIznHagnpvvcJiwiNoPpnHqIeGEv6Z1eTNkPKx0WgPm7K+dK7v5cXFRi8YeaZRaTz9G0o03Vs1pJTjTDozWkSiWPL6kX6Eq89toHX/Wt+k86S6kGsjP63UZ3xxHNb4bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXxpFcjq; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXxpFcjq"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2a2d248a2e1so1416540a91.0
        for <bpf@vger.kernel.org>; Fri, 05 Apr 2024 08:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712330425; x=1712935225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khktNbgcrMg4lWtVC+HHmiY+qicibrhDhO5K3Jh7lCQ=;
        b=eXxpFcjq31OIz9RoyHnnHtJFARNOKo80GXVbF3CpChxv7Jeq6RygoeUYqKMGilSM4T
         JfPwBq8T/oWOr9hVNf3PHJn2zdhyBCcn7eqT/wzwCuKIcrLhZys1Pem8JkbG76XHyzBv
         sYlOuMz9mojHO3OoOvwwN/BsQGYHW+y3C6hBY3vpKTCR1+z3SXvXyOqMm9dOcBnqYq1B
         xr16YVZyTKjXSMkmM5ZphEVlWOxdg6soeblfEbrZt3AsZXwe9BDg5SdtGw0hl9jAgEbv
         5ER/jl444SbDsarnEPFvDDxcvW+IQiYKK/CRrxXLrvgjzGyrdpVbrotnYTKo+mSCuNuE
         g/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712330425; x=1712935225;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=khktNbgcrMg4lWtVC+HHmiY+qicibrhDhO5K3Jh7lCQ=;
        b=j4T7JUBKCzqP5OG92e5q3RZf7n3/QuOP9bCugN7NVZOVws/zMM5y4TZwep6Mf/vTC9
         cgVeCOqBvl7tgDYY8ij8Dgi5yBGBsb0aZ3ExOBlnJXQWYl13PJN3cGhvk/HnrCfFJVgv
         +J9GweJbuuvVX+oAH2qpGFQpcdav1DKlrMKfidBxA2bO7fDRdsTb7/MddHHp0OUhWAcH
         k/VXfzkTx8KSAx7hxzOTd0F6vwJWOsykGM6bIi3KnlWtt0lRZPP80DZEmytgrD9Qof6o
         Alm2IeDU4fG1gDGXz9D6ZEvm5cRVMyBU6kALt3G8F/WGMwwyyQ2zBbf9tPoGJVlPBXqa
         SY+g==
X-Forwarded-Encrypted: i=1; AJvYcCWgbFGZQUCOCRNS9rv43iCU5duPPwu5dkG2Ub66YaWIAgM8iwtxvqzoSo8FVFnPHtZq9mhnVVDzn5Eq2yabJmyYaquM
X-Gm-Message-State: AOJu0Yz+cXkAA14R9bdFT3uJYAm1zUqdOe5cNXaBLrBYDC2XyuRyyHGp
	Gh9vzTy1jDJNzBxqmI7zoeOpLdHbHU4sfloxVdOzBwA0TVzHT1W1
X-Google-Smtp-Source: AGHT+IEB/U+UT2BBWCOGsbuGxemIQPeZK56ELSDVD8edrqVijbDHEMoLVGIJToexDiSfwUL0Q3iu2Q==
X-Received: by 2002:a17:90a:bb97:b0:2a2:7494:15df with SMTP id v23-20020a17090abb9700b002a2749415dfmr2679497pjr.9.1712330424935;
        Fri, 05 Apr 2024 08:20:24 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id s22-20020a17090ad49600b002a03456ccabsm3477391pju.30.2024.04.05.08.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 08:20:24 -0700 (PDT)
Date: Fri, 05 Apr 2024 08:20:23 -0700
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
 Eduard Zingerman <eddyz87@gmail.com>
Message-ID: <661016b7a5a33_580302086b@john.notmuch>
In-Reply-To: <20240404025316.2212069-1-yonghong.song@linux.dev>
References: <20240404025305.2210999-1-yonghong.song@linux.dev>
 <20240404025316.2212069-1-yonghong.song@linux.dev>
Subject: RE: [PATCH bpf-next v4 2/5] libbpf: Add bpf_link support for
 BPF_PROG_TYPE_SOCKMAP
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
> Introduce a libbpf API function bpf_program__attach_sockmap()
> which allow user to get a bpf_link for their corresponding programs.
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
