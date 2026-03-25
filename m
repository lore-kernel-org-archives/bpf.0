Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354DA2192F4;
	Wed, 25 Mar 2026 01:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774402963; cv=none; b=fH7W0sB+YGzx0DqJscayz135aZhERbSxXDQa4FSP+1vNz5smdINSsYQZpeel818l6Mq1XZvb8VL/YYiNpaCkZRLEuhsLbKMH19GmpDlGRr3wDg/nlFCW6ZyKyoSOOpnUp2gQg4EZxVf6AnanXzKcenzhgu6SzaNwk7jKkXElTTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774402963; c=relaxed/simple;
	bh=poc8RQKZHV6IyOZIlkXBpoaLWdoilvRbScnWqgIzwkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hvL7H19+8S4ZAmocU5UGsdXfEqEhC59zAgGGJN3Ycd61SyqZtXuBC1UUvKT3gCqzsGyJVO4997a2Wyinylmm34p/kaZ6gt4EUrDZ0dCRi7R4rTSZX1Ds6LX7mgKCKo3SvsYJgVchQdU5ilvkhX3G7vhBZMOEZ130bOMPNLVAvOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h4ilSWka; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h4ilSWka"
Message-ID: <401134e3-2a2f-4c23-8ba0-3a4cc901d6a4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774402960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYZezwn0ZMtB7MrRH2625PaWZJBlv5I3izmJUNinHpU=;
	b=h4ilSWkafyyuwUX/2VlnmemnQoV//SuMV1p7ZUAymmYa9O79QdPScsrxWS0EsavENGU0Fg
	GM7UcmvzaWMc/d9DebK2+QIJgUQT8DCm+wwgieK2UEHLzNIqougGu2yvyez4VQcxRzl2aX
	sojrqgVxAcULluq70GxWejoMEnE6xzE=
Date: Wed, 25 Mar 2026 09:42:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/3] bpf: Disallow freplace on XDP with
 mismatched xdp_has_frags values
Content-Language: en-US
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 kernel-patches-bot@fb.com
References: <20260324150444.68166-1-leon.hwang@linux.dev>
 <20260324150444.68166-2-leon.hwang@linux.dev> <87ecl9mc9d.fsf@toke.dk>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <87ecl9mc9d.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 25/3/26 00:18, Toke Høiland-Jørgensen wrote:
> Leon Hwang <leon.hwang@linux.dev> writes:
> 
>> xdp_has_frags was introduced by the commit
>> c2f2cdbeffda ("bpf: introduce BPF_F_XDP_HAS_FRAGS flag in prog_flags loading the ebpf program").
>>
>> The commit f45d5b6ce2e8 ("bpf: generalise tail call map compatibility check")
>> was to ensure backwards compatibility against tail calls. However, it
>> missed that XDP progs can be extended by freplace progs, which could break
>> the backwards compatibility, e.g. xdp_has_frags=true freplace progs are
>> allowed to attach to xdp_has_frags=false XDP progs.
>>
>> To avoid breaking the backwards compatibility via freplace, disallow
>> freplace on XDP programs with different xdp_has_frags values.
> 
> The problem you describe is not actually a problem, though? A
> frags-aware program can run on a non-frags interface just fine.
> 
> You're messing with long-standing behaviour (since 5.18!) to solve a
> non-existent problem. In a way that completely breaks the frags handling
> in libxdp[0]:
> 
>     Running tests from ./test-libxdp.sh
>      [test_link_so]                PASS
>      [test_link_a]                 PASS
>      [test_old_dispatcher]         PASS
>      [test_xdp_devbound]           PASS
>      [test_xdp_frags]              FAIL
>           Kernel supports XDP programs with frags
>           check_load_frags:	FAILED
>           check_load_nofrags_success:	PASSED
>           check_load_nofrags_fail:	PASSED
>           check_load_frags_multi:	FAILED
>           check_load_mix_big:	FAILED
>           check_load_mix_small:	FAILED
>           Test test_xdp_frags exited with return code: 1
> 
> 
> Please don't do that.
> 
> -Toke
> 
> [0] Run 'make test' here: https://github.com/xdp-project/xdp-tools
> 

Indeed, it failed to 'make test'.

Will drop this patch in v2, as it wasn't an issue.

Thanks,
Leon

