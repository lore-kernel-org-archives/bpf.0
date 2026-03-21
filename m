Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B003191A5
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 17:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774115548; cv=pass; b=OXIOE3uT1BkoJLMTXUodVHKr7CjX+sd1Z9ffjFIa/uw5/80Rv2QXMuNiHfINQn5Z7aUs7EBNNvizxekGyecxAiJawOm3h/FKl4mqd8UCk8gFSZ+nyetMr6LlkSEad/UG1kL6WlOPnY5NZXJoejqNmxWD3ofunRSyDC7fd6zIAEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774115548; c=relaxed/simple;
	bh=xOtivuzC1u7qs0tccX4nAuXpb2S4sLdDIsBXc16+/kM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gcVYLVD3PQ1Reyl3VGRiNdlD0bDUslOry4wuRPT5jdlrDE9ydrS8B1y8bd+UlP/ErvVh3JBq5y1h6LEcOACgYI7zZrn50d3Cxs1dbe9MST4DAErsrXzOqFdeTy3TdOaDdh/Vi0MD9j0wy5cT1ldhsS8RMpdmkfi28FRKVe+BPV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdKFXyc3; arc=pass smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdKFXyc3"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-486fe655187so21708295e9.2
        for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 10:52:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774115545; cv=none;
        d=google.com; s=arc-20240605;
        b=NZ9lbfc8V0dApbnrJZWThgnhDJlecaXvB/JsA6AX8MDCAhBBrV6u+HZ1Ac0QG453bC
         p71PINh67x6hxUa0CUjL9JkT88J1C6v4mnr6cUSV1Mkl/L8r2KLDZ63lyHHIub0dgnbN
         rmfq3PRZid8JGf6G2LTno6pGsT/jKN0EfFqD9hONdk/E4Ixi0imaMHH7pgPQIwiJE5t7
         dpq3okldDlLLDGrpeX/7v42syzBPgYH+VXtVI45LmmJi6snYrEXhNlAt6W3hD0eHS5hw
         2E+wrFlAujdYaLYH3Or665ljVz/+Yli7+QnFzFohiRN2bCf/Rmzk7YcK7plclpKthftM
         KoPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VjWmKaEpPmua1A5mJ4thcxD9fgMtwaI7wu9hm2FvvIA=;
        fh=kuelB+lDFwGqT000Zb+8fiQTlSBtz/KdWBXIXsBINvE=;
        b=iqSWIvqhNkfm61caOivjJoDk9n1pK6w2baxWdIIGnSFvp7dm0KBGc9ZzzACLLnQzEm
         uA58kqmGFdjEXxVomQK4xfqJrJB+baWAt7rslWLEB5ha5JYjeMD7x/ZNErufuvfv0cki
         zT6pcEi5RfGR4Js5khwqkV9oWQQBIWraeRybxTor0C/Q8eSl3rup8FGEHGOSCzb7VAgd
         bYkAOTtEk6bQYpl+YE0WVyitxZkS32e1J8q/W5i14Z+TnSillVoetlz8i03M6n4NbcYE
         LkQ2UjWQAEttOjmL68KZs3+kYyFoj/fqfVD70e/O54upeoHwBv9Gr3uFdFeUwTYIThBD
         SPJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774115545; x=1774720345; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VjWmKaEpPmua1A5mJ4thcxD9fgMtwaI7wu9hm2FvvIA=;
        b=SdKFXyc3QQYFe6tSK8qFbcrZuwUxPRnpmaYHH7aTvJ5wHCa2UoUM77uvUPHMNjlw6o
         02W4ju7nV+RwIMmVqUE/AFYnYSiJKjmMdfMuURdV9SEg/Vjm6dkNgTL4bb02uzB8BNzC
         LcNS/mkYH9eBIOrFMmp4V1R7y61yn+jgwkdnoPZ6761nd0PBAxk0/W35tNsuuVOCFnxZ
         e/mJtkeFvS/XpR12SrGSAHxynIgxuDErASbtOqzzFRAk/dV8ZfAwPxiTvp3wzx0/zWTT
         pyuQQnkYJ/9Cb0iyEd6hh2NLQuTQtZxR4FlF6bKWADI1Vleo8RstJCt3OvTLuQgrMgla
         c7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774115545; x=1774720345;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjWmKaEpPmua1A5mJ4thcxD9fgMtwaI7wu9hm2FvvIA=;
        b=c5eJ3ACefaWl+Ca0zdgNJ4GuxrCWo6yo6JaGq6EhDoiQY4fIAxJhAd1mA1VrGzpDH1
         x+F820tw/lToXfmqWmoKogLB/tz2rwTCeLp8qTU/Z99o33rS/8Hi2EBMrZvd4OxdG6NC
         rBjJ5EV1qUa5XuPpgq5+QuvvLW5DVv1nc6exO7VWEayNv/2GsVSb+dQI70TTHai130DI
         HTASGQ1K1Fclr/vuhM08SUAXJYUTYnUFnhgo2ZsQObU4bMtPaXJK5N4Z/NZt2qna2hJZ
         CFrcb2adiHXoTbwIjQ8HVRwuDEWwrOqZFfiVm/jFcZeRJBQoZho3YOp3EStGvMcidPBq
         7flw==
X-Forwarded-Encrypted: i=1; AJvYcCVKRAqA3ojt7ZiUydNFAuRBQ/a8ffif8anGjjGZHik/O3T61tXTkLdXqd78KtzMTfj7A+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGKq6znvEU/2eyFeD8xtsQ5Yk49lts5MLWitsaGkoQZPspwj+y
	lDBoMwof30R0/CZzorfPweM8KRzcHtQSc0Nteb9/f+W0yu695+oi+H/1RTL/GAJu/HS5nuS5+v9
	kP/mE2ouDptxwdIS6ZqX+yK40gdkuZ9s=
X-Gm-Gg: ATEYQzybAlE2sT6kM8Tlkwwuz4PBJMjxIy/j4eiNGsNHexOAvIlenqTUnPuOdilKCP3
	LoEh38ETvNdoPqdgXFdEFwe+gdc93H1RnT8bfC/yHKoyzOg+pnN0DmIA3m9rP9t1dqfOed9RTP4
	iRmrDE8dkDE5ZeOn0YgeIvxMtTC8iG8KFO6k/upm8Sujta4JbOEVzpqm/44k4EYSX5ApbBBDAm4
	O2INr11QLR/hqi77jotAlY/fOWH1qmdZUXWWF93jEuIMvFucE3BdTLc596FaljhKMCZH7r5T70d
	mCl0gwHuFQcfYwqnxUi/Z80E0n56JHfy4HAYBaLp8ttKX37vhiASdUVYkRg=
X-Received: by 2002:a05:600c:8483:b0:485:531d:28b9 with SMTP id
 5b1f17b1804b1-486fedc0070mr99667325e9.14.1774115544902; Sat, 21 Mar 2026
 10:52:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320160055.4114055-1-wusamuel@google.com>
In-Reply-To: <20260320160055.4114055-1-wusamuel@google.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 21 Mar 2026 18:51:48 +0100
X-Gm-Features: AaiRm53hX-S7iTWxzgANdr9Lu-L4x_TBCFGlJa3VypmZ-mBcKZAol4lCVpxhFIo
Message-ID: <CAP01T77hy3j5BZMBcYdadLfPe7dYb3zEGDF9daUxJHYy=+fcgA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] *** Support BPF traversal of wakeup sources ***
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, andrii@kernel.org, 
	bpf@vger.kernel.org, kernel-team@android.com, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Mar 2026 at 17:01, Samuel Wu <wusamuel@google.com> wrote:
>
> This patchset adds requisite kfuncs for BPF programs to safely traverse
> wakeup_sources, and puts a config flag around the sysfs interface.
>
> Currently, a traversal of wakeup sources require going through
> /sys/class/wakeup/* or /d/wakeup_sources/*. The repeated syscalls to query
> sysfs is inefficient, as there can be hundreds of wakeup_sources, with each
> wakeup source also having multiple attributes. debugfs is unstable and
> insecure.
>
> Adding kfuncs to lock/unlock wakeup sources allows BPF program to safely
> traverse the wakeup sources list. The head address of wakeup_sources can
> safely be resolved through BPF helper functions or variable attributes.
>
> On a quiescent Pixel 6 traversing 150 wakeup_sources, I am seeing ~34x
> speedup (sampled 75 times in table below). For a device under load, the
> speedup is greater.
> +-------+----+----------+----------+
> |       | n  | AVG (ms) | STD (ms) |
> +-------+----+----------+----------+
> | sysfs | 75 | 44.9     | 12.6     |
> +-------+----+----------+----------+
> | BPF   | 75 | 1.3      | 0.7      |
> +-------+----+----------+----------+
>
> On the memory side, between kernfs, dentry, and kmalloc, each wakeup source
> removed from sysfs saves at least 10kB.
>
> The initial attempts for BPF traversal of wakeup_sources was with BPF
> iterators [1]. However, BPF already allows for traversing of a simple list
> with bpf_for(), and this current patchset has the added benefit of being
> ~2-3x more performant than BPF iterators.

See, it ended up being faster ;-).

That said, I didn't understand why you dropped the test. We still need
unit tests that ensure the verifier causes the bpf_ws_lock to be
released before exit, and an example program (like the one you
benchmarked with) to demonstrate usage. Both are mandatory. See
various *_fail.c files in progs/ and RUN_TESTS() macro for running
negative tests easily. I doubt we will have any wakeup_sources in the
CI environment, but the example has value nonetheless.

pw-bot: cr

>
> [1]: https://lore.kernel.org/all/20260225210820.177674-1-wusamuel@google.com/
>
> Samuel Wu (2):
>   PM: wakeup: Add kfuncs to lock/unlock wakeup_sources
>   PM: Add config flag to gate sysfs wakeup_sources
>
>  drivers/base/power/Makefile |  3 +-
>  drivers/base/power/power.h  | 14 +++++++++
>  drivers/base/power/wakeup.c | 63 +++++++++++++++++++++++++++++++++++--
>  kernel/power/Kconfig        | 13 ++++++++
>  4 files changed, 90 insertions(+), 3 deletions(-)
>
> --
> 2.53.0.959.g497ff81fa9-goog
>
