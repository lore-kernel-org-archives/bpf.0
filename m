Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A49D13C918
	for <bpf@vger.kernel.org>; Sun,  8 Mar 2026 10:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772964083; cv=pass; b=B1KmgV0gzt5YK2gPixYISedWvRP6HTjXIDgrorN66lYp9tXDz+9PiyoUJNK7TKA/XC6UnC3ViPW2N4RTFOltrVjfI26ts0TwylkKm+zZ8+ACWoOFyNuFBI9hth/OAwqY1YOusuF3x8CoI9Be8kmHq0QczOLXD1naiPsFH48SPEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772964083; c=relaxed/simple;
	bh=b7LJSKV14IjUILcevbUXEQrSrJc8p+kP3/Pcv50K3xM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CBfMWNkvtF0I1tByiAimBM0S0ni0Dbh/9I0sJaaq0gQdFSv0tRBZfKLe70FRw28vR0r536entMshlfvDYXCsa0GKqEMIqQgU8MiWwmIqY1c2ustN7TV3qrCil5M4D+7ej22M/ydU4rIZpnOehA24jzVkOE6ASsd/KzVMElJKmsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJMYT2K1; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJMYT2K1"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64ad9238d8fso10478701d50.3
        for <bpf@vger.kernel.org>; Sun, 08 Mar 2026 03:01:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1772964081; cv=none;
        d=google.com; s=arc-20240605;
        b=enzwHzy89zJmB5L85gZpdbEHK3AVb9bw6ZazS+jNi2N5vAndwAEzfiZZjeH+oEmzmO
         81SmkU0wG6IVvNiMr9pFULklkXjQ8k79LtMYtDbI8LiSz9e0mOgb9QpxceLXSq4/ZXc/
         nIrazg7xezCEOGFQK6dRCtMzCr9mYAT/Myfptle6KCfDFF7P7Z4SF5Cn3KP1mcNbO5Vt
         6K6uw0+4xXc3jHBFHdvoced/LxKyDYJ2i0dpIPclgXZ6fIujov6yYQXm1rTzgIjcLn1q
         1k1E1qsUUc1xCfZc/pif3Q0dPJEdeoOBC0q8pD7lnt/sO/MTEuIsWIUM4+sFMmFMS71L
         Mybg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b7LJSKV14IjUILcevbUXEQrSrJc8p+kP3/Pcv50K3xM=;
        fh=t7uE7o9u0VRxQaeqGAvHgCeimyRJALjAQ6hJX56hyHc=;
        b=HTGnw+vgpqpuN8hF3lpKQBSDQMgkdMYFXTKaKhykaGdcL4ykz8w4Se2wl6A0Kud13l
         BLB0EMjdTAd62yCEkmKx4MY5J7DDdBfqWBm4jdQAAyiwukM48rncr6BO1CEUxBnacAmO
         qY7SHC00B1uyJOhrayHKANNqFoxluirDbAdvhep1+N/flykgnN1/y7GKGTvWXPc3zgcS
         4iYboEC16ZFepBV5BWJu3Rowz3PMVXRCcTRGQQFnUgsWxnfyLNiu70gp1DlPPdH3MeIC
         B0T67MBsuQsbyKsfLy3c+QzHDx5aPXI7TW9JmOQOySTpo41GhWfS5UiHa4lkP4WP0f4U
         xwBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772964081; x=1773568881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7LJSKV14IjUILcevbUXEQrSrJc8p+kP3/Pcv50K3xM=;
        b=mJMYT2K1velHbWaUWxR8X0ITgQAID0cxfoU3jo8u5A1mCSaGBYFN0Ja946kBZDvAhb
         nUHK3e2tRVxBkEnS1++WwTUAaM+UaXwhHYiE2lU6FfEed1lWsuZmLaOJ1Syt5IUaf3Ti
         YoSwkxwGeiXZit50eU4S0d082b4hcB8kcywtetKU4VO/vCsDiDdQmHB5lKCnXWeVMZs1
         CB1Y4oHKe7PBGxrVvIXwLmLQdxntTOVjCapfatA5hpyly32BTOd08Qr/G6FUfL+v8tXn
         XikH5TNgrc//8Qo/oWit2a1HFU0ymO1vZJcgB9eAtqAcZKC0w9hJenZ0bBFtN43gYmxD
         Oc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772964081; x=1773568881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b7LJSKV14IjUILcevbUXEQrSrJc8p+kP3/Pcv50K3xM=;
        b=CtueLEB8rmSCYPISoJq82M3FWW+R2b5F+FOyQgzMgRISXRb4SEAauu2QUPsQHhLXuB
         Wn/zHxZQBY3dFodQMctFujV8cEsDP4korjbD8GHm1pi3lT01tpIkvKDJHSwXHs2SikKY
         lvLLfgbrZlv1zTMNSgH/DcempbjNmAJTDBmFEVA8HXcmckiDlMe56/vOzIkeB0M32Mys
         tImbO6wbzN01xoUWuO6/PDROqztIbpRB+nQ6O7bs+1Dz2MWEijrnTiKx85LOxSOOhkXM
         ETeSDaSxlumtNEwbX+7ocMZ14G7OORqnq/aunVwHqdIDjTs6Nkx55ijuPI68kuVn7V21
         Mh9A==
X-Forwarded-Encrypted: i=1; AJvYcCUHBt1EbA8OmT+EO48dILxwTLX9RoqmY5d/YXOulXItygPW0eV2sxuVs72EgJ7omtFV6+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd5QhgBW64V355u5jZyNblEd11SiydYx8lHzddY+qM1HFXO4Od
	y17NXrFZfcpcv7EZY3oLRYnsbn+tdFH1liZF7t8SMXgvL7BqLYuxRGAnw/gVVoyA0fhUbQfMAs1
	mOI4DKn0aLFM/ZIVZrJCQyangLfW+keE=
X-Gm-Gg: ATEYQzwfDmVvL5TBEdSb3ysULqIbXvMBsX3O2r9fmkRzqLRaxEQuwxmlPy0e1QhLP6+
	9N4lrvBmOrWL8CMj0zvJ2/G/GI1DK1Uz07J3fEF09T4tpjt5JgFdmI/yM91/lcAMfpm0UZUdoc5
	TLHGgTSXQ2EpdoXSHI5ea2V3Op1sNjO71bnA0cJ4Caa0dMTwR/U2dWgeP1+ljpLJjVBuTnaHfVe
	QAg9fZfP/QUEbl64LW7XvlFO0nGz1itbSOtSj8EyvbqZ5AHWM5zT6k7MBWGFYshePsD79l4/lGm
	QMXIrZsQr6hAeg==
X-Received: by 2002:a05:690c:34c9:b0:798:e620:c4c9 with SMTP id
 00721157ae682-798e620c55emr44448907b3.50.1772964081228; Sun, 08 Mar 2026
 03:01:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306120024.1032301-1-sun.jian.kdev@gmail.com>
 <aar9gzh7QVhezeII@Tunnel> <CAADnVQJtG9s1CV-qeF8NSgi_UFPgahOXtB3PWiivBooAYC69GA@mail.gmail.com>
 <CABFUUZGV7ZAVY=Y6Py3ytZUzZV0i9otPWADgP9HtVrDzf612ew@mail.gmail.com> <b45c98d4e59bb31c3101d6ae2ef5d7cee8b4f6c8.camel@gmail.com>
In-Reply-To: <b45c98d4e59bb31c3101d6ae2ef5d7cee8b4f6c8.camel@gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Sun, 8 Mar 2026 18:01:10 +0800
X-Gm-Features: AaiRm50KjtWFkDZgofmR-lB5_TXyaKS4c2EWK9-h6YthclHybfyOLwRYlyUqjSQ
Message-ID: <CABFUUZEZ1ZLP-cgS542sqnoRT7bu=niFCrUU+YOVEHLLGaKOdA@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/bpf: avoid jump seq limit in verif_scale_pyperf600
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Paul Chaignon <paul.chaignon@gmail.com>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 8, 2026 at 4:12=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> I have an old investigation for the pyperf600 failure reason from March 2=
024.
> Attaching it to the email. The discussion happened off-list.
> The source-level "mitigation" I found back then still stands:
>
> The decision back then was that the "mitigation" is too brittle to
> apply and we should leave the test as-is, hoping that verifier would
> get smarter some day and be able to load the program.
Hi Eduard,
Thanks, this is helpful.

The write-up made the reason much clearer to me.
Let's leave the test as-is.

Regards.
Sun Jian
