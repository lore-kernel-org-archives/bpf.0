Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793136199;
	b=MvUTXhcALPUk6B+mYOXEv37tsbkWXHKA53V52vheznoIvhuRqINd4R5Lboce8Z0V5x0Y
	 l56Ooyj1DWSeeJrUqUu22HzeUT4A72t/lwG2bZN8WzX9kl8fWmY2vJA7bPyN2SMbe5HoH
	 73e36DwrW+KgJJ7Xeypq5ya4J/IYQLdNVrG1XgIS6mT8pqtj6ln6hkoiSr+S581JmnUks
	 2mFKf2lWeBib8shfMuhzvN3LcSifK6HgFEJE+kwx88hZTgq+lAwSEoEQwBc7rmTQjTLQs
	 kROciaVOsUG9QmsLrvY1nE5+JMLeQtHlWEyq4cqr9UmsO6OdlUnKdJuk7Ry4HHW1baA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793136199;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=9idYOTdTg5vvYVxzKaK7W1ipap2GkVgprvezV8xbRsw=;
	b=hcJ2TKW/ZvvFe2PulpYAKn/NM9a6HgYuPX1bV7/i/i1r3kq7dMcjhY0rTYo/Aq1oRzv6
	 Pz/lOzABwFb1cdLdqQ1Ara+EJORQkbAgfvol7gqaaKLOo5TeH2y1kF1q6X7L3tLZbaMjR
	 h8gUzRzls3N/kXal9/wg5+PFgi9A1WrNWDow+cmX2AlZ1S0D18Gwu3a7ZQLhb/GJmwgNn
	 dk29wtL6DHw048r8fLni1iyYTDxa9efN6YcCcU//pvYf83/1MGNYMlFDraXPGcgecB56+
	 cQvVIZaKcP02DdlrsEVorwVUMKF9ebBFUuTXRzj4riI/4R2H3eLXGN+PfM8zloPxxXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pds1exdX;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC55606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 21:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AC55606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pds1exdX
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ea1e7fad99so1509775ad.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 14:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793136198; x=1793740998; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9idYOTdTg5vvYVxzKaK7W1ipap2GkVgprvezV8xbRsw=;
        b=pds1exdXG3JpU2wrZG5soKLXT18XBUsVHcjDnWlbiqnmjv2OGmpgVMO69A4bglBNnY
         m0Q1a5pf+smKZXZbZynYlX6PJvZKcL6jzl6cpTiTQjAXMu7peQwiIWH+RfP1CHbmQSID
         2dYUPEgzHbVPn/VZGs2L4wGPeDTP/mYlpN11j1MYPVP4Z/WeG4K1uXP6lW36sC7ORdUe
         YLKb5wTesNvaDFR0QT2In3vXaIMNjt0ipqSIyEKCh0DH/iLuTDlc2AaqFf92D6KS8kcs
         cpSSkAXsr95XlEwy0PbDT1G1XRI7gQrT3m/7bozkScQvIm7zXKfe3DSPPnckXU4RZ5OC
         0/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793136198; x=1793740998;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9idYOTdTg5vvYVxzKaK7W1ipap2GkVgprvezV8xbRsw=;
        b=I23np2hqJJXBg2WmJ2iIW5H6KyJOVNAaHmex0gNb9XQT6n9D3UoasxX3kBOX/HH7/v
         FjLzMdwO7gMv1Kp+g94uiEGg4Z7IfmWFVHGM5B6Gcp8TddGQ91JWWkeSqgujWN+sqiq+
         9x8kmlMay+jeuMuN9LK5C/A5qo9+pJQgEfSoCu1utqmPEsKef5qSosgddyN7V0vKWIZc
         H5/0AQNNzylJDHkeVbOtAl1iuS4OgIDnbnJE8e+fpvEGUqqKAxYChHpiX5o557IfacJM
         VkWxI9NwtpI1RvrOXSYzY8CiLUGaFHnQPxzBKt241wMlZ1oVjPWfyu3EPASiOv/ro4o7
         p8xw==
X-Forwarded-Encrypted: i=1; AKwUvByd2Eqh+P8X7F9f9cTh4Lbnt1ahd2hsmeQh8XivtMlr1GkSBg8fUXQ5U52rqKLDWy31jtQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ65yYTAsqnEIxf/hLEzUmOoBOw0bSeikUQ/HcCMaKVI8eW7eBX
	e0aN8OWO01FFJ/h/C4/DWBNfUiyw2wskB3CM8GC78uuepUqHl/kOJaAb
X-Gm-Gg: AYBFou3GuH9lLHzkVoUwyrL1fDGP2xwFom2cm/9/HezDekY65i1D6QIoqvLSFgNgy5j
	URTr9c5CXA3sS3hf776avo7UZOJQ3rhLEZXVYsDGGJbquCZ9pod6WOG9g44pJ4XKo4Q+vTLutDd
	fF8Bsssmjt8hjKfE129R/yAaxBzwVwGcvxq4EOcZFIcSe9prKMcP1rFasLgXJPmvuNifsKDXsOw
	NTchXq1AcnndNGlN9fGPp61KxUw5XzgWfOUnioy4zqgdhzaPBrCV5PSc+R+Sae9drP0IaO3tf+p
	03LHipHYvsF8Eegmk4OF7J0hI6lfbYUgkSxXdXQwirM0r6WYdC7wiFv0gGLQYlp1+8QIqL2ZrZ8
	0A6RNniREKLj6qN36pCySBbwOQ75LXKZcMkDbjNIlAq7wqdMIVnn6meV7n44CeLQS1htSUlHMjT
	46uDjm71YlYkzXIImzTulTElEa2hq1qNagEJKRUJdJ9cAlEHVOOv09tPKov5IeHup85IOxMLhZU
	ElUvYCoVPO2lup0rgoNHnsOJVLj4Izg+ii1aIAQCGmATh5IeeUJlHOF7VqOW4F49LWal7v9iXQ8
	Z4TghoqaFrdeG6DSGQLJ1f8jXS/hWytDXpFAOfmHKOxv4z6oWvTzmg7Xjjx7
X-Received: by 2002:a17:902:d581:b0:2e9:7ff5:5462 with SMTP id d9443c01a7336-2eb003e17d2mr4788335ad.22.1793136198193;
        Tue, 27 Oct 2026 14:23:18 -0700 (PDT)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6454a37sm14856625ad.3.2026.10.27.14.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 14:23:17 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Oct 2026 21:23:17 +0000
Message-Id: <DMFXQCZ2UNDT.MWVC9S7KIDKT@gmail.com>
Subject: Re: [PATCH bpf 09/81] bpf: Clear delta of a register that scalar
 evolution widens
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Daniel Borkmann" <daniel@iogearbox.net>, <bpf@vger.kernel.org>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>
In-Reply-To: <c750f9be-f62a-49e4-8816-080601f7c192@iogearbox.net>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com> <20261026025943.404450-10-alexei.starovoitov@gmail.com> <c750f9be-f62a-49e4-8816-080601f7c192@iogearbox.net>
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

On Mon, Oct 26, 2026 at 01:09 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>   	case SCALAR_VALUE:
>>   		reg->id = 0;
>> +		reg->delta = 0;
>
> small nit when you respin for bpf tree: clear_scalar_id

fyi. this is done in v2
