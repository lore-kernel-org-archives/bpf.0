Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D69D3932FF
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 07:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066864; cv=none; b=kVAzA40BlOEZLcy/ebhoEf7tMdKG1rT/ERvWku0cqPAUNyI2dSoHuhfy9xTRmZ/6nYIk/Mhv0GXZNuprnA0QerklAHu/Y2WWvA/tLsXxI9BulzvAV1Ppc+Tx2vDmdTf4w73N0Li0hbuCg0AnpkXRRgHtz0BE3XssRUx4UeSuAAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066864; c=relaxed/simple;
	bh=orB0DgU4wxJRKiIe3DWuU3+rc1kYgBrsrLIu4o42Cv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZqOW5kmfa3uObcZvsnvLF9Q7QMlYNaQEnI9oIuB6YFF4fsao2J8IXeHDRXAmpGOHY/4X46rpMe8UGv0OboFExxwoPy3BfQHTmaBC71mBzoaveCuDIT7YKx144/6kcHnICynQ+Mk3NYKMmISXDLR0LqpPRcWr8QVsCNOvijStI88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N+B9oLmM; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N+B9oLmM"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d17bb1c65so2646668f8f.0
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 00:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776066861; x=1776671661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6snTvocp4fL1cYl7s1+cy6ol2rfDxDg3UNIgS0nANoA=;
        b=N+B9oLmMVBzyOHuqyQK76nBsJAfpvmlEIEwt6xNZbGa+Fq3W8kiFOJiZ/3FJ5DHuDv
         2PRPmtobICFZmoq6Q4MPlpFLxoebKTM1STGK17oktf96mP9w4N6xrHPRu8c+nYzHaYVL
         r4Dsf2nQWGkBrLWPpw59N5w0mNSr/Gfcd4D+pcIWaczOoW4cWKqVPKjEUUAXE6j3sYgz
         +eFvw/vjPFwgUnuSRG7qD42ILVjjOq/Vy+b+MDBq2tdtyR9kKXETo01oJMS444Sg0uQd
         nCZf7KjfoOiVLbNsUJrp74A9d9SWu9pM0Ie+Ymom87ts8MMSgX7yUUuy8LIY9qR1jF3C
         d/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776066861; x=1776671661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6snTvocp4fL1cYl7s1+cy6ol2rfDxDg3UNIgS0nANoA=;
        b=DSNTmr8TbjPnORZw4r52C1EtU/wHPfio6RbkrpBVTtzqpF3GudKKGwnkMmiCNm4yiW
         uu7Wax/fbBIHWwsnlxyr1+BfgBA5VHEpSWq1ZSiekJtRxkjcKaCnosKOnLSN1K+Bm8bg
         NJAgsKZ2MWdM4oVwIeBP9tUvnunysgy3IwjGWv6Cnw3lBQyJiX9Ug2cRAaukUy9iQizw
         30f+bmCUAvxtDUt4Yrj6hPR0g1AULp+pZx7jqHfWdi8SyQcfbAdMI6gcEWwd3eq5ijl7
         nWpIhv4lPKp1S9n0aOBRalCyAORQls8nODA6EGbQm4E3+3IyjDZICh0YnbGXRhtDhV4H
         uBMw==
X-Forwarded-Encrypted: i=1; AFNElJ+j5MKa2Ns86YagtTSGhpk4KZEee/OnxSBlI83mDD2752LrXmUqF6maPi/DRmSGhlwQQsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNH7rsLkJe2ysn9CQs0ws+8V7VWMCDGkzxbt7C6lZQ94O0b7Lm
	uid/6JXMBuvaPUD5lHd0ENaS4NyiKSECRuzL52tJhPsQKdx9QWgog16uJe1jjJmf9EU=
X-Gm-Gg: AeBDietpsuWwKQL/1gjUr9GTu0/an4bieR0rIa1DeHqEthJ1qXa0zVOv2l+CbhiPRbV
	Voi1df+ox8xQGzdI5+R/xRJq37gX3tCdSb/6r8dgKmRcxpj50gVIjMRZ037wcQaR+QTCRiVbRio
	H2s/5p4sg8DLLJ+ID2qs50Cxo1J0lO+0FXOGwu2GqF45U7oCD//ak3wSqj+cPKOUGN71zvpWrqh
	WRHimT/kmsnt51uz0R0s7py8PdRqUs7bLedS3ot6JYYnidu8ovDsj49hNr2TlVZ7OMtPBTnRhgH
	0cumi9fUhV7Sl1RSOLbDMtQgAF/QJbsiLKOXWJWST4MQmEMEOfPE2PKYPQPa1F8YAh9cyp3I1CM
	1M1zaUwIPuK5Jwi/fZgcxa4ItpEyvT4gscrTQyviLUg91WdZ2jO/SpCrOdGGYy1j1HB3Y6K1xRw
	T3+1Aa8AVtF2uldtbRZ8sqHCCpOnKQCoGz4l+CjroWokTv
X-Received: by 2002:a5d:5849:0:b0:43d:7261:8759 with SMTP id ffacd0b85a97d-43d726187ccmr6706140f8f.28.1776066860612;
        Mon, 13 Apr 2026 00:54:20 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d76eeb2d1sm10959190f8f.22.2026.04.13.00.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 00:54:20 -0700 (PDT)
Message-ID: <a48e9d73-90b7-4108-b5a9-5619a5659556@suse.com>
Date: Mon, 13 Apr 2026 09:54:19 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kbuild/btf: Remove broken module relinking exclusion
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 Masahiro Yamada <masahiroy@kernel.org>, Sasha Levin <sashal@kernel.org>,
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260410131343.2519532-1-petr.pavlu@suse.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260410131343.2519532-1-petr.pavlu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/26 3:13 PM, Petr Pavlu wrote:
> Commit 5f9ae91f7c0d ("kbuild: Build kernel module BTFs if BTF is enabled
> and pahole supports it") in 2020 introduced CONFIG_DEBUG_INFO_BTF_MODULES
> to enable generation of split BTF for kernel modules. This change required
> the %.ko Makefile rule to additionally depend on vmlinux, which is used as
> a base for deduplication. The regular ld_ko_o command executed by the rule
> was then modified to be skipped if only vmlinux changes. This was done by
> introducing a new if_changed_except command and updating the original call
> to '+$(call if_changed_except,ld_ko_o,vmlinux)'.
> 
> Later, commit 214c0eea43b2 ("kbuild: add $(objtree)/ prefix to some
> in-kernel build artifacts") in 2024 updated the rule's reference to vmlinux
> from 'vmlinux' to '$(objtree)/vmlinux'. This accidentally broke the
> previous logic to skip relinking modules if only vmlinux changes. The issue
> is that '$(objtree)' is typically '.' and GNU Make normalizes the resulting
> prerequisite './vmlinux' to just 'vmlinux', while the exclusion logic
> retains the raw './vmlinux'. As a result, if_changed_except doesn't
> correctly filter out vmlinux. Consequently, with
> CONFIG_DEBUG_INFO_BTF_MODULES=y, modules are relinked even if only vmlinux
> changes.
> 
> It is possible to fix this Makefile issue. However, having the %.ko rule
> update the resulting file in place without starting from the original
> inputs is rather fragile. The logic is harder to debug if something breaks
> during a subsequent .ko update because the old input is lost due to the
> overwrite. Additionally, it requires that the BTF processing is idempotent.
> For example, sorting id+flags BTF_SET8 pairs in .BTF_ids by resolve_btfids
> currently doesn't have this property.
> 
> One option is to split the %.ko target into two rules: the first for
> partial linking and the second one for generating the BTF data. However,
> this approach runs into an issue with requiring additional intermediate
> files, which increases the size of the build directory. On my system, when
> using a large distribution config with ~5500 modules, the size of the build
> directory with debuginfo enabled is already ~25 GB, with .ko files
> occupying ~8 GB. Duplicating these .ko files doesn't seem practical.
> 
> Measuring the speed of the %.ko processing shows that the link step is
> actually relatively fast. It takes about 20% of the overall rule time,
> while the BTF processing accounts for 80%. Moreover, skipping the link part
> becomes relevant only during local development. In such cases, developers
> typically use configs that enable a limited number of modules, so having
> the %.ko rule slightly slower doesn't significantly impact the total
> rebuild time. This is supported by the fact that no one has complained
> about this optimization being broken for the past two years.
> 
> Therefore, remove the logic that prevents module relinking when only
> vmlinux changes and simplify Makefile.modfinal.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
> My previous attempt to fix this logic can be found at
> https://lore.kernel.org/linux-modules/20260402141911.1577711-1-petr.pavlu@suse.com/
> ---
>  scripts/Makefile.modfinal | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index adcbcde16a07..01a37ec872b9 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -46,17 +46,9 @@ quiet_cmd_btf_ko = BTF [M] $@
>  		$(CONFIG_SHELL) $(srctree)/scripts/gen-btf.sh --btf_base $(objtree)/vmlinux $@; \
>  	fi;
>  
> -# Same as newer-prereqs, but allows to exclude specified extra dependencies
> -newer_prereqs_except = $(filter-out $(PHONY) $(1),$?)
> -
> -# Same as if_changed, but allows to exclude specified extra dependencies
> -if_changed_except = $(if $(call newer_prereqs_except,$(2))$(cmd-check),      \
> -	$(cmd);                                                              \
> -	printf '%s\n' 'savedcmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
> -
>  # Re-generate module BTFs if either module's .ko or vmlinux changed
>  %.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),$(objtree)/vmlinux) FORCE
> -	+$(call if_changed_except,ld_ko_o,$(objtree)/vmlinux)
> +	+$(call if_changed,ld_ko_o)
>  ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>  	+$(if $(newer-prereqs),$(call cmd,btf_ko))
>  endif
> 
> base-commit: 591cd656a1bf5ea94a222af5ef2ee76df029c1d2

The Sashiko review system makes the following observation [1]:

> Will this result in missing BTF data if the module is rebuilt solely due
> to a command-line change?
> 
> Since Kbuild's if_changed executes when either a prerequisite is newer or
> the command line has changed, a command-line-only change (such as modifying
> LDFLAGS_MODULE) will trigger ld_ko_o. This overwrites the .ko file with a
> freshly linked object that lacks a BTF section.
> 
> However, because no prerequisite files actually changed, Make's $? variable
> is empty, meaning newer-prereqs is also empty. The subsequent check
> $(if $(newer-prereqs),$(call cmd,btf_ko)) would then evaluate to false and
> skip generating the BTF data entirely.
> 
> Could these commands be unified under a single custom Kbuild rule
> (e.g., rule_ld_ko_o) and invoked together using $(call if_changed_rule,ld_ko_o)
> to ensure both linking and BTF generation occur atomically?

I'm aware of this issue. However, it is a separate problem that has
already been present. I'd like to address the exclusion rule first.

[1] https://sashiko.dev/#/patchset/20260410131343.2519532-1-petr.pavlu%40suse.com

-- Petr
