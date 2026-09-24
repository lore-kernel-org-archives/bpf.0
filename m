Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B774B3939D2
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 06:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790229655; cv=pass; b=Vmml/2GZcL7qjzRUaI8dXNqvZY9mSc1+hdvCJdeF+aRRe5qLq82zoCGjJ1ZPq45HqRYbigsoq2lK8I3LgF4MQKQOnQKzfo49cG+QRFiVsA6bk9saoK8/yyyDZUgjisuIdRcpntAs1qAvXVcbet52BC31le5HuxH5b8GSYSfyXss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790229655; c=relaxed/simple;
	bh=+JbfxkLFNuGTTXluroSTHxswjtu85RbvZJnu+D1DF+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KrpBs7IywQMtNtyTsHOaOBtmAuG6OcLELXm2Ea2sAAwrg6Ps0bGL3DFkjilFwy5P6SRntLBrO83LTUA1E2nxFE6EsM1VPzyt9Gz1G8348Dqi9S0PAJWFkg0v1Ltj5w1o84IXPJJfQxYNwUmUlqjErOO26KHIs1vZ5xHAF6GpShA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3xzd05z; arc=pass smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3xzd05z"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccd4f99cso1354754a91.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:00:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790229654; cv=none;
        d=google.com; s=arc-20260327;
        b=aYl2jfO8irRt+cGt/dmgVhimrZ9jzv4EWvt0dNwmLVdeVV5ctHzKWI4Lk1gr94xdtD
         V4OHKQrkYbFW7YQ32mENB1r/RH5SvyvvE4g1ayqC9qLPaLlswMTihqcq19r4e3VNgpJc
         6JiLB7/s8Kdqh/DX7IueYRID60iLGPVDfYrqJcQtKDpwtiPCaNegeS3Ut65vzz52c1bL
         sVL++Kiuqn5jGIJfKP2wAYg3zq49+I3wLF12IkxI+W+NjQCcx+sz0I4+g3Y8DlUgEcgY
         wOj5acjd5qR463TcqHtPnCjtpsz4VhD2PmjdFqJs62toxDhsos43VTnxr0YQyHwdF10R
         p45g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+JbfxkLFNuGTTXluroSTHxswjtu85RbvZJnu+D1DF+U=;
        fh=s3TL9yO7Iouruc7ucj86SE4XieJGQqrG0uNI452IXAg=;
        b=Z0neb0dCma3A5peL5CWgH+dq+m9xdEYCOYptyZuXarWR4547nCWudv4R7oBLhN+C47
         ozF3VkeNtX5kk4poOHfseT/jDJVJAMRfRzepxPtO0xt//PZsACkC06CVSJtjcWQ3eN7O
         +smk+Okqb9zVKPv1bbv6G5WFzzfFPcZ/pw9Vn3IAP35GImHkOFAuqL9O3Xy2/PjvH8K+
         xLl6Q+Nx0xgwM+veJShhsBXk7Mh3Gs3yx5rerIB8VTum1yf/Ssvy+MuIDwQgQ3IyZZw1
         LlyAzRaSN1NG5GGsPwAettsGeeAD/TPFjsqU6DSYQDQTfnpT5rcMqDfH+0FEYXspRT5k
         peGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790229654; x=1790834454; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+JbfxkLFNuGTTXluroSTHxswjtu85RbvZJnu+D1DF+U=;
        b=U3xzd05z7IjTGm5Hgxvdi3it7bOoguuC3f/DfKo0Fwe2UiYnQUFTVreOV1Ksrylwlb
         zBAp+xZkK2Ip1GOfAcE8bcPtAuC3LoPcg34O7Xfa+Ml9n53PlbdnJomCbaEaHxEshaVB
         CAdnj9nWqS3A5b+smFIpBwAWDHFMQoXJs50e5BUjMGPOWi83hsgFwJom2dDD+tfYHyts
         gPZrWhR2I+aaOEfrOBDP52EZcJnd/7++GpGawjHqjjf0T+FzQfGK0MOFzNA+QU2N1A2n
         WzJfhf3bRuqGgfRo8iLtQPjEapMwzy/oB8AVxnR4lTsQ734Fu3QzxQAR5nn8MjrZPld8
         qJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790229654; x=1790834454;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+JbfxkLFNuGTTXluroSTHxswjtu85RbvZJnu+D1DF+U=;
        b=Shsqz3E/UUu5o2ABDyYwUtsT7P93zFR9s9ftdsYB02KppTNHQ3s5Sg0JrNBlwEEmhr
         eY9xGHEm381nMqtD+qRpZT2gkV8Ax6RpM1JGqqJ7OGZTKGx5iDnlGaETg8EEk+eWJdT/
         5kvlgBZUKI4YYRjLbxmdmkjAcceyouppPVWw5siedncBj07ZK30AcLtkPoX5vvfnXpH7
         hLVd8FABMKCOfC5S9fcwEiCCwuGIZJwB3TJUfowLQSF/ZSMuODwNkATHePCOjq5d2Nkz
         RNIH5W6W/cs8Lydaj0USJvXARZ5lCjwN4rh1NoG5oogiTIKQVR4pQh6erg81m28ICrR+
         FAWw==
X-Forwarded-Encrypted: i=1; AKwUvBzDIKp4Rpp6PSXsPvZ2LKMFfNufrGHNFg22F8Lic4rilxAOcz9o22FzfrOlMf1p1iqCx6o=@vger.kernel.org
X-Gm-Message-State: AFuF++kVwAiUWoAHOibsKwWuJG/QB5L9iMEN2yNOCH+A745rT70sMZ07
	iq+Jxc9069Ii8A8vR2q67TM/y84zn3iXPAOUGKvEAUDMr2iwF+HX8Fd9/8jHMBNzdo1bQL1CUlb
	YFkzf+vXOeoLY5U6cl/jVXDNqLDjsde8UdQ==
X-Gm-Gg: AYBFou3GOTk7i8DbtAoPIeI+brEuxG75o+z08ibWGcdwxK4DvIcVqyp0fj41NUtZsuw
	F5W6LgWItDADA7EI4lw/phaE/SFFn34FHQhjPj3a3hzQrJDV4woRPY2ydPiXls84ZUeRLXKNuqh
	I1XbdECJHI3MHmvet60ZGBtVJYj8AwM9EruGx3iBpM5R0tKL04TLXPI1tyMc8mR65qzfzQ0TfgQ
	Rrvpz8C3LK3yxitFGrTMf8l2gyLW6hfbmFzfw/UoqqX9l+lRRnfOA7yTpe/0j4/SdzqnTri718m
	arjBX9lBLidkDefF1WDuFh6Q78wad53d1RPF0AVHo+URqFYffQVWmCao6PfENPV+y/aT2WTC7MY
	7oP5nOfW5gMsRLgffT48ni9hyCqM61Dhcayei9sjvq9+JCIGqUynaOxsB+nAeEgDaNAulZGtNJA
	==
X-Received: by 2002:a17:90b:2548:b0:39e:6c69:9b8e with SMTP id
 98e67ed59e1d1-3a099231ff8mr1264807a91.51.1790229653887; Wed, 23 Sep 2026
 23:00:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
 <179022901639.1337807.12766583921039284951.git-patchwork-notify@kernel.org> <a913f2c69fdd3fa9ccf6df18b3e95fc880c0ea72.camel@gmail.com>
In-Reply-To: <a913f2c69fdd3fa9ccf6df18b3e95fc880c0ea72.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 23 Sep 2026 23:00:41 -0700
X-Gm-Features: AclHuK_S7liveD6zlK5lliMhzTpl26cUZ7WOTUCEwwj3iBA1eyDcMgRKG5VZdXU
Message-ID: <CAADnVQK0uvyu_2+_4BVN-NAvhy7-k+2gZG5CRoKZ3Ge5O5fjLQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 00/17] bpf: Indirect calls of bpf subprogs (callx)
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: patchwork-bot+netdevbpf@kernel.org, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 10:55=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Thu, 2026-09-24 at 05:50 +0000, patchwork-bot+netdevbpf@kernel.org wro=
te:
> > Hello:
> >
> > This series was applied to bpf/bpf-next.git (master)
> > by Alexei Starovoitov <ast@kernel.org>:
>
> Well, that was not fair at all.
> We agreed that I'll review this code today.
> Anyway, if my input is not needed, so be it.

Feedback is needed. nits are not.
