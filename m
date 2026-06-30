Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF9A3D330C
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 07:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782803684; cv=none; b=CmCn+VcYwrdx+WR3ioL/j066Qs5ZYyhLxFGVT/9MvE1tlKsoT1UQCbH1zkHQxp8f5ESJkxnpIawhlnvg861sKATmUHZRzS4EXn21Sk6xJoN5S39DC3QiEOB/zTs+MymHksdSmkqL3yG1/141xqujOiGusJAvBWfJqOyhpVE0j0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782803684; c=relaxed/simple;
	bh=XL23FZIFV8lgtowgc1D3LIn4aqMyxN0Pts3G4jOCcZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnhOdt3S2J4BUkCdfi07977B2uUL0Iw/alwfiXa8YCswgl/hdYiT4xcV4Rt9r2LHsAIj+YyTXGCfR+z7wB4C0JopknA+X7uhVxKQM/Yo2NvOKVPNw1e6zOn7JV4hsrruxHyCzbt5JK4abv46toZiGBxd0YvfaBU4POLdbfyTS60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgN5FXQE; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgN5FXQE"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-37e1607f7faso1878467a91.1
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 00:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782803682; x=1783408482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2bDQGREITe91mNJKLkfaBft7iY0zy1ezAMTmaONILis=;
        b=fgN5FXQEFp7ODVTlb5EKin3jjBuoNcnuY813a8+INqGJD5QCMSObTCqWfspj6cY8ma
         e+CSpiBPZz5LxN6QtnVJBNgCE3gFD2r/CTnSo3N0Ib7M7oLJVpt10Krm+HIwJb5SclPg
         4rj8Anq4Lg4dSYXs9bVx4bdr1xQ43iPyYmTNjb+32ccty2ZGU+tfIdHDVxc/8zSxh1Y8
         KyfXqQQYpgaznKXfD6L8u5YDVX44XB7uj4AI+O4+EhBWlqDzFKCRRhgH2m70ZZEVLg3t
         ATC8nct5RdNwm1Uz13EGl+tyzlsLdSgiIfPJLJ1Ngx76lH7MQrzx6y94lX6unE9i7CR+
         9APQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782803682; x=1783408482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bDQGREITe91mNJKLkfaBft7iY0zy1ezAMTmaONILis=;
        b=HuQ7XFWcszuqTNHtu4NX69WRefTGlNfoR8HLh/MQSsHdsL08An27patD15F4caRb68
         BqdTbSdGHBlLgA9DyiSjHWpm5hJHmWqQeurEq5ZyObIvZq2ZoDTiTbISpR1qgLlIB9OZ
         3vMMxpfxuKBpcXnxT0eRadnMi4JIvLtW1t7GuEOEQlDoienMJKzGs1RqyOVo1/Ds7ad0
         3a7tcd7rliL9CLQMD40EEfmcQc2nwjENLIb32CtkiFOB+bfifRBLgHgIgrJ1qHhnnRxK
         z3v9qy2fPc56+nmIVv9kg7FUqmqVhvFdxpOLtOvGxcTLPrRQSMEjrTZ+9kSUwHQHpIe6
         kF3Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro4zgmUQHuqfxWtyONYGFumqKtqeRkRa17tgRbsS1zhUovreAXZcdJeReqIHp8kicB/4IM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya+sbICQHJdJPFvk2JKMIp/L7H418OmMebgZKlF1p6vyYg9E/V
	bysrxVZWdP4BqheloRj+wNFlrlNBX0UboI3wZ2hcE1cjPbRBhFGgYO+U
X-Gm-Gg: AfdE7cniaRChybwIzVZG2dT7RvV1LBqjla7VgM81MmZfn8xRKlKlFmUosV08l15gHIc
	ywRGh0docAlCF9ro2dC288jbP8F5kK+vSUvt4Ppcx4wjyYhveamnV4+RzSnxMwQ4tA8ou9zQy/1
	fTeTRDV0+0XJ+e1xM6zRsIGb/+8uv65oioSPBGvw/vSwAVAOtI/pmvMLUes+J0NFFsODbSYHfKL
	cq6OVWZG82j6OQ66/ABkuhOqjE2HkYSqh2HVd85i8XwS9pspVmTFZeYLpLnBVaGrFdFXSdDLZoi
	BEUgKUDbQT42guaRxPrhLCu9XhIYcVtzh8A6vN6utpvTLoF2EU9pYcFf5KjYFzKKENn/ssOiL9K
	iHmaDorxnnkxTMzC0XsVdAuEB346/YYPlMwyHsypmCE81LGh6NPi4NqkmcGTItKuRynbYiWeU5z
	ehq7xpK9oyvs5CVnktPQkWwv/Di1YeNRabR/k+tTV4iB8sH29sbzv5r+io4is=
X-Received: by 2002:a17:90b:2e48:b0:37f:9cdf:f0ad with SMTP id 98e67ed59e1d1-3805281b8d0mr1773163a91.28.1782803682352;
        Tue, 30 Jun 2026 00:14:42 -0700 (PDT)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3805bf2c5absm285378a91.2.2026.06.30.00.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 00:14:41 -0700 (PDT)
Date: Tue, 30 Jun 2026 07:14:32 +0000
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Lorenz Bauer <lmb@isovalent.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/2] bpf, sockmap: disallow update and delete
 from tc, xdp and flow_dissector
Message-ID: <3speqrvxsx25cbyronbm4jatlhkawkjiki7j2b7clrtkbwgpn6@x2gx7rwvpho7>
References: <20260629172704.1302218-1-rhkrqnwk98@gmail.com>
 <20260629172704.1302218-2-rhkrqnwk98@gmail.com>
 <DJLQSC87KCSV.314DTZAWRNA8C@gmail.com>
 <akNXhg5K7aV7Opdr@john-p8>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <akNXhg5K7aV7Opdr@john-p8>

On Mon, Jun 29, 2026 at 10:47:41PM -0700, John Fastabend wrote:
>I think we additionally need to also block 
>BPF_PROG_TYPE_SOCKET_FILTER? Did you check this case I guess the same 
>case is possible there?
>

Yes, same inversion. I'll block BPF_PROG_TYPE_SOCKET_FILTER in v4.

>Then another patch needs to restrict BPF_SOCK_OPS users. For that
>we need to block BPF_SOCK_OPS_HDR_OPT_LEN_CB and BPF_SOCK_OPS_WRITE_*.
>Let me know if you want to do those as well. Let me know if you want
>to do both patches or just the prog blocking above with the possible
>addition of SOCKET_FILTER. I didn't search very hard so probably need
>to check all the BPF_SOCK_OPS_* to find the valid cases.
>

Just the prog blocking with BPF_PROG_TYPE_SOCKET_FILTER added. I'll
leave SOCK_OPS out of this series.

Bests,
Sechang
