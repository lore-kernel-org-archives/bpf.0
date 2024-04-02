Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE56086253
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712067585; cv=none; b=p75Uo7ZbgRj5M7GJqT13R8KdstNO+ZLaUFiByfE6IqnTbBCsocZEOj23tMIX0A0jNap0lHbFcWQmdUGowXXaqz3pFnBoW7TIyHCwunmHebbtkEVE8/izomIGMBFTAEnawxQ+u4PNUZkU6ro8L31DsMOWu2mLQ+dPguxt/6Ff19I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712067585; c=relaxed/simple;
	bh=ni147LSy99ja5zJiEsiizkGiuRduQqR+DOhRpy5m1KM=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MaoW53waTDxmscUMmIPjMlfepzmtbxsgmFTCPFtMg6sYedCgtNIyDgNp0xhtWUNYAFHfvVT2kW0Y3BVrYsUyxMWRuIkDaTTTVRyigaUWLRjVnQGzAHAFe3Lgj262Sojb3K7liHgx9XtdLkKg3Oy5Qlbda+wfFwEKYiEjAVnwBQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=chsOywMT; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="chsOywMT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=JNR4Xz6d9Q9AZ6x9zzQMblgnZtAzIRK8GCDMh16dxFg=; b=chsOywMT87XoYgLvP8r8XcUyAY
	QfP9aLnhSabtqmBHBke9JWajZQ4FYsAuc2rFSshoVk42n9Vnc+0oDrQliuLpuE4iPw+dWc1c7If+H
	2eEba0SSv4yr1WTlm3X7yKgLJG4hTnPmDUkoNWrXGpmwlERwOuCpg5nwYNp3h9bwPlgLYDSTrciht
	33uzNPFnwPKdZj4aOAXDBA7dPtUXRlzvNvoQDwlBicEyykqUlxjynsxPklBOP7XoFtw/RsmnjMiyu
	ib7GSr6U2hqqeQCqxQU13G8a+aTTivtVyr6DJiO+jUhBxZyO6Q9XjPsKkRYZj1qdRis0Vf28ZAsnl
	uRDZLlpA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rrezA-000F0P-IL; Tue, 02 Apr 2024 16:19:36 +0200
Received: from [178.197.248.12] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rrez9-000V68-Vs; Tue, 02 Apr 2024 16:19:36 +0200
Subject: Re: [PATCH v3 bpf-next] bpf: add a verbose message if map limit is
 reached
To: Anton Protopopov <aspsk@isovalent.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Stanislav Fomichev <sdf@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>,
 bpf@vger.kernel.org
References: <20240402073347.195920-1-aspsk@isovalent.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <48d8d527-efb6-08e7-7a87-654c4490f7ed@iogearbox.net>
Date: Tue, 2 Apr 2024 16:19:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240402073347.195920-1-aspsk@isovalent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27233/Tue Apr  2 10:26:21 2024)

On 4/2/24 9:33 AM, Anton Protopopov wrote:
> When more than 64 maps are used by a program and its subprograms the
> verifier returns -E2BIG. Add a verbose message which highlights the
> source of the error and also print the actual limit.
> 
> v1 -> v2:
>    * make the message more clear (Alexey)
> v2 -> v3:
>    * fixed grammar (Anton)
> 
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> ---
>   kernel/bpf/verifier.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index edb650667f44..559526191ae7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18348,6 +18348,8 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
>   			}
>   
>   			if (env->used_map_cnt >= MAX_USED_MAPS) {
> +				verbose(env, "The total number of maps per program has reached the limit of %u\n",
> +					MAX_USED_MAPS);

Btw, small nit, but might make sense to streamline capitalization across
verbose() messages. Bit of a mix of small and capital letters right now
in the verifier code. Either way, independent of this one.

Cheers,
Daniel
