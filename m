Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD76D4AEFB
	for <bpf@vger.kernel.org>; Sat,  9 Mar 2024 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710011466; cv=none; b=dG3rh1yUpKkSkCtgWFCwTrfMIF9knDQB3StGbUzwHpPFukgiSMh2NWBE9eCDQ0+4RrvpNcTMHkAE3hcmvtbUO1MBP/5rXzkMWLLIRpyWK145njqyMqNjaDGHiH9RXgtctM3CIyjrjcWPeedxepAepo+XcWx4bLF4l/9M8Unxy10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710011466; c=relaxed/simple;
	bh=T3yETo5tb1g9D6/f/i5zYJPkeIe/kR0r9AqB7mUphEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oh4hQC8eVLmu0N/co8CjHKG3j7OULD43gcH2Eu6n5Kw0/ih9BDxQGhGgcXxVDr8Hj3BZ2zg3M34c76U7Nrqmr/2bZcXjzZfgknNWI21xTPzW2/g1gkwV3+1PQCDStY9+4k8PES1ucMH0igiwYjgT/5o/LyN4dW5j1A7vI/6hAFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXDOPQUr; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXDOPQUr"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33e742ca96bso2124383f8f.3
        for <bpf@vger.kernel.org>; Sat, 09 Mar 2024 11:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710011463; x=1710616263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3yETo5tb1g9D6/f/i5zYJPkeIe/kR0r9AqB7mUphEg=;
        b=EXDOPQUrYEZWrPDriF4/qWoXVnDDDqbUyeLgD40yjKrKvL75yYUq83jxMgKNZ/1ttB
         hlfBo8ohCPOd94FTcYufRqWKVsTupfJZ+PDxnoMP6QJLcDZ67kXgIFNehU9Jq+EXvFdC
         pUVcQnGwOf4SOPICA8RLZn/uZE0Od3gUKOToxqiRHRRXjl6AKjJdrYctIh4l9d4SJvPH
         ZQucFzluo3dP/zUtqCjcCsOL4hXNBuZt2YfV0Xi5fNHPBfIQ7mwB1zuTK0+6Mk3oC9MH
         JRCUaOs+UCr4Gg9KCEA4TwP9sKLovbJjXabbWM4M1cU0RmaSqwVYKfDdFBUZT0bjBpAF
         T9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710011463; x=1710616263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3yETo5tb1g9D6/f/i5zYJPkeIe/kR0r9AqB7mUphEg=;
        b=SXm5CDguD2jZqi3JNLvBBj2rs54/jqyAdeu51PxftM/poQc5RiQYDC1XGxYLEVNIOG
         Xf592Ey7/WSf0kezAptQBOHXBjABuWqiB376jKaewwe99EfHT7lE/Nt0nknd6lb6/vLA
         fzQhQdJegsaiy0pSmtxvcjv57HhxhhqAqHIFbFy+BhWEq0qofd9HjeqfNmHJECV7EA3C
         KA8Jq/T4StucDciUOY/GGPtGLGwDzUusb764DD2cHCAZO6rKKWqQy8NnckVg4SgmfcS0
         3NlqRwDjwS5dkh8DvGOgvZd4KTszUOSiC2BF9qeY52fRnOu1GPM7cg/ggv2BTmufMwVi
         ZU9g==
X-Forwarded-Encrypted: i=1; AJvYcCXQJ/CM7JQ1JopVQOZqOTuXuE/aPsay3T1oZy3UO7J/ciENgbOAi5nwwWUEim+GFaXHdbks5jZuH/qNOhl6o7cUK8wu
X-Gm-Message-State: AOJu0YwkicwucanPfG3kkxyMLSi8Cr+2y7rX9Eet78ZaB08gtyIn4T8Q
	XuL3FJv2CfZ5Vf+QUdx38PUsA70SmtDiiUoCKA1oSth8SVSdpBFhhLG2gdtbwltdn6vfnyf40Fv
	me2+bwKV7HnrO0D7VM7gZY+aY5rk=
X-Google-Smtp-Source: AGHT+IF+RcgYRBiiY2wZa8raXWr1oN4v+diV2SG2HxHBwHy+5lL6Tqsa4oU80rGEF6QZlP/3fDpNuJYUNtlnhTcwx2o=
X-Received: by 2002:adf:fa91:0:b0:33e:11c3:7ebf with SMTP id
 h17-20020adffa91000000b0033e11c37ebfmr1663721wrr.62.1710011462988; Sat, 09
 Mar 2024 11:11:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307232659.1115872-1-yonghong.song@linux.dev>
 <20240307232705.1116787-1-yonghong.song@linux.dev> <CAEf4Bzb+=OyvTtqwu_q1ouY7dcNVm=uD5rpYohAqGdjFBQntKQ@mail.gmail.com>
 <c8c7968e-79f8-47ec-b549-025af95ff895@linux.dev>
In-Reply-To: <c8c7968e-79f8-47ec-b549-025af95ff895@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 9 Mar 2024 11:10:50 -0800
Message-ID: <CAADnVQJiEEDereGw-pbNj+RAaaZMNKY8m_M_dyPrOEs3o0x_9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Allow helper bpf_get_ns_current_pid_tgid()
 in cgroup and sk_msg programs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Yury Namgung <ynamgung@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 9, 2024 at 10:40=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 3/8/24 5:06 PM, Andrii Nakryiko wrote:
> > On Thu, Mar 7, 2024 at 3:27=E2=80=AFPM Yonghong Song <yonghong.song@lin=
ux.dev> wrote:
> >> Currently bpf_get_current_pid_tgid() is allowed in tracing, cgroup
> >> and sk_msg progs while bpf_get_ns_current_pid_tgid() is only allowed
> >> in tracing progs.
> >>
> >> We have an internal use case where for an application running
> >> in a container (with pid namespace), user wants to get
> >> the pid associated with the pid namespace in a cgroup bpf
> >> program. Currently, cgroup bpf progs already allow
> >> bpf_get_current_pid_tgid(). Let us allow bpf_get_ns_current_pid_tgid()
> >> as well.
> >>
> >> With auditing the code, bpf_get_current_pid_tgid() is also used
> >> by sk_msg prog. So I added bpf_get_ns_current_pid_tgid()
> >> support for sk_msg prog, so now for all places where
> >> bpf_get_current_pid_tgid() can be used, bpf_get_ns_current_pid_tgid()
> >> can be used as well.
> >>
> > If tracing can call both bpf_get_current_pid_tgid() and
> > bpf_get_ns_current_pid_tgid(), can't we just add both into
> > bpf_base_func_proto() and have them available for all types of BPF
> > programs? If it's safe for tracing, it's safe for any program type, so
> > why not?
>
> Do we need any capability to control bpf_get_[ns_]current_pid_tgid()?
> nothing or CAP_BPF or CAP_PERFMON? In my opinion, pid/tgid
> is available to user space and there is no leaking kernel private
> data here, so bpf prog should be able to use it in all prog types.
> I will wait for a few days. If no people object, I will incorporate
> this in v2.

Yeah. It's safe without extra cap-s.
There is ns_match() inside. Nothing can leak.
Let's just move it to base_func_proto.
