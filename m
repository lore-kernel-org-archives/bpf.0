Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2243BD644
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776437030; cv=none; b=dfxZY/ODxVq2o4ugmTEbTyFK4rYQlnfMXT800p+p+l6lNQjZBmM4ti4VBTqcUYWX1MFM+WD2lvwngMDkYOkN7ZX1o7B04NuF10jcjHlv4A5xeQuKDhY89+WV9lfE9DQ+ZTkUodK1au8YQMI6EQ9s7joVXAjhsF0/UeTqlpEEgVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776437030; c=relaxed/simple;
	bh=zExflP75gQf0oQqOPBmdCtbc26dwNnHym90L6bk8+Q8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qR23bGSF8bDu2reJmQagSyrKlqXQnrRsl+iA3uCz809cMZYTYZE9x2e0wNtnOylBogh1cfH3xgkPP9llZrBKT+4IqFdoU6MamJrLjwTlh2rHHnASvUgdzVv3kfQSWm8qks2wHeysQ0+6Ex6jCi7vNe0+sNO7Oka9hjOzWT4698A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=arUXwj7W; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="arUXwj7W"
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c795f75e971so362393a12.2
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 07:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776437027; x=1777041827; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fs9BXi/2izGug8X4JqpoDqxUY/imNcCggYfWPLFDoNE=;
        b=arUXwj7WPcbgmzztDMWr1glJnFjTvJCzkoPNWzBSeiNDyHIY5Qb4UD2ckUDUd31t6T
         9FlxgqAp/VBaKoEeaBBTxVhNBGa7dt5/HbInTKKfrz7GweQOcnDlgHTJHJYM+rEv/iiT
         P7PmIgWhWd7cG1jb4w8Sq0eLAwEo8mmcyo7/dJJZSctR4Eby5waXZQxodzYmYK1vckJG
         IxxCKH0ckhyUYQAwQqvaklE0d8y5DoSeAvoWHWNhfZS9jtDWRal0bjV8oT1Ln7tpHqUY
         PMrIuFcyEimatI2AqlEliWZVTyWamTeseQ0Uf07LcerEOhVjKluobgBebnLM9cEPC7/M
         Ma7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776437027; x=1777041827;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fs9BXi/2izGug8X4JqpoDqxUY/imNcCggYfWPLFDoNE=;
        b=X/rOwa3ArDjl3hgjH+J4Ia2Dmc4/yP/Aw6Aj092hMqZiXGGW4lmJAJvCdpJaah0CeN
         M7uHuWGb2yw5xLg2oHfn2K0alesTNZ9eQ8REVzw7/BpWZls0FJAvFlJnJTXd+29FRM9j
         mtWkdGIYekemY2chnC2c7rGD1zJMtdTaFigE+083QPjOMOLjk4Ocb45rGTtQruNDoWgi
         rPHadAfcX4i9+F2UHCSaTIZWS5T2P5Lp3+ghhw1F/BWfZwaEsQEOok2siD5UNEFOpip3
         9jEbF/9KHLjzQHYYd7o9qPl7dQbvvrJ4IONshQY1YUpep3L4wVdxipaIOplAhoUEQBul
         CE+Q==
X-Gm-Message-State: AOJu0Yx2u8sB7l07UCjMY5slb1EpHn/jzk25U0CNYn8a1Yy8BXsKCZHM
	31vYGl3tZ4qnh3h31MInT1hrqm/cl0KD3JmfkvJ4rvx1lrk/mesQ1aY4sdN6kAD+n4M=
X-Gm-Gg: AeBDiesTUibggnjq8vm8LawlRsdhN9ohL6DWxldr4cgkYiHYq3Hd3cReyeOZNZKfJSo
	telxyiytKUp62nLZBfGSQ0/DELD0wE+vZu0BukWD/JZU/RhJ/3EDxTxN1vfWT4KIQ/ycFEjoJTT
	O14Bllnj2iGQ5maLA6kdL7yOL+lDskzzOMLp5WXf6hk1rxZQKyAzm91oCoy9t2fknRmvhqqMBLb
	1273uHnpEOQoTKSOwGUE79x8OAxM5p50sUh/XkpyDdv5ktjjv6miWQgVsv9bUUpbDsWJ41H6Cyi
	qaivoyB8FsXPMXPkNnFqU9Rx3xhKok3o9fNTjl8cjyvgn5Ia9HD3RZrJ2WFY3xuaXbkuXpFzyf+
	eoT7FFeLT2Xwk+cipKCiimRtGSLo6bNbzJN5i4XOTWwkAT0lQ80lZ9xBTfGeXehcIa/lb9LSVF4
	BdmrhgoadP+b7ACDYQjg==
X-Received: by 2002:a05:6a20:3d82:b0:398:c0ba:9cfd with SMTP id adf61e73a8af0-3a08d67d89dmr3619709637.1.1776437027313;
        Fri, 17 Apr 2026 07:43:47 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f9dfc8sm2026190a12.12.2026.04.17.07.43.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 07:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Apr 2026 10:43:46 -0400
Message-Id: <DHVIDBPOK7I3.2837ZLDGJOBY@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <song@kernel.org>
Subject: Re: [PATCH bpf-next v7 0/9] Introduce arena library and runtime
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260412174546.18684-1-emil@etsalapatis.com>
 <CAP01T754f+qzWDG=9PyDmOXuL1mn9R9UBAtUor-RdzDGMGZx7Q@mail.gmail.com>
In-Reply-To: <CAP01T754f+qzWDG=9PyDmOXuL1mn9R9UBAtUor-RdzDGMGZx7Q@mail.gmail.com>

On Sun Apr 12, 2026 at 3:22 PM EDT, Kumar Kartikeya Dwivedi wrote:
> On Sun, 12 Apr 2026 at 19:45, Emil Tsalapatis <emil@etsalapatis.com> wrot=
e:
>>
>> Add a new subdirectory to tools/testing/selftests/bpf called libarena,
>> along with programs useful for writing arena-based BPF code. This
>> patchset adds the following:
>>
>> 1) libarena, a subdirectory where arena BPF code that is generally usefu=
l
>> to BPF arena programs can be easily added and tested.
>>
>> 2) An ASAN runtime for BPF arena programs. BPF arenas allow for accessin=
g
>> memory after it has been freed or if it is out of bounds, making it more
>> difficult to triage bugs combined to regular BPF. Use LLVM's recently ad=
ded
>> support for address-space based sanitization to selectively sanitize jus=
t
>> the arena accesses.
>>
>> 3) A buddy memory allocator that can be reused by BPF programs to handle
>> memory allocation/deletion. The allocator uses the ASAN runtime to add
>> address sanitization if requested.
>>
>> The patch includes testing for the new allocators and ASAN features that
>> can be built from the top directory using "make libarena_test" and
>> "make libarena_test_asan". The generated binaries reside in libarena/.
>> The patch also adds test-progs-based selftests to the codebase for the
>> libarena code, so the new tests are run by ./test_progs.
>>
>
> I am back in the same position as I was with comments in [0].
>
> I.e., again, I don't see anything in the stream output (passing -v to
> test_libarena_asan) when I build it with clang 23 (LLVM tip).
> What am I doing wrong? (Leaving aside all feedback about integrating
> it in the regular test runner that is still unaddressed, thus tests do
> not run by default).
>
>   [0]: https://lore.kernel.org/bpf/CAP01T75+BoQfQN=3D47NhYYviZttjCPb_CXNp=
a=3DDUC0=3DxSvdNZdA@mail.gmail.com

The series introduces a selftest for the test runner called libarena. It
is introduced in patch 9 to avoid creating a runner that does nothing in
the previous patches. Tests run with test_progs like regular selftests.
For ASAN we do not have LLVM22 support in the CI yet so test_progs doesn't
exercise it.

The stream output is suppressed by a switch in asan.c to make the output
of test_libarena_asan legible. Each test that expects to generate ASAN
will generate a ton of output. I will add userspace logic to consume=20
the splats instead of emitting them to keep the output sane.

>
>> [...]

