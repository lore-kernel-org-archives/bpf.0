Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC830221721
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777562726; cv=none; b=UGTemSYCWTLm3GEx2QFgGiWnAhGACvq2m5gunAgrrW6OqUPNHkOzJRwSqo+W1NZawwgiK09Rha4fVTiRROz+PyuO6BoTUyacDmWss+A0n9fQYcLsH+mp3+qwwBYV2CaSUZaqSyekyW/K1uvcJKhJ3sOkPx6BSkUDSDaVdot/oUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777562726; c=relaxed/simple;
	bh=8lRwO7PUF96OaeHWy1v2ksQCXnai8aaw1UtNnjzr2KQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fl1K1mC1NUkz3YOHmuGxJIgwNHVzsTuyOYF8/gAeZnyL5LGGC9+Q/OYTnf4mvLUladwDSzQRlvPI+/99XU61xt9kt+Eqdl3YwrjWAgl0iY9OBmdTMeAfHCaXZpnkmH/0XdBehV39cRVaw2vrILD6NEu84plhTe52X7SKhYt8wd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMCcDsbA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMCcDsbA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D272C2BCB3;
	Thu, 30 Apr 2026 15:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777562726;
	bh=8lRwO7PUF96OaeHWy1v2ksQCXnai8aaw1UtNnjzr2KQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uMCcDsbA2oLdo28r/twQBNwYiyQhbJd3cJQ+UPKXjTNHIXf7/aBesbrcYwrs7oaCD
	 LqWvWyzh1VbVBWuW2ot6XjWJw2hTo2/MvpXrda5xB/ztEBvtnssYq1L2Ov7Ew2qhB+
	 RSmOIe1eSt8XTmWO15OLhHR/1mliFkDEvhJTQJnMElkKlDY2ql98GhQ743jq6R8l8J
	 DsiEi4cF3o1J1eXErgdc68b3rxGsm2DwlTit2HbdFFmDl3YMdKDSfktxARU4y5Pwkz
	 zxIBDuJiiFC1RNSvRDGmNSJl9IFMaqlg2/+eKmGuYliYP5rQ7rU+SIB4g1HZHpQDx5
	 jMj1Erb2r595g==
Message-ID: <c801c51e-70d5-4bdd-8f83-d1f71f84186d@kernel.org>
Date: Thu, 30 Apr 2026 16:25:21 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v9 2/3] bpf: Fix s16 truncation for large
 bpf-to-bpf call offsets
To: Yazhou Tang <tangyazhou@zju.edu.cn>, Xu Kuohai
 <xukuohai@huaweicloud.com>, bpf@vger.kernel.org, ast@kernel.org,
 eddyz87@gmail.com, emil@etsalapatis.com, puranjay@kernel.org
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 tangyazhou518@outlook.com, shenghaoyuan0928@163.com, ziye@zju.edu.cn
References: <20260429171904.107244-1-tangyazhou@zju.edu.cn>
 <20260429171904.107244-3-tangyazhou@zju.edu.cn>
 <518d74d6-7750-4950-a76f-3e67e480840e@huaweicloud.com>
 <6fc310e8-f929-4b1a-b298-71f2445e3c6e@zju.edu.cn>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <6fc310e8-f929-4b1a-b298-71f2445e3c6e@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2026-04-30 23:00 UTC+0800 ~ Yazhou Tang <tangyazhou@zju.edu.cn>
> Hi Kuohai,
> 
> Thanks for your review and the Acked-by tag.
> 
> On 4/30/26 11:29, Xu Kuohai wrote:
>> On 4/30/2026 1:19 AM, Yazhou Tang wrote:
> 
> [...]
> 
>>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>>> index 300e4e251931..8947ef74f6a8 100644
>>> --- a/kernel/bpf/fixups.c
>>> +++ b/kernel/bpf/fixups.c
>>> @@ -1250,9 +1250,9 @@ static int jit_subprogs(struct bpf_verifier_env
>>> *env)
>>>           }
>>>           if (!bpf_pseudo_call(insn))
>>>               continue;
>>> -        insn->off = env->insn_aux_data[i].call_imm;
>>> -        subprog = bpf_find_subprog(env, i + insn->off + 1);
>>> -        insn->imm = subprog;
>>> +        insn->imm = env->insn_aux_data[i].call_imm;
>>> +        subprog = bpf_find_subprog(env, i + insn->imm + 1);
>>> +        insn->off = subprog;
>>>       }
>>>       prog->jited = 1;
>>> diff --git a/tools/bpf/bpftool/cfg.c b/tools/bpf/bpftool/cfg.c
>>> index e3785f9a697d..df43a0e0023f 100644
>>> --- a/tools/bpf/bpftool/cfg.c
>>> +++ b/tools/bpf/bpftool/cfg.c
>>> @@ -142,7 +142,7 @@ static bool cfg_partition_funcs(struct cfg *cfg,
>>> struct bpf_insn *cur,
>>>               continue;
>>>           if (cur->src_reg != BPF_PSEUDO_CALL)
>>>               continue;
>>> -        func = cfg_append_func(cfg, cur + cur->off + 1);
>>> +        func = cfg_append_func(cfg, cur + cur->imm + 1);
>>
>> Do we need to matain backward compatibility with the old bpftool here?
>> I suspect not, but I'm not entirely sure.
> 
> I agree. Since bpftool is maintained in-tree, it should be enough to just
> keep it in sync with the current kernel tree.

Hi, bpftool is also mirrored on GitHub at
https://github.com/libbpf/bpftool
and many people build it from there, so yes, it should be backward
compatible if possible at all.

Thanks,
Quentin
