Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85909372076
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783955969; cv=none; b=rpSHPjM+kKIK4LbydWfTBsf1I0AFQ/6MMeQkDQR5PUx/p1Ct4TmStZHejGRWIjJxSARpRPqP5hQK2buPtirt+RLsddXmGbYgKcEP0ROuahfvlISvCsNmGHJ5yWvxo35aTH5rG/LAPsQERGh7WGDl73uoxdiyKUhmpgpGUpNVDTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783955969; c=relaxed/simple;
	bh=XgfMyReXk9WbmWlpqj5QpOsH9T7Axa67XF6W7nxC6hw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=V5JLHODvPtKZOQIqld3/BxIOnh/Op2z62FETm6y/9NsbS7ob2qCjFKaLferpvNT8Bx1sb8zrZsvklZZnbmScNykjd42nKOA3T1AmOUq7YIUg7zuexOWvKSzFpPGADR0n4uGgOrL6fk3LCF+H4pObeBzFhimCpxnalUr6Y7NoAcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IE9gFOzQ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IE9gFOzQ"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ca80d708489so1990882a12.1
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 08:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783955967; x=1784560767; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Y+ujhi7qr+5PDvfWnrugr3cptYcf6a5ot8pqDt3RfQQ=;
        b=IE9gFOzQxBDi0IVIrhm0xXbwtjhN28eJ/IpULeUzVkLrp4WItFQSjycxXQBT8F/RRf
         ZZDKLuohqee4ndlVWfcJeRLAzaEOAxov7d3xU6on6CPD7dOtfB9dMJ+KpDdJQcax1rPO
         /iHly/a+oJlxoRMoniQYQ0dRecTsxtPtRRXJ7eCTHymRpN2542pMfENTlXrM17TP0zZr
         SH2hL9lc9jcxx5xbK9FU8/Rl4hZZGma36UhIX0MwY25wxVho40B2I/jLLdhXeIq4Zxqj
         /fFquG9TDC48spLnFuf55vNQDeZpXvs1mPYRL/uru0NCAz7cFtsNQF4QoULbvbwe4jj/
         r0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783955967; x=1784560767;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y+ujhi7qr+5PDvfWnrugr3cptYcf6a5ot8pqDt3RfQQ=;
        b=Mui5m6NzQgvE+0I+/lJmnKFelAttScHlb1O5Smk/Ye2AOic7JSvEoSmlbAw5NC4eBx
         Xuo369F25lz+8HXHdkihOSwOz7P4EFhru8t2vRdUfKH4QBxPm/iVV/P4mlx0bkB/P3G9
         HujcccSGhHIw+zeRQuq8oxYBJwype51yqkBJkwsTxmFIu09Kf5WiCnlklVm02RTC+Lqi
         Z4rJcdKxsTd5aqNMoDym7kqKDXQFKnB1YypKxIqfUhqDCOv4g1ZmIAsX1mM0F2eLO0nx
         ZcrwjPsn8J82NxT12PzOsYq+o7qiJ3282ld+WJA7lGfOKHu+36ttv6N1CZglQy+wnXgt
         BHrw==
X-Forwarded-Encrypted: i=1; AHgh+RrfxoOUlML354Tc1JSFUHuSf9ZrlKTBIz+8kmbhYy8lgPRcG/xBLgK009aAkL/2TOdXDAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOIxHcIRORAf6lhNbOm4n+ZkjkafbPPm5WKY48qJ/Pucxwnunr
	52Db/7MWJbhKA0mlJwLW0m6i8z35UBbXt2eNJmw34N0SMvF/ug5AhDG1
X-Gm-Gg: AfdE7clUspsBmVVgMWBZO4Uo4sdXxcZlrVoDQJNlLOR7cYcneWNmwkhKc7Z1x/qWXZh
	A+oOjoVxYbLZ1vWn4hGHqoTTzrT6iZA2Psrj8wLVp7Mkna5xypSfGv0+MQk46qfMBDzcOkTYHBP
	TP7fdiFflJARP+E61jtDezlmN7KWtAg96e19E1xAK/5JsJIt2vI5ZhIoSn8/lBc0ZrjqGlbemaW
	qm1F2/yyRsb83moQ6XYhHh5JwHb1x3BLZ1LgZUnmBSugI+e02OFkbswpy0Kt5uVRyuM/LZB1GzO
	meD1W9MTvCz7VWe4ziepkQ4w244FrgODjVdAStzLWML5VpX4AmaIG1+nC5Uc6ZDOh3i81OHC+B8
	KrCS5T0GryIduFm3MV0mJWafn7usdeZNR0XzOKswOOg5rrKqY8srMZsZhO7uTDnwCTIHShho2LM
	zJ903Vro0AwwtM3A==
X-Received: by 2002:a05:6a20:244b:b0:3a0:c246:bb98 with SMTP id adf61e73a8af0-3c0f0b9158emr16049895637.29.1783955966577;
        Mon, 13 Jul 2026 08:19:26 -0700 (PDT)
Received: from localhost ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b924258a2sm54513605c88.1.2026.07.13.08.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 08:19:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 08:19:24 -0700
Message-Id: <DJXJM0838IJN.3AJ9MMQ89SUUR@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Shuah
 Khan" <shuah@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Kees
 Cook" <kees@kernel.org>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan
 Kara" <jack@suse.cz>, "Jonathan Corbet" <corbet@lwn.net>, "Jann Horn"
 <jannh@google.com>, "John Ericson" <mail@johnericson.me>,
 <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] binfmt_misc: bpf-backed binary type handlers
From: "Farid Zakaria" <farid.m.zakaria@gmail.com>
To: "Christian Brauner" <brauner@kernel.org>, "Farid Zakaria"
 <farid.m.zakaria@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260711-binfmt-misc-bpf-v2-v2-0-d6591ceaf207@gmail.com>
 <20260712-abluft-brutkasten-aufladen-c8063a4a1a0a@brauner>
 <DJX4IFO55D9S.3IV3K5XICJAEV@gmail.com>
 <20260713-unerlaubt-luftkammer-kosmetik-46532d395f9b@brauner>
In-Reply-To: <20260713-unerlaubt-luftkammer-kosmetik-46532d395f9b@brauner>

On Mon Jul 13, 2026 at 1:20 AM PDT, Christian Brauner wrote:
>> > - The single sleepable load op is split into two ops:
>> >
>> >       struct binfmt_misc_ops {
>> >       	bool (*match)(struct linux_binprm *bprm);
>> >       	int (*load)(struct linux_binprm *bprm);
>> >       	char name[BINFMT_MISC_OPS_NAME_MAX];
>> >       };
>> >
>> >   The non-sleepable match program runs from the RCU entry lookup
>> >   walk itself, exactly like magic and extension matching: same
>> >   registration order, same first-match-wins semantics, and it can
>> >   only rely on the prefetched bprm->buf. It must be free of side
>> >   effects since the walk may be restarted.
>> >
>>=20
>> Is relying on brpm->buf enough?
>> Right now that's only 256 bytes I think, which is not enough to read
>> segments we might care about. That worked fine when it was just a magic
>> number but the idea with the eBPF program is to make decisions based on
>> more data.
>>=20
>> In the selftest I provided, the `PT_INTERP` segment is already at file
>> offset 0x318 (792). I was imaginging NixOS having to support
>> `PT_INTERP_NIX` in order for the produced binaries to be backwards
>> compatible with older kernels.
>>=20
>> The other idea would be to make the `match()` broad and select
>> everything but then nearly all ELF64 binaries would match and then pay
>> the price to `load()` and ultimately `-ENOEXEC`. Seems like it would
>> make multiple BPF binfmt programs less useful.
>
> Ok, so your idea is to have multiple bpf programs that look for
> different interpreters. Yeah, then you have to be able to sleep because
> you need to be able to fault. It makes the code uglier but I can see how
> that's useful. I'll see how nice I can make that.
>

I mean... I thought that's the intent to binfmt_misc, to have multiple
handlers -- with the expressiveness of eBPF vs. the limited
magic/extension, it seems like a natural extension to support multiple.
Otherwise anyone on NixOS would be limited to our single handler for all
binaries which seems not ideal?

I'm not knowledgeable enough to comment on the sleep/faulting aspect so
I leave that to your expertise.

>> >   The sleepable load program runs once the walk has committed to the
>> >   entry and does the file reading and the interpreter selection. Both
>> >   ops are mandatory, the struct_ops plumbing enforces the sleepability
>> >   of each, and since bpf_binprm_set_interp() is KF_SLEEPABLE a match
>> >   program cannot select an interpreter by construction.
>> >
>> > - A match is a commitment. A failing load program fails the exec inste=
ad
>> >   of falling through to later entries. -ENOEXEC keeps its usual meanin=
g
>> >   and hands the binary to the remaining binary formats, for a handler
>> >   that discovers it cannot serve the binary after all.
>> >
>> >   This kills the part of v1 I disliked the most: the skip cursor and t=
he
>> >   leave-and-rescan loop in load_misc_binary() are gone. The walk is
>> >   never left and re-entered, and 'B' entries need no special semantics
>> >   against concurrent (un)registration anymore.
>> >
>> >   Your v2 changelog note about keeping the bpf retry loop in the
>> >   __free() style is moot as a consequence. The loop no longer exists.
>> >
>> > - The load return convention flipped: 0 now means success after the
>> >   program called bpf_binprm_set_interp(). Returning 0 without having
>> >   selected an interpreter or returning a positive value is treated as
>> >   -ENOEXEC, other negative errnos fail the exec.
>> >
>> >   So the "return bpf_binprm_set_interp(...) ?: 1" idiom from the v1-er=
a
>> >   programs becomes plain "return bpf_binprm_set_interp(...)".
>> >
>> > - The handler name moved from the offset field to the interpreter fiel=
d
>> >   that field consistently names whoever supplies the interpreter, a pa=
th
>> >   for static entries, a handler for 'B' entries. Offset, magic, and ma=
sk
>> >   must be empty:
>> >
>> > 	echo ':nix-origin:B::::nix_origin:' > register
>> >
>> > - 'C' is allowed now, v1 rejected it. It behaves exactly as for a stat=
ic
>> >    entry. The setuid transition stays gated by vfsuid_has_mapping() in
>> >    the caller's user namespace. Which makes 'B' handlers usable for a
>> >    per-binary loader over setuid binaries. 'F' stays rejected as there
>> >    is no fixed interpreter to pre-open (I have other ideas how we'll d=
o
>> >    something like it later.).
>> >
>> > Nothing changed in the exec patch, the fs kfuncs patch, the kfunc
>> > itself, or the registry/namespacing model.
>> >
>> > I can send v3 in a bit if that's ok.
>>=20
>> I don't mind at all you sending v3 and in fact I've been enjoying your
>> involvement. I didn't know what to expect when I offered this idea up to
>> the community.=20
>>=20
>> I'm happy to keep co-developing this with you within a design you feel
>> acceptable with. Please let me know how I can remain engaged and
>> helpful.
>>=20
>> One last thing I was thinking about is that we will also need to support
>> $ORIGIN in the shebang path, however I just tested it and this current b=
road
>> BPF solution can largely handle it [1], with a small wrinkle.
>>=20
>>   $ printf '#!$ORIGIN/interp\n' > /opt/app/greet
>>   $ cp ./interp /opt/app/interp     # any interpreter/loader
>>   $ chmod +x /opt/app/greet /opt/app/interp
>>=20
>>   # stock kernel: binfmt_script opens the literal "$ORIGIN/interp"
>>   $ /opt/app/greet
>>   bash: /opt/app/greet: $ORIGIN/interp: bad interpreter: No such file or=
 directory
>>=20
>>   # with the handler registered, $ORIGIN resolves to the script's dir
>>   $ bpftool struct_ops register shebang_origin.bpf.o /sys/fs/bpf
>>   $ echo ':shebang-origin:B:shebang_origin::::' > /proc/sys/fs/binfmt_mi=
sc/register
>>   $ /opt/app/greet
>>   <runs /opt/app/interp, the loader found next to the script>
>>=20
>> The wrinkle is that it can't express today is the single optional argume=
nt.
>> (i.e. `#!interp arg" -> argv[1]=3Darg`). We might ned a way to express
>> that in the load.
>
> Ah, fun. binfmt_misc wasn't able to express this at all. It's good to
> close that gap. This can just be done by adding
> bpf_binprm_set_interp_arg().

What is "cool" about this is now it's also a net-new feature for shebags
which the "old" binfmt_misc didn't support. Anyways, I was thining ahead
about what I would need to support $ORIGIN fully and this was
a remaining gap. We also explored this idea in a patch pre-BPF [1] but
now that we've settled on this solution it seems much more natural.


I was recently reached out by some Bazel people who are also interested
in this $ORIGIN support. Interestingly they let me know that
IllumOS/Solaris had support for it as well.

[1] https://github.com/alurm/relocatable-shebangs/blob/18db0da6cd69ce19bb02=
73f2548a2d96bdaa82b1/relocatable-shebangs.patch
