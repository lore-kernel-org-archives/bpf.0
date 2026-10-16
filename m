Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EE14F93C3
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 16:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166744; cv=none; b=qYCXIoJO5t0GV22Htk3Oeb5HSjEsHDa4zxKdExlip6W3sBrORWXbKhZnQkIaGxAoLMDOjHwysO+aDOej7mWd7GEgl9viOnFMuL/1cXN0h6HDMyZfOZE+uCNgKSOxs21L6uNludxvunpwo2/b8tXaNk07Hvv5pIQ4d2jcLkg53MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166744; c=relaxed/simple;
	bh=5ug6v5uuguLMr0+ls7SFxJsomUB55a7qx3oFLi85A2w=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=LFv5Ci3Xg6q6dNLzEVzq8yAFeSajKYuB/8AQoi3vvIL7LWy24OaT8cKFfC4zCf15XqOB/UZOe4QcPaO57Zu5+8TCYC8KhuaTa7I4G9arZoR3ylSemRnVaeLq02QFelTqX4ZIlm3rCuVuC63vYT3j/5o3PtSbCix7Mopm79yBVkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcRyK0k5; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcRyK0k5"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e987b4a710so4862745ad.1
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 09:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792166740; x=1792771540; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5ug6v5uuguLMr0+ls7SFxJsomUB55a7qx3oFLi85A2w=;
        b=GcRyK0k5WHg4tEAQXetii8VT3FpuvJBNc9gVD1wQD3kMRzitP/JkjsmADGHjlxL+PU
         dHscCPnQ9ROWEDOE/OjpTTPkkW+9u9PUeqKT/kqYjGW34i6hvQfGoCLsdJNK4tcG130J
         zc7JXjUlQJmAqNygBZXjncIIBCIFwbkCsq7S8Cn/f93qWLqegi8o5YtuUgWAjFROKG9E
         GtHeMrAIMwmSJGz0RjZi+ebFBUcibNF84F20L7+YmfBkQ46KI7ZMFQkvRTMbd5DDuHnd
         JElEwXE2PSDo863dbeijudiL6Vi32+qgW+Eopbhf2Tf1pjDO9UrsJOdPkzdat8qiGLTd
         ueLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792166740; x=1792771540;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5ug6v5uuguLMr0+ls7SFxJsomUB55a7qx3oFLi85A2w=;
        b=raeAJ8oHeoEd4e/0JO/Ur2DMzRMtpfAoygzDEF/s/hy9szcbslz2ORdzxL6vjMdPeh
         RSmoU3nU9kguGpi6nBacXiqeKSxfb0u1WgYCZ3tqs8xoOJxnebndldRbAv9iX+NmnrE1
         kFWfB5yx6hzQhYWxH8shk3ZgluKR649jXyGAPEFyEvZYiJ0ywSsRBGZk1rxiSnoFgIhZ
         6o6Kv8OLhFP+o2lR5cMUZD3MjjW9YehJisAQN/rE4SOWWcAk0Mka+9CbccRYITLbHQTf
         7SyevvgX5Q1VHZV0bVYWCyWOT76WGL70qInOcN6nGfR8NqrgrDoyR6ji4TULaBJUN2mD
         jA1A==
X-Gm-Message-State: AFq9FYJuGInD/iQrVEaabDnCiXQi7hargq3haI0Jst1bYrU/pXrXK0Ib
	hnayrgRiAwmxC7H5iD+ESB5PnYChBhKF7Vxva3Z9GFQD+rdSoQn2qdZB
X-Gm-Gg: AYBFou2pGTwMEfpsFtFNS3MDyhco7xXOP1Yi5Gn05W6qG344GqQdeGHYxCbOERAH3qx
	XNFo6+9RwrxuM+6n7XmCcJwkG2Jbogp+Is6TFK4albV6urkGjFmCTfkS7NyaWLBNvkC2yW9Zd1p
	prPo3OPIFpYeUjugYfMwqfcqyUSsjfmunfmSw4ijukm96x1NKwWArCqRWtWWKavEhVpZDQg4Q8v
	1yiqk47mQKXsSdAQXB1cNUXxSjFKh6i/95mQ78VZW7l3yJW3SY0xQ0ImWJ1p2V6DH9RadE6wVD1
	ZJnIPmMRvLh8JLN351jx87zX3MREdsbBJQUgQwkcoWI+hBa+ca9Y3Wu09U2zt6q0qP1Qmwb9ZMU
	pG5iUy9J9daQxX9GpcouqahqQhX7Uou6n+efl+mb7xAKqSxuqPQz65+AB6wwGr8hlhOlYeJcppV
	AREa7+KQi48PuuO165PhuIaY6anIDlYtWxs6mSy1nAnIa9ffD1dPgcI+in/8XeWOmGVAgv5jol6
	tv6XHv0fithc/v9twUYvL3zPf/dkGRMfY+2pXn2B1HfjxlUo1/gsE//8zd2yhjSRntKl7okNHSp
	bi8=
X-Received: by 2002:a17:902:cecb:b0:2e9:569a:214d with SMTP id d9443c01a7336-2e9a6e555c9mr2838805ad.43.1792166739835;
        Fri, 16 Oct 2026 09:05:39 -0700 (PDT)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e834f32sm12220085ad.41.2026.10.16.09.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 09:05:39 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 16:05:38 +0000
Message-Id: <DM6E35SUH95A.2B7HJ5XOTFJHS@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Run tc_edt serially
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Qiliang Yuan" <odys.yuan@gmail.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Shuah Khan" <shuah@kernel.org>,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <20261009-selftests-bpf-tc-edt-serial-v1-1-f72e045f2465@gmail.com>
References: <20261009-selftests-bpf-tc-edt-serial-v1-1-f72e045f2465@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 09, 2026 at 09:50 AM Qiliang Yuan <odys.yuan@gmail.com> wrote:
> The measured time includes the time the sender and the receiver take to
> run. When test_progs runs other tests in parallel, the sender and the
> receiver compete with those for the CPUs, the transfer takes longer,
> and the measured rate falls outside of the 2% margin.

The test is flaky without -j too.
It's in DENYLIST.s390x in CI since Dec 2025:
https://github.com/kernel-patches/vmtest/pull/418
and it fails on x86 with ASAN:
https://github.com/kernel-patches/vmtest/issues/503
Both jobs run test_progs without -j. serial_ won't help there.

pw-bot: cr
