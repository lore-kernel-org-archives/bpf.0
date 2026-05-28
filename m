Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0F8408013
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 16:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984104; cv=pass; b=elnf1PQ/ZZ2wgrmwODly/li2mm80S7wvnyEYBHo4XEh4/sphwCE+x/ghw0Z47gNtEPCshopavIyp67wMt2G5CDnt6XecItoxxJYXI2m04f2oIQD7CKO6ms8MbxB2Trs11qU/t2jD1+/xUxU6LpXB1PSJ7L3lSeYMzNhVoKf7nnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984104; c=relaxed/simple;
	bh=HoRv3ITsVYotYbByUgMqXQNPFv0UOt3EzvZpSuUdf5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DH/qHQFAgnYSWmAxV7zF/1SOkCDdD/AW2R+JWiVPd/b4/fcpD2KHo6b7yEFmJSOlzJb046tFIgz2L18BUuehx2zaIrlNiDOAnQpo/7w5gBs25hhPnZ7c0j1PIqEk74Mw07TKz8GEO6lILHmksakw219XPwZJuapXP2TTLWIwvgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T0L2C5OB; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T0L2C5OB"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50e61648f10so68441cf.1
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 09:01:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779984102; cv=none;
        d=google.com; s=arc-20240605;
        b=aUgSElUvhUsnWIbWMuQdyNKNJE32LpB6ampeY43qxOPGzatV1DGdFArRJ+ap4eJ+2Y
         1qSlUVWFbB3NE1vHZ894cHcIJLnyAbSFYqERvVaa38mEKuK+nRsZ7mM+JUvSxa00kqGF
         NNvsIA7F7aTm1ljjbKdG8sFUPyYkk+ClLTqWS0vE4rVdvDMaYuTnUtKosZYNNy8HZtRi
         Y4Rp4/cQGiOEfVUqmlU7HbH2QLV79+9O3zdmhF3Ipc5L5jM203JqPN+uHgeYmuRYUIUr
         ZfV4ocrvlyKgDT4eU3xtiImdgk0NmYYC7CI5XF+IYf2uLJlNeHBb4U1cNSni/C5MpM+M
         XutA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BYsaex7hgpDTcxP9G0jUXkwS6mGFhA1uEqhqBMmQ8iA=;
        fh=Lyzfei6KEarXcWj7oe6ocjwldwtzUCyDBks3k4+6YhU=;
        b=lU3HIKnf6TZoyxifDjmxtqWDw7uUBcQFAsutswhqUxNF9JXzDRh6T8K/eDmXq1bi+R
         i8D6iVMFMfmhGscVDhrCUkLnb9YUvQrczFbjTF50qd8wdjl3/iD/rx5xGvnXHog7zkpZ
         dZj4K2ZhCtFbX6R9u3tsS2cGh3zJe9NdXnYdl2RkoPviao/GCfJVkM++stTDhI7eapH3
         wRgdVNukqtlAx5OkYZeysfKqHlXt37E70uOM+yXjvTgbI0M/JARWqMWVtP/GE9KpEiJp
         gQIItor8zo8VT17h7A2qZOtB/cBiRpjI4joJsZAJbRZjx641LXxnYr5DqwVvJY5fq4mu
         T9QQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779984102; x=1780588902; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BYsaex7hgpDTcxP9G0jUXkwS6mGFhA1uEqhqBMmQ8iA=;
        b=T0L2C5OB5eyKIPzMHsiPVQNr1viCSihOUZmkYUM5cGPXkhMxoJ6M3OzSgpCKFExWDy
         szdyZoMpD9zxcItskA+UbPBxYHZTegez2MJySasSWzj6ryqYLVVBCl81AJjBJxO1P++U
         FtF5D4uKoHrnYsSr5CM9DRAXsFIeVDwgWTITtrt7fuuylaTUZDyK/JH8UvpmtIpQGdlK
         aYIgu51EvAqaxzk5pXAAJYZHODvlvxsKYeuG1EG5o5/LO5RAwLEQsF+iPzqDwBe1x5C1
         zEotfoDoz5fHx8B5n808J/IFfRdT7t5Z47BjvXsew4l7v5kLJ0ZNvmwtUDI415N7ev5s
         n8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779984102; x=1780588902;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYsaex7hgpDTcxP9G0jUXkwS6mGFhA1uEqhqBMmQ8iA=;
        b=WaRt1wsOO0hLc1K7KkRzVilAMf0YIGPamAz6B6hoUmheLiT4Ikd4WXhy/6hQfq301e
         gOaBTsO4iZrVARpWjS8wj2YD2CEZV2OZG4+M60BmHXab4l0CcGzJvsF+/WzeRD9DL3xh
         ZGKKOmsz9MU7QgBF+LDy3bDTfwg25XR5eeZbCECV7vIDqsIT2z7SxvOhWEsd2Nb8Sa/E
         j6FAFlbJ0b0gecB4gJE50J8OBCj+Et3r8B8a3q0H0Pk6O5uVR+Mw2OKADv+RqbVo34tv
         5L9KurfFyTlM6xgWX53oLffvpMZWz7y9QR9DZIjIoy1E9fyHmrgmCtKQqeRKIzYoI/Hu
         0fmg==
X-Forwarded-Encrypted: i=1; AFNElJ96oUNgCz7b/g2qSCQbsv0HkW0Zv2ASdyo0kENuMeHHDcjoiFxWne4MGjltKKfVMqqDuNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOT4MVmZvVXO5kcvsLAvSFlcF2pNsNMhhsLfgpwb9R142fQcq1
	4ACMWiim3awunKV8KETf/htwLQ4RiGovtQv9WL/m9k4G6eUC94t9GtwrtHLdxjuVOzytAQ8koC1
	9gSpLvZ3UOHJ2x1JA8YxiKNXnKu8D5Eg2i+JnafZt
X-Gm-Gg: Acq92OFEh0Ygkk7sDuqdf5/7U87rSEgfX/qEDbOvChxBFIA2jjVIyVOLRCcUeg+LrVv
	pRfS5Qk3p0SfVeE88v2VX6m0ezL8POzn5GSwEv3k7SZSFlzL5m1XXvGCxVapaPgvyr8hJeaq4mC
	fg0exwbV927Onel/qSpH07KHFhudJIVqxfGmxP4wbgqn/2CmEMMNPP6cYjg1fuWSsolqvktyjBC
	jy1XL/Cdk/W+IaEo8jFGW84UaCm1GALx7cKVEUHq2wBFuNVcr6eZMPhdZDB6mmvaAtXWtQ+uaze
	wyy0fOv78Y16FWCM3J7rihnchnPmHMbaKDWn3OjgP/LeoY/Ib8+gORAigs4XEf1N
X-Received: by 2002:a05:622a:8c02:b0:516:5709:45e5 with SMTP id
 d75a77b69052e-51720af90damr6978311cf.14.1779984101530; Thu, 28 May 2026
 09:01:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515071504.2054786-2-yuyanghuang@google.com>
 <2e08eb1ca27a9a2f8ad29e1c24f779b579621b0a648589f7044799d91c5e00f5@mail.kernel.org>
 <CADXeF1GVtFHNZJb8xwFh6aadR=H19S+kja8rF185XB5=fg0D0Q@mail.gmail.com>
 <CAADnVQ+42+Th6OFGq2KawzvyKUAykazb4fXh2_uqss-T+R8VCg@mail.gmail.com>
 <CADXeF1F=7RcxAsW38w_mpFeKCLxTAh5p_XYHd=x2Ru+oajoN3Q@mail.gmail.com>
 <34b18a3e-50c0-4b0c-8ee6-d7a291619231@linux.dev> <CADXeF1HRe=U7aWx2yx6RFZ_uH-mMbdsxMheofr2tMD9wae46oQ@mail.gmail.com>
 <6083831a-dc6d-42e4-a1c8-8b7f6b966650@linux.dev> <CAKD1Yr32VMefwq7Bo6_hmhFrDVsttNFwZJZcaXS4P-ACOwWobw@mail.gmail.com>
In-Reply-To: <CAKD1Yr32VMefwq7Bo6_hmhFrDVsttNFwZJZcaXS4P-ACOwWobw@mail.gmail.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Fri, 29 May 2026 00:01:04 +0800
X-Gm-Features: AVHnY4KYoAqz9rUtz8nGlc7zWjwvk4SuqM2I4D6DnfwQvY05GaYxUOEso4as720
Message-ID: <CADXeF1EWY0=TyvhFap3iyKdpHNkk5pZuHD-RDnXuqMa5LrNJ2Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: align syscall writeback behavior with
 caller-declared size
To: Lorenzo Colitti <lorenzo@google.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, bot+bpf-ci@kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"

>It seems you haven't convinced Alexei in that thread.
>Attached below.

Thanks for the test program. It proves my hypothesis: you had to
manually unmap a page boundary to force that `-EFAULT`. The part that
is still under discussion is whether there is a kernel bug or not. I
think there is no question about the behavior of when the -EFAULT will
be triggered.

> To avoid such stack corruption, you should reserve enough space for the
> query, e.g., by extracting union bpf_attr from kernel BTF vmlinux.

I agree that your suggestion to extract the layout from BTF is good
practice when writing a new program from scratch. However, our focus
here is on maintaining backward compatibility for existing binaries.

I think the core question is: **is a 40-byte query a valid request or not?**

From my understanding, under the syscall ABI contract, passing a
40-byte buffer (at least for query BPF_CGROUP_INET_INGRESS which has
been stable and supported since 2017) is 100% valid and legal. **The
kernel must never break existing userspace on a kernel upgrade**.

One example of a syscall that maintains such backward compatibility is
openat2. The documentation notes it as follows:

EINVAL size was smaller than **any known version of struct open_how**.

If this bpf() syscall want to follow the same way to maintain the ABI
contract, your `mmap` test actually let kernel return -EINVAL to a
userspace program that passes a 40-byte buffer (declaring `size =
40`),  because the kernel unconditionally tries to write to offset 56,
which happens to be unmapped.

Are you arguing that the `bpf()` syscall does not need to follow the
ABI contract to maintain backward compatibility, and that it is
expected that newer kernels can break binaries compiled against older
kernels? If you believe that all binaries must be recompiled or
dynamically updated against the latest vmlinux BTF upon every kernel
upgrade, please be explicit about it.

Thanks,

Yuyang
