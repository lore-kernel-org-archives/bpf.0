Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D167A45C0B
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 00:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772842315; cv=pass; b=D6DaQ7Yq3AKeBwQrWOJ7j7Bd7MjtrIL73h2fBPxicIJx1SbrUccZt8oIoWci65+8vuqWg9YxLUs+HyNn+y6nsMUkqiC4p/eajTPtG35Dx3i92NwkHwIshAmZBpHXSvdXsbEuiEwl6rj+eG557Jq6IPGZfCWUkP0rhtDDVE+jmS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772842315; c=relaxed/simple;
	bh=HgKcstrIYQl9x5oWbLGZjwkY9nmjJZ0Y1THp/KSzgGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCGLsVnm8wMrGnFUVlvvCwfrFGmuG/VrX0Gv3+44XE/CdKi0moC5MS9ZbrsvlGJj3TSpm/bDzUrsDQ21dezrTxQXaaXX1RO2QewPhwdsIHQ/2q4McMdLOrxrJGLUolcsM/XCO6DrcSvmsnANNeYSQ38FE0an8FTk4aEDPSWz9ZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mv6tFWrk; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mv6tFWrk"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-439a89b6fd0so6388494f8f.2
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 16:11:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772842312; cv=none;
        d=google.com; s=arc-20240605;
        b=eNwUedJg3QYIU5XSpT7IhQkJnhj5TH9cf8mu2A/ZSsxM/Qqkc9uXvHKaaUT5e2/avU
         GwqOQISntqT6RLZF1yYUBGmNKi6E9U4RI7KIi5gRTiti8BZRiWQG+3bvKesjc3QuRcxK
         P18puq5FVIVAse7N2zBtKAKgSRpXyk+z2uLnPHd/8uzF6M/RUb23p1QuiYBUU4oDqgOV
         1ibpDz/25wW7Ne/S2k9NLs8mNZdPTkkR7JYG3W0BnIH1RRnIOi6GCd1CZYkyWtPL2qR5
         8tBWJ29oEyofLUcKFuVdz674wgtDd9ATa/sjdPNw4Uv1SpUrK6eyZ9X80upG1+i+dbdw
         ltkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HgKcstrIYQl9x5oWbLGZjwkY9nmjJZ0Y1THp/KSzgGA=;
        fh=mDzR4F2HYBiPa8yJgVCsLrTGPRgvi8n+zig1o3odmZY=;
        b=hVv4EPRvgWfGWaqPu61Q3s9V+x94qfIuCwGf2PxjMsIkm1OEyX6/7KUS0rIREQ8m89
         U5pTT/ebxHlKiKntkCbyUDIFa/VSwxo4KHfUYRiYNtbe/Jv1zSvHFLOMM9R/LvlNjm5v
         E/iU7+OP9I/w/W8TF34rFJv41Ibab2iDe0Csj4E7PPGY8iclmjn4mm9J/rYq9v+NA0RI
         oduZrY2o85O00+pXzDOw2RC6LD5HgrU9FklqOCpGSnSRnVc8ogpJyovBF+vefkAzVVUp
         dDItiRhZTYG05S3QtRLfDQYb1YvOPagN/G2jrfr5TOW3C3O0IwVkmMNtoqrgBmCtzQTd
         hpEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772842312; x=1773447112; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HgKcstrIYQl9x5oWbLGZjwkY9nmjJZ0Y1THp/KSzgGA=;
        b=Mv6tFWrkT18Y+wmDQt8sQ9R0XLYA2qdlwyW55yCh0oHUAS0So67XtwWqWlD/14u0Xx
         Dzns3p2v22063ufgB7QPIuyI4b09yRoXxSKYDv+DASM7KENhmihN4dejz0vc+ITqxM3X
         gzzHodgzkhiT/thmqR1usEd+arN9UJaobTch4E65tnc6S23HDg/AjVdjzz+lCz5UmDX4
         MKXb0FmsAbS32cqAED4bqvRplMyb7RruHrXx1Od0pBUPaE2PghQHuCtr95VyJ1Fzh+fE
         spCTdi8aLrO+M6OCya07T6KgcA6vx5tihXu2qgi64857yv7MXhE+26BhPj/54fMhU8YN
         fAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772842312; x=1773447112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgKcstrIYQl9x5oWbLGZjwkY9nmjJZ0Y1THp/KSzgGA=;
        b=t5vDneLgohtz7mE+p8iyxYGoylRM74rDqGYjSHBIefpdmHanjoy18+fXJbcyNE8dSL
         cmIrsADJ2gK3H6FD0gY6VT98YhNHHklpy6H42DEE5blBXtTjyEsHiNDwCGOWuIyjSldt
         G007vCuyvnj/dRmITpILBwH4EA5+CSxftt22oC0jBI1k08R0qeoVaN4l85om6sTeef+C
         J9styja1UYVSDyxIbA5j/lZbsnUW0kuoaZR/E5EPZs/FCh3FM8T5gEK6RsftYEv3TOdD
         nahcBdNVvOh5b6+dDnrYd9CRmX7w2FQWJoiTevJIEzvQB+g9UPBhlSUTfB6O1UqaZW3k
         GJFg==
X-Forwarded-Encrypted: i=1; AJvYcCUnX45toUOxy38uyZXDdmM1yZO6HB73D/AAWrLcvYGPEgUYQloQWmfZHQDtFCdFeseIm+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjpZC8IomtGOLPHn/qJl4c+65eMooBVO4k7koP5Ht8YyjNSH4w
	13ddJgR008oTKgkkEVfXOs/w7Td8UFR1uyG2uPzYr+JktWAvXcJmXHufYX+kE7iEFAqAsrU8DBp
	UGgUF/3lhjfx4TUZzPF7/Ht1zensSkgk=
X-Gm-Gg: ATEYQzwnQcno+iXJdvxRQfOHBboV/drj93Ff16AGMRincwO8ehbP459zuF+PfyJGYJh
	2zWPZAUNMvLGFSxCWMaM3UmWWfoIYBtcKc7DKXWPz/PhNYq2SLWyQwtNDAY8CINvEN5sSthNrID
	T8g0ntu0KxrnXcI7weslbb1o9h3SkVk4pptagfWO62J7tiIGehTCod6Bu3ynt4vmc6gjToowYij
	A1NTuuSag/dIim3fcurquXgoH8+/EYjIr9feXnmHJsHaoUdpTbFGeNMR8dZ/pLORfnEzpCJOL6Z
	s/Q1SQv7c5NKt1iSWSIJAN/rK+P3wCDLOR4cFRomDBQK1/pFs4x6abLT3fQ=
X-Received: by 2002:a5d:5f84:0:b0:439:8580:181 with SMTP id
 ffacd0b85a97d-439da89ea7fmr6848894f8f.52.1772842312052; Fri, 06 Mar 2026
 16:11:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306083330.518627-1-sun.jian.kdev@gmail.com>
In-Reply-To: <20260306083330.518627-1-sun.jian.kdev@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 7 Mar 2026 01:11:15 +0100
X-Gm-Features: AaiRm51N-jBt4fdfi663B6taShcS8Y3p1eyaEPu_RJ_GMA655_c7cCYiVSkGd08
Message-ID: <CAP01T74GzzNuqRVQ6-hk8KpmV2t-CEa1KuF4mAvh6jiQkhaLCA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] selftests/bpf: filter by pid to avoid cross-test interference
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Mar 2026 at 09:35, Sun Jian <sun.jian.kdev@gmail.com> wrote:
>
> The test installs a kprobe on __sys_connect and checks that
> bpf_probe_write_user() can modify the syscall argument. However, any
> concurrent thread in any other test that calls connect() will also
> trigger the kprobe and have its sockaddr silently overwritten, causing
> flaky failures in unrelated tests.
>
> Constrain the hook to the current test process by filtering on a PID
> stored as a global variable in .bss. Initialize the .bss value from
> user space before bpf_object__load() using bpf_map__set_initial_value(),
> and validate the bss map value size to catch layout mismatches.
>
> No new map is introduced and the test keeps the existing non-skeleton
> flow.
>
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>
> [...]
