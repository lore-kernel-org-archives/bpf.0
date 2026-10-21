Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792541320;
	b=ZQAKL/oWeTQRYdag3VphEx0HZdw8zVZE+45HNZxe11bHxJniUeF4nmgnLonPlwx+IIcm
	 F5V2en+3XbN6Yr+oa2+ZfeMcrpMEEO4pBC+2fQjjBcumLaFsIj8IXn3TlEmgQ0F2uuUTs
	 gugA8y2Zl5Eh+QXAWXIP5cxX1LQV85YpR6iWqxiCcUsBk5GEhNyfQq42LZlGG/rv+oxGQ
	 VXaIJbcAlXClULd69iK1XhJu6XzyRPz9D+Z7Awop+zOIPgkE91kP4us6H1hA1IIIV8ltm
	 bcjOlWuS8s8BRwd0SsQMKHDf5EyUDRCOwf+0E3SmbKztFSYv3RYPCrogthTrKtmHFDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792541320;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=ne1zWRudvzywUfkMAO9aChns/vCIzOVe3eUHfFa4uY4=;
	b=h6FRKamvvAUQBb+EFs5roheKgMGMdIglx32o5MWUZ7aLHWhfrqvZoDgSHGgLKuWd4FFV
	 GWBOuIOMAjsbu3fIpGz41QkOVBLjAKlRVuFrHJmLMIYA4cpgUQyNAlKYiWBV2C6Wr40K7
	 C3hpRs5OgvwSlO/igmqpgmNkh/Ai8qPovdGsjMB0ZR4jsQ48epl6ePzXtGKk8op+37b35
	 XIT8L2ODWme1RLbBW0NujnpQ+8KLbezEzwicm+sO2EXB0POxJGZJjqPgRqch9L7+dNRbG
	 gCIyjUZEeolt3bki7VS5/GVUQkZaHQAiqjorAa6erfbS53vZgYq3uj6lSw+KNTJul9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d67UiA+y;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7511A606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 00:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7511A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d67UiA+y
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e60f9af6e6so1138185ad.3
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 17:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792541320; x=1793146120; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ne1zWRudvzywUfkMAO9aChns/vCIzOVe3eUHfFa4uY4=;
        b=d67UiA+yPSVHKI9B5B0LpvwkGp82bm90nwhkeb0RDm/oiqUocbedLOFC2zyFYA6d+5
         8N7uin9hVfwXMACUlnmR2jiXbWrW7Q3k3f1JT05oJ6otNGQ7L5YqCDJCvOjJcq6zJ9tj
         RigZZcGUJBqZ61Ii+mPTCf5yEMBUR26sVZe9rvvmr9YURB+WYgHrH8udZlMmMf7LDDKl
         72Df7c5hQeLql8ci8FzAUuRv9WJOCmeiC1MhTzDxrzf4uzoW8PjavBfkWhUnrIvzFcDD
         9zoN87xArljuxZ68eq5xqWKIWuh+LbZH5OJyVBCz3KhbA/g4PysJbHyOBwBXfM4uhnVa
         spJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792541320; x=1793146120;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ne1zWRudvzywUfkMAO9aChns/vCIzOVe3eUHfFa4uY4=;
        b=FVmEYuA1cA+J75J8+7WdU3ef0V4I26CIXRGIsfW+gp/JI7ShXlbgcULSB8OI/C4aFp
         kp3orPwbdHfqThQz7ffc+0uA3Tkx1xCUDTgwR6bTZK9luGnWeP8AptV0LoQOskZfTwMc
         7I4pP31fQ37IQlOjFdcvLy7EAYjS1exxeuH2vuhD2LVbCEU8klTDdXIthwPi4scQRwdO
         Aw9eXzU73ff0D0lmVL+QmDhIa3g3MxXaX4eqWSJan4utNIe74q+XZj1+OxYxFO6ADLfs
         z5CNOTCihWn5sFM81/9OU01OlK+7tFSLNZHREkugGZghLtEsDWyIGsK8wHihA05Xl3tm
         uNTA==
X-Forwarded-Encrypted: i=1; AKwUvBx9UZgrJ5EeGC8uZL73q0o3yR44IiRvXUq2c0NkCTQSnqSXgb99hgPgnDuQvceW3lkiHrE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIw0VktUDfALwNNNIfA81VMyuL9SCF3hN+OUUjALhiXkONGYk3V
	BTy3Ojp2auSt6KGqH3nLNFf8CAYRLLFQ9y9slja0inSWY4Q8jpc8pmPj
X-Gm-Gg: AYBFou3gjtX635uSVBIE8Ndgh2y0bVtx/0Cbsgd27jGpt54tnrgLuMDBTfoLkzwMg/f
	DDM0BFbFol/PfF5GARwicHJkuV6vanadDxBI8O/X4N6mZUd/9lJCuM2SsUJWCxw29SOjvskExDo
	nXPAPwBcwuCEa4IWLyhjdNhwDsytuKLLSS57afk3Qnjhgtoz/d/zURBexkCS4dx8WSqb7+U8j+H
	Bbghbl8QbLL4GYwtzhfkgtgNhge20GUx6LokOXORi/HSRGwO44h0rivaH3rPxWNG6PSp88RnWbf
	bg5oKEmYPIJiTTlLxmSX8ZmVdUQpqj48hgdonURzAvwIfNCbTRlOZdi5w7abNTvjpM8abaChjgq
	sm+Tw4otFoFWcObxSOcKVb+C32b6Ic7NJjVOxfnCv3EctAvJC8s8P/BjfHlEt7J9ytGRoVxn6v6
	IAAreXvESWGFZ80+8SJ6/tSfpMCrf4A4N0kjK2x820iIFv+Q7et2LiksyzpMjZW+sG/SSnZwyZk
	ZcagLDA9jc3gTgbik3RFYtyMuXef526MjqQpsudGeVJahw0pflryDp9V4UA/z7RSqm/2lNeJIlc
	TKOe6LptncLylhXul4W63nLfczdVt0Iaqy1eWKQtlLNfuhgNQ8mtzCmF3U7CixXxV1xMX8XTebc
	xivK1tw==
X-Received: by 2002:a17:902:e844:b0:2e9:7dda:bfd7 with SMTP id d9443c01a7336-2ea43cf0998mr3685795ad.56.1792541319642;
        Tue, 20 Oct 2026 17:08:39 -0700 (PDT)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4ada65sm3810805ad.73.2026.10.20.17.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 17:08:38 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 00:08:37 +0000
Message-Id: <DMA2V519LNME.1WWMR93G4S295@gmail.com>
Cc: <daniel@iogearbox.net>, <martin.lau@linux.dev>, <kernel-team@fb.com>,
 <yonghong.song@linux.dev>, <memxor@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: reject pointer operands for 32-bit
 recurrences/latches
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>,
 <andrii@kernel.org>
In-Reply-To: <20261020234705.375067-1-eddyz87@gmail.com>
References: <20261020234705.375067-1-eddyz87@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
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

On Tue, Oct 20, 2026 at 04:47 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> -	if (ra && rb && bpf_same_memory_origin(ra, rb))
> +	if (ra && rb && bpf_same_memory_origin(ra, rb) && !latch->zext32 && !latch->jmp32)
>  		return true;

This covers the latch only. A 32-bit recurrence on a pointer that
is not part of the latch is still widened and clamped, it seems:

     r7 = map_value, r1 = 0
  l: if r7 > 24 goto a
     goto n
  a: r0 = *(u8 *)(r7 + 0)
  n: w7 = w7
     w7 += 8
     r1 += 1
     if r1 != 4 goto l

r7 at the header is (zext32 (linear r7 8)) and is_widenable_reg_type()
is fine with map_value. 'w7 = w7' makes it a scalar. At the backedge
bpf_clamp_scev_regs() takes linear_bounds() of the entry reg, which is
the offset of map_value, and clamps that scalar to 0..24.
Then 'if r7 > 24' is never taken, so 'a:' is verified with
r7 == map_value only. At run time in the 2nd iteration r7 is the low
32 bits of the address + 8 and the prog reads from there.

Should bpf_compute_loop_iters() also have
	(!coefs.zext32 || reg->type == SCALAR_VALUE)
next to is_widenable_reg_type() ?

pls follow up.
