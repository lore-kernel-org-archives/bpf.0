Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9E33911AA
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 22:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785708008; cv=none; b=XDuCqyzFsyv3Y28bZWgMk2Bn/r54emFYOMeaEnKnrv06D4X6NwpV1YB+Ahj1INjsRWsLXm5wXNg1kJJvATXejGBatciykrr9Iio0r1JEMeQJwwQHo76vfcgm7nCI6u9OwxX4ObCBa3RDbxhYjlegGu0/1W8/NhbgI1yrfmJaEnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785708008; c=relaxed/simple;
	bh=/EX8GxkNRxJRId62xWdmu0HESNRg36GVP5S3AX/7dGc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=PUK6WTLg8+WgthGVvEU7VKbkCWFec65rkoXcQnV6p4Vh+exahLrs9Owxl15f11VM9PLTVOGJ5irLYNvq+3obWNLfRo6lpYeONF9swljzadQfZTtO78JM8SiydHN6bjSdBB9hYM43GTUl1SyPcMwuCU49Hx1HKhQbXkkiT/r65dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBZLav3C; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBZLav3C"
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-49242309566so2820655e9.0
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 15:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785708005; x=1786312805; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/EX8GxkNRxJRId62xWdmu0HESNRg36GVP5S3AX/7dGc=;
        b=HBZLav3C39ZiytCBzAwxclDuqbS/pqR+yH7IygjCp9x17VAoZJrsk8zFObMa9gJKa7
         j7CgfJJOfmkHMiwePdWY3kk60OAZYRQ9ctYZcZpc7PaqCF9E0XeHFfLJIdlkikWMqhX8
         uTnVBNik+iqm+WJpJZGKLUKTueF5Pr9IBvNkbmgLvzbhOJsbpMO8Q6LGWlUwIv6a+85k
         Oca9qmjrQ0D8/98ZJiWH+B5hwFcGcrceWOHIlV8f2GOmDBDZW61bVQyrCggzuBfpn2+R
         bN9RwBbL8ZQLqGED5nGWNYdozCyRIMDP8/+ZiAp9+mqYUM8CuaOf/vlzn1cRyOeC9q+F
         JPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785708005; x=1786312805;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/EX8GxkNRxJRId62xWdmu0HESNRg36GVP5S3AX/7dGc=;
        b=ilbcvf45V6AouU99wPqTmdeTwak76UjjtlXuOAA5YNEnnyK2yWl/PP1tZT8eRpX4Td
         h9jSJNGXP/f/0mf/nmoUxzRLFCF7sB7ZnKR+Z8eIPEO5PnhbkfLJ1xd8aslnpfu5rchR
         7ILnp136ll+Ysp+U6Zmu5CUaG+BBV9tRBDhrMOJC2puFkIMc2MZNxvBnKi2ypjlrUg9S
         3FXyDvX0Jra6jbk1YtAlrqHXzkDdajst3z1XrSJIbsib4KFCurrmneAvCzT2AzY4+XRc
         shtvXtQew/dRc3Yy4A9RlzVXoeZVtMIpf3/8cjX1mufCRE72MpdcNIQFQk5qx5t08Bme
         qMjg==
X-Forwarded-Encrypted: i=1; AHgh+RoqsLv2r56TCPymNgOj1KT+AGzFL/1DEB/oYxbDLdQMUFNpPgjFidOmk2hToXhVch+vBYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLtSB8fcZ7VFzoNFqArIqwQj9GsKADEk4Q0aitX9kBBR4xpQHH
	1xuBosIQ/3h/eh62PCqVAbOOoxMxzgaJThEY6wXz6MtHSCIcy7Zu8FDd
X-Gm-Gg: AR+sD10J26Jakt2viN5gkjgFLjZ6yA7zW8BMQAUeu7kCdEXgLWkN0FAMAB5H9WAMSU3
	XDY7okNsNcunqyX8pio3m3qfP/dEuBd9uWT8fUb/TIYpCuudikCjb5Q3GbO4YkDhYwtloumgHHa
	isDdczbx1oqGmyWh8wTU8qMvoD7kISdaOH5ADbzQ4c+2syrGodky07c+5Qa9tvJ2ll7LxQXoXky
	KKKWgRa39IOOPNBV8tB8bqNOoKN2B4YA+HEazsw1uqGRjjDjVjXTB89OB6MwPwks4SucQivii/e
	49qcI/Mc7yBBanLrrKAX10ZyTpM9s0tKeni+6QcxrjsPplRZQNgxYdv3PFKPZoIpfh4tqCIsTl/
	Gx6alqjdifcqFkv1DIDWUyBHIT3LvmDtTfFzrc6j0X3HIy18jaZATq8p0PcLWlqk8+Q76P3Hesn
	tRjHGT98IRUqwfLstEW7ngT1KQA+1luh6eZKC14m/W2TIXVp/KTPlxZd/1NrhPqi4BkdFhH6X/G
	5bMsI1qj39ggUdAL+/9ltid+Z2Oo1ov6iz/9irqKx6RP0pJ6o2nGhbuoYRCekC6TjqhB9V/CTR6
	1dvTrDp9IvK3IIlgrfGvj0B5X5k=
X-Received: by 2002:a05:600c:3b23:b0:493:cc25:9c0e with SMTP id 5b1f17b1804b1-4980c679e43mr183329435e9.14.1785708005286;
        Sun, 02 Aug 2026 15:00:05 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b9441csm163255775e9.4.2026.08.02.15.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 15:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 00:00:04 +0200
Message-Id: <DKESNO9TRIMU.3RWVUW9A1WE96@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 2/3] selftests/bpf: Adjust veristat stack
 depth parsing
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260801230400.850271-1-memxor@gmail.com>
 <20260801230400.850271-3-memxor@gmail.com>
 <95d8960950ee42a77c2f62301cf4ffd31763fbe3.camel@gmail.com>
In-Reply-To: <95d8960950ee42a77c2f62301cf4ffd31763fbe3.camel@gmail.com>

On Sun Aug 2, 2026 at 11:11 PM CEST, Eduard Zingerman wrote:
> On Sun, 2026-08-02 at 01:03 +0200, Kumar Kartikeya Dwivedi wrote:
>> The verifier changed the output format for stack depth verification
>> statistics. Adjust the parsing code.
>>
>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> ---
>
> Do we care about backwards compatibility in veristat?
> E.g. I see it packaged in my debian system.
> This won't be able to parse the output of an old kernel.
> On the other hand, I personally do not use stack metrics,
> so the change does not really affect me.
>

It is an open question, given it is packaged, my instinct now is to parse b=
oth
formats, to cause the last amount of disruption. So that's what I'll do unl=
ess
someone tells me otherwise.

> ...

