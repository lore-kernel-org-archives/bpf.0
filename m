Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCEF313543
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 19:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780083063; cv=none; b=SaB4ffybZQoZZ31wI0FMGrzlYbLRD4sFeVT/xrHVsPw/hcZt9rHrCCtI269GbUNQdKDCESE75h91LHHu3IkJuaXiLmYKkD4W5AR7seb2bKDvqVWP9jeTBdGCtS65jCn/7r91/VskGkshuIPfXnjXXhNdZIQCP/f0dso+T9mHpR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780083063; c=relaxed/simple;
	bh=rW16bLrk5jwR3xA+seXd9jZUjipO6l5pgJWVWKnG+fE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=XtypngbAX5l/ga82MiOeyau+dIpxmwiMUeJrHv65iRvBS2FZ1qQ3yxEbsmd6SRYlxZWacGhdoWH7M1aYoW5I2J8NflV6P+P7QNbTBgB46YCCJpUvZIdT0d4mm6lpvbX3YSmv8XmR9J0Kf0quhOjAPqtY4KkyN8twkJr4o5GZ4BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=PAY5kKYw; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="PAY5kKYw"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36ac67f489aso4080839a91.0
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 12:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780083062; x=1780687862; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2zgBplC4QLh5fCVxJaGloXAKbIUWfB8PjLO7zQSv/c=;
        b=PAY5kKYwUbpX+BU5Y+fovRbh8ST8WmRQheDULxijvoR8Z0Dm48bFQSXC1DOTlB3frR
         Qg9NMWaJ4rTvCFQgYuNPrpGaocjslWcvbeJ+4reOtVGOVYUf4LCygPiahbvQKyas1Wlg
         STj1Qvsmb0mtXng7EOUBbP//FlXNsUKKZr2qmNVSo3AUqd2XxA+TYYctT9XsUZpHC9Q1
         5Vg6nc5AuUsFmxCm6SmCB0rqjbrBLSNi1xBGwvvcPwecGvjk/vouAugpd7wnxDyL/SxW
         vRL6UgxadunjOfN50UdAf11ldnUtMJnodWrAzivZdx9KLt2CRp/ESizRiwAnXzft0cgn
         2A8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780083062; x=1780687862;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f2zgBplC4QLh5fCVxJaGloXAKbIUWfB8PjLO7zQSv/c=;
        b=rRhRLP9lznZGdWeKZfAnnQABl3ODyestXttN14PCw8SYg2UvkoXgfPqbKnYhF8faBa
         dSu/iIIR7C2hOVIFQCGqfzLWhZgHNGeozjGG8SmtxhtgOgQuakTuQ0/XnjYod3QMPnVL
         brK6YSIpEz97swM1ehHDTiHFLad+vceYowaYEymmGM89mGG+N/Purvyfw2gLU08tfSM5
         TUkCmhDkdP+QLZHxH5woZ1wz4Y+PKcI/zmCZh+jDwVxLohUVLlZUlEEROcK7jT92AzXr
         1xi9iXg6zaB9bOEmPOjUV1Pv5+In8HhcwrLBoPNbVmsDBuOg+N7s0DgeEv2HgJWAaw8f
         mt9w==
X-Gm-Message-State: AOJu0Yy+24l+2CQ6wi8MJcreZPAp+WYZ0nUBH3nDCC8l9UY0tAjacwy3
	aiH6QdfZKVELVnrhudRuPWol8MILWxPtokiS14wO1Uoj2sEaaoms/gtnQUF1NA1fmWY=
X-Gm-Gg: Acq92OFCuugAe6l3aVocuosBAMYLgWrIHANfYTOTdqu++0VWRan//yvpz6Fpc9TPhS0
	vnkGBwjmMtX//ZRQp6pQnfl2qIf+xv2HRrLSyQcI2JxXp82EXxIOslWiW4zg2f/2cCL2WTV7Fnk
	42HAk7ieFs0lcGNnoKB/bPC69AjtdTwvPsEABVc4ZBxiUdqR629ZOqt0uSnG8ems1mXNTxDjpkQ
	q4+A/6Kvr+XB2nkIGdI4QIIdt53sG0dmeZdbUzhKEdaCj5GKeYW7+kIP4TBwBE4vFDutOKhcMPM
	ZFxL2mbrZ3KjD/w5eDBnjnhPbQVhvwyIiZhUxiVRG5AiGPL8Fwbs4ROGbUSjdoHjMrZ/X8lXcBn
	4OAM26YL86xL0HK6i7mjW0utoNQuQ5N3D50UzFhOtc3PCgXAF+A2AIEVVRNVFDOz0PF1nrv4DfB
	8YRcY8YwF1gH7ix9AnZRob1EL7vPHvZZvNzRJjFrbUUNkY0g==
X-Received: by 2002:a17:90b:520c:b0:36b:a162:a1be with SMTP id 98e67ed59e1d1-36beb2e0700mr651835a91.4.1780083061507;
        Fri, 29 May 2026 12:31:01 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bbe0d89d8sm1626812a91.3.2026.05.29.12.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 12:31:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 May 2026 15:30:59 -0400
Message-Id: <DIVES4GO0CWX.32QB3C6SDEXVS@etsalapatis.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf, lpm_trie: Allow lookups from sleepable BPF
 programs
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <sashiko-reviews@lists.linux.dev>, "Vlad Poenaru" <vlad.wing@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260529174233.2954240-1-vlad.wing@gmail.com>
 <20260529190220.2090C1F00893@smtp.kernel.org>
In-Reply-To: <20260529190220.2090C1F00893@smtp.kernel.org>

On Fri May 29, 2026 at 3:02 PM EDT, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the fix is inc=
omplete. The patch resolves an RCU lockdep splat in `trie_lookup_elem` for =
sleepable BPF programs, but leaves identical core kernel locking rule viola=
tions in `trie_update_elem` and `trie_delete_elem`. Sleepable eBPF programs=
 hold `rcu_read_lock_trace()`, not the classic `rcu_read_lock()`. The updat=
e and delete operations acquire the map's spinlock (`trie->lock`) and corre=
ctly serialize access, but they use `rcu_dereference()` to traverse the tri=
e instead of the update-side API `rcu_dereference_protected()`. `rcu_derefe=
rence()` strictly asserts that `rcu_read_lock_held()` is true. Holding a sp=
inlock disables preemption but does not satisfy this check, leading to the =
exact same 'suspicious rcu_dereference_check() usage' lockdep splat that th=
is patch aimed to fix.
> --
>
> commit 1ac6e30b3c7fb4d93d67bfcbb5dc35077814b266
> Author: Vlad Poenaru <vlad.wing@gmail.com>
>
> bpf, lpm_trie: Allow lookups from sleepable BPF programs
>
> This commit fixes a lockdep warning caused by sleepable BPF programs
> accessing LPM tries. It updates the RCU dereference checks in
> trie_lookup_elem() to use bpf_rcu_lock_held() instead of
> rcu_read_lock_bh_held().
>
>> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
>> index 0f57608b385d4..ac36063cb7e62 100644
>> --- a/kernel/bpf/lpm_trie.c
>> +++ b/kernel/bpf/lpm_trie.c
> [ ... ]
>> @@ -280,7 +280,7 @@ static void *trie_lookup_elem(struct bpf_map *map, v=
oid *_key)
>>  		 */
>>  		next_bit =3D extract_bit(key->data, node->prefixlen);
>>  		node =3D rcu_dereference_check(node->child[next_bit],
>> -					     rcu_read_lock_bh_held());
>> +					     bpf_rcu_lock_held());
>>  	}
>> =20
>>  	if (!found)
>
> [Severity: High]
> This is a pre-existing issue, but does this patch leave the fix incomplet=
e?
>
> While this patch updates the lookup path to avoid lockdep splats from sle=
epable
> BPF programs, sleepable BPF programs can also trigger map updates and del=
etes.
> The functions trie_update_elem() and trie_delete_elem() acquire the map's
> spinlock (trie->lock) but traverse the tree using rcu_dereference():
>
> kernel/bpf/lpm_trie.c:trie_update_elem() {
> ...
>         while ((node =3D rcu_dereference(*slot))) {
>                 matchlen =3D longest_prefix_match(trie, node, key);
> ...
> }
>
> kernel/bpf/lpm_trie.c:trie_delete_elem() {
> ...
>         while ((node =3D rcu_dereference(*trim))) {
>                 matchlen =3D longest_prefix_match(trie, node, key);
> ...
> }
>
> Because rcu_dereference() strictly asserts that rcu_read_lock_held() is t=
rue,
> and holding a spinlock does not satisfy the classic RCU read lock check, =
won't
> calling map updates or deletes from sleepable programs still trigger the =
exact
> same suspicious rcu_dereference_check() usage lockdep splats?
>
> Should these paths be updated to use rcu_dereference_protected() since th=
e
> trie->lock is held?

Fair point by the bot

