Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794368772;
	b=CRH17oKFrW8mclQpD5xtpUAQSP6l0Wwbk7bG4Cv2HBBe+gUs/YVvWtPJNt6em03CX2ii
	 vtZxCXTptny9m3g0UaDSaOAqyTTm6Pw0Hoilh3TWneQ1io758adMrz0K+OK5xJmXenmBf
	 qLqJ1akwZjlZ9uJtIAgvcQhD4ZmjzL+5PzKGtDASZ7si5e8PXfDjmnxVtTv9XsHrM3CZK
	 mRTNiQg3KPnaleBtAT07Sbmyycynh2Z1M4m0Svc44+FpihqMHv8j3z50fxRsF6DBUCigI
	 5kAaRWAWBDmmKwKyLKYJobo21TLD+LmOTXz2V9UohIu7fdxgEHPrmTaHhxPCk8vME9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368772;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=RXpnzG8jc2yYtoFLBv7ZARt98Mz5wOXGm+EBvSjKUfM=;
	b=Ue6dovxw4ubFdGywjATiRhToBiyBK18sr9YKcOWL0kVPaO1gXv0gZRVRy8NHKDCZDNyX
	 Ma/DFvNbsFdRRjFV11KEZDVov34x4jbvHpX3pzCW8Rh7PCwgxjWDCq0pYGGbIxu2H54sK
	 8bgvNatGJOK0LoQsm2Qkqi5pOQxcBbhijB6jsJ/Jpk2dlO0wUMAbF9tl7XAgcgnRDK/Ml
	 KlqSo/ED6JVdjf9jlbF8stj+aZsVvkvp4/+LLBRPRp9k01uUH/mq2YUDrkkfLNarl3nos
	 mvIOT4ua5PiV4n+mPFLL0yaYOc9ft4IRuOwOJsSGaXBYvHGHf2pUKboZ5X1+PQJcL6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wDmRvi5U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94374606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 03:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94374606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wDmRvi5U
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-67be4f2f4d4so3518654d50.2
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 19:46:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794368770; cv=none;
        d=google.com; s=arc-20260327;
        b=HanJ8hcCCrDjJFTZg1KBVmdSXVFf+uRaCm7dTI0FQ7+GMbUKQMNBS0+cqb4TW+c1nG
         38yJhrMWbVGrlKGX0LeQoQqxGkXzFrIHO2AJm7pabdtzLX/dRMxnBXvs1PHubUx7Rl/k
         c8REpABZWtrnUzNPEybzxEO7JmT7yNr8p14I0DgCF3c/QKd58+1VNCjpir/uAGn6yrjr
         edi7mwpHO8q3yBuV0u4TIXB76xOr4ahMU/92rYyPcPb7Z5lWXvp5TMtmjKCbtT3amkEv
         iBMdEhBbI27e7GYJXVylHuZ0hqdpamy/nnQNUDB/UcoK3MQUceeSQFdJU4IMqsZkdebE
         lZng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RXpnzG8jc2yYtoFLBv7ZARt98Mz5wOXGm+EBvSjKUfM=;
        fh=emmQa7NFVvB0rscUNDwP+4iWgQ4OgqGNt7zruvkkjkE=;
        b=g/dyFAevsWZk9gGlyjWltYSC/8RUgmiAda1HWF0ylln1kGvkwe5Qx/KJwpNmaKXnz/
         MZhweuiQYuC8YKp5Zbq9szfcp+R+PiCDuvlfqY4lDmf9tECnJdungki/U5zRKLkFDsFU
         YqqxC+H6SJTVX13QU1+6pOFRKW071cCVecpsMeoZJAJnfk/6c5zG2AusTWLrgSp4rx24
         dkGV154ykcyFrmTn7RN4r/ykB5nmRVEH6sToFaMGJHsb0ovz9ve7ZZSnJsyLjhbLG0yo
         omu/D6GbvM1E75IJB1PgcfrVfkZLkaDQswn8XYGO6Kqw5apDN7Q986OCqVity8T843IW
         RtGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794368770; x=1794973570; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RXpnzG8jc2yYtoFLBv7ZARt98Mz5wOXGm+EBvSjKUfM=;
        b=wDmRvi5UDOHoU7lvv5PYFvNw/6ZCjkQMZd1A9CuYNK61SeWNpUw7SFVHSuXK81Jftx
         LqFrl+MMeAfNQ1dN4VgAkPSGL4mGMkvB85vU/HldNCWDivRC/cNo4PAavvHG3u6/x6iD
         NvRqkYXq0KioY9aYKfoeF3x7hZmb4oN/Cqv1MDDJdEPflYm+1hQTIMTqO/hDwl2WXw+g
         lbD5aDQpTz5+uWMvoBX+3lAEIgoX1bdI53Fov3ccsCW6voIrj/vZlzWrwWwJdofq3w17
         T8mGbovHjlrnUYPSCtJpVDvopcd/+XZlW3WKBxmeYfVmguC1aytJJ6cwhXCyv3d0lwMT
         X/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794368770; x=1794973570;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RXpnzG8jc2yYtoFLBv7ZARt98Mz5wOXGm+EBvSjKUfM=;
        b=MqDa5Vq+VcL4dhIztDICYtTsVTf7htKjmfYxiT7ApVmpLiBudKS3q+k0GF6WBxmP8K
         kZ5q5guI9q42hwUbLI/YLSfYhcpsHOKuITeBTNS3ddvdYaGBEL2LPrK/Wpu3erzLCUIo
         obDpgu4uP0adUDLv9LWN6+Whuu+4RnGGKWEyMuB7giDgElGClRppvlEWVdSAU/iTeW1l
         IZdixVkaNVPVjTyQ5EEYfw5DAW8Y1KMDMM5mI98EDfK6z5y/HKNM9iSb1KYbXVWvYrhO
         h6RURb9PcRGk0nB/xmghYRgO/dK/0Sv+5IfOK3vCvhaj9LpAFInFHTuJWM4xI7VPg0vS
         aYYg==
X-Forwarded-Encrypted: i=1; AL+hErEigmno1JTNunCmPfddEKzGmR6pelQH5iReBb9wooNDMe+WxOfSuGnkk0EYwUe/rPuQm3M=@vger.kernel.org
X-Gm-Message-State: APuU4Z9qOHGcc9KhRCBiAfZjtM75JH0oqnmM17YmoDUTgyxgSshsTZMe
	E9zp6aK5tRW+BJb+a7SlIyMTTfwWni1FHEGXE9rAvltEPGuz327M3Sny6J5cGgG0XDacKsRBrpv
	7LCKa3VA63PE8YYSKv5XylwsOtzZiVBY=
X-Gm-Gg: AYBFou0CN/ij2cTzFQjYQU1gu5tAvW24fvn1H2PHqFB/uEnm8jHJngHOZRC32tD5MrB
	SprmjM8+xWbULxR6Itm6UrDeUvm7h0dqlhrc71CLqaMxGuJAYYWc0X9who3+7SXqaCuSNVndByz
	LB4jACVCB4f4hNdCXL3P/J7T0h7cRZVcJjFJbvguyAcZUoW8P99QtdbRwuima1QiSicvxK8DXwe
	fmM72gUxS/DJHaall2WSrThnZBK6asx0tfZOSf9KfrBd2lcKLvjiCRVs9AfeCkWZ1ZFx9GgqYA0
	ptooqaH7CAmEOMz/Bucqrjvj8qrYvUn5GxHx/TsIzXxHL/OkGA/0m1gyFb+iVMf/9c2M6rTNZEn
	ILYYkxylJk213LiZX704mqbu2xCjz1cHggpHH8XZEp7Eow142MkiYIlrpu4H3c7xFkbU=
X-Received: by 2002:a05:690c:f04:b0:8b1:567c:e7ae with SMTP id
 00721157ae682-8b3a8114a85mr9107737b3.47.1794368770490; Tue, 10 Nov 2026
 19:46:10 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110032913.71974-1-laoar.shao@gmail.com> <3296ff1ecad6573e1719cb205d9128f7@kernel.org>
In-Reply-To: <3296ff1ecad6573e1719cb205d9128f7@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 11 Nov 2026 11:45:33 +0800
X-Gm-Features: AclHuK_EYuNKM1uN4O291ubvtl6N0s-HDZmJBzZexNtlBKQbnavU5QXTx2HKC3E
Message-ID: <CALOAHbDqE5qD7y5_A25wxWR603QcGnSVFFoBe6iZ4TH7t4a_Sw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v4 0/4] BPF-based per-cgroup NUMA balancing
 mode selection
To: Tejun Heo <tj@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, akpm@linux-foundation.org, 
	david@kernel.org, gourry@gourry.net, hannes@cmpxchg.org, mkoutny@suse.com, 
	shakeel.butt@linux.dev, roman.gushchin@linux.dev, yu.c.chen@intel.com, 
	zhao1.liu@intel.com, tim.c.chen@linux.intel.com, lizhe.67@bytedance.com, 
	ziy@nvidia.com, mgorman@suse.de, bpf@vger.kernel.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 2:45=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Yafang.
>
> I'm not going to engage further in this series until the situation
> changes.
>
> LLMs have made it much cheaper to produce plausible-looking patchsets
> for new features. That makes it easy to keep sending iterations of a
> feature which touches code that the submitter doesn't really understand
> or hasn't thought through in depth. The reviewer ends up doing much of
> the developer's work while the submitter sits between the reviewer and
> whatever the LLM produces. I think this series is an example of that.

Thanks, and I'm sorry for the time this has taken.

>
> Some examples from v4:
>
> - A folio belongs to a memcg and that memcg decides the policies around
>   it. That's how memcg works for every other memory policy, and tasks
>   belong to a memcg too. The series still splits NUMA balancing into a
>   task side and a folio side with different semantics. DISABLED applies
>   to tasks but not to their memory, and the two sides combine the
>   hierarchy differently.
>
>   On v3, I asked why. v4 moves the storage into memcg and keeps the
>   split, but doesn't give a high-level reason why NUMA balancing should
>   work differently from how memcg handles every other memory policy.
>   More generally, the major design decisions come without the reasoning
>   behind them, and asking didn't produce it. Each iteration only barely
>   updates what was pointed out in the previous one.

The task/folio split was my attempt to avoid defining a single owner
for shared folios. That was not a principled design choice.

Shared page-cache accounting in memcg is not a clean ownership model:
pages can remain charged to a memcg after the tasks that used them
have moved on or exited. That limitation is real, but it does not
justify giving tasks and folios different policy semantics, and I
don't currently have a defensible model for the split.

>
> - numab_memcg_mode() walks up to the root memcg and recombines the
>   requests on every call. The callers include every load-balancing
>   candidate in can_migrate_task(), every task migration, every NUMA hint
>   fault and every page migration including compaction. This happens
>   whenever any cgroup has a mode set, although the result changes only
>   when a mode is set or a memcg goes offline.

You're right: the ancestor walk is not an optional optimization. It is
on hot paths, and leaving it for follow-up measurements is not
acceptable.

>
> - numab_memcg_active() reads css->flags once and the comment says that
>   this makes the three state bits describe the same moment. However,
>   nothing synchronizes those flags with the mode. In the lookups, the
>   check is redundant anyway because offlining a memcg or disabling its
>   controller already clears the mode.

For numab_memcg_active(): the technical point is that the check is
only needed where the memcg does not come from a task/folio.

In the task/folio lookups, the memcg is tied to the object being
examined, So the active check is indeed redundant there, and I'll
remove it.

bpf_numab_get_mode() is different: it resolves an arbitrary cgroup id.
There is no task/folio context that pins the policy. So I use
numab_memcg_active() there to skip an unusable memcg and continue with
its parent.

I agree the check should not be in the task/folio lookups.

>
> A developer could cost reviewers time before too, but each round took
> the developer much more effort in comparison. That kept the effort
> balanced between developer and reviewer in a sustainable way, and it
> made sure that the developer learned and improved while working through
> each iteration. LLMs broke that balance.
>
> I don't know what the right solution is, but at this point shepherding
> patchsets like this doesn't make sense for me.

Anyway thanks for taking time into it.


--
Regards
Yafang
