Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309DC37B402
	for <bpf@vger.kernel.org>; Mon,  4 May 2026 22:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777934039; cv=pass; b=Mk5Ns5P4LboivXLyykui0VZwAajOCMpYh9bJoQpfGjZo4hFgM7AaXXObE/+OO2cRKj7SuN3kaAJc9p4u1WjVnVAC2XSphb9SHPgPs/boe8BHQv80B/AmcQdIfSPICjV/bQwvYdqVPE1iFM8KepcpebnfZnsn72+3JcT/4A0LTbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777934039; c=relaxed/simple;
	bh=SRyzc0UaWv+n7V9qD3GfiNb+SIIGW8GsbwmzjOQHX18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YMtD9z8g7ldAxJe4C0x6h0i5BrLcCSTDJH4pYU/VFcAf2KLcvDhkXFDTAjlqXOWTXQu80TgOVtH2sPf8xNONOECEONt45bD/2vRcXSbFMUo+eL0VReVpokZVRs5MZ5CMfv51G1lC3kl5nL/KE2SduORQCikXmaE9BGeyHBH6h/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=b474DNHm; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="b474DNHm"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35f9ab079bdso3677133a91.2
        for <bpf@vger.kernel.org>; Mon, 04 May 2026 15:33:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777934037; cv=none;
        d=google.com; s=arc-20240605;
        b=J4MssiChYMBySMPiniEAyH0lzGAlZiHiwbZBEnATGaEUXmpLvHR//dyujbPHsw6FbS
         eI3AgMeZutqQDDyF+OEe4y9uw0tNHBE05daD9nanYVKaRwY4nWKuLdP8Kk3RK+ov56OJ
         duKIIDqXyBL4N2UGtL02NRQAdA1hu6XI/oTk0VKS5KCMsofbG3N12SamFqkG4Svl1G5O
         4uRQtxGbgn5kNESnLq6Dt+E/qqYE+AE/wLBn+5wUI81jGFPESLeINHndNlcZbivStfot
         D3MOBPDdbPZYAbOwXr5BLZGMbjAADM8Rg6eQ9DE5YdopnB+/FwwKIw0kKhfsbSNoUEFh
         2AMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7hnYb5QDpibHPGWq61YUR3Nlj5MGB0V4/cWv+6o2s9s=;
        fh=fhd+0N2lHKM1/vYbYWKgVwwRug3R5QwEufLJvyKnrA8=;
        b=kICktpnL58W+P5/+H3BWJYkjPLxk9XUVosbOt1HGrvA81YXEEQ4deAKC4helcC4QCW
         4QTe8cBce7yYaSIGH11NWuZDRB9zwcVo5770P/H/OXuXf8wcbrfzKtfRFPZ+CO8PFE7i
         f2rDEI1PN7zShAiiQfMMxJnDH0mXH6KjjNDFlFzWahYRO/kPCwMSDxeonXVVxUzr/P97
         LerGUeaFxHnxR6U8LmpWkWbHpEgjOVMTd4zX2OkHL3FxlwfByovVcZCLoLIDUNksij55
         65k3NDXS6uYIltGj7FlqDF6Ld5vvt0JCY1N81Od5U8K9Zdxoo1rDTESHSf6h+F8aASn4
         +zvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777934037; x=1778538837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hnYb5QDpibHPGWq61YUR3Nlj5MGB0V4/cWv+6o2s9s=;
        b=b474DNHmLbyPnOY4UtiXM5GN+X9I+S0u72RdwKdxeGJHFbyi8dy3N/skGTD8aswwJT
         mQh/fHxQh2XMu0/wXWmILNqAoHVz64tnsQj3uwYrG/nMHnMiR3+62Bg5+hYVAMqGGZa3
         Yhzv530XbxJbU0D0vwHq2/YSke9JUBH34F8cjupFBBSgKFVJDHqdHlHLgKPIsy++DjBg
         CSXKH02/rcKaE2K2wh+4yhWhycJgwprwu1F5I1VKpVbKdHi6Ab35lJlWSVF3M/jPkfFU
         QubU5hVrrXJSyul/eUU6NZH9S3lF2JCWM8rscrobVAwd5+udUgedARCiFdjuMMWnSxUC
         /4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777934037; x=1778538837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7hnYb5QDpibHPGWq61YUR3Nlj5MGB0V4/cWv+6o2s9s=;
        b=bQATo5ZMS7wjv9cs6gJILc+LAIOneODO7UUmapCKDNg71oZh1g39R+HNmw94WDl9pl
         0tliw5g0cO/UD56RQEBqrErGN/+knjyDYNmBmziDZoWL9TjoEQmOBXc6vcdIkt+x+UIi
         Qpa7kW1Rsg/r7ur+LmquSjjnA5mH0JfgEzGhJ8JWW7Jh2jkpnkpy0Y8QvL/tsPvfEEjq
         +gd1EfQxauz8p90np/d1/Hqb5J01CPD11vjAo/DD6wr8akfeCG1JD5nIZ9xp8shRz79e
         jMaPCoP1f2pvGiguCyDAzQ6wjHBIK/EUe7TvYno64f8Cm/EP2Qr1LVcRFzaqbfHdpXZF
         9HzQ==
X-Forwarded-Encrypted: i=1; AFNElJ8npC+vE+eMmHku1/Q4fQUPIr+RUB7VSVYCykH9+wnKd+KTs7lGNKySlKeA9e9AVyWvkR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwMNE+PPdQ4sWjQ3P+z2haRENWVGOM2LU0xJfYf8Pc7StBksAt
	TGSmjwSfC1UhCJ38uUtF9Zhi9VNpDkq7TjKLg5a/oEC049Kf57YDP+xclv2ebxg7g8aU8oUKZQS
	qPxIgsrqe1vW/zZeyHjYRQKniKmaNMJqZHgB0nisg
X-Gm-Gg: AeBDievLZVNtJn39YBRLw7+KFCg5kpgauxO5HF17LAbcNzTcbPyuWXUQ3Iv9QSx8GO8
	dOtkr6rIZa+lJN29KEr9g6Aro7GP9mbQw4booHtOQLXesYqsaEOW4Vch8PLDf9N0Ezs45SneYDL
	102jeIbJ/wJcTbwrQnfgj6Bm+/QQ5j5N4UnesFH6uQ6hlpUKPD/gz3ClseYyPQPnYT2meUleSVY
	Yly/XpMoZyuyHPwMe56ZJnxptPoruIbqDO41JeVZX56K+Aex4+oIOAre0921cwXWQbs/Sgo7cX7
	m0nFDiqejxsEfT5/gA==
X-Received: by 2002:a17:90b:1343:b0:35f:bb33:d721 with SMTP id
 98e67ed59e1d1-3650cd08160mr11400198a91.5.1777934037438; Mon, 04 May 2026
 15:33:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413164220.GP3694781@ziepe.ca> <CAHC9VhR1Uke9P==CELKavBcogHoNCtMZFfNWUbgm5HYUfomhtw@mail.gmail.com>
 <20260413231920.GS3694781@ziepe.ca> <CAHC9VhTLamfe4C81ZNRVT=H32x+KLxSqH3o0eBfrHsWAgAqxCA@mail.gmail.com>
 <20260415134705.GG2577880@ziepe.ca> <CAHC9VhSECYihup=tURo_Qk__xUdYYPkHgnz5CWA0BrRAkvwbog@mail.gmail.com>
 <20260417191749.GK2577880@ziepe.ca> <CAHC9VhQbpS9XpO6dWu7gOiX=ppjtAxnNBOFe6s5wjEZNpMRjgw@mail.gmail.com>
 <20260424143603.GB3611611@ziepe.ca> <CAHC9VhR++21SD+v4Bb16SQmYHgJYZ0ytQ+BecGPNK+fEOe4G7g@mail.gmail.com>
 <20260424221310.GA804026@ziepe.ca>
In-Reply-To: <20260424221310.GA804026@ziepe.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 4 May 2026 18:33:45 -0400
X-Gm-Features: AVHnY4L0o11c1AyvQPCh6gK_ec0IV1Rogd7iCBcWBXwoMyFuE6qppAiDKI-2lpU
Message-ID: <CAHC9VhTsx6cpKMP8nVgK4F=drXTFJtK3_D9k9pmKr56+ZFUu9w@mail.gmail.com>
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

On Fri, Apr 24, 2026 at 6:13=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> ... I wonder if we are even speaking the same language.

Let's reset the conversation.

As I understand it, based on our discussion in this thread and Leon's
previous patchsets, the basic idea is to enable LSMs to enforce access
control over fwctl requests/commands sent from userspace.  I'm going
to start with that as a basis.

Using the kernel's docs on fwctl, the userspace API appears to consist
mostly of ioctls with some basic sysfs interfaces.  It looks like we
can mostly ignore the sysfs interface and focus on the ioctl side of
the API, do you agree?

https://docs.kernel.org/userspace-api/fwctl/fwctl.html

While normally I would suggest simply using the existing
security_file_ioctl() hook, Leon previously mentioned that the hook is
too early for fwctl as the userspace copy happens much later.  Looking
at the code, it appears that the copy happens in fwctl_fops_ioctl()
for all fwctl ioctls regardless of the device or ioctl, is that
correct?

Assuming the above is correct, how about the following LSM hook,
called after the copy_struct_from_user() in fwctl_fops_ioctl()?

 union fwctl_data {
   struct fwctl_info info;
   struct fwctl_rpc rpc;
 }

 int security_fwctl_ioctl(struct file *filep, unsigned int cmd, union
fwctl_data *arg)

Where @filep is the file/device being sent the ioctl, @cmd is the
ioctl command number (e.g. FWCTL_RPC), and @arg is the copied ioctl
data (e.g. ucmd.cmd in fwctl_fops_ioctl).  In addition to applying
access controls based on the ioctl command number, a capability that
already exists via the security_file_ioctl() hook, LSMs could also
apply access controls based on the RPC scope as well as any other well
defined data in the ioctl payload.

I expect most of the existing LSMs would implement callbacks for this
new hook with the subject being the process submitting the ioctl, the
object being the file/device that is being operated on with the
ioctl() call, and the access/privilege/verb/etc. being something along
the lines of INFO, RPC_CONFIG, RPC_DEBUG_READ, RPC_DEBUG_WRITE, or
RPC_DEBUG_WRITE_FULL.  Of course these are just quick examples to
demonstrate a point, please don't take those names as hard
requirements.  Each LSM is free to characterize the access request
however they like, in a way that best aligns with their security
model.

--=20
paul-moore.com
