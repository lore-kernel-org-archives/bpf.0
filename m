Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793670556;
	b=pl1jAMUktOK4nXiOpyOZJtL+MjsJ4seqjNR8cmKCM6zVVsHDJUbJ4aMH5fiN2fVaTMNw
	 zjp51JJEoj6Fgmfwzx/FhK/glins387ZrtdZ7/OTbgY3mAF1P9XLlyt3UQFf5Q1DOeidD
	 7Ym4cpteHzJDANqPUhjfCPgTApqJFuaedqFoYvJjhF0VcDL2LL3oSsWFUb1CPBpQk6i83
	 gcxmtnSo8u9Xmy+gGomfa6b70FpZy2qLqAjHbnw7M/Y6wyAYGSeXD1VIVfHYGvPJMnJis
	 3mfKc43NtRIswTHnZQYjRsUZ+gUmeJ+mN7wdAyTTjSmQ00q2msKgIAAi2OuF3PpX5aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793670556;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=JkIPtkRIMfFcSEfUGwxsTLNIjz/Hdrm5pN4sxYxlXGQ=;
	b=CTAqHY2vZPCAPe8bmEGfI360Vo+z/PVYXqX2EXIP57RW1JSdWLT/n0FOYHPPWa835EI4
	 41lhbtvalTIQv4sZQeCcXnp3RLf7VlIGzsOjJeHBW0fcjJPO/pKJFMqdwT+R0ZCpXWWd2
	 OmwvszpRnnAVm5alPIHVeXn6sgtq96AATJ4hlDPDJ7w00OLAJ/9R0S0IKQuaZaQ+2g5/r
	 hRWRs53cI11KS3/J8sHnUdizRz9NNoOvC1odMDkXMFhM6XROhGO5+FxP0c6VFGtkQTXyL
	 /B4UeTyA0Hms7TMDtrCuztu+V+87aZDHyM4jcLPH+j4vV+pOlcatoB5p62R2PtyhztA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A7BJO4Lo;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BEB606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 01:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96BEB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A7BJO4Lo
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cdb15cd8558so909387a12.2
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 17:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793670555; x=1794275355; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JkIPtkRIMfFcSEfUGwxsTLNIjz/Hdrm5pN4sxYxlXGQ=;
        b=A7BJO4LoPpfxT6+H+ASpf8yGG9XZnj4GXxUtBiNX2dAZVoPB5KgLe7CBPmVM3Vgnp8
         dvKfDhjUDTRsKY170r6Chzx/5Ety2nC39hhwCg2njDrwCboUt+RtjVVKcpVWxcDZfkzQ
         KEWPtqMk+RC4F5tIsgO7faez614XCFe1pCoScDUC0+RXyytYiJBO0RQh53jUe+M3/9EB
         9dneUAlA4I40aRZ21WI3NNHBmQ5vORTDct/3PTlsqSy0vAJ24f9JSIGAqONzH7euyTuS
         o+YC3cMmYpmuCqLxyuVAwvJwEjF29hy7TWjUaZZ+aYjoh6TRwHRM6UFgg6a2hnuaA53N
         IMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793670555; x=1794275355;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JkIPtkRIMfFcSEfUGwxsTLNIjz/Hdrm5pN4sxYxlXGQ=;
        b=iNJgsfympoEEsBR6nFFpK5aga52at7rDlSm0bQqGbAwVxqdJT/2JXz/kAWgTkEkucG
         5U0jBvKaItTwp/1MvsxfSuxshEz3teaqBS2+KBlEf+RcZASPdADdKnC2DdwPisKA2PtS
         yaB5R8Oz815MKY1/ICEsr293/VI5g7StkzvE2kOVITcmIyoPcdN4kIQZ+gme/BEJBP7L
         lKf5UQLnoKbojl4UX4biPByHxynkiii7Yfl36KDgDrRzHxLzXQq59EW6s/E8ZUWPgObO
         Z1eZYqZliWydx5IlruwyDa2ERU6A9z1R8M3lMkX2er8mBUSrKOWAAdlwufabTvB7QB7b
         KTgw==
X-Forwarded-Encrypted: i=1; AKwUvBz6ReJSYiVmxF6WhjXP6Eo7fyRLdjsy6JN6b4RVOVoCxClh98/C354EqyzQIn6heXMwaiY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8yruHiBx6rEesV/Y6I0+tb70+eCs3l1cuwTFTIK8xpFBs/2xia
	UqNBkRxb1YBVXVI+CeweKYI4WzVE9HfWwRa9WqtX0rsIeR2dwF4D2NXe
X-Gm-Gg: AYBFou22pS4GtnHkvz2VaQugX50HUalS8WjOFs+6MBkDvb0BTzsh/kf6VhOLbc+XxNm
	qqxyqJKYUo4KnDXOCiQFL+B54KGVGjqCDdaon3N93EuaeB86qdpRbpkrKLnCsTrxh1UmqbLFfam
	RokjbeT9ZvYmPkRrXJXKxYRIEU7JX0VKnQiaxiG7+Wef722DZT2lxLAwELVJ1XC7zOMFctvsuDa
	/4J4X0O+Bc27oUJ9ASABR1RIzsOOqRw+mCzUTXRN1105kKokOibLYuvmIXjHbHg84UUhDhMkKtB
	J35qVV+xz6iZ30Cjd8FDIAbLkD00OZ2f7lWhhsmN2nKHisD1LhWFJ+rxe4aUIf1u+Mk0BRRYoX2
	BhJXS9n90KDTqGUkoE+VI69lK70gs37fKpVKGr5Fvc/wjxd0PQ16NRmycO/NMRXszQHEX6U05MF
	caTSBsDJ7HFMd5bl1cKmlHOdvgQG/nF4VJ9U2sGBAsIqR1bcDcgA3DqrUko84g3UFgO2CKamNHI
	8NxN9cinTyPF8j5EDtD8/Z1WF5Pg1balcuxgEkxisq9VNB7D4z+VrZfAR8C/knywx0wpbD7Rs12
	fmXElGFGUfZbpyrZ4r4r2d6o6bipDzjbfZ3TY33zOhGj1NFFEbM9i203aYQxBTPLQXTLfpQWTtH
	fqRs7fjS44BwqzY16Hvgfkb0PbBCquTtTPw==
X-Received: by 2002:a17:90b:2745:b0:3a4:b0a1:c7ed with SMTP id 98e67ed59e1d1-3ae89776d99mr9290272a91.13.1793670555014;
        Mon, 02 Nov 2026 17:49:15 -0800 (PST)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85e4ff4csm10375603a91.1.2026.11.02.17.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 17:49:14 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 01:49:12 +0000
Message-Id: <DML75890DWIX.EYB690LPBM1O@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "Shuah Khan" <shuah@kernel.org>,
 <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [EXT.MSG] Re: [PATCH RFC bpf-next 0/2] bpf: Do not let
 preemption cause false recursion drops in trampoline progs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Mike Bazov" <mikeba@sentinelone.com>
In-Reply-To: <CAPnbwjrB_je6jXt3BGD-1q1yFs_wFd-Yh9KzixKzLK_X3Stuag@mail.gmail.com>
References: <20261025-b4-bpf-trampoline-preempt-v1-0-198dcdc0c6ac@sentinelone.com> <DMIIV9CE0PN4.309YUGIXQUZNF@gmail.com> <CAPnbwjrB_je6jXt3BGD-1q1yFs_wFd-Yh9KzixKzLK_X3Stuag@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 02, 2026 at 03:24 PM Mike Bazov <mikeba@sentinelone.com> wrote:
> To fix fentry/fexit while keeping preemption enabled, we'll need to:
>    1. Disable private stack for fentry/fexit (so each task uses its own
>       kernel stack), and

Yes.
Then the stack limit covers the whole call chain instead of one frame.
It's 2 Kbytes on x86-64 and arm64 now.

>    2. Check recursion in __bpf_prog_enter_recur() per-task rather than via
>       the per-CPU prog->active counter (still blocking same-task recursion
>       and IRQ/NMI re-entry on the same CPU, while allowing a preempting
>       Task B to run).

No. I don't think we can switch to per-task that easily.
For your use case try fsession. It was added specifically to match entry/exit.
