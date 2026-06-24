Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E1434753B
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 04:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782274339; cv=none; b=NVvbIwAMO1m3zsFf6m75Gysf9X2KmMA3N7SLWYLgvav99bMzywAqdgrqpEkHd96lJqXCFlGjWvrqAPDx8TuNXxuC04GB2mNJ2I2c9oG6tqAlT484nev1lqASKbUtgUymkteoHF1M9p19mE9WYFKZ1a5+3qEhlsFK4RER7t3k4ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782274339; c=relaxed/simple;
	bh=bBG1n+imcuvQSVkq82q/due+HFqznLosHpnq5suYMck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NoK7vpUJT3FJ9NOZsZHlr2FN22To5L+e2zrPJAH6KECYOc3ULth0aEjPy9W7eh05BFAWvGtdDcdVM7zPpn+WYnxXHbBOLcapfQJ1CYgoapHVuEytZ3wG1bfZFrhYikpE0u7cIByev7NhhvYpXkS/JRn8eHFab3tXLM+T+I4c7Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xcOjqmm3; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xcOjqmm3"
Message-ID: <bef12722-abae-4dfd-a32d-2e5c87b04787@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782274325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tq67/RLWdr4UXVlNhGEPGP1ZSAdu4cOta2u4Qou8dLU=;
	b=xcOjqmm3wbspEUbJZquZOVxeTnNV079S14FBjCbrB10L4NUqjZszu+4JtceqBG4JnPqdL7
	TQ5qhzH/JZ0ubrRxV2/A2F3dqpzxwI3OR1+xIzOrgWtyNLicWibs4MkpvzSjgpZzmTUuU+
	MgJBqrPA2Suz3vlc8dMPhtGdQKzIWT4=
Date: Wed, 24 Jun 2026 12:11:35 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 05/11] libbpf: Probe percpu data feature
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
 <20260622143557.22955-6-leon.hwang@linux.dev>
 <CAEf4BzZ+1Zc4QerMGVeS0MJ_gkk14VVKCKS0PfOUJ5P_Q_92WA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzZ+1Zc4QerMGVeS0MJ_gkk14VVKCKS0PfOUJ5P_Q_92WA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 24/6/26 06:45, Andrii Nakryiko wrote:
> On Mon, Jun 22, 2026 at 7:37 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> libbpf needs a reliable way to distinguish kernels that can support
>> global percpu data from those that cannot.
>>
>> Add a dedicated feature probe, so libbpf can make capability decisions
>> early and fail predictably when global percpu data is unavailable.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  tools/lib/bpf/features.c        | 35 +++++++++++++++++++++++++++++++++
>>  tools/lib/bpf/libbpf_internal.h |  2 ++
>>  2 files changed, 37 insertions(+)
>>
> 
> lgtm
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
Thanks for your review and Acked-by.

Leon

