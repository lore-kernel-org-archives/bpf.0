Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB282449ED9
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768931770; cv=none; b=psNQOnrOPooPtQd0VipK3pgGcG9QDetmIAe6Fq0LqrEK5AqoH2arT/nQbzQj2MYc0XRIf2m+YJLEiKfvv7tT04hVrRmVsrU5rpsumFXbZxKOn1DwKgD2rZ3ev0pDiL0kU6Fw7fB56gCI1iWOUlnBCm+W9i73i4YV1LBywXfWZ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768931770; c=relaxed/simple;
	bh=bntCYoY/lWBskz/E4EMaSD5LphJe4tlIc8UXi+CQOYM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZaUxUYVEOUYocauOPfzDV45X42QaDKz9mFWScMN03ejBhIdPYnOOJ5qWQWelJo2I+1xsVruuPpIsFkRg3Y64unTyzeJeVFPBrX3IkhNnkc0+48jT0cGzNATwPSNEhNK2XduZHMnyvDJ2CntFNk74bov3ZDFdN+fDDp25GedEfJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gR8mMOvB; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gR8mMOvB"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b1981ca515so6126314eec.1
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 09:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768931768; x=1769536568; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bntCYoY/lWBskz/E4EMaSD5LphJe4tlIc8UXi+CQOYM=;
        b=gR8mMOvBYSYs4BDd+EuMw286bxsDrKO4AlPwF9KVstZhN1kymsTmbasIhsPF5of6di
         /O3mucE5owcpmwBrw7zrhAj1lRzUp8XrV9ZCsS2rwuBgIQeMu1COKMYVsC0+k+Y0q/tT
         f9VUsiVtLr/yo7A8DMvlBLZmmA2SqtXzYJ/r3tWtmvMXu+aEp5GO+b0oSCIOHkGqfAVG
         x9t5wmZligD8PQIeUCfahqpVz5NUaJYsGSKVU/cI+ojkRViUnncRrWh7467dLBmaNqNJ
         YzWzNewZPbM599cBMRIgs6K9lHlb1g+zUqoYmvRx3voaovo8RXtorooaS6vLoeh//FcJ
         68Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768931768; x=1769536568;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bntCYoY/lWBskz/E4EMaSD5LphJe4tlIc8UXi+CQOYM=;
        b=cS2rBLsfjLuP3QnLutwVXSVgvDVpDn8dG65NQCQSqSrAqk2pRCi7Z8qflR2TGGQGmh
         xajLLVvC28hy5tKKoFwfSaEcxnFXnHUk+KpGnmw9IJwdYoEJDru2Xhd3eoIF5MVSuQlZ
         Jjl8P/IXumcnATsjd/Wslnwb2ZrXipukY5JsJbNb+4qpClTCNImilE9Kh1iLMEeTf1Jd
         a+rXXriNgRyfxc7CZF7yI/5XTL4uUDJ8pvtsvk2mCd1dA/TKaKsNiX99xuFzf6F2ZCuC
         9TV3dER78GNu9V0pNQGmr4225u1PtOKBlnFdE15h3veKCVkQK4wO9NxLbZ76Bifb3wEu
         S3NA==
X-Gm-Message-State: AOJu0YxTWQwpzjQp4wafsrz9h+YpcuobC0Pd6i6O3PrusX5OHR2nzfyZ
	IdcV1oNmTAA5QgpHjsQu/ConMAXwakbkAXKhw7fJq8dUJ78nUmZq8sSv
X-Gm-Gg: AZuq6aJBddDXU8WqYl8KLJmOfHkw41aMKWH2gv05zqyaB2/k6orztRBKUxcLNlQNe6N
	b8RFZZMT+SAg/8T9liiU9kL/6bYEVkS+676uTpI2haOEj6naYD6XPUwC5mKsrrjjBMvFeXsXsrA
	D3OXfHLM+enOSPOmxkxYZJUAIK0i0wvGCOc/NWzr/tQELqy+p5Shfh3YvSmEZ2Woed2fcYA2ceI
	JuvCxKpwFplWQ8O1uFYpTBGmLBqvrpgKttxXFIw5kpPSOar8W+9H91SV06qBUsMiVsCG0kIkoOE
	9i/OHaWhfCHY0xkPFmez9IkY1WVx+cJp4dLb1SkPpAT8wxDisMeUK6h20vWuaYDvwKwEz47C5uN
	0MUFy2nA0emS2n9zTAA6vXqbIrN7XFMJl6/dI89n8y4DgSrD4ri0iT5weFxJ33SXTO3A1wUt58g
	dqnjVzUK03mRTrOuZVtjfh9kSyHHoNhyZcUkJa1y5f9v0QMkniYoOfCguXaRYEeGDQQ5m5
X-Received: by 2002:a05:7301:7c0e:b0:2b0:4c12:d74d with SMTP id 5a478bee46e88-2b6fd746d53mr1663983eec.15.1768931767667;
        Tue, 20 Jan 2026 09:56:07 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:b08c:bb3d:92b9:704d? ([2620:10d:c090:500::3:93b1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6c2de1f29sm16004104eec.15.2026.01.20.09.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 09:56:07 -0800 (PST)
Message-ID: <00d9e1ea7e4eef7a7891200a03e99083cdbd066c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Fix memory access flags in helper
 prototypes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Zesen Liu <ftyghome@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Matt Bobrowski <mattbobrowski@google.com>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu	 <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,  "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, Shuran Liu
	 <electronlsr@gmail.com>, Peili Gao <gplhust955@gmail.com>, Haoran Ni
	 <haoran.ni.cs@gmail.com>
Date: Tue, 20 Jan 2026 09:56:03 -0800
In-Reply-To: <20260120-helper_proto-v3-1-27b0180b4e77@gmail.com>
References: <20260120-helper_proto-v3-0-27b0180b4e77@gmail.com>
	 <20260120-helper_proto-v3-1-27b0180b4e77@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-01-20 at 16:28 +0800, Zesen Liu wrote:
> After commit 37cce22dbd51 ("bpf: verifier: Refactor helper access type tr=
acking"),
> the verifier started relying on the access type flags in helper
> function prototypes to perform memory access optimizations.
>=20
> Currently, several helper functions utilizing ARG_PTR_TO_MEM lack the
> corresponding MEM_RDONLY or MEM_WRITE flags. This omission causes the
> verifier to incorrectly assume that the buffer contents are unchanged
> across the helper call. Consequently, the verifier may optimize away
> subsequent reads based on this wrong assumption, leading to correctness
> issues.
>=20
> For bpf_get_stack_proto_raw_tp, the original MEM_RDONLY was incorrect
> since the helper writes to the buffer. Change it to ARG_PTR_TO_UNINIT_MEM
> which correctly indicates write access to potentially uninitialized memor=
y.
>=20
> Similar issues were recently addressed for specific helpers in commit
> ac44dcc788b9 ("bpf: Fix verifier assumptions of bpf_d_path's output buffe=
r")
> and commit 2eb7648558a7 ("bpf: Specify access type of bpf_sysctl_get_name=
 args").
>=20
> Fix these prototypes by adding the correct memory access flags.
>=20
> Fixes: 37cce22dbd51 ("bpf: verifier: Refactor helper access type tracking=
")
> Co-developed-by: Shuran Liu <electronlsr@gmail.com>
> Signed-off-by: Shuran Liu <electronlsr@gmail.com>
> Co-developed-by: Peili Gao <gplhust955@gmail.com>
> Signed-off-by: Peili Gao <gplhust955@gmail.com>
> Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
> Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
> Signed-off-by: Zesen Liu <ftyghome@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
