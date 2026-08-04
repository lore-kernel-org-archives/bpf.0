Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058D242CAFB
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 20:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785875287; cv=none; b=gNM0GkQl6sxk7JAMocEtT7w6QgnVpiV4afH1sQ5f69aTiOjnRsVMy8TGvvuXwpW7r0rmtEvIRJivn8h3Oi31cn+GpsFexUNTZto7ZE6oSJul/fg+eGhAnC/wgb/SOPskARKVL4pji+fR/AQQpHvLxse9bDhF7rcKrqU73dkYVAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785875287; c=relaxed/simple;
	bh=e96XV6rpaG217foQlxVqp0eEZW8mlsHZX4N2v23tWZ0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=donYYM6fMlA3uXyP8KBkLhf/ckKenfJJUfvYyWlWu/aK+mBgG2iDQYAr3vnrJa/4Eq1x496LXTB6JWGeBeKCJhKYr/NZ7bGF1liyoDlQkE7MsmxYH91RF9G66JrKTp4AJPu77yD8gpYso17t9LGQwTVOxQiK8SnA0XU7EoUjFOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMI85nXs; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMI85nXs"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-4955674321eso411705e9.0
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 13:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785875281; x=1786480081; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e96XV6rpaG217foQlxVqp0eEZW8mlsHZX4N2v23tWZ0=;
        b=jMI85nXsEdQ+padT7Cnb+REpofCUCylDAVheBvYcx08KqSmTPFw3LF15GD5p3IpMN9
         ggTEh6UqzGZe7ma7F1tYIIqPdrldDLXhGe7TjIx3Kds2KkJpRXpQwb0GKsYIovF6rrJX
         qGeH125LudxE046gvzUU3UAKi14DC9tRJAbUlby59BctoMcHlM9CoNlj5FPKFEicIqkC
         dEZpfQNcRoW9ibjDqS3XSWLOeVI9CNB57AU8O+GXUIB8ubZOr26CLFD+qCxVuXbt2h7K
         WEwd2FL9ju4Dzv4Yj3EhxkxML5MUaSs4JQn4bSxHpF1cgwxMNR2gInhZ5IGfWwOD90ye
         KNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785875281; x=1786480081;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e96XV6rpaG217foQlxVqp0eEZW8mlsHZX4N2v23tWZ0=;
        b=VS5p7YZGgwnZR9ww4uRghi62++CPWRBce693FQleTzH4utbruwO8WRMyoAHtT+Hy4h
         tEM5Cikv3qg6BOG68K3aiwJZFP36i/1Gy2djHV09yDqrbxAxKYr31XgfgQnBNi8CciWK
         UBBHenWKcWvOv9WM53o/C2CwttaZGlpm8GfG2RVJt7MHMvyrKkVeT1gGDq6nBn3Uoni7
         nxw4a5Cf4xs3/LIw0QemwUKOWyggwpKACnjqunrDpWN+VZ+sRJjNKnHJPMs8vq8TVs3b
         AlrR8eMe24VMTeX1eeW/q5EKdjE7LgHG7XNIKjeYsK38nMozlC+ZJozmzV5/9o948aNO
         bgUA==
X-Forwarded-Encrypted: i=1; AHgh+RpeYCdoey+5OJx4+fgBptIADF68lujbd8usDAbWPutblNbw/7OR5mDtbmj3Y56vYMFsWNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyharW4UQQaMiUsBXvJaM8ZZgjBh9U9QmjlgwIJLNFUubuJQPsp
	5M3I9RziJMMQNNx3gehIlFtgvESDbcxusRHj9APAJk7jMomZGzwcW27rP5YKW4ZE
X-Gm-Gg: AR+sD10wiAC+WWDdYo6lKh9Y0A4B/RGWvwDbhnBmVeqCyFMi8QKSagxHJwuCFJ3Vu7y
	nXWquUNOn/I1Q21xrXVSm3Fs6MwsVbr4c+OYGoZ+yVBC6dYk6JmoAIyRwOnuDU1OjtImju61aOp
	4ZvAKmN2m431lf1bwnOsufpQba4nf6rDXmIteeWJsHdI+7jlUwHEcNaVFgcaOPIDDvcohGZYwaN
	3aYNcElzrI+GW6mYkHCYS1PNzG+yvyqF8NPonYhbpIH8HjzhjfjMiGpLVBuWXVE5t9pFzBFHJns
	sh03aKsE00i0c+Qk2CpmmfXT/+pAba3Pe0gHST8ANmArJkT8keRoLduX3KBV2+leR0fq1iOIKkr
	iWZs9pii1365Ceui3T0M5x4vKUINOI8BBahA8gvthIGnLQLaWFyzoLyYtfsuUMFOlXWB9JfczTB
	2ERKnREJYPmQ3+oJJPosw5LxICpDgVV2Os4IhFUP1lXsCjF3TJccVtcbv/JK34H8QUTOm+HPfjw
	nG5PlMvzzefFLaTxyPSuv2FqS8vY6GsWkTj1EGgF+piVktDloWVViJoeo/0SbslXjppKfAiMwSE
	X6z4AJU9KdCE/RgPYMmIo1taUFs=
X-Received: by 2002:a05:600c:1d10:b0:495:7a23:1eee with SMTP id 5b1f17b1804b1-4994e7ba86amr9012485e9.12.1785875281141;
        Tue, 04 Aug 2026 13:28:01 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec232328sm3053933f8f.24.2026.08.04.13.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 13:28:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Aug 2026 22:28:00 +0200
Message-Id: <DKGFY9Q5M8NG.1OR49ZSZI3VCZ@gmail.com>
Cc: "Tejun Heo" <tj@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 5/9] selftests/bpf: Add kfunc __arena and
 __arena_nullable argument tests
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260803125115.2264733-1-memxor@gmail.com>
 <20260803125115.2264733-6-memxor@gmail.com>
 <7f0d996cbfb2703450b9974d18c9f60ac2a3a959.camel@gmail.com>
 <DKGFO6NR1WR4.JUGJA7Q941BU@gmail.com>
 <4d3b9137362fd9151ecdaf29d863a6cc0b0799d1.camel@gmail.com>
 <9552fc68c2d06c5dd88bb7494b4934e779bc45c6.camel@gmail.com>
In-Reply-To: <9552fc68c2d06c5dd88bb7494b4934e779bc45c6.camel@gmail.com>

On Tue Aug 4, 2026 at 10:26 PM CEST, Eduard Zingerman wrote:
> On Tue, 2026-08-04 at 13:24 -0700, Eduard Zingerman wrote:
>> On Tue, 2026-08-04 at 22:14 +0200, Kumar Kartikeya Dwivedi wrote:
>>
>> ...
>>
>> > > Which leads to several conclusions:
>> > > - We should reach a consensus regarding KF_ARENA* usage, as these
>> > > =C2=A0 kfuncs would clearly benefit from having __arena annotations =
on
>> > > =C2=A0 parameters (on the BPF side, on the host side these should be
>> > > =C2=A0 declared as plain pointers).
>> >
>> > Yes, but even if we do, for the time begin, we won't have support for
>> > automatically emitting it until resolve_btfids changes are done. That =
said, I
>> > can manually add the annotation for now.
>>
>> We can fast-track resolve_btfids.
>>
>> > > - In patch #1, it appears that there is no need to allow PTR_TO_AREN=
A
>> > > =C2=A0 for parameters passed to such a function. At-least I don't se=
e a C
>> > > =C2=A0 code not involving manual casts that would require such suppo=
rt.
>> >
>> > This one I don't understand. Why wouldn't we get PTR_TO_ARENA typed pa=
ramters as
>> > arguments?
>>
>> `(u64 *)val` is translated as an address space cast instruction.
>> This instruction yields PTR_TO_ARENA. Except for explicit casts,
>> how else can you pass PTR_TO_ARENA to such a function?
>
> For example, `foo->ptr` yields a scalar from the verifier point of view.
>

Sure, but I don't think we should reject the case where someone does explic=
it
cast. See e.g. the global function __arena tag, which also accepts both cas=
es.

>>
>> ...

