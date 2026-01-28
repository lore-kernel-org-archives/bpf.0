Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4BE372B34
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769626773; cv=pass; b=cc9wCgKstJptiRMaA3vjAWvyryhjXgBwAwQQBz5/C8dVKwhrj+SPs67RWxM2/FWicQLJoakDe90UGRmFkoWI2w0npGGTCt0THckNIv8PL9X+OxYYP3O2r2mRZI4yiaPY/N6Q138MW7zdq98/GvxVoXQLGftcnaYtsRLCRxcsWr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769626773; c=relaxed/simple;
	bh=ZUuhuB/0J2fpvmMoXKZsjO3MnD0BmMp/y5PlorPBH+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJoQJKxw/kmpWxz4z4x0vvVVYo+wIinPnGV0ZC9lhFflR+XWW/3qVyKbYNk7yvPfBwOrN8eBbM6w74BGN9akXRWeKVWU8X35Y/GqKOJyDAEpkyciou6zAdMYxXzyeYo6WQDO5IwmO0EOEf70/12orOEAfaOu1UHKVvcUyqoT8yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTqFHXD1; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTqFHXD1"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34c363eb612so78483a91.0
        for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 10:59:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769626771; cv=none;
        d=google.com; s=arc-20240605;
        b=QQgim/db/AZCWHPDf0qV7I1jU7jr1uqbJDQqHFHoCqSZnIOMQGSRKKioG/2O4wy3fo
         TuHWta9xvSLEdm12OT3kpHiWlQoDyJU3qavNnoTuOkQ4Bg8Ild3dDWl3BzOU/+dHNFiz
         9E9ATTAfLk/Qc41aKsznFjRgho0dqLpX5r+bGsGoF0dbaDEbfOgDkT5qmGQT5l8qvkIK
         VAjGF8ZAQEr0ZPM/PKYEquVi3waGaVODAb1LNgjLuPY1yJxgN78u2LMdYvuexmPa4tHy
         4JlQhwrw/zY5vqihsqsVaWIRoc99/mMJBz5TWOdqKgYfxtV7UU1tSbOX+TMml6W1fwDu
         1FLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZUuhuB/0J2fpvmMoXKZsjO3MnD0BmMp/y5PlorPBH+o=;
        fh=k0Ce2MkaDb51sPaAMperxY08hsdZuuGTlP7b4MbW9PM=;
        b=XM69Bpn/3EX/MCLuGBo9vBQyI3mnO9Uw8s4TGf6Qom8/wmTTIBwKUEJXyG6xGNjOzA
         JgOmQIGzjcicuTO0Amn8p+itWdzzzxklzjscbUW71Hs+ZzITl/yCCMn7rYt0XvE07ss/
         W1hHXwg/4Zrp94nDybK0GdaOOgrFgYuafyBZt16Ed7GQ48L3MSArSxbUxoh/wENv6T+Z
         bYj76VXPUFOiRPBWN4RyzQ4yg+AhPNtxrIHsGnsqkIhtNOz466TsLBkrsWN7EpUB3zhD
         Qat2/jFmCZWwcns6cNIcj80ub9wiqqPNSfy9Jknuw6IKDsADFBwW03tEHqt5nxgdgfPy
         x2qQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769626771; x=1770231571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUuhuB/0J2fpvmMoXKZsjO3MnD0BmMp/y5PlorPBH+o=;
        b=nTqFHXD1cRx5d/aaLdS0n+I1BvN+k0KWXXGjtiu4Nz9crenqITcJXU92RHD7O/xilG
         K9ku6egzSdptIgiDu+shAxgUM7taeGpvXyMLHhyjlcv4Upu7YaOItfFHg8cGd0ui4Nl6
         B0oGDZYf0sBi3MMKtJ19qxlmAhWwmGZg5et95P+86KK0lPdR/bLMi3uQz9A2EgPLKbqt
         TGy462kiLSPd28Gzdj7dYX8gR3RkPNlyZ5+lTT0ma3QJcXqgLFRSJH0tfOK3YFd5ECvI
         y31Lg0srioe1ngh0Wz66k2duZxSwZChbVUZQOdTmNwH/HZl3H51aLiaKakAQ3clGgtxT
         4xIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769626771; x=1770231571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZUuhuB/0J2fpvmMoXKZsjO3MnD0BmMp/y5PlorPBH+o=;
        b=kbgbrSzZ4bwWMj29ET+W9EfcxEAR4Zct8R+K+vrbIWU+3FZJBAZvcOd6wtLLiTxjOf
         N6Klk7/TuME/7nLcI18MXrz592NejTv6heFnNQD8FITWjYVMrUwWMBFD033YXb/8rAtf
         4aTFcWhvT8UABmTqPqhK+953JsQphOrc8IpNjgg0pFaHwY2F/w88vWERaB7l8sqewbZQ
         w7zaTCMNqb4aqllPkb3oe1cNYL9zX5OPOejb+PCmWrXi0p9/OyTtU76gxB0vz4th/wej
         4Za1a/SbdYG+1kRYu592wsrsBMq5LSIPpU68On+jb/XRYLIgh3OtcdohSYg6qgHKtGPE
         Ug4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8gnIxiTsmxXqikxyyioObuir1NhGvCAe/ZU/2FOPZ4KpgCcUeoajJty3UR9qQd4jglSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywj8GGBxivCPBJ27EJuKSbWeztoWfysmbtBA61ZiQK0Al9x9uV
	IRU/Ez++zXbwBhhuyn0N5B/uWb94QNyrb4R0E7of3sdXTPjZa15myaq0F6CktGjm1oCHx5cWTMj
	DNWm89fGL+0lZ5Gs0fcs+jg9Fa2v93C8=
X-Gm-Gg: AZuq6aKmI3+mFQKjVWaa/kcHk4RncaF3EUWb4vTmxsq5ucy1sM9GnpFLERJjwKnBEuP
	0D8VwjvnxjfKiYaVvQhjrAD91Gi3y0jgToXn9yxkj1WtdY6+RyAP6WmsFwnNdfIgScThkSvizx1
	bn8LzeZnj8m5HpiXjQDS5nipmeRgcK3FsfBY1ebZy5EiJ0fNgDh85FtF7EfX+3rcPhnHSnnG94S
	Y69KUMPTZYDjzQrrezu5lg5nIjMSpIutUUwTkN/ddp84ViGJY63DtRuTsb/pGprilZSizqPVdtn
	7JDgPLGGghXNYvun9/9+FA==
X-Received: by 2002:a17:90b:3c88:b0:340:ac7c:6387 with SMTP id
 98e67ed59e1d1-353fecc6756mr6041046a91.7.1769626771524; Wed, 28 Jan 2026
 10:59:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126074331.815684-1-chen.dylane@linux.dev>
 <20260126074331.815684-2-chen.dylane@linux.dev> <20260128085945.GF3372621@noisy.programming.kicks-ass.net>
 <00fd7c67-dffa-4647-8370-59a195a41deb@linux.dev>
In-Reply-To: <00fd7c67-dffa-4647-8370-59a195a41deb@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Jan 2026 10:59:18 -0800
X-Gm-Features: AZwV_QjkUNRJR2Sau_L0ou-dN1plaIysd0UYjWytfNzLKLYwjuh8FIQT8Px8kog
Message-ID: <CAEf4BzY5tQYSnn4Jwg+cwypnwG6BLLOu6e6=f938d33eSCDObg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 1/3] perf: Add rctx in perf_callchain_entry
To: Tao Chen <chen.dylane@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, song@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 8:53=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> =E5=9C=A8 2026/1/28 16:59, Peter Zijlstra =E5=86=99=E9=81=93:
> > On Mon, Jan 26, 2026 at 03:43:29PM +0800, Tao Chen wrote:
> >> Record rctx inside the perf_callchain_entry itself, when callers of
> >> get_callchain_entry no longer care about the assignment of rctx, and
> >> will be used in the next patch.
> >
> > Sorry, what?
> >
> > The recursion context is very much about the caller, and very much not
> > about the data. This just doesn't make sense.
>
> Well, Andrii, it seems we have to go back to the original way.

Huh, why? Peter is confused by your wording, he didn't say that what
you are doing is broken.

The point is to couple rctx with the exact perf_callchain_entry
returned to the caller in that recursion context. There is no
contradiction.

It's purely about simplifying the interface. While previously the
caller would have to juggle perf_callchain_entry and rctx separately
(but still ensure that entry and rctx do match each other when calling
put_callchain_entry), now it's more convenient and less error-prone
because returned entry will record rctx it was retrieved with.

That perf_callchain_entry should not be reused by anyone else between
successful get_callchain_entry and put_callchain_entry, so there is no
problem here.

>
> --
> Best Regards
> Tao Chen
