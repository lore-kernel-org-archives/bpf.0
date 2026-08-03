Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD4F30E82B
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 03:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785727442; cv=none; b=PlSrQZj6Fb98M4DJSQDxkliiWfUFPxU0CZP4Z8QY79gyCQGP1UFnXLrkmIH2qu8Zj9lXd74AmtYrhzqOlHLLEPiPnhDK2MyqIDyTGSL+Ed9/5d5zkGJ58pYUVc3MmyXH006XmTfIaRZFBgQmEztzPulmM9mtL+twEYtFWEuoXmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785727442; c=relaxed/simple;
	bh=AmQyAMSuqxJJh1tRWCMHVryQkgDZwg+roMr9ttIg/+A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=pO6lxwim7gnzykc1GQ7Zz6D4YTI7wfhlRKWditjdD5dApIqy+sVWY45jDGzm02SB3ZpOyJptlj/8mYHDFsGGrkf+MECj0R2yN2EoOen/x2oGxBmNGDqaRlFFU/+W/l39GXMZpVdDIZL8CJCtxM2hGc3OivSeDY4Fwp5pTydf5gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjaHKABX; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjaHKABX"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-472365266f5so1489794f8f.1
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 20:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785727439; x=1786332239; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rw7cSHM2gPv3aimZBxhTVVl7shztjpKboM+yNnNbJNk=;
        b=MjaHKABXHQHCz7NTiGYajRNy5YaB3OoStSPD52E9+ebgEuYVKfAGcnxgXQTmld9fCr
         OTuOCYAzLYOAc8iTsZ7KIxkEyeJ4Qh3ZTjrtMSoBXrkxRgdao7N7kEbOGNg3M46WmJVa
         r8cAyKJhjseefEOPQ1fylyRhTNzpt2U3CpTD6BxMoLyy9MK0e1/f4D3CTIw1/+5u3XpA
         shjBBkrUo8P8cRyN3ks/4PqkZtsns3J7dvC6hPbn9EHf/EFk9TROjK0K9khgJmYbIQEC
         h5Ox9X+WknRbl1FIdtCmo71r5SJNeZDAnSRvGFzYRTjI3wWSrua45Y19wvX6sld3Q+Q5
         FgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785727439; x=1786332239;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rw7cSHM2gPv3aimZBxhTVVl7shztjpKboM+yNnNbJNk=;
        b=IXfWZ6M6qZq5jIjV/sAZh/1BbkEe7ojwArvZvsT/ptRlY5d7cdYtv+OJ+ySCPLxHhe
         hZB/YigtQ3sjnLU+eE0EqsfHY7D4fo+MM0oGDgJGud/myg3JlzimIKCrs2lHvH584rpI
         vJ7Ls6ZGoNFG+YBYObKaZID9EZt+ubrGBBEZat8KpetjjNpHbWlEuBUt6+qnDlx6cgTK
         5RhbNY6mDTJ+2Q6uVWfNZY/Qe/O+yB43Hd49Aqa9K22KQl7wVbLldWz8cR92cGfgDkmL
         PCLkF+Rc499qX8+mD2Fx3p6l+6IyNlJJ6Cy2/ixq4GYdUtBDeQRS0cxhEA12ncJk+lMo
         mKpQ==
X-Forwarded-Encrypted: i=1; AHgh+Rous3EvdBEucy/UHLjr3uk3QHS5+GTkzYKNVDbkqHwcF5CVyHLVI5A6tcRtKpP6tCjO6M8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvypQtQxJkX4rVQjcjYGp8gCZ4HpfHcol0JBIdP+9adzkv8n3F
	ixKAgxVa+nlbyHgs9OUiCiSUXuozd7jVeMLQRja3LItPRF65DezfiSKZ
X-Gm-Gg: AR+sD103UGfCqbLbYdVXTBfkMRXJSzTKtOc3UBKUJOMsaK2MFnt/RyeyflznixHk6YI
	qnJ51XMAulv1SlE/Lc7p2PHnlJwffVCm9nBmaFzngzPnq3QkQ89sfUJio6qnhZQmaHQ/AVRHPBB
	+33hNnjhhJ9OL2TgcWbYYkWRdu1Gc1ByCp4afEKuGT9MfTWDSBrNVPPfN/H1koVtjyjVPvVbiDD
	m0wGEJ7FRP/Lpm411XNh2xClUvQthD5JfZIfWapVwxm/+wiucDqigKwo57MNllUaeBNHUdypZiz
	sPsZpYDkajONAi9zH/m0+Lr0zpS7TDKyMdKBzEEbtOyVRyVvF9iNiHw4Rsuvm+GYbqYZEzRt6W+
	ahGBcFzPQsAEQ46TBALjqg4RycxCVnL1qHjnErrCme8JgZKf6mxeljwTTrK4BJeXjBlCxQTVnPU
	nuCDyNqpsRpkxh17GvSDcxU/ECFFGS5qhpHnGm9i2JjatUfIsLaYgX71UCkYfvoeHjEt6anKNw1
	o77QIQPn2rmT8Sp5WtNTGpfU05V6mgLA+tWmxP9yROoZhDM9wBXCrl+j3sNCmrx7x+Kre2RgYYk
	ZSR0VlyiRDYuAeJDWBl+NTy0eq4=
X-Received: by 2002:a05:6000:40e0:b0:46e:8226:96ba with SMTP id ffacd0b85a97d-47fd72a81bbmr16303883f8f.13.1785727439093;
        Sun, 02 Aug 2026 20:23:59 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41e2abbsm29407343f8f.9.2026.08.02.20.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 20:23:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 05:23:58 +0200
Message-Id: <DKEZJO5FZPQA.2NBTLV562CY3U@gmail.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Ihor Solodrai" <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next] bpf: add BPF_F_SEALED flag to seal BPF links
 at creation
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "David Windsor" <dwindsor@gmail.com>, <bpf@vger.kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260803021643.2189641-1-dwindsor@gmail.com>
 <CAEXv5_iXbExVvOSyOu_BsNeAjhqBOf3880vfUDbfLNmKPgLVXA@mail.gmail.com>
In-Reply-To: <CAEXv5_iXbExVvOSyOu_BsNeAjhqBOf3880vfUDbfLNmKPgLVXA@mail.gmail.com>

On Mon Aug 3, 2026 at 4:20 AM CEST, David Windsor wrote:
> On Sun, Aug 2, 2026 at 10:16=E2=80=AFPM David Windsor <dwindsor@gmail.com=
> wrote:
>>
>> Introduce a new BPF_F_SEALED flag for BPF_LINK_CREATE that creates the
>> link permanently sealed. A sealed link can never have its program
>> replaced via BPF_LINK_UPDATE, can never be detached via BPF_LINK_DETACH,
>> and holds an extra self-reference that is never released, so the link an=
d
>> its program attachment persist until the machine reboots, even after use=
r
>> space closes every fd referring to it. There is no way to unseal a link.
>>
>> The sealed state is tracked by a new bool field on struct bpf_link.
>>
>> Signed-off-by: David Windsor <dwindsor@gmail.com>
>> ---
>>  include/linux/bpf.h            |  2 ++
>>  include/uapi/linux/bpf.h       |  1 +
>>  kernel/bpf/syscall.c           | 41 +++++++++++++++++++++++++++++++---
>>  tools/include/uapi/linux/bpf.h |  1 +
>>  4 files changed, 42 insertions(+), 3 deletions(-)
>>
>
> There is deliberately no selftest for this, as running any such
> selftest would necessarily create a sealed link, which cannot be
> cleaned up.

Let's wait for more comments, esp. on whether this is useful or the right p=
ath
forward, but I'd still prefer adding selftests to verify various aspects of=
 the
behavior if we proceed.

I think the point about a user being able to create many sealed links is
definitely valid too, so it might make sense to keep this gated behind more
privileged capabilities (if not already).

For tests, we might have to force decrement the link refcount (after verify=
ing
it stays elevated after close(2)) from the test. It might involve some crea=
tive
use of a kfunc in bpf_testmod that can do the cleanup for us to avoid wedgi=
ng
the system on repeated invocations of the test. It wouldn't be available on=
 a
real system. It depends on whether we deem it important enough that leaking=
 the
link on VMs running tests is important enough. You'd probably have to run i=
t
thousands of time to exhaust memory unless the VM is provisioned with a tin=
y
amount of memory.

Anyway, let's get into all that after seeing how others feel about the conc=
ept.
