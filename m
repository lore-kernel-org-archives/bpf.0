Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59BE25B663
	for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777228933; cv=none; b=mg1fE+D+ahjSQV9E+Bem3Z94s9hkpotnvwqBt3W6WzE3TCkNzK9IV4PPPChx/wMBDZxFNWMyPEK31uGHxaZuUJH2pL9siS5vkptyi7sYJlk0DF9bxhFRfN2J/96qezpW5edPpNVjFu/kCqw37Bc3KiJjxslpmZCAFkqAeLpOkOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777228933; c=relaxed/simple;
	bh=0SWFefRQp7XON6acs4hT+E7mX8XaxU7C/WHwtWtI5lk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BMP2NnW9M0O8H7vizFzsYBKmV66T1wlOv8B7o6xmHXMFZOlU+WbT4rWKOcN4+k2Kldo8ZfBVaVcdbrPe2sZM+iafkC3AfWZhcvIJkBux3Y7QJ+6OolOVCI5d9tvSq0CJSC24FYR6f1q+KtoCbBOyNzvlTdeq6JinNXohPRp4ux8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOEXM7cV; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOEXM7cV"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d4be94eeacso9893776a34.2
        for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 11:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777228931; x=1777833731; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ktuf9HdbYnfuI6ARz16asO3pxbeGnkMlqXfFCrz8E0A=;
        b=fOEXM7cViWSNaVP1t5anDF+F2wcxhHJC3AyEVVInKg9IUSJlKIHbwjsyGI4Wd+0vU4
         9qQC6kZAUZFPdPj7Gx5kG7ayRvSCeAvXivCSxwLvDZP8OG3JsSrAwE6Ou/Ix95XNBQ1b
         MwRcTxrqYK2JTVlwhV4c9dvPo1jM4X8XNCwnJBzkZjfO/jiKSIWInlkXd/jlhr3p+bza
         x1yjnzsiEVk5QBrQk4+J7Pu6rkRfvM2etoxEIfVPyhjtvPPMLLhQEQ/VIkzwesT015uv
         hOQ9Srr7hlEon6Kebd3GQX6ttGp5y96k4Kc91RqnqAL39HHUK3kQIkuoGMVUS3QReNYv
         CV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777228931; x=1777833731;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ktuf9HdbYnfuI6ARz16asO3pxbeGnkMlqXfFCrz8E0A=;
        b=YOy8geGSUu3PwNTRlWI3qaM/pgI7EmaLasnnWJHmyG8avmQHm6CXju22aOpBoDXzNM
         C04343WGbQEU8m1mkcCewWuBBkGQNRe+W26vzJXyZu1v0DTZHcUT0k8qiwJ2hyRLI3u7
         9DJ8m3xEdUNM1nQojEUDqAXItuyQ8UfUnn1zEAy/N0FS/dkym1+PoCk8Cxirj36YDWIS
         5OMt+2ASepfrWIeq4lpV6/Ax808qgKnSneHz3Xs+EzyomK7TBbIfPNNT8htnfddoOOfa
         xMxfbz5EjIynC/pp1l/YTpeytW5mkSU8YrLU/ANL+H5MzjDz0JSwsRirAkw2bU+s1i8M
         l8xQ==
X-Gm-Message-State: AOJu0YzJlvIJuPHO5CLii5Fr2OdD7+EkKX1snfEPdpQmv3GaHhgcxMFn
	Ea2rIgw4MOfNMfUS3e3D5Jfqff8pMt779fWI35IVRMCtKyOYXj0u7cqg
X-Gm-Gg: AeBDieulmx0fzShvp5q1QIIzNKZ4isNuOQ1I3Qg+4dG/yW2u5+q/7cCCW6NjQz33DAX
	A/SU4RrYiVUqDSOtj0iO059HiMQos59aETb/g1CZpEpt4xrkxmZWmEvHo2hPwpbjcxboKCtobJD
	fm1NcmQd31eI/2foPVbibQmPsCibV+ERZUaus6b+smfge9MmkLcLMjFxybGEbEWWonHaAJ+cpj0
	uDNr77WfjYgjpokE69D05BJJY90eEO5HCuTtH4hkh+FbzZQ1Jv0nWeAIBGWH9CQ0z4Z3+/o5Xtl
	V2mpfAKVZKbYL6yjkNUOvtV5/cZEwWiCqiycZBXHruVG31XjcwankJdwnt9WveUuGmiVRU3nR3X
	jtAB6uUSyMeaTkzUgMFbkoWZz4rWZHIYWIBqJJVdi5vgvuzlY1aXllSYnF2ILCORGQQ9xX0Egms
	xURlJp7ZwsA9neO8Cwx5bWqXNED5DT2vwKn5Cxt0HmZLgfYzlsx7C2O4CIn+jieee1XRqmyobml
	oCW3Her9MEoR78hPAqVXASCZHeUnog03IH3PA==
X-Received: by 2002:a05:6830:67e8:b0:7dc:d7e8:cb30 with SMTP id 46e09a7af769-7dcd7e8d77emr15224062a34.26.1777228930809;
        Sun, 26 Apr 2026 11:42:10 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:7::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcdbef352bsm14589116a34.10.2026.04.26.11.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2026 11:42:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 26 Apr 2026 11:42:09 -0700
Message-Id: <DI3B2QZ8TA16.V0ZDKK2KS7MB@gmail.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <memxor@gmail.com>, <daniel@iogearbox.net>, <eddyz87@gmail.com>,
 <song@kernel.org>
Subject: Re: [PATCH bpf-next v8 2/8] selftests/bpf: Add basic libarena
 scaffolding
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Matt Bobrowski" <mattbobrowski@google.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
X-Mailer: aerc
References: <20260421165037.4736-1-emil@etsalapatis.com>
 <20260421165037.4736-3-emil@etsalapatis.com> <aenXSvDSN98azW_T@google.com>
In-Reply-To: <aenXSvDSN98azW_T@google.com>

On Thu Apr 23, 2026 at 1:24 AM PDT, Matt Bobrowski wrote:
>> +
>> +int arena_fls(__u64 word)
>> +{
>> +	unsigned int num =3D 0;
>> +
>> +	if (!word)
>> +		return 0;
>> +
>> +	if (word & 0xffffffff00000000ULL) {
>> +		num +=3D 32;
>> +		word >>=3D 32;
>> +	}
>> +
>> +	if (word & 0xffff0000) {
>> +		num +=3D 16;
>> +		word >>=3D 16;
>> +	}
>> +
>> +	if (word & 0xff00) {
>> +		num +=3D 8;
>> +		word >>=3D 8;
>> +	}
>> +
>> +	if (word & 0xf0) {
>> +		num +=3D 4;
>> +		word >>=3D 4;
>> +	}
>> +
>> +	if (word & 0xc) {
>> +		num +=3D 2;
>> +		word >>=3D 2;
>> +	}
>> +
>> +	if (word & 0x2)
>> +		num +=3D 1;
>> +
>> +	return num + 1;
>> +}
>
> What's your reason for not using something like __builtin_clzll()
> instead here, for example:
>
> int arena_fls(u64 word)
> {
> 	if (!word)
> 		return 0;
>
> 	return 64 - __builtin_clzll(word);
> }

Great suggestion. If it works, let's adopt __builtin_*
