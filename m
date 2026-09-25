Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEC34AD7DC;
	Fri, 25 Sep 2026 20:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790367672; cv=none; b=E3QepVks7Bhzeuvu9Ca6S8+UnTxbYlM8J4574FUhfZMqTeSk5wYD9Dk15FAhDvT7YGpVynYa90pqzR6qJLMDqgu5xuUCywCPVQbvKGkbDNxanq3Io0QD6ShfOwhjjXHJrUTpi+qOvFljKyz927f/ZxAX4rAhfJwpHvwi/r48+Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790367672; c=relaxed/simple;
	bh=VL1kdqUsEBfQB1cOxXTLekwiK2vjR8EsvNrPQF12+yY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gKtMMz5fajX2z9NwkjINmGfzpu5GvvsxAOFIB8jBhDqt2m6GMYYejog03nhjdzkL1IMXF43zJeqTJru8ULbsZZQsPW3elCB4F/2ZkmUYCaQaMqMt0xx6b1XG7fL2LYyBE7dS1snGfvAszmYF60EYRmQAXPgtkApXaghfANSJ8W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acvS+Dm6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acvS+Dm6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012251F00893;
	Fri, 25 Sep 2026 20:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790367671;
	bh=vwUXydKxcZzPhrlocpBNFWxFF1A04M//+XOOIX6v3gk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=acvS+Dm6zwVTwI2t3anAp51kvB47qRoYL3+fUAQemUJ8kgVmGWUWnzwx6/z2ksObN
	 LRxSk8J60b0LOtcCtAXwAwSWv75y/eEF7VLGgFtHs2N1HtJ0LXKkXhYUQjwk+lDFRU
	 AlxFOkxVxGJL4Mf3HT7AOj9n1xPq/e/p10yIjkpWcE1hfP5ykyrT0RX29/4Rx2FUdh
	 IS9rj+X12SiE8OviqcBz8rhWX64gQXSLvQRNAjZ1GreKevL4i3xgQXOwJDrkCabwuy
	 oHniMFogF/FTZSYzEwhT9nTCxy8jDbYNBdXAZo012PRvGT5lfsaGhY6oIMt7ki//y2
	 X77FfA2bo/18g==
Message-ID: <43549d30-0f47-46a2-a60f-fb6f252e6738@kernel.org>
Date: Fri, 25 Sep 2026 21:21:08 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 1/2] bpftool: Add recursive map dumping
To: Tianyi Chen <hi@tychen.cc>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 linux-kselftest@vger.kernel.org
References: <20260925174402.2028649-1-hi@tychen.cc>
 <20260925174402.2028649-2-hi@tychen.cc>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260925174402.2028649-2-hi@tychen.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-09-26 02:44 UTC+0900 ~ Tianyi Chen <hi@tychen.cc>
> Dumping a map-of-maps currently shows inner map IDs without their
> contents. Add a recursive keyword to map dump to include referenced
> inner maps, leaving the default output unchanged. Show selected maps
> followed by distinct inner maps, preserving plain and BTF formatting
> and using an array of map objects for JSON output.
> 
> Holding every discovered inner-map FD open would make descriptor use
> grow with the number of maps and could exhaust RLIMIT_NOFILE. Keep the
> selected map FDs open, queue distinct inner map IDs, and open, dump and
> close each queued map in turn. This needs only one additional map FD.
> The tradeoff is deferred ID resolution: concurrently removed inner
> maps can disappear before they are opened, so the dump is not atomic.
> 
> Report failure when an inner map cannot be opened, retain per-entry
> lookup errors, and close JSON containers before returning.
> 
> Link: https://github.com/libbpf/bpftool/issues/58
> Assisted-by: LLM
> Signed-off-by: Tianyi Chen <hi@tychen.cc>
> ---
>  .../bpf/bpftool/Documentation/bpftool-map.rst |  15 +-
>  tools/bpf/bpftool/bash-completion/bpftool     |   3 +
>  tools/bpf/bpftool/map.c                       | 147 ++++++++++++++++--
>  3 files changed, 151 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> index e4ed7e701c9e..0b804926d829 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> @@ -16,7 +16,8 @@ SYNOPSIS
>  
>  **bpftool** [*OPTIONS*] **map** *COMMAND*
>  
> -*OPTIONS* := { |COMMON_OPTIONS| | { **-f** | **--bpffs** } | { **-n** | **--nomount** } }
> +*OPTIONS* := { |COMMON_OPTIONS| |
> +{ **-f** | **--bpffs** } | { **-n** | **--nomount** } }


This hunk is no longer necessary now that we use a keyword rather than
an option, please drop the rewrap.

Looks mostly good otherwise, but Sashiko's finding seems correct, so
please look into it.

Thanks,
Quentin
