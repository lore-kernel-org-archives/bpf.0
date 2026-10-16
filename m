Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0F5342532;
	Fri, 16 Oct 2026 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160711; cv=none; b=uj394/2DIzAPbdNgZDdfx37B2fYY6HtaL0/5j5SiSHHLNBSPcvi1aaOb5A54M9mlyBnIyk+CzJRw5n5pJpO2UidQ968BzZmqifYeLLfeCtCUKC7u/DcUAvPibI9l7Q4EYNnXo6vjhXw8847yiyI0crpFP1omFLgysrbvWqNa9a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160711; c=relaxed/simple;
	bh=GMKPboZRb4xk5rnx6KBbRfnAdpDLhocjqQhxUQ08umk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Os9Or4ayCv7yMl+UD05jdV+mx8iWfYhAPNdw+1agD9UcgeyvmPfOGKsVL/r9kKj4ZStPvXHAru+VvOKfU+W032A4Q5h3LoP7YRBnim3aJjZi4R46pcOI6Qe3XR46r4Qm/0FMtFeLJy67PVTorottuH62KAS1z5Bh1lecXOepRbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8iXBpiv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8iXBpiv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB36F1F000C4;
	Fri, 16 Oct 2026 14:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792160710;
	bh=t7QRpvWSenK6aaM+rge2qbJ5VADBltgru+NepNvsUCU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=C8iXBpiv8J51wFkbbZw3PdEudE9Y2PW9kBzM0dHmTlq7mn9ZeRlIBVnOItOpZPKgD
	 XShws3kggms8h+/E+SqTknrkzipJepeHAB1yxwH13F6PTYVfsEajeBpCTx3OCONzag
	 6Xl0OV5/7hFKCyJqKbdNYWhZ5ERiKouEnaBPNKJg9Q5ZrsvDaCj9UFWZ85/lZqS/zm
	 2dEkgRL051yoMurKosJtywld82CNrW8ZCoYkkmFxvkmRZGYtyrSXl3wwSi7vqnfWuX
	 oZfIaN8OaKWttsV/VjxjE48thwyHBuY4iaL/aIDhKjkeBtZQBM46KvKMmEEG+m0R0L
	 Qghu590EdhacQ==
Message-ID: <b0cd17c2-2c57-4663-848e-f5831b275124@kernel.org>
Date: Fri, 16 Oct 2026 15:25:06 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: Print map_extra in map show
To: chenyuan_fl@163.com, bpf@vger.kernel.org
Cc: Yuan Chen <chenyuan@kylinos.cn>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org
References: <20261016071700.280539-1-chenyuan_fl@163.com>
 <20261016071700.280539-2-chenyuan_fl@163.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20261016071700.280539-2-chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-10-16 15:16 UTC+0800 ~ chenyuan_fl@163.com
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> bpf_map_info::map_extra carries per-map-type creation attributes
> (hash function count for bloom filter, VMA start for arena). The
> kernel prints it in fdinfo, but bpftool does not. Print the raw
> value in plain and JSON output when non-zero, without interpreting
> it per map type, like map_flags. The attribute is already overloaded
> per map type, and bpftool must not grow per-type knowledge of it.


Why not? Do we expect the semantic of map_extra to change? Having
something like "nr_hash_funcs 7" in plain output in the case of a Bloom
filter would be easier to interpret?


> 
> Example (bloom filter with 7 hash functions):
> 
>     117665: bloom_filter  name featu_bloom  flags 0x0
>             key 0B  value 8B  max_entries 128  map_extra 0x7  memlock 520B
>             pids fixture(3543054)
> 
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
