Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D3A257452;
	Sun,  7 Jun 2026 18:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780856449; cv=none; b=SkTevKE1oyQGeYq7mnStbxDWDum2GUV8YGk3HEtW3luXHweQYIrEMAFN+OBofMRo1FsKkUnqBYz5F8T1ATfM/KxRV1Wd9Mf9fCmVaSE1FCKSe7v20om6nmBPdJJVbv5JXuYcNI3AL+IvaJGaP2PeVIX1fj28wPYg1njKVgfq+nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780856449; c=relaxed/simple;
	bh=0F7DPyToee3xO+cKZrrCkbxswMZT4eDHVs/NfLhcOJo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PlwVxKUFX0BxD7pA+zQ1HSIfVijmSRtl1dOxunXLVS4gYynMIBf6+lsRdMrwcsYOv/Zm7MDYsosZ1rEQFSRif5xzIle6QmCasS0dymIaAYDJs27hXptUDUcbx0QhCaTqLF9NqmKab5/IN3i+o5ZjGJdBLrq1Q4/CEmh9dujlhrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pc1rHFo2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pc1rHFo2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882B81F00893;
	Sun,  7 Jun 2026 18:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780856448;
	bh=LYCNRsaLfbFMffqYd6MxAbma/hVOtG8OurYIyF1tJmw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Pc1rHFo2SDrAhZn3HBZkK8vgwzDTmV1eAZdZcbLp960AohVprE9SpRntm3DY6HBcB
	 LZoMvnMfeRQw0Lce9AeQENoid75dUyNBT7Dh78KetoFhCvGOHi9VuiKgvlhuPdg7lE
	 Lj0A3yrlXG2p1HWw3+vaeXlpDJJOiSeMxvhf8FErpkuOoGUYvmeEKL6rgGYgSjaYSV
	 5FAO96sNGBzRZfaAqfjrbBT+p4QJYDMNKHNZaHA0j8l5OWjtp3x5/YrV+nBD6u59Y0
	 s313vUpwwRLLtvtAGT9xn6/rhezOZ5A2TzxlVe78AYz5LcyWTbS+nyBFUQjD0JbZ4C
	 BZCy5TPc8C15Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199833930C97;
	Sun,  7 Jun 2026 18:20:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv8 bpf-next 00/29] bpf: tracing_multi link
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178085644764.273544.8250000589480262551.git-patchwork-notify@kernel.org>
Date: Sun, 07 Jun 2026 18:20:47 +0000
References: <20260606123955.345967-1-jolsa@kernel.org>
In-Reply-To: <20260606123955.345967-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 hengqi.chen@gmail.com, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 songliubraving@fb.com, yhs@fb.com, menglong8.dong@gmail.com,
 rostedt@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat,  6 Jun 2026 14:39:25 +0200 you wrote:
> hi,
> adding tracing_multi link support that allows fast attachment
> of tracing program to many functions.
> 
> RFC: https://lore.kernel.org/bpf/20260203093819.2105105-1-jolsa@kernel.org/
> v1: https://lore.kernel.org/bpf/20260220100649.628307-1-jolsa@kernel.org/
> v2: https://lore.kernel.org/bpf/20260304222141.497203-1-jolsa@kernel.org/
> v3: https://lore.kernel.org/bpf/20260316075138.465430-1-jolsa@kernel.org/
> v4: https://lore.kernel.org/bpf/20260324081846.2334094-1-jolsa@kernel.org/
> v5: https://lore.kernel.org/bpf/20260417192502.194548-1-jolsa@kernel.org/
> v6: https://lore.kernel.org/bpf/20260527113951.46265-1-jolsa@kernel.org/
> v7: https://lore.kernel.org/bpf/20260603110554.29590-1-jolsa@kernel.org/
> 
> [...]

Here is the summary with links:
  - [PATCHv8,bpf-next,01/29] ftrace: Add ftrace_hash_count function
    https://git.kernel.org/bpf/bpf-next/c/e57f13eaab25
  - [PATCHv8,bpf-next,02/29] ftrace: Add ftrace_hash_remove function
    https://git.kernel.org/bpf/bpf-next/c/af7c32365090
  - [PATCHv8,bpf-next,03/29] ftrace: Add add_ftrace_hash_entry function
    https://git.kernel.org/bpf/bpf-next/c/2cd298c106e0
  - [PATCHv8,bpf-next,04/29] bpf: Use mutex lock pool for bpf trampolines
    https://git.kernel.org/bpf/bpf-next/c/e6abd4cd157b
  - [PATCHv8,bpf-next,05/29] bpf: Add struct bpf_trampoline_ops object
    https://git.kernel.org/bpf/bpf-next/c/8a35e8db740f
  - [PATCHv8,bpf-next,06/29] bpf: Move trampoline image setup into bpf_trampoline_ops callbacks
    https://git.kernel.org/bpf/bpf-next/c/bf4bc3e11c41
  - [PATCHv8,bpf-next,07/29] bpf: Add bpf_trampoline_add/remove_prog functions
    https://git.kernel.org/bpf/bpf-next/c/e6cc9ed677e6
  - [PATCHv8,bpf-next,08/29] bpf: Add struct bpf_tramp_node object
    https://git.kernel.org/bpf/bpf-next/c/65499074efaf
  - [PATCHv8,bpf-next,09/29] bpf: Factor fsession link to use struct bpf_tramp_node
    https://git.kernel.org/bpf/bpf-next/c/880db5d4abb2
  - [PATCHv8,bpf-next,10/29] bpf: Add multi tracing attach types
    https://git.kernel.org/bpf/bpf-next/c/d14e6b4346bf
  - [PATCHv8,bpf-next,11/29] bpf: Move sleepable verification code to btf_id_allow_sleepable
    https://git.kernel.org/bpf/bpf-next/c/bd06659d3b8a
  - [PATCHv8,bpf-next,12/29] bpf: Add bpf_trampoline_multi_attach/detach functions
    https://git.kernel.org/bpf/bpf-next/c/aef4dfa790b2
  - [PATCHv8,bpf-next,13/29] bpf: Add support for tracing multi link
    https://git.kernel.org/bpf/bpf-next/c/c1d32dea5d46
  - [PATCHv8,bpf-next,14/29] bpf: Add support for tracing_multi link cookies
    https://git.kernel.org/bpf/bpf-next/c/46b42af27d40
  - [PATCHv8,bpf-next,15/29] bpf: Add support for tracing_multi link session
    https://git.kernel.org/bpf/bpf-next/c/ba042ed6446f
  - [PATCHv8,bpf-next,16/29] bpf: Add support for tracing_multi link fdinfo
    https://git.kernel.org/bpf/bpf-next/c/8abecdafd575
  - [PATCHv8,bpf-next,17/29] libbpf: Add bpf_object_cleanup_btf function
    https://git.kernel.org/bpf/bpf-next/c/fe9c8cb2b52b
  - [PATCHv8,bpf-next,18/29] libbpf: Add bpf_link_create support for tracing_multi link
    https://git.kernel.org/bpf/bpf-next/c/630e85a9f005
  - [PATCHv8,bpf-next,19/29] libbpf: Add btf_type_is_traceable_func function
    https://git.kernel.org/bpf/bpf-next/c/616a93b473a6
  - [PATCHv8,bpf-next,20/29] libbpf: Add support to create tracing multi link
    https://git.kernel.org/bpf/bpf-next/c/f2aa370dfe57
  - [PATCHv8,bpf-next,21/29] selftests/bpf: Add tracing multi skel/pattern/ids attach tests
    https://git.kernel.org/bpf/bpf-next/c/2922dd58413c
  - [PATCHv8,bpf-next,22/29] selftests/bpf: Add tracing multi skel/pattern/ids module attach tests
    https://git.kernel.org/bpf/bpf-next/c/2863f074f146
  - [PATCHv8,bpf-next,23/29] selftests/bpf: Add tracing multi intersect tests
    https://git.kernel.org/bpf/bpf-next/c/4309f580a0a6
  - [PATCHv8,bpf-next,24/29] selftests/bpf: Add tracing multi cookies test
    https://git.kernel.org/bpf/bpf-next/c/1b938f42f5fa
  - [PATCHv8,bpf-next,25/29] selftests/bpf: Add tracing multi session test
    https://git.kernel.org/bpf/bpf-next/c/69f25d4b0c17
  - [PATCHv8,bpf-next,26/29] selftests/bpf: Add tracing multi attach fails test
    https://git.kernel.org/bpf/bpf-next/c/1fd832854997
  - [PATCHv8,bpf-next,27/29] selftests/bpf: Add tracing multi verifier fails test
    https://git.kernel.org/bpf/bpf-next/c/443c91d08c4b
  - [PATCHv8,bpf-next,28/29] selftests/bpf: Add tracing multi attach benchmark test
    (no matching commit)
  - [PATCHv8,bpf-next,29/29] selftests/bpf: Add tracing multi attach rollback tests
    https://git.kernel.org/bpf/bpf-next/c/b349efe49a12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


