Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793294156;
	b=5SwWTuwrhoZgIkZsOxlsMdiiDuGamU/RPKiuw4DdaFPUv8jazsJuFW936GZJzBNRsm2Q
	 chaR9MvZHYRgxbfaST/QDcSePhlRaevvxX3ElZ++sklu7YqZ4wrhLrOA7TtmgWHD//6Oz
	 YEwBfSE4WuvF4VfdD7PGlbcS7M21xG2XGxIU7DxXr0WmqiteUUbev/+BHSPC9E7YnXZuZ
	 ozTm/Txl2EMbkmHJY41CbEYon0BRpIQKPFbmle06X6BOPLycLUArAwTG1sDWpi3ziZPl0
	 qYDZyDA6VtOiQb/YHGbpBv+S9dmwqUYNC2JcVwDQG7MViJtCy5QkKewHqShcRe3vNcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793294156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=4AC+76/KQ+QerS0vbEfd85krwo5e3I+GiqoZ0yXri7Q=;
	b=F18DIzQAsgLlHHEvc8SuL/BcvgUVRkhkvqR8enn0Dbr88VGFVoFKcLO8bxKVQUqCMT7f
	 QTTzt5lk8SnOep2TmQTAmkc0KfTVSHbgOzXwlGKU8t8+sMBcU18OfyY3ZjOsqorrDRups
	 Tay8uRhUfUzGkx4+b6h92JX+AS9mFjiE6F5EgHwELS3GciYZlxJYSGQAJIUTlf+JDRM6j
	 6wYqnqJ0KVT1vpGmjfOHwAliZKe/AHQFEnFqy56gKXusdyHQJxiTQ8mpJ/PN9wdzvWlAY
	 3UcQ6uDtfviYUt1kGCAZACzpE5+sr8PaCJ20owEF2AB+LW35LVQyDFwqtN+jL4h2hFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=dT11O6tJ;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9E8606A31C
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 17:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF9E8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=dT11O6tJ
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ae1d0caaedso1215571a91.2
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 10:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793294155; x=1793898955; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4AC+76/KQ+QerS0vbEfd85krwo5e3I+GiqoZ0yXri7Q=;
        b=dT11O6tJyExylRrs1nXl3/kAWbLocR/Q3wbKp6eWfFGOl5xbvupjbb7NLG1DxBS4kR
         7CZlnnngeHVGtjQ+MGsUgPRdXjy4FoMlT92COUAEAu0lBmC13ZRVYTaNNHG8pHSklvMv
         oGPPeTCk1PYZuV7eUY1ZVoqclYUFxAJ2al2s8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793294155; x=1793898955;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4AC+76/KQ+QerS0vbEfd85krwo5e3I+GiqoZ0yXri7Q=;
        b=Phtbfhs1/wP6IkcjuaULRz6U/chQT3+pgFKUZQdiGn89o6HHIS7hHpW01Twn4CeMLQ
         fj7+LtYq7LTQnlGqPDt4knlFBHb1Abn5j8C+MxN1MUhSfHnY9TTZkJE7CNXtDdWRwy5f
         cLphKVxak6DuyBLw14ToYfw7HMa0aDLtMAp/gcXOGy7KbqZJRgVwjDdN3zMdwi47WI6G
         rvFnvU8LnZzw5+bHyM/ndq3Yy6okcjs36NKXL6whLYrPsosXfZjTvu2Z4WF9PA8c9+TK
         TEOvs210Sj4CSd8S63czMM2lFUjxfa04L6l5Jb3XpSLL23XpOKQI2sb9hIfxM7wLVDuK
         fmYA==
X-Forwarded-Encrypted: i=1; AKwUvBzqObRupqr+4qUHl/fhPTP4HIh/1aG1ntbHHsmyE2kJ2Q+l+QltNV81DFJNvbMjigV0/jI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIuP4JtzJ+NQRUB54WQ/yoAyyncFTA2FVHNhkMN4xb3E/M3fDRs
	OAsUsBt58dIUsVaUZF8rA8S73yLxEagmKT+KF9qUDOcjfgckHKjqRuIV/RNSxkUnFXQ=
X-Gm-Gg: AYBFou1XKOQcwcbj9yKJyPBIxX5N192RJY0KSZnoyGgXvxDgbqm/gqdMmCht+z0W2Jt
	5ftK1nxJsbA9exsm2OMfQsbA8kYPzX9tbfKkSl2yp2k3fZLJIFNnQQoQj+OT8WOKGHGIYhrOaA+
	yqvihM+crKdkDSQmpU0r3zseIUW1WJV50tbIezDUl2iQpo57tBIQxSTPCasgF/+icstKbCSnDvu
	YuAmi9fx9+NPm6hOsEktZLQ0r3l0fzaM3T6dcvfnpWe4QrUbt987ANNDEdQeiHQFgetQ4A5dJ8i
	LR+WfCI824ZIrAtnwmCFtjxgUNQs/vK8EHhtCp8ZVSXW+ZQBkjUsmZHyWIEGqEoY2FNV0MBJGFk
	dFPFdROSbPhHhCV5asHcWg4hzQEzpvDCUbAx4+9ZEg0AE5LqPLmayZaqxXuoZUxnhqYpTNYHz0E
	x6HEUxEIS4AsuvK1Gd2NvxLrXolAmP2jo+2w4xpV3RU5Se3WVFraPo5JRxiPf8YIqW/Hbtq+qr7
	JrvDrjCSI+Z0z5DXvtA1fCpNdJRcAn1YKpAh0qi/ZF6Bz3+IiYwjZu38WwUOYKQbrK+trLJUThx
	LCm8zvCKoW1b0SJ8Nc1N2JwxsYun3bxsyKonPwVYBrcWsvIQgiRPzTuJcf4CDQqkw740ojRsrBd
	rz6U+AqXZEFfZ8IDKxBgZ/6af20aH4LOyZME4XKPkaaxL2IMhRXYMbgivkaHCcQrEq6VdmWP7
X-Received: by 2002:a17:90b:3c43:b0:3ab:c80:936f with SMTP id 98e67ed59e1d1-3ae57f95afcmr4290753a91.16.1793294155121;
        Thu, 29 Oct 2026 10:15:55 -0700 (PDT)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85e567ecsm64167a91.3.2026.10.29.10.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 10:15:54 -0700 (PDT)
Date: Fri, 30 Oct 2026 01:15:51 +0800
From: Chris Down <chris@chrisdown.name>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>, Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf 0/2] bpf: Gate dynptr probe-read kfuncs like helpers
Message-ID: <auN_R9gCBqNwEkKV@chrisdown.name>
References: <20260615-f01-07-dynptr-probe-read-cap-v1-0-e626cd61a381@mails.tsinghua.edu.cn>
 <DJ9QOWVIXFHR.1S8UL5H0USVCB@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJ9QOWVIXFHR.1S8UL5H0USVCB@gmail.com>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

Hey Alexei,

Alexei Starovoitov writes:
> It's fine as-is. Won't fix.

Could you expand a bit on the lockdown side of this? I ran into the same 
discrepancy independently and was preparing fixes until I found this thread 
while looking for prior discussion.

The CAP_PERFMON side is now covered by 81c975aae375 ("bpf: Require CAP_PERFMON 
for kfuncs reading memory"), but the probe_read_kernel helpers still check 
LOCKDOWN_BPF_READ_KERNEL while the matching dynptr kfuncs don't. Is that 
intentional?

I also checked bpf_rdonly_cast() plus typed loads, which can still read kernel 
memory in that mode, so I can see why just gating the two dynptr kfuncs 
wouldn't give us a consistent boundary. I'm less clear on whether that's the 
reason for leaving them alone or there's some other reason.

Thanks,

Chris
