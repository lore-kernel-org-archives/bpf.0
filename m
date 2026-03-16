Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88F31531E8
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773670280; cv=none; b=ar/c+M/ZlBymP9X+30YVIy+r4GIBkZz3Q+k/eQZbXa2gxZYXRHQcHklozJnVlKXxcjOjNd6hnx2GmHMlPpmgS8BlCwTdUe//70GrGMue+WQ8xPQ+oVESqJIHoxBteZIMj+yhYtLjKVKEM+Ye4iHYP/2YTjkbhEM49Rb9TNvuYFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773670280; c=relaxed/simple;
	bh=6MhZruKcYazF+3BPm0e8m8792pkYHz/z0j4HoShIO0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+ZBynn8xirDiXiKLi+4gWM/sEAk7NNHh02h6OaF9DTQgEkiZj686cXgHYIFTxowX05eevj20gf9cPXdK8QiU176ADzTUjU9vLK+LhLtN8NkcJR3O/dgcVJt9AOEpAMZH1T+aF3MO5wRd2nVtiFffRVQOn53CeT9/ArgodiGmKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDXXwunJ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDXXwunJ"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so37594775e9.0
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 07:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773670277; x=1774275077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CeuCiAK583AilFbkFWhX7tefuvc2DnKYSLxKweQuT/M=;
        b=PDXXwunJ5uYCMbUUThLmom2V6l9c62skkMGoAqvpdB+qk6EOBxMZS1ey9y5ycZriCg
         ewKRr7u+nTLfXR84djuSe+Frlx9y8XQSvrVbaMcVssYz5T500KbQOz2H15ekWT0A5wxd
         OB050fu5qe8hSibZW7U3xyPeOKalso4tDzfBQlVZx28Hj//flQgguMKQZLDrlzeLKNSu
         uyTNoi7xZZ2Gb7pX1gYYNqwiWzshUskOhW3uwXaLPAQqEIgJWPSG8tH7V5jj84lPtvre
         HD26ajZdFGlY2X5LRe59A4lvU45iYOtQX8dkQqVzB/Z+eQWicym89q46UPnxBM6FhH62
         0/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773670277; x=1774275077;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CeuCiAK583AilFbkFWhX7tefuvc2DnKYSLxKweQuT/M=;
        b=sRd7fFxisaVYCK7UFk2RDysy0g8hkApOPdOG06v6GJKnSeIXn7t2he8R4qvFlYlu4o
         0IF0gDUcQrojUuZF6XTEdRMhy6ABr91hkUhJF0nWdfPd/DDyh51bbEmV9ZageH8xSj6u
         2s21AtSCFQ2bDg9A+qVhFfHdRvJXtx0nSoOw2xVcStD5U8FFwTaKwp/y1VUvQkjvfEPY
         7qz2QAVjR+SLUYbJhDGVRirz4lsY1zqX1Q6VOGkW8H10sYrBzdAUWWTtWRY57NEjoYOP
         If+Ydcdbf5/sThZ+bglGdCBwPvRkPKL6t+ErjxTpKmexveFWa7oEoy+wxtfs0w+uPfXF
         fu5w==
X-Forwarded-Encrypted: i=1; AJvYcCXSJ72te9F7GH+h+sPW+GbqIZ2MxqzPL086pO/x2bE+0xYQG1df8woiuCMbVnLvZzJQ3xA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVQpwcNc21C2h4Hs2s5xZBF07w+jJJkooSBCvptqcI65eEGqvR
	GgXUN6C7RdQRDw/Oe8UgqV/cIJa0AxRX7acak2mUAuvIifOC7DP1HaSGUNEU9Q==
X-Gm-Gg: ATEYQzwf0dTcQjEslRciRU2fwrObOdYCqSP30McFsw2QOD4b9AOEcRL87n40hfQ7yez
	SxAyNkMrU/55H2cmIUizhVbSEeUmTCU8+nQJIkt40yXzmPOxP9OK02VouAjAReyXoVVtYYdNcfN
	wsDdVQZpVtbLSdUWRlnHWTNy5IYdlxMKjoKJnRxTIzDLGWdaNcSvrhGrJD/1aQAQGwr4EN90/CN
	2ejVpTf6Y8zCJjYWaMPAxclNyYD/ELuKxzEuEeVBL9lrQPSnnNRfAFZ85YEy9Po7mvdtZUOtB2o
	9tzv3ynHbXEUiQpSoDtedoZQc5U2RYWEh3y7G/7E0nNSnLgL+vvV3JbyuO/m51NHkxdDZPgJFNj
	uA78FgrMvxAR8TWdDc6cqNLzrcK1+K5AF3xgs6bBZmLaSkPnxfLuxZxJODBNWPkN32VTVEdtnBz
	Ll19zRac6sotj6rb30Xcw7j0xC3nrOOc1xx8ITvygAIT5EJzLK5REB0bvUffnxB6m/73QoiF70M
	eMG3qCzsIp4a6lcGJZYByCbj3nq3yOivN3sC5ykZnQGZB7JY2VOKoTXkaj/vcebaE6N
X-Received: by 2002:a05:600c:4752:b0:485:3dfc:569 with SMTP id 5b1f17b1804b1-48556700c54mr222906325e9.16.1773670276971;
        Mon, 16 Mar 2026 07:11:16 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:a0ed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854e67ea40sm368784765e9.7.2026.03.16.07.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 07:11:16 -0700 (PDT)
Message-ID: <6d2a9643-962a-4328-b8e1-3bd264d73d19@gmail.com>
Date: Mon, 16 Mar 2026 14:11:10 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/4] BPF controlled io_uring
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, bpf@vger.kernel.org, axboe@kernel.dk,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <cover.1772109579.git.asml.silence@gmail.com>
 <d8c8748a-4b13-4097-bdeb-495e6410a0df@gmail.com>
 <CADUfDZoBTwnCo-f_st9-jdgNhHLWUCjZQFpGdowGUA5BoJ836w@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CADUfDZoBTwnCo-f_st9-jdgNhHLWUCjZQFpGdowGUA5BoJ836w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/9/26 15:02, Caleb Sander Mateos wrote:
> On Mon, Mar 9, 2026 at 6:24 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
...
>>> - Smarter polling. Napi polling is performed only once per syscall
>>>     and then it switches to waiting. We can do smarter and intermix
>>>     polling with waiting using the hook.
>>
>> Any comments for the patch set?
> 
> I'm not opposed to this feature, but I agree with Ming that it seems
> largely orthogonal to his patchset allowing BPF programs to access
> io_uring registered buffers[1]. This patchset doesn't provide any

The idea of giving BPF access to registered buffers is largely
orthogonal to underlying ops implementation, I agree.

> kfuncs for interacting with registered buffers, so we would still need
> something like the kfuncs implemented by Ming's patchset to allow BPF
> programs to access registered buffers directly. Although either the

Surely

> ->loop_step() or ->prep()/->issue() interface could allow userspace to
> run a BPF program in the context of the io_uring, I wouldn't be keen
> on reimplementing the entire io_uring_enter() loop logic just to
> intercept a few requests to run BPF programs. 

I don't think some 50 or maybe fewer lines of generic code is that
much of a hassle, I'm thinking about adding it as a library code of
some sort. In either case, I'm not trying to convince you to do more
work.

-- 
Pavel Begunkov

