Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E1713D891;
	Thu, 25 Jun 2026 02:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782355536; cv=none; b=QG37CAI9jBpl11gX9YyZA0u8QouxqjlZb4e9/1Ns1xMGKZbGlgBUaRZYfjJ/hc4kZoAEF8oZEXTThgNfKoWdhBEtw6eyW9aDOS5PBdQtYo9s2TjS2EUlwdvwYg/1Y+4NOjkeBZKYPtZZP0D7iUWmiBbg1pNsklRb/dvhnL09amw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782355536; c=relaxed/simple;
	bh=HsIsvkCBdswzkkwm80TK52fKpjineNgdx3hZ57XP61E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qDtmAHMy5pzjqOkw44ElB/zuP2L7bOjM5hm4O6KtH0G59ikGdmaQZVmRAd+qhHTU2500JhVD8cc8tEk864zYlOeNWbZxXbxqiGJi268s7eEl/RS63EBJEt1JBbI9vfKaQW9PHQALiya7RWxFlsudsDqsCe54MQsk1zM1QgfYiPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YQUiPYwC; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YQUiPYwC"
Message-ID: <951feedc-4764-42a8-886a-b2e7dfe75cf9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782355532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j7zz5j64VzwH9RWYlZ65le/ZbRuht5ZmZ+Z29QkrcwI=;
	b=YQUiPYwCeuFPWCjth8pOY+R+Q31ZyCVQY6g7m+VTKjgfCH2ifPfJy7Sb1Ynh5PpeI69KNz
	9K0Em0MrhJb5JbZVppCTYs3A8t4IZNbjlNKomLlWS/RhcMhouW063WAXONcxou3FSoYKjd
	MfTnJQ8E3A7DM0N0eg3TdZyJS36qvQ0=
Date: Thu, 25 Jun 2026 10:45:22 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 06/11] libbpf: Add support for global percpu
 data
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-patches-bot@fb.com
References: <20260622143557.22955-1-leon.hwang@linux.dev>
 <20260622143557.22955-7-leon.hwang@linux.dev>
 <CAEf4BzZSeMSMnuYdLvEfb7-pmbthjU3J7W3QB4q9-WN_4+QrbA@mail.gmail.com>
 <8f06ad4d-d003-4671-9dd4-24b5c7e4b806@linux.dev>
 <CAEf4BzYc5n9GQEBoSs3kqzM7DuPaYuZ5q+BzXNMbrF6sV1DLmA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzYc5n9GQEBoSs3kqzM7DuPaYuZ5q+BzXNMbrF6sV1DLmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 25/6/26 00:45, Andrii Nakryiko wrote:
> On Tue, Jun 23, 2026 at 9:14 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> This was suggested by you in v3:
>> https://lore.kernel.org/bpf/CAEf4BzY9KeVeo2+6Ht1v3rL6UdwNxABZCSK1OZ_sD8qhpYZaeQ@mail.gmail.com/
>>
> 
> ah, the dangling pointer in skeleton that needs clearing, I forgot
> already :) ok, I don't mind mprotect(), it just was a new case that no
> other map followed, so I was curious if we can avoid deviations. But
> that brings back the KCONFIG map question, can you please check what's
> happening for it? Maybe we should do the same mprotect instead of
> dangling pointer (if we have dangling pointer, of course).
> 

Looking at prog_tests/skeleton.c, skel->kconfig is NULL before loading,
then becomes a read-only mmaped pointer after loading.

So, skel->kconfig is not a dangling pointer after loading.

It looks good to mprotect() skel->percpu.

Thanks,
Leon

>>>>         } else if (map->mmaped) {
>>>>                 munmap(map->mmaped, mmap_sz);
>>>>                 map->mmaped = NULL;
>>>> @@ -10806,16 +10847,19 @@ int bpf_map__fd(const struct bpf_map *map)
>>>>

