Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C49714B08A
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 01:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781140677; cv=pass; b=Uer5Rn+YB/yJ2eX5V2Eu6H5axVNCx77X/HCPYnIBILYq2b2SHCckz5pW6TjwehJXr2bAFTOtUhZWjMSOlrfcmj1qCoUFSEp494pjaEPL5o3vCVfZXbtnon8DVZeuyh7Rrq47+GYzJbORQZLQXX0PmZp3lzYEbdkOohw7jV6SZ10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781140677; c=relaxed/simple;
	bh=y6kzzG3ct0h6IoHvAD4R7WtfG1tsXtsc+74I95kF+5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPvqzi6rQsZynvyupTRSOYDznnaqNW4r4uIJzuMzLcXBBPu7GMEIwgw8Z4Vyo8KWBfji4q34vcmHgzahg4dtZ6V6rUOdPt6XsytZT3vLjIol6oTH3H7Ki7p2ZfExJAYOctNuAGliujwN/gMQQ7ntDUSOm1Iix3m9nxBRzXRI97E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1DPFvIV; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1DPFvIV"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7e16f05fd79so79936457b3.1
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 18:17:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781140675; cv=none;
        d=google.com; s=arc-20240605;
        b=RllP0VD7oKiUzJvAs13P1rBxxPItACgJUJttUGOzCbIq+Yj6hMKHdz+vylXwBDe88N
         XW2C07xU/s1NLEP+F64SHgm7I73LVrd2xn7Mt8YckDfEm7+sgqtF5LFj3Z79t6muF/YF
         5dqlP26PYdC98Mi6PqTPqLnVY/kYdbNJtYYL0mBZdUo48EMgg1cnCo8LbYLXR3ybjzW8
         HXyxF2/nMoIjuLfOZ5uX1Pi/428ymo/JAkb8gWidGDyqCjeuhnn2Wc5a8h83F9QOZlZ8
         dY0BPGwgKBhY2TUNVWVLL6wLcMULzAeShqaBisJCbj4Z+fkrz7cRHwv3Vn2Le3N7xSkw
         c1PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cwpdyNCQVE9Z0vBjg+vKg/1VB56zfLGyeI5CigKesGI=;
        fh=xtiVJYSA2QhaQTnB5uwArfpo7uNpQE62Qw2iUFhuvg8=;
        b=Q1KQNey/z/u0OhQkAp411zI2xiyudNFy3vS9RabI8qVBDY+Z2iG0QHi7hlJ/LMHB55
         qVq7Scd5hZ/Mgb3lxdXSk/hI+yNWy00Rixe8NlwFeai6PbQTzFx1cMSYKfn8mqD+WXCL
         nD0CHqL21M5FvpuZA/KrFT0zA7YrilLRC/yfD0lwt6ZyqdJNw9eybWEenkZOlWxIvXEU
         f5aRD9FTZ/MQ9GlZ1o0E4KRDQLYCbR7dCG1j6q3k2Ze7n8B+1CiI4fft3KQj8nrSfJqM
         69vh8a1vPW7SHVzchAF5tMBNmQeTT+ZHM1ZkQYeCmsTSCQc0zDv/29ScFUQusfeKbDWQ
         BZyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781140675; x=1781745475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwpdyNCQVE9Z0vBjg+vKg/1VB56zfLGyeI5CigKesGI=;
        b=k1DPFvIVaJUG0nOCozFMPM7VTT1VRTdz6b/erSM0D6FJdFyzsu8I9bkzXbRDvldUVR
         o7EmWMu/u1ZqsrsPzmr4oj1slHt0VURPq5WDlsGMJbk6rXhKkp7ATlxhpoNenKZGEsGl
         Cx7hgBJQ5sYtzvmRZAPUMwwSCnu8mU6dqFr4hmaqswcRdT1fj9EqNohlAyGcOUYg16EB
         T4qUyin8OQ6elJ9d9MZnNWkslxZXl3d5eanQ5StrgGbMvOsjHr/R+ZdtkMt7dVDk/0NN
         3MD/jFHPy0Q0UbLbLBGX2b9K6qZ5Ad2N025qBEhBuS72QN4QG9hbyzNLvTHdXb5jiE+t
         LNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781140675; x=1781745475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cwpdyNCQVE9Z0vBjg+vKg/1VB56zfLGyeI5CigKesGI=;
        b=QEtO9mC9vKPDFxPS2FkEpQ6AS/a02HRgXaWD/OiduedYVDFnpd4ZpfOoy8AORBVDLL
         uHgSgB/Yj8bYuZxxOABcrysaNoKhRaAyPWORKae1t+n1YckFtM9IwfsKtnP9eHEmF9BV
         zWQTLdbQaJVxIi6J0w0/OK7IutlvdHSzhP0XMq0qeTphOr8i0b57UPGH1SPyFsHOkCAT
         t+Phf7iFuVI4+D7LSyvqmwycG/1vR1T+wJeFcWRCgIk9CCMhN07W3QhFeMdlw4gm3OZz
         l3NyCo0KqcBUKY8Ev5UUfDxb+lnhpJtfXRUVQsS1rrSBG+x+Jx7ckej3ekhU0BXI+W0z
         +V3Q==
X-Forwarded-Encrypted: i=1; AFNElJ+j4ROgEx7K3qPbzqnSv+7IBXSSSoKioUM+zm52GfzesQ4DE7/wh5zTdZ02RuguHct+IDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtaXtpbKP0y16RMc+9FR/0B5UsQLjYnXNXjfvAfkARO4/mrgtp
	LJoOiYgpiBDwusORqRQpOvYHxbRPUf/hl85jFV+RXUcF9lk1ZN7d0JDYbHtfcGYo+ZMLZZRfRoa
	UhOAMy3+g8d+axUMjwqz+tslm/D47jqY=
X-Gm-Gg: Acq92OGFtsrAVdw37z1lZwLG8k85hNqGQBBQN81uv0/cMCRVxuzS3bVUT/BkFYvh5JN
	aUyl2RKDTZsL08xT2oNMtZ67wdJZ7HLqXU5PkE6ENiV4A5RzV7T0b+2gVr+/mIMeRcvL/qqSCAs
	8nltoXXpXZuYiZKP4c9h9V9Yt+Z6cp8d85pKPdTtVgs62HjITZLe4OXNHrxDQGcHAQtAFpTaloS
	ezZJ4eLtz+rZfdsrNBJ29hdxyHIUweBHpX2w9QlV0h3MngtzYfQuNW22TFWo5f/45z1Ltnka9+P
	4H94BQVHMueS0eHZOAsebT5oADQIZabemRLwCIRHRIiyeLf6ues0Gov4lJBzSEZIUVw0fw==
X-Received: by 2002:a05:690c:3392:b0:7f4:fad5:2084 with SMTP id
 00721157ae682-7f6559e6bf8mr8454907b3.13.1781140675216; Wed, 10 Jun 2026
 18:17:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610102850.483291-1-sun.jian.kdev@gmail.com>
 <871peeacre.fsf@toke.dk> <20260610075018.6162cec7@kernel.org>
In-Reply-To: <20260610075018.6162cec7@kernel.org>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Thu, 11 Jun 2026 09:17:45 +0800
X-Gm-Features: AVVi8CfDR3TXqyYOHmrrylWsHkJhrNSrybKrnHMejG_1zq7GSb6GOaAcLezoD7U
Message-ID: <CABFUUZEKS9P8=hsboyBj_f_9W8ycZHVG3GwqmtcnUoiRgh8iVw@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Run generic devmap egress prog on private skb
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	bpf@vger.kernel.org, Menglong Dong <menglong.dong@linux.dev>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 10:50=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 10 Jun 2026 12:52:21 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wrote=
:
> > > @@ -700,12 +700,22 @@ int dev_map_enqueue_multi(struct xdp_frame *xdp=
f, struct net_device *dev_rx,
> > >  int dev_map_generic_redirect(struct bpf_dtab_netdev *dst, struct sk_=
buff *skb,
> > >                          const struct bpf_prog *xdp_prog)
> > >  {
> > > +   struct sk_buff *nskb;
> >
> > nit: this definition could go inside the if statement block below, to
> > make it obvious that nskb is not used outside that branch.
>
> Or maybe move the copy inside dev_map_bpf_prog_run_skb() since it only
> has one caller and already checks if prog is NULL?

Hi Toke, Jakub, Jiayuan,

Thanks for the reviews and suggestions.

I'll prepare a v3 that splits the selftest into a separate patch, makes the
DEVMAP_HASH keys deterministic in the last-destination test, and fixes the
Fixes tag to point at the generic devmap egress-program support commit.

I'll also look at moving the private-copy step closer to
dev_map_bpf_prog_run_skb(), as Jakub suggested.

Thanks,
Sun Jian
