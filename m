Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D7449A3DD
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101898; cv=none; b=I/FD1RfeHVaPZ+03wKK/Cd7MIU1rBOXmqLZzc9XWJb037g7IALv5XVX+LQghtGzMsZiDJ5uptY9D1eYbrxknL5DfjI0OOhKKRvRRGX0lCakJSAjwhUgV0Tno0pW8PeMu07hCsjA132yYa97Xf18jJ/oEfkt/F3k7whB0OHDSQyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101898; c=relaxed/simple;
	bh=yWlRsj2VmYWLEwsE7rqPaBEfZ0LkFJBnk3HvMYu8raQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=BpKj0L//vxGX5azPssm/nRoMGTbAU8o2gI5vGe8g/5ufPlqOLAKmuaK94UQW1trig2uAP38lxRSsgsZQ7G643uVGQ2lX+Sw7jga1eJQ9Z9gLj5qZiYZeJc4ziWmbyB3RUlOl97oAshhgRph6/5JbDCfVUoZe71osWFbU4k4XgfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=p+jsXQLT; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="p+jsXQLT"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c112aaaf04so159682b6e.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 11:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790101896; x=1790706696;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yWlRsj2VmYWLEwsE7rqPaBEfZ0LkFJBnk3HvMYu8raQ=;
        b=pwIaNI4ro15ObdNCuOMFNwd1cSJFrJ5YHY/K8FtMvai/Is09TEzn1+Yv3h1z0f+i74
         khME/pH2+C3lze++eSILgieS0GSj6gD7TOiNbUsqeymAiXq/4TyHUNojDO9wsHywfRfZ
         hT4tlMsVEVjsn+73lFeb5Si0tMCrKCPgqDRJascP77o83BRZOJC1LM9Nmpk5CwYS5ftr
         Wfutz/08zutapeQfynekzRpBvszTwImlb3OP3D+DXMt+l19Xk+iescQkJm/qVFxJst+1
         y6wqs+IESQ5AJYOl6r6usMiZIxTL1qUsnK3C//mdy/9tVaWzFyEdjxc+cZUw2M4O3vMh
         Dp1A==
X-Gm-Message-State: AFuF++nCqM1kvhKEBIOxunXEI7zemTs1C7W4g6/t1NdIfRVf1Lf3Wf3l
	GJgVbL5j7iv4pg0EG5EAovyuPv3WVUBXdAgAWvh8BsvkQdxU7gPyqm2P
X-Gm-Gg: AYBFou27LkQMcReg1igGjrAkmojqSZVqubQmj/lpN2rnlyi3XAE4Zjsl5sgN9pO2vYi
	BLELQdQVGvSqAtnj5lZsJ5rJu1y2m9GJaB6IOw5F0Ijggv+dECHys5uQTIa0Ast0Av0SAZJIB2k
	gF1RTkeQSyFV29DGVFHQ2V1/X0SMZ+DDPecf8JDZ8MQsDMwcikzTnkqXtOIkryCwebbavRwDclr
	W7KScG83uwQyZH5fx8+KZRnbvQsZr6rRjmilzMYHX0kzwIch1BHpLC9SvpZZFXwMOUorgPc7zJd
	MQXwaqDToHooC6cWXNM1rDUGUV99hr0JXuOIgD/FE/QdTPo539/fOPAjpBm/iJYXqOD4dbFOdGD
	wFrSHAQYXEpTYtfhi58FbuVebbHZcfcCa5zzHmO5d09G+sBhVtC/mcepIL4/3Wa8oEpb+c0j6Y2
	sqJpVGn5iB3oE+ZDoCKGPIO04GENi5Qkh/oxnLbi8kMhJxWFWawLUtNZWoqhqzMYcuokxc/bokS
	2qVFUh26YqoFR4EMBBusVFXw89Em9y365fVkOHUW6WUpnULjSJGddV+nhd2g/CTuOHLNnDYxg3b
X-Received: by 2002:a05:6820:f028:b0:6be:7782:5a51 with SMTP id 006d021491bc7-6d2d00467cbmr250934eaf.10.1790101895616;
        Tue, 22 Sep 2026 11:31:35 -0700 (PDT)
Received: from mail.marliere.net (137.65.66.34.bc.googleusercontent.com. [34.66.65.137])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4908efd733bsm365466fac.18.2026.09.22.11.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 11:31:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 71C4F60C83;
	Tue, 22 Sep 2026 18:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=dkim; t=1790101892;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yWlRsj2VmYWLEwsE7rqPaBEfZ0LkFJBnk3HvMYu8raQ=;
	b=p+jsXQLTluWpAJryr4dItCOuD5oOk7c0F0XWrvwH8KuPw1Uo7Aoo1Xkhyllm/UlJNsKRKl
	KQKeLR/aP9kkfHLTTTJon3wSf/dbQ68sFzUWJKdleVN6q1hQpZKMNCH6jXmRMPDTA/LXpF
	qdfRU3hEqou5I2Xim2B0X61qErlldZQkSsGsxhoMtnsgDsN7fI+YGEq56l/WuiWTCgPrWa
	eCYLSa8fSDDZgU3Dhp7X6V6XtR/3Jyq9/AYhDL5znrK5u/QZgwIv83c6u8dFClMysUC+Vi
	QiEoa/qARYboYVuizRS+UEgWXbf4WlGrOowF2DU+WhNNdqygt8F0ZEFSn5CohQ==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 15:31:25 -0300
Message-Id: <DLM25PIKJTE5.1Q1IO5PAM6VBD@marliere.net>
Subject: Re: [PATCH 0/3] selftests/bpf: Fixes for out-of-tree builds
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Jiri Olsa" <jolsa@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Song Liu" <song@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Shuah Khan" <shuah@kernel.org>,
 <linux-kernel@vger.kernel.org>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Martin KaFai Lau" <martin.lau@linux.dev>
To: "Eduard Zingerman" <eddyz87@gmail.com>, "Nico Pache (Red Hat)"
 <nico.pache@linux.dev>, =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmUgKFNVU0Up?=
 <ricardo@marliere.net>, <ihor.solodrai@linux.dev>,
 <nickolay.lysenko@gmail.com>
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmUgKFNVU0Up?=
 <ricardo@marliere.net>
X-Mailer: aerc 0.22.0-16-ge144528849ba
References: <20260728-selftests-bpf_oot-v1-0-05feb15d94db@marliere.net>
 <6f95ec90-194a-4304-9673-c7bb50065223@linux.dev>
 <d3a251acf5131bea732e23bbd135a5fdebec9ad6.camel@gmail.com>
In-Reply-To: <d3a251acf5131bea732e23bbd135a5fdebec9ad6.camel@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon Sep 21, 2026 at 6:04 PM -03, Eduard Zingerman wrote:
> On Mon, 2026-09-21 at 14:40 -0600, Nico Pache (Red Hat) wrote:
>
> ...
>
>> Given your series was defferred, and there is a "rewrite" coming, what w=
ould
>> be the best approach to working together (between us three) to get these
>> fixes in that series too.=20
>
> The, "rewrite", as you call it, had landed today.
> So the series in question can be re-spun.
> Regarding your patch on top of it, it appears you can just post is separa=
tely.
> However, I am inclined to be confrontational towards changes like this on=
e.
> The purpose of the selftests makefile is to run selftests as appropriate
> for current tip of the kernel tree using a very specific kernel configura=
tion.

Ideally, if a Kconfig symbol is needed and the kernel under test does not
have it, tests are skipped. But with BPF they were simply not built,
rendering the tests useless for anything other than in-tree vmlinux with
tools/selftests/bpf/config*.

> Main users of this makefile are BPF developers and BPF CI.

But they shouldn't be the *only* ones, IMHO. Enabling distros to build and
run the tests is also valuable to catch regressions in their kernels, don't
you think?

> Support for distros customizing the makefile is a non-goal.
> The "PERMISSIVE" change done enough damage already.

It's ugly, I agree, but what damage has it caused? I see that it's going to
be reverted anyway, but I would appreciate if you could elaborate.

Thanks!


