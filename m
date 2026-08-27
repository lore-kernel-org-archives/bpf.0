Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A48348C4A;
	Thu, 27 Aug 2026 20:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787861945; cv=none; b=RBuGxmJqWSYaoQA2Ok8483kdp3ED5aN1bOA4p/ikyOiXz9uVqcG5VFy2iF6aDzhaa0xn98Iq98nmkCYLHQY0olXtqyxCAJhBnfxxrRYcXAIYbjShJRmzzUbfRMRaBsKGpeTgyukGs6H2uOnNi7xZElZZRs6/AjXBYN757jC/DRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787861945; c=relaxed/simple;
	bh=2f6eS6hq1Zzb3eUH7OrgppEfRhvqNgO/0bsmbb0EKE0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=bjgqoZ4Ls2JU27Aer1VNk/qe58QRt6uVlmvL62qq3Tv9LZZdBh7hNyPDInBAHJAhXghTsG8h12b8l9KdIJ/qt6ZfbZS+ERFDo0dHQX6LnXzTbrpUNdECMa8fg9qhRMf8dbWPp57RwgvhnY7eMavK+3gE1WN6cr7bMl1ExGeR0Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=17OEEkrw; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="17OEEkrw"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 660ED1A1882;
	Thu, 27 Aug 2026 20:19:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2E9395FFF4;
	Thu, 27 Aug 2026 20:19:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B0CB211C78052;
	Thu, 27 Aug 2026 22:18:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787861939; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7uHVjlxK5JPXxPTdPekPU98fIYVQa5fVUZYv6z5mbfw=;
	b=17OEEkrw2a9ETtr/oUp5Y9+henF4VZlqOBWuv1wnfNySeoEFYdwTmvj52X5HtQ32OotUys
	igMHg0DAgWw5cFp8iOP8oNAHpfx6vEvo8lIg+sgyob4TvVdEE3y/S6Cjhdgx3QpNWo+ci0
	vcUXW5DpWDSQUo4V2XGjeEO0MsWJSz2oEH/EPwfRdMQS3kkQ6/IqQU7hpHFfrWinTvRxSO
	NSvgJ+DY68HviE3MiZJqI+b+6aypAdSr2c9qvmT5dsP0xwuL6oha2ufDJR6wKhom2vYhEy
	dbj8LkCwb3IIOEedkfc8DqMhFsX73dpvdrUWe3+/QiHNB76i2z/GP3WN+cAJLA==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Aug 2026 22:18:52 +0200
Message-Id: <DL005T9QKREF.2E4AFUZS1M0MV@bootlin.com>
Subject: Re: [PATCH bpf-next v7 0/9] bpf: add support for KASAN checks in
 JITed programs
Cc: <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Borislav Petkov" <bp@alien8.de>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, "Shuah Khan" <shuah@kernel.org>, "Ingo Molnar"
 <mingo@redhat.com>, "Andrey Konovalov" <andreyknvl@gmail.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Yafang Shao" <laoar.shao@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260822-kasan-v7-0-99afee6ef7fd@bootlin.com>
 <DKWOY12R4ZJJ.A8KDS1DU1PHS@gmail.com>
 <1c34603a-9170-4074-b826-e98d9871e2d8@linux.dev>
 <DKZJ7GFLAU12.1WHACTBREQQV2@bootlin.com>
 <a96f8530-114d-491d-9802-83d72dfab16e@linux.dev>
 <542d7a2c-a435-4b0c-b860-42e2209eac3a@linux.dev>
In-Reply-To: <542d7a2c-a435-4b0c-b860-42e2209eac3a@linux.dev>
X-Last-TLS-Session-Version: TLSv1.3

Hi Ihor,

On Thu Aug 27, 2026 at 6:59 PM CEST, Ihor Solodrai wrote:
> On 2026-08-27 9:56 a.m., Ihor Solodrai wrote:
>> On 2026-08-27 12:01 a.m., Alexis Lothor=C3=A9 wrote:
>>>
>>>  [...]
>>>
>>> If despite the comment above, teaching check-kernel-splat.sh how to
>>> ignore the kasan selftests specific splats remains a better solution,
>>> sure, I can work on this.
>>=20
>> No need. Let's do the SPLAT_ALLOWLIST, I'll take a look at your CI PR
>> shortly.

ACK

> Sorry, I assumed it's already there.
> Please submit one to kernel-patches/vmtest whenever you get a chance.

Done: https://github.com/kernel-patches/vmtest/pull/520

Thanks,

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

