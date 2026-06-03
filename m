Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074713AD53F
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497855; cv=pass; b=DbUGRUvSMkvAXGYKy5gN5esOes7bKkvRdoiUBQhh0IXk2pkLRuwv6wUUP2vLF1kpq6WmTHyKAa8iPQqP08DnbEhWMOpHBWlcbMWABQYD9LX73zHqn/aKw1RGtV9D1RuvNCAuEMAFbIkmfE8rDxlfB2ukunk2nxbYO2o5dGcDA04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497855; c=relaxed/simple;
	bh=2OkasJ0ndKZfg6cpcJo7yWgVLndNvCdeEQG7xxbqLK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SXaF3Ct4y7plxr0Q1a59sXALXNnJHj6vu94X+EcAWWvklYPVqsUYXDXAoiw15h5G+4eXh6mD3fwHesj2zyS9zZ8fAPbKGs70xk9HFtbOuVe7KtgWgEhEaa0p853BFT2bI9VkCHwqqqOZ0Sd7i82Ytq0GZKCiXNNXOwHOqC5e4XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=K7D5f+wx; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="K7D5f+wx"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bf237e1433so58548085ad.1
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 07:44:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780497853; cv=none;
        d=google.com; s=arc-20240605;
        b=DVsneln5uO7YeoHxWR4ImfF07uG4ngfLRCfkk58/8Up17rEooHXyuvbLe6E3PN+8Zz
         4rJVy/gNsnxunpqzzg5+Fl7oHJXwkSb32aSHxL4W9zj83ltbU6oMOs0tjygPWlzkepmK
         pty1Usu0vSxBEVk3ZW2cYeTb/tAOW8I3WAZomjywpWhN+wyQXHp6w+NVvfu7titGAw4G
         GTlcrXXijAbUwWMAi5PjkoV8TeH9j21RDISwat0cfyMcC0zvQuG6I2knZ57w9ttBRUkT
         QvbU4+tSpimwmA/pZHlCC35masdWsuTCOIXdbz60ycwKSQSekJKk2Qn2UVotus0Y0omd
         fKHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y5JjMZYEtQz+6ik+uw6aiCOF6sKgKEkR5ogTnZvnVt0=;
        fh=jHPo5E/3oZlmQA9mghuroZ3llg3i3vlsM+aaCxasLCw=;
        b=SmZfY0jvqycOZh6MWzt6mgLdsJcniJoAnQpJ6uToMm9zWj1oJlBjJ+BKHqZ4+o2TDw
         SqUYwVRnUJCR7gpbPw73XNhwoP+u8aK8J58Tv3TBH7+kDyTETOvFgDstPgCjoOJk9CNm
         hg5cwXDJz4kOruTB8QfZl+7Y9q/NYJtGSM+a9Xtgghry5Xkpn6JXu2wACeKKCWF9ElmM
         cRitOHQVr0o6IOS32aqa5Orf0UrJVjOpWSQ/n7f7fYM/nW3Pd6gwM5J7mStJ1lM91Lkc
         32qra5pC/ZZO+1Z5EKfFXE8Ck3HjWhTNCEHX5+x/JhZwzS9/Ne+BalQ77lO0Mu05jb+A
         817A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780497853; x=1781102653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5JjMZYEtQz+6ik+uw6aiCOF6sKgKEkR5ogTnZvnVt0=;
        b=K7D5f+wxF8jERGEb36Ms0OO4m+9Fq0hFqokg0cc/mIe6f0adFu2IYc5qQhRMZtXZbo
         pYvyvR/AEHzCCdFP2qNPsBqN8HHt0YKQzvy5TLrFSuokRHsD6sYOc8KrthK3gVHRHmLG
         aJfQ7VIK3oh18o8tj3DvLr9YXhwnBfS+6F/l33cKn7Ux0qcvgzzYqCqEAxEhIG4iX/No
         66kkJd70ctGAG0yysuDInWJWr7gBdbAJ5QaM5ZPB1rCQz6WWysVhBAWyFeV+VVKr9R9b
         OECQC8asSoRgfC9w8GuRmhULjIm+omSKKVfyFaM2/3yu3fnr5++/8/i9nD+k+dmevIFs
         u51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780497853; x=1781102653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y5JjMZYEtQz+6ik+uw6aiCOF6sKgKEkR5ogTnZvnVt0=;
        b=oqISMpriNVuHBlTVOk7tQbWdpy5bdhYEC4WiNEkt4L39RGQUaYSewO+6VS8E4s+Lw2
         hKuEz++4CsfsV5ACaAgG3fNaCzeGg/vPzG+f1NH1ZIZRAuklyUj6+E8W1zRIW07AQRwd
         OpWgPqNqQiu6HIbUEPYsd33PN8t3LUAnTaJtwvaHI0nD+FlzJApexskCPRLP9ss9Qoc+
         wHlYsQwKd5ozt3CmynVQO7dnT5A71BHMHnm5+SONeAod5woMaDFFd/s80kiKtZf36s0U
         nIwVtG/MAktWWC7mXAYm3AOipTgcwu+FeysCwMTQrFjXldkcbggGfgtsGeA7dyEweygb
         tGpQ==
X-Forwarded-Encrypted: i=1; AFNElJ/tbKwNh73ybPzMz/dyenainjfbBkIA6YHsRABl0I7xzqGZbW435UXzuD17ZiCgX18tuQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr3h8IPkffTlRmgiTmhcg5kSSagCXVO0mG+jPcouSoj5v1aMue
	mpXqsVA/89rMTfmolCStUNl1/HfYrZe6Y/YaaoR9nxT/LrnoSI7XihaIqkUVEGIPaGnpnhewbxM
	akLvvGuCkJy8zFGPK+voKW7iWpWrcQyTuHAKsIfkL
X-Gm-Gg: Acq92OE8Q0uCCQ1uHdnipJkNQltlLdNMjlOt0pEGZxzhQG4isPFy2WhQZiZe+3GlJ/v
	bOkWOuyyTy/nyQZ/RN4/K+qc1gj66Wo65vdMV/vTrRcDJoQJNywQyaxL+fSBKKZ3kptW0GcO3rb
	fIUIewxTMbcfsctq0o6CtqZOGKLFW0qQfVjTCrK7W3cuW/ZiXbOJxVQlbeQ8vB9ajbEefyT0ext
	Z/tYF8YmYT0AsOjyssxXkzspxG3hJlIE6AZrj7vDJx/KAoTN1wwUU5QW3WPkVC4ITJcn50dokge
	ESA+h8w5F9d0Kmpplg==
X-Received: by 2002:a05:6a20:d4b:b0:3b4:895f:6ac7 with SMTP id
 adf61e73a8af0-3b4978a23d7mr4133938637.22.1780497853207; Wed, 03 Jun 2026
 07:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ah8BzqSmZO40xYhS@sirena.org.uk> <CAHC9VhRR4mmkOdWwUCLswmA+_KEjB8RCBBTJ2W4JGiLUWKzxyQ@mail.gmail.com>
 <CAHC9VhRPbkVYAMec0KG55er6GOPdKqMXKdpC8rrHgiAodSv-sw@mail.gmail.com>
 <9d34218f-abbf-4a23-8b35-b305873ffae3@sirena.org.uk> <CAHC9VhQnBi55hjwTATA_tgKNZ=StFYTKu2Av5R8N4yDJwsFswQ@mail.gmail.com>
 <6565c4a4-3102-4521-9c84-48c7c7f0117f@sirena.org.uk>
In-Reply-To: <6565c4a4-3102-4521-9c84-48c7c7f0117f@sirena.org.uk>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Jun 2026 10:43:59 -0400
X-Gm-Features: AVHnY4JIW8gQBYMOr8fggrJDG2mD4293Ofq_rtsFtHA031eqjcjZT-6N6e7Vah8
Message-ID: <CAHC9VhR9R-wBAj64aO60pSUb7f5Tmfj6gprrHQB3g+=WYF14mA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the security tree
To: Mark Brown <broonie@kernel.org>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 8:42=E2=80=AFAM Mark Brown <broonie@kernel.org> wrot=
e:
> On Tue, Jun 02, 2026 at 05:45:04PM -0400, Paul Moore wrote:
> > On Tue, Jun 2, 2026 at 3:16=E2=80=AFPM Mark Brown <broonie@kernel.org> =
wrote:
>
> > > Can you ping me when that goes in (or things are otherwise resolved)
> > > please so I know to drop the revert from -next?
>
> > You shouldn't see a conflict with lsm/next now, but if you do let me kn=
ow.
>
> It's still there today, but seeing Linus' comment about not merging
> hornet I marked it as BROKEN instead.

My apologies, I forgot to push my local tree to kernel.org.  It should
be all set now.

--=20
paul-moore.com
