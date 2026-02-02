Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63962BE630
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 20:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770064454; cv=pass; b=KJANYRJbUeHuriThjZ3vX2WLvOBnqGpoZ09ZaETZpX7cVuqoiHDLV/ToLksKUMG1MFEOpaekXwiEoMVFTLAVw+6WZVgQSpvrL8jDPiXyKpIrBusc4L9hV+I1CH11FtAbzdelUlYp4aVF+t75qzJ/eAmxNd4JhgOcg4AlChcsmeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770064454; c=relaxed/simple;
	bh=EjTrHJGCKhR5boXRYUI+Jfk/dvUeA0NTVO3B5HxvjZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xdm+iRP5SKGc/SRujR560bvby45MB9UacK0ySBwVJRtLVsmXwBFDcRilNSj1SV4VSrxa0XpJT4fcxAebISVOkgPU7uJZb5nBu3YLU9fOl7e95BlSbnD+D7U1/UwMgTcl78dHxGCRViYcl+3qDX9UFSHdSu0m2PHxAJz1KVP6L80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p3elRbe2; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p3elRbe2"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-658d4059b79so7296364a12.1
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 12:34:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770064451; cv=none;
        d=google.com; s=arc-20240605;
        b=lVjS71+hFt8IVY9k3VzAt/4PsD9p5jDZFOuxK0Meei5B7Q6P/EZNumX0l08HdALM7b
         bdo5sWH+AySPamCUOMzzfM7l3kRr1fQE72/B5IgAoenHNqQkLTBDbwQ2VtWGQA/5fRpP
         cmFPLOyGSqzm55GqIMtktc8ZUp3D+JoMJb94koh6DBfFZJxmsW1riwt18mLDxJZdA71/
         TSxW1fhGRctHyM4cDS09Gox5Zu+ACsPh1XS4On1HFiwGxZ/fvpTMlzjP8A81Wx1Am87q
         NEyquECQQ+n0lMHY8uIQq02TrEsfJqyW5Sc7R/RJVPi8LAsnPDsyAmR1gKcehO9idZHb
         01OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fbUqeYjip+fDu2694PTri+FtAQxkD6UXiSLsVh9cQ8I=;
        fh=xWaSRP5TWhd+mPiTErjzohblhQdAQx7tRnM8OYb68+A=;
        b=QvpR3Mapz6jIDK/tJGXhw8gsg11KedNr5RNWmeWgYbS2fnmBiXw8u8fpqqJHd3Ah6r
         eHZTSXyVG3MbWN0Y2TL1+QT8HcFgkgxs5fNAOLPP7eCOmHEKpd5fnNB6qcX0JZFAp2Qp
         h30+fyvuY3+xxVBDPZ4tPBmadFOvAKd0GnaHOep5C7R5c2kVRMvb4LlJoHSZdO8nz+e6
         9Ud2Ix0btDQ4f3ULJIcifKEHsYY8egrlps8J5FD5HQsaMmEZAHevm1ThpanTrmqSvSke
         Pvbnafih5FWj3VYXtpEnLzsUVGvl6dk+y5rruHROVHKKB0NqmV7th9gy1bTSzVUQBLN8
         EfsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770064451; x=1770669251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbUqeYjip+fDu2694PTri+FtAQxkD6UXiSLsVh9cQ8I=;
        b=p3elRbe2EDd1D2oRb06vHZgZGTMcmwQskgU1EpGm/oAB2gLoLEGe5p/7VrymgkOW0o
         HXRDCXq1iUwgFkYl5TJhkYsksO2TAi/HUFDfvN9zY4skS8dp6mhzMPX7g84CSGqDNbH6
         5q+D0K522ehaQ1VNHGoR+tMy7oC/1485cRPBMLWjHch2LAxo0lLAYambiKY1KSNnLl7H
         kYUYHsty14rIQaLGxOK5pcR54C/xIPEAFgrt3Ph2/ZuOsRr8p+LL/uu0infH3Xa5wU7V
         9SgEtY5putD/vCXtpb+9kbSlYW5yLLXb/ML6vGuT91gD2QylJQ2cILM15ZcJ3dVNH0+w
         z4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770064451; x=1770669251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fbUqeYjip+fDu2694PTri+FtAQxkD6UXiSLsVh9cQ8I=;
        b=wAeAo9S5MVoqh1lyvQiex4d+UH51GZcfdNGPjxeLKg7qVP9Ry0rThwKedxMhD/xiEg
         37VBaab+JdJ13GR2LvAhbkvLAgj8lZHKHPwe4OW+WdT8Khz6YBcKKGCwyPj0H0r3RyYb
         CA4gENpZ7XtxoxUZlOAGYQSH3R79W1p+0u62UGYID9NAt6ktJH/8vteTGwKPvHv+R61Z
         lre2jzrtgioh824Z69DVNUMKYqzohl25MyhPfDd4IX2j0FfTAprJDJHlYQeunvxdKb3a
         eCxOBiKsKI7s6FjIYh4hvn4vg1WOoLgQMObQCppw/lcnkMcv+7eSMRFr/bxpU6VzdeeS
         pw0g==
X-Forwarded-Encrypted: i=1; AJvYcCVuwrLt9Q0ISVyQTqY48YEgbV3qJ4daIqhD8MCKchyEtvWCueLZpEWKwuamVijCZFYg6fA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIlmzmy4qEXEX1w64QO1F9wSa9a8Asl1L6WQWTZFtyloHgPcxu
	UG1XEzXO313D9SoWtKiUsOR53SBXTga02LlzNHLXRqsZuFnrdXT9SGMq5yqqTDnP73zG6FRs4Pj
	vOH8VCBAeyQBZiZqvYedgqGmR2vmnYtzTpgLVIfBh
X-Gm-Gg: AZuq6aId0L3PYg5YkctcGUlR7ti2URX4HyS6aP8TfcrJKCw8B99PAOj5l4rZiqtY4Ac
	LoULfkK6qV1CJKoybYHSmCv+oYeGXsrdSO3SXcGuZVh/BGhaW8bToi6LqTG3LEvOW4XifHjfPYi
	TzZnykIjlV6zROf8c4vjOBpzQZ/rHuHSuZdqvNF2ioa2cnic9Rk4K+EijQPfk5fHsshcHpo3mpK
	qHXHGRqGNGWbfdiz23Lbqew3ocp+6cj33geclhs26YkVCj+ncyZchEcStO1dh0f/xR/+JPT0wP4
	ztCjie85BhgB5i7ZnBQ26loyEg==
X-Received: by 2002:a17:907:968c:b0:b7a:1be1:983 with SMTP id
 a640c23a62f3a-b8dff8071femr749742866b.63.1770064450976; Mon, 02 Feb 2026
 12:34:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260124012133.2451708-3-wusamuel@google.com> <baead0e0a77a98f1f54703a05fcc861f40d8f9eec0a24f96cf26df249dd1cd1f@mail.kernel.org>
In-Reply-To: <baead0e0a77a98f1f54703a05fcc861f40d8f9eec0a24f96cf26df249dd1cd1f@mail.kernel.org>
From: Samuel Wu <wusamuel@google.com>
Date: Mon, 2 Feb 2026 12:33:58 -0800
X-Gm-Features: AZwV_Qg9DXmMmV2h_Maz_0xWq2nHkrts0cRt9nDGe687Gic8SPCzSfFDm2mNxs0
Message-ID: <CAG2KctpZB2EnBHccEYqGMjWiAoE3+HzV-0vpu5J8tejg5opNUg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] bpf: Add wakeup_source iterator
To: bot+bpf-ci@kernel.org
Cc: rafael@kernel.org, lenb@kernel.org, pavel@kernel.org, 
	gregkh@linuxfoundation.org, dakr@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 5:50=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/wakeup_source_iter.c b/kernel/bpf/wakeup_source=
_iter.c
> > new file mode 100644
> > index 000000000000..ab83d212a1f9
> > --- /dev/null
> > +++ b/kernel/bpf/wakeup_source_iter.c
>
> [ ... ]
>
> > +static void wakeup_source_iter_seq_stop(struct seq_file *seq, void *v)
> > +{
> > +     int *srcuidx =3D seq->private;
> > +
> > +     if (*srcuidx >=3D 0)
> > +             wakeup_sources_read_unlock(*srcuidx);
> > +     *srcuidx =3D -1;
> > +}
>
> Should this function call __wakeup_source_seq_show(seq, v, true) when v i=
s
> NULL to notify the BPF program that iteration has completed?

My understanding is that above code is invoked as a N+1 case after
iterating through a list of size N. If desired behavior is to do
additional cleanup not already covered by _seq_stop() (e.g. printing
closing footers), then v =3D=3D NULL should be handled. However, there is
no such need for wakeup_source_iter at the moment.

>
> Looking at other BPF iterators like map_iter, prog_iter, link_iter,
> task_iter, and kmem_cache_iter, they all invoke the BPF program with
> in_stop=3Dtrue when the stop callback receives a NULL pointer. For exampl=
e,
> map_iter does:
>
>     static void bpf_map_seq_stop(struct seq_file *seq, void *v)
>     {
>         if (!v)
>             (void)__bpf_map_seq_show(seq, v, true);
>         ...
>     }
>
> The bpf_seq_read() function in kernel/bpf/bpf_iter.c has this comment at
> the stop label: "/* bpf program called if !p */", which suggests this
> callback is expected.
>
> The __wakeup_source_seq_show() function already accepts an in_stop
> parameter but is never called with true. Without this callback, BPF
> programs using this iterator cannot detect when iteration has finished.
>

If I understand correctly, this is not mandatory. For a
straightforward iterator like this one, I'd like to keep it simple and
not unnecessarily handle this case.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/213068=
80863
