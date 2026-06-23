Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF9C331EB8
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782243914; cv=none; b=J31kG7MnOcXwxJE639O5l6R5jg4R5ZOVa5x1fdHRQMYN3YsqLnwTEmaRMzBxOlCRTZfhsmWY4z6h2jD6PjvJTgLxfyn7L7xMxv/Ich2A2vIA2igHstbtPevkNXLBTsZrOQ+H+91hQ3tM90zqj3tZzSzyzNgKHNLeXGhbyJyYE3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782243914; c=relaxed/simple;
	bh=w0LYy/lkhOkRJ1mcPpKcBJQ8WkRX9RNPOn4dmhRbI5Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iknJJCg/lEW29AR3KNB7GdaWiokKEzRuX0ikGJy+dv2z7Ni6Vkc7gexVW3hPWOmnQjdC0saY2jLST+Ydzy7Ef1CZJt/K0TJiT4fnb5c2/k8XbkdR+fiDGUabyWayLW+O1eU3kuigcpwgMsFgs7hJiwOYMXOQ005q+nHAtO8e+3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R1hyBgEF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UjIEQNPU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R1hyBgEF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UjIEQNPU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782243912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qROIoP7Ox4zuQ1KlaWsTu9O+Pw1tden3SzMg+Ihd/Yg=;
	b=R1hyBgEFrX893jkR2Rcm+cSFBc7W+rzLAfIQNnqj+x1xu3RX1xMC+2rsuSxXRxDimjhsM3
	8WKqv19cziSr6tj4l9IdjGuBwOzION6yls3tEW139Zbs495GlRrUDbjPAZzVlXZkNFaGuX
	2tKjGPygIWdnvJgZj2Qf+RkxfdjfibU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-ynO5bCHKNI-OlQ1bnAgyuw-1; Tue, 23 Jun 2026 15:45:10 -0400
X-MC-Unique: ynO5bCHKNI-OlQ1bnAgyuw-1
X-Mimecast-MFC-AGG-ID: ynO5bCHKNI-OlQ1bnAgyuw_1782243909
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c07ea058c29so19663866b.0
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 12:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782243909; x=1782848709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qROIoP7Ox4zuQ1KlaWsTu9O+Pw1tden3SzMg+Ihd/Yg=;
        b=UjIEQNPUMkiH4TwPruAPCW4v81RyCjUhxAdBRCU+jiFaYQF1MeZZ3WmGmIj6y31dr0
         APSrj9pIqpIbIw3X4K8OTRWQkhWkRYA8aiE3EKhyHGI94q+NW/FHXJ9R3hBlzk8/MY0/
         Ixyhtob4WtIM1AWkGnuB/prI2d0K2nyys1scIlrmjbTZvFHib5UzPigw/BJjIv4ECqpA
         +hlmX853OkyiNu9LIQvkn42vOmYCWgvkQ3Oyo/rfoRjhVAfq+NnP3NJL438AmCToBKRd
         s04v0/sfyvGj6kghTpRdKXd3UCiMhh7qg8wttzZ5cL+wt99cX+PiusDPVfYKOzrP1CUX
         /3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782243909; x=1782848709;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qROIoP7Ox4zuQ1KlaWsTu9O+Pw1tden3SzMg+Ihd/Yg=;
        b=Voj6wPdiDiSp+gx0ZL9/QDCidUDAMd3v221LmqLu5aRhxiViwFfU+p7nn+Nq5Ujnz6
         tYp38LnGmG72p6dUK0Qf3I4DLxRbaGXrORwUIsbN6dxQGxGelbfebw+Fn33wVkSHHvI+
         6QkpiBw2+sNF7GuQlCQmUPMhUXCykOHV6WKggfhbUeaHyI3cEcqMpCS7exQu07XHS6AX
         sZU7Vytk33PU3e3IdZwYnXE7O40tOSU9XJdo7seC5WLCEq4yHXVJ/wzhZG9HUe4atfwZ
         bpInzkZGocjcKd3fqMVXDBXP+3J8kgXNt17LiuUFjyEplRxNEq9UGQ+aVJ+hGtRgG5El
         Ve1g==
X-Forwarded-Encrypted: i=1; AFNElJ+V7v1MKfNT7Vr2KacO5xvlsA01xredGIjQXCQ9lRv8qc++RWGvtbJbhDvHle8yyRF6cpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz42qEpDTJ7HtadDsn73uKIdQm4LfhzghB8AFfVoYiNRYFBwJVD
	lXWSr9LJrLa9qIGhNXmCVrKw1tQNd1WpAWkqQ7pdyjI7keuP6eJuWbFmnjPDrkVv/cGZEiCVLqK
	OmYFyQxD3o0I2IoC9PLq9AVr9lD2IhE1jFSeKGyw9Mlm5N9HN1FokSw==
X-Gm-Gg: AfdE7cnjCVHU0BmqfDJUk1oqE4KpqiO5na70F6Zxt0pblWhz59M8aXd8abjHRBjPutb
	XlJB80+xbM/oQLMTC7zZzxvn78nhNaPJ5VTsLKUQZ09c1Uj0pyZFcfI3upzNaalqQ8qvanmuiGU
	guGAqOOsb5FgoJre90traCi7GpTCc9S4apsfrAbke1DB+ij333TU68WGwYB24R1uNqXVbnZWoE7
	We48hq2lSB+dIy+6AhzNGRIcgY3uoIMbvhADkn6p+QqKq5gDx+u9JU5FWXqlgYFOG24eKULy1PZ
	/br7aSGLBVK/muDEIxFgCEbbN0VeLsVTTVBPHHHhR3nFv4EjGKmwS1jgqDthFJCfeRaE2w+VI4u
	vHgvNpNJa/R+F6dGVBytonbeQXX3eqW41Hs1fag==
X-Received: by 2002:a17:906:99c2:b0:bec:2d7f:fe03 with SMTP id a640c23a62f3a-c107e0dffb5mr233287466b.17.1782243908578;
        Tue, 23 Jun 2026 12:45:08 -0700 (PDT)
X-Received: by 2002:a17:906:99c2:b0:bec:2d7f:fe03 with SMTP id a640c23a62f3a-c107e0dffb5mr233285566b.17.1782243908159;
        Tue, 23 Jun 2026 12:45:08 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c610e4c76sm563520866b.46.2026.06.23.12.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 12:45:07 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 25089808D82; Tue, 23 Jun 2026 21:45:06 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Avinash Duduskar <avinash.duduskar@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, john.fastabend@gmail.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, hawk@kernel.org,
 yatsenko@meta.com, leon.hwang@linux.dev, kpsingh@kernel.org,
 a.s.protopopov@gmail.com, ameryhung@gmail.com, rongtao@cestc.cn,
 eyal.birger@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dsahern@kernel.org
Subject: Re: [PATCH bpf-next v4 1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to
 bpf_fib_lookup() helper
In-Reply-To: <20260623182849.2623521-1-avinash.duduskar@gmail.com>
References: <20260623025147.1001664-1-avinash.duduskar@gmail.com>
 <20260623025147.1001664-2-avinash.duduskar@gmail.com>
 <877bnpeaeq.fsf@toke.dk>
 <20260623182849.2623521-1-avinash.duduskar@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 23 Jun 2026 21:45:06 +0200
Message-ID: <87y0g5ca7x.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Avinash Duduskar <avinash.duduskar@gmail.com> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>
>> I think it's better to just move the assignment of params->ifindex
>> entirely into bpf_fib_set_fwd_params(), instead of this restore dance.
>> That way this can be simplified to:
>>
>> 	err =3D bpf_fib_set_fwd_params(dev, params, flags, mtu);
>> 	if (!err && fwd_dev)
>> 		*fwd_dev =3D dev;
>> 	return err;
>
> The caller-side restore is ungainly, agreed, but the assignment can't move
> all the way into the helper. The early params->ifindex =3D dev->ifindex
> sits above the neighbour lookup on purpose: that is d1c362e1dd68a
> ("bpf: Always return target ifindex in bpf_fib_lookup"), which took it
> out of bpf_fib_set_fwd_params() and put it there so a program still
> gets the target ifindex on the BPF_FIB_LKUP_RET_NO_NEIGH path and can
> bpf_redirect_neigh() on it. bpf_fib_set_fwd_params() is called only at
> the set_fwd_params label, below the NO_NEIGH return (and below the IPv6
> NO_SRC_ADDR return), so an assignment living in the helper never runs
> on those paths and params->ifindex falls back to the input. That would
> change the reported ifindex for plain bpf_fib_lookup() callers hitting
> NO_NEIGH, not only the VLAN ones.

Right. Well, seems I forgot about that patch, even though I seem to have
written it :)

> I can still get the caller down to your form by keeping the early write
> and moving just the VLAN_FAILURE rewind into the helper, with one extra
> parameter, the input ifindex saved before the egress write:
>
> 	err =3D bpf_fib_set_fwd_params(dev, params, flags, mtu, in_ifindex);
> 	if (!err && fwd_dev)
> 		*fwd_dev =3D dev;
> 	return err;
>
> and the helper owning the rewind in the unreducible branch:
>
> 	} else {
> 		params->ifindex =3D in_ifindex;
> 		return BPF_FIB_LKUP_RET_VLAN_FAILURE;
> 	}

OK, if we do need to restore it, I think it's better to do it there.

Also, wrt the fwd_dev parameter: Do we really have a use case from using
this from TC? In TC you can just redirect to the VLAN device; this is
meant for XDP which can't do that. So how about we just reject the flag
on the TC side, and get rid of the fwd_dev parameter entirely?

If we do that we're back to just a plain 'return bpf_fib_set_fwd_params()' =
:)

-Toke

