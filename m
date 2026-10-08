Received: from mta1.migadu.com (out-6.mta1.migadu.com [95.215.58.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D135749E152
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466053; cv=none; b=Q9pZJ4w+RPYYbbc1+urzPZUtV6roTajWsH0xUt2BSbaxzBprN/AiyEgT7UtdmYgl+7rFONcrF3C9h9F4QVI88QTkAjubUj7mUV6xZCK1FC8letzA/jZ26uBlkSKM+nvn5JM9kv1ZxtWX7HXJ5SKpcfBe7y20gQzQ3TBqm0pnziQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466053; c=relaxed/simple;
	bh=QfmJI+k19pGT+KX/1CqtGFtY6aTg8jRIz7IxSKjs1es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZIaVTtzbuABG5ihAUL87bpybUbFZVo2yrGF9FO2tJPpppVQkDxMMH6i39B2rk0PdAfaWf4nrMeEkSkksPRgXffp9t4WhLyLbVKip9EGRc3K5p+pNSz4gUEfe3nglWPVzFvdMlKzsZLp4ymilM9Qbi3GeBjT5y9Hd6N3NrN/Z4/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z/6vbEBj; arc=none smtp.client-ip=95.215.58.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z/6vbEBj"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=QfmJI+k19pGT+KX/1CqtGFtY6aTg8jRIz7IxSKjs1es=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791466049; v=1; x=1792070849;
 b=Z/6vbEBjgy0AkmBGPzm9MZXtN0dSBh2D/IxVzPdvyfAHciT5ggcNBdN5Pb57QbdZKNt3OxrZ
 htOkknO5Te4CwS8iuasOIjQZb+4kNrRD0+jZRBlYRRVu5cDEExD7kaH1xnbg8wLTzvH4fAOaZHW
 A1f11SuK9TRa1byGHLu72AQs=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bf462f2c389ed3b2;
	Thu, 08 Oct 2026 13:27:29 +0000
X-Mizu-Trace-ID: bf462f2c389ed3b2
X-Migadu-Flow: FLOW_OUT
Message-ID: <f5df3786-3fe6-4659-988e-6381bada63ef@linux.dev>
Date: Thu, 8 Oct 2026 21:27:23 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v6 2/3] bpf: Fix incorrect handling of user flags by
 percpu hash map updates
To: Masoud Aghasi <maghasi@disroot.org>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, john.fastabend@gmail.com
References: <20261008120734.1565972-1-maghasi@disroot.org>
 <20261008120734.1565972-3-maghasi@disroot.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20261008120734.1565972-3-maghasi@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/8 20:07, Masoud Aghasi wrote:
> For BPF_MAP_TYPE_PERCPU_HASH and BPF_MAP_TYPE_LRU_PERCPU_HASH maps,
> htab_map_check_update_flags() and check_flags() are not considering
> the possibility of a combination of (BPF_NOEXIST, BPF_EXIST) flags
> with (BPF_F_CPU, BPF_F_ALL_CPUS) flags. This causes the
> (BPF_NOEXIST, BPF_EXIST) flags to lose their effect in some cases.
> 
> For example, when using (BPF_F_CPU | BPF_EXIST) or
> (BPF_F_CPU | BPF_NOEXIST) flag combinations with bpf_map_update_elem()
> on a percpu hash map, the BPF_EXIST flag does not prevent new
> insertions as expected and BPF_NOEXIST flag does not prevent
> modification of existing entries as expected.
> 
> This patch fixes the bug by adding proper flag validations and checks.
> Before this patch, htab_map_check_update_flags() rejected
> (BPF_F_ALL_CPUS | BPF_EXIST) and (BPF_F_ALL_CPUS | BPF_NOEXIST) with
> -EINVAL. After the patch those combinations are accepted.
> 
> This patch also starts returning -EINVAL for (BPF_EXIST | BPF_NOEXIST),
> with or without BPF_F_CPU, which was previously accepted.
> 
> Fixes: c6936161fd55 ("bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_hash and lru_percpu_hash maps")
> Signed-off-by: Masoud Aghasi <maghasi@disroot.org>

Should carry my Acked-by in v5.

Acked-by: Leon Hwang <leon.hwang@linux.dev>

> [...]

