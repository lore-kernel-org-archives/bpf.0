Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B6A46546
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 14:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711117005; cv=none; b=g2C9lbvRZ4C0GRfNj1LPefYOtWgSREzOhq2y8mtU57k7lc/qzVxxNotjIySNfx8ubFzqrAbm+PDuXdVBML0M5UowQ2No0jbRzfFbqDjCOJGY3BckXy3RcryGesC+HWlHfPZjXkT0LgaQwNej+Gzed978jKo8H8D07fFuJbkNPpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711117005; c=relaxed/simple;
	bh=dM534EfADE62EAcMXvCsJRoLZE9hVMXHRQyZjYiLvw8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KHjWUIoFSacSQLBZocpH6e4VTTC07kQwlTr7OxUVWODzlohjXEyQoMLfByqiwPS4OBpmY0llPPyQJ6/iIZgyULF4jX/xoFYAtioQCUteuotcQ/rg+FjUCe1ySIxc+TeYadDTWYubpjAY+HtLx8Pq4Cd7gRPcTAaNezvFzwTk4To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ag92MdLy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ag92MdLy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812C4C433C7;
	Fri, 22 Mar 2024 14:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711117004;
	bh=dM534EfADE62EAcMXvCsJRoLZE9hVMXHRQyZjYiLvw8=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=ag92MdLyyOQNAaZLhV6YKidgdu3I4Boy6Xp1f+QzwKDtsTzNlShcEOHvGwspJvGeO
	 ay6r0wGTbW3+EK3MB4ceWR1TojfK5l5DwtdrqhjCCVT76hIML0ES8X/H2pp4K5L6+4
	 lvgc/bD0WXIdFH7eAAdDTZKvEvjsO4JxbBvX63URlbnaEdplkJTUUKPzpZErxX2Pel
	 NwrbcIuHfCJoE+A0CpFW89hFY03MUV9k+2PPfEvBu9uJ8C8CC0fkbInuI6tgXqBSvl
	 f5xz8E32b3FNtFbncrpqqlK7/vy0mtr0DBKpQJW+Hjbb+RRHHAj/obLaj/iYPL0g+O
	 fzCZ7ld1ynNbg==
Message-ID: <c54b3f13-dbdd-4988-9bd0-62679fbbd448@kernel.org>
Date: Fri, 22 Mar 2024 14:16:39 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf-next] bpftool: Clean up HOST_CFLAGS, HOST_LDFLAGS for
 bootstrap bpftool
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 bpf@vger.kernel.org, Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20240320014103.45641-1-qmo@kernel.org> <ZfqjiFeHmLoIO-rS@krava>
 <CAEf4BzYFC_RMW01mLcehrZ4G64R_uQm9-xj3HLKyC7Z0nX+dYw@mail.gmail.com>
Content-Language: en-GB
In-Reply-To: <CAEf4BzYFC_RMW01mLcehrZ4G64R_uQm9-xj3HLKyC7Z0nX+dYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2024-03-21 18:55 UTC+0000 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Wed, Mar 20, 2024 at 1:51 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>>
>> On Wed, Mar 20, 2024 at 01:41:03AM +0000, Quentin Monnet wrote:
>>> Bpftool's Makefile uses $(HOST_CFLAGS) to build the bootstrap version of
>>> bpftool, in order to pick the flags for the host (where we run the
>>> bootstrap version) and not for the target system (where we plan to run
>>> the full bpftool binary). But we pass too much information through this
>>> variable.
>>>
>>> In particular, we set HOST_CFLAGS by copying most of the $(CFLAGS); but
>>> we do this after the feature detection for bpftool, which means that
>>> $(CFLAGS), hence $(HOST_CFLAGS), contain all macro definitions for using
>>> the different optional features. For example, -DHAVE_LLVM_SUPPORT may be
>>> passed to the $(HOST_CFLAGS), even though the LLVM disassembler is not
>>> used in the bootstrap version, and the related library may even be
>>> missing for the host architecture.
>>>
>>> A similar thing happens with the $(LDFLAGS), that we use unchanged for
>>> linking the bootstrap version even though they may contains flags to
>>> link against additional libraries.
>>>
>>> To address the $(HOST_CFLAGS) issue, we move the definition of
>>> $(HOST_CFLAGS) earlier in the Makefile, before the $(CFLAGS) update
>>> resulting from the feature probing - none of which being relevant to the
>>> bootstrap version. To clean up the $(LDFLAGS) for the bootstrap version,
>>> we introduce a dedicated $(HOST_LDFLAGS) variable that we base on
>>> $(LDFLAGS), before the feature probing as well.
>>>
>>> On my setup, the following macro and libraries are removed from the
>>> compiler invocation to build bpftool after this patch:
>>>
>>>   -DUSE_LIBCAP
>>>   -DHAVE_LLVM_SUPPORT
>>>   -I/usr/lib/llvm-17/include
>>>   -D_GNU_SOURCE
>>>   -D__STDC_CONSTANT_MACROS
>>>   -D__STDC_FORMAT_MACROS
>>>   -D__STDC_LIMIT_MACROS
>>>   -lLLVM-17
>>>   -L/usr/lib/llvm-17/lib
>>>
>>> Another advantage of cleaning up these flags is that displaying
>>> available features with "bpftool version" becomes more accurate for the
>>> bootstrap bpftool, and no longer reflects the features detected (and
>>> available only) for the final binary.
>>>
>>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>> Signed-off-by: Quentin Monnet <qmo@kernel.org>
>>
>> got some fuzz when applying it, but other than that lgtm
>>
>> Acked-by: Jiri Olsa <jolsa@kernel.org>
>>
> 
> this was applied, but PW bot didn't notice it. I marked it as accepted
> in patchworks, just FYI.

Thanks for the notice!
Quentin
