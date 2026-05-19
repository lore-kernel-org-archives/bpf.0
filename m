Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A57B3BCD15
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 19:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779218997; cv=none; b=XWw+LsTxmHCKyTQE2VPB8KpYPWahYtS2m2uYd2TOil+oVNTi0fhkXZL/6+4abxGo6OWCpESAbpL09vsShihPTPv8lFEYiwdpHEVu1xsl1ZGyx/dsjm2H4j8X7h/wUCE+rrv2/46pqK8x7sfcGnQ1/yh/Hk8vT8EZtd208Pc5/sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779218997; c=relaxed/simple;
	bh=YPcRiw4Tsr2KvMmATm06qRml6/4p3sbblnDe0qTV42Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W9ciaJQbQnydCew8YTCcrbA7izueJkaNQnyoy1xnYwF4C0gymXF4eDG4nwOEK58WfsYveB6X41rSUVwY9kKEPCif8Ht1BUKT9cp2UfU5KEpbD8kz1F3zr5mGAZ851yhfR9LIV69wONjzq4K/2LsfgOsywo01Kb9XCT4t8bReAYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=F12NdEY5; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F12NdEY5"
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-8bb09239328so32639486d6.3
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 12:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779218995; x=1779823795;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HOwWa+Njguq/yZzIYzDdMRRevQFxklUNPfoFyUumtAI=;
        b=LngISvt2zzffDcb9kHk6vy8QtkKy07W4o0iZD6CZUoa4GNaZOhz+NBNakYq+yyQuIK
         V8RMQB6QvYljiKU+DjPD3uVpN5nRNdx7HGEPL7/yU3v65gIXs6M8SrZDfzEz4as1u+fJ
         PQECGFqGPzpstA51oT9RT0WDJ5/jbacI400ksc5cGXjiXDWOeXHK9hrOwMV1WD20/boX
         6XOt+niSWDB+NK1hRuilM/aO8chJX1eZ+12Nb6MXeBbtBqtzXb7aQDIPFsORFb2nub5G
         pznx9ALMHqBOCmdSPoDOC+gWDHK89wLeI7lx5oObFTkaWNKhKmy1Uyy2lk1aEre6Wu7C
         kz9w==
X-Forwarded-Encrypted: i=1; AFNElJ9aQ1XIc1uMU5jYJOg1rSxX6ov4fe5RtEoUyAsliEiX8LlBXBN96wS0eJhrGCPpvPVd5q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHPhtpB4fLCD48ScGBwGqjCSVH7z/K8QtYJ4FnSVwLOIJlbY7f
	bn0hHkZoYewxpK76TdmdhKL6T4mT9Uk8qR+rmZi71n6Yok8J7cDCylqeMs6h2sacYwKdBUi5ZSf
	O7YKzHWnn3L8ufPYyPIiq1eeSP46WWcW2f6OPvXXe4+aX7TetP1DeNvKwDBz0NY9PBa2aeu8tcN
	EascgJgC2s/MCylr429uJsjjQ4IOHyrCX6UgohECdQmtuTr2hstkhWvPV8H3AxWvhlABRZUmLo1
	jwotVSjwFPv
X-Gm-Gg: Acq92OHnFDhsBs7o6VS3WzlQjV4R1V/6ACMRXfwS8notS8ls1+wjUXq/fFhfEQBZ0Mc
	ybwEJ+EJp9zvFgFHfRZYFJNTGSTi/V01/ddEfnB+WlLsNvjdCNZovXr3e482lfiwsx9d/siDnzX
	F9PAPItX8ONpo+N7qu6IHoIhhjjPTJ9KWWo9bM3Lrnjn1ngpNL6eDMG/CEx3sarnNc/GgPCq9AI
	+Xrv+LdVP42sAO5wjSV4fq3Jh3UU32MrZX8rDtdBQkrnXMBB29Mu6uqQ9E47wYKKQEc/tlu3sR3
	7J8hqYlaLugm3glnIRyZ3oqmzR272bB5gYM4Sp9ONrAeJGGUdrhHf5ZDwWw9BxFZPlOrX8fUE8H
	R4OmR+/unCdNA1tkaQhLiGJ8IMjygRnbnYKSDg7oWOcT313CS0qh2nQubk73oznIS4caOpTJFj5
	hCuqXuu4GxU63E/wrQeRm9+OheaEX/4VU/qQpI65cIX8L+hCETuwW7xwPbIN84Xw==
X-Received: by 2002:a05:6214:2a8c:b0:8ca:16a6:3d3e with SMTP id 6a1803df08f44-8ca16a641b6mr301469126d6.3.1779218994942;
        Tue, 19 May 2026 12:29:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8ca3618dd6esm7906316d6.24.2026.05.19.12.29.54
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2026 12:29:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44dad1b938fso2400559f8f.1
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 12:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779218993; x=1779823793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HOwWa+Njguq/yZzIYzDdMRRevQFxklUNPfoFyUumtAI=;
        b=F12NdEY5w/jRp9DG94zgThPn4WGv5d/FoQarefXLkWGC7qS/fZB0JiX95AvVpbfLRR
         wBVn9D6xnMPSU1XBDh4RdaH1N5thSUYDyUFvo9zEVH9Gfqqg0aVIOYHWUaLAcfCqSEy+
         KKFeXZaQ0cSBXZr0H+YKpqXuOJifLhHE8kLgk=
X-Forwarded-Encrypted: i=1; AFNElJ8vuOqLSEmAamVBPZ3Q9QoBMY0gr5vphMOzBxPDq3gvOnrDmjpOB5CMSMoXFpTWl13xOhE=@vger.kernel.org
X-Received: by 2002:a05:6000:2c0f:b0:45e:9323:63ad with SMTP id ffacd0b85a97d-45e93236594mr661952f8f.36.1779218993474;
        Tue, 19 May 2026 12:29:53 -0700 (PDT)
X-Received: by 2002:a05:6000:2c0f:b0:45e:9323:63ad with SMTP id ffacd0b85a97d-45e93236594mr661909f8f.36.1779218993060;
        Tue, 19 May 2026 12:29:53 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe2464sm49304372f8f.32.2026.05.19.12.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 12:29:52 -0700 (PDT)
Message-ID: <5b6063d2-a57f-4a8a-9b1f-9cc8ab4cf175@broadcom.com>
Date: Tue, 19 May 2026 12:29:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable 6.1 0/3] perf build fixes
To: Ian Rogers <irogers@google.com>
Cc: stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
 "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>,
 "open list:BPF [MISC]" <bpf@vger.kernel.org>,
 "open list:CLANG/LLVM BUILD SUPPORT" <llvm@lists.linux.dev>,
 bcm-kernel-feedback-list@broadcom.com
References: <20260519185154.2987285-1-florian.fainelli@broadcom.com>
 <CAP-5=fUuhNRj2Dwz9FmMnWKwXjM3RCFV1oQKO4e3X20EOHstEg@mail.gmail.com>
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
In-Reply-To: <CAP-5=fUuhNRj2Dwz9FmMnWKwXjM3RCFV1oQKO4e3X20EOHstEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 5/19/26 11:55, Ian Rogers wrote:
> On Tue, May 19, 2026 at 11:51 AM Florian Fainelli
> <florian.fainelli@broadcom.com> wrote:
>>
>> This patch series contains "perf" build fixes specific to 6.1. We have
>> seen occasional build failures in our CI looking like these:
>>
>> util/parse-events-bison.c: In function 'yy_symbol_print':
>> util/parse-events-bison.c:901: error: unterminated #if
>>    901 | #if YYDEBUG
>>        |
>> util/parse-events-bison.c:1020:62: error: '_p' undeclared (first use in this function)
>>   1020 |   yy_symbol_value_print (yyo, yykind, yyvaluep, yylocationp, _parse_state, scanner);
>>        |                                                              ^~
>> util/parse-events-bison.c:1020:62: note: each undeclared identifier is reported only once for each function it appears in
>> util/parse-events-bison.c:1020:64: error: expected ')' at end of input
>>   1020 |   yy_symbol_value_print (yyo, yykind, yyvaluep, yylocationp, _parse_state, scanner);
>>        |                         ~                                      ^
>>        |                                                                )
>>   1021 |   YYFPRINTF (yyo, ")");
>>        |
>> util/parse-events-bison.c:1020:3: error: too few arguments to function 'yy_symbol_value_print'
>>   1020 |   yy_symbol_value_print (yyo, yykind, yyvaluep, yylocationp, _parse_state, scanner);
>>        |   ^~~~~~~~~~~~~~~~~~~~~
>> util/parse-events-bison.c:991:1: note: declared here
>>    991 | yy_symbol_value_print (FILE *yyo,
>>        | ^~~~~~~~~~~~~~~~~~~~~
>>
>> which are resolved by these patches.
> 
> Lgtm, but the changes should be unnecessary as perf from Linux 7.1
> should run on Linux 6.1 and with more and better features.

That's a bit harder to ship logistically for us and likely for others as 
well where we expect a single source to build the kernel and its 
companion tools.
-- 
Florian
