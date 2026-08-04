Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73133397929
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 12:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785847385; cv=none; b=rcuP7/p2auYxUOGI0zk3sIuBsQzFhqsAoO+GyFcFuwPVWSeVnEWIH3NE2eZITeBs9iNQ1zs7uIk0EQSmTtW9aMvVDOaW4hy7pUhbTXDML5Lje/JcIjYHaeWQ7749jXjTgaf99RA+CnVhEIIbkLI2OaYXa8urBFbVKv1UKfjy7H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785847385; c=relaxed/simple;
	bh=DtXh/mlNFR+bCLuXlTNfTGrdyML0sHf41b1CPtvxdZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oBoZJ5KZ03gKGLCg+zmdowhC+SopFwjpb/TJT5wiaEysGP+N1rYAArGhyyv+AXLMwlRGTH9nk/KuTNhmOS9yc9xxGiBjKqj6T8THacLlwAnVSYwVJ7S1tVXbwD0pXP7zDe0tVrI9GDhu8P7kJl/12h2Plxha6lgFxLYJGh0Ww3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayJyDSw9; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayJyDSw9"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6aae90e595fso1965687eaf.1
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 05:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785847383; x=1786452183; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hhSW4//mX9v1/R7JRR+WipUpRRwR6Gq7OCxzrdqwGgs=;
        b=ayJyDSw95L+O5H7AaNOZMK/bOuqi22gHNVQ6ZuLGL14SY27ajZhph9RZC9sT6XqFia
         uu5I+W4rLLolgk+E96qW8sScpBUCBn5x2r8x7pUy+dODnHL0GAluLxyHDDy4c7yFq69W
         rwl+VO7n4V2bNJE82sutJ6qXAasy9gfITvoyCyKOnus8jJVtYtLdDuIi41PKF06UuTG4
         FHaIHt6Q2bQ6Nk8aj0MKTy91SFSZw1tmHov1BGuq3wJDQ41aqjPd5PyrKVLEfv6r19H9
         K6ZiECuPwpXaqRZnflrYSfhD/rjVcFCNX65zmUAUGdw3RBV9HM7egKVmSp/AKY4ijsZu
         DSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785847383; x=1786452183;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hhSW4//mX9v1/R7JRR+WipUpRRwR6Gq7OCxzrdqwGgs=;
        b=mKHgKDuuaoh5uamnj7+IOxq66ofsTSVO+Lxn9N+fDo6hnibzQxVLXgl3P23qq9AalV
         SedIYrEKMPTsz91EsACzz/XI+atTERbKn8Dpefof27yU4NXcstrz+zNF4x0SZrVSFS+w
         TVLwG1ZFZgJsycq66NHH2Awj9NlLUrfpVRjryMgQGAihxZWQ6VCt5CHnXn+ZCeIuDvv6
         4dCLTs/aJvBXaE7G7DLPO6YhWN1DNi+Vs24cfLn5ClCYW7/GNBXOZAH25IxyFwNgfmjO
         MbAz/UD29lRxaWBqbA9B2aPnbhRyRQyxJ7XfwHLkfSZxnZ6Ep40OEu2dYBUEVayhl8sj
         8Upw==
X-Gm-Message-State: AOJu0Yw2+nsK74yLY3COe5iHWcSNuac55I3KB3cZ/yjVEwqT+/jSGNuC
	vdOoe/3Ev7SK0Hq4rWVyCemdNRT9IBKxhkIXfqgieYXKSO9fvkF76pM1
X-Gm-Gg: AR+sD10APLB43dJwCYHuEnyqsKlEsbCdOXwOvBEmvgnL5oUGRhOPW16u8rx7Bna+7Vz
	RST2PIgShmIH8XcvDpQ4S5XC9GXZdXTPGurqnc7q8i+HaJX4HXwCN623gVn9vpux9E+6tFnPVE+
	+h8wxk9uVCVlV72rZGXhkkAvRQH36d6fxFKEw5fyRIHqR/jQSeYp7lzfw3mPFAP4GWI9UFlhHfp
	1ueUtBGMXIIHD8GVhwxufYt1LxEPzRq2mE1ex8ImWu1qFOwY3yLyb/IJ1XpYeJRLjJS1xKMIVSX
	aLULjW29c/jHCErSLxwjL/hMAM3EycJ54eskHGf63Uubr1IlTL/MXJBkoUXEzXvkMqPF4BIQOEl
	3Q1JlH/NUscNMTuKO61uBBc6aDyS65CJXcXxxr0qeI7/2JfCoGaln7EVrpRMuwr+MD9taNDGR1i
	ZXxsgRYRHaPp/i+LtKQtDLu86kA8Ok9k3YkW1mpC/5hzdg9GeWY8b82t1aWwhp4izM2WtGMULY
X-Received: by 2002:a05:6820:61a:b0:69e:42fd:4070 with SMTP id 006d021491bc7-6ae431e0e4dmr17186032eaf.8.1785847382595;
        Tue, 04 Aug 2026 05:43:02 -0700 (PDT)
Received: from [172.20.10.7] ([117.20.149.92])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ae3a31d93esm8556474eaf.14.2026.08.04.05.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 05:43:02 -0700 (PDT)
Message-ID: <8d256ca9-9291-4151-a329-d0b9bf101a72@gmail.com>
Date: Tue, 4 Aug 2026 20:42:54 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: add KF_SPIN_LOCK flag for kfuncs under bpf_spin_lock
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Kaitao Cheng <kaitao.cheng@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kaitao Cheng <chengkaitao@kylinos.cn>
References: <20260804083212.79271-1-kaitao.cheng@linux.dev>
 <DKG0YUDSTBUY.1X220287HT9V3@gmail.com>
 <4aa061ed-6640-42b4-9f12-e33edb8ba1b2@linux.dev>
 <DKG27RH0P7OV.36PQRQ6C74UR0@gmail.com>
 <dd8e114a-7aa0-4657-ba28-2929ebca0973@linux.dev>
 <DKG32J18PN0J.OP1J3RRHOU13@gmail.com>
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <DKG32J18PN0J.OP1J3RRHOU13@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/8/4 18:22, Kumar Kartikeya Dwivedi wrote:
> On Tue Aug 4, 2026 at 12:09 PM CEST, Kaitao Cheng wrote:
[...]
>>
>> Alternatively, following the naming of GFP_ATOMIC, could we call it KF_ATOMIC?
> 
> I think that is also confusing, every kfunc is allowed in atomic context in
> general. E.g. bpf_map_update_elem() in spin lock critical section would be
> problematic (due to embedded bpf_spin_lock in map value surfacing a deadlock
> opportunity). KF_OK_IN_SPIN_LOCK_CS is another option, but slightly longer than
> the previous proposal.
> 
> In any case, let's choose this or the former one, and not fret too much about
> the naming. We can also choose a better name later on.
> 

KF_LOCK_SAFE? Since other kfuncs are lock-unsafe for verifier.

Thanks,
Leon

