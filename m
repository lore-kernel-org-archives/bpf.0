Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3B03659F1
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 19:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769023866; cv=none; b=N7CwhgXsBHczehnbvG7q9hxvdsuNy709DdS3oVfnHzXe+qfFj9RDdfvzza8YIivJ8u2dsxZ5F/OfJTA9yH1SZyU6up87izMAEGPFyXVstq7bAMTUBbirtmHW2k17jf+aG49J9yJEV75J0OtdHWwWHXxD34caS2Wm41ym8oWmNb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769023866; c=relaxed/simple;
	bh=b9yDAYsE05ZOuVfuBYEVHwA5ph6pRefxAyMjtjlx9Ac=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=kV3pPyd/8UuVyIUrO9SwBJFlbN4AMdeGeS0+WMAysuoCEqlGsqnJJkuyAlbaQ7IqJaaL7LKoAu8Z9Ce69X/K+7c/pRuctYTUTnV3i74N4Tuta7VBKx1yHp5TGLsX7B/QPhlX7OH9wDmjvSKUDB7Db4Df2n4gOzvyBL1gDDPOzwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=v7e+HZOc; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="v7e+HZOc"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CAD541A29B3;
	Wed, 21 Jan 2026 19:31:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 84C026070A;
	Wed, 21 Jan 2026 19:31:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B05C2119B1C9D;
	Wed, 21 Jan 2026 20:30:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769023860; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TYMvCSZvFJ1CRk+4p87DSgWZ6r4MnmaAK0r2XbWIWYw=;
	b=v7e+HZOc8f4H2v1d7DjCerX1tAv2B/Oin2tDzVYI9jW30iyjBkNZcNpA0BKCaNXT2vVIZe
	VRIwHXROR5FpuddFeut00i1RHcP2A83JBBKnDA9HArWTJupqdsQq+EfRgcwKE/1SuP0XkL
	y8GB8C8P0za1O7bM/hoGdyzpsr3HQCJPgj0hRu2+k/sNMql7Os1Lnzj3MWtqf/4HB1Vopn
	PcZsxjaNshrx8fkeanvQ6yleuexm5nyfzjbaiwTfTWtt2t4zRqR4ng6lgnm3AjjXDJVHrc
	b16AT1ITmk0au0yhbTwG4HFxccZltIul2PSJefb5QPnNuUfdEZkaGe0A8VIaSA==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Jan 2026 20:30:55 +0100
Message-Id: <DFUIMCAAYRYZ.3RH0727Y7TOS0@bootlin.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>
Subject: Re: [PATCH bpf-next v2 1/4] selftests/bpf: reorder test_progs
 sources alphabetically
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>, "KP
 Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao
 Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, "Quentin Monnet" <qmo@kernel.org>,
 <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "LKML" <linux-kernel@vger.kernel.org>,
 "bpf" <bpf@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK"
 <linux-kselftest@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260121-bpftool-tests-v2-0-64edb47e91ae@bootlin.com>
 <20260121-bpftool-tests-v2-1-64edb47e91ae@bootlin.com>
 <CAADnVQK0kxfjkORv8=a8W8peiBTtpzB91FCh=6X+N0iA+OCzJA@mail.gmail.com>
In-Reply-To: <CAADnVQK0kxfjkORv8=a8W8peiBTtpzB91FCh=6X+N0iA+OCzJA@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Alexei,

On Wed Jan 21, 2026 at 6:26 PM CET, Alexei Starovoitov wrote:
> On Wed, Jan 21, 2026 at 7:18=E2=80=AFAM Alexis Lothor=C3=A9 (eBPF Foundat=
ion)
> <alexis.lothore@bootlin.com> wrote:
>>
>> Update test_progs sources listing to make those sorted alphabetically
> ...
>
>> -TRUNNER_EXTRA_SOURCES :=3D test_progs.c          \
>> -                        cgroup_helpers.c       \
>> -                        trace_helpers.c        \
>> -                        network_helpers.c      \
>> -                        testing_helpers.c      \
>> -                        btf_helpers.c          \
>> -                        cap_helpers.c          \
>> -                        unpriv_helpers.c       \
>> -                        netlink_helpers.c      \
>> -                        jit_disasm_helpers.c   \
>> -                        io_helpers.c           \
>> -                        test_loader.c          \
>> -                        xsk.c                  \
>> -                        disasm.c               \
>> -                        disasm_helpers.c       \
>> -                        json_writer.c          \
>> +TRUNNER_EXTRA_SOURCES :=3D btf_helpers.c                 \
>> +                        cap_helpers.c                  \
>> +                        cgroup_helpers.c               \
>
>
> no need. Even if we sort it now it will not stick.
> Files might get renamed, new files added to the end, etc.
> Just add whatever you need to the end.

Ok, I'll remove it and just add bpftool_helpers at the end.

> Also see that there is a merge conflict. Pls respin.

ACK, will do.

Thanks,

Alexis




--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

