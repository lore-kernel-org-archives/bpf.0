Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB27831A072
	for <bpf@vger.kernel.org>; Sat, 31 Jan 2026 01:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769821549; cv=pass; b=Xtw8CKWRbJpAjAo9h/2em4Ts0OjkgGi/FUPK8L9LYzrmA/M20xc0j+ZMfbyv4quWjvYLeiyx0XdPr80zIUfvgY5JtwLUqzGyRIfpsAaX/PbRUL3lD2UmNHiiAtXhV21KfOG327VRB+n5FZCivHBJPNDLMQ6WVQE9Lkx05DkopVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769821549; c=relaxed/simple;
	bh=xauAVDrNEqxXuQQDfkuXjcLzA9iR5d/8KDCLj8SlAUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDltHPvMioGoQDdjwGqQvGWchvZkN/V8ydBjc7aNjWscTi97C5s3IpgsADXDD7Wns9A3KGgsOGGilDyaiDM22JepMNZ7jDkN4QyzjyO2R2qF7cZF8SyP5gvwWE5UfJ6PoxegRDIU6It4DKZ9Ne3Q14bfyRKsz+9tbe2o7I8Vzuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HllqAs+/; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HllqAs+/"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b884ad1026cso429821966b.2
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 17:05:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769821546; cv=none;
        d=google.com; s=arc-20240605;
        b=X6e2N5gEyhpjj4z8gT0d6od4myt4GdVvyY0JvYE0TAUbuhcwMGyh4305/UgYrn06R+
         /yme9AkufTxZojIl+8cCygyLDeAW1GNq6QCRdQCJYsndAI1P0VdEwYzUdhXVcCMwe7d4
         JN3PYqCUkiktemVDAUMuWTPRhkzQIpvsaYxtvpDhVz7t2NV0q9U57WL4NOTQU/lN6AvP
         gz6fSm73JRzYs9dcmpAgFrr0FoNZdZyZyMijJ1Z8dU7nA2mfruHOAjQKgMbbAHF6Qmty
         s1gephGGb7ZgZvlGc+UAxDgRnyv1XaT97CUvaDl3u0vOyZV3O3Y/oPe2Wh3pckLG+X2T
         /9rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WR8rpY2KGV4n5Wdzx9LxUGbuZ8iHOgSWcj67TDHRUAg=;
        fh=gyPWorsq5J3r1N3A9Cttoyggkwl1m2Q9VvpsEXheUCQ=;
        b=SRU88n4JLxgWa1r4g4jus0BWaTGa2ACTk5+jpIDwsHCSH0TI9HddF7SMaTZaf8wLAu
         u4icOUnsgcBVC4Y1AiMj8ntK9cUqbJXtQQbon5z9fLE152ST1jl0Fdw/zfSsV+fAzKJn
         MtBv58ahmYiqt2FIlZ+soe6R/BbROQVLm9DAh3055caGMJgDwU1sLmqTNAfNSlGyeDL1
         g/k8ZIsBJ/ikSUeAGK0HvRZH6Bv8HVF5SDNtlcyqQndcIKKt847y0DyO3DoFcOY27kPr
         Zk0PT4vT4GtOLtckdCi4DUN2gDNvpVP5xIiocfVEmpxRg5ZslITxT6bZb4u6Lw+QI+K2
         z0zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769821546; x=1770426346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WR8rpY2KGV4n5Wdzx9LxUGbuZ8iHOgSWcj67TDHRUAg=;
        b=HllqAs+/IWHE2+kQ9ii8b5Gtko1h7Ik70Pwl45FY+prbj2XSVoNyELK+flYSa2NQo8
         EXfzD6mw0oX/ZlcIu3rfD3gSpUvxACQGYIH/Tl36lScTzSqGPf7KX8gtg3w/jdI+zaqh
         b70RFAKtyAAsDtS1eh60MRioJEW4g53yrxfS3kn8JvPA1T8gyDJ3TbalXssoUOVJkQbB
         jvGjJObfMMQbMdMBdGn+zwg4BMNPdymUx9VX9d4oC/MnBUwn5iYrXwM6DX/OcGYm3wZH
         /zCPYr3iPl0vH84xBlQRUFtR3PnsqszdSt7W3HzHNo81Di8s17L3tMFO2MgvOo+9Qs0Y
         at9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769821546; x=1770426346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WR8rpY2KGV4n5Wdzx9LxUGbuZ8iHOgSWcj67TDHRUAg=;
        b=FYWCAYPdxzdFOKs0+moYASAmiL3pZ7+jeK54snska/KNlKFsie3+IVZJBi5oeTy6qi
         Ybjb5NLGMenSjYfkA5h37W+l9Gjm+GW3MvsI4xoiy3pQfIcoWtQ4B1aE9jZrohX5UHn/
         EKfFGISi+xkUhVWFbJVv6PWgGep55R/yPL80uoVrBcHMKH7B9iY5ujN9hPXhSk2/yEVl
         d1MqCFhZ+34ePtm8aY1wBk2M6YwswgSgnnHcunBhBNirhNVfVDNJePjVBR7u3jMDWG+N
         B5YZ5xy2T6vBsbPNzy6Hj1yXJ1RnMsc9MKt7EVfUWPPweO8Y0rg76b5iw8pQ5PqlVRD/
         7cHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ9wOXYoaU2SORyI+eF0vVNYBRWPT+WFxQgCbKbCQRpmXigyi54SOYoEqF82SiAroITWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGrvFQBWcFEVSgMdat3Dvq3pdJp5dLxpddc/KVFVHxDYFAf0gf
	YXnUXGO2U5JIYlA6IzIA5e+RXS/cF8DtkRbZHm9ZHHaWAvDpZinZNyNxJw+AbtA/CkuICtyhFUx
	3rhoB05J6d69/waM4yQMkECNx9Y2h9H0eFpygoDZe
X-Gm-Gg: AZuq6aJvXjTQMWAy4pEtFVoYrMiCxu8E1DMHbiWzkdQfVxV+BluuJ4mTGu/LWvjXmAY
	dfbyzvuoSIcCwxx2SoherHMvYzOKSFHU1ZnEumZlkLtDbKOnJqI/3eBuXtIv02KyWOdUfhjhCLf
	n5hDBNBe2b2P4PUF5tHpTGhhM7QTkC//SLXNh5CqcZCjN23J5wXNozkiw3sttOsvDYs5lMusAK/
	qDKwiMgXE90HRLPsA+dnLVoxUOyI/teRI3rsSH70e2pZhTUOamAXh1SfVCg0/nQ9FkW/5S9+k11
	8Sk=
X-Received: by 2002:a17:907:3e0d:b0:b87:322d:a8bc with SMTP id
 a640c23a62f3a-b8dff696c0fmr254282166b.31.1769821545900; Fri, 30 Jan 2026
 17:05:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com>
 <2026012715-mantra-pope-9431@gregkh> <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV> <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
 <20260129032335.GT3183987@ZenIV> <20260129225433.GU3183987@ZenIV>
 <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com>
 <20260130070424.GV3183987@ZenIV> <CAG2Kctoqja9R1bBzdEAV15_yt=sBGkcub6C2nGE6VHMJh13=FQ@mail.gmail.com>
 <20260130235743.GW3183987@ZenIV>
In-Reply-To: <20260130235743.GW3183987@ZenIV>
From: Samuel Wu <wusamuel@google.com>
Date: Fri, 30 Jan 2026 17:05:34 -0800
X-Gm-Features: AZwV_Qi-TVApb-UR_yhUuzDZcqy8acCYfKVdTsorIhJOL99wmGwpM0Som40uK5A
Message-ID: <CAG2KctotL+tpHQMWWAFOQEy=3NX-7fa9YroqsjnxKmTuunJ2AQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, 
	torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org, clm@meta.com, 
	android-kernel-team <android-kernel-team@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 3:55=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:

> So we have something that does O_NDELAY opens of ep0 *and* does not retry=
 on
> EAGAIN?
>
> How lovely...  Could you slap
>         WARN_ON(ret =3D=3D -EAGAIN);
> right before that
>         if (ret < 0)
>                 return ret;

Surprisingly ret =3D=3D 0 every time, so no difference in dmesg logs with
this addition.

> in there and see which process is doing that?  Regression is a regression=
,
> odd userland or not, but I would like to see what is that userland actual=
ly
> trying to do there.
>
> *grumble*
>
> IMO at that point we have two problems - one is how to avoid a revert of =
the
> tail of tree-in-dcache series, another is how to deal with quite real
> preexisting bugs in functionfs.
>
> Another thing to try (not as a suggestion of a fix, just an attempt to fi=
gure
> out how badly would the things break): in current mainline replace that
>         ffs_mutex_lock(&ffs->mutex, file->f_flags & O_NONBLOCK)
> in ffs_ep0_open() with
>         ffs_mutex_lock(&ffs->mutex, false)
> and see how badly do the things regress for userland.  Again, I'm not say=
ing
> that this is a fix - just trying to get some sense of what's the userland
> is doing.

Ergo this didn't make a difference either.
