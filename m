Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795726339;
	b=1KKXl+gwUbvNdzzxRCYw1BAN48oBeH4F1wVc8JwBFLxk3kyRw+74B8pwVc0AJPiE0z+k
	 ZZh5Akr+bex/5JdQeymkRS/5zkcdHaeYF1isbXW8I8B5gPUhpHvIyV3UDAjf4aFjVqEK5
	 CNz6oVWvjYCbIMtH/Ss/X2AbrwoEQ27LyPXQAq0Ki9CXKRFeCc95oOarkGLtgMJf4x/pm
	 uXu/LbcOrzcDCYiZ6Ne8AS74rwkC9sE8kuyVC01o8l6I6tc01TSoxgQzuFXO58N2/HpwJ
	 BwR4wg232NvkiRLHAl+GylvlxXya48BsU8/H9BMJWjF+upj4reKrUFO2nXrbYwlaPMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795726339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=JcEEyA3sx+c6Rpqf0psrYSYbyT1hssX8f9kin0pu5oc=;
	b=l2Cspte7WTKE8k1yeiUDiM8HUMpJq2aBNt/XVg6xtflnpsVv5qAvQDDwPVr0bgMm82Z1
	 uX3L6W63CZFT/w7ped4J1w2a8x6lHW9by2mm+Op83ZoWXJ/O5qjZFuKKkmArAApv6EQbZ
	 IG1XHkEq5AE89m91DOnbLeGGxJP8e8O7eV7uULf5OnC9ZlnXKeLASf2VyiZbFHLNjmcfD
	 Ksf41Gj9rSXwBUGp0gqqetyRJxd6626T/X184b1mK13tm5x3zK86oSlNHQB8/i3wc4Sko
	 fxrkmUKvRouDOWIrmEORv6bWvlxl4fJtmkOTqeqYPIfK49RVa/7EH6f5RqT6irifsOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sGCTtS2V;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5284E606A31C
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 20:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5284E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sGCTtS2V
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b08cf16decso4355218a91.0
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 12:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795726339; x=1796331139; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JcEEyA3sx+c6Rpqf0psrYSYbyT1hssX8f9kin0pu5oc=;
        b=sGCTtS2VGoZw5jrde8R1AV7EAUVYQ1ka19rLViNoI4nBW6vy17pzFKbbefiStr/558
         uPYLarn1XZHNLmbEzxqHJ9fmvSy+AzfeiQZZxRSRFq3ZUvTwxH1OPrUnbeCKrFG3w/x3
         4CwtFAT6A3l+HcgJGHWD5fYPJrsA4+pkgvunLPlZmPGXwbLy//MJ6rHfMs4WnFdv/m4P
         cd5MdgCQsxZRqmvMOigFKhYseHN2E4mtvzF5CA/xkdk5bd+DOxlgh+b0iNmAAPvevO/5
         UL1VRFqOZEWg8gyexWkVI26T6mCaKVUhBJzcuKa+Yw64m6DT5AadgmXQh8XCi40Z/t/v
         jhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795726339; x=1796331139;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JcEEyA3sx+c6Rpqf0psrYSYbyT1hssX8f9kin0pu5oc=;
        b=qmFRLc3WuAh23MUSelrD+urw2fsQQ9YsdIRvn5L3/ld1yt8UWOhVztRFp+inOa+Wji
         FnfwAq1qMhl4m75TxMdcYo8efLHileyzPEBX65+Ic9bo8CnxKGRCJHX+XD759PZlUdeA
         GtBWZtrgY46VlZX8xwTof1kfoc2yCUCc+vxwrTL9ZxLraQSM2uH15o1SlyHQrfzIRxoA
         vWu0fbq5nzBrfJHff9TNms1Pcenvv4zQdrn4IJYR9qoQwuFoI3uiYgEK0iwE/gMo2Bxe
         t5kuLWueoLRoZ/leDULHtA25xr9/ZEvFOY6Vyxiy5ZACOtVhX8OxsjqUuwAr6POB2SHs
         W/Hw==
X-Forwarded-Encrypted: i=1; AL+hErFo2hiF76pGs9Px1kJn3naexe3YJWPuI+1hT8gZ/3/dxs0UXtOCZaCwVKyDoaPIXQ0gMuA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8c7jtgWqZmvLJnRXO/SfSZ+V/OqckbQXxeQNRz7K+M54n1T7L4
	iyom7xz3WA3lEChKJndoT97kVBnFmOS2yCzD1yi/B25lhGKj7iwT2LX/
X-Gm-Gg: AZFdTZd9ZF+m6dSDkGY2MhC5PX7nYCfIh2m6LM6nDhmhE2s8TIGFL98DrN2l9Ib44uF
	EnmxrOy1Eq6GTMX9J6m1WWQ/1QXLsYgtMqpE5U7sroh98U4EXslUvcc8oELCk8Idz4g1c/MFaxn
	HD2XmTHfJXMGqDe/C6c87yzmWCz6Ds1KnMMH13wadNYMjnQs74lUP6gHMfGrVG+1Rjjir/I4tN3
	dS+EpYuTyuTM9uZJLrjkfBj2hIjZ5cG87bf0nfV1g+2mZGc4PGKIYsFBbaTkLlH4Xmnp6M/i2+T
	uH1aErPtA5ri+s/9G89pdwYD4LSNG7vIusiacmspZDGqiYK26CVjuM9lbKxh9arVznvk6GoKgeV
	jouYghqJQg63z+5PeewOEy7gNCqnWa3uJ7SMQR49OX2I/mvEWLO0+hi5zLOiPd8ZInARik9my29
	xJ2j6atjvX4zB/kkbxlRtr0Du7SqdIfKUiyhzcgXY2pLT3IXxzXDM9oolmUZAngBanuuNHWUGEL
	XdQyOqNlUYPJeb84V2kovcOXPKS9KN4wUEh4Lz65UrG85Igk44oG5B/XoGELDWenvTvGOZIzPU6
	jd/DZJxL1WIF0+8IgMsgMCNgBSpi6wMN3VtAJ/1bXXIdNW7635leyiQwjkuInUGVcRDTB5xy8N5
	aDw3oHD0o8Qu0cCrt/HoiX2+xHVnHdSwIdg==
X-Received: by 2002:a17:90b:3d50:b0:3b4:d312:8fb4 with SMTP id 98e67ed59e1d1-3b4d31292ebmr10238160a91.43.1795726338554;
        Thu, 26 Nov 2026 12:52:18 -0800 (PST)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40f4312dfsm36006303a91.3.2026.11.26.12.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 12:52:18 -0800 (PST)
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
Date: Thu, 26 Nov 2026 20:52:17 +0000
Message-Id: <DN5FUYZ25YIK.1DK9UDC0VY8CZ@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kartikeya Dwivedi Kumar"
 <memxor@gmail.com>, "John Fastabend" <john.fastabend@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Bradley Morgan" <bradley.morgan@linux.dev>,
 "Paul E. McKenney" <paulmck@kernel.org>, "Frederic Weisbecker"
 <frederic@kernel.org>, "Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>,
 "Josh Triplett" <josh@joshtriplett.org>, "Boqun Feng" <boqun@kernel.org>,
 "Uladzislau Rezki" <urezki@gmail.com>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Lai Jiangshan" <jiangshanlai@gmail.com>,
 "Zqiang" <qiang.zhang@linux.dev>, "rcu@vger.kernel.org"
 <rcu@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3] bpf: Add rcu_read_unlock_special() into btf
 id deny list
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Sechang Lim" <rhkrqnwk98@gmail.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261125055359.2715140-1-rhkrqnwk98@gmail.com>
 <E03F487E-3E0D-4FE8-9BD4-F2ABAC7213B4@nvidia.com> <awcXeA5xej8w-UL7@srsys1>
In-Reply-To: <awcXeA5xej8w-UL7@srsys1>

On Wed Nov 25, 2026 at 5:14 PM UTC, Sechang Lim wrote:
> On Wed, Nov 25, 2026 at 08:18:51AM +0000, Joel Fernandes wrote:
>>
>>
>>> On Nov 25, 2026, at 12:54=E2=80=AFAM, Sechang Lim <rhkrqnwk98@gmail.com=
> wrote:
>>>
>>> The BPF trampoline takes and drops the RCU read lock itself. When the
>>> outermost rcu_read_unlock() finds ->rcu_read_unlock_special.s set, it
>>> calls rcu_read_unlock_special(). If a fentry program is attached to
>>> rcu_read_unlock_special(), the unlock on the trampoline exit path still
>>> sees .s set and calls rcu_read_unlock_special() again, which recurses
>>> until the stack overflows:
>>>
>>>  BUG: TASK stack guard page was hit at ffffc90001657ff8
>>>  ...
>>>   bpf_trampoline_6442575622+0x5e/0xac
>>>   rcu_read_unlock_special+0x5/0x490
>>>   __rcu_read_unlock+0x9c/0x120
>>>   rcu_read_unlock_migrate+0x93/0x220
>>>   bpf_trampoline_6442575622+0x5e/0xac
>>>   rcu_read_unlock_special+0x5/0x490
>>>   ...
>>
>>Can this problem not happen also if you have an RCU read-side critical se=
ction within an ftrace probe on sensitive RCU functions?
>>
>>If yes, I wonder if we need a more general fix than BPF-specific, such as=
 using notrace on the sensitive function.
>>
>
> I don't think so. ftrace, fprobe, and kprobes take ftrace_test_recursion_=
trylock(), so
> only the bpf trampoline recurses here. v1 used notrace, and Alexei
> suggested fixing it on the bpf side instead:
> https://lore.kernel.org/rcu/20261124185659.1370644-1-rhkrqnwk98@gmail.com=
/

I don't insist. Sounds like RCU folks prefer 'notrace' ?
Then pls apply v1.

pw-bot: cr
