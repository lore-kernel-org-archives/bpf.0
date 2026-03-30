Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541693DA7E7
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774889184; cv=pass; b=BhNnXikfWN7kY5IkQf1nSERjxT5KzzM8Pcx4NWTFc7BLbbK4fJ0DrJkJgb5/wJKdjGLZlp5Yc16uPlr5Jq9Q7gx08/IS5Egl/wPwLX6YM/kqtOH9dAbzX085af8xOt4xPILx2QGWOu1lBcHCbB7Ysd0Hd7XhvgWL/0JysOk8h+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774889184; c=relaxed/simple;
	bh=4feyuDqrUmgHeKROraJQ/+XkjdShpl24vAeEH6ljdSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQ1v6Af+ihBYacws/mF3djP+A7mvjCMybj0gdhFGtLTmLbJv4DJ6L6Xpcy3F6MkVt4R7a/JLptCiNs3eYKTEVOamiDmpY+QfpW87fCgtZB2oQjNZSyWmqaxVOXeCOnINiMLoFIgJO/XvcOUveGLIoXgwE76SeTh3Uwjl5c0etgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qoSvMK+X; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qoSvMK+X"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b980b35534eso889578866b.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 09:46:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774889182; cv=none;
        d=google.com; s=arc-20240605;
        b=AmC8phpOUC1gskIezzYrLo5VTuYY10kvdtljxQwslxOKAlcoKja+7GokZII42Yiz3a
         ESKj2gflUieozwbs/EphEMrSuRoAVhIHeEPFhnMcdKuFiIb92UqaNeEJ68tz9vI4wRtQ
         nhdl3Pc7IKCARxwH7UcqGHtnozsQHKjU/HvAtEzvhgOUw+psWfZRfRR2qD/2rOCnPJk+
         Yc9Utb3YCe4iTdt+w+JiRPP401MBWiuVBilcQE2XE3QeTG4zbzbkHY7B8P5xqKhZebZ4
         M82+jOzSW9pw1XnvGwRQPorfLqvhlq5rjJiuscy0cpYoAMSxgjogR4mnA33uDB8JKczw
         edlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4feyuDqrUmgHeKROraJQ/+XkjdShpl24vAeEH6ljdSo=;
        fh=l+sOHNGp0kHC4DTGgwcmkKWxb0J3N8enUjd4xjROCgw=;
        b=Ou3YltSmQCwV4/yhSMEt/iNFUyEuCJNX5Kd/xJkBzgSC3q+Di5VgLdcIxAzqs8BlZV
         iBKn0+OrDy8IOBkgiBBOlCod1pYtTjbpm77YOft9hCs3swf5rHKX3QDkgDaGF3Gv/O9n
         kLRTyiUVWITJYA3AsOzyKX3ODNiEZpqdNHXdGPmiaR3UpD3pNgo01OC6yxoEheO4vm6J
         1JI2jice6Y4WD4RVS095U/AwcHUXVHQfCaIZXQv9dY4nqEFSEycceMSISSi6SFfAxHAl
         RRwh1BnB+7cd+cwJMccWZL9QfVGFITxG0LIsvBy32qCHTbNzAxeE4JukTePwvT91mYxg
         z7oQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774889182; x=1775493982; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4feyuDqrUmgHeKROraJQ/+XkjdShpl24vAeEH6ljdSo=;
        b=qoSvMK+XNKgfVyFNZd6tPDdaEAR3wx1K7boBb9miPG6p7aATYEp4D9idJtIzGMVrZS
         jm+XmqNnDcydMEoJJVyEXqlWgvNQDMbJAlTOGA5LAuzhf1ProoNDo+R8tE+lUVbyNEZo
         Jzx3KqxSrBmiCQhD6kbz0LZ10BRmFcZ0v+Dat+mcZUvxCkGwxIUAN0tToSW0+VLQvpua
         dOm9ht0CC406u0iTWBnaC7U5cBzC5S9XmQiIIhxZcVl2XE9dTYtjPmOeZN7RlxCUQj/H
         ebRTRfKIV20ZFHbpwh/25AiTt4SxDxLM9vn/mdjEAuKXchR5w1n+QbQBi+/hPdCWKoSi
         yhjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774889182; x=1775493982;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4feyuDqrUmgHeKROraJQ/+XkjdShpl24vAeEH6ljdSo=;
        b=EvVlbtz0+v+nUhW2RwWMPzQ7A7pGAOR4yDQ4nMgmPTGsNCxki/cThSvRTpBZF6keEH
         XTQ0KVQxAl1gVvFO/yPXBVxcgehfQyZXCC9mllSXYLoIQp5AqUM1+r/jSChoqc+3PfdM
         Wqn9LHO2lDPaATXjuJ6DUA2SIGJQ8twdan4qZDSOlwn9ri6m5NkDqGt8WtHueZEqIgjO
         xnUkVw6QrV6I7m5Mnw/nzzkzSyeul1RQ7vIlkEpmCUEcVzrVRvW74mhMns7TNnaIqb/U
         xYK1O+tfU3jJu0GO/AmkNZi6l8cV0p7o6G64IUmj9Ii9VuZ3rgblGr1532nyPRP6dbS6
         9dYA==
X-Forwarded-Encrypted: i=1; AJvYcCVJnstfVdUgOkgKStNxF2O//rpXPz0GB65BEhHGSysJFnSXKvWWCMeWRsB6CsFfMU4QElo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAYdfuiDPADwsBKXWDxOJeXBFuWt5/wbGvxtsR+g7gipUriSl9
	6tSZDdJk3brh9+z8LS56r73f0IMOGSATUHrnbucdVpe0Ebm7lNiBYh87av2R1Us7/6wDuScoYaE
	GycSdvfXAn6zjdc5bNFA+oWifdG1q2TA=
X-Gm-Gg: ATEYQzz9kGC/vdKUNXFnVM/k9QWtTZ/4jwaXfwk9bxGy7XYRpokpxzE+4klP352SRpx
	NN5HKyXiCUfsVO/ABhg3+xFUndWBzqDn35cRNaDVFTvt5lj2AIJSfHnHSD/YzXcPeOMTQScSICN
	Qv7C8V0EneqmDubNmoONwIgacyZ7jRlWzT1ya+MxhSk7kE7A7evsshWr+g9mC9kblOCZBjnRkJh
	jqljz5IcQH6IVugBHRvD5TPi5UfDVY2miHQDVuRombMwymI+a+OKis+Ep5oJoB4RHhZu8V9nD7y
	0gvzJfVtXqOEAXNURYIMYTJ9MfCVLOXJUCj/UCk=
X-Received: by 2002:a17:907:1b09:b0:b8f:d2a0:c283 with SMTP id
 a640c23a62f3a-b9be835abb3mr17283666b.1.1774889181445; Mon, 30 Mar 2026
 09:46:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327141616.1961457-1-hayatake396@gmail.com>
 <20260327141616.1961457-2-hayatake396@gmail.com> <CAADnVQLh76CWYJCJXgOst43FcJOrPP2Y0wcwGPX71QqmiD+7pA@mail.gmail.com>
 <CADFiAcLvdjE7zwqf-hpH01jnbxtnWQNoj4+zBwK0+RU80-k9bg@mail.gmail.com>
 <CAADnVQLR6Y94wKo1G_4w0-xTPdR8ws38oGu3xfHOXxNKcqjyWA@mail.gmail.com>
 <CADFiAcJtjVHYVQeYJ_znVsjiJkEBmLfOafp5srY0HQMGwVtiQQ@mail.gmail.com>
 <CAADnVQ+0EwaJXgS1WSDf12+Ds2Uxbh9KMpDcyq+gyZjcQ_6+dw@mail.gmail.com>
 <CADFiAcJFy-n5Zz+Wj1dWEH0WcK+PhKXi7cbvdsLnPhMXRcVktg@mail.gmail.com>
 <CAADnVQJmqKVZC1gkvAaAmO9V=cnYPO0UYB6Wyp6Shko4tZeUQg@mail.gmail.com>
 <CADFiAcJCrS0wjkPcGU9sCYQukEoegeZG7JMkqhGDYq5C43nfXA@mail.gmail.com> <4b0e7341-f2e2-4ad2-8c9e-b482a1b1cbfb@linux.dev>
In-Reply-To: <4b0e7341-f2e2-4ad2-8c9e-b482a1b1cbfb@linux.dev>
From: Takeru Hayasaka <hayatake396@gmail.com>
Date: Tue, 31 Mar 2026 01:46:10 +0900
X-Gm-Features: AQROBzCbYsF_0cVVV3z8GVQf9gn5AjGulzxIUzgv5Xjg0GCGvjjDqN_6nyl63fg
Message-ID: <CADFiAc+4hKQGSEo9XRvrNuTTK4LXwCfAqPMR3AMxiNBtZTc4mw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf, x86: patch tail-call fentry slot on
 non-IBT JITs
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	X86 ML <x86@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> Sounds like you are developing/maintaining an XDP project.
>
> If so, and the kernel carries the patches in
> https://lore.kernel.org/all/20230912150442.2009-1-hffilwlqm@gmail.com/,
> recommend modifying the XDP project using dispatcher like libxdp [1].
> Then, you are able to trace the subprogs which aim to run tail calls;
> meanwhile, you are able to filter packets using pcap-filter, and to
> output packets using bpf_xdp_output() helper.
>
> [1]
> https://github.com/xdp-project/xdp-tools/blob/main/lib/libxdp/xdp-dispatcher.c.in

Thank you very much for your wonderful comment, Leon.
This was the first time I learned that such a mechanism exists.

It is a very interesting ecosystem.
If I understand correctly, the idea is to invoke a component that
dumps pcap data as one of the tail-called components, right?
Thank you very much for sharing this idea with me.
If I have a chance to write a new XDP program in the future, I would
definitely like to try it.

On the other hand, I feel that it is somewhat difficult to apply this
idea directly to existing codebases, or to cases where the code is
written in Go using something like cilium/ebpf.
Also, when it comes to code running in production environments, making
changes itself can be difficult.

For that reason, I prototyped a tool like this.
It is something like a middle ground between xdpdump and xdpcap.
I built it so that only packets matched by cbpf are sent up through
perf, and while testing it, I noticed that it does not work well for
targets invoked via tail call.
This is what motivated me to send the patch.

https://github.com/takehaya/xdp-ninja

Once again, thank you for sharing the idea.
Takeru
