Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.68
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795468734;
	b=IeKudw+0uHtJoz9TdTEXMRQUgsFwZoq/VEjkNBajcb1D/k+My2WT+DwyUn9JWAckd4QC
	 L37jkUt0eGw9P/2bsQoNmkIyXGrKumRFOngPBcNlA0iYwUqPD7WJtGzICFPugzhKqm0ep
	 mrJQGamJIqIbappQ0dgMEn+PQJHGqAzEW25OcqmFogFFHADxBerjp3IRcv006B4bqTF9/
	 ixsxvLxDfdCAYE7keeFRgR0XPUm6kUKJbjt1ubNhsM4Zz6KYZRQ3IwADBv5FaFfjdQRkH
	 5/dNCzXb+PTsng5mLHmmUb2HtTjK7M//hZZrCRjX6wjMaA7dYV9oOq9KTLb/Lm88Jgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795468734;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:To:Cc:Subject:
	 From:X-Mailer:References:In-Reply-To;
	bh=UdbWtdWbnHAnBe9m59yDmsAfmbDCGbDO/F2rxx+Kr/w=;
	b=eGraHfUE4A8xmamsO3B8nl2fO7XF9H9xUqt5FCrTi1o06eanEdMDF8MtVI23Kw8Nttun
	 Mt0wEvjEvJ/GL9eumQajuL4bue5e9yn0gpER4sAyJPkukfNT0W/ScNRotiwO1j0lvMpvM
	 KQYJuC7mohiFNh6UYGuG7BLD6Hw933q1eMcW+b31DcY41Tbfym9zHPXbQYAPeggNcvQ/r
	 fPfXS7akr5hJvjYFOwLH/Pgnq+J6LPoYvHBcunhGnJV5yM7d9xipgNT030cvSSQxLoeTH
	 F1zDW69uABQ2s/KlYAtEMUz49Bo3ViZeLqdsZZs0+72crQxg1SqUJS4aIanyvmiHbJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MQBhbA9a;
	arc=none smtp.remote-ip=209.85.210.68
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C6A606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 21:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41C6A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MQBhbA9a
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-86288992de5so2906953a34.1
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 13:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795468732; x=1796073532; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UdbWtdWbnHAnBe9m59yDmsAfmbDCGbDO/F2rxx+Kr/w=;
        b=MQBhbA9abCEm2W4n2Sav0twyTWtHL9dlzCuGMe+dGXr+Bmgsqse/NRFIyOVfR6kdc4
         UX5Vlwam3jCbCoRj3cJmsGOZzo9BU8ufbFW+1KzByk1lTtB6Lu8kgr6C2z6452t4fG18
         SnRWJUAMIpb8EuBZxehw6staapYIft8RHTa50htw8vH/dTmOhZDUlI7Hc2e7BQjEM6Fb
         Q8IhVefAvcdWnpYWzYomK1MWevYD6eIHXQnODB39jOrXmnT77+/SyIMNi/1qHwME2J5Z
         HkR4ho/r/3wjX6fZPuCOxcVdG25oAMq8Iiuvw2lACgNuqpxPZ+SEjg/LiAMsUMVs/7UY
         tZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795468732; x=1796073532;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UdbWtdWbnHAnBe9m59yDmsAfmbDCGbDO/F2rxx+Kr/w=;
        b=G48WWolbAwW/m9hiqwg25YiiocggxInCn8CNp3EUDMPut8PZzm0Km5fdW5Wr2EgC4E
         g/XNuiuplP/XEZo22l3wnh7sOnW2k8IwuHdlVidXVV7gwC3X6c/AEnGxsYb/X68bwOKw
         gUCo9cztQ5hUS/DGRwgATjwX+QUjJZF9JaDv6nAIIb3sPavE00mWsk2mqoCTvJ4Ajhp3
         qJpAOR9OTLZgfzXxPt3BV3Ay0BN4k7AzPE2YcUyi3KzOktPoxrqR4xw8P4rbr7FNmzQD
         nEl3+GvvxYaoCv6A+360/7bRmPlggeJvUlTKBgDzDrqnnf2M+lj0gtDwTQ6J7RySP66A
         Silg==
X-Gm-Message-State: APuU4Z8qO4j9MjyJk1/cynHt04LD5o1mqOGTgYIgQEnkb/0/YwSMN6Gv
	Fi6/iWELqhk1PWcazumRLrQ+H2EIToYAgskmfZmnOueP6IoQ467HMeiJ
X-Gm-Gg: AZFdTZd9fam/h56ekDC8SMggMDfo/n7CpGROkdCbRUjuH5Mt2YKL3wwBvzLvtowoOqq
	tQ7SeWIMGKbBueX5ajwso4TAMUuDt163KN5WCPWjhimUEeqZIE8+aAc/B9PFTSI4y7B+ZGZGGNF
	7x/yHeDNf4c3zzDstJtWgtFZ7KERnfQmtu6Lyt9UtI3UZepuOISclYfUhfgdec4cmsz7BNF9Vbi
	bnH02V1o4R9iGimwdAKW0O/atQVvugfmPaxoI6s2Ov1aDbJqPsUnsQww0Qyv+1ZVj5DBvD5GSIm
	JKNMs/hcE6n8czLOx3nF8EQB74uUgvQaTD7+BHkX5LF9jqxhdlz8f7sR/9AISQl/LdDUZY/oRcJ
	zeGZGysbJfckUVSj760VurqeZ0f7ZzdGflUHMlO4nO340Ly0nQJXWv81k+bkYgT28H2cx+2GV0q
	96qLRBNBUleM0diaHGzusoa/rtfX/MWjVDAomnuhO7VmKxxpko6yClzCbT0r2RrUkXqWFr/DgFe
	UpBUhJNAC3WDv1phJFCmUSmRg7BxDwLuz0t31PUl8TrqIeSeK3UyM2QXCTl9LedYJCuIl4Oip/8
	M2BiZnytfkD5M5kGyM3sK83W9lR8jWxSeXoDBnCAo1/M/hrefZmDiBXLo3nxwP6S1agowoy1OdL
	ZzZ/N6G/zqtg1fuklDLk1u9RTA/88vSmgbMM=
X-Received: by 2002:a05:6830:82ee:b0:85b:895:a015 with SMTP id 46e09a7af769-86309065b5amr10471283a34.4.1795468732137;
        Mon, 23 Nov 2026 13:18:52 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8631692d9f7sm9734033a34.24.2026.11.23.13.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 13:18:51 -0800 (PST)
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
Date: Mon, 23 Nov 2026 22:18:48 +0100
Message-Id: <DN2WJMWD5G0R.27OOI2IBOXA6M@gmail.com>
To: "Tamir Duberstein" <tamird@kernel.org>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>,
 "Andrea Righi" <arighi@nvidia.com>, "Xu Kuohai" <xukuohai@huawei.com>,
 "Andrea Righi" <andrea.righi@canonical.com>, "Bing-Jhong Billy Jheng"
 <billy@starlabs.sg>, "David Vernet" <void@manifault.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Andrew Werner" <awerner32@gmail.com>, "Zvi
 Effron" <zeffron@riotgames.com>, "Andrii Nakryiko" <andriin@fb.com>
Subject: Re: [PATCH bpf-next v3 4/8] libbpf: ringbuf: Add a caller-owned
 iterator
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.22.0
References: <20261120-bpf-ringbuf-fixes-v3-0-ff7ca15d6c37@kernel.org>
 <20261120-bpf-ringbuf-fixes-v3-4-ff7ca15d6c37@kernel.org>
In-Reply-To: <20261120-bpf-ringbuf-fixes-v3-4-ff7ca15d6c37@kernel.org>

On Fri Nov 20, 2026 at 9:33 PM CET, Tamir Duberstein wrote:
> Ring buffer records are exposed only through callbacks. Callers that
> need to stop at an operation-specific condition have no non-error way to
> end consumption early.
>
> Add a caller-owned iterator that returns borrowed records one at a time.
> Each next call ends the borrow and can publish consumed records before
> inspecting another one, allowing callers to batch consumer updates.
> Implement callback consumption on the same internal iterator core so
> both paths share the record traversal and publication protocol. Allow
> iterator-only rings to omit the setup callback.
>
> Preserve callback validation, so callback-based consumption of an
> iterator-only ring still returns -EINVAL. Keep the consumer-publication
> barrier on early destruction, including bounded and callback-error
> returns.
>
> Keep overwrite maps out of the public iterator; handling a stale
> consumer position requires a separate resynchronization protocol.
> Require iterator users to observe exhaustion before waiting for another
> readiness notification.
>
> Signed-off-by: Tamir Duberstein <tamird@kernel.org>
> ---

Hi Tamir,
I had a similar patch set in flight, to ressurect your older changes (which
explains why I sent out some your fixes which were landable).

We can compare notes on the API design and decide on the path forward here.
Feel free to provide feedback on [0], I have put you in the Cc list.

Thanks.

  [0]: https://lore.kernel.org/bpf/cover.1795467315.git.memxor@gmail.com

> [...]
