Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701C62F616E
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 01:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769822838; cv=none; b=Et0AegWrLMd6Fq7kLARTaexXGE/4qk/At7VP8e2+3MmOMg0WZFk/IqPwi8Oy99ZSnL1i2QluoJlqRfhm7hkYUaUixKg+37EcBiAW1y3tRoOrr/43dmkdZXDgn1+Oa0AWYzh4vl3lGMl/6mp9k4SL8Q4JEClDROpOGhLvoq719cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769822838; c=relaxed/simple;
	bh=LqjG26iPcgUJUjdKHHQUCfcuvzKdnJ4bXKdhZ7B7/mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KY5zgzatXcn/BCD2cMIaq4PdWWgsLIO+i3QAyDi9dTC8dWEJcnOQ0O5oDcyS3vq2lV7EfDz+5+QF9aJiVo+8sMgmSloD9ENMANVjWlt9X3LMdxkVmsJZKl7srZi5pzAH/3wNOwayaI2t5zxb9c5jQI8tQ64oXNq0Om/J3eL9sq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=R9e5Bpa8; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="R9e5Bpa8"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-658b9e95990so5142233a12.1
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 17:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1769822835; x=1770427635; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X+Zsir5E/r34txHH39Th9Cb+s5GtaeVJrYm06jsRDB0=;
        b=R9e5Bpa86dk+Ei0n4y0EXrpvoERRHuz6VPEvOKQyh70V2AYlZ4zD0is586U8PMto09
         eNO4XCxCsEh2JM1ujrFVKKOnjT7aVry/Xn3rGpOqCBE/saTtf2jnZmuKnxHNsur+IRRw
         JXktgOwXxWS/7odSJMJm0gIdyM4WS6vO8vv8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769822835; x=1770427635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+Zsir5E/r34txHH39Th9Cb+s5GtaeVJrYm06jsRDB0=;
        b=Uorj9Xw0IBfSlvCH8oFKoLgDglAMHpkg0OeM8HMVg8JF0M12hzXf/vf4fRZAop56uz
         auCZLBMB6fBRAVc00OJiZJcXKtHBhuLihaNGPqKbG5cJRLmFv5fmpjVQdK+qqtnqF5zq
         hnawLFNYa9PWYzRbIzCUCDf8mjtLUCtpcJtaI6aOYmibZWNSG9Z5aOH2/ugLIOnlMZZv
         bOZtk/1v/W409eE83SItw3NUadEbnLV/L7kTtZaBRR840nEeNWmaCiY5dIO8ooKJ+uCz
         naRK1tr1LXOCG62UvFtve9QkO+LMNzgA5YF21fVYjoXH3CEt9cyptFSFkrrAed2RlZKs
         KAdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnL1pQ4DUoq9WSoRlmgBomIKHTV327rs04SN6mcyxMACszVvGifB37nmf+i9hW9VW4Jpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5rClYkAK0GA7nPo5qo111oE7/uDa/mOeH7xDMH+CCx9yO4kbP
	Kd2U4L+zPaEwXE6vYLBPWpmj3nVrj3rcdCFaHLZSoL6HjE5j+2YieGw3kWtMe5Uu2RD/1hQvjD1
	EhReasFJRzQ==
X-Gm-Gg: AZuq6aJOKr2gpRa1aaRD0cWWtpMEydMlzh7LpUfRf/NFTujsBOphbi1upWcYcyqeduQ
	MFJSVXh3eL2lw6hjCOgglK8XjLa5zclvBHHR+NeN5QzctQpvYVeZVKdTsX2oJWAxczvxOECHAgw
	8Afz1MvGknaUAGijK59Sk6xsDTFshkwWSrlRwsZhVlR5NnRYUdCZGzU9ap/th6MsX9/1SQq1Hmq
	9ntZJ6rGiox6I0ZFokabwch8+kjvjbmGFBvCi5498rf5MdLCWD2uILApsKhQVeF8T0fRFv2lOx2
	CtQgS4FkUipo5QTH/5IAHuHOJMQD3izvJSOeXCt64YXZnpRSfGoFqfXwvTJiN8yBpYQBbNxrZXv
	2FVlXGw28+JOVzqmrcwMvKbz/JyhZo8NralhnMBbBID7VxM6oLynZ+bhX87S9FeTiPabd90e39j
	n7SUZWsIZgE7cTWY8efA6p26jz8qF/Eu0a6gJY2OscTOZ0AY8lcoJdS/LqdWXrn+rdgI87QIY=
X-Received: by 2002:a17:906:c116:b0:b79:f984:1557 with SMTP id a640c23a62f3a-b8dff78c673mr277889266b.46.1769822834665;
        Fri, 30 Jan 2026 17:27:14 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbef86df9sm517156566b.10.2026.01.30.17.27.14
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 17:27:14 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8869cd7bb1so452866466b.1
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 17:27:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVqoAfo/r6QRdos339IjXyVw9DYQroDcwXnVN2IcRD1BQck2LYJPWTcBJlDzik8+z61GkU=@vger.kernel.org
X-Received: by 2002:a17:906:6a1f:b0:b87:701d:341a with SMTP id
 a640c23a62f3a-b8dff607a33mr279550266b.25.1769822411525; Fri, 30 Jan 2026
 17:20:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130-getsockopt-v1-0-9154fcff6f95@debian.org> <20260130205227.6fb1d9ad@pumpkin>
In-Reply-To: <20260130205227.6fb1d9ad@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 30 Jan 2026 17:19:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiiPxGrVxFzzf1nbx7_0abjZkhmd9oPximUxUyDM7gwug@mail.gmail.com>
X-Gm-Features: AZwV_QicYb2Y4IsMdcHkp6aaLn_xxvWlOuA7e1nJwap4TdBtycKshhvQFgQOM3M
Message-ID: <CAHk-=wiiPxGrVxFzzf1nbx7_0abjZkhmd9oPximUxUyDM7gwug@mail.gmail.com>
Subject: Re: [PATCH net-next RFC 0/3] net: move .getsockopt away from __user buffers
To: David Laight <david.laight.linux@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, metze@samba.org, axboe@kernel.dk, 
	Stanislav Fomichev <sdf@fomichev.me>, io-uring@vger.kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 Jan 2026 at 14:40, David Laight <david.laight.linux@gmail.com> wrote:
>
> There is not much point making the 'optval' parameter more than
> a structure of a user and kernel address - one of which will be NULL.

That's exactly what we do *NOT* want. Because people will get it
wrong, and then we're back to the bad old days where trivial bugs
result in security issues.

Can you point to an actual case where setsockopt / getsockopt would be
performance-critical? Typically you do it once or twice.

              Linus
