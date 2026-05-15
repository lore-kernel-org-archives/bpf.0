Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AD43FF1D9
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860050; cv=none; b=VMeahAVH1PwxFqEa7dmz8S1FiNISYao5KbaUuc9HxSxicRV0TbJ/5hjEpom/aB0ytRM4nga3UJebdI+FuWleb6v1oX4C6RrfZHqq5C2PzY9aHfHXku6p1I4pBT4281LfnlL5zDjnrcmmMN4q8yq8uwI1jQ029J3lUTXQFV4GTdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860050; c=relaxed/simple;
	bh=CVdUnOiNPpPmGc3LezT8e+nwF1TZwRu4S/w0u6LkBm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hBvfWderIVn7mU2Qw7/TIm+euKP89NQryNlU2PCyQaai8NMx67YaPlEf+2PdAEJloan114qxp/2F+J2S3a3+PnqDg8l7TvV1xplHEuRl2iTJHdIuGgTMwH5IifE7Zbqbxojb7geVJxrFR6wI/lS4L60VF6FlWLaJfSWo+/BBnJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=KDhloYDv; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="KDhloYDv"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-47cacb4ed99so6419793b6e.1
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 08:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778860048; x=1779464848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F1yk8fFWUiOttWO09N8CWC0NIU+i5kI1E9W6FnulKH0=;
        b=KDhloYDvIKp9ePnUjpQKVS3La596lCDCRYljsmZXs//VgO6sz44+4vftOGLBQv/G8e
         QOPr6cTe5o1nTll1S3S04288kjlZEVzndevnsbeRxnHHZupCWVxgzjJkyfjzWNLlc3SX
         44BbIDGYj4Jhl/DsD6m1w4P5gG12BfXVdBxBnzG5UsRL7PisHiLO2oXcL1PS/Q8Wo9eS
         5deSltZUsswrStxKZ3gID3/8fpxGnEKRqwSJLIxOuwjJjSDlGh+dhZ3nH47PeMZKKaNU
         Cs2LpQuKhh10t+6Sp6wnspppplYpIVxl/2JbQzpbgfzCplZf3tNThjvfmle6/dS9YKKL
         ipuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778860048; x=1779464848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F1yk8fFWUiOttWO09N8CWC0NIU+i5kI1E9W6FnulKH0=;
        b=OqGZmn1TPhBdCXODkQhBE8JhZKjxaj+XamADsxDHYVOScIFUyfrwyDH2TPpJ8VV8AU
         CeHPD5rGbpk2+2uZZ74zOXXQWQngraoox8jveyUe5I+5opwQdXb6IMYOUx1gm/Eih66i
         a7XAOjvwvjEH50J1Wdu2KT6maQkTRRlnjJExgm4XpdEVVZMkxjG9ijtS+UZ15qmkEubY
         QvOMQbtGJpQzo5PLIiyx2wJpAaxYWly1tROMC9CFkZsqN2ttqCLkb9BFkDFUP47JtELj
         a0HD/k78pDyeDEy7JZlfP1yJDSUeJAvhnTIc0Su68K12MKi2EeX/SQzqLd8Ae3bpYMf6
         IxRA==
X-Forwarded-Encrypted: i=1; AFNElJ+rn9i5EkCntUhSGPuJz0q8wQCPiHCCMUwfomfbKomxBVEkI0Kx/ph5poggzmZeBhAe6dM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7eJv/2LWqGkNjfdK8hvFAeQ/akhX86Fs6QvlYms+XXdeaa7mc
	XmxwRGKmvQ3hUgx0HTXSwyX7aTzZU08eC2eRuJ3IsU54Jtv4rzFZ0lIpdyWj0opA+rxKCkOv+SF
	haNIL
X-Gm-Gg: Acq92OETWUuIHkW4SodKvPYXhp+hPaE42nPjBcQS5D+1yHwuED/N9g8WflS7d7NhViZ
	nUEewoCHWHHbxvpLq6uLKGwYlYopfnFBmpX/ujBq4l3/StKFETZl7jGtjY1ORXe2p2gquL8QLpY
	ya/tLkAmndA0nLx7ORiV/BE8sX/AHy8iElapDMZarjmIw5lh5V/Xym3cpBJbU4a59Uwj2DanRMI
	DRvNclMOeS7XHZVlJpvroJrPEFevMMnx2PD0ALB8Fj0OyPYWa3s+2FhgjARYGzIo5cFL7mWE6WV
	fK9xkMNCrDE5GmjdoblEF7VGIOXtHEtS9JvuDtFU4BrlWXmhqUlKWbJ07WNM+L4oJGYx9H7L/mR
	fsqquFf4BuhP2RoBpqjFxpUvtu+bZhORjD1juL93dJLFdnditPwZuFv3X6FQrn+hFXb/4sXOn7r
	PrrjWebZYQSfTKWvxxA7KT52eJ/TNprtIC/HJ3JxxwIrxORwQ78YqAtSVJ4ux9JVwHsWsn1SoEy
	ThxO/QcabvkiTLfb9w=
X-Received: by 2002:a05:6808:6ec5:b0:47c:3733:2558 with SMTP id 5614622812f47-482e5717b2dmr2717102b6e.8.1778860047709;
        Fri, 15 May 2026 08:47:27 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55bc4749esm1673726a34.23.2026.05.15.08.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 08:47:27 -0700 (PDT)
Message-ID: <cac7db8a-a547-42d0-8589-c8a282cb6860@kernel.dk>
Date: Fri, 15 May 2026 09:47:26 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring: propagate array_index_nospec opcode into
 req->opcode
To: Keith Busch <kbusch@kernel.org>,
 Michael Bommarito <michael.bommarito@gmail.com>
Cc: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
 Li Zetao <lizetao1@huawei.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260515145812.1241925-1-michael.bommarito@gmail.com>
 <agc_m0rN3MN7ttAY@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <agc_m0rN3MN7ttAY@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/26 9:45 AM, Keith Busch wrote:
> On Fri, May 15, 2026 at 10:58:11AM -0400, Michael Bommarito wrote:
>> The compiled change is one instruction (a single mov of the clamped
>> byte to req->opcode); the cmp/sbb/and clamp triplet is unchanged.
>> No functional change: array_index_nospec() is a no-op for opcodes in
>> [0, IORING_OP_LAST), and out-of-range opcodes are still rejected at
>> the bounds check above this assignment.  
> 
> Since the bounds check above already catches an invalid opcode, why does
> it need to be re-initialized to the clamped value? Surely it's already
> the same value if we've taken this path, no?

It's to avoid speculation values being used. If the ->opcode store is
the last one, then it doesn't exist.

It's pretty narrow and mostly theoretical, but does make sense.

-- 
Jens Axboe

