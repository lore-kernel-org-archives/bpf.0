Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4D9356759
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 18:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784573896; cv=none; b=uvXn7K45Reb1kCKURNkMn0AFg//wjVKdrAmuu9+sg/Lt0tN/QZmMjSUPbrhCAwBZEdkzQD4WP60pnaSk8qnZMweFhjCPtLEdbKgfoZNG2h+CPTYLElV1J5WIOIGPb+Y5iP9tLeC2xwJEl+OqRyZBezRraXR+dzsJaS2PJJhqp/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784573896; c=relaxed/simple;
	bh=eMgTGw8wrTt0RInOc+uENx4fWyxGJ4zX701Lv6w7LfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pHLc2v0PZMLvqKH7F2O+bH57/VOqIWdXFkQybttGkmZLtCCOucsVuzHPEVDG02q4DGG4H62RJL3YB2EI6i6e8z4p2+Il/rSnBZxOOKLqlhtIZWPgM7XSkSY9H75X9aA+Ju3xCSx8Eu1w0s06Ltn7QAIfyIAGf+33jB2ILQu/aag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JseSykWn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JseSykWn"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2caea3f742bso125898935ad.0
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 11:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784573894; x=1785178694; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EUhJ3DQnkMITZG1aHb7WqoIrpGY+mCsbkAev63KsSzg=;
        b=JseSykWnQEbL9VNHG/JeFVk4GQrH5oPSkhuNksL7MzZYtCyomCmp+za+G4cUxVKEoy
         qwYyMBGgjK3XsnJajq5cr177cH6/ma41+ArA2yckiGPRljm10n8KN1OEEiEUYO9QxW9s
         XTM997IyM42GB6GFvNjgvyCD7yLPqkgWClBuNXSRB122MkbRBPH3m7Mho24r1PN/n97r
         hkonbXZcXNwpGcqtF95yLG+FUxFZddlBvfMdNohltecxGkJ+1saLbFIxYRJqFztvMH+0
         1Enm8/tT7TO0W1uVHUFHKlcC3V7SZtNWcoW6bYd0+p4aNPzqPqfjVRtaBeAnJIw1Qirn
         sLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784573894; x=1785178694;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EUhJ3DQnkMITZG1aHb7WqoIrpGY+mCsbkAev63KsSzg=;
        b=WhfT+d/I6OoVgoqR0AR1FOQBgZMVF8QcR6sxpxDHpDvEwo8uAGvTE6TRm+XmIIaS+W
         fuvIPk4Z98QF9r854D1xuY7tErXw9j2/yj1+/zdj/yXA3b1/8ac8goOwywN9XKzX/bVU
         vfxdR9Z/5Wu8sPundeictzveKFppiPz15G9Lpc4qqMBqSWCcyrgjVIS4UcDQrcyJbOCp
         vUT82nGC8VWv0vG43REzUYa1C/YYP/TbzgrVUOA/rjozc358OvZ2TqFLW4Cx9Ti+Ouwr
         BA7aVIPMIne4DvjBXIhSzqLEKIlPn90qx27dnlCD9RVYf9Jy0DXido8qnpNeB/Yo1nFT
         CwsQ==
X-Forwarded-Encrypted: i=1; AHgh+RqPvuyjLV1rfNQ1XBdiWjTsVMbe6bEKt0uQN0XuNPbWYAiyGCajZjWrwbGtPkeOuxZRKsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEOWnLow7K3CyodKALOiCGUuxtZ398Uz0OLNIq+qiumfEMeAy7
	BhjlOLTaZXKpdefcnaH9LCdxXA9CYy+/oA4mRoq5kv/W9TDo2oBE1Ywa
X-Gm-Gg: AR+sD13BjcMcT2pxXh0eC/1hqedveuMgLQDyKIdz331GWsmmdcJE5+fYJevXxlczDyV
	koSOb6yVb1rgU0m4mDmgw1GyOJPQt5EWoOqqc7ds38SH9r5Wxtd1raX//YoAe7fEo7GUbflv4ME
	06n8NtMI5riuqrM05q5/l3skOu71ChhkzxBW9YJDxwSI/VtcMt5vodv2V/t30ohpXlrgRkiojGv
	wbyEPZMaoTBMbNuKr5tBYTykOu4sxlBxitbK5e1d8X/Y/7xr9fH9NnEJIWrp+tTOlmb/xeq7nO7
	zuo0HgdlwAkx5xLXdnyyu/pr4RB5ZcS2WurhmPswhnVqyAkj7XZUNd8jw86wwdYb+0PpUWtRtuT
	Dl+AGyVBT2EkHROfmjAqu8+PCB/DQYVtxwP0QI7vyIJT8baxGP3x++3LpOw7Zoz31oDysS/SNby
	/uFPKzAVRiGx/SlOUqUms=
X-Received: by 2002:a17:903:13c6:b0:2ce:b096:e517 with SMTP id d9443c01a7336-2cf3489548bmr165934705ad.5.1784573894122;
        Mon, 20 Jul 2026 11:58:14 -0700 (PDT)
Received: from [192.168.1.77] ([50.47.108.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf347166e6sm61259355ad.59.2026.07.20.11.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 11:58:13 -0700 (PDT)
Message-ID: <505a58d4-e585-4cb7-a21f-80a721f5c452@gmail.com>
Date: Mon, 20 Jul 2026 11:58:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v4 4/4] bpf, cgroup: Fix storage null-ptr-deref after
 replacing prog
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 Pu Lehui <pulehui@huawei.com>
References: <20260720134547.1289964-1-pulehui@huaweicloud.com>
 <20260720134547.1289964-5-pulehui@huaweicloud.com>
Content-Language: en-US
From: Amery Hung <ameryhung@gmail.com>
In-Reply-To: <20260720134547.1289964-5-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/20/26 6:45 AM, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> Syzkaller reported a storage null-ptr-deref issue after replacing prog.
> This occurs in the following scenario:
> 1. prog A, an empty prog, is attached to a cgrp.
> 2. prog B uses BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE and calls the
>     bpf_get_local_storage helper.
> 3. link_update is called to replace prog A with prog B.
> 
> The reason is that __cgroup_bpf_replace fails to alloc and assign the
> required cgrp storage for the incoming replacement prog. Consequently,
> the new prog inherits an uninit storage, leading to null-ptr-deref panic
> when kick the new prog.
> 
> Fix this by properly allocating the storage and comparing the old and
> new storage pointers. If the storage changed, fallback to
> update_effective_progs which performs a RCU-safe update of the entire
> array. If the storage remains unchanged, we can safely retain the
> fast-path in-place update.
> 
> Additionally, handle the error path in __cgroup_bpf_attach strictly.
> Although it is rare for update_effective_progs to fail in this context,
> proper rollbacks for storage and flags are added for code rigor.
> 
> Fixes: 0c991ebc8c69 ("bpf: Implement bpf_prog replacement for an active bpf_cgroup_link")
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Reviewed-by: Amery Hung <ameryhung@gmail.com>

[...]

