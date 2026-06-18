Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6586933D4FB;
	Thu, 18 Jun 2026 20:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781816148; cv=none; b=VTGlwxJxhJf+NXWWdBDf8fw+VeN8iEXGP2ywyX9LJPAeAxylRGJ6ggu1svCofK1Ph2oKYM57OuTxaxq2DXAVRtB/t31H8cyMg4Pgy+Nny4jfPkNAEHt7qesZy649QBuCmGhwiZu66DkAzIPM/YyAoAGp4961nWyqpRBVdVkzYiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781816148; c=relaxed/simple;
	bh=wZ9mFPqRAm2TdSK/cvkHllSbhR7/LGR96v2WW/jl5gw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type; b=At80gOiPi27leG708SmlfQafhIanEfqbyqFjJEQhCZ093nc9TxBvDTOdCKASdXHifyXIUDy7gZcBnA+3m1jjEfjgCsJUhk5aks89Y3bErvg6OSFJIUusFhoTOPC2soZgUN18zFg2R1e2nmA45JblXh+qD3os12SE+izvoGm1OvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YexpeD5Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YexpeD5Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4AD1F00A3A;
	Thu, 18 Jun 2026 20:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781816145;
	bh=wZ9mFPqRAm2TdSK/cvkHllSbhR7/LGR96v2WW/jl5gw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YexpeD5QWR8pGq+SuIT5o7raWx3iotqUfHdCZfvQYlRzTihz+t3P+yB7fDWir3j7t
	 7HJ5G3nT6pWIllU0OhXsUKAJikGifzVt/CGh6WcQSenJpxBZ+6YzRJOuF/oXcHQiZq
	 YHjjTCsydS6NMYFZ1iEi2V2fVLLODE1X0QRWen6FWy7R9LzBldWWI2cRyBwrAPnxlc
	 VFdWoYSXmr/xmlDRS6J/FLQooZeChC3C/YRbfAJwAJMZKIhmZ53j9CmO4ERjlqWD4J
	 Yqb0aVwW8l5WLbBIOojrNE5UUcY9sOe4M/b6P1DfLmNxBEiPI/4ojFiftugrvoBbn8
	 40NZFaxk7+ypA==
Date: Thu, 18 Jun 2026 16:49:43 -0400
Message-ID: <e384ef2f478093a70af11980d2d1cdeb@kernel.org>
From: Tamir Duberstein <tamird@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>,
 Andrea Righi <arighi@nvidia.com>,
 Xu Kuohai <xukuohai@huawei.com>,
 Andrea Righi <andrea.righi@canonical.com>,
 bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 Andrew Werner <awerner32@gmail.com>,
 Zvi Effron <zeffron@riotgames.com>,
 Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH bpf 2/6] libbpf: ringbuf: Prevent NULL callback crash
In-Reply-To: <DJAWPR7RA9VX.2LHJ0V3EVGR7S@etsalapatis.com>
References: <20260613-bpf-ringbuf-fixes-v1-0-e623481cb724@kernel.org>
 <20260613-bpf-ringbuf-fixes-v1-2-e623481cb724@kernel.org>
 <DJAWPR7RA9VX.2LHJ0V3EVGR7S@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Tue, Jun 16, 2026 at 08:44:13PM -0400, Emil Tsalapatis wrote:
[...]
> Can we just prevent a ring from being added with a NULL sample_cb?
> What's the use for permitting it?

I kept NULL callbacks valid because I plan to add a caller-owned
iterator that does not use callbacks. Rejecting NULL during construction
would prevent callers from creating iterator-only rings.

> Even if we don't, rechecking the callbacks every single time we
> consume the ringbuf seems overkill.

Your `unlikely()` suggestion on patch 6 applies here too, so I used it
in v2.
