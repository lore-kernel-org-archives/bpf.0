Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDFC380FF2
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781256016; cv=none; b=LXW5ceeNKDvd49h51t5c2BjMX//XFec1yxazsGnHMao0SzJn3ytQW/YB2yU9l63Z2JSfWK7oqUiLOaqcy6RySIJ/XLnEt8Ea3Oxcewvcl7W6AoEQ2hEEBmkk5JO9x0PdGxdyQJeVJpu3OKem/pB0m4uNyBw8KcLHUJO8tfWsl84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781256016; c=relaxed/simple;
	bh=FbMvPYyCn440rH14tgIb5oTanap74+bGchGNNTOutIk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=kzuupZPMTKN/xZDKgfsG1DErcvJBX4kITDuDiTiyiO7SbhopqXP2W62SZd5yl4SSe2RETKOEM4s1ARUtG0DBl/sPYvetjRrw8eqakhPp9cYaHJJt1KK+bO2U7cxC2yLZmn6gZILw63TK1bmHhEZCF7yrtlHYRemjVYUAH1kdU04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NPUVXd/I; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NPUVXd/I"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 23F8F1A38E3;
	Fri, 12 Jun 2026 09:20:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E708560012;
	Fri, 12 Jun 2026 09:20:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 78C43106C8615;
	Fri, 12 Jun 2026 11:19:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781256009; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ncZwz3sNo308KUWItJhOltAt4oaQ+Dyfb6WfEv6tuTQ=;
	b=NPUVXd/IqoKsy6s7A+fdPRQy6EEOpjPaH8ih3ujTyougrpDUztW7Anv/xDTuCzxcIY/9RD
	imNRzYSlcydkukZ0CZtMQSJjh4uOKTT9VQwQ+p0uRTBmwDnthntHxlHl32ILPKKGwZkk3r
	ETMuGlhnGDZZO/FZwNOc6o5+ckd2bOShZZE6IlcVO6d6tX+ExlAMFHwMYUQQs97g4ojmLi
	Eysj++XJxX6NCM+sF4JDtVWGx2eUxr0jBqhuI4TektmgXGBmvOBt/ipTfE5qC6kdqTkWHL
	FZUzNclbZSDOKLOZI+pgkKWxBXEYysKXgQTpCZfu222VDf81u81G8Gvwaapd3A==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jun 2026 11:19:58 +0200
Message-Id: <DJ6YJX01138K.SRJQQJFBY73J@bootlin.com>
Subject: Re: [PATCH bpf-next v2 8/8] selftests/bpf: add tests to validate
 KASAN on JIT programs
Cc: <ebpf@linuxfoundation.org>, <bastien.curutchet@bootlin.com>,
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <martin.lau@kernel.org>,
 <clm@meta.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: <bot+bpf-ci@kernel.org>, <alexis.lothore@bootlin.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <john.fastabend@gmail.com>,
 <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
 <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
 <shuah@kernel.org>, <mcoquelin.stm32@gmail.com>,
 <alexandre.torgue@foss.st.com>, <ihor.solodrai@linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260604-kasan-v2-8-c066e627fda8@bootlin.com>
 <8642178be3be8efc7f19ac4a9aa37e699f2baa82cab200909b99997068c6ae7b@mail.kernel.org>
In-Reply-To: <8642178be3be8efc7f19ac4a9aa37e699f2baa82cab200909b99997068c6ae7b@mail.kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Thu Jun 4, 2026 at 11:45 PM CEST, bot+bpf-ci wrote:

[...]

> The Sashiko AI review on the RFC v1 8/8 posting raised a concern here tha=
t
> does not seem to have been addressed in v2:
>
>   https://lore.kernel.org/bpf/20260425065049.BEC63C2BCB0@smtp.kernel.org
>
> The original question was:
>
>   KASAN operates in single-shot mode by default. After the first subtest
>   triggers a report, will subsequent reports be suppressed, causing the
>   remaining subtests to fail? Also, since BPF CI runs with panic_on_warn=
=3D1,
>   will the first KASAN splat invoke check_panic_on_warn() and immediately
>   panic the CI runner?
>
> KASAN runs in single-shot mode by default. mm/kasan/report.c suppresses
> reports after the first one unless kasan_multi_shot is set.
>
> This loop runs roughly 50 subtests, and each one expects a fresh KASAN
> report emitted via the JIT-inserted __asan_load/__asan_store calls that g=
o
> through kasan_report().
>
> Under default single-shot KASAN, would the subtests after the first one s=
ee
> no report and fail the positive assertions?
>
> Separately, BPF CI runs with panic_on_warn=3D1 (config.ppc64el still sets
> panic_on_warn=3D1). Would the first KASAN splat reach check_panic_on_warn=
()
> and panic the runner?
>
> Nothing in v2 appears to enable kasan_multi_shot or guard against
> panic_on_warn. Was this intended to be handled somewhere?

Hoping to silence this one on the next revision: CI has been updated
separately to enable kasan_multi_shot, and so all subtests in v2
properly triggered the reports individually. The commit is lacking
documentation about this need though.

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

