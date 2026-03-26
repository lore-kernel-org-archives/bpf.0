Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79DF3375AE
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 22:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774562808; cv=none; b=LXvLoloqY1qUfeW490wPmFo+g90HatEHgi30A7KrfXhBOPjW4AY92sK+Q97nOfT2l+1ed2u8Yrm4FVotRP9KzVRW1qzuU8O65k9ez1yHvYISyAH4ZVBiEmp5kVH8IW9JD7keweMVzqnvP/1pL4JewUcNgUYDhvRhcahcZCiTDXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774562808; c=relaxed/simple;
	bh=VHcxuzCD6goD5XgHUp8HZt3sVRcSxxWJZeFmpBM71Qo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IYrXAuEDoUQ4o/fT1sRTBtk4EeLZTcPp/P0U0VnxaGpXrtq/jFiRJiXbinuyFrwKbsmG6f/fR0fpEjHyiZePQzIYaryDTb4zX8DE24WhP8R9XbKetQKIaeXoUZ+jTO24bYb53nhHcvgKBhD1eeCNRKCynmiN9HEcJUCfTyfh14w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dvzw7op5; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dvzw7op5"
Message-ID: <e0ca748d-3204-4160-b37d-0f76cbac8c6c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774562795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ap4HZuU3Kp/MebHLlBMt2MHPRPf8GdkWOr2FuBBdAdU=;
	b=Dvzw7op5c5X6VP5abajNjvoHkIBJxJAk2lEJ2Li2ge9tGe5TSNF4qSaJEHnCf2tfm2yunU
	B44Q4XghGrB5JB1dEYr4rEDjchocp6YetnTDiU9SclLTdxbAwpgfdOEPlJalxX4Y07vpys
	wPX98H7qZLiOX8iAYf1WNC2Y0kW/9GE=
Date: Thu, 26 Mar 2026 15:06:28 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] docs: Document pahole v1.26 requirement for
 KF_IMPLICIT_ARGS kfuncs
To: zhidao su <soolaugust@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, Tejun Heo <tj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, bpf@vger.kernel.org
References: <20260324062028.2479059-1-suzhidao@xiaomi.com>
 <CAADnVQLbtuD=7mtGZFR25ULhjZ-3ifBpkyRcqu9jPSd2Mt3fBw@mail.gmail.com>
 <69c2dbe8.170a0220.226f48.721e@mx.google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <69c2dbe8.170a0220.226f48.721e@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/24/26 11:46 AM, zhidao su wrote:
> On Tue, 24 Mar 2026 08:12:12 -0700, Alexei Starovoitov wrote:
>> I don't think that's true.
>> At least when implicit args were designed the goal was to avoid
>> pahole dependencies.
>> Please share exact steps to reproduce.
> 
> Here are the exact reproduction steps and code path analysis.

Hi everyone, sorry I'm late to the party.

First of all, a *Nack* to the doc change in isolation, I agree with
Alexei here. Tejun, I suggest to revert it.

Doc change is insufficient and will make things only more confusing.

Kconfig checks for pahole version, as well as Makefile.btf. If we set
a new minimum version then it makes sense to assume it in the kernel
build code, and *disable CONFIG_DEBUG_INFO_BTF* if the version is not
recent enough. Also remove any flags/conditions that depend on pahole
being less than target minimum version. For reference see a patch
where I bumped the minimum version to 1.22 (903922cfa0e6):
https://lore.kernel.org/bpf/20251219181825.1289460-1-ihor.solodrai@linux.dev/

More importantly, the reported problem is real, but the actual fix is
a bump to v1.27, not v1.26. As usual AI got it about 80% right in the
analysis below (I assume this is AI output, it certainly looks like
one). Although to be fair AI was misled by a human error.

> 
> Reproduction (Ubuntu 24.04, pahole v1.25):
> 
>   $ git clone https://github.com/sched-ext/sched_ext.git
>   $ cd sched_ext && make -j$(nproc) LOCALVERSION=-test
>   $ make -C tools/testing/selftests/sched_ext
>   $ vng --run arch/x86/boot/bzImage --cpus 4 --memory 4G -- \
>       tools/testing/selftests/sched_ext/build/runner 2>&1 | grep "func_proto"
> 
> Result: 23/30 tests fail with:
>   libbpf: extern (func ksym) 'scx_bpf_create_dsq': func_proto [382]
>           incompatible with vmlinux [53813]

This is indeed an error you may get if BTF for kfuncs with
KF_IMPLICIT_ARGS is wrong.

> 
> Root cause:
> 
> The KF_IMPLICIT_ARGS mechanism requires pahole v1.26 for the DECL_TAG
> generation step that enables resolve_btfids to do its btf2btf work:
> 
> 1. scripts/Makefile.btf gates decl_tag_kfuncs on pahole >= 1.26:
> 
>      pahole-flags-$(call test-ge, $(pahole-ver), 126) = ... decl_tag_kfuncs

This is correct in that resolve_btfids expects that pahole ran with
decl_tag_kfuncs, but the version check is and was wrong.

decl_tag_kfuncs was implemented in pahole commit 72e88f29c [1], which
was released in v1.27. But on the kernel build side, the new feature
was simply appended (ebb79e96f1ea [2]) to the list of features under
1.26 check.

[1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=72e88f29c6f7e14201756e65bd66157427a61aaf
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v7.0-rc5&id=ebb79e96f1ea454fbcc8fe27dfe44e751bd74b4b

> 
> 2. Without decl_tag_kfuncs, pahole does not emit DECL_TAG BTF entries
>    for __bpf_kfunc-annotated functions.
> 
> 3. resolve_btfids/main.c::collect_kfuncs() (line 1002) early-returns
>    when nr_decl_tags == 0:
> 
>      if (!link->nr_decl_tags)
>          return 0;
> 
> 4. With no bpf_kfunc DECL_TAGs, btf2btf() never calls
>    process_kfunc_with_implicit_args() to create _impl variants and
>    strip 'aux' from the original proto.
> 
> 5. Result: vmlinux retains the 3-param proto (with 'aux') for all
>    KF_IMPLICIT_ARGS kfuncs.
> 
> BTF evidence from our pahole v1.25-compiled vmlinux:
> 
>   $ bpftool btf dump file vmlinux | grep -A5 '[53813]'
>   [53813] FUNC_PROTO '(anon)' ret_type_id=... vlen=3
>       'dsq_id' type_id=...
>       'node'   type_id=...
>       'aux'    type_id=...    <-- implicit arg still present, 3-param
>   (no scx_bpf_create_dsq_impl exists)

So far so good.

> 
> With pahole v1.26, resolve_btfids creates scx_bpf_create_dsq_impl
> (3-param, for verifier's find_kfunc_impl_proto) and rewrites
> scx_bpf_create_dsq to 2-param (for libbpf ksym matching).

And this is bullshit. The kernel build with pahole v1.26 has the same
problem:

  # Notice that 'bpf_wq_set_callback_impl' is absent from BTF
  $ bpftool btf dump file vmlinux | grep 'bpf_wq_set'
  [63890] FUNC 'bpf_wq_set_callback' type_id=9991 linkage=static
          'KF_bpf_wq_set_callback' val=29

vs expected (v1.27, v1.31):

  $ bpftool btf dump vmlinux | grep 'bpf_wq_set'
  [64253] FUNC 'bpf_wq_set_callback' type_id=51033 linkage=static
  [64254] FUNC 'bpf_wq_set_callback_impl' type_id=34861 linkage=static
          'KF_bpf_wq_set_callback' val=29

One could've figured this out if they tried to actually run the build.

> 
> You're right that the design goal was to avoid pahole dependencies -
> the implementation could be fixed in resolve_btfids to handle the
> no-DECL_TAG case. But until such a fix lands, the dependency exists
> in practice. Jonathan Corbet suggested raising the minimum version in
> the requirements table to 1.26, which seems the cleanest fix.
> 
> Signed-off-by: zhidao su <suzhidao@xiaomi.com>


zhidao su, I suggest you prepare a proper "minimum pahole version
bump" patch, modifying kconfig checks, Makefile.btf and the
documentation. Please route it through the BPF tree and add me to cc.

Thanks.


