Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555C533EC
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773831636; cv=none; b=UEZg61+elPhFmQdPt7S3xaLRIzCeawIvD5Bok49eN0TQXxqjllPev9WAsefM5KGsKV5EZVPFFGP7pwjGVOC4fi1SYuLnAm/kRwaj33OWP1VLJ88+R1+vNA6BR6/vl5oSrK/5RNa+xyi7ZWuA2Z/uC8qKTHlzTNw4PeuWXdlSelA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773831636; c=relaxed/simple;
	bh=NAzQvZljCxN8j9k4fUxGKFciilFjDg69mpMO3HdUlWI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ODxc48vboEATPUbgN9hTLewy5+Rj6RtpCJVYtdOQ3BzFWqNagM9slVZ3at6/J8zzmJsLtI/cpvgoT9ihwODGUGIuBcUxCC0hDoQwd+OVvRoqmoAEDxCOyWlRfJgSOxcKuOqt3Yrw43RVDQzKIZ119XbQvLnr9HQ01tSAjdG65Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiyPGfjM; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiyPGfjM"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-667df358d78so588332a12.2
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 04:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773831629; x=1774436429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ABvSCbQVr4b83qEOAzrT2E+z9+rprhgoQ15uDUwWsmY=;
        b=KiyPGfjM2mceQF3qPCQmaf1/kd1H9DPABTcXwPDrLkcY6TAbeg+/7gITetN9qYWuSG
         EzpAxMJedbm6ZfnwK2iyfBC0gT7O+FoQgdEBaW/5KYqZsjD7UO7j4k1RNCruZt6wYOxb
         wo3/IJQEhQ//lIhEabeVI0dwqdjjVLlS20pE0e6D5EefHZoKEMVxOQtIz8IdRsCVi11w
         6lyn+VDDVul7Kk+tiNru2/lbz7alQqUfyJJ8VD1Edh2KvB6tfFBQ57BcLbyvheDvMQnt
         2cQLQ8b+f/4xs806Wztwq2XGtfuoCNH1PKDy1mry9bhEerohNJqTNTroAFQMkyxhLWxp
         FJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773831629; x=1774436429;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ABvSCbQVr4b83qEOAzrT2E+z9+rprhgoQ15uDUwWsmY=;
        b=r29kCNhyXHREckzaVRSqKlzAdQ4r2IxIyPf74u5+ej4rJqHAouNHHYW2RKyFnzbVlR
         Wyy7eoDJjQVx+Xxkq3K9q3xwGtwkG2LBqBs0G9rg1Ix3Qefvjv1Ci5AfJBBzxe8VSyP5
         5ONmCBqBzijgGDX0sa9R7cDSjOaQ46REc1kT1IDVh5bzskVzkpRHP2kdWC54k5glpVeA
         IMNhHd9yiOR7LIAnKivsXUWnZAsBHTTYkppIyJgdwkl7wmoHmDNiE9m7WgWU1uckdlYJ
         XW4eJWrNHSTEEo6CLWyP119Y0/SUeuwpkcBzTx4YEl4LKD9uWUXoH7FF4VqT9LCbIbvY
         +RmA==
X-Gm-Message-State: AOJu0YxreiVjyd0TsSqw+hBBPB7I3l2jawj7RQlSKO9ij+5xslueR7lG
	/c6t3HOHBz5ztpa/lbSogWuj7ypmelvi+dIFl+0m5Mml+iN/r5ADGR46HFY3Mw==
X-Gm-Gg: ATEYQzzvd3IEiilNXbEAhMEfQBgV4uEm4M11pGi4BWEWs8iLjSpSi9bzWEGWvTByCs9
	LTa/9oN6TQjrKXh5bGJB7U9/2QtSaXBXKrEqTceDb9fZJ6+swaJ0i61JEMWFLSUD4Ri1V3v7znm
	Q9EGo+Lcc9xH0x+LCWwqMTE1rrIcj0XB6MT0NcFcuvUfrGILLyKa6inHWJJPPqcRv76SoyTpSi2
	1CfHjnGYG1vKyLmYzYfX2hVKRMMkGc9IjSe68yqdZhtl5jvst64PmmozcpNf9wwDy5LxoBOWwAf
	EOPuZznXuImTKah3DSFW3WSwj35L8OwiZZOM34vTw0X0+MKCqyqxAfdbh4L1rxCX6kCn+/Fxo1/
	jnGPsVQqNjJ7HWq/gQnDBbvAcW4ruwQda6P0LHt4VNrBWCc03FXIE9XBnVmHpAU005sWNk+6eCo
	jv5uPU3IIbBzgvCGVYfK+fentiFv29Gc9/bKqPGUg0ECNZTE37+VT4G6mzM9HNY8dE+WX7CjcWH
	8V7jkyt+nd4fjdzWjfx4wD4dutAPVoD2ef72K1bawXHGwALFMpvvUi9qpE=
X-Received: by 2002:a05:6402:398a:b0:658:3972:3a3d with SMTP id 4fb4d7f45d1cf-667b2ffc300mr1369682a12.15.1773831629293;
        Wed, 18 Mar 2026 04:00:29 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:e45c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-667b129c63fsm1553510a12.20.2026.03.18.04.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 04:00:28 -0700 (PDT)
Message-ID: <f7f9f2bd-10d7-494c-888e-0de5b91e4fec@gmail.com>
Date: Wed, 18 Mar 2026 11:00:27 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH liburing v2 1/1] tests: test io_uring bpf ops
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Cc: bpf@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <818dcda223b3288c764367cb0ab8d57c83722d78.1772109275.git.asml.silence@gmail.com>
 <9f08ade1-ca61-4ba3-9d1e-744ea5e8c004@kernel.dk>
Content-Language: en-US
In-Reply-To: <9f08ade1-ca61-4ba3-9d1e-744ea5e8c004@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/26 01:53, Jens Axboe wrote:
> On 2/26/26 5:49 AM, Pavel Begunkov wrote:
>> Add some BPF struct ops io_uring tests/examples, one is issuing nops in
>> a loop, the other copies a file. It needs appropriate tools for bpf and
>> hence is gated on a BPF_TESTS make flag for now.
> 
> None of this ends up getting compiled... Can we add a configure test for
> this too, I suspect most of it should be there already in terms of
> liburing supporting the cbpf filters.

Assuming you mean it's not compiled by default, I can take a look
at getting rid of the make flag.

-- 
Pavel Begunkov

