Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02E02773DA
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 20:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777061811; cv=none; b=THWVUE7k7+7Iki05+LdYr/n7EdlX7Av2l+akRodvQRHruJPneBoX5t/AC0QTg89S5aG/uYcuOKaBG7oLhHXz3ABgYkUIFTQDW09iOt2AR2IvEHTux+yBnpPyMAm/fL8x7LoBxIY5H+jn44AO0MoARUpqXqmuMIWOA7GNpz2F0Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777061811; c=relaxed/simple;
	bh=0ATpinyhZLa/pz07NKPfrYEC8Ia8kxnpRpRKn3rb580=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=O81/ZVrUsyj95UB0UOqQhHh9dzAO1FeEy+OMu5cE0Ts/Hs/AtuCZOzUzD3Tb4AujFbRtOJY2QcSuCrgTvfjKmfQP81tC4++lx1rxg02MPro0vma+vdVMDe07lSfoplMZMBz/Z/Gk9fVGM3l/W01/KimhCLpXbEfVfBefCba1fR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=y+Dujubp; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="y+Dujubp"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2d868d014a5so8147598eec.1
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 13:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1777061808; x=1777666608; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcW55QyV6ypNR4eKSM4ztqICyZlAQ9U3yzYxTyxBMPM=;
        b=y+DujubpLwPQqoSbCuGGhEhcYiKlmnsZp0a+B0gyWvQOB12O/igklI8Q8JTKzCQKeT
         hDw5tR4Zs971bl0aYvVVkO2kuj6tkwHgatba+Ez7POl6FB6qir43SiWBxzYLYxowxthi
         Mr1ypFodz89NEA8Tft3yAw28CSlBQ5fG8B3QxG3yK3HOZxT5OD+u02v7RC8v7HUzvla6
         o6zFkU48GO7Vajk8EV0ebUx4jm+Oidg9FzKtaGlt9pbDE+w1lbZSOlyQKMGtTQg45MG6
         R0DC33gbpM7xmZWp+rFQz6AKxd+PE9uPxzwCuPdwrCKNBwN8hVRrxRiFd//h5wQvi8XR
         Zbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777061808; x=1777666608;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AcW55QyV6ypNR4eKSM4ztqICyZlAQ9U3yzYxTyxBMPM=;
        b=dG7tgrZOucY1lncEovjZH+webv+4e102+WthBYBmtaqP87UpSKu09yVRVeVQUYAj21
         QIJPylz0CvQJ9x26IjSv1vDBHOd+7jv0naY4ByfP+iFcapNtl7k5NMzag/gvBhcvknPm
         yTPDW8Cv3faVrsBLvpIDdw+WcS4y5h3g8f5Md+vNXHStnpRM86kHTZYEfzeJtdjqoCwL
         KIMcuZEbIjjw4svFO/h+7eddp5IFw9uf0Fl/MbXMGgkSouBWXETwpPJdG18hSU0FFau8
         bU8xwJHmRoxCRCaxgvVnWBt02R2c4w26IJauloA8DihHl4IOdU8fyJxpIf2GoCAeM0KK
         9EMA==
X-Forwarded-Encrypted: i=1; AFNElJ+RnY8wPhTWXiQ8GN0cCu7lEXdQIueI6RQGTVxiQzvYvqcTq7yAEyu577HVJPM7FFFq0DI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY8paqaYqE8ioI9pnDdWD0JLfMDP/BW/pQ3hVLUzZNcn78iwgt
	OjAwNGks4F2Jvvu8RjlQoK5Id53UH/gi05HvGHe5oSbKSR2mTh9e6ES28N0EQnaV9y0=
X-Gm-Gg: AeBDievalT+lNQOL+zLscqnPzuilnQ+p/w/7dfKc1kQnTyLM0FxTTjBg3ojWAtdJ63P
	+XIDw1ubr/n30XVSwBcLoKbx5E5lwCIMRhipyquspi8qUGTcvwA+2w5JUKlxFl1O1sNhNT70Gtg
	d8X5kSGnSVrTdxWHAzkwZrZAkSHlbh5/BRgo9YKu5L5nBFTs4p3syqChvDgxm02XWgZuRShaW3e
	dA2R16+F+6M56wr1YmNvfAylKdU7Pvlb5PWE48W13AL63Eow0bDBShpKWs3h9V49VrP9gG8BJR3
	JJpspcKqlMne42GW4o6ibUlxtxFPg0fXqWFMxiLH/tfSbAfK0htoKMlXRtxY2JvIfN0n3+3CWCh
	/J6nO5kfb7vPDG8ugOOQ7FmJXlu6Jmz1Br3GHzgWCsylbCoPqJaJl/Ee0ox9iMy1oV7Txa8CLvG
	co4/BXfYyyEKzQNA==
X-Received: by 2002:a05:7301:fd81:b0:2be:80c4:2c8c with SMTP id 5a478bee46e88-2eada6d6576mr1907496eec.8.1777061807663;
        Fri, 24 Apr 2026 13:16:47 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::9ef])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce0f5sm33350443eec.17.2026.04.24.13.16.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 13:16:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Apr 2026 16:16:44 -0400
Message-Id: <DI1NU30EXXE8.1UYJFT5BV8H36@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Weiming Shi" <bestswngs@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>, "KP
 Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao
 Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Barret Rhoden"
 <brho@google.com>, <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "Xiang Mei" <xmei5@asu.edu>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add test for arena VMA
 use-after-free on fork
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260411112944.1455470-1-bestswngs@gmail.com>
 <20260411112944.1455470-3-bestswngs@gmail.com>
 <DHQI86CY1QDQ.16RMS5QSX99EC@etsalapatis.com>
 <635af96f-3a8e-4d39-9df5-8c66945bf9e5@linux.dev>
In-Reply-To: <635af96f-3a8e-4d39-9df5-8c66945bf9e5@linux.dev>

On Fri Apr 24, 2026 at 4:01 PM EDT, Ihor Solodrai wrote:
> On 4/11/26 10:33 AM, Emil Tsalapatis wrote:
>> On Sat Apr 11, 2026 at 7:29 AM EDT, Weiming Shi wrote:
>>> Add a selftest that reproduces the arena VMA use-after-free fixed in
>>> the previous commit. The test creates an arena, mmaps it, allocates
>>> pages via BPF, forks, has the parent munmap the arena, then has the
>>> child call bpf_arena_free_pages. Without the fix this triggers a
>>> KASAN slab-use-after-free in zap_page_range_single.
>>>
>>> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>>> ---
>>>  .../selftests/bpf/prog_tests/arena_fork.c     | 86 +++++++++++++++++++
>>>  .../testing/selftests/bpf/progs/arena_fork.c  | 41 +++++++++
>>>  2 files changed, 127 insertions(+)
>>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_fork.c
>>>  create mode 100644 tools/testing/selftests/bpf/progs/arena_fork.c
>>>
>>=20
>> The test doesn't work for me as advertised. Does it fail for you under
>> vmtest without patch 1/2?
>>=20
>> The test doesn't fail on base vmtest for me, even without the previous p=
atch,
>> because KASAN isn't turned on for the CI. With KASAN the test triggers
>> the splat just fine.=20
>>=20
>> Should we maybe turn on KASAN and panic_on_warn by default on vmtest?
>
> Hi Emil,
>
> I just noticed this message. BPF CI has KASAN enabled by default
> (disabled only on s390x) for almost a year now [1].  Did the test fail
> locally for you, but not on CI?
>
> [1] https://github.com/kernel-patches/vmtest/commit/5db11d295888c3f048021=
a15c3a8a9875c8612c3

Hi Ihor,

My bad, I misspoke - I thought the CI was running the standard vmtest confi=
g. Since
we're running KASAN on the CI it's not an issue that the vmtest config
doesn't have it on by default.

>
>>=20
>>> [...]
>>=20

