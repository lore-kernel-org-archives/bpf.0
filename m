Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C84383982
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 06:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782972953; cv=none; b=bPJvdN44pe9qLv4aNCW9iiIKMK6QURy7H1hWgnMsizt9eO9QEJmjXLTDt9XMAt7tW5PefSRVuLxEFspHq+U6i056y73WOM8qEU4ryjQ/2w+kV7kflTNu03XFGTcDruuWIJDlPcQJKsQ2L1667xDkejiTmQN4uQTk53L/c4tHLI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782972953; c=relaxed/simple;
	bh=gZataAktdZqFVOQNF9xTx4XhlvCz1HfP5FRQulEDopw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KTFkcFh6x4r1e9twbFLX8nduLHKJR1Ji6o+EAnVa99ZsuphR6YLvimFt0iYfmja5ZLaWa69FNFQduje3+0w0LRMEJCJ3LJLdxLrI8wq/8Qol2kD7cL+UKoYL/+9AW8VV886Ti1nut2zWd5iOm5No7ZE8rTMcqlPtCfTRPAieJaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xXTx/Fja; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xXTx/Fja"
Message-ID: <b9413abf-0735-4acc-8770-e0582436b2f5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782972939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uI8ueJO3T3j9lODHWCIaJNjGSGrgbiCEdlasJRUkOPI=;
	b=xXTx/FjabfNJXkzPXAZj4AElGy9w+AF0b4T/v6NN8HfY5JhlqOsb8k82jeqMoAvzaD5QHL
	A/89zeKn/7+jJJNh0ug3btdpQxgbsLeiKqTmQifGRBbPtm39KJxcj9ILFvWldDNBAJxTz2
	qVppmoC9eDOo7KSwU1LJ91wkUM7vQ+0=
Date: Thu, 2 Jul 2026 14:15:20 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 2/9] bpf: Introduce global percpu data
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-patches-bot@fb.com
References: <20260629152406.52582-1-leon.hwang@linux.dev>
 <20260629152406.52582-3-leon.hwang@linux.dev>
 <CAEf4BzbLDna2j_yNniZ8gW6Um4AzWd6xYS4N8hp7hk879phgug@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzbLDna2j_yNniZ8gW6Um4AzWd6xYS4N8hp7hk879phgug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/7/26 03:31, Andrii Nakryiko wrote:
> On Mon, Jun 29, 2026 at 8:24 AM Leon Hwang <leon.hwang@linux.dev> wrote:
[...]
>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> index 3cf2cc6e3ab6..4f84d087ca69 100644
>> --- a/kernel/bpf/fixups.c
>> +++ b/kernel/bpf/fixups.c
>> @@ -1819,6 +1819,38 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
>>                         goto next_insn;
>>                 }
>>
>> +               if (env->prog->jit_requested &&
>> +                   bpf_jit_supports_percpu_insn() &&
>> +                   insn->code == (BPF_LD | BPF_IMM | BPF_DW) &&
>> +                   (insn->src_reg == BPF_PSEUDO_MAP_VALUE ||
>> +                    insn->src_reg == BPF_PSEUDO_MAP_IDX_VALUE)) {
>> +                       struct bpf_map *map;
>> +
>> +                       aux = &env->insn_aux_data[i + delta];
>> +                       map = env->used_maps[aux->map_index];
>> +                       if (map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY)
>> +                               goto next_insn;
>> +
>> +                       /*
>> +                        * Reuse the original ld_imm64 insn, and add one
>> +                        * mov64_percpu_reg insn.
>> +                        */
>> +
>> +                       insn_buf[0] = insn[1];
>> +                       insn_buf[1] = BPF_MOV64_PERCPU_REG(insn->dst_reg, insn->dst_reg);
>> +                       cnt = 2;
>> +
>> +                       i++;
> 
> oof, this was a subtle head scratcher for me.. that i++ is easy to
> miss. let's update the comment to be more explicit: we are *skipping*
> first half of ld_imm64, patching over second half of it with that same
> half + percpu mov. All because bpf_patch_insn_data() can only replace
> one 8-byte instruction, which doesn't work well for ldimm64.
> 
> Anyways, this looks correct, it just took me a bit to figure this out
> and while the above comment warned me about this, it didn't really
> make it any easier for figure out what's going on.
> 

Ack. Will update the comment.

Thanks,
Leon

