Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F1D44B66B
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768933156; cv=none; b=BgPqe6XBhrnvMDiAit1H1hXJsaFsxqrk9va/6gXs/fSj0KMTrYMIxRwu1Qym8jn29/mptmctN473BPqqzyNccZFAUYVegeKbI9+ye/J4Nd6Q2Co87NS4DV392AX0oN3kwRRd/TYwD5aKyLIAVy8MQ/3skVblZGKcabA84KVVJ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768933156; c=relaxed/simple;
	bh=Z6WkaZNjD+eEC5S2sCu+mWSNmR7uwq/DhhVRU9ARdG0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eJX1XxR3lRvgt2LHTzFrWbaXjT1MUmao3fAcKTKeq9L3owmnDlMp8geJnW8ODlFLIMY0oFd7xyMWNw6f+j1MmoJYi+ycjI+Oa21zLnY6at6FzPcTdV+f6CTbxVdbYFCqjRMSsm9/LLvn6yj130NtwlecyqZhlND5YCmVTFE1ycM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSKLxziI; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSKLxziI"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12448c4d404so4620913c88.1
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 10:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768933153; x=1769537953; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SBww9KLEHQwBhj2b72CiEvbmeQf+WrCHcUWGacrEJTM=;
        b=nSKLxziIag/pKIfQCKmFiGkaJ10nI3Vn1oWj9LoMCM4B/JQIUJjJtXIp80lS0/n4rs
         u/6JuYY3/WpvkahE7NmVWNvO9e1jete2f9sK81KcilSOvIYsS7U+6RATjtIzd5g0Zq2+
         GRHKFYGBI/mpgqpLo3eepLVmbbZO/muS28mGiU8EabYjxlSk+Uo3WmodNscZk5HF8bek
         X/igo3BykZ6TozWfgSUvFimICZhxgKdKliCMF62DOim4yMFAZGv+vkuSusU2YAL/Tq2T
         ZsGmEZC5bppH+HWhqImSfp9lXven/RxZk0J3DvdyTqwLuGlFB5iicdiEDXUaA9BOIE2B
         tXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768933153; x=1769537953;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SBww9KLEHQwBhj2b72CiEvbmeQf+WrCHcUWGacrEJTM=;
        b=I8F06Qb2oMDscbx0JLfRthW6rQFxikT08xtJbo47lEtbCSHLahSvQ0SsVEw/vq7NW4
         QOpC7k1EcSZYutSRGxRAQIeI8qCSEHOQOF/ZFCNzoTJYNGLabqsZDtkuKl6tsh6YTjG9
         7iegT/1xIPTQWCUBCre2chi8X3OKvn+4JpMN6ezQYGiV8nw5HzxDbMCp3jVwEoC5+gmj
         3WU+8UQP5/yz+LGYyrJtXli8De+lHU9Jd0daW5MXXQ9EJyJGbaN8cy+oRMS517aZtHrv
         TrtxZltKR+Ll2JzepbGD+3Duy4qIn9xL6CD8WHa2HQdN8eShdMHb5cHLDvjzS+eSGf4G
         CzXg==
X-Forwarded-Encrypted: i=1; AJvYcCUbovmdgz60Pm1WnbtXDZ2I63BvBnqv/7ILiDyfJOAhi/1phUCg2Y26AfkgUXanTW5P1Mo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrlNklyHaErgPcNGkXfCnK3mirdY3QYpUKMvwObnfqiBpg4+lV
	yX4TyYDjDFlN9ofIpgUDICIRjfStgszvP0ZO1/AsDOOtslAiJIiBOPJS
X-Gm-Gg: AY/fxX6ceYqob+9CAB4G6PNJGDpGrppbP1EbKZRCW1C7h6x4ktTa/RnGPMcf9cBSVif
	nHyz1Hl6jCv4gIfC+Pjm0tHIifr5zVuvZvTLuzLR+Nsx9HJRt32SHpr4joISUx4UAkMMQXCdZVU
	QKIqJWI5mWWn4GPAhtqkz97jncT3+vhyLvArIpPymyM0Us2tOYZvXfdj6S4W4P6QRJeY71PW5yz
	XMShHiQCkgtMax4ktPZfnIB8+1HXj4Bl/6BBSEQfndsatY+gXQ/9fuk2roHsnAM3fn3zMR6IJg4
	P+U3WnQxnABIg4GNl8aARF7J0UZaskiK0rU1mfPoC+jaAfWC2sPYQuMmo0bcYaYkvrmsFWwxfHh
	ztsKAjyWh2HqscsfZJ6Zw7UIqZ038gtyO7MnT3Vpn/EvkKgC/2dfrILO6n9YYwwSOcOwJPzYKoE
	W182tNOL7diBcBSKgCP7uCpC4Uyx3kuGGZQhjDhkNSDCurDBnb8wSbLRzhBkjhvqQ3Qg8y
X-Received: by 2002:a05:7022:e1a:b0:119:e55a:9be7 with SMTP id a92af1059eb24-1246a955faamr2004520c88.3.1768933152685;
        Tue, 20 Jan 2026 10:19:12 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:b08c:bb3d:92b9:704d? ([2620:10d:c090:500::3:93b1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244aefa7c5sm22503340c88.10.2026.01.20.10.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 10:19:12 -0800 (PST)
Message-ID: <b92382bdb9b9b274c0eda1d2bf8aba69c9768ecd.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 04/13] resolve_btfids: Introduce
 finalize_btf() step
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, 	sched-ext@lists.linux.dev
Date: Tue, 20 Jan 2026 10:19:10 -0800
In-Reply-To: <fe471a8c-4238-432b-9507-e2039f7fa9d8@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
	 <20260116201700.864797-5-ihor.solodrai@linux.dev>
	 <c404446ab6d344338592dfa44f5a7e1b95492564.camel@gmail.com>
	 <fe471a8c-4238-432b-9507-e2039f7fa9d8@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-01-20 at 10:11 -0800, Ihor Solodrai wrote:

[...]

> > > @@ -1099,12 +1116,22 @@ int main(int argc, const char **argv)
> > >  	if (obj.efile.idlist_shndx =3D=3D -1 ||
> > >  	    obj.efile.symbols_shndx =3D=3D -1) {
> > >  		pr_debug("Cannot find .BTF_ids or symbols sections, skip symbols r=
esolution\n");
> > > -		goto dump_btf;
> > > +		resolve_btfids =3D false;
> > >  	}
> > > =20
> > > -	if (symbols_collect(&obj))
> > > +	if (resolve_btfids)
> > > +		if (symbols_collect(&obj))
> > > +			goto out;
> >=20
> > Nit: check obj.efile.idlist_shndx and obj.efile.symbols_shndx inside sy=
mbols_collect()?
> >      To avoid resolve_btfids flag and the `goto dump_btf;` below.
>=20
> Hi Eduard, thank you for review.
>=20
> The issue is that in case of .BTF_ids section absent we have to skip
> some of the steps, specifically:
>   - symbols_collect()
>   - sequence between symbols_resolve() and dump_raw_btf_ids()

> It's not an exit condition, we still have to do load/dump of the BTF.
>=20
> I tried in symbols_collect():
>=20
> 	if (obj.efile.idlist_shndx =3D=3D -1 || obj.efile.symbols_shndx =3D=3D -=
1)
> 		return 0;
>=20
> But then, we either have to do the same check in symbols_resolve() and
> co, or maybe store a flag in the struct object.  So I decided it's
> better to have an explicit flag in the main control flow, instead of
> hiding it.

For symbols_resolve() is any special logic necessary?
I think that `id =3D btf_id__find(root, str);` will just return NULL for
every type, thus the whole function would be a noop passing through
BTF types once.

symbols_patch() will be a noop, as it will attempt traversing empty roots.
dump_raw_btf_ids() already returns if there are no .BTF_ids.

[...]
