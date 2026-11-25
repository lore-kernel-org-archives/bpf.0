Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795615967;
	b=gh0ftxMh9pRXQHJZp1LjWKpvT+2cWHqB26pNacfsOlmc4LZc/+Y50Zm/qJMcIp5s5Xhg
	 R/eyUnvTITqlGmkuDzvKQNO2tV0zRne/ncQcV5YCF3clPSxAjV7iXbdpGavyyvIsjFsvh
	 6PS8sJZFNuzuQNP4NvwCL+VcAGQR2lMlBsOUM2p1JoApoeiqdmQVeNvIcNqrM3nG6f0wE
	 kHBUICGaOyfUl54/3Vl27oYESTo933sqzvLKCVgn6x5R8ZdvKeu9w1JS3ykSbQmEgJKSv
	 ooFao7iY1k9zmBPwEIlelfqkol46+Ue93tzn+dd9ciFxG/yxz/LvhNf29UV2iinVi/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615967;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=+j5ASClty8/ZKXrnqcuhSTiI2lW3GfIrSFmOpzRXZaU=;
	b=MKv8ZsmUlibWcbPO/qAcPDFBfFlT3ZOqyWC/9QvByUSRgkx7QjnpuEsxiwiPF7kgM7QI
	 X/nuqALe+JTrS5zxiaRLZpUK7rrWwGGKSn6558Wjfxnun7XHK6KHxt92uVIBNrOsbamxk
	 Dbota42hfgQ8lDok4fTEKPaXcBuIcKFILCrktEOxfdsbROdAcV/T1qrLEe8AaXNlsvr6c
	 es1zIqXF87bn/I9ekeeBxMGTMTuepRDyoYITPWhfvJ9XcDT1o6CVqJtUfo7/xF+gFWe7N
	 L5duGkiR0R7OIpAvcn0yL5/EzZMGk+RDkjn4mrlGuWCYrXjyt/phF1niZVuQ67qlaMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sentinelone.com;
	spf=pass smtp.mailfrom=sentinelone.com;
	dkim=pass header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=dDeTy2Rr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8241606A329
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 14:12:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8241606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=dDeTy2Rr
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ed3df47bc7so6194625ad.0
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 06:12:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795615966; cv=none;
        d=google.com; s=arc-20260327;
        b=benz4tkvUZ4LqT+Tc5V7yiCiQREOTJosHN743sPqmUxgcwKgs7/4++38m8xfZHvOdB
         csH/KdRvjAwXDx+Tf06KuWtEa5Ef3wi+oGHuv9SOS/jwSTqOrhQaW/Dd3r5NH7JL6DQE
         Ub0/cMf/va9qItGaKwBrOQ3ZcbQN+fAhOvoUoUul34fOmxOULQoo4YQa5l0G4asPffUJ
         8YyqNRyn9bc9MaRV93mJ0R76bsFo7tAAlM8y9JspgOa3la7Gn2vOdzdg0rUvBePx8gZV
         +n8kNP4hsCoOTdOLgXRBaT5L7IlzDt1AjlALU2J2L82T0UYUQ/fEWkuCm6B+Wx7NtoRV
         1yoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+j5ASClty8/ZKXrnqcuhSTiI2lW3GfIrSFmOpzRXZaU=;
        fh=/tzMfYPNLANCJX6H8y/5dBLiFUFYbwO44qzn9v+Mhn0=;
        b=ERI5V8iUnfYawpQgeZnwBKtgAU29Bavd4ORCamW6YwFIf3pJpkUo8jk4V6QHBokngy
         S5gPanB6jkW2XHQs1Ud0fk5BgTDFO9086IgDB7tY4HVXCel4xfi8EKCNgixjkBfFIV9u
         IL/kZgVSw4kNQzZoMFNEgje1IjGgVxH7ncowzGiG8aqjSGxV5caPCo+iBZuoRxA7gRRf
         8S2UecQrEs45EZouWT/cc2uHOAC2+4d87SRn5a2bib5wrS00YS8JsbhOCRI3YiYB/jV1
         AjUgmQ9zeu8MA6OVL20Z+DKYecy7ddmr9D2NZ47If+1TMYhWtU95GW7xuB03ntiVhMm1
         bo0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sentinelone.com; s=google; t=1795615966; x=1796220766; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+j5ASClty8/ZKXrnqcuhSTiI2lW3GfIrSFmOpzRXZaU=;
        b=dDeTy2Rr9s2Rac8C7vb4lUCuu1aLkI265b3Dd6A3RHP0Tda/gW+a3I9JA8QPYMpG7o
         sp3bIVjAmhy+7kK0EYbeim0rN1VCdPk3bMeYF+aTTOUtGaixEYoQis2fVYc4opjYRUJt
         uggEBl8SlXCoz0e3l4qpT3CjggmqpDyNGaED7GbXsei9uRIUYhz5y/E35WAuW3vgUCZ/
         hTclPzUDxe4/lxgWWAyMgVzpg+JJgyfWe0ZqC6qbA8RzckHLq7tGzofGnyNaXfCF2Aqw
         i7k8MtKe9uII98rn8cLoWJdhV40HZLyxMegmuojtqRnwGeEXBxuN2I4D91JhyxjU0hlg
         2v0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795615966; x=1796220766;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+j5ASClty8/ZKXrnqcuhSTiI2lW3GfIrSFmOpzRXZaU=;
        b=j98y46pSHkJZa9MTiZPQGRYQY2/dGNsPQmZbIZFAYF/5eBr3Jwlb+punxhAZnDm132
         d4CChiDz4W0CbTcw4XbL1H7o4WybEvO5zhlZDC5UbLhdroe4xIE5W3fG7hcsvtgCwR9s
         nGDfbTVqcjaqghnq9sVtN9y2PO0PTr8j0vDCkmL7SBifETwXgEutvG81qWG6u8SY5mbr
         KpKdfPVRWYKt0W3mPxb2/kx8iF2VcOkL9WsvD/tLhXVK+8ZG0JgKquELu+VaRFlukLKW
         GvXYqEmq2N+hHjwSX+oZbHe7whJix7m8qBfIzddUKU/e3hPcNxBjfh9f5lxBDbnU6IpD
         2few==
X-Gm-Message-State: APuU4Z/rBhc8P3ivJvM3pznx7Vu/DXwNx/agiHwvMGauYkpJyLG6AY27
	A8kxvVW11td+igGq8YB2QHg5yA8HkeLajgg9Y6XnZ1as1MUF43FDzzrhqMANLMUpYks/3P/E8DS
	wzpPDRqrcfxA+Z4ZT//fihTrd0LnLeJn8fzWD9/L+gQ==
X-Gm-Gg: AZFdTZd+DT51QIX6Wx3K3AfDgh1JXfu//Ip2NOAzRKrXW+7XkL6Yfw5dPUVbxp8JZCr
	hNmrd/9qKdlSaVsiP2oIliWDS55gDCwrH2+xhi78DSWPG9KMhpn7Fn2EEza/YcKtJg2MxkB71T2
	Qtv+0btlKzCB0YrHVFOiinWt0UubHoaWLtQA1rMc/EIWcMs2meoR8OU+HJZaOWPWwxB/di71d23
	q+nO673Qu9f45exoyKPi1+p8bZTEHF0bKQ7+YX69zt++R/fiA4vN1AS/1h72s9BaAEypAJliogM
	Jzq3AtcG1BlSz99UV/hDf57Yt6sGL82NCuVOuJF9uey7pikl69qgBLSUCc01T53ubjZikvNREHo
	VESs8eePQDZt6fQiU5PJUZSE620gbGoFvRcE=
X-Received: by 2002:a17:90b:498c:b0:3ac:73c7:9c07 with SMTP id
 98e67ed59e1d1-3b41c55b914mr25284757a91.0.1795615966034; Wed, 25 Nov 2026
 06:12:46 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com>
 <20261117-bpf-preempt-v2-r2-v3-3-586376ec3672@sentinelone.com> <CAEf4Bzb6sq6g7jq715fqAAaL=PNSvuVWn6u3o+76w52gsT+bJQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzb6sq6g7jq715fqAAaL=PNSvuVWn6u3o+76w52gsT+bJQ@mail.gmail.com>
From: Mike Bazov <mikeba@sentinelone.com>
Date: Wed, 25 Nov 2026 16:12:50 +0200
X-Gm-Features: Aa3M54qvrNfH9VUBkNsCxXuuT_4IkvvxlNYuj2vYVSaYeAaT17sYXXVQTIxMML8
Message-ID: <CAPnbwjrkkX63T6UCdtsE0yTV0C81DFp51ONXvNOFaB8zOdmZ3g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/4] bpf: Check program recursion per task via bpf_ctx
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	JP Kobryn <jp.kobryn@linux.dev>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 24, 2026 at 2:04 PM Andrii Nakryiko wrote:
> Am I missing some complications that would prevent that separation of concerns?

Not really. I can do that in v4, it simplifies things.

Thanks,
Mike
