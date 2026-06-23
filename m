Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E97F2FB97D
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 20:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782245349; cv=none; b=n/qjwfxlwtKXDgUt3AcjSTWRe3AzIr5siYm7fNhfy9NEcHM91mophoPnZKtj8Sb62Orves9EsFPKcOibrst7UoP4pX1zM60hzTymiTzDLzKLK50LJuzI4d1Eu+ll1GQv3DPx7N6MmAADHDUreevIE0pkhwofrFVI3ORsRDPzFLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782245349; c=relaxed/simple;
	bh=7WVnW0wtsKyMSsRVu5jiZnreaAUWuQYXUj4K+nyHjFg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h9Nrd1uVUSUE6jquRYZ8nAz0Z9foCnh1AbhvhiqHGUTQeM6DWZtBVP/t8t6N/vadqAVUx4hj3D2GUHeUnVYL+HstYOx9nVjZHUcdtqGZkUZTo9xo2vhKWNbceRw8MUSCuX9/4EepXAYlFPR5iIj7iKy+u9QDNDcxT7FvxK/aNL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XZ5aNruO; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XZ5aNruO"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-697ce8cfe65so340242a12.3
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 13:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782245347; x=1782850147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSmXA5HFeluPyLRo5oZ3PmwkYRRot2n1RG1ZyVygTHI=;
        b=XZ5aNruOlHSO8OKMlLuWpCkFHeLJDJZcL16IW3lMBH6AMhHcC+SwbSC6dULZr/abQ8
         pwGBa2PXxdkrzWRFNB0+lwxJwxIXo70TiJZoM1X/Qy0y2QROz+KEtShLFIDBuinn7oV3
         7kdLiNVEkMURr6V6dnP9etcVSvYG8Zv1+rPSeGzI4ajQjeJb8PvHcNHgPmcQyj6I77vm
         Hfv44YZKC9I6ANrxy4ovkvfE3EibYwJshsIo/DNRfvK6T7O6v0t8kuNRT9NXtsbsaou7
         m9O0IIrDmeAA5qmBf5RR6R3OtVLscdxVXhEusnguhgb6eMQJchv6TRYVxwqgpPTuWzsR
         4rZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782245347; x=1782850147;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jSmXA5HFeluPyLRo5oZ3PmwkYRRot2n1RG1ZyVygTHI=;
        b=Ag7OsnwPYGVYDMVEAZevFYVAPuVVAvO4iHMrsM6Q/Ak3zdqca5qzvX5m/grm1EUQ7e
         9fVg4iFX20/EOQANrH1vjRMDcoSsU9kghG0BPx694ksmrxMPEahunbKJBPYmBIzeJgPm
         HrYzbzvvkaxog57w3vLTPE/h39T3mFQc1nMqAFMdrXawoEUOC7fI1YmekDM/rg8cQ4pc
         C+TSLZXJcz7Lj8FJy/CRmkwCf+DXBQMSklLYB/4TCQmQUvDjVEKhTf7Q6qsgRunXZVnR
         8dYFFhWYMCX6prsvyI7XSnZFcUr5ys9NCL+OROHrusQN1Wnc22y/LXNtb7/fMmsJUl/Q
         t/wQ==
X-Gm-Message-State: AOJu0YzrvIsCmtYlRL/pg9Xq58Jja6dvyNwk2d34O6VlSR4HLWqSZyi0
	V9ptI49Aj8RCxEe12vkMAyN+h9NiSNp44262h/tK2HZLfuOjE6UJ74+SROC7KI6qeG0=
X-Gm-Gg: AfdE7ckdU40BcWJTWMLihHlyK8UiflahplSLssUJfQNbQkDf1JopmJho5+6JwUD5XCE
	me3ieKSLn4HPBB66X6jGVTGYiQ9ZceLUmAO0QgWTaTjLLVB6U8MhRiB0yLoRUb4AKpGvhk8YtKo
	PpUEKVmXiUdxuRZD0xKoJGWHq0OG8E9b57Rvr9BFLhUG0O1A6bCtXhziYkxgrxpQt3GYgap2Bps
	Dya3qj5/ZD7KgogxNSc2LKinmhWKdtI2Kj+Ryo2PM5VSkP3RoGvXbk93hr99Wa/X2SQmY9wkCWB
	Qnw/0vVJQD7oEkAb0Qpwf3XkvklPaRgkGVyWGSK3KraP89/gr8uFOSJtkk1W/mclrF27yAorup5
	fqOpy8cDWXZYz4llWlzlI3BrWGY1KT+yI45PX1U/zZa6+rKygZPwf5Zs0SvhzpH8TXBlf9iEFKv
	1nyYLm0S1THqcLeCU=
X-Received: by 2002:a05:6402:254f:b0:697:ea41:97af with SMTP id 4fb4d7f45d1cf-697f3adb2a4mr26160a12.28.1782245346658;
        Tue, 23 Jun 2026 13:09:06 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f3aec1a3sm8778a12.11.2026.06.23.13.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 13:09:06 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Jakub Kicinski <kuba@kernel.org>,
  Jiayuan Chen <jiayuan.chen@linux.dev>,  John Fastabend
 <john.fastabend@gmail.com>,  netdev@vger.kernel.org,
  kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code
 behind CONFIG_NET_SOCK_MSG
In-Reply-To: <CAAVpQUBARp1qCEomgzWXVe35WatdaswujVLku+RESm_LW0dE7Q@mail.gmail.com>
	(Kuniyuki Iwashima's message of "Tue, 23 Jun 2026 12:31:41 -0700")
References: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com>
	<CAAVpQUBsQFFxJFDnJzxmsER3bOjm=zqJ5P5MSeW_T9v-4639cw@mail.gmail.com>
	<87v7b9ysep.fsf@cloudflare.com>
	<CAAVpQUBARp1qCEomgzWXVe35WatdaswujVLku+RESm_LW0dE7Q@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Tue, 23 Jun 2026 22:09:05 +0200
Message-ID: <87h5mtyq72.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 12:31 PM -07, Kuniyuki Iwashima wrote:
> On Tue, Jun 23, 2026 at 12:21=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare=
.com> wrote:
>> Okay, will put the whole file behind hidden config option like so:
>>
>> --- a/net/unix/Kconfig
>> +++ b/net/unix/Kconfig
>> @@ -30,3 +30,8 @@ config UNIX_DIAG
>>         help
>>           Support for UNIX socket monitoring interface used by the ss to=
ol.
>>           If unsure, say Y.
>> +
>> +config UNIX_BPF
>
> Maybe UNIX_BPF_SOCKMAP or something.
> bpf_iter is supported without this config.

Not sure what you have in mind re bpf_iter. Can you share more?

