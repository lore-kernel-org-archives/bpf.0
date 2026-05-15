Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B539450917
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847312; cv=none; b=QTk/B+fEco0XQnCwhKv18QtsP6Qg4iqB7KH+HPxn4Q9S2mA1K8zec4ZAJBg08l1SKrYGpBUf2lPOMNMn83Du2NrqtNcVEHO6g/q6ISjOztx1x+lsKKH9mT78gEokSE8pd3Esvx6Hn0DfwmAy5o0MP2944gKS8qXo8ZU+RGxKlOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847312; c=relaxed/simple;
	bh=nghT9y6ENngQFDLkYT8F2cg45VlQPtMjBBkDABwEj3E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=mXbjje3/SuiXqq+i07KxGmvEXSkZsRxowsHza/yoix8JeHUx9pKtZ2qiYi43XYZRuRNvkLJhr9Qna/uctX49jHdm85A5NVEOLM+7DAs/gdTUvrRfnk7CzJjYTWC7Xs4HbulJVcPFNPVWIVKD0guVkBgG/1lP9gkps59c1zXMadc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JB200RN6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JB200RN6"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488b0046078so73897305e9.1
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 05:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778847307; x=1779452107; darn=vger.kernel.org;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nghT9y6ENngQFDLkYT8F2cg45VlQPtMjBBkDABwEj3E=;
        b=JB200RN6ME0pPcc6NnDTS9ZcXpFHbgD3XFVJkEDxSUvqD3ZFeZJcFmkCM/BXvwssz8
         D0H1q+/MkEZLvWbKRgvaSXEAJFOc7Yu44GyPsTStTlEmwfvMKEfV+LceHGMAhbz9+fub
         JRK6z40eU8OzQWctUCZVGcw1tHpovyu1oQV9avHxuTsaiTChS1AwpH+dl8NoMniMJh4D
         MFKOj6Jz8J9luahTQP7BW46oNmcNNf75gHMIGX98RrFmiuA+dAMYUDf96AhR17hiMx5p
         53VprpC+KdBktCDm809kWkvMYA4s4Lct9AMmF7aT3GTEXOqy14/IgekPMM29tz6evvlL
         e4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778847307; x=1779452107;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nghT9y6ENngQFDLkYT8F2cg45VlQPtMjBBkDABwEj3E=;
        b=HVxJVyHFt2aje5nG8DRhbeWeXFXt+URXfNlClFf2u+l3QEBVEkZpcCHH0S6lfYG1v5
         JSiZqMxNZsQZyxKK5HxCYRu6Fc3r2zYx4E2rignh9NeUBcKjigwDCDO6n7JKgLd79oJF
         TgRBZwXOXeUcZ26WqR9o4wCaslSh0WHfynid943x3miYgHoJmd7Js/dKy5PZVMTKWjKi
         cAKq1MKc54ttxRRh8mYbajnmATs0XrhHzYO386yDnumkyDIq9uNQd6zJ6cMqJfSXosLY
         /S+VQj6GByfRXb1wEwYzrYNvk9jo3lyIY69n4LWArISi2zPLrnTz3Zfs5CY535yr/hlL
         kUwQ==
X-Gm-Message-State: AOJu0Ywc/IS2GO4pozGPPZMJOW0kSO09I6O7AtC/7lcQonOXeXlvXcZ2
	cxmUBtizYonSi3J9RyL93YABLq5sW9Mp2G4R7NEE4pG+2GU9NiRigK7MpXsF/FI6Wiw=
X-Gm-Gg: Acq92OGNF5a0pmioWS/aCtf+N7Go3zX3uzuNu/qE9S5Bakt/0AezfyUIJ3VCtlwlnXn
	ijjsyFCNM7z990oRIaYy3eJLRkDhe80Ev/afIHCtN5wr56qSKkF/EhQ8I2Wx0bD7vWeURHNpzQ3
	G1v2kQY0fLuDeWAy6lUy+p5+lLe1jEgYBLGd1Rm56tZ24EyiZAUgD1DaA7QI8d03bii/imOm424
	X8zzrr7TIKuHnWS2An81Qu02XY/ghXU7WYWva/j3JHAQPBPiP+bBEENSKSW1GERWSQD334Xpids
	dAZk08eO7+7xFs2nFIDk4Hqao4Pi6Ze690dB7MwWsqhCmnPq8RdI+Y8FtWFZD6gOgPCeYgMEMkQ
	Bs91a7qPw6iYvLuQwzuKyrP/cxHJt7rd36NZeGVyLTPyK0tgQKYTnuPfycQ3vsHtjqdQ9lGed07
	cSrqkblinT8JRtC9O00b2w/voFB5POnFvY
X-Received: by 2002:a05:600c:8b6e:b0:48a:6fd4:d3d3 with SMTP id 5b1f17b1804b1-48fe61ed21amr56127295e9.20.1778847307241;
        Fri, 15 May 2026 05:15:07 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:1285:2ecf:67ff:fe81:9da0])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc2351d9sm9796573c88.9.2026.05.15.05.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 05:15:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 15 May 2026 09:15:03 -0300
Message-Id: <DIJ8QPTPH61Q.6NT4DT90K5F9@suse.com>
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
To: "Alexei Starovoitov" <ast@kernel.org>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Subject: Re: [PATCH bpf-next v11 00/11] selftests/bpf: Tolerate partial
 builds across kernel configs
X-Mailer: aerc 0.21.0-146-g87073a0460e3
References: <20260430-selftests-bpf_misconfig-v11-0-e11f7a8c4fdc@suse.com>
In-Reply-To: <20260430-selftests-bpf_misconfig-v11-0-e11f7a8c4fdc@suse.com>

Hi Alexei,

Just a gentle ping, please let me know if there's anything else that could
be done in order to move this one forward. I believe everything has been
addressed.

Thanks!
