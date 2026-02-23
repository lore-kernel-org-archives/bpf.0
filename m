Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EE9199FAB
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771857462; cv=none; b=fboe2JVLax3NhXWrlZKkdzLr6obBIuyuWLc+9V61bScMOVAJsR46dGa1wwYjoNKL9H1S2nIT129h6wbT29K80y3R7cYzAspYrijFuF074HoBkMbQZ2KhGUmxNkfnGCcjnhgMzR/iqpWtYpYlraS15PMkwyL6QLX4Z0zZ/5sv0/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771857462; c=relaxed/simple;
	bh=RTkzzyKDatZddgiKvuWDwjXsDtIiYngshI5KMTs6CMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E6nfUk31d9Y+w0JrOkdTJtwvf0K7ADD3n34XNyf8xH5V7VMCzbJRivOlX/DYB8TlAsEHLtoKV0uUZePbobYJydMrl25l47KAGaTZb7gmNMyKbxQbWia6ltN7Uo75vNeXlS41H5QG1MiD/DtW/HzxnvJU8zW0HJtWrazL3GU02O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7hGF0sR; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7hGF0sR"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2aad1bb5058so46563485ad.0
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 06:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771857461; x=1772462261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xs/cTzQu5c5itdBFJSEbXqGtwlQXJ9IuXssVyXeWfPw=;
        b=f7hGF0sRsMxSPe6VyExolSVMBmlDme6fB7oFe3uchmH6LHLSSSPXp06oU5txfMK7K4
         4CS7rEwFHo38Usb/fzkhfsLmsBSu4YJHd8aGl/UNhswZ1uO7Xba9GI9SV9jAUpAioYcG
         QAAXP42JsEg8zwrXQ6nGRTIN8hAzfzrVGFZ0TE71Cajh23mGW3/kpksqYV00Tlkf1cWn
         Hbtl0WuLkVrhjAPnekulR1eWFn+jqSbsq8IKW3S8AENuuR3TAHh6lmDQXqq9mn076SGs
         lB/sw64KfbAGs6n2B1N9fiGU/DiOiLQqY5H7heO+OkfWOh1mtDrrj73VedPYyp4+YXuD
         CepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771857461; x=1772462261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xs/cTzQu5c5itdBFJSEbXqGtwlQXJ9IuXssVyXeWfPw=;
        b=gry6vnWy69btn+ThhezVfNmOJ9X/KZC1w6hZ6NhqrUO21TgFhkHzN+xw+NttXBzE3C
         dZ3dn7iSID+p29JXksrYp2bMRwmf0Mf9XnSp+WBwHMeNfanbsRPNqJiTjGafhXUj2xEL
         kf50+RCpoXgPLR3TDK7RhnvAO3+lgRz102iCpV5maPur9AbnCnS3mx12PNMRz16FUNjs
         tdbvfbpGAgxZGmTyAV0/wl87hPt6QOljDD7CtZB+wUY/yqQZ4V8Fl9UCAdva0fLwm059
         xYL/JNSkpIwPhzKjrdV5hmim68eME98WDZQPGiV6Ovz3pHKVyqmCg1lpl754/AIHUyik
         3A7A==
X-Forwarded-Encrypted: i=1; AJvYcCVk3ktFkTPuBkABxrLYTBQjA899fH25WseOF+Bt+HivzNMHAAgx94tYvvqYgsrLUxZ/ho8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjtN8vADX29G03UUzHsHWJ4JQb49s0LH5mBejoV0HQwR7ZdhD0
	PNs8r+tx5hgofKMcVhOCp4nR8LepwCmUpwYTJoATQ7tbOWZ9SwenGefX
X-Gm-Gg: ATEYQzwKHB4ve764Mnh2ob9aOpw/O49jYgimGz6LG2yPSzXYutuxFcRi2CDfp90JdYC
	SZFhbNzjNE4i2skheWI+X/6PSlohOEcjUQ3/9adcCd8CLjbm/orx1mJTo9OOvWEGSNXy1/Kc/cT
	PvS5F0EcW45ObXw+jTvcX0oiD8X0AEXsBQezeS1vXH05JX6w9VmCL0mbowvAxoG+Y5+XM77uYvM
	c58qvEnxCt4lbuVvRkEkgZKkc4EVXtM4Hc1ObvE5tg0X0c/gy9pGBq2zZ0UjF6jGy76KVw7ZaVm
	mwdvln+yGYTRzj3UQaG71G9JOqxy7gRMI4Ms9aEHMt1Cy9IIQ3vCmL1AbqT1gvwLPvXh5WJ6Lyp
	6/0ZlswZpJmsSvyF9NY0HblR78H6pkE7vjOLIEpxK+fJEIB+t//bF4hTfSGFV02/cy8FHG+NjyK
	tsETXC/RtRbKxkr2ZFvlHDUji5+FitB9iedqGTPBU2EPmQVgnILJjZAGpYXMXJYO/O0+lYY/6ZD
	vDxCdA8ZHChiOpCDo+nl6KmH5g9EEg27XPZ0LI=
X-Received: by 2002:a17:903:32c7:b0:2aa:d320:e969 with SMTP id d9443c01a7336-2ad743fb337mr85824485ad.8.1771857461024;
        Mon, 23 Feb 2026 06:37:41 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325::38a? ([2620:10d:c092:600::1:36ea])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e34e18sm78958695ad.10.2026.02.23.06.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 06:37:40 -0800 (PST)
Message-ID: <42f297b2-7742-4d96-8a7a-4d3d8325133d@gmail.com>
Date: Mon, 23 Feb 2026 14:37:36 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/5] selftests/io_uring: add a bpf io_uring selftest
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: io-uring <io-uring@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>
References: <cover.1771327059.git.asml.silence@gmail.com>
 <7cc147a959ac068c55dae4f540e38e9e4ab121e0.1771327059.git.asml.silence@gmail.com>
 <CAADnVQK0RaOA9ZYZdYyQxOzLde9MR8HpMM0SexcW59A9u7X2Jw@mail.gmail.com>
 <84e2f3ad-28f0-4e9a-804f-2647cba9b30f@gmail.com>
 <CAADnVQLSEoZ0V1m5j3ggX0o0gzVKyiDHL=J6F0wRXB8qk-MCGA@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAADnVQLSEoZ0V1m5j3ggX0o0gzVKyiDHL=J6F0wRXB8qk-MCGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/20/26 17:45, Alexei Starovoitov wrote:
> On Fri, Feb 20, 2026 at 3:41 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> I had such examples, but selftests is not the best place for that.
>> It can use abstractions, and I want to make them reusable instead
>> of people copy-pasting from selftests.
> 
> Sure, but please still post them as extra patches so it's easier
> to see what's the end result.

As a follow up to this discussion I sent out more realistic
examples together with v9. It also has a very much toy program
working with registered buffers as you mentioned ublk wanting
to checksum them.

https://lore.kernel.org/io-uring/9c8d6af7-8546-4409-91fe-85f92a08f503@kernel.dk

> Also please reply to that thread:
> https://lore.kernel.org/bpf/CALTww28QMg=YXqKWpWLZrLO+xiqOe3LGyput8dx68-dnQsxg=g@mail.gmail.com/
> 
> It's not clear to me whether your io_uring+bpf setup will work
> for Xiao's use case.
> I don't think we need 2 ways of doing it.
> In networking bpf is hooked at xdp, tc, socket levels,
> but those are different abstractions.

-- 
Pavel Begunkov

