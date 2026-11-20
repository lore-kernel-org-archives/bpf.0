Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207345;
	b=J7xcvAVubdUgkm2sz20QcLJ66sKQ1YCCwz84yAvkIghbGy4zMEe/bZkhUboplSBYrhBY
	 Fn9cHR5tP6UzdproH6FJqMeDyBXgME0GUo8v64lna6UIAS/m2NEx5BdyWgs7IPAbPHSoa
	 VhMDxDUg4EoCI/4RIMjKYHaU85xOJP0D5BIAZW6tKkhvD28ICqWpdpIGzod1I+/KFGvyl
	 hMQkzLwbXzlmrkuF0wicuVopxVoFsrOnHYos1jrSHIrCNhZrsCqhWpPCyHD5EO+mY3eQk
	 wHAh1I9qiUbxK9AP0nMuBxkvp7M3oOh2rmc/gmD1BXfvMbTUrMO2enoiSVTqCKkbRLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207345;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding;
	bh=GAbvZ3pPSOrdVekXC8XU8MwNJ3POcX0QULZFkXtCXJM=;
	b=3KYZAdg9njQORyjpqoCorqk1aeWduxsNlK9XktcX2r6VVPNOyzUDI8ajAkuRp6AT6zZz
	 fYgBmSF9XzXShubMTFY+XMV43lcPEt+GGBNxJnDW07VGLaHmcHnxEIgR6naTR5mrYigcl
	 A6fvZT0BrKIPGNkK0ooBEXrywMPWWgTkURx+Ehj5kYLcjZ7Z09e8H6wf+6N4t1wXPi1Ds
	 cNUo1ktS8g1FFlmITZQgLKb7LQbfiugCuQPjQspj9nM9uC77OoFqMhm0PjLAvSY4btLz9
	 SNh/X7ytygx8rxYn2tC4np2ggB9QoeSGTF7UnzXort+naM827f2XWC7a1jySZ/nKUog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD219606A6E1
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD219606A6E1
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-53639b8903bso16490031cf.0
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:42:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207344; x=1795812144;
        h=content-transfer-encoding:content-type:references:in-reply-to
         :mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GAbvZ3pPSOrdVekXC8XU8MwNJ3POcX0QULZFkXtCXJM=;
        b=Wm9acCXDvQf6WtczNT1SVqldv4q5bgJObhnOzqagLEEj6ZLOEmQ9y5ibdW49WoHNHX
         Oba+kw+zoBqY2Y2hMiWk9PEItm33H7yqsdrWcOShEbr+PvDGqSBY1GFx1JMKsIYwFONR
         +W/M2V+8gATe2M7IJK2tOdKYfMtpb5dBWJZTfa7gQKzNqlMaVNjLAXozguD9vf3FltTP
         Jkdb0DFgSWjIGpGUrcKa+i2HcPZbpPiUELBwpUqje4GI+M+JiwE8MnixruotXmx49FET
         7mTb6EVEjqrLZQ9S3ViiWenUNsaQEbXH7fyOXds0xKMnbz9OH0F4ZkfZs22NtWSA0JJx
         1LKA==
X-Forwarded-Encrypted: i=1; AL+hErEAUHGHXk2f8kuJSBsC80ScAvuqs/YU5Iluc081VXfQeW05cpW/EoBUBialKMEC9lW7nRA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/GGumK2QJbCsei2AYFI8xOIzHvSdxWTf4xpNLaT/Iv1ktzfFF6
	0zr7iu4OKx8ieZ+QcK5JPcaO4yXfVUipAB+Kuzkuq7HYQJwnxmf1g2Ib
X-Gm-Gg: AYBFou0i1r0vkqGyivgt4p4wjfTjx/iaTkPe8wj9rugfo8UFQHwiuVuQBXKD2nuCXZu
	ZCUr0k4VkoytkUFrhkPAg+tt9I3HVIlLCAwjRVCKJyz5wXK16fiOS8GjWiS6iB76xFSmEs5K24L
	mNjv8NxNDkBJveVldCbG8cJYTcge919QCfVTegegiapBmPzYv1a62GIGq+s22q5J8+3S5W7pTF2
	FglA7HcOm3zNEWFeL7gVwYf7a1nvR3B9uxIa64aKD2//ab0gnHl388AAx8elOm0/u+ya5v7mQ8H
	2/b7q196alap+F9JKd82QVZsvGGWkXE+D9WoiXA3jBau/oFnBVtHChCmsOVLU4/AFAOt2Ct4Uta
	HLaXEn8BOgouPs0sXWCdIe5ZUaXlmOTLGfs4OgAf3OWd6tWNELzhtrJzC7CpuftQbV7jTHAD4OY
	tc2hnNgfg73pknpgblA2lRX7NxF4molpCOAmIzl9E76uU4Ibgon1FtTFEXmuI22ZF8E46ZmlzWt
	DfNWi5JjwrDB2hgJB7+K/Gog2jvQuAHI2RcsPVUoEdUXtOucSNn5SvgdpchgZYw2anWzPg492sL
	8voEos8qNQ+g1qXJMBwMDBwmpmwb8T3KHqVHmaHIRSad4jAUaN/xbZiOoSLTmqgJ5zT3S+DGJP7
	G8yGTJ087ne/ol0A1ptURQL3jdR8FTPTtWZWZOwe+27IT9Yks67zm
X-Received: by 2002:a05:622a:259b:b0:535:6e9c:d374 with SMTP id d75a77b69052e-55d6fcabb67mr91725931cf.14.1795207343793;
        Fri, 20 Nov 2026 12:42:23 -0800 (PST)
Received: from localhost ([199.170.132.196])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d78852bafsm32418241cf.20.2026.11.20.12.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:42:22 -0800 (PST)
From: Tamir Duberstein <tamird@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Andrea Righi <arighi@nvidia.com>,
 Xu Kuohai <xukuohai@huawei.com>, Andrea Righi <andrea.righi@canonical.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Andrew Werner <awerner32@gmail.com>,
 Zvi Effron <zeffron@riotgames.com>, Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH bpf 6/6] libbpf: ringbuf: Reject overwrite callback use
Date: Fri, 20 Nov 2026 17:51:54 -0000
Message-ID: <179519711430.18576.13986256491021949684@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <DJBZ6ML455FF.15NG4FYCAX9DE@etsalapatis.com>
References: <20260613-bpf-ringbuf-fixes-v1-0-e623481cb724@kernel.org> <20260613-bpf-ringbuf-fixes-v1-6-e623481cb724@kernel.org> <DJBZ6ML455FF.15NG4FYCAX9DE@etsalapatis.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Nit; unlikely(r->overwrite)?

Included in v2 and now merged as f756eedb24d4.
