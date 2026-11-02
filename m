Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793601629;
	b=SG/0xAWu6aPxvwhFv4AmaJ4pP5RhxhxK9UmeHzU4kS/IhiLy/XvMrvl3kT9wVjVn9fGh
	 JMMdhu/MxZ+I5bDxfhBVUWtHHfAYycQb5jnXvs3cvOQDjlPmqtbAaie2K/3xqze68nZ1K
	 yK//qIIbYKewVZiXxeKhQalrziRrnsEdIqcuhQG/p7EEm/MqQkKsYnFaOSBWWojsfi8xW
	 TOWSDG7nvDkEKAXdlwv/iPPJAT+FTCAGtWtp2AdYeYsOmg2fcYYixbYEMjs1BGYjb+U6c
	 4VkQwXNht3h3tZriByCjP33tfNmbT24TBTqEWaeMJEvgHweB8l+7l6pLb801R/ymrtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793601629;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To;
	bh=clXPxNZWm9dVdvLhu0gZD+skjmVX0q4s2RrOKHi1/nM=;
	b=1yF5nd7qLVSvw/i4JyqI3fuSo2ClOQlEY+ipIe4CEa044WvK9bvFG6btVN+0E+c46L4s
	 R9fj2+zkry8YzLnjQ7NZ0Af+13ujEnXwEHdw0jmEYVMwRdvgQZurO3phc0xg8Th4ueFdh
	 INLpJlirAEZ1YrBHmGjosCBGzQMJFNX07UFVFTieAbIxV2LtErgRiZgCP3NNxb0tOXQUT
	 vnMrnWCkusnUxNZxTWqN2q4B2lfR5Xg9txOAGNk0xXrkniheJk1f8J4LySpX/mZ9g/8MG
	 KzbMUsWSVdtjlE4mgpL4XjkdPkuF5vUGNAIS+H/xGgr/cGmcZuq6sv+Ikql/lWnP5yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PO3O+zf4;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75937606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 06:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75937606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PO3O+zf4
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so3195832a91.2
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 22:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793601629; x=1794206429; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=clXPxNZWm9dVdvLhu0gZD+skjmVX0q4s2RrOKHi1/nM=;
        b=PO3O+zf4gVEZfkP86xfvI/TroHLNpUza5ZtNU56hMXenAfR2WQHEaMuIVGDV9lt+Yh
         2waxVVvAXZ7xL5tXR5rli1+RvmiXtcXKoIu6Od7phLVePXZ4j2v+6gkv0TDGgZkM4iF2
         xqSS2nUIRWbgJofLdwoWIfDClDOq8QwKpyywwJNLn1Txr/zvOhrSMOmCAi8MEAgYaEox
         BB8BdMRsBU7M8FJ8O46wNZLsAKsagXheh6DKnBit+loCPH3JHmFma/iC8o8Z95SQMJFF
         vW5/m7pEWFyaRNxZjjyzvL+xY9MdiEmnZEnOJ9Lk+DwdVGscGuNiEwR/LTpSypbOFOh8
         xnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793601629; x=1794206429;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=clXPxNZWm9dVdvLhu0gZD+skjmVX0q4s2RrOKHi1/nM=;
        b=I/19UTnVoBSzgCIFzJ9XOaqwqEp4+s5JDOvW7TsYhWZXrtchgJJy12u78jRfcXX4BG
         7Rc8TQhLPP/uYT5w96XjDW+8VWJtqPYRbA6W88STtHuZeNSYASiIPiuOkr8m65o5QEvb
         6cX759XGU4PBvmQ+Z5AxYggyIs8gvLTkILvzcAJ4w1dZWiMOqeey8wU8ye/4xTEaIa66
         GbpLCMd8KSCN3hhZYQIj4hbUqjuswceQZyNaNZYnw3/2ZjGfik25AAADdTKUCiLbenwu
         HoNya0qDEsggDJaq1Pq2kHVbwbMxlRqEiDBeQT8grLt8QKybcV8tiFvjiD+lU4PE2nc0
         jFyw==
X-Gm-Message-State: APuU4Z8GPRKP4taZb3Z/3yk/FjRe56XVziPvk5SYzSu6ANrmgLwEwlRw
	w/ZsyNxpC41Z/j8Oroxc0zL3gZ4Hkht0KIca30HudLe8ebv1jpW2vulc
X-Gm-Gg: AYBFou0/po21QNWe9HNP3UVVBe74mry2Wt9xZFWh7x3gGlbFi87n00r6QFbN6kHO/KH
	mDX5WJZKDS4Pa0rCIi6EWlAvOUnRfkann6zFlLk2hOKR+TDICRAjLkaihKZiA0DGW7XKyOdDiXB
	zW/Yy5MNLo3hGriUHnOMnpaON43l9yvDIejfE52o4t9A7BiYTSWMHRRq7Hb/IVejwn/i9GUDaNW
	22LOMEDNduuIBf4S3m2ygSf/dhwyE1IQYJG8Xc8ZmcCVOiZSwTFBMiZfdd0dtWOuAQaAxnj5Qb8
	8Dj8zxoc4T4V9R0PT06M41xWv8Hpx251772uqji7xJkpAhFAh6fDq5xSfj3r6DK/MYSzmrLUUuw
	Bx3GKMrAimbOpjwiSMLByf41fpqCg41I/WYeojsRzqwZcfPsnzyx7BqQYMR1gGgitxLfjiL6SPS
	waHuZmdMP3KjCoeHR9Tna+HQvWFShnnEKnx+HY+3Ft7c6esjF0decj6v0foJULSlIdFoSfT1lXR
	RBMerlUTvAZGZkV934zchyN6DT6SHkcfvVQWQ6vMQIP3nFV07SFIWsd6ln6wFngGoQ3n2s/a1rs
	dwP5ZyGv4Jejl7P/LwM+Csx3EYhRtrXdgyMgzmIC86wt+2Uk9uWVCt5lts6A6Oti0tx7xZSDyAt
	bbb9e9/co/pG1TtPaqiDybqAdZBsIFLQKxxgRGMJzuljb6xuW2lNIij8=
X-Received: by 2002:a17:90a:c2d0:b0:3ad:eb34:4c6c with SMTP id 98e67ed59e1d1-3ae897c886amr7715024a91.13.1793601628639;
        Sun, 01 Nov 2026 22:40:28 -0800 (PST)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e8fb2c5sm17344824a91.3.2026.11.01.22.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 22:40:27 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 06:40:26 +0000
Message-Id: <DMKIPODYTAFW.2YX0N1TUKND78@gmail.com>
Cc: <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>
Subject: Re: [PATCH bpf-next v3 00/13] bpf: Replace bpf_patch_insn_data()
 with a list of deferred patches
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Qiliang Yuan" <odys.yuan@gmail.com>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261102012940.1756142-1-alexei.starovoitov@gmail.com>
 <DMKHZS5B5CNO.186F6YH1T6YU4@gmail.com>
 <20261102063016.652958-1-odys.yuan@gmail.com>
In-Reply-To: <20261102063016.652958-1-odys.yuan@gmail.com>

On Mon Nov 2, 2026 at 6:30 AM UTC, Qiliang Yuan wrote:
>> 1. Patches 12, 13: the tests need net.core.bpf_jit_harden !=3D 2 at the
>>    start.
> [...]
>> 5. Patch 6: no test has a second patch with a jump in it.
>
> By the way, I was almost done with my own v3 this morning when yours
> arrived, so I held mine back to avoid two v3s on the list. To avoid
> the same with v4: would you like me to send a v4 on top of your v3
> that fixes 1-5, or will you send it yourself? Either works for me.

Yeah. Sorry for jumping on it. My own patches were blocked on it.
Applied the set. Pls follow up.

>> In the tree today.
>> Pre-existing bugs... pick me. pick me.
>
> I'll take 10-12 and send the fixes as separate patches once the series
> lands.

Pls go ahead.

We need to accelerate kernel development 10x.
If we don't, there will be no kernel left.

