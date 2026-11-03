Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793729149;
	b=dD4uCCd9hS2MA5XK+2zamTRecPQ/CBzgYG/2YdGVu8CzeDbx48bhT0k627S8+fPxS/nB
	 NdNCggAqXZ82F7yqbd0XENpgjXrVK2vjGEpuoLU/B1WeAEjN4aQWG0EH/PhIhVNrgftZj
	 EwKNLY4jaBthcI2Z15cIt/8QRgOnS7/efGuYXq42ytL/u6JP+NINxSdfLGYI4qmvlH1Wv
	 zOxPp+E6uEWGH9VOFVMNOXCuKE6+SahFUYYMTtfTR2WDno9tV47qzBs9qFg5C2K6Md5tS
	 h6UwhsdVtKVK9651Z7ICnBotrNt4zQzcrJJ0CPuHCDxjusurLdvf3BxMe6hh39GeOdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729149;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=DIk9eOu6sfTTG6oQRXGPr58pAWgkze4z9h4PinwbNw8=;
	b=14xadgBgflqhe9vpi2HxS9j83DXIQ7x3JcT7vUMQB0l0zgtGjDBiGHp1hR2oFDbA3+X5
	 F2cUM9+k8RNgUYmdGmyOK3stiHmP9416awkKOVFw5iH2xU1ZoOXUvB2U5Psmrp0Nj8ZvX
	 tJFPcnAbnvypLSBkEHHEqGC0JcsIjEZhjYl/TYc1FuM3LcXn61UuEpbaid0jucNdcMxIl
	 4Q44pgZV3eWam9NClDb20yZChW6Qi6MrfDk9fnXR/A8Cts82vgXiN7GF8f92x8f2PBjt+
	 MDh4e2O5XN5At4L5nQq9YRYsBk/u8Dhf/UKCBNt15vnCz4UCEbgTRLP2DWCIWscb9LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NCPHNHvb;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE774606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 18:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE774606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NCPHNHvb
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a070781f63so1867553b3a.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 10:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793729148; x=1794333948; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DIk9eOu6sfTTG6oQRXGPr58pAWgkze4z9h4PinwbNw8=;
        b=NCPHNHvb0AMTn/b04U4ydEjEKaUZsmEeC/ZICo127iP5Jt02NzyulI9xZCnxBtO5kG
         T2jA9lq2VzSuO5e9IGNB1bUoeF9v5NR8jo7abtyym8Bc4PC4k6FZfRLFp/F9hNByOv07
         kllrKdgwiyB95NLmYMNj6ipX9F5LiD5UdpvBtDfOQx0+qEMJsFG5pp/JshDGRf0tsTE2
         9YNWX+PcUkqbQlogU3lD084ZDQjw/noUPXar3c+KxAEREJbQMPvFQOvXqIik7tHuhtgE
         B6Fk4BXvhjFmnEnsan/2jPHUu6XUm0pPl+6KWkIFGof8sS8V5csaf1U9g02iZUt+ND8q
         RLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793729148; x=1794333948;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DIk9eOu6sfTTG6oQRXGPr58pAWgkze4z9h4PinwbNw8=;
        b=qIOUuy6WN7C61qlaqQOhySlaRiWNLYXYE5YAwv3bOgGhsidBTkk3b/jL9JrIgAWmyb
         K/G3JPXATt4YDhwLuOOVZ/rw39wx24JbonTdChRNmn4moQ/fcUuUKibfzdTrmNhiFBu1
         TexP7r8mgUe6HL6FiFIEIWRPd4YcXdc+RDSl3IOWASVdOCWv6pXbSaW/eONSjmuwK/1Y
         Rdjir87zdE/ENTJAterEv/k8+5YQbG8OaxTaw3nmC4JvXJdeGZtEqXbOMhIpJrVT41pt
         o4tvj82XJQMjKbOPebymGBqOJpgc2CBAmZ6WFEKvH369TqXJNwEdSJLKzoDi9UnmoJxL
         Mh2w==
X-Gm-Message-State: APuU4Z8/3G9weNiAqqspQNPsAd+8AhQ/z52oQE5vWm7ib3SdVkA3ga3c
	3Qj+kB5vQl6FQsYTE9Jbty0xqGRxSjDs3qrlwKDF4ev12WWaQbNHbU6b
X-Gm-Gg: AYBFou1r/5IR32qXz0Tb+x/h6v3OD3qbKeAUv71o+X6oGtnQAVmr6/sQj1rZGHMz+wV
	mCtT7vLpzt0QSKzq0x/9qqOpl1W1uklHfpIUtLi9VEg7CzycvqDsF4KJpanCkfaRRYttXQTX9ik
	SkhCqbDGEiCX4Oh9h6nJnAffscRliTIvSNtO6jH5MwvlEJvd1xmW+lxibQcyQ+PLVfutXGozGI8
	zS0Fpyk8fyBaAjv0LOIkp1Tdlq6BF484CAv6GmjnzenxffTuvvpH/GERbGpVnB26+WQM33t36Sh
	YOoH1nujjKQlUsk921RIAK+u6CJr8gYWA+y3MeyyISq9J3kIZlaxuiquApT4+qliDRx/0xOi0to
	07oR+SPEGr43WPzh9p8Z9KecTrXFsl9e1cA6cacN2iVajGGBHFKrLl4oO1Kfgo2G4HD+AIKOvsU
	dtzHh2r/rl/HdlmPGKhJCXEVMHQ59T3us9+r0l5IK8lcjdtQDaE5piYD+OYCimyrYjlqZxFetVm
	YJsy9c/6MyZEWDjT8BU+PSRLiX5yfEEJjtgWaLc30a+NPg0qkkTqC12ka4HjXsONVl4bS1pGWhg
	HiJu46X0kSWZcIEIils4UnxDJo+nftpx1w3usu4TYn7FOQHI+QVIT+ofOZXwSmVzVvgOf7QVkfA
	HSjCrwKQ8g2fxYjLCOVMbFf8r6hDvh16obI0=
X-Received: by 2002:a05:6a21:3216:b0:3de:b120:bba4 with SMTP id adf61e73a8af0-3e928e5d19emr11228287637.50.1793729147815;
        Tue, 03 Nov 2026 10:05:47 -0800 (PST)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb46981369sm61910a12.25.2026.11.03.10.05.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 10:05:47 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 18:05:46 +0000
Message-Id: <DMLRWY2OAGS9.3KD9RKTC5MYPX@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-mm@kvack.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Lorenzo Stoakes" <ljs@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "Federico Di Pierro"
 <nierro92@gmail.com>
Subject: Re: [PATCHv2 bpf-next 2/8] bpf: Add user memory kfuncs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jiri Olsa" <jolsa@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>
In-Reply-To: <20261103075916.100050-3-jolsa@kernel.org>
References: <20261103075916.100050-1-jolsa@kernel.org> <20261103075916.100050-3-jolsa@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 02, 2026 at 11:59 PM Jiri Olsa <jolsa@kernel.org> wrote:
> +#ifdef CONFIG_IA32_EMULATION
> +static unsigned long bpf_user_vm_mmap(unsigned long len, unsigned long prot)
> +{
> +	struct thread_info *ti = current_thread_info();
> +	bool compat = test_thread_flag(TIF_ADDR32);
> +	unsigned long addr;
> +
> +	/*
> +	 * We are not in a syscall, but x86 get_unmapped_area() paths
> +	 * ignore TIF_ADDR32 and rely on in_32bit_syscall().
> +	 */
> +	if (compat)
> +		ti->status |= TS_COMPAT;
> +	addr = vm_mmap(NULL, 0, len, prot, MAP_PRIVATE | MAP_ANONYMOUS, 0);
> +	if (compat)
> +		ti->status &= ~TS_COMPAT;

Do you have users with ia32 tasks ?
Without this code bpf_user_anon_mmap() returns -ENOMEM in an ia32 task.
Nothing breaks.

arch_uprobe_get_xol_area() calls it a HACK, and that one is in arch/x86.
kernel/bpf/helpers.c has no arch #ifdef today. Let's keep it this way.

Drop it and say in the comment that ia32 tasks are not supported.
Pls don't add code just because a bot said so.

pw-bot: cr
