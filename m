Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795722402;
	b=adPauJyG51+SvUOw97ZuelmVYvPCRnrEikTEDTLWyVoMtA3J2Q+PFUJyfEDfyXSttPMA
	 kdARJoKF8t0cBla6eey5Hcca5+ci8mKhGZb1umYjrr2U92MqIJRWlH15lixxCV7b6GjqK
	 Puc1NxNxM/6rd2HJitoeBkW4XjH3h8Ky053TAdBnjpPAV+2lSO3uOma+LGh2Jo2VcFTNq
	 ZZg6UMGaaG58hMFQSN6H6KaDu98bFuU83XQD5QHZTL/6I1MFA7QIoV3wBj9SMM65OCg/d
	 KnbPJOvf2CmtxuuysAeKPlR6AxuxLgMcioYpN0S1effTJYly40JNc8qXadRBm5i0fjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795722402;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:Date:X-Clacks-Overhead:Message-ID:MIME-Version:
	 Content-Type;
	bh=KhBO03LfZYXZ1MuoXIhy/hvL4fgdSiNrAUBItaGl2so=;
	b=CnmWO0aa+2XTjW0Mk+yDsu+bKmKV+PPznEgDQJjBdbxEHnNiKIM3etK+r/2pDuB4MeH2
	 D/75pCg8lEIWoudcgGAsUVFsZamL/b7wHjSBRzKpbKomVCWi0dmCgfTGrVa4qcYu9IOiQ
	 GFx17FfqZQuBWyngE/rk1E3sbQg59YAtWaUS3Q9qPwp8dCfGIoSg4LXT+c1R+6RKBo6RU
	 Q0ymj5AufWLfm3ZZuNKfN/clZGixGaiRj2KoV66j9zkFu4maSso0vOtVRUKSW5PUV11iN
	 Yqwv6ujUD30g9JND752GAR9fXjkdhpSP9D8F/9yZ2QUAy3twAD6YezsuwG7k3+nCZMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	dkim=pass header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=NXxpj0wS;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B6C606A329
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 19:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58B6C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=NXxpj0wS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1795722400; bh=KhBO03LfZYXZ1MuoXIhy/hvL4fgdSiNrAUBItaGl2so=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NXxpj0wS3DiZ9JUfknW82XlOaCP5zsLXFkFqvAvqUx6CoQ8psR99nO9Tr/hf1KQ1C
	 UWFuYZQt6ofpN5riFifOQBTjIUZckLd4aZh/cb+zjmbsEtGLrIHto+SYEAycGEwg7K
	 LOHXEcd3HgtUXaBHy7kHxzpUldc4r+0/B4f9MDITjt8cKDez0dpsOKta//lDjza+gU
	 e55K4YqPTn2oJyzowLVW4spTAo7H7wwv3c+78efWFJSKuiORyZw3C3LWjJbhJpgw4B
	 3ZaRN6wnBjwRhFwjh2DDN2LEhk2E8BezMZzpss3Zk4/mVYHZMQ0X14ITs0Wu8YSpbg
	 llvu4XHncP+Iw==
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 john.fastabend@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, mason@kernel.org, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v3 4/7] libbpf: Move bpf_object_prepare_token()
 to object creation
In-Reply-To: <468774737b63c8aa4d8cd6b2d7de16ac60d3c29add13446eb9960a8be1ef1ff8@mail.kernel.org>
References: <20261126-bpf-relax-get-next-id-v3-4-338e1d3077e7@toke.dk>
 <468774737b63c8aa4d8cd6b2d7de16ac60d3c29add13446eb9960a8be1ef1ff8@mail.kernel.org>
Date: Thu, 26 Nov 2026 20:46:39 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87mrqvcr4w.fsf@toke.dk>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

bot+bpf-ci@kernel.org writes:

>> libbpf: Move bpf_object_prepare_token() to object creation
>
> TL;DR: Creating the token at open time likely breaks selftest
> token/obj_priv_freplace_prog_fail at this commit; the fix is in a later patch.
> Could it be folded in or moved earlier to keep the series bisectable?

It's not possible to move the selftest update before this commit (then
the selftest would just be broken by the commit that updates it, and
fixed by this one, instead of the reverse).

I am under the impression that the "keep selftest updates in a separate
commit" rule takes precedence over the "keep selftests working for every
commit rule", in which case keeping it like this is the right thing to
do.

Am I wrong to think so?

-Toke
