Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BF2242D7C
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770056612; cv=none; b=lKb1SkssW3M0sK9Dbf0z0GG81KXWPHYC+vyjrwPcFdcB9ZrT1WSpOazISZgbhhhN15z2j6ulXssHNOrBIbwgXhHbIHSiNpf3/gZvGAe1Uaw0aI79Umwm0OBgTeQgs8JW929AGM0CuRwtReuYMwNOFi1+fO//iLoIu+S0WacgcO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770056612; c=relaxed/simple;
	bh=EEpCeipGCGwIgXiIVof0HaBesP/mrRrYQn9Y+9ZYpnE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aHH5LJUVbXmkD5qQtzpDN4sVp14sGpXc/QIQmrHqZZ9guuE3cdQXCszOmJS5p04fY+GdZ83ZKMQ/dxB0KGLOlI9BwAwIbcLwcX5Pf9ihYD+mAgU0KymkgVqfMDeVGsq5rMZsDMAq2lwFDPmhoOpFIuPsOKLUGUChUxhFLqF8c1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EK1YSGYM; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EK1YSGYM"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2b7da62b487so5863354eec.1
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 10:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770056610; x=1770661410; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EEpCeipGCGwIgXiIVof0HaBesP/mrRrYQn9Y+9ZYpnE=;
        b=EK1YSGYMvCJncRcqfQmEeO0pKlRY+ldery3+37fsmghInYkj8U9tKyDHvGUvK6LXfq
         D+9LlHkDBjgpy5Ah0McUaD+RQ4POJ/ANly9kSOIsA6G7rjs/ZfGATVCSwD50W84I5fPT
         GP9NVEYenladS0VgaINH4AL+Udpu7zqDV7wmTQmbX9tbybKsLAK8P+aqdnI62OWrVXE/
         fTvywPrZ8fKl0oEo7J5qw2EbkZBb7f/AlbrlK5zm31gWJy2dVU/wVa6ygEFnSW0XguLx
         Ou8Q5IP+2C3wTHYoyuqaDXM768+tLaXJMmXFFN4v2getPdBxupIwmOkXsGYsrlCb7sTS
         +jpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770056610; x=1770661410;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EEpCeipGCGwIgXiIVof0HaBesP/mrRrYQn9Y+9ZYpnE=;
        b=GtgI1PA8Qz/P0svVvvH1odV2/xmg5sT75DnIeU+zF6bAPrDfJMm7NC3G10B7qMxQ3P
         khfMxW/Ms1YlXhDpq1jAXviAzI9xCmVlLLWWjclVaO+McPXuS+Qc2gkv0XoHGnNHemku
         1NB23szGiMmsPvSGK32WunQQTp3T23WiQculG4R9W8RPxzQRtI4oNplzMWWLrzdsBDcp
         76PlTrDpqjPZ3Gm75Hlgtu3DBq+qATaq8Z9cDpigdybjTwxYlrbOJLajcxgySv5a2APS
         3dIclcx0ICCTRf99yjuajRuRDUiZ61kurUJELgYu8Dl5pYEOlIlkgh+efX6NoRM2kAtG
         ACjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7l+yuqJY0AZMizqZKXSWol9b/t1x34FdG0zFCzJT/jeN4CCiUkAGDvZaWBQLv8N83GKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmcTXnx9n1/yjXWMfkVmfoUdt9y2WwFhpCERPewudhZvuVq98T
	s53OtCU3uF2WbE9DWNYvPTVe9g9bCktwAzAHGcMwMhMNXe8OIRN+tKvS
X-Gm-Gg: AZuq6aKcIIVRCoyCETWUYZR341pFZL5kp3MEwCrdSzFYeUofk4uO67cAAaFpH7BoS+t
	OlzxDJO6bxURqYGYIbWefK9A1dNsv9UyH4pRoBJZKR7MeTjzFsivmVvlaX1he5U7JjUyH76seQC
	Ir4LrCbKVSu4VAx7/ulmnSJuNUCvPZ34aEF1BlJCk2pqRtfSddyfn8o7gnfBwJE7JUCwqHltgk5
	TIkntRUGa/KZtWbubqsguBE4yButZjgQwqXihseH7WbFFjpKMuyVLgUzKUQtWMSX9wuY8EEpnJz
	GDmer54dyvxoWOqg1w5tee2OZS6SPDaMvBgTLD769WocnFMx9dHFq6TZpPB5cHeaHEjGFiAhpw9
	lCanBwekILGWgpd3QruKUp4dTRZjQwhFjpG6LJsB5fUAasUzNFxAn6ICW5elB3Y/CHToulO4sbK
	Sm6alYk2Y4ADv1Xp/4c/KhcA3R9De4fY99DprrqgyBLCCMkdpVruA7MxuGj7xbEBeMX8mo3faz+
	KlF
X-Received: by 2002:a05:7301:1e48:b0:2af:7ee:5300 with SMTP id 5a478bee46e88-2b7c865f32emr5778505eec.14.1770056609990;
        Mon, 02 Feb 2026 10:23:29 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:eca2:6a75:cc8b:c3? ([2620:10d:c090:500::3:5713])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a14bb02csm19942117eec.0.2026.02.02.10.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 10:23:29 -0800 (PST)
Message-ID: <d9efa65eee0c8cf5f7e2b47e0968fde3ddee4b58.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: verifier: Assign ids on stack fills
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko
 <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com, Andrii Nakryiko	
 <andrii.nakryiko@gmail.com>
Date: Mon, 02 Feb 2026 10:23:28 -0800
In-Reply-To: <20260202104414.3103323-2-puranjay@kernel.org>
References: <20260202104414.3103323-1-puranjay@kernel.org>
	 <20260202104414.3103323-2-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-02-02 at 02:44 -0800, Puranjay Mohan wrote:
> The next commit will allow clearing of scalar ids if no other
> register/stack slot has that id. This is because if only one register
> has a unique id, it can't participate in bounds propagation and is
> equivalent to having no id.
>=20
> But if the id of a stack slot is cleared by clear_singular_ids() in the
> next commit, reading that stack slot into a register will not establish
> a link because the stack slot's id is cleared.
>=20
> This can happen in a situation where a register is spilled and later
> loses its id due to a multiply operation (for example) and then the
> stack slot's id becomes singular and can be cleared.
>=20
> Make sure that scalar stack slots have an id before we read them into a
> register.
>=20
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
