Received: from mail-dl1-f100.google.com (mail-dl1-f100.google.com [74.125.82.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9473C8723
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 16:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294911; cv=none; b=t6DSWdYMpG2n4+p9zW3YxpcKSdpKcP2MfQmL6BWrPD/z/xAhg24yes/acwV1BuMP8MKqFDbLFa1bAiTBrVaC2WQ3Otc1Lq+472lKXuw4WWl9J8mnuRCaA6he2Xuynd9lTOp2+ajYH+So4+AR8//ZxjracN3yTsZiSVlDq43/S6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294911; c=relaxed/simple;
	bh=3lGRAEnQMtX4zERAKSIZdMRkPZ+RvRXWmkS38F/ap7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gbAEmjnWzjxFyZYa0vosdxb3FYP7cfLP0SzFOmCujM/AJG6wgSBle6aeooWDN3cFk2gbbNZWrflw2psKpXkjnvFtLZ+dKCFmV508WCf+uBSJMNdp1y7e/TsYSm3b+WbLBvr7afi58v9sMb2fw4gS92C7mxYEH1CGZs3FucLMA/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GwGMNYlj; arc=none smtp.client-ip=74.125.82.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GwGMNYlj"
Received: by mail-dl1-f100.google.com with SMTP id a92af1059eb24-13621cca8f5so436706c88.0
        for <bpf@vger.kernel.org>; Wed, 20 May 2026 09:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779294907; x=1779899707;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k1YJJ1YFmprPS6ntzC8PQrKknM/3MWPFYqmao9X/xvo=;
        b=VoJIxiGoKmRaXdNxJX6rNL6ibA8sEpMpB7QLREl5bQjre1mYKncqolewS9gN54Mn5o
         LpzA3pinHVwVUVv5XKAYydwJAHbk8zjLKWCJu+SxVG4q/qSfxEiN+xFvvGIgnHag5xLB
         Z02XoSSG9bKx1FjBmbrsRe0OPxpepII4klBoTFZx32WC+LDnqOgilHRI9r4vfHrpPokY
         dITWdNWy862mhWWxBttsBWsjr0ts81og+6V0MqLGrSCdzAAxPoRSAeWq7FxO0QO7Jggv
         5TDRiNluygj+saAU9KoQRziW53P2ncSQXEB/NEdN5A3ukleetbnkRmD+Un5aFjhX4Rmy
         uveA==
X-Forwarded-Encrypted: i=1; AFNElJ+nkFvtl0rOAzAAMFyY2+iH2e/cMjcPqW6Ta9kEKuoGWndf1HYa9PfrpFv8ZErWh3wYaLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzAQolcL0a00CdZT74jr/6IUwx0KdefHAnYZm7m0QQtDtXZuAh
	qNGvJwGJI+VSpVhyHmgzwVtjT52cAZ0mGrxSADqzTuxiqUoTxyCakWSEEyIcf60x+gbhcYBzOSr
	IOmEXTbGy8SqBMYvcG5aPlT+SETtmOEmLJpCROthLfgt7IYGFEOC7pMBdD3T/rJnVAoqMNMt4D6
	nIYh4HoLgUfklDgISppgPVtN5TZK8kLZtpyUbFaKldfZZz7F9fCbLT8ntK77gXVgBJ4Pu/VduMe
	t6Yl7mWo1Fs
X-Gm-Gg: Acq92OH5GJPEzm31EylZvlhsmeXnLC2CueJd182r6+QZxIYV8Bkq9vkG7Wu7zUW01n/
	X5/vnOVr6ORD8pXrxVa4qzXMyacstkg53upCMWgMT8U2ixJAkXzCzi9juJpu4UID1XRSKqlGay9
	CZ3vndS7XF7995iCTyVhdal2ZGLZMuIMKZGBN91gZv91xigdyiaHTuq5edCcf7fUEJHFzy4wcv2
	4ZIG9YxboioiR1KstZu5NzUEzX8ePH9EHDSCgBDDJgwniax+otbtL/aN3noaVfvDJsvvjEz4Rf/
	2jK0BvXlrKNI3MWsJ5k7I+iMPko5uhJ4+jwc55B8cr9WJmR6Rm2di+kN1/zERLRIce2vCASNqmW
	Oi+LPcfayUkRy2fvwSc7EDisJ+qHaKQ9sy68sr/1dVnf61fInRnAXJii9RcoBrPBSNT1uumcENM
	RUPvyMw2ZdCBK9qkV+HQhCET95wk2eyylkeyQYhNX5mMCnqxgKl6HY0AmoEJQC6A==
X-Received: by 2002:a05:7022:68a1:b0:134:c6ab:bead with SMTP id a92af1059eb24-1350484e8fcmr10729782c88.24.1779294907249;
        Wed, 20 May 2026 09:35:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-134cbcba1a1sm2293148c88.1.2026.05.20.09.35.06
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2026 09:35:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1353a6f29deso1238119c88.1
        for <bpf@vger.kernel.org>; Wed, 20 May 2026 09:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779294905; x=1779899705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k1YJJ1YFmprPS6ntzC8PQrKknM/3MWPFYqmao9X/xvo=;
        b=GwGMNYljw6jBdzJepJMLbeQNNXO5dD9AGOQAnHSzthnCgY8wOt3+6Nir+1jpOdLoNN
         3WLo08ybTjH6mC/GtGPE3EVZpaetLUoqwdTaPuEAJjrJoYvvrV5RmuVX9FIBfXI0+REZ
         jph+oeSQzt/7hFtxGYwdc/DV/2UaKeKgmZveE=
X-Forwarded-Encrypted: i=1; AFNElJ9smTwoBOkmhXMAThzifdWAQpyXfNsUbABVCRVwnb/iE7u9Rv/TBk6y/bngykrfjDZVeXs=@vger.kernel.org
X-Received: by 2002:a05:7022:607:b0:133:3c47:932e with SMTP id a92af1059eb24-1350494e402mr11987643c88.28.1779294905269;
        Wed, 20 May 2026 09:35:05 -0700 (PDT)
X-Received: by 2002:a05:7022:607:b0:133:3c47:932e with SMTP id a92af1059eb24-1350494e402mr11987597c88.28.1779294904668;
        Wed, 20 May 2026 09:35:04 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb9ed3sm27311954c88.1.2026.05.20.09.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 09:35:04 -0700 (PDT)
Message-ID: <6541a5f4-a150-44b9-af27-8712cdafc1ae@broadcom.com>
Date: Wed, 20 May 2026 09:35:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable 6.1 v2 5/5] perf build: Remove
 -Wno-unused-but-set-variable from the flex flags when building with clang <
 13.0.0
To: stable@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
 "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>,
 "open list:BPF [MISC]" <bpf@vger.kernel.org>,
 "open list:CLANG/LLVM BUILD SUPPORT" <llvm@lists.linux.dev>,
 bcm-kernel-feedback-list@broadcom.com
References: <20260520163320.3073037-1-florian.fainelli@broadcom.com>
 <20260520163320.3073037-6-florian.fainelli@broadcom.com>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20260520163320.3073037-6-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 5/20/26 09:33, Florian Fainelli wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> clang < 13.0.0 doesn't grok -Wno-unused-but-set-variable, so just remove
> it to avoid:
> 
>    error: unknown warning option '-Wno-unused-but-set-variable'; did you mean '-Wno-unused-const-variable'? [-Werror,-Wunknown-warning-option]
>    make[4]: *** [/git/perf-6.5.0-rc4/tools/build/Makefile.build:128: /tmp/build/perf/util/pmu-flex.o] Error 1
>    make[4]: *** Waiting for unfinished jobs....
> 
> Fixes: ddc8e4c966923ad1 ("perf build: Disable fewer bison warnings")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/lkml/ZNUSWr52jUnVaaa%2F@kernel.org/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Change-Id: I8db8a372d1e83d26fbe8beda2bcf4d1a871a2b80

Argh, sorry the Change-Id snuck in there, let me know if you need me to 
resubmit.
-- 
Florian
