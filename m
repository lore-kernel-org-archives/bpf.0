Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A212D5937
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771606568; cv=none; b=gEARdmqy7150f0GSj/WjV0Q6XrkXozMvDO1dkMYeptGJFP7OPWdyyYHmFDnLMusT5yMtAKtF8ttN+OucvnHRmEGdlvl5c6B9rKCO3yC/V9V7PAI2OWPo/ghTOwUYrDTBQQgEmWIiq7wjtyOrrvrbs2CDTagTsChEDe3T3Eled1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771606568; c=relaxed/simple;
	bh=E2SGaWCd17EE5DFtWnpmU5YdrkeY+6ZDZ6X2tydSN78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uKQIRryOUKhqISHT1OGa/pv8nwAzcKaT96SigDaAsVwPefahMi+ows3ZxBCesJIWIartvI1q/aeICsCe5VhKouoB8NYI4cVaWiN1MKliphu22XPoXD74hAceWud9gH/7WlRiXUxBKL2LR31pE1QspvaAYBizQMFpFZvw6DyJswo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xV4dE5s5; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xV4dE5s5"
Message-ID: <3602c85a-8680-4074-9632-9be849dd414f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771606555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=arS8abSpsou7xMicaKoZ+GBuNuPKi3l6l9KSMTEZ60c=;
	b=xV4dE5s5mleS6mAYXCnwNX8C+jRD37UfcV0uHUaVhkYjokImIPyT4tTYiv3CgzwzmbA/tj
	Q9suKfsMpduXv3KOabsOLtkzchqVpBGRe8/D0OjDObebhKnHvV7LAD2W9380ZeEPtjl2S6
	mVGv3gMUFRCmw9ZFGbrRJ2UkB4lkye8=
Date: Fri, 20 Feb 2026 08:55:45 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Fwd: [PATCH v4 07/17] kbuild: generate module BTF based on
 vmlinux.unstripped
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-7-0b932db9b56b@weissschuh.net>
 <27a43b85-5a7b-4e53-81c5-a34a3c0d1735@t-8ch.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <27a43b85-5a7b-4e53-81c5-a34a3c0d1735@t-8ch.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/20/26 1:29 AM, Thomas WeiÃschuh wrote:
> Hi BPF/BTF maintainers,
> 
> could you take a look at the patch quoted below?
> It is part of a patch series which only tangentially touches BTF [0].
> If you prefer to receive the full patch series, please let me know and
> I'll do that for the next revision.
> 
> [0] https://lore.kernel.org/lkml/20260113-module-hashes-v4-6-0b932db9b56b@weissschuh.net/

Hi Thomas, thank you for the ping.

The BTF generation process has significantly changed recently:
https://lore.kernel.org/bpf/20251219181321.1283664-1-ihor.solodrai@linux.dev/

I suggest you rebase the integrity checking series on top of that
(it's already been merged into Linus' tree).

Adding a .stamp is a small and simple change, so maybe it's worth
landing separately through BPF tree?


> 
> Thomas
> 
> On 2026-01-13 13:28:51+0100, Thomas Weißschuh wrote:
>> The upcoming module hashes functionality will build the modules in
>> between the generation of the BTF data and the final link of vmlinux.
>> At this point vmlinux is not yet built and therefore can't be used for
>> module BTF generation. vmlinux.unstripped however is usable and
>> sufficient for BTF generation.
>>
>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>> ---
>>  scripts/Makefile.modfinal | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
>> index adfef1e002a9..930db0524a0a 100644
>> --- a/scripts/Makefile.modfinal
>> +++ b/scripts/Makefile.modfinal
>> @@ -40,11 +40,11 @@ quiet_cmd_ld_ko_o = LD [M]  $@
>>  
>>  quiet_cmd_btf_ko = BTF [M] $@
>>        cmd_btf_ko = 							\
>> -	if [ ! -f $(objtree)/vmlinux ]; then				\
>> -		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
>> +	if [ ! -f $(objtree)/vmlinux.unstripped ]; then			\
>> +		printf "Skipping BTF generation for %s due to unavailability of vmlinux.unstripped\n" $@ 1>&2; \
>>  	else								\
>> -		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) $(MODULE_PAHOLE_FLAGS) --btf_base $(objtree)/vmlinux $@; \
>> -		$(RESOLVE_BTFIDS) -b $(objtree)/vmlinux $@;		\
>> +		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) $(MODULE_PAHOLE_FLAGS) --btf_base $(objtree)/vmlinux.unstripped $@; \
>> +		$(RESOLVE_BTFIDS) -b $(objtree)/vmlinux.unstripped $@;	\
>>  	fi;
>>  
>>  # Same as newer-prereqs, but allows to exclude specified extra dependencies
>>
>> -- 
>> 2.52.0
>>

