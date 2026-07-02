Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EAB38422A
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 06:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782972996; cv=none; b=IJBgammBJxlDN22tUuDkytqmKyl5hr8rV2xB2RrpdDpmLJOg3f/sH/vUVoEgwpvpa36SEn0QorPZf+VZ1dun6DeAeRgnxH7auxQf0R75ahKTlc1tposRJNIsePXEfiD2U6NfN/4BP0OM1C8PSyVzVB6oHgy70+eMJxAL0PvfGBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782972996; c=relaxed/simple;
	bh=y2lWQetm/SsebnOJSE3QoRjhYBxQyq/0WamEDnjb4yY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BqMOEwb/38G4gGk+lKMIc5YHZkbVq8G/BwLhmx1FfAzAWFEjFeWk0+ncMlC7HEG9DnnH+6YxUycMSSEAJmO0dbkc9pa/ySnV2tpOOUUmcZDMd7gjrO1MoOTyPIhC81NWyBBWZhdbK9CcRYLlQxDeAEtiX6Owjrs+0NGJvVKIYIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BTMExvYC; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BTMExvYC"
Message-ID: <9b3f954f-fe5f-4aef-b290-30c4f92d4c11@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782972982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XDYLqf+Bz2afmlLc3wTUZI08nGC+yoHSsm0rrmj/GnI=;
	b=BTMExvYCDuKm8tK3Te+da/XTfM+JPnBCEoiuOEjNspBRj1loKE65JDPq/sZ7LXx7FA64KU
	SavO6eKU9mU15zAR0hlhTdwkggiNTQC3wUuwzjvEx4xY9lqJUQw4cTtN2pZgeu75T6TOjg
	Ayq5vl38f8mubywdBYLymr9gLQs5/8E=
Date: Thu, 2 Jul 2026 14:16:08 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 4/9] libbpf: Add support for global percpu
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
References: <20260629152406.52582-1-leon.hwang@linux.dev>
 <20260629152406.52582-5-leon.hwang@linux.dev>
 <CAEf4BzYVdP23ASHtAAzpuGH2Agx+aXRRxTsy6MZx0OgE+OffjA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzYVdP23ASHtAAzpuGH2Agx+aXRRxTsy6MZx0OgE+OffjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/7/26 03:32, Andrii Nakryiko wrote:
> On Mon, Jun 29, 2026 at 8:25 AM Leon Hwang <leon.hwang@linux.dev> wrote:
[...]
>> @@ -1975,7 +1981,7 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
>>         map->sec_idx = sec_idx;
>>         map->sec_offset = 0;
>>         map->real_name = strdup(real_name);
>> -       map->name = internal_map_name(obj, real_name);
>> +       map->name = is_percpu ? strdup(real_name) : internal_map_name(obj, real_name);
> 
> nit: I'd probably pass type into internal_map_name() and let it handle
> all this in one place, consider that for follow up
> 
hmm, it is a true issue that 'map->name' must have the tail '\0'. And
strdup(real_name) does not guarantee the tail '\0'.

Will pass type into internal_map_name() instead.

Thanks,
Leon

