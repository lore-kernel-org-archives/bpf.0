Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52731E864
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711723065; cv=none; b=aLnK2HR54n8Ob7jBfg8Cy4hyXYf+llYrtfPIytPneLnrMvpcCwU3RswihUfm9R5xf7+mfVduE8viQCXmMKEKFoB/BbosRLEEsqo6jMsZ0VoYgRLShHpw8C0DAnRO9P1lfdhR+2YLvuHXlzLTgZTAJXp9z6BBBx9oQTl2XxDYvfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711723065; c=relaxed/simple;
	bh=ub1TbXK2yGtL+cw1EEp+3F/q9iowL4zaFxW+JbiaTZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uvyzLTfsEy127rAvE5PQEbn6F2JZEtI0nXeVpjKqJsmqCi/CDXo4nLR2wumaKfimo6+cs371M56h2tdZWnVjtxi89MmXM4aZG7kygR2mhAe3LptAXaJ8ofHahdfYQ6b328bJRK3pSYe7SZV0vokZ1l0UwvGUcUiwwYo3BJcU/dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jMwNwY2z; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jMwNwY2z"
Message-ID: <ad148859-6786-455e-bd2a-1e3b7542a4b9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711723062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ub1TbXK2yGtL+cw1EEp+3F/q9iowL4zaFxW+JbiaTZw=;
	b=jMwNwY2zH4GbqNZ5yXZvTkhoGXJr3ptzxFywrJgbAPCAuf8E6FilOITDFqahZYDeJVvKwM
	va7jsZm+H91xwk4kju3kHWQx23RFfpLOifJZSK3BjnIlXG16tzWFU4zUT5BFAfFZ81lJtk
	1xS2b7uLjtWWQx4gfJuadym/+qS0BQM=
Date: Fri, 29 Mar 2024 07:37:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: add a verbose message if map limit is
 reached
Content-Language: en-GB
To: Anton Protopopov <aspsk@isovalent.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev
 <sdf@google.com>, bpf@vger.kernel.org
References: <20240329072050.68289-1-aspsk@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240329072050.68289-1-aspsk@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 3/29/24 12:20 AM, Anton Protopopov wrote:
> When more than 64 maps are used by a program the verifier return -E2BIG.
> Add a verbose message which highlights the error and also prints the
> actual limit.
>
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

