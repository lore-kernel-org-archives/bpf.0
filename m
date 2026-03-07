Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A2713DDAA
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 00:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772842339; cv=pass; b=fkACgFaU8VPamDz9jl+0sKzESuBiD9DpRmBBCAqqpSaLYvvnwJBEkdbqXMqDQIHbx3lI5qj/GH3dhauvudN9uRggSd2pM//jpkcD+InwwTjaYV35bMBft2pY6nrFV2p/vwb8hQ7ZotgD7vM5NN6DCxYl6gzeHP+kpLESN6HbJrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772842339; c=relaxed/simple;
	bh=biHPkTU5i6uzovfZilTp6Jg8ImXxZbG2QoTFU8Of71I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OIOdDLETIqvBSw9Odk/RHFi5HsanjkB5+DTLd4PP/9hALAUvBE0aXEtC6GVH0hgJiLmTAwoH39hjs5tr9zcs+jzLh/FJCGLm0LBKN+jsKCWVJycLLjGOY31Q1z/HHmqnZcDgerqsTh9EMCdPHwtZj8uGEVqixnJbbVc1DpqgB6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7Fo7lsK; arc=pass smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7Fo7lsK"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-483a233819aso96447825e9.3
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 16:12:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772842336; cv=none;
        d=google.com; s=arc-20240605;
        b=EVtUXZcmNUiaQl4mDK9hmwpYjyzgJ1HNDNe4izulWj8iVsIWXJa4MdOXgAbm+rwjse
         gmY8QUcQ8ClU5yC+XjhS/Aam42XbvSZ1FN6qZZbYS0awsCrEtZVGe8As+hpP9Ch+p2ki
         ZJFyAsYrhD/s6AQATjVfFaHqNuhRIbJ9RGSXZCu3Yb71H0Ip1TeQvPBHAlm3fbvnhd/h
         5MTftab7tHPT2w9q2XFmlawa3vYk9IJui+sjSGyALrz3haApb/R7E/UdqYH5gevD/cqC
         9sIEzdF7TYy7ItaoNzpfAORCC95QYPdEYm0DpaFvGmIfF0lJiZPg3KWx4o8R6JmXAkSk
         RjGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YuW+ZEOlwWNjJXkfhiPp/nzopgzeOmjwPNaZQSo9JBY=;
        fh=5iF2h7k4YlEUAfd4dMnI/SEaTn+r6JzqyFlogRFjJfA=;
        b=Ozx+hg9NyVqZ9IDei4MMn4ki0jFdHiQKAlcJOUGX3ATdfjSQTlQDvx5jreUaVSKiN5
         ahrGW0uQTFuTnoZlOJrPXySksc6yjFrYtT59ARDayTIjq0TPb0HmvlDcIVrRAwsGr+C0
         rLP97bsjrTl7QGM1V78MyNZa+Bk6QRD54EAzjs7NEeWlBmnvcA1CnmAuIdm+vlRnrGIj
         ANswnoTf513Hih1cWSfup7rnZbcpDeG2aokxwQi8+nJTtnZWb7X1hSRGW8//Nwy4MMOQ
         xhDPw73HCHZP8ltL2bOlVJlat/JJr/Z52F7EvxBRSwGBGIJGSZ6KUBf7fl0XZQ1aMM8l
         OFYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772842336; x=1773447136; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YuW+ZEOlwWNjJXkfhiPp/nzopgzeOmjwPNaZQSo9JBY=;
        b=g7Fo7lsKJDZ8xF48d4hV+racf5b5MHUz6e6GjY0ZGuS+ubW4YfqeSsrxCBg7sJ1fsA
         HW9Db3McmIQr0urmvhQp67YEhwtLfsJKke42DLAYNNVH8VKlIZxH4pn7XZ3gdvR8WowM
         Jbe0MufS1Ngwj0me99x/czcSE7mYGkJtbmVENpPePRPJaeAQigdLiO15aJf6fk4EznA5
         ybqbhSTe5VFgUo623cF6U1bIBCJRuO5DYdYhe0xoKcnmycl8BdZL1vg6YP08AeMPs8gZ
         xqq57Deb8VjBkx9GZsbEy/B814YRUIR2yGZDoau+UYDwhJ1JAetrct1Sp4FwVhIYBWIq
         mPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772842336; x=1773447136;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YuW+ZEOlwWNjJXkfhiPp/nzopgzeOmjwPNaZQSo9JBY=;
        b=SXQ3lux3T0aZXNq9vcuDwyNaehM9CBF+QsWpwQuSjB33ya2HKNL6mBrKy+WyxyVjUq
         etp9HO/QjaI0mrTYOfskJa4rv6z9DKJrVLq2Z/KkxYBAa2RBGz3ULdQJp8QNMGUh8IvX
         +BBhHCOcbTNApFCKlqVYVBgKjv0igYm5/JQLzOp/5LUU0hvmpXuMn7zyJESzo4PELcZb
         ZsrKoAkWMXRl8Jv4RQ26SmhQ1V6whz4F/FVbfDeNW/RHlXItqBbzUB2w7cPST/VWY2qf
         dLoUbCcJUihm4w2OnWmnkY0Dqg7LxoTLjKiAWPhxONLatZKFUQTatFS4jJVK0gBS8eBs
         4kWw==
X-Forwarded-Encrypted: i=1; AJvYcCUuEIvy0efIyWTqDwNk6bFMN3aZ00rdz21BBYoYTahS5kJm+T28aojRtH5q+TmWsedBBMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrGhCXUyGAIqxPqLYe0wOqiW+H+qUHk6yZwKpLS0ZlH9rPpMCa
	nu0DNLBrSdDVKBdX4F4sIRF8OusBsEpxyiGO4I/LpShMDuCSKAGjochTCl8OMarCr3MxP8RLrLV
	fuK/pnqHcfwrCOKgHd1sTLkWl+MK0QU0=
X-Gm-Gg: ATEYQzxHm8yCh9edSiPTfml/xuXfrHjYuRvw0JN10GB4wuP8WijCNQ0YXpEC3aCI3wA
	h5sL1VdATlPGnCfmqmQFngHtWPhAfB+j61yTdaH7S58WC5tBUDvK7pTFyN1Nl3lZs6yrjqU/ISI
	SmPCxaNCT4O3zQpIrSWNpuqAyjdQxqEuxDuCtTKgt+rpReVPZYIb0VNk253TSlkoVrfHAjiNQ2n
	Yg6UKKhfpcsG0Izfb9CWpnKECkcLUywvLIqo7YyT3R55nizIqTpu0IO8th1CxVF7UXqTAEGQJ5Q
	ZuAznmgrna3YYutPmsIESZm10X3Zkp7n1vmSxqEF4ccxa1WanxIlZCJp5qQBK3bSMEesmg==
X-Received: by 2002:a05:600c:c4a3:b0:483:9139:4c1d with SMTP id
 5b1f17b1804b1-4852692c943mr69335975e9.14.1772842336318; Fri, 06 Mar 2026
 16:12:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306083330.518627-1-sun.jian.kdev@gmail.com> <20260306083330.518627-2-sun.jian.kdev@gmail.com>
In-Reply-To: <20260306083330.518627-2-sun.jian.kdev@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 7 Mar 2026 01:11:40 +0100
X-Gm-Features: AaiRm52kGwLc-IqCrj2d6kwEzwvV9YuXEYuT-7l1k2Hxe9AYBniYOwy9uAhAEZ4
Message-ID: <CAP01T75bQ-OAGontunAfAEP_zaJ+gLY-+=6U0ZHkJ4DasTEBdQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] selftests/bpf: drop serial restriction
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Mar 2026 at 09:35, Sun Jian <sun.jian.kdev@gmail.com> wrote:
>
> Patch 1/2 added PID filtering to the probe_user BPF program to avoid
> cross-test interference from the global connect() hooks.
>
> With the interference removed, drop the serial_ prefix and remove the
> stale TODO comment so the test can run in parallel.
>
> Tested:
>   ./test_progs -t probe_user -v
>   ./test_progs -j$(nproc) -t probe_user
>
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>
> [...]
