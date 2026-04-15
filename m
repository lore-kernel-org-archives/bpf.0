Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207213E51EE
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776273812; cv=none; b=tMHGpaBIt5wDKbxd7pXjhAYv+qRC1h2luhojadO4AK50YhskcQlUuaPCrq8w/L64Ux3jCvuMF2ywHDi4jVe7OIv9/g6pKdaRoTAhbWrdBUdeHbDGIAHZlfcKivX16fd9z4oe9kbLPUAofGhgjr1IFYJCHxFvfGW7VRuCtHeYLb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776273812; c=relaxed/simple;
	bh=mpiW98q5chB3jszBp5OXfQ1hRIuKU7nwacyQchk257U=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fpNdevH8RMJJ/BA54TeEh7OBvmi0ZJbeFFxX/8Bai1e5zJ/+KjULmHZa5YQUta2zbAog7aTKZB3GA0lPWfudW/DjmiAtjZhG7r6arZtKBJZqfsUjl8/ujPixpQ1douTr6AIdhVpJpyrtvEVbUio9xRP+RwZ32S+Eu5JWuMV84MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBvTTE8a; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBvTTE8a"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12c55e3858cso5138827c88.0
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 10:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776273810; x=1776878610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpiW98q5chB3jszBp5OXfQ1hRIuKU7nwacyQchk257U=;
        b=KBvTTE8a1mEX0n5ee3suoG6vnre8r0VQSYC3Z8kVmp/bulTZkImpUjiCTVGRwE1PoN
         MqAJmHBHvIlTCOPVh0TH4qDI0KZUw3FpHFjesFyH9IxhiKEksQqcC/GbJDp+LSHepgGI
         NkYWfluGQOF6ouigZUpThu8l8MBPzmEr0fOTpmPtGTdtqVX2iz7+0KIynxOxza6efz9H
         2ltl24ozJItfGthqUFxBMnDgJIrOk9rqQMIEMtf/RAaVmuMFfF4DiWgfIrqCPs87+Cvt
         SEwxmB1PY4D9ttRcA4ZvNkTpXkIzTT5LtrWc2xj/13yjgDoztAxLQJ3bClxgSsFBuFFW
         DuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776273810; x=1776878610;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mpiW98q5chB3jszBp5OXfQ1hRIuKU7nwacyQchk257U=;
        b=kFIv1k3hQ+D63vSlQoKDmzyKeqURDdEmQ5pi9kcwdKhJLiCVKb6FrO14h/1bgLj1jO
         a6nFTY+Nb6bKqGmSKUOj2BgvaPQOqjN+AB54gUgsLtMpt+mrGP5GNUgpmNXeSrEUwcdL
         0e3LQJi6e0lvQAxLjP30mLWAK/CJ5GeNq7IV8Gv7oQpkornZp/aqgu4ttIoOFjl/bIjB
         O7If1EJI0EoCaRcvBThFpr/Wv9pXep8gJBAG/fx9WWpYQ+JVq8dnMAjKq9TCpXKyOYzO
         XlLCfEpgnFN1gfGHfCIWdDDRrAuAcSNQyhq/WwG/yD+WAEqR8eIfQNgsjDidRGdrpWOv
         1uyw==
X-Forwarded-Encrypted: i=1; AFNElJ97J6XngGa/YeLjra9BgM3NFla/kRyKCJqwmIzFSB9Lh8rzvXKHgfFw+xwtfZKzcAekyCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqXmt6bFRrUxJ7n+u5r/bFplZ6Fs5VWKupQlrRgMG3vsWFtBz9
	9F4OaHM7q/cIhJNfkf5kE7r3pe2oFTT7V9lujGxcURzxaSn9bWgDGCsR
X-Gm-Gg: AeBDievW+/JpiLkUYgCJcIfbkbXkOQsyxBN+9j8BxYlo+536FiWkPfZkf8B8z/85lTI
	bi6NBErWZZ8KTtB/Zo59rHspQoXvY21C1GQqeLY4RNEjRsn4Hb0V2HBSPjK+T9xDZ5UuqmCrfSG
	3e+wZoU3CZt9thGPQt/QLiNSeHj+eDBpy4I7piAHrmbmIgi7EaqzPGFcYccwk6XmQvJuPC5banD
	xiJVMwmrYDM6o3xjHwVTHxZBGZ1TA9KUxKwdCa8woMTFoMkwx/BToo0BkuP5vXYec0Z7C4lN3VE
	icVeJ7FXqE9UMqi/21li5wuaEFJiX7P0UoLu7ElPFQ9i9+89tKTiCFyM1rI3sEn1GZsxuJsFQbX
	9raCEA+Lffha8NN2beUuoleuJ8QIxQX0wIe40fKAFo4EQjDkib3YR8lKVrdQRU8M9fKICE7fr1g
	GW8qS0iFqhzvi6h3nPs5MFwtW7X5x0OaV8gFbZcBTwPczDX+s=
X-Received: by 2002:a05:7022:fa8:b0:128:d2a5:709c with SMTP id a92af1059eb24-12c34f18363mr12935629c88.33.1776273810099;
        Wed, 15 Apr 2026 10:23:30 -0700 (PDT)
Received: from [10.0.0.2] ([169.235.25.186])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8f65fc42sm3485269eec.23.2026.04.15.10.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 10:23:29 -0700 (PDT)
Message-ID: <2fbe2fc5-0e4d-4a87-93b7-9b23f8b3a16b@gmail.com>
Date: Wed, 15 Apr 2026 10:22:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: yuantan098@gmail.com, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 sdf@fomichev.me, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, bjorn@kernel.org,
 linux-kernel@vger.kernel.org, yifanwucs@gmail.com
Subject: Re: [PATCH 1/1] xskmap: reject TX-only AF_XDP sockets
To: Jason Xing <kerneljasonxing@gmail.com>, Linpu Yu <linpu5433@gmail.com>
References: <cover.1774701288.git.linpu5433@gmail.com>
 <6584463e576b7bb3619dc302cfecfb8ca56bc86a.1774701288.git.linpu5433@gmail.com>
 <CAL+tcoAy5WQRsL6z=YinPaiBNvd_=WB7qsR4amf1x4=qVw7AAg@mail.gmail.com>
From: Yuan Tan <yuantan098@gmail.com>
In-Reply-To: <CAL+tcoAy5WQRsL6z=YinPaiBNvd_=WB7qsR4amf1x4=qVw7AAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/15/2026 1:43 AM, Jason Xing wrote:
> On Mon, Mar 30, 2026 at 3:33 AM Linpu Yu <linpu5433@gmail.com> wrote:
>> Reject TX-only AF_XDP sockets from XSKMAP updates. Redirected
>> packets always enter the Rx path, where the kernel expects the
>> selected socket to have an Rx ring. A TX-only socket can
>> currently be inserted into an XSKMAP, and redirecting a packet
>> to it crashes the kernel in xsk_generic_rcv().
>>
>> Keep TX-only AF_XDP sockets valid for pure Tx use, but prevent
>> them from being published through XSKMAP.
>>
>> Fixes: fbfc504a24f5 ("bpf: introduce new bpf AF_XDP map type BPF_MAP_TYPE_XSKMAP")
>> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
>> Reported-by: Yuan Tan <yuantan098@gmail.com>
>> Signed-off-by: Xin Liu <bird@lzu.edu.cn>
>> Signed-off-by: Yifan Wu <yifanwucs@gmail.com>
>> Signed-off-by: Linpu Yu <linpu5433@gmail.com>
> Hi Linpu,
>
> Any plan to post a v2 with our questions resolved?
>
> Thanks,
> Jason

Hi Jason, Linpu has an exam to take this week. He told he can try
preparing the v2 patch this weekend. Best,

Yuan

