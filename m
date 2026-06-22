Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023F32E11D2
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782130844; cv=none; b=ZW77ly0Nv1K/q5R0QsKG40mc2tATr5vui5ajr9eRYNXZkXQHxPB4MqoSGNGvdZfS+wrdikijYf5Xla+/QEdPAJksUT3Pf+vjQb+xA8Cnwv2/xwLl0fus4AVqdP/2CB1n1QJwF7kK+vJ+o271PBi6ygyTTRl6qXF8mmfS5kr/KA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782130844; c=relaxed/simple;
	bh=tk81heUtCbCuiZ79M3NF+u8kjz5DLuV0LKwfU8H8rvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d+HNYMxdUcZGQkIfNUyLgXQSCvEU5jeWUsVXA77ftmAzoF0nDKfgXVv39PNebq4UHhtXUkjJKeVSzjaLLf8jFVcCMCXaeALr5AzjFWa8HEYzOL9s6lDwThnl1uQ11K55jMjc5n4MXMLSLPe9wVV0I/8pxTJKAkEMbtMnQ8mMPSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TP33iIHt; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TP33iIHt"
Message-ID: <06bb11c3-8d2a-41bc-b506-e444a63645b7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782130831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tk81heUtCbCuiZ79M3NF+u8kjz5DLuV0LKwfU8H8rvM=;
	b=TP33iIHtqdfCaBQ+JgMc0Y/e+j+ic0RfP9u7WjQVZB8AT5pMXEO25Sk1nRRPrlA7xFBpo1
	st/LNZPJf3MPoCkYQ20Gi1WiY/z3aSsYMDMwNwQg26eAafUKKaKBqLuknNuGjUuesFXUHM
	H3yN00s7tOIgDXCg/ZMLsFTUWYFqdko=
Date: Mon, 22 Jun 2026 20:20:19 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] tools/bpf/bpftool: Reset vmlinux BTF after map
 commands
To: Yichong Chen <chenyichong@uniontech.com>, qmo@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260622031255.1160657-1-chenyichong@uniontech.com>
 <70577B1B956C33F3+20260622031255.1160657-2-chenyichong@uniontech.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <70577B1B956C33F3+20260622031255.1160657-2-chenyichong@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/22/26 11:12 AM, Yichong Chen wrote:
> get_map_kv_btf() caches the vmlinux BTF object when a map uses
> btf_vmlinux_value_type_id. map dump released that object when the
> command completed, but left the global pointer stale.
>
> The same cached object can also be returned to print_key_value(), which
> freed it directly. That leaves btf_vmlinux dangling before the command
> cleanup path runs.
>
> Use free_map_kv_btf() for per-entry cleanup, and reset the cached
> btf_vmlinux pointer when the map command releases the object. This keeps
> batch mode from reusing a freed BTF object.
>
> Signed-off-by: Yichong Chen <chenyichong@uniontech.com>

You added a Fixes tag to another patch. Should we add one here as well?


