Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5240202997
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 01:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776044331; cv=pass; b=Bh2ZB5UQIbkBrbWPmuI/zICf9PbLpH2quw4rPjimapW9dqPK93/2M5aafZ44WMTb09sicI1CfwumyoWA+KlBKbrFavd2g1/TyxFFyYfdtd+NlSXb+PARF7u45mtmX6BOgKyytezxphd2k/T/1eZvEiu2l+WUN1yMGKIotqHm5js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776044331; c=relaxed/simple;
	bh=nFQMxFVF63QIAvOySvI+1iQgD3HbEkVh9BhKaGfv3zE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdJLTjpfjjnTc3U5eCkk/N1YKNjS7l27IEFG7KPZRfyoPxodxhCd8bv8XXDx0kYgSe6VdyoIbMYMgoBwRM1bYTSZF+UbX8a9QAdtVWkUbOlZqVJfqBbGSWCPmX70bcqVitB5ifGTY9b77prpbx+nxd4ztGFT5OdJ9KoeKvvt53k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eKE915kT; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eKE915kT"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35d9f68d011so2422364a91.2
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 18:38:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776044328; cv=none;
        d=google.com; s=arc-20240605;
        b=iwSq8v2iLS19nhBW4zbCm1TFv/ZchLacK2/VQcr2A9iGTvv10oMWqMxOIR084GLK1q
         d1QyD+AL7QWsrsejaz9tHJrqyK/pKRpDFCHbHKiIQbDmdMefPXtFAWZ+E/UE2k7AVDNE
         Kc7ldsdUypqm+j7HsBQzk5IdY3No1wdPeAi95GpJa1a25VSWoHGJk8X01c15ITXUoWfE
         y5TDvttCkwtLm/1xQjWFdeSmIWP+geHDvUlQFblqOu3hGG2LReRZZ0j6sYCm+KnQyNXI
         PvO9zJTSAZojyQdfI5HtmE4A3XBN2JES0HKUlDiPVkjlMi95c8nTDCaQryWN2UXjVs9g
         tm4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rHM3YXF7LUUih11DEyeSF4HP2j8S81Um3Rlg3lvVGk8=;
        fh=FBoD3LPuVzJ5FGxG3cMeCluArSOqgcF5QEgdD/feAtI=;
        b=Hslo8f1qDGGylYCh4fRNaFwpueeRWuDGkMi0e2BQVm+JSbhLHIRLN4xKhygtpmHhor
         6LgCTJj0ShIQDsgmY097J5YSBx1go+30q9d8IuW5HCXy3AwQj2KAYk1X1zrqi4fJi3E2
         TYpA9ICEqGhwnxRr7Cl4IGsvAjXR2ITPHRg01nGIGVOP1GHnR9IexbrB5y57pqmqBBQx
         1RKYO9SAlVYa838LJH32p8Gp2VhkDoJYM+bKufhCUDwjTKPP2V3ezJlqVbh5FPP7smlF
         22bhualTbjV0GezuufbpBRtlJ25rs+r5wq+x+czcbQ6mRwyr5VueWNQqwC0IuIWSbkJ4
         CjzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776044328; x=1776649128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHM3YXF7LUUih11DEyeSF4HP2j8S81Um3Rlg3lvVGk8=;
        b=eKE915kT3+S+mLQpSv3WJJllJZL/rf+5tW81dTt/VcQBQmgXELrog27o4zy4CEjsoU
         +v3RHtxTvZeZt2a9GAo4Qmr626+pPtGF3BOBmSlcJ8ZBDxC8LM7kCyz4QShBkEC+5w3f
         hOpDkHeIynke8mnG7Z1NnJXU2fC1A5ZHio1CnH4fR887v4rM26xdrha6gmofMI5Duh/N
         E/CAq+/NIBUNICffAMLYY+17nyxZaBuK31dz9PyF7xfHLF2nrXJ3U+ipmQZYS3/FQSFh
         HhDDtTrE02yaipqxGDhtYhVW8CEBlnX58VdF3oDqn6uaZEj/ruFLfnwN7FnCvdXbEBfN
         Tm6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776044328; x=1776649128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rHM3YXF7LUUih11DEyeSF4HP2j8S81Um3Rlg3lvVGk8=;
        b=es1KJruIE2/UbYEs2irOApQsZQPnq5ok1gk71wY4L9KfqE/yJWqGyq7FW6aBWMeu8k
         63VKxdL0Ass9xLTzdvonlV1B+XY1xvX7dzFL8SQjp43SykPyaYDwQhxeIiAPt6dEHwyu
         eDJIg5EMeXCA3+mmtTaJDb4Bqfb9Od2gt2Ffy0/vuziX406YTz3VW+6DdN5pxuDs69E/
         pxTnRA4U57jeJHCoJnl8gdA3k4M8SIZeQ1YsbvWTdqULPVEZw/0gczp4ZkxnZBwOLbm1
         RW0W4O4R00UhgerGbcPLffeoqTnPka5yCL/iXFT2HgVaWWGNT9+OSN02Fi7K4hUcUqAM
         9c0Q==
X-Forwarded-Encrypted: i=1; AFNElJ9Jp19YSDfFNyUgucZtcmOHuNUtFcWJS5b9h07L1aL7/vWG4+xLwGwkwn4Xq/dLqLv+ecc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSNwdDkSnNovIuzdXcnxzo2Ynu++nchZ86RvCEOd76WqQRzh2k
	eQPmV6cgM14R14TqFXKMNApt4Uc0MB6sbZvV7okuqX3/cLUnArNjaMVUs0afP510xA6o/S25L0H
	xF95n8oyHCudZNTIFR60qIokVzJNP0IMiAXxfMyRw
X-Gm-Gg: AeBDieu3rCMhrK1R1p1U0rVj1VC4PdEb+/Do7VG9oyXCEjU4oWPqh1Cd1vTj2OMUxDV
	pebGKG3OtdkpVqnxqJcwNvST0VlnJglInQSaKfLbjJtsa5lmISYd6BjSvd4sAqnR9sKFDpTunNU
	9DhiS+oKvANFbWJDM1yRo6elXc4za06x6SftxbyLdvBrkCulIdVGt87XHI6cSbTEJaFcDOwIsy6
	e+NbTSKfDmxjTdqjvt0kUGAWTvc0ZTr+xfXduuatZ2+BzfIIxVLPQ+gNxEHbeVH2ce9XNqb/Nta
	Fahbaps=
X-Received: by 2002:a17:90a:289:b0:35e:58d3:3286 with SMTP id
 98e67ed59e1d1-35e58d3350cmr2477282a91.24.1776044328031; Sun, 12 Apr 2026
 18:38:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-fw-lsm-hook-v2-0-78504703df1f@nvidia.com>
 <20260409121230.GA720371@unreal> <2dd138a2ae87f90c55dbc3178d9c798294fd4450.camel@huaweicloud.com>
 <20260409124553.GB720371@unreal> <CAHC9VhT1X4HX4bGrK=mEzu=g=mZ-Wg-LDXVgZVe-e6oM+W9aHg@mail.gmail.com>
 <20260412090006.GA21470@unreal>
In-Reply-To: <20260412090006.GA21470@unreal>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 12 Apr 2026 21:38:35 -0400
X-Gm-Features: AQROBzAOzVjdc2Fm0JK51NQkLRAYu7tuztXcHDPMGgqzx6OZVzpwqD1l_OckOpE
Message-ID: <CAHC9VhRnYXjg+vE9a8PeykbXk91is12zYLaO7EFdfZPKMxDfPA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Firmware LSM hook
To: Leon Romanovsky <leon@kernel.org>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Saeed Mahameed <saeedm@nvidia.com>, Itay Avraham <itayavr@nvidia.com>, 
	Dave Jiang <dave.jiang@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>, 
	Maher Sanalla <msanalla@nvidia.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 12, 2026 at 5:00=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
> On Thu, Apr 09, 2026 at 05:04:24PM -0400, Paul Moore wrote:
> > On Thu, Apr 9, 2026 at 8:45=E2=80=AFAM Leon Romanovsky <leon@kernel.org=
> wrote:
> > > On Thu, Apr 09, 2026 at 02:27:43PM +0200, Roberto Sassu wrote:
> > > > On Thu, 2026-04-09 at 15:12 +0300, Leon Romanovsky wrote:
> > > > > On Tue, Mar 31, 2026 at 08:56:32AM +0300, Leon Romanovsky wrote:

...

> > > We implemented this approach in v1:
> > > https://patch.msgid.link/20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidi=
a.com
> > > and were advised to pursue a different direction.
> >
> > I'm assuming you are referring to my comments? If so, that isn't exactl=
y what I said,
> > I mentioned at least one other option besides
> > going directly to BPF.  Ultimately, it is your choice to decide how
> > you want to proceed, but to claim I advised you to avoid a LSM based
> > solution isn't strictly correct.
>
> Yes, this matches how we understood your comments:
> https://lore.kernel.org/all/20260311081955.GS12611@unreal/
>
> In the end, the goal is to build something practical and avoid adding
> unnecessary complexity that brings no real benefit to users.
>
> > Regardless, looking at your v2 patchset, it looks like you've taken an
> > unusual approach of using some of the LSM mechanisms, e.g. LSM_HOOK(),
> > but not actually exposing a LSM hook with proper callbacks.
> > Unfortunately, that's not something we want to support.  If you want
> > to pursue an LSM based solution, complete with a security_XXX() hook,
> > use of LSM_HOOK() macros, etc. then that's fine, I'm happy to work
> > with you on that.
>
> The issue is that the sentence below was the reason we did not merge v1 w=
ith v2:
> https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-lsm=
-hooks
> "pass through implementations, such as the BPF LSM, are not eligible for
> LSM hook reference implementations."

I can expand on that in a minute, but I'd like to return to your use
of the LSM_HOOK() macro and locating the hook within the BPF LSM as
that is the most concerning issue from my perspective.  One should
only use the LSM_HOOK() macro and locate code within bpf_lsm.c if that
code is part of the BPF LSM, utilizing an LSM hook.  Since this
patchset doesn't use an LSM hook or any part of the LSM framework, the
implementation choices seem odd and are not something we want to
support.  As mentioned in my prior reply, you could do something very
similar though the use of a normal BPF hook similar to what was done
with the update_socket_protocol() BPF hook.

There are multiple reasons why out-of-tree and pass through LSMs are
not considered eligible for reference implementations of LSM hooks.  I
think is most relevant to this patchset is that an out-of-tree hook
implementation doesn't necessarily require a stable interface, and
without a stable interface it is impossible to make a generic API at
the LSM framework layer.  As you mentioned previously, each vendor and
each firmware version brings the possibility of a new
format/interface, and while that may not be a problem for out-of-tree
code which is left to the user/admin to manage, it makes upstream
development difficult.  I did mention at least one approach that might
be a possibility to enable upstream, in-tree support of this, but you
seem to prefer a BPF approach that doesn't require a well defined
format.

> > However, if you've decided that your preferred
> > option is to create a BPF hook you should avoid using things like
> > LSM_HOOK() and locating your hook/code in bpf_lsm.c.
>
> We are not limited to LSM solution, the goal is to intercept commands
> which are submitted to the FW and "security" bucket sounded right to us.

Yes, it does sound "security relevant", but without a well defined
interface/format it is going to be difficult to write a generic LSM to
have any level of granularity beyond a basic "load firmware"
permission.

> > The good news is that there are plenty of other examples of BPF
> > plugable code that you could use as an example, one such thing is the
> > update_socket_protocol() BPF hook that was originally proposed as a
> > LSM hook, but moved to a dedicated BPF hook as we generally want to
> > avoid changing non-LSM kernel objects within the scope of the LSMs.
> > While your proposed case is slightly different, I think the basic idea
> > and mechanism should still be useful.
> >
> > https://lore.kernel.org/all/cover.1692147782.git.geliang.tang@suse.com
>
> Thanks

Good luck on whatever you choose, and while I'm guessing it is
unlikely, if you do decide to pursue a LSM based solution please let
us know and we can work with you to try and find ways to make it work.

--=20
paul-moore.com
