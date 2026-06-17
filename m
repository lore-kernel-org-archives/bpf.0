Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3540F37F74A
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 18:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781721271; cv=none; b=OmEidhQ86/HV4TuQ7GK3ZvtbeHQWZbRqvgnJj8k03lHufwBBoEbpfJQZTe5u3g56QB7jLmn3/dCPlBDD+B9dNq5zWE6G/3uxklVw0yuM7/17odKRkjfHR912exZqdpHsgTRlv/YOJcTnIvKM7DXS+y4ZmMLMgLElS+VRdjXGlZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781721271; c=relaxed/simple;
	bh=566wfjr3FYnHrIw02HZwXcsTHRhlJa559MvaFVl/zRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sEQZE2GdUjceNHR/BUloGezVzXAps7hqy/7/sxQpmPZ5WK8teGlSsulzymHKICdR6HCuZ2zd0tlsDLBMD6fN9tzxMyqT7SEqPv/YsQyoYDZbQcDGc50CSdiA2Zz7CLEN+B567pATPh2p4QbT8c//pH5wkXi4DUitlEM7CEbzwp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KlFj6k9n; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KlFj6k9n"
Message-ID: <3796b595-2889-4668-b242-5bc43be17714@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781721258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=566wfjr3FYnHrIw02HZwXcsTHRhlJa559MvaFVl/zRw=;
	b=KlFj6k9nW+1AfAj0uNwFam+GEhOyqx6Ax0hAkJQgCN4yTkR0772dkH/93QortRmuAkjKIM
	Sgn3j88uxn/aTQIcE5ymfEzo0QA48IXdvEsy37fB70vdgr2Beo04rlLpwG1uKVmQ3wnu4J
	5DYx1dF0iZTRLcMN2l7cXGLOVbZJsug=
Date: Wed, 17 Jun 2026 11:34:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PAHOLE v4 2/3] dwarf_loader: Add support for
 DW_TAG_GNU_annotation
To: Yonghong Song <yonghong.song@linux.dev>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 acme@kernel.org, Alan Maguire <alan.maguire@oracle.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, jose.marchesi@oracle.com,
 David Faust <david.faust@oracle.com>
References: <20260602195512.1511013-1-vineet.gupta@linux.dev>
 <20260602195512.1511013-2-vineet.gupta@linux.dev>
 <8ccb6133-2964-450c-9409-ac99e4d5300c@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <8ccb6133-2964-450c-9409-ac99e4d5300c@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/3/26 2:41 PM, Yonghong Song wrote:
> LGTM except a nit below.
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>

Thx !

>> + * Handle gcc style btf_decl_tag annotations for functions/struct/member tags.
> For 'struct', gcc is not supported yet.

Good catch, will fix in respin.

Thx,
-Vineet
