Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C1422ACFA
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 22:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785710476; cv=none; b=MoqEYIee0G5w0nFc0LvuxmHbM3fojjlidS+GshJN/SSvpmt/EDiaTrK1sHPIq6hxqOjojijhq/4dxSdCa8PFmys3srdYvaeC0nv6BP02hHKVQfyrRJZauonXxL/XdZ8ls+/FfdqHhVNy6LeaYMImh4dXRihlKoUteAGufZex5pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785710476; c=relaxed/simple;
	bh=SgUymoBlhuDuXFAQ7He6FfGYxYy29GI6S1Ybw7CX9TQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lmaRxX2g0bguaWBPctEhp+g9AdYqWum2JhiAGw6AEyr/sUO143bZfeq7Uo1nOCFw6q2FS4cML8ppr/Nbuc5KLSj4LAc8kl8Qzq5EN+LecRLekyxbSx+hOensTEb3PWRkA2n2UOyrj8gmgXXOpOL/Pa8faLTML229ZNGm1VnZWtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoZKAXTm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoZKAXTm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9638C1F00A3A;
	Sun,  2 Aug 2026 22:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785710474;
	bh=Ewpws/G+IGLtwBzYcAausDrvvHEZMVGFD+Bt/3M1wHw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UoZKAXTmRaXoaOgtsGv/kv87CHh/6g7yOm37/QtZFs6X0VHrpFlpii5HilXQc4n7F
	 OqfOqduQFgl1xKNvHqbHIjQ2fPE8HM78flNh1rQeLhnsrjyXePoSUfKEHE/1S8Re6e
	 HmV+5/b5rdR0WqbbFq2/94lpOtHL0MqF03ZrpeLRMuB5KgeeLxFWcojT8RLbJCQu2i
	 WPD10yr6r3CdKYz+a4mJVTvTjH8xHLDBMBU1xtau3/nl/PCar3zif86Rf53NWcYQ+A
	 ilESAawVWcoKhwyHkL+XNIJzBRqU5R1LlenSExPNJ/OTzopmfK7qjgoBt1PKJwbNiE
	 0DdWTRh9Tqw0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5A0D23809A3D;
	Sun,  2 Aug 2026 22:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 00/18] Generate bpf_func_proto for kfunc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178571043614.1504719.8056919816890329289.git-patchwork-notify@kernel.org>
Date: Sun, 02 Aug 2026 22:40:36 +0000
References: <20260801074633.1595644-1-ameryhung@gmail.com>
In-Reply-To: <20260801074633.1595644-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Sat,  1 Aug 2026 00:46:15 -0700 you wrote:
> Hi,
> 
> This is the second of three patch sets to unify kfunc and helper
> argument verification. It:
> 
>   1) further aligns the kfunc and helper argument checks,
>   2) makes kfunc argument type classification depend solely on BTF, and
>   3) generates a bpf_func_proto for each kfunc.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,01/18] bpf: Drop process_timer_func wrappers
    https://git.kernel.org/bpf/bpf-next/c/70a841617aa8
  - [bpf-next,v3,02/18] bpf: Unify const map ptr argument checking for helpers and kfuncs
    https://git.kernel.org/bpf/bpf-next/c/b33d09b4d914
  - [bpf-next,v3,03/18] bpf: Split kfunc map argument into __const_map and __map
    https://git.kernel.org/bpf/bpf-next/c/c82b998777b7
  - [bpf-next,v3,04/18] bpf: Pass kfunc meta to mem and mem_size check
    https://git.kernel.org/bpf/bpf-next/c/9f52714dd89b
  - [bpf-next,v3,05/18] bpf: Resolve map lookup result type at lookup time
    https://git.kernel.org/bpf/bpf-next/c/341d227fa5db
  - [bpf-next,v3,06/18] bpf: Check helper and kfunc mem+size arguments identically
    https://git.kernel.org/bpf/bpf-next/c/d4e7fb59c0d4
  - [bpf-next,v3,07/18] selftests/bpf: Test map lookup result refinement
    https://git.kernel.org/bpf/bpf-next/c/e6d200dd1026
  - [bpf-next,v3,08/18] bpf: Check fixed-size mem args of helpers and kfuncs the same way
    https://git.kernel.org/bpf/bpf-next/c/e566701b9b0c
  - [bpf-next,v3,09/18] bpf: Rename ARG_CONST_SIZE{,_OR_ZERO} to ARG_MEM_SIZE{,_OR_ZERO}
    https://git.kernel.org/bpf/bpf-next/c/c0e091f30f0d
  - [bpf-next,v3,10/18] bpf: Fold __szk const size handling into the scalar arg path
    https://git.kernel.org/bpf/bpf-next/c/f16e80c2c451
  - [bpf-next,v3,11/18] selftests/bpf: Test __szk precision with a NULL nullable buffer
    https://git.kernel.org/bpf/bpf-next/c/f88caee62e45
  - [bpf-next,v3,12/18] bpf: Classify kfunc mem_size args from BTF without register state
    https://git.kernel.org/bpf/bpf-next/c/ea5ab2389801
  - [bpf-next,v3,13/18] bpf: Handle NULL kfunc pointer args without a KF_ARG_PTR_TO_NULL type
    https://git.kernel.org/bpf/bpf-next/c/76fb08750481
  - [bpf-next,v3,14/18] bpf: Distinguish fixed- and variable-size kfunc mem args with MEM_FIXED_SIZE
    https://git.kernel.org/bpf/bpf-next/c/90990ee10be8
  - [bpf-next,v3,15/18] bpf: Classify kfunc pointer arguments from BTF, resolve type against the register
    https://git.kernel.org/bpf/bpf-next/c/c9e995ba0d11
  - [bpf-next,v3,16/18] bpf: Tag nullable kfunc pointer args with PTR_MAYBE_NULL
    https://git.kernel.org/bpf/bpf-next/c/ba5b99470c40
  - [bpf-next,v3,17/18] bpf: Classify scalar kfunc arguments from BTF
    https://git.kernel.org/bpf/bpf-next/c/1690dcf27c73
  - [bpf-next,v3,18/18] bpf: Generate kfunc argument prototype at add-call time
    https://git.kernel.org/bpf/bpf-next/c/a49b70400b9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


