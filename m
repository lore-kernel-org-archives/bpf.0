Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793485852;
	b=k4EkJJ97swCXwLA8E08Tmx3nI+oGufhJy7fat60TcJCQNfWkExyTNN1nog4iOq8+t6cK
	 HModY/ARApp350MdyZcre0+V2b9mjDs1v+uJdTAE5+vUta9Awi7x1kDGeutOUzovRoea3
	 LR8Qt2ekWd3tMHmFKguZ6eBxYnt2yH5/UtNFMaOx5h0icWfIeKa/SeaoRDYIH8/jug9dF
	 SXQgvyJfskUngoqHxi4Z1qKdNhJ+M5sxEnRZvJutHK5jLrp0HOvnevtB+xklkkK24v95k
	 FlOuFB7VXcxTHRwEc3Ql5qySvjYKe2pxJ+I5CBW5cNg3OmN1/GC0uV+sB9YkliuRshw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793485852;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=MGo4Bgn3xfsuhIWP7gZlr7cJuf2A0Z2Vo1yEXLBRDEY=;
	b=LD8p+XdR5U5YYd1+zgY6yzPAZFOq8WPV2DKAg240/UXo8CnLBoLF3HXC2h7RvFYvX8G9
	 KKa7VuUuUbrK0YwIubsQBqYiMmSkFoPGQifLOcSkPaCeJk28Xm1WGxXLCtBHXt+LRW5yM
	 hqpOF6+QWK2ZbIiTlduijIcpjjV8hcOlYv/40rK+vt9zab5L1DTxWYOvbIl6E8+/UTbyJ
	 dPvUEpju5vsEjm9+3e1G+jPqTdiB9AcOmbZtSNY+MZ1dXw487N1E2fHTxiHBGicPb53I/
	 jPgZpklnTO58w+9oJmvo2GsnfsN4Vcn3rqU/494ikBMIUVu5zJmZegd92XB3xVdRKNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X9XAPEW2;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D10606A31C
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 22:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0D10606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X9XAPEW2
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ae57dc1ea9so912343a91.2
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 15:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793485851; x=1794090651; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MGo4Bgn3xfsuhIWP7gZlr7cJuf2A0Z2Vo1yEXLBRDEY=;
        b=X9XAPEW2HozBhIKQ7l+J6smYnrUi1bRGz8qFFTwdLvBoJkEn35MTq9Qit5p+feiAUq
         MVeHZyYdNw9hE3tbxGtFmsEKYSxP4FcO39BQ9QCtTSdF4FzKCCUYr0GsF6jjti/xyFd3
         GBxnF0cHCBoYTd5Rs7c8gZ5exHgnzKi6e4w9MYtPGBAxevN0TgG9C9yJQl3Ke9bEsLwp
         BxBLrElAzTIfZ3zQsK8Vofqs39RYigi+vRDcrB+nPI5bzkIjkv8i0ow9RhRwj/QG5zSS
         bCuxFTD7s3pilAc9fbyCHe3CzxmkV/pitGBQvVJ0dSskSvyEvRi5UJO/CRmOMAY/U3J/
         YDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793485851; x=1794090651;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MGo4Bgn3xfsuhIWP7gZlr7cJuf2A0Z2Vo1yEXLBRDEY=;
        b=ml3XCpABT2jBCa1nxfUPZZcC4IOlaX009Jp64mzqEGiFXDZg//xNBwtW1cc+ikA+5a
         qGzEqDPmpmf7dLJK4WesI7HZxZ/6EM1wIht5iS1iKBtIRXSYI7TqvY6mMrpme1ChVHiW
         hU75yRfMwTCHbKnvKD6Y6Hf05wy1Y03y7Yg0wyf3PdJ8s/5hqrGc6st/q/59oHRsEL5H
         zGnRDjhxITHGVZY94nqAnG7SVQMxji3cUFx4sUiaBfTH6GxBpg+oxYDY4GMBl4Ww7Kvj
         C2Yp5gSYEMMrCqH4qp87lSfEPuk/KOcpctneahzEbY6coXIEQuXVP2LJY6lOjDfsDMW+
         qiUQ==
X-Forwarded-Encrypted: i=1; AKwUvBwdKp8eAPU401vyXu6IIpraaiNxeSe3SqosiTPjenSU1HQ76rPnXQ+XdLN73h02SszFzgQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKeyq3UBuJWaitJbQVONzhV3yupgfVaa06t6FYtjqhzW1Fcr3pF
	NFG8/TkDzPYpVb9TEUh/Sq90bi2Dyt97gIH+1Gi+s0kQq+cPh5+UAm91
X-Gm-Gg: AYBFou3hWyAXClckeiwgEETPQu4S/+FDRti2A0WMnwFPR1gI8t8FVTyPwHul9cK3dSQ
	GTgAevdg5oK0HHsBkQEkkPGHYrhw+QWqBg3czIOwY4UJxFWiRvfNt9CMusT4BZbPObq5EjSz2Fn
	PGvkfNJB+kl+dlD3fXBy/68Ex0kWnIFdMa/K5V276ZtFDR9DuEBQ9O4Tt+SveoBC2SkLYr07W6G
	ufPptftedDBE5bYBhk54WODXkx3boRcANh+7hhm3gLN2hma1czVcJ/ndVnAy7NBnVOe2Vv2wGrp
	ccCgIVwQPPC6GL1QSN1iCylSqBzfIslhN9Ql43AYEAvUiJ9DqwhK3iJdaAPBAZCaVM7OxEHEp3e
	zBS+QsoVLOdgJnT+V9Hyrx3Q3O3eRIddSHy2WEIzNoW84lcMlzsJHUBc4RyDhX7hKpfPWx3ayFq
	4SMAGxWHxwCshFT/iZb2qEgLZaZ73O4ddRXzo+tB/uNMUNtjhMasSv6jkdhVpiCUHpYROXRkLLK
	OfXEqJVStA0oN++rwN6JtTNlhCqEOZw9G08xg1Q/+yGtKUZJghBSxpb9isaZSJ/P0w7VbrPQpnk
	xdNT8vQHTTNOiBXp6cwXwgMxQKquE4tjUZYcQV6mQuSpJlhmSccEiiRCARXiiBYwMDHST4Pn+n+
	wUbzgmffsr5HF32uRdf77USR3m6z26CevhA==
X-Received: by 2002:a17:90b:1e42:b0:3ac:a1c7:20fd with SMTP id 98e67ed59e1d1-3ae8957d4ecmr5239181a91.4.1793485851158;
        Sat, 31 Oct 2026 15:30:51 -0700 (PDT)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845432e4sm8689761a91.3.2026.10.31.15.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 15:30:50 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Oct 2026 22:30:50 +0000
Message-Id: <DMJDO9F7MS0Q.1KWWWLKDATXA4@gmail.com>
Subject: Re: [PATCH bpf v2 7/9] bpf: One may_goto time slice per prog
 invocation
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <sashiko-outbox-192205@kernel.org>
References: <20261031215543.682284-1-alexei.starovoitov@gmail.com> <20261031215543.682284-8-alexei.starovoitov@gmail.com> <sashiko-outbox-192205@kernel.org>
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

On Sat, Oct 31, 2026 at 03:25 PM sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
>> +		off = off >= 0 ? off + tail_cnt : off - jmp;
>> +		if (off == (s16)off) {
>> +			insn_buf[cnt++] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, off);
>
> [Severity: Medium]
> Can constant blinding cause the 16-bit jump offset in may_goto_expand_timed()
> to overflow S16_MIN on backward branches?

Not a bug. That's the limit of blinding, not of may_goto.
Blinding adds 2 insns to each insn with a constant. A loop body of 32K
insns with five constants in it fails with the same -ERANGE before this
patch. Every conditional jump of a prog has this limit.

[...]

>> +	bpf_timed_may_goto_save(prog, &saved);
>>  	callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
>> +	bpf_timed_may_goto_restore(prog, &saved);
>
> [Severity: Medium]
> What prevents bpf_timer_cb() and bpf_wq_work() from reading a mismatched pair
> of cb->prog and cb->callback_fn when bpf_async_update_prog_callback() runs
> concurrently?

Nothing. The race is there, but it's harmless.
Two progs have to set a callback on the same timer at the moment when it
fires. Then the callback uses the count and timestamp that its prog left
on this cpu. Nobody sets them anew, so the callback gets less time, never
more. The limit of 250 ms holds. The other prog gets its values back.
