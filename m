Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB8C34B662
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779800626; cv=none; b=NHqLaPenANuDlYuEjhJeKBc+3/5m35SZPJT/6BfE3AGYws0k+dD2XhSs3Df0CyZ5rMSRXDdSsTsfVrMEW0ClN9FPMk21EU6BzVukeiuQLxhj9sxkzonEhv5mp5mjquhsKt3gJbILSRnoRq/oJafMWdH/os6TXCR2aP4bfoq6Jys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779800626; c=relaxed/simple;
	bh=cIV7eVLFj1WSRdO8UJfWGAKcQ4RL3tgfGuH1jAdS3kQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jtfs+4LGxGk24R+WVrrXG6H3m+u+XYlCmzE/yxujGD97PsZcNJ9JE5aCw730xLpPUSUZGboAEcoJJX5F1C5Fi/7CkuyYXFgJsq5+IyIgv4WWnXYKLUhmfPjgY3pTh5UZ6Lw5M3Fx3KTPC1JgK2p8krdoYB2aSQa1DKsm47paxtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EKza7bFe; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EKza7bFe"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490388fd0dbso50136465e9.0
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 06:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779800623; x=1780405423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UjNTcWc9bOGf723loCTUep8771/uj7ug5EPYZq+XxOs=;
        b=EKza7bFeRfOQx4baBBdJSdVBzM2bve8Vku8qcuHTL1cYVJoQa2hWXbtAPm6EKv+KnF
         IterkP4Vdog+meaG7Vze1zOImzDCFf+4VYTp7uhiBNH9SWeHBhz67Egxfm1Y+vIwLZkq
         iXkupGSTgn20E5+tdlHJ3VTYvJ9nWNOMRCMpxNamsJCwQ3jmAF7d/A4FhvgNh/dKB1k4
         jIdjIY35h4zCtboEngwh4wP1MQ8ujcO+wcL0uxiix57Hu9LdhlaJfHiWyzZZd8DrRvr4
         dWlyVvqCuyLlokSTAwAvFB6yTdsoOhP0YVuxsM1t5zz8rNsgqshkwHrtovjbfmMBXRwA
         jZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779800623; x=1780405423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UjNTcWc9bOGf723loCTUep8771/uj7ug5EPYZq+XxOs=;
        b=N3o9kjSz5BkmzI6a99gr09TTS5JeiGuE6CQG+H5cHN3tyED1dxEBXm2QvAHIQHQ8BN
         o+ssvcNS68CvdVue+wpLFrSNXS+nJcY1noGGgETUKROo4vuOBZAubA2NlTt7QCaESrYG
         z4EJNyfhfbzn2EREXzaQyzBtjL0k2pi7X37LRBiQ3x5H3HSWrUVEc4xWuj8XxeafI2t/
         Yr7g83MkGi7aeTE6tL6l7kp0d9746p+yfd4xSoC93jPXVFjAyVFEscWAdxlfQqNdnASh
         Do3XiHTMFkvEzMECuPRnKeNnu/PTnqqk3GpurlFG3QU4H0tdNsLgi4CcPpEzINykl+mk
         vs/Q==
X-Forwarded-Encrypted: i=1; AFNElJ9iGAj7Dp3O1slOuO1IYdSMEU1uBydSTenQnM7GbSWA6Ym8ac5+q3zcXqw+u2XwYpZ/+es=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvBUbqAWRlndb254FmsNCM0CMUcqbJbwe4JYi0/7DpIfoRPZI9
	ZRb8VAw3l4x8nYVaVfIGaiVgo6VUoGEA7n5k8iQj2qgPpSFF3TGlDnRuibqy7PF2UI4=
X-Gm-Gg: Acq92OG+5RZNWTwYL38+PBtwSdTydA4ooEG0LNDhJ5kkWbPt75Dmu5bgxn3Eh2BlezQ
	KnQbZiaLXJOGTBXwXdzU5fJYh4BJzGWwYz1APbq9gyoNuR/ju9lBiVis9oCwFY7Eq0WOJsYALXQ
	E5BCygfFla+teBCqgkaIX+fFy56iBtvBBBChfumSrzTR4nnYHWUghCphoI+8LJRLN2QyPyrza+y
	YhKlQ9BrPJueXE67Ry+Zoqor3yNG26DWFoLaI1Lsym0WJrLwChQkkEpt4ezyUdvqguzgYJ/Bxtq
	W0Jktgoz4bU0xEe1PK0yNnZ9ydxOGkwvw96/sAcJGangyLPeCDiUNFAMlwYS/RCjBQHFh16k47X
	QaDv6bRZCZEIbbNxNzaCLvxI0RMpnweEdJMYZXoznfj+gD94I9d1u+dtqH1GrQxLK7kUaL6D/+8
	tGLE6B2VmZKmuhl36RJvj9G/rIKNq3B+zBSK7kSE3lOeyu
X-Received: by 2002:a05:600c:45ce:b0:490:52c0:73f1 with SMTP id 5b1f17b1804b1-49052c07823mr223327865e9.9.1779800622880;
        Tue, 26 May 2026 06:03:42 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904561a198sm318501285e9.10.2026.05.26.06.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 06:03:42 -0700 (PDT)
Message-ID: <635fed3c-4e39-4357-acd1-13f1653f9e3d@suse.com>
Date: Tue, 26 May 2026 15:03:39 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/14] module: Move signature type check out of
 mod_check_sig()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>,
 Nicolas Schier <nicolas.schier@linux.dev>, Daniel Gomez
 <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?=
 <f.gruenbichler@proxmox.com>, Arnout Engelen <arnout@bzzt.net>,
 Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>,
 Christian Heusel <christian@heusel.eu>, =?UTF-8?Q?C=C3=A2ju_Mihai-Drosi?=
 <mcaju95@gmail.com>, Eric Biggers <ebiggers@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org,
 debian-kernel@lists.debian.org
References: <20260505-module-hashes-v5-0-e174a5a49fce@weissschuh.net>
 <20260505-module-hashes-v5-9-e174a5a49fce@weissschuh.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260505-module-hashes-v5-9-e174a5a49fce@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/5/26 11:05 AM, Thomas Weißschuh wrote:
> Additional signature types are about to be added.
> As each caller of mod_check_sig() can have different support for these,
> move the type validation into the callers.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- Petr
