Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795101728;
	b=wBxE4Q91W9jV54SpoiRQ/+Yz6KUjGmUY2NLBk+uXlRTTS4VCY9JzFb+v//A5/8mHO3wa
	 v9D7p0MkPMz68BEArq9/+Jamgha2Ki6adwE2B+9twIHTvWS+5+fEGXUinjwS/4e068WNH
	 zbjQ7uSqmrB8HEOcvvecWtRXjdEWZLcf5BGQlBtd5B71+ZscA2YV/gpFcV1qiTn/JgDDK
	 6zqHjIhbab8Eiz2gMkDTcYqkYn4flixV3AHnfYK1n4jmy50K19g3tJBcsKVgkIDjWByDI
	 1LLUvN3g9ivOkclbjVWVVoxWJ4QMwDFNWQ8iqKbBGhyxXG4JXBfieNwFk2qLpNt3BOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101728;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=oV4J42aG7aSlwZmO4hsI4nR3tdj4IKf86NVOjXkIpNI=;
	b=EVJ0MUowrx3b9w9QsOhGH8uu5peOnV3YHyBKbcrSnq4XEhO5WvdwV1i8Ms6hVSfjs4g8
	 9tGW6XppNVpCRPy1BtGaAMkmzP8sN1daHH2DvBaBCAIFW6QJwX+9kYCZhIAt/WlYAvVWN
	 AE4jczD2wAYhOlORilil/hvAAb2XQRjb7c+Y9buz6tV6rYdoroUIw4VTzso9YTgOQ2tNr
	 fm49R817nM+SgmZ443BqhqSJKh/GHQSWu3X6vEmcpG+Tbx9/tpsPMMubarnzhRmFlfYdh
	 GP44Fxkp2EE0Df+42Xr9T+tuYtEX6VMPM5sIx5LerbjjcKnVDl8DVa7mPWFydWYzJpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=ed9MC6g+;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802E2606A324
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 15:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 802E2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=ed9MC6g+
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb666304fdso9059195e9.0
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 07:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795101726; x=1795706526; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oV4J42aG7aSlwZmO4hsI4nR3tdj4IKf86NVOjXkIpNI=;
        b=ed9MC6g+5Qtaoy2xB6R75hiktNRHrl7RaNAjvJeRhSHqpYmnLg4iyU3/hdIW4Pu90D
         a4LQmtDz7S9rGXQd8aG1A/52yzeUu+XvQDN90ggIDTb2We7bKM8vuvXuYrr9v7ehhHXK
         P7QBdQhyVZmPZydzQW88om3uzIo9thgVho6ku23S1CGgMS4BdIfOIiKtP50+yNHtvxJa
         KmtxG8XqHOaTzAS7jgYCxmxQTzMgfEsFdZPmlRsYoT29OqJYiNYjWC1tYEqdP0sMJwQc
         dlWpmyj71nQQ0v8C4hD6MEHQmwQRN2YbJ8uEGM8vF1OWA8ciDyydUn0Duphkcbv01yhy
         +P1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795101726; x=1795706526;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oV4J42aG7aSlwZmO4hsI4nR3tdj4IKf86NVOjXkIpNI=;
        b=uPXIA57yJjtYhjmdhX20LX0F6ImAnVI28Q6Fa0g89wrglUKsTidKyfzU28GJbP/JNS
         KbeDKe4WCvFISbfOXUuW7gFaO92HO90pjhX67qtdXFsz9qBLUVtBS+a0v5APna8I96WA
         0fn8FC6zfHyrg9dOjsIiCYMPRlnEXRvuDiWLZAoTpsH/Ex817JW7DLefBEfiv2jeBg/D
         TDNHypNUEVB7+nx0gH/UujNwcV9e8HFCgX/FsBw7ZRKgjdr3KfNPblYCaC043lCF1QaO
         K7DM9+iJ+XzkcsEYYfIMaOKqZEU07inj+w3h/angUbWc/gtInkUTgo/kgVQfFhMNsudw
         bd/w==
X-Forwarded-Encrypted: i=1; AL+hErFCRNnGOePIbRrrp0O535W24QZyiLxPcBgsI/fQyuzj3AuhH61JWyCtRXAtZQBvlItsH4g=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Hnp+L72UGiXgxxxn3YMc3PaxC5Hsah3h1tZ0O0ki1jghDQkGu
	iseXSrYVuB1mFSDXa2WNxKjnGgV1MzAY36n4xDkOUBgFqQLADWWzrOOcFYkLURTzEDHemlPopTt
	V1mSM/4o=
X-Gm-Gg: AYBFou1OG0BEI0+iRUlVGT2QYNFsWyvySSKWGht3DOVe5zO+SyV6nzvKyIUjvq07EiS
	xBZp8P/JWFK0fAzorkIqXgHskVYq2MHtlef+Mjls1Jew96bIbmUU9VpaYyItrPdoD/cRrjMyjf+
	1bb280sfr/Y7aB64Z/YjoFMoKro9xyxZNJ0jgwrZlVy9hKFQOLCk+Vtrh2cCk/uZByi6S78Hvyf
	6kIKk1nkEtmFzBBed/TBcz7DpqgJHliLtvghqSALInON4DkeDWT7NGYyPGeg1SjTf88mP/3UOZD
	T0ljSJdR7weCueWodvscBsEiZ3FeGBfAtB63BT8Ppj3GeAem7o7cjHC5U6cZ4vYQK8obVyI6m93
	S8P2vEhYvwFmW2IGz1lrIy+BLrFQqm+1VCY0LHQ8oR3DCAtXKgWVcBOsKJv4W0ZYf8rx6XElXGd
	MkiVit6LEJgDtOPh1j5Kn//d8qUrOmWm7O+qKBXbmN8rKC1wWwAl4ijYDurMunZfikYeVk2oGDI
	Aml46HXx1uo1u4X80Yul5F2Sb0tEEXXWfTTFCMVYWpw95iGZ1WwWdXuqI5qkgvdVbGHfp7kCybE
	1Al52E6/mIUqfr9GPNtttdw0S1WQ1ArPVGe9AxVMZ/ENlWbDHvt8yT3J1Kayuaas7w==
X-Received: by 2002:a05:600c:674b:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-4bb860ffbaamr34819435e9.5.1795101725389;
        Thu, 19 Nov 2026 07:22:05 -0800 (PST)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb84cbc5d3sm29859235e9.0.2026.11.19.07.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 07:22:04 -0800 (PST)
Message-ID: <8b47b628-865a-416d-b9f9-fbeca3f9d649@suse.com>
Date: Thu, 19 Nov 2026 16:22:04 +0100
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] module: Add stubs.c for CONFIG_MODULES=n
 module_put_and_kthread_exit()
To: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
 John Fastabend <john.fastabend@gmail.com>, linux-modules@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261014-module-stubs-v3-1-319f2a7d4a55@suse.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20261014-module-stubs-v3-1-319f2a7d4a55@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/26 3:34 PM, Petr Pavlu wrote:
> Module-related stubs for CONFIG_MODULES=n can normally live in
> linux/module.h. This works well when the stub does nothing or simply
> returns a constant. However, some non-module implementations may be more
> expensive, either because they have a real implementation or because they
> require additional dependencies to be pulled into linux/module.h. This
> header appears in roughly 15k #include directives across the kernel, so it
> should avoid bringing in unnecessary definitions.
> 
> Specifically, linux/module.h defines module_put_and_kthread_exit() as an
> alias for kthread_exit() when CONFIG_MODULES=n. That in turn requires
> linux/kthread.h, even though linux/module.h otherwise has no need for it.
> Note that linux/module.h currently doesn't include linux/kthread.h and
> requires its users to pick it up through other paths, which is itself not
> quite right.
> 
> Introduce kernel/module/stubs.c to hold such stubs, built only for
> CONFIG_MODULES=n. This mirrors kernel/time/posix-stubs.c, which is used for
> CONFIG_POSIX_TIMERS=n.
> 
> Define module_put_and_kthread_exit() in both CONFIG_MODULES configurations
> to call __module_put_and_kthread_exit() and add a CONFIG_MODULES=n
> implementation of that function to kernel/module/stubs.c. Since
> __module_put_and_kthread_exit() is now implemented even when
> CONFIG_MODULES=n, remove the corresponding '#ifdef CONFIG_MODULES' from the
> noreturn_deny BPF list.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

I've queued the patch on modules-next.

-- Petr
