Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578BC33BBDF
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 19:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769541651; cv=none; b=QZoOxZnfGHLaqJkrMiesKXjsl8aNx2CA8aDLOglhgK9XZdRB+n7X8UY48dplddD+H2Qh9dhKnNah0kMfFUKEEL2aMs8Y3gTQrXeub4Bf7E95cbJ3uElRV6JQeyYGwRUWTzAGkq30pu7j0WP2iCAssSLcjlbqVx/lM/1qegYBjqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769541651; c=relaxed/simple;
	bh=WN4/nLcSn14d8v7TmB2eqmEF6NNK9K6jkUkRBsCZoLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/T8vRB8BDk4Tx3ieE1dtg782GjTf9yk87I2NoaLE4AXsdiwzd3bAXRkFy74s+8o92gIJoQZUKWIqxpTWbc2V1Zp/pkqCUsEWLJhcIrdrZK1FjjM0QDk2grL0FuAZAbN5h2AkZg8DkimS8YCeH6d3LhrrZqfuVYp0YEbgDYMTfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7OGg9bL; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7OGg9bL"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4806dffc64cso202585e9.1
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 11:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769541649; x=1770146449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RNNELjmA7t4CjhlGrI7qDPRy51rdXa6xjB2ziKOJD6M=;
        b=b7OGg9bLbnNkgSEkbJdeWscFZ2EbVaVMTZONFcvdwgNPN9PvH8xHUZKzGFk2HTchmI
         nM/+KHLjT5a5/DX0noQjy1liHCvbVOs+9vAL0oHXRp3id3ESJyP2+7GXTxCPd2H5VLz1
         tzW1qh2mNX3G1FBYkOU5MCak45ymD3X4FBLPVy/X39I/BjtrQaPBEfkevJKDwhOL24dZ
         H1IzXiGcK2qbPuLWockS7o9C/gLZZtngQW8Nm7M3S99toY5VxK3d0zB8K37NvCvL6axF
         Emk3v6mArQb8OosaQnr+U8eX+NgJ2dOnsIO40BAyjYhwnZ3+SeKFOS75+bt2/6b1G/lp
         uuaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769541649; x=1770146449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RNNELjmA7t4CjhlGrI7qDPRy51rdXa6xjB2ziKOJD6M=;
        b=DCoFJr4bfq7bTqsj9Efioa76IUtBe7D2pHErzC55q0Ilzz77+Jl6Oa1L0nAXHYFv/U
         rjJ86NP71W/pOngD7jCo2TajqucFtkkc9eCRWqv+ewRtwgbdGuBBIMS4RAMAIaKW06Vo
         W6MNgDRKA/UYIzkgg0ehjiWyqsY52f+EGXrIDd/HnJDg/a9xnroOfJGMi5vy2fj9i1iX
         H9lyW3OqXnyOhvOM6kq0KuQrFRy8DYGqlHs7JgHbc6Ktj1lSeWY/NSqn9vQmxFuvWa77
         aCuA9bbO6mUCfDt3kl6TahsqzNY0tsHvGiR+D5a8w+1yW9rManYMo9uwltCraTajob0K
         bG3w==
X-Forwarded-Encrypted: i=1; AJvYcCX4QLhGVrVMZR52TPBlSQ+hI4Dq1Xws7oiSAUlHa7Eb+EejqFg1loZbpkav8TEngcOD0/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY/CWbLc8PBTh8uzbrJyIkVAaxhKtl0MNv7FrSUxVGhK8wWZvy
	VJCbCoML/u4yCo0Vi0Yb+ofPEtFq3t5j92tZBO2Zg2iDw55VPxLxvAol
X-Gm-Gg: AZuq6aJuwOVNrNb9ja6hgX61fKHUqVaFymSwfulJwzyvOiC7Pntkc6bPzeoK23Apjnd
	chy983hSqH0YUkaM5zClHPQmbOHRlbOD8gMkxsiMBQhtrg+MuPckKNJeCxBhGsodBPGwQ6iV02o
	7uh8VhbAPhO1VVfCY5WS2/bXlhMlyBoEAreeaowCtAYfgt+AEf0vuVdeVJI+jvDFrwDSMy3UQlO
	plOUxM5qF89tF4CDTBH4P1lqnyz8ZHOBzISY97+Crm8KP/9LG7OfgjUACRimgiYtm/2HMwbUqUc
	JbnP102imk5j/WVaTnQwcZcTiFo7Rv4SiQSqXj17+oRYTBYC1bcf0iaWa3TpIZzzRDa3BPBGrwG
	NNkI9xZBgxW6MCYG2kJd7iTtBnPpHnH/ChQ2zxX7w4QFhtF7IEpYmTeZOkpKxxiW/N30uEZGyFW
	zr7wbZtCTejFDx2k5SXQgiG4zQ4E1yPEsVQqzGVfA7Pi45hNoAjK6V0k0Y5rFygsOTaCqZnlm5i
	xZ66Vu2G2zoJCO6PRHZNaGiw8fsdh8Bx8pIO34XcwW/BBkfX/w0qWr2PzjGu6YDQQ==
X-Received: by 2002:a05:600c:3b96:b0:47e:e4ff:e2ac with SMTP id 5b1f17b1804b1-48069c60317mr42538605e9.33.1769541648637;
        Tue, 27 Jan 2026 11:20:48 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c37420sm87008175e9.9.2026.01.27.11.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 11:20:48 -0800 (PST)
Message-ID: <8b2cee27-e6ac-42fa-bf9a-38a1af39b0dd@gmail.com>
Date: Tue, 27 Jan 2026 19:20:38 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] selftests/io_uring: add a bpf io_uring selftest
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: io-uring <io-uring@vger.kernel.org>, bpf <bpf@vger.kernel.org>
References: <cover.1769470552.git.asml.silence@gmail.com>
 <b766b428ec90862d69c9ab843dc89b6d0a017628.1769470552.git.asml.silence@gmail.com>
 <CAADnVQJcoyJ1hmU_oUcjj=8ewPAPTOZ8eccTutSJWHFy2Xza=w@mail.gmail.com>
 <a61a73b4-01bc-4547-89de-7d70b0c86477@gmail.com>
 <CAADnVQ+w1OEm7gFb04u6V=5LVw6VefNr_V2FuczBjtaOioH=Cw@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAADnVQ+w1OEm7gFb04u6V=5LVw6VefNr_V2FuczBjtaOioH=Cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/27/26 18:53, Alexei Starovoitov wrote:
> On Tue, Jan 27, 2026 at 10:42 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 1/27/26 17:32, Alexei Starovoitov wrote:
>>> On Tue, Jan 27, 2026 at 2:15 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>>>
>>>> index 000000000000..7a170cb2f388
>>>> --- /dev/null
>>>> +++ b/tools/testing/selftests/io_uring/types.bpf.h
>>>> @@ -0,0 +1,131 @@
>>>> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>>>> +#include <linux/types.h>
>>>> +#include <bpf/bpf_helpers.h>
>>>> +
>>>> +struct io_ring_ctx {
>>>> +};
>>>> +
>>>> +struct io_uring_sqe {
>>>> +       __u8    opcode;         /* type of operation for this sqe */
>>>> +       __u8    flags;          /* IOSQE_ flags */
>>>> +       __u16   ioprio;         /* ioprio for the request */
>>>> +       __s32   fd;             /* file descriptor to do IO on */
>>>
>>> 1.
>>> No need to copy paste. Just include vmlinux.h. It's there.
>>>
>>> 2.
>>> drop KF_TRUSTED_ARGS from kfunc. It's a default now and this flag
>>> was removed.
>>
>> Got it, will change both, thanks
>>
>>> 3.
>>> add a runtime logic to check that the return value is either IOU_LOOP_CONTINUE
>>> or IOU_LOOP_STOP or instruct the verifier do it statically.
>>> Otherwise it will be less convenient to extend to other commands,
>>> since the way I read it IOU_LOOP_CONTINUE == 0 aliases to any value > 1.
>>
>> Is there a struct_ops hook that can help with that? check_return_code()
>> has some hard-coded checks, but I can't find anything customizable for
>> struct_ops.
> 
> yep. check_return_code() is the one and you're correct. It's not
> customizable atm. Much simpler to do a runtime check for now and
> improve through the verifier support later.

Makes sense, thanks!

-- 
Pavel Begunkov

