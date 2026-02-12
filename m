Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A444A21
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770913354; cv=none; b=UdIb1gcuEZeH3tnQCdZyjAYI6PG8KHI61WQ5y0J/CRwtiPlLemPNmzqjvw/O6v661rEN7UFS179wp6Jf+2Zmj4K3Yxie61Nfob2DdLIJyHY/hY0Q/PoKpdlDZpuqgs9O+ITRHsOeK+2C5M4AZIP2HXFyUOx5UZeAcRF7vZlfD7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770913354; c=relaxed/simple;
	bh=4IE9KKdlECBRGFdg+lsYnAGBUFJLqMKho+ptX6WwNQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rCNQsWUWhvI8MnvLFZmWSZW3ixr8taHDdc8qoqC5Y2LjHmVPZr6cIz0St3KU/kzUmcm/SwUZeZ26TFv2lb/jz2XFu47oL40JQ6iCm9IKEPX6s0qlS/kxt231vEy8mlwCoa9XJO8I4UZPkhZfs3NdLSjv0HrrISR1tbOIwDOgiF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InzLVJCO; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InzLVJCO"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4362c635319so35058f8f.2
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 08:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770913351; x=1771518151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4IE9KKdlECBRGFdg+lsYnAGBUFJLqMKho+ptX6WwNQM=;
        b=InzLVJCOtmyaPlXjWlQfVJnTdLcc7T0eibPwMbTB8PfORg7v5m5cdzn3hgNqo4m2em
         OkLVDGvhhSIi3c6vgkm30ihxjMUfb1sC0oeHSvvGaUH2pdrx59uLHwLt9VLmu/t8tt3o
         57xilscsD8485htFVcd6LxdI52werfov4MLhPz9vPbV327H8k5hweQi/wNWy5piSk+Qe
         qoumdjxpNyqYhlP5+2uikxJQi/lqYTHbb/XXk8aF9fAe5IJIcj/w8aRcG+WoBMF4l1UJ
         ygF6DdxJNEe7DhuiZhVDgImA8Ry31Zc7ozVwB0B0718brEGjO0nWO3ZEoah+2gmj9Ckg
         6MqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770913351; x=1771518151;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4IE9KKdlECBRGFdg+lsYnAGBUFJLqMKho+ptX6WwNQM=;
        b=UKYYgQX+u1Nr/yQBWBPktocQfwzuY8HE4XW4Xx9jG7tjrbnEKqlpMZmBVgJR5PoOf+
         4y1sqeW7jaqGt74wg2hu3ax9QPCiBHesBscd1OBRTDFFmBjlJehhDd+u9PRm2lLri+wm
         kbG0DA8iwcHfH3YuUSs4i/oIYX07bh5k1WVJUWoy9rMPnPPUdPdEhmNAgETd3AVXi0Ed
         8RdnaoPP07CkNEyRx4F/KOHiIqImQrLaNG6XI8aG03u66ryNPaR5zXU2K5x4FB0e+qsM
         HOkkT8GIf7quQnTaA9CE1y5edbOzQnghOjY4G6EhowiFLNFF7sN+E5fu1rynrfcKfPJL
         SL0Q==
X-Gm-Message-State: AOJu0YwrFBOIEU1m42y1m+hq/dLw2GK95z5+GEWQKq0C5N4OJMUBGG5e
	ksUwJEw73EekCTSFS4bV/qEqNM2icC7WTgjsgaDbm20LEzziV/XSVFZm
X-Gm-Gg: AZuq6aI7XM8tgqhJCqP/CmYhKZidR6UuhPrfnWYAtyYHNp1qUCakqUmq+drTf3ATgIR
	HMNRRb4lQo5Do7jbQA/O4WpmjrMZvclRvVJPzSYQlu5yZewjThU9vIUrlmfKK8YfoZSe3Yk7Ds7
	ddBdcZ46mmgHIH2iFIOlIcNyX9ze2O/QCfr6urdh66Oo5w1LrEbFxvhspNhTASONjyet1EVLpCK
	PGLVctxAcdj5IdbhY88w9sJU3q8O7LbTkwJ5Iyv2fIKJxF/5ub+zJsc1gmxrgJLcwoSq7oiV2q2
	bravcTDKkc8ZQfx8DVdGl9ZXuRnaWN9GuthYroVEWtfcUAkjUuZPBC0csL8VtLkivdKNQwciFiQ
	Y5xab9wTF3+kgVf+QbzGXtcH34DXG/BlZxPRyVVba9t8qI7DrsAXV41rklc1HLaQqJdjRy4slal
	LbaqPl2DK1bD5rgb2Jwr1YDYx4OyELINlGTG9D3KZqdcyBT6FDUm0jSf7kpL4nPStWlNyGkGAhv
	vilwlVT2n2/a2w=
X-Received: by 2002:adf:ecc9:0:b0:437:6efe:94cf with SMTP id ffacd0b85a97d-4378f128b27mr3508206f8f.1.1770913350933;
        Thu, 12 Feb 2026 08:22:30 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7? ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d746a3sm13453060f8f.17.2026.02.12.08.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 08:22:30 -0800 (PST)
Message-ID: <02973092-a718-4374-a6ee-e31e8c046ade@gmail.com>
Date: Thu, 12 Feb 2026 16:22:29 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Use bpf_prog_clone() in
 veristat
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin Lau <kafai@meta.com>, Kernel Team <kernel-team@meta.com>,
 Eduard <eddyz87@gmail.com>, Amery Hung <ameryhung@gmail.com>,
 Puranjay Mohan <puranjay@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>
References: <20260212-veristat_prepare-v1-0-c351023fb0db@meta.com>
 <20260212-veristat_prepare-v1-2-c351023fb0db@meta.com>
 <CAADnVQJqBqBaUZjQAGdchePKZMT5BMop8Sn1W5jmVOKUUdv0OA@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAADnVQJqBqBaUZjQAGdchePKZMT5BMop8Sn1W5jmVOKUUdv0OA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/12/26 02:45, Alexei Starovoitov wrote:
> On Wed, Feb 11, 2026 at 4:45 PM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Replace veristat's per-program object re-opening with bpf_prog_clone().
>>
>> Previously, veristat opened a separate bpf_object for every program in a
>> multi-program object file, iterated all programs to enable only the
>> target one, and then loaded the entire object.
>>
>> Use bpf_object__prepare() once, then call bpf_prog_clone() for each
>> program individually. This lets veristat load programs one at a time from
>> a single prepared object.
> Any performance numbers that prove that it makes a difference?
it's neutral, I did not manage to record any difference.

