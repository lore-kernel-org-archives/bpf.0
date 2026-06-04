Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42C92DF15C
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780592738; cv=none; b=IXhP980Bji0451PUT5l1fIuJcv0/5A60Kxt2E7jGQlh4mUO7jiPjsKAAugmM0sjmLiXaEiEXuOXxHBhPLUYxFpNn+7wetHsfdVutS1i3wfpDkrHSGCB+ridG0084U+/qJEyGhBI3T9aPXgpCy+g10zCYWVRK4TS4tlI4xBGy8mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780592738; c=relaxed/simple;
	bh=l1WZwA8nhbBK7hwJWuX8RcExIX6FfYi0Dnq2bn2OwdM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Xj5gnuAiuD2DtnObhMQdvOTGV4M5DFVPKC54Shzm3Iqui2Jm2MUISelSv/g7XoC+wy3xbQ0g6fzb5cor6FliTl+OY0jSIKwi2b5HKwaWFEdjHOAMJyxxopeVXjhKceJxmHHmIgUx/peUsSlrh+FSx1oxIXgFFJciN5XJ9MDicxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=m7S5YxoQ; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="m7S5YxoQ"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2bf1cda2b17so7463725ad.1
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 10:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780592737; x=1781197537; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3l3X6Wowat27xwCCkDK7d+XzQWRyAYhwmb8fwBpPQQ=;
        b=m7S5YxoQNt2pxZ1CtJFWbSesc+tIqDURDJKKRB0QqbufmSbjR/MqJRahCyXv90a5wb
         ++qtyIk84CHFNbtbsx//exQNxAyuGLuNj/ylmZrRVrEnZdjuiqRgLfe5zzobK5qyAwf+
         mUhUoeq8DV3YG52mJftEwVM7JFCunJGSj4Uh0jLsppfI9fKj9TH7dxjw5yde9LjhnDWY
         VAv+S2pF2EdnWXo8/7CgrniQoZ8yQcd6efX2f4ll3jI+E8CUFUbdY70kRFgqn3Z/lbV5
         7C3uFjE0FKOS5IWsWRrnyEt8jEyquL+OTMfpFP1qa+7I1dzg3v/tLhTIv2MTvvQunYry
         XtOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780592737; x=1781197537;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W3l3X6Wowat27xwCCkDK7d+XzQWRyAYhwmb8fwBpPQQ=;
        b=NNrqxBf9oEMr7GBdN3CvKATXSrVYKUCUdww2sof2RfKw1hvwUapvcXcACmu7OssuQQ
         e/of7WGAIN/J7cvX5FOttlVlSMK/GJZgOeA6ClWfWUG5Iw1Dufkg04ilCG1NAt/WKEzv
         IPWyfi9AA6iReocd5EKcr7i1n+rHmo8H1No/Z1NSzAUEnTv8thosk3FSNBG7IFQKcyJx
         HsqnfX0VgI0uxJiofLqaQ2ql9IGgHZK1/m6mWpyHMe2KciDyUOniyEFUjfjTP7F1I54x
         zbzk5VQ7s64j+axERsrVUgCcPut7rOQ3hv/tjJ4dMZdBzCpqSbpQC9rilrbVrU07pPY5
         e+iA==
X-Gm-Message-State: AOJu0YxBIHMKFZ79RImUcF6u6cnRoIJMc5kTFNJNsotkhODULopgMluL
	aHEb7+W7K70m3DrRwGZrzxpG6an0MTzZawoFj8+EJCFJ4QE5IxxCoD3APsGEZrOO5IuzFXnj2x7
	h83MCMiJ3PGGxwqQ=
X-Gm-Gg: Acq92OFY//XfgQXC6cEk5l4EYgCp+bESs3mlqyIsBTrsWWVtyu6Mzx1F5JRWPzHDJ2H
	fsurHLstzd4+dvfHHlUSEzM/BiuGSgKBE6fPmmdyIuK0Tn4Hehzmg6fUqIhggVE1i/MJVWe5EO2
	Gs434+Iy+Xj7OIfF/XR07cwfYEwQrYfOaBFPhNjfbfbg/28Rct+QImOc6RkRCoucmQew111dh08
	Wbj46knSCWwfPRQ5PXsinXcspSccrlSggSA+VodVwbBAOdmoY1mPrA7H4lkpRS/QtIshRqaPjIe
	zV0HITLVZBmiP79CD5f0yUsGK6DBl0Oh3uuxYGC2axzexQ52j3M40D2SJCnrNZ803fzexa7Vsmb
	n+u0aA9wia8nM2TH9j2R05BXZQd6m0nyP+G1mdtqRd7ehdkBm7wLDzcW//5f4YtAAUBxdcyxkxl
	tnLcZNSmLQCIwShtBu43y6q9HNK0aMrHhldcwvQffH1dMxFQ==
X-Received: by 2002:a17:903:19ee:b0:2bf:1845:baf5 with SMTP id d9443c01a7336-2c197e61f94mr42483265ad.12.1780592736881;
        Thu, 04 Jun 2026 10:05:36 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e573sm64493295ad.47.2026.06.04.10.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 10:05:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jun 2026 13:05:34 -0400
Message-Id: <DJ0FG1XDA4ZU.3MA6IY4M6LA51@etsalapatis.com>
Subject: Re: [PATCH bpf-next v2 0/3] selftests/bpf: libarena: Add initial
 data structures
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
Cc: "bpf" <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard"
 <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Matt Bobrowski"
 <mattbobrowski@google.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260603182727.3922-1-emil@etsalapatis.com>
 <CAADnVQLCk1gVt6XOcZnuvsULx+R+T0DaJBQ7-sYHFSaEKPW=ZQ@mail.gmail.com>
In-Reply-To: <CAADnVQLCk1gVt6XOcZnuvsULx+R+T0DaJBQ7-sYHFSaEKPW=ZQ@mail.gmail.com>

On Thu Jun 4, 2026 at 12:51 PM EDT, Alexei Starovoitov wrote:
> On Wed, Jun 3, 2026 at 11:27=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis=
.com> wrote:
>>
>> Add two new data structures to libarena. These data structures initially
>> resided in the sched-ext repo (https://github.com/sched-ext/scx) and
>> have been adapted to the internal libarena build system. The data
>> structures are:
>>
>> - Red black tree: Fundamental tree data structure that can also serve
>>   as a base for more domain-specific data structures.
>>
>> - Lev-Chase deque: Queue data structure that allows efficient work
>>   stealing, useful in scheduling scenarios.
>>
>> The data structures are accompanied by selftests that are automatically
>> discovered by the existing libarena test_progs selftest and incorporated
>> in the CI.
>
> bpf CI says libarena tests are failing.

Looking into it, the issue is not manifesting with LLVM 22 so trying to
see why. In the CI, the compiler is generating code that is doing
the address space translation then still dereferencing the scalar
instead of the PTR_TO_ARENA like so:=20

r0 =3D (scalar)
r1 =3D addr_space_cast(r0, 0, 1)
r2 =3D *(r0 + 16)

In my opinion if it's not a programming error we should prevent this
kind of code sequence from happening.

