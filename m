Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADF339B4A1
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 22:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776119780; cv=pass; b=Xw/LYUwTH2ZPhX2krZVlDfI8kz3601ofb7gGbiEqWIJFKDuW1WJXH9VyzVugAelXfC1d/HdoaK8zCgAVta+ETMtaGhKb2D9FOd6JL9IWKXtdxD+HT/0b6GFW703LcGpYoEaeNNDUAltd8ZLyTpJQU50j5l3DAIO+p3jQKZhaKBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776119780; c=relaxed/simple;
	bh=d8vMZ6K308Us1/0IQb4+4Tj0D+uy5+oDNEDVfIfLGOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LxQlXcUOt7H4iwpOIraoY052J+L9hyBI4J1qtc6mVHorBvn0/UZqChQrI4vuUs1PhwmLhwbWfUxsWxTZVNDmJI6LY13aFLXCcj3pZiej0gBOiYNp+4Uh8QGbwr63ubFsqBYXHXGtBRc1x/HxPigtrLt/Gamrbp4k1b3JQ28WCAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fMAgNRYl; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fMAgNRYl"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c76bde70ec9so1960269a12.2
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 15:36:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776119779; cv=none;
        d=google.com; s=arc-20240605;
        b=ItTTF8E+tsoqDV7PyCL8UldzLQKr2rlvtis3MORNOq6Dt8RW4p7s4/x5OOm2ZIrtYq
         i1QTFVJQ0QOIdlhqmwSFk2vQunDKYECaxD8hCZlalLnxOp4eO9iDLXVnDWn/HC4mOlaG
         dX2LER2LV3naByv/T3GRK7uH8cw5+LX6yKimQ+mv0vLDWGLqvdtnaPprqSVcNGxmL5JI
         c/Oj2IyAOcIHXKRGAFuFe/zp9SsIbY/zTnI8S2TXQNKZEVERAbTTanWxSvTpiqtJMd4m
         0yY1kBPDHG03vGZEFV7G6L2dC2jymkD47LbPX3e5L0lg2HJ0xK6hWXlzWpJ9D4xoGU2u
         5K8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qtbV5B7Lu+P+UBXu1v1nm/SRzL7N0UD8vGEwc1vtats=;
        fh=7JO/zzWF4vXLawapC0+q34TSAl9VWhogAj515/LbuhY=;
        b=W1QdhCFPazlCtsQ2771FbqYZAsbYA00YyAA/+GK5PJdUZTv1K6/GWGwsPRHLAidDtD
         QUvMxRMIaPXbR4h24gy20Thb6UBvCuGEXwjxCpqNISGRsSUlOqszATnWLloZJzl/ycXj
         2PvXmc1GWiKA2sIfd9gcIDiOpbvsZafBcmRzmnkOddx5peE3oOsmPkbEpffH6Xkw6j2a
         LBg7q/NFybl+EEYEZ7pD/DD3TLvlE7hZrsYvbPFzYnjJlyBUA7CzOzyKQ224mPt5r4mZ
         SmMao9l7dN27vji4LodH5ukVXGXe91B98dLWsojKHhfgmLyz5oWHYkAPU8FtSlFpxwm/
         sVZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776119779; x=1776724579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtbV5B7Lu+P+UBXu1v1nm/SRzL7N0UD8vGEwc1vtats=;
        b=fMAgNRYlp3Yrd3ZdH5HEQb3NH4f4EXq3nlut5HRXSXQO+wxCFm16+ZTpfIzd/ND/hG
         d6jqlG6TywVJE0MAq90nxLLT/I0VUvHBZFUtk+uwuu3Do4zyHSjzm5mYBF8n3lzUPnvC
         uEZC3oxsj7QxhtbOcItEtAwhnoVya8NkYw0SXVOCc7TwFchKBstK1snppvmjeiYpG4Vr
         X0lI+/tohvyJsyVZFgQD++itBDqZkc/cQDyhLJr+/lez79gcEEi95trc86S32Oy5oME+
         UwZl34OmlOXrUhFsa1ezN6+ofaEdnZ+Lu+t1C1eQV6yM4iGHsJOpfJ96+KsN8nF7eZol
         hL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776119779; x=1776724579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qtbV5B7Lu+P+UBXu1v1nm/SRzL7N0UD8vGEwc1vtats=;
        b=sVrRSQmytC+HoHMq7mEnXZ7Z9mOeuwGh2zo23QVIFRp8aGzVPMolc/7YGoUu8SG7a0
         K0QlT9VByZCdtdhJuoYqdHWWl6h9ztV3BHxTNwRNlFQ081YzIjuGZu9wwaefpI3y1Qs4
         91I1Xw2vHNplS5k8MmRnnRKCwz8+WlCXkNNCNgyhuQiqbytDTKOcDLSKU50Bpi9lIyIj
         Zx3eygbQm8J3+Zq3z1pKP0eQExFNymjhpIbuL59mYq4rAcjtcA1K7wJWzIkaHndMs1mA
         CZ4gNA/X2ZZKkdoM/Jp0/FywsZBGrN5bJ2ezVkhDwYl+BUoeI00w/x1Lz1Nx6ihf7Kdo
         FlAg==
X-Forwarded-Encrypted: i=1; AFNElJ9kDvlEDHqDTBO+DwVywL1KLXmRt/FXz2Fn6JmLAbJcDxeNucKeiJvxuX9dVYk9sQEDKJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5dausA30XkeacRZQoQvLil2UCU7eH/shQyWIetueOSqbc3ylp
	4nxvrwXICpSXTQa8psApN3BJJLyhSqMGshuGvFmMMRnpmdXhuT2qLpr56qKXY+bi8HpLZpQ4Zqq
	GtCESYSgh3i+KsTC+MeHFLUKlspC1kQH+52q5+rF4
X-Gm-Gg: AeBDieuwMt4Isb1wqYGDnMZR8RVvZGw1oryDVZn1uaTB/7FZ+NtfsFMECx0YQR1mb7w
	Fh4zMAG5/Py8YyMNDSMe2pIkHstdfo5wuzLZ2OyiylUyA04usDiVR92S1SgWoA0fA5atJ0Xjpna
	SpN1ZwUfLhtDvOMWD+BHZXfhkmOSeaWrcYd/cdkjImNFcZFQ1aY/yVH11l7jT8dKWmu9GJGF0Vs
	mgtdKP28XZyPDV3o6rNzd9OoGsAsD69v935m9oerZUNUbqLHC2mjEFUCbIVqZVw5TSZ+Bi2E/m9
	7SipkXk=
X-Received: by 2002:a05:6a20:7486:b0:398:9bf9:7d6a with SMTP id
 adf61e73a8af0-39fe3f51d5cmr16064116637.38.1776119778634; Mon, 13 Apr 2026
 15:36:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-fw-lsm-hook-v2-0-78504703df1f@nvidia.com>
 <20260409121230.GA720371@unreal> <2dd138a2ae87f90c55dbc3178d9c798294fd4450.camel@huaweicloud.com>
 <20260409124553.GB720371@unreal> <CAHC9VhT1X4HX4bGrK=mEzu=g=mZ-Wg-LDXVgZVe-e6oM+W9aHg@mail.gmail.com>
 <20260412090006.GA21470@unreal> <CAHC9VhRnYXjg+vE9a8PeykbXk91is12zYLaO7EFdfZPKMxDfPA@mail.gmail.com>
 <20260413164220.GP3694781@ziepe.ca>
In-Reply-To: <20260413164220.GP3694781@ziepe.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 13 Apr 2026 18:36:06 -0400
X-Gm-Features: AQROBzCpXDxX7fahVQKtrKxvxE3JbcFeRuTT_Qi2M1jo4CF48jegNZMVkpYlsoc
Message-ID: <CAHC9VhR1Uke9P==CELKavBcogHoNCtMZFfNWUbgm5HYUfomhtw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Firmware LSM hook
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Itay Avraham <itayavr@nvidia.com>, Dave Jiang <dave.jiang@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>, 
	Maher Sanalla <msanalla@nvidia.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 12:42=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
> On Sun, Apr 12, 2026 at 09:38:35PM -0400, Paul Moore wrote:
> > > We are not limited to LSM solution, the goal is to intercept commands
> > > which are submitted to the FW and "security" bucket sounded right to =
us.
> >
> > Yes, it does sound "security relevant", but without a well defined
> > interface/format it is going to be difficult to write a generic LSM to
> > have any level of granularity beyond a basic "load firmware"
> > permission.
>
> I think to step back a bit, what this is trying to achieve is very
> similar to the iptables fwmark/secmark scheme.

Points for thinking outside the box a bit, but from what I've seen
thus far, it differs from secmark in a few important areas.  The
secmark concept relies on the admin to configure the network stack to
apply secmark labels to network traffic as it flows through the
system, the LSM then applies security policy to these packets based on
their label.  The firmware LSM hooks, at least as I currently
understand them, rely on the LSM hook callback to parse the firmware
op/request and apply a security policy to the request.

We've already talked about the first issue, parsing the request, and
my suggestion was to make the LSM hook call from within the firmware
(the firmware must have some way to call into the kernel/driver code,
no?) so that only the firmware would need to parse the request.  If we
wanted to adopt a secmark-esque approach, one could develop a second
parsing mechanism that would be responsible for assigning a LSM label
to the request, and then pass the firmware request to the LSM, but I
do worry a bit about the added complexity associated with keeping the
parser sync'd with the driver/fw.

However, even if we solve the parsing problem, I worry we have
another, closely related issue, of having to categorize all of the
past, present, and future firmware requests into a set of LSM specific
actions.  The past and present requests are just a matter of code,
that isn't too worrying, but what do we do about unknown future
requests?  Beyond simply encoding the request into a operation
token/enum/int, what additional information beyond the action type
would a LSM need to know to apply a security policy?  Would it be
reasonable to blindly allow or reject unknown requests?  If so, what
would break?

> ... Once classified we want this to work with more than SELinux
> only, we have a particular interest in the eBPF LSM.

One of the design requirements for the LSM framework is that it
provides an abstraction layer between the kernel and the underlying
security mechanisms implemented by the various LSMs.  Some operations
will always fall outside the scope of individual LSMs due to their
nature, but as a general rule we try to ensure that LSM hooks are
useful across multiple LSMs.

> Following the fwmark example, if there was some programmable in-kernel
> function to convert the cmd into a SELinux label would we be able to
> enable SELinux following the SECMARK design?

As Casey already mentioned, any sort of classifier would need to be
able to support multiple LSMs.  The only example that comes to mind at
the moment is the NetLabel mechanism which translates between
on-the-wire CIPSO and CALIPSO labels and multiple LSMs (Smack and
SELinux currently).

> Would there be an objection if that in-kernel function was using a
> system-wide eBPF uploaded with some fwctl uAPI?

We'd obviously need to see patches, but there is precedent in
separating labeling from enforcement.  We've discussed SecMark and
NetLabel in the networking space, but technically, the VFS/filesystem
xattr implementations could also be considered as a labeling mechanism
outside of the LSM.

> Finally, would there be an objection to enabling the same function in
> eBPF by feeding it the entire command and have it classify and make a
> security decision in a single eBPF program?

Keeping in mind that from an LSM perspective we need to support
multiple implementations, both in terms of language mechanics (eBPF,
Rust, C) and security philosophies (Smack, SELinux, AppArmor, etc.),
so it would be very unlikely that we would want a specific shortcut or
mechanism that would only work for one language or philosophy.

> Is there some other way to enable eBPF?

If one develops a workable LSM hook then I see no reason why one
couldn't write a BPF LSM to use that hook; that's what we do today.

> I see eBPF doesn't interwork with SECMARK today so there isn't a ready ex=
ample?

I'm not aware of anyone ever doing to work to try/enable secmark with
BPF, but I see no reason why someone couldn't work on that.  Just make
sure to take into account Casey's comments about multiple LSM support;
any new LSM interfaces will need to support multiple simultaneous LSMs
(the original secmark work predated that).

However, it seems like direct reuse of secmark isn't what is needed,
or even wanted, you were just using that as an example of separating
labeling from enforcement, yes?

--=20
paul-moore.com
