Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD69030BBB0
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 01:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769737481; cv=pass; b=H69LQN9roi1p599ZfAa7q/6oGdMZlzQPnmV775F6tOU304PUvGjs/RWw+s6saW9I4bdZXjaDrTbNfzDkVtW0VD4Z9G9xT8rte0J3hH05/TpFFBELfkCoO7RJJcEuFhHpp5rAv6MhEykEazM6ezt1hzHn7PUwY84ZpN316/2lQ90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769737481; c=relaxed/simple;
	bh=T/GhrQBQVjqNPzvfZQ4TUHYy6QZAn7nhFEWgVyl/BG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CseIjy70llqJuZAOLUVIVRpY5/b3p9WpKkIKPvj3iXQvMbEen+6vSrl+htkOQy4n/q9Hr/g1J8WRJinYgM3QLJc0wCPi2DC4A5y2mdVXc6BrOTlw7pHJfL1lwP7dPnCojBq+nyYhS0Fu3YrfE8XTrMzAaJYtf3+moJKX+kQajsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HprUsp+s; arc=pass smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HprUsp+s"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5eea9f9c29bso967474137.2
        for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 17:44:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769737478; cv=none;
        d=google.com; s=arc-20240605;
        b=ZBY0AWTtWTKSgzZHjxsIKSnB5jS2AWu2nQF+bhlxde1oFurGMqR4GUlF7gJup28Hi2
         xHF2LPvolbL2l0tI17CA+XWvvl50Lcp9QnSQdBoqEQJHUPrjoL20qRbI/hn2fnnCFp8Z
         ArdYLXuA11nhxOJ6o29JGxSp2L02ZOZb6sXhnmdMg1hQp4ltNwOQKRNk/jRQPgFf+7cT
         GRgQtZkEF/Ap1CsKScOo7NbXq0i0m/ke0WsKc50EHjVUwpRytfhlMKG3lUPner4S7Q4V
         J9XHbXb9w4ydS2T8U2E3q8dG3MGtVX5bIcsHECjiWWD9sPLAtX7l7NkSJ3Z3l8tFAptl
         VFxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dcMQSiThkUzt54G8zE45foYFOQWbB4K41eFTJ7Xn4eM=;
        fh=Y+6elDDmkCmgG5EqVRPSqb4W56xnqpUovJD6l71KU+0=;
        b=a/w65f3qMJbSjcYqBdHIfhHIKP+pthuyi5arrTTm7I9WJgl835mIVSwmXOLP4SUtlg
         Q6MIFF6LqDagJTwEb5YP5w9vzpLfZXz7BfPu23sRP3VMa1StvV1SnL0btmpBPTi4fQ6J
         WrbqVJvqxWDXIrGHb+B58xMMESN/DAZqwTdt8Yf59vtPthq8pDg3uPHrqhSUEZlU3UVm
         JBVZacEMGRkiflSNPZ02vppPxv/HI4W0rfG8/ZxLk6ojFlMcTsxCdsx9kcVuJZx5MlOa
         glLljtYaBBPAjAjEYUzE/7hqo+oLN0nbZcpNP9jLNpQdeH8QftBu5R4xqwPpqCsiu0ru
         si7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769737478; x=1770342278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcMQSiThkUzt54G8zE45foYFOQWbB4K41eFTJ7Xn4eM=;
        b=HprUsp+sldmgqQKK7XSfJ5/v26Qm8loHuVk+47OyT9z6EgT7GHiAS1lsf/HknF8aTJ
         dXKY8IYe/HNjCoC3yfZpPMaqxTTv2Tr0qVnwQucOyifRbfttevIAcAGDcqDa6h2XYI6Q
         dpOssu6iIYmjw64n0hEME99pbBTWI5BMlAT2/C37X0PS4GHy+PETW+/VyXkN/3tHh3Z5
         zuJ2WbFvRogR7u77kbEA1tK518UnuW2/rDXtLOM7DsWCcWfMn++NoFVznaW+qJAbQWwq
         fwBF61D5YbLKxkFrRFg48WPqJGFVMeM8f3pSTyQneDBLYo27/PMTWeCPikoy3QmYTMER
         H9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769737478; x=1770342278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dcMQSiThkUzt54G8zE45foYFOQWbB4K41eFTJ7Xn4eM=;
        b=HXpYCbTpuPaEXYKhkWAdtHaWQrFGYANRtW5dyiC8P9mWhXVut/EGeJOGzq3+VZ+r71
         nADRMeurPsZUt3ECEE3BbCbNR5kGiEonkxXeWRFm8SDoxZJ+9v/n4h7xw/oPniIBLWNU
         xmnLg/wSsfymGrPRbVcoaEyywnbrGk3TZz9q4u4uplzJ2tf4mrhQuy4uh/C1whGHZbAF
         FzKaVrw1RCpJwH9O4qwXWl6cvM2zV6CQi+n0yFNTl6+K7219ZfX2WHetu62awPbVuvFe
         hyejdTPVdv62wWKXLBMP5MnYhtxEdT0ItKtoKjrvT5KEP32/997efLIragKkl2NmI+H/
         l+Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVT0W1xQY9NmCcNpEXPFYo3e3As/uLRwtKH8UMlyLhGwtur5b545zUeQBo79S6Aw1iUKo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1odkFu38ntjzwkQ48AHyXatgr9cgWcRrNxa8R85jWPcVezrhU
	jvS4gD2wPM/Tf6EbWAVOLK3uAZ27n9J8OzBB4fcDMUqM+0EXIDMsFvfNM815eEXe+K/VtsSsAf2
	+XOF6DqGhm7zevA1xK5pz9CVURlVEEwhfjWNjizi4yPj1dwp6W1YbPhkB4J4=
X-Gm-Gg: AZuq6aJYZmNNSAv+m79z5DZAac8tOxlblK1cBGUR44kDnKZ/LEEkHbU1Rc+Ar/rPnfc
	eqHR0f3DusRG3qKZFS7wDK3heSg6sP8ZsgN86/ASlugIrhzkAr/+NYeFyQiFbEbbgaarLbichN1
	riaRmFm6utDwqvb5eZw0MTIIAvfU94YaHig3e6U4Vxewxk4incYYYQC6kt88jLUJYWLQgQXrYC1
	QxIj6UfUaSg5ZAkR2W6aHDClHQjvswxogxdwhjZQkyLINeToNJbzM4xuv1N+816rOB/6gUe
X-Received: by 2002:a05:6102:50ac:b0:5e4:95f6:3dca with SMTP id
 ada2fe7eead31-5f8e259affamr585057137.30.1769737478347; Thu, 29 Jan 2026
 17:44:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126142118.2ea3cf13@gandalf.local.home> <CAEf4Bzax24jJVDs2bBiJuz1ZuuDihsb5Xq8pGcy18vLUMMLxbg@mail.gmail.com>
 <20260126192010.4f14bcb9@gandalf.local.home> <CAEf4BzZ0cYkJ-3Kt-O+2FTvTEirS7cSuea2swgaom18Q_sve4A@mail.gmail.com>
 <CAP_z_CgozbHejsuKeLRQHN-bz5jPA+C+c0GBNitgEvwOucm8TQ@mail.gmail.com>
 <CAEf4Bza91wTWzESxAyz5qP4e8siwGn=rvm-Few6xT_VpW9oJzw@mail.gmail.com>
 <CAP_z_ChhkA1W_5Bd0GQYpo2Vb-p-zP+Lbdp1cZw8Fr_WHQ=TcQ@mail.gmail.com> <CAEf4BzaSgmgzqfjToDx-O3BRKNZECJeeLpN81yNNWGF+N_uMNQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaSgmgzqfjToDx-O3BRKNZECJeeLpN81yNNWGF+N_uMNQ@mail.gmail.com>
From: Blake Jones <blakejones@google.com>
Date: Thu, 29 Jan 2026 17:44:27 -0800
X-Gm-Features: AZwV_QjjYAh6l9nXTrb0KE2sjqDXJTX_lgGwZUepWW2cOqn9eKmRGE-LctrsEQ4
Message-ID: <CAP_z_Choy4Pe_VgdxwFzkUo4P71+TA=xAM8kov8QacGpRS5irg@mail.gmail.com>
Subject: Re: BPF with deferred stacktrace and sframes?
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrii,

On Wed, Jan 28, 2026 at 1:21=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> I'd probably pre-generate some unique ID (using atomic counters from
> the BPF side) that will be sent along with the async user stack trace
> eventually. And then join everything after the fact in user space.

I might be misunderstanding what you're proposing, but I don't see how
a single unique ID would solve my problem.

If a thread executes the following kernel function foo():

void bar(object_t *o)
{
  mutex_lock(&o->lock);
  o->count++;
  mutex_unlock(&o->lock);
}

void foo(void)
{
  mutex_lock(&current->foo_lock);
  list_for_each_entry(object, ...) {
    bar(object);
  }
  mutex_unlock(&current->foo_lock);
}

and blocked on both mutex acquisitions, it would generate two distinct
kernel stack traces in my profiler, corresponding to the two calls to
mutex_lock().

If I held onto the first stack trace ID in fixed-sized task-local
storage until I could acquire the user stack trace, it (and its
associated data) would get overwritten when it came time to take the
second stack trace.

If I just used the kernel stack trace ID (and not the user stack trace
ID) to index into a non-task-local BPF map, I wouldn't be able to
distinguish data from different user stack traces.

If I stored this data in a log, adding the user stack trace ID when it
was available, and aggregated the log in userspace, my profiler's
memory needs would go up by 50-100x, which would make it unusable.

Could you help me understand what you're proposing?

Thanks.

Blake
