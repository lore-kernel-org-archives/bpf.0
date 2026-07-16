Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02259463
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 00:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784160774; cv=none; b=C/oJAOB9ZN+si3CURMrht+dmgJ/XYLYsIDiMM3yUZxaqyn2QFoPVkfUZ2hbv5e6sSmUVzWYgtcOfSeBu2m5pzirl1p7/JCnQowjvfM1FPeo3GoR+WlV2QeTpmdJgtwFfkudJUCjJTq+J9bSP51ON7Cyk62CWKEGxBgHopaWJQ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784160774; c=relaxed/simple;
	bh=FZPGY9KYrMtOTNqPRwUkPHORLOYpJ6tk1GVDc+iL/yc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kWiIhQ9+g5k+9YZ/eBB/Vp9bU3iKP+FuOJREQ7sPkSou4THO7a7vxPq4WF6icCb62O7BWkQiGNgkPSVE91p/nA8eIPVjrWrRbrjQXgtXKfgglW1gOKxj8V+E/l1YL8uWHm74Lru6rXZxKMwK1FA5jE5YuSMYCxg5I6hqApRGGEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvSaKW5E; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvSaKW5E"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c96c92c0980so1729455a12.3
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 17:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784160772; x=1784765572; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Yqp9M8SmLPe+XpZ6WaehY4883xFTw01pffMOJV97erU=;
        b=MvSaKW5EK7Vtl87mdOX32EMKmP+7XPQSKQLftRYH2Kfn+V2EakzqrZwF43Gt07LcO8
         a2Wh932u01JACFY4q7W1cRNN+RlDm7cniR+Gs1GT/mRMmH13ejjwMUmg1GOPIWJUGhZa
         0VG+VLJBNmUaTknpzBS0Ximj5sPWalFMapzuCuGYpBPGlle3MDgLp1ZqC2/jtM0PY1yR
         AxY0DIHpg528ij8y3Q4i4wHy2KNHLlBOsMblilakK9iaUlb/AvBQOOcNhA7w38rG3/pm
         1jtJ9pu9n/p3TZEHFXjnPrBnjyY57MYUhox+72yZ4I8TvKVc4F9CvVPhX8gJUZjkIau7
         KqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784160772; x=1784765572;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yqp9M8SmLPe+XpZ6WaehY4883xFTw01pffMOJV97erU=;
        b=rtYLgShzerRL1vouRmQPMXukkZH7Wa5WpaSiEksc3TPWNc4d4ETdwucw0tIHPx2FL/
         vLpMpFpli7KcIjg08bD4EI7Q8KEX0N2nQbYCkq7CqueXPE0M2cY1+TCcLKV2px+2PBSa
         CACOhp+NEvVUJt69O1P9p5niKrGwEi/gnJZz71aG1pgz/qdLR/jytX+kX/pZR4PNGwFz
         KKFvKVA7NSXKpYiI+x9Kc2O+MLo6wZ/L+WygJ77DQ2+JEL8BTiGZgFwps0Ik9q0bxA0/
         IyvsdCr2KisFZdxCQgzgc5hUTRGqLjfLuP4eTH4Lhz2sLpmD+cXp2m6TXkM6s9GHtlaM
         tpbQ==
X-Forwarded-Encrypted: i=1; AHgh+RqtyajQ+5CHpxatvnUQpmCUevK+877PNcICo0jXEF1aVJfq+Zuwm/Spz+6Q6WXtWNA1XdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSU7I6MLBpdaJ1zwEloRgkMlpc0ajoIojOe8fCjCLvQBymcqgq
	xhqFXUDirMaRgcZxqSpmlXPOztW7cTDI1XRDv2gzymjgotUpmTSfwc3I
X-Gm-Gg: AfdE7cm4NkvFyWEcyEdzuyU5/gvHDRSkn8f3yWOps8WCsI7kzUWJTUoXHzvmit1J+Ey
	kpNQ/Pxa9dugqU5fZOJSIzFhy2Q3Ior4YbUntSyDEDhjUyapnx/R3kiDhEZVJjWzC7tixbmU8Fu
	r+6f78TsHLH1ZqaQd+uqkbAzco4RXDqT8ZMJfEP4Sa0XxKiF/X0LEh6OCqVYhuMhjVqnSQcpBEx
	+ECzwBHHBRRtJDyVbSw659VpgXKdESQv4XMoWyRZNrsT++cHg9QqeVS7zgPQmhhsrxN6Z3ypTqx
	+bsyhfQStPsffmHGrgS5GaDMaDK0bieQYd7QGgbwcNXbiO5QPlebovZSVoPsEdvxsBmKjRI6vm9
	TYABsL3ghIaSuiL/POaQ2GS7QVen6gFgP6fdsznJCcxmAeN1vKGgCunGTISP6pPnzb4SVBDD/ur
	7KsUMu6NgeI4QGkQ==
X-Received: by 2002:a05:6a21:1309:b0:3b4:b24e:27b4 with SMTP id adf61e73a8af0-3c11077668bmr21904263637.1.1784160771979;
        Wed, 15 Jul 2026 17:12:51 -0700 (PDT)
Received: from localhost ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd4359166sm4828005c88.14.2026.07.15.17.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 17:12:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Jul 2026 17:12:49 -0700
Message-Id: <DJZK7IJ53B5J.141W232JLWL44@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Alexei Starovoitov"
 <ast@kernel.org>, "Kees Cook" <kees@kernel.org>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>, "Jonathan Corbet"
 <corbet@lwn.net>, <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
 <bpf@vger.kernel.org>, <jannh@google.com>, <mail@johnericson.me>
Subject: Re: [PATCH v2 0/9] binfmt_misc: bpf-backed binary type handlers
From: "Farid Zakaria" <farid.m.zakaria@gmail.com>
To: "Farid Zakaria" <farid.m.zakaria@gmail.com>, "Christian Brauner"
 <brauner@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260714-work-bpf-binfmt_misc-v2-0-57b7529c002c@kernel.org>
 <178407531866.2243172.12944140194021045628.b4-review@b4>
 <20260715-reorganisation-umtausch-radiergummi-8b38ca81ebb0@brauner>
 <DJZK5TY3IXQC.2XKA1X9IEGJDO@gmail.com>
In-Reply-To: <DJZK5TY3IXQC.2XKA1X9IEGJDO@gmail.com>

On Wed Jul 15, 2026 at 5:10 PM PDT, Farid Zakaria wrote:
> On Wed Jul 15, 2026 at 1:40 AM PDT, Christian Brauner wrote:
>> On 2026-07-14 17:28 -0700, Farid Zakaria wrote:
>>> On Tue, 14 Jul 2026 21:58:05 +0200, Christian Brauner <brauner@kernel.o=
rg> wrote:
>>> > [...]
>>> > 		.load =3D (void *)nix_load,
>>> > 		.name =3D "nix",
>>> > 	};
>>> >=20
>>> > Farid, this should slot underneath your qemu demo from [4] with the
>>> > program ported to struct_ops. Feel free to take it from here.
>>>=20
>>> Thanks for the recent update.
>>> Is it still "take it from here" or was this left-over from the previous
>>> series.
>>
>> Leftover from the previous series. :) Sorry.
>>
>
> No problem -- just checking.
>
>>> I think you've done the majority of the work here with the validation o=
f
>>> the few selftests and mentioning the gap for shebangs.
>>
>> It was a nice joint effort imo. I think this is in general an
>> interesting idea. I'm also working on some glibc loader patches. One
>> of the patches in this series allows for "transparent binary execution"
>> if the loader supports it.
>>
>> In this mode you can pass AT_EXECFD to an interpreter and don't change
>> the command line. An exec like this is indistinguishable from a "native"
>> exec.
>>
>
> This sounds super interesting (orthogonal to binfmt_misc and BPF work rig=
ht?)
> but a neat feature nonetheless. I wonder if this makes it easier for
> tools like perf to attribute the correct binary or they have already
> handled interpreters in the cmdline well enough.
>
>>> Please let me know what you would like me to do next. I just tested
>>> reviewing the series with b4 + AI -- pretty cool. Was a little clunky t=
o
>>> get it to work but overall a good experience. (I need to tinker with it
>>> a little for NixOS vim setup etc..)
>>>=20
>>> I shared this patch series at my workplace as well.=20
>>> I think there is some interest in the work.
>>> (If you are curious as to why, I can elaborate on that as well).
>>
>> Sure, happy to hear other use-cases. I have a plan to make it possible
>> to pre-open a set of interpreters (pin them essentially) when
>> registering the handler in binfmt_misc and then bpf would be able to
>> select from a set of pre-opened interpreters but that's for the future.
>>
>
> This is assuming that in prior calls to the BPF it returned the path
> string to be pinned?
>
> As for the use case, we use buck2 --
> a build system similar to Google's Bazel and does many things in spirit
> to Nix by leveraging RUN_PATH to create links to the shared-libraries.
>
> We have customized our interpreter however the lack of $ORIGIN means
> that we've had to maintain a single glibc versioning across our machines =
as
> a platform since glibc has tight coupling between the loader and the
> libc.
>
> This has been a pain point for upgrading. I think the ability for the
> loader to now be relative to $ORIGIN meanst hat each binary could
> diverge glibc/ld.so and not affect the rest of the machines.
>
> tl;dr; ld.so from $ORIGIN itself is not only useful but since it's
> intimately tied to glibc, it allows for more flexibililty across our
> builds (very similar to NixOS in spirit).
>
>>> I hope you are enjoying your vacation.
>>
>> Thanks!

Ah one more thing!

What's next for this patch? Do we wait for BPF maintainers to comment?
Should I continue to add Reviewed-By trailers to the other patches?
(I have limited knowledge on some of the mutex stuff but the agent
review in b4 was helpful in understanding it enough to give a review.)

Sorry if it's obvious. I've never contributed to a patch this far
along or substantial to the point of having to understand the
merging/acceptance process in Linux.
