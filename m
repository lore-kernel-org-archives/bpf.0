Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC4D13B5B3
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 22:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773699243; cv=none; b=BlKRKrCKRWNi2eIgJeI1t5//r2karMdaCCJePWPur5jGRxRGud2wzYSBWmEYg7+TEboOCmN/4Nrdu0SX9ytRff/C4ujIHZ9PfJGoVnnIsMNityIU986cDqybEgzji/QTwPdpKHqJRJDsyfXDgJhS0c3H3jTX6X0hjjt+jFpAqp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773699243; c=relaxed/simple;
	bh=yf7LnFAH/20ojMzGfvo3YFdGZZ+8Gj569dfrgxe2Ve4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HeGnonlG+jydVkYiWZSAm3DM3p4gQ7AjI3+kSeAlCPiPXhEpGaIVF5SjgrvwQTWHoMbxq6KWUkNadmKaXD2gMWro0ou0vJBbqWLd60sUYxR5RdApAJ1wIj/8Reu/tCnqmcsKRmmtWOXAyFrF/Dq5zntZqjJMprH5inok8uTCfDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UqCxBnGc; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UqCxBnGc"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-467166cb638so1830772b6e.2
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 15:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773699241; x=1774304041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GPwvoJ+HhUgl8bXKAn5EwOyGikkP/OfmER1NlRgJVCc=;
        b=UqCxBnGcVj/kgX5D4NZC3jgBUDKglK/dBZ2D8JCiU5N6z+BCi5rLT+4iQTlrXMQDHU
         47zReOSuhbX0d0a9iY8QnIBnlZk6nyIMpXLVO1jCl1D0DNv6WPRqMKIur6TnC1BEx+uM
         eFd/wy2r9VcoXFv3XWP3UWv26DtViyngxyTy17qvuTa34YvIY56SVfzzz1oMrU2cbRkM
         c+TBE9jh9PzZVDsowco/z1hrbSrcncUQzKAseTAdWAt4+vyKO+TTYKB2SaFPDgu0yh0Q
         LGyatNtpuW5z2uyKTFEpaYdkS1GN9fPCIT9JUtv3+6prbKfz8YR21KpIL4DKt6xJLe06
         RRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773699241; x=1774304041;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPwvoJ+HhUgl8bXKAn5EwOyGikkP/OfmER1NlRgJVCc=;
        b=gWTtiknyGWG/s+cWBbSB11yaMjcfk4PuDs1M8su5fseOYAD0uE0ziKy8ZZ5SFQhp02
         ry0CFF+mEbycvXZqankxXCdhmgmtkreRRfnwXZ1fL86Nr4KokHmr2qXlM0Fv8cYEhn5k
         WP+zBHVvPM5QOw8lTzJHolIiAEyt0dGYr5K+H6iqO1SYTJFImDGfC/DlomL6Qlb0Buer
         Uy7667937qcCON+oVXhqvYnHvhFMEBxAbZ+0RvK2n6S8ss2BMSM9EvAvIgOWWNtDaLnv
         O42c6xVviF7wFHTGZGd22GdXhnKk09lteQ3s3rtsohqNsJFRwxE1g76nazEc1+2u3o3H
         Yt0A==
X-Forwarded-Encrypted: i=1; AJvYcCXgAzb73jaQd4UotUTDh6e3xrnnsPuU82DtntzU0i2Piwf8M48NANfvFZrrnIYqR/gn/oc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5VY35bMrydylvSrS6u/MUidwbiSvufciwIDuRDlonUplEussq
	lG3UhmSNFc3NvKFT4WQ6mFlIG5OfqqOPLZytRMzfIRpASENn6qRh98RJDCyeai2pGVVnXW7OAap
	xwsAVw8Y=
X-Gm-Gg: ATEYQzyCWd8KdTTpMp98o1cKYsLJEOQ4Cia64UMDCEO2pN9BuT4bBLrxcbsuvajnCPT
	1LOSgJOd+BQEWJT3u9ZqG+B/u0bCzIJ1vq81Xu87+w9sucU9pqfPqjSRFMgT+gQQDCvDU+P2J32
	SOhw+lHZCWUeWB07VpQnn8NqS6nLIi0ArCMpyiF07kakdsQSLW4UY8mcFvPpDM260goMTjzFV3Z
	rINKR0dVTBLWipnrmir5/heVyen7q38bN6Vcv2Ap5+qJkwrg6LYJOYz5sPIVHOaDEtq2OFA4f3Y
	fUECbEo7ZHAkSLr3KB370hr/1FRA24EXzzZCx4qHvqHwIsNo7UrGfmkPYAL9DsKPxin6AxzNkb9
	5+62Aw65Sxi8t1nWVFcydPjrKR3Li7oTaKlqi1JKVZTOtjbLz996OEFEtYU7sf/NMNFJtpOj1NM
	IFoRJosqtlQM+JP2Tgx5t+baRzjIHqC+9sBQaizUV3b8f3nxOJJI6fA76wp2dbdp8U5+UFp4Wt7
	A6bsHSsFg==
X-Received: by 2002:a05:6808:6ecc:b0:467:2a6e:adad with SMTP id 5614622812f47-467570374dbmr7908027b6e.11.1773699240783;
        Mon, 16 Mar 2026 15:14:00 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467342ef6fesm10347379b6e.14.2026.03.16.15.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 15:14:00 -0700 (PDT)
Message-ID: <c75e0728-4619-4435-b4a4-9c80331a5408@kernel.dk>
Date: Mon, 16 Mar 2026 16:13:59 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/4] BPF controlled io_uring
To: Caleb Sander Mateos <csander@purestorage.com>,
 Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, bpf@vger.kernel.org,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <cover.1772109579.git.asml.silence@gmail.com>
 <d8c8748a-4b13-4097-bdeb-495e6410a0df@gmail.com>
 <CADUfDZoBTwnCo-f_st9-jdgNhHLWUCjZQFpGdowGUA5BoJ836w@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADUfDZoBTwnCo-f_st9-jdgNhHLWUCjZQFpGdowGUA5BoJ836w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/9/26 9:02 AM, Caleb Sander Mateos wrote:
> On Mon, Mar 9, 2026 at 6:24?AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 2/26/26 12:48, Pavel Begunkov wrote:
>>> Introduces a way to override the standard io_uring_enter syscall
>>> execution with an extendible event loop, which can be controlled
>>> by BPF via new io_uring struct_ops or from within the kernel.
>>>
>>> There are multiple use cases I want to cover with this:
>>>
>>> - Syscall avoidance. Instead of returning to the userspace for
>>>    CQE processing, a part of the logic can be moved into BPF to
>>>    avoid excessive number of syscalls.
>>>
>>> - Access to in-kernel io_uring resources. For example, there are
>>>    registered buffers that can't be directly accessed by the userspace,
>>>    however we can give BPF the ability to peek at them. It can be used
>>>    to take a look at in-buffer app level headers to decide what to do
>>>    with data next and issuing IO using it.
>>>
>>> - Smarter request ordering and linking. Request links are pretty
>>>    limited and inflexible as they can't pass information from one
>>>    request to another. With BPF we can peek at CQEs and memory and
>>>    compile a subsequent request.
>>>
>>> - Feature semi-deprecation. It can be used to simplify handling
>>>    of deprecated features by moving it into the callback out core
>>>    io_uring. For example, it should be trivial to simulate
>>>    IOSQE_IO_DRAIN. Another target could be request linking logic.
>>>
>>> - It can serve as a base for custom algorithms and fine tuning.
>>>    Often, it'd be impractical to introduce a generic feature because
>>>    it's either niche or requires a lot of configuration. For example,
>>>    there is support min-wait, however BPF can help to further fine tune
>>>    it by doing it in multiple steps with different number of CQEs /
>>>    timeouts. Another feature people were asking about is allowing
>>>    to over queue SQEs but make the kernel to maintain a given QD.
>>>
>>> - Smarter polling. Napi polling is performed only once per syscall
>>>    and then it switches to waiting. We can do smarter and intermix
>>>    polling with waiting using the hook.
>>
>> Any comments for the patch set?
> 
> I'm not opposed to this feature, but I agree with Ming that it seems
> largely orthogonal to his patchset allowing BPF programs to access
> io_uring registered buffers[1]. This patchset doesn't provide any
> kfuncs for interacting with registered buffers, so we would still need
> something like the kfuncs implemented by Ming's patchset to allow BPF
> programs to access registered buffers directly. Although either the
> ->loop_step() or ->prep()/->issue() interface could allow userspace to
> run a BPF program in the context of the io_uring, I wouldn't be keen
> on reimplementing the entire io_uring_enter() loop logic just to
> intercept a few requests to run BPF programs. The ->prep()/->issue()
> abstraction seems more straightforward to me, though I understand that
> it's not as general as the ability to modify the behavior of the
> entire io_uring_enter() syscall.

Caleb/Ming, any objections to merging this patchset? I think we all
agree it doesn't cover everything that we would want, so far we have two
different patchsets out there, but they also aren't mutually exclusive.
In the hopes of getting the ball rolling on the buffer side too, I'd
like to move forward and merge this and then we can rebase Ming's stuff
on top where it makes sense?

-- 
Jens Axboe
