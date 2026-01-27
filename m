Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF75328B52
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 18:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539362; cv=none; b=MYkt2EbLz7XX6KQV6EqRrq9bXn2Hr+woRNO5Xczc8SL6AUFZgeaZUoMHKO20CoMW/4vbCNBgoD03oefM9R8TLvY2mjE7llxuBhlfe9yNVdersNONDqGrbB5b/emUYqT7rvmWGxu/tcvX2H17ZMaHT/5wl91Nk59Bne93zlvEyxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539362; c=relaxed/simple;
	bh=wFzLu3MBEJzskcbgdlN7e4gWlGRm5+p4qZvnJBX8CNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l0SichMPY8IoIwWkbrLnnpf+Pwmknigrrxj4UANcU977vciYSWPDE/eAjV28xdLoLR7rQ1OEmJ9eroLcTOC9fK/I3+UOHeI/z+hjujHYDeyXq9zuEvYW91xrFGCNtyPODVxuryjMphmTbojKuEHNfmjpYDWOhLiSr/qCfYDpDqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXeshiST; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXeshiST"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4801c731d0aso47819655e9.1
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 10:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769539358; x=1770144158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o9ZuXtZ9PMapguvR1sUXaXbSM3pScxlllWbzjAEYBR8=;
        b=HXeshiSTyP/Jf99KtVOEkIMPhC/NIrXMQM9w58TRTt1rJv3kR2JWCdJX4ABx2pwOxB
         3DE8MM/gn6ARUMWg+i6kgHGJ6EJ3AYTW6ypNpXen3gdxkIsQKsuVoHKJm6ulRg1y/lR3
         6o6ItC7Uc/yJz9bYXzp9G1SSl6ajcWMK5ghTyuUBd/KlKVsZUb87tRr00WwND4HBejtQ
         O83vYkvJAQ3C2P8bTg49qAXCi0qcsT2MSae8kMy7gUVyjTD95OFL92Jg00SAXL25q9QV
         vfJDBHnPhdUl5fvDSO226tEMjtnDrgro7/nSX1JCyU3Xty8gaNBNBvO9VGY+XHox58rT
         OdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539358; x=1770144158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o9ZuXtZ9PMapguvR1sUXaXbSM3pScxlllWbzjAEYBR8=;
        b=t1geyOfb12KTTwRmmmOaxSK0JMbEpHqIfKYRdoTPolfvcH/9ABSHUr79ZZ0XqTBy2g
         8p6aWbeWMcHlQHdBCavBbvqG0+S06IYOB+NViNqOs9FXLVSaiDlfGoEEnaz2Ey8MHjRz
         YqcAoM6AwfCc/8/oNaYJt4QpOzENzA5nKhZvFP5ezFy3fwOJNfIOaASov+e1Sq0xOtxp
         wlgvwzwBtI8UqAQ8FjeA3kTKer4vkAjOemqSC0hJPbkRrw2nFFuz18HVBt40tmEBm9F/
         tJBW8ruU/4jpcze76si4iyFCU1VpqogWLK39AVQpLg1lTGYwy3NMYEc21rb9j4JG9iLs
         os9A==
X-Forwarded-Encrypted: i=1; AJvYcCXOx7DA/Nojuz7n1SoflwdZeN+XFOCcYcao0EDI/8bPoi4PgErrQXNy+Yl29NwcP9KsUEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq7b8CTXoKN/G4zktjjj7oSGR3Ae/qIu4gB0lM3jMambUNhjvE
	8boiVpBhegDU6x59v/F9A2GSXoAPjNaz4nLXxIhEFUVA8K0ko99pL/09hRxXyw==
X-Gm-Gg: AZuq6aJmMEiRQHIjjzPmYOETI8ixR6C6AfVx1TGc7zOWFxBGaLKYerR74a+ft80pvB9
	nLAnm1aNCiVWbc5EUQBNJpHMdWtRwMVO2ktyjPtNO3fHyoXMzqgbsM6teygPhgPXoCPcP+uQeiX
	AlD9g0tSGCVNHL88PIfEbMRHRzaAJz+TdWgY1+a4xZJ9PE3lIQe55y5eWbXuPaf6hrW3foPvlmP
	4J/6ovphS1i04a4SmmfhJlH7Ze9XWtDU8h5FdrTHDJzTQcT09NVFtKviudS2k1W6hMVKy+XKj0T
	V3J1wP1PTSz7vroFJtkYdERJNXiq2jN0oWqdXEBNW13b6kcN9H8nkq4jkR+5bTJWCmCr9USZAeo
	YUXTmZIwPhso4E2e6EmB6fZjpfEdpE0a2lsZqZk5q70nwCNZ3esJayKqtp7saPGFdNiIf5AizYS
	mtvPjn3O7c75ZfwnbF/8bqESf+lTtL8EzLERkym8c5JsyvI5RD+SuU3iv1CiKbhlqQIdPv9LMeT
	4ROOaWVgS+hhLrT8mK+Ee9/OIZGhcscXec/FLu3OzOMhpAYpOKpbpryqKFjnbox4w==
X-Received: by 2002:a05:600c:3b19:b0:480:6852:8d94 with SMTP id 5b1f17b1804b1-48069c54d4dmr27946635e9.27.1769539357798;
        Tue, 27 Jan 2026 10:42:37 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066bee7d0sm80440745e9.4.2026.01.27.10.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 10:42:37 -0800 (PST)
Message-ID: <a61a73b4-01bc-4547-89de-7d70b0c86477@gmail.com>
Date: Tue, 27 Jan 2026 18:42:28 +0000
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
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAADnVQJcoyJ1hmU_oUcjj=8ewPAPTOZ8eccTutSJWHFy2Xza=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/27/26 17:32, Alexei Starovoitov wrote:
> On Tue, Jan 27, 2026 at 2:15 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> index 000000000000..7a170cb2f388
>> --- /dev/null
>> +++ b/tools/testing/selftests/io_uring/types.bpf.h
>> @@ -0,0 +1,131 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>> +#include <linux/types.h>
>> +#include <bpf/bpf_helpers.h>
>> +
>> +struct io_ring_ctx {
>> +};
>> +
>> +struct io_uring_sqe {
>> +       __u8    opcode;         /* type of operation for this sqe */
>> +       __u8    flags;          /* IOSQE_ flags */
>> +       __u16   ioprio;         /* ioprio for the request */
>> +       __s32   fd;             /* file descriptor to do IO on */
> 
> 1.
> No need to copy paste. Just include vmlinux.h. It's there.
> 
> 2.
> drop KF_TRUSTED_ARGS from kfunc. It's a default now and this flag
> was removed.

Got it, will change both, thanks

> 3.
> add a runtime logic to check that the return value is either IOU_LOOP_CONTINUE
> or IOU_LOOP_STOP or instruct the verifier do it statically.
> Otherwise it will be less convenient to extend to other commands,
> since the way I read it IOU_LOOP_CONTINUE == 0 aliases to any value > 1.

Is there a struct_ops hook that can help with that? check_return_code()
has some hard-coded checks, but I can't find anything customizable for
struct_ops.

-- 
Pavel Begunkov

