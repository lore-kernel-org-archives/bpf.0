Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F8435F182
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 22:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774390181; cv=none; b=hf66GhkN+lRi1vwwHVFQIsxlJ0OlIurhdBoRqZ0p/CJ5+BjYuo+utsEprvEQnWzM3SnxjobDh6/024BY5UsOhtznomYYGzFoRb7GuUXptUN1k7IgQ9yiVWKrrNhNU7xW3zVs9KEqCmDHAXB7ATe81fRHR+N0//vDj0c8SE44cVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774390181; c=relaxed/simple;
	bh=y6P9MPWTMWfIwA+Y0RPOqdVnrenIsDWCepAPE7AE65w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qn6Pp0spKwoYrtREMVOy07tw1hs3YxuELAwWIkPnsbGByyaQ/FaYhrQY6+6us5PDTWMYIzE2s05fj/InBJtsvkV+ZwpU3wqiObr0Ae4eF+pN2AiKF6wSTkW6jVSQKoS8meL3Lht+bw0SWY2BSPdIhPt+LnUXZrm/tMkBPYW9k98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ywszga2H; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ywszga2H"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-126ea4b77adso6326503c88.1
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 15:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774390179; x=1774994979; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y6P9MPWTMWfIwA+Y0RPOqdVnrenIsDWCepAPE7AE65w=;
        b=Ywszga2HFmuQuTdvu/zxbBrW9XGQ6tVcns2jt29gbn+VE5LUEELHwd97BAHQiZ4GI+
         LKdRy9tLJky7ERa7ee77MgE4qPD9UR0Fnf4Aq6Mh+YpfMfJ2xNsOJXykDhFqQWucHDsr
         KxxooI0UBLWh0y6yUIbCMzdClIe0OKQ5hMT1QaArK7weX+U6ti7LwvXf7LaCGh5XaoB0
         ZQOm4GHh3pLOnDxjlmUMgQZjH+Kt9nRXSMy2YnuMXo8+WxFoB6y94EdOpOOvDre6qMwl
         qXsKApS1+Mwr7xIhx3aOkQWRzyAm7WbmjAgDX6d+OFoGrug8ryCEzqp+8uR4DmjHaSW/
         uIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774390179; x=1774994979;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6P9MPWTMWfIwA+Y0RPOqdVnrenIsDWCepAPE7AE65w=;
        b=PXG+WSyDVhWYv3qBJeJJmYXfsz6DNbzV9iJwYZMmqzxpYwTlNqK1T+ybFEQrDLD/Vj
         QxQBO7Eu8m3IeEXFVYu9o86hxpf/D817Tr8iJb4XaqBCM2nhT5W+h0oo1f67gIGUiHxA
         7Cox+G1hF3N6amLlKBDl3gGNWN2a8qqhcgYbUFAThhtv0n483exzN8VVzDmF1iyEdUjJ
         9xKRaiafYN3NdyZz9IVeZ2Synp7cUm8Ds9w0RYtRGZFlCw0sbY6kG2TKcjKvA47qZUuI
         yekpXhfkKg/vtiOZd2cO1btKlODinpAAKd9oA478RvN6T865UpzfXQ6plvGOVzbKr6CA
         tuvw==
X-Forwarded-Encrypted: i=1; AJvYcCUvzzW5g4H2VJZUcy0nHWJsjIDcYpWwK97lAi8jDRTEvijDTWoRuBfpSOq8SQMDFwI9uMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWTfVn8nnzvTpMoF+WiLf1nlxoMJUTgLqJ/nZcYN2YsDkli4IY
	CYCoFA9lh6mR9HjKuBvvK8xKE4wLaf2ZRKZ0Wwp5rPkZmF6jq7vMbooh
X-Gm-Gg: ATEYQzxj3IC1LX7hnMkqCoJM2EO8MF94U4U0mHNqUrG3lzMBZfyH9ufldwdKqaaWl6J
	ELjecw+1tKD0mpk9Gjpy/UYpOFGaPtP46qfCbvFO1S70QnrkD65RY6sdf1nW2R5q10+dY5/70B/
	syQtM9QupGpC+qg8qtHIBQW8JnJoQpJLek5pwp3e4z0fOhNUyZh+GGCFI7vv+zvOfOkZGFfA2Y5
	ALEaeK9JSpTFhs/hgYuA9mE2RfP3E+TFpVJhDznsR3dqHq9d8UnPuTUy9N/zbT8qGtlLkJZ+4Qc
	xV2OQiRCbqtwaKApF9R/6ymfPQE1YSn87oKc/PVHocwIAimCO1D4/nvtSVFhHxuATV/a72EzJ5e
	Vt9NMeSVs7u1sEfWa5nLjncDuoHNS1i1I41a4+YKIdN4qiERFoUV1AG7dSljfVb3zoCJB11acAD
	IO0Q5wgzjsz2ZKhMmqs2DdPOHXavsVJfC63vuKDfccpBu/9CV+BnfkoXOXsURXPS0obir46Y5zN
	0gszw==
X-Received: by 2002:a05:7022:69a:b0:128:cc34:35fc with SMTP id a92af1059eb24-12a96e5deefmr525678c88.16.1774390179193;
        Tue, 24 Mar 2026 15:09:39 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:41fb:8dcd:b77b:d6ce? ([2620:10d:c090:500::bed7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b14caf3sm22183879eec.5.2026.03.24.15.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 15:09:38 -0700 (PDT)
Message-ID: <3d751aa82864a7847e0da881927c3a0c19e9fa93.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Fix variable length stack write
 over spilled pointers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com
Date: Tue, 24 Mar 2026 15:09:37 -0700
In-Reply-To: <20260324215938.81733-1-alexei.starovoitov@gmail.com>
References: <20260324215938.81733-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-03-24 at 14:59 -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> Scrub slots if variable-offset stack write goes over spilled pointers.
> Otherwise is_spilled_reg() may =3D=3D true && spilled_ptr.type =3D=3D NOT=
_INIT
> and valid program is rejected by check_stack_read_fixed_off()
> with obscure "invalid size of register fill" message.
>=20
> Fixes: 01f810ace9ed ("bpf: Allow variable-offset stack access")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
> v1->v2: factored out into helper
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
