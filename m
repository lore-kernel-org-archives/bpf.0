Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638598;
	b=kpsrN2mPs7z2VChlW7ZT4X5DCikTOUYkb+mtrqy/K+sb+cBb+VTNLgFXiGgovXqFZ/kg
	 a+KTu6hodZh8iC4RPxnqU0DkEhOlJl2i88SS8UJ62Gdc+ikKKglzKFuFJN9Fziy5HTZHx
	 2APs8WP9Nu8hPaExsE9iBmqcc3N1XiTW2ds3biHjC59vm8avHJ5th6E6q2PgQCQhD2zXy
	 lqRpfZIUp0C8MUbGY+zUGyBDiJfrTI6uTQYi5nm2FklzYvbrPHU6nUWISVkJ3EhVgxfdJ
	 ffMiQv3ManT08xk0mHNb1sBtwBWMumU5CjcCzDA7eRACdkcWz6QHQ7Qpqqwl3Hizw7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=fwjIWZZN+Xku/wuznq5Djc9dY6oT6GSmRAkG+xrsrHw=;
	b=nnKoYLS72lwXPfTn2XuRNuGyz0vj4P2Quc67gFla/QQUT4um2+mG2oe6RTm7HTOGtwK/
	 MT3vMgqegx1YF7EaSANxLsjZPxzOOGJCaRtPUxJ1bAuk6qTRCDGTFvvgN1eL0r9lhA1ai
	 TSDDfsE0Y2FIldzYcyOGs/GuDu2WZq7SmPeXo4CnxE+usGoz6A2iegDNSMBJ/Dmj83P3M
	 ofoMjcEEjlAS+2fbaz67Qnw1i/8N1RRUCgvTiGQx1i0ULn/LKjQjAajUvuBSfV7p4078z
	 N8ErdMoBlQaZCPm2ozF1y4ElE3Fbqo7bcN4UCD3ZWxYAUtJMOTCM44ewsuZynudOahQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gQPBCdN0;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B50606A582
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 16:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83B50606A582
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gQPBCdN0
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a05effaf8dso1836204b3a.2
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 08:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793638598; x=1794243398; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fwjIWZZN+Xku/wuznq5Djc9dY6oT6GSmRAkG+xrsrHw=;
        b=gQPBCdN0ky7g6NTtQ3EStf4AoqYXYe0mvkYYWBdgWkEBAAYnEd9QMLgNWRc9w4B4U0
         K3raciejRcckVb6b/RpzthiCzmLRJPgBw7TcktVk1pzWCQYoHoTFP6nE32OkMzCJ6vW/
         40PmJnMenMr3LD94LFviVg89uX0p51VSaHPXIOA9k+T7X9D+DaMg7AbPXuBp6WJDlUxx
         1YjjOmDZ9I6qjaONDe7tdvrT0hRKbXGDb+zzYzRXvjGX5swDjiMeMJULBwNkBlGdL7qi
         BHpTjztF2qgxLxOz1bO1pctvkcD/mXDaRcY9CBbEl3Kc8iSMMjDo+q7At8EfFywjycZ7
         PJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793638598; x=1794243398;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fwjIWZZN+Xku/wuznq5Djc9dY6oT6GSmRAkG+xrsrHw=;
        b=Egjkw2YkhhsLwo+M1Zm9DHoBD/CssztupVIRbHcUVEgkjQ/+nyjJODDxWsuSzs2woK
         RUGN9OI+Gop1iyPN0WSGRb9TIkXlVIRL8gfcq7K/NsLJLny9FARMSCHY78crcZy+JnyI
         /vHw72llFck3ZexTtENFGewh1UcarPxjehR2Lj3pASnEnTgXCaSx7p0ekR+rAGe3lpQh
         bwAsaV+XKzDPSzP3DpbYb0dUUYW7iyOMCIhBj8OWAwi2qAEiExA9P6KCnrF4qQMyNnfW
         tQyQnQir6zPZeYhNOV1j3EPvZnV56f9SeWLQiheIQ8NrICxcw73jHs8NUsqcTZkfzyXB
         MUcA==
X-Forwarded-Encrypted: i=1; AKwUvBw2dVmx71sQDkan8wEZ3V7xm6EKPcgz3qYLvIZ7qBCRnfkronhSfai+6pcZuxmHnHX8qYE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLH4t87/7YjYHtv6SmFiILOBV1hOuNjFZI/rRtaPO/BnK6tPihA
	tuFEQ0NDLKuqzDKIts3ucrrwqzib3k1X7R6qcZSakYK16lNa3gWan5Rx
X-Gm-Gg: AYBFou3qm5BTIykf3jmWQ+dAT0MwNQiicPI0A4iKRWBoPqMMOVBrG34qIF5gvZRVJdF
	KzA3N7MghrQpqmlCmZsR4Cz1skSKp1Dbn3053HaWN4TPsWgDFyP28XO2o+pKqycnMi5sn7Mzb2J
	bvAUyLhjfOtTWSZuxOo1EvfJuUZAOFOXD77PdSdBLEq7M+ht466z78MKHhA+oupCPT0gemNM6EL
	Z7SHgg6vIGdIM8A3194qkaEoatJrAFX2IbLCarjiMg+CdKYFd9GYobNpFuyIkb/pUNPuF2iSG7C
	lxDjNlokmzLnOaC5de9Y8ajNl2rI83fe+w+ck0Fkn+Dw3hPJ1PtgeVvLHQcg2rwCtnovOwdwfu8
	38yPFlnaZvIAdWJLE0K+rKAodRQ8FaO/3WIiABCEUisig65WIwoCb5RluQ5jweyCe5w8dSK7dTY
	uZhlTT2ZDfyIaPW8rrJOTm+fYzKnota3UFDvUJL5N3kfhnTyclJAr6fWV0f8i7OTteB5pcz4i8a
	Lg7AoEAoi/a8MpZHQ1io1Pvr0iVW1ti0SErqy9heDN6sy+/AFkb1xXnhnw+geCBrTfcpNPyzyIp
	0WlQxKP7f/8hYXit9GkFaz56rwmZg2mObeoMsdaEBrCG9jBWul3RGaIwrjBwg5+2XckhtVAMOvu
	7Ft7311tb7Pj39U0IMsqMns5B0zumpbyzuPDTpaMhQsIoY0QB36H8a01/
X-Received: by 2002:a05:6a21:b91:b0:3e2:ea7:618 with SMTP id adf61e73a8af0-3e928c5ffd7mr9018818637.18.1793638597595;
        Mon, 02 Nov 2026 08:56:37 -0800 (PST)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada6c2c28sm2229529b3a.43.2026.11.02.08.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 08:56:34 -0800 (PST)
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
Date: Mon, 02 Nov 2026 16:56:33 +0000
Message-Id: <DMKVTEMTLA43.8R6RXYD1UMWN@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-next@vger.kernel.org>
Subject: Re: Fixes tags need work in the bpf-next tree
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Mark Brown" <broonie@kernel.org>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Eduard Zingerman" <eddyz87@gmail.com>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "bpf" <bpf@vger.kernel.org>,
 "Networking" <netdev@vger.kernel.org>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <auiZYnNYLEgcR6TT@sirena.org.uk>
In-Reply-To: <auiZYnNYLEgcR6TT@sirena.org.uk>

On Mon Nov 2, 2026 at 2:08 PM UTC, Mark Brown wrote:
> In commit
>
>   b73855c31c7be ("libbpf: Enforce program limit only for loaded programs"=
)
>
> Fixes tag
>
>   Fixes: c9b2a0975c39 ("libbpf: Reject excessive program counts in genera=
ted loaders")

yeah. it's wrong, but it's too far behind to fix. We don't force push to ad=
dress such mistakes.

