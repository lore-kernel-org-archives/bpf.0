Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B245B27281D
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 23:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769816918; cv=none; b=h56uhFM2qjyvW2Pvt5UqMzMzMGK7z1LAIXmQAeHCiU/vWaJGFjJ2zcgXFFtMKe8Um/GkSi+jdKO40QlvaAx2uRJRbTQMh08GHNagGMJPlrTmb+JVUQvFZlFy6jAfSw7YoUousI5oYNjKmYsMbEDYNuFQ8uHPQgE/tEkCB6iRIh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769816918; c=relaxed/simple;
	bh=bZ3myM0jPjsdbT1mwQfhbLvKT3mtlrvxq907N2Yr7jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Av1p92kCGvtkVwemtR2EQyZFzgWFGc3P2Of1JNOs8IAC+yZxKvdkibcLeLioGaK3H92TQEHqXcBwPWJN5oSbrsYyiVaB7847pIYEtakxrYCn36hdxJiVXlqrHYWBgKHq6gMH7AQExY9k90TreIbtrB0aDdeYFA0uWaufX3ppqXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKcV1Zy1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKcV1Zy1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B1AC4CEF7;
	Fri, 30 Jan 2026 23:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769816918;
	bh=bZ3myM0jPjsdbT1mwQfhbLvKT3mtlrvxq907N2Yr7jo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qKcV1Zy1FeBP81dsixRt+3ows8blv1uFMV+UgqgU4m9HIsk6g8tZ0AA9SO2de02BI
	 9rs0ufHjqdU4Q88GZcK+g7Y/BdqcL7U4bbqpiNI2etQcb8UanusTnIvWgqFeCWrymX
	 zyckXURmltOwxsjXXBIIrQB9PImLnKsjMRN7DYhcvyWPXq9WWf4VwHBwXlapiLcjcN
	 GCHJMdJprv7yFRuj1XiGDiCnNR7OEPBaZaX+X1sWI6vT1D7giThfeGHcCduPF43jHW
	 NwkgowA8ImsdpW7S/RdyOvi1Tr2xDHpAL5PyMDi5yhZfM05fTHFnPn75WC6qbGlTJk
	 Xu3NyM5KI/FDA==
Message-ID: <1d4546ca-8849-464d-9080-ef77602134c7@kernel.org>
Date: Sat, 31 Jan 2026 00:48:34 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpftool: Allow explicitly skip llvm
 dependency
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20260128233425.374535-1-mykyta.yatsenko5@gmail.com>
 <2b6f4cd9-ff0f-4a91-90ef-8d8e6812f80f@kernel.org>
 <CAEf4BzY16OkoUQZ-Vaywb0oAL=UGY=8FVcBWLVM8oe=-bQ=4xg@mail.gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <CAEf4BzY16OkoUQZ-Vaywb0oAL=UGY=8FVcBWLVM8oe=-bQ=4xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2026-01-30 12:46 UTC-0800 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Thu, Jan 29, 2026 at 9:34 AM Quentin Monnet <qmo@kernel.org> wrote:
>>
>> 2026-01-28 23:34 UTC+0000 ~ Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
>>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>>
>>> BPF selftests depend on the bpftool. In some environments we may link
>>> bpftool to llvm dynamically and then try to run somewhere where llvm
>>> library is not available.
>>> It's simpler to avoid llvm linking altogether in those cases, this
>>> change allows to do it.
>>>
>>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>>
>>
>> Hi Mykyta, thanks for the patch. Do you have any other solution to make
>> it work on your environment? We've been rejecting similar changes in the
>> past, because we don't want to encourage people to strip away the
>> disassembler when shipping bpftool [0], so I'd rather avoid adding this
>> if you have another workaround available.
> 
> LLVM is a huge and somewhat problematic dependency, so I think it
> makes sense to allow to opt-out of it. Of course this shouldn't be
> abused by distro packagers and they should strive to provide
> fully-featured build of bpftool. We don't have full control over this,
> but let's hope they won't cut corners (either way they can always
> apply some ugly local patch, if they decide to cut LLVM dependency).
> 
> But for a lot of environments this might not be worthwhile to wire up
> LLVM libs. I haven't checked if this is the problem for bpftool's
> bootstrap variant, but if LLVM gets pulled in for that one, it's
> especially bad :)


Hi Andrii,

The bootstrap version doesn't include "bpftool prog" commands, so it
doesn't link against any of the disassembling libraries.

As for opting out from the LLVM disassembler, I understand the lib is an
issue because of the size or when compiling a binary supposed to run on
a different machine, although I do fear this won't help with getting
bpftool shipped with the JIT disassembler.

But if really you want to do this, at least let's do it fully and give
more control for the disassembler dependencies: I think it shouldn't be
just LLVM in this case, there should be a way to opt-out from libbfd as
well, which was problematic for other reasons in the first place, and
probably some mechanism to tell whether to use libbfd or LLVM for the
disassembler when the two are available on the machine.

Quentin
