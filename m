Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D542C21F1
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 19:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784317542; cv=none; b=b0sFcLQS+X7wul/1YztGkIordCg41a50mIRuKYcPajbazBt/m3SEnWlm2t61nGAOWXdz8D8q+e590v8QZDl/vxb5VD2XrdfZlHpJZk/rIU5nEmQo0xH7zttOrt2k+IL6TMWS8NefD54HI1qiY/pwNQG3QayCFVeMX3VKtUqdY4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784317542; c=relaxed/simple;
	bh=w39gpdOdAZCCy/sBAjAKU7RRDVxYVaLXmEz0ABBfi/0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qtk78NW37te3kJGj57J1LXFHLEckvwmeltI/4y53dZ2vbPWeEuzRHW3FCFjGfAvwdWVdSgcIxu+c0xWVwcftv+Kqj8nUuEFVkgVSt5hNfe9rQsKYI3/tSJa1bNRYc/BFopwfMviJmsRZxyNiMQ5gO4VJ9IcULTIr4MI2V1+pkYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEx9V5eC; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEx9V5eC"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so4392518a91.2
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 12:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784317541; x=1784922341; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=w39gpdOdAZCCy/sBAjAKU7RRDVxYVaLXmEz0ABBfi/0=;
        b=jEx9V5eCm4mxLywSeG5ebgav/9Wn3k995efFmZgSMT5rYF2Ur0Emrc7H0vEv4j4ONg
         A5cjeIhGwFFjyIvFNIcLtzxgK/sK5KcMnmBBVe1QpQPi3b70CO1ha7vCQUCh7ISfGT3A
         iOqgYbCGPrTDBXpkLpaRnL7bBAaAPt+SfX4ST05SHrfVmmPOGaYN730X/46sYfhTe91N
         QYXbqQ7UglIIeRAb4xhTAcPcG4P1F5uCw24bJtZ5DpoToafIXXN6QvuO49uye9lH6tcB
         BFn5fLzXOkiZvQeQcqzVxOC5VUbsjLY5n5y0CIQpGy4Wpech8I0eIJ4LB+uUpsCrzvBh
         JZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784317541; x=1784922341;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w39gpdOdAZCCy/sBAjAKU7RRDVxYVaLXmEz0ABBfi/0=;
        b=UnJ/BbtDTFM0urKvNmdbhlrpM88GEB9eMQhVY3cH46Pec5kYo3kOkj/GBL55rqUCEa
         hgmSbtSiNaPqSyi0mgqB1/loZkwxatAVxkYYmb4t2erJ7Pd+tG4+nKQyyOhGo0bCTFJ/
         Q7sbI3Aiaqb3Ym+cVcUq0ph0Oiuuef1axkxI3F5tFoN/pjXsghuxY30phJ/Q8qPkM7r0
         4YXKCwrR9ow1m2ltYRG7y4q/xdiHRZb3F5V8gg2myXC8xaZ1k02a5ZK8a0oLBeOnqucX
         kGqXJH9xD7BhzqYEq3RNVIl7kzzrkZvoTKjdSmAaSdzxM60ZZV1vjJSMfZz+xMmUNN+n
         E7nQ==
X-Forwarded-Encrypted: i=1; AHgh+Robtne0+FQKgoIbKOD5jFkb+R9IiBl5p4lDT43e073EmSChI4yyMOTITUl6yH6P8JNEBRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMfFU7CnO0uT8RE4qgp09NA8AerzdznW7JJcuESCPpV+VtSXwn
	3a7qZTHvTe8PwAIJqYaKKWnfayFF7h4OWNg/Q/aPcRNx4DUHTAnoVjTL
X-Gm-Gg: AfdE7cnzHQlrC9VVvEYq85GC1Al09DQDOBIqdkH9nBmdh/Y/OXVvA4LHBQ5fhBT+B8j
	bT+65zQk2v3Bks/ovIadi/B7Vho4eRiqPQPXb1kYSFfloRSvrnhgv3E1FIBcFmVvhkLwG/D0wtm
	WK7pK4HrZZWd0Rwql8bR8A/ZCcgWH2U+2Jg+dQiwYWgYJcwOZAjiz0PzHTWQvGQ/G0SH9Daoz5P
	6VXrnL8rql7ydgN9YsPblfcxNpQqf1ngu7oZ98UO6EWI/+JYAcuMxJyX1uAIWI8zl+2n4/5Tc5N
	xT8QVfXUSVCcpLtQ3Kh71LupwlyRzwfj43CdeGEl2cMdhD8t89uT7/yka6xgr+D4Sh+/jo08+HB
	AemgLiKSgCSHNb6zgbax4+AcSQ/9V3DSIRnZAHMvv7wvmnvo/y28EsdHbx/Y3SX6VUrFEMB0egF
	5i3eXvyhAIkJlIMNXb/Pmia1eQnVfAwH1e3FjZZcHQasjj0qCllobZlwFptQ==
X-Received: by 2002:a17:90b:35c1:b0:38e:485c:ebd3 with SMTP id 98e67ed59e1d1-38e4b43145bmr4412372a91.15.1784317541049;
        Fri, 17 Jul 2026 12:45:41 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:87e3:2c3:b68c:94ea? ([2620:10d:c090:500::1:14f3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a210571sm9872397eec.31.2026.07.17.12.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 12:45:40 -0700 (PDT)
Message-ID: <f2116abb909f0f6ce85b6b8bab0a687580a1fc00.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] bpf: Inline bpf_iter_num_destroy() kfunc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>
Date: Fri, 17 Jul 2026 12:45:39 -0700
In-Reply-To: <20260717120215.2171057-4-puranjay@kernel.org>
References: <20260717120215.2171057-1-puranjay@kernel.org>
	 <20260717120215.2171057-4-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-17 at 05:02 -0700, Puranjay Mohan wrote:
> bpf_iter_num_destroy() only zeroes the on-stack iterator state, which is
> a single 8-byte store. Open-code it in the verifier to drop the call
> emitted at the end of every bpf_for() loop.
>=20
> Inline it in bpf_fixup_kfunc_call() by replacing the call with a store of
> zero to the iterator, matching the kfunc which clears both s->cur and
> s->end. R1 holds the pointer to the on-stack bpf_iter_num.
>=20
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
