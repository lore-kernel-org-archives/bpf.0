Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2453264EF
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774363249; cv=pass; b=d+SNLoouWBHhODZzJDEKMnpYi9l7OUqwc6YGwCywMUoqRYdHQFAbDSzRj14Oo3Io54wrp7bPKjFyG1v3eB0rSdSDTOp447GB3gYR5IYZD6yhL4tAPy4jh/EsDm2xOKALIvcvduojmBv3rA4KSvZND4TuUSzzBjnba4+gPYQ4NHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774363249; c=relaxed/simple;
	bh=vIOTQppSONw9z50oLZexhAWHsb4Q3HZrSfu8BpJO/QA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hDTAKswBfdmGc91Mexw90TcuHDH/R94U9cMQ9bybGxta4hVABPTsTykIiJWo7sA7f2dXxqmnoCT7GE3Vv4eL3gXtLIgjpdNNccAWIdbgaxi+IabrcOF+tki8ta4e8UFbB2VCTrSXbOsUzToXmeGKye7mlsfFhHJDdNBaIbzTa48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5QR1fr5; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5QR1fr5"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79800183233so66977867b3.1
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 07:40:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774363247; cv=none;
        d=google.com; s=arc-20240605;
        b=gPaZVtSIUKNUbyzG68PIrzRms/RKiM7/Q2C3pM7SzC9VQh077buqcL7JMlJRqt3Gjs
         PESfKq40J3RGkRLz//oFAQlYgryR2h3YiuS+TIUvIKggt+L+45b+Y0MNUm7nvYrb+mif
         fLCQkXcKy+J/yNxtsqZ+UWnZ+2qan4+Z6fZafD1cmjo5Vm2G/9YYkZ51OTtKlZvjJGmh
         lLAa7HLKWX7np93nW0H7PP1Rgg4wnD81izkjIcj8lP47IQuIfijjKOezopZLObiySpZQ
         nVKcAs1f0vFMqrBn9THqy94KaVo+M6Hf3sut8znzC5uQPYiyWadxF++HDb8qFh/kAGG7
         gcyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vIOTQppSONw9z50oLZexhAWHsb4Q3HZrSfu8BpJO/QA=;
        fh=uj4bHNePqMqHIm01ax9c0SbxIDykM1IFMq3TVmFeNEU=;
        b=FRuZ42sNJD7fHK7ikslO0JdVQsT2BPuKooYOHc9z9wBhrMzZovJdzOZNLpI3d0yzqh
         iQfu5vwwTrpXGKy2D00CgTW6hPD+P4Rgj2TmyBmf4XGyt1bhA7l+fR0NhUij/r8uK34g
         V3GGqJnCdZljngSQouYHtEhDbNu2MIfSTzdeI2nf/jrPyRXzjPsoieFmz87zR8PGAxkz
         Q4IYQ+KkSYBVIyKyx4hxWImsIZv67E9dombIhGqM7X2LZvw3K8HFdMs7kJ8GUDsgu2Pc
         p7nE86b10n+yYbFmDndIbTyFaNtnJAGEAm4GZxmQgNxVv/K8Ctzd6lUTYvUnd8cdWIO5
         XBTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774363247; x=1774968047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIOTQppSONw9z50oLZexhAWHsb4Q3HZrSfu8BpJO/QA=;
        b=T5QR1fr5LsUidi/oSaEMN/akhtx3oH2F3/ILSN4y9ePBxOpKFNONsW2SFRhPoNG0b7
         cjVJE9iDIiqGxwzkhcM5OFxxilJUSUcwFyZjI6TiFubm/DdiqcJuYZdTlqZ8xj5LppZj
         yG9owVHUYaZq1Nc+Ia9LrvLS9EIrTQY1tdQ8/+lut+OityHzoxWQbCKAL/cgiD8O4Mr2
         tL6Qljdt2VN/sKufJ6JHwNZVdzo5Y3TCoHMChazIVGyB07xFag3JxH3+GQz0KsK6JxnC
         F+lmdomEjA+RbcU2pKGgEhhKRHgl5qDQEVWguzmaUPDDMRW7SXbcoDrTdpKXx7sYqtbf
         tAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774363247; x=1774968047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vIOTQppSONw9z50oLZexhAWHsb4Q3HZrSfu8BpJO/QA=;
        b=FZ9dRT3EH2A325Zewzo7OP9sg+YFXSXE8TC+5Gv/d+t+Pp7fkuBShiY1H4X3dIHn5B
         hlqsbJPoNUA4B+M7Q4m8EMDXSu2r27QkYbZspamSdGkOEUcbmb8boesnZzUiYfqMLBce
         r/ecPcgP1SQZQ6AtQPvG1+/maVNCnwyAvCPYfEKjkJ4lfpaFBaiKIzCILHeEqlM3ClCp
         +3UEd0Ki2fLvql7e2oxi4UZyz/1miBdkE/NJE7eS4vc006lzWkaQaRnXw/9EBeQUBx76
         zsUl6bFumUtA1xGz0p4vyFAbBVzdd2FbpEJmHhbaaJHXTVX+ZSWWCzfn9W//jZi3ejd3
         PJxg==
X-Forwarded-Encrypted: i=1; AJvYcCUCjv21vNFZRIL/ddG82uajksMW2tXkHmgeJmH6af3oY7k3EWbaVnyGez3H+d6ZeTZ8drE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYjVYv8zwgHswxuoSXDQhALFAxPD0pzKZlgYg87WAv5p89icmL
	YWDHAmRDGHqUiyRWRRbw3EBCZs1QEbpa+fJ3tZYeu4Pw4eKj6dt3jZ0mv6eqBj035FU979tUYll
	iz123eT9EEUDPXFxGEryCBdhWtEFkzs8=
X-Gm-Gg: ATEYQzxEiPJZ+zB5cCqFwC25n2PcS3MX3oq/bKXSkF82yMoRMVQvFtg1d5P0nOxIShM
	kOUZe8yw++C2BMsR2zJFgXXczzpOjRoGuB4F3c2iDlGCCOUpHI1o35CxCzB6cRreGfCBv/HP3gj
	EkxjlxHqZT/0zllfOh9b58oGrIkjWz9igL1BZHfKrCDJPK5o1tUkLRlMIQCkms2MkKN+72Tfw8U
	YohHR/edLBqNb6FEWmUuqbVxS+PIBCtAImvKyVWCCG6gJEKxchY4p3zflT5BNC04h20ij1b5BU9
	5KlykavsadKUsLHoNHxU4S/5diaylHV6K8y5EU6Yt6L8gez5iC8=
X-Received: by 2002:a05:690c:386:b0:794:c283:5fb8 with SMTP id
 00721157ae682-79ac2f69d32mr32318717b3.25.1774363247300; Tue, 24 Mar 2026
 07:40:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324040535.work.851-kees@kernel.org> <202603232224.C1555BF@keescook>
In-Reply-To: <202603232224.C1555BF@keescook>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 24 Mar 2026 22:40:36 +0800
X-Gm-Features: AQROBzDuylfJpvIzbHVr5tertRSIgq0oIglskAWDMfwVyWLSS3eK64LQ-Sk2jqM
Message-ID: <CABFUUZGYfw7=yHu8p7CW_JC6FSNSrT8jg1pAPqBK6nj_Br0iNw@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Replace strncpy() with strnlen()+memcpy() in skel_map_create()
To: Kees Cook <kees@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 1:26=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Mon, Mar 23, 2026 at 09:05:39PM -0700, Kees Cook wrote:
> > While the original strncpy() would have copied a full 16 bytes from an
> > overlong name (producing an unterminated field that the syscall rejects=
),
> > but this wasn't a reachable state. This replacement will instead always
> > truncate to 15 bytes and keeps the NUL terminator, which should have no
> > behavioral changes with the present code and avoids potential issues
> > with future over-long string literals.
>
> Hm, I got a failure report, but it *seems* unrelated? But nothing else
> fails that way recently, so I will try a v2 with the "unterminated at 16
> bytes" behavior restored and see if it passes...
>
> test_progs_no_alu32-x86_64-llvm-21:
> https://github.com/kernel-patches/bpf/actions/runs/23472955268/job/683004=
40546
IMHO, it's a flaky test failure, likely caused by timer-related
activity when selftests/bpf
are running concurrently.

As for your patch, replacing strncpy() makes sense, but this also
changes semantics
for overlong map names: they are silently truncated to 15 bytes.
I'd prefer an explicit length check and rejecting the overlong names,
instead of normalizing
them by truncation.

Sun Jian
