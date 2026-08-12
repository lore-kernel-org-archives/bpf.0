Received: from mta1.migadu.com (out-63.mta1.migadu.com [95.215.58.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DDE48CD7E
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786574361; cv=none; b=ZBG49m85ROt+bvNHmJOJOoR3hIb5yzSviPgxA9gBed+FycKPSgE+rfJJIYXL40bdd1T+T+gSoEKPC3MHUSyNDhkQ9offa2eJjRV2oqoaFJgvCx4RQbkIgJhm4XPFS0xxqVbB1G93zfSaDpphUdqpy1pAkvQaL0MNwZb5Mc/6Gf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786574361; c=relaxed/simple;
	bh=CA//ApKPRdiszCZwXe606biRwkb+GkzqfsMkcoiO8js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EpzY6jVQ0SrXtzWWf7oeK+lFbcgM+DB8bpCrNl+FBXSyH72j3VivwcH2X4Wjo/j5nz/FGVNEkhCzFcsvbyyzMUqfkh0gBMiBBL61H7yPC0hbsxq/BrpC0G5MAQYv+o0pGVWATHrHEB0H7sKe2tPOOZ1xCflJJ6NLlNsc6mQjT4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I4cfnJEH; arc=none smtp.client-ip=95.215.58.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I4cfnJEH"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CA//ApKPRdiszCZwXe606biRwkb+GkzqfsMkcoiO8js=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786574357; v=1; x=1787179157;
 b=I4cfnJEHuu1LZ1owzlWUxcwPTHDwIyh5BEduO20tLacD1bZ8yhcQ/IsuYXh0XfRMt5MOM8fY
 VoF+roNBdcwFBZxC7qLXn7CauVDWxSI5oM1ixzG+Z+/QZVyW76p6tsRJXdl5vpVYwDmwQZZZyib
 6grTb13N5qRobHU8m7ti6RMs=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:125c:1:c4d4:5d0:c3b3:cab6] (2620:10d:c090:500::5:f7a3)
	by smtp.migadu.com with ESMTPS id a9eef6517d78ad5d;
	Wed, 12 Aug 2026 22:39:16 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <3903c659-6378-4849-8bc4-8c1937e4bb9e@linux.dev>
Date: Wed, 12 Aug 2026 15:39:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 0/2] Add resolve_btfids support for __arena
 kfunc suffix
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 Tejun Heo <tj@kernel.org>, kkd@meta.com, kernel-team@meta.com
References: <20260812193842.2879226-1-memxor@gmail.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260812193842.2879226-1-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/26 12:38 PM, Kumar Kartikeya Dwivedi wrote:
> Use __arena/__arena__nullable suffixes to emit address_space(1)
> annotations on kfunc definitions in vmlinux.h. See commits for details.
> 
> Changelog:
> ----------
> v1 -> v2
> v1: https://lore.kernel.org/bpf/20260809085155.3305519-1-memxor@gmail.com
> 
>  * Avoid enumerating all the ways resolve_btfids can emit the
>    "address_space(1)" attribute in its header comment and in kfuncs.rst.
>    (Ihor)
>  * Drop the kfunc_has_arena_arg() helper: add_arena_tagged_proto()
>    returns the original prototype when nothing needs tagging, so it can
>    be invoked unconditionally for every kfunc. (Ihor)
>  * Add resolve_btfids selftest cases with mixed tagged and untagged
>    arguments, and a kfunc that combines the KF_ARENA_RET flag with
>    suffixed arena arguments. (Ihor)

For the series:

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Thanks!

> 
> Kumar Kartikeya Dwivedi (2):
>   resolve_btfids: Emit arena attributes from kfunc parameter suffixes
>   selftests/bpf: Test resolve_btfids arena argument suffixes
> 
>  Documentation/bpf/kfuncs.rst                  |  4 +-
>  tools/bpf/resolve_btfids/main.c               | 72 +++++++++++++------
>  .../selftests/bpf/prog_tests/resolve_btfids.c | 41 ++++++-----
>  tools/testing/selftests/bpf/progs/btf_data.c  | 20 ++++++
>  4 files changed, 99 insertions(+), 38 deletions(-)
> 
> 
> base-commit: 3a59f11e0f989bdd637c87151992605a6559a7cb

