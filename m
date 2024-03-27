Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A72137C34
	for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553579; cv=none; b=eUQCo0Jyyyi9dTtNZvUoH7GhOyj0c6qzERUaCdcuzlzLVIpkPxGJRKf4ZVr4ZflDd9JMfN3hfhBktIe2DopUe3Lve/1hg9NyqOrJewfTHdh57wu9ZE3idL2odiF/YYS7qcFtgbEXxMFYRB2CYg7ETXBvUw0vAdJf2eB+jasTrmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553579; c=relaxed/simple;
	bh=P8G03x5KCTx8TF0jsmww7PVADh6Q30jFkCYr5AuRElA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5CADT+69xueHPkNCIn4oL5v7TC3mmMByc7P4PLCbfqV2H+TQlo2xiUMnKKNFFvDqbls9em/UxpkdV7PHjR16WiaPXNPCFY9XKfk6EF779Cn8hKk2Hsv69pNZbdVSs8zoKTIxyfln6EXPGlYVpprm/Yjbr/OGjAX8g49lUIwnkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=dj9cK6Ah; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dj9cK6Ah"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-368713f2f23so23593695ab.3
        for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 08:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711553577; x=1712158377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PF7BpT7xgpetmn2SxPDafvgaaG8xfRfOiIeigueJv44=;
        b=dj9cK6AhEWzqlbDhCvRDfli7Y1bPpYgYfvcKbdrLqmxFosf8oE9jmwoETfSouaKb3l
         QJTKmLGzg8NhQVEcAz88u95V6k+gKfSaPV5dZGHf474ULtUAvrhQ0MWY80qz4LQvDiH6
         bPgWqaPbp1b2gZDm4OZLIrgi7SpLRzCm3/IyIxKgDT09IXhItQiu/0yFVRyXnwhHBaR5
         3STqfhsTjkwL4Dh0xBsasslrlYsc2GTmd2lkgtuk5cmPfJ5NE0731fdnjdazTlUOkm+p
         8jR5YrUrNYwHqegjzz+w9SHRZZmc0UMvFOBtPuamlIBG6mt8qkfrgmVzmJZo4pFvXTuf
         L7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711553577; x=1712158377;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PF7BpT7xgpetmn2SxPDafvgaaG8xfRfOiIeigueJv44=;
        b=gRxyaEIqLEECGh6mdIHoGp9nR7OQPN0/hDTjPNIvMlxLBxrMI2HsYm65akoM5UMBs1
         iTnPl7sql0CAgw7p370kSm7dj64BnERaP5Sl3NFW0tdXcXt0E2VGiZF2CI84bdHidtDl
         uTpoOfUfiV0lUwzajSG3AW2lly8rXezMhRoiDk8ioi76JnsoUN9HKkx4L+VvuU7CFNu0
         EMS2ZI1y00qn4N9+ilqnenuAe0o903TSMkZr3mgViSmeXozGTcRuwp/w9pG1eWTuYwAQ
         9UcCL77fIJVLx9r71gRyBnkd+WFL1CF186NA9iyDpPxlpLuaSAI1fsqymYwUi5FlPhvh
         u2rA==
X-Forwarded-Encrypted: i=1; AJvYcCXS5C4cB3DJJbFhRY5T/+TammngZwxnNweYMBGXRurbOuJEJv+3bZhe/IxMGf1dCIUpb5BuMx7dq0Q/9TAcSgBvZtEs
X-Gm-Message-State: AOJu0Ywdfzop9vPiaUvtThkweDrE0D6lbOx1xhTDNfM2r4E6gtRcontl
	r3yVcCNAU4MBaQmNOMXGX90vR2G7RwOav02KIZXx6aIjDaehKEBd+lQ+psjJwtQ=
X-Google-Smtp-Source: AGHT+IGdMChH50XwuKfroi9Ldx4vewY2tL5TXEOV1NEDYN3TGmpIkbk/uE2En+YsZ29z9C1dTS/OdQ==
X-Received: by 2002:a92:c68e:0:b0:368:980a:d879 with SMTP id o14-20020a92c68e000000b00368980ad879mr354346ilg.17.1711553577622;
        Wed, 27 Mar 2024 08:32:57 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.190])
        by smtp.gmail.com with ESMTPSA id r10-20020a922a0a000000b003687950b384sm3021534ile.18.2024.03.27.08.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 08:32:57 -0700 (PDT)
Message-ID: <c63150d8-a479-4d75-a826-3f87b1a792b9@sifive.com>
Date: Wed, 27 Mar 2024 10:32:54 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] riscv: Various text patching improvements
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jason Baron <jbaron@akamai.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>, bpf@vger.kernel.org,
 Alexandre Ghiti <alexghiti@rivosinc.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>
References: <20240212025529.1971876-1-samuel.holland@sifive.com>
 <ZctnfZWWO3HCiXe5@andrea>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <ZctnfZWWO3HCiXe5@andrea>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrea,

On 2024-02-13 6:58 AM, Andrea Parri wrote:
> On Sun, Feb 11, 2024 at 06:55:11PM -0800, Samuel Holland wrote:
>> Here are a few changes to minimize calls to stop_machine() and
>> flush_icache_*() in the various text patching functions, as well as
>> to simplify the code.
>>
>>
>> Samuel Holland (7):
>>   riscv: jump_label: Batch icache maintenance
>>   riscv: jump_label: Simplify assembly syntax
>>   riscv: kprobes: Use patch_text_nosync() for insn slots
>>   riscv: Simplify text patching loops
>>   riscv: Pass patch_text() the length in bytes
>>   riscv: Use offset_in_page() in text patching functions
>>   riscv: Remove extra variable in patch_text_nosync()
> 
> This does look like a nice clean-up.  Just curious (a "teach me"-like question),
> how did you test these changes? kselftests, micro-benchmarks, other?

For all my patches, I do boot testing on various physical boards (Unmatched, D1,
some internal hardware), plus some standard internal workloads. For
performance-related patches, I run microbenchmarks or whole-system benchmarks
(e.g. UnixBench). For this series specifically, I didn't do any extra
benchmarking, as all of the functional changes should be as fast or faster by
virtue of simply doing less work.

> BTW, I recall a parallel work from Alex and Bjorn [1] that might have some minor
> conflict with these changes; + both of them to Cc: for further sync.

As suggested by Alex, v2 of this series will be based on the latest version of
that patch.

Regards,
Samuel

> 
>   Andrea
> 
> [1] https://lore.kernel.org/lkml/20240206204607.527195-1-alexghiti@rivosinc.com/

