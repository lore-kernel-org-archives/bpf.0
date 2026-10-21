Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601721;
	b=yjA7J98VHysSqd0zuxHPcuIDQljlE3vUHhpwFBQWH1lKMqQrmJGicCqnUaP/j0iZca4v
	 nlhbUeLxTKXsYA2XslFVf0ZXYh+23sCsJZ4+NpxWb2AGXyge+rqKvToKlNGq09jA8rPiv
	 Q2bbffnDe8yWDDFlGayWsAOKVlZAOHOzBlkun+j0CVkxoXxf4Drgv72+Xnxq88eSUbLkH
	 Fu75BHOMp5GetugKQJfyj2poL74qKNpp8GG4ernktlHJYfAfXfx/60fMnvkG793xVc4w3
	 ne+BF8YxxCIzveWKALnCqzyO8xtMucXTFwU7omwJdxVLeDiS5dPMULywGcfEwavhIqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601721;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:X-Mailer:
	 Content-Transfer-Encoding:MIME-Version;
	bh=d3vvN8FGGnO672Wz9KeHuEsBR0S4tEOrTs9ISnUowPU=;
	b=MHeJezNOJasZWGFI2Bdy+i5Xk+0CBHu/KvAtKLBgkzWeUhfea/W/pW+462JJ7RSneWA0
	 0h+9DJh/gIhbrLoWwJ3TN8JoQNROKY5OAxhmuCdPMxTyaQlYsTstAHKdludrRJY5c4LVV
	 eshjLDhLe3g6pYhLqZsXvY3OOdPAscpeOWyzzhdiEDPqdWN9RvEt6KTZpCr71/Prtq00J
	 brUJagXnY2pkQSGvbnL7e1/fQCNIAgl5UOCtuSyYyjk/DFMruJoUcoQCUC61KWlA0mqhI
	 nbhNIf9R3nUxufxXfmykyD7wQVhiCa+2zqD0ND+WSTa5aODV+gLoSj4Na+qenixlBpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pv+1zfDT;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AC2606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 16:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3AC2606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pv+1zfDT
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a064dcfcfdso310147b3a.2
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 09:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792601720; x=1793206520; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d3vvN8FGGnO672Wz9KeHuEsBR0S4tEOrTs9ISnUowPU=;
        b=pv+1zfDTLFmiuxgb/ULE+QN6qP+JtBIwHKYux0sdq03NgKsm+1AyVjlq8xjd2WTPrv
         ahD7r6y0YZ6sIVYHR4bJciDBrLggss/oq8uyf541L1Gx4JHgv3puEwUGJkj3OosSgljl
         jylGO47M6+irpszxAGwwxpxgQswvXiC6Kptyu5wDGiRlXdMSQTTodrl0Uu+6lga46brS
         Sj1GmHMU31JGemrNJZWibz4e6RElf7qsZRYIA+SoHOIZFndiTMu2Ob5ew/DlXeQrC7Vs
         R1CbdvVV/VqlDvxLfvRL2Nv+z+WWCFLAhrVpEPV+H7k5QQt6KGd/Qf09tO7X1tM7C0M4
         Zs6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792601720; x=1793206520;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d3vvN8FGGnO672Wz9KeHuEsBR0S4tEOrTs9ISnUowPU=;
        b=u6DvRRUNzqr9nlgQf4HUZsYPvDq/RPTFE5z9+oi7gDY/SMvLDZRs9fn6wrm14U0fAq
         D6NOl+N/z8wHCdoFt3gsc4vgQ9tGK/Urc1AC1pC22rQZ6t3p9wEE2UwtdDmOBGxMKuYr
         fb8Yj+gCB3MHHwaJUeBTRZKCvQnLZE8IHq4uQdWIgonPwIfEBaphf9TT1r3Al00AgWdj
         +JOmlma4G1JrCeuu8rniPjUSQCeGChxdy/xozoBBnsKfJ+WXjVD0kZT+KMkxiVPf23SX
         9l0TufMmz04E4Cr6AU+sqFij9Vb19LDpiikLFUqLWMuloQbcCiIC2tvRROWFP8VUrsmJ
         y5gA==
X-Gm-Message-State: AFq9FYKCtQ1YJSsg9v8/+MrEwOIcnF3mDuoDCmje5AZ99rJvTb5+TaYt
	XW8x46JzxKy5XnRTxFeh/bsIyUJVfi3tQ15aITkUcF7op7ePlfSX6bqX
X-Gm-Gg: AYBFou1WcmEM0DMHGkCEvd2IKvSvKX2hjY8NBg+oJwxbFN9Wsob9xk+Hu6sGgXAufeP
	4qyA76+sfV5cPftDudoqdNS49g1XJbSWgcOPvETpnKyFFzoffktOKayc9b1mwjaN7dZDpAcO0p0
	TjszCnnFn4EuBt5ygWMyQJjYScVbt4d2UTPs/lTN5iNpPUR2qa3ZoHucsUwmA4qXK5GX3QBGFz/
	86Ai4qF4z5qkK7TUbh76T/2s/VFY7HPz2hDxPGHdk2ri6YC+qrcdfal2OCnEgHSA0HLaeRtzhNP
	yTBRfDnS4TC2cjAQ2zkkNYh6MDGWB1UVYlisN9SM93egO7pZZTI6soNy5ad1TS8jkwa3tw3JKnx
	Ti7KHmysPasWq9YFHBmOCqPp0qaUAuFR9lYxc5zM8btMMNvaPJB9bO3/2skI4ZS5xRii1JliIqj
	Yyt5D6fL5UK0KeJENn2DEnHK9pvhFXvkrbbOJjpWbYzeGh/noyzSU0BqygFeaXj6sqfGVfDjt7c
	7FQWSQpGJNGAnk/+IGqbINLns3D2v4T87tW5G4jCnd/mvRNsOmBEmose4P56fjRK46YF49zL/9z
	Y9oFPxqn4E6ueZcgefC/9loljsDOGGpPN3xRiT4MWQByY00iBcPR/I3fB1nv
X-Received: by 2002:a05:6a20:914a:b0:3e2:6997:4995 with SMTP id adf61e73a8af0-3e287b22eb2mr2187245637.2.1792601719967;
        Wed, 21 Oct 2026 09:55:19 -0700 (PDT)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0894b49e7sm1201078b3a.19.2026.10.21.09.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 09:55:19 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 16:55:18 +0000
Message-Id: <DMAO9WXLPZ4Q.3KZLMI783AR3Y@gmail.com>
Cc: <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <yonghong.song@linux.dev>
Subject: Re: [PATCH v3 bpf-next 0/6] bpf: Unwinding with unwind_goto and
 unwind_exit
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Wang Yibo" <szwyb123@gmail.com>
In-Reply-To: <20261021011249.17-1-szwyb123@gmail.com>
References: <20261020043319.3031996-1-alexei.starovoitov@gmail.com> <20261021011249.17-1-szwyb123@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
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

On Tue, Oct 20, 2026 at 06:12 PM Wang Yibo <szwyb123@gmail.com> wrote:
> I tested v3 on arm64. The cover letter says test_progs was only run on
> x86-64 and freplace was not run on arm64, so that is the part I tried to
> cover.

Thanks for testing.
unwind_exit in arm64 JIT is different v4. No autia1716 and pacia1716.
The epilogue authenticates LR as it is and adds the offset of the pad
to it.
