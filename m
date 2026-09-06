Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7FF35CB95
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 20:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788728356; cv=pass; b=ifUon8FwKEuM+fYI0QUSdmlWZ522ULGpqWU+HpAUjLYl1MVI/jZqS5Mgkj/133wQMlb8bjms2eILN4wUJ3bpoUqEemyR1gxMbJr/u5SSakvEpcjb/8Q0rOu/gLK+pOjy/fESBnx6EUX7O5WpE2+UShNV/BZZoGKbkItkPRtcWyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788728356; c=relaxed/simple;
	bh=GmWNxMpRYaYka4G7Ng6tm18FCMqF9Ep8MTVv4Hnc9OY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QC8LAYEk7PKW88fRl7csgM0N3q1/CjHxqSrrnH8ksc1VoV2MyUaVFjtm2/kFRkh7Qwmzc/w0S5au7FhCo6+9rk1cZKMYL/Q00xOHoDgHXweu9wzWGScy3rG/OCs6egfhqnW7nAdBZ+P4gypXMIVz3fjfnvPXjrltH5KGLg4RZTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1PZCMAo; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1PZCMAo"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so2809423a12.2
        for <bpf@vger.kernel.org>; Sun, 06 Sep 2026 13:59:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788728354; cv=none;
        d=google.com; s=arc-20260327;
        b=R1pbS7E/6eMoaZlWOHKWmUjB6qQJtXmzRXK8a+TMEBj205xB5TQVPHXDwTvs21vnmU
         i4cmqvuh5PczxLmn9YpsYuXRrvWRP5z1aJpdLcXE7ubEoT+G5G2h/69g5wn8+Uv/Q59c
         mxbGxjo5vmrBlsJQejgLk/DMVBKkDFWdLNIQBIqIJIIU0kNh16d03Ak/67FlvYt49R1S
         3wdVw48IlXhQ23kPYWJxPqzs8/MqgWpVL7nMHj5td4xdEzqTS9RNqp1M3oD2ERVTuKL2
         p0TtW864iMAjlCL+aAixf7B6duVP8tGr8BlQjiYzPVJ1aEB9Kwu3teykmtxA/OWyjNn8
         Cxow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GmWNxMpRYaYka4G7Ng6tm18FCMqF9Ep8MTVv4Hnc9OY=;
        fh=sz02Pah7YgR/8RijVW1v3Unde8wuWDCDANH0+I2r9iE=;
        b=LG3uZb9oi2ef1SqDbdVurufbnFn/KEJ1X6fgpchkmQrxCAmDxFY83TJ3Yrsb1Ky6uy
         17wAfZyjjJ8cVM3FQqzUHbhpiZ++HF93ErzDBOrbs76v9Ku0wLB5nCILa5KoaXgxJnQl
         2DbJRvWou5ehUVXzTboURZQp5TwxuIvNOCWShvS8HlnTMB6JmZWHl7uY8SSSt4zN2IKk
         vxFXn+8bfhnhSlllPCjJyPwhi2s8diqwijhU9vXGhUoSU4I8RJ0/fAlHasdUDnyFFpCQ
         WJ7oKi6eAiP1kc9EeWBExbOwyskWmc1t3tGEbtF+9WfDz7FfwqZaNvdbKG/Rf8VDSH+6
         +UOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788728354; x=1789333154; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GmWNxMpRYaYka4G7Ng6tm18FCMqF9Ep8MTVv4Hnc9OY=;
        b=N1PZCMAoq6Rb9QffgHeGjEtFdwwKouQKwPNj1i2h0i0wJn/Z4n1/nJe+grImNNpbOc
         2Snkh83IjCBfbiDYjmJgt3fBlfHyR5ImSV8OxctE1W8N22uVlDb5VFDIiRe+cNKj/zLe
         AwFXfA8a0j2zSXnaFQz+BySrQeLtR2FnRMUQrpnCWWeyhnstEFa9ayge9uxElZy/zP38
         Z5QbgbJ/jW0E0B+s2rpmd6fY8EWowGyNdre3qmAxnQBeqICi1t7YbtMfRDEBfgqYMYdf
         Bme1NINbbQf/iM7leVTZsJNtpL1024amABE2zRChXG5mIqk2kNUGAbj20Yj5qSwZmf7Q
         TXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788728354; x=1789333154;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GmWNxMpRYaYka4G7Ng6tm18FCMqF9Ep8MTVv4Hnc9OY=;
        b=P5jwWfD7xPntA6Q6j5X5RlwD4TV8/ZcNevmoIe15UGzZmei6h9IbdVPWjty6RrFi5w
         7PFSr1scKCaKP70haJwQ4Ngyj4QDpgTAvHDm3uOMwKqz1ASWzkLW8pbTSd69kjjO+vXx
         yhjYvsV01ohYoIfAtsVS7MQ5hIKK7DLsXVLIF4faEWE56oKz7LFgOCUlLEek7qPeXTqr
         2w+aOrBCl2+Vh04MMrI4V6m9xmxD7iqADEAGX9ULAOG1vvBvmC2NFnG7aXZ826gMU7f9
         ZtmTb+VVQUPlTa0UJH4NacKPgk8kDfXCOxivNprcSFyzWHNpDLuHrskVLyCrH6cOQqNh
         3NzA==
X-Forwarded-Encrypted: i=1; AKwUvBx27ZHmanDa9aYU5cmQghMXgWFAHIhz7cAXJ5lvyA5bdvJvG40tBM7tRiUXy3v7Vid+Yvc=@vger.kernel.org
X-Gm-Message-State: AFuF++lf7jJlMdzwVAppVE5e7lwd4tXwbWpNRPSB1USG1gqFCMtXq7U2
	3gKBoLEyUM1jdsfwYdLmnFhWqMk1PyXBK3bIC88+G3owEo38bvCHjHFSX6ZqDByS8+pihbe1B8J
	UCKaDozs6WZYDwkPXBKKBpLMSwA9asfE=
X-Gm-Gg: AYBFou1P6tRadvDKYAwsWjVZDdKl6O0kuEyPStMugaBgYIn27c+Npcz7gM6mSSGtGBm
	f2jHqIHpI3acp9UCAxfVNw4CsY0YLi8vDCt5WxU3mdYhnbFoHH4ldsdRSJ5izA9lROeKZlTpJTI
	tDQEozlTQ70el91NlQj45D7HNBAZkQYOObuvXz0GSsYpnPuq9qjoYMhtnsoW6tTIlV4M4FcSgYM
	gOPKkokLYmTRAgIiaNw0BcNX6hJoYgx8spjiGEtoUSmNqzbY3UVzpYs7KauIk5zn8Io3PIbimtm
	0KuYs3Q1XNdpCGOopCcNXxSGLU3pP0WnAjcpl9M4jLtUJ2rsDKU3VcIwHLxUugV3+w1RjoCVeKa
	R8MhYF5eZ4RXElARIzTMLKltjMpr/
X-Received: by 2002:a05:6a20:729e:b0:3d0:d1f1:6ec5 with SMTP id
 adf61e73a8af0-3da39bb5957mr28017799637.4.1788728354236; Sun, 06 Sep 2026
 13:59:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906-perf-gtk2-v7-0-1ece839fbca0@gmail.com>
In-Reply-To: <20260906-perf-gtk2-v7-0-1ece839fbca0@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 6 Sep 2026 13:59:02 -0700
X-Gm-Features: AcwNN1W60lfgmZ5yuSBplCeQGrhxaU8sIs3bdr3CFsw0EYVrdti6riCJvMr2erE
Message-ID: <CAADnVQLrga+tx0QCUkviGHqbk9Q6a7bmk3oAe51ZrLhQgRaw5Q@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] perf tools: port UI from GTK2 to GTK4
To: Matt Turner <mattst88@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, LKML <linux-kernel@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 1:13=E2=80=AFPM Matt Turner <mattst88@gmail.com> wro=
te:
>
> GTK2 is long dead upstream and increasingly hard to keep building on
> current distros. This series ports perf's GTK-based report browser to
> GTK4 and fixes it up so it's actually loadable at runtime after the
> port.
>
> Patch 1 does the mechanical port (build system, widget API changes),
> including the leftover-GTK2-call and signal-handling fixes that were a
> separate patch 3 in v4. Patch 2 fixes a runtime issue found after the
> port that prevented the browser from loading. Patch 3 fixes two stack
> buffer overflows in the hierarchy view that predate the port.
>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
> Changes in v7:

Matt, please stop the spam.
Wait for humans to reply before respinning.
7 revisions in one day is way too much.
