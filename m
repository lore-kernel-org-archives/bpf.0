Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9784E3A1C9
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 00:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784160641; cv=none; b=R8X8nTL4rgqBYPJG+NsJWRUJbwuQCpuS1iSYLvEHtxCC5gDvz7pea24btMaela3jk65Zgjr2gMSGUcMhh4O2bvpDqCxwQikUjRj+0/V0ntaizBwZEUWcNpPyyS9r4UWJt/zCK7bhhgi0GCmJ4gI4U36me9pb4Thejifg3wePcyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784160641; c=relaxed/simple;
	bh=iFLgZLz3ksNBmau+Jra7CtGxgjSGyRGOtEuDc5teeQE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=QC7TJvbQaCL7Ek6HeRuHv4wcKBPxOmOV8SQs1RAz1sFgDksYn33KVv7N2rggn5KOv27ljaM/Duwwhu2/TCeOrxyomY907Pgb5WOKqDDhjtt/OUoJjFj2786SyKuOINrKJwsPVoTBB3LR2qPEhly5TmsvNEFOgcf11qKv/oLY8KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGKLgxMZ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGKLgxMZ"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3811f512167so6611478a91.3
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 17:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784160640; x=1784765440; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P4jDzMSQG0md28knM5bL5uqnp/M0FWc4W2jCI8EKDHM=;
        b=bGKLgxMZE5H6aZP7O4yGap1QdkUUYV//Y27k5yYIuvArF5V1xSOiYsB3gR0H7hOgk6
         OkkHNP26vxtH4rzQretMwI+iGUwS2klN/AAxuG1BOw9coSYPhf8RkTGfu2hE9FK8/HGS
         UJ67DpPTzSVmVO5y5Qb7rvitQcYkYMrokUGNOYRTA8Y7RvwPUTOGev03rUdBtFmh5cdr
         VuOjMaR7QUQQyxchWwCONEgHhHIjTnyUrP7PYaSvZ2orSeZmEGlAzR6TZzy12L5SmMdd
         U9HXsObivCqSD5fZmDWjqAuIQnmQFfDjrXPnrlXhufVNeeR6jmaM2DLkMSJjwXf2WA0u
         +vMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784160640; x=1784765440;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P4jDzMSQG0md28knM5bL5uqnp/M0FWc4W2jCI8EKDHM=;
        b=j4m/qsLNuYu+BzeNgMO+SiHIkIUclKNrjQQDlCCJmlOkjWxaEzVqHWNWWOY4vyNeR6
         5m5CxtXXq6K6CMs/N9OQNdmVxKpdcBds/rwZDUlvC9zbazbcQ5lX4MALJlWEU1ta5HXS
         VCOI64Inej8B9lNMWA8pxlaF8qiDXMoBiFgTHs6SI4k8VR2cWvS2vUo3e4ZVAhtl38Cz
         AcX3oH1AWSDeeKGdV5x7rROWlfG9GTsE9ftyVV8o+p9V3GS+4pLT5E5/2ZUMEJBjCwjQ
         h81YQzAePkq0ptazWryzfDsKXwuZNAXcpjQqF5oPKoPvEoObd7y+ebG4Cly0haN1j+Yb
         slkg==
X-Forwarded-Encrypted: i=1; AHgh+RpDimORhTtfdEGO6dLjQlGcMfOErmFfQyM1iInoK+Y7jrVdc33dyePch7IlB0pLxwnZ0xA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYVyTOQufq/hg2ORnCzuL2dy+BJg0S5sXgd00KNlmpBkoXNGlH
	/qTalBEdPUBXlREsbLFHKQ6HHD79d1hUn9EEd6nqJ0yb7n5tkuVP+c7Y
X-Gm-Gg: AfdE7clz3Xo55j9AbVPz8CqIYIlg1XHmBXNMGtb6KEpXKqAoBrQMEKuaHgJZSILg3uL
	lGVzJFd/htDQOESC48TRYemftxN/WEAb8lKxrgY7nNWwc0sleKj3bgFAbWbVI7AJL2PPEEQrRAa
	FeYIliQMjdYs+z0Ph5dYrioc1xu2jOKY+LByFwgyJi+7/FUK//iLknsZGnKEejuyODMsBttT2Wq
	lJ4ieUk5n/gdU6vzWb7j8u6V2tDNwGbrtfHAxSNJkkHHZfy6lVSDqMjmdYGOyr+VUKxcdoIm5Ig
	ZTF4AOXrXy4wW1zq8T6ZalO8Lorxv6GVwz/PssN09TXDOhwvkZgty6gwhLeeDS8BFPGM0/rHC93
	bKjjfU+y+VIy9GNrFizTtZrs0qVSninAw56+rIdGU9FnzeqchT9ch4nF32nVX0QVXErv6TZoVzo
	vDpUI=
X-Received: by 2002:a17:90b:2ec7:b0:37c:774c:77ba with SMTP id 98e67ed59e1d1-38e1afbf5abmr8173040a91.21.1784160639936;
        Wed, 15 Jul 2026 17:10:39 -0700 (PDT)
Received: from localhost ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e6ebe98sm4999273eec.26.2026.07.15.17.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 17:10:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Jul 2026 17:10:38 -0700
Message-Id: <DJZK5TY3IXQC.2XKA1X9IEGJDO@gmail.com>
To: "Christian Brauner" <brauner@kernel.org>, "Farid Zakaria"
 <farid.m.zakaria@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Alexei Starovoitov"
 <ast@kernel.org>, "Kees Cook" <kees@kernel.org>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>, "Jonathan Corbet"
 <corbet@lwn.net>, <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
 <bpf@vger.kernel.org>, <jannh@google.com>, <mail@johnericson.me>
Subject: Re: [PATCH v2 0/9] binfmt_misc: bpf-backed binary type handlers
From: "Farid Zakaria" <farid.m.zakaria@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260714-work-bpf-binfmt_misc-v2-0-57b7529c002c@kernel.org>
 <178407531866.2243172.12944140194021045628.b4-review@b4>
 <20260715-reorganisation-umtausch-radiergummi-8b38ca81ebb0@brauner>
In-Reply-To: <20260715-reorganisation-umtausch-radiergummi-8b38ca81ebb0@brauner>

On Wed Jul 15, 2026 at 1:40 AM PDT, Christian Brauner wrote:
> On 2026-07-14 17:28 -0700, Farid Zakaria wrote:
>> On Tue, 14 Jul 2026 21:58:05 +0200, Christian Brauner <brauner@kernel.or=
g> wrote:
>> > [...]
>> > 		.load =3D (void *)nix_load,
>> > 		.name =3D "nix",
>> > 	};
>> >=20
>> > Farid, this should slot underneath your qemu demo from [4] with the
>> > program ported to struct_ops. Feel free to take it from here.
>>=20
>> Thanks for the recent update.
>> Is it still "take it from here" or was this left-over from the previous
>> series.
>
> Leftover from the previous series. :) Sorry.
>

No problem -- just checking.

>> I think you've done the majority of the work here with the validation of
>> the few selftests and mentioning the gap for shebangs.
>
> It was a nice joint effort imo. I think this is in general an
> interesting idea. I'm also working on some glibc loader patches. One
> of the patches in this series allows for "transparent binary execution"
> if the loader supports it.
>
> In this mode you can pass AT_EXECFD to an interpreter and don't change
> the command line. An exec like this is indistinguishable from a "native"
> exec.
>

This sounds super interesting (orthogonal to binfmt_misc and BPF work right=
?)
but a neat feature nonetheless. I wonder if this makes it easier for
tools like perf to attribute the correct binary or they have already
handled interpreters in the cmdline well enough.

>> Please let me know what you would like me to do next. I just tested
>> reviewing the series with b4 + AI -- pretty cool. Was a little clunky to
>> get it to work but overall a good experience. (I need to tinker with it
>> a little for NixOS vim setup etc..)
>>=20
>> I shared this patch series at my workplace as well.=20
>> I think there is some interest in the work.
>> (If you are curious as to why, I can elaborate on that as well).
>
> Sure, happy to hear other use-cases. I have a plan to make it possible
> to pre-open a set of interpreters (pin them essentially) when
> registering the handler in binfmt_misc and then bpf would be able to
> select from a set of pre-opened interpreters but that's for the future.
>

This is assuming that in prior calls to the BPF it returned the path
string to be pinned?

As for the use case, we use buck2 --
a build system similar to Google's Bazel and does many things in spirit
to Nix by leveraging RUN_PATH to create links to the shared-libraries.

We have customized our interpreter however the lack of $ORIGIN means
that we've had to maintain a single glibc versioning across our machines as
a platform since glibc has tight coupling between the loader and the
libc.

This has been a pain point for upgrading. I think the ability for the
loader to now be relative to $ORIGIN meanst hat each binary could
diverge glibc/ld.so and not affect the rest of the machines.

tl;dr; ld.so from $ORIGIN itself is not only useful but since it's
intimately tied to glibc, it allows for more flexibililty across our
builds (very similar to NixOS in spirit).

>> I hope you are enjoying your vacation.
>
> Thanks!

