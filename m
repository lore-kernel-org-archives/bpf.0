Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795556716;
	b=fmlsakZUThADIF6djIm9rpMvO/mpsatTF2xFeYmzUvM6I95M+u8ECmb1n2cM0tzjOZIq
	 hCopcBJkwSxMwoCtJpeolw5O7VnmrPX3gKz9TlZu4hhYZUYeyG/fsVuZboQeGF6tciv7l
	 At1kLqdgUDqrehZm+FZwWJMKoCBsgmcw0+tWrH3UdAD06c34Gkm0LqKpsF1S0E2FxCvc6
	 1Y4UuWh2aihxReneDQHZLX1DNJZP67yHvTMaohRrZGIzN0Xr+7+yddypbBc1w5F/PovOw
	 CIt0qkV0rziFoSiQ3nzf1cAv0bjwGtd0ShGEQV2xxvnaDb9BNiuIifPrizuQJBNlSCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795556716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bTez84NgMvGMhhtSTu0NJdSFRdBYeMlDyeUBe50JSsA=;
	b=Fxn+pnnK4WtPmFXUkONETPKcyoQ89L3ja0dTnEs6UIVcq6Wkugt99CQXtqY6+VY5u6zc
	 TSLKsx3qWxWIJFNN9QunI/LKFMgk6kAfxwE5jdziNPvXECf9KSgBIyf2ZXt437u22iiGd
	 KHqS7ihCU0F/lzUQCHtBb/AT7G8LhS60qNCMflO7ih2NQwjNbJgjR5F1rSwk/shnVJP4g
	 dySOl4hq491A4du2h2cbJzI/VL6eRb1f0VEoufzLWdrNadxNiRNNoww6h4+knZZBbO5nl
	 HkHP6HdEQo1whDOWfgD35w2GK6j9+DsHsOJQCOS6HxYedrVQOdwwJErxynU9kdDorRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="m/Pk4GYk";
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1D6606A685
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 21:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A1D6606A685
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m/Pk4GYk
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48ff6bd58b8so473157f8f.2
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 13:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795556714; x=1796161514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bTez84NgMvGMhhtSTu0NJdSFRdBYeMlDyeUBe50JSsA=;
        b=m/Pk4GYkd4a0n+3Ofirfb5f+ITK8dBGDcfib4ub3zN7yISODpaZZ5mJ5xBGmohTMYt
         HC7ka87JswHaOTPQyJ2T/rBoIAHPU9Kte/ev8XNaH+LB9KAFn6P/J5WfJaMewXaCyVEG
         +3yJrJ2m3ARt37tDdBCJe3Ox2Njb1uwPHBdgPNxtWDoFpF+iLv0VEeCkzKO9gPk5IDyH
         q6AngNbo4UkQsLr0pz0cnQuMxwod4OQDXtRK7gTiOmWsqCUJKO97VGkdDcxNG6QVk62E
         XC1LvLd9nXySVrMogVq4z3of5DmjXxYhi61MhUGmzZ/xNFo3niBYWfIP+9FY1iLgXvmZ
         V8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795556714; x=1796161514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bTez84NgMvGMhhtSTu0NJdSFRdBYeMlDyeUBe50JSsA=;
        b=sbiXNGUZqGzysyzTV5U8DqqIAr+tjrW1GXHKRPEHouDLZ/tTCh9/IFF6vGKL2hV0eT
         kvJIC0++pEkSuXF+9xVoiFG8wM293ndKpYXj1QXo4/I0twkR5fdhmQWtEpOwqoz7INZJ
         hDeZvEDVczZiUAXcjB1FDUp3hVn5NKZ9jas9NP1Rnu4klReLyfo++gsiBI2t5D0Qw4mZ
         vLwDTnc2a32Cdksb9B37EFoPgQC19h6hMTVhKu+UsnpnE0SKvY9FAKv12q9rt2SBKBx/
         9rOKu9g4AYsh5QruzRIoz89D8jvy0w1lpTeV3YVOewbwktomyWKVUDQV3gSksdwbX9NF
         1V4w==
X-Forwarded-Encrypted: i=1; AL+hErHfwQ9YSYARLGRJPe71I36hUd0x7AZEZwFrX/YrxkJMIXYNpCgRuc9vtDC6OflmbUSTpPQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+d/t8978q2iTC1JOnmlePxCfqxUiZ50P2tV4ffTJfilPDpHkeP
	nwhEuErndAeM6AZOK3VfNTmHaae7nKp2jK0g+kZd/QeOqMv8gYVGbQXb
X-Gm-Gg: AZFdTZdQG59AdV/u20Bis+fzardLrFYbNU5GhfhROiu8ad65Ju1SoI6VV+KffCGx1vE
	l5fkF2I0s4DJjxfUd++Ln44hDLkDIoDHCM0zwBMTz3sEntO6d7ZnGOzvmgvS4X7HVtUMEaTWEOa
	wE0xJ7LmcWzev1FbDFYbA/aCBeXEqJ36eo3x2Mi7uiMkBzH4JzbvuAtsfAMQHZfbaOVz1Zj/2Hl
	LxK8tQ6XZ9J1kFbJLFSsJPdjHGXLpNOk+NXJ0Z8XmNjw6oJ3UiTtzFmfwYcixRkjuFnO7bY4VzU
	dEovJ8aq9637nrb5G/ilO4aQK4/wW5c1FzIvGRTfCgNVi5amb69SGdJ/Al0VL1cHNnw6cLkArup
	E+9NN31Ydz3yGEZvAiMVDPhoEAIZbmH5Gkr7PaJ/MlIpLTnJNcEAESJuAH5cHzxEwy8fPWsocyd
	fy57wcZeIREKzwMqAWwlTWWakhVm7kj3bLXnJO1xt/SV9tEa7Q1Cv3adDLC3WUQXhQoOsqXwe9b
	ZF4Orv4YlLX+4VBne1L+rSDRmnH8hAjTcCsaW/4gYTfTb4Dqb7yk9iJHrFWASYY1yJmqN9ciuvT
	qVfaSd804p1EwhQ9nugMbKrM51FLEnigD97RWyB0Z/5L+/xiJZzVxA3RwVMRbye8GHMCxw==
X-Received: by 2002:a05:6000:184f:b0:4ab:cb33:9b87 with SMTP id ffacd0b85a97d-4abcb33a2e9mr33409232f8f.5.1795556714219;
        Tue, 24 Nov 2026 13:45:14 -0800 (PST)
Received: from Nuel20.localdomain ([105.118.4.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110d56sm29025201f8f.40.2026.11.24.13.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:45:13 -0800 (PST)
From: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
To: hangbin.liu@linux.dev,
	tianyi@cloudflare.com
Cc: kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	kernel-team@cloudflare.com,
	tianyi.gao@linux.dev,
	emmaonana18@gmail.com
Subject: Re: [PATCH net-next v5 3/3] selftests: net: veth: propagate bad-settings check failures to exit status
Date: Tue, 24 Nov 2026 22:44:58 +0100
Message-ID: <20261124214458.12800-1-emmaonana18@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123052207.GG10218@Liu-laptop>
References: <20261123052207.GG10218@Liu-laptop>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 23 Nov 2026 13:22:07 +0800 Hangbin Liu wrote:
> This one and patch 2 are fixing the same issue in the same test.
> Why bother with two patches?

You're correct, squashed into one propagation patch in v7
https://lore.kernel.org/all/20261124214025.11603-1-emmaonana18@gmail.com/

Thanks,
Omokefe
