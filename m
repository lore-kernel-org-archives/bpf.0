Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAB51FAC42
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 01:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768959183; cv=none; b=rgwU+z6VvezZ5BYTCZ4pZTkrqzXXFSmqDjCY8jbIB1M2tV1KMqhHWFbQXLoo4ojJdFH/IcrW7PNJOmWIgi6L+73G5tfawDzatdqQHDXcp3NJm+KUeo2ScYXR17mSA5jvD0RkHzPjIxeeLcfKFGDLcGu1Zd+tu7JO6Y8VSdB/Xjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768959183; c=relaxed/simple;
	bh=hT9gGp+GTStA+p0XTftxURymXw7pEgxx81yY6VDE3+A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SxWyLr3/ZdaLniHqzK9mivdCpahNeHk6o8LZ8T3Xj46b0Oz0k4I0F9Q9D2pt7PwUTO8YKSQXM30rV9UVWC/PPCa1ta7KYB0MZrE86PvqwPTnisPQXIsrF6j23YCsEr5ljyCSwm4guP3Gd5wmsNdagSt1U6jPl2+5lWl2QcffWwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsL66bGD; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsL66bGD"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ae38f81be1so6768180eec.0
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 17:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768959173; x=1769563973; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hT9gGp+GTStA+p0XTftxURymXw7pEgxx81yY6VDE3+A=;
        b=nsL66bGDl5jBZ3i3dYtIhunMBjsiOoQ9kL2L6NHXfTarSY5ZmS87UelzwSk67u8cCk
         uDk8rLK5Ublm+xbCtwTikS7fIb+hft3zJJ6SHZxJrki/GlYZnOIVwkuiQ0rh6L4eiHit
         Pxr2sVvQtUEpTxnbvWlRNorKK5ifc8e0D+83EWQF0gsfCWWfpTwXhb0RAKEDxMfzKZ0E
         49t+ZwXTpW4zzu2WJA9HepGEKVz0zPh4C7fCizMy6PC3GbXazNemXi8yGYeKc6vg5vZN
         juTOMAUXqn5Aia95dhqimkH6gjcWxC/SZIuG4iOIVDgKso9fjsJf/47WH105HL1gL7yl
         UXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768959173; x=1769563973;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hT9gGp+GTStA+p0XTftxURymXw7pEgxx81yY6VDE3+A=;
        b=wI8a6s6qcRwADWnRzouO25W8C2YZp8CWPkhVBZ+tMx58FuJWTsoatOE2jBezenP5HR
         XCUlxOJdmZ7yrpwRa/MyEfthbsbmE0XBbEy8DysPqILCQftcvBiGDs72kZCe2w0tfugX
         MNluOeyJ2n4kR4UdtG2BQYhC0xwOySgF+Y8+yRFmrSLQrmVgIS2w4EhE9VL2eH9kCFfU
         xdaQIw2xlKIr8R0G6xAU1p8ArH60Mx8LCWIqvMCim/x6zYXwchv5koOWjr10iBpYr/to
         YTzZHBRzB9uwKqs0kr0r4LN3dW8VGkPLZVm1wtzGOyYuko/m4aafqi4TXm4Bu8trFAc5
         d2hA==
X-Forwarded-Encrypted: i=1; AJvYcCWubTCrqD+lm08y1Dqpec+GMECpzv3b4Nw9LojP5FHB3Mzv/636MDTg5scdCjNd/eZ+6Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgs1De8LK8wKAabRdmmoLhR9Ji3iKTylOVR4o9c2s+WGenZcNR
	viDxUeqTcdURnfqWMLNZ/8TQxJxI58tCyqcVTxTJ9HCnJtP4rR5FsEO1
X-Gm-Gg: AZuq6aKo1Hr4qkFn3xVdRfely9HRm52JPo4p8tFGEfvlSWsEI/oJtQn54AINnBF09dP
	YCOLyGYwHgt5raODgOQmXkhh8+e2AK6SQx7XCvxa2BMiG6+4f+v//KyVsvGw75phHGiJtFq1PXI
	dBUk6UyO4woMuib1vYVBD501ecswN06+gpGGQUBtsFEplbeseTzAFXr0l4qB8ukILUwqrwEHnM9
	NkxBVT+rPRBcG3WmdLEen9LtOFeySlvKMx8+YGBY0WtMQvO0wWRjEmytO+eWG1Gmf643ge744L3
	qW712aiw4NYoFa4OMU+5XSfVieLosszuJz+AtdLlE2JQ6+1VGIYVyWA4plicXGExS2Cg6njxmkM
	zRFG4tYKlcckv6UMQUykYsh3X0CQ/9QEuTXyCI7x0M0NvgW0fPNcrCF7U3xgziur8NhKJYb/OEl
	aaZaZ6KQy33UufgBzAXvW8Fz3x1eNqP4ZkwzuKO9WqtaiANOvlLCbv8CJ/+zg4qTz7fkzi
X-Received: by 2002:a05:7300:690a:b0:2a4:3593:c7cc with SMTP id 5a478bee46e88-2b6b471331amr10168060eec.12.1768959172969;
        Tue, 20 Jan 2026 17:32:52 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:6a7d:961b:9e54:4392? ([2620:10d:c090:500::2:634c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b34c11c4sm19194701eec.1.2026.01.20.17.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 17:32:52 -0800 (PST)
Message-ID: <bac96afe1a99c6a12cd85285c677f4eedcada066.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 2/2] selftests/bpf: test the jited inline of
 bpf_get_current_task
From: Eduard Zingerman <eddyz87@gmail.com>
To: Menglong Dong <menglong.dong@linux.dev>, Menglong Dong
	 <menglong8.dong@gmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, davem@davemloft.net, dsahern@kernel.org,
 daniel@iogearbox.net, 	andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, 	john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 	jolsa@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 netdev@vger.kernel.org, 	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 20 Jan 2026 17:32:49 -0800
In-Reply-To: <5071056.31r3eYUQgx@7940hx>
References: <20260120070555.233486-1-dongml2@chinatelecom.cn>
	 <20260120070555.233486-3-dongml2@chinatelecom.cn>
	 <CAEf4BzYzT2OUQ37BvzTRyo5Ah_t_CXv=AJixtAmU_pgr8eLpLg@mail.gmail.com>
	 <5071056.31r3eYUQgx@7940hx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-01-21 at 09:28 +0800, Menglong Dong wrote:

[...]

> Do you mean that the CI of arm64 doesn't use LLVM for the selftests?
> I noted that. I found that there are other similar "__jited" testings for
> arm64, is there anything we can do?
>=20
> PS: I tested the arm64 locally, and it works fine.
>=20
> >=20
> > So we should do something about silently skipped tests at least...
>=20
> Like a warning?

Yes, probably llvm-devel or libs dependency is missing,
hence jit related selftests are skipped. Same thing for x86.
Discussed with Andrii making llvm an opt-out dependency:
fail selftests compilation if libraries are not found and SKIP_LLVM is not =
set.
We plan to address CI config issue tomorrow.

[...]
