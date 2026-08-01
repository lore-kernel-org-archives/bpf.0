Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19383B5F5D
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785605893; cv=none; b=EzJMF4TNweAviGKbNcgSHgUmtB0uNTXMPuapQFGt3llWuqsoGWRZP6rKOi7XffTqea+bzRsCKo3FpiaRhyL/zLJ5uJGT90K3F6UoyOzmbsDtBqtORPjr4YCg2dlARlq+PawU4mKrw8Z0eA3NuPWNlrVZqk9/ypkhSqzp4irA41I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785605893; c=relaxed/simple;
	bh=h1I5cBGaL4NNtruvUDMk6k72yunOA/sUN+iC6Di/G7Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UcogRpAFgLsVRwMRVXyLs1Lo86914tEPHAb4faxvqVV47UQEEpnj++3EOS0tfTMmb2DFCDxUe+AVRLIkAWE5e9C0S4H7It1sAQ1NoOTz/xi1KS4hWbJEABQRQprVwRjT9vn6TV8ruaJUZhHfbdt/ya8j0eBEC4IioDPi+c7Rbws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGgsdVI6; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGgsdVI6"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47f9c6bc99eso646732f8f.0
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 10:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785605890; x=1786210690; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3nDM0mc96Bzr18k4xoBHNsXxvKjDpatYOwOhRrLaoyo=;
        b=mGgsdVI6YR+M1FrcqYnt02Rc/Y6TDJiSbOtcpg9qQhYb3gX3LcDq7b50KPjgOXraAq
         cCtEJQhPKQsAOdEHqUTajSXGtrUsGOH7TY5ZpDwezW4+utkwxAXSs/ATE0x3BFIKs/ar
         JoCbExesPFxGzYMprEhIw91wrN6PNauKjXXGDdYT1oPGOJ2SnzWqaojmns3DQunFOcca
         /SQlzIKrgGm/9pchfYIChDj1KRS0PbksPIHmAMMzw/RGxfqyiGh1qRhG7T3bRIXVCmsd
         wlso9lP0WFhVUh4i1WeVluz/kJgs/NU3YGDlK7iIKff8nUa74XCBWUjkJtR5Mufv0sOW
         ZANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785605890; x=1786210690;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3nDM0mc96Bzr18k4xoBHNsXxvKjDpatYOwOhRrLaoyo=;
        b=W29iMFidMrVVh8r8dlCuca6t2pM4NjS59hqCiCYcSVGMvmBKS2cnC5tppPBP+iX60T
         PnjIgyiTi+yOuD260Rc7tomQawXhd8mO5yPqvooMct6tZ//8Z8mL1Wwiu8Vk1XWMtg+b
         +EnP6EYKYW9b3P1Bd5VfZIr46ZMPEfRqWU9e+F61mKVemjyJRXivaA6XREQ2OsGgByqo
         FBb+NRnMZuTEzz1J91KlrkI19R+kaWsibQ8URsTFgiqQeuOSxqyIiwT6oq9V1YLc8Tyr
         fgFccc+llP7tAgPGFoVbVAzpMsupS6GiNzLMycfXvEjjE2Z5E1vZQgjlI2h8XZLt/+Px
         QYZw==
X-Forwarded-Encrypted: i=1; AHgh+RrAaudgWV7dyiFvplDlkWOHQqcY2SQuGr9LoSE5Ah8j/gIhjvujXlnYENQMrZsSmfOZ4NA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1dXAyQEjiPFMtxP10/17pQISADLwyf16Vq0NpcpKT0fY9Fcgb
	iunTnihIq0u7e3D0hKwPkty8PGW9CB4P8iyjomhkJuempHZFfwl45wOV
X-Gm-Gg: AR+sD10dKlJPnoq+zCCFmTkrKXjaP/QrJqH/MlbhYZiskkZi+NLTzND4/sVqqby2TsE
	SylXBFpkECd7CmRu1TB44LqADtW37WH0rWZQqXuaU5AVZq4QuR+LlaSvJ0qo/BSI+ne7ZN3/mbd
	l/CsoIl1mEYItBwmqJ3SUkh96lafagCqbhBMqdBdg3bymONRcQIATxNQjYsQbyOrcHTUU1pjrSD
	gu+zreeEN88cnQIKtzx13MQLJzzamlbH0MB93P+hMisP5o7Sw0Jsfe2K4IOENkgz20mv2aEY+4K
	U/nX+hydulySxS8Nf9m5dBJTMWOh2+66Ca6IW5o48oRvDKsZ5QxVEB308aQXNPQsFIHEmBl15MA
	7XxymIEUURHoJkPnqF9+J2M01IqdCT8HiUow/53HYaKCz8iH+h2KdgAlIlo0n/VriVAo5eCy5O7
	HDiA1N1gTRaPjYXPsOmRXd9CvoVVbwxnQsuRETdIDiuxL6gyrWbAHWvn9j0hDh/RK2ITEJoOleO
	tyGUZPKU+apwBbIVTfOk8S2NOjw7SvebFbxCV87JYraqq96edoZrnap+2KZAA5kZDwXAJJW0Cl8
	vrSgom5tOHIqv62vDkKWldUmJ20=
X-Received: by 2002:a5d:4acf:0:b0:47d:f441:5f93 with SMTP id ffacd0b85a97d-47fd72c560bmr6890615f8f.25.1785605889988;
        Sat, 01 Aug 2026 10:38:09 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d17f2sm20504660f8f.2.2026.08.01.10.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 10:38:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Aug 2026 19:38:08 +0200
Message-Id: <DKDSGKU7WKI2.3UV1GEZW2VZWY@gmail.com>
Cc: <fsverity@lists.linux.dev>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Martin KaFai
 Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Jiri
 Olsa" <jolsa@kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] fsverity: Fix bpf_get_fsverity_digest() dynptr
 assumptions
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Eric Biggers" <ebiggers@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260731003925.2728977-1-ebiggers@kernel.org>
 <DKDRHTVNMQ2E.1FCTWQZO2EB7Z@gmail.com> <20260801171549.GB3567@quark>
 <DKDSE8AVM7Q3.3KZHCSNL4NT4L@gmail.com>
In-Reply-To: <DKDSE8AVM7Q3.3KZHCSNL4NT4L@gmail.com>

On Sat Aug 1, 2026 at 7:35 PM CEST, Kumar Kartikeya Dwivedi wrote:
> On Sat Aug 1, 2026 at 7:15 PM CEST, Eric Biggers wrote:
>> On Sat, Aug 01, 2026 at 06:52:45PM +0200, Kumar Kartikeya Dwivedi wrote:
>>> > Also correctly handle sizes over INT_MAX, which previously caused an
>>> > integer overflow and crash.  __bpf_dynptr_size() returns a u64.
>>> >
>>>
>>> I guess this occurs when using file dynptrs? Otherwise the size is capp=
ed to
>>> DYNPTR_SIZE_MASK.
>>
>> Yes, though it looks like __bpf_dynptr_data_rw() excludes file dynptrs.
>> So this particular issue might be unreachable.  Still seems like a good
>> idea to match the u64 type that __bpf_dynptr_size() returns though.
>>
>
> I don't see this in patchwork, so you might have to resend this with [PAT=
CH
> bpf-next] subject again to trigger CI if you want this to go through bpf =
tree.
>

Sorry, [PATCH bpf], rather.

>> - Eric

