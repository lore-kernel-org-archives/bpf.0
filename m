Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CEE21D5B0
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 00:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776733104; cv=pass; b=t1hRf0qEP6x4CQt7q5o5lwrut5xoYpUKnSFIk6QSFCMvgRDrB/WsO6UZ0r2hCiay29PulUXlyx65YEuXfEZGy+Jw2PGQjmOIR/nfNmO8lfvJR8exliHLEt4EEwsX+I3wCfD31N0fgUBMXrl+bneGNwYtRV1AwpaVtCY14NMpWOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776733104; c=relaxed/simple;
	bh=LHJgU5o4zlFKIDCYIg/sT/NOeaqAOnix6HRSAOXirFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gos5gEbvqfOfD5WvCRxl5mDFeSMmZsgbADIUkH20LfT6mtVR8xaz3aKWRcSewdTMKN757BVe/ES7O3h1fbGy3bOBoHZg4JxkbSWgU2CtnFDVlsLEWOOfgoqaHWvwNjgyWhzzt87xJ0YbP25pDph2AKEDSubYf0MttbNOgSlXv7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JkYmabei; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JkYmabei"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso2796287a91.1
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 17:58:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776733102; cv=none;
        d=google.com; s=arc-20240605;
        b=MsVEV8T0CzVe9PYGPidTg7xJM30w1du0BYZp1f89AI0qdLBkAklbFp9MLuXhi0Q9vP
         NeNX0Ut3QZc87rPRd3xB9hrIwPT9StwHdjwwRcgTTjIBSff0H+Qq1EiduB2RLCpN0gN3
         +TtmF3vDCu5Wp9a3FK1U5ybWi45p2AdR9PcB6CkIvkXv3VtzQmvMmcZfqBt4f6CcrfPW
         GmpAAHO5UFYm2HYsiOs3X2y2nkTAZ1x0IKuVUisWTEDd5DUMmornoFg8xqGdCvGBv2Rb
         aY3WHevDxGmh/iPsa5wTGUTlye01t4DcGifbIv0NLhxL0miJZVhcVK7uY2Bf1KpvODNk
         7O/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hlwm4FYDSQRfdqm2h1oqg/AzDTMUaQgoUeyswjnB5ZI=;
        fh=SCsQSzTpqhAxGK9hkC8gMppyiYqbCrcmjbELzHl8Ufs=;
        b=OvGuuz/6zsHz8VEUWk3Q+yq2DEJX+jvayMHw7tXMdS7u90X1RqVYppUG6pw5aNnJ2f
         r4G5K7m9y6boe4Dlnmb8howLZo3VzUU1js7DMsDfFGZd0L2X9MWHJahIfFyaShWHmQm0
         JLcfS/2a0KNzJhp6po8CyUyDzza4kOYERcSP0TrOkOOrkaLP80P+25BoeECwIV+KlyUY
         Bvfnj9b6oePdwyFjUA5RsaDAmliiNn5RMQubcRMB3suTBlIuXljjuhtqkfyjddG0v2sM
         V7Swgcvj7E50fksL5DgUomFh7UoeR1evjiVC9Q7nGm5Epc//FnTj0NFLeSKpvk7vBOpa
         n/gQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776733102; x=1777337902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlwm4FYDSQRfdqm2h1oqg/AzDTMUaQgoUeyswjnB5ZI=;
        b=JkYmabeixhCW3tygHOkl8WHNX/J5tVEwBNxaOTCUx1fhT6a4VRqQ4KTAUyOp3RDzcn
         V8rNaSD14WyBq0UFkks5ao98rXVK3xZTp0vPPBgZXL+myN3j2A+m/YTxtYio3DbwnCqc
         VeQVeVooZ439Cgg6nHODQ1sgd8g/YMq2EUK6EcGw/jahwiVYFs7PCtBItL1d6bBvvr2I
         DVKePZQq+wXAxdNzkOrwyzwx5AM0ZK//yXwoI3hdFCf19AQFfnWSUAyB3TcdIc9mG3xf
         acFtYZZ7W9wyU5pL86gjdQm6SDB/HwvmuAyhoj9z3R9H9j7NVYzJKus5oAOsTWd+Mpyz
         hpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776733102; x=1777337902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hlwm4FYDSQRfdqm2h1oqg/AzDTMUaQgoUeyswjnB5ZI=;
        b=o5T4/OAdCryPOZBXRTs/j3n8tjngyDAfOfgfqfcXf/HcVhyWvudC7AchIw18ZB38rg
         nWnBqP10hrUpzIPnqjYvVchtiK2iqsQe2GcIf2fQf8vcuIOl6qhmiu1qbxhajKuInuPi
         NYcH7ZIRyuD/lV8UQYPfLL2fdQDgpSxHKz13MfFCCXarHSqfsQOlaPnrRRKl5GEB1Ndk
         ULNp5KQqKhBMCOWf8xKRtLroNx6G/DvogkRcd/m8Lii0R7kIDn1Dz+ssBE98ocMfuJNx
         68Ir54AZ6OsiOPVWrzRlgZOgqLSbNlonSQTjH+/Up3F77Y1ELjmGdIQZIWOOI+0IAPVI
         tWqQ==
X-Forwarded-Encrypted: i=1; AFNElJ+oRupk2It8H/GnUU5jb52+X0A7vOqFIHJi8y4zkM4hXktQgvB2Msja7tloIHJreWJNfnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX/m6+yx1UIxqVkEw67sOEWTWTjOjPjp7Vzk7IWcF78jKfC98K
	VO8afpwCeLcEuV8dOTAw+ZbZcogbAkge+2GNCcsmn2fvxxedFodrLg80CPXPrYCJnnk4qmjdhFv
	Xa3Ny8vvBtZ3XANWw/HTcZo91mewH5ffXOCsI61TK
X-Gm-Gg: AeBDieu5sfk1a3XNRaHMrCy2IZYpx++VP/1PQtBa4QJKto3rEFuzITH5LU0sHzqiu8j
	2zzl5UanVfP/D2QDS8uIHpjtCOk6QSK5/5pgXhOabfnWDFb/rGFa/J095CxWWfAuNAV7yDhHEQt
	XAnwuluFXgjhfkYL1tFXT8OTxprbzpL3rdh3f4Ce4R7Y2JfG1Le7grv/1870eXbsdkz5K9IEusV
	q2oAIdWj/6yJWmxKcA6tO7W2liNxWpwNXF/E2SqHm18pq3J3vghoPWq67asaKOsIHUWYZJnFYR7
	RE2vwg3i5Mz4HTgdOMLwjG7yCbsE
X-Received: by 2002:a17:90b:4c8c:b0:35f:be09:1a2b with SMTP id
 98e67ed59e1d1-361404104d3mr15707115a91.10.1776733101940; Mon, 20 Apr 2026
 17:58:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409124553.GB720371@unreal> <CAHC9VhT1X4HX4bGrK=mEzu=g=mZ-Wg-LDXVgZVe-e6oM+W9aHg@mail.gmail.com>
 <20260412090006.GA21470@unreal> <CAHC9VhRnYXjg+vE9a8PeykbXk91is12zYLaO7EFdfZPKMxDfPA@mail.gmail.com>
 <20260413164220.GP3694781@ziepe.ca> <CAHC9VhR1Uke9P==CELKavBcogHoNCtMZFfNWUbgm5HYUfomhtw@mail.gmail.com>
 <20260413231920.GS3694781@ziepe.ca> <CAHC9VhTLamfe4C81ZNRVT=H32x+KLxSqH3o0eBfrHsWAgAqxCA@mail.gmail.com>
 <20260415134705.GG2577880@ziepe.ca> <CAHC9VhSECYihup=tURo_Qk__xUdYYPkHgnz5CWA0BrRAkvwbog@mail.gmail.com>
 <20260417191749.GK2577880@ziepe.ca>
In-Reply-To: <20260417191749.GK2577880@ziepe.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 20 Apr 2026 20:58:09 -0400
X-Gm-Features: AQROBzD3bPay_GfERLBaTKyLHFewS9zTfkn7kJbzuJjwn1OBJ7EB6NLWqF-EJvc
Message-ID: <CAHC9VhQbpS9XpO6dWu7gOiX=ppjtAxnNBOFe6s5wjEZNpMRjgw@mail.gmail.com>
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

On Fri, Apr 17, 2026 at 3:17=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
> On Wed, Apr 15, 2026 at 05:40:04PM -0400, Paul Moore wrote:
> > > The NIC doesn't know anything more than the kernel to call the LSM
> > > hook. It can't magically generate the label the admin wants to use an=
y
> > > better than the kernel can.
> >
> > The NIC presumably knows how to parse the firmware request and extract
> > whatever security relevant info is needed to pass to the kernel so the
> > driver can make an access control request.
>
> Not in practice, we'd have to agree on how to describe the "security rele=
vant
> info" and that won't happen..

I think you're going to find that you need to describe the security
relevant info regardless of how you implement things, but we can leave
that discussion for below.

> > Leon mentioned that different firmware revisions would have different
> > parameters for a given opcode, and that one would need to inspect
> > those parameters to properly filter the command.  Is that not true, or
> > am I misreading or misunderstanding Leon's comments?
>
> They are ABI stable, so there will be rules about future changes that
> old software can follow to ignore or reject future things it doesn't
> understand.

Good, "ABI stable" means there is some hope :)  Based on the various
discussions I'm guessing both the ABI and any assigned numbers
are/will-be vendor specific?

> > > > The access control point itself represents the requested
> > > > operation.  This is possible because the number of networking
> > > > operations on a given packet is well defined and fairly limited; at=
 a
> > > > high level the packet is either being sent from the node, received =
by
> > > > the node, or is passing through the node.
> > >
> > > I think we have the same split, fwctl send/recive analog is also very
> > > limited.
> >
> > Sure, but I thought the goal was to enforce access controls on the
> > firmware requests based on the opcodes/parameters contained within the
> > firmware request blob/mailbox?
>
> Yes, that's the goal. It is the same as iptables being able to
> identify that a send system call has a packet that is http or dns.

I think we still have a disconnect here.  A packet being a DNS or HTTP
packet is different from an opcode.  The opcode in the iptables isn't
"DNS" or "HTTP" it is "INPUT", "OUTPUT", or "FORWARD".

Most LSMs will want to know who is initiating the firmware request
(the subject), the requested operation/opcode (the action/verb), and
the target of the request (the object, which in this case is likely
the kernel or the device).

For most LSMs, I expect the subject to be the process making the fwctl call=
.

Similarly, the object will likely be either the kernel or the device itself=
.

As I understand things, the action/verb is going to be the opcode
within the firmware request.  If you believe I'm wrong about this
please help me understand why.

> > > LSM takes the secmark and determines if the access control point
> > > accept/rejects.
> >
> > At this point I think it would be helpful to write out the
> > subject-access-object triple for an example operation and explain how
> > an LSM could obtain each component of the access request.
>
> I think I am talking about this:
>
> app_1 FWCTL_RPC op_unpriv_t
> app_2 FWCTL_RPC op_priv_t
>
> - app_x broadly comes from the process executing the ioctl

Yep.  Were on the same page here.

> - FWCTL_RPC identifies the IOCTL userspace called to send the RPC
>   packet

Maybe.  That is an option.

> - op_X_t is the result of the classifier inspecting the RPC
>   packet. Admin tells the classifier to return op_X_t similar to
>   how --selctx does for iptables.

I've tried to explain how this doesn't match with secmark, but I'm
evidently doing a poor job.  If you want to continue with the secmark
comparisons it might be helpful to spend some time configuring secmark
on a SELinux system, and writing policy for it, to see how it works.

Beyond that, I think you will find that most LSMs - although not all -
define their security policy via an abstract subject-action-object.
The policy either allows or rejects a subject's ability to perform a
certain action on an object.  My concern with your example is that the
object isn't what is actually being acted upon, it's the requested
action.  The fwctl ioctl/API allows a user to act on a device, with
the actual action being specified by the fwctl payload.  From what I
can see, the classifier's output is the action, not the object.

> > > Same as for networking. Admin understands, admin defines, kernel is
> > > just a programmable classifier.
> >
> > Are you able to define all of the firmware request operations at this
> > point in time?  That is my largest concern at this point, and perhaps
> > the answer is a simple "yes", but I haven't seen it yet.
>
> We can identify all the IOCTL points where the RPC packet will be
> delivered to the kernel (send/recv/etc)
>
> We cannot pre-identify all the mlx_XXX_op_t's an admin might want to
> use.
>
> The same way secmark cannot pre-identify all the XXX_packet_t's.

Once again, I think there is a disconnect or misunderstanding, on a
SELinux system using secmark all of the packet types, e.g.
"XXX_packet_t's", *are* pre-defined in the SELinux policy.

--=20
paul-moore.com
