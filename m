Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882ED3E3C47
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 03:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780455691; cv=none; b=A8OYtPcLPnyQ1v8GYpaqmraoScC2h/hG5ElyfEORTpfJFDpA9hsRn2EP9nKu9WNz7y6IWOjXDvPoKvxyWbiXB7wzAotIrAogc1AAOdytQAxOA2Rx8amAV+Uk90qUawUDTSzdBPh1lwR+dxmIwuYo78G96fPLK5vRa3JHxwPk0fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780455691; c=relaxed/simple;
	bh=OAC3EV25gu9JOlTRxwpQTujtC3M12PFsbYoGBxlVDZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dYYtI7QKoP6QlawXfAmhgsabUlw0ONXocHO7bS49qU9RZrAvDAYonPxU2y5Nf+aoymADixyIw/IjbgVNGCYRMJ4YE2qBmPngd6a0uzMu4utdShdnb2ul4Ys/qA31bpjBVApiLRgHReNSMaw3Due4z9qCM6VxyJx/GIS40XE8AF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tU1kWuvb; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tU1kWuvb"
Message-ID: <8e3b5ae4-a399-412f-a161-fbb0121c6904@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780455676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OAC3EV25gu9JOlTRxwpQTujtC3M12PFsbYoGBxlVDZY=;
	b=tU1kWuvb/RpC5iLN/ZVRIHDN4s7QgbZBoDJv7aB7DPbKJ3tIf5vQbcCQbRKvoUBKnk8vOb
	nkgfQVGZkWt/IS4GnEiTtWCrOYlR4QENWw/KyNAch2qHNPngEkI353d4EvYevWndzazlsz
	ub63ouNlqlsO5rRqBKemVFjBEwUBlsU=
Date: Tue, 2 Jun 2026 20:01:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2] bpftool: Use libbpf error code for flow dissector
 query
Content-Language: en-GB
To: Woojin Ji <random6.xyz@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, jolsa@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com,
 qmo@kernel.org, sdf@fomichev.me, song@kernel.org
References: <22ab9375-e7e6-4929-a80c-0ee9cc74a907@linux.dev>
 <20260603003339.33791-1-random6.xyz@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260603003339.33791-1-random6.xyz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/2/26 5:33 PM, Woojin Ji wrote:
> bpf_prog_query() returns a negative errno on failure.
> query_flow_dissector() currently closes the namespace fd and then reads
> errno to decide whether -EINVAL means that the running kernel does not
> support flow dissector queries.
>
> That errno check controls behavior, not just diagnostics: -EINVAL is
> handled as a non-fatal old-kernel case, while any other error makes bpftool
> net fail.
>
> The namespace fd is opened read-only, so close() is not expected to
> commonly fail in normal use. Still, the BPF_PROG_QUERY error is already
> available in err, and reading errno after an intervening close() is
> fragile. If close() does change errno, the compatibility branch may be
> based on close()'s error instead of the BPF_PROG_QUERY result.
>
> This was reproduced with an LD_PRELOAD fault injector that forced
> BPF_PROG_QUERY for BPF_FLOW_DISSECTOR to fail with EINVAL and then
> forced close() on the netns fd to fail with EIO. The unpatched bpftool
> reported "can't query prog: Input/output error". With this change, the
> same injected failure is handled as the intended non-fatal EINVAL
> compatibility case.
>
> Use the libbpf-returned error code instead. Keep the existing errno reset
> in the non-fatal path to preserve batch mode behavior. The success path
> is unchanged.
>
> Fixes: 7f0c57fec80f ("bpftool: show flow_dissector attachment status")
> Assisted-by: ChatGPT:gpt-5.5
> Signed-off-by: Woojin Ji <random6.xyz@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

