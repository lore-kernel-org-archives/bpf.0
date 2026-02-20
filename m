Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE87E7262F
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 01:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771549793; cv=none; b=Js4tXS6wxmixb8BRLMX/glfKrUTUfAA5Xx5B6xvF/OResXxT7BSGKXuAaJgpmrGAzHZABnNT7xbq+65hICZOP0VUZlYK65ysYLbckIfLKZgCLGDtls4RNDu7NgtuBtinwwA8SPJqCqBBa5pH9eIhhuq+wLUHftn8Cp9DcUcN8AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771549793; c=relaxed/simple;
	bh=/bBk1D9FyTZRycI3nbdGSzmQwwRETyWhWyjZcn6ZWBc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q9ner1A3kJtufOgz7rViqTmunsLCN8q3qzzx9vCor6JBLv2/VVabGMPi4MOQd/vgIKuIg5oUH0CQyrsUz5pJCEcQgtnmFm5BpL76p/4cYRh5oy7h583X27f9SVGliBCN99C7+a+vn1wT3XTTbIDR/SJeBsdBXQETP2yIuRTIhJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqRzt8IK; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqRzt8IK"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a8a7269547so15232945ad.0
        for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 17:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771549791; x=1772154591; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/bBk1D9FyTZRycI3nbdGSzmQwwRETyWhWyjZcn6ZWBc=;
        b=hqRzt8IKueEqIFM/qeRu2daqGtnl/dB+MkWTHJPL+xuSAKuJQPmMHyBDSpt5SAs7V7
         g7rEAn6c2wu95Kb7wZGlGag5j0dLFNwerA8UB/6guggplOyJvNRcS6Kw7AcrHUo6y8Cf
         TGvLMBz3rcAzB842NuRupk3X7YSETNXNkAvNAH9V5VNyZ7PNFHR/HdxPH0UtILZRxUg/
         tdsL16RfqYIp4k867iRyG72oX+asRIamlGbjVRq7lOLGBbHRGnbqRa8CWojGYUE2qMP8
         ZMy3lD32VYMhNkDMuF0pJahLqCzJ6NeKwi7j4g5YkX4V2aAV3RHOl/iizFpLIY6tmY7V
         l3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771549791; x=1772154591;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/bBk1D9FyTZRycI3nbdGSzmQwwRETyWhWyjZcn6ZWBc=;
        b=tQ3gUxyA6VsgjKujGUIX2vTQt3tuOX0fQpzQQRQLOEl8WX4UgbiRvmCRl9l9zgOoJB
         Z9xBlNTrfBoBxKiB/bHZhNhQuD0ViGJBViBZanaNKpb+C3ATSE4OOOiYjgXu+wtFQ2HO
         3CjwFgvZVqqO2A0TD/qLRf5H4GzbaNuwVSUeUHn/+H6PWnZalKVHlgAzqCWjTC6SZgc3
         sUHn3KA0JMGoRKmazvBFUigZ4X3fspa7axoRVcsI78aANurSenyaoUSE6GYvE2RWxYgO
         9NKCtqIBhx3yVDqmjRWUgaoT9aQKudrjXwf9VhL7xhYgTejuwdI9U5TJAUxZqGGltVeD
         yIMw==
X-Gm-Message-State: AOJu0YyhmWidEuR7YHNbUzLmdkU2L0tvh8tA+pegA42eBJ8mk3mCXa7Z
	3yRa/iFDUsWrXwsOlIRNugZ4rRXf3G0suUggkxRobE9yY+mgu6ltIDZR
X-Gm-Gg: AZuq6aK5sU+eH+CIe53QZl8Eta1amDJMvSqcNz2l7vHIXPZ6qObipoNYFNN6V731in3
	Ungdlk1zNauJq6WSql486GLrtf2FY+q+VduU9OZp8rbJo9aZDB4IUJcpq7QbPv8j240qS9k61nZ
	iD+DRn50RDJ2p7XYJN7eOTbcPLjN6NxfcnnGr+gQMqCChB8wJAkDsH+FHSqHjSswnFnOvTNx8PY
	1n6S/QAH0g7zQAPaBLQ55IZlHUTzYNb18uMqp6mdhn7cvmMCpdqhyNKTnst1HNFMfatRwoOjEIP
	bvKhj06iq+7ciFOrjebuPjYX2kcW5ofYT+s3hvLvn7Bl9PgBx/DXHZh6vgruBxOJ9bvtLEXNQuL
	BR3hgNB1HT8s0Spwy6PEmW7rbeyr4HVuqV3OT7jNH2QzTzL81neffG7I78rK9KNetZULPWWXW5y
	smXoudYGoaCFpYiYOjytLO5cui8yhj7mH5y0/chBzu7+tNw2uLa/s=
X-Received: by 2002:a17:902:ccce:b0:29f:2f40:76c4 with SMTP id d9443c01a7336-2ad6cde75f1mr396175ad.34.1771549791199;
        Thu, 19 Feb 2026 17:09:51 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1aadc755sm178097315ad.63.2026.02.19.17.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 17:09:50 -0800 (PST)
Message-ID: <0d16f1af1b7b499b587ce7a5beef6bdbf1ddbccf.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Add KF_ACQUIRE and KF_RELEASE support
 for iterators
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
 kernel-team@meta.com
Date: Thu, 19 Feb 2026 17:09:47 -0800
In-Reply-To: <CANk7y0hiddq=eiViLF6c4kGUBNS-vdHoWXK7PEAvTyb9W5rshA@mail.gmail.com>
References: <20260218182555.1501495-1-puranjay@kernel.org>
	 <20260218182555.1501495-2-puranjay@kernel.org>
	 <b36ca4ba2eada11a9b5cd5dc1f44e9217a86add3.camel@gmail.com>
	 <CANk7y0hiddq=eiViLF6c4kGUBNS-vdHoWXK7PEAvTyb9W5rshA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-02-20 at 01:05 +0000, Puranjay Mohan wrote:
> On Thu, Feb 19, 2026 at 8:37=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Wed, 2026-02-18 at 10:25 -0800, Puranjay Mohan wrote:
> >=20
> > [...]
> >=20
> > > @@ -13797,7 +13826,7 @@ static int check_kfunc_args(struct bpf_verifi=
er_env *env, struct
> > > bpf_kfunc_call_
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 }
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 if (is_kfunc_release(meta) && !meta->releas=
e_regno) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (is_kfunc_release(meta) && !meta->releas=
e_regno && !meta->has_iter_arg) {
> >=20
> > This makes the check too strict, right?
> > E.g. for most of the release kfuncs there would be no iter arg,
> > hence the check won't ever be true for those kfuncs.
> > Do we have tests for this check?
> > Either we don't have the tests or the check itself is redundant.
>=20
> A release kfunc should either have meta->release_regno set or it
> should take an __iter arg, that is what this is checking. If we leave
> it like it was then every release function that take __iter would fail
> her.

Oh, right, I missed the point here.

> But anyway I will be doing it the better way how Mykyta
> Suggested, so this will be gone.
